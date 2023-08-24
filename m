Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885F078743B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242185AbjHXPb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242201AbjHXPbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:31:12 -0400
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CA419B7;
        Thu, 24 Aug 2023 08:31:09 -0700 (PDT)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id EC7968CC7F6; Thu, 24 Aug 2023 17:31:07 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        azkali <a.ffcc7@gmail.com>, Adam Jiang <chaoj@nvidia.com>,
        CTCaer <ctcaer@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add a driver for the ROHM BM92Txx USB-C Power Delivery controller
Date:   Thu, 24 Aug 2023 17:30:52 +0200
Message-ID: <20230824153059.212244-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
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

The BM92T36 is used as the USB-C Power Delivery controller of the
Nintendo Switch.  This has been tested on a downstream 6.0 kernel[0] for
now.

[0] https://gitlab.azka.li/l4t-community/kernel/mainline/linux/-/commits/icosa-v6.0

Emmanuel Gil Peyrot (1):
  dt-bindings: misc: rohm,bm92txx: Add BM92Txx support

azkali (1):
  misc: bm92txx: Add driver for the ROHM BM92Txx

 .../bindings/misc/rohm,bm92txx.yaml           |   67 +
 MAINTAINERS                                   |    6 +
 drivers/misc/Kconfig                          |   11 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/bm92txx.c                        | 2403 +++++++++++++++++
 5 files changed, 2488 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/rohm,bm92txx.yaml
 create mode 100644 drivers/misc/bm92txx.c

-- 
2.42.0

