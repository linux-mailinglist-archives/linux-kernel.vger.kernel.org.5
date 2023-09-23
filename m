Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2A37AC50B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 22:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjIWUWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 16:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjIWUWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 16:22:00 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A9E1AD;
        Sat, 23 Sep 2023 13:21:51 -0700 (PDT)
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
        by cmsmtp with ESMTP
        id k0HiqjBDJOzKlk98RqJrfl; Sat, 23 Sep 2023 20:21:51 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id k98Qq2PqJHLNfk98Qqo33Y; Sat, 23 Sep 2023 20:21:50 +0000
X-Authority-Analysis: v=2.4 cv=Vp0wvs6n c=1 sm=1 tr=0 ts=650f48de
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8 a=cm27Pg_UAAAA:8 a=HvF037n1xESchLcPDVoA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dMtmtT6tX/J/Z9nN8F6wXmACJvxIhIjSA2EPSc7V54o=; b=nLSy7Yyg8X16vsP4+fNRB4Rotn
        66Cg4GycjlShrC9MRh6WTMvGPinJuZLxjOs9e7FizT69nAYp/OkhR/IhrDiNHjixOGY/4eQKAaoAX
        k5Mo8kidONlYLjZEvPv5x03+/cg8aCmfQvKmVYwJJLElNvPgHwbAr3yxCrtCiOdxlxn92geZB8iJJ
        XBNc4Flajgvmg6YhTs2c+QPVHTvFUWeE0RH4EULSQF2sBJ0kPOkstu9MQClUpd+K2JjCAdzdvLssr
        /wYuucKyHkJ8cnJPRYkXa3e+aPSVpAWxxoGE685mXoLtUsQXWVVXwa5l9DNTpIkhtmnfuc3VkZQ8v
        6sGqmEew==;
Received: from [94.239.20.48] (port=58218 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy3s-003bcu-2i;
        Sat, 23 Sep 2023 03:32:25 -0500
Message-ID: <f1aa9b5a-6867-6000-8f3c-9a15eb216961@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:33:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] video: mmp: Annotate struct mmp_path with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175141.work.450-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175141.work.450-kees@kernel.org>
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
X-Exim-ID: 1qjy3s-003bcu-2i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:58218
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAg1o1m1slACG/5MiR22o/lfKiMf1eXt4tBJ7+At16soq6acAFNQbeKijHAMUkSOiUJfxhzeFb8lP530gr+De8qTCMBNBEBRMg3Qm00ieDOq87Tb/lhU
 mi84RPQjlgW9MWfZxdRiRVleltxUNPsLBbuEvg/mWdk69qeONyM8QzE8wYsP645mvsb/7p4YY1x1wrcJQRNhceRz41CL0JXzOyNTiGaXmG1TTm6/gZh5kBvt
 RRy3Kv1ynklXW5EH2bixdDS1URsfCz1RFSK/kkFTtcqCg+4dagWLna5XB+4MB1r2qDBEqJwWfsuwbYaY9fR4zA==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 11:51, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mmp_path.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   include/video/mmp_disp.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/video/mmp_disp.h b/include/video/mmp_disp.h
> index 77252cb46361..a722dcbf5073 100644
> --- a/include/video/mmp_disp.h
> +++ b/include/video/mmp_disp.h
> @@ -231,7 +231,7 @@ struct mmp_path {
>   
>   	/* layers */
>   	int overlay_num;
> -	struct mmp_overlay overlays[];
> +	struct mmp_overlay overlays[] __counted_by(overlay_num);
>   };
>   
>   extern struct mmp_path *mmp_get_path(const char *name);
