Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431227E7F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjKJRy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjKJRx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:53:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188422FED2;
        Fri, 10 Nov 2023 03:30:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFC0C433C8;
        Fri, 10 Nov 2023 11:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699615844;
        bh=njSaKFsGWjCldhNW7Y7iD3HrJm8EnbqsgMz5zjrw6Ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IGtrMwspaNcfUWQFWD9Mn9esgOUZwlXqIYnHRt/ONA36Vi0xFevDcjIDyNdxHdstb
         CMUsgVaJeowXqHuk4o3yZ/OJwRjBd6kDUYdkN0cB39smLWfaiRYieBSYr+WYQX6H/7
         j4/VU9AQsEUXMp6ptXOg2j7V+isEosVSRIJ5sj/1y80v1FoXVd8SYPReSoJsejT+cH
         lJjCz3bwOvWULf6teJ8fwB55ql6PqDZpM0agIjRpfjktSyxIXSocVMxeUY7WrCQPOR
         q52ZdkeQUqPrs4ZLOmgRNvAvKzhfM1bCOdZj+brnECWTTKQeKjmSwxrs/nGD65tUJR
         riBTtu03lvvug==
Date:   Fri, 10 Nov 2023 12:30:39 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Robert Marko <robert.marko@sartura.hr>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        wsa@kernel.org, codrin.ciubotariu@microchip.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] Revert "i2c: pxa: move to generic GPIO recovery"
Message-ID: <20231110113039.esdkjkpzj7p2aqc3@zenone.zhora.eu>
References: <20231110093039.190076-1-robert.marko@sartura.hr>
 <ZU37aJfDpcixU2OZ@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU37aJfDpcixU2OZ@shell.armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marko,

On Fri, Nov 10, 2023 at 09:44:08AM +0000, Russell King (Oracle) wrote:
> On Fri, Nov 10, 2023 at 10:30:11AM +0100, Robert Marko wrote:
> > This reverts commit 0b01392c18b9993a584f36ace1d61118772ad0ca.
> > 
> > Conversion of PXA to generic I2C recovery, makes the I2C bus completely
> > lock up if recovery pinctrl is present in the DT and I2C recovery is
> > enabled.
> > 
> > So, until the generic I2C recovery can also work with PXA lets revert
> > to have working I2C and I2C recovery again.

Reverts are never nice, but if you are confirming this doesn't
work I can't do anything else than acking and bringing the driver
back to a working status.

Acked-by: Andi Shyti <andi.shyti@kernel.org>

I would have preferred a different fix, directly in the generic
i2c recovery, but this goes beyond the scope of the patch.

> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > Cc: stable@vger.kernel.org # 5.11+
> 
> My feels were that this should not have been converted to the generic
> recovery as pointed out at the time, so thanks for confirming that it
> broke as a result of that conversion, it did indeed break.
> 
> Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks Russel!

Andi
