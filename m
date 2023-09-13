Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3798B79E680
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239970AbjIMLU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239949AbjIMLUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:20:54 -0400
Received: from smtp111.iad3b.emailsrvr.com (smtp111.iad3b.emailsrvr.com [146.20.161.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A5A1BD1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694604050;
        bh=v3aK3FoFe0rbk7xMjyVqCexNZz6vZAGZMldnWIt2KP8=;
        h=From:To:Subject:Date:From;
        b=idC6q1L/xJx+m2SryXYzMx8LfGjuggrDRqxVypfoTOfOh7FT6mz1TpzxO/12b+obs
         FerddNBu0A8SReknsk8/u+TVyYYOsPrN3pkWgRBCTx/o8Y5lQPAI07ovnwCE5xgIXf
         bM7Jq4FRJDD5IIygaUuKMpRg7hcGXDFHYHRP+e2U=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp6.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 6292B200CF;
        Wed, 13 Sep 2023 07:20:49 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 01/13] comedi: Correct dependencies for COMEDI_NI_PCIDIO
Date:   Wed, 13 Sep 2023 12:20:20 +0100
Message-Id: <20230913112032.90618-2-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913112032.90618-1-abbotti@mev.co.uk>
References: <20230913112032.90618-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: e346d63c-f057-4595-b974-8be9cf32e1c1-2-1
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

