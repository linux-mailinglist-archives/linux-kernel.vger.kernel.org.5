Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A01B7782B1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjHJV3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjHJV3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:29:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572E526A0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:29:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6BB364669
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 21:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BDBC433C7;
        Thu, 10 Aug 2023 21:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691702990;
        bh=udij2PLbfirwon6in/VcXMGaiWAROe2LPcfk4aF2xiA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kr4fT1MZ5n4GcU6trzHtMM5Y0K2DmSAq6NFe0l/WM2mtlZQTgFAYtRe7GiNfmHtki
         GkMwXKRH29jk22YBx5KtKeMnebZaxeX6+GM35fEtCbSX0ToaJy2HXrRz7ZvWHo/ADf
         HiFtf8j9CS3CqUNg2LzSSzalFMq/aG6x4NkCc+gVxJJKSKo7xBvgoXdBS2wzdyFfHV
         ESvT848fAvMkyl3rMEKWJZYchVB/JBlBSmEAlUGPbHHsG163YyagOEVG9HW+FASyzU
         P83eyNvkLm4TBsrlRGOO+G1y78XpBvTN4RLSA05q4FNQwqJMSMXKKkOJk1Ezxwpb8j
         fqMNoWQC9exYQ==
Date:   Thu, 10 Aug 2023 14:29:49 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>,
        xieyongji@bytedance.com, jasowang@redhat.com,
        david.marchand@redhat.com, lulu@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Subject: Re: [PATCH v3 0/3] vduse: add support for networking devices
Message-ID: <20230810142949.074c9430@kernel.org>
In-Reply-To: <20230810150347-mutt-send-email-mst@kernel.org>
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
        <20230810150347-mutt-send-email-mst@kernel.org>
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

On Thu, 10 Aug 2023 15:04:27 -0400 Michael S. Tsirkin wrote:
> Another question is that with this userspace can inject
> packets directly into net stack. Should we check CAP_NET_ADMIN
> or such?

Directly into the stack? I thought VDUSE is vDPA in user space,
meaning to get to the kernel the packet has to first go thru 
a virtio-net instance.

Or you mean directly into the network?
