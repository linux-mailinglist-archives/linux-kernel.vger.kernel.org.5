Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DD27D205B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 01:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjJUXAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 19:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUXAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 19:00:54 -0400
X-Greylist: delayed 4200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 21 Oct 2023 16:00:49 PDT
Received: from 17.mo583.mail-out.ovh.net (17.mo583.mail-out.ovh.net [46.105.56.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C9C1A3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 16:00:49 -0700 (PDT)
Received: from director8.ghost.mail-out.ovh.net (unknown [10.109.156.41])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id C31F926F35
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 20:31:55 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-mfq7p (unknown [10.110.115.64])
        by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 938551FDE1;
        Sat, 21 Oct 2023 20:31:55 +0000 (UTC)
Received: from RCM-web9.webmail.mail.ovh.net ([151.80.29.21])
        by ghost-submission-6684bf9d7b-mfq7p with ESMTPSA
        id SjPbIjs1NGVgpxoAlMRRDQ
        (envelope-from <rafal@milecki.pl>); Sat, 21 Oct 2023 20:31:55 +0000
MIME-Version: 1.0
Date:   Sat, 21 Oct 2023 22:31:55 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 4/6] Revert "nvmem: add new config option"
In-Reply-To: <2023102100-tile-spinning-fa1b@gregkh>
References: <20231020105545.216052-1-srinivas.kandagatla@linaro.org>
 <20231020105545.216052-5-srinivas.kandagatla@linaro.org>
 <2023102100-tile-spinning-fa1b@gregkh>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <ef93205165ac15b4d6ea14a5e9f22cd9@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 31.11.218.106
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3835659510162041636
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrkedtgddugeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtkehjtddtreejnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeejvdelgfeutdfhfeelheegfedtleduleeuvdfgfeefvefhvedtheetjeetfeehgeenucfkphepuddvjedrtddrtddruddpfedurdduuddrvddukedruddtiedpudehuddrkedtrddvledrvddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgrfhgrlhesmhhilhgvtghkihdrphhlqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekfedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-21 19:18, Greg KH wrote:
> On Fri, Oct 20, 2023 at 11:55:43AM +0100, 
> srinivas.kandagatla@linaro.org wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>> 
>> This reverts commit 517f14d9cf3533d5ab4fded195ab6f80a92e378f.
>> 
>> It seems that "no_of_node" config option was added to help mtd's case.
>> 
>> DT nodes of MTD partitions (that are also NVMEM devices) may contain
>> subnodes that SHOULD NOT be treated as NVMEM fixed cells. To prevent
>> NVMEM core code from parsing them "no_of_node" was set to true and 
>> that
>> made for_each_child_of_node() in NVMEM a no-op.
>> 
>> With the introduction of "add_legacy_fixed_of_cells" config option
>> things got more explicit. MTD subsystem simply tells NVMEM when to 
>> look
>> for fixed cells and there is no need to hack "of_node" pointer 
>> anymore.
>> 
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Why isn't this also marked for stable trees?

I think it's explained in commit message but maybe it's not clear
enough?

This revert (PATCH 4/6) is possible only with the previous PATCH 2/6
applied first. In other words "no_of_node" config option can be dropped
only after adding "add_legacy_fixed_of_cells" config option.

Since adding "add_legacy_fixed_of_cells" is not a bug/regression fix I
didn't mark it for stable and so I couldn't mark revert for stable.

-- 
Rafał Miłecki
