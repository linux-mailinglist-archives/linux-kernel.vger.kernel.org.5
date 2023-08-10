Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E651778353
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjHJWA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjHJWA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:00:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BA62123
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:00:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C89960A5C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C7DC433C8;
        Thu, 10 Aug 2023 22:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691704855;
        bh=s5QIG+X19estRlbIsKWn9bmkPv61euAyFKFlJLfA9uA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YmW+gMTn+RNUvBFT+Vxz6ayGWIm7w8UdC/fGyXCmtPb2ORtcqxu3CVWLSib/XFoiT
         +b79K5P5RkyvSfakLAbmiDgwqPs5bjBVCn90e2Lg4hSJlmqDIZh2Hm0FMwGoUvOoJs
         2m1nw2CJqyULtvqdgft3Fmj5v+QHCnov9Y+dWcP/awKQj4/jPkdPum2FmysCV2Hytd
         XPLKEc/z/48d3fYkc9XXV70vdjOA2kb69sFq3UaeKfsG0RjF6YA23BMjm2Z0TAinza
         i68lPdEiioUMvSAjNNUPgWbcSr0GpeR86tviPqfqdRRSE5mL/+cMrtKvBLSpApbumS
         r4hkpAc+TSLpg==
Date:   Thu, 10 Aug 2023 15:00:54 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>,
        xieyongji@bytedance.com, jasowang@redhat.com,
        david.marchand@redhat.com, lulu@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Subject: Re: [PATCH v3 0/3] vduse: add support for networking devices
Message-ID: <20230810150054.7baf34b7@kernel.org>
In-Reply-To: <20230810174021-mutt-send-email-mst@kernel.org>
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
        <20230810150347-mutt-send-email-mst@kernel.org>
        <20230810142949.074c9430@kernel.org>
        <20230810174021-mutt-send-email-mst@kernel.org>
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

On Thu, 10 Aug 2023 17:42:11 -0400 Michael S. Tsirkin wrote:
> > Directly into the stack? I thought VDUSE is vDPA in user space,
> > meaning to get to the kernel the packet has to first go thru 
> > a virtio-net instance.  
> 
> yes. is that a sufficient filter in your opinion?

Yes, the ability to create the device feels stronger than CAP_NET_RAW,
and a bit tangential to CAP_NET_ADMIN. But I don't have much practical
experience with virt so no strong opinion, perhaps it does make sense
for someone's deployment? Dunno..
