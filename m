Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A0F76C96B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbjHBJZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjHBJZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:25:10 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB461723;
        Wed,  2 Aug 2023 02:25:07 -0700 (PDT)
X-QQ-mid: bizesmtp82t1690968301toujdzgr
Received: from dslab-main2-ubuntu.tail147f4.ts ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Aug 2023 17:24:59 +0800 (CST)
X-QQ-SSF: 01200000000000705000000A0000000
X-QQ-FEAT: C46Rb8GPIEcwTNFcAxvTxh1n8OgQwU1nyZED9XU+OxgEETOwsWFWc+kM9+z4v
        ykMlyCM/mUVqdw1Kxro6wt0SL4V10aMCWZuYZ6ig3PTYazuv9asxo58VkoHlzjS0a+8jXHv
        xGrYRExYANCDMvBh+rhgagrn7CzCy7mGLjvT+P5IfQFyyzc2iicUSHeWieheo9jxapJYwgE
        tFSwZSy7dy1taDlmwDnFZXD8qBp5Vq73uE/BW5QukfYyIFBEfGDknsQDIyONMLBvOzA7d9T
        cKws0bkZE8yTeVp4hB9ar7dVZQJD53jeidnZPQI246HG3tEAnU86GwkrOUEk2JV7jk0FGeh
        zTBwrx0ZsIZn4pHaBHYfDEHqEOpzg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4205973809664876242
From:   Yuan Tan <tanyuan@tinylab.org>
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@weissschuh.net, w@1wt.eu, falcon@tinylab.org,
        tanyuan@tinylab.org
Subject: [RFC 0/1] mips: malta: Select PCI_QUIRKS if POWER_RESET_PIIX4_POWEROFF is enabled
Date:   Wed,  2 Aug 2023 17:24:57 +0800
Message-Id: <cover.1690968173.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

I just found that the on QEMU Malta, POWER_RESET_PIIX4_POWEROFF relay on
PCI_QUIRKS to work, or else the reboot will hang.

Welcome everyone's suggestions.

Yuan Tan (1):
  mips: malta: select PCI_QUIRK for POWER_RESET_PIIX4_POWEROFF

 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
2.34.1

