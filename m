Return-Path: <linux-kernel+bounces-119732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA4B88CC80
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2E6309EE9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057BC13C69D;
	Tue, 26 Mar 2024 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnQb6l4o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF6713C692;
	Tue, 26 Mar 2024 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479444; cv=none; b=chHVwdd0/aW+zCygAqdrzfyHLXdVbPhZpCT0CvY508k1AkEUiPl+jISudFrR9m7d5tb5dW/z8G5h8NO8uKCI/DkAyyRXxVZymRZ4YIszNvKTzqKPgN3GGghJ19oyAtP59eJZGSerLClph/al84CEl2HADWMI+T07Q8FS+AcVhJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479444; c=relaxed/simple;
	bh=G6mc0QUGBHLFWSqnsGqxmIC8vKxJ1zCnaOScx8J3TQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cD7C+nkRbfYZ2qFmXvfg4+KUAnQ/Lzj4208IKCnM9gf8zZK+xE9GKQifb6/qwCimfCPh8vieoOPmz54nNO557u02n1gjedpBXqBG8om8L2wjM/sOZfqYjVbCtTAxIHJNHLzrlOqAJMYaoMlGg3Wsr4HVuB+KaM0EMQoAtbAL5kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnQb6l4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB434C433B2;
	Tue, 26 Mar 2024 18:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711479443;
	bh=G6mc0QUGBHLFWSqnsGqxmIC8vKxJ1zCnaOScx8J3TQA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UnQb6l4ori1UnlnKacvSGErLo7U07JRCVt2nPfBNLMm44T/m7r57d0/k0u/sid38R
	 lEBu8yksww/lt7cmBkm/FqLKSnNQHHiZjpLyWFP2PCCwAX55oI4Dn9SvCwc8eDbZks
	 tMtGccHuh2dcIaWD3CNx7FELxVrUOBZJiF3z9WFPTiNPxMoZ0cW38iyNa2NHdF2CYf
	 288bUFgzLAy7EVmpyhht7M8tIz9Vqa6C2VBSDZNWLpVFTJY4atccQGkgXXWpG1mDi0
	 Ttv6Sl53VFMqMWxl0rmjxgw8/M3ISM5SW1GT4n1Nhv1F+LrX3GzLQWLCEskDxWSRYF
	 vjNMsFjrJGcIg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C739FC54E67;
	Tue, 26 Mar 2024 18:57:23 +0000 (UTC)
From: Folker Schwesinger via B4 Relay <devnull+dev.folker-schwesinger.de@kernel.org>
Date: Tue, 26 Mar 2024 19:54:36 +0100
Subject: [PATCH 2/3] devicetree: phy: rockchip-emmc: Document changed
 strobe-pulldown property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-rk-default-enable-strobe-pulldown-v1-2-f410c71605c0@folker-schwesinger.de>
References: <20240326-rk-default-enable-strobe-pulldown-v1-0-f410c71605c0@folker-schwesinger.de>
In-Reply-To: <20240326-rk-default-enable-strobe-pulldown-v1-0-f410c71605c0@folker-schwesinger.de>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Chris Ruehl <chris.ruehl@gtsys.com.hk>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Christopher Obbard <chris.obbard@collabora.com>, 
 Alban Browaeys <alban.browaeys@gmail.com>, 
 Doug Anderson <dianders@chromium.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Jensen Huang <jensenhuang@friendlyarm.com>, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Folker Schwesinger <dev@folker-schwesinger.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1613;
 i=dev@folker-schwesinger.de; h=from:subject:message-id;
 bh=lYZfvZDtpySgOOqOAfgoLZ9THvZvx3kUJVgOxDEo5RE=;
 b=owGbwMvMwCXG5FBoZNu1u5bxtFoSQxqz1KSXEXPm32GZ9Ic3tF984fKDer0GAtunykV0cP6yz
 H7bbzOzo5SFQYyLQVZMkYU1L2MLc2b5Uuuun69h5rAygQxh4OIUgIloiDH8M3MoEvsnn9Sap6p9
 m/mcrMz8Y3p7k5le/NnupqBbaKzYzfA/8b/SW42WBQVnEx5bsJ+P/fN+1SF+002WnFemZ19pzyr
 mAAA=
X-Developer-Key: i=dev@folker-schwesinger.de; a=openpgp;
 fpr=056E68B4036977A53B8AF9EB024071323D8ABB7D
X-Endpoint-Received: by B4 Relay for dev@folker-schwesinger.de/default with
 auth_id=144
X-Original-From: Folker Schwesinger <dev@folker-schwesinger.de>
Reply-To: dev@folker-schwesinger.de

From: Folker Schwesinger <dev@folker-schwesinger.de>

Document the changes regarding the optional strobe-pulldown property.
These changes are necessary as the default behavior of the driver was
restored to the Rockchip kernel behavior of enabling the internal
pulldown by default.

Fixes: f34e43f12382 ("devicetree: phy: rockchip-emmc: pulldown property")
Signed-off-by: Folker Schwesinger <dev@folker-schwesinger.de>
---
 Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
index 57d28c0d5696..10c05437f7ab 100644
--- a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
+++ b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
@@ -16,8 +16,8 @@ Optional properties:
  - drive-impedance-ohm: Specifies the drive impedance in Ohm.
                         Possible values are 33, 40, 50, 66 and 100.
                         If not set, the default value of 50 will be applied.
- - rockchip,enable-strobe-pulldown: Enable internal pull-down for the strobe
-                                    line.  If not set, pull-down is not used.
+ - rockchip,disable-strobe-pulldown: Disable internal pull-down for the strobe
+                                     line.  If not set, pull-down is used.
  - rockchip,output-tapdelay-select: Specifies the phyctrl_otapdlysec register.
                                     If not set, the register defaults to 0x4.
                                     Maximum value 0xf.

-- 
2.44.0



