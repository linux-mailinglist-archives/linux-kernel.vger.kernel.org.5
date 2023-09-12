Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1973779C4BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjILEY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjILEYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:24:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3C0103;
        Mon, 11 Sep 2023 21:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=mlSD8LobofgvbfvCkSNn5XreFoScL5N0hakORkL/97E=; b=DWMwj0k73e6PXT4ZO/Q7WHG45J
        Mu8T3KghkSHrJdFFZWDffXZdjFCSxKOjqdAaSPSy7sSNWdoVrghd08JApo4yTKThEsujeLZsa2bRq
        BVbL2MMAqITFNblzfO3wVyAykkAhsouv8WZKPfGwNwhE0cXz0U+hc8Ai6djSzEg4fmfk9ZPdwd7+s
        Y/cXeF4CjWI298uU+BCoLNne4Zu0lfp3A9ly3PEpMG5wLukLBmCV7GmT39Cqr0D6X7cjjheq656Fl
        j8UnNIRb8pdCXJ7BRvBfZnGUFEa+K4N+DG0jGAMnIM1kVkZ8dBO2TDMBHGDOUIru8c7c/M1l5K7iX
        jDlJUK2w==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qfuwZ-0025Px-3C;
        Tue, 12 Sep 2023 04:24:08 +0000
Message-ID: <e0d83e21-c1fe-5f3b-9613-e9d137baaee7@infradead.org>
Date:   Mon, 11 Sep 2023 21:24:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 1/1] scripts: Introduce a default git.orderFile
Content-Language: en-US
To:     Leonardo Bras <leobras@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20230911234418.38154-2-leobras@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230911234418.38154-2-leobras@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/23 16:44, Leonardo Bras wrote:
> When reviewing patches, it looks much nicer to have some changes shown
> before others, which allow better understanding of the patch before the
> the .c files reviewing.
> 
> Introduce a default git.orderFile, in order to help developers getting the
> best ordering easier.
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>

LGTM. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> 
> Please provide feedback on what else to add / remove / reorder here!
> 
> Changes since RFCv1:
> - Added Kconfig* (thanks Randy Dunlap!)
> - Changed Kbuild to Kbuild* (improve matching)
> 
>  scripts/git.orderFile | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 scripts/git.orderFile
> 
> diff --git a/scripts/git.orderFile b/scripts/git.orderFile
> new file mode 100644
> index 000000000000..819f0a957fe3
> --- /dev/null
> +++ b/scripts/git.orderFile
> @@ -0,0 +1,32 @@
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
> +Kbuild*
> +Kconfig*
> +Makefile*
> +*.mak
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
