Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D157B98BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 01:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjJDXjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 19:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjJDXjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:39:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292A1CE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 16:39:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B741C433C8;
        Wed,  4 Oct 2023 23:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696462770;
        bh=XcrEHh7VURvqf+a/pDJhVah/wclnCHtLqyJgoKS2JRw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ygx4Czz/3hK4v/b+Kq43HLoPDxlzdl1EcIydhNPn3vplsq00Otzn0ARDzFbb5H8Kw
         BVmkSE8EXwl7JdzUdUTTVK5g5vQkx8fwCVIT164+OgUvA30IBN0lkN+kXYgd6tDan3
         M1/R+B8onwi7+t6QbAG7z+hJmRk2sVE3rPXFqpreiMXUh7Fb/w8XmIHsvdeHzUyBTd
         39mYAdQ47fawhUW6ZK0XwoByt8XS+ZXgCbNoc0XFvQwpAhWUBuYgL67s/60xDgEfXn
         aVPVrrXVfgOF/+rSSRaQVuT7KgRy68KCDQEwPMWWIklrHPUKmM6j2PipWaCUBTIkNV
         jGJsySgr4alnQ==
Date:   Wed, 4 Oct 2023 16:39:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Moshe Shemesh <moshe@nvidia.com>
Cc:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Jiri Pirko <jiri@nvidia.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] devlink: Hold devlink lock on health reporter dump
 get
Message-ID: <20231004163929.70977d05@kernel.org>
In-Reply-To: <1696173580-222744-1-git-send-email-moshe@nvidia.com>
References: <1696173580-222744-1-git-send-email-moshe@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Oct 2023 18:19:40 +0300 Moshe Shemesh wrote:
> Devlink health dump get callback should take devlink lock as any other
> devlink callback. Add devlink lock to the callback and to any call for
> devlink_health_do_dump().
> 
> As devlink lock is added to any callback of dump, the reporter dump_lock
> is now redundant and can be removed.

I love the change but it needs more info in the commit message :)

 1. what exact / example but real problem are you solving?
 2. some words of reassurance that you checked all the drivers
    and the locking change should be safe (none of them take
    instance locks in reporter callbacks etc)
-- 
pw-bot: cr
