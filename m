Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F8F758D96
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjGSGQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjGSGQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:16:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F352A2710;
        Tue, 18 Jul 2023 23:16:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 444E3602F1;
        Wed, 19 Jul 2023 06:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225A7C433C7;
        Wed, 19 Jul 2023 06:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689747368;
        bh=t+T4CR1LRsJIOLJggJMoEKySOyakc0tyKErwSDzZ6Ps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WqlsT3G4uAFK3KMitHBb3xrH5iCdMBvy2Y5KDdGdfIkcp7+Yjs0rvop7POdBfp5Xq
         gtXNe3zgiXRShIdzqjkpS3Z4G+dUsJ/XzLYwE3KfXLG2zmdxfpYg9jq9ph6/A/dwOv
         CPfNlacsFkZyUFxAChqLEAV1tavOcbnziJLv8+7chalRiH71zxGaarffsE8ltbYYO5
         UP224f/Ume2sJBJiEPZjAajkzm7Kp0SWf8mKMFOXuWXhpUbwOVJLLV3VEgEgddollY
         cZsA0VsdwEyc7a1PM1r+J6g3goEJCZ4bqLv14EY1LHzJFpWipShiu5MuKp0/UmJZ9+
         b1tQ8WZlpDNBA==
Date:   Wed, 19 Jul 2023 08:16:03 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Tyler Hicks <code@tyhicks.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the vfs-brauner tree
Message-ID: <20230719-dramen-komisch-9c43665a0a5a@brauner>
References: <20230717101114.5add1194@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230717101114.5add1194@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 10:11:14AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the ecryptfs tree as a different commit
> (but the same patch):
> 
>   8b70deb8ca90 ("fs/ecryptfs: Replace kmap() with kmap_local_page()")
> 
> This is commit
> 
>   031a0300f2c9 ("ecryptfs: Replace kmap() with kmap_local_page()")
> 
> in the ecryptfs tree (where it has been since Sept, 2022).

@Tyler, mind dropping it? I'll send it all in one go for v6.6.
