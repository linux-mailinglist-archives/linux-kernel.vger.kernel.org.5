Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD13E79EF04
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjIMQnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjIMQmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:42:53 -0400
Received: from smtp71.iad3a.emailsrvr.com (smtp71.iad3a.emailsrvr.com [173.203.187.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBD63A97
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694623228;
        bh=I0B20dZMkjYKat14tZVtw7la5InFdaiAteuV0o6c5t4=;
        h=From:To:Subject:Date:From;
        b=xvz/NYupvz/u8jsBANLG7N4Y6Pd1f5yMOJZxd2L4lW/h7agyQS8iJSZ9MV7LGDgL2
         Y98JdTe8OCwY+c7g3qkf7RUakghXzRPDJyKUbEIZcRyR6HlJ2D1Q7Qirp2Z1/rnEKH
         AFsubvpxnhmW+HuxWDlJXmLmVTLjJOYpUZ8TUknc=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp25.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id A3430239DD;
        Wed, 13 Sep 2023 12:40:27 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v2 01/13] comedi: Correct dependencies for COMEDI_NI_PCIDIO
Date:   Wed, 13 Sep 2023 17:40:01 +0100
Message-Id: <20230913164013.107520-2-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913164013.107520-1-abbotti@mev.co.uk>
References: <Message-Id: <20230913113247.91749-1-abbotti@mev.co.uk>
 <20230913164013.107520-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: bb5231ff-a70f-4c9d-8b55-93f03f91465d-2-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ni_pcidio module does not depend on the comedi_8255 module, so
change the `COMEDI_NI_PCIDIO` configuration option to not select
`COMEDI_8255` and remove the inherited dependency on `HAS_IOPORT`.

Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
v2: N/A
---
 drivers/comedi/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/comedi/Kconfig b/drivers/comedi/Kconfig
index 9af280735cba..536101f68e0f 100644
--- a/drivers/comedi/Kconfig
+++ b/drivers/comedi/Kconfig
@@ -1042,7 +1042,6 @@ config COMEDI_NI_PCIDIO
 	tristate "NI PCI-DIO32HS, PCI-6533, PCI-6534 support"
 	depends on HAS_DMA
 	select COMEDI_MITE
-	select COMEDI_8255
 	help
 	  Enable support for National Instruments PCI-DIO-32HS, PXI-6533,
 	  PCI-6533 and PCI-6534
-- 
2.40.1

