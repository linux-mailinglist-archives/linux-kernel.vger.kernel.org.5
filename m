Return-Path: <linux-kernel+bounces-19819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F288274AA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7F4E1C22D5D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72295524D5;
	Mon,  8 Jan 2024 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Chb5hd3L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D497524A8;
	Mon,  8 Jan 2024 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-67f95d69115so18182306d6.1;
        Mon, 08 Jan 2024 08:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704730198; x=1705334998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dhSewSpgkcJyN3c0+ItuRDu2rcQV9xAuNoLxs3FbQc=;
        b=Chb5hd3LVaV/0lQjKPeMGxPrJlIFdQY1sYY7uBkMIWpQ8w1O7zkLf94sa5K5lefARi
         wWu2V561owDDd2DuXDl8SG+KabIFr8KDjGZwz5xWaOgN7aAgGa7HAganxq00QMW/7Bj1
         lrnuRbj+BhfmrLFyZzSFwGKbbAxG6SXkWav51dL6Wjq7GsIe8f90xWvXTPCFmDpxLbDZ
         9uoqUZBmL/XitOY0cZcEng+9utr68KtCj0ii1FzJ55woiWO5QHAAsEohEEe4OhZavo5+
         HjmJpSBmUIz4XxhWNL2YWKtXqsAeKmmFxjQyY7fPydht/75ZxRZ4ZDaDBSPt0WX2v2Ov
         3YAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704730198; x=1705334998;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9dhSewSpgkcJyN3c0+ItuRDu2rcQV9xAuNoLxs3FbQc=;
        b=ahMD94I5xq91PiE3w8sVDWpXTss9PPyD56BiA1Remdm/L3qU91wH2OYBwL51zGV+Or
         h7IMIrVMcVXV47NF1VgZWiAKLipOJWj8XZwciUpRrkMpoJQGU0BI685fb0g+wfVFNh6j
         gcykzAQfg95FgF9MXW5NZ8h8hSowlwmBMwykmiWSicAIU2JU79Yn32k+BQrIEXb9CYWw
         Hb/xXEsb2/CEDXmamFDovaEstFoCT6vB2lOB5u2siANjJmGmDAm11RjnzN7JkLbF/MS5
         P/fBOPWF1k9K+msFRw4lDM4pTR7FBgSPlaE4IBCntAr19BVexfRO3HVPbIkHMj5RQrn5
         jtTg==
X-Gm-Message-State: AOJu0Yx13SNO2UG3qLxxYWg3iLTH4Q3cqMG0XShMroRIi+mP72IHzaoK
	OFwmVMxt44ZnXHNMlJ2TOGw=
X-Google-Smtp-Source: AGHT+IFKR91jU04CKBhbztCBLlqtyR1fBQRnsnwWFAyu8YvnPWRmtUUDj4FcqzL39Kh7XN9JLd5ulQ==
X-Received: by 2002:a05:6214:d62:b0:67f:a9dc:4cc9 with SMTP id 2-20020a0562140d6200b0067fa9dc4cc9mr6000478qvs.30.1704730197994;
        Mon, 08 Jan 2024 08:09:57 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id d6-20020a0cc686000000b00680b7496635sm81108qvj.42.2024.01.08.08.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 08:09:57 -0800 (PST)
Date: Mon, 08 Jan 2024 11:09:57 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <659c1e5543102_32ba6829429@willemb.c.googlers.com.notmuch>
In-Reply-To: <49f86f3c-2476-4991-b01c-171a54258994@intel.com>
References: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
 <658b364d56c6e_5c2a929468@willemb.c.googlers.com.notmuch>
 <49f86f3c-2476-4991-b01c-171a54258994@intel.com>
Subject: Re: [PATCH RFC net-next 00/34] Christmas 3-serie XDP for idpf
 (+generic stuff)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alexander Lobakin wrote:
> From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Tue, 26 Dec 2023 15:23:41 -0500
> 
> > Alexander Lobakin wrote:
> >> I was highly asked to send this WIP before the holidays to trigger
> >> some discussions at least for the generic parts.
> >>
> >> This all depends on libie[0] and WB-on-ITR fix[1]. The RFC does not
> >> guarantee to work perfectly, but at least regular XDP seems to work
> >> for me...
> >>
> >> In fact, here are 3 separate series:
> >> * 01-08: convert idpf to libie and make it more sane;
> >> * 09-25: add XDP to idpf;
> >> * 26-34: add XSk to idpf.
> >>
> >> Most people may want to be interested only in the following generic
> >> changes:
> >> * 11: allow attaching already registered memory models to XDP RxQ info;
> >> * 12-13: generic helpers for adding a frag to &xdp_buff and converting
> >>   it to an skb;
> >> * 14: get rid of xdp_frame::mem.id, allow mixing pages from different
> >>   page_pools within one &xdp_buff/&xdp_frame;
> >> * 15: some Page Pool helper;
> >> * 18: it's for libie, but I wanted to talk about XDP_TX bulking;
> >> * 26: same as 13, but for converting XSK &xdp_buff to skb.
> >>
> >> The rest is up to you, driver-specific stuff is pretty boring sometimes.
> >>
> >> I'll be polishing and finishing this all starting January 3rd and then
> >> preparing and sending sane series, some early feedback never hurts tho.
> >>
> >> Merry Yule!
> >>
> >> [0] https://lore.kernel.org/netdev/20231213112835.2262651-1-aleksander.lobakin@intel.com
> >> [1] https://lore.kernel.org/netdev/20231215193721.425087-1-michal.kubiak@intel.com
> > 
> > This is great. Thanks for sharing the entire series.
> > 
> > Which SHA1 should we apply this to? I'm having a hard time applying
> > cleanly.
> > 
> > The libie v7 series applied cleanly on bc044ae9d64b. Which I chose
> > only based on the follow-on page pool patch.
> > 
> > But that base commit causes too many conflicts when applying this.
> > Patch 6 had a trivial one in idpf_rx_singleq_clean (`skb = rx_q->skb`).
> > But patch 14 has so many conflicts in page_pool.c, that I'm clearly
> > on the wrong track trying to fix up manually.
> 
> net-next was updated while I was preparing the series. I also did a
> couple changes in the basic libie code, but a new rev wasn't sent.
> Please just use my open GH[0].
> 
> [0] https://github.com/alobakin/linux/tree/idpf-libie

Even better, thanks. I'll use that to run my basic XSK tests.

