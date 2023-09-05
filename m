Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9978C792A73
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbjIEQhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353880AbjIEI2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:28:30 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964D5CC7;
        Tue,  5 Sep 2023 01:28:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2070F5C00D7;
        Tue,  5 Sep 2023 04:28:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 05 Sep 2023 04:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1693902501; x=1693988901; bh=5jDiTe+a/3
        BCTH6WBKikex+dCxi9PDN83ta/4fvqmq4=; b=OQ2OZCMhVJRg+6WqZErqBVoT9v
        2xMzxyifLmMlWa5I9bvt3rBkxS1WTu1MtEy58VSE1oj4+U4cOkhcwq6W4VaOZEce
        YbNAh5lC1UBN8upNmD4zFgcdF9ml4y0QyYzQgbw9JqGK26iu7RPCgrtZbqP2Ibj6
        I019kBPGIt4wE36JC6a6OjnmGD70GX1pgoDz74iTMo9QKjJPjsnaw8vFGyk8jDjI
        wehj4+5GWVrQrTsjVBjFLBgdMyyllzS2bJVoPRX4yNAtu85bjIYnk2PmupnlNK6O
        KOAD8ZLgiusjtvdAFYtSf+hTuu5BVs1BoUbjnu7kqGt330hBrMpQCr1TZsgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693902501; x=1693988901; bh=5jDiTe+a/3BCT
        H6WBKikex+dCxi9PDN83ta/4fvqmq4=; b=2ifOQ2uCleqetPbzngex4dyPZdi2d
        hqs/QhUV3DE7CCygtSKs3p8KpzO+6JedjlqyCO2FvOlaL5L2MfEGkQezNGfsvamL
        ZgmFOOZFTuJo7stjRrWbT6J8cm7nw5MDH/rx3DopXCySwp6s4SpQGgT4sYqNoSG/
        VuCoAJcFEiCSLLoEBsBwyw0718ViPlkwjnYmLSxwSgFq8ftCn0pVuHoV475LMAIA
        MwKYX6/KutsaxxEtUxDNE+pW7x6S/vD3cz0r5yHUsq5flV87PYaeBnDR0PnXIpEY
        3nviijDCeIiqZQfH1kB2/lKcu8M5mEdeNiac29P7GHkdLES3Y62QaAnlw==
X-ME-Sender: <xms:pOb2ZHgZlA9kWQD45_1qmEBGVxUucbb6WPne_oR_alJNWKfpSRBEVQ>
    <xme:pOb2ZEDEhoONAfZ4BFvqqazyS6SFNEcRbdNC2GbR9bNl9BKqnU3MD3i-T5tGqre7i
    v6WGz7DjYM6BOJKXVk>
X-ME-Received: <xmr:pOb2ZHFnE3e3nPNbjL9sHGDITjKvaoqTA4CuxcZD59fcmsqQ86FueEHNuhpz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehtddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:pOb2ZET9QcHJX99u1L6lEHba7Chzd094Nbdjr_BeTUjlgJ5G3-Sfag>
    <xmx:pOb2ZEyyl0G7srbsMCObuAknbAKiMlSuyJU9r6xuQA_CrgWPWcdnRw>
    <xmx:pOb2ZK7Ovf77afHvUVQH5ncI0Mf1baFjD6xDrQODOLveS9xRmpKMQw>
    <xmx:peb2ZA8cpJCVl8lTP7X8Qxo6NEGi8HGnMtTAwFrItqQRKPeuaAaMEw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Sep 2023 04:28:18 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] platform/x86: asus-wmi: Support 2023 ROG X16 tablet mode
Date:   Tue,  5 Sep 2023 20:28:13 +1200
Message-ID: <20230905082813.13470-1-luke@ljones.dev>
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

Add quirk for ASUS ROG X16 (GV601V, 2023 versions) Flow 2-in-1
to enable tablet mode with lid flip (all screen rotations).

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-nb-wmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index fdf7da06af30..d85d895fee89 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -478,6 +478,15 @@ static const struct dmi_system_id asus_quirks[] = {
 		},
 		.driver_data = &quirk_asus_tablet_mode,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS ROG FLOW X16",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "GV601V"),
+		},
+		.driver_data = &quirk_asus_tablet_mode,
+	},
 	{
 		.callback = dmi_matched,
 		.ident = "ASUS VivoBook E410MA",
-- 
2.41.0

