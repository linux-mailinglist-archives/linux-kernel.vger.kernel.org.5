Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8B375C1AA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjGUI3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGUI3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:29:39 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEF22D54
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:29:30 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3460815fde5so8317465ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689928170; x=1690532970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqcAnVxpvMo7IksBTYj7fHRMjHClyEVoFOPZWnp2zrc=;
        b=hF1OzzEufhEDtjc1xGiWd3Q09tWgNep/QKfIBNhgJHpTTbdq2kKmoY/mkJdducvuFx
         e09+2Wsf9hGM4/njO7eO5dATDrHIhU95LkRhtbffp/ztBgDXWaotwYu8GK7AmSFgSlKv
         kPbrYmWW9/r+bMdm5GbJyIDwY2rym7M9bdP3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689928170; x=1690532970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqcAnVxpvMo7IksBTYj7fHRMjHClyEVoFOPZWnp2zrc=;
        b=lgRaBbONlQX+r0J9foX8T7CWWmly6rFAaWVqQzP5sMQHIc8twXle5x+IfkzpVYbyuq
         2StNkbK1bMkAmzcpyJI42ht3S6eF7GoBYWNxwucdmcjW7py2B756AIB9hnmEPjeYS3hu
         xbDDqe7QCfys9gieAuf25U9Hd0LDUpmPjvlEeZZabv8O5HyeI7Op7bpVxAdtRZKpJIuc
         pzpaIXiIQqJsPqTS25hyV3RCLL0jUXjIRuJpiPTNy7S4Co3NtUJLuulK+nUzJywO6KbN
         4QWVuT7vj2j/6sh7y187v0lqud6ygW019UTv0dZM47UKQzM/5tDH/dZ468TSyrOwtfUi
         WCPg==
X-Gm-Message-State: ABy/qLbpJmrd8k7BgYI0YpI9Ds2C2HrT7NTMJ6/5U8a2Es4rKZ26GJ+B
        gW0chI+PztONammpI8qdGfBKKw==
X-Google-Smtp-Source: APBJJlE5WyToH7m3ndabro+eq52oSmJ/JsGYQfuT01AgpnGmcl+yZvTY8UCuBx5ycfIiD0RBXTC3mg==
X-Received: by 2002:a05:6e02:164e:b0:345:d0c1:12b5 with SMTP id v14-20020a056e02164e00b00345d0c112b5mr1535037ilu.26.1689928170285;
        Fri, 21 Jul 2023 01:29:30 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6d86:d21:714:abab])
        by smtp.gmail.com with ESMTPSA id d26-20020a63991a000000b0055fe64fd3f4sm2594382pge.9.2023.07.21.01.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 01:29:29 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 1/7] mfd: mt6358: Add missing registers for LDO voltage calibration
Date:   Fri, 21 Jul 2023 16:28:53 +0800
Message-ID: <20230721082903.2038975-2-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230721082903.2038975-1-wenst@chromium.org>
References: <20230721082903.2038975-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the LDOs, except the "VSRAM_*" ones, on the MT6358 and MT6366
PMICs support a finer output voltage calibration within the range of
+0 mV to +100 mV with 10 mV step. Some of the registers for this
function are missing from the register table.

Add the missing ones for MT6358.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 include/linux/mfd/mt6358/registers.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/mfd/mt6358/registers.h b/include/linux/mfd/mt6358/registers.h
index 3d33517f178c..5ea2590be710 100644
--- a/include/linux/mfd/mt6358/registers.h
+++ b/include/linux/mfd/mt6358/registers.h
@@ -262,6 +262,12 @@
 #define MT6358_LDO_VBIF28_CON3                0x1db0
 #define MT6358_VCAMA1_ANA_CON0                0x1e08
 #define MT6358_VCAMA2_ANA_CON0                0x1e0c
+#define MT6358_VFE28_ANA_CON0                 0x1e10
+#define MT6358_VCN28_ANA_CON0                 0x1e14
+#define MT6358_VBIF28_ANA_CON0                0x1e18
+#define MT6358_VAUD28_ANA_CON0                0x1e1c
+#define MT6358_VAUX18_ANA_CON0                0x1e20
+#define MT6358_VXO22_ANA_CON0                 0x1e24
 #define MT6358_VCN33_ANA_CON0                 0x1e28
 #define MT6358_VSIM1_ANA_CON0                 0x1e2c
 #define MT6358_VSIM2_ANA_CON0                 0x1e30
-- 
2.41.0.487.g6d72f3e995-goog

