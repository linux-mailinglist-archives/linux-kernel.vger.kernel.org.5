Return-Path: <linux-kernel+bounces-152491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828A58ABF38
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 14:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF2C28101F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 12:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3371429B;
	Sun, 21 Apr 2024 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kWCAaW3p"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AEF12E5D;
	Sun, 21 Apr 2024 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713703994; cv=none; b=csPOBMNEfwjid2NGVFvSW3F4Bk3DD1ZynJf6WkPwcVww6Rgf3AZFv11GcHoQV0h4CG+4ABTg47Men0LSJjxBmR+GqntVC7roWbIMmKg1A9rihYb9jrD7DsYJoUaWp3NQ3O9vhxrzxV6Pb3M3Wh+9ExUh9V1vfNgzdPS6S4+KMhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713703994; c=relaxed/simple;
	bh=SKSWf5drZAIMxxyx7CqVNHbBlfdMwWwCpOCl9v4vz7g=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=IN8znAXfxm+GeJOzuc7VCqLKK5o8ZevL4oTtr/06ExwvzsP48q0Q8eUaaJMOz8no6Mu3V2cfda74leipr9/YPU2V1Huvfa11qU3ffDKs0lZHY827gFHF+R+JVfbH8fxsyQdk2/uGdK+eimKVy70sjowm5Yfl+mX2D4H792VkJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kWCAaW3p; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1713703976; bh=9yDBgQO4TbmtaqpS9si5I27IyPRDwpcQsvToSrByr5g=;
	h=From:To:Cc:Subject:Date;
	b=kWCAaW3pM4ygcmKzLmjcnih/bJ8Pga+3h5+ZMSa25VMTI9HYElD0K38x7T87jwWo8
	 N/JBTRRK3PTdDLY9yGFcxSdnbsVBeWpurn8ZZtaCI0tnfXeIPH6DCTvL+HOr3b19Ix
	 UlRqfqx0nnaUyximKh4giGC71gmFxxFY3vTQOwis=
Received: from cyy-pc.lan ([240e:379:2264:6200:aa04:7d36:395a:da35])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id D33992DC; Sun, 21 Apr 2024 20:52:51 +0800
X-QQ-mid: xmsmtpt1713703971tqsj69njy
Message-ID: <tencent_E9B853316D217B8D1E7CDF8288DA5E8ED908@qq.com>
X-QQ-XMAILINFO: OLnGMPzD2sDVlqXcDkXPfyYiQdQtEoO2sX2M6LXOzSLZIlX3ONwmstyW8GsBgS
	 +V2/eif459i1yOXB7vnvDk6GENdyWDY8H8fy6iDpDM87c6N/fgLSbCmtVKx5MagWd0vvp7A3Fn2+
	 xjltDdBwixT5zlRzoH5+k0wkd1h7uFaWJCvSRC3I1NnquSDMm0ElzWwt3XpuvUzDnWYMwBYnVBaU
	 lJAUSk6fhqEb2/DOe0UXaHcF2zW06FB/9iRjnGUrvpbmuUahFyl9MaC7fKhRSV1IuyxnOJDgiHLq
	 u29VPXB2lAazJndDuLYSj7no/o1WLYSmqMTEJ5P2aHRCJOT7Fnx343RNSMoxA6X7/Ew7eukN9u/m
	 9LJIB4IJm3n2qJl2pFBXrRHZ7BC08UCktR4qwWTwa6a0Qu/z7z6YAuh1aarOnm6dfQkiOZoqO/i6
	 BQ7rrB1es1TY19SqhWmvPEtWMpjwJbYIjkm+XFyr4UthmkQWgZjFrPXf8wMt4pgc0v/R9YO5YIXX
	 +nkUJDw2ohQTVPN92QuLmpO2BpfHhx+morTqIeYWP/JbQXLK33c/gLwyl1YL6N/fDLFtFIMlse5g
	 irnETmYUensSOs0rlHV1mnJSACC7jfQomSuWx7nVtvfbiLK03bJKN5V4DJ76hf2gPWS67k01jmxS
	 I8oqxwCPIY8yPbqsjcw33B6J24PeuPF5CrbjSbgQVhTKdoo59pBVKO6HmWf7fRxUSGsd3kwS1poK
	 +yrHXhgjgKaXGqSIi8I2NR7hUj5DWTLkSrr7fTsQMf0vH8Mv/Snt8tgt+nAW/BevWwbXl3FcD1/U
	 k1kGBBvu74h+JphDA6E3arB/qWSzMSCBR4ZnQpIfm7omtiNIjN2fBWD7Bu04sm5Hy+HcT5ffM+wz
	 x7R1lv9DixA8CbRi+Y/DpBXxIsIZ26KqLqz8MfOvJC29p48CjOp8iviiqccVARIYcpseaMH3tVNR
	 x+RuXjBzpNrKlRep8XMPF2Bfl1lQiWOC88xjmSmkXcG9gA9pRt/zCsQ6GhI4Aakjk1fZXiraVHdV
	 kNB/EOuw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v1 0/2] riscv: dts: add USB nodes for Canaan Kendryte K230 SoCs
