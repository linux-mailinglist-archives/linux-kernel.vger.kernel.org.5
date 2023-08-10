Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50372778248
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbjHJUqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjHJUqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:46:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D19C1BF7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:46:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2242C63DFA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D18C433C9;
        Thu, 10 Aug 2023 20:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691700389;
        bh=/L1/FoIolTCX5+WO1AdKsvpi/9tkJrtA02vyz07SQxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DSf0elE5/+x+ysK6HrH2O7I9Zc8jcBnZLRrpmX5p32f00gEXV58IY3TspVfxphrVx
         vbfHvAGur24PsvXR66o0FN+OeK5fwQ+gHISM9LZ6KQsoHTn7+6uHP3dPddTv+KFnC8
         qpnb1EUjGtkb6BqS9Dj1Hu20kn+3Mfqqs7SyQNkILQrf4TCygqkiLxOmgje6Crxbua
         dW2BUae3XS06mcR05vZdBSLsx0i5YjAtwGL0oSTgdp1Rwrj68LROeMVYhWTfYN5KOO
         sFo0EtpRXo0+XAAPXYQzcm2asCtDNENXxqC3WKWKBfrL6OLsPMR9NumlQq/J0SCkVD
         H7HvMLIUSUkrQ==
Date:   Thu, 10 Aug 2023 22:46:23 +0200
From:   Simon Horman <horms@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Geoff Levand <geoff@infradead.org>,
        Petr Machata <petrm@nvidia.com>,
        Piotr Raczynski <piotr.raczynski@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Liang He <windhl@126.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ethernet: ldmvsw: mark ldmvsw_open() static
Message-ID: <ZNVMn1HMuV0LvnqD@vergenet.net>
References: <20230810122528.1220434-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810122528.1220434-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 02:25:15PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The function is exported for no reason and should just be static:
> 
> drivers/net/ethernet/sun/ldmvsw.c:127:5: error: no previous prototype for 'ldmvsw_open' [-Werror=missing-prototypes]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested
