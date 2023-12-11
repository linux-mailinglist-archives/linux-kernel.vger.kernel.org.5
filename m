Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4D580DE2E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345484AbjLKVk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345458AbjLKVkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:40:53 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9634CC4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1702330857;
        bh=jPzZVmLZLxpc+6gdrmZfgoyb81mBSDbC9YeZTSPXdXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YUTuCJDTKbwfxm5O5zhc10MjnCCW2DAR4Nnh64Toqr3VqmsM8DcJdUW57aHi3icef
         SCpB0Qsy0qeHRaIRV+ttQpzKvtsbXc0tHBJDo99Fei1AZk32S1i/PpU+vEADS+qkkE
         /0LpUqqCmy8nMPuD04kmE5n9xX5c5MNxdWN3rgwE=
Date:   Mon, 11 Dec 2023 22:40:56 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, WillyTarreauw@lwt.eu
Subject: Re: nolibc changes for 6.8
Message-ID: <d486df54-4484-4f6a-b40f-aebeb5f0131a@t-8ch.de>
References: <4208adae-d185-44a6-a564-ec9bc4c6eb2a@t-8ch.de>
 <4074b0bc-e89b-4b2e-ad11-cb3a9517b725@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4074b0bc-e89b-4b2e-ad11-cb3a9517b725@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

On 2023-12-11 12:52:10-0700, Shuah Khan wrote:
> On 12/8/23 10:09, Thomas Weißschuh wrote:
> > The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:
> > 
> >    Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
> > 
> > are available in the Git repository at:
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git/ next
> > 
> > for you to fetch changes up to b99c3b15310e7c7cd5f2d843289fe115ab3f8043:
> > 
> >    selftests/nolibc: disable coredump via setrlimit (2023-11-26 11:39:52 +0100)

> [..]

> > ----------------------------------------------------------------
> > Mark Brown (1):
> >        tools/nolibc: Use linux/wait.h rather than duplicating it
> 
> 
> I am seeing the following problem when I run my verify_signedoff.sh
> 
> verify_signedoff.sh HEAD~22...HEAD /linux/linux_kselftest/
> Commit a0fa60e42bbe ("tools/nolibc: Use linux/wait.h rather than duplicating it")
> 	committer Signed-off-by missing
> 	author email:    broonie@kernel.org
> 	committer email: linux@weissschuh.net
> 	Signed-off-by: Mark Brown <broonie@kernel.org>
> 	Signed-off-by: Willy Tarreau <w@1wt.eu>
> 
> Errors in  with Signed-off-by, please fix!
> 
> Is it possible to fix this? It appears commiter signed-off is missing.

Thanks for spotting this!

The fixed commits are published on the same "next" branch as before with
final commit d543d9ddf593b1f4cb1d57d9ac0ad279fe18adaf.

Thomas
