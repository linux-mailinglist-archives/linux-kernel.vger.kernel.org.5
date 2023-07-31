Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975CF769306
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjGaKXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjGaKXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:23:03 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF101E8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:23:01 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=6590db4e63=fe@dev.tdt.de>)
        id 1qQPkq-00G4d9-C0
        for linux-kernel@vger.kernel.org; Mon, 31 Jul 2023 12:03:56 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qQPkp-00G4cl-W1
        for linux-kernel@vger.kernel.org; Mon, 31 Jul 2023 12:03:56 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 55586240049
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:03:54 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 10792240040;
        Mon, 31 Jul 2023 12:03:54 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 7D2E121055;
        Mon, 31 Jul 2023 12:03:53 +0200 (CEST)
From:   Florian Eckert <fe@dev.tdt.de>
To:     mturquette@baylibre.com, sboyd@kernel.org, yzhu@maxlinear.com,
        rtanwar@maxlinear.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Eckert.Florian@googlemail.com
Subject: [PATCH 0/2] clk: mxl: add mxl,control-gate dts property
Date:   Mon, 31 Jul 2023 12:03:47 +0200
Message-ID: <20230731100349.184553-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate-ID: 151534::1690797836-3EC89A8C-BEE7426C/0/0
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gate clocks can be controlled either from this cgu clk driver or directly
from power management driver/daemon. It is dependent on the power
policy/profile requirements of the end product. To take control of gate c=
lks
from this driver.

Until now, the source code had to be changed for this purpose by adding t=
he
flag 'GATE_CLK_HW' to the LGM_GATE macro in the source file
'drivers/clk/x86/clk-lgm.c'.

This can be better handled via the device tree, so that the source no
longer needs to be changed. For this purpose, a new option
'mxl,control-gate' is added, which specifies that the gate is controlled
by this driver.

Florian Eckert (2):
  clk: mxl: add mxl,control-gate dts property
  dt-bindings: clock: intel,cgu-lgm: add mxl,control-gate option

 .../bindings/clock/intel,cgu-lgm.yaml         | 11 +++++++
 drivers/clk/x86/clk-cgu.c                     | 30 +++++++++++--------
 2 files changed, 28 insertions(+), 13 deletions(-)

--=20
2.30.2

