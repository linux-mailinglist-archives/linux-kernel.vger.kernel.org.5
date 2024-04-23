Return-Path: <linux-kernel+bounces-155890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EA88AF89B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DAB0B29DFF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24A2144303;
	Tue, 23 Apr 2024 20:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9vQ8df2"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7357614389E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905574; cv=none; b=YBYVf5spN5Ho7FDD1r3cDBt9GOG5TNU9u0+i9odEAvFmIz7KByAyLKCl0d47CJ9eTdOHZCPsF7kZ5Lc0daplP00ybPww3DD46zr2qIU6aCkXIcDcB5/3XV7hZVCJH/EBfyMhXTP7uFO7z36XZQFIrTWf418GnQljJafLvTW/CzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905574; c=relaxed/simple;
	bh=agoaO+yLgcCTgSTMLIJU2ZqfpAxYpRgRuzhSrnmExVE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h2jBQzxhW27qtzm+OdwUorwrjg1VXeAo1/bw6I811savfQPwGKpwnm1NP+5/7DW5eVvbg20jJJEexZniBcyZHeLdeppXvscToZTRes9/S0PchqjIqq5xZm+VnMl2tIPyZcFcrL6HifSmrq0vw1jYeIGGKdLw0iNbzUS7TGmxbtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g9vQ8df2; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a58872c07d8so53666266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713905571; x=1714510371; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=enKb/FePM63duYlRqV9Qk3Sv4AxdpT2UptzUIV9J624=;
        b=g9vQ8df24kKpLTwa2JI+wacBBhqNdnYNi+jciZTQKMm+zfrnhITsCqsZvgwR12z4z4
         nPrd5aNd7zrkl9VK4ACYjHSwILC2SSzERf+6sSgrxOiMO1sUxoo+zYd+SK4kM06q8+27
         H5TV7ROjtuRQOZxfnb7c1LwgOWbPqvyq+uQQ74XoHHdbQt7Kne0xURe4ydFiAkGovcdO
         LvSx18QfXsj3rt9RoDX4FROwmyr8499NMgY5mYC7VO2i9pLMWmYc8dvx0+msfbZ7e3ko
         RTMTJ9R1UUChp8YG3cVENf+4TWrkGw5Jwlyo3CBs5agfk5OacfQ7kmnfPeRoHJNZBncC
         Nl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713905571; x=1714510371;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enKb/FePM63duYlRqV9Qk3Sv4AxdpT2UptzUIV9J624=;
        b=PdJS026T9HpKbtj9fLWECHsdOPK4FYfI3gOh2GFw6j4Qk6d4Z0Fum6/HfhljJq54io
         FC4urJbkMGtTFhT7SskSm+xY4A+CC5rmIqT3iVmQupsh9XWgSHez+CGKIgbT322FSemK
         wRYrtCk1Qn/Bo7DNhyTlE0m3TvSB1L/GJliO1QxpKmYZV5HqqLniIMBnY7knEHFMYW2Z
         50RGpiMAQ2msPmw8zXmiDZWWH3Eb5EViqWC7IwhscTq+nsShHN69uTo41xs5AkYPNOEa
         4cjM5gYzEvTFLAYJdoPsswroIxTWIJSh/pfVENKHoG+loz2jqbO69yencQ3zNpVgdzo2
         OY7w==
X-Forwarded-Encrypted: i=1; AJvYcCWeIDLMEYLIRCaWxrrO/9W3PTbV/95MzgNGZWqRAciLv6LgvOt+LgUKPCJBmnWYh0S+h1K0OHW/G+QXJ1y9dZCuB7UCVrZlo4Mx8TZ0
X-Gm-Message-State: AOJu0YzBbPwIz3cTkLSW5d7PHpHHlwTV7w4vJLejZyYJrJpnm8FcAFTG
	hhySsluiR5prJ1lI68dpz9WmWlROToo8p5GTDnbH8IAiOYaOGFeAUnrp1QNVERE=
