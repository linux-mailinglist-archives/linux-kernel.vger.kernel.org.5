Return-Path: <linux-kernel+bounces-134609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C5189B390
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326F6282606
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513523D0AD;
	Sun,  7 Apr 2024 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJ23vzzQ"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B652B9A1;
	Sun,  7 Apr 2024 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712515224; cv=none; b=B1qyuBiYeySOgp65i7zxIga/O5lK5HQuUAumM0MptxUR/oHNtJ4y82QsyJmxVHb1QjO2Z+jfoja18pq+dfMoLVuN4IETuFaz7f9VRsRlJE5PVY+BL0/xUhV4yro2IbjqBZRDw0xpgcVRIxU8dbui4jUmYWyu6uH63tkJbdh/lcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712515224; c=relaxed/simple;
	bh=Glcv9Cfa/RL+I7lKtLosx7TfMrb+W2ew4tTTMPcMOMg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KI1+8YMaerleS30Srhw2TrXyn37vyls6OGNj1h8iEQSxOHQLrC/HexsqmGdlI55UvNJ7sS3CddqWkfJquJAvMO3JrdBnL6nMpHGyJ3KqnzmjRkK7CCUDV8IGEJWA8BV5fKHgBkp0RVxgJvkDC/PNWP8YK/yqSnWa9JqwD/bLHxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJ23vzzQ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e6d063e88bso2719614a34.3;
        Sun, 07 Apr 2024 11:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712515222; x=1713120022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QUKtwHYYOS78zOcm53x8cFgShMzlmboFlKQVfaRJWT8=;
        b=LJ23vzzQ+0aW7d/Ct7D7Pv4zjheZ3mMGSaZ5nhTJQh1WU8oYRAh1b8IGgNm0TziB/o
         BmrNjz2/fS3/xgJ8OQWNeMjPuxK8D6hRxUdYzbyzuk+cnElAzJHP8nGxBoFf57yB/JG+
         V/wmKmM8EUtnp3aUtjKnOOpgO9nQXSGq7JMNCeKxUPcEwTza6GRieyIwDuIn5PQTaJGu
         zTbEzrzLeTDdsE9ARcvZIHiwb9TN5lRvblxUxr8kbiBDFIAlkkuhXh83w52HW1BMZolF
         6uKuOMLFAN6dliYSwU3xJ4TzTSmN1rWrlsK6uzmQMec7JXKQlhPWl5hcKXZ80aiG58a5
         43Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712515222; x=1713120022;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUKtwHYYOS78zOcm53x8cFgShMzlmboFlKQVfaRJWT8=;
        b=u73UhxP83eOmRFS2u9rGyBUHrBqZ0NKvGSq2bgVB87fzHR5pA9lo/X1i6f1BHtwIHD
         9j/DfiT/4tVwZt7ZBmHkXgH1OXOd8VGBKRVxL/K/Xafos2Vsf0dXhZLmYfbap4po94B1
         SfKgz2vlEKLhbrjJjoPybSP6u5oG38Q7e37K5SGUvHK0SG3Y3T55fPbw6uBp1PFEHYZy
         SVHa78HsqnKSu4BKYN6xlSqmbuJ0NV9qbYGYJBo5htz9SDvDcy+TYiL93TiZkE0p5ITw
         vjhp05w0dhRLOm2zlDTgivnw7LRTMQ1JUWoZKrDYp/F5BK5Jn4yndlXCG20p/tqwV56C
         +iug==
