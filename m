Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FDC754F4A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 17:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjGPPNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 11:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGPPNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 11:13:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B05E1B7;
        Sun, 16 Jul 2023 08:13:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDD4360CEC;
        Sun, 16 Jul 2023 15:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0101C433C8;
        Sun, 16 Jul 2023 15:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689520422;
        bh=cWG4PNnZsug6VEfKe/LFOgjXd2wLbV9Kp7KvEO+UGcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jleRNJPpVnEDCJq7WR8xqLMk5k8IAWm32fdwviDhU3KSHK+3kOohyYSCU6w0OeW34
         EqLBWj+/4VvtNTvLAEOtMF6NlTyAXU+ugVere7H8VvhHS8xKWkCpbKd/ifZhcJX9O5
         pqp4VDsL/u0VGL/CPbfq48cfqvN4QwkFTe1LjDlI=
Date:   Sun, 16 Jul 2023 17:13:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     miklos@szeredi.hu, amir73il@gmail.com,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH 5.15] ovl: fix null pointer dereference in
 ovl_get_acl_rcu()
Message-ID: <2023071631-mulch-dork-101c@gregkh>
References: <20230710032730.2049748-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710032730.2049748-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 11:27:30AM +0800, Zhihao Cheng wrote:
> [ Upstream commit f4e19e595cc2e76a8a58413eb19d3d9c51328b53 ]

Thanks for this, now queued up.

greg k-h
