Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0A27A1764
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjIOH2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjIOH2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:28:36 -0400
Received: from 1.mo576.mail-out.ovh.net (1.mo576.mail-out.ovh.net [178.33.251.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF5E19A5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:28:23 -0700 (PDT)
Received: from director3.ghost.mail-out.ovh.net (unknown [10.109.138.157])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id A629526D12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 07:28:21 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-kmpnv (unknown [10.110.171.251])
        by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 863E91FEBC;
        Fri, 15 Sep 2023 07:28:20 +0000 (UTC)
Received: from RCM-web7.webmail.mail.ovh.net ([151.80.29.19])
        by ghost-submission-6684bf9d7b-kmpnv with ESMTPSA
        id 3NYNH5QHBGUBRAAAnwAMdg
        (envelope-from <rafal@milecki.pl>); Fri, 15 Sep 2023 07:28:20 +0000
MIME-Version: 1.0
Date:   Fri, 15 Sep 2023 09:28:20 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?Q?Rafa=C5=82_Mi?= =?UTF-8?Q?=C5=82ecki?= 
        <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH] nvmem: brcm_nvram: store a copy of NVRAM content
In-Reply-To: <CA+Jzhd+HLoUDifQQ5vF7m66X3rsk1Bk2yx_0h6eSzaUwXVa72w@mail.gmail.com>
References: <20230914064922.3986-1-zajec5@gmail.com>
 <28fad55f-1253-deb2-9615-b32746129664@gmail.com>
 <CA+Jzhd+HLoUDifQQ5vF7m66X3rsk1Bk2yx_0h6eSzaUwXVa72w@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <24ab9df46703695cfa7402695a5dc5a2@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 31.11.218.106
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 546342932523559692
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudejuddguddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhgfkfigihgtgfesthekjhdttderjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepgffhueeihfeitdettdehfefhieefffevkedvgeetteekteejtdeivddvhffgffffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpfedurdduuddrvddukedruddtiedpudehuddrkedtrddvledrudelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgrfhgrlhesmhhilhgvtghkihdrphhlqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejiedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-14 23:30, Scott Branden wrote:
> On Thu, Sep 14, 2023 at 2:26 PM Florian Fainelli <f.fainelli@gmail.com> 
> wrote:
>> 
>> On 9/13/23 23:49, Rafał Miłecki wrote:
>> > From: Rafał Miłecki <rafal@milecki.pl>
>> >
>> > This driver uses MMIO access for reading NVRAM from a flash device.
>> > Underneath there is a flash controller that reads data and provides
>> > mapping window.
>> >
>> > Using MMIO interface affects controller configuration and may break real
>> > controller driver. It was reported by multiple users of devices with
>> > NVRAM stored on NAND.
>> >
>> > Modify driver to read & cache all NVRAM content during init and use that
>> > copy to provide NVMEM data when requested.
>> >
>> > Link: https://lore.kernel.org/linux-mtd/CACna6rwf3_9QVjYcM+847biTX=K0EoWXuXcSMkJO1Vy_5vmVqA@mail.gmail.com/
>> > Cc: Arınç ÜNAL <arinc.unal@arinc9.com>
>> > Cc: Florian Fainelli <florian.fainelli@broadcom.com>
>> > Cc: Scott Branden <scott.branden@broadcom.com>
>> > Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> > ---
>> [snip]
>> > -     priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>> > -     if (IS_ERR(priv->base))
>> > -             return PTR_ERR(priv->base);
>> > +     base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>> > +     if (IS_ERR(base))
>> > +             return PTR_ERR(base);
>> > +
>> > +     priv->size = resource_size(res);
>> > +
>> > +     priv->data = devm_kzalloc(dev, priv->size, GFP_KERNEL);
>> 
>> These can conceivably quite big data structures, how about using 
>> kvmalloc()?
> Why do we even need to expose MMIO interface to NAND though?  Why not
> always go through the controller driver.  I don't see how the MMIO
> access would be used given bad blocks aren't handled?

We need to read NVMRAM *early* for booting purposes. Some vendors store
there information about used firmware in case of having main one and
fallback one. That info is required for partitioning which happens
during mtd initialization before we have NAND driver fully initialized.

-- 
Rafał Miłecki
