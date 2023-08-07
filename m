Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A692772D8D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjHGSMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjHGSMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:12:03 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A193171E;
        Mon,  7 Aug 2023 11:12:02 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id ABA884BF;
        Mon,  7 Aug 2023 18:12:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net ABA884BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1691431921; bh=WHqC6U0bmErWak531vlTN+is0veLI9Xe/uZCUjZYmW8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DDori1jGeHLG0LG1FnwlmIV62Ilr1Ke8Mhb5t9z6KXjQfFmOfBRPyIHaNpwal8wWH
         Be5SmiVq/rQabOj7dNpmobiG7AhTKeCQ5AuwzCG7ZdxJ4ywiJHRT8gwbsCvJ1HfztS
         UKcavh92ZfNnqBfg4f/khxbEO+BzBeHbFVrNZhX5vT8GhN1ZHV472u7bpQYi2FyVch
         0FU3Kn8jUQ2ZINFULrTnWMzvIlATwChqO+bZNCs+bpxDpFI3CGDJUcmHIvqopSGmvj
         8ErUC+84nM7y4HR1XpPsIhzI5TSHpRcSv/jxq/pnsR9X8xZnOYRKbayGHxdIC8beJw
         OHdGOI463W9bw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        torvalds@linux-foundation.org, randy.dunlap@oracle.com,
        paulmck@kernel.org, markus.heiser@darmarIT.de
Subject: Re: [PATCH]upi:media: Added rest of the Generic Error Codes to the
 existing list
In-Reply-To: <20230807045212.32489-2-unixbhaskar@gmail.com>
References: <20230807045212.32489-2-unixbhaskar@gmail.com>
Date:   Mon, 07 Aug 2023 12:12:00 -0600
Message-ID: <875y5q67tb.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bhaskar Chowdhury <unixbhaskar@gmail.com> writes:

> Added rest of the Generic Error Codes to the existing list of codes.
>
> cc: torvalds@linux-foundation.org
> cc: randy.dunlap@oracle.com
> cc: paulmck@kernel.org
> cc: corbet@lwn.net
> cc: markus.heiser@darmarIT.de
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  There is a "moreutils" package across the Linux distribution, if you
>  installed it and that package has a binary name "errno",if you run it with
>  "-l" or "--list" option, it will show all the error codes.In my system, while
>  running it shows me precisely, 134 of such codes.YMMV
>
>  .../userspace-api/media/gen-errors.rst        | 479 ++++++++++++++++++
>  1 file changed, 479 insertions(+)

This document is a list of errors that can be returned by media drivers,
with a focus on what those errors mean in the media context.  What is
the point of stuffing it full of error numbers that media drivers will
never return, along with generic, one-line descriptions?  I'll defer to
the media folks on this, but I don't think this helps their users.

Thanks,

jon
