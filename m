Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D8F7BC0A2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjJFUrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjJFUrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:47:00 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF78DE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:46:58 -0700 (PDT)
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
        by cmsmtp with ESMTP
        id orX8qohJpNWIeorisqivyt; Fri, 06 Oct 2023 20:46:58 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id orirqOgXdZLueorisqrqaZ; Fri, 06 Oct 2023 20:46:58 +0000
X-Authority-Analysis: v=2.4 cv=E+reGIRl c=1 sm=1 tr=0 ts=65207242
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=ag1SF4gXAAAA:8
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=cm27Pg_UAAAA:8 a=0yL73Cyy68KADmUz8mEA:9
 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yJDh+BzYryVHURkRG0+e4mBjz5lxhhL3Icwuaxn3lOk=; b=IrA9GRSJjCiYLlD1IlJl7yFifs
        S5S4uB0zf77a7PlnpBsiIMDHdQNGfOrk+eJFm4B13pqFjR6qQEzqCSdNjHTrzzBcq6/10AlBYyDCK
        PZm/QI+zk3zRrkN1TjiiBOgE+BN6yZkOG9Hw8M+3ZGox003ATbwgujqtLXCM71LqAmZmtwaxWcYQD
        ZTds/nql5RRZoY3P02MaiFJrEJAdS36K+9N7vcy5yYPOM49ecg4xB1AGEmD/yZCMvXIDk0v8KJHTY
        X5SsDiB7DvQ+ThMKFOFnXLa/mgyNaDE08UCgk2HUQSaKiHvnP+HhEGgMK4WJTsweX2rr8ZyZCdME7
        OJPNeSqQ==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:47408 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.1)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qoriq-001Bge-2b;
        Fri, 06 Oct 2023 15:46:56 -0500
Message-ID: <3c42ae53-ca2a-4b99-8010-ca70e4fbad58@embeddedor.com>
Date:   Fri, 6 Oct 2023 22:46:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: platform: Annotate struct
 irq_affinity_devres with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20231006201749.work.432-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231006201749.work.432-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.238.9.39
X-Source-L: No
X-Exim-ID: 1qoriq-001Bge-2b
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:47408
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 35
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNqb+3XBPlJGVc/dnzEoQ+zbb8T4wIBSwAjZX1+BFQUDt6lWnwGruYOuQnF4c85QfP2/zvcCukf4x8SK4WByaTVO9nAMyIEi+HNoIC0R4aG+kFclNPly
 qwW3Bf3db/KW6cZ4FulJqMI5s1ZHsl+6MNuBJZowjnACYQZxcm+XdzcAGjGM1iVC1IhX93Uc1u6x7GOd27E6eMyfvhcNo4TcUAaE2ERLwV/+QK/roMjUpb0T
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/23 22:17, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct
> irq_affinity_devres.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   drivers/base/platform.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 76bfcba25003..07216889d3ba 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -291,7 +291,7 @@ EXPORT_SYMBOL_GPL(platform_irq_count);
>   
>   struct irq_affinity_devres {
>   	unsigned int count;
> -	unsigned int irq[];
> +	unsigned int irq[] __counted_by(count);
>   };
>   
>   static void platform_disable_acpi_irq(struct platform_device *pdev, int index)
