Return-Path: <linux-kernel+bounces-48340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E16C845AA0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34614287AC7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1572F62154;
	Thu,  1 Feb 2024 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pH/GuvyY"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20BF5F49A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799019; cv=none; b=Mc5RZoU7q3lbY1nee+RLT/9Z865WsZaeoUzxTjizsSUYE0BsanlBcyTl9U9Bc51TVrNcxjvT+hMuN7FZkzEhuDmNmOakW3dKmS4sd2cbyc2+muJ8ud1DCHjzdOz8trB/UDTCehiBGAJ80XXzRv1NspyJslZWoVxH8Jo6XNqYrGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799019; c=relaxed/simple;
	bh=aw19DufwEeqP4LhGjvEITfZan1Zo5IuofANyrA5Rwek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKaC/mpDYTSAQluvQfB+6cD8pZFG3O8d5ECHOgh2+sJVbZ4TWgHS95aIbLFdR3zlmNT5OJHuxnefD6/0g/l14LaNG6acAgqZXQjEqZjHwR31jnMHL+bIQUkvV83nridBazMmp1aKwd3zB2K8+VTAEsDC8T+q+zO6Kf1pmU42/Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pH/GuvyY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55f19a3ca7aso4084868a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 06:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706799016; x=1707403816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJFlqe+JTUxhYaqLp60MKDwf52Cd95FjNB3ZIkwo2Eg=;
        b=pH/GuvyYZVvRCJRpyFjWSU7BuFbynQ2jhp0PtmA3+BTXELstsMX7KVHf+KdO0lNkPq
         RRmLDGSypwKF0SCCoC1UYfWwQHbSIvjGICD2S2vVJik1yTRqzHlztwsBZqUsf9jGfPAz
         LZQJOE9gDFKmnIWuYf9VEhzJNl+sqUzDlrSGmJXJPvVf/NXXzgUFRznDUeW6Yi8KYoWU
         d5hdeZnq5rQv2LMay2ijSmpA6caAAzWlDgQ6ZsaNlyfji0mLop0P2epVjkSeTDH2uS70
         TIj2/uP5S0wac+9tcLF4iydc++BZOIIQWKSDv31m88C4I3Q/Lbe1vZttH1pwJDz7Z8ZY
         GQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706799016; x=1707403816;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJFlqe+JTUxhYaqLp60MKDwf52Cd95FjNB3ZIkwo2Eg=;
        b=koqWFbxnehxmnODhpLAHpib6Vikp6+4/N2RcWUQ1GE7BTtRzVeKO2htNYagd74Td8W
         TlvzWBArX60MamtxzRo1gdXFt28Z4UesRTKQ6jTWNllwtJ931j7HyyONMF7ow2u5IHcF
         ZXrBgoj4CpIospt7N7h1OzO9Lw4ZhYgqcVT2az08IbsO4H5OPt0VmwsdjN+JNe0t/U/n
         kRekhSucdjqNR8TshfDqe9ewwfbL7n+jJJe3VQcbEYNUezTpVMEYL/wAurvFeZDvWusK
         WR8rrOd/3C/H2OJtR1WzlgrRLoTMIgT2pU+NjYh44q4z7g/wKe2DJaw3wiypS4IfnXaL
         eUvw==
X-Gm-Message-State: AOJu0YxPwpYx80cr/TXxtER091Xua3jo/wH3ks1M9f1JwNafQc34u8Qn
	+mZdWrs8+2JVpmR5WB94XRx7/fO3S3o5JffdDszhCtUnyxKXqDSqDDqO0RpmxZw=
X-Google-Smtp-Source: AGHT+IGT1Gu76xltGpzaJLSSM9wtLptDLRyhJVDnh2IAovJ054mN15U0Erd0knyS4BlHkht0punXzA==
X-Received: by 2002:a50:c359:0:b0:55f:ca00:f0ab with SMTP id q25-20020a50c359000000b0055fca00f0abmr1059883edb.18.1706799015769;
        Thu, 01 Feb 2024 06:50:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV/25pHTacFl82Fyrea7lnsGghHX0O0XW3L7s+e+3yPqNQ1MEMMWHXJmn8T+70eVf4o0Sp29ZHnu9pe9erZGAlXeIZUWlhCx9wMsjjriaUOzXM0EzbbHIpAjQqlzMVyczMYvQ==
Received: from [192.168.159.104] (178235179129.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.129])
        by smtp.gmail.com with ESMTPSA id g13-20020aa7c84d000000b0055c1433be60sm7040424edt.50.2024.02.01.06.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 06:50:15 -0800 (PST)
Message-ID: <5d7a3b97-d840-4863-91a0-32c1d8e7532f@linaro.org>
Date: Thu, 1 Feb 2024 15:50:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: mdt_loader: Add Upperbounds check for program
 header access
Content-Language: en-US
To: Auditya Bhattaram <quic_audityab@quicinc.com>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240131094253.20384-1-quic_audityab@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240131094253.20384-1-quic_audityab@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31.01.2024 10:42, Auditya Bhattaram wrote:
> hash_index is evaluated by looping phdrs till QCOM_MDT_TYPE_HASH
> is found. Add an upperbound check to phdrs to access within elf size.
> 
> Signed-off-by: Auditya Bhattaram <quic_audityab@quicinc.com>
> ---

Could you print an error when this happens? There's a lot of EINVALs
in the MDT loader codepaths, but you never know which one fired..

Konrad

