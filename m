Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9B77E9C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjKMMot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKMMos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:44:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09205D4C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:44:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021C1C433C7;
        Mon, 13 Nov 2023 12:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699879485;
        bh=w3mr6OS81onuZnbxek6iE46F/Yw752xlsfKCcXvPfNI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=t9usVa5S4OmnwAAuzjCR79ebBTaskvZZ9Isi7UgVdnSROSsKbiy3WE3nZEYblK783
         XtWGzMS4uHlC8l0TgBkKETmvzFm688u+EJkSTCt8yx4Ek20X7wbKYBEuiB1Wwausb6
         y6bN7k9C4rVHjHF8YqS0cWaR1f3pRIZwCmpCbj3o2l5whtxLs8bnAXI7L4bdKouqIu
         sNMb826dW75AUcBycR1L9osIxUeOKHIGJisWeDo5be5qcLUYzPgj/LUtsSOukwLpsS
         5zAz+GFXvuvQDVjIsD0j5gy/oN1UYpKJ2oFJ11k22Ov6wkZM7SY2wdk4LhHbLB6FVs
         bpNygWAWkbeWg==
From:   Pratyush Yadav <pratyush@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     AceLan Kao <acelan.kao@canonical.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] mtd: spi-nor: Stop reporting warning message
 when soft reset is not suported
In-Reply-To: <7fbd05e9683e7c79d7d9ef1bf2cec5e8@walle.cc> (Michael Walle's
        message of "Thu, 09 Nov 2023 11:57:48 +0100")
References: <20231108094303.46303-1-acelan.kao@canonical.com>
        <20231108094303.46303-2-acelan.kao@canonical.com>
        <7fbd05e9683e7c79d7d9ef1bf2cec5e8@walle.cc>
Date:   Mon, 13 Nov 2023 13:44:42 +0100
Message-ID: <mafs04jhpg6v9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Thu, Nov 09 2023, Michael Walle wrote:

>> From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
>> When the software reset command isn't supported, we now stop reporting
>> the warning message to avoid unnecessary warnings and potential confusion.
>> Reviewed-by: Dhruva Gole <d-gole@ti.com>
>> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
>
> Reviewed-by: Michael Walle <michael@walle.cc>

I did read your reply on the previous thread but did not find time to
write a response. I do largely see sense in your argument though I have
not fully thought it through yet. But I think it would be great if we
can ask the controller "do we need to do a soft reset?"

Anyway, I do not think this patch does anything too bad so it is
probably not worth debating so much on. So for now,

Acked-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav
