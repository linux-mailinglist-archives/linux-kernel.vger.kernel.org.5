Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0507AC41E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjIWRmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjIWRmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:42:07 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7837F19A;
        Sat, 23 Sep 2023 10:41:53 -0700 (PDT)
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
        by cmsmtp with ESMTP
        id jnFfqzM8QWU1ck6dcqUhIJ; Sat, 23 Sep 2023 17:41:53 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id k6dcqYsbcsKmik6dcqOQHp; Sat, 23 Sep 2023 17:41:52 +0000
X-Authority-Analysis: v=2.4 cv=JOMoDuGb c=1 sm=1 tr=0 ts=650f2360
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=qjWHau5h7Oqj65Zv8QkA:9 a=QEXdDO2ut3YA:10
 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=a1cv35n2o4f2bEvZFIreE5M4LZ3FPB59h2mQVFSlpSc=; b=Tg3GH2p50Nka6ir8Q4DNv5x/ww
        7plSfgvQWc5sSYK4RuetdXhG7v05M8vyxtTOvmD868eudh+kdKc9egqFmcvtBfVB+sUZ36td2ERyn
        6i9jH1SrNVv0EYxSLrfxw190CZetTaMK/T8qF+iwuSP1mU3CBhbct2rJWYMxwHbGSf7eMSxIKzF/m
        XPcJqtzh42uoQAm33NDC59L+rOEGj9tGKoSWD1qwuKmFa6E9L48lx2iUIbTeTTCCFjdxki+N93Y77
        H5ZSoB960cCu22SSYdsoRiX68ztTYcrxJAdzT95UuTRByB6op5Rbs3IWdwbA4lSFzFxt+U33Cx7Lf
        nBhg2AUQ==;
Received: from [94.239.20.48] (port=37634 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy63-003eQo-3D;
        Sat, 23 Sep 2023 03:34:40 -0500
Message-ID: <fd9a945e-b5e6-2926-af22-e632ad2281c6@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:35:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] reset: Annotate struct reset_control_array with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175229.work.838-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175229.work.838-kees@kernel.org>
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
X-Exim-ID: 1qjy63-003eQo-3D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:37634
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfG1BXNuvT4TlYdWvieUR0tk15pd+m6Sqxj8QJhoNhNI30fpqY76CSDvRQHD2gKkgtFzOxVCd/zLsZIjMcnr1y9PQfEt7NUzZqO26o8OomBxFqZSno/1k
 1cv1TPocph9r1zAyJQPyfrbOm1xS+fQkqW0NbXRWQEXRGLCRh7KKjXDzEBY3Yiyn+ZwSihYdrCKBRnkCJFMfg1fIP74xza1NPd+PARmLjNCcDqUiOhHScQMX
 eLZ/mGr1KkdF25kD8jvIRDv7+27HGoDR7tXyo1d263I=
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
> As found with Coccinelle[1], add __counted_by for struct reset_control_array.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/reset/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index f0a076e94118..7ece6a8e9858 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -60,7 +60,7 @@ struct reset_control {
>   struct reset_control_array {
>   	struct reset_control base;
>   	unsigned int num_rstcs;
> -	struct reset_control *rstc[];
> +	struct reset_control *rstc[] __counted_by(num_rstcs);
>   };
>   
>   static const char *rcdev_name(struct reset_controller_dev *rcdev)
> @@ -1185,6 +1185,7 @@ of_reset_control_array_get(struct device_node *np, bool shared, bool optional,
>   	resets = kzalloc(struct_size(resets, rstc, num), GFP_KERNEL);
>   	if (!resets)
>   		return ERR_PTR(-ENOMEM);
> +	resets->num_rstcs = num;
>   
>   	for (i = 0; i < num; i++) {
>   		rstc = __of_reset_control_get(np, NULL, i, shared, optional,
> @@ -1193,7 +1194,6 @@ of_reset_control_array_get(struct device_node *np, bool shared, bool optional,
>   			goto err_rst;
>   		resets->rstc[i] = rstc;
>   	}
> -	resets->num_rstcs = num;
>   	resets->base.array = true;
>   
>   	return &resets->base;
