Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317CD7CB46D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbjJPUQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjJPUQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:16:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F52EA;
        Mon, 16 Oct 2023 13:16:20 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a6190af24aso819919166b.0;
        Mon, 16 Oct 2023 13:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697487379; x=1698092179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mog/BonNox2pvkdSIDtH1hNgJSkOylthKpgqbZnc1SM=;
        b=XvP9jB6pDqSc5GFCF4vnkoFP2UtqP8vzFgrW3F/s6x/fAUUMfAignVZ2F+qOHnX5iX
         iy2wykasnDNqdEAG1M+ic5nCVzR1iShRByesbRbsEIUTC3jW8EnIweAtpjPvb8YYtveE
         gGq/elbktVJ7201RsMhIhnfxrMQ0m0Z1kYw9+0eWbOTn8mcCeA9oRaz0eiAg6GEnSalt
         b4Z/YeghnBJQoevJqtaaUS+mf0NXmlskkgZuhmPqfImYWBEpQgjDx392rdPb6Bz9pmbO
         OW7obXRbPnyEuow/Gca7EzRld8DswdtE1ytD/CX2lqX/rWHFZ6/hllb2n9BSddzUuJ+2
         DDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697487379; x=1698092179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mog/BonNox2pvkdSIDtH1hNgJSkOylthKpgqbZnc1SM=;
        b=iVE+wvnX5d3SDZwc+NXH9HiaY7tvf7K5FR2MuufEqOojiZhtrSk2k4hhvZcTCO0ScZ
         QYRXvu6+0sSB8EBWSrmPtBuk8zZMCn+gcI4xYutKrb7w61hJTGwFTk4XvL/+gbgGcH8P
         IQScPyLxidpvjhTlWZCSjRbCL/eQ7GNSrtMBOZ5abhq8zC+ZDGh+OMVa38na4h0EcKIU
         sK2eRRYqzrEPPtyebldnnupB7mr/frkb8aBI41SiW/iKhBaM+C5gCpmH2xig5WOoTFi6
         qiNa9aN7AVS3wrfs/KSrscluHJhyfnN8W3uqfPxyf+P/7SwNJbo57JVXCt3M2q2neXbc
         y9rA==
X-Gm-Message-State: AOJu0Yy1+eZb45n9Nq6E4NQQrXaycW7jj14xnmVbDpwqaVpb+J/ESZ5y
        0ErbESpECNgj1D4ONZUH+w==
X-Google-Smtp-Source: AGHT+IGfqRKbTT1hBq+q2DfgykI2vT3cOjnlG6SZIJyHPXxi80bQhTSGcqlLMKAzWcEyjpWTAaLTzA==
X-Received: by 2002:a17:907:a09:b0:994:555a:e49f with SMTP id bb9-20020a1709070a0900b00994555ae49fmr81690ejc.31.1697487378908;
        Mon, 16 Oct 2023 13:16:18 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine.localdomain ([105.163.1.143])
        by smtp.gmail.com with ESMTPSA id u26-20020a17090657da00b009b97521b58bsm4606055ejr.39.2023.10.16.13.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:16:18 -0700 (PDT)
From:   Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     anonolitunya@gmail.com, outreachy@lists.linux.dev,
        julia.lawall@inria.fr, dan.carpenter@linaro.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] Staging: sm750fb: Rename programModeRegisters
Date:   Mon, 16 Oct 2023 23:14:11 +0300
Message-ID: <20231016201434.7880-5-anonolitunya@gmail.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb
In-Reply-To: <20231016201434.7880-1-anonolitunya@gmail.com>
References: <20231016201434.7880-1-anonolitunya@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function programModeRegisters to program_mode_registers. This
follows snakecase naming convention and ensures a consistent naming style
throughout the file. Issue found by checkpatch.

Mutes the following checkpatch error:
CHECK: Avoid CamelCase: <programModeRegisters>

Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index fc3db09de9ae..e901855fa9b6 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -75,8 +75,8 @@ display_control_adjust_SM750LE(struct mode_parameter *mode_param,
 }
 
 /* only timing related registers will be  programed */
-static int programModeRegisters(struct mode_parameter *mode_param,
-				struct pll_value *pll)
+static int program_mode_registers(struct mode_parameter *mode_param,
+				  struct pll_value *pll)
 {
 	int ret = 0;
 	int cnt = 0;
@@ -220,6 +220,6 @@ int ddk750_setModeTiming(struct mode_parameter *parm, enum clock_type clock)
 		outb_p(0x88, 0x3d4);
 		outb_p(0x06, 0x3d5);
 	}
-	programModeRegisters(parm, &pll);
+	program_mode_registers(parm, &pll);
 	return 0;
 }
-- 
2.42.0.345.gaab89be2eb

