Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123197B4B2C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 07:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbjJBFit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 01:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjJBFis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 01:38:48 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEE59F;
        Sun,  1 Oct 2023 22:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uOUzmb8ftzbOyFeK0edTqft1MheQUfEIQXgPtEe/8BM=;
  b=Hd8NbBKsVd0zs1p7J5JnV+4cB+382/OjJB/78nDnuyqCucAQsl6Nk0H2
   fy6HM5EWGeeK2/gAFUSUB1wpfOsGxEFpu2tBRjL4k02Bgv5uEi/dH+oo7
   ozD+ml33TF3cf43UZFaTWgXzclPYV+SccLRPMrVqkzn/GbSCp7Dc7yqLI
   I=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,193,1694728800"; 
   d="scan'208";a="67469029"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 07:38:42 +0200
Date:   Mon, 2 Oct 2023 07:38:42 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Kees Cook <keescook@chromium.org>
cc:     Julia Lawall <julia.lawall@inria.fr>, Kees Cook <kees@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] comedi: Annotate struct comedi_lrange with
 __counted_by
In-Reply-To: <202310011515.D4C9184@keescook>
Message-ID: <alpine.DEB.2.22.394.2310020737570.3166@hadrien>
References: <5c3b7459b820e22e2ac6ce892d4aadcc119cc919.1696065263.git.christophe.jaillet@wanadoo.fr> <202309301342.5B5BED40A1@keescook> <alpine.DEB.2.22.394.2310010945130.3166@hadrien> <90E2BBA5-8A2D-42DE-B36A-CD37BABBB433@kernel.org>
 <alpine.DEB.2.22.394.2310012112560.3166@hadrien> <202310011405.7599BA9@keescook> <202310011421.C4F19D45@keescook> <202310011515.D4C9184@keescook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 1 Oct 2023, Kees Cook wrote:

> On Sun, Oct 01, 2023 at 02:22:17PM -0700, Kees Cook wrote:
> > On Sun, Oct 01, 2023 at 02:05:46PM -0700, Kees Cook wrote:
> > > On Sun, Oct 01, 2023 at 09:14:02PM +0200, Julia Lawall wrote:
> > > > Kees,
> > > >
> > > > You can try the following.
> > >
> > > Cool! Yeah, this finds the example:
> > >
> > > drivers/comedi/drivers/rti800.c:74: struct comedi_lrange: field at offset 0 is the counter for the flex array
> > > drivers/comedi/drivers/rti800.c:83: struct comedi_lrange: field at offset 0 is the counter for the flex array
> > > drivers/comedi/drivers/rti800.c:92: struct comedi_lrange: field at offset 0 is the counter for the flex array
> > >
> > > I'll run it on the whole codebase...
> >
> > It found only the struct comedi_lrange instances, but that's good to
> > know. :)
>
> On a related note, why doesn't this work?
>
> @allocated@
> identifier STRUCT, ARRAY;
> expression COUNT;
> struct STRUCT *PTR;
> identifier ALLOC;
> type ELEMENT_TYPE;
> @@
>
>         PTR = ALLOC(..., sizeof(\(*PTR\|struct STRUCT\)) +
>                          COUNT * sizeof(\(*PTR->ARRAY\|PTR->ARRAY[0]\|ELEMENT_TYPE\)), ...);
>
>
> minus: parse error:
>   File "alloc.cocci", line 15, column 34, charpos = 485
>   around = 'struct',
>   whole content =       PTR = ALLOC(..., sizeof(\(*PTR\|struct STRUCT\)) +
>
> if I drop "struct", then it complains about ELEMENT_TYPE...

The sizeof with an expression argument is treated differently than the
sizeof with a type argument.  So you need to write:

@allocated@
identifier STRUCT, ARRAY;
expression COUNT;
struct STRUCT *PTR;
identifier ALLOC;
type ELEMENT_TYPE;
@@

        PTR = ALLOC(..., \(sizeof(*PTR)\|sizeof(struct STRUCT)\) +
                         COUNT * \(sizeof(*PTR->ARRAY)\|sizeof(PTR->ARRAY[0])\|sizeof(ELEMENT_TYPE)\), ...);

julia
