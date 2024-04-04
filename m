Return-Path: <linux-kernel+bounces-130770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A6A897CEA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD8E28C5D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E50B14292;
	Thu,  4 Apr 2024 00:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="llwp11bv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JJ3U6K1D"
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730A914290;
	Thu,  4 Apr 2024 00:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712189852; cv=none; b=eZjllGyCaJM4ci4OzZjJumCmCPG48xukglZcBR2iN/2c2ri0XHwXPntShVSj5kzG6KLX1L0wj0DJt0E2zvgViPe0OZLWlV9RPvpKRCMzn4Bloj3vopyhEp5uKB0gdQqS825npuLYduBff4gdTmReoXmnUfjEwteSKq7QdPU4Cc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712189852; c=relaxed/simple;
	bh=l+urmTucqsDaN1OqRf60e72kkzCF9DKrlY4Vt9xB01s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qb1hheZYYiX3Jf4deFPtnVKGOKMm73g7xErXcxx+Fp0Q/Hjgpj5K/OrIViQZWu1ojmbwSbtE4xKmsfMKfmoeKsvWcw42wXylMHHFcAtk8B8zNBMfjpyGJRvxV/MXwwFQchdbyH9IOSCBibm4K9cgPTbmj2eisSZVT8Gf868gmQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=llwp11bv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JJ3U6K1D; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9D9B518000C8;
	Wed,  3 Apr 2024 20:17:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 03 Apr 2024 20:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712189849;
	 x=1712276249; bh=52HgFVs0jtkjYiVKyD0T+9/xaIFl0PeY3ojaOnzkf3U=; b=
	llwp11bvQVe0Q4ypNXQTg2xTA9fnYvLvMMyTx7r0i4OfOpLv3Acas9E6D65QCteW
	PvwqOkghc8e07odrk1yjaws4Sj7j1OnHivkvj8dHpoiCaVFEChsGAXbx2GrNMz9l
	w1OwmHrl5H3aMcPKbde4SARSRY53anzO3QEJ4TfcBMdcoZLRypC+OlDF2UlZbYMs
	xnVVU4zqx2uU1QHskPwBe44Z40PDB8zbkoqWBLv7u8SFrfVZKuoZzSC6/1qQfxt7
	daSGcYCgXFJXzQoJD8SlPvJKTXkvEvsG2fqVX4vEmNm9C09LU0OKYqx3AMl4zXvg
	4yNdmBhmnEEsYikP5zpLSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712189849; x=
	1712276249; bh=52HgFVs0jtkjYiVKyD0T+9/xaIFl0PeY3ojaOnzkf3U=; b=J
	J3U6K1DKOaTHXD/VTq2bZo6FslQGCEV7OMiWQfas9KPXOLUdzvd8xIYcoCOXDX+p
	qotP+qzT+4nASmvXVeW7TD4Lg6y4tnTAg5Nh1qhfAz0vb+6+KTe91I9I3pHssGmd
	+4BVLckK2/YhGxEOd1smNoqGouweVhbJXoAQFaOOZObeFs1j0utm9krdnyupYVxB
	2P6LiSYwvq+2rh/nKayEigKRpU5arNf76qlDR6LFrH8vSImazRipnDq92YIeVG5m
	duvh6JKJy2KKLO6NSsWUmH2q55hLknf+KBIJFhSD/G1KAQLlD7mK8RD3uBJ7QXQf
	JTTwk3VEadW7JdPt77wig==
X-ME-Sender: <xms:mPENZuaWBajeTcGclElYiuafyB4NXnKassXL-iPCh37bZkNfEBnipQ>
    <xme:mPENZhYA8meIsjhToYq5Gk3gbUCEj2AUJ7M7VsgeYSYUSRjUz3dNI3rHCqZDAVAaz
    mDz7FauQPSmbr4uWag>
X-ME-Received: <xmr:mPENZo8lxs1wcJxffEckTmCNriCtb5jwCJ9JYpqwJ7TWPO_big6VZUGVFZ2K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvges
    lhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeduudetudehiedvvdevveelhf
    egkeefffdvfeetuefgveefgffgffeiffeitdelieenucevlhhushhtvghrufhiiigvpeef
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:mPENZgrk04nJK50oHiZkj7ELCyLmPpcRbfK3wi9vGDM_w1ph8z5nQw>
    <xmx:mPENZprYlC9l26RkezzwUMILxWoRgtoLNFnjvQ3iB9iZJ2Poof1gHg>
    <xmx:mPENZuQx2bdg7b3Hx7E4yExbENoD4RlNEZX3vZucoQspZkT69ToQcw>
    <xmx:mPENZpqnGpNK5Foj822VJ0eBa3EzwJzbuhfBknWIT2U_EpiucZzdaA>
    <xmx:mfENZqeBPgBNivLFUAQTH_9ozT88qTatOO9cSImU2_qtHRaI3ZH5JeLl>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 20:17:26 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v4 6/9] platform/x86: asus-wmi: adjust formatting of ppt-<name>() functions
Date: Thu,  4 Apr 2024 13:16:49 +1300
Message-ID: <20240404001652.86207-7-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404001652.86207-1-luke@ljones.dev>
References: <20240404001652.86207-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Shift the call to dev_get_drvdata() up to top of the function block
in all of the ppt_<name>() functions as part of a minor cleanup.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index f13606fc62e6..976e26c82f80 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1008,11 +1008,10 @@ static ssize_t ppt_pl2_sppt_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result, err;
 	u32 value;
 
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
 	result = kstrtou32(buf, 10, &value);
 	if (result)
 		return result;
@@ -1052,11 +1051,10 @@ static ssize_t ppt_pl1_spl_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result, err;
 	u32 value;
 
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
 	result = kstrtou32(buf, 10, &value);
 	if (result)
 		return result;
@@ -1095,11 +1093,10 @@ static ssize_t ppt_fppt_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result, err;
 	u32 value;
 
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
 	result = kstrtou32(buf, 10, &value);
 	if (result)
 		return result;
@@ -1139,11 +1136,10 @@ static ssize_t ppt_apu_sppt_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result, err;
 	u32 value;
 
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
 	result = kstrtou32(buf, 10, &value);
 	if (result)
 		return result;
@@ -1183,11 +1179,10 @@ static ssize_t ppt_platform_sppt_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result, err;
 	u32 value;
 
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
 	result = kstrtou32(buf, 10, &value);
 	if (result)
 		return result;
@@ -1227,11 +1222,10 @@ static ssize_t nv_dynamic_boost_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result, err;
 	u32 value;
 
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
 	result = kstrtou32(buf, 10, &value);
 	if (result)
 		return result;
@@ -1271,11 +1265,10 @@ static ssize_t nv_temp_target_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result, err;
 	u32 value;
 
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
 	result = kstrtou32(buf, 10, &value);
 	if (result)
 		return result;
-- 
2.44.0


