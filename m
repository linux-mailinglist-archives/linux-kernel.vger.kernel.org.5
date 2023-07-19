Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C546D759A04
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjGSPkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjGSPkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:40:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BB71FF9;
        Wed, 19 Jul 2023 08:40:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A718461763;
        Wed, 19 Jul 2023 15:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9FCC433D9;
        Wed, 19 Jul 2023 15:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689781225;
        bh=yX/Ul0q6k+gD3JIVRJJiWvifByik2J4h1betQHGgVIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2WQq4ocf3+cbAQZPfeA0Q53vhtgOdCkfpVphsaeGYXyTMBDhAqLepxMq1fT7w7X8o
         VtL0tCtyBeEgGrq402GARJ2rpt9AdzNnLycNBKC7tr4BOXH1Hdg11EbqXL0ZKWZf++
         vwDH5H+ZzKEswf5JHHNFFD/LpDIgFk84uKmo7DQ0=
Date:   Wed, 19 Jul 2023 17:40:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, stable@vger.kernel.org,
        Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH v3 3/4] fs/9p: fix type mismatch in file cache mode helper
Message-ID: <2023071914-serotonin-balmy-5d58@gregkh>
References: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
 <20230716-fixes-overly-restrictive-mmap-v3-3-769791f474fd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v3-3-769791f474fd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 03:17:07PM +0000, Eric Van Hensbergen wrote:
> There were two flags (s_flags and s_cache) which had incorrect signed
> type in the parameters of the file cache mode helper function.
> 
> Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
> Link: https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de/
> Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> ---
>  fs/9p/fid.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
