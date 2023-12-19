Return-Path: <linux-kernel+bounces-5415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D957818A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E881C2129D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509CD1C293;
	Tue, 19 Dec 2023 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAm0RyZg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AD91C284;
	Tue, 19 Dec 2023 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cc5d9cf766so49068941fa.2;
        Tue, 19 Dec 2023 06:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702997556; x=1703602356; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vzy04ObpjX890JmFMpxy3bGkqqGmQ0dqXGeU+O4Kb18=;
        b=cAm0RyZgTacxtJcSZs6xyzq8ZB7OumJms6S3qfIRbf6Lsx9VKJl39U3qqanHIl/4AS
         8ZCIBVGUDIAu2GM8yZbdt4i73s3tMGlYqT6wTTGzYwfHEjLtbcWSltybDlaPUJZVEmu8
         M8Tyvv7zdCzTFqWQi/gy4eDHGvTpLZnq7KGTM/ZsXjGYrIeBDpEOBt1O6gjFU3JSySel
         KsaULPnuDM0K6fmRGuuad7Hf+qWL01FsaJVMRxSvw7mbaf/QwlZgIhbau3XUafJDViVJ
         Za+KkmTTO0X3fZjg1PEupTU7cXdrTDq6t6CgeHBOvFtd1CdMXFHS/ZSgvWGFmVr3DANN
         HJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702997556; x=1703602356;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vzy04ObpjX890JmFMpxy3bGkqqGmQ0dqXGeU+O4Kb18=;
        b=K1D3IrG7M1LJPc6bmw9sCCgCbl8Y1ZkfWkt8CcWuYBFKvH1JU5RQC9q2X7w9L1yc9z
         apADDxjyohThqwXj7KaPxGBr7PbEu/FORvEAKlaU+4DdVI0d/nI37zUChY8D1upYxEQJ
         riLR7ixZCNm6kkXoNFrsUEkI8RxmX0RIl0s5Wh3hK5OePJ5UbPZJlIATCzsPTCpTTsZQ
         vJFasEPlqGnm7WE3nITEM96CASN6I3hYu4IcXQWAve6+55EreqLkhao4PdADv2ZShoMf
         YIInoM1vyl1qRRYcZz5qgGuE0Y3VLpDyKGxSVj7HbXeldjtxQ4z+OMEFgx5xt99SbwhJ
         0EJQ==
X-Gm-Message-State: AOJu0YzipthLfH67NZj0+rkchJQ1x2ESUlxdfRQbTAmzEsNDHCg8h7ep
	wksYz3kTpwofTm7bCVNsHJ87OHoEh08=
X-Google-Smtp-Source: AGHT+IEpEQOBYmp7KTxCWJn5L40Mta8y5pdbWSBBhWnnSvaCe32skYFcCguuYqr/hRiGk269EHEI6Q==
X-Received: by 2002:a05:651c:622:b0:2cc:7718:edfe with SMTP id k34-20020a05651c062200b002cc7718edfemr1280605lje.41.1702997556139;
        Tue, 19 Dec 2023 06:52:36 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id s5-20020a2ea105000000b002cc89571c28sm40544ljl.30.2023.12.19.06.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 06:52:35 -0800 (PST)
Date: Tue, 19 Dec 2023 17:52:33 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: xiongxin <xiongxin@kylinos.cn>, hoan@os.amperecomputing.com, 
	linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v3] gpio: dwapb: mask/unmask IRQ when disable/enale it
Message-ID: <ee3fwqa5r3jablflueewun7wzu3g6uezoniloouxfebox5qnyf@e7n63v7teaw2>
References: <20231219013751.20386-1-xiongxin@kylinos.cn>
 <7zdg5ujizncarxvdyahnusojiq44rzxx2zybqj4kzsonzr27gq@fm5wj7npqsk3>
 <CAHp75VceVAZYTNsJaYYRN+EMExFZSQARsJowd-CvDLRtuOPKSg@mail.gmail.com>
 <euhbczna4hk5sacb23i2xwqh2jewlek7cfceprfslpsiijhwk3@3d6vtybmgag5>
 <ZYGsRXJUcrLKEzUn@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZYGsRXJUcrLKEzUn@smile.fi.intel.com>

On Tue, Dec 19, 2023 at 04:44:21PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 19, 2023 at 05:31:38PM +0300, Serge Semin wrote:
> > On Tue, Dec 19, 2023 at 04:17:16PM +0200, Andy Shevchenko wrote:
> > > On Tue, Dec 19, 2023 at 11:14 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> > > > On Tue, Dec 19, 2023 at 09:37:51AM +0800, xiongxin wrote:
> > > 
> > > ...
> > > 
> > > > Also note all the tags you've already got must be preserved on the
> > > > next patch revisions. One more time:
> > > 
> > > > Acked-by: Serge Semin <fancer.lancer@gmail.com>
> > > 
> > > I recommend using `b4` for that.
> > > 
> > > it harvests tags from the email thread, so no need to care about
> > > possible misses.
> > 
> > AFAICS it doesn't pick up the tags from the previous revisions at
> > least if the new patch wasn't submitted as in-reply-to the prev one.
> 
> ???
> 
> > Just tested it on v3. b4 found my new ab-tag only and no yours rb-tag.
> > Did you mean something other than I thought you did?
> 

> Grabbing thread from lore.kernel.org/all/mdogxxro42ymeaykrgqpld2kqbppopbywcm76osskuf3df72sl@5jalt26vzcv4/t.mbox.gz

It's _v2_. I was talking about _v3_:

[user@pc] $ b4 am 20231219013751.20386-1-xiongxin@kylinos.cn
Grabbing thread from lore.kernel.org/all/20231219013751.20386-1-xiongxin%40kylinos.cn/t.mbox.gz
Analyzing 5 messages in the thread
Checking attestation on all messages, may take a moment...
---
  [PATCH v3] gpio: dwapb: mask/unmask IRQ when disable/enale it
    + Acked-by: Serge Semin <fancer.lancer@gmail.com> (✓ DKIM/gmail.com)
---
Total patches: 1
---
 Link: https://lore.kernel.org/r/20231219013751.20386-1-xiongxin@kylinos.cn
 Base: applies clean to current tree
       git checkout -b v3_20231219_xiongxin_kylinos_cn HEAD
       git am ./v3_20231219_xiongxin_gpio_dwapb_mask_unmask_irq_when_disable_enale_it.mbx

In anyway, Xiong already submitted v4 with all the tags added:
https://lore.kernel.org/linux-gpio/20231219101620.4617-1-xiongxin@kylinos.cn/
which you've already noticed.

-Serge(y)

> Analyzing 4 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>   [PATCH v2] gpio: dwapb: mask/unmask IRQ when disable/enale it
>     + Reviewed-by: Andy Shevchenko <andy@kernel.org>
>     + Acked-by: Serge Semin <fancer.lancer@gmail.com> (✓ DKIM/gmail.com)
> 
> The flow you need to follow is that
> 
> 	git checkout $BASE # gpio/for-next in this case
> 	b4 am ... # as above
> 	git am ...
> 	...address comments...
> 	git commit -a -s --amend
> 	git format-patch ... -1 HEAD~0
> 	git send-email ...
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 

