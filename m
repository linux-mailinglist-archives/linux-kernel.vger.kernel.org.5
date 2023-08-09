Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C15077542F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjHIHc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjHIHcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:32:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51419E61;
        Wed,  9 Aug 2023 00:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E576C62FFC;
        Wed,  9 Aug 2023 07:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD871C433C8;
        Wed,  9 Aug 2023 07:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691566341;
        bh=+MVa0ePyDrCY62pmWvjRNYg5sLo14nlpj/nK6ltEC80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ATA/D7UvUrwIuIcfFYkBgo1y4vn+BOHJ57VVmVUpvLOqKNlqYPaCigCQMd/WmyPcO
         Jgpszm6yIkvhtnUNGQYFI3Cd8pCQnmj74FNe4CSgP9BWs/LvI3WMiqwVZBNxZkLZzU
         uo344x0txIEtsXMBaOEXpgW9Coyfwi6tqPv+itqE=
Date:   Wed, 9 Aug 2023 09:32:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     stable-commits@vger.kernel.org, Yuezhang.Mo@sony.com,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Subject: Re: Patch "exfat: move exfat_entry_set_cache from heap to stack" has
 been added to the 5.10-stable tree
Message-ID: <2023080949-reveal-curling-20fa@gregkh>
References: <20230809014920.320461-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809014920.320461-1-sashal@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:49:19PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     exfat: move exfat_entry_set_cache from heap to stack
> 
> to the 5.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      exfat-move-exfat_entry_set_cache-from-heap-to-stack.patch
> and it can be found in the queue-5.10 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This patch broke the build, so I've dropped it, and the other exfat
patches from the 5.10.y queue for now.

thanks,

greg k-h
