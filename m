Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35787FCB37
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 01:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376651AbjK2AJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 19:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjK2AJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 19:09:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2218B198D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 16:09:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48EFC433C7;
        Wed, 29 Nov 2023 00:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701216595;
        bh=m73Trz87dPQgImAcfxCzaxmbSK2YY2Ek+G0J2e+T4XA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1AHvE14L3YQOefTK8+GgjBEgn0lUAjnW9vDqnzKHN2p72Be4Axcvp44XbEt5fLHv
         sTmBVE9Ov+n+zAuTF0kLf2KL85lJr8O8erbCDusuuhB/8EoFs0x3bwzIs6sFJlK5XK
         wAWQw+OMrjqAHWxK6B83Opmy5Bx+l14ZfpUyvvNqN/79BbOIM9MtlzWdz6NygmUhsr
         R2xbrLTyEa78hOFoe/UM4oMI4ZX+7uzL3qQNGChBYTQbbNnBS0xiFnVVeyhfCe58mm
         jzfgwwGTCb6I/7MMt+gpBCGjeEj9bBxCUWwFAqxo57SAqmTsIWpdBgvI8ECJ/OxbmV
         VnzWrtzlZHfVg==
Date:   Tue, 28 Nov 2023 17:09:52 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     "hardaway.tseng@sk.com" <hardaway.tseng@sk.com>
Cc:     Jim Lin =?utf-8?B?5p6X5b+X6J6N?= <jim.lin@siliconmotion.com>,
        "Jim.Lin" <jim.chihjung.lin@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        CJ Chen =?utf-8?B?6Zmz576k5YKR?= <cj.chen@siliconmotion.com>,
        David Yeh =?utf-8?B?6JGJ5a+w6J6N?= 
        <david.yeh@siliconmotion.com>,
        "sangan.han@sk.com" <sangan.han@sk.com>,
        "ives.lu@sk.com" <ives.lu@sk.com>
Subject: Re: [PATCH] nvme-pci: disable write zeroes for SK Hynix BC901
Message-ID: <ZWaBULOgInxbp6JQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20231128025737.53026-1-jim.lin@siliconmotion.com>
 <SEYPR01MB4341EFAA7D4B563BFF903B45FDBCA@SEYPR01MB4341.apcprd01.prod.exchangelabs.com>
 <71aae1b4cb0441d0940a5e536f4ffce0@sk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71aae1b4cb0441d0940a5e536f4ffce0@sk.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 11:51:42PM +0000, hardaway.tseng@sk.com wrote:
> Hi Keith, Jim and team,
> 
> Thanks for efforts!
> 
> This is Hardaway from SK hynix, this software change has been tested and verified by ODM Compal, the testing result is pass, therefore, we would like to apply this update.

Great, thanks for confirming. I've got this queued up internally, but
want to check if Christoph's question could lead to a better outcome for
everyone. For reference, asked here:

  https://lists.infradead.org/pipermail/linux-nvme/2023-November/043298.html

If you were already testing close to upstream, 6.2 or newer, then this
patch is already the best option.
