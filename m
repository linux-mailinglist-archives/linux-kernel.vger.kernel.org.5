Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA9A76EFD4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbjHCQnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjHCQnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:43:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01DFE4D;
        Thu,  3 Aug 2023 09:43:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DD9361E41;
        Thu,  3 Aug 2023 16:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E6DC433C9;
        Thu,  3 Aug 2023 16:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691081024;
        bh=t2efrwd21vFvvl7GhICo1tZ73gri6q0VneszKH4LxNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=St6hTYZKmM99n7KxnE0J+5FCP45WP+hKD9Nbc28A/nQursI7MwoqUNHEBAfYd57UJ
         w6LZ46FhYfB9qtbGRXoYHsSSgnNdq1rG56cUvKiiSe2VTIyqmgc4r3aGlPb1oAk9oL
         NgbdOVyVmrQW1wguLZs3IfHtnREiESDbTqccrxynazZCTkeAi/1G7kNxdHxYd4mvsF
         dDPx9iM12bzmTtc+F/xpL58KwcWLDT2xsjhdtcav8BNRFjnrYMlE+Z7pQQ5r9lvw+Q
         B+p2KVsJzjBclYftr5P+z6Hnh7Yn9fs7dZlEYviUGxfr++bPvan5c5mpgi8BVn+fF4
         l7+ogYlD/+b6w==
Date:   Thu, 3 Aug 2023 09:43:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] tun/tap: set sk_uid from current_fsuid()
Message-ID: <20230803094343.698b3c34@kernel.org>
In-Reply-To: <20230731164237.48365-1-lersek@redhat.com>
References: <20230731164237.48365-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 18:42:35 +0200 Laszlo Ersek wrote:
> The original patches fixing CVE-2023-1076 are incorrect in my opinion.
> This small series fixes them up; see the individual commit messages for
> explanation.
> 
> I have a very elaborate test procedure demonstrating the problem for
> both tun and tap; it involves libvirt, qemu, and "crash". I can share
> that procedure if necessary, but it's indeed quite long (I wrote it
> originally for our QE team).
> 
> The patches in this series are supposed to "re-fix" CVE-2023-1076; given
> that said CVE is classified as Low Impact (CVSSv3=5.5), I'm posting this
> publicly, and not suggesting any embargo. Red Hat Product Security may
> assign a new CVE number later.
> 
> I've tested the patches on top of v6.5-rc4, with "crash" built at commit
> c74f375e0ef7.

FTR this was applied yesterday to net. Thanks!
