Return-Path: <linux-kernel+bounces-112630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7C2887C38
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 11:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43335281C84
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 10:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2309B171C8;
	Sun, 24 Mar 2024 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a88nlKwt"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B4615E89
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711276071; cv=none; b=OIXXXqWfyqOEXSXTUp91bWGF5JX1ioFZon1FNK8/nj5BBzD+LxFYdPBsKmE2Ichkg6hlLYpknxjO/uWa99ut8IRjffK1vPrNVdX97D7BCknbkWIUVI4L6Nw3WFIFNQfFxfz8rbKU/aPc5q3AVds6/rqtvIH2FQ6FLJdTPJ3sOII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711276071; c=relaxed/simple;
	bh=g5o4Usv6iCgLDxofD0zUG1xxJtGV/DtXPWmHDLxqyrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrCOCUpSDrh6XktYOfJtXCzHuMhXwMHVrBYOJhtIsl/IXzrkhONgu2uQnQRvhK1GQN8+EAw8ZU2kdXEWsRNFPy0cnY81dvFEst5FSU6xJkvBNbYB3PaC5fTxh5A6Rpj5eFgDVIj5dnkfyJ8QZL7xwxsZNytX8g6fFrg0ehj3WNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a88nlKwt; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513e89d0816so4307449e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 03:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711276068; x=1711880868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bauhf/2rjBkok/hrNxsx2Lp6yFKty71agj7qYN59Fb4=;
        b=a88nlKwtLMDtpmkVgKn7iCcZLp4xcfsLF/PRb8fI2tUjrpxa+XHAKfL3mLDzVOXIe2
         zXwW8hpfWOijIvX+eWHB9gdtY2z6cMrHIm9NrTyCPvmiY+I1JtqyECoyIIQ9uAfDuA1s
         ihSOvWluIfTsuQ4UzRzMRbZyHNC3DT59tP8BqDQFoThBgRFdji1CCDb91DmBOTXdvsF8
         Y/RdhXMKZ9A6XTnHdBjvtVr51CuQLmxflcUacyVloz2gIsQVmVfVVis6rqK9tUmHa+1W
         I8qQE40s0AARbFnEHIEaqlk0JTDABlAhS/BUgpjgT+JRECapAXDHmuB8MN4wdhVYAeuM
         UzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711276068; x=1711880868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bauhf/2rjBkok/hrNxsx2Lp6yFKty71agj7qYN59Fb4=;
        b=qOv4vQz6QgDv/FE3K7baiLOl2Y2YLHPreSfK2EgkGNtnYb28cn6rsQ6lzNwgrLV+ei
         150HwCvXhkzLcbaEr1Q9G5E01VNCiphpj+2XnDRq/jYRI1Y1XII2rTLdMN4ctx8KvJdH
         9ikJedbarhqyL+m8PfE+LkZAFA8PFPU3N1sFEh7Dyl3bZwBvgtDOIrmwNwa9KM75wyfC
         FCQUKTUtwVXGLx/dq3Nih13S5pbRt0lzPZW+MgDxqvPV6/T1+aPP2U8W3DzcrNQ01dHf
         BffsKU21rW3mm/iVcMiftZY1d4ctN+k5nI+c+FZotO7ET/a1djGDVYZhi6PtMNkGVDeP
         cp2g==
X-Forwarded-Encrypted: i=1; AJvYcCXh5vlY/eBVtqXQ7GIV5A6m7tKk696+B8FylAeXTo4gw7ix8R5dNL2qMEGAl9WM6bir2iau3CtX+DHPV+Gf25msclxkgsUaghLBGuVI
X-Gm-Message-State: AOJu0Yw4kwsF1XDPPqDSdHixrr/hW9HV/ZQ6FuvCTUvEQqdtXR83vWW/
	22xCF53cDE/1odrhRHwMguKiYquBHWJbbBhSVOv26p/gatRsyqrQ
X-Google-Smtp-Source: AGHT+IFqkThVpXulVzVhNJekNUYVHumLnBKOTdbzFKyjcLlJN4lf7UbH8vVeWJuT2lsfD35b007Cug==
X-Received: by 2002:ac2:4643:0:b0:513:4705:a4f3 with SMTP id s3-20020ac24643000000b005134705a4f3mr2753394lfo.65.1711276067486;
        Sun, 24 Mar 2024 03:27:47 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b00414808dea22sm1107606wmq.0.2024.03.24.03.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 03:27:46 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 24 Mar 2024 11:27:44 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	akpm@linux-foundation.org, chenhuacai@loongson.cn,
	dyoung@redhat.com, jbohac@suse.cz, lihuafei1@huawei.com,
	chenhaixiang3@huawei.com
Subject: Re: [PATCH] crash: use macro to add crashk_res into iomem early for
 specific arch
Message-ID: <ZgAAIB6H+7+t7YpW@gmail.com>
References: <20240324033513.1027427-1-bhe@redhat.com>
 <Zf+m4YtKtmdrjw4Q@gmail.com>
 <Zf/51a+QonYj6sI7@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zf/51a+QonYj6sI7@MiWiFi-R3L-srv>


* Baoquan He <bhe@redhat.com> wrote:

> On 03/24/24 at 05:06am, Ingo Molnar wrote:
> > 
> > * Baoquan He <bhe@redhat.com> wrote:
> > 
> ......snip
> > > ---
> > >  arch/x86/include/asm/crash_reserve.h | 2 ++
> > >  kernel/crash_reserve.c               | 7 +++++++
> > >  2 files changed, 9 insertions(+)
> > > 
> > > diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/crash_reserve.h
> > > index 152239f95541..4681a543eba3 100644
> > > --- a/arch/x86/include/asm/crash_reserve.h
> > > +++ b/arch/x86/include/asm/crash_reserve.h
> > > @@ -39,4 +39,6 @@ static inline unsigned long crash_low_size_default(void)
> > >  #endif
> > >  }
> > >  
> > > +# define HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
> > > +
> > 
> > Any reason for that stray space?
> 
> No clear reason. I saw stray space was added for macro definning when my
> below patch was merged, not sure if this is preferred.

No, it's not preferred - and I don't see any stray spaces added in the 
code added by:

> commit 85fcde402db1 ("kexec: split crashkernel reservation code out from crash_core.c")

Anyway, please just remove it.

> And there are a lot of "# define " when searching with 'git grep "# 
> define " arch/x86/include/'.

The overwhelming majority of those are not standalone defines like 
yours, but nested/conditional defines where the space is justified:

#ifdef CONFIG_X86_32
# define MAX_IO_APICS 64
# define MAX_LOCAL_APIC 256
#else
# define MAX_IO_APICS 128
# define MAX_LOCAL_APIC 32768
#endif

Thanks,

	Ingo

