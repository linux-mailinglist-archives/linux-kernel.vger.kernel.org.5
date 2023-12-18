Return-Path: <linux-kernel+bounces-4076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723428177AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D3B1C230DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5605D735;
	Mon, 18 Dec 2023 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPa0h1G+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711824FF84;
	Mon, 18 Dec 2023 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b9f111c114so2181995b6e.1;
        Mon, 18 Dec 2023 08:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702917395; x=1703522195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQV19gsqAR0o53Ir8ZJ+QKmKnVhQISOohb4gzU/oY50=;
        b=PPa0h1G+yOpX7fieVTz1c1RZRdBCbN+F1AnY/WVAjnW1vBPZk7snG2W9hnwIR3MtK/
         LqcAmsQH6SpLhE1wKW8MFB94u/rboNoKxwyafTW9QSj69IqRHpoiXh21WlUkZH0Hf2ai
         JrMvo+0MHb1ZsHYMgPubZQXi/MjB1M2XXjWMpSbC78T0vOQVmfTdf3WpZZ7yn3SeCwvN
         LxLSx6t2OrBz6lTfSuW9PxlnH5RUHxEjEG50y0KyhjIKsoEuTgplmXhL+mLTkmZzxFbc
         uYkxG4pMAatqUlbkzpDMlwC2Yrd8293tok1NpEveN5P4RToqhrztb2KOi5evUCWMa5rf
         6jnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702917395; x=1703522195;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lQV19gsqAR0o53Ir8ZJ+QKmKnVhQISOohb4gzU/oY50=;
        b=atFNVGaNflx9Ncx0FDWO4I/3U+7vVyw9hGhq1hvDtIWuF9HJ/+/VDo4yj8IVhUlWpR
         XHVrs8Ttl1VUB/lcuLldkPKQa14/GRlFY31jBhusOwhQOGDthV3x2g79M+ytwZrj2hKY
         STTz1t6h0SduExmG6K2Riq+SxVWCGMG6I0LdTGzLXBN3hAD7tX07g80zYEAdTiogiqim
         +xdEQVt/y6g0urjao0NEyztsGNmoXvyTN93FSu1vIvQj9DMcnYfen02fCbUr1dJ/D9YB
         6qs2k8dF3n33i/NJ1S1Nw1X8OngpImlGH27h5YdapHapZ3EUVsrNHYgaohQo0WC017lL
         BZiA==
X-Gm-Message-State: AOJu0YzXiSGs5fnqs00RbWYMj2VU3VmvkqgIbKQzQFMSi89TuTGnulWP
	aQZr8NAk5LeXstAWMJZX7W0=
X-Google-Smtp-Source: AGHT+IElzJWlJ9gs7JsWQZZ0tgpLq9OGnBM00u2DOHZw3YzQXThA4bGST+JUjXecMMmFXfbzQ/IWjA==
X-Received: by 2002:a05:6870:a40b:b0:203:936b:70d with SMTP id m11-20020a056870a40b00b00203936b070dmr3344641oal.62.1702917395435;
        Mon, 18 Dec 2023 08:36:35 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id bm27-20020a05620a199b00b0077d62e78db9sm8408821qkb.128.2023.12.18.08.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:36:34 -0800 (PST)
Date: Mon, 18 Dec 2023 11:36:34 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <65807512bc20b_805482941e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231218-v6-7-topic-virtio-net-ptp-v1-0-cac92b2d8532@pengutronix.de>
References: <20231218-v6-7-topic-virtio-net-ptp-v1-0-cac92b2d8532@pengutronix.de>
Subject: Re: [PATCH RFC 0/4] virtio-net: add tx-hash, rx-tstamp, tx-tstamp and
 tx-time
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Steffen Trumtrar wrote:
> This series tries to pick up the work on the virtio-net timestamping
> feature from Willem de Bruijn.
> 
> Original series
>     Message-Id: 20210208185558.995292-1-willemdebruijn.kernel@gmail.com
>     Subject: [PATCH RFC v2 0/4] virtio-net: add tx-hash, rx-tstamp,
>     tx-tstamp and tx-time
>     From: Willem de Bruijn <willemb@google.com>
> 
>     RFC for four new features to the virtio network device:
> 
>     1. pass tx flow state to host, for routing + telemetry
>     2. pass rx tstamp to guest, for better RTT estimation
>     3. pass tx tstamp to guest, idem
>     3. pass tx delivery time to host, for accurate pacing
> 
>     All would introduce an extension to the virtio spec.
> 
> The original series consisted of a hack around the DMA API, which should
> be fixed in this series.
> 
> The changes in this series are to the driver side. For the changes to qemu see:
>     https://github.com/strumtrar/qemu/tree/v8.1.1/virtio-net-ptp
> 
> Currently only virtio-net is supported. The original series used
> vhost-net as backend. However, the path through tun via sendmsg doesn't
> allow us to write data back to the driver side without any hacks.
> Therefore use the way via plain virtio-net without vhost albeit better
> performance.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Thanks for picking this back up, Steffen. Nice to see that the code still
applies mostly cleanly.

For context: I dropped the work only because I had no real device
implementation. The referenced patch series to qemu changes that.

I suppose the main issue is the virtio API changes that this introduces,
which will have to be accepted to the spec.

One small comment to patch 4: there I just assumed the virtual device
time is CLOCK_TAI. There is a concurrent feature under review for HW
pacing offload with AF_XDP sockets. The clock issue comes up a bit. In
general, for hardware we cannot assume a clock. For virtio, perhaps
assuming the same monotonic hardware clock in guest and host can be
assumed. But this clock alignment needs some thought.


