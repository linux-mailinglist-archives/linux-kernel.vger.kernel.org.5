Return-Path: <linux-kernel+bounces-65236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A04328549D3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 414FFB28D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E1252F86;
	Wed, 14 Feb 2024 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GlAK+298"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011E22C862
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915503; cv=none; b=o5QIUxCI+86ydE8k+FTK4PLIvh+l+Q2isbZCglzL+FlxHyvJQ+L2FQMmABrPcMgQWZE/ZwfHrFH0SD9W0bEG8L0a7ol+yQYYAeBSgXF+Rh7/3+07jvZ29BcnTtMQ5/E1i+Ihy/EFxIC1jxcOVL4Mrk013eSC7D3mVUb0bCJloQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915503; c=relaxed/simple;
	bh=APx2E3fvp48dROhXirvbfoT7BMcdWI18I17pXx4JJhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwrjW2fhpkj/0dtmcqxgrEUQsPUbFmuLIdgtrJFB00GnoUvc0o8mP9sMnHJ/lKfrjkyAFsIdwijmQijtBYBFs46Vg3kokEiDR/4GzSxuhG3/VacNq6T0rH8666PAt5zhziyLdCF4xxve6jCT0uzy8cEnCo+M4g/WvexjaSUohdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GlAK+298; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c1333b0974so65218b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 04:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707915501; x=1708520301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BshCFmZRTopNtWYiAcH887NjvRSn30bZAm3GwAPRNi4=;
        b=GlAK+298HN5lcnFubFDlk9ZIfThijASikbhoNdp9D4vNgy4IrU3+jODMBg1ckKKO48
         qlzPmOziP09rA9p6NVWp48qFejqKNoRgn+XsftArxVMIG4OgkJTei5CzHS50I7ym/5RE
         7AW/CYXhsE4//xDT6yb4YxYmJgFhW++hiUTKGvPe32y5aUujmr8OIRvxFhejZMpd1or7
         rT/gAYMxi9RF4mkGR8TSD1ZC++r1SPnc0pNVY1eLSDt8YoGPHdGHbgQfZouyGTycumTW
         DtoYGBuwUt8h9VkAF0wY/5eOkKpWOV8p71Gwag7UEsRDlKiAvZeY14oK4k820asILR0S
         9J5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707915501; x=1708520301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BshCFmZRTopNtWYiAcH887NjvRSn30bZAm3GwAPRNi4=;
        b=uuLyisvuk3Syy9uM8xdTzY2z9itszgujZJOSkfipFPBF/euv1rui+KI5BLsS1ls1OV
         pQ3bnVTbwzGJh0r4bDDjsHZEYELgRRyP1OlkExBaM98GZ7+vQTRqYrLTDOLtux8LXglE
         ULW2SpX0+jvccrolylxhpK4Ol3+D0QzQ2ZSYEevu4WxeG4PEXVk3cZ3IlS1pkN2gZoDA
         QUIrVjsISRrfkJwrFz8+WcqFZD9WVc6E6yNmM40B0/jEgmm8YknEqTLzySKzVXuiFA4z
         P/Bsfe3KwhZlfIprwyq6ssHknls2mTYSd0Tx6WVqjwXeE1uSoAbmN4jncn5SlRwR+Vv+
         fxcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7CmCKJyiJYqLXUxpN8pE6/PI3qXW22jkcf5eRu36DMXw7K+D2DT8RKsGZVguHeQanwi8DDpQYD9ERsYJvnOqQXetuEjVkqcY5Ob0m
X-Gm-Message-State: AOJu0YzUnz1gJOZoJECVyjIaW/B7pjb84+VBiME8IeMNtymiKjGJXzs/
	1nZwYzJ6N2vV7tpJgc2NBSdAgL7F4OlVhS4HlgWvuS9Tq4BaKnc+mN8+aqpMfXc=
