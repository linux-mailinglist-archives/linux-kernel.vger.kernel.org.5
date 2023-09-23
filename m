Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13F67AC419
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjIWRlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjIWRlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:41:46 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517D7124;
        Sat, 23 Sep 2023 10:41:40 -0700 (PDT)
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
        by cmsmtp with ESMTP
        id jx8Vq18v2WU1ck6dPqUhEr; Sat, 23 Sep 2023 17:41:39 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id k6dOqhYFWn53Dk6dOqbxA8; Sat, 23 Sep 2023 17:41:39 +0000
X-Authority-Analysis: v=2.4 cv=IPsRtyjG c=1 sm=1 tr=0 ts=650f2353
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=X3a0BiUdAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8
 a=AuTdd_Ep57LbaUdTmj8A:9 a=QEXdDO2ut3YA:10 a=aWu3muFgq6otJbhCXpL5:22
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M66ES8raypmZxTFZFcm0fZAv/4ZU/qyjEnhhF6PylkU=; b=T7yvBLcDRt3PZiGIsXUV1nG8cP
        smJP/28JNL0aEs9JeNUsu3QC9rsVdh6qCIoNiHzgOlb7fakmGeImVwsRSudktjqPySSu6Uf0Q1elU
        2z9/EaGBzpSLeylyZBpPar4x04zSB/tCiAHIx1OJPogE37JvTQ/lJ4opDPl9ZfhwGGKUOvVLhAUCg
        EI5FglVuNusYtTVvH3aVDWjysR9xdz/1CrO/jQOxVxHGFD1FZNcYc8BbTi3OzeWP9cXVWPYpPn1sq
        DuYQnZQ1LI0kaGOjMv4pUWd8OiQWE7bDZg6tw6tETZSMj8kY4piTP2PW22SKHedoUboJQOdxK9u4o
        oCukBiOg==;
Received: from [94.239.20.48] (port=39558 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy5H-003dC0-2T;
        Sat, 23 Sep 2023 03:33:51 -0500
Message-ID: <495ab28c-b3bc-b690-ddbc-54284143b44e@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:34:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] regulator: da9063: Annotate struct da9063_regulators with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Support Opensource <support.opensource@diasemi.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175207.work.576-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175207.work.576-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qjy5H-003dC0-2T
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:39558
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfA1t5w7u1qFJoFMmxulskilcR4JKAD4DjvkKNc05iFsp7WFOYjjsYgKUwgEwkPWyC0qfxvuEcX65nQjIrf+g8ZZ9bpGmXm2gbaTj7DYN2o42IdjkdyAi
 9lHfPxzzp5JuthoCjvv+l2RpeEmwnxe1e5S4pmvcvM/ooGRGnJtWq1xBmbaM2U6Pk7dQQkD8bwb4JmpHtLkgVIaRzOjfWZqq3yQcTDY+BmP83/v9KN93l+hw
 BGEeHi6k7tDi6eGz3lbBkV+AaYoKTAfA+QjJFHZQ0so=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 11:52, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct da9063_regulators.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Support Opensource <support.opensource@diasemi.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/regulator/da9063-regulator.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
> index a0621665a6d2..82bf321ae06f 100644
> --- a/drivers/regulator/da9063-regulator.c
> +++ b/drivers/regulator/da9063-regulator.c
> @@ -158,7 +158,7 @@ struct da9063_regulator {
>   struct da9063_regulators {
>   	unsigned int				n_regulators;
>   	/* Array size to be defined during init. Keep at end. */
> -	struct da9063_regulator			regulator[];
> +	struct da9063_regulator			regulator[] __counted_by(n_regulators);
>   };
>   
>   /* BUCK modes for DA9063 */