X-Google-Smtp-Source: AGHT+IE5ZEFfPw9z6hVQ6KJ4VDfJlUP0PDE9gbusrIEU5+zuqqJGyyYKlrOwD4UvxqV9eS82lWjsuw==
X-Received: by 2002:a17:906:30d0:b0:a55:aded:200d with SMTP id b16-20020a17090630d000b00a55aded200dmr533206ejb.12.1713905570797;
        Tue, 23 Apr 2024 13:52:50 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id ww4-20020a170907084400b00a51d88e6164sm7443632ejb.203.2024.04.23.13.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 13:52:50 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/2] enable USB on Pixel 6 (Oriole)
Date: Tue, 23 Apr 2024 21:52:47 +0100
Message-Id: <20240423-usb-dts-gs101-v1-0-3421b0371298@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJ8fKGYC/x3MQQ5AMBBA0avIrE0yrUbDVcSCGjUbpINIxN01l
 m/x/wPKSVihLR5IfInKtmaYsoCwDGtklCkbLFlHzlZ46ojToRjVkEFn64bJeB9ohtzsiWe5/1/
 Xv+8HWsKQDF8AAAA=
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

These patches enable USB in peripheral mode on Pixel 6.

We can only support peripheral mode at this stage, as the MAX77759 TCPCI
controller used on Pixel 6 to do the role selection doesn't have a(n
upstream) Linux driver. Therefore the role is defaulted to peripheral
without any endpoints / ports.

For the same reason, we can not detect the orientation of a SS USB-C cable
and therefore it will only establish a link in SS mode in one of the
possible orientations of the cable. In all other cases, the link will be HS.

This series has a dependency on other patches, please see below.

I have mainly tested this as CDC ECM Ethernet device using the following:

    mount -t configfs configfs /sys/kernel/config/
    modprobe libcomposite
    modprobe usb_f_ecm
    mkdir /sys/kernel/config/usb_gadget/g3
    cd /sys/kernel/config/usb_gadget/g3

    echo 0xadad > idVendor
    echo 0xddaa > idProduct
    mkdir strings/0x409
    echo 01234567 > strings/0x409/serialnumber
    echo ADADAD > strings/0x409/manufacturer
    cat /proc/device-tree/model > strings/0x409/product
    # create the function (name must match a usb_f_<name> module such as 'acm')
    mkdir functions/ecm.usb0
    # stable MAC addresses
    echo "6e:27:3a:b9:40:87" > functions/ecm.usb0/dev_addr
    echo "ca:49:84:b0:3b:bc" > functions/ecm.usb0/host_addr

    mkdir configs/c.1
    ln -s functions/ecm.usb0 configs/c.1/
    echo $(ls -1 /sys/class/udc/) > UDC

    ifconfig usb0 192.168.1.2 up

at which point the other side should detect it and network communication
becomes possible (once the other side also configures its network
interface).

Due to the clock IDs, this series depends on the bindings patch
"dt-bindings: clock: google,gs101-clock: add HSI0 clock management unit" of
the series in
https://lore.kernel.org/r/20240423-hsi0-gs101-v1-0-2c3ddb50c720@linaro.org

The bindings for USB and USB-phy have been proposed as part of:
https://lore.kernel.org/r/20240423-usb-dwc3-gs101-v1-0-2f331f88203f@linaro.org
and
https://lore.kernel.org/r/20240423-usb-phy-gs101-v1-0-ebdcb3ac174d@linaro.org
respectively.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (2):
      arm64: dts: exynos: gs101: add USB & USB-phy nodes
      arm64: dts: exynos: gs101-oriole: enable USB on this board

 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts | 24 +++++++++++++
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       | 41 ++++++++++++++++++++++
 2 files changed, 65 insertions(+)
---
base-commit: a59668a9397e7245b26e9be85d23f242ff757ae8
change-id: 20240423-usb-dts-gs101-4269e0177c0f

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


