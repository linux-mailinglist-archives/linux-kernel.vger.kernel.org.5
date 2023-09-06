Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F237935E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjIFHEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjIFHEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:04:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AC7CFA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:04:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86063C433C8;
        Wed,  6 Sep 2023 07:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693983845;
        bh=iaLhRtKyGtozPCEIVwdSztCExtfwyqEGcqw5FKdYv6Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oNhSpxqafGb4vd0yUbC3mBK4LGciSxdUG5gcuZJss0y5MjAgjGMmQ3RB7IH8w3nHh
         A8AJpDjmIfu9ShvG5c82K7BuqJbyuT33I8RctABtg/NV9hrQf7Yqz88hVHFdfF6zJR
         8yGgvgriBec4BVQEPaez4PcEIKYiOwT7er5szstNDCPnXvN+PUjeV09QqNbTjrIjR3
         kTWzm/ZGilVF63Lc5lGi44yhxrqFstusSKzxACo1GPbmsw94gdpgEhl0biiCdq6FwM
         Kpf47Mo2b8o4u9L0UncOafjLLnHznTdXc/SODWeUYd2Eu8ERXhLSETUZH+VEyXphP3
         l506S3dEU5fNw==
MIME-Version: 1.0
Date:   Wed, 06 Sep 2023 09:04:01 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 12/41] mtd: spi-nor: introduce (temporary) INFO0()
In-Reply-To: <aefff5dd-925a-41e7-ab56-9c3328b672b7@linaro.org>
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-12-291a0f39f8d8@kernel.org>
 <aefff5dd-925a-41e7-ab56-9c3328b672b7@linaro.org>
Message-ID: <55b60d1204d3550dc5ab17dbbec523b8@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-09-06 08:04, schrieb Tudor Ambarus:
> On 8/22/23 08:09, Michael Walle wrote:
>> The id will be converted to an own structure. To differentiate between
>> flashes with and without IDs, introduce a temporary macro INFO0() and
> 
> why do we need to differentiate between them?

The INFOn() macros will have a pointer to the SNOR_ID() whereas INFO0()
doesn't have a pointer. Before, it didn't really matter because we
tested for the id_len, but now we'll test the pointer (see next patch).

-michael
