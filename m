Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAA778FEA5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345152AbjIANzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjIANzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:55:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6127F10EC;
        Fri,  1 Sep 2023 06:55:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDD6F60AFD;
        Fri,  1 Sep 2023 13:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DD4C433C7;
        Fri,  1 Sep 2023 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693576548;
        bh=+VvfZVPGs4uQ9zqARpEX9ACbrVsYYT1G2wpq8eWpZJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RXayCCtUUumCsXNuP07jC5j+7VbZ1/+ZPxMMP8oSEPuWhNBaCklCmd7vDl2+RMyJY
         YGac+HqLRIYrmG9PvVBJO83jZE85OWdpEyLSUuy/Yb/DQkxR+gD9fnTGVyF9tEOFqO
         s49nOeh5uPNxxUQKnUO2x39CXz99bA0k699zxZ7BFzlzM+JqEcFCiK6GKYT9LDfHZW
         s8uNyMoQI3SQC3PPnyuuECbdfAF9bBIXe3uePDJQyHKbF8EJOcYA4faYoupczScP4E
         nJfkvCnMcq206fyeOZLlAM/XdjgsBU3RLZK25AwGdYL2BEOyDdr2cNBfXYhCcmyqB3
         RXCA6H2cRJOGg==
Date:   Fri, 1 Sep 2023 15:55:34 +0200
From:   Simon Horman <horms@kernel.org>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     idryomov@gmail.com, xiubli@redhat.com, jlayton@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ceph-devel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ceph/decode: =?utf-8?Q?Remove_?=
 =?utf-8?B?dW5uZWNlc3Nhcnkg4oCYMOKAmQ==?= values from ret
Message-ID: <20230901135534.GG140739@kernel.org>
References: <20230902201112.4401-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902201112.4401-1-kunyu@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 04:11:12AM +0800, Li kunyu wrote:
> ret is assigned first, so it does not need to initialize the
> assignment.
> Bad is not used and can be removed.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>

Hi Li Kunyu,

A few things:

* Your clock seems to be in the future.

* I see you have posted similar similar changes to related code.
  Please consider combining them into a single patch,
  or a patch-set.

* Please set the target tree, net-next

  Subject: [PATCH net-next] ...

* net-next is currently closed

## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer
