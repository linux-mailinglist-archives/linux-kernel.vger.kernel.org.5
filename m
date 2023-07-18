Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C693875747E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjGRGlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGRGlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:41:10 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2098B2;
        Mon, 17 Jul 2023 23:41:07 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b9cd6a0051so32859085ad.1;
        Mon, 17 Jul 2023 23:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689662467; x=1692254467;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ss351zSIYWfQhu+bNWxKLoSYfDEjnuyNfe4mYrOgQz8=;
        b=ESd7x52kPKUq9jbEJD7WQPWYjN/lysuEr1+dHZ1irC8juSQbRBQPfOkZdqVrHvrf8b
         t+Sn21wECswvesNAfG73UVV2kWn+Qg9q/fd2EzEmC//N6An54GE/LheNo3hUHe4nuYNz
         D/zzR+np2XE0MG5r/xc1OQ/Aors4QXRUb7+oK/LDWXah5dO3huc/VdTKSPn7/aqEEf9v
         EpFZKJn0FoB8vctr3H4DAvOdEfutbkU4f8xBt2Nd9QZ+NE/smQiXntRyytuVaLVZIuGc
         n2PL+YtyQ2KXo4whhWl7zDY0BPIqzuYMpXkNuLX2LtOJV+zbbTPN1Q8FzE/6ZYbd5RHa
         XYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689662467; x=1692254467;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ss351zSIYWfQhu+bNWxKLoSYfDEjnuyNfe4mYrOgQz8=;
        b=IWKas61rX6MyPqTd8HsoXbRcTfhILafRkF7XXakqJN0xV4csfI6HTozIzWYxdIYNZ5
         qafvHpYLGBnaNQj7LRmcvUWAWC4SOmJTLorM7mEbS5tE0OjLHQE03dYWKEbY4fxBAU5f
         DN2vnl8vgw/z+Hb09dUz5TrW2Hx4Y3rR9vMSa0z7CJnrJ29TkU5e2A9xUHGp5MjQooSd
         EiVchuYpoz2g1m5U+xSxy0DMHyNVIUXz6ImrFN8OMe9s+A+R4t9zhzPCGrqlMUll5XIf
         cFXAnIAyC4sgGJpTQ1rHSWJ0Qg/zHW5jsk5SHrNDvjg0m0Q4pabDSeWAOi4heuHo+coE
         aAlA==
X-Gm-Message-State: ABy/qLZ8YRGx3U76C79ivwtac7T/HbOonDBBzbQy1EKjrIl063islqid
        guyFlm5o3t3wcAPSteHVNwdD2WClGMC6yw==
X-Google-Smtp-Source: APBJJlEbckENCNpdqxg3Wvp7O6bQMhDyYQIPEqA9fawCE6Knzd7UaEqFRwANNU/bUQsx2/4qWf/UXg==
X-Received: by 2002:a17:902:d2d2:b0:1bb:2d0b:1a19 with SMTP id n18-20020a170902d2d200b001bb2d0b1a19mr1391506plc.62.1689662467236;
        Mon, 17 Jul 2023 23:41:07 -0700 (PDT)
Received: from ?IPV6:2601:1c2:980:9ec0::2764? ([2601:1c2:980:9ec0::2764])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902eacc00b001b89466a5f4sm993434pld.105.2023.07.17.23.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 23:41:06 -0700 (PDT)
Message-ID: <ac8d6190-06ae-b538-1293-07efedbfe94e@gmail.com>
Date:   Mon, 17 Jul 2023 23:41:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
From:   Randy Dunlap <rd.dunlab@gmail.com>
Subject: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rd.dunlab@gmail.com>

When (MFD) RZ_MTU3=m and PWM_RZ_MTU3=y, there are numerous build errors:

ld: vmlinux.o: in function `rz_mtu3_pwm_config':
drivers/pwm/pwm-rz-mtu3.c:374: undefined reference to `rz_mtu3_disable'
ld: drivers/pwm/pwm-rz-mtu3.c:377: undefined reference to `rz_mtu3_8bit_ch_write'
ld: vmlinux.o: in function `rz_mtu3_pwm_write_tgr_registers':
drivers/pwm/pwm-rz-mtu3.c:110: undefined reference to `rz_mtu3_16bit_ch_write'
ld: vmlinux.o: in function `rz_mtu3_pwm_config':
drivers/pwm/pwm-rz-mtu3.c:382: undefined reference to `rz_mtu3_8bit_ch_write'
ld: vmlinux.o: in function `rz_mtu3_pwm_write_tgr_registers':
drivers/pwm/pwm-rz-mtu3.c:110: undefined reference to `rz_mtu3_16bit_ch_write'
ld: drivers/pwm/pwm-rz-mtu3.c:111: undefined reference to `rz_mtu3_16bit_ch_write'
ld: vmlinux.o: in function `rz_mtu3_pwm_config':
drivers/pwm/pwm-rz-mtu3.c:397: undefined reference to `rz_mtu3_enable'
ld: vmlinux.o: in function `rz_mtu3_pwm_disable':
drivers/pwm/pwm-rz-mtu3.c:259: undefined reference to `rz_mtu3_8bit_ch_write'
ld: drivers/pwm/pwm-rz-mtu3.c:264: undefined reference to `rz_mtu3_disable'
ld: vmlinux.o: in function `rz_mtu3_pwm_enable':
drivers/pwm/pwm-rz-mtu3.c:230: undefined reference to `rz_mtu3_8bit_ch_write'
ld: drivers/pwm/pwm-rz-mtu3.c:234: undefined reference to `rz_mtu3_8bit_ch_write'
ld: drivers/pwm/pwm-rz-mtu3.c:238: undefined reference to `rz_mtu3_enable'
ld: vmlinux.o: in function `rz_mtu3_pwm_is_ch_enabled':
drivers/pwm/pwm-rz-mtu3.c:155: undefined reference to `rz_mtu3_is_enabled'
ld: drivers/pwm/pwm-rz-mtu3.c:162: undefined reference to `rz_mtu3_8bit_ch_read'
ld: vmlinux.o: in function `rz_mtu3_pwm_read_tgr_registers':
drivers/pwm/pwm-rz-mtu3.c:102: undefined reference to `rz_mtu3_16bit_ch_read'
ld: drivers/pwm/pwm-rz-mtu3.c:102: undefined reference to `rz_mtu3_16bit_ch_read'
ld: drivers/pwm/pwm-rz-mtu3.c:103: undefined reference to `rz_mtu3_16bit_ch_read'
ld: vmlinux.o: in function `rz_mtu3_pwm_get_state':
drivers/pwm/pwm-rz-mtu3.c:296: undefined reference to `rz_mtu3_8bit_ch_read'

Modify the dependencies of PWM_RZ_MTU3 so that COMPILE_TEST is
still allowed but PWM_RZ_MTU3 depends on RZ_MTU3 if it is being built
but also allow the latter not to be built.

Fixes: 254d3a727421 ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
Signed-off-by: Randy Dunlap <rd.dunlab@gmail.com
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org
---
v2: fix typo in Subject;
    correct my email address while infradead.org is down;

 drivers/pwm/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -- a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -505,7 +505,8 @@ config PWM_ROCKCHIP
 
 config PWM_RZ_MTU3
 	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
-	depends on RZ_MTU3 || COMPILE_TEST
+	depends on COMPILE_TEST
+	depends on RZ_MTU3 || RZ_MTU3=n
 	depends on HAS_IOMEM
 	help
 	  This driver exposes the MTU3a PWM Timer controller found in Renesas

