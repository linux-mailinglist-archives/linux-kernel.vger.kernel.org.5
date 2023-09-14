Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2B47A10F3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjINW2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjINW23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:28:29 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC7F2100;
        Thu, 14 Sep 2023 15:28:25 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79565370a93so54867539f.0;
        Thu, 14 Sep 2023 15:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694730504; x=1695335304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ikDIJLUecCkV3WtFu7/oHCQdEcq7hrPWZ64V7X/Ijos=;
        b=aSwoQ9/fdR/auzhSeJ08WrYR2Li5EB4J2wx5daWGYoeRRHTV7m7n4WXhDAU0KzETeM
         Ryfg5MZkPdp72Im3ydoG8B+4klMOIaspbh8OMB8OahgMt4k/5dq86V04ce/zKS721x0g
         iINNtFFlHIx1641tUjA3nqwb+7ZFrLJ2MQwqfSnMJZrzYuAcl4aytDRs4i2gw1fR/jtU
         Jq7EDv9LQ+cdAlNowJZqR0JVXISoDSB3Oarks0Vsk9nPb/3zdvWOz72KsvEOknWyYgCM
         +Wlj/2jVkt5Im+ktBYYU2u3w1R5yP8A/sgu5ggLIXBUVSfZfBLItOZU/DVK64IXeuCo6
         SS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694730504; x=1695335304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikDIJLUecCkV3WtFu7/oHCQdEcq7hrPWZ64V7X/Ijos=;
        b=eVrN2A7Nu0ssQlxaiBZrsI5xgQ8IlyO8Ksc+fEC/3NPF1PBxE8FjwSso8JotTg9Gbi
         gqTtKRbhFJJV2WPN4SKSyb4gH7UQoHk80+4ACC2+WwtjU5zjgwzD7etkoNhJnVsSPfcM
         FbM0XVMqErmYmHasXImbeJmQCjDX40q8ore87UT0t6EQC61qxSSvN3H7ZV0I1fUVbUnu
         0oBWWYiZw84gr0gogkj6hPzinfOw1Qsau13ygjDtbHRaMrdk1JZAMOguPKaPY5o+OIeX
         IRAin++N3jN07o4fLw4wnoc7Qg81IXkbyFAKL/T4Z86O+97U31U23KKHRTpjHXCyhAsO
         VBvA==
X-Gm-Message-State: AOJu0YySsq1rK0VQJVjqV7AhdZBvuf8P/HuFOYvNFA80SCFG6BWECnv0
        xDslV/xxh7usNI8xSC2nG0oniQy2BHK8pw==
X-Google-Smtp-Source: AGHT+IFK2gos0DNjVgHBixlcfuHS0l0nutHhuM42Sprkse5i9He/u20GTsRB0zwye5h7Lgo5By6DQQ==
X-Received: by 2002:a5e:c803:0:b0:786:25a3:ef30 with SMTP id y3-20020a5ec803000000b0078625a3ef30mr7515272iol.7.1694730504428;
        Thu, 14 Sep 2023 15:28:24 -0700 (PDT)
Received: from doomerbox.lan (c-76-154-162-109.hsd1.co.comcast.net. [76.154.162.109])
        by smtp.gmail.com with ESMTPSA id m9-20020a6b7b49000000b0079199e52035sm671886iop.52.2023.09.14.15.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 15:28:24 -0700 (PDT)
From:   James Gruber <jimmyjgruber@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Prashanth K <quic_prashk@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeff Evanson <jeff.evanson@qsc.com>,
        Yadwinder Singh <yadi.brar01@gmail.com>,
        Jaswinder Singh <jaswinder.singh@linaro.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        James Gruber <jimmyjgruber@gmail.com>
Subject: [PATCH] usb: gadget: f_uac2: allow changing terminal types through configfs
Date:   Thu, 14 Sep 2023 15:27:46 -0700
Message-Id: <20230914222746.155126-1-jimmyjgruber@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "c_terminal_type" and "p_terminal_type" configfs entries
in order to allow the user to change the capture and playback terminal
type codes.

These fields affect the type of audio device that Windows detects, so
being able to modify this is useful when it would be advantageous for
a gadget to be detected as something other than a generic
speaker/microphone.

The fields default to microphone for the capture type field and speaker
for the playback type field as was the case before.

Signed-off-by: James Gruber <jimmyjgruber@gmail.com>
---
 .../ABI/testing/configfs-usb-gadget-uac2         |  2 ++
 Documentation/usb/gadget-testing.rst             |  2 ++
 drivers/usb/gadget/function/f_uac2.c             | 16 ++++++++++++++--
 drivers/usb/gadget/function/u_uac2.h             |  8 ++++++++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uac2 b/Documentation/ABI/testing/configfs-usb-gadget-uac2
