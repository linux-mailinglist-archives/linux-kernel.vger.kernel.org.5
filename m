Return-Path: <linux-kernel+bounces-119971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26A288CF91
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72782C807E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D1F13D523;
	Tue, 26 Mar 2024 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVwTIcUc"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05CB12B156
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486953; cv=none; b=ODYQ1Tdg4IQMNo5+WBEAKqQtFKGHKQLmfyoIckmfFMMt+osbKqWvNeX6Dz9Y7Y9K1Gcsvp/wNlvVpFnRbghBEF6UgfnLbLc39meoOjQsixMas/n7Xfacbc6ghM+craUn8IwV5uvcoe3wHLIjAFcyU3nkAk/S7RsdwGCoPlVgj7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486953; c=relaxed/simple;
	bh=on7uOmWOeWqBAIBMJG/2+F6UGZUMHF6+ikg65Ma31Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkXHwQuIiAv9rNKSy22kgNBAsurBwKB7jfk+kNPCC/2+PxHaeAl/C5kjanNzVagqs1gNvfzubA1xfQnRoewwX+kC35S2A0QNoHfi6Ge4tqQyAPNU6GCCp8pw9G1VNufHBcryCAfHvMQSlWdDpdGDpp4fC82i/Y1fLod1pj0Ozl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nVwTIcUc; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-515a81928faso3584563e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711486950; x=1712091750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=09Zf5P5vGBpmvdrWtx4RMS92d4LIttiFFqXDuisdloo=;
        b=nVwTIcUcBWmpw19MfsTFbDa9g1RT0fjCQE4UVgtF5ofdyFWJhX6L4R+TByF85E6Q74
         8x+In79VynjQCBElmRfXCF3ofmkHRlRA00hf16CuO8FwGTSZ7zdmNw9Or9y7DA9r7tfY
         hfjXs62xv7xWcbv5tT/zE4yrKq96ZSBrOPVqlxc/towdqq69NGJRzQfmbzkYENcml2f0
         MW3Ryjku+pWDB5ZWqyfCaxqa/uH0vmEsbMFzqPM+ehjN9UT3zDHmh4r+Mc6eBiV3Wl/H
         Bdi3He0xOoVY17MevmEdGMdTdxFUrYY7LOHuCesYQTru4ps9ws8aFTS+Vc/J/O50nA9G
         s8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711486950; x=1712091750;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09Zf5P5vGBpmvdrWtx4RMS92d4LIttiFFqXDuisdloo=;
        b=I9LUzaWgR+k+irAoAXZlBu+2JhGD4TvmZzfPy7jSJocAf/Vp0n2ckeWKVNA0KqWgbw
         zPGO6yRyksoruT4STv65sd7q6eKMg2rzMc7hZ5guAsV4lKBQQUIVBm3idaWAGf7OHCuL
         dsL9s5xU+IJakJpGTgdX4pMdX8zQdj9C0ArPlj4863qI4y1ae+OIjzFgRhY81NHQquL8
         MD7C5zYoP/LGreUaTKipCyurs2rbRN/vKeIqQKoJ/psdaGCkVbrdGGERgCPLW15zhZNU
         ruXvCB6rboDFoi++hBEsTLzs2Ni4ebxsle40tcQY2n+NrBLafsyqCPgF91SiqkgZPsFz
         XGXw==
X-Forwarded-Encrypted: i=1; AJvYcCUvlcMF5LSn/SLIOPOQ1FOHYbldMQX+ABVj/Kb8SS8IPvq3SpEoSNwvRce0CtS4SkYhLBUMgsl3ceiMieNNyBczGueDQ7CevtmzSAdK
X-Gm-Message-State: AOJu0Yy+EOYuZnAvi/5iVu9ltp4ZkOMAKE4liGQSBrN3tOH5CVvhVtN6
	JneizLWHuwRUyX5YV36n4etBt4R9Vz1x6QThXWawQDMcCmdgWQ0Gz4G5KQMXonc=
