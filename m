Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7337976CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbjIGQQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235597AbjIGQQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:16:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14501FE7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:15:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCE8C433CC;
        Thu,  7 Sep 2023 06:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694069734;
        bh=mjcPEuc/gz0ex7VoEhNdmXz/LJ1yG2hyB4GVOCktz/w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Of4n82yUjLpH0jr9GO+SkTaPM7UepX+lFfRpXy3ptxIL1iU+qS67KTyqOjHhgWyQS
         Gg4GWfztbuDocJ6yV1JBWphktEYR0DsdGrw0+/UWuIPVzLQSc0P/1bcYofAvpW2b28
         +C+A09bBFmNvfZy6N+SACzkykc7LSUYx5sFiJ0TgeuAHb/UN2PCWYndkK6jvIBo5cm
         mIyGk7j6uj6PB4YuPO6hoZ2R6LLfuX2ebGhNgQZ6CvdItCLjjt99MrhYXWeIqrzf6t
         OCgwfuuiQDUDaxJZhlXIcq/09cfyrCLRxJOKjgVxqbSA0Eqi8NQbPAIl8okGViXj4d
         OiVBbyOkwnC6Q==
MIME-Version: 1.0
Date:   Thu, 07 Sep 2023 08:55:31 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 11/41] mtd: spi-nor: drop .parse_sfdp
In-Reply-To: <530942be-4175-43d5-a111-c433be7eff72@linaro.org>
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-11-291a0f39f8d8@kernel.org>
 <530942be-4175-43d5-a111-c433be7eff72@linaro.org>
Message-ID: <b843818e776a33d58db8b969270a5cda@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> the condition looks broken. the method returns bool, but here you 
> return
> size_t probably. And when size is zero one shall parse sfdp, not the
> other way around.
> 
> maybe return (nor->info->size == 0)?

Yeah, good catch.

-michael
