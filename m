Return-Path: <linux-kernel+bounces-165010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0DC8B8671
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9EA0B224E5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3034DA14;
	Wed,  1 May 2024 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUGvPhFZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637BF4D13F;
	Wed,  1 May 2024 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714549933; cv=none; b=CGm4qwG031pu8XJLEsKrgobL4YhzjBhFgZtlX2wQPGUrVgUlIkIy+vJct/L0TYDQ8cB4F4Wt5/uK6QzO92aP1qexDAJZsV1OCuG0//bimv8iPM58qi7LchZa3vUs/rLfCFIWbCdCT4NEPHEwmvfv/+T8nknb6TzB+kjpeckjD1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714549933; c=relaxed/simple;
	bh=6DP1CpcEqv5NSAPjBMsu0vTBvBumydwSlw7nTPGBD+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fKa/UjJXzjAGiM5BgFrz3sO5skDhpaFeZFIuR6Se9JowdnknMMiPzeXf1mElvjhppRn7y0NyxMU+sbZUA6MP4H+/wdde0XUN6fke5mlRHFQN/9aNIkWzTYdIi8TAkkOvf9xDDIj4DMuu6bFhgzvs7NPrg6g1CCAYpb0phC4Hj7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUGvPhFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF854C4AF18;
	Wed,  1 May 2024 07:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714549932;
	bh=6DP1CpcEqv5NSAPjBMsu0vTBvBumydwSlw7nTPGBD+k=;
	h=From:To:Cc:Subject:Date:From;
	b=BUGvPhFZ5CmN0ftTHNfGyvAf5qpeJONoguTYFM1AejE+ZouPQkw/bixqXy/4VkbnI
	 MQj07HW/M/DWSM5JMTl3Y9rCKH5zqJgxJtsobgLk+hfFfZo7fZoOCFoOsvMqGCrphY
	 oEXnwaHuTYoBn4TI7TRVtdf4pzF6LnkSsr7JvHg56dbjjAAr7UPOUzFsRvglObQ7dj
	 NuDCc2C0XM6WBqYfJ0Gcy64WXRf8/nMri6dSEvdiiliSt/3+M2Ig2jZa2dzgXkN+jY
	 xBT3aETeNzzBcBObr/B1q91kZnANCms+EAOm8EqYJkHXicfUq7YLt8BFTjBUhLq6oi
	 7QMHFzCvx2quA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1s24lC-000000001En-2z00;
	Wed, 01 May 2024 09:52:14 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: qcs404: fix bluetooth device address
Date: Wed,  1 May 2024 09:52:01 +0200
Message-ID: <20240501075201.4732-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'local-bd-address' property is used to pass a unique Bluetooth
device address from the boot firmware to the kernel and should otherwise
be left unset so that the OS can prevent the controller from being used
until a valid address has been provided through some other means (e.g.
using btmgmt).

Fixes: 60f77ae7d1c1 ("arm64: dts: qcom: qcs404-evb: Enable uart3 and add Bluetooth")
Cc: stable@vger.kernel.org	# 5.10
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 10655401528e..a22b4501ce1e 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -62,7 +62,7 @@ bluetooth {
 		vddrf-supply = <&vreg_l1_1p3>;
 		vddch0-supply = <&vdd_ch0_3p3>;
 
-		local-bd-address = [ 02 00 00 00 5a ad ];
+		local-bd-address = [ 00 00 00 00 00 00 ];
 
 		max-speed = <3200000>;
 	};
-- 
2.43.2


