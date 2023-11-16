Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485CC7EDB65
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 07:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjKPGDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 01:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjKPGDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 01:03:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C03E19B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 22:03:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38BDC433C7;
        Thu, 16 Nov 2023 06:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700114592;
        bh=3mqFKUsuT68n/sSTZqcH0Cb8LWIbVDw0n692TohaKl0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IjN+hJ0obX4QdrYRIph8gkaAWwAvWhIAD/DxfdJ8gAmlVJSF/azMgC2Lz25mqb1/j
         9bW4kljHbqs17Yu8C3H8HmxjcjIdaCg0tlJLECqbhMOYh2EeaB/Hoyawf5OnYnlJFt
         nWay1GD6xH0S5dDSLOmLcMCCjgmeTg1aFKwV2NDFmvlR20ZI4Nc7/Z9EZwjFXTFbFD
         85Yd/ZVaMUL+DA3k9UGgqRzqCcaioJCIr4ZnHC0GJlc1yecnqZGWCPnkzr1Q1AlY/N
         eY+TQt2oE4Gt8INaw0JYXCpNFrJ1xwcvYF+dNxDCA+mrcaYUyIaTL6fMDRRxXm/VQ2
         GKPGdqdOFMCnw==
Date:   Thu, 16 Nov 2023 01:03:10 -0500
From:   Jakub Kicinski <kuba@kernel.org>
To:     Simon Horman <horms@kernel.org>
Cc:     Tobias Klauser <tklauser@distanz.ch>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next] indirect_call_wrapper: Fix typo in
 INDIRECT_CALL_$NR kerneldoc
Message-ID: <20231116010310.4664dd38@kernel.org>
In-Reply-To: <20231115175626.GW74656@kernel.org>
References: <20231114104202.4680-1-tklauser@distanz.ch>
        <20231115175626.GW74656@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 17:56:26 +0000 Simon Horman wrote:
> To the netdev maintainers: get_maintainer.pl doesn't seem to
> know much about include/linux/indirect_call_wrapper.h.
> Should that be fixed?

I'm curious how many of such files exist under include/linux.
Files which are not really networking specific but only tree
the changes ever went thru is netdev.. 
But yes, in the interest of "taking responsibility" we should
probably claim it.
