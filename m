Return-Path: <linux-kernel+bounces-82949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BFB868C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766F91C221C9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442BA136993;
	Tue, 27 Feb 2024 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbunBls5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769C27BAE7;
	Tue, 27 Feb 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025872; cv=none; b=LQwaJf9hySjeSt6cUqnrvRLNUVWbg7ZKWbK0pSN55foD5EuDMIHq09XhJ395zNMs0CCb0JcSj3Z6oYZ2qosro4vLfAse4aGrrxpSQyH8llHtsebuiLOKwJfsOA/bsoh5THX8QkCDl3IKdshtRuMNNius23H24lEDimDBa5B7o0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025872; c=relaxed/simple;
	bh=qWXeJYjYG0Iu2gVtoyFChyerwaz4BDAl6pUAVNJwAyI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PPxYXYcBWVqtVzuG/cydt5svwGtql4AHkivoH5ZGRLeXAqxkwDLGTK2CE3p3HwQLAOlL4hj1lAqhK0n9qZ28rXgB19e4wYr/0plh4hoMPv7toikBM6g+PTLGABiwWU/MQj8lSyEFCvNeZWpfDUmONEcexgrSIL/1CZ2fHDbWUVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbunBls5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED07C433C7;
	Tue, 27 Feb 2024 09:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709025872;
	bh=qWXeJYjYG0Iu2gVtoyFChyerwaz4BDAl6pUAVNJwAyI=;
	h=From:Subject:Date:To:Cc:From;
	b=PbunBls5HB3SN/51UU63RdLqmiFfJYxT9fThuHN/byaMMnC2kiF6JhAr23oKZN8U+
	 tlzD+W4LOb2FBmJLOsExkOwMOSggjLHKXaHSC8qscqWpd+6Q8Av3TZZMWx/co6SmUR
	 V3eihkdp5ToBzo9XSzSjlZ1E+/miD6uiNHRDS3jb9WbXb7g4MhpOmt/tpUvnu2Nv10
	 FBBjMetWYM1RNa520iPOILiK0pyNtw6Ma8gFoOJimkWGbY2fcpICuvaEFWzlS7N19S
	 RKGalgK1ROMao7MIfPet+0ZCmCPoi7kMwGwBAtlNv8xRC9KRiRi/YHGvf2lrBzfUQa
	 6H4ucXU5jHrnQ==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v4 0/4] usb: dwc3-am62: module removal and errata fixes
Date: Tue, 27 Feb 2024 11:23:47 +0200
Message-Id: <20240227-for-v6-9-am62-usb-errata-3-0-v4-0-0ada8ddb0767@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACOq3WUC/32NwQ6CMBBEf4Xs2TWlrRU8+R+GQy0LNCo1W2w0h
 H+3EM9eJnmTyZsZIrGnCKdiBqbkow9jBr0rwA127Al9mxmkkFpIYbALjMlgjfZhJL7iFYnZThY
 VCpRK5R3ZiuoWsuLJ1Pn3pr80mQcfp8Cf7S2ptf2JS/1fnNYo9ZHcgSyVlTvfiEe67wP30CzL8
 gWvwZo8yQAAAA==
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: nm@ti.com, r-gunasekaran@ti.com, afd@ti.com, b-liu@ti.com, srk@ti.com, 
 francesco@dolcini.it, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1196; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=qWXeJYjYG0Iu2gVtoyFChyerwaz4BDAl6pUAVNJwAyI=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl3apL5DmuXLAjol07Uty2PLmZIKZVsiG7CZKEo
 Rt3IEnUJOmJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZd2qSwAKCRDSWmvTvnYw
 k85RD/9HceSMPbvjt8T5xNwY1GjiHk21GjKlrHh6/0irDsQMDqHYVbfYaah8GRynSd+GGyW9tNZ
 SmHzZ3OJ3QMXoIZocJ9dSldrPoAyto/N90Y8OLrcx0vz5YzaT5S0IZSlc4qKOYeIhvFFVI9qwzV
 euenR27I5FvEmist/ZgTvtTuLwp53E+HbSlSwQpOZuF8YNX0GxQBhzNj8qBqUx6xoI0vjTu3ABo
 RfwqTe/dqIVkegGQYwRM9nvbiCbvDxsVbgzMSIJ30CTW1JYQu3yVgJz+04R+QeyzpIdWH6Ie35a
 mMzAmLGXt9gPedsRBK0BlC6C4gNDxHGKSyeu6AU6PwHJZBpEfgY3l6eJoXfB2QVBhviq6kejGWZ
 R2ALn81zjoWd6aoTV4WQBtqNBYBjfSBKzXHzzlfCNIJtw0M/r2KDrzEq8e+kwNL5WmPSkq0TG5J
 +OPVdGrPLT/jtYmNBLrackbe4tiglk5qLt40Ioj7CQJC0Pw2wF8+4r/gdSKJh98FeLwBze0BB5+
 R5aeT0Nd56ZMa4WC0+TbxPxQQ6lfBftBXJXJfbDxursPt8kFg8ndl6vQLs13IdGzN4EMIMaKI2w
 NWsKg9WvIdSIRFJYHb3HGQdivDadDU8AqeLAxFdLiSntUa7kq71nRInn4VcD3h2QAMynLAZIhMX
 /v29G4SmotjsgDg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Hi,

This series fixes errors during module removal. It also
implements PHY core voltage selection as per TI recommendation
and workaround for Errata i2409 [1].

The workaround needs PHY2 region to be present in device node.
The device tree patch will be sent later after the DT binding doc
is merged.

[1] - https://www.ti.com/lit/er/sprz487d/sprz487d.pdf

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changes in v4:
- re-arranged patches into first 2 bug-fixes and added Cc stable for them
- Added Acked-by
- Link to v3: https://lore.kernel.org/r/20240214-for-v6-9-am62-usb-errata-3-0-v3-0-147ec5eae18c@kernel.org

---
Roger Quadros (4):
      usb: dwc3-am62: fix module unload/reload behavior
      usb: dwc3-am62: Disable wakeup at remove
      usb: dwc3-am62: Fix PHY core voltage selection
      usb: dwc3-am62: add workaround for Errata i2409

 drivers/usb/dwc3/dwc3-am62.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240206-for-v6-9-am62-usb-errata-3-0-233024ea8e9d

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


