Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816867F9315
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 15:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjKZOX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 09:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZOX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 09:23:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097D6FA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 06:23:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988CAC433C8;
        Sun, 26 Nov 2023 14:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701008613;
        bh=nJRLDScxE9MREoMy7ECO/mS6jpoglTXrMPk1fUXKulI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AV53LiJSewklLVlZKiAj10KL6A/ozscKPdmzAayQoLtrnCnn4z+WG8huk+x5leLiR
         VyzTFNhFJFc7o1N7VJ5U5crGErjBhQhq8nMXb6tgZzVbHcyuB8m56oFBd5ku9hI0CH
         3rMUzNj9lYpNLZbqBWhqBdCe0RM1W3t7mqMhZmJv5fp+sI7iXPTFaueLwi+KABAqgE
         o+EJWk2JEGM7026TpE2UBQB6BoEhtpeQyqiW8JsRao+Ik9W84Nlxeik3Mh85RH3ULw
         0+SpF1VApUXXs9eXX2wOrwcBq88otaMQJM6/Rj/RPqqQhvmSErYPoNR/YzJvl/I1nf
         tIoWjDV+3sLPA==
Date:   Sun, 26 Nov 2023 15:23:27 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] i2c: Don't let i2c adapters declare
 I2C_CLASS_SPD support if they support I2C_CLASS_HWMON
Message-ID: <20231126142327.fwi5pzr2apjyhicz@zenone.zhora.eu>
References: <20231124101619.6470-1-hkallweit1@gmail.com>
 <20231124101619.6470-5-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124101619.6470-5-hkallweit1@gmail.com>
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

On Fri, Nov 24, 2023 at 11:16:13AM +0100, Heiner Kallweit wrote:
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
