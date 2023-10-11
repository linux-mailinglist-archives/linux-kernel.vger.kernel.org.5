Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0CF7C5EBE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbjJKUxm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Oct 2023 16:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjJKUxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:53:41 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2948A9;
        Wed, 11 Oct 2023 13:53:39 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qqgCn-0006PR-08;
        Wed, 11 Oct 2023 16:53:21 -0400
Message-ID: <b99cd99fb6758ceb4cf3152c038fda761d597bb6.camel@surriel.com>
Subject: Re: [PATCH v4] execve.2: execve also returns E2BIG if a string is
 too long
From:   Rik van Riel <riel@surriel.com>
To:     Alejandro Colomar <alx@kernel.org>
Cc:     linux-man@vger.kernel.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org,
        Matthew House <mattlloydhouse@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>
Date:   Wed, 11 Oct 2023 16:53:20 -0400
In-Reply-To: <ZScCP2RqArDeixLz@debian>
References: <20231011124301.4d93ea72@imladris.surriel.com>
         <20231011125330.13dfe148@imladris.surriel.com> <ZScCP2RqArDeixLz@debian>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-11 at 22:14 +0200, Alejandro Colomar wrote:
> Hi Rik,
> 
> On Wed, Oct 11, 2023 at 12:53:30PM -0400, Rik van Riel wrote:
> > Sigh, once again I did a git commit --amend without the latest file
> > change being
> > included. The change below should be good. Working with both git
> > and hg gets me sometimes :/
> > ---8<---
> > 
> > The execve syscall returns -E2BIG in 3 cases:
> > - The total length of the command line arguments and environment is
> > too large.
> > - An argument or environment string is longer than MAX_ARG_STRLEN.
> 
> I'm still concerned by the wording of this sentence (and the next
> one).
> When I (and any user-space programmer, I think) read "string is
> longer
> than FOO", I read `strlen(string) > FOO`.  Since it's rather
> `strlen(string) >= FOO`, I think you should clarify.  How about this?
> 
> -  An argument or environment string is longer (including the null
> byte)
>    than MAX_ARG_STRLEN.

That works. Would you like me to re-send a v5, or do you
want to massage the changelog when you apply the patch?

I must admit I paid more attention to the wording in the
man page than the wording in the changelog :)

-- 
All Rights Reversed.
