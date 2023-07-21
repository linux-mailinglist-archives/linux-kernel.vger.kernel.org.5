Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B09F75BB98
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 02:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjGUAlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 20:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjGUAlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 20:41:10 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C672D55
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 17:40:50 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6W1q18jZzBRDt0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:40:47 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :subject:to:from:date:mime-version; s=dkim; t=1689900047; x=
        1692492048; bh=gxoAKulf5uW+xa9wxplQQyRtHiJaHRDy/eDDf/C/0MA=; b=y
        Uv1DlypEEsxTD8gsmRJhWi++JCZtdgzGv+WFF38eR4/C7iDtfbOI0THfFwSAo0Xp
        AxL1uHPxLSxhRfR/61JAa24dPgklZY7y8nF8gwMyhygKo5+StLL6gyL00KpJsugf
        bSSnAcsCNPsMQB/auoKEv7DspID7p7WEMbrIhebwzONqPR90Q/x3DawvIeQQS3no
        Ayt0oXCyV+DlXM/6rZtJKwnRM7odtjLpE+dk/uU3qDMkBxMLTs+zfMbriTC8aGnC
        JdQIf6Lpg9fXMgwtYBd7HjFIUvjKEX34qtHjd7p4hRN6jppxptV4NFMbiWtJUq0h
        Lzaem2RByn5KQLLhhFR6w==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id i5Q1fCMA4Wk2 for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 08:40:47 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6W1p67qzzBJqBP;
        Fri, 21 Jul 2023 08:40:46 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 08:40:46 +0800
From:   zhangyongle001@208suo.com
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sh/boards/mach-migor: ERROR: that open brace { should be on
 the previous line
User-Agent: Roundcube Webmail
Message-ID: <b3dc7e5a2e8913d21ce9cc80dbfcee53@208suo.com>
X-Sender: zhangyongle001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix twoce following checkpatch error:
ERROR: that open brace { should be on the previous line

Signed-off-by: hangyongle <hangyongle001@208suo.com>
---
  arch/sh/boards/mach-migor/setup.c | 6 ++----
  1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sh/boards/mach-migor/setup.c 
b/arch/sh/boards/mach-migor/setup.c
index f60061283c48..a51a36b132dc 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -109,8 +109,7 @@ static struct platform_device sh_keysc_device = {
  	},
  };

-static struct mtd_partition migor_nor_flash_partitions[] =
-{
+static struct mtd_partition migor_nor_flash_partitions[] = {
  	{
  		.name = "uboot",
  		.offset = 0,
@@ -364,8 +363,7 @@ static struct gpiod_lookup_table tw9910_gpios = {
  };

  /* Fixed 3.3V regulator to be used by SDHI0 */
-static struct regulator_consumer_supply fixed3v3_power_consumers[] =
-{
+static struct regulator_consumer_supply fixed3v3_power_consumers[] = {
  	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
  	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
  };
-- 
2.40.1

