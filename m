Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9EF7E91B4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 17:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjKLQzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 11:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKLQzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 11:55:03 -0500
Received: from mail.malych.org (gateway.malych.org [185.150.1.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4131BEC
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 08:55:00 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C641FAA8CB4;
        Sun, 12 Nov 2023 17:54:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=malych.org; s=dkim;
        t=1699808097; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=eAC0I710PoxZTn/0/FlbsP7dzbrDcfhVJ7sO0L74N+k=;
        b=c9Duai2M6qcLDSGPMzZ/Bf1UAzUk4vXkd2iF/GWzkYtp7NnrThRvqnnuux8PCzvMbdus3h
        i8YmCEQvAP8EqxvmyNWxSICuC48PiA6ozBcceyIRLdYOCY3ze9qWCQSsOimbAFdH6AOzYP
        vS33q3jy09MyZQ4HLnrMneiYNqkxiqEJuXTYHDbunVaJARDLB6dcjYq1Mrc6tl1xTo9H2v
        8EzzJcQfdI+kNsODv/YivN5Sgi45WgKztyUC62zKRgqvlX6+yI2iYkG43LAx2bRAB/WSfH
        dm1V8kCN2+TGF9/5Mt9C9kERW7Qy8WOSDfI/W0MekL5Z9WGCSNQvMmW+uj90aA==
From:   Matus Malych <matus@malych.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Matus Malych <matus@malych.org>
Subject: [PATCH] ASoC: amd: yc: Add HP 255 G10 into quirk table
Date:   Sun, 12 Nov 2023 17:54:04 +0100
Message-Id: <20231112165403.3221-1-matus@malych.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP 255 G10's internal microphone array can be made
to work by adding it to the quirk table.

Signed-off-by: Matus Malych <matus@malych.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 15a864dcd7bd..e2a510443bf1 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -367,6 +367,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8A3E"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8B2F"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.34.1

