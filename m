Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809088073F1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379419AbjLFPrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379343AbjLFPrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:47:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4F79C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:47:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E993DC433C9;
        Wed,  6 Dec 2023 15:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701877643;
        bh=MrNgRiYa9MAcWug7NSrquxYR6x57hudTb4cvkZDbmPc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ro/bRRwOO+94JLkbJreebvw6kzsLXzH273lFl8owBLz/0qKxATZ0YD8ffzRNas+VV
         mzNASWXVLIzxByTT9T1mvE/+c+IYox12jtXy8GyTPHBeRvtiwrbDkEMPQ3rKRRLsnO
         A69ymnBP1Je81RnuIbNfaxQ12msOVQneig9gQmhOqcXGj/oJvSrsFyBWsqh5UbfF/B
         zNxrJ9FSYlOZDJMT34eu8b9I28y8LCjhUXCNjJ+IraHjpSpcUjT/nLza5IZKBX+EGS
         M1jVjfQCb7Hz5acbgXGhWqaJTzLAXoyDY8gyanoObj1X6Gl+JRIjz1bqLYsYNWm7k1
         MeyLDE78g6PcA==
Date:   Wed, 6 Dec 2023 07:47:21 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Kory Maincent <kory.maincent@bootlin.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] firmware_loader: Expand Firmware upload
 error codes with firmware invalid error
Message-ID: <20231206074721.2eb68abc@kernel.org>
In-Reply-To: <20231206-sacrament-cadmium-4cc02374d163@spud>
References: <20231122-feature_firmware_error_code-v3-1-04ec753afb71@bootlin.com>
        <20231124192407.7a8eea2c@kernel.org>
        <20231206-sacrament-cadmium-4cc02374d163@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2023 12:04:33 +0000 Conor Dooley wrote:
> It's taken me longer than I would like to get back to this, sorry.
> I tried pulling the tag today and I think there's been a mistake - the
> tagged commit is the merge commit into net, not the commit adding the
> firmware loader change:
> 
> commit 53775da0b4768cd7e603d7ac1ad706c383c6f61e (tag: firmware_loader-add-upload-error, korg-kuba/firmware_loader)
> Merge: 3a767b482cac a066f906ba39
> Author: Jakub Kicinski <kuba@kernel.org>
> Date:   Fri Nov 24 18:09:19 2023 -0800
> 
>     Merge branch 'firmware_loader'
> 
> commit a066f906ba396ab00d4af19fc5fad42b2605582a
> Author: Kory Maincent <kory.maincent@bootlin.com>
> Date:   Wed Nov 22 14:52:43 2023 +0100
> 
>     firmware_loader: Expand Firmware upload error codes with firmware invalid error
> 
> I'm going to merge in a066f906ba39 ("firmware_loader: Expand Firmware
> upload error codes with firmware invalid error") so that I don't end
> up with a bunch of netdev stuff in my tree.
> 
> Have I missed something?

You're right, looks like I tagged the wrong thing.
Merging a066f906ba39 will work, sorry!
