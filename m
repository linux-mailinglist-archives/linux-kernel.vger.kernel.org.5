Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B9679EFD6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjIMRHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjIMRH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:07:27 -0400
Received: from smtp114.iad3a.emailsrvr.com (smtp114.iad3a.emailsrvr.com [173.203.187.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BDBDC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694624842;
        bh=hq5cTMt8hRdDEQ0+Y7ze+kwKAo7GTgiStcd2TgJocNc=;
        h=From:To:Subject:Date:From;
        b=Jtk8m/NCHvZqNlH+MtVKNh+a8dfAiomkx8cJDY7loAU64cTfq+tmXFjLERzeejBfH
         CwsZ4x5WL6fiSVO+hUuGpPHXN1d180jOhRX+2zW21b2V57glM+mLsqML/GO96zXqaU
         7XPC8/tW4mwqUB+YKNNEzYTUO+VLu1AMuzcag6v4=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp39.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id DAFD554E5;
        Wed, 13 Sep 2023 13:07:21 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v3 01/13] comedi: Correct dependencies for COMEDI_NI_PCIDIO
Date:   Wed, 13 Sep 2023 18:07:00 +0100
Message-Id: <20230913170712.111719-2-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913170712.111719-1-abbotti@mev.co.uk>
References: <20230913164013.107520-1-abbotti@mev.co.uk>
 <20230913170712.111719-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 19793052-af61-4898-a406-82596fa230be-2-1
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
v2: N/A.
v3: N/A.
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

