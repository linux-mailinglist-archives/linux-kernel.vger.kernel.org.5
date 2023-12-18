Return-Path: <linux-kernel+bounces-3758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D684B8170A2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85236282B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B458E129EE3;
	Mon, 18 Dec 2023 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="PC6JJ39J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71290129EC2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1702906789; x=1703165989;
	bh=oFxiJsLYp9oMwSWHBY7gyKETjQXSFfN8A+P1KnZ/vZI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=PC6JJ39JhDa6cJ6u4SaoAzug2jN0BUgwIF1DovUZLNPXNDVY/f42/FHiI+KsAu/Nn
	 BIVOCG4MsnvTumx/MGrlexVwCaCobnkPRlz5Okpqfho6N3G9I9H7bkyUTWVGLkRXYU
	 3NwMHnnYX0GrwgiYzycnvDCzpSDexNSTOccIhwAiraEzOssfYP8SwhMtJoSNxjVY2D
	 4W6tJk9L+2pO3lmS0xoX0iHI90OLwxlUCAQx9cuTSPI2ZK6xTXhwzcOicdOtDHz6xq
	 NwINVDY1n8nXAqKwTA3iP6F8RaIsjQ92eM1oL7TjwQfGuVRp3UFEveOnCwrXOxuoed
	 lnzbi0e9BHJKw==
Date: Mon, 18 Dec 2023 13:39:42 +0000
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
From: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, Yassine Oudjana <yassine.oudjana@gmail.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8996: Define UFS UniPro clock limits
Message-ID: <20231218133917.78770-1-y.oudjana@protonmail.com>
Feedback-ID: 6882736:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

These limits were always defined as 0, but that didn't cause any issue
since the driver had hardcoded limits. In commit b4e13e1ae95e ("scsi: ufs:
qcom: Add multiple frequency support for MAX_CORE_CLK_1US_CYCLES") the
hardcoded limits were removed and the driver started reading them from DT,
causing UFS to stop working on MSM8996. Add real UniPro clock limits to fix
UFS.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qc=
om/msm8996.dtsi
index 13667886f50a..4f9939b13c3c 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2064,7 +2064,7 @@ ufshc: ufshc@624000 {
 =09=09=09=09<0 0>,
 =09=09=09=09<0 0>,
 =09=09=09=09<150000000 300000000>,
-=09=09=09=09<0 0>,
+=09=09=09=09<75000000 150000000>,
 =09=09=09=09<0 0>,
 =09=09=09=09<0 0>,
 =09=09=09=09<0 0>,
--=20
2.43.0



