Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F097BF0E8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441854AbjJJCcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjJJCcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:32:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0AB9E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 19:32:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE85C433C8;
        Tue, 10 Oct 2023 02:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696905120;
        bh=6o/kjifs3KbWaTn2Ziz1oUxyttEWW/VK6fOR+vDlP+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WKhfXdPXd4hKZolc8afo6KCkwSDD6WhLH7rwXXpXObKidjQyYtNHlXwKqlcbFht/l
         wSvUEl5v49s7syQjj7ob+F+oZtM6fZywh61M8OXBU99PJvWytwTMkEVDlEyUcvCWKT
         9cuFpsjbxbhENrXR4KrSumFHPs9OWoShBAMqSDjTqVMTfh9OuERP1e/8U/s7bKcxCy
         FOMAoC/WnBYBgYwmHAHnIZnztnl5w8KJW5DR/UN2U1diXMclcw1kSxGFdSLljTBBUk
         NGFp/71CmtFTHdOFu3vWO0CqLXZWKjQ1H8+eSfywLLCLpmy4B9cHa65BtqlK2FszRM
         vzMaETWwxpwOA==
Date:   Mon, 9 Oct 2023 19:31:58 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     jlbec@evilplan.org, davem@davemloft.net, pabeni@redhat.com,
        Eric Dumazet <edumazet@google.com>, hch@lst.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
Subject: Re: [PATCH net-next v2 1/3] netconsole: Initialize configfs_item
 for default targets
Message-ID: <20231009193158.28a12cd8@kernel.org>
In-Reply-To: <20231005123637.2685334-2-leitao@debian.org>
References: <20231005123637.2685334-1-leitao@debian.org>
        <20231005123637.2685334-2-leitao@debian.org>
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

On Thu,  5 Oct 2023 05:36:34 -0700 Breno Leitao wrote:
> +static void populate_configfs_item(struct netconsole_target *nt,
> +				   int cmdline_count);

Could you move alloc / free_param_target() to avoid the forward
declaration? (separate patch)
