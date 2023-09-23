Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EB97AC2FC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 17:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjIWPBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 11:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjIWPBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 11:01:51 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16686180;
        Sat, 23 Sep 2023 08:01:36 -0700 (PDT)
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
        by cmsmtp with ESMTP
        id jkvmq81bNyYOwk48Vq1MSN; Sat, 23 Sep 2023 15:01:36 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id k48UqVJzxuMYjk48Vq4HOZ; Sat, 23 Sep 2023 15:01:35 +0000
X-Authority-Analysis: v=2.4 cv=RtrWkQqK c=1 sm=1 tr=0 ts=650efdcf
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=pGLkceISAAAA:8 a=zd2uoN0lAAAA:8 a=JfrnYn6hAAAA:8 a=cm27Pg_UAAAA:8
 a=VwQbUJbxAAAA:8 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=saoGgFJRW6eoqqvGVB6N6sncSASVw7j1ZUzVjFSJ6Ks=; b=yyW/V+RSJ5BXaXl7J5sQOPdcGR
        YeCBMzNWxCKfuRwd6rFuHfn8mN4WihSSTyOsBYC3GDsD0NXrpNm/mIOTnZS51mensVmVxmbmscDzR
        1RccXdO8rKcRgB8U2CJrB5/8g2qxJb8SH3EbXKbHF3YCx9sspklaXUWbF9+XZ+WTBrpbq+lxNAK21
        QgdN8dJaR47V2+cs17BZcbrnjXaBCoKXbRgGJVQJzR1J5XwFHML+vdMxlfnoa+EvaexXW1mA5qdEd
        YZd9oj/eOlJjgDIG+qCvMrIiXLd0pRrdchRHPenwtHFikdr7jesaeRGx7OS6UjGsBjTnRd7OAWn8r
        VzEPyKRw==;
Received: from [94.239.20.48] (port=54308 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy8E-003ho9-2h;
        Sat, 23 Sep 2023 03:36:54 -0500
Message-ID: <d1b540f2-c909-7c43-6b5b-aabe2607f532@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:38:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mailbox: zynqmp: Annotate struct zynqmp_ipi_pdata with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Michal Simek <michal.simek@amd.com>,
        linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175351.work.018-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175351.work.018-kees@kernel.org>
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
X-Exim-ID: 1qjy8E-003ho9-2h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:54308
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfF/6bCmhG2CgpVtsxbntxd2hhTuLjzdKQzyXO4aYv/ag+ehg6obCnjLpmhB9UreCpq0SPD+C4RJAYR46wfBEZeeQTFetyplCxKMGoljCEuls5y/Jk095
 XnwGqSWrMTPdi6AJjC21rhPPzTrzjz5QDTTR+WBX8zL0Jv+DD/AsI2RWAI7WDS9mmiByBsqS/ZoqBxBtSH0eHRDBiN7r2C0SrCmDpja6LBQFVx43OqFlrsBR
 8vEVJGKG7egYWU8kv8oZQIJngQO1QyX8liGK2nV99r8=
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
> As found with Coccinelle[1], add __counted_by for struct zynqmp_ipi_pdata.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/mailbox/zynqmp-ipi-mailbox.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> index e4fcac97dbfa..7fa533e80dd9 100644
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -108,7 +108,7 @@ struct zynqmp_ipi_pdata {
>   	unsigned int method;
>   	u32 local_id;
>   	int num_mboxes;
> -	struct zynqmp_ipi_mbox ipi_mboxes[];
> +	struct zynqmp_ipi_mbox ipi_mboxes[] __counted_by(num_mboxes);
>   };
>   
>   static struct device_driver zynqmp_ipi_mbox_driver = {
