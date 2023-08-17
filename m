Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A6977FE95
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354709AbjHQTez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354766AbjHQTeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 15:34:50 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CEA3588;
        Thu, 17 Aug 2023 12:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1692300887; bh=M18qW+YoHfZZUfbrSb07UFjTPfx6MWf2IpDNTQW/Smc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZNsge/99xQoC9YC/YOlPqqjX95OXx6S/BXZWrGeBeCCP2UE6sb0DviIa7X3te5EVq
         roHOlpofbP8ZcVwNH+w5lh0sKQLp/ATH+0iTtbOIin5ie+PJ9w7p1tmLksbwDTNvft
         LSqJWR3tubxFOI4054N9hPXfp0TYAceB2QeTLlxI=
Date:   Thu, 17 Aug 2023 21:34:45 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Willy Tarreau <w@1wt.eu>,
        Christian Brauner <brauner@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the nolibc tree
Message-ID: <d2f5f50e-4e32-4ec9-8417-b617c26e3815@t-8ch.de>
References: <20230817133811.0a73c624@canb.auug.org.au>
 <e0af8d82-e099-49fa-9fbd-6f6bb63b7706@t-8ch.de>
 <9cfb4fe4-162b-3f26-646b-71bed3493925@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cfb4fe4-162b-3f26-646b-71bed3493925@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-17 12:27:46-0600, Shuah Khan wrote:
> On 8/17/23 10:30, Thomas Weißschuh wrote:
> > On 2023-08-17 13:38:11+1000, Stephen Rothwell wrote:
> > > The following commit is also in the vfs-brauner tree as a different commit
> > > (but the same patch):
> > > 
> > >    ba859b2e419c ("selftests/nolibc: drop test chmod_net")
> > > 
> > > This is commit
> > > 
> > >    49319832de90 ("selftests/nolibc: drop test chmod_net")
> > > 
> > > in the vfs-brauner tree.
> > 
> > I think we can drop the patch from the nolibc tree.
> > The patch is only really necessary in combination with
> > commit 18e66ae67673 ("proc: use generic setattr() for /proc/$PID/net")
> > which already is and should stay in the vfs tree.
> 
> Thomas,
> 
> Do the rest of the nolibc patches build without this if we were
> to drop this patch? Dorpping requires rebase and please see below.

Yes, this patch is completely independent.
It only interacts with the mentioned commit in the vfs tree.

> [..]

Thomas
