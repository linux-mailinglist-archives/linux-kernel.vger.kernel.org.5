Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B697CDBAB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjJRMaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjJRMan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:30:43 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE4698
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:30:42 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507a3b8b113so5507510e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697632240; x=1698237040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XlWVy8FnYNsiroEYg/XCM/swGlknLzbUla9FpYNTLwI=;
        b=Y7RYRxwOici1EhBopn6TTLdjT0dBp5gZH8pLzvrGZLnPCX11FKzSyo5TblpXbU29hG
         ZGrcHAI6mCbpygbt3cJLhTGbqyVGeKceS11Eqql2I2SSSgXhaEiJ+eHibrN26+//AjLa
         5v3816xGB8uqNqSLm7XuocdwGmdiCLS3HQJshXSOaknVldNOzDQEZmSuAc/y85qR59oG
         INHqBC7p1nWxG9XGMiLchVvdHF1dxMwGMVq1rS7+azZ966yXGOSX9pVcqOzbSqyF5uQq
         f76Owr8zXAd7FVss46k65z3qKcR5U/wcSvol/TykoMQisXNud8WOj3h2u3RxThScOZ9Y
         5wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632240; x=1698237040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XlWVy8FnYNsiroEYg/XCM/swGlknLzbUla9FpYNTLwI=;
        b=XkAKiySev6aOOEp4FEJsozLS1MK5CDbmZSXOrm7N/atWiOzrMWhpGbwtRqVXqDITG4
         VZze138786NkytLRanFjgP9U34M9mMPX6IH10FNcpCUVQARsZbc7kD+oFEcbieXfDEnr
         HxxpsjEQ+jGRBn+z6+EvlKazr1T/pqppZICHgESYPXvSzlSCgWc8rw1SM0nW69X5/RLS
         R90lay+pFSaAqjnZBg/P+NIUFvGwmdSVhRS3YAXpTkPcY4NniHDsYSoEA4AE297DaQIw
         pgqMapvwTek4nhewSVSy57r7AFSL58mw60vLQUmmG+z0ORGFV3uIQ1C7xfd5+MTXd06f
         kKjQ==
X-Gm-Message-State: AOJu0Yz5px1MYjP9uTBdkxXQJ01Z/bmRC2TfLO4uRsWajhr9oMO1eoZZ
        Q31GvYy2pEm9AZNSemBcUufGXEra+4Q=
X-Google-Smtp-Source: AGHT+IGG2PMd+DSKIh+wlGtwWGHRQT6tSYHStRv4TH+Nk562cqZRcbv9ANqWkMb0J7I2EUaYTiPpMA==
X-Received: by 2002:ac2:4141:0:b0:507:a766:ad29 with SMTP id c1-20020ac24141000000b00507a766ad29mr3896962lfi.12.1697632239570;
        Wed, 18 Oct 2023 05:30:39 -0700 (PDT)
Received: from debian.localdomain (mm-47-218-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.218.47])
        by smtp.googlemail.com with ESMTPSA id t8-20020ac243a8000000b005009b4d5c14sm679565lfl.265.2023.10.18.05.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:30:39 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH 0/6] This is continued work on Samsung S9(SM-9600) starqltechn
Date:   Wed, 18 Oct 2023 15:30:27 +0300
Message-Id: <20231018123033.301005-1-dsankouski@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


- Samsung s2dos05 pmic driver added
- touchscreen support
- usb 2.0 support
- some cleanup



Dzmitry Sankouski (6):
  dt-bindings: regulator: add Samsung s2dos05 pmic
  regulator: s2dos05: add Samsung s2dos05 driver
  arm64: dts: qcom: starqltechn: remove wifi
  arm64: dts: qcom: starqltechn: enable more features
  arm64: dts: qcom: starqltechn: disable crypto
  arm64: dts: qcom: starqltechn: add supply to framebuffer

 .../bindings/regulator/samsung,s2dos05.yaml   |  89 +++
 .../dts/qcom/sdm845-samsung-starqltechn.dts   | 205 +++++-
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/s2dos05.c                   | 601 ++++++++++++++++++
 include/linux/regulator/s2dos05.h             | 173 +++++
 6 files changed, 1067 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/samsung,s2dos05.yaml
 create mode 100644 drivers/regulator/s2dos05.c
 create mode 100644 include/linux/regulator/s2dos05.h

-- 
2.39.2

