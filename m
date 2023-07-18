Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3627758392
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjGRRgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjGRRgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:36:36 -0400
X-Greylist: delayed 2182 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Jul 2023 10:36:34 PDT
Received: from 6.mo576.mail-out.ovh.net (6.mo576.mail-out.ovh.net [46.105.50.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C1B91
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:36:34 -0700 (PDT)
Received: from director8.ghost.mail-out.ovh.net (unknown [10.108.4.127])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id 599DB248A1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 16:59:04 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-zfdpl (unknown [10.110.115.151])
        by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id B81521FDF3;
        Tue, 18 Jul 2023 16:59:01 +0000 (UTC)
Received: from RCM-web4.webmail.mail.ovh.net ([176.31.235.81])
        by ghost-submission-6684bf9d7b-zfdpl with ESMTPSA
        id utcTHtXEtmSNUQEAfcRA7w
        (envelope-from <rafal@milecki.pl>); Tue, 18 Jul 2023 16:59:01 +0000
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 18:59:01 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     kernel test robot <lkp@intel.com>
Cc:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        oe-kbuild-all@lists.linux.dev,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alban Bedel <albeu@free.fr>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "nvmem: add new config option"
In-Reply-To: <202307182316.AVNL1wNs-lkp@intel.com>
References: <20230718084804.20139-1-zajec5@gmail.com>
 <202307182316.AVNL1wNs-lkp@intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d9aea2179b54f83084e22eee137819b7@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 31.11.218.106
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14184087028245310427
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrgeeggddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtjehjtddtredvnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeetheelfefgjedutdeivdduvdethffhhedulefggeeitdejudfhkeetjeekieejgfenucfkphepuddvjedrtddrtddruddpfedurdduuddrvddukedruddtiedpudejiedrfedurddvfeehrdekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrrghfrghlsehmihhlvggtkhhirdhplheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeeipdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-18 18:00, kernel test robot wrote:
>    drivers/mtd/mtdcore.c: In function 'mtd_nvmem_add':
>>> drivers/mtd/mtdcore.c:542:29: warning: unused variable 'node' 
>>> [-Wunused-variable]
>      542 |         struct device_node *node = mtd_get_of_node(mtd);
>          |                             ^~~~

My patch I mentioned:
[PATCH V4] nvmem: add explicit config option to read old syntax fixed OF 
cells

adds following line:
config.add_legacy_fixed_of_cells = of_device_is_compatible(node, 
"nvmem-cells");

So this is a false kernel bot warning (but I understand kernel bot
couldn't understand it needs my other patch).
