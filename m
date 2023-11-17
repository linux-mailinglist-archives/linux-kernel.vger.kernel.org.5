Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E807EEA9E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 02:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345619AbjKQBQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 20:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjKQBQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 20:16:30 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A8D1AD;
        Thu, 16 Nov 2023 17:16:21 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 80FF05C01D5;
        Thu, 16 Nov 2023 20:16:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 16 Nov 2023 20:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1700183780; x=
        1700270180; bh=6VCvJjojGG/O8+rbwWkHTqMF8m/NO3fQFVfb6jMvLVc=; b=j
        oJ1IrQkctNq6Z9EoVV8wV+1PpDSuUJj7CRNNwjZ28LS6BcoHLF91fsc7JggUL00w
        zLKnMg5Rkxfhl5vaRFNP7LuQ1JxTbo8jenkt8KE3oMhhm5j0E1ciyHEC5tubM8C4
        hJHKFYK56dhKw4H4bv05/4K2t25zgME1BVHginuNJToupYX1Y+vZ+H1byx5CFVDR
        VuhYNnoIOlUlhiMFIs4qq0ZXcEXvq0JRtE06SlwQsjlKKibILKaPsg0E4j+HI1cO
        BFGOcEXD4IJgzZ7L7etIXomAWGPlCtjSyfGyFhVVT2Tkr8MRnH971E1BA+rtownx
        FlcLqdYHevxGBPVF1ow/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700183780; x=
        1700270180; bh=6VCvJjojGG/O8+rbwWkHTqMF8m/NO3fQFVfb6jMvLVc=; b=O
        gcXPjZQq/MUN7cHYWBpzZy4vSH6jAzg861vtzKMzj0M0TZY1uhebF4DcK2+slxV8
        OjJOzuO8xbezJuq9oINt4k3aa/wZbHTgQMKCZp/Y/9og/NSEgAm1gcW9SXxnXQc2
        X0hgo9oWOnB71CSyZFPrRTDFMJdysZxMYX6lk3IuJxtCsDcwrRm7Ibl187Y/5b+a
        eKPSR2WsoLXTatWnpyFUGUFlkH4oE8JcexVqoubex7EkvSf/RD9ruZA6lthmUg4q
        0gLFGO9wO+jKd1TdLu1KGtDpHD9nfvuZJNiY106nQNYbAslkZoumgipZX1q8DLNd
        Cvfcc8ETFuHTjTCLawXww==
X-ME-Sender: <xms:5L5WZZThhjJXvCrJS9aa2YR7e_zq3QWba63-klSi4C2YMx6qpWp6_g>
    <xme:5L5WZSwgf0bMp5s0edZF37MoW2ALjC97EVMvNvaien2HwwxTsA3MhyjGA4qbR5El7
    ar053vdhuRwYunce-k>
X-ME-Received: <xmr:5L5WZe2S-AI72DhYjD5G0yy9Vp9IAYQSu0rUOZhjsY90MGlIqrYLLLDQIG15>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:5L5WZRDpNtVMB2JEUjRakHCQo8yBOZgOGCtwVg4O87sSCpAkGY8MwA>
    <xmx:5L5WZShgyRTLLhMQ1FbTqFRCK7q4rO8y01_1ej_Bmdi_SX62i466-w>
    <xmx:5L5WZVp96JuOjG0DAFGMPInav3v6PxYWQhQDX4sjTIP7Rd6b5uc_vg>
    <xmx:5L5WZVtKQTu_ZXbq6rYiW4Hi26Tz5NE9tt0SL8nmcliUeQ2vbsBPOg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Nov 2023 20:16:17 -0500 (EST)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, benato.denis96@gmail.com
Subject: [PATCH 1/2] hid-asus: add const to read-only outgoing usb buffer
Date:   Fri, 17 Nov 2023 14:15:55 +1300
Message-ID: <20231117011556.13067-2-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231117011556.13067-1-luke@ljones.dev>
References: <20231117011556.13067-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Benato <benato.denis96@gmail.com>

In the function asus_kbd_set_report the parameter buf is read-only
as it gets copied in a memory portion suitable for USB transfer,
but the parameter is not marked as const: add the missing const and mark
const immutable buffers passed to that function.

Signed-off-by: Denis Benato <benato.denis96@gmail.com>
---
 drivers/hid/hid-asus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index fd61dba88233..b70673a929a1 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -381,7 +381,7 @@ static int asus_raw_event(struct hid_device *hdev,
 	return 0;
 }
 
-static int asus_kbd_set_report(struct hid_device *hdev, u8 *buf, size_t buf_size)
+static int asus_kbd_set_report(struct hid_device *hdev, const u8 *buf, size_t buf_size)
 {
 	unsigned char *dmabuf;
 	int ret;
@@ -404,7 +404,7 @@ static int asus_kbd_set_report(struct hid_device *hdev, u8 *buf, size_t buf_size
 
 static int asus_kbd_init(struct hid_device *hdev)
 {
-	u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x41, 0x53, 0x55, 0x53, 0x20, 0x54,
+	const u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x41, 0x53, 0x55, 0x53, 0x20, 0x54,
 		     0x65, 0x63, 0x68, 0x2e, 0x49, 0x6e, 0x63, 0x2e, 0x00 };
 	int ret;
 
@@ -418,7 +418,7 @@ static int asus_kbd_init(struct hid_device *hdev)
 static int asus_kbd_get_functions(struct hid_device *hdev,
 				  unsigned char *kbd_func)
 {
-	u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x05, 0x20, 0x31, 0x00, 0x08 };
+	const u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x05, 0x20, 0x31, 0x00, 0x08 };
 	u8 *readbuf;
 	int ret;
 
@@ -449,7 +449,7 @@ static int asus_kbd_get_functions(struct hid_device *hdev,
 
 static int rog_nkey_led_init(struct hid_device *hdev)
 {
-	u8 buf_init_start[] = { FEATURE_KBD_LED_REPORT_ID1, 0xB9 };
+	const u8 buf_init_start[] = { FEATURE_KBD_LED_REPORT_ID1, 0xB9 };
 	u8 buf_init2[] = { FEATURE_KBD_LED_REPORT_ID1, 0x41, 0x53, 0x55, 0x53, 0x20,
 				0x54, 0x65, 0x63, 0x68, 0x2e, 0x49, 0x6e, 0x63, 0x2e, 0x00 };
 	u8 buf_init3[] = { FEATURE_KBD_LED_REPORT_ID1,
-- 
2.42.1

