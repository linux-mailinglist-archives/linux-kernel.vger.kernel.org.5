Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7107F9313
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 15:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjKZOWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 09:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZOWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 09:22:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB34FA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 06:22:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE997C433C7;
        Sun, 26 Nov 2023 14:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701008574;
        bh=BNgeLRJLCAh0rW9IkfVXu7f7qPYQfsEuFY1bt7Md1nU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Caor826w4BjAII1NYrBsv+w1kcRWAfbeXDKWIM0TQZdZxpuxOrZfNF76V/fNHSPJo
         nEwm4WzeoC/GPPzaj54RpB8+6+Qe55NjxQGQqt0+NRJrQjbe+gDcqdu5YnKdbppnHQ
         st7neXsE3C09N20vbiYyNL9TBxFMzUSl4VNIdYUi6B05jt6T3tylxyFDpsfPrNs00P
         rq1t0WCk/Qs5skZNaGOxIFja+PNOb7LhgGfNOXvSY3k19KySZ9IZlgkRGA50vkLVlx
         ohsgdHR7P+9BS6bCSzttd36bYb7Z56YfLPz5sO/V7SMDa+hGlVBK06zs2A3fsgNgv1
         RFc3J6bkEuoWg==
Date:   Sun, 26 Nov 2023 15:22:50 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-i2c@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] i2c: pasemi: Don't let i2c adapters declare
 I2C_CLASS_SPD support if they support I2C_CLASS_HWMON
Message-ID: <20231126142250.afzfqb5obrvkglsl@zenone.zhora.eu>
References: <20231124101619.6470-1-hkallweit1@gmail.com>
 <20231124101619.6470-4-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124101619.6470-4-hkallweit1@gmail.com>
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

On Fri, Nov 24, 2023 at 11:16:12AM +0100, Heiner Kallweit wrote:
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
