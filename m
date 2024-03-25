Return-Path: <linux-kernel+bounces-116553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE0788A0A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F371F3A753
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A35A15F319;
	Mon, 25 Mar 2024 08:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="TdIBOzRk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FXRZgN3l"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D35714882E;
	Mon, 25 Mar 2024 05:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345829; cv=none; b=J21EEZ+gbLXjqU4XwS3cb+ewzPpK0ZnwA4NTgJdplt6ZpRey0aDHYLTbXSUQGyQY8NpDgFV9vWdRJXyaitxQYkPPZEQwSx2pDS3IBy6UfQH2GS4H8UmJ1AyowxGSsChZa95dPiJVKYP+RgpeLW3AhE5mqHLWZFgzq7gWoOlc+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345829; c=relaxed/simple;
	bh=q7htrRhmIpffAJaSSd/Qrm0hkgm0oq7FbiA9QPXJJOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2moGlCu/0Q6HXH0KO0TNph+t4P1XEHTkWyknCj6iqx6modMeXnFmtP1mby++7rYg9joH0LyBdCRRsGWgPptof3uvFi0XOWvht1ZDRrhMeEwUOx6hB3NfG6nJ2kVRf6sKap6wwfh+8vW+VtfjEHK3iUOy3dQWeigXJZPTytO0kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=TdIBOzRk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FXRZgN3l; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id B137713800F3;
	Mon, 25 Mar 2024 01:50:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 25 Mar 2024 01:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1711345826; x=
	1711432226; bh=FCaPLFbPfBeh6lcaDURHJE3JwO/F9VTh2vUzGDfablw=; b=T
	dIBOzRknhRRQW/a2n9+cN1i6UXjL3ob6mwlDh9Sy7aYcwxz8wwR+/46SDcFnTc7m
	HSRISNylEIIjdptn6yAGgvCIMpTRIuRdnC+FgBDbuqncP+IL6AEzenF36TDQkVB+
	3V8HqDNF33Pl8uHNaBG9jXF71Ghh/xJpuqzsK0BoV4f9VWBHsSQ4QMBfCu6sWvnk
	Wxi3+U+TjOxi73wIQpJFnf9iEhRFwbald/MlGFsmqQylz68juedYN7sH7YZR8Yrk
	UYNCRfATcslrhkt8AYFxTqxXHKS6GYq2wnxQN5ffqhTKrURF3SMdaX0o8s/M7zD2
	DzmEASr7BdYlImE2TweOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711345826; x=
	1711432226; bh=FCaPLFbPfBeh6lcaDURHJE3JwO/F9VTh2vUzGDfablw=; b=F
	XRZgN3l/HTnooHCMXEBOwYU7MGxaGc/qVrG1qNVo7LReIRWwx9Zq3xfSBoDjIVo/
	NOfwXu3t0wxPtiPC4ybmXG/pzGj2MXXVky+Fs/Gj5D0n2Y8SabHwsPwF72ZwbU1t
	ZVoRWHMeVEoUcBYv4kPMDqCWK6uq5EuFaaFGd/j3jhaz7XqCCTJAyYzLUiYNwy+m
	4Lp0tVDeCtLa7f+JLf2MUi6XkVJ1yAMmbTXx5LrnedDeqmMRSP+IuIYHroIjPv45
	QWhrt3EYubsxRWYlo479+1SKu+s3iguTtOSxhAOgmgMkUWnD02GbOUDBdx9VXoA8
	dKMXyFBvAgbzv67U//Zuw==
X-ME-Sender: <xms:ohABZtTStNXIc6sJdAqeGvEktAGaTcwu-fwyAESNgF3eUiY22rvjrQ>
    <xme:ohABZmxYzu6B8WzKfy2hL-vzG3FxSFfeRrq6TWvoZN_9efwoSyyZQvb9-lpqFfWik
    MRaLEiHhrMg3x9lCA4>
X-ME-Received: <xmr:ohABZi0GPTS73XbOdxvbF5UupVb1Y63eDWWfS_5PMB6phBGv8GtzOTsa7CTS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:ohABZlB75w2Fx3T6KY-6-nbsYqK6yU7msg8xVbAXdingo9MfrrtH_Q>
    <xmx:ohABZmglXS722I4BZrSvRJUXO9wpvcRYBMRyTjey68dwouYclkwzzQ>
    <xmx:ohABZpr5CprDs6e9NX-nFeqwySZZQe2XbsFbmDWQRWRQKpH0wkecSA>
    <xmx:ohABZhg0gos5m9y_6N2QBQTwe6q9He-3SckxiOHlj78U_llze4IsDA>
    <xmx:ohABZhWVDGAdH9WOcVqGjS5wTqBwUCAiST5i6tU1LUvi2JYs_KV78A>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 01:50:24 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 6/9] platform/x86: asus-wmi: adjust formatting of ppt-<name>() functions
Date: Mon, 25 Mar 2024 18:49:35 +1300
Message-ID: <20240325054938.489732-7-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325054938.489732-1-luke@ljones.dev>
References: <20240325054938.489732-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shift the call to dev_get_drvdata() up to top of the function block
in all of the ppt_<name>() functions as part of a minor cleanup.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 1e369b673a72..11ce6dec31c6 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -998,11 +998,10 @@ static ssize_t ppt_pl2_sppt_store(struct device *dev,
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
@@ -1042,11 +1041,10 @@ static ssize_t ppt_pl1_spl_store(struct device *dev,
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
@@ -1085,11 +1083,10 @@ static ssize_t ppt_fppt_store(struct device *dev,
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
@@ -1129,11 +1126,10 @@ static ssize_t ppt_apu_sppt_store(struct device *dev,
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
@@ -1173,11 +1169,10 @@ static ssize_t ppt_platform_sppt_store(struct device *dev,
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
@@ -1217,11 +1212,10 @@ static ssize_t nv_dynamic_boost_store(struct device *dev,
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
@@ -1261,11 +1255,10 @@ static ssize_t nv_temp_target_store(struct device *dev,
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


