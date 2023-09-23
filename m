Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62207ABEB4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjIWIAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjIWIAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:00:37 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D60C180;
        Sat, 23 Sep 2023 01:00:31 -0700 (PDT)
Received: from localhost (unknown [217.144.90.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BE2A6735;
        Sat, 23 Sep 2023 08:00:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BE2A6735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1695456031; bh=5CjtbACEHioF3rW7Wtbr9kbr8IpW0MXFY8yUPwlRWs4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NF2WeiM7zoXvMQdc1yqNeBIadZ+PB7IHE7R5ZEKP3iau9iYgJv3yiBADXAgut0Vq5
         KVCDksozO/TiTXcflQ0RKVGzNEyeC2P3BL/9K1ufV5Y/PirtGeZWb1SFcT8CXQGLZ3
         uHw/8kvMfpeCRWeqUf6YVWrdQELEMdpZ6xQZRpeTM+ryiGFBbE/2xQdoEJmO8y5OlQ
         vYw3y3QgesRhVWuTS8WOoBBe1WQ8jOQMKO6GPNlEbgrHEYN/Aor69hUtBk2flpElMj
         nCdegnVew9xjVrDNZM0BXFWIB8PEKIyzj6ymt73lOKrTCFF+002bU6NvPYxoxr0hsB
         UlNvhzt+Pzn1A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res.211@gmail.com>
Cc:     Hu Haowen <src.res.211@gmail.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs/zh_TW: update contents for zh_TW
In-Reply-To: <20230917084646.92319-1-src.res.211@gmail.com>
References: <20230917084646.92319-1-src.res.211@gmail.com>
Date:   Sat, 23 Sep 2023 02:00:28 -0600
Message-ID: <87r0mp5nfn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hu Haowen <src.res.211@gmail.com> writes:

> The content of zh_TW was too outdated comparing to the original files.
> Consequently carry out improvements in order to both keep track of sources
> and fix several grammatical mistakes in traditional Chinese.
>
> This is a thorough rewrite of the previous patch:
>     https://lore.kernel.org/linux-doc/20230807120006.6361-1-src.res.211@g=
mail.com/
> in order to get rid of text damage and merging errors, created based on
> linux-next (date: Sept. 15, 2023).
>
> Signed-off-by: Hu Haowen <src.res.211@gmail.com>

So I get the usual sort of problem here:

> WARNING: Message contains suspicious unicode control characters!
>          Subject: [PATCH] docs/zh_TW: update contents for zh_TW
>             Line:  =EF=BB=BF.. _tw_process_statement_kernel:
>             -------^
>             Char: ZERO WIDTH NO-BREAK SPACE (0xfeff)
>          If you are sure about this, rerun with the right flag to allow.
> AM FAILED

*Please* try applying your patches before sending them so we can avoid
this sort of difficulty.

jon
