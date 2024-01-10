Return-Path: <linux-kernel+bounces-22616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFA382A07A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31161F2485F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271964D5A8;
	Wed, 10 Jan 2024 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FeHX1Skv"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED57E4D12A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso5282858a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704912765; x=1705517565; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m3UJsqaOgk5eE2VQnILkdg8C0bn7x8fx0mLavVcEL4o=;
        b=FeHX1SkvwsxvfzE/eELwaPdgUllP66IgEj3HgO+eOMZi9w4TJY+UcrzX7NFdAAM55g
         Uj/NX+yIls9FrQKTQvgTVWhCMicEbJh6vOLtfPbK92oeG+C/esMYA9jUkdxHqMGKtQE0
         fIsnP9tfKkeBqmMi0zMrMjE8ZeFxcol8g860Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704912765; x=1705517565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3UJsqaOgk5eE2VQnILkdg8C0bn7x8fx0mLavVcEL4o=;
        b=IWPVhs0B95wTIh0X2q7jHBejguyHJITWNK68c075XT7GzThsVNCdGhRS9HbLzlPSj0
         faHFkfWyPG6WsPKZmacCCscqMuYl67tMf92Y5bHyyqfcRjTvK2+Eu6HyKXnuLtHQEM8u
         IQVKMg3jW7QWJ30pL5RpMIJpIBU8HPVEL2IxQTK+V1mywnNWBwKdJj/VhPkxsUjciqHt
         ne+AhzRTqfdlnwBhZp4R+lRjly/8Iv4nWLhyeGDbD6RciZL5fOftGeTmX7M6vVju4m8/
         y4kBtU3BtAnW+qRd78zDMOM+1VGw94sFFWp+6Z2Rfp1aagbdFghXaI0cPm4fGkb/csu7
         4ajA==
X-Gm-Message-State: AOJu0YwUieiQ9H1CJcMPk84S2gzG6wa1qub2Modhs0nsz5OS8vcI8qLX
	CUVYFE4C/P+P4bz673qmFXJYzfiHpbMSd1kQUzsR2P8prJmFXd8t
X-Google-Smtp-Source: AGHT+IElvc/ZD/60V3FEDlZujVjuEU9Djqrfwrd6LMbVJHNy1HVyLst00agfLeK/orVGg8cJCyyDgw==
X-Received: by 2002:aa7:d152:0:b0:557:7862:573 with SMTP id r18-20020aa7d152000000b0055778620573mr360630edo.52.1704912765165;
        Wed, 10 Jan 2024 10:52:45 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id g23-20020a056402115700b005527c02c1d6sm2267282edw.50.2024.01.10.10.52.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 10:52:44 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55822753823so2208050a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:52:44 -0800 (PST)
X-Received: by 2002:a7b:cb45:0:b0:40e:4ada:b377 with SMTP id
 v5-20020a7bcb45000000b0040e4adab377mr402184wmj.62.1704912744493; Wed, 10 Jan
 2024 10:52:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ4fyY4r3rqgZL+4@xpf.sh.intel.com> <CAHk-=wgJz36ZE66_8gXjP_TofkkugXBZEpTr_Dtc_JANsH1SEw@mail.gmail.com>
 <1843374.1703172614@warthog.procyon.org.uk> <20231223172858.GI201037@kernel.org>
 <2592945.1703376169@warthog.procyon.org.uk> <1694631.1704881668@warthog.procyon.org.uk>
 <ZZ56MMinZLrmF9Z+@xpf.sh.intel.com> <1784441.1704907412@warthog.procyon.org.uk>
In-Reply-To: <1784441.1704907412@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jan 2024 10:52:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiyG8BKKZmU7CDHC8+rmvBndrqNSgLV6LtuqN8W_gL3hA@mail.gmail.com>
Message-ID: <CAHk-=wiyG8BKKZmU7CDHC8+rmvBndrqNSgLV6LtuqN8W_gL3hA@mail.gmail.com>
Subject: Re: [PATCH] keys, dns: Fix missing size check of V1 server-list header
To: David Howells <dhowells@redhat.com>
Cc: Pengfei Xu <pengfei.xu@intel.com>, eadavis@qq.com, Simon Horman <horms@kernel.org>, 
	Markus Suvanto <markus.suvanto@gmail.com>, Jeffrey E Altman <jaltman@auristor.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Wang Lei <wang840925@gmail.com>, 
	Jeff Layton <jlayton@redhat.com>, Steve French <smfrench@gmail.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-afs@lists.infradead.org, keyrings@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	heng.su@intel.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 09:23, David Howells <dhowells@redhat.com> wrote:
>
> Meh.  Does the attached fix it for you?

Bah. Obvious fix is obvious.

Mind sending it as a proper patch with sign-off etc, and we'll get
this fixed and marked for stable.

           Linus

