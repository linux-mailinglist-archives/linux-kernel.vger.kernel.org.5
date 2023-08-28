Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4121578B88E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjH1TlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbjH1Tky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:40:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E392C124
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:40:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79749644A1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94338C433C7;
        Mon, 28 Aug 2023 19:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693251650;
        bh=yS/x4S3B0SAE5WxEAeTZKQjfCSYVYBosMEntmMa+VI8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jImMnye5gpm7ZO4ZaxCapaI/8gtOFPHtHJ3agla8hS7pT1PVMw3pEn0/vy1SRG/5Y
         YWk9xZM0L3EITRbgp2k6ISva7Gik/vxeXKkuxkZcePBR3C2iKv7i0KtQehtFdIdrNp
         NAGEnplyMNQ0PxGrYHFdKYv97Uk56mdYcYtHHqXW3IQ4EYo3kYQWoFHD/edHAx7vJK
         xgfISi9apw9LQ/z+m8Hi55WPSDfQYkHFp4UHhlN4ORu4PStJ7TvmsuvuYZQTgWN+QE
         6Wm0U/Yp0zScf2bIFldUuUDoMbXXaBsqt/sd269PcZey2emu4D75OJZScKAqBJFljY
         Ghxp56ko0c/7Q==
Date:   Mon, 28 Aug 2023 12:40:49 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexandra Diupina <adiupina@astralinux.ru>
Cc:     Chas Williams <3chas3@gmail.com>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] idt77252: remove check of idt77252_init_ubr() return
 value
Message-ID: <20230828124049.6bec893f@kernel.org>
In-Reply-To: <20230828143646.8835-1-adiupina@astralinux.ru>
References: <20230828143646.8835-1-adiupina@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 28 Aug 2023 17:36:46 +0300 Alexandra Diupina wrote:
> idt77252_init_ubr() always returns 0, so it is possible
> to remove check of its return value
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 2dde18cd1d8f ("Linux 6.5")

How is this a fix and if it was how could the release tag possibly have
caused the issue?

I think this is pointless churn, unless the error handling is buggy
in itself you should leave this code be.
-- 
pw-bot: reject
