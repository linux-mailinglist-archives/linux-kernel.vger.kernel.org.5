Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5647EAFDB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjKNMay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjKNMau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:30:50 -0500
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AEE1AC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:30:44 -0800 (PST)
Received: from Vostro-3710.lan (unknown [58.61.140.31])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 2EB4A80010C;
        Tue, 14 Nov 2023 20:30:18 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     miquel.raynal@bootlin.com
Cc:     amadeus@jmu.edu.cn, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH 1/1] mtd: rawnand: add support for TH58NYG3S0HBAI4 NAND flash
Date:   Tue, 14 Nov 2023 20:30:08 +0800
Message-Id: <20231114123008.185071-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231029144840.484facee@xps-13>
References: <20231029144840.484facee@xps-13>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHh9IVkhMQkJPS09MTR5MTFUTARMWGhIXJBQOD1
        lXWRgSC1lBWU5DVU1KVUpPS1VISllXWRYaDxIVHRRZQVlPS0hVSkxKT05PVUpLS1VKQktLWQY+
X-HM-Tid: 0a8bcdcfa0fbb03akuuu2eb4a80010c
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MS46Pww6GDwrLU9DPjlLMRVL
        MzNPCRJVSlVKTUJCQk1OS0pDQk9CVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWU5D
        VU1KVUpPS1VISllXWQgBWUFKT0hCNwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

> It's more like a request than a question. Please fix the parameter page
> at run time by registering a ->.fixup_onfi_param_page() hook in
> Toshiba's nand_manufacturer_ops structure.

Sorry for the late reply. This flash is not ONFI compliant NAND,
so onfi fixup can't work. Datasheet available at:
https://europe.kioxia.com/content/dam/kioxia/newidr/productinfo/datasheet/201910/DST_TH58NYG3S0HBAI4-TDE_EN_31565.pdf

Thanks,
Chukun

-- 
2.25.1

