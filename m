Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C9777EF26
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 04:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347665AbjHQCf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 22:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347678AbjHQCff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 22:35:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8305726B6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 19:35:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 122AA63B5B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF4FC433C7;
        Thu, 17 Aug 2023 02:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692239731;
        bh=zIOeh3858fGEdK+Q1WSdpimv6EuLoQVNUwd1qY937oc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W+VVu4CAfknNrwqjOLW2XYSDYAruMDgoJ0xfqzrNvsZyU+BMA3riBJeLt/hBu15HH
         ZnZ6KSpLv4Vj1AVbGv6KLNHS4LqZ+KiHI/WmEHgpKxXo7nu0E2nFmLQNCD3ypRXC5U
         pP6UMFQF8upSKMHp40PjtiKsXrxnjvGpeCkZC1CAAbx5bDprUzXZ8HVFjKQvQuTxH5
         M4Cqdzh+gwrDEVRlpVlrEi7ImXb2Gxv9aSXn0qkpzo++jSZyacXzFbpB6aiJMIV29z
         0yJUj2CnIV3LLkfuzrPf7BIstl9mZliSEfNvR3pJqdO7Gl9C5rDQOVvs6aNfBonnTK
         7nkPiPl7Jr/BA==
Date:   Wed, 16 Aug 2023 19:35:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        vladimir.oltean@nxp.com, s-vadapalli@ti.com, srk@ti.com,
        vigneshr@ti.com, p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw: add mqprio qdisc offload
 in channel mode
Message-ID: <20230816193529.174a57c4@kernel.org>
In-Reply-To: <20230815082105.24549-1-rogerq@kernel.org>
References: <20230815082105.24549-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 11:21:05 +0300 Roger Quadros wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> This patch adds MQPRIO Qdisc offload in full 'channel' mode which allows
> not only setting up pri:tc mapping, but also configuring TX shapers on
> external port FIFOs. The K3 CPSW MQPRIO Qdisc offload is expected to work
> with VLAN/priority tagged packets. Non-tagged packets have to be mapped
> only to TC0.

FTR this got silently merged but I'm reverting it based on Vladimir's
comments.
-- 
pw-bot: cr
