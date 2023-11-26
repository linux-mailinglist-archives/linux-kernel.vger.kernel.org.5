Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428F97F931A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 15:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjKZOY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 09:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZOY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 09:24:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB800C8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 06:24:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D0AC433C7;
        Sun, 26 Nov 2023 14:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701008674;
        bh=E73aNZkPWZQbs+CRX4L7x72nEDCK9HoTHpreFGTvXBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8PP1NSM5KVvCkhWRTqtmfIJlhhu7S3e2PK1Cm3YSOOISTLVMe3Oz53mbownkEdE6
         R3hdsh4149I5VAtwgWjj8cW0fph+fBy4P4s2pP8Myh7sr0yIU6gJW5GhUtgW8JfDh6
         mPZGRnMZBKeZPdzPd9Zu42vR2zlQPftEG3pgZ0d3NcW/5oAaht2GxGeJu8ft4Dg1GS
         rWoN9pdWWwQmdX3mbeftKxr8Qr0Vea05fpYMNBl/t8df18+P4YLfaccB3fTr/p/mbT
         yG8Q66SdoZUfyvLh4lbTD6IBnnz/9BMo9AG00+aV9eo+fIq3iS+sN9BetGXQeqUMr9
         krN4ePDN7G7aw==
Date:   Sun, 26 Nov 2023 15:24:29 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Wolfram Sang <wsa@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>,
        linux-i2c@vger.kernel.org, Michael Shych <michaelsh@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] i2c: mlxcpld: Don't let i2c adapters declare
 I2C_CLASS_SPD support if they support I2C_CLASS_HWMON
Message-ID: <20231126142429.b7xwle7so43rtgwv@zenone.zhora.eu>
References: <20231124101619.6470-1-hkallweit1@gmail.com>
 <20231124101619.6470-8-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124101619.6470-8-hkallweit1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiner,

On Fri, Nov 24, 2023 at 11:16:16AM +0100, Heiner Kallweit wrote:
> After removal of the legacy eeprom driver the only remaining I2C
> client device driver supporting I2C_CLASS_SPD is jc42. Because this
> driver also supports I2C_CLASS_HWMON, adapters don't have to
> declare support for I2C_CLASS_SPD if they support I2C_CLASS_HWMON.
> It's one step towards getting rid of I2C_CLASS_SPD mid-term.
> 
> Series was created supported by Coccinelle and its splitpatch.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
