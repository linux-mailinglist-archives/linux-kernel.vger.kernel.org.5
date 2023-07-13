Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498BD7517F1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjGMFTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjGMFTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:19:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688D22114
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:19:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0042C616B0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5EFC433C7;
        Thu, 13 Jul 2023 05:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689225580;
        bh=UORb9mc0lGDf75zSOdKYCgMV7oZNdLKIXMMWW6q0N5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j6g+cCZs+khGuIxRz84uliHvE461LQgBMfHoehprB45BRCFOqLRQ/Icmy2VmsAhZL
         Ckl8k9B6eUph1LLJCgh07g/gYX4e3/OqwK17L+iuCuCU7SkdKVpMhIC6ao17qVea+T
         Hv8CO//9N4HOKsI5feWg5cfFI5n9Y8/dG+q/w27h3CES8TUENYCpm7Tbi8jZoy2XKw
         4EwWw+RhLGA4pYKNuXkMYZLKUm5u76b2HnhzsKJEQSdZq9DVFThBqLL7+ffKD61uqa
         K00MjFdCXYqoMKmnwE2xGBElrZ4cRPiDoIyfgAeCyO2ZI8Ay4g4/ZxmmC/ZMY0IyZP
         1pk1dEFyRiV9Q==
Date:   Wed, 12 Jul 2023 22:19:38 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [net PATCH 1/3] octeontx2-af: Fix hash extraction mbox message
Message-ID: <20230712221938.0ae4374e@kernel.org>
In-Reply-To: <20230712111604.2290974-2-sumang@marvell.com>
References: <20230712111604.2290974-1-sumang@marvell.com>
        <20230712111604.2290974-2-sumang@marvell.com>
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

On Wed, 12 Jul 2023 16:46:02 +0530 Suman Ghosh wrote:
> As of today, hash extraction mbox message response supports only the
> secret key. This patch adds support to extract both hash mask and hash
> control along with the secret key. These are needed to use hash
> reduction of 128 bit IPv6 address to 32 bit.

What are hash mask and hash control?

Why is this a fix and not a new feature / extension?
