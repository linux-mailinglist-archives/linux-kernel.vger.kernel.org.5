Return-Path: <linux-kernel+bounces-4715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CDC818101
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13917285D5D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856EC746A;
	Tue, 19 Dec 2023 05:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAFD5OFT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E8E6FB4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 05:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-58d18c224c7so2565023eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 21:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702963802; x=1703568602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KSDKlkaKqJ/0klbby4oepQ0g/PTqlT6o7kLyfpy1io=;
        b=nAFD5OFTvPEZJbXH0dY1kDTboG0FWXyenFbvQe6f8SyWWvjY0zJnaau4ttnSpf60rV
         KHjqGYGUnpTPYssl82Z0eAHPrBEguulz414bwV0N3/SNW8qFaha5OiybXNzFg5nU6aDP
         1BW8f40f9pHLnaiV9Y9qvFdOAlKc3Do+AgvR+7J7sXDlLG/peQJkZx54nY5w0T/TXUap
         vlBig1k20fSGz/NFvgz+TCiVFENgmajWfvH27TbNrES/T3adbz3dF948SggDc6mgELrU
         xxc2/vSK04hcX35aKOrS0peSA52F3grFxV5PM3qmUoTn61Cpj/tQgMLoIRLFMDrmRsF8
         AqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702963802; x=1703568602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KSDKlkaKqJ/0klbby4oepQ0g/PTqlT6o7kLyfpy1io=;
        b=Bs1JpprXZXclRKHFMEJSltiEkQPmlhG2Rfj2QWCImO93pNUS/90qad1BwOamXAUBBH
         mkIbnwxP0tfWzy8Er59c2lx/htih7sTEAwyeL1rpLDsyX8Enp8joI+cSagBlNaw+6VVr
         z04k7SWyQiMIVy62PM1og1xFVbwRlovGNHNy1K94UdD6bO64ET3S9+UFBRGqXhYFBYRH
         2WSP53pZW/psHY9WBUkJCdDuCr7w9kV1xRiBof4YALSN8Ey9vnkLZgdJLPH8Hi19eFuw
         pjG4fGwtNaQXr6raWUnZAbBdYDoxf4oCcxMeHjixRXTCKMWdZsNwGPDNY5FMqAFt4Kwp
         Nngg==
X-Gm-Message-State: AOJu0Yz3fnNCS9v+rR3qhcgwVYdcCb36bCFnYcphKvgbP+nJettVhfR9
	0RdrvhStzXRUMqTQ8cF1gj8=
X-Google-Smtp-Source: AGHT+IGEThJt6CiGC764R0tEHsIGvawOxueOl2KAAAtuymZ2zRABXJEYv1oewzC0AqOEt2NXdSCojQ==
X-Received: by 2002:a05:6358:248b:b0:170:6ed7:3148 with SMTP id m11-20020a056358248b00b001706ed73148mr12035927rwc.22.1702963802200;
        Mon, 18 Dec 2023 21:30:02 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id 17-20020a17090a195100b0028b1fce7c01sm568132pjh.37.2023.12.18.21.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 21:30:01 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: fuqiang.wang@easystack.cn
Cc: bhe@redhat.com,
	dyoung@redhat.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	vgoyal@redhat.com,
	ytcoode@gmail.com
Subject: Re: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Date: Tue, 19 Dec 2023 13:29:29 +0800
Message-ID: <20231219052955.40414-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c797bdde-b5a5-4b2b-9106-c1386a0e7516@easystack.cn>
References: <c797bdde-b5a5-4b2b-9106-c1386a0e7516@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 19 Dec 2023 11:50:32 +0800, fuqiang wang <fuqiang.wang@easystack.cn> wrote:
> 在 2023/12/19 10:47, Yuntao Wang 写道:
> 
> > Hi fuqiang,
> >
> > Yesterday, I posted two patches that happen to address the bugs you an Baoquan
> > are currently discussing here, I wasn't aware that you both were also working
> > on fixing these issues.
> >
> > Baoquan suggested I talk to you about it.
> >
> > If you're interested, you can take a look at my patches and review them to see
> > if there are any issues. If everything is fine, and if you're willing, you can
> > also add a 'Reviewed-by' tag there.
> >
> > The following link is for the two patches I posted yesterday:
> >
> > https://lore.kernel.org/lkml/20231218081915.24120-3-ytcoode@gmail.com/t/#u
> >
> > Sincerely,
> > Yuntao
> 
> Hi Yuntao,
> 
> I'm glad you've also noticed this issue. But I'm sorry, I want to solve this
> problem myself because this is my first time posting a patch in the community,
> and I cherish this opportunity very much.

I can truly understand your feelings because I still remember how thrilled I
was when my first patch got merged. So keep it up!

> 
> I have carefully reviewed your patch. There is some changes where my views differ
> from yours:
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index c92d88680dbf..3be46f4b441e 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -282,10 +282,6 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>       struct crash_memmap_data cmd;
>       struct crash_mem *cmem;
> 
> -    cmem = vzalloc(struct_size(cmem, ranges, 1));
> -    if (!cmem)
> -        return -ENOMEM;
> -
>       memset(&cmd, 0, sizeof(struct crash_memmap_data));
>       cmd.params = params;
> 
> @@ -321,6 +317,11 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>       }
> 
>       /* Exclude some ranges from crashk_res and add rest to memmap */
> +    cmem = vzalloc(struct_size(cmem, ranges, 1));
> +    if (!cmem)
> +        return -ENOMEM;
> +    cmem->max_nr_ranges = 1;
> +
>       ret = memmap_exclude_ranges(image, cmem, crashk_res.start, crashk_res.end);
>       if (ret)
>           goto out;
> 
> 1. I don't feel very good that you have moved vzalloc() to in front of
> memmap_exclude_ranges. Because if memory allocation fails, there is no need to
> do anything else afterwards.

I moved it here because only memmap_exclude_ranges() and the code below it use cmem.

I think it is a good practice to put related code together, which also improves
code readability.

> 
> 2. The cmem->max_nr_ranges should be set to 2. Because in
> memmap_exclude_ranges, a cmem->ranges[] will be filled in and if a split occurs
> later, another one will be added.

With the current code, image->elf_load_addr should be equal to crashk_res.start,
so split will not occur in crash_exclude_mem_range(). Therefore, setting
cmem->max_nr_ranges to 1 is safe.

> 
> Thanks
> fuqiang

