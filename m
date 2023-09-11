Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE01E79C2A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237581AbjILCUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237363AbjILCUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:20:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244B7141938;
        Mon, 11 Sep 2023 18:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=o91i0BrRYW6i4ggXpHFxM6+k8TqRwA2kmbfi7bWB11I=; b=jtOtBkVi85VfoTYtK70HkFQRhV
        7n1exiuutzIDGv0/lTYyDrXxLtRiyFs8vVVQiPwvxfGaHKcUS5fwsX/80Lm6JEH8l4+uWkSQYHUsS
        f/TLIAunPWJqd2nMjW2U4mbs3tL7bIi1bCXAnBtel9fmVehJDx0/8xZF8xtdzqvOXt7XDKQoXdVUT
        NNWBdJHbG1Rc+uGGzV17Xp15A1LuIAjVfvT2hiW8XHgn/lvlEjQyqF/NLy1OHl5SUmX8QH1KsBZ/e
        YQpQBAYQGc1C3qON0ke0vT+ov5P/V2dHPc73RvV+WTvSiVzv9wMXgCPdFJADLBU4ZDfrYvsJteYfx
        I0O2cwjg==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qfp2e-001SmM-1a;
        Mon, 11 Sep 2023 22:06:00 +0000
Message-ID: <85563fd1-b9c1-60a9-24bc-4e5f7ee3bea4@infradead.org>
Date:   Mon, 11 Sep 2023 15:05:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 1/1] scripts: Introduce a default git.orderFile
Content-Language: en-US
To:     Leonardo Bras <leobras@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20230911193752.27642-2-leobras@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230911193752.27642-2-leobras@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/23 12:37, Leonardo Bras wrote:
> When reviewing patches, it looks much nicer to have some changes shown
> before others, which allow better understanding of the patch before the
> the .c files reviewing.
> 
> Introduce a default git.orderFile, in order to help developers getting the
> best ordering easier.
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
> 
> Please provide feedback on what else to add / remove / reorder here!
> 
>  scripts/git.orderFile | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 scripts/git.orderFile
> 
> diff --git a/scripts/git.orderFile b/scripts/git.orderFile
> new file mode 100644
> index 000000000000..3434028be2f2
> --- /dev/null
> +++ b/scripts/git.orderFile
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +# order file for git, to produce patches which are easier to review
> +# by diffing the important stuff like header changes first.
> +#
> +# one-off usage:
> +#   git diff -O scripts/git.orderfile ...
> +#
> +# add to git config:
> +#   git config diff.orderFile scripts/git.orderfile
> +#
> +
> +MAINTAINERS
> +
> +# Documentation
> +Documentation/*
> +*.rst
> +
> +# build system
> +Kbuild
> +Makefile*
> +*.mak

Can we have Kconfig* here also?
thanks.

> +
> +# semantic patches
> +*.cocci
> +
> +# headers
> +*.h
> +
> +# code
> +*.c

-- 
~Randy
