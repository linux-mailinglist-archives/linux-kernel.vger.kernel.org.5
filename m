Return-Path: <linux-kernel+bounces-35811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7D78396DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3EC1C22EE0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E95880044;
	Tue, 23 Jan 2024 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DBLa7Gx9"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B12C823AA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032149; cv=none; b=JljHZeGy1AYYEg95/L0m3fEJNnDAK2LSKVne53sMGee4pQmwO6n2cfKCpPGYCZEHJkOr/k2CTxs8Gj4ZC65TRNFx8i/gPAaYb5XP1KFHQ8NeX73ka1vxct4ucb8GOepODRXE6nw27a5w9WdX43y6toGCrdI9E+DdvbzvZnkwLSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032149; c=relaxed/simple;
	bh=ldYuq7Lt/RjB+rbs9K+UJX/SUyAcwFnHAk8K23hdMB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5eJ2hQskyXBOHkOfeT7G/Vgk3B4cAwFkodXXc41W165DDkUb+vvYXmzuWwL247sBS9wLfAWmgpb6MSh688d3FwkJhgdBKWL7XOMDFHOwfsMEnazxLeupKIKusnqQl9uJCXar9OjYJACVUIPZcGBHYxTsJbkls6ZDgsK+TTYNzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DBLa7Gx9; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5986cb7bb61so2542858eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706032147; x=1706636947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fWjeJyn0CywpF872L1BG3qw+k7bbvDqxkePP+937fmU=;
        b=DBLa7Gx9kP0Tl0denS9L0lWfeiLu0O1FxWwBkwHIfr417KNH4/W7eNsBeLroqB58OG
         2Fyfv6xoEaWeMxY4sUZrbumag0MHyL0qF9ZexJvAVcO7THw9UKX0aww8LQoYE2d1Ai+v
         Scak9gEkoAm4zCv5RWWFkGG9lJuEUWyLX9eRY8Zva8uT+rSVrgjoZM9TIZpewyyBIZv9
         JPBgda4quV0Vqk9yay8t+yunrSeSVxgdQ+ZCaUR/dw1FFdGZ49HRZxYa2ZIJ/wbylQ8T
         H9DFzYz2NogH/W4jRBxiVHlxATCSUJ54PuvJz3BqkzRcGc+a+V3iIzM7j3qsIimjNow6
         sIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706032147; x=1706636947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWjeJyn0CywpF872L1BG3qw+k7bbvDqxkePP+937fmU=;
        b=jp5EGfazztUpfsDspDgAMwvQYL7rj54iXFgnnugnS6dB68apCO9a0BJtu69hUK7D/f
         fCEM1s7IFfpTEzBf3Av8RANjMYnZAdZ80IDE++N5zukBRIHypqGA65+/IKYPXONU+v+k
         ggMBsTsv6m5GY4BdCXdnR2/Rzh1Sp1ZvUtQkG4igqPMS+IXj3H2LmIethwautSGuDXsU
         XHtFjIoCxQyhiwjMFQblqKSe5MuMjgIZTwiEDi/8CASKPuTPCln3F0OPMX2i5ANPbfTU
         lVj27YCqqkCe51ZRzWgEe3jGEUscDJWOyXkLLzFtwO+EBGD6Bloj+2DInk8FYISDKaHW
         6FnA==
X-Gm-Message-State: AOJu0YxSqtiZAjYWxOTR6D+j2Fn2evoFhuSQI3T+Hx5LL1UBEiRRa5I6
	UNb6tumBLdMpTqVPpHIQ8YWAHOYFA6lTilt3VanhVhRvDsBxRrytRilMkBxUrkG9laJ30Gbxa0Q
	x
X-Google-Smtp-Source: AGHT+IH6W3JG0GancI79tmoYyAsVmtzeInW8Ee9IwcjHB86NWQplVJmmV+pUrWxeClqJMK0CoA4W/g==
X-Received: by 2002:a4a:d00b:0:b0:599:b548:e5f6 with SMTP id h11-20020a4ad00b000000b00599b548e5f6mr275607oor.4.1706032146980;
        Tue, 23 Jan 2024 09:49:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id h6-20020a4ad746000000b00599aa7f4d79sm223882oot.8.2024.01.23.09.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:49:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rSKtV-008KJy-7z;
	Tue, 23 Jan 2024 13:49:05 -0400
Date: Tue, 23 Jan 2024 13:49:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: ovidiu.panait@windriver.com
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org
Subject: Re: [PATCH] iommu: iommu_group_alloc_default_domain: Fix
 ops->default_domain codepath
Message-ID: <20240123174905.GS50608@ziepe.ca>
References: <20240123165829.630276-1-ovidiu.panait@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123165829.630276-1-ovidiu.panait@windriver.com>

On Tue, Jan 23, 2024 at 06:58:29PM +0200, ovidiu.panait@windriver.com wrote:
> From: Ovidiu Panait <ovidiu.panait@windriver.com>
> 
> Since commit [1], FSL_PAMU initialization on t4240rdb board fails
> with: "fsl-pamu-domain: pamu_domain_init: Can't register iommu device".
> 
> Commit [1] changed the behavior for drivers that set ops->default_domain,
> as the function iommu_group_alloc_default_domain() is now called with
> "req_type == IOMMU_DOMAIN_IDENTITY", rather than "req_type == 0". This
> causes the following EINVAL condition to be hit during FSL_PAMU
> initialization:
>   ...
>        if (ops->default_domain) {
>                if (req_type)
>                        return ERR_PTR(-EINVAL);
>                return ops->default_domain;
>        }
>   ...
> 
> To avoid this issue when ops->default_domain != NULL, remove the check for
> non-zero req_type and always return the proper default domain, as set in
> the driver.
> 
>   [1] 0f6a90436a57 ("iommu: Do not use IOMMU_DOMAIN_DMA [...]")
> 
> Fixes: 0f6a90436a57 ("iommu: Do not use IOMMU_DOMAIN_DMA if CONFIG_IOMMU_DMA is not enabled")
> Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
> ---
>  drivers/iommu/iommu.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Oh, that is a neat combination of things

Removing the test will cause problems for the sys flow - I think the
right thing is to get the correct req_type earlier. paml wants to use
a specific domain type so it should not be switching to identity at
all.

Does the below work for you?

Also, what is your interest here? I have been wanting to delete this
driver, would your system still be OK for your usage if it was
removed?

Thanks,
Jason

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 68e648b5576706..7fa3ccdc3286e6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1799,7 +1799,7 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 	 * domain. Do not use in new drivers.
 	 */
 	if (ops->default_domain) {
-		if (req_type)
+		if (req_type != ops->default_domain->type)
 			return ERR_PTR(-EINVAL);
 		return ops->default_domain;
 	}
@@ -1871,10 +1871,18 @@ static int iommu_get_def_domain_type(struct iommu_group *group,
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	int type;
 
-	if (!ops->def_domain_type)
-		return cur_type;
-
-	type = ops->def_domain_type(dev);
+	if (ops->default_domain) {
+		/*
+		 * Drivers that declare a global static default_domain will
+		 * always choose that.
+		 */
+		type = ops->default_domain->type;
+	} else {
+		if (ops->def_domain_type)
+			type = ops->def_domain_type(dev);
+		else
+			type = cur_type;
+	}
 	if (!type || cur_type == type)
 		return cur_type;
 	if (!cur_type)

