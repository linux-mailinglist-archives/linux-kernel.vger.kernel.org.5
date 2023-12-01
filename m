Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E30800A7E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378733AbjLAMKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378681AbjLAMKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:10:32 -0500
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A7CCD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:10:37 -0800 (PST)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Fri,  1 Dec 2023 13:10:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1701432635; bh=4Rsj9gA7e9Ue6wn3vRDGDWjkoxNcibwIf7ka6ip/lWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X/EXRtCSBE0g6zQJ0FaCIQfblrUP72IZ/q1eKVZab5Rhi4D7ztobQHW39vKLlhFzu
         0HyU+l4EDbUsOlvPRXU03u9MbZD9rrVazUF9BcxOs+gI1MclsgxMn8zExM7f/nWZK7
         MFgTvg2BAOXsuE1Ib3p5dVfRRkpb74KDxfFK1KPc=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id B5FFF80A37;
        Fri,  1 Dec 2023 13:10:34 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id A7869180F88; Fri,  1 Dec 2023 13:10:34 +0100 (CET)
Date:   Fri, 1 Dec 2023 13:10:34 +0100
From:   Nicolas Schier <n.schier@avm.de>
To:     Hu Haowen <2023002089@link.tyut.edu.cn>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/show_delta: reformat code
Message-ID: <ZWnNOswNOP_1_EcH@buildd.core.avm.de>
References: <20231130143822.17173-1-2023002089@link.tyut.edu.cn>
 <CANiq72nS9_uPXNXc6mORtWsBEUB7JBWeUW+aAQ0Osqnca3vaVA@mail.gmail.com>
 <9075f00e-f914-4739-aae2-ba4ccfd6236b@link.tyut.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9075f00e-f914-4739-aae2-ba4ccfd6236b@link.tyut.edu.cn>
Organization: AVM GmbH
X-purgate-ID: 149429::1701432635-A0E0F9F0-D592868D/0/0
X-purgate-type: clean
X-purgate-size: 1412
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 12:56:14PM +0800, Hu Haowen wrote:
> 
> On 2023/12/1 01:13, Miguel Ojeda wrote:
> > On Thu, Nov 30, 2023 at 3:49 PM Hu Haowen <2023002089@link.tyut.edu.cn> wrote:
> > > -                               if string.find(rest, base_str)==1:
> > > +                               if string.find(rest, base_str) == 1:
> > If this is changed, shouldn't be others like:
> > 
> > >                  if arg=="-b":
> > >                  elif arg=="-h":
> > be changed too?
> 
> 
> Sorry, ignored by accident. I'll make up within the next patch version.
> 
> 
> > In other words, it seems this was done manually. Should we instead
> > introduce/use something like Black or Ruff if we are going to do this
> > sort of changes?
> 
> 
> I'm sorry but I'm not familiar with these two things. Are Black and Ruff
> some kind of tools which help identify these code format issues? If so
> it is better to introduce them to assist to accomplish the similar
> series of work instead of only completing it manually with avoiding
> omitted parts simultaneously.

yes, both are Python code formatters:

Black:
   Documentation: https://black.readthedocs.io/en/stable/
   Repology:      https://repology.org/project/black/

Ruff:
   Documentation: https://docs.astral.sh/ruff/formatter/
   Repology: https://repology.org/project/ruff-python-linter/

Kind regards,
Nicolas
