Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3552078D216
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 04:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241722AbjH3C3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 22:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241713AbjH3C32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:29:28 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327E883;
        Tue, 29 Aug 2023 19:29:26 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 3928A3200985;
        Tue, 29 Aug 2023 22:29:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 29 Aug 2023 22:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1693362564; x=
        1693448964; bh=HEpiK3a0e5YZP+QDu46vUt5AK2l3SqMXFcyefmW/6xg=; b=b
        p+FGW/xPzI/yFyGbXqRc+a4OvZY+9lVnmM7/vULpKjU5xWC52uIxmslES5G0V8gf
        FlyJpsNT9K36ZbOx+N7iwIgYEKQUpJrUGu8eF8YyFCt/gbdmZ2JyqccCDeq4v7Nz
        3rIs4eTqbt8CXdG05qrYbUqmEOq8Mi799dpQOWhYm6sxFf/pXz96WNEvg2oxegQM
        jPeMo7wX8Mi+AzjPMN5Dl2T8HP1XKOrIlABr2pvE2c8+zdnm+xyKJighLi5w+iPL
        ANbyCtwYn9R//0IHT9TOH8QpSWaW/ZoXYcB8BcB0Y3n3IXvBMdnG+QRsMn64xY2x
        CaLfTLfy7wf3SFKeyh72Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1693362564; x=
        1693448964; bh=HEpiK3a0e5YZP+QDu46vUt5AK2l3SqMXFcyefmW/6xg=; b=D
        K/+S0iO3y3Dl37KfJvgn/Eq1Qk7YeAqWr5KPaZTfzYkORX46HB1f3OGLVhC+qFjO
        j7Av9aFc/eKNqj16no5F2SA8tIzi6HHWlXQ4L2YdWxkQbLA/xmsdOu54h7/P7M4B
        otIERxacrA/4Iy6jX2ImDCsjCK9gkb+JYVmz+75YC6k7vpCeNtwA4r2AU64q+agA
        P2a3X9KlboCxZ+xGuFoUrPEQF+ly0GLNQ0NbHhdbudYmMwiiJoZR0WvJ0iRX22qE
        5KZgkCQv17Bh0ivA2kSOrhYCiY6lskHCmdR2BYujgXV/qGHsr+rOFVe7CQQ3/J3k
        K9J5DVVqPXF3r95aJSM+g==
X-ME-Sender: <xms:hKnuZOCQKTTvt5Zb_N9uK4IZi3kwN5Q7LDSNCke7tQevNgzsiLxdpA>
    <xme:hKnuZIgLUqRZTUYCh_xWBTleOSVsfEHi1IiQQGFuUuLt6n-hA_Y-Yal82vOaYi8AV
    DMTJzKEUDSsPTA4ffY>
X-ME-Received: <xmr:hKnuZBlxCzaY_bKWa2c4Z_dLoX4dAa3XtZihnBcwq-3CMuU6VwIkDIY_sung>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefjedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:hKnuZMwJa4BS-SfQKBDUjM1BfbiOxU5NMkOvMYsrnSchpBAp5w5MRQ>
    <xmx:hKnuZDQ4tASenkerbJEQn-cOXzSnAxs_EMtxLa3yhI40Ejlgczc8ew>
    <xmx:hKnuZHZCEVTJ1qQHH1qcKOpZjnW3bYWyLpBXcrzUH3BWXFTYjoNCxw>
    <xmx:hKnuZNdAN1l4w7UYxIRSt6pqQNIYbObJ_qZm2c0BdnCfpZK0nHPMiQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Aug 2023 22:29:22 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 1/1] platform/x86: asus-wmi: corrections to egpu safety check
Date:   Wed, 30 Aug 2023 14:29:08 +1200
Message-ID: <20230830022908.36264-2-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830022908.36264-1-luke@ljones.dev>
References: <20230830022908.36264-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An incorrect if statement was preventing the enablement of the egpu.

Fixes: d49f4d1a30ac ("platform/x86: asus-wmi: don't allow eGPU switching if eGPU not connected")

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 9783893d2d6e..f54178d6f780 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -726,19 +726,18 @@ static ssize_t egpu_enable_store(struct device *dev,
 		return -EINVAL;
 
 	err = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
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
@@ -748,12 +747,12 @@ static ssize_t egpu_enable_store(struct device *dev,
 
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

