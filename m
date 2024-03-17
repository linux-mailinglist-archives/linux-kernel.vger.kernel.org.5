Return-Path: <linux-kernel+bounces-105356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3D187DC9A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 09:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A43F0B21180
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 08:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434B51170F;
	Sun, 17 Mar 2024 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="ODLGbW28";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="WIRMpSdU"
Received: from fallback13.i.mail.ru (fallback13.i.mail.ru [79.137.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF20A4C9B;
	Sun, 17 Mar 2024 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710664555; cv=none; b=YKH4tFCoJlQX2yjvDWGtGqLK3U96QhWpLO+T8JF5PpqO/9AxcO+TeBhwZ5KGKfqa3s+rvxoVMk8oFdHN1iLzFRPYsXRvLEBe1D6XbuGIlvMWjvvauuutM1DCSpz8ALsJDsMwN2dcO9Pf6ji4dh/xeL+Zv2/YQfvxuamFVDzyvXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710664555; c=relaxed/simple;
	bh=7E1x3Pit6kK0R6/hxJ/eUTs7x+9jBa5poEPF307Zju4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kvLmu0xjrFV2pZFn8t+NUoqtJPrYJdw3+Ytxg5RDNqFVDA4pBpNkkQ5RXbHkE+kS7nBmBXwxB53A1VYQSpFybIJH0Bao0qkmSPld1GGbChfxFozMdSk0j2AJp3789DG3QY84K65+rlhjKhyhqojZy8+Ulj3qeX6KD0OJ+xiDRpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=ODLGbW28; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=WIRMpSdU; arc=none smtp.client-ip=79.137.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=C2bvG1Uwgvum8U6oSn2ZFXWtD2RHh6nI4Y75MT72qYI=;
	t=1710664552;x=1710754552; 
	b=ODLGbW28VGC2zWK21rb5gX6sE53yT14QtwaHXbMaadFBcy/mJp94MR4MD5LWKyXG7wfLvvBhZ0eM3ppcf+7JT6VXmpMgY1/Wyl0revifdqyjDTdWLyiE8YvkGLdl5NoUeOJKRsg8Eil61+XQ4BVXOJHcwVEcvW5a4YjWSfTVN+4p+GwtMMy/ruuqhTsn/ceW7+VD+WCPA6Ei7BFEOuqVZn4kt75wAQK/w66gJ5eNdL0e6encfoDrZyyYAI9ZDt5gBrRtWgrvX9oVWfjLushs5RZq2I6WWqAMaxhoSRJctjCFP8ErDxz3+dpcIRRvwY+H/PgaJgmUeCAbe2B53W+LZg==;
Received: from [10.12.4.21] (port=33312 helo=smtp42.i.mail.ru)
	by fallback13.i.mail.ru with esmtp (envelope-from <hitechshell@mail.ru>)
	id 1rllzd-00CMRq-3c; Sun, 17 Mar 2024 11:35:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=C2bvG1Uwgvum8U6oSn2ZFXWtD2RHh6nI4Y75MT72qYI=; t=1710664545; x=1710754545; 
	b=WIRMpSdU3yd9iobJPBB7UycpPVMSxJFZRb48yb9a/jYq5G53fYt6+hfuB3sZLlZnbnTK+r7BbP5
	7aqEl35C47O6Xud3gQBR3ExCoP9veFOQATfUYvHL9f21PS3XMirKMz50T1WuKH0YFdKD1/Q6zfmLd
	f8iI6dRguvdXHbJ+tWcgUcjmyoEIWn1QCiwNJirY3OM88y565iyow4IN9duncQqW9bHLB7QHZemMU
	2LhXFYfbxz/DuatAEFxrR2t1IaJQHhsD5zhZmwfQeVHtUDtR6R6h9mDRrSfHWL27jcfx/2FvQMN9Y
	PTnifunrbfEWI0N5Pn8hy+oYPg6Kd2f9+3iQ==;
Received: by smtp42.i.mail.ru with esmtpa (envelope-from <hitechshell@mail.ru>)
	id 1rllzO-00000003bZW-24ML; Sun, 17 Mar 2024 11:35:31 +0300
From: Denis Burkov <hitechshell@mail.ru>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Denis Burkov <hitechshell@mail.ru>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: sunxi: Add PocketBook 614 Plus
Date: Sun, 17 Mar 2024 13:34:44 +0500
Message-ID: <20240317083445.4668-1-hitechshell@mail.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD987C0EE6E7F0A597D14B510CDCFC426C47375EECC9EF82252182A05F5380850401171797352F077CCA6D5EE0DB6E1EC8D60CD3A9F334C475CE73681F7A7D763F8A02D50AE20F21E99
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7C6068CE86C2B75F5EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637B20ACC28402695E48638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D82AD850D6F1F0A484DF8A4F223E113580CADACAB2DDE3873420879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C058C1844A7A85E7B68941B15DA834481FA18204E546F3947C457EE4B4996FC546F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637B18CEC08E50EEB57389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F79006372E2E0CF213AC68ADD81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE731DB45BFE237DA1FEC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5278DA827A17800CE7A03E8F3C2D3812562EB15956EA79C166176DF2183F8FC7C0E4A630A5B664A4FF725E5C173C3A84C3F318ED4C9C90B29A35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5C4E5BBA5B41A5FAB5002B1117B3ED6969C9E915D873D5F7CA9DAB4B68AE4D22F823CB91A9FED034534781492E4B8EEADC0A73878EBD0941BC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFE342053CE1402531FE4D53C944477A16C17A370CEFEFECD371D802F178C025CEF62474FBACD619B06CD0533D1BDF67EDBFE8104F530FDEE61086B51C93BC5CDCCB31759AF00544ADE4FDFA4A036B0C3902C26D483E81D6BEAB6E9BFA52983102758FA77D78A604EFC3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojpAzVD49/gcM5XnRRRxGIiQ==
X-Mailru-Sender: 4504732FDC166E0E21A896EFB29DF0C90F95B987A6AB5E38A6D5EE0DB6E1EC8D60CD3A9F334C475CA165F1893FAC5C757035CE191D947B125A92E71CC7C3152D68C1C4E17AB7C113897BD3F63E44C176075AE25EB8835B0E4F1F69ACE5C499A7A0577211E31DE16C327D77830F209D780D4ABDE8C577C2ED
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B485448333635D8AFAF2FD4A3C9FF394F59934010964AD860B049FFFDB7839CE9E3B76AC3706630B51D7B4E5E724E77A0749393DBEF992D08E8DDC5EEB2C396DF0
X-7FA49CB5: 0D63561A33F958A5CE2390E67E47AD4BCFF3321AC6F65BDC7E3194F9B69BAC56CACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F7900637CBA2F893EF2800639FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C342E5C09891E4E6C3CC7F00164DA146DA6F5DAA56C3B73B23C77107234E2CFBA522CA9DD8327EE493D1AC325EA934333D6A58BF81F659395FC4224003CC83647689D4C264860C145E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojpAzVD49/gcPmpGYHCWN8SA==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Add a new board name.

Signed-off-by: Denis Burkov <hitechshell@mail.ru>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 09d835db6db5..43491e7f8a5e 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -774,6 +774,11 @@ properties:
           - const: pocketbook,touch-lux-3
           - const: allwinner,sun5i-a13
 
+      - description: PocketBook 614 Plus
+        items:
+          - const: pocketbook,614-plus
+          - const: allwinner,sun5i-a13
+
       - description: Point of View Protab2-IPS9
         items:
           - const: pov,protab2-ips9
-- 
2.43.0


