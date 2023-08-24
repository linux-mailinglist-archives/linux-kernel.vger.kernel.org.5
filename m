Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5145678677C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240159AbjHXG1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240078AbjHXG10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:27:26 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CA2DB;
        Wed, 23 Aug 2023 23:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1692858443; bh=JjFkVZrdCSytTcbee0J3okytpGDqjtGHyQRntbsAStE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bj2wMXSQeGVvyV3OyPiTjI8PFeefiaf9tHMfuI+1haEX9FE1tzXUIlQzcsqKxeMqD
         Z7fw7SV2TGcerRdXtLp5THkktzP6/Rq8YNlaQMVHOgZxVifRwDbDs2JYRjizeYAKmD
         aPz/cwC4noOKn5cduB7ZEV+Nve8RixR4PsjN0GG8=
Date:   Thu, 24 Aug 2023 08:27:21 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christian Brauner <brauner@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: Re: linux-next: manual merge of the nolibc tree with the vfs-brauner
 tree
Message-ID: <3028a552-bd75-4ded-9211-62d10768d9ea@t-8ch.de>
References: <20230824141008.27f7270b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824141008.27f7270b@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

On 2023-08-24 14:10:08+1000, Stephen Rothwell wrote:
> Today's linux-next merge of the nolibc tree got a conflict in:
> 
>   tools/testing/selftests/nolibc/nolibc-test.c
> 
> between commit:
> 
>   49319832de90 ("selftests/nolibc: drop test chmod_net")
> 
> from the vfs-brauner tree and commit:
> 
>   148e9718e2a2 ("selftests/nolibc: add chmod_argv0 test")
> 
> from the nolibc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

This is fallout from the recent removal of
"selftests/nolibc: drop test chmod_net" from the nolibc tree.

Christian:

You mentioned before that you plan to have this series in
-next for some time. If you only submit it to Linux for 6.7 or later
then you have to, if I understand the process correctly, rebase your
-next branch on Linus' master after 6.6-rc1.
6.6-rc1 should contain the conflicting nolibc changes, so you would need
to resolve the conflict during rebasing.
The patch is intentionally made to be easy to resolve conflicts for,
just delete the line containing "CASE_TEST(chmod_net)".

Everyone:

What is your opinion on that?


Sorry for all the inconvenience this tiny series causes!
Thomas
