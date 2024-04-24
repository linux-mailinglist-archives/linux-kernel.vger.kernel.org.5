Return-Path: <linux-kernel+bounces-156583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FB98B0528
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B59281CBD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2997158A2E;
	Wed, 24 Apr 2024 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XWQkydc6"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE74158A0C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949025; cv=none; b=PpR2jxqi7AuZb78pD7V5HDWL9eayNTkawLvxc6Mz8wsMn7wGUGJz9fOqxd4qCljI1Vb8wS4KR4BC4R15uPjL6FOrg7EAmIHUmlfTQEgv3zwXcCJaetgW80ndxrq4IY1zTjz4i3Oa+4joS+NzLJ1sm6vy32YW9ztaUpIprsydxt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949025; c=relaxed/simple;
	bh=2O72LDU1OqLroHzeVRXvbfTsfJ2fryQ4/oEHiZA7yqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oC5GpZrxK0UJk3locDQnCABoHl2jNxRbGMJipMl2bCPrBXs2/6hHQ8FnPAebIP9gObCZDtpR2S/HvVY4NYZ9iT83v0wGTe8Y63ESW0X5FlAAnbHPByPC40oDOJR+NzIOWJPW3SPfskuZxlhQBO3bFG+cc83q8YbeiZ/Ny5sAd5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XWQkydc6; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34a3e0b31e6so4824034f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 01:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713949021; x=1714553821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AkIP6wFEIDdLYh2L9xznda/rD06h99rIWQ52OqgoXs8=;
        b=XWQkydc6ifkoesYyyw2U5cHA0sdZiz0VjUkM/xH8y520/Dt5tITDvpVYNOHnqCNKsO
         YeUs/mIzlikaaIXUw9xfTNIU8bcYE1ypsSNTvaLB5BY5zCqUoO9a4XOm7CFx22D8EpyF
         H04vx0AO7iea0+w0oib9MLmG7cXIo/+lcn43nZyWdidxFNC4J9W9bcmUJJ9xmi+4d+Tp
         8KRpj+ORL+IDXg/M/WCKmqI8dEnPs+4dKqiFFDWyb5NzReVNlBdvomZbOocJsscVhv81
         0MiLGDZc9SNK6HXrEwvHfjXb2FSSO08J02IuRPoM5JJlZL7bSUjCcc483jPC3LsJDS5R
         f6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713949021; x=1714553821;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AkIP6wFEIDdLYh2L9xznda/rD06h99rIWQ52OqgoXs8=;
        b=VmABDgvqF6pvC1Rn2f0i4IZnCdOmcTRP0oxLbtGGBPLW9wlDQRCWCdp9/IRm0ZiT7d
         S1rMHQZMU130GWvlvSly5+XJHoDIcWrgKzleRp6xgRCviHSHp8RdX95wHoMlwCWH9NZ+
         er1amFrqVG4sLSPhb2ZHQ86yULem94UIpAnfzNUGW9LDxPeq8KC2b+l5yqZTsBx3C2z/
         uhb0q3yY0n7qWtPxEMFjkf61RSujlNesD4LYjfeQx0saPHEz9gUZ0W8B8+QS7uFNGRDH
         cELDzP7zFel10yWM+XYEnev6rBBXBAbYtCSGTRhgxFZOgXE3k4jyUvhAQND4Q3Z3GPnY
         IMTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWusZTdtdgP4cK894shwky0vjGoyiGBMW88jMWkeYMFyylyjqi6RYC63WT+qlD66Pu6L6FFUeXBe/+8/Xa04jBwUVTjAWYRfZAa90jt
X-Gm-Message-State: AOJu0YwIE4/wD/ENqjY6Fwz8Ifik+0Mxuf9gjGCS5yiuZZ4C9stDv4IY
	qZJKbx0g72aGmDCPoeQg5sfv7lI9Oj1JpnPaQur/GFGzTXSi3uEBM7Td2mq14F4=
X-Google-Smtp-Source: AGHT+IEyU1gmwXgqSJtlqDiujsmNdbhvlCic00FHBLWvq1Gj2coaTNmeFtYG0ICD0QzXKkhlq8J0Rg==
X-Received: by 2002:a5d:5449:0:b0:34a:a836:b940 with SMTP id w9-20020a5d5449000000b0034aa836b940mr1011074wrv.18.1713949021138;
        Wed, 24 Apr 2024 01:57:01 -0700 (PDT)
Received: from [192.168.0.19] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id v2-20020adfe282000000b00346ceb9e060sm16488957wri.103.2024.04.24.01.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 01:57:00 -0700 (PDT)
Message-ID: <40e817d3-3a7a-4da5-9237-12915357e011@linaro.org>
Date: Wed, 24 Apr 2024 09:56:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: venus: fix use after free in vdec_close
Content-Language: en-US
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1713943070-24085-1-git-send-email-quic_dikshita@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1713943070-24085-1-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/04/2024 08:17, Dikshita Agarwal wrote:
> There appears to be a possible use after free with vdec_close().
> The firmware will add buffer release work to the work queue through
> HFI callbacks as a normal part of decoding. Randomly closing the
> decoder device from userspace during normal decoding can incur
> a read after free for inst.
> 
> Fix it by cancelling the work in vdec_close.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>   drivers/media/platform/qcom/venus/vdec.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 29130a9..56f8a25 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -1747,6 +1747,7 @@ static int vdec_close(struct file *file)
>   
>   	vdec_pm_get(inst);
>   
> +	cancel_work_sync(&inst->delayed_process_work);
>   	v4l2_m2m_ctx_release(inst->m2m_ctx);
>   	v4l2_m2m_release(inst->m2m_dev);
>   	vdec_ctrl_deinit(inst);

Needs a Fixes tag

---
bod

