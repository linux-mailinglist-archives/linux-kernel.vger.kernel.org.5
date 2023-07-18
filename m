Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A694975737C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 07:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGRF7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 01:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGRF7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 01:59:05 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256C6D1;
        Mon, 17 Jul 2023 22:59:04 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6726d5d92afso3938556b3a.1;
        Mon, 17 Jul 2023 22:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689659943; x=1692251943;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXYEcHFxyrbA69rtii4+ZKfjZ9itoGUX8c0WkuXiT6w=;
        b=CDjXPKboGZfn+pwk2wCl8kF9+EUUdqmuP7TCwW5MLsM4lxATRgjYHAbePatj5OlIxk
         eYyW1rDRoUP1n+RwYTyVi/rbToK/w3nEGm60fG2ds1H3rJVuPKwWWFYzuorEY9Mlwzf8
         yvIZ03M4cVaC4nJ0GCW/aAcQ3OdEUmrYoFj3HLdSQiCv51ZaQevv1ZzhL8r7hgYhTSIZ
         ABjPybq+fqqBUdyPSOkQIOqGLZiFGaxgvCPOTYASkI/apBU42OAk7ZZgVe+keK786rrd
         kcAbSKM9ByWhJDSzzxh2tEA3Vv5o3hVaIxtXoD5w2zGPZgfCp5mA+DxiWWLdkcgPp8rv
         VykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689659943; x=1692251943;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rXYEcHFxyrbA69rtii4+ZKfjZ9itoGUX8c0WkuXiT6w=;
        b=BCaKT3j69HhbS2P62V3+gfUVzZrKbazfFXLzPwq2EOui0CpRqktjNP8HCXkX96YhYt
         4fz91gFP1WWsyrpDF5nvRvcn9F7ChnXD8uR+LI0ZlNdY0DpMsVWkBW1Jw/6f0WosYanT
         Xkeyi1R86MVM+9ffUqVZQVD//MAiRO+z10XadVgGAfXK/je3ln5vZuMsXc/v1ZwlFvtw
         rNM2HaP8Dbwf0UTqXwVRPRuV0xmWETmCWB/WQ/Z9Vfh9O2xdiAcBkBYgPZEEduunUkDx
         aNB8xuta7sUILoiHTE8IPBgf54GTvzuOOYaZrmUpvrOtvnajRswPQuXfxwAFJd0Lna5H
         F6kw==
X-Gm-Message-State: ABy/qLbRT9/BKWSJ0GBGf3rhit9Q2oldXYzb9IIrHX91Nas++45Gwq/Q
        WJOVRVXZ0ftbKuH8SDZSN4E/qMiid+2hSg==
X-Google-Smtp-Source: APBJJlE2eIrn11lRxoaLgXD7wyDe8gOQRxnwTrjWGEZStH/z7olIv7Cb6qKuzLBXtHi4UfaWTVkaJw==
X-Received: by 2002:a17:902:c94e:b0:1b4:5699:aac1 with SMTP id i14-20020a170902c94e00b001b45699aac1mr14246327pla.12.1689659943315;
        Mon, 17 Jul 2023 22:59:03 -0700 (PDT)
Received: from ?IPV6:2601:1c2:980:9ec0::2764? ([2601:1c2:980:9ec0::2764])
        by smtp.gmail.com with ESMTPSA id z13-20020a170903018d00b001a6d4ea7301sm858033plg.251.2023.07.17.22.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 22:59:03 -0700 (PDT)
Message-ID: <8a4de6c6-8d7c-a115-2a14-d264d6d28ccf@gmail.com>
Date:   Mon, 17 Jul 2023 22:59:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
From:   Randy Dunlap <rd.dunlab@gmail.com>
Subject: [PATCH] pwm: fi pwm-rz-mtu3.c build errors
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

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
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org
---
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
