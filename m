Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7D67DEC38
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348524AbjKBFUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 01:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348472AbjKBFUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:20:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDAE116
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 22:20:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B99C433C7;
        Thu,  2 Nov 2023 05:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698902447;
        bh=YhTfqLur7/NQtlk8H9Cl3X4eNRRBK1DfeII4CpjFXWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YwvoDwylHxhrQyMNZbt0YmegaTf9VzAd4jgxPYpYAtTO7666H2DmLp8VFckNRA7h1
         MMgYO7qoq1L+fb9FEEvfpWyPcBvJSHz0jDxas40g1w+CMBmtqL4HomNCruvYXQUu6h
         MdoRq11FdCH0bqi9SUsWu0BNt6L6jwgdPj+mj9HDCTnxoVTTqUmNDuXPE/9bXHl425
         NVBxLI5LTI2EfOQHyIVSlTpBEKh9gy15O/+HvoojJmvaQ/5eAaA9U41USFeRQpZCj9
         rYPr6zaDl6y5IMr6Uy2isOl4Ul8QenaA9LN6IG/iWVE5Uz+XegdK3EjzVXBM03nvFt
         ZMMDQT1Q4fIig==
Date:   Wed, 1 Nov 2023 22:20:45 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     stefanha@redhat.com, sgarzare@redhat.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] virtio/vsock: Fix uninit-value in
 virtio_transport_recv_pkt()
Message-ID: <20231101222045.5f7cca01@kernel.org>
In-Reply-To: <20231026150154.3536433-1-syoshida@redhat.com>
References: <20231026150154.3536433-1-syoshida@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023 00:01:54 +0900 Shigeru Yoshida wrote:
> This issue occurs because the `buf_alloc` and `fwd_cnt` fields of the
> `struct virtio_vsock_hdr` are not initialized when a new skb is allocated
> in `virtio_transport_alloc_skb()`. This patch resolves the issue by
> initializing these fields during allocation.

We didn't manage to apply this before the merge window, and now the
trees have converged. Patch no longer applies cleanly to net.
Please rebase & repost.
-- 
pw-bot: cr
