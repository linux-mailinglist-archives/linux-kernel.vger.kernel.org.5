Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A3F77A16F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 19:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjHLRbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 13:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHLRbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 13:31:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC17BF5;
        Sat, 12 Aug 2023 10:31:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41C84612EE;
        Sat, 12 Aug 2023 17:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF05C433C8;
        Sat, 12 Aug 2023 17:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691861499;
        bh=iUDXVG8e5HhRTBSYUHeFAJZJwhrf70qAOSIQnEWFjLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jdk/X27x9qT/PKWtBeBk1eIEFxLkEFAN2oi0pdNY/96pSVBs8suocssyazALhbyvu
         pngCak7o0fAcGqZItolZERJzpdS9UBxh+ivaAGbsOl5Q6NvaPt7j2Jh0Tz6nG/Up9N
         uIW1k+OX1H4UO1QK2yzP9Eu4jVvchKgc345kc9Zg=
Date:   Sat, 12 Aug 2023 19:31:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     pablo@netfilter.org, stable-commits@vger.kernel.org
Subject: Re: Patch "netfilter: nft_set_hash: mark set element as dead when
 deleting from packet path" has been added to the 6.1-stable tree
Message-ID: <2023081216-pliable-wrongly-98a5@gregkh>
References: <2023081204-open-vitally-a04c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023081204-open-vitally-a04c@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 06:58:04PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     netfilter: nft_set_hash: mark set element as dead when deleting from packet path
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      netfilter-nft_set_hash-mark-set-element-as-dead-when-deleting-from-packet-path.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Also breaks the build, I'll go drop it from all queues except 6.4, sorry
for the noise.

greg k-h
