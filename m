Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCFA7F1E92
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjKTVOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjKTVO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:14:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84535C4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 13:14:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41E9C433C8;
        Mon, 20 Nov 2023 21:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700514866;
        bh=487b6FPg1xIDbQ/pxGNTb0FaznMLNOH9vYL7GyLQj/Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DrHmb5wfqN3Pyv3DZTA9D7EOZFwsXaWEIYQisXe4v8zskMyB23kwACppmYc+TowL4
         +5W+RGy0YZ4l5KYY74eChIm8T6nPU6wavkenXC3V1MhqO5l7TZazKiqGKAgMBaRFxE
         URVHqwpigvtwwoMaHsFiZiVOaUxRtl7VS7wW0W/YfueSAR+dd63U4ltDl+GUlfQ12c
         xRl0Z6mni2E2WLMJJNYvCJ4KRCP6hZDsjLzLWo6mqExsVnbRjQ8V+bZ2oVQjEXy+oZ
         SNPrNwJ0WdGuyGVy8A1P6WXojPOrWkb6wq9lWdgtDWCwpQYHXUw4068dUjf+YCpPun
         pkDsx/FzpTLVQ==
Date:   Mon, 20 Nov 2023 13:14:24 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     leit@meta.com, Jonathan Corbet <corbet@lwn.net>,
        netdev@vger.kernel.org, donald.hunter@gmail.com,
        linux-doc@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Document each netlink family
Message-ID: <20231120131424.18187f0e@kernel.org>
In-Reply-To: <ZVvE36Sq1LD++Eb9@gmail.com>
References: <20231113202936.242308-1-leitao@debian.org>
        <87y1ew6n4x.fsf@meer.lwn.net>
        <20231117163939.2de33e83@kernel.org>
        <ZVu5rq1SdloY41nH@gmail.com>
        <20231120120706.40766380@kernel.org>
        <ZVvE36Sq1LD++Eb9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 12:43:11 -0800 Breno Leitao wrote:
> > %.rst: $(YNL_YAML_DIR)/%.yaml
> > 	$(YNL_TOOL) -i $< -o $@  
> 
> That is basically what it does now in the current implementation, but,
> you don't need to pass the full path and no output file, since it knows
> where to get the file and where to save it to.
> 
> If you are curious about the current python script, I've pushed it here:
> https://github.com/leitao/linux/blob/netdev_discuss/tools/net/ynl/ynl-gen-rst.py
> 
> I can easily remove the paths inside the python file and only keep it in
> the Makefile, so, we can use -i $< and -o $@.

I think switching to -i / -o with full paths and removing the paths
from the generator is worthwhile.

We'll need to call the generator for another place sooner or later.
