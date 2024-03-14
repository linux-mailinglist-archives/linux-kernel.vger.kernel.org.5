Return-Path: <linux-kernel+bounces-102951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7241087B8F0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B7C1F210C9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251AB5D46B;
	Thu, 14 Mar 2024 07:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jg/yIvLb"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C8D2AEF5;
	Thu, 14 Mar 2024 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710402806; cv=none; b=u0w6/TAcfwoIcYYUkugQ7Td4yomNw01N+OCGmAKpM8DmWsHKXhOgA9rb6dp/8xyDRzzvN/Ke6eJXdkij5y5iG8pJOX/rT3dePPhXzdNN4ACyXPIah9RAv8ULtkP2Aihua4S8KgM/sd8+tOOMH6hyUIzoolcFcTZX6ej7fu3+pms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710402806; c=relaxed/simple;
	bh=bxdzSN/8FBeJ0CQl64AWcR2laY+ZofOFZBaFzP3Q14E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZtOqSZEzd+ZwPpHLIORAEwsuHljpMQkBWUKFMG//60m5mcEAHvyVefZLIpqzHIU+udF6gRMpxi4l7kMsf6S7DL35mMeB/UCFcO8F3i0dYQuhzTjukC1j+K/VaA/ijQiNZwBUBuInCXlyWZGUJjvSwvRQqvLC2v62NtFDu0+2SFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jg/yIvLb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4132f37e170so3807385e9.2;
        Thu, 14 Mar 2024 00:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710402803; x=1711007603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gn4gj7fpfifQMAh0+TuenKxoInLOMHsjt+PcnC9Scoc=;
        b=jg/yIvLbb77FV2qWX0N6VaBF6L4a+GxfjHic6apQ2njgxfqLkFubUgkyAwrbseLZQ/
         vkdQ0cj/aDsE+zbt2gjd2VjgVWBR/dDqsEi2yJMRhzt8xShji3d1kNwRQ4jqeUSod7sK
         DV9qq+IFD/5jdiHEgoA3EKaVpqyskGLCpp7YDGKhYKw3p3zDPdi1m4gQjojVG1niNtJk
         whVieNL5k22nH0yEWGteWGejkAORkvfMPQPyI/s5q8PcC2HEDm4oNehFNSUhNtwDTAew
         gO2J9ztSU2lXZwS8lknP2y+2jzBDI1AogeL7JWNlowp2RzUdmQSN0LqDDS8+bHBGfVQ4
         Baog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710402803; x=1711007603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gn4gj7fpfifQMAh0+TuenKxoInLOMHsjt+PcnC9Scoc=;
        b=a4uH2P2TPPieec3i2Mq7Tu1O6XQJFBBrafPSdLfLDOxuuURbcE3bloizL8yV2FzAXV
         O+wzO3XndjSI5jN3SEOGVusnu5TI+uxr+7SvbdS+tixM4oi3RoWFQkWy1HPz6Ortoj+O
         Ec/BCSlZWw3osOV8PdtVeaBlremD3Hq/XibHaY0iN37RF+0an69ovBTsHu09kcibKm+a
         79c+k/pL0bGtgu1JOqsgRD2nLAPxKGdWDCkl/rx+YK8O7hnaY18Hl1EMM5Adc1skW8Ly
         3SjEwt+qGvFvcEE5wwGx387gZqFGtd2wf+WtHnIJb785V91kw69p1SO+937U2m5vIiLZ
         VS8w==
X-Forwarded-Encrypted: i=1; AJvYcCX5uM7AZWssKcLPVd2CXWfKuSd1XSQvZkxmKVms6yKnhSsomqoApq2rIERxQtgRYYmV0x8EqApUOkLRXC46WNA0B+hzhuSVIo0H3tNgfxcSasiGWhDE9bS4AbCdb5DuCIZisWl+Y8A73g==
X-Gm-Message-State: AOJu0Yy9P4KNFWrjwrdkm3N3XY5k2kfSqZciglzH+FsSqlph610qnDN+
	LVOr/hQ+djTUKl9H8MSV7xmQG4gESqr+asC6XI0Of1djSrlH7Dh3S3yl4RtkUNE=
X-Google-Smtp-Source: AGHT+IHIYi9eNIj5NSdmQ1rkHsd/2kZvtqfCiSo4m+lFDbTKXiYw2m+vJ913NZKJ9XC09jwD5GbLHQ==
X-Received: by 2002:a05:600c:4f56:b0:413:eee2:96a3 with SMTP id m22-20020a05600c4f5600b00413eee296a3mr717728wmq.1.1710402802707;
        Thu, 14 Mar 2024 00:53:22 -0700 (PDT)
