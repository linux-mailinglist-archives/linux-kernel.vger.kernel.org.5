Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5255B774C52
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbjHHVFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbjHHVEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:04:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEEB525B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=aKUT38crUjXmg0Sy1d6QsQX9s/3F4Tvjcy/j1c2UkrM=; b=ev12Cj6DfcUUWoSjNw/8qm2kIG
        8gOUGDdsOZIgH13y3+SxS8el5+sRdNlLzrpKvk/wAVj/Lpy7TUPNuJM6PnALxfWyrLww9wPzjEWFb
        /7u/P1txWtb89fY9TAMHr/855tPQv9od+8wQ2eo9OY7Czx03jL99Lz3yvKAni0ZdMOsBhmXQPzubx
        C0tbMy+J8qJgmviIvKwiVXkek7Z+/WjcFjiQQeu5Hc3FxpTh8eJDjq/QZ9KfH24z/9WmC1CZpAaO5
        Zsv+B97MFY2iDJZH+CYP8CZiIw+LBYMCofoKb43nzDynfwlSbwIgyfyFlHmFq1+8SUSHp8NUeLauw
        xJoC+q6w==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTTs0-003T7T-22;
        Tue, 08 Aug 2023 21:04:00 +0000
Message-ID: <7d59769d-ee06-f6e8-9570-edfa301eeef7@infradead.org>
Date:   Tue, 8 Aug 2023 14:03:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] x86/linkage: Fix typo of BUILD_VDSO in asm/linkage.h
Content-Language: en-US
To:     Jinghao Jia <jinghao@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
References: <20230808182353.76218-1-jinghao@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230808182353.76218-1-jinghao@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/23 11:23, Jinghao Jia wrote:
> The BUILD_VDSO macro was incorrectly spelled as BULID_VDSO in
> asm/linkage.h. This causes the !defined(BULID_VDSO) directive to always
> evaluate to true.
> 
> Correct the spelling to BUILD_VDSO.
> 
> Fixes: bea75b33895f ("x86/Kconfig: Introduce function padding")
> Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  arch/x86/include/asm/linkage.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
> index 0953aa32a324..97a3de7892d3 100644
> --- a/arch/x86/include/asm/linkage.h
> +++ b/arch/x86/include/asm/linkage.h
> @@ -21,7 +21,7 @@
>  #define FUNCTION_PADDING
>  #endif
>  
> -#if (CONFIG_FUNCTION_ALIGNMENT > 8) && !defined(__DISABLE_EXPORTS) && !defined(BULID_VDSO)
> +#if (CONFIG_FUNCTION_ALIGNMENT > 8) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
>  # define __FUNC_ALIGN		__ALIGN; FUNCTION_PADDING
>  #else
>  # define __FUNC_ALIGN		__ALIGN

-- 
~Randy
