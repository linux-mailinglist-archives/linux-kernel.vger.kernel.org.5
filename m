Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12777ABF6D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjIWJmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjIWJmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:42:13 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939CACCA;
        Sat, 23 Sep 2023 02:41:47 -0700 (PDT)
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
        by cmsmtp with ESMTP
        id jx8cqaxZ8DKaKjz90qHoLh; Sat, 23 Sep 2023 09:41:46 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id jz8zqyRBBZb7Mjz8zq1r5N; Sat, 23 Sep 2023 09:41:46 +0000
X-Authority-Analysis: v=2.4 cv=Z57/oVdA c=1 sm=1 tr=0 ts=650eb2da
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8
 a=cm27Pg_UAAAA:8 a=gq5M5jF_6ledRb6gi8cA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0NtaCTVGjOYSpp7Vv4BMjxuQDFYb5u3uxvIHM5NV04k=; b=FU7vQujz2rS0onI7bq2398r92f
        yjnfA8G0aQkFCaHHiAQNObT89HDOuXpxfchnLtf/LZIOXXI0557oPadCaz0cxOIpO9vlp5nyaJnmY
        lzY1kKtx8iuZ7r7Xjk35r6tfJFqh3Ts9D/jxjrOEcwDxCxsS+ySD59ijGTizylOrSBrQ01ds7h8DC
        QHghQuneEEYZqbsgDkaGauphGNKcrayXtHw+QATlBE70wJDGgK2cTrgIQFGxJjxhR3tUUKQzpZsKc
        jriQOX3K7c/NHW2rIm1sVxGbppvGhYvkLgpBnFmABsLohWW/mIF8h5JoWjW777iXZn+Sat7EzEXmr
        JBZs88PQ==;
Received: from [94.239.20.48] (port=55432 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy7m-003gxW-0M;
        Sat, 23 Sep 2023 03:36:26 -0500
Message-ID: <436d7488-1a20-b6af-8e3f-f151ba2c210d@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:37:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drivers: thermal: tsens: Annotate struct tsens_priv with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175341.work.919-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175341.work.919-kees@kernel.org>
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
X-Exim-ID: 1qjy7m-003gxW-0M
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:55432
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfArTGrjtDyCD+nMBKezyuAx5fwLeVjXFBuwD2atG6aDTeJ40gn1jnEDJj4Hx59AAYCAr5+CUvPxoFCSyHDeK2gdWLq1aCMdBdP3df4EtwL9zdekjkyBm
 6+zmKihJqDBBHqbrqf3FBQ+73EDOqYMx5NY7rTqX02UeDzkzQ/Xl5746xxBn2Be0Jt+ql/7oTiuhH/sYPkD+K5EzHdAvaltzrGrYJj0t7WQdkN/OU5d9hnXS
 xDyxVANNoRXSAEbWnIBl8OowUHYidPNMqdZYnd11iDdhzQP7H/HlxBHn9JrqbHOZr4qKWch2ZZj8syvGIHw11+ma/8V4yJzaWdZQNwe9S6p03TclWjvlxz0c
 gHAxYZ7U
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
> As found with Coccinelle[1], add __counted_by for struct tsens_priv.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Thara Gopinath <thara.gopinath@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/thermal/qcom/tsens.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 2805de1c6827..cb637fa289ca 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -585,7 +585,7 @@ struct tsens_priv {
>   	struct dentry			*debug_root;
>   	struct dentry			*debug;
>   
> -	struct tsens_sensor		sensor[];
> +	struct tsens_sensor		sensor[] __counted_by(num_sensors);
>   };
>   
>   /**
