Return-Path: <linux-kernel+bounces-127300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DA2894962
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913391F23BA6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499D317BB4;
	Tue,  2 Apr 2024 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="jFTKq/Tz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wUmjbMvL"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EE9179BC;
	Tue,  2 Apr 2024 02:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024806; cv=none; b=VjJ2o1bt30UgP8694P0fstSqlvYwmcF71u33b6wLzIl92RLx2rE5rwEg7/JPvxI4dVYF7AnRRVRD+IQjst7EMeFq4NrePTok1Gp1/3junwNW/D4blo/6RoA+SVIo6wRhgLrTWeKNStiGENtFTHoKKVEp7ktBs1QBOpLR9Y18oOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024806; c=relaxed/simple;
	bh=+nJ1i4zjhw6QYZq9p+edmZbpJx6SUFFReBlnsuUMOXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfXszV85MivtvJX0qfGnTkyLwaF7/08pL+s60viWZDzYHnOPwn6DBPl9LM9MbcQy8XPIB7EYBNSfAW2bOJDEZVY1NHiTRYwOIrsHGBnqspdd+vTIzaiDoP6o5AYY/jcKzqxtqq7FWdeE4xonciXV9AddrNPprvJsaCm9PhZr2rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=jFTKq/Tz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wUmjbMvL; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id C52CF1C000CC;
	Mon,  1 Apr 2024 22:26:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 01 Apr 2024 22:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712024803; x=
	1712111203; bh=341GqYNK58gKj+Y+aZKsOtylg69391aSNxN3HwJLYqw=; b=j
	FTKq/TzUhPo+lRB0gcwn6iedHIHXrxIo8vwddX3btt2qZEQJTcHZQVWUSjTNygaH
	S5GbxcwJn/Wo8GH1OrvqqS9wPRDbkqXTXCBniwl1B5OgOyn8dBdNd2a+sVkLTdUw
	4lMqSDm/1C+zDkhTWyqKVLhRaI8Tj4yipvs5Q3QfryQCiwR9YnPAO3DaZeb23Cxm
	3PuGtKO9xkVHRIkj8AJij21GD4e5N4mbiRcxfaGrn5+izFrbn3nzfjxquU5/XJAZ
	+gF46/bqwmxYOzPg0IQG6tM0GH7V3ouuHQwYFlrtYMl4CGwsD966YM9X+gXgEMfm
	vwkL7/7LKlj8heoHt37hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712024803; x=
	1712111203; bh=341GqYNK58gKj+Y+aZKsOtylg69391aSNxN3HwJLYqw=; b=w
	UmjbMvLJSTQu2PS8qbOrpN6c2ytiZFlvBNB/qPPklPl6ywKj2Q9ETrSenrhDvZsi
	9Mnp5GqKYZNqHzoxqOZTOp+gYYIoTc6gv4jLOCYCI+0awHV3Bzgv8YWU0DURgvRB
	9geAqVU6GI27T4ZAIeFTwyJK11wx9Hqqnk09lDw/IvIU8wLNzvYb1F5K6Nq7tsTy
	VNSi70NgeNwkhMzyd+ykMaODm1cWimV/33itjPCY9vGfWR39fsrqMF2NcxIv9Fx8
	QtyvRUmVsIPPTaH4r3DZ5GHcYtgHxbONmpcBgg6J2MfInhEXtNEkpluzSQm1sSJ/
	O+RVB9yMKys3+F9mpT3MQ==
X-ME-Sender: <xms:42wLZgXfKBEkk2ZM62_BLzanIdgotzo0631sRpsMDfsNgWvWLC1pDA>
    <xme:42wLZkmPVz1uGE-RyEfOEOyabWHKeUKBYrxiFFpiIrcytdC9wg7_YKqbbpvFjgkwI
    k2QHJk-Kk4oWq1VpLA>
X-ME-Received: <xmr:42wLZkbwryUKIOZlQfuGRwrZocj49qHIxQ4oxyQQRH7HoRgrnpb1cdaM1v9c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:42wLZvWdM5fSt8i8t-QbQt1wXScBOBtophiukJ1tlWJS6L8PalTpvg>
    <xmx:42wLZqkjBBGzDVTn29BD1raexaQ17aF4QvMMkuCnwRrGKebe7JzDpw>
    <xmx:42wLZkehf-W-i9h9-_ytUG50HgQMKDyooSA4gj7Ij1Kj8zYd4doKWg>
    <xmx:42wLZsEGTxT44W1XHRSFe3MUZw6jbJfXOkWUmpCPQVs2-nkjFFXF5A>
    <xmx:42wLZoYP0EZEzqkzYNitMEMKgd_nT2oyaRenXrQJz07c3EaGmjGrQ64vY0I>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 22:26:40 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 6/9] platform/x86: asus-wmi: adjust formatting of ppt-<name>() functions
Date: Tue,  2 Apr 2024 15:26:04 +1300
Message-ID: <20240402022607.34625-7-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402022607.34625-1-luke@ljones.dev>
References: <20240402022607.34625-1-luke@ljones.dev>
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
index c80afa385532..1743ff1eb0ac 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -997,11 +997,10 @@ static ssize_t ppt_pl2_sppt_store(struct device *dev,
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
@@ -1041,11 +1040,10 @@ static ssize_t ppt_pl1_spl_store(struct device *dev,
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
@@ -1084,11 +1082,10 @@ static ssize_t ppt_fppt_store(struct device *dev,
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
@@ -1128,11 +1125,10 @@ static ssize_t ppt_apu_sppt_store(struct device *dev,
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
@@ -1172,11 +1168,10 @@ static ssize_t ppt_platform_sppt_store(struct device *dev,
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
@@ -1216,11 +1211,10 @@ static ssize_t nv_dynamic_boost_store(struct device *dev,
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
@@ -1260,11 +1254,10 @@ static ssize_t nv_temp_target_store(struct device *dev,
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


