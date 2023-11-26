Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90317F9320
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 15:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjKZOaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 09:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZOaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 09:30:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16DCDD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 06:30:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19BCC433C7;
        Sun, 26 Nov 2023 14:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701009019;
        bh=TLLNQA2VXYNSg4iw436Him1x6VjVGm1YWNWyuFM/u4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hbzMyO0YssbdHB/JPvPVODgrCt0suqRszKTI/l7lRIJYgZAwm52GvFBEGG2/D8TET
         6SCHkDSxn33BTdpXCFyGpLV4WX1UQpzH/EDdQ66e6A0ZSuP8kfDHcxIFa3v0QUEcJJ
         MtQQLH8AVsEjySbTo79MCGxHy3budSA3FrdEM6O8BlBKliESGn2TvndXNWBdHX/Xl/
         zdEG5DGJwriJgu4Ac0G9+vC8c3sJshnEniuc1MDnU+jCkWXmhkWKUVf3Ev0C91e+17
         IBPBXUOFXbsy6g6VBUuoolLi2HRV8LhCmAApLMjM6kwETgeJqgAiBOCPtOCH1oregS
         Pke7V/Fbb+V8A==
Date:   Sun, 26 Nov 2023 15:30:14 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Wolfram Sang <wsa@kernel.org>, Jim Cromie <jim.cromie@gmail.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] i2c: scx200_acb: Don't let i2c adapters declare
 I2C_CLASS_SPD support if they support I2C_CLASS_HWMON
Message-ID: <20231126143014.sz4jjwuqcl5biz5p@zenone.zhora.eu>
References: <20231124101619.6470-1-hkallweit1@gmail.com>
 <20231124101619.6470-11-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124101619.6470-11-hkallweit1@gmail.com>
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

in this last patch I will add a couple of minor comments valid
for the previous, as well.

On Fri, Nov 24, 2023 at 11:16:19AM +0100, Heiner Kallweit wrote:
> After removal of the legacy eeprom driver the only remaining I2C
> client device driver supporting I2C_CLASS_SPD is jc42. Because this
> driver also supports I2C_CLASS_HWMON, adapters don't have to
> declare support for I2C_CLASS_SPD if they support I2C_CLASS_HWMON.
> It's one step towards getting rid of I2C_CLASS_SPD mid-term.
> 
> Series was created supported by Coccinelle and its splitpatch.

this sentence is grammatically incorrect, I guess you meant:

"The series was created with support from Coccinelle and its
splitpatch feature."

Please fix it if you are going to resend it.

> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 

Just for you to know, all your patches have a blank line after
your SoB, it doesn't really matter as I guess git removes it.

In any case, as before:

Acked-by: Andi Shyti <andi.shyti@kernel.org>                     
                                                                 
and I believe:                                                   
                                                                 
Acked-by: Jim Cromie <jim.cromie@gmail.com>                      
                                                                 
so that patchwork takes it.

Thanks,
Andi
