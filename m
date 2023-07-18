Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B247578FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjGRKKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjGRKKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:10:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE673EA;
        Tue, 18 Jul 2023 03:10:36 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4vkt1Ggrz6D9CJ;
        Tue, 18 Jul 2023 18:07:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 18 Jul
 2023 11:10:33 +0100
Date:   Tue, 18 Jul 2023 11:10:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sean Wang <sean.wang@kernel.org>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 09/10] pinctrl: renesas: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
Message-ID: <20230718111033.00001f59@Huawei.com>
In-Reply-To: <20230717172821.62827-10-andriy.shevchenko@linux.intel.com>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
        <20230717172821.62827-10-andriy.shevchenko@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 20:28:20 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Since pm.h provides a helper for system no-IRQ PM callbacks,
> switch the driver to use it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Slightly more complex case, but looks fine to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

