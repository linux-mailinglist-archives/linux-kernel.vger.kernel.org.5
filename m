Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFE97C4075
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbjJJT6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjJJT6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:58:01 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55CB8E;
        Tue, 10 Oct 2023 12:58:00 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 64D5E44A;
        Tue, 10 Oct 2023 19:58:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 64D5E44A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696967880; bh=OSvDt4gafYGLJ1p5fuFY+tZRsl8aP0WqWAt7qYZ4Vlc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NUiIGFhnrvwXMBtFhyW9HV8zAN+yt0lKEPeICNTQQQU6uemtcoC5UptIiC8ph2zRV
         91JbLKIxM96kegxqNLiuXMD2VmrF2tO22kSR9KUKvKuSy6ENZpE25xYDTeBZ4f0hVM
         RQjgCZQOnpKCHCBU1ufDe7TwkR5MMFQoaa0gHuBq+FyV8FE+AUBZ/wzGOsEbQRrq/V
         77GEE7YzVahiaVHoMyXs+6CSq/2TffXjiSMqO4y8txIge30Mip1TyEFsD1YtmSqhOE
         aFiZhGvNdx+EslSyl8pETCQgLyvK2tEju373Rj3GBjmLDJwtPitjFWktRngD3/cZoQ
         jfw4Nzus2JpQg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, backports@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH v2] docs: add backporting and conflict resolution document
In-Reply-To: <87bkdfg2ds.fsf@meer.lwn.net>
References: <20230824092325.1464227-1-vegard.nossum@oracle.com>
 <87bkdfg2ds.fsf@meer.lwn.net>
Date:   Tue, 10 Oct 2023 13:57:59 -0600
Message-ID: <877cnu5jy0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:

> Vegard Nossum <vegard.nossum@oracle.com> writes:
>
>> This is a new document based on my 2022 blog post:
>>
>>   https://blogs.oracle.com/linux/post/backporting-patches-using-git
>>
>> Although this is aimed at stable contributors and distro maintainers,
>> it does also contain useful tips and tricks for anybody who needs to
>> resolve merge conflicts.
>>
>> By adding this to the kernel as documentation we can more easily point
>> to it e.g. from stable emails about failed backports, as well as allow
>> the community to modify it over time if necessary.
>>
>> I've added this under process/ since it also has
>> process/applying-patches.rst. Another interesting document is
>> maintainer/rebasing-and-merging.rst which maybe should eventually refer
>> to this one, but I'm leaving that as a future cleanup.
>>
>> Thanks to Harshit Mogalapalli for helping with the original blog post
>> as well as this updated document and Bagas Sanjaya for providing
>> thoughtful feedback.
>>
>> v2: fixed heading style, link style, placeholder style, other comments
>
> So this seems generally good and useful.  I have a few small comments,
> none of which necessarily block merging it in its current form:
>
> - I would like to see an ack/reviewed-by tag by others with experience
>   with this task if possible.  The lack of complaints is a good start,
>   but not always indicative of a lack of disagreement...:)
>
> - Might this be better placed in Documentation/maintainer?
>
> - Colordiff looks cool, but I'd at least drop in a mention of the Emacs
>   ediff mode, which offers (I believe) a lot of the same functionality.

So I never got an answer on any of this ...  I've gone ahead and applied
the patch on the theory that it clearly hasn't upset anybody; I do still
think we should consider moving it to the maintainer manual, though.

Thanks,

jon
