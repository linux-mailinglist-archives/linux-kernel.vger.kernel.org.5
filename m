Return-Path: <linux-kernel+bounces-59529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D5984F86A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A381F25C8E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C3C73186;
	Fri,  9 Feb 2024 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="FVA4XC2d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hn9//HTc"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E992F71B34;
	Fri,  9 Feb 2024 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492229; cv=none; b=IqfpDrhlBM8gNELcj805Bu6C+JPXJX/v+zu/+i9OmOjyS/quKb+riz2XUmZ1XB2SY068Uz5sGZCbVup2qTHzcIEYZFS40Aw1+yil8Y5jMWMru+4SUyknGPAgIchtGsivqCFA5bMeBwSDq1UzVlhdc65ICbMnOgmJmDuS+Ru/9tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492229; c=relaxed/simple;
	bh=WHb6VFhTlmidZTsOn/qpnzXsJ8oAzSMB+3Ur5jn8AM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V80m/qcQh1kzyRkYxVYxlroeebyWIEYuzfEsAKWUEQA6zJstF9ZU8e+VVhpAK3z5hULstt70vPlB0NAZcK/SkrKMKbqKNIjrCnDzI9M7ttX/O1g+lkOE6CIzG8xlJBXeETG0d7otXaPF2aPNAEBNORAEQC3qC90idEYdqFo0ZIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=FVA4XC2d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hn9//HTc; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id B30A83200A95;
	Fri,  9 Feb 2024 10:23:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 09 Feb 2024 10:23:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1707492225; x=
	1707578625; bh=joYfk4S7PqfM2niyx8PZjn01Ae11B6QrPcjL7gY/O9k=; b=F
	VA4XC2d+coe/gjSS6H8c55iVJ7nEYaujtJviYsZNX2E014/mgIbtjMmsc4fJM6Ew
	T5rJuECxi2RXX6Vt17TzMgNa9PkpdBO8aNQMPb3sUeJa3z+/6p4UFF2lLkHH2orv
	lE1/1OUiTSMVYG5Dj4BVdtFH1z6vd5D8BagwTrMYCch2XExm4cCW68Czc4Suhr1c
	ppsqtWewE5cVRbQvx/MLVZNRAfOlr94Q3nM85J13GASgZfzsC4/DXCuXxPTNGSic
	nR21kI+IDEJSchJ/Y0hDf2RV/BFJ3mcyaRnQvtf2kNCOS/e09ovkWGHeTMzaui0C
	PspV5pfwyFtNYAqan1Xag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707492225; x=
	1707578625; bh=joYfk4S7PqfM2niyx8PZjn01Ae11B6QrPcjL7gY/O9k=; b=h
	n9//HTcKgoAESKHqnch2C2IwGxL2ma08gABRbQ+7aL/Stl+dOXZkKkkeZ0CkyNG3
	EsHtBpSY7qN4mfzdRK185yXgPyX5RExgrsCMMvWH1mw+abxAKZVzqvHwY0VUGpY4
	PuYsn/vzW33vI/59IruPAEuCToobRL28CubUeyTtwQyqm8TZwm+/W8eseLqpWevR
	/4yxKgWViaHceK0KgJSd5uQXfg3dAr4vbCbB8AX77mpXkCKkIIfF0YBwsK1dG+zM
	HnD4g8y2SX69vHq3NZep2VDrzamf7rwM8PK7fy7LskzQOv4emQiH5frrVWRUKxh9
	FoKvPY2c7jXz/kTNZSyXg==
X-ME-Sender: <xms:gEPGZTG8gChWBdW0Hs2uo2WgEaFJCm2dIT-a2qo8UexqjY_yYFBRBw>
    <xme:gEPGZQVDBisyAb6duE8l8AlxW5HLEGd6vsNeipWPYWsw_so_MXNpYYuxxOTMBsVWW
    cyRAOqSPnzAmWRO6-I>
X-ME-Received: <xmr:gEPGZVJf3QfttgEeGpKcu4UtFM54VifGiCfFAFER6dmdnpdVv3N332Hmd5zqCqD0D-68DkzLykI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghrshho
    nhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtffrrg
    htthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeuteeh
    gfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:gEPGZRGuYH2JhAK7e6YUDHbCaNkbdYtctaQsRbkKe4q3U5ghxenUJw>
    <xmx:gEPGZZUnfbAkGMj5bhHSZhw5nQk9HQbATX80Zem68l9M1mtVCE4yMg>
    <xmx:gEPGZcNUHMt5kLHqPEHi3LB7_ZLdQDhR8uQyvELALo6T7K9ctIX7GQ>
    <xmx:gUPGZcRvIwrbcg1IQgADhwxuQWdygl7NBHNHpw-AiMbBrBhevfdvGQ>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 10:23:44 -0500 (EST)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: think-lmi: Fix password opcode ordering for workstations
Date: Fri,  9 Feb 2024 10:23:47 -0500
Message-ID: <20240209152359.528919-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Lenovo workstations require the password opcode to be run before
the attribute value is changed (if Admin password is enabled).

Tested on some Thinkpads to confirm they are OK with this order too.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 drivers/platform/x86/think-lmi.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 3a396b763c49..ce3e08815a8e 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -1009,7 +1009,16 @@ static ssize_t current_value_store(struct kobject *kobj,
 		 * Note - this sets the variable and then the password as separate
 		 * WMI calls. Function tlmi_save_bios_settings will error if the
 		 * password is incorrect.
+		 * Workstation's require the opcode to be set before changing the
+		 * attribute.
 		 */
+		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
+			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
+						  tlmi_priv.pwd_admin->password);
+			if (ret)
+				goto out;
+		}
+
 		set_str = kasprintf(GFP_KERNEL, "%s,%s;", setting->display_name,
 				    new_setting);
 		if (!set_str) {
@@ -1021,17 +1030,10 @@ static ssize_t current_value_store(struct kobject *kobj,
 		if (ret)
 			goto out;
 
-		if (tlmi_priv.save_mode == TLMI_SAVE_BULK) {
+		if (tlmi_priv.save_mode == TLMI_SAVE_BULK)
 			tlmi_priv.save_required = true;
-		} else {
-			if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
-				ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
-							  tlmi_priv.pwd_admin->password);
-				if (ret)
-					goto out;
-			}
+		else
 			ret = tlmi_save_bios_settings("");
-		}
 	} else { /* old non-opcode based authentication method (deprecated) */
 		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
 			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
-- 
2.43.0


