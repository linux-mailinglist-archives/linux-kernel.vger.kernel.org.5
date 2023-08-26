Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F274178932C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 03:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjHZBv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 21:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjHZBvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 21:51:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686892106
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 18:50:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 075CA60BD3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 01:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F0CC433C8;
        Sat, 26 Aug 2023 01:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693014658;
        bh=T8134DBtc6QVe+JLnbNIFkvgc1ywDwi/8qUoC5fSQAk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hbYyEM61f06vCUWvSAxuPp1dgBhyKsIh08v4+1nPRIuqHonoIgkjeZE7fc71YYYlM
         wH9zijy3RpGKHNE9BNFBZNAokTIyOguo51y86hzYIv8vHzSeEqApPO077vXbkmnKB2
         j0cbo1IcI+IZZM7ymm+RWNWRKRWJXHz8y9bE6yXTF8DNDARn19BRcaRJMAwSsJ5Exa
         A+/fIjzb+J+L3ARSxr1yKIR2FOOkt4PNRUsa/66ze5gjGNzLD5dLZY1bqCU4EcM+8A
         vMdOaV83HjpifSQTXgsPxkH2Qnsxrrk8g4xPR/iAwQ7cJIJ506h0lD/9fZjtoqFpeU
         q9pFRPTw7DOXA==
Date:   Fri, 25 Aug 2023 18:50:56 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>
Subject: Re: [net PATCH V4 0/3] Fix PFC related issues
Message-ID: <20230825185056.393131aa@kernel.org>
In-Reply-To: <20230824081032.436432-1-sumang@marvell.com>
References: <20230824081032.436432-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 13:40:29 +0530 Suman Ghosh wrote:
> This patchset fixes multiple PFC related issues related to Octeon.
> 
> Patch #1: octeontx2-pf: Fix PFC TX scheduler free
> 
> Patch #2: octeontx2-af: CN10KB: fix PFC configuration
> 
> Patch #3: octeonxt2-pf: Fix backpressure config for multiple PFC
> priorities to work simultaneously

Minor note for the future, if you don't mind.
Please add the prefix to the subject of the series as well
(octeonxt2: ...), that way it's clear what the driver is
in all the places which use the subject of the cover letter
to identify the series.
