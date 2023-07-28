Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542A676625B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 05:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjG1DUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 23:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjG1DUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 23:20:19 -0400
Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com [115.124.28.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4AB2726;
        Thu, 27 Jul 2023 20:20:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1200358|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.019553-0.000666478-0.97978;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=like@awinic.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.U2YUSwz_1690514404;
Received: from awinic..(mailfrom:like@awinic.com fp:SMTPD_---.U2YUSwz_1690514404)
          by smtp.aliyun-inc.com;
          Fri, 28 Jul 2023 11:20:11 +0800
From:   like@awinic.com
To:     broonie@kernel.org
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        liangdong@awinic.com, like@awinic.com,
        linux-kernel@vger.kernel.org, liweilei@awinic.com,
        robh+dt@kernel.org, wangweidong.a@awinic.com
Subject: Re: [PATCH V1 1/2] regulator: aw37503: add regulator driver for AWINIC AW37503
Date:   Fri, 28 Jul 2023 03:20:04 +0000
Message-ID: <20230728032004.1479251-1-like@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <812a3f8b-7d5d-42f2-aaf2-dcea18f6ffac@sirena.org.uk>
References: <812a3f8b-7d5d-42f2-aaf2-dcea18f6ffac@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark Brown,
Thank you very much for your advice.

> On Wed, Jul 26, 2023 at 08:16:11AM +0000, like@awinic.com wrote:
> 
> > @@ -191,5 +191,6 @@ obj-$(CONFIG_REGULATOR_WM831X) += wm831x-ldo.o
> >  obj-$(CONFIG_REGULATOR_WM8350) += wm8350-regulator.o
> >  obj-$(CONFIG_REGULATOR_WM8400) += wm8400-regulator.o
> >  obj-$(CONFIG_REGULATOR_WM8994) += wm8994-regulator.o
> > +obj-$(CONFIG_REGULATOR_AW37503) += aw37503-regulator.o
> >  
> 
> Please keep the Kconfig and Makefile sorted.

I will modify the sorting of AW37503 as suggested.

> > +static const struct regmap_config aw37503_regmap_config = {
> > +	.reg_bits	= 8,
> > +	.val_bits	= 8,
> > +	.max_register	= AW37503_REG_WPRTEN,
> > +	.cache_type	= REGCACHE_NONE,
> 
> No need to specify no cache, it's the default.

I will modify it as suggested.


Best regards,
Alec Li
