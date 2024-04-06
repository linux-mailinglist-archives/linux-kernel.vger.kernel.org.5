Return-Path: <linux-kernel+bounces-133915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FB689AAA1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B0FDB21B5E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9DB2C84F;
	Sat,  6 Apr 2024 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwTBsd+c"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E43E2B9D7;
	Sat,  6 Apr 2024 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712403465; cv=none; b=sPEWGV738it91TL/3Gl2RoXUMjquB2WSeNU2df4N/k1VVxMLXDUR+WNU4DBGhq2vIhbuC4Or7cCz0+K7nKoF+2PgMHnyQtXqgWBroiRT5+ApemVR69SDwNmJwpqZj5BYNg9H/VzVaLNjRMPTZU47IoeTEz8Gc5H3C67TpieP0Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712403465; c=relaxed/simple;
	bh=qbJRZ1fh3T7KDvTQux8mpTlbcrzgVexcA/Yz47FCB68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vqz0PjGWxxWXN2jaaMY1fPBdzFslt6i6TufW0Ph7us+t8mfUABJq4UyWKODqE9lLJakTXnPZS4YJ+Y+kk62SREex1vCZ/TBaQmxBZTO3LR74N155g3dpJ/MnAvF/aeQEHyr0ktmJR9XyCZS0oH7l9r4KVXzWBl1KlZbqLBitHQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwTBsd+c; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-416441b16f6so519095e9.1;
        Sat, 06 Apr 2024 04:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712403462; x=1713008262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zk/YuqAdgfC9BxkPvx9YV/xfkfXepnXKE3kC7Wn8SAU=;
        b=jwTBsd+cKA8HBXqNsmmSbYKMejJgP7E5n0AIykkXxuvueWyU80ArtTn8Et5BoixoGI
         i+x9//6hetf3glyJOLbcw0+4Q3zz080KIkQoiLTmuTpnjTGqBXuBAYbiFzK3q8ESDaSR
         sRIoiv60OY29YjoDsSWNbSHf2C5jA50qpQTt4YuhvSWC/It4xFnf3xrtIHPZy32F/bPB
         86+PPIjgcj5TBJHlEpFCX/IR4rnnYM80c5V456JMwMjRdjDmK3k/elsVaYSpzNZUxoOQ
         vsYaFTppXPW7knRVx4hTtJFDDoDxVAhPA9aZBdPEwn+qyYqjrsRrXi2WbW9Vd2X1a2ye
         DF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712403462; x=1713008262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zk/YuqAdgfC9BxkPvx9YV/xfkfXepnXKE3kC7Wn8SAU=;
        b=WRyZhLv2nuGoMPz59ppbSRd/HEylgZfFCySRpdZaHSKYw8qBsmGZFnA4hBZov5sgpL
         jyz89amrlcuA/AgeNsT5Xr+utKWOXu/SqRn/sFhnfdJmd+Hx4g0UozbYkaFeD9ACdmcv
         t+/csukJkt2dLNIBazQ18touWVlzP++KdtcyjhBn5aXxZaR6YDBUG+O4bQkmBalq0qL8
         Vu2vgIa07oK3Lt4nmONoR8NsU5Y1H6DZXyOLkzVewtY7K0jxVYzvGxF99KCH6+n2Dgrs
         ULpD6ozHdFMPRBBpyZzMF0Vp3trEieOK6vZDAXLTc/bjPlsHKNbQzQPyRdfiyEou375p
         QVzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEDpt7NdWjGtlhSE+nbR2fsvhllcgZ6RmfNQltprVtMmcMSz9ZgKfHHA/5gpQicWF0E+OO2sGSbueTiCxnvSuKYed8K0DWuqTuiUUp/uQmdZE7N1Z+fHZ4Q5S20pW4Y2uPmQ9VNfexTPJLcg==
X-Gm-Message-State: AOJu0YwHV30ZKu7EQ0assocb9TFAB8iqcTeOC38aDEsjfoN7cHNHRtGk
	52cxZZ7L3pvahazAaW0wkRne5ygrzfeEyBfGalVQADTnguTd1ayK
X-Google-Smtp-Source: AGHT+IF/b9jy9As4wQJjxtC1N1AHTgnFLGKGjZBXGmSsxUy1gwJaaGRTShMqdM/GLYUlqFy8GpQazw==
X-Received: by 2002:a05:600c:3b84:b0:416:2454:ad7b with SMTP id n4-20020a05600c3b8400b004162454ad7bmr4732344wms.1.1712403462268;
        Sat, 06 Apr 2024 04:37:42 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c35ca00b0041622c88852sm9781083wmq.16.2024.04.06.04.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Apr 2024 04:37:41 -0700 (PDT)
