Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCB67C9B4B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjJOUN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjJOUNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:13:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF35B7;
        Sun, 15 Oct 2023 13:13:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-98377c5d53eso581530566b.0;
        Sun, 15 Oct 2023 13:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697400832; x=1698005632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DT1W8gUSuxT3Wwy3qW2e2tPQ4NkLWmb+aTGBrsPTZaY=;
        b=DNtQw7ocVHhbwP3gIBKkhIhpZX3BiAxtUxi9MasJuIPkip4XUOA/Egy5rS5M7AmZgc
         fcEwHRQoUTvUMtKXV1nRDDKCFjIdcC9Nr6QOWxU6J7I+f/hM3hvAtVTmUhm9i3/vfVFr
         6qPlZufVHyvnDLPADEAw2cwSNGYXh6IJPgAWbVYbrwb1ccLCt+hPiIpVCFuIjGUJY2jC
         LrO7S2PRL/4xYaoVuDvqok2uZd0h7a+DytgrMCQtTcW6BtmuDOb2t+WiCle4yIevaGjF
         Qy25Pwu12EWSAfWdr6r2baKFfdoh48EHjveh2aQ7pyzxqRQTHtXzRDGmjhi13PsE+L0I
         n2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697400832; x=1698005632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DT1W8gUSuxT3Wwy3qW2e2tPQ4NkLWmb+aTGBrsPTZaY=;
        b=h+XnR53AZNzEmHqmeJa1dCaXqaV+NACbkLax6M3l0+WlptOZmqZZrSarBH8y2FMwCc
         bT6iv3u74AbHKFMzhzguVsT0Zqsjbnf8MKYhzPNiHZ3XcTorIBOpttxwI+vqV5cmISMS
         Fu0RP7oWAiwUsL7sS128q//G9ZGHbFkypu9YWhYE/CBAvzH05qB8kat6SKv15yblqbrI
         linCcsfJX60dPd9kKFUoFKH3rQE3SMBCr+CaBR7soQaluOAkSVg3DfVGlMi0tYAipnyp
         MkUTMJB+M6pMgARN1bw9JQjxa9csXkj65LTsDuCHwru1XNisnKeT5bkraYoxsXqiUeOt
         vKtA==
X-Gm-Message-State: AOJu0Yzau2YtT1wz57VNenPM2sHR98vS4+4tdcy7ALpUnEaDHiwW1qW6
        x1AM7F/p3m26e7//OsPa57yQZWbCLt8WEvs=
X-Google-Smtp-Source: AGHT+IEXViXuLbUs9s+KmzkE5bixqlOmue7yjzSoBKZULy7e0QSO4Sw9iKCVoEKX9cfxdOgfcgIHTQ==
X-Received: by 2002:a17:907:a0d:b0:9c0:99c4:79e8 with SMTP id bb13-20020a1709070a0d00b009c099c479e8mr1751940ejc.6.1697400831619;
        Sun, 15 Oct 2023 13:13:51 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine.localdomain ([105.163.157.6])
        by smtp.gmail.com with ESMTPSA id m10-20020a170906234a00b009ae587ce133sm2721766eja.188.2023.10.15.13.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 13:13:50 -0700 (PDT)
From:   Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     anonolitunya@gmail.com, outreachy@lists.linux.dev,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] staging: sm750fb: Renaming camelcase to snakecase
Date:   Sun, 15 Oct 2023 23:12:33 +0300
Message-ID: <cover.1697400022.git.anonolitunya@gmail.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb
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

Renames various function names and variable names that were previously
in camelcase to snakecase to ensure consistent naming styles.This issues
were highlighted by checkpatch.

Dorcas AnonoLitunya (5):
  Staging: sm750fb: Rename displayControlAdjust_SM750E
  Staging: sm750fb: Rename pModeParam
  Staging: sm750fb: Rename displayControl
  Staging: sm750fb: Rename programModeRegisters
  Staging: sm750fb: Rename ddk750_setModeTiming

 drivers/staging/sm750fb/ddk750_mode.c | 90 +++++++++++++--------------
 drivers/staging/sm750fb/ddk750_mode.h |  2 +-
 drivers/staging/sm750fb/sm750_hw.c    |  2 +-
 3 files changed, 47 insertions(+), 47 deletions(-)

-- 
2.42.0.345.gaab89be2eb

