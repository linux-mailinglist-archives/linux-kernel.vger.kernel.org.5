Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A6979E6D1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbjIMLdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240303AbjIMLdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:33:12 -0400
Received: from smtp73.iad3a.emailsrvr.com (smtp73.iad3a.emailsrvr.com [173.203.187.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F5C19AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694604787;
        bh=v3aK3FoFe0rbk7xMjyVqCexNZz6vZAGZMldnWIt2KP8=;
        h=From:To:Subject:Date:From;
        b=EsBzIbjSmot/+k79+EO6NyR9V3ZW9PHB/6MfoM8q0ksERKPxb/YWBULzWEe2CguTT
         vvigYt9NRH7UrewRUx/zYLeszBrjZgcHSbaujk0FP7NJ6YRssOlIgv/ZxYILnbTb4f
         PbwuCOzsVcE7l6VQuQR4L1v3bg0s3LT9bMXe0znU=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp26.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id EFBB63B56;
        Wed, 13 Sep 2023 07:33:06 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 01/13] comedi: Correct dependencies for COMEDI_NI_PCIDIO
Date:   Wed, 13 Sep 2023 12:32:35 +0100
Message-Id: <20230913113247.91749-2-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913113247.91749-1-abbotti@mev.co.uk>
References: <20230913113247.91749-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 007ec4bd-2574-475a-9bbd-5a4f93b29aec-2-1
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

