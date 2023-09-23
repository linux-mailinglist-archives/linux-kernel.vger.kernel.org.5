Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C01D7AC1F7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 14:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjIWMWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 08:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjIWMW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 08:22:26 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D411CC9;
        Sat, 23 Sep 2023 05:21:43 -0700 (PDT)
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
        by cmsmtp with ESMTP
        id jq44q9ExqyYOwk1dmq0hkf; Sat, 23 Sep 2023 12:21:42 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id k1dlqvbg1U8Krk1dlqtQZO; Sat, 23 Sep 2023 12:21:42 +0000
X-Authority-Analysis: v=2.4 cv=Qt9NYH+d c=1 sm=1 tr=0 ts=650ed856
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=1WtWmnkvAAAA:8 a=JfrnYn6hAAAA:8
 a=cm27Pg_UAAAA:8 a=dCm2NbBjv5z0pmeuAAEA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=AjGcO6oz07-iQ99wixmX:22 a=-_UHfarfsM-RsASml2Jt:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=B8/E2A+UIVSWA5A2I0nitCK8u8v9UCjBOdaXQ/lRK9g=; b=zMkCHadzeGZVvkLQ03lviIFK8x
        aEq31t4XMRvyc2kOAIWUjcxN5ajD781J9bCz2xVyFsJATMkkxGQ9bObFEVr/ISPk4VEN4bN+VbZ0s
        Y8fle2DM3fhC1vmLdErYUI7aLjyj55g/ceY8qFuBJ1JNzutfOGWdSx1ptW17Bn/kfvWseBjzKmjhG
        /iclwog9caDG0gdty7mYPgg0VN6k469kdEjR30Fd8i5LD0M3Yf2G5BQoY1uppTLZeyFEoK4WxWqAK
        sg2q5EG85XpcsJVym/Z2lAkILtV/Yy2bAmN0GZE++DdMC/ZkiIvy/kOxCEi6MdECke1DhlLzoNjAE
        o9eHnzfw==;
Received: from [94.239.20.48] (port=44556 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy6J-003eaU-0v;
        Sat, 23 Sep 2023 03:34:55 -0500
Message-ID: <7ab98b69-8aac-416e-95b5-6105c63f4fd1@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:35:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] bus: vexpress-config: Annotate struct
 vexpress_syscfg_func with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Liviu Dudau <liviu.dudau@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175234.work.134-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175234.work.134-kees@kernel.org>
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
X-Exim-ID: 1qjy6J-003eaU-0v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:44556
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGXhegmKgBsNVKtulfB1OvfGTl6M96l4nKpXLG1QQhhG2G4V0nVsg7h9FDdghvLJED6HHWbEwN8x6fzp4OQS0NWv9PNuMJeG5CF+UkM7sQZOTtBzRs6G
 ECTf4caff+TDcYFLjaqKRCaQF+D9kBfaG3juH7HyxaXgAaTuTbeHmfbxkNC3ziAWbXMmaQAQXebHeU8i/Erh5qaHdA+0u/wknQySSTrEFN7HlqF5ATPEVdRZ
 m4tLpIH0aW62ErCCStrRs/0/7ByMh+V2el6fSE5eQhg=
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
> As found with Coccinelle[1], add __counted_by for struct vexpress_syscfg_func.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Yangtao Li <frank.li@vivo.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/bus/vexpress-config.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
> index c4e1becbb2d2..d2c7ada90186 100644
> --- a/drivers/bus/vexpress-config.c
> +++ b/drivers/bus/vexpress-config.c
> @@ -54,7 +54,7 @@ struct vexpress_syscfg_func {
>   	struct vexpress_syscfg *syscfg;
>   	struct regmap *regmap;
>   	int num_templates;
> -	u32 template[]; /* Keep it last! */
> +	u32 template[] __counted_by(num_templates); /* Keep it last! */
>   };
>   
>   struct vexpress_config_bridge_ops {
