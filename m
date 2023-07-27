Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBCB765803
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjG0Pt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjG0Ptz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:49:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104172D5E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:49:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D32261EC4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66301C433C9;
        Thu, 27 Jul 2023 15:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690472992;
        bh=iai8Dl1aZsshs+BYkCfB+zSQzXKojFXc8NGFY9536+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UR2a0/eGLPKam4rWnuFcFWycmApBEJQ5EKOIks8Xj7MFTa0PmR3B/YsU/iEC68vlY
         yO/eWxOqPLucS5jbhdrF8O9ED9ZZfrytlvhOj4E+aiU9thnNehCfI60l0AfzuUenfG
         aImFx7+d9Eegd/JrsyKSANBu/6JLGOCyLfYNGRo1O0wFQn+a8niZ9PPfdG6/QbjFZh
         44BgpK7YVEYYIHBqtdehGGiaYAbAlBkwJUhe1Ptvi0ATRj15JUAojSorMbfVGDxrpG
         rGbkEIEIk2LLu6ntEcNz2CyRX/TRkriE/NDpoJ/ManaiTF7zen7eaDQMW5e7uYyeEA
         Viiz66wEaFTQA==
Date:   Thu, 27 Jul 2023 08:49:51 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Edward Cree <ecree.xilinx@gmail.com>
Cc:     Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
        saeedm@nvidia.com, tariqt@nvidia.com, ecree@solarflare.com,
        andrew@lunn.ch, davem@davemloft.net, leon@kernel.org,
        pabeni@redhat.com, bhutchings@solarflare.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [net 0/2] rxfh with custom RSS fixes
Message-ID: <20230727084951.1e4d3279@kernel.org>
In-Reply-To: <f565a8d6-e3b8-96d1-a7ac-212c64c60b1c@gmail.com>
References: <20230723150658.241597-1-jdamato@fastly.com>
        <b52f55ef-f166-cd1a-85b5-5fe32fe5f525@gmail.com>
        <20230724150815.494ae294@kernel.org>
        <f565a8d6-e3b8-96d1-a7ac-212c64c60b1c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 09:40:24 +0100 Edward Cree wrote:
> More generally the status of my RSS work is that I've been umming
>  and ahhing about that mutex you didn't like (I still think it's
>  the Right Thing) so I've not made much progress with it.

I had a look at the code again, and I don't think the mutex is a deal
breaker. More of an aesthetic thing, so to speak. If you strongly
prefer to keep the mutex that's fine.
