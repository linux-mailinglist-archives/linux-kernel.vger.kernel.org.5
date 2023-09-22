Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428BD7ABBE2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 00:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjIVWkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 18:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjIVWki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 18:40:38 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786CBAB;
        Fri, 22 Sep 2023 15:40:32 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bff936e10fso53204691fa.1;
        Fri, 22 Sep 2023 15:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695422430; x=1696027230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=le0OuGLsU3JORmn3p7Lmf2Z/hHnqT/ugH7hRtzH6LxQ=;
        b=VQ2CbanKv/y+S3qFay2hLPOMz7NDjTPdjQL2TGbONQMDddvp74AE8ReCGtGNKF+QZu
         n0dG4tpmTNL+TsRyiKkl3l1ba/aOG8u137/AcfpTBoZRXT53n34TW8Dq9SThetRqtGkg
         nqt7zEXRbX95JXuhMZYZP3IZmz3cpn01ddQyznTPpd7vpjU2BUnPtbLsVKQvHyOKwAnc
         Ga+o0gVELjR+cGltoAHeJHFU9vmHaUDPZ9hgedRT7lB2CID+/PcF6CSKw0dk5hPto4d6
         na1OlC+yuPvL0Nl5m0D3jNgvSPO7WjVQpFL/6K0EUrnKJUiBMS3jDe+6GrSi/6kOKzlU
         OvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695422430; x=1696027230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=le0OuGLsU3JORmn3p7Lmf2Z/hHnqT/ugH7hRtzH6LxQ=;
        b=AUnsamZ2qZb/i7R9BwieDzCD9V061j/Slelq4FEhiGDBpODMcGav+VqjOOY23FHJlr
         kK/uofZ+zcA2/1GMuizPK+omjp+KHjLpdSQSnUJwagmOENQIX5ZcCfyPLQx6zw4p7jN1
         1jnHEudxkVovv3VMHB4UeFKceR4BQ0IEqXdWhLE1HcUo2ZLr215hAo4XuMVj2biqbwr8
         tgH+UF1ucFLn0bQ2yGrlIn7hvaqeF1Oqr1zqlN1TGu6faNeYuQ7pt8+tHbx44bBX24I7
         7+I534/btZswDSQl4AcPt8ryez4poQfxIT/HWFn0d3wOi2Js8clfS4bQZgjVo73LjIqb
         nNDQ==
X-Gm-Message-State: AOJu0YzNtpL0nlXe6SYuMHdbk02rZ90y4/dieDXVh4ZruNj9l+PvwyUo
        Zbe3LLr626msvrmpqBiWnxkAXflzmCcPdQ==
X-Google-Smtp-Source: AGHT+IGfox4cCDsOyrpaBMMVcmAZCPptsa9iQRPcQ8PPTjFnO/9MEZSoy4+ERHQKvwSXIJfy4VUtkQ==
X-Received: by 2002:a2e:3513:0:b0:2bc:dd8f:ccd7 with SMTP id z19-20020a2e3513000000b002bcdd8fccd7mr340846ljz.16.1695422430436;
        Fri, 22 Sep 2023 15:40:30 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id j2-20020a2e8502000000b002bfec05a693sm1090423lji.22.2023.09.22.15.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 15:40:29 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] MPM pin mappings for MSM8226 and MSM8974
Date:   Sat, 23 Sep 2023 01:40:25 +0300
Message-Id: <20230922224027.85291-1-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the MPM wakeirq mappings for MSM8226 and MSM8974.

Matti Lehtimäki (2):
  pinctrl: qcom: msm8226: Add MPM pin mappings
  pinctrl: qcom: msm8974: Add MPM pin mappings

 drivers/pinctrl/qcom/pinctrl-msm8226.c | 12 ++++++++++++
 drivers/pinctrl/qcom/pinctrl-msm8x74.c | 12 ++++++++++++
 2 files changed, 24 insertions(+)

-- 
2.39.2

