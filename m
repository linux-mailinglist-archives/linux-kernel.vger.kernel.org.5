Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FE17BC2C8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbjJFXDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjJFXDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:03:04 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B40A6;
        Fri,  6 Oct 2023 16:03:02 -0700 (PDT)
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
        by cmsmtp with ESMTP
        id oYGBqjmR9NWIeotqXqjgZm; Fri, 06 Oct 2023 23:03:01 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id otqWqCwDY0GnbotqXqXpZZ; Fri, 06 Oct 2023 23:03:01 +0000
X-Authority-Analysis: v=2.4 cv=btBfuWWi c=1 sm=1 tr=0 ts=65209225
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=n9Sqmae0AAAA:8
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=cm27Pg_UAAAA:8 a=u-_MtDP4nkpryoX2ZJoA:9
 a=QEXdDO2ut3YA:10 a=UmAUUZEt6-oIqEbegvw9:22 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VBGDvZyyYkRgxFIbXzQBi8VzcoI67HAzbQQBsrMirwE=; b=ep9L0mkkrQy2WMIZJ65JEfzfix
        0zmqIVnJ0o3V5YcvcY6kyu4NDrTdhiz+ZlVj1SA17X4irNaBJlcB2FBrBaXILf1NdkMHTDuzjIqL5
        2Uf7VNW65DgEfzdOAdWe6hK8+HcTTp2mhoK6EPR/lNdS+ceNT+azTgCQha+GOMzNva66uitI7tKR8
        fcKFyR3lJIBu0KH3DGzInQGLgjHf6sPmwPcZz+2HyeHxceFAEcoPFwRc5UKE1sjFWczy+Zku6qnI4
        FymLJzjlIF7IHDp5UgEhkl57bAOLCf6MaLUIaN5hw8d9VQZ2hszGruPAYwxgqRoHOLRhYZpZpe4i2
        ZKs1C1Rw==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:47408 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.1)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qorlY-001Bge-0E;
        Fri, 06 Oct 2023 15:49:44 -0500
Message-ID: <00482b1c-c88d-4e84-ba06-92f00dec8f53@embeddedor.com>
Date:   Fri, 6 Oct 2023 22:49:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtw89: coex: Annotate struct
 rtw89_btc_btf_set_slot_table with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20231006201715.work.239-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231006201715.work.239-kees@kernel.org>
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
X-Exim-ID: 1qorlY-001Bge-0E
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:47408
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKCkX5Qz9iTbjJqp+ORZRZ/hg+4pAS96w8SuLz2X9dpNO2zyYo+HXK0BkSTvmBVJYoudOYjddaUSj4dNPP0cO9BmqeH9xTKJ/tMqO4wLmivTC3gaqrjd
 CwGPwUBZbChREXWuM5t7zHfFIKTzjIoxKEAXoigeJFPihlTbITdwLw2ZX8n5JspiRLBh03W10nO5t1WcWXm5tv5QBQZRi3o+uJl2kIAacI4Ldmf//N2n0B/2
 OibSFX0DFCtqAn1nSzqCu2IbZJHQ9aHoJrVyRXNtIYu89+q+UN2WFFoyu7anIwzKDsJl6rRHSGWKK59inAaKKw==
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
> rtw89_btc_btf_set_slot_table.
> 
> Cc: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   drivers/net/wireless/realtek/rtw89/coex.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
> index 4ba8b3df70ae..d66a1152c3f5 100644
> --- a/drivers/net/wireless/realtek/rtw89/coex.c
> +++ b/drivers/net/wireless/realtek/rtw89/coex.c
> @@ -237,7 +237,7 @@ struct rtw89_btc_btf_set_report {
>   struct rtw89_btc_btf_set_slot_table {
>   	u8 fver;
>   	u8 tbl_num;
> -	u8 buf[];
> +	u8 buf[] __counted_by(tbl_num);
>   } __packed;
>   
>   struct rtw89_btc_btf_set_mon_reg {
