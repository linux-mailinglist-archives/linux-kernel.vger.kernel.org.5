Return-Path: <linux-kernel+bounces-134030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FAF89AC4D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC72B2827CC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B985787B;
	Sat,  6 Apr 2024 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkwjDuVN"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D594CE17;
	Sat,  6 Apr 2024 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712422131; cv=none; b=twNNrXm1zFcpdy0HO6fYvWudUx3suY2DXilyZoqIPSEB5i6MycLTK89JuB0t/qCibH/CGFYFERrKtoc81dw4mQu58Uui22QGRsrZf0dpb0I4R86S43Tv60LG2kG8uNFxn0Bp9d/fEPGqTXZtYftRAuzuIKTlY44rL3r/YQi1rXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712422131; c=relaxed/simple;
	bh=l0HOUvCH5NyJ7m1SR7z+oF/8ktmm109ZvDWMpVVXq88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7ChMlJi9kjK+ysMFgqyHcNsK8wRqKr/8fUz5w7+FbMe3bO/f3UZp0V7xfv/cAEvUAFxrDOcS0zy3t8whVycKkajzi3btvdv/WuMRiwXvTQER5nU8Obr8h0AmkKCoD91PkemCy1guE6rBrOGJspb1SOZqghQ/LzAjXedCfFysMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkwjDuVN; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e6a00de24aso1813728a34.3;
        Sat, 06 Apr 2024 09:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712422129; x=1713026929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DKheQqCooEORfEAc4BfVHAN7JSAJma1nB9maY1cQRV4=;
        b=nkwjDuVN41tyYOOa/+a+Yw5xNlSffz7DilVPwDiL43lvNT/GK5jiFVDn6dg5SD0wmg
         gF4jWTeJVD1I4DhTpoRgFtXSFXXOFoEi+1O0RHZSyz8WvYGeHa7aTTNySYb0rK9zB5y4
         zRyMYaQsD/bTPFLktzjp11X6jIxWocXGuJx4iSMoMclHUZhI0kR1l5YAhGi36ipl7Mox
         QMH7pbywVBbwbP52sLJls1hX+nPjImZV4GryTI83r7GKWRVcvGUsBrmIPu+Z6gl1W0uW
         XA5RS0uc6b8sLAE0kIp9wg6aVhDE6EfqLIK59T2oMQvjJDCObBdWvbxregF4mWroIRYb
         nwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712422129; x=1713026929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKheQqCooEORfEAc4BfVHAN7JSAJma1nB9maY1cQRV4=;
        b=N0mKFSOy35s0MFbmTObHjVhBsggUIQ2X5deGwrX3sWpXOnVOQZKKOfKilOw2S+Ra2Z
         geDRZokDh1Iu5l1olXxIxvBHfyKPjhx7PKmgLAoTqP6qvHDNXgyl2EUNFXTnE9Lq2xix
         ErilFSQ7AZtMrV6UbN8hr7nJiEJPecIDlIWNf/emwE/Jh01E8KJq10Yst4JCkA/xEv4n
         wgvty9xAGNQfVKk8XpRH4gC/MB9ZGWTJ/p/ywbAEscm+LdnCElCMhEBe7lb7nkje4Hrg
         8qLxCG3BMuUH4lSYdvsozvlyRjMpKPLVXMsK9iWqbfBFU10mXBUKFyRWw83bUbo4kJil
         6iLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRd6g2ROl/Q3qzmDfsMmu+2gTWjXBqxjhJL1o0Htd96KXul/juIfHUEI7ktTteidllr+p1wYmWNrjjlwJMosNI8eBePUcmtTLAiZzRj1qLBqXx9138g4cM/A6bNEwbWH+q6Rt2grXlgg3WLg==
X-Gm-Message-State: AOJu0YxFlSY6RDi6SSZvPTPkJq0oX+HspZK86cPSCgiYEwZy/Y10XbYd
	Lq19W3ZdPFHs+YrLOyGozQydSP2C2QLjeNKqvqnmpxsgdrmndN0t
