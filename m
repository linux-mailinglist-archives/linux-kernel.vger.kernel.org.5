Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49660765979
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjG0REO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjG0REM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:04:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF54F7;
        Thu, 27 Jul 2023 10:04:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90DAA61EEC;
        Thu, 27 Jul 2023 17:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED1BC433C8;
        Thu, 27 Jul 2023 17:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690477451;
        bh=eImfQdtW4BdLj71xuN6/ItkgYPB00aTK9XN90ZGDmxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qoXeDg9ASXfjw/Y5vIj/JtbVJ56ktXnxmiHd08Tvn+otZjM6cXD6Ymc9vhhp2BzGG
         OVW9OuuKiOjNbKcS8OdCnLyrqCeZwLmt6dKEAvktrwzRn8A5zHsRyozbnw5gOlyJ5w
         WFQOq55OU0oSE1drbbqOxb4fSHINfuGYemulDJ6g8egH8SpD1KaKMZjan+sFhCzZ6u
         8FPfYxL/tE1Ydb/H7LL2ALYAJCQCGQDzIbbIZDd5/ZwkMuqJVpHBVUMO8mZA/iq13b
         12OJ1+83/P3yRiQyvgZtVdLvqr8eiEbqX5IIID/LD09XwI5egvhUwShhmpkfGI9D2/
         BBfuzPxbU5zmw==
Received: (nullmailer pid 1813074 invoked by uid 1000);
        Thu, 27 Jul 2023 17:04:09 -0000
Date:   Thu, 27 Jul 2023 11:04:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] of: unittest: fix null pointer dereferencing in
 of_unittest_find_node_by_name()
Message-ID: <169047744793.1813007.10204887890918817559.robh@kernel.org>
References: <20230727080246.519539-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727080246.519539-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Jul 2023 16:02:46 +0800, Ruan Jinjie wrote:
> when kmalloc() fail to allocate memory in kasprintf(), name
> or full_name will be NULL, strcmp() will cause
> null pointer dereference.
> 
> Fixes: 0d638a07d3a1 ("of: Convert to using %pOF instead of full_name")
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
> v2:
> - add fixes tag
> ---
>  drivers/of/unittest.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

Applied, thanks!

