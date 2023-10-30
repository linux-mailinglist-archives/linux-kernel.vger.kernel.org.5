Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B017DC303
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 00:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjJ3XPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJ3XPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:15:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8BEC1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:15:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB760C433C9;
        Mon, 30 Oct 2023 23:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698707705;
        bh=9umW4ZL1h/kspfg3KCaDmu0m+cqzhiIXiYtpSFVPNOA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GH4SCN612U+QFEpNv1tXJb1QCWqn457q8C6WX+17HrdA3G4JiyNsmt9s07RyQtINu
         G79YXdsQ49Btr48yd9YFwggdd+sU/DDrLiowqpQMPe/ybEiy4HhPsVXf03PwYx2AS1
         tjs9LJPqZIIUbDabAeLmFUyBgiIks2iNpriGWASMwe/vMptMqbkezHnNHETmo9q9C/
         bfm0Q91P2pfI5d/EV3lIF5M2Xv78SpskFsrIiLlOnrl5VJdINl13phLCLLeCdQtr44
         34Ft3QSwynllml8145pzK5720Zpt4tEl7h7a46YgDx8/YgdYddSCfAT1IZ7CToiX4f
         kk/qysJPIgc/A==
Date:   Mon, 30 Oct 2023 16:15:03 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: Re: [GIT PULL] Networking for 6.7
Message-ID: <20231030161503.4f247eeb@kernel.org>
In-Reply-To: <20231028011741.2400327-1-kuba@kernel.org>
References: <20231028011741.2400327-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023 18:17:41 -0700 Jakub Kicinski wrote:
> Hi Linus!
> 
> I'll be traveling next week, so anticipating no -rc8 here is our
> merge window material.

Minor heads up, there's a silent conflict with the crypto tree,
you may want to squash this into whichever you merge second:
https://lore.kernel.org/all/20231030160953.28f2df61@canb.auug.org.au/