X-Google-Smtp-Source: AGHT+IESNQrgHfg5JgyaHpHE+qWwetm/jueQiitOJitnpPoqM/W2YOs3iN/UgpbRKLLVU/CAztYjgw==
X-Received: by 2002:a05:6808:3987:b0:3c0:40f0:7985 with SMTP id gq7-20020a056808398700b003c040f07985mr3316077oib.55.1707915500870;
        Wed, 14 Feb 2024 04:58:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUaM4shHxQPZNY2W7OsOMIR0XxdEA1Z6eic/XG0Pn660Nqds49rj4683zF/wT0Y5mn7KrPql2LcGLFYOhDDnqtnm0Nhdzh846p/obNRHtUueM0j/v8HpRyRL6fVBsYSxC1UDm95m2DC6e1PHgh1FFGvBWk6p69FCTONJbdqHokwgOJcOC0j70P8JtoYqJK7xKP55TZXMEuU+iHSauhgojL/vs1XozbQyCoiPBC2v5Bi79kmSR3k1AR6q7R3xXmDgpceDF1ajy/sK7Xpt98GNpUe0Laar02lZ+UrEbF5eZZibLrleK7ilgX8tuMuSwx5IoRqCio49mnwJGFtErgu478iMwhEJPxtUL33HGVPACVZilMRLBdWElcG5wbZaCtvwgfcEn1ApwKksQGEy8fxHEDVdW3+FLMMo5dV5cZ6ArimIBUpAwM7hQPBmE7ahj86IfajfCZk7VPGD5j3aXhKzSi2IdWR82LcFJwfM3OBD/3y92S3Z2zzN6Go7QpaTDKdHeaZgTxb016H6bwSVerGegkg7Ez2G6wg4NPutwP86Q==
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ok5-20020a0562143c8500b0068f057ec7b9sm334991qvb.131.2024.02.14.04.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 04:58:20 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1raEqB-00AhZD-Qh;
	Wed, 14 Feb 2024 08:58:19 -0400
Date: Wed, 14 Feb 2024 08:58:19 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>, iommu@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	npiggin@gmail.com, christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com,
	jroedel@suse.de, tpearson@raptorengineering.com, aik@amd.com,
	bgray@linux.ibm.com, gregkh@linuxfoundation.org,
	gbatra@linux.vnet.ibm.com, vaibhav@linux.ibm.com
Subject: Re: [PATCH] powerpc/iommu: Fix the missing iommu_group_put() during
 platform domain attach
Message-ID: <20240214125819.GA1299735@ziepe.ca>
References: <170784021983.6249.10039296655906636112.stgit@linux.ibm.com>
 <20240213172128.GM765010@ziepe.ca>
 <4f5e638d-30a2-4207-b515-d07c20b0fb47@linux.vnet.ibm.com>
 <87le7n6wcf.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le7n6wcf.fsf@mail.lhotse>

On Wed, Feb 14, 2024 at 11:53:20PM +1100, Michael Ellerman wrote:
> Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com> writes:
> > Thanks for the patch. Applied this patch and verified and issue is fixed.
> >
> > This issue way originally reported in the below mail.
> >
> > https://marc.info/?l=linux-kernel&m=170737160630106&w=2
> 
> Please use lore for links, in this case:
> 
> https://lore.kernel.org/all/274e0d2b-b5cc-475e-94e6-8427e88e271d@linux.vnet.ibm.com/

Also if you are respinning you may prefer this

@@ -1285,14 +1285,15 @@ spapr_tce_platform_iommu_attach_dev(struct iommu_domain *platform_domain,
                                    struct device *dev)
 {
        struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-       struct iommu_group *grp = iommu_group_get(dev);
        struct iommu_table_group *table_group;
+       struct iommu_group *grp;
        int ret = -EINVAL;
 
        /* At first attach the ownership is already set */
        if (!domain)
                return 0;
 
+       grp = iommu_group_get(dev);
        if (!grp)
                return -ENODEV;

Which is sort of why this happened in the first place :)

Jason

