Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B447F76D0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjKXOrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjKXOrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:47:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B9010CA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:47:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1462CC433CB;
        Fri, 24 Nov 2023 14:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700837245;
        bh=q8CschYes9Wu/H5uo0LqNzGtNJB/0uksw1+KLg0LLqI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ojqk9VYsNdC87X39AK42OGMtvuoARxFlfed8TdkUjrvdGYUQSqGaHS4hvFWqjKeGU
         ZXrGaapQXMrsEIJsI4k528eoHd7ZRK38JlAOCaWZ3bT2jT2G9pvXDHm5A6LeXrS93B
         6FD9zRtFmceTjsSDAZ/YJkhxXKWgHlVT6j/RdfIfEerjOUy4QEei6EzOfob4354von
         /BYMas4NssvxM4eQsJyf8J1sK/lYEzG6SLdfbHga2wNWXAzGolxle5XVtGwjxbfWqF
         9sj8SxBdjgBUxBxhLAHtuKzBdtStHx+dAcOTfTSX9FPoIvNYTwKlnuAs8aGhUbm3Oc
         nUWIB6MC8xJ7g==
From:   Pratyush Yadav <pratyush@kernel.org>
To:     Srikanth Boyapally <srikanth.boyapally@amd.com>
Cc:     <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
        <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: Re: [PATCH] mtd: spi-nor: issi: Add support for is25lp02g
In-Reply-To: <20231123054713.361101-1-srikanth.boyapally@amd.com> (Srikanth
        Boyapally's message of "Thu, 23 Nov 2023 11:17:13 +0530")
References: <20231123054713.361101-1-srikanth.boyapally@amd.com>
Date:   Fri, 24 Nov 2023 15:47:22 +0100
Message-ID: <mafs0jzq7dx8l.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Thu, Nov 23 2023, Srikanth Boyapally wrote:

> Add support for issi is25lp02g.
>
> Verified on AMD-Xilinx versal platform and executed
> mtd_debug read/write test.
>
> Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>

Based on a datasheet [0] I found online, this flash seems to have SFDP.
And since you do not add any flash specific fixups, it likely does not
need an entry and would work fine with the generic flash driver. Did you
try using that? See [1] for more info on contribution guidelines.

[0] https://www.issi.com/WW/pdf/25LP-WP02GG.pdf
[1] https://lore.kernel.org/linux-mtd/20231123160721.64561-2-tudor.ambarus@linaro.org/

-- 
Regards,
Pratyush Yadav
