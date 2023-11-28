Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94BD7FC1B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343949AbjK1Q0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK1QZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:25:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD369AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=6YdxQ6TPTCO0wTiV5GT2AhsiDswNReE589bphcgljEY=; b=ADgKcEYyEXvG3Mr2mt+9ghny6L
        thlIgwCSfq3HD+j2IeeCDJJVH9ysDjlxQV1fYEJBYfmiYENxItb1ZP99OXQtqdpcb49wTYmH6yHCv
        B0vrKjTrg+mZ/J1pDKfF1kk4P7CpaOBktKDZ8cvBKgr3UIiP2BAonKSwkehWdro6q8FPT1DUKaG33
        xMXQoDlvVY7Zm26dTV97kN4oI+o0ABh63AGP+oV2PcRMWJbyxXC2xvy00nOfF140ruJml+J3+xAEZ
        5wycLC7LU+D2ljS9VV1HpMtKabsolAQGKNaGp2Fmq8kmguo2s7pGkbPPi5uGqg2a8PpDcM0gVVk5z
        MalqlmQg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r80uS-005oAG-22;
        Tue, 28 Nov 2023 16:26:04 +0000
Message-ID: <d9ac4b6c-e473-4c00-b016-a9cebdb59325@infradead.org>
Date:   Tue, 28 Nov 2023 08:26:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: kstrtox: fix typo in comment
Content-Language: en-US
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
References: <ZWWkeVTvDBQDA_SF@monster.localdomain>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZWWkeVTvDBQDA_SF@monster.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/23 00:27, Wilken Gottwalt wrote:
> Delete one of the double f's in "iff".
> 
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Nope, see:
  https://en.wikipedia.org/wiki/If_and_only_if

> ---
>  lib/kstrtox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index d586e6af5e5a..b0a9fdce15b3 100644
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -340,7 +340,7 @@ EXPORT_SYMBOL(kstrtos8);
>   * @s: input string
>   * @res: result
>   *
> - * This routine returns 0 iff the first character is one of 'YyTt1NnFf0', or
> + * This routine returns 0 if the first character is one of 'YyTt1NnFf0', or
>   * [oO][NnFf] for "on" and "off". Otherwise it will return -EINVAL.  Value
>   * pointed to by res is updated upon finding a match.
>   */

-- 
~Randy
