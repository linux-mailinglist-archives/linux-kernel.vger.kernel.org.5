Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4358F797982
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbjIGRQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242144AbjIGRQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:16:10 -0400
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D5694;
        Thu,  7 Sep 2023 10:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1694106890;
        bh=pgA+I/1UethBA3kTPM9wHgQdSRMpsBbEzyngE18JA8E=;
        h=From:To:Cc:Subject:Date;
        b=LBSt+mnZ8f++wfmzxHfkk+dD+BEVDr4oYqB6OUTqXBD/rv1eP8nlVRWFE9cKkOp24
         Gdkej132D2SLAEjvZwREtm//QNk/6VMC/Wb0dgU33+eeOJYiSkurvH7gczLvaoZvPT
         RLn0BAzWPNoIn56LVh60WbvtNux4j+TjrHCskA/I=
Received: from localhost.localdomain.localdomain ([117.61.105.88])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id D722ECB4; Fri, 08 Sep 2023 00:53:50 +0800
X-QQ-mid: xmsmtpt1694105630ti09a7drb
Message-ID: <tencent_3373B90C5A9E646DDCF91C0D8CAD2184BC0A@qq.com>
X-QQ-XMAILINFO: MBjwNRQMz5zUjCcz/6jhtF96ZPHh72CPUDwiLARk8gXh0pPNgvMiPCwmZKKMYd
         eFuaCPEelFaBcCCA3CZzhdwuGJw/5vsHTl1t0QFq1S7YCRIJSGf/PGcNygBTIhPI6mOL+Vvj2VMl
         Qj60MEdcQ9q0hK1pCtMbA5no+bdEPpmrNrygpdysatUHc2SBWHuoa5f2hq5C4wp+VIEGjTxWqCnD
         SNFL5qjvPRYTVsH/r52P1mFeM4VyuAvSMHp3UCEOuY2VQp11VLZ5VZqaAQiM/uvXpBP6e1On540f
         Goep+edpLiHyOG3CseXy2dsqsFmO59YQJ/CQiNcsmebme7/ONYaQ5g8A9F2vx4+S3DDfTQcP7dDP
         CZB1DXdZdnSuMalfKF1LPoipnVUcqD1/0s+UkTZn/UvoEd1dFn6oDF7Anl1mx0Fyt2a/8ZNMqz4h
         g2IfO0+MCIUAzvofsAsaYjb4igROkU+Krg6F71UiTqHQWM1KSo+2Vdp8SB96wjywNKmJPS3YP1it
         ajbgHG6ORMpYjUvp0V+TX5JsepCRyPp3P+sI8cUsKSFsvS155LM07FWa50zn6tTvMLN+NWktWRVT
         ZhJNUXz5TGKVY9cbLptn2CE56x7I1Pt4infc792+yXBumC4i00ynudvCol3WXAHTBbC6QGB3hb4I
         rL1Hb9Kbque8/gYBCxX37cWjF/E3zhHDGjMrVvaf618VPlZ4srI8PJMO/yAW72H28KiD/ZcjU2CW
         W0azm17BeyDgWLMgANQgXPT1T/wON5T0Oja+2ls7T0e+nCbWAGsH+gSxDkCeA8rz6rL3TpXFqSye
         thdUx1arY77fr3CC9KL2h4wf2lYjIB6MiI1zHSUJuiFl6gbpdDL0MmqJ9YvYrxjrBmw5x55xfNFa
         AAAJk7iS7p4U4qyB+PI0Gm3cYW2QVElvDYrFbByEdf3v71WjaS42MujLEnKizO2akuiwhnqXqVoE
         jclVRj2DrylAF74pNde1PTlIs5R3HssAgu/W/RS+PBda6LyrygH0drDuMzIacot8kLFFRl4zZiIj
         imCDRtt0M/LCV3loTA6it8PGRA95tm4kcSV5rFMA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From:   Yan Zhu <zhuyan2015@foxmail.com>
To:     zohar@linux.ibm.com
Cc:     dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yan Zhu <zhuyan2015@foxmail.com>
Subject: [PATCH] ima: fix return value of ima_restore_measurement_list
Date:   Fri,  8 Sep 2023 00:53:49 +0800
X-OQ-MSGID: <20230907165349.8770-1-zhuyan2015@foxmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the function restore_template_fmt returns NULL due to insufficient
memory, the ima_restore_measurement_list function will exit and the IMA
measurement list recovery fails. However, since the return value of
ima_restore_measurement_list is 0, there will be no prompt for IMA
measurement list recovery failure in ima_load_kexec_buffer, which can
easily cause misunderstandings for users.

Signed-off-by: Yan Zhu <zhuyan2015@foxmail.com>
---
 security/integrity/ima/ima_template.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 04c49f0..1b030cd 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -489,8 +489,10 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 		template_desc = lookup_template_desc(template_name);
 		if (!template_desc) {
 			template_desc = restore_template_fmt(template_name);
-			if (!template_desc)
+			if (!template_desc) {
+				ret = -ENOMEM;
 				break;
+			}
 		}
 
 		/*
-- 
2.33.0

