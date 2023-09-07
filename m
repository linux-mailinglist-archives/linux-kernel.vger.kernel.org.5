Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91010797366
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbjIGPXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbjIGPW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:22:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2770CA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:22:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86021C4339A;
        Thu,  7 Sep 2023 08:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694074434;
        bh=oTcxoO3zSCDpXZafwrXHiI751ZzS6JBBCs2MekhQSC8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h7mM4Ku4a+8i8f8+p7KrSkBXuMm25TcVgXN5MWs7i559RWnwuBGSGkpLFA2dvMUjE
         EyU35V6rD/KMjA3rxcdIxYrUeFVsEsvAJR88zFtzU27vE/j0mJQ3jaothsbR8onimL
         th3Rf/UcwcwZUxrqCBeOh54sVQLP/e4qX2Anjhq6z91gc4pA1OdlY05pxExtkEC/Ad
         aa8dUP+9eZw8Is5jgdZ+TEAlLfj9PNkvKywL6/VUhuSNB5yvzJm06CpiNNqvGNDXkt
         tdCWq73INCZ45RFNP7xxiGpOO8dJytoDlv17J/+LVk5T4sH9zWg8loKqO3QMyVHji+
         blaw4TA9+b+Lw==
MIME-Version: 1.0
Date:   Thu, 07 Sep 2023 10:13:50 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 17/41] mtd: spi-nor: atmel: convert flash_info to new
 format
In-Reply-To: <aba618e2-ad74-d716-c8d7-e77588b22509@linaro.org>
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-17-291a0f39f8d8@kernel.org>
 <aba618e2-ad74-d716-c8d7-e77588b22509@linaro.org>
Message-ID: <4a25955300a53a36a842f4e8bd3a2e1a@kernel.org>
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

>> +	{
>> +		.id = SNOR_ID(0x1f, 0x66, 0x01),
>> +		.name = "at25fs010",
> 
> nitpick, we shall respect the order of the members declared in
> flash_info struct.

As mentioned in my first reply, you're fine with keeping the id
first? After this series, we can swap the name and id members in
struct flash_info.

For all the other members, they should be used consistently. So
we could also swap the members in flash_info.

> And I'll let you double check if the conversion is accurate :D.
> 
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

So I'll convert that one in an Acked-by: for all the conversion
patches?

-michael
