Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512B67B8701
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243535AbjJDRxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjJDRxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:53:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81969E;
        Wed,  4 Oct 2023 10:53:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1398FC43395;
        Wed,  4 Oct 2023 17:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696441998;
        bh=LTu2Bz+uaRRsDt3o9GbnxUenQJtJb+UgTi4E6dBfxU0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZPNJbm1lU6aKZP+vpkX2TCKRzT1EefnCdRlKE6Fv/SZg07H2c5mwjDO2qPP8ynpWg
         iaz5b0mXFeSLuYGXxtoFehSLf2LkYDhZYdGUwp46zI1WAbC7AnWXsgS8w+49QkAhWQ
         jnPLY5Db8CDQ/z49mkZsTXcJgcKU4FGDymy8bQJLpN1L2rhgN6p0kgzVPWGWe83Y3t
         Rcq223xAwhoPjbgytffWIB33zCBdgZBFoRcJL8eut97zVES1EGrniVy0KCvXZ2ausB
         qpaXvTYWYRG8oobDp9lenu7my+uGE5SBebJWrbUJep3e2khdvWgNWp0nLCsxdxW2/p
         UnQf/K1MTBGsw==
Date:   Wed, 4 Oct 2023 10:53:17 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Simon Horman <horms@kernel.org>
Cc:     Chengfeng Ye <dg573847474@gmail.com>, jreuter@yaina.de,
        ralf@linux-mips.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, linux-hams@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ax25: Fix potential deadlock on &ax25_list_lock
Message-ID: <20231004105317.212f1207@kernel.org>
In-Reply-To: <20230930161434.GC92317@kernel.org>
References: <20230926105732.10864-1-dg573847474@gmail.com>
        <20230930161434.GC92317@kernel.org>
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

On Sat, 30 Sep 2023 18:14:34 +0200 Simon Horman wrote:
> And as a fix this patch should probably have a Fixes tag.
> This ones seem appropriate to me, but I could be wrong.
> 
> Fixes: c070e51db5e2 ("ice: always add legacy 32byte RXDID in supported_rxdids")

You must have mis-pasted this Fixes tag :)

Chengfend, please find the right Fixes tag and repost.
-- 
pw-bot: cr