Message-ID: <93d54733-bd83-478c-9e4c-727c3b09396c@gmail.com>
Date: Sat, 6 Apr 2024 13:37:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom: uefisecapp: Fix memory related IO errors
 and crashes
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Johan Hovold <johan+linaro@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Guru Das Srinagesh <quic_gurus@quicinc.com>, Ard Biesheuvel
 <ardb@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240329201827.3108093-1-luzmaximilian@gmail.com>
 <Zgv6aJ4byNiujmo-@hovoldconsulting.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <Zgv6aJ4byNiujmo-@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/2/24 2:30 PM, Johan Hovold wrote:
> On Fri, Mar 29, 2024 at 09:18:25PM +0100, Maximilian Luz wrote:
>> It turns out that while the QSEECOM APP_SEND command has specific fields
>> for request and response buffers, uefisecapp expects them both to be in
>> a single memory region. Failure to adhere to this has (so far) resulted
>> in either no response being written to the response buffer (causing an
>> EIO to be emitted down the line), the SCM call to fail with EINVAL
>> (i.e., directly from TZ/firmware), or the device to be hard-reset.
>>
>> While this issue can be triggered deterministically, in the current form
>> it seems to happen rather sporadically (which is why it has gone
>> unnoticed during earlier testing). This is likely due to the two
>> kzalloc() calls (for request and response) being directly after each
>> other. Which means that those likely return consecutive regions most of
>> the time, especially when not much else is going on in the system.
>>
>> Fix this by allocating a single memory region for both request and
>> response buffers, properly aligning both structs inside it. This
>> unfortunately also means that the qcom_scm_qseecom_app_send() interface
>> needs to be restructured, as it should no longer map the DMA regions
>> separately. Therefore, move the responsibility of DMA allocation (or
>> mapping) to the caller.
>>
>> Fixes: 759e7a2b62eb ("firmware: Add support for Qualcomm UEFI Secure Application")
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> 
> Thanks for tracking this down. I can confirm that this fixes the
> hypervisor reset I can trigger by repeatedly reading an EFI variable on
> the X13s. Before it triggered within minutes, now I ran it for 3 hours
> without any issues:
> 
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Even if the patch is a bit large it's straight-forward and fixes a
> critical bug so I think this needs to go to stable as well:
> 
> Cc: stable@vger.kernel.org	# 6.7
> 
> A couple of comments below.
> 
>> @@ -277,10 +296,15 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
>>   	unsigned long buffer_size = *data_size;
>>   	efi_status_t efi_status = EFI_SUCCESS;
>>   	unsigned long name_length;
>> +	dma_addr_t cmd_buf_phys;
> 
> Throughout the patch, could you please refer to DMA addresses as DMA
> addresses rather than physical addresses, for example, by using a "_dma"
> rather than "_phys" suffix here?

Sure. I've applied this and the changes below (as well as similar ones
for qcom_qseecom.h) for v2.

Thanks!

Best regards,
Max

> 
>> +	size_t cmd_buf_size;
>> +	void *cmd_buf_virt;
> 
> I'd also prefer if you dropped the "_virt" suffix from the buffer
> pointers.
> 
>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>> index 49ddbcab06800..fc59688227f43 100644
>> --- a/drivers/firmware/qcom/qcom_scm.c
>> +++ b/drivers/firmware/qcom/qcom_scm.c
>> @@ -1579,46 +1579,26 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_get_id);
>>   /**
>>    * qcom_scm_qseecom_app_send() - Send to and receive data from a given QSEE app.
>>    * @app_id:   The ID of the target app.
>> - * @req:      Request buffer sent to the app (must be DMA-mappable).
>> + * @req:      Physical address of the request buffer sent to the app.
> 
> DMA address
> 
>>    * @req_size: Size of the request buffer.
>> - * @rsp:      Response buffer, written to by the app (must be DMA-mappable).
>> + * @rsp:      Physical address of the response buffer, written to by the app.
> 
> DMA address
> 
>>    * @rsp_size: Size of the response buffer.
>>    *
>>    * Sends a request to the QSEE app associated with the given ID and read back
>> - * its response. The caller must provide two DMA memory regions, one for the
>> - * request and one for the response, and fill out the @req region with the
>> + * its response. The caller must provide two physical memory regions, one for
> 
> DMA memory
> 
>> + * the request and one for the response, and fill out the @req region with the
>>    * respective (app-specific) request data. The QSEE app reads this and returns
>>    * its response in the @rsp region.
>>    *
>>    * Return: Zero on success, nonzero on failure.
>>    */
>> -int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
>> -			      size_t rsp_size)
>> +int qcom_scm_qseecom_app_send(u32 app_id, dma_addr_t req, size_t req_size,
>> +			      dma_addr_t rsp, size_t rsp_size)
> 
> And similar throughout.
> 
> With that fixed, feel free to add:
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Johan

