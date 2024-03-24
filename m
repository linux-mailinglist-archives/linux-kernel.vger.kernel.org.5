Return-Path: <linux-kernel+bounces-112579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3D2887BA3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8591C20B1D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A539470;
	Sun, 24 Mar 2024 04:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuDNcU91"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697E423CE
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 04:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711253224; cv=none; b=LFeIaa5VYrfzzeavs9RULWX5gQI+EFRb/rPH325eRYtiV/HEER/yjbgpit/UvQvovn1xs2dhS/5O/UIOkTC8yup5HcId3HEsVLg6QBv39tGTGajr4QuW8nu1Q05zsWpa/ip9iNgSex3RR7acbfPcXiNVFnCnwP+aW9Vy8EjRKZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711253224; c=relaxed/simple;
	bh=rtihWBQcO+f01Fp1toRH6VRZJC7RziVDNZH5AjaCfek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=limyGw5DOs3OLZP9RpWdScOK8nUT2PNUqdGZGWwbZ5useqjL6JEpN0687/LiUCopeOmvor+adJkVpKhmpfYkrnl+M+OMglFNMMFpVoemgMrbRjwYuBanP2/t/ibBvZyHQaFfIzYvuTfaliIEOO46QDXkuiVvSsKR5F5vsSNmaWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuDNcU91; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33ed5b6bf59so2303715f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 21:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711253221; x=1711858021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CoEoEfVFuz6mK2rsSHpUkc2k4VLzktd6pNRYNSI33vg=;
        b=kuDNcU91QzGP6EsiVc5rOxA05DdBN6Uld2aYCnDT3L415lTXVhJE0V0X9Kaqdok+sG
         l45NXvZGvmJ9GTlPmZSaAQK/jcXxN2NI9JkUmv8mFr4h1Lw/vIlNPo+62Gr54wc6Nc6o
         FtvUyVgHw62ujPRE/u47nIGWNHaO0c6l4A0br7AMuqF28/FQj6aZthxMIRAwMXCiTCDh
         3uCwp/MlmAJpokbi5IZUL1IFOGe+Wvr67O8ONgubyNdroL28BcTGS517VATlVPgf29Np
         i7zIdX/CAAIgasqeuizujjo2/ek+dzDb4NeqfjbSt7gamW8Npk6xnvodYGx0sVM+Hcvq
         quGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711253221; x=1711858021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoEoEfVFuz6mK2rsSHpUkc2k4VLzktd6pNRYNSI33vg=;
        b=X2+XGZrgTBrMXyiKspfkZoMpCogtmYmA/od2OwOU+4N7GzSLYagCArB6iB2ssG/rlh
         7jnN66IujXD5ERRXWDG/K8l/RRdei2099D3j6fMibHMKAYeAHEvCQnftTc8PF2nhrC5H
         GSnPd3wbb6fwgg+AdgnKUPsQu9nvq3oLuqsZBakUalulovHdPfC+pFRNAPJ36mZ8x22h
         e6Ka+QoZEFTCnDmj3GSZ16uBBgrzNBOT6HExYEPjRcJx+DhRET3KrT/DuncrBrQW9lyt
         zQvTThr9dX7RVgzkErjtBsMSf355KDsg5xqxi07bwxVW3jCvxcZDmvnD2rE+EsYkzaYD
         t2FA==
X-Forwarded-Encrypted: i=1; AJvYcCUz6OrBefe6wAQj8IC6RBeu8xyslyTyzymX0z1+Yf3ia0h/ZOhlYN6FZHYtYXzvYCfx961CYRLLHaOV41/Z1FkW7FtM2QNcKCGen2eS
X-Gm-Message-State: AOJu0Yxqu/A1P52GvIsF7918TsQI6PuRRpkVl+czoeyd37seU4JB4mmp
	TwCfdpV+t0iq8POu++ec7LeyRVTY0pYIVZRf8dYu8FSnd2/ZXIIw
X-Google-Smtp-Source: AGHT+IEveqr8Ikeunb9ZMOPuR2Y8bK0WNDTQp9eMtP2gcjqHfA+X7uAYuBF26KK1Brd/v1Sz6y6mXA==
X-Received: by 2002:a5d:6382:0:b0:33e:7aff:a3a0 with SMTP id p2-20020a5d6382000000b0033e7affa3a0mr2140376wru.71.1711253220432;
        Sat, 23 Mar 2024 21:07:00 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id h2-20020a5d5042000000b00341c162a6d4sm2770501wrt.107.2024.03.23.21.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 21:06:59 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 24 Mar 2024 05:06:57 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	akpm@linux-foundation.org, chenhuacai@loongson.cn,
	dyoung@redhat.com, jbohac@suse.cz, lihuafei1@huawei.com,
	chenhaixiang3@huawei.com
Subject: Re: [PATCH] crash: use macro to add crashk_res into iomem early for
 specific arch
Message-ID: <Zf+m4YtKtmdrjw4Q@gmail.com>
References: <20240324033513.1027427-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324033513.1027427-1-bhe@redhat.com>


* Baoquan He <bhe@redhat.com> wrote:

> There are regression reports[1][2] that crashkernel region on x86_64 can't
> be added into iomem tree sometime. This causes the later failure of kdump
> loading.
> 
> This happened after commit 4a693ce65b18 ("kdump: defer the insertion of
> crashkernel resources") was merged.
> 
> Even though, these reported issues are proved to be related to other
> component, they are just exposed after above commmit applied, I still
> would like to keep crashk_res and crashk_low_res being added into iomem
> early as before because the early adding has been always there on x86_64
> and working very well. For safety of kdump, Let's change it back.
> 
> Here, add a macro HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY to limit that
> only ARCH defining the macro can have the early adding
> crashk_res/_low_res into iomem. Then define
> HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY on x86 to enable it.
> 
> Note: In reserve_crashkernel_low(), there's a remnant of crashk_low_res
> hanlding which was mistakenly added back in commit 85fcde402db1 ("kexec:
> split crashkernel reservation code out from crash_core.c").
> 
> [1]
> [PATCH V2] x86/kexec: do not update E820 kexec table for setup_data
> https://lore.kernel.org/all/Zfv8iCL6CT2JqLIC@darkstar.users.ipa.redhat.com/T/#u
> 
> [2]
> Question about Address Range Validation in Crash Kernel Allocation
> https://lore.kernel.org/all/4eeac1f733584855965a2ea62fa4da58@huawei.com/T/#u
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/include/asm/crash_reserve.h | 2 ++
>  kernel/crash_reserve.c               | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/crash_reserve.h
> index 152239f95541..4681a543eba3 100644
> --- a/arch/x86/include/asm/crash_reserve.h
> +++ b/arch/x86/include/asm/crash_reserve.h
> @@ -39,4 +39,6 @@ static inline unsigned long crash_low_size_default(void)
>  #endif
>  }
>  
> +# define HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
> +

Any reason for that stray space?

Thanks,

	Ingo

