Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400377D8803
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjJZSHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjJZSHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:07:19 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9400D9C
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1698343634;
        bh=/XdUvlNTO4zdDZMBAOycXXb/ghIDFkL5KXud5WJOJc4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K4auNB9dGJnlskO2Zlz6XOvE90XuJNpL4S2HKXCG5Du14gafVhIS3wMyRL8NGp6X0
         Oc9UuWh0KL6K1OEAuNCtXKMP7hLj4PsS9T+FC89krzyVtj1HsYJgZe4pLHsL+/ymvZ
         V7nkW4CxZ+tHh/6+jIc/uhuXdw/hwtIo+obgqa4IbQhZwS3zg49xbEu/IXeLFrFsmY
         v5Fcu+aXsIMjCf+sUPJ36WY9RxqQYqylTb2BqnPzXtZPGMu8lr7xZzDvzA6X3s86K3
         Y9yNaLIaS6ngFOVdJKVeUu/QA7GEXopXnys6rECU8aez2xMPoZ4v3cUKADTFZplIUe
         wZhkiQdA9xffA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SGYfT6Y2Kz1ZZL;
        Thu, 26 Oct 2023 14:07:13 -0400 (EDT)
Message-ID: <0e0cbc68-2b4c-462d-aff4-abd795b3b63d@efficios.com>
Date:   Thu, 26 Oct 2023 14:07:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] LoongArch: Add RSEQ_SIG break code definition
Content-Language: en-US
To:     Huang Pei <huangpei@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231026114446.5932-1-huangpei@loongson.cn>
 <20231026114446.5932-2-huangpei@loongson.cn>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231026114446.5932-2-huangpei@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-26 07:44, Huang Pei wrote:
> Signed-off-by: Huang Pei <huangpei@loongson.cn>
> ---
>   arch/loongarch/include/uapi/asm/break.h | 2 ++

Why is this part of the uapi ? None of the other architecture has this 
as part of uapi. It's only defined in the rseq selftest arch-specific 
header file.

Thanks,

Mathieu

>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/loongarch/include/uapi/asm/break.h b/arch/loongarch/include/uapi/asm/break.h
> index bb9b82ba59f2..e0fcfc304834 100644
> --- a/arch/loongarch/include/uapi/asm/break.h
> +++ b/arch/loongarch/include/uapi/asm/break.h
> @@ -20,4 +20,6 @@
>   #define BRK_UPROBE_BP		12	/* See <asm/uprobes.h> */
>   #define BRK_UPROBE_XOLBP	13	/* See <asm/uprobes.h> */
>   
> +#define BRK_RSEQ_SIG		16	/* See rseq */
> +
>   #endif /* __UAPI_ASM_BREAK_H */

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

