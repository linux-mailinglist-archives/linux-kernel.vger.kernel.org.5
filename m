Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB9D7D81EB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjJZLjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJZLjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:39:52 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759721A6;
        Thu, 26 Oct 2023 04:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1698320388;
        bh=E0eOwIPtihtJQ34i/6glHc8gw6B1tMUkjKoloY9JA8c=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=fwONLk6q1c7TvXFm5OzVovef/DUpPEuN3P1dMnh+P3FFYONlYhJM+uoqLGaUxHj+N
         5nzlER3CU4FqJ0RwJtwvPTceTwa99uwdF4AnL6qTaQ5gEZyqJiJNqlC++cgVyc49xy
         oEu9fEMm1Egf9iInc++yeVoW6IATtKGyOJNP23VU=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 34CF61281005;
        Thu, 26 Oct 2023 07:39:48 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id GZyeXo-IasqM; Thu, 26 Oct 2023 07:39:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1698320387;
        bh=E0eOwIPtihtJQ34i/6glHc8gw6B1tMUkjKoloY9JA8c=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=qxtjAYvvE0Vi6sg087QDeL3/NbMdbKAZoCilTz/nelv3UIdvStxp5H/8ArFkSL/fK
         yQckNC0O8U6WOqY6IGXxTO1OjAKRZyUME3Zh0o0cZ+wJNIKFYB5EvvZUG/Q8jubcnq
         +hfe/MPqhAKEOZDLM4iJ6JnL7oxI7JV1CJeAkgFA=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E59CD128037B;
        Thu, 26 Oct 2023 07:39:46 -0400 (EDT)
Message-ID: <710149630eb010b18b69e161d02502bc3b648173.camel@HansenPartnership.com>
Subject: Re: the nul-terminated string helper desk chair rearrangement
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Date:   Thu, 26 Oct 2023 07:39:44 -0400
In-Reply-To: <20231026100148.GA26941@lst.de>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
         <20231019054642.GF14346@lst.de> <202310182248.9E197FFD5@keescook>
         <20231020044645.GC11984@lst.de>
         <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
         <202310201127.DA7EDAFE4D@keescook> <20231026100148.GA26941@lst.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-26 at 12:01 +0200, Christoph Hellwig wrote:
> > > There's some docs at [1]. Perhaps there could be more?
> > > 
> > > [1]:
> > > https://elixir.bootlin.com/linux/v6.6-rc6/source/include/linux/fortify-string.h#L292
> > 
> > Right, And it's even valid kern-doc, which gets rendered in the
> > kernel API docs, along with all the other string functions:
> > https://docs.kernel.org/core-api/kernel-api.html#c.strscpy
> 
> Well, I never use the generated kerneldoc because it's much harder
> than just grepping the tree, but indeed it exists even if it's hidden
> in the most obsfucated way.  But at least I know now!

This, honestly, is one of the really annoying problems of kerneldoc. 
When looking for structures or functions

git grep "<function> -"

usually finds it.  However, I recently asked on linux-scsi if we could
point to the doc about system_state and what it meant.  However, either
we all suck or there's no such documentation because no-one could find
it.

While it's nice in theory to have everything documented, it's not much
use if no one can actually find the information ...

James

