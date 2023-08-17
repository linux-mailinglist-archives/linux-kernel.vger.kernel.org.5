Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B99877FC27
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352365AbjHQQbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352150AbjHQQbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:31:09 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBED173F;
        Thu, 17 Aug 2023 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1692289855; bh=qJcU5Nw4ZhAM/ZXqvDRC0z8gHB9DFVPeYiejdM3zgiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DonZkdJc3+HKPCIx9DIBYyXUzhXvGc1vTQ2JSbIwGxdLRkdOEnVI21xJyz/QN2ctE
         M3vMoLrklKMhPDR/mPUS6kqYTrsp9bfvHK59Slnbh6o46FaDpmeH/XGLtSkDDroSDy
         JvyjabLvFkXcU9/whBF+btY8k5HSkE8Iki3aCrsI=
Date:   Thu, 17 Aug 2023 18:30:54 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the nolibc tree
Message-ID: <e0af8d82-e099-49fa-9fbd-6f6bb63b7706@t-8ch.de>
References: <20230817133811.0a73c624@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817133811.0a73c624@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-17 13:38:11+1000, Stephen Rothwell wrote:
> The following commit is also in the vfs-brauner tree as a different commit
> (but the same patch):
> 
>   ba859b2e419c ("selftests/nolibc: drop test chmod_net")
> 
> This is commit
> 
>   49319832de90 ("selftests/nolibc: drop test chmod_net")
> 
> in the vfs-brauner tree.

I think we can drop the patch from the nolibc tree.
The patch is only really necessary in combination with
commit 18e66ae67673 ("proc: use generic setattr() for /proc/$PID/net")
which already is and should stay in the vfs tree.