X-Google-Smtp-Source: AGHT+IGY+1iLe+1YFwBHQoSnDeRUdrevgbO3flkn+8e6KQZaVK+F/yHcPIiR4gvMFTdxihmoS6apsQ==
X-Received: by 2002:ac2:4ecf:0:b0:513:e21:2a64 with SMTP id p15-20020ac24ecf000000b005130e212a64mr1645468lfr.31.1711486949970;
        Tue, 26 Mar 2024 14:02:29 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id x18-20020a170906b09200b00a47df55cf5esm3123065ejy.13.2024.03.26.14.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 14:02:29 -0700 (PDT)
Message-ID: <236a104c-fc16-4b3d-9a00-e16517c00e3a@linaro.org>
Date: Tue, 26 Mar 2024 22:02:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 0/7] arm64: qcom: allow up to 4 lanes for the Type-C
 DisplayPort Altmode
To: Bjorn Andersson <andersson@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Abhinav Kumar
 <quic_abhinavk@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-0-07e24a231840@linaro.org>
 <CZUHV429NTF7.1GW9TN9NXB4J1@fairphone.com>
 <7a7aa05f-9ae6-4ca0-a423-224fc78fbd0c@linaro.org>
 <liah4xvkfattlen7s2zi3vt2bl5pbbxqgig3k5ljqpveoao656@iacnommxkjkt>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <liah4xvkfattlen7s2zi3vt2bl5pbbxqgig3k5ljqpveoao656@iacnommxkjkt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16.03.2024 5:01 PM, Bjorn Andersson wrote:
> On Fri, Mar 15, 2024 at 06:35:15PM +0100, Neil Armstrong wrote:
>> On 15/03/2024 18:19, Luca Weiss wrote:
>>> On Thu Feb 29, 2024 at 2:07 PM CET, Neil Armstrong wrote:
>>>> Register a typec mux in order to change the PHY mode on the Type-C
>>>> mux events depending on the mode and the svid when in Altmode setup.
>>>>
>>>> The DisplayPort phy should be left enabled if is still powered on
>>>> by the DRM DisplayPort controller, so bail out until the DisplayPort
>>>> PHY is not powered off.
>>>>
>>>> The Type-C Mode/SVID only changes on plug/unplug, and USB SAFE states
>>>> will be set in between of USB-Only, Combo and DisplayPort Only so
>>>> this will leave enough time to the DRM DisplayPort controller to
>>>> turn of the DisplayPort PHY.
>>>>
>>>> The patchset also includes bindings changes and DT changes.
>>>>
>>>> This has been successfully tested on an SM8550 board, but the
>>>> Thinkpad X13s deserved testing between non-PD USB, non-PD DisplayPort,
>>>> PD USB Hubs and PD Altmode Dongles to make sure the switch works
>>>> as expected.
>>>>
>>>> The DisplayPort 4 lanes setup can be check with:
>>>> $ cat /sys/kernel/debug/dri/ae01000.display-controller/DP-1/dp_debug
>>>> 	name = msm_dp
>>>> 	drm_dp_link
>>>> 		rate = 540000
>>>> 		num_lanes = 4
>>>
>>> Hi Neil,
>>>
>>> I tried this on QCM6490/SC7280 which should also support 4-lane DP but I
>>> haven't had any success so far.
>>>
> [..]
>>> [ 1775.563969] [drm:dp_ctrl_link_train] *ERROR* max v_level reached
>>> [ 1775.564031] [drm:dp_ctrl_link_train] *ERROR* link training #1 failed. ret=-11
>>
>> Interesting #1 means the 4 lanes are not physically connected to the other side,
>> perhaps QCM6490/SC7280 requires a specific way to enable the 4 lanes in the PHY,
>> or some fixups in the init tables.
>>
> 
> I tested the same on rb3gen2 (qcs6490) a couple of weeks ago, with the
> same outcome. Looking at the AUX reads, after switching to 4-lane the
> link training is failing on all 4 lanes, in contrast to succeeding only
> on the first 2 if you e.g. forget to mux the other two.
> 
> As such, my expectation is that there's something wrong in the QMP PHY
> (or possibly redriver) for this platform.

Do we have any downstream tag where 4lane dp works? I'm willing to believe
the PHY story..

Konrad

