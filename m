Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C937A77D1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbjITJoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbjITJn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:43:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6905BA3;
        Wed, 20 Sep 2023 02:43:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62A6C433CA;
        Wed, 20 Sep 2023 09:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695203031;
        bh=G5UM/29/hoBsMPyW7FLQUB8OajG2L6Rdtpoi19mG58k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WP8CwtbHcJmAdr/iRqPtIzKnIHMSKWm+3gNleNOamQqF8S63MMmduC+vehafF0YJS
         dv62TxnALfCWo7r/u6toDY5zUVp0RNmovCO8qaB2KA5tBCvCF2ke5vwTuBWp8qogXY
         oQq5pvOCkesPmGDOWC38tq/WQ0uVdvut1hPcaW1t9mVsLDl9It7B7oP6bXHf82hSCF
         TjknjKI9ZjMqSMw5jTtwvuEJNbxRhU8XD1SsjOgDzLwTV7qlRRELSLWj6cOwc2/DEz
         73LWVDFNgC0RnemSG6sZ55d81qycvRzQlT3JSXgz+YPu3KZWbuwJRA7uz7HlGOZzwT
         DCaRhmWlihobQ==
From:   Lee Jones <lee@kernel.org>
To:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230831183153.63750-1-biju.das.jz@bp.renesas.com>
References: <20230831183153.63750-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v3 0/4] Match data improvements for palmas driver
Message-Id: <169520302957.3358496.16888014730596121759.b4-ty@kernel.org>
Date:   Wed, 20 Sep 2023 10:43:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 19:31:49 +0100, Biju Das wrote:
> This patch series aims to add match data improvements for palmas driver.
> 
> This patch series is only compile tested.
> 
> v2->v3:
>  * Patch#1 for removing trailing comma in the terminator entry for OF
>    table.
>  * Restored the OF table position and moved near to the user in patch#3.
>  * Moved OF table near to the user in patch#3.
>  * Updated commit description for patch#4.
> v1->v2:
>  * Moved the OF table just above its user.
>  * Removed trailing comma from the terminator entry for the OF table.
> 
> [...]

Applied, thanks!

[1/4] mfd: palmas: Remove trailing comma in the terminator entry
      commit: 00e54d48f88eda223306a38cf6016e7209cd1f00
[2/4] mfd: palmas: Constify .data in OF table and {palmas,tps65917}_irq_chip
      commit: e8b286068fc1f53f9784b1e8364bd6630918bbb2
[3/4] mfd: palmas: Move OF table
      commit: ce48b597e892a4eb5cb1b0adad4b46c4af737860
[4/4] mfd: palmas: Make similar OF and ID table
      commit: 3935ffa5258510e516645a29ae3c4ac582e66ff3

--
Lee Jones [李琼斯]

