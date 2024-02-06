Return-Path: <linux-kernel+bounces-54499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0E484B005
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0EA1C24605
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D6C12BEA2;
	Tue,  6 Feb 2024 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjxaItS3"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88FD12BE82
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208496; cv=none; b=WO38ZNAguZNBdFMESmX+7Qfb+eHF1b9tenOJ5Tg7yaO9yJM1oTj3kLOp5F3kH3XIS+YTtmaCZOzijwXjJcHFUT2U1VJQhpAyNNuRtVsmVpQNXoL2ectiNUeZZ8zNdaH3nx/DUX+BeWeDRTgRe5GWLMevXWbzluNqew8I5LdDhF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208496; c=relaxed/simple;
	bh=rs/Fib0MgDHZF7Nnuf+WqRbrCQD6BL2rjYrqaEWkF4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9KvR1BtVlCz+cXwyKbexm4hx+UGs7+77IPNc3j6Zjd15aFMNDB1OOyW8SUvGZvqiFL8nyR+Zuvk/8SL82x/uzTmj/WqbEUeb47dXpIbIiKeGQmiprNi3sYR8vfiIlgj4EST7VbbkX0qA92CFWr9yL2gB/Bat4Mp0jZj1lN1gL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jjxaItS3; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33b1d7f736bso2967389f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 00:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707208493; x=1707813293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WrhfwaHoTCx5SMzEOHHRswhgOy4PniLDtBWLSTSgBsM=;
        b=jjxaItS3GEGBZn6SQuqkAJ8Hr6W1onzQObO/mg/vhyrGqOtKP2vZftJjo8Cbm2mwBd
         c+AdoZjbnx5ng+x/FJ6c8pqG8JdAzY6j+8KPHlxM5ZjVpwSCiDkLEfYV9d0tkgruu7g8
         ogE8U1ngzdqwxsimSq5m1e+RLTjP/4bH8zJSg5NZ1DZXLMH5wEMsPq26PhfkrNqxJuJ9
         5ZF2vTZCxvGdkFVTwaRQMZn9rgd9KmI50BDVix9t3ZKASCDxbo2fzB+jh+CctOvLfsGg
         Cs3lu5yfHwmOkF/C8wfHcqXxjfa7TnsSyA80a7rMPdKyEzoL9Awuzlb1642hPiYL1r1a
         zGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707208493; x=1707813293;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WrhfwaHoTCx5SMzEOHHRswhgOy4PniLDtBWLSTSgBsM=;
        b=DaAqgtW8Eejdt/O8sMHGW6cl0jDDCeEMiPAwzighd5QZ7Hjk53QIlVT5Dw4KQKVAQP
         qPVPRWLqbcMlDskOy4HmEWJ8dIThXvJrhCvJlhgWFtcEFgdVrvp0i9DMgl6cHWAyTih7
         huM9KXuDD654/TOaEF3liEre+vSB+5loRI6IwMoJRy0QoJJ4Fteb0KZn1L7kRqynyrJv
         nMa9I6o7i0Auvc8L3XW7gugHk/+ucXNXIi5x2ncIwMSX8rJigA9npJKf1F8tx+Bxwig6
         gar0CT3gSnNPjH8oWx5noG+eXTuKS9IjdX46EFUTPgbLSWxJIIAbH52DLeAIXOD7DbeY
         scOQ==
X-Gm-Message-State: AOJu0YxZvJBxK5VjlX4KvkLFES6GBOygqKMyUvLHYJ5LuwC33eb9+2pK
	W9Y5Mw9Srlqt1wP0N27byp4K7wlsbJ1ValOzqUxlVMrzp0ZWQhHBGoKhmctGfsM=
X-Google-Smtp-Source: AGHT+IGaR11vgelKck8ZS55v28U+umc+qEpGu6dNNCG12aKXBJRF8ZRkUPMo1uB9V8imlup+calwug==
X-Received: by 2002:a5d:5265:0:b0:33a:fafa:8cdc with SMTP id l5-20020a5d5265000000b0033afafa8cdcmr630993wrc.32.1707208493131;
        Tue, 06 Feb 2024 00:34:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW8he47LZICa4empMEOaoyU35W9Mm4wnamnx6xBx7B3TLGFAgqKBINx/WMMvSgPkkpDK5T8XLKY5+y8kkNQxDVl4hf0UwlyBaje0Y2DKTXmUKXQMyZejW6zcBrxja54QgAs5W+PKp7CKldMN6TbqquQze5djxCZcHMlLY64Kh5AcR9pj4kwryuAxfhk2ntXEjlYc64ifkSG8yMoGfVk2HASBCPtBrTSYrjxBBl2DSR/nao2wFKopmKzidXEF4XkB2uPd/JSDzPCa2bOUr+pTQH+/rOqLbfvNxFZou6HY12n0cZB47t5hWkHXmEWw49cGFevogtLpvyarA==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id u15-20020a5d514f000000b0033afe6968bfsm1487670wrt.64.2024.02.06.00.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 00:34:52 -0800 (PST)
Message-ID: <be9d964b-7900-4fef-9268-67ef404cd611@linaro.org>
Date: Tue, 6 Feb 2024 09:34:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] LLCC: Support for Broadcast_AND region
Content-Language: en-US
To: Unnathi Chalicheemala <quic_uchalich@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <cover.1707202761.git.quic_uchalich@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <cover.1707202761.git.quic_uchalich@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 08:15, Unnathi Chalicheemala wrote:
> This series adds:
> 1. Device tree register mapping for Broadcast_AND region in SM8450,
> SM8550, SM8650.
> 2. LLCC driver updates to reflect addition of Broadcast_AND regmap.
> 
> To support CSR programming, a broadcast interface is used to program all
> channels in a single command. Until SM8450 there was only one broadcast
> region (Broadcast_OR) used to broadcast write and check for status bit
> 0. From SM8450 onwards another broadcast region (Broadcast_AND) has been
> added which checks for status bit 1.
> 
> This series updates the device trees from SM8450 onwards to have a
> mapping to this Broadcast_AND region. It also updates the llcc_drv_data
> structure with a regmap for Broadcast_AND region and corrects the
> broadcast region used to check for status bit 1.
> 
> Merging strategy
> ----------------
> 
> All patches should be merged due to LLCC DeviceTree/driver dependency.

Dependency? Sorry, there cannot be a dependency between DTS and driver.
Please fix your patchset.



Best regards,
Krzysztof


