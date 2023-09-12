Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2151B79DBBB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbjILWP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjILWP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:15:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4D510D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=NIxqE6FO3o0CdOEr4cjgDYr7N/uQ/DrL4AkGZwEHTu8=; b=hn2YVqcbHWqeqqP7MmMWcU3nEn
        0el62pWkKyH9Fwy/jU8ypzwa2Zp5VRK2ogfpTiRd+97hTCnzI1Qy6edA4E7+Ca6aKmANUpPI2JqRl
        lRiw2GAD+hFW201bCqdYgMy9UQCjuX6tufNX5FeuCEIEPXe5wWScQ+994znoQyk+C8eZxc3RzfOwk
        MV7ADONj34KUhicu/sDg7cai3DXZRPO5k9lNtibLjYI2jraLtcFepWJt8hdPbI3VzPq7Yjeulkwwp
        SYLPd7Z18+PxVrV1BrBJBllRScDQ40EsCG2Wptn+Cqc/4Tb35R+BBb6/XK9//iLQr68piTe6T3pPf
        3BskT9jA==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgBfi-004B9h-0V;
        Tue, 12 Sep 2023 22:15:50 +0000
Message-ID: <c3981a8d-de56-448d-adb5-6685530b85f7@infradead.org>
Date:   Tue, 12 Sep 2023 15:15:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] soc/aspeed: Add host side BMC device driver
Content-Language: en-US
To:     Ninad Palsule <ninad@linux.ibm.com>, joel@jms.id.au,
        andrew@aj.id.au, eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
References: <20230912220923.3701688-1-ninad@linux.ibm.com>
 <20230912220923.3701688-2-ninad@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230912220923.3701688-2-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
index f579ee0b5afa..8a4f096d84cd 100644
--- a/drivers/soc/aspeed/Kconfig
+++ b/drivers/soc/aspeed/Kconfig
@@ -52,6 +52,17 @@ config ASPEED_SOCINFO
 	help
 	  Say yes to support decoding of ASPEED BMC information.
 
+config ASPEED_HOST_BMC_DEV
+	bool "ASPEED SoC Host BMC device driver"
+	select SOC_BUS
+	default ARCH_ASPEED
+	depends on PCI
+	help
+	  Say yes to support PCIe based VUARTs from the host side. The end to
+          end VUART communication between host and BMC requires BMC side driver
+	  to activate VUART functionality. This is a driver for the BMC device
+          on host.

~~~
Please clean up that indentation. Consistently use one tab + 2 spaces,
as documented in coding-style.rst.

Also, can this be tristate instead of bool?  If not, why not?

Thanks.
-- 
~Randy
