Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4747715ED
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjHFPhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 11:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHFPhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 11:37:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7069A9F
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 08:37:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AAB8611AE
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 15:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2507FC433C7;
        Sun,  6 Aug 2023 15:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691336269;
        bh=QBn8NPkWp6aHEu6yqGnfnqh3BbKlk/in2dLR6TFx3Yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jzXQcRhjhBj2ZK+T6UAU4DoxsC3QkltgzNCXm+GSy9pqhdQ/+PWTCOUGb+yZqMMwp
         tBqu1TeODn5BWFhqfMxTyQaiP43OFpKKrTxeZ6QdIL5ZKWycbC/d5WvCxtZ4qyKpBe
         izThVgiRrMgq6TH60LLS4bqc+eAtI0E2tlp6eOmrWIHVXlea2qJhPPhgvJlN83zv4u
         O+dNfIEcfoRgDoDT2d8oiKxMOSmsLmViSzF6mMHN/k0Pf1ahfX5lKcQlb5vJUUy33E
         FxlpINzYSxakrSfqXng59+OMSQ+IxvvJRHeU1+gytDUw+uStFPvwnZ71CdkL1bMnR8
         XuSFNlfpwhlKA==
Date:   Sun, 6 Aug 2023 17:37:44 +0200
From:   Simon Horman <horms@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, robh@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v2 00/10] net: fs_enet: Driver cleanup
Message-ID: <ZM++SM4xJ1K6bBxc@vergenet.net>
References: <cover.1691155346.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691155346.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 03:30:10PM +0200, Christophe Leroy wrote:
> Over the years, platform and driver initialisation have evolved into
> more generic ways, and driver or platform specific stuff has gone
> away, leaving stale objects behind.
> 
> This series aims at cleaning all that up for fs_enet ethernet driver.
> 
> Changes in v2:
> - Remove a trailing whitespace in the old struct moved in patch 7.
> - Include powerpc people and list that I forgot when sending v1
> (and Rob as expected by Patchwork for patch 6, not sure why)

Thanks, this looks good to me.

For the series,

Reviewed-by: Simon Horman <horms@kernel.org>

