Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223F37FB44D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344132AbjK1Ig2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjK1IgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:36:25 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2498CE1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:36:29 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 61F27957;
        Tue, 28 Nov 2023 09:36:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1701160587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v7glijZ94HivCAw9X2/CNGh4iPBKIx0lMfpD6J7YHzw=;
        b=Q/V8VItWQFtZyEEvwC+SczVu+gyUqbQLZLTIH+h0OZyxZHBkhVp67d2HATpAkpt7rYr3dO
        UmFtaAD/hD1sNEBZZqNQL2mmy8RJPWjAlUOrWc0mH4gjJmh+9j4T3ns6b4HasL4F9Ne5l9
        vKzuW0qQg9V5PvpSMaQF9h+8O5C0An1dloKkPj6dzsshpGhrveILw0hMy7BAAyy2RjNrET
        GQXDfMz3KiyeFx+3RiJtpDX4XlShpdTXD74EkUaQUZCaBVOliIuEwNVX3AjwqxQW9j+C1B
        tEePae6WjARPrhqunE0QWTfR4FcdA4ZwKvkkTEti5LvXUusYK0jWYezSgR1smA==
MIME-Version: 1.0
Date:   Tue, 28 Nov 2023 09:36:27 +0100
From:   Michael Walle <michael@walle.cc>
To:     "Boyapally, Srikanth" <Srikanth.Boyapally@amd.com>
Cc:     Pratyush Yadav <pratyush@kernel.org>, tudor.ambarus@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH] mtd: spi-nor: issi: Add support for is25lp02g
In-Reply-To: <BN9PR12MB51966705C3E306502ABABA6E9EBCA@BN9PR12MB5196.namprd12.prod.outlook.com>
References: <20231123054713.361101-1-srikanth.boyapally@amd.com>
 <mafs0jzq7dx8l.fsf@kernel.org>
 <BN9PR12MB51966705C3E306502ABABA6E9EBCA@BN9PR12MB5196.namprd12.prod.outlook.com>
Message-ID: <6342ad8a798ef811d37775b7269623a3@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> > Add support for issi is25lp02g.
>> >
>> > Verified on AMD-Xilinx versal platform and executed mtd_debug
>> > read/write test.
>> >
>> > Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
>> 
>> Based on a datasheet [0] I found online, this flash seems to have 
>> SFDP.
>> And since you do not add any flash specific fixups, it likely does not 
>> need an entry
>> and would work fine with the generic flash driver. Did you try using 
>> that? See [1]
>> for more info on contribution guidelines.
>> 
>> [0] https://www.issi.com/WW/pdf/25LP-WP02GG.pdf
>> [1] https://lore.kernel.org/linux-mtd/20231123160721.64561-2-
>> tudor.ambarus@linaro.org/
>> 
> I ran mtd_debug read/write tests on this flash, without adding flash
> entry, it worked fine for me. Please ignore this patch.

Great! Could you please still dump and post your SFDP just for us to
have more SFDP of diferent flashes? See [1].

-michael
