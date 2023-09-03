Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68E4790B25
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 09:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjICHlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 03:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjICHlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 03:41:50 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DA0124;
        Sun,  3 Sep 2023 00:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1693726905;
        bh=iv1pLLc+v8+kime8HKgyY+vHVntfdfZAs7FRY9OE20I=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=hBOHXo9TLbOATfk0TiEL83BU5xf4IrWX9OpF0NI8y57gn2kNZM/AkvHYI6yuKfWIu
         hoYJWDlBCAf3+BTbvd6gYE6HXTO+ORtmUHGulDBzW7BojMD3WpPTWU+UzMhhMIqSfp
         TozoRFHnsjS0juiZVaJiXr3RDwijnIUZTpbVkvzY=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BB5A9128178D;
        Sun,  3 Sep 2023 03:41:45 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id gnRfFe011lwK; Sun,  3 Sep 2023 03:41:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1693726905;
        bh=iv1pLLc+v8+kime8HKgyY+vHVntfdfZAs7FRY9OE20I=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=hBOHXo9TLbOATfk0TiEL83BU5xf4IrWX9OpF0NI8y57gn2kNZM/AkvHYI6yuKfWIu
         hoYJWDlBCAf3+BTbvd6gYE6HXTO+ORtmUHGulDBzW7BojMD3WpPTWU+UzMhhMIqSfp
         TozoRFHnsjS0juiZVaJiXr3RDwijnIUZTpbVkvzY=
Received: from [IPv6:2a00:23c8:1005:a801:e95:68ca:9caa:7c8c] (unknown [IPv6:2a00:23c8:1005:a801:e95:68ca:9caa:7c8c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2D9811280E00;
        Sun,  3 Sep 2023 03:41:43 -0400 (EDT)
Message-ID: <2740c0e76e3feffbd43956d342c1805082396c99.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 6.4+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 03 Sep 2023 08:41:41 +0100
In-Reply-To: <CAHk-=wgA6CBwnJ02H+vSgneKPcPRP0BWQ-Kx2Re1B56Y2hXkFQ@mail.gmail.com>
References: <6908480e8808a2d025926f2ff1f9a2468d1b6bb9.camel@HansenPartnership.com>
         <CAHk-=wgA6CBwnJ02H+vSgneKPcPRP0BWQ-Kx2Re1B56Y2hXkFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-09-02 at 12:08 -0700, Linus Torvalds wrote:
> On Sat, 2 Sept 2023 at 00:39, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > Updates to the usual drivers (ufs, lpfc, qla2xxx, mpi3mr, libsas)
> > and the usual minor updates and bug fixes but no significant core
> > changes.
> 
> Removing 3000+ lines for UFS HPB support wasn't even worth
> mentioning?

Sorry, my bias is showing.  I always thought HPB was a useless
marketing feature and was against including it, so removing it is just
the world going back to being more correct.  To be honest, I also
didn't think you cared at all about UFS ...

> I am happy to see it gone, and maybe as a technology it was a failure
> not worth it, but as a "we gave up on it as being worthless" might
> still have been worth a word or two..
> 
> Sadly, I see from the commit message that apparently the next stage
> is going to involve zoned storage. Now *there* is a technology that
> seems to be a complete failure, brought to us by the same kind of
> failed hardware people who tried to convince us that we should care
> about 64kB pages in SSD's.

Well, we put HPB in in spite of most of us thinking it was a bad idea
because there was a tiny chance it might work and it could be yanked
out if it didn't.  There's no reason not to extend the same courtesy to
zoned storage.

> Oh well. With enough thrust, even a pig will fly. I suspect that's
> the motivating factor behind all those zoned storage things too.

That's why RFC1925 exists, yes ...

James

