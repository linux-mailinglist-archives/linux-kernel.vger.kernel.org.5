Return-Path: <linux-kernel+bounces-39137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FEF83CB4D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C4129AE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB12132C19;
	Thu, 25 Jan 2024 18:40:32 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87951350CE;
	Thu, 25 Jan 2024 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208032; cv=none; b=C5DldOBQoBSdN4/H8Gi5JNga3vxUn79g7TXOULBDzhZah6JUDjkQCZrkRB3btuYWI1rLgF0bRtYW4PKa6+esPpqnhgk9bH0idqlPc69LF7WGgDL4JQsnLJ/hjiI48KIT7dVnSUxhc3RC6rDOTpIQ1SpMi8MVm65pSeIsedex2wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208032; c=relaxed/simple;
	bh=TMBpSWKLpMjMxzPR+dvTvMo8w9FIUm4RDCY7BDGWaho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HyeTZHuN5x2amuM8WZq785n2Zjp+CmAHqTV1MULZNd764iirhp/zp7VJ5VnuFyGzl9Gi0R5Em97PYWVGHO20ckyLC1pLmzbqO8T7AMCUD1hi2M3fCqpHUp+x8PHzTOJiivzYRS/t59y/fVljuxCCXP7aIVKBiGxzsIn50xvaods=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 3772082A1E;
	Thu, 25 Jan 2024 19:40:26 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Thu, 25 Jan 2024 19:39:32 +0100
Subject: [PATCH RESEND v2] arm: marvell: Fix maxium->maxim typo in
 brownstone dts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240125-brownstone-typo-fix-v2-1-45bc48a0c81c@skole.hr>
To: Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Samuel Ortiz <sameo@linux.intel.com>, Qing Xu <qingx@marvell.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=TMBpSWKLpMjMxzPR+dvTvMo8w9FIUm4RDCY7BDGWaho=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlsqryADFPoaisPm55ib5yqSTOpCPdo3KP/Bp1a
 cWHoXnSZPWJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZbKq8gAKCRCaEZ6wQi2W
 4XbSD/9zCdTtb1DryZeTTWB9tBEpXMftM9QSS9SFq+MDQfAuluPCT9hKXxEx/b88JAS1foNMF6v
 yXsXr+jcovJnXS0udSjdasQ9YKii2bZO2kTp2/DV3xGMgVDoPKq9l1df5f+WIAuarNcoomSCO/S
 bNo3ukBqnJrjpyi0GSHm6eSxvH/68Y8PzmdhHhqbItCMhXgiwNat8ehaQxibmXlnvmZd1PRb/Ag
 VhU05L2uUMfZZS3W+hSQL72BstAXRL9/iNCEDYvqpAq5icwTScbFIbl12soeOiSaN1WdXMmFc3k
 Uk//JcwnLthKhi/Ii1MudzFnvFrlGsglX+HdowKhWNRcvt2b53PNTu5omsAc0pagXMtTBvvXvt5
 jTbkH6GzAyA9f8uqz8ubpYnSVlFk++gkfdooV9RnSYHD3EdW3VRIU3gq0F0tBmbkZ1qq0X4Aytv
 T0KP44u7aa3gOEjtIkGH9TNIP0SIDxnZndXKMecq5fN+tCCEV+9O23aViDEvAiCsiNWBbSkYRKz
 eWy+YLYTLKnS4kc07a5MfisYB+huJxDfm+Rqg30ZLFjxKVB79H327rr+i/m/MiwSUGJDILdDKd8
 D4Jih2BWZuuOgdGkebn6eWGglh1/5C5fWKOTbatqNK6Xvwe7k5dHsNSsTZ/FD5YrrDiTbkakrLC
 WX9zUc6HYlqmH7Q==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Fix an obvious spelling error in the PMIC compatible in the MMP2
Brownstone DTS file.

Without this, the PMIC would never probe.

Fixes: 58f1193e6210 ("mfd: max8925: Add dts")
Cc:  <stable@vger.kernel.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Changes in v2:
- Address maintainer comments:
  - Add Fixes: and Cc: tags
- Change "for" to "in" in subject
- Emphasize PMIC's inability to probe without patch
- Link to v1: https://lore.kernel.org/r/20230804-brownstone-typo-fix-v1-1-4832d84c0509@skole.hr
---
 arch/arm/boot/dts/marvell/mmp2-brownstone.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/marvell/mmp2-brownstone.dts b/arch/arm/boot/dts/marvell/mmp2-brownstone.dts
index 04f1ae1382e7..bc64348b8218 100644
--- a/arch/arm/boot/dts/marvell/mmp2-brownstone.dts
+++ b/arch/arm/boot/dts/marvell/mmp2-brownstone.dts
@@ -28,7 +28,7 @@ &uart3 {
 &twsi1 {
 	status = "okay";
 	pmic: max8925@3c {
-		compatible = "maxium,max8925";
+		compatible = "maxim,max8925";
 		reg = <0x3c>;
 		interrupts = <1>;
 		interrupt-parent = <&intcmux4>;

---
base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
change-id: 20230804-brownstone-typo-fix-f5b16c47d865

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>



