Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B827CA41F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjJPJ2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPJ2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:28:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC6A95
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:28:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C881C433C7;
        Mon, 16 Oct 2023 09:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697448516;
        bh=6JVObMnC4svsaTvSG8K5uJD/aYfQg4KvX/i+ng9zLzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tBpJm/4sfi9pjqlEPxEwfuMGj9VpZ8GCNsqNmZnLYM2MX9jk1qfXPaH5jsagRjnVv
         d94EeUHhfTrZ4wYMGj3cYtHMf2gvjTFFkU4RsPZu47pwFDZUbv1dmw7HfiumUUO/vl
         3CYNbn6Tl9U33BORhE3diJDkYm9fpKEL8xtrP4FTX+lz3hGft2E5xnhKkAljt8X8r7
         UMEI/0DuleO/IrXXW0p28inkbFVW3WH9zlWjfpqctGjbVQT1qQZj7klW1YTOpHuaPV
         r6ZNqjYs1YPWCRXc7l8IGy08MD6ghpDaGuuN3ibMZh+o8vSBLKTxdAndnlook3eklG
         YMnHl9017y8EQ==
Date:   Mon, 16 Oct 2023 11:28:32 +0200
From:   Simon Horman <horms@kernel.org>
To:     Liansen Zhai <zhailiansen@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuwang@kuaishou.com,
        wushukun@kuaishou.com, Liansen Zhai <zhailiansen@kuaishou.com>
Subject: Re: [PATCH net-next,v2] cgroup, netclassid: on modifying netclassid
 in cgroup, only consider the main process.
Message-ID: <20231016092832.GI1501712@kernel.org>
References: <20231012090330.29636-1-zhailiansen@kuaishou.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012090330.29636-1-zhailiansen@kuaishou.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 05:03:30PM +0800, Liansen Zhai wrote:
> When modifying netclassid, the command("echo 0x100001 > net_cls.classid")
> will take more time on many threads of one process, because the process
> create many fds.
> for example, one process exists 28000 fds and 60000 threads, echo command
> will task 45 seconds.
> Now, we only consider the main process when exec "iterate_fd", and the
> time is about 52 milliseconds.
> 
> Signed-off-by: Liansen Zhai <zhailiansen@kuaishou.com>

Thanks for addressing my review of v1.

Reviewed-by: Simon Horman <horms@kernel.org>