Received: from [192.168.20.170] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.gmail.com with ESMTPSA id bu25-20020a056000079900b0033ec9007bacsm112151wrb.20.2024.03.14.00.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 00:53:22 -0700 (PDT)
Message-ID: <dba85b0b-2318-4cdf-a678-a07ae82c65c1@gmail.com>
Date: Thu, 14 Mar 2024 08:53:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: add TP-Link Archer AX55 v1
Content-Language: hu
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240313-archer-ax55-v1-v3-0-cd9402efab59@gmail.com>
 <20240313-archer-ax55-v1-v3-2-cd9402efab59@gmail.com>
 <b8d9117e-5e99-4f69-844d-997a3fbf04d6@linaro.org>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <b8d9117e-5e99-4f69-844d-997a3fbf04d6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024. 03. 13. 19:27 keltezéssel, Konrad Dybcio írta:
> 
> 
> On 3/13/24 19:25, Gabor Juhos wrote:
>> Add device tree source for the TP-Link Archer AX55 v1 [1]
>> which is a dual-band WiFi router based on the IPQ5018 SoC.
>>
>> At the moment, only the UART, the GPIO LEDs and buttons
>> are usable, but it makes it possible to boot an initramfs
>> image on the device.
>>
>> The device tree can be extended in the future, once support
>> for other periherals will be available for the platform.
>>
>> 1. https://www.tp-link.com/en/home-networking/wifi-router/archer-ax55/v1/
>>
>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
>> ---
>> Changes in v3:
>>    - change pin configuration to use "gpio20" and "gpio21" for UART pins
>>    - rebase on top of v6.8.
> 
> Did you actually check this?

Yes, I have tested this.

> And how so?

First, I have checked the stock firmware which uses the same pinctrl configuration:

  root@Archer_AX55:~# uname -a
  Linux Archer_AX55 4.4.60 #1 SMP PREEMPT Tue Mar 14 18:25:29 CST 2023 armv7l
GNU/Linux
  root@Archer_AX55:~# strings
/sys/firmware/devicetree/base/soc/pinctrl@1000000/uart_pins/blsp0_uart_rx_tx/pins
  gpio20
  gpio21
  root@Archer_AX55:~# strings
/sys/firmware/devicetree/base/soc/pinctrl@1000000/uart_pins/blsp0_uart_rx_tx/function
  blsp0_uart0

It is also visible in pinctrl-maps:

  root@Archer_AX55:~# cat /sys/kernel/debug/pinctrl/pinctrl-maps
  Pinctrl maps:
  device 1000000.pinctrl
  state default
  type MUX_GROUP (2)
  controlling device 1000000.pinctrl
  group gpio20
  function blsp0_uart0

  device 1000000.pinctrl
  state default
  type CONFIGS_GROUP (4)
  controlling device 1000000.pinctrl
  group gpio20
  config 00000001

  device 1000000.pinctrl
  state default
  type MUX_GROUP (2)
  controlling device 1000000.pinctrl
  group gpio21
  function blsp0_uart0

  device 1000000.pinctrl
  state default
  type CONFIGS_GROUP (4)
  controlling device 1000000.pinctrl
  group gpio21
  config 00000001
  ...

Additionally, this is what debug/gpio says:

  root@Archer_AX55:~# grep -E 'gpio2[01]' /sys/kernel/debug/gpio
   gpio20  : in  1 8mA no pull
   gpio21  : in  1 8mA no pull


Then I have tested the following with v6.8 and with the previous version of the
patch.

Exported GPIO20 via sysfs ...

  root@test:/# gpio=$((512+20)); echo $gpio > /sys/class/gpio/export; while
true; do for dir in high low; do echo $dir >/sys/class/gpio/gpio$gpio/direction;
sleep 3; done; done

.. and measured the voltage on the UART pin header. Then I did the same with
GPIO21 as well.

This revealed that GPIO20 corresponds to RX and GPIO21 to TX.

If that matters, the downstream kernel also uses this 'trick' for some boards:

https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4/arch/arm64/boot/dts/qcom/ipq5018-db-mp03.1.dts?ref_type=heads#L443
https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4/arch/arm64/boot/dts/qcom/ipq5018-mp03.1.dts?ref_type=heads#L565


Regards,
Gabor


