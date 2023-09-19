Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030AD7A5F03
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjISKGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjISKFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:05:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A9AEA;
        Tue, 19 Sep 2023 03:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1695117942;
        bh=qnEPlg47MH9dE/ib7+sBEVpstd8KaTfTXJ6XGs34D+8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DcXPXZ8RevrVci8TzkhlGkgvXdCrEBGdTI2ecUCjD+lo37dLcg/XalDi/y6ZSG3e0
         ZfEzOeTrwD4zUqaZkYMLKWxU04OEzjxLQDC3oyiUnT4jIYpx7i/x1SBjc8jkZH5ZuF
         cVZ1q7BPhuYhUjawCqSBGXNdIqZqKyhCCqVjn9RWYMp8fBWJuxYnqI5RyU+loysU60
         R60cgwWXRUkFdLL1zXe+Q3zjl8pQpNIoUWLtNqMX4O71AUgnk8VqxHI3hGED+d3Skm
         CV7dsCNdJcOtIGs720eP25IE4XlnGlkEUMzuUl3lhLv8dYuwFzPI60JiRRP7dHAAfq
         sHJslzYoFLf2A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rqcjx2f8tz4xNj;
        Tue, 19 Sep 2023 20:05:41 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] powerpc: Replace GPL 2.0+ README.legal
 boilerplate with SPDX
In-Reply-To: <CAMuHMdW6=wnOjT7qG4tHvc5X4JAJkkHMnVDsQ-dKM6i3FKyWWw@mail.gmail.com>
References: <cover.1695031668.git.geert@linux-m68k.org>
 <d91725ff1ed5d4b6ba42474e2ebfeebe711cba23.1695031668.git.geert@linux-m68k.org>
 <87h6nqlxli.fsf@mail.lhotse>
 <CAMuHMdW6=wnOjT7qG4tHvc5X4JAJkkHMnVDsQ-dKM6i3FKyWWw@mail.gmail.com>
Date:   Tue, 19 Sep 2023 20:05:35 +1000
Message-ID: <87o7hytr4g.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> Hi Michael,
>
> On Tue, Sep 19, 2023 at 4:13=E2=80=AFAM Michael Ellerman <mpe@ellerman.id=
.au> wrote:
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> > Upstream Linux never had a "README.legal" file, but it was present
>> > in early source releases of Linux/m68k.  It contained a simple copyrig=
ht
>> > notice and a link to a version of the "COPYING" file that predated the
>> > addition of the "only valid GPL version is v2" clause.
>> >
>> > Get rid of the references to non-existent files by replacing the
>> > boilerplate with SPDX license identifiers.
>> >
>> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>
>> LGTM.
>>
>> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
>
> Can you please take it through the PPC tree?

Sure thing.

cheers
