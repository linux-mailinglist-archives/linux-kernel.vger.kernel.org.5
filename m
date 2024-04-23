Return-Path: <linux-kernel+bounces-155303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F978AE88D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774691C21FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8736113BAE2;
	Tue, 23 Apr 2024 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xi4eqHs8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6271369A8;
	Tue, 23 Apr 2024 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880012; cv=none; b=A/U8kVQSxtpeBgX52MoYlH++2TxZYx5rVek4cuTG7EqbFdm18wjpomAdOf9tA4gSVKprX07MbtRNu1alnqg0+M7kkw2bg2qGx8daH7ibbdXtx0I8ZI4Bm9d4JKzxkcqZ+fOwUTOkLMFB23qISNYBnbAJYRkfJOkdH68bJoGs5+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880012; c=relaxed/simple;
	bh=57AUgmWZZPSkewtMIOcTfHR1ByUp86J3e5693409NdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbnUsS+mJ6taSBp5lz4MO4gj7YYheGm2pUe9o3xUk6hRDWCpZM/m1kembLSmz4keQB52DYuzZ6iQBKhAnO1vECWucPwOCY7trUPVVfn/4FN4XNMvW+wLK+0Ua96FMpaLuEIbqQqozYrRAv6wy+bFp/H0Gy2/iraQT/CEQkJqqkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xi4eqHs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F18C4AF60;
	Tue, 23 Apr 2024 13:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713880012;
	bh=57AUgmWZZPSkewtMIOcTfHR1ByUp86J3e5693409NdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xi4eqHs8aOghaj81YHDiBaS+QrS5jlIF07O6y608L33yNXVu7DiSv3CSFoXfTWQAj
	 9zle0Ennl+k1ZQqAQtaAyhGtDisY2FmTRAzqr/GUo8CV9+xkt4uGECyBz45FfNAZi2
	 7QYr403cUxxkH6uBS62uAeLuphDtkEcLuVPR+r/xJ4L4TOKG89VSKu1+mKrzwC/ZK5
	 jUTOs6xf8Z6O+F3XyVtZ4WQW9xJEt58GSEn23kkEWYKYtNzQj9tPIFwTbHyOKztvN4
	 z5wdXV0W43XA4tvBuXkRkvW1DRD6awovTsixcs07c+TL83dAcatmZJJmLV8PGWuHpq
	 jqrhYXAk5cnTA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rzGTy-000000008Kq-27Dq;
	Tue, 23 Apr 2024 15:46:50 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 6/6] arm64: dts: qcom: sc8280xp-crd: use external pull up for touch reset
Date: Tue, 23 Apr 2024 15:46:11 +0200
Message-ID: <20240423134611.31979-7-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240423134611.31979-1-johan+linaro@kernel.org>
References: <20240423134611.31979-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The touch controller reset line is currently not described by the
devicetree except in the pin configuration which is used to deassert
reset.

As the reset line has an external pull up to an always-on rail there is
no need to drive the pin high so just leave it configured as an input
and disable the internal pull down.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 08b3627049bc..68e70c983c94 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -1014,8 +1014,7 @@ int-n-pins {
 		reset-n-pins {
 			pins = "gpio99";
 			function = "gpio";
-			output-high;
-			drive-strength = <16>;
+			bias-disable;
 		};
 	};
 
-- 
2.43.2