index 3371c39f651d..a2bf4fd82a5b 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-uac2
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uac2
@@ -35,4 +35,6 @@ Description:
 		req_number		the number of pre-allocated requests
 					for both capture and playback
 		function_name		name of the interface
+		c_terminal_type		code of the capture terminal type
+		p_terminal_type		code of the playback terminal type
 		=====================	=======================================
diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index 2fca40443dc9..471e9264d82b 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -754,6 +754,8 @@ The uac2 function provides these attributes in its function directory:
 	req_number       the number of pre-allocated request for both capture
 	                 and playback
 	function_name    name of the interface
+	c_terminal_type  code of the capture terminal type
+	p_terminal_type  code of the playback terminal type
 	================ ====================================================
 
 The attributes have sane default values.
diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 0219cd79493a..f9a0f07a7476 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -212,7 +212,7 @@ static struct uac2_input_terminal_descriptor io_in_it_desc = {
 
 	.bDescriptorSubtype = UAC_INPUT_TERMINAL,
 	/* .bTerminalID = DYNAMIC */
-	.wTerminalType = cpu_to_le16(UAC_INPUT_TERMINAL_MICROPHONE),
+	/* .wTerminalType = DYNAMIC */
 	.bAssocTerminal = 0,
 	/* .bCSourceID = DYNAMIC */
 	.iChannelNames = 0,
@@ -240,7 +240,7 @@ static struct uac2_output_terminal_descriptor io_out_ot_desc = {
 
 	.bDescriptorSubtype = UAC_OUTPUT_TERMINAL,
 	/* .bTerminalID = DYNAMIC */
-	.wTerminalType = cpu_to_le16(UAC_OUTPUT_TERMINAL_SPEAKER),
+	/* .wTerminalType = DYNAMIC */
 	.bAssocTerminal = 0,
 	/* .bSourceID = DYNAMIC */
 	/* .bCSourceID = DYNAMIC */
@@ -977,6 +977,9 @@ static void setup_descriptor(struct f_uac2_opts *opts)
 		iad_desc.bInterfaceCount++;
 	}
 
+	io_in_it_desc.wTerminalType = cpu_to_le16(opts->c_terminal_type);
+	io_out_ot_desc.wTerminalType = cpu_to_le16(opts->p_terminal_type);
+
 	setup_headers(opts, fs_audio_desc, USB_SPEED_FULL);
 	setup_headers(opts, hs_audio_desc, USB_SPEED_HIGH);
 	setup_headers(opts, ss_audio_desc, USB_SPEED_SUPER);
@@ -2095,6 +2098,9 @@ UAC2_ATTRIBUTE(s16, c_volume_res);
 UAC2_ATTRIBUTE(u32, fb_max);
 UAC2_ATTRIBUTE_STRING(function_name);
 
+UAC2_ATTRIBUTE(s16, p_terminal_type);
+UAC2_ATTRIBUTE(s16, c_terminal_type);
+
 static struct configfs_attribute *f_uac2_attrs[] = {
 	&f_uac2_opts_attr_p_chmask,
 	&f_uac2_opts_attr_p_srate,
@@ -2122,6 +2128,9 @@ static struct configfs_attribute *f_uac2_attrs[] = {
 
 	&f_uac2_opts_attr_function_name,
 
+	&f_uac2_opts_attr_p_terminal_type,
+	&f_uac2_opts_attr_c_terminal_type,
+
 	NULL,
 };
 
@@ -2180,6 +2189,9 @@ static struct usb_function_instance *afunc_alloc_inst(void)
 
 	snprintf(opts->function_name, sizeof(opts->function_name), "Source/Sink");
 
+	opts->p_terminal_type = UAC2_DEF_P_TERM_TYPE;
+	opts->c_terminal_type = UAC2_DEF_C_TERM_TYPE;
+
 	return &opts->func_inst;
 }
 
diff --git a/drivers/usb/gadget/function/u_uac2.h b/drivers/usb/gadget/function/u_uac2.h
index 0510c9bad58d..5e81bdd6c5fb 100644
--- a/drivers/usb/gadget/function/u_uac2.h
+++ b/drivers/usb/gadget/function/u_uac2.h
@@ -35,6 +35,11 @@
 #define UAC2_DEF_REQ_NUM 2
 #define UAC2_DEF_INT_REQ_NUM	10
 
+#define UAC2_DEF_P_TERM_TYPE 0x301
+	/* UAC_OUTPUT_TERMINAL_SPEAKER */
+#define UAC2_DEF_C_TERM_TYPE 0x201
+	/* UAC_INPUT_TERMINAL_MICROPHONE*/
+
 struct f_uac2_opts {
 	struct usb_function_instance	func_inst;
 	int				p_chmask;
@@ -65,6 +70,9 @@ struct f_uac2_opts {
 
 	char			function_name[32];
 
+	s16				p_terminal_type;
+	s16				c_terminal_type;
+
 	struct mutex			lock;
 	int				refcnt;
 };
-- 
2.30.2

