Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287537A17E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjIOICD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjIOICB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:02:01 -0400
X-Greylist: delayed 1202 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Sep 2023 01:01:55 PDT
Received: from 17.mo584.mail-out.ovh.net (17.mo584.mail-out.ovh.net [46.105.41.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C19BAC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:01:55 -0700 (PDT)
Received: from director2.ghost.mail-out.ovh.net (unknown [10.108.16.216])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id AAD2626F8B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 07:25:48 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-wk657 (unknown [10.110.208.116])
        by director2.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 5F6DE1FE5D;
        Fri, 15 Sep 2023 07:25:48 +0000 (UTC)
Received: from RCM-web7.webmail.mail.ovh.net ([151.80.29.19])
        by ghost-submission-6684bf9d7b-wk657 with ESMTPSA
        id f7YJF/wGBGUpJgAAKs0qSA
        (envelope-from <rafal@milecki.pl>); Fri, 15 Sep 2023 07:25:48 +0000
MIME-Version: 1.0
Date:   Fri, 15 Sep 2023 09:25:48 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH] nvmem: brcm_nvram: store a copy of NVRAM content
In-Reply-To: <28fad55f-1253-deb2-9615-b32746129664@gmail.com>
References: <20230914064922.3986-1-zajec5@gmail.com>
 <28fad55f-1253-deb2-9615-b32746129664@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <58a017a92ee82f95972b0a14c604f313@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 31.11.218.106
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 503277259095976943
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudejuddguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhgfkfigihgtgfesthekjhdttderjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepgffhueeihfeitdettdehfefhieefffevkedvgeetteekteejtdeivddvhffgffffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpfedurdduuddrvddukedruddtiedpudehuddrkedtrddvledrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgrfhgrlhesmhhilhgvtghkihdrphhlqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekgedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-14 23:26, Florian Fainelli wrote:
> On 9/13/23 23:49, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>> 
>> This driver uses MMIO access for reading NVRAM from a flash device.
>> Underneath there is a flash controller that reads data and provides
>> mapping window.
>> 
>> Using MMIO interface affects controller configuration and may break 
>> real
>> controller driver. It was reported by multiple users of devices with
>> NVRAM stored on NAND.
>> 
>> Modify driver to read & cache all NVRAM content during init and use 
>> that
>> copy to provide NVMEM data when requested.
>> 
>> Link: 
>> https://lore.kernel.org/linux-mtd/CACna6rwf3_9QVjYcM+847biTX=K0EoWXuXcSMkJO1Vy_5vmVqA@mail.gmail.com/
>> Cc: Arınç ÜNAL <arinc.unal@arinc9.com>
>> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
>> Cc: Scott Branden <scott.branden@broadcom.com>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
> [snip]
>> -	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>> -	if (IS_ERR(priv->base))
>> -		return PTR_ERR(priv->base);
>> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>> +	if (IS_ERR(base))
>> +		return PTR_ERR(base);
>> +
>> +	priv->size = resource_size(res);
>> +
>> +	priv->data = devm_kzalloc(dev, priv->size, GFP_KERNEL);
> 
> These can conceivably quite big data structures, how about using 
> kvmalloc()?

Good idea.

Actual NVRAM data usually doesn't take much space, but it reserves quite 
a lot and we need all of that to full expose NVMEM device content.

-- 
Rafał Miłecki
