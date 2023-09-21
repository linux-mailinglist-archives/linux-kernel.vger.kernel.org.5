Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83557A9950
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjIUSNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjIUSM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:12:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F7F85D04;
        Thu, 21 Sep 2023 10:37:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558CBC4AF7E;
        Thu, 21 Sep 2023 11:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695297096;
        bh=pNpu7kAjTQG7cwg+rw2cpVUro1wPNljZtedLZJWJg00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rg6s3O4ob+dBxj+11wlsPemZwDZOC9UcNhtZNwkYJMSzN37C0M3fSHXBdHaOPrqLZ
         jwWPZTieql3Zdl2it5z7aIl8RV1S8NPgg7kZpCWb7aKyDRnlVdQ0ao/FGnXBPwjati
         lyIEpb4tkOg8oJl01GhR9CB7VS+/uUiRS5GRDRbyEyQSz/CH3EL0gBeFNUzRc2u8W8
         yYD5XYZULCCGgHy5MBAZRTDH8Lxe81RLH1AGHZ8mcG0+cdYseQpLvHJ7uxq5vCYQoU
         BQ+8ur0SWKTOMvpaiAtO4FE5HvY7EW6ZVx8845h+GxHHuay3an0kWaOdVWCfQ3r9f2
         /zsy6eAUx5GQQ==
Date:   Thu, 21 Sep 2023 12:51:32 +0100
From:   Lee Jones <lee@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     william.gray@linaro.org, alexandre.torgue@foss.st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] counter: stm32-timer-cnt: add support for events
Message-ID: <20230921115132.GH3449785@google.com>
References: <20230829134029.2402868-1-fabrice.gasnier@foss.st.com>
 <20230829134029.2402868-9-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230829134029.2402868-9-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023, Fabrice Gasnier wrote:

> Add support for capture and overflow events. Also add the related
> validation and configuration. Captured counter value can be retrieved
> through CCRx register. Register and enable interrupts to push events.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  drivers/counter/stm32-timer-cnt.c | 279 +++++++++++++++++++++++++++++-

>  include/linux/mfd/stm32-timers.h  |  15 ++

Acked-by: Lee Jones <lee@kernel.org>

>  2 files changed, 285 insertions(+), 9 deletions(-)

-- 
Lee Jones [李琼斯]