X-Forwarded-Encrypted: i=1; AJvYcCVPMmm0xZnBpXC4AEMOjJ1GwCiJXP0kXxmLITma+rSuVZMlDGJm2xLjVWgv1cMU9mM7afSmYXor4vOTWopB6oD5RhW8/ETrQb+1jnvbqMLeNwPwYXo3AHPwATJ/Xczo4LEcSVaTC2dn/qm7xhU4n1x0wmMuymnvWc78O3t5bTIcFvscQqMqS/KihCMxGhAD5t2UH2gNJGN4nneJWcXzxqur1dI=
X-Gm-Message-State: AOJu0Yy4LKa8ENqM7Km1KSPRCfzguKjF5Vl7cSbsEehf995mVkhEbHXF
	KNk8pPIQg2kdutvYRMjmrXu2Ih4aMc4zN16zgKG+Jn9ijLqsRE3n
X-Google-Smtp-Source: AGHT+IGcqRPsdihGAZOFsMaEZYvWNrkAJe8AeEvdxDpvELNxvl9nXMdBo8DkpHTLIvxk68A3QU/rRA==
X-Received: by 2002:a05:6830:1341:b0:6e9:f501:1943 with SMTP id r1-20020a056830134100b006e9f5011943mr7227024otq.33.1712515222151;
        Sun, 07 Apr 2024 11:40:22 -0700 (PDT)
Received: from [192.168.7.110] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id p13-20020a056830338d00b006e6cb624064sm1176829ott.40.2024.04.07.11.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 11:40:21 -0700 (PDT)
Message-ID: <4f72048a-a764-43de-846c-3b4edc1232e3@gmail.com>
Date: Sun, 7 Apr 2024 13:40:20 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] spi: spi-qpic: Add qpic spi nand driver support
Content-Language: en-US
From: "Alex G." <mr.nuke.me@gmail.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, broonie@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 manivannan.sadhasivam@linaro.org, neil.armstrong@linaro.org,
 daniel@makrotopia.org, arnd@arndb.de, chris.packham@alliedtelesis.co.nz,
 christophe.kerello@foss.st.com, linux-arm-msm@vger.kernel.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20240308091752.16136-1-quic_mdalam@quicinc.com>
 <20240308091752.16136-4-quic_mdalam@quicinc.com>
 <1c803d8c-80b2-47a9-bc8c-8b13cbfc6841@gmail.com>
In-Reply-To: <1c803d8c-80b2-47a9-bc8c-8b13cbfc6841@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/7/24 12:48, Alex G. wrote:
> On 3/8/24 03:17, Md Sadre Alam wrote:
>> Add qpic spi nand driver support. The spi nand
>> driver currently supported the below commands.
>>
>> -- RESET
>> -- READ ID
>> -- SET FEATURE
>> -- GET FEATURE
>> -- READ PAGE
>> -- WRITE PAGE
>> -- ERASE PAGE
>>
>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
> 
> For the entire series:
> 
> Tested-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> 
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index bc7021da2fe9..63764e943d82 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -882,6 +882,14 @@ config SPI_QCOM_QSPI
>>       help
>>         QSPI(Quad SPI) driver for Qualcomm QSPI controller.
>> +config SPI_QPIC_SNAND
>> +    tristate "QPIC SNAND controller"

Also, don't tristate this. It can be set as CONFIG_QPIC_COMMON=m, which 
will cause the build to fail because you don't have a MODULE_LICENSE().

>> +    depends on ARCH_QCOM || COMPILE_TEST
> 
> Here, it needs to 'select QPIC_COMMON`. Otherwise it can run into 
> unresolved symbols:
> 
> : drivers/spi/spi-qpic-snand.o: in function `snandc_set_reg':
>   drivers/spi/spi-qpic-snand.c:56:(.text+0x484): undefined reference to 
> `qcom_offset_to_nandc_reg'
> ...
> 
>> +    help
>> +      QPIC_SNAND (QPIC SPI NAND) driver for Qualcomm QPIC controller.
>> +      QPIC controller supports both parallel nand and serial nand.
>> +      This config will enable serial nand driver for QPIC controller.
>> +
>>   config SPI_QUP
>>       tristate "Qualcomm SPI controller with QUP interface"
>>       depends on ARCH_QCOM || COMPILE_TEST
> 
> Alex
Alex

