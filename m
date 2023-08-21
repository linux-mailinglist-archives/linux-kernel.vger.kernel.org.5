Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC5D7830CF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjHUTLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjHUTLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:11:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF3F131
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:11:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41CB8635F3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA2BC433C8;
        Mon, 21 Aug 2023 19:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692645087;
        bh=bLnmPR/fj6fxgZzD4TUsyHXd4feqUx23RQO7PPhMvtQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UH/tHdFOF4v1GEZMnE4oLN4QzHj9POPj4vYSrCGRzZC0hE4yM7KE3HcPXkYHFaZyU
         oIkcEp5gXzgFdi9+MQ/VPpzqKDK5VURcY4mbjwG3qon3kto/c5Liv7S+CecgLZTsX5
         PqmywcHUfVdrr9fAj2Yg3ITLQ/4YN6uLP2q97CF2OKvIiMonheypFwhIihZdkD08L1
         d0BfhB4+QQrYCG7wudO668xX10032kiPaqHISA417/OW3NiZVwjNvdvP+xIGWewftS
         Jjn3losV+WW+m7kyy7L425up2Fq88/Z+uJP6ji/+oHVKW+5cy2+yOFmLSkwku0PF//
         a7Qio2ZUBor5Q==
Date:   Mon, 21 Aug 2023 12:11:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Brett Creeley <bcreeley@amd.com>,
        patchwork-bot+netdevbpf@kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>, edumazet@google.com,
        davem@davemloft.net, pabeni@redhat.com, shannon.nelson@amd.com,
        brett.creeley@amd.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] pds_core: Fix some kernel-doc comments
Message-ID: <20230821121118.394c713b@kernel.org>
In-Reply-To: <20230821112237.105872b5.alex.williamson@redhat.com>
References: <20230821015537.116268-1-yang.lee@linux.alibaba.com>
        <169260062287.23906.5426313863970879559.git-patchwork-notify@kernel.org>
        <ed1bd63a-a992-5aef-f4da-eb7d2bc64652@amd.com>
        <20230821112237.105872b5.alex.williamson@redhat.com>
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

On Mon, 21 Aug 2023 11:22:37 -0600 Alex Williamson wrote:
> I'm sure Linus can fixup the conflict, but a preferable solution might
> be to drop the patch from Yang Li from net-next.  Thanks,

Slightly tempting to just move the HEAD back by one commit but IDK what
consequences this would have for people who base their branches on
net-next. So I'll revert.
