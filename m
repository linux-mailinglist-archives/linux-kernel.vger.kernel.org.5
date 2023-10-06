Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BE07BB881
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjJFNEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjJFNEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:04:46 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED51E9;
        Fri,  6 Oct 2023 06:04:43 -0700 (PDT)
Received: from francesco-nb.corp.toradex.com (unknown [201.82.41.210])
        by mail11.truemail.it (Postfix) with ESMTPA id 2530C20B4D;
        Fri,  6 Oct 2023 15:04:37 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] power: reset: gpio-poweroff: use sys-off handler API
Date:   Fri,  6 Oct 2023 10:04:24 -0300
Message-Id: <20231006130428.11259-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Use the new sys-off handler API for gpio-poweroff. This allows us to have more
than one power-off handler and to have a priority for the handler. Also, add a
priority property so we can use gpio-poweroff even when registering another
poweroff handler or using the legacy pm_power_off method.

v1->v2:
 - Add $ref to restart-handler.yaml in gpio-poweroff.yaml

Stefan Eichenberger (4):
  power: reset: gpio-poweroff: use a struct to store the module
    variables
  power: reset: gpio-poweroff: use sys-off handler API
  dt-bindings: power: reset: gpio-poweroff: Add priority property
  power: reset: gpio-poweroff: make sys handler priority configurable

 .../bindings/power/reset/gpio-poweroff.yaml   |  6 ++
 drivers/power/reset/gpio-poweroff.c           | 82 ++++++++++---------
 2 files changed, 50 insertions(+), 38 deletions(-)

-- 
2.25.1

