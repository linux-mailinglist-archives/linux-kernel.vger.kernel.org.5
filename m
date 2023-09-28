Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568A77B21C2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjI1PvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjI1PvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:51:07 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Sep 2023 08:51:01 PDT
Received: from 8.mo560.mail-out.ovh.net (8.mo560.mail-out.ovh.net [188.165.52.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BE2B7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:51:01 -0700 (PDT)
Received: from director4.ghost.mail-out.ovh.net (unknown [10.108.16.31])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id 5F14E23E38
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 15:31:21 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-xtrd6 (unknown [10.110.103.92])
        by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id ADCE01FDB6;
        Thu, 28 Sep 2023 15:31:20 +0000 (UTC)
Received: from RCM-web4.webmail.mail.ovh.net ([176.31.235.81])
        by ghost-submission-6684bf9d7b-xtrd6 with ESMTPSA
        id cUnAJ0icFWWmLwAAgHucVw
        (envelope-from <rafal@milecki.pl>); Thu, 28 Sep 2023 15:31:20 +0000
MIME-Version: 1.0
Date:   Thu, 28 Sep 2023 17:31:20 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v10 3/3] nvmem: core: Expose cells through sysfs
In-Reply-To: <20230922174854.611975-4-miquel.raynal@bootlin.com>
References: <20230922174854.611975-1-miquel.raynal@bootlin.com>
 <20230922174854.611975-4-miquel.raynal@bootlin.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <1a27a3341379b9679174f7c5143bbeb3@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 31.11.218.106
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11261532344254573469
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrtddtgdeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhgfkfigihgtgfesthekjhdttderjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepjedvlefguedthfefleehgeeftdeludeluedvgfeffeevhfevtdehteejteefheegnecukfhppeduvdejrddtrddtrddupdefuddruddurddvudekrddutdeipddujeeirdefuddrvdefhedrkedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgrfhgrlhesmhhilhgvtghkihdrphhlqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeitddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-22 19:48, Miquel Raynal wrote:
> The binary content of nvmem devices is available to the user so in the
> easiest cases, finding the content of a cell is rather easy as it is
> just a matter of looking at a known and fixed offset. However, nvmem
> layouts have been recently introduced to cope with more advanced
> situations, where the offset and size of the cells is not known in
> advance or is dynamic. When using layouts, more advanced parsers are
> used by the kernel in order to give direct access to the content of 
> each
> cell, regardless of its position/size in the underlying
> device. Unfortunately, these information are not accessible by users,
> unless by fully re-implementing the parser logic in userland.
> 
> Let's expose the cells and their content through sysfs to avoid these
> situations. Of course the relevant NVMEM sysfs Kconfig option must be
> enabled for this support to be available.
> 
> Not all nvmem devices expose cells. Indeed, the .bin_attrs attribute
> group member will be filled at runtime only when relevant and will
> remain empty otherwise. In this case, as the cells attribute group will
> be empty, it will not lead to any additional folder/file creation.
> 
> Exposed cells are read-only. There is, in practice, everything in the
> core to support a write path, but as I don't see any need for that, I
> prefer to keep the interface simple (and probably safer). The interface
> is documented as being in the "testing" state which means we can later
> add a write attribute if though relevant.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Tested-by: Rafał Miłecki <rafal@milecki.pl>

# hexdump -C /sys/bus/nvmem/devices/u-boot-env0/cells/ipaddr@15c
00000000  31 39 32 2e 31 36 38 2e  31 2e 31                 
|192.168.1.1|
0000000b

-- 
Rafał Miłecki
