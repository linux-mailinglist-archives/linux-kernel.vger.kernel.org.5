Return-Path: <linux-kernel+bounces-139207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F0F89FFDD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F381C24A36
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D2A18E0E;
	Wed, 10 Apr 2024 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jzmy6uVn"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF1565F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712773995; cv=none; b=WMlobqTYCM/f4o7th+2qgI0C5ODJasjyFnJkQuxgsinb1BNySRUhuek5NHAc/2LOLynPuDJojaY9J8ArYgH+3pk3iycga6JEbSow2PDL2sLrfV1TQc8Sj80XPHzEZeWMKrUWBOIqE+bXfTfr684lEuGIAUE43mDTSsgbGHH/rUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712773995; c=relaxed/simple;
	bh=bYCyv/O3/hLc44nZSjDSFCyO2zmTU3edpKu5n7dXCMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIpFKDtYkxaraJALxUdVm/Ak+DnwPs6uV2q+PWL55ALlGuVIfK4gYo/GlpRP3WPlFZ8aVv8e0sV1vqwre/szYKEmdCrwGeaMnexCvfDd2BCXRU7PrOaVkqL+FdjzSFeXXjjDrA53j9WwkAFl1jZiK7dpkbgRh2lQvwyB72ZQM2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jzmy6uVn; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516c403cc46so13543716e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712773992; x=1713378792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bYCyv/O3/hLc44nZSjDSFCyO2zmTU3edpKu5n7dXCMk=;
        b=Jzmy6uVnT/7dNabG+nTyrR+SqzQWCRbSBPEpPoDMy2HKPo/G2yazhjR+NWJS4CUq6t
         TbeA454gxaaxSmCTJdrAdsoucj+wtOEjsvTmLBTXLUhKbgrol/ZjvV6xZxZY4Vl4VhnX
         ocJexlWg2RO23wZ2yxEsYPFMHm11CIIQeIh//fuegblTB/VO5WZ/IK44Og+1HtccxRqN
         M3MjlC2SfFK19mIzjqftxc0j7ddfp2aabNuZKMqxQE+G780es41H9klofM1j5+9Zd0Hj
         wjUNRxV/QhUWTd9np62DzS/ryWLKaos28b0fNYbW9es4AwuQ/yW/edoupDa8z++ndMbt
         2ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712773992; x=1713378792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bYCyv/O3/hLc44nZSjDSFCyO2zmTU3edpKu5n7dXCMk=;
        b=YPfo3hSNAXuutCROR1zu2kjL3rTAbV+bHIJizO/MjYN56WKkpA+cW0YSxND7lEr+5i
         MKGOeVcuMGpZmYAgcXCeoFmAvzQQq3cv+f0JuvtViWU3E7iFfGwNyMGS8LQ9MCE1Jahh
         PDNwcQCtWZBukLavAf2hOIMKozzV3MlcSLCiSyvjFvwObBOzHDGX4/ck8a99kuOAk1Ym
         eCi7kGyHftFYAWdIhSdyicoOY470YhKWDMgCr2tfLVk+lwv4cekGW1GUt3pGjLAJeFeg
         ub8X4Xx3Vc96bMCWoU7LHpuPLcNwA4JdZA+fK3WtY07gjrB9OmVrLOujkB2ZbIu6ck/4
         axgg==
X-Forwarded-Encrypted: i=1; AJvYcCXOVsO7mEH7CanGqwaj+280vQHVMEVjoKk2N0UAApTZTnWUUft4XU0GEwUZitRPn1PGa2TPRvWB2WBrYAdHu4B+b6I1kFIu85nyQw0U
X-Gm-Message-State: AOJu0YwTHZfZnnuq0NTMIehFr+1ibaJSblhCNy6qf8S1FXWE8mr3dw4O
	gEQYNjZhmpqMdezPghxXojufXgGoQOiryeLo3oyUNvNF1/6N7SEhQ8thyuJwnt0=
X-Google-Smtp-Source: AGHT+IHZV4s1cFLZE7b0PkP6H4vHg5k3tMb5z5t2HUtz7wHs9oqkyOgsfffSF08o3vAhrp80oLz7Wg==
X-Received: by 2002:a05:6512:481e:b0:513:ca40:fafc with SMTP id eo30-20020a056512481e00b00513ca40fafcmr2448227lfb.11.1712773991912;
        Wed, 10 Apr 2024 11:33:11 -0700 (PDT)
Received: from [172.30.205.26] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id s17-20020a056512215100b00513cb11cd66sm1908076lfr.219.2024.04.10.11.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 11:33:11 -0700 (PDT)
Message-ID: <0a706bc5-b1e6-4332-a31f-44a91f4f1c92@linaro.org>
Date: Wed, 10 Apr 2024 20:33:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sa8155p-adp: use correct gpio for SDHC2
 CD
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240410134022.732767-1-volodymyr_babchuk@epam.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240410134022.732767-1-volodymyr_babchuk@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 15:41, Volodymyr Babchuk wrote:
> Card Detect pin for SHDC2 on SA8155P-ADP is connected to GPIO4 of
> PMM8155AU_1, not to internal TLMM. This change fixes two issues at
> once: not working ethernet (because GPIO4 is used for MAC TX) and SD
> detection.

Oh wow..

Konrad

