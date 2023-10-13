Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B527C8794
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjJMOOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjJMON5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:13:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC90B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:13:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675F7C433C8;
        Fri, 13 Oct 2023 14:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697206436;
        bh=M5cG4RpybhGR4hgZg1XQY4kjHzVg92/Zir9uslnYWVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nulF5lL/9q59T08g5Jh54kmdx/pI15HMlErRA7Gy4E1nW0V/L2zWevrswRKrFaMqc
         XXd4/SZA3onZzggnvri5E3Vswty24s5nlzuhAoI5r7kXns/UsFyolUI3RaatPedZTZ
         n5D8l9nxjw77Ewxc0jDxNl6dYRT4SQj8fV4TISl/mfGo5IZppsOnjPxvaaZ87++vmy
         LdP/CFEylCbhxH1bADHqHKeavtobUQ+8KNBGNbDDcymzL80ejnq+5x+oDoMHr79omf
         zIJIo+ienRq+MTUUz1IDcnjGK9447sCCbxtjgXwU/JxQE8yh0XoHHPq0oYPUAmE1J6
         WQYEgAc51FnAw==
Date:   Fri, 13 Oct 2023 08:13:53 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: update firmware version after commit
Message-ID: <ZSlQobW4LOuJd018@kbusch-mbp>
References: <20231013062623.6745-1-dwagner@suse.de>
 <ZSk/5Fubv+BYPQ3z@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSk/5Fubv+BYPQ3z@x1-carbon>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 01:02:29PM +0000, Niklas Cassel wrote:
> 
> However, when upgrading firmware (even without a reset),
> can't more things other than FW version change?

New firmware can change all sorts of things, but I think firmware_rev is
the only exported sysfs attribute we expect to change. Other attributes,
like model, serial and unique id's, should be stable across these types
of firmware upgrades. I don't think "activation without reset" can be
used for firmware upgrades that change fundamental ways the device
operates.
