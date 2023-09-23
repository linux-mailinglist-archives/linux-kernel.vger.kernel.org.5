Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07B57ABF64
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjIWJln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjIWJlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:41:40 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C306E180;
        Sat, 23 Sep 2023 02:41:34 -0700 (PDT)
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
        by cmsmtp with ESMTP
        id jx8dqihb7OzKljz8nqHS63; Sat, 23 Sep 2023 09:41:34 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id jz8mqxRQ2JUhvjz8nqzvrO; Sat, 23 Sep 2023 09:41:33 +0000
X-Authority-Analysis: v=2.4 cv=Re6Dtnhv c=1 sm=1 tr=0 ts=650eb2cd
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
        bh=1wdEGoU6/HFupSbgOnwR5HVhL1BYLqkDW6W6jZfdmgk=; b=eYEDLGiik/sPc3rFhF5R0gumip
        w/4M5IrAfAdoNjcxjixWFMOXL6ngURCPhuDhqTA55oXq4vMA3Q5+qEz6tpEvmabK5ch8KEyAtD1L3
        Ljh7kriitPrQdUHp0YfjXc0+urDlwVZEJTs27X+/7pAyPG5/dbWhEbgMb+f581HGVptruU3sZeK4r
        j+edhV8QVS3toL4DAs2vSYDK+xuPBgkSipD7ZvJn86rIC/vHI8poHMZACs4/iip0EhyPSXchdTfi8
        VdxSl04lOpYp8v2V+b+PE5DIAASRYOcwC+wb8+7i+vwq6IlB++p8O6/BngulPZP8HhE7zUX1WJ1Hr
        kcLHkArA==;
Received: from [94.239.20.48] (port=56476 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy7B-003fxA-0S;
        Sat, 23 Sep 2023 03:35:49 -0500
Message-ID: <de580a6d-de78-f9bd-067b-d4dd5f4e09f0@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:36:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] regulator: da9062: Annotate struct da9062_regulators with
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
References: <20230922175330.work.066-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175330.work.066-kees@kernel.org>
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
X-Exim-ID: 1qjy7B-003fxA-0S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:56476
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKngqgtP81oLlL261UtUjCKKYvYJgLXElwSiPlTaeXlE7g+L2dgfMmjl9OXQq8EuFJMGvUYXuO5C2AaBSpFvRo/31EMS4lSM269x96qzzbLu4rugzUuh
 qFURWikjsw1BlF2boc6puYvDG0FiI1vRQPS6S18HVkfgCFNOiEkWetDvEkUdEcmUJnxoHXdPon/haIGWGrXQpGe/qjX+UNv5IYaPzRq5nNFEmnuwLP+09TCM
 GmkyM/g45pDHuUBJCqHCsL1ncaDJmM5vCVV+sL2lgcI=
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 11:53, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct da9062_regulators.
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
>   drivers/regulator/da9062-regulator.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
> index 1d354db0c1bd..e0c96f10e570 100644
> --- a/drivers/regulator/da9062-regulator.c
> +++ b/drivers/regulator/da9062-regulator.c
> @@ -73,7 +73,7 @@ struct da9062_regulators {
>   	int					irq_ldo_lim;
>   	unsigned				n_regulators;
>   	/* Array size to be defined during init. Keep at end. */
> -	struct da9062_regulator			regulator[];
> +	struct da9062_regulator			regulator[] __counted_by(n_regulators);
>   };
>   
>   /* Regulator operations */
