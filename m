Return-Path: <linux-kernel+bounces-44836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D7E8427FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362472878AF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065A786AF6;
	Tue, 30 Jan 2024 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b="vInUSoCl"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED0786AD2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628252; cv=none; b=XrwrGZXhlveW8G3FHIH+Ssl0edl8RNByUNLfmy46DJ7Jqwn3QJtjr7to0u8+dAtcCudBd0PNGyaE1JjnT5Uwa/e6g9EpiVrtjJW7lq+RzgKCLFPqHqWhTf6/DuOuZXweRjfxYTacQA7jOWY6OwjPuSjzRv6kZAdAqfs2foMlp2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628252; c=relaxed/simple;
	bh=RWoMbArJCJ2qut8LsUpeWadEL9hpH4D1vGmVcW9tVmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJWbkyMhJGFXHUQXSeqHjJ+R4xVh7tDv7S3JRmIF5vqtl5S5rLSxTQsWhRGsV2AJsjQ6MxpP2DMo/SBM25mwSR0UeMG6pzEO3xIcVsFRpj5ZIuyo4dv4MfED2sf13fQ+Wb61ieE71+xomNDeyvlTQClC+GBC6ACSiu5xQ85iCtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie; spf=none smtp.mailfrom=nexus-software.ie; dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b=vInUSoCl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexus-software.ie
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e9101b5f9so45018665e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20230601.gappssmtp.com; s=20230601; t=1706628248; x=1707233048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i3sobrlmzlgQ267qaogC7twZ6ZN3NAHO1POj2V3Oyvc=;
        b=vInUSoClga+Hdun7P/75sHfAVkuFCj0eP0pP3d6vxtIJ+RtuZ/wW0wSVKKyb4qsn2s
         M9WMNpjvXLbAyIDREq8VPlWXFJF435offpdz4zz86kM61WMYqlBAanpLN6FL8XpohL4t
         /76F0nMb7G4Q2IGYmSD5lNP8ZYcMd33pznTy9fyhDOV1B/xSIbNGYjALXIEJPwHN8LXp
         c/zmeeOW1cMyABPd5DK+BG0GaTUuS0Fx0jyOZFfhR642lGP1koIKXWCIrbnCWww622Q+
         +hw73MaAK81X7xfYRyfYe2n9iyliX80o7cWjx9HY6Q87unu2CTAs6afETUiGj+Kcs/nO
         wHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706628248; x=1707233048;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3sobrlmzlgQ267qaogC7twZ6ZN3NAHO1POj2V3Oyvc=;
        b=XGZkZrQWBZvG04z62rNZJS6l9LOhL/9o1Ge+72jogIHWuTzBcLSD9Fayb/LfaNE4eP
         yRsUFVCgLUIYsI/EXKEp3BTlW6klrwz/JNeL3TXnESCiJ9SkrMTXdp75eBdoa2FhDx8p
         zaXJPEC2rZe0Ex1MSpZ24l5v+SN94Cj0d0pXJX2agbcp/RnfSpwTyUEIYuFq5BKmP9uH
         wrVZtOXqgdyag0Zp35ufsn8M+/vLskzi+BNCZwespyOQV/tokTtv8QAzK/U3xKZ18Vzn
         juNGLqmtPHykxhErhYHPVllvTSBWfBp4ExEJ9oFIg9g6CO2wOOUKGhJ6v/FVd0+4Z1f/
         Rk4w==
X-Gm-Message-State: AOJu0YynqKODsqa/nET3XcCSD88UAkcUIH/isdT5zum6Pf2TijwyMqJe
	Bp7dzZ3NP3wPCaBF32DV2UaC488f8LBmqXby5ceZFLEN+QaFFKxU9LHRHm4dtPw=
X-Google-Smtp-Source: AGHT+IEyAAbMLGJbgqPjXgEAeGFmKuS59P8+cb/8gbye9868qSzHvrPXIkwWwsrpovu8gtwuNUB1sQ==
X-Received: by 2002:a05:600c:198c:b0:40e:cdff:8d10 with SMTP id t12-20020a05600c198c00b0040ecdff8d10mr6966048wmq.6.1706628248296;
        Tue, 30 Jan 2024 07:24:08 -0800 (PST)
Received: from [192.168.100.86] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id bj12-20020a0560001e0c00b00337d6f0013esm7683953wrb.107.2024.01.30.07.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 07:24:07 -0800 (PST)
Message-ID: <b94c4c9f-a3dd-40fb-a80e-569199e93ee2@nexus-software.ie>
Date: Tue, 30 Jan 2024 15:24:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V2] i2c: i2c-qcom-geni: Correct I2C TRE sequence
Content-Language: en-US
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, andi.shyti@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, vkoul@kernel.org, quic_bjorande@quicinc.com,
 manivannan.sadhasivam@linaro.org
Cc: quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com
References: <20240129061003.4085-1-quic_vdadhani@quicinc.com>
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <20240129061003.4085-1-quic_vdadhani@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/01/2024 06:10, Viken Dadhaniya wrote:
> As per HPG(Hardware programming guide

Since you are doing a V3 here, please amend this too.

"As per HPG" means almost nothing outside of qcom.

"As per Qualcomm's internal Hardware Programming Guide"

Right thing to do to reference the document IMO but, you should make 
clear its an internal silicon specification that's not public.

Also not sure the TRE description adds much.

Just give a high level description of the sequences being out-of-order 
with respect to the hardware spec.

---
bod

