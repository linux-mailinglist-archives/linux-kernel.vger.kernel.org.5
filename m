Return-Path: <linux-kernel+bounces-22099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E968829934
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0571281AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A381847A67;
	Wed, 10 Jan 2024 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="myUJcrFj"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F82347F40
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50ea9e189ebso4117870e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704886349; x=1705491149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pEYNQVl4EfVcsy1yzh6J8gEcbt+r98QebOoStpii/nY=;
        b=myUJcrFjTl9ZqjZf7AcZxgux1afGCi1RuGuZNA6BAkNg7IcuTQlAvncxiGN/IcgLuc
         N/xpTyqAyRFd6722pthMi06bm0j+YydQOjTVxUpFje2mWl49K9nT2OuzpPmNQQhfn3h4
         pqv6bGVKNLMfeHz8eMV5QDsj2J+6tY4KmWxKj0/Q/NvbKRzG3wsRds5lDyZ0uLLypF9r
         sj4Rf8/VkrbbNET82v2RtNd9DqkxZEMvKVmUiu96/y/tqGfZEP1XGR1/k0DxXi2vW9kc
         mZXSiXwdEEhIel7W1XTq+B7chKRzlCS7JO/44mV4NMlUx1TpnNZzHlCV9QXoTvt8fHFb
         DU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704886349; x=1705491149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pEYNQVl4EfVcsy1yzh6J8gEcbt+r98QebOoStpii/nY=;
        b=EWOVZ0Oqbak0bu0cyKU4rwnHCAeEOZiSSfZ9vK4SAfjrBSCPHsLwp085CkNHKYl3dJ
         HzD86z0j+GV4iIPXRRSTa0y2rlJjuBQNMqFVxaGZb2G0DXSjh6yWJCpQrvJuL3E1rVr2
         Ob/Zn7vi5aqaksX8Sn/bDuhnnDvJCowk/dZSHhZp9sPQRXpwkbW8iv5LcEx3iKGIkHDe
         SN7zm6jx9YWsp2cKFAJlwcq/xNVO861biHR+3i/Tbx9IVfFzvsk80srSiLHqrXcY252f
         Kat+8P1A8+KzWGoDl+/4swGQ5XGTVIT4o7tf0Aw+f48I0enp8q60BoZ9XNu+AVYJRaMw
         kYwA==
X-Gm-Message-State: AOJu0YypTwY/GkAK9RwlPREmfbHTYNH+z3g9P9/f3z219tZgiCFJCFKs
	XM52tmrgvYQN0gHxSLL+Dpk78fyZIj9qjg==
X-Google-Smtp-Source: AGHT+IGAMkvcpAUqyxRbD5/R78Qb2kagPxgsXLcXC0AOuJ2ThqexDzA5wsbcuzXqLXPlb2wTFi9INw==
X-Received: by 2002:a19:3856:0:b0:50e:8487:1ec6 with SMTP id d22-20020a193856000000b0050e84871ec6mr253105lfj.56.1704886349316;
        Wed, 10 Jan 2024 03:32:29 -0800 (PST)
Received: from [172.30.205.119] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id z22-20020ac25df6000000b0050e6df07728sm629214lfq.180.2024.01.10.03.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 03:32:28 -0800 (PST)
Message-ID: <0ac211de-e3d4-4a41-b0ed-d2bf393e58cb@linaro.org>
Date: Wed, 10 Jan 2024 12:32:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Add PPE device tree node for Qualcomm IPQ SoC
Content-Language: en-US
To: Luo Jie <quic_luoj@quicinc.com>, andersson@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 quic_kkumarcs@quicinc.com, quic_suruchia@quicinc.com, quic_soni@quicinc.com,
 quic_pavir@quicinc.com, quic_souravp@quicinc.com, quic_linchen@quicinc.com,
 quic_leiwei@quicinc.com
References: <20240110112059.2498-1-quic_luoj@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240110112059.2498-1-quic_luoj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/10/24 12:20, Luo Jie wrote:
> The PPE(packet process engine) hardware block is supported by Qualcomm
> IPQ platforms, such as IPQ9574 and IPQ5332. The PPE includes the various
> packet processing modules such as the routing and bridging flow engines,
> L2 switch capability, VLAN and tunnels. Also included are integrated
> ethernet MAC and PCS(uniphy), which is used to connect with the external
> PHY devices by PCS.
> 
> This patch series enables support for the following DTSI functionality
> for Qualcomm IPQ9574 and IPQ5332 chipsets.
> 
> 1. Add PPE (Packet Processing Engine) HW support
> 
> 2. Add IPQ9574 RDP433 board support, where the PPE is connected
>     with qca8075 PHY and AQ PHY.
> 
> 3. Add IPQ5332 RDP441 board support, where the PPE is connected
>     with qca8386 and SFP
> 
> PPE DTS depends on the NSSCC clock driver below, which provides the
> clocks for the PPE driver.
> https://lore.kernel.org/linux-arm-msm/20230825091234.32713-1-quic_devipriy@quicinc.com/
> https://lore.kernel.org/linux-arm-msm/20231211-ipq5332-nsscc-v3-0-ad13bef9b137@quicinc.com/

None of these describe (or even use) the compatible in the first
patch of this series ("qcom,ipq9574-ppe"). I didn't check the
subsequent ones, as I assume it's the same situtation, so this
is a NAK.

> Lei Wei (2):
>    arm64: dts: qcom: ipq5332: Add RDP441 board device tree
>    arm64: dts: qcom: ipq9574: Add RDP433 board device tree

These two look unrelated?

> 
> Luo Jie (4):
>    arm64: dts: qcom: ipq9574: Add PPE device tree node
>    arm64: dts: qcom: ipq5332: Add PPE device tree node
>    arm64: dts: qcom: ipq5332: Add MDIO device tree
>    arm64: dts: qcom: ipq9574: Add MDIO device tree

Konrad

