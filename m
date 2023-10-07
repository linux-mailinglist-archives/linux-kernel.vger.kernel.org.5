Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4A97BC4B1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 06:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbjJGEgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 00:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343500AbjJGEgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 00:36:36 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0570DBD;
        Fri,  6 Oct 2023 21:36:34 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-79fa7e33573so114055739f.0;
        Fri, 06 Oct 2023 21:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696653393; x=1697258193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ok8Rh3y2ALFjfV49m+uqoRm3bDzIqJbrPJY0knJ9gwg=;
        b=UVUqHWWGGzj7eh993/JT5iUKgEhCg5HQ9+nTj1HgD0JP4eaKTzMN/9aQdgBdmTnGfS
         lCMZWn2Zj8AuH8AFhS9LZm5lApx1e9BcamXmSLnoMLbwEN+7OnnrAqNrF1Zj2ieqBcvy
         UA9L+9tEWq9ID29Z+yGgPWXO1FkMiM2hWiMpjfX49DvaEGFufeMWjnbKvntDbL/F8Ewq
         oEDKmXNpOwwiaLKiSuW+1zoCHmNfC0+MAOZIBkF14lCE3fZ5HEWKUYF5H89hCAI900Ht
         q/SPLz8GQd7kXYsRvaysu0NZ27aksNIF8DIveJOPbkmwdjlLSerIeFfEWJ1VlJWS2K3v
         GyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696653393; x=1697258193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ok8Rh3y2ALFjfV49m+uqoRm3bDzIqJbrPJY0knJ9gwg=;
        b=WjGrnsCUesgMRnzXqLXZZvhgE/uDKOnOuM6Sdke4x5l1lG5M/Ip515i8UrnuVGCsep
         yhZCUpkjczr7D+o7ED3j5pKL9T7D3thUrogJPztaR6/QkLqtrOkdnsADgfClEGd1Do/x
         gs2Qpwd9elEgrKr4Yy6mrknGntmMtTXeJzTZHD5ku3gcIjOtIBe0DzrG22VCoA+5dD/S
         1381v6C4oqkfnHb4I3BNGuo3XexlA1Mv8UyJtyKxBMK9zvPs8JF0ElOlBc/Ux5xFAweI
         9H3MaSnOC3Dosr0rxcWfbk1v1pJaqDBIu8TXre0ybt8swpFfdtkf/CySxQTh7QjN/kQj
         OA6Q==
X-Gm-Message-State: AOJu0YyIXl0FCveBCWvYyLpzpSBirJg/JDujqGA0Fq25FDnnWowDZ+9a
        0Ep+JHlpprNSIdE9av2AsfI=
X-Google-Smtp-Source: AGHT+IGhLckTYtMKqGkgFLX/i8qTq5r32gXSFPHAFcqwx410+Tqa7+Semmsr1IEyMXyqd7aTahHTUg==
X-Received: by 2002:a05:6e02:de8:b0:351:5dea:a596 with SMTP id m8-20020a056e020de800b003515deaa596mr9100722ilj.4.1696653393177;
        Fri, 06 Oct 2023 21:36:33 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:8a60:ad5:1051:21e3])
        by smtp.gmail.com with ESMTPSA id x7-20020a92de07000000b0035129b9c61bsm1520910ilm.45.2023.10.06.21.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 21:36:32 -0700 (PDT)
From:   Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
        Sven Rademakers <sven.rademakers@gmail.com>,
        Lokesh Poovaragan <loki@gimmeapis.com>,
        Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 0/3] Add initial devicetree for Turing RK1
Date:   Fri,  6 Oct 2023 22:35:57 -0600
Message-ID: <20231007043600.151908-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

The Turing RK1 is an upcoming RK3588-based SoM built on the NVIDIA Jetson-style
SO-DIMM form factor, meant for compatibility with Jetson carrier boards
(but by far primarily the Turing Pi 2 cluster board, from the same vendor).

This patch series adds the initial devicetree, which enables most of the card's
I/O functions. I also have USB and thermal management working, but this depends
on other patches that haven't yet made their way upstream.

Reviewers, be on your toes: this is my first DT contribution to the kernel.
Please be tough but patient! :)

Thanks,
Sam

Sam Edwards (3):
  dt-bindings: vendor-prefixes: add turing
  dt-bindings: arm: rockchip: Add Turing RK1
  arm64: dts: rockchip: Add Turing RK1 SoM support

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3588-turing-rk1.dts   | 627 ++++++++++++++++++
 4 files changed, 635 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dts

-- 
2.41.0

