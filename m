Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2D6784A88
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjHVTgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjHVTgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:36:09 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21789DB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:36:06 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RVfhz0fN2zCP;
        Tue, 22 Aug 2023 21:36:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1692732963; bh=dlAnPMbgJ2HyRDZFb7C5oXFmuHlLCCG41j4oHUAvcTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LEIc7Vss66TLIMhtnIgjV9HdAzRToKwYSByIg1aZPJI6XX0hkeM/OOWtAWO/bP9QI
         t8q+j6YqMGeyGg1rt0Et7WdANDUk5+W37vI8+cEhcsbvuXyQnt6VCstCua2pnQclOA
         aYX82Oo+4xVxJVRL8KXyvhiYUv//CMsSf+0CRnTbVbUxJCCic96JmhnA/T7MLIPPxK
         A51/zZsyrUfExuN/ukd/KD3ApiLYdD/TGKdsnBU+DKb5z6QnpQcmlm1r9u5z5iJFZj
         rY8ddZmkabZ2v+Ve8zCIXVMVzvUiaeDli5sAguy9RPSV7y+t+1lriZikxZUmMZbrDr
         s/SYRfw0obUWQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Tue, 22 Aug 2023 21:36:01 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: core: Un-constify mfd_cell.of_reg
Message-ID: <ZOUOIT40/qH7VOTS@qmqm.qmqm.pl>
References: <aa8de668f39f76c98e443c7cce2834e813807111.1692188782.git.mirq-linux@rere.qmqm.pl>
 <20230818155815.GY986605@google.com>
 <ZOAIplO6tcFN2H8L@qmqm.qmqm.pl>
 <20230821081340.GD1380343@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230821081340.GD1380343@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 09:13:40AM +0100, Lee Jones wrote:
> On Sat, 19 Aug 2023, Micha³ Miros³aw wrote:
> 
> > On Fri, Aug 18, 2023 at 04:58:15PM +0100, Lee Jones wrote:
> > > On Wed, 16 Aug 2023, Micha³ Miros³aw wrote:
> > > 
> > > > of_reg is the only constant member of struct mfd_cell. It seems to be
> > > 
> > > Sorry, what?
> > > 
> > > struct mfd_cell {
> > >         const char              *name;
> > > [...]
> > >         const struct mfd_cell_acpi_match        *acpi_match;
> > > [...]
> > >         const struct software_node *swnode;
> > > [...]
> > >         const char              *of_compatible;
> > > [...]
> > >         const u64 of_reg;
> > > [...]
> > >         const struct resource   *resources;
> > > [...]
> > >         const char * const      *parent_supplies;
> > > [...]
> > > };
> > [...]
> > 
> > All those are pointers to const, not const fields themselves. Only
> > `of_reg` is const regardless of the whole structure.
> 
> Please make that clear in the commit message.

Could you please help with the wording? I'm surprised being asked to explain
a basic C language feature in a commit message to have a patch accepted.
Could it be due to me using 'constant' instead of 'const' that made it
confusing?

Best Regards
Micha³ Miros³aw
