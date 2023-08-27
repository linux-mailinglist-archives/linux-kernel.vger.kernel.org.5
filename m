Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2C078A35A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjH0XPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjH0XPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:15:39 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619C6124
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:15:36 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 25B7F5C003D;
        Sun, 27 Aug 2023 19:15:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 27 Aug 2023 19:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1693178134; x=1693264534; bh=AbibuSICgE
        UTeMVyy2LtST99AtEW/cx+46pzl83Ho0Q=; b=ZdKmMBnlSOO0X9/4EqERpeM3wE
        7CQxy/Ztwh+yb+FXx458D/ZsBECv6PefAg/7S1JM/WYZYd5sRhqj6W3MXMjokAHI
        /nueVlI8eh2I7ZNCDieur3eK1vtjO0ZFuMF2QlDgzzgfdaAHtaNAf98tbWsVycI/
        a5Er34UqZ3Px4VjcGVTi5B5Tc/B78lYGVYvM7BZXUXDhfL4jWIKCFY4SSITeun7r
        0cHPouyHD8MMMpNzBbIaJacomEcPX6v58zXBq9jtqazYt9Dohv3XYcjy3w49EOWC
        QiIUj9L3Xad0auEjQmOulSS04AYM9ruZ8meRQzxgR6F3l+TbYRtHUOPsLeCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693178134; x=1693264534; bh=AbibuSICgEUTe
        MVyy2LtST99AtEW/cx+46pzl83Ho0Q=; b=qD2QXdUMh/LRZIicMsJyX97jMwaQ/
        G7xh5tn/YtoiUxJ7b7wooXf3dNbN3Ig8UzD+Kj8lUmOAdtoxVxHpKKz7q+bcem7s
        H1MDFBGGCdzYKHEke1chyUhTckDP1/n+/CefoufhwGyB2iFu7vHZpHVBz3PQob0C
        BosUs/O+XsIVKmgS5Wc7ws80qWEXCZypQMLOCFLHKRDKXlq62LVqi91MXGCbAlnQ
        ZqVW7lwFadqOcyc7pPi90KtcsYI+eQYAKKCTIMvyBJUQ4xaSj9+ehmj/Jd/ctv11
        YJk3VeE5uHKJHKmn67+/zXYo97djRBxPP935gpwjaDaG8hAi7MZxbb2/A==
X-ME-Sender: <xms:FdnrZEp6krl40lXBxii4QTUkm4Z3ZiLAPGLGoDQjbiBI2Purv0X98g>
    <xme:FdnrZKqpas09e3UV2tHZl2i6H_pEAgV0275H8-fblBN4AJrdJPmrC8bfOD8bxyraE
    KfuNx_CfDXmUFwj3Q8>
X-ME-Received: <xmr:FdnrZJNR8RYfjcT3YWCI2HFBeFcyRPVDbbQsqQ8zdZBJBe4qan_XMSGrb8QW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeffedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:FdnrZL45cYb8X2kwKZ8xD3VAi6G3IRtpLp5FEffJmmkRiHjZgWJqFg>
    <xmx:FdnrZD4OgjNdfRu_R-kFZ6YuyNn1sIcJyVPIEO9LofJZYtP84yRWoQ>
    <xmx:FdnrZLhgOi2S4nVlUaGVNA1qGfw9JuAKkLxvbK75zlQJOW7glTq47A>
    <xmx:FtnrZDFlXbiHOO82TFrDCszXF4-AxzqC82faTBm2ppsvVLDo8fvL8A>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Aug 2023 19:15:31 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] platform/x86: asus-wmi: corrections to egpu safety check
Date:   Mon, 28 Aug 2023 11:15:25 +1200
Message-ID: <20230827231525.78693-1-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An incorrect if statement was preventing the enablement of the egpu.

Fixes: 1bddf53ccac0 ("platform/x86: asus-wmi: don't allow eGPU switching if eGPU not connected")
Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 6db2d18a61e0..b51586986450 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -731,19 +731,18 @@ static ssize_t egpu_enable_store(struct device *dev,
 		return -EINVAL;
 
 	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
-	if (err < 0)
-		return err;
-	if (err < 1) {
-		err = -ENODEV;
-		pr_warn("Failed to set egpu disable: %d\n", err);
+	if (err < 0) {
+		pr_warn("Failed to get egpu connection status: %d\n", err);
 		return err;
 	}
 
 	if (asus->gpu_mux_mode_available) {
 		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
-		if (result < 0)
+		if (result < 0) {
 			/* An error here may signal greater failure of GPU handling */
+			pr_warn("Failed to get gpu mux status: %d\n", err);
 			return result;
+		}
 		if (!result && enable) {
 			err = -ENODEV;
 			pr_warn("Can not enable eGPU when the MUX is in dGPU mode: %d\n", err);
@@ -753,12 +752,12 @@ static ssize_t egpu_enable_store(struct device *dev,
 
 	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_EGPU, enable, &result);
 	if (err) {
-		pr_warn("Failed to set egpu disable: %d\n", err);
+		pr_warn("Failed to set egpu state: %d\n", err);
 		return err;
 	}
 
 	if (result > 1) {
-		pr_warn("Failed to set egpu disable (retval): 0x%x\n", result);
+		pr_warn("Failed to set egpu state (retval): 0x%x\n", result);
 		return -EIO;
 	}
 
-- 
2.41.0

