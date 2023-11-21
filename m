Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18127F3926
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjKUWaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUWaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:30:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0488119E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:30:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A45EC433C8;
        Tue, 21 Nov 2023 22:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700605802;
        bh=j7aU0i8BzZ0LWN5tC676qAeLCJLeUSdku5k+b6N9i6U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U4TUrZedEFvbcBlmmpC9Gs1a7TVbDWGT56xCuhYva+NYZSlcBAYnXPnatx2olRHoy
         cGv4loLsDlRqCfWUG4NJs52rF1IbrFzMPv5N1ZaQSL+x2v0dd16kkgOSQVSKJ8m/Gu
         OXqU5f4nxSrOyWjFTI1flvbSjMS8ws5A/ie76W8mLhulU6EJg4vMGuuEgLgstfVu/m
         mOgc6GD6PxJ12mT1n1nKNf2jl5FJ/YO4XeCR+HOGolPXaG1VprGtKY+N2bui/EB/g1
         v8KdRswzCcUSyLg6JRj7e+GFfYIHSAvLwaucVUBuJCnhBqu5xCtP2b6dE3G6Wux2Jx
         HAfvsv8hprMNw==
Date:   Tue, 21 Nov 2023 14:30:01 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 09/17] tty: hso: don't emit load/unload info to the log
Message-ID: <20231121143001.4990312c@kernel.org>
In-Reply-To: <20231121092258.9334-10-jirislaby@kernel.org>
References: <20231121092258.9334-1-jirislaby@kernel.org>
        <20231121092258.9334-10-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 10:22:50 +0100 Jiri Slaby (SUSE) wrote:
> It's preferred NOT to emit anything during the module load and unload
> (in case the un/load was successful). So drop these prints from hso
> along with global 'version'. It even contains no version after all.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>

Acked-by: Jakub Kicinski <kuba@kernel.org>
