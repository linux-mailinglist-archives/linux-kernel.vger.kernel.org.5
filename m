Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE32786FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbjHXNOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240152AbjHXNNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:13:50 -0400
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2D4198B;
        Thu, 24 Aug 2023 06:13:48 -0700 (PDT)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 7F3AF8CC656; Thu, 24 Aug 2023 15:13:47 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Alexandre Courbot <acourbot@nvidia.com>,
        azkali <a.ffcc7@gmail.com>, CTCaer <ctcaer@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add charger support for the Nintendo Switch
Date:   Thu, 24 Aug 2023 15:13:28 +0200
Message-ID: <20230824131342.206784-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824112741.201353-1-linkmauve@linkmauve.fr>
References: <20230824112741.201353-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These aren’t my patches, but are required in order to charge this
console.  I have tested them on a downstream 6.0 kernel[0] and they seem
to work properly.

This is the first part of a bunch of upstreaming I’m going to do for the
various drivers required to support this console in mainline.

[0] https://gitlab.azka.li/l4t-community/kernel/mainline/linux/-/commits/icosa-v6.0

Changes since v1:
- Split the dt-bindings change into its own patch.
- Add a message to the second patch.
- Add my own SoB.
- Remove a left-over dev_info().

Alexandre Courbot (2):
  power: supply: bq24190_charger: Support bq24193
  power: supply: bq24190_charger: Export current regulator

Emmanuel Gil Peyrot (1):
  dt-bindings: power: supply: bq24190: Add ti,bq24193

 .../bindings/power/supply/bq24190.yaml        |  1 +
 drivers/power/supply/bq24190_charger.c        | 84 +++++++++++++++++++
 2 files changed, 85 insertions(+)

-- 
2.42.0

