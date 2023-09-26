Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FB77AF1FD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbjIZRwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjIZRwN (ORCPT
        <RFC822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:52:13 -0400
X-Greylist: delayed 949 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Sep 2023 10:52:04 PDT
Received: from smtp1.ms.mff.cuni.cz (smtp1.ms.mff.cuni.cz [IPv6:2001:718:1e03:801::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23B09F;
        Tue, 26 Sep 2023 10:52:04 -0700 (PDT)
Received: from localhost (internet5.mraknet.com [185.200.108.250])
        (authenticated)
        by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 38QHZev2083218
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 19:35:42 +0200 (CEST)
        (envelope-from balejk@matfyz.cz)
From:   Karel Balej <balejk@matfyz.cz>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     Karel Balej <balejk@matfyz.cz>
Subject: [PATCH 0/2] input: Imagis: add support for the IST3032C touchscreen
Date:   Tue, 26 Sep 2023 19:35:22 +0200
Message-ID: <20230926173531.18715-1-balejk@matfyz.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series extends the Imagis driver to support the IST3032C
touchscreen, which is used for instance with the samsung,coreprimevelte
smartphone, with which this was tested. To use it with this model
however, the regulator driver needs to be ported first. Support for this
smartphone is not yet in-tree, upstreaming is ongoing at [1].

[1] https://lore.kernel.org/all/20230812-pxa1908-lkml-v5-0-a5d51937ee34@skole.hr/

Karel Balej (2):
  input: generalize the Imagis touchscreen driver
  input: Imagis: add support for the IST3032C touchscreen

 ...gis,ist3038c.yaml => imagis,ist30xxc.yaml} |  3 +-
 MAINTAINERS                                   |  2 +-
 drivers/input/touchscreen/Kconfig             |  4 +-
 drivers/input/touchscreen/imagis.c            | 99 ++++++++++++-------
 4 files changed, 66 insertions(+), 42 deletions(-)
 rename Documentation/devicetree/bindings/input/touchscreen/{imagis,ist3038c.yaml => imagis,ist30xxc.yaml} (97%)

-- 
2.42.0

