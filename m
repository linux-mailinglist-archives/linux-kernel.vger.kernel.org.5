Return-Path: <linux-kernel+bounces-62502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AADD8521C5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F41F1C229A7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7FB4EB28;
	Mon, 12 Feb 2024 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex.com header.i=@yandex.com header.b="ItaX6CF4"
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946A14F881;
	Mon, 12 Feb 2024 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778276; cv=none; b=R74oVdXlBKeQAvgQCMjIZ28jS+9h6LgjCdxMvjEc6HiB5Kdzotxc7f4tNkJF987oa0s4Lf7AG+yahuFB1N2D1kkQhkzymk0CdQOEv7VnylH0fT5JNVa9iOlHLUOMM/0E9mqxI8Ork2emWTCIwIlpnLLCUHQiG+wD/n/pxbYJ+NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778276; c=relaxed/simple;
	bh=Rp0F2p2xa4tMIVuAskKB9+PZDyi3+DpKiaCAZIuQVJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9lmn0U0Lc1hIC0FzymYPlsrwoPtzJveB3jVJSGuVVm+/ZgXiImwDJgXadMVSehDIWYsFM7YVqMH2fkzydqgUGtQFlEK/SdxXkwlrkaomsE0lDw2rDrhHNAYkfXd4Wf3FZWAZgnp18B2HVQ8SthzsZcocYCosjB3L4HCc3NVFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com; spf=pass smtp.mailfrom=yandex.com; dkim=pass (1024-bit key) header.d=yandex.com header.i=@yandex.com header.b=ItaX6CF4; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.com
Received: from mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:5a6:0:640:ee22:0])
	by forward500c.mail.yandex.net (Yandex) with ESMTPS id CC6E460F42;
	Tue, 13 Feb 2024 01:44:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id civpIX0pHCg0-aviaNSvO;
	Tue, 13 Feb 2024 01:44:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
	t=1707777881; bh=l8YSD2byZe121ynq36axzQobriPKExDpwph35JKavO8=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=ItaX6CF4USzkVKNlQQCdzilewN5z2Q7DBFIvnEZuIxlmcJs8onDIXydbmfYoYRpg+
	 tHqvqS52aa+lhAHGn064WwlFWUku1+2lHNGxi4OuotcDy55wgflA6pak2SgMR0MkQA
	 lZuvjnIRIiCGvY0L5gkQTcYYJS/Srfu5XwLvfyrc=
Authentication-Results: mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.com
Message-ID: <9f8d39c1-66ca-4bb7-994e-de15cb516473@yandex.com>
Date: Mon, 12 Feb 2024 23:44:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/10] arm64: dts: rockchip: add USBDP phys on rk3588
Content-Language: en-US
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Wang <frank.wang@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20240209181831.104687-1-sebastian.reichel@collabora.com>
 <20240209181831.104687-7-sebastian.reichel@collabora.com>
 <6bc2f825-7e50-488d-a373-a211ac2cc8e1@yandex.com>
 <dsfne22iebd7mvyyskhpw3rkkfhlxpv32afht456vq3u52axyr@kgkxfzm5vn4c>
From: Johan Jonker <jbx6244@yandex.com>
In-Reply-To: <dsfne22iebd7mvyyskhpw3rkkfhlxpv32afht456vq3u52axyr@kgkxfzm5vn4c>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/12/24 19:48, Sebastian Reichel wrote:
> Hi Johan,
> 
> On Sun, Feb 11, 2024 at 08:24:36PM +0100, Johan Jonker wrote:
>>> +		u2phy1: usb2-phy@4000 {
>>
>>         "usb2phy@[0-9a-f]+$":
> 
> Interesting. I would have expected that to pop up in dtbs_check, but
> it does not for some reason. I will fix it for all usb2phy instances
> in rk3588.
> 
>>> +			compatible = "rockchip,rk3588-usb2phy";
>>> +			reg = <0x4000 0x10>;
>>> +			interrupts = <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH 0>;
>>
>>> +			resets = <&cru SRST_OTGPHY_U3_1>, <&cru SRST_P_USB2PHY_U3_1_GRF0>;
>>> +			reset-names = "phy", "apb";
>>> +			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
>>> +			clock-names = "phyclk";
>>> +			clock-output-names = "usb480m_phy1";
>>> +			#clock-cells = <0>;
>>
>> Align with the (new) documentation
>> about property ordering.
>>
>>> +			status = "disabled";
>>> +
>>> +			u2phy1_otg: otg-port {
>>> +				#phy-cells = <0>;
>>> +				status = "disabled";
>>> +			};
>>> +		};
>>> +	};
> 
> The above follows everything from [0], which does not specify an
> order for the "standard/common  properties". For those this follows
> the order of existing usb2phy nodes. Did I miss any other new
> Documentation?
> 
> [0] https://www.kernel.org/doc/html/next/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

While reading the text below I think it's in need for a clarification that the property order for common and vendor category is alpha-numerical as is for nodes.
For Rockchip DT in this case "reset*" below "clock*", so that the person after you can add properties in a sort list.

Johan

===

The following order of properties in device nodes is preferred:

    "compatible"

    "reg"

    "ranges"

    Standard/common properties (defined by common bindings, e.g. without vendor-prefixes)

    Vendor-specific properties

    "status" (if applicable)

    Child nodes, where each node is preceded with a blank line

The "status" property is by default "okay", thus it can be omitted.


> 
> -- Sebastian

