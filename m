Return-Path: <linux-kernel+bounces-46926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EB284466D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECDCDB27DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE92212F5A1;
	Wed, 31 Jan 2024 17:44:48 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FF712C54E;
	Wed, 31 Jan 2024 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723088; cv=none; b=HIenoc/JWBpyqqtHs7bsatfxlMoWH8l2aIyTkKE1Pe/xcMAAc2kTwl7Rod3e/9OKKoZA+nwT4Tu/Q7aZ5tUUDrkGPuzB+euWgUdmDThmEQM0tGOasXs33O9gDujffOFPRa1guvSH04JB2UXYtGzsS2mUardG8zc/Ja4cQwdqjjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723088; c=relaxed/simple;
	bh=lYoivAyk+e6CW1VcYsTxunEDWl28AOdTjol2cOLh4cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IsJ/l64Y+MwLPlcJC2JiuGts/igjnNnWPQxT+J0AYxF0MGOPZOchrGDz75xqX4F6C2uI3cgdAfEqdnu7ARcYH0JZMYTdbMHa8EeDofDWgb+DfmKF4Uib8uT8O3K6i29mmDl/VujdsXLPbVotM78yrvaGerELNbBs0d3UWjDVAvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d8a66a2976so116695ad.2;
        Wed, 31 Jan 2024 09:44:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706723086; x=1707327886;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0biSaZpPh88aXQJnfLxYrKqT7EKvScD1Wm7p/pQaoI=;
        b=uG5/VBjmhOYb4BwT7EQ+wyAOyolETD0lnaPgjOO8h1MYaUJcPpSuMsi7AnRQYixwxd
         1e4bffSahyGDDW4XNtopJaNiq1YGzIJ21VlLDlYrUPIuukVk9uIYHqPyjeT0z+107B34
         QgnRfbCzncMtF66xURErR0+0lW1n27pdp8aFneluClDxrklG+OTNQbuQpF4p2Ik/UfMt
         OsnL6xhN81gf+WR0D6EKHY7JYbFLMpGJt7igSy7TqSaquw5CYFJaYScgA+8grgrwHhce
         PMXRQndtRC+TAC7GR9hq6Gy2C/giiVfsZAZobH+MCmc187bEvBy8j5nGgPBa4VSraPlT
         G1ag==
X-Gm-Message-State: AOJu0YxqC1aN/r+9u5aS82jUlY5V2SrLoyaIZuBLZiZAooD9WPRWwCua
	mN2JtvnXogSX+tn0TluoP3WYr76fFsnnuOZlA8mhfzyVi8sbSt4Z
X-Google-Smtp-Source: AGHT+IEdQ5FVrC0bV4TOGiuq1EYLm2pqVa0OOPId6GKXlf7ALwz4AvXuIJBVHW4TtJu0n8vwDAhYzg==
X-Received: by 2002:a17:90a:fd95:b0:295:b4af:6600 with SMTP id cx21-20020a17090afd9500b00295b4af6600mr2498850pjb.7.1706723086230;
        Wed, 31 Jan 2024 09:44:46 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:1d95:ca94:1cbe:1409? ([2620:0:1000:8411:1d95:ca94:1cbe:1409])
        by smtp.gmail.com with ESMTPSA id iq24-20020a17090afb5800b002906e09e1d1sm1787750pjb.18.2024.01.31.09.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 09:44:45 -0800 (PST)
Message-ID: <0ae6c12e-3b55-4d90-b042-e8c2b3a2c4a7@acm.org>
Date: Wed, 31 Jan 2024 09:44:43 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] scsi: ufs: core: Remove the ufshcd_release in
 ufshcd_err_handling_prepare
Content-Language: en-US
To: SEO HOYOUNG <hy50.seo@samsung.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
 kwangwon.min@samsung.com, kwmad.kim@samsung.com, sh425.lee@samsung.com,
 sc.suh@samsung.com, quic_nguyenb@quicinc.com, cpgs@samsung.com,
 grant.jung@samsung.com, junwoo80.lee@samsung.com,
 Can Guo <quic_cang@quicinc.com>
References: <CGME20240122083204epcas2p26a1bca522e201972ca072e0b24d23a52@epcas2p2.samsung.com>
 <20240122083324.11797-1-hy50.seo@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240122083324.11797-1-hy50.seo@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 00:33, SEO HOYOUNG wrote:
> This is because ufshcd_errhandling_prepare() and
> ufshcd_err_handling_unprepare() repeatedly release calls.

It would have been much more clear if it would have been mentioned that
ufshcd_err_handling_prepare() should call ufshcd_hold() once and
also that ufshcd_err_handling_unprepare() should call ufshcd_release()
once.

Additionally, a Fixes: tag is missing. Is this patch perhaps a fix for commit
c72e79c0ad2b ("scsi: ufs: Recover HBA runtime PM error in error handler")?
Can Guo, since you wrote that patch, can you please take a look at this patch?

> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 7c59d7a02243..423e83074a20 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -6351,7 +6351,6 @@ static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
>   		ufshcd_hold(hba);
>   		if (!ufshcd_is_clkgating_allowed(hba))
>   			ufshcd_setup_clocks(hba, true);
> -		ufshcd_release(hba);
>   		pm_op = hba->is_sys_suspended ? UFS_SYSTEM_PM : UFS_RUNTIME_PM;
>   		ufshcd_vops_resume(hba, pm_op);
>   	} else {

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

