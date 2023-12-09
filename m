Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8553D80B646
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 21:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjLIU2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 15:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLIU2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 15:28:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D735413A
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 12:28:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC43C433C8;
        Sat,  9 Dec 2023 20:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702153698;
        bh=rslBYi0BViswbTgH93m6HMfXVxguyYBllIpDJEbGmY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PzxK6iBLgBu0UDJZ5PDebxoB2/rmQ9/0kO+w7tV/H/fCrrgYe1Ag+jo+7XrTon596
         Xsp75wGvG91ldzPwNe8XC7BF0M9Y2ac27ZkjPozdeC1grIQVQpwclyg1xKHLz72rLb
         OsPDi4flg4Dd63wZh5kOfS8Hq5E6alekoMGJZ9Aef2WzfqRR9z0UKQs+8RaDIveLQk
         qpgSShjeZl0a8hNMDdE/JjmyzBVyuT0Hi57k2ngyCzbwI7H6+Gy/NMq3Rj7/L/gfus
         +SGuJ3Zzg5VxmI1npvnQAXlTvzFq29Slgi/3xfK3hESpslB0u3TUsk3A1D/z9AeddD
         ZPQ5WavzE6mFg==
Date:   Sat, 9 Dec 2023 21:28:10 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Wolfram Sang <wsa@kernel.org>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Cosmo Chou <chou.cosmo@gmail.com>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: Re: [PATCH v3 1/2] i2c: aspeed: Handle the coalesced stop conditions
 with the start conditions.
Message-ID: <20231209202810.r7kkz2hlaonyibha@zenone.zhora.eu>
References: <20231208033142.1673232-1-quan@os.amperecomputing.com>
 <20231208033142.1673232-2-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208033142.1673232-2-quan@os.amperecomputing.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quan,

On Fri, Dec 08, 2023 at 10:31:41AM +0700, Quan Nguyen wrote:
> Some masters may drive the transfers with low enough latency between
> the nak/stop phase of the current command and the start/address phase
> of the following command that the interrupts are coalesced by the
> time we process them.
> Handle the stop conditions before processing SLAVE_MATCH to fix the
> complaints that sometimes occur below.
> 
> "aspeed-i2c-bus 1e78a040.i2c-bus: irq handled != irq. Expected
> 0x00000086, but was 0x00000084"
> 
> Fixes: f9eb91350bb2 ("i2c: aspeed: added slave support for Aspeed I2C driver")
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
