Return-Path: <linux-kernel+bounces-34121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0152E8373E5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F9F1C24DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF42747772;
	Mon, 22 Jan 2024 20:36:35 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1737D3A8F0;
	Mon, 22 Jan 2024 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955795; cv=none; b=K/pOCUqIRxF4n02AaPgKhCZjICL4jkhVDpu2EHhOO8m5QBqrWPSjQ00HjZt8a/800MFbPxOg6UmVaMseEuRSxwq3WV7mN8biuFwsiRn3SxN1565tHLEdt2NSqILfuQRqgW8kj6Xm8Mar3bb5m29KgorXOjA0vopVoF80MrKBNds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955795; c=relaxed/simple;
	bh=Kixq2tKERqPAxwbmb8+kxRNb2FCPuoVGwis470nnWUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PpEQ+He5tcBwt+sd/FPRbyZtLd48B6UjGlDsIRiOf/fZbMBIF8lSoGqj5xnDHl5muJHsWKI1zNFw3aBr6gKIh9jX9k55OOptc9ALChlBsbf6OmAp6muBWzlVxHEgqrtHYnEu5gL2PbypliJxojKVOMUdhXq9AD2yQaN2qTcSk6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d75ea3a9b6so8842575ad.2;
        Mon, 22 Jan 2024 12:36:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705955793; x=1706560593;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkJkPMG5ftc94SD7NICfT1Jj+ErKWedY6H03mn3a72Y=;
        b=Uxdy69XYJmhRPa7mKIjvqMYpzAEkgdNsVAgtXyXZOtuo+AbOy3ctpCqge+pfXkFUO5
         rzIG9W6vNa8YGcWhJlb41E+NF1+Pen0AKhe7JYR6sz4kBI2b7s1VI6XfsoMjVBfVJp5n
         sRJDqlFYQ1sno1SLXEeZIqA6qLL0m57yeXLAabN/k6exTXrxD+0qU4C4bPTzwXSWUB3/
         5rekfv9wX3EPsmkSr/7rxmUJzO+Fx0NgViv8oLNZodebbL17HXPY0PhrceCqSHBe/4lw
         /LEr1w4vZGD6aK3cmir7wbUeWGtLsFOdsROT1iRY2i6YOyuE8HHrxOF6jfrUWN5chNHh
         ZdkQ==
X-Gm-Message-State: AOJu0YzjHavjSXIvvsnYUo6CDe4Qysrt2geIxvTSPs/AFLk295aJ7y/q
	/qh/PdIXIhyhGp8aTMZKjrHlWJ6fL0Z2q09XsONYjK1YVO5lDucq
X-Google-Smtp-Source: AGHT+IEb68sE53R3LbCi3L6zFv3XjfadxEil5FyAQrEWiihaw7c7EnQgmMS2OeJ7VShTMkhEGDjJ5w==
X-Received: by 2002:a17:902:b78a:b0:1d6:fbab:d40b with SMTP id e10-20020a170902b78a00b001d6fbabd40bmr5293131pls.85.1705955793208;
        Mon, 22 Jan 2024 12:36:33 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id v1-20020a170902b7c100b001d75db0ae21sm1310642plz.170.2024.01.22.12.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 12:36:32 -0800 (PST)
Message-ID: <06e0ae57-f567-4b90-ad68-4ae73909c29e@acm.org>
Date: Mon, 22 Jan 2024 12:36:30 -0800
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
 grant.jung@samsung.com, junwoo80.lee@samsung.com
References: <CGME20240122083204epcas2p26a1bca522e201972ca072e0b24d23a52@epcas2p2.samsung.com>
 <20240122083324.11797-1-hy50.seo@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240122083324.11797-1-hy50.seo@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 00:33, SEO HOYOUNG wrote:
> If err_handler is performed in the suspend/resume situation, ufs_release
> can be called twice and active_reqs valid can be negative.
> This is because ufshcd_errhandling_prepare() and
> ufshcd_err_handling_unprepare() repeatedly release calls.
> Eventually, active_reqs have a value different from the intention.
> To prevent this, release duplication processing was removed.
> 
> Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
> ---
>   drivers/ufs/core/ufshcd.c | 1 -
>   1 file changed, 1 deletion(-)
> 
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

I think that the above ufshcd_release() call pairs with the ufshcd_hold()
call three lines above it and hence that removing that call would be
wrong.

Thanks,

Bart.