X-Google-Smtp-Source: AGHT+IHQhCgoz1D7z2Bflhbg39hCU1gZZwVTvOMMq3IkNcQxp3kf0snzpBO3qyliIQ0NwjSLyvPMJw==
X-Received: by 2002:a05:6830:11c5:b0:6ea:f00:5c2c with SMTP id v5-20020a05683011c500b006ea0f005c2cmr701920otq.35.1712422128821;
        Sat, 06 Apr 2024 09:48:48 -0700 (PDT)
Received: from [192.168.7.110] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id i4-20020a4aab04000000b005a48e64c699sm821908oon.40.2024.04.06.09.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Apr 2024 09:48:48 -0700 (PDT)
Message-ID: <45e1a982-fd59-48de-ace4-d6b6e821189d@gmail.com>
Date: Sat, 6 Apr 2024 11:48:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] phy: qcom-qmp-pcie: add support for ipq9574 gen3x2
 PHY
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Vinod Koul <vkoul@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, ansuelsmth@gmail.com,
 robimarko@gmail.com, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240402192555.1955204-1-mr.nuke.me@gmail.com>
 <20240402192555.1955204-6-mr.nuke.me@gmail.com> <ZhEMB0HP0g1YwPvE@matsya>
 <CAA8EJpqYV537aCbkwTRUeZJzcn4wMXFqGxQHSdDFraGV_2zbQQ@mail.gmail.com>
Content-Language: en-US
From: "Alex G." <mr.nuke.me@gmail.com>
In-Reply-To: <CAA8EJpqYV537aCbkwTRUeZJzcn4wMXFqGxQHSdDFraGV_2zbQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/6/24 09:37, Dmitry Baryshkov wrote:
> On Sat, 6 Apr 2024 at 11:47, Vinod Koul <vkoul@kernel.org> wrote:
>>
>> On 02-04-24, 14:25, Alexandru Gagniuc wrote:
>>> Add support for the gen3x2 PCIe PHY on IPQ9574, ported form downstream
>>> 5.4 kernel. Only the serdes and pcs_misc tables are new, the others
>>> being reused from IPQ8074 and IPQ6018 PHYs.
>>>
>>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>>> ---
>>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 136 +++++++++++++++++-
>>>   .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 ++
>>>   2 files changed, 149 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>> index 8836bb1ff0cc..f07bd27e3b7a 100644
>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>> @@ -487,6 +487,100 @@ static const struct qmp_phy_init_tbl ipq8074_pcie_gen3_pcs_misc_tbl[] = {
>>>        QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
>>>   };
>>>
>>> +static const struct qmp_phy_init_tbl ipq9574_gen3x2_pcie_serdes_tbl[] = {
>>> +     QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CLKBUFLR_EN, 0x18),
>>> +     QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CTRL_BY_PSM, 0x01),
>>> +     QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_SELECT, 0x31),
>>> +     QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_IVCO, 0x0F),
>>> +     QMP_PHY_INIT_CFG(QSERDES_PLL_BG_TRIM, 0x0F),
>>
>> Lower case here and everywhere please
> 
> For hex values

I will these updated in V2. Thanks!

>>>   static const struct qmp_phy_init_tbl sdm845_qmp_pcie_serdes_tbl[] = {
>>>        QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
>>>        QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
>>> @@ -2448,7 +2542,7 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
>>>
>>>   /* list of clocks required by phy */
>>>   static const char * const qmp_pciephy_clk_l[] = {
>>> -     "aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux",
>>> +     "aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux", "anoc", "snoc"
>>
>> How about older platforms which dont have these clocks
> 
> The driver uses devm_clk_bulk_get_optional(), so it should be fine.
> But the more important question should be why the platform needs
> anoc/snoc clocks here.
> 

I got the info from the downstream 5.4 kernel. While I don't know why 
these new clocks are required, they are needed. Omitting them will cause 
the boot to hang.

I could rename them to "snoc_lane" and "anoc_lane", if you think that 
makes more sense.


Alex