Date: Sun, 21 Apr 2024 20:52:50 +0800
X-OQ-MSGID: <20240421125250.1039510-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As K230 SoCs have two USB controllers, add USB nodes for it. I have tested
the new dts file on both CanMV-K230 and K230 EVB. 

I confirm it can work well in USB Host Mode with high speed. I use
CanMV-K230 to connect an RTL8152 USB Ethernet adaptor to an OTG Port
(USB0), which works well with this log [1]. The on-board ethernet is
connected to the USB1 port, which works. On K230 EVB, the RTL8152 USB
Ethernet adaptor works well on a USB0 port with high speed [2]. I have no
health device to test the USB1 port on K230 EVB. My K230 EVB USB1 port has
no +5V power output even on factory-patched u-boot + opensbi+ kernel. 

I also confirmed the dt-binding can work well with NFS as rootfs over USB
Ethernet. It's good news for those who want to use K230 SoCs to boot a
mainline kernel with distro rootfs for daily RVV1.0 software performance
evaluation since we haven't submitted MMC drivers to the mainline for
SD Card support.

There is a thing to do: add the USB PHY drivers. Although I can let
High-Speed USB work on both of my boards, the pulling on D+ and D- pins are
not right in gadget mode for another host to detect the speed. We can see
from the factory-patched USB driver, which adds an item pointer to the USB
PHY controller [3] and sets the pulling mode for D+ and D- pins for
different modes [4]. However, the factory-patched USB driver is not the
right way for the mainline kernel to go. We should add the USB PHY drivers
to do the right thing. We can infer these things from the factory code:

- USB PHY Control MMIOs are at base 0x91585000 with size 0x1000. [3]
- usb_ctl3 register controls the ID_PULLUP, DMPULLDOWN(D-), DPPULLDOWN(D+).
- ID_PULLUP is at bit 4, DMPULLDOWN is at bit 8, DPPULLDOWN is at bit 9.
- The usb_ctl3 register is 4Bytes wide.
- For USB0 port, usb_ctl3 is at offset 0x7c.
- For USB1 port, usb_ctl3 is at offset 0x9c. [4]

But I'm too busy these days to add a PHY driver. I would be happy to help
if someone volunteered to do that.

base-branch: [5]

This patch is available to test on that tree [6].

[1] https://gist.github.com/cyyself/f7f2849e6a262b6281687b906e1512cc
[2] https://gist.github.com/cyyself/ea8895012d1035ca5bd3375b798f5786
[3] https://github.com/kendryte/k230_sdk/blob/v1.5/src/little/linux/drivers/usb/dwc2/platform.c#L526
[4] https://github.com/kendryte/k230_sdk/blob/v1.5/src/little/linux/drivers/usb/dwc2/params.c#L195
[5] https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=riscv-dt-for-next
[6] https://github.com/cyyself/linux/tree/k230-usb-v1

Yangyu Chen (2):
  dt-bindings: dwc2: Add bindings for new Canaan Kendryte K230 SoC
  riscv: dts: add usb nodes for Canaan Kendryte K230 SoCs

 .../devicetree/bindings/usb/dwc2.yaml         |  3 ++
 arch/riscv/boot/dts/canaan/k230.dtsi          | 29 +++++++++++++++++++
 2 files changed, 32 insertions(+)

base-commit: 5db2c4dc413e27720b8f567522cd5ebb0bb7ef70
-- 
2.43.0


