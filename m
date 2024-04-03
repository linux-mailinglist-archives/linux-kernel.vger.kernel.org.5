Return-Path: <linux-kernel+bounces-128879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8841689616B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8971C22FA7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035DB1BC37;
	Wed,  3 Apr 2024 00:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="JCXBOTNF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TOdPx2VN"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3E199B4;
	Wed,  3 Apr 2024 00:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712104187; cv=none; b=fRhPaF5oz2sRqUnYt+M71JVrzJQbj1jMUHfRqQf7Q3MCSbdzfUDB+sT9mi54VC2aKhHK3nE8hW433NbD882kjYb2zWtf/2ZEkHGsDw0uZK6YQCfzqwJJGyeqi8ldC0a4UpTVhRoegfSb789X4Fw9XGGLIUuCc+M8NsDom94qoIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712104187; c=relaxed/simple;
	bh=NRq9T9dTBGop8ST/HCJTvuOwuOGjuthRTQcwuxHAPBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJrYKZLiFVpb0IfgcjEj4yiO3CV6rf4xg/StU4OaZwUwfYsELETjB8VHeFBT+ui55VT6698LgoJvZjjo1mkQSs2ZD0zZGl/ZjxCbgUV38sgLoRUYU9prq3f7x06cLvH3Iv0hEQe5Hw7DIP+L0mrOBNHGMfurgS/Hs1jwsylK5xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=JCXBOTNF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TOdPx2VN; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 619F313800D4;
	Tue,  2 Apr 2024 20:29:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 02 Apr 2024 20:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712104184;
	 x=1712190584; bh=dcJf/uhZRGW+ikiB54OFQL0MBarFcEONBJk1uxSQBNw=; b=
	JCXBOTNFLYPRyAj9FGRoLLMsJJdjzU/3uop4Yad6aALyCV6IqV8d/XpfLLNN3z4N
	0Uc43J+qInfUCHqvrTTNVrM0hymqK4c+Ah6JYAq8eINqXP5jum+gm5VC67lIKG/D
	Ra+GlJYVZdX81ccPhI515v/KnSyk+cBLzjnSl456BHtCrUl4ZNLDk33LrSb0AsO1
	/Nw/5Hp5vkAi6nnbsQHoxybLjDi+bVRkYJJJgNxfE3NWBCIvS5LDagAbiwrOQBB6
	3tEZaHTQOq5zUQgvLQ06c5ZA69TLyhOLISEXPSYdFkPqNi8uOO6jjvlhAdjFpSC5
	ecjYYnueemPrFuMKQprlkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712104184; x=
	1712190584; bh=dcJf/uhZRGW+ikiB54OFQL0MBarFcEONBJk1uxSQBNw=; b=T
	OdPx2VNJpVSXGLk1kL6Mhzbacel54KdphZW4D1VoQTkRecJnZJT3ob5x+no9Skcg
	b/WWZFGl+0T4CFvizqrcRaq35/kiEdzCJOMk7nkQuK0JxAqRymBmmXk8yjzcCMl2
	5zuKilcbLbTZ5ithZDRx9FBeyQQRwFXC5lP0ar4Xq+RrhAQ+GcPJMKaY2UxSofBl
	Fd0ugOcfOefgP36Qd9gOJeAmWjP3SrX4tMudk/ErUmZJnog6LY9ObYZW73BJbLZM
	t3pHCPx3gza2BWSLrTkPyFG2MvPbiEGrvxneD1AdcxwmnfGuVT746JWREekyMMBq
	dOz1M6koj+dN7kYVT0+EA==
X-ME-Sender: <xms:-KIMZsS7CELLofEfYcD3u6-8WlLUpeplTRjrS8mmC0soiwoTto_y5g>
    <xme:-KIMZpwmEE-S9q7sK0r0eeZl457LGqLL6fjZijitT3afv7AS17scs_9-uu2tuff6K
    XL1zFrNO_Tv8UbgbIw>
X-ME-Received: <xmr:-KIMZp3wwAOHPBbH7uKtCkqz2kCFnANMc-8g2Ui7BNjN73T3m8qoJNfdd-TC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvges
    lhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeduudetudehiedvvdevveelhf
    egkeefffdvfeetuefgveefgffgffeiffeitdelieenucevlhhushhtvghrufhiiigvpedu
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:-KIMZgDt8iw6cGtF_NdYkMg7jVEdSoV7yAM5bOhfac5D_QzXBjtU3g>
    <xmx:-KIMZlitoBzFigJf7t93S7-x8ZDsbwfvHrBji-WLOrXxXEziMyPcYw>
    <xmx:-KIMZsp6LSoIXihAaTkyCMGiXokp6J241vVfklicorvgFckXTk9IgA>
    <xmx:-KIMZohVhKKU-SetOMzY4CvutYf6PrHu4pgWzDvcMuGyGpmqWX7mZw>
    <xmx:-KIMZgWa7BXwyaAjfJ_f5XC4iMbdkv0opEPiqNIbk1c7fZ4wtZ3c9XM0>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 20:29:41 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 6/9] platform/x86: asus-wmi: adjust formatting of ppt-<name>() functions
Date: Wed,  3 Apr 2024 13:29:14 +1300
Message-ID: <20240403002917.2870959-7-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403002917.2870959-1-luke@ljones.dev>
References: <20240403002917.2870959-1-luke@ljones.dev>
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
index f87500d87f56..aad4f94cfdba 100644
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


