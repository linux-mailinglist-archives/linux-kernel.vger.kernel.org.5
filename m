Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21A77B765C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 03:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbjJDBpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 21:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239938AbjJDBpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 21:45:20 -0400
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB2BBB;
        Tue,  3 Oct 2023 18:45:17 -0700 (PDT)
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
        by cmsmtp with ESMTP
        id npJ5qV5ESMZBknqwuqUeQj; Wed, 04 Oct 2023 01:45:16 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id nqwuq7G9NfxkCnqwuqAhq1; Wed, 04 Oct 2023 01:45:16 +0000
X-Authority-Analysis: v=2.4 cv=Ncf1akP4 c=1 sm=1 tr=0 ts=651cc3ac
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=cm27Pg_UAAAA:8 a=Ya94Id-Vmw91v3G0P5EA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oUTcrB8y0U/ZeJDKrciZRPYgeYAFIfr5RUqYNxtqMgI=; b=SS3mVSfxR5i7AXjWHDiZ0XaEwo
        rk0kvAPo565hAxsj9PytvyqKROMyi0+sdiAUZPz1WP0M7U8bKvp39b/VkK91d7bXZp5K2RkiVD1xg
        LgJL096IbKDEpFuxfv7AmN1oN9u3Gxuj2GTBUumPs0oza15c0ztomFouUx4sUbzMm1ejb1QMA+S1S
        WxQO0/ZaZcdUVBLZmS++LqMv43obHFl5LHbl53omxyP+mOHjETHDpzcy+7WloqbY2L8E5nnHA1RZh
        aDykUoIPgwwX0f8dKxiEpWsPhJueICZrTvUrrDNxZhJHE+YQybOZcHjhjo6Ifpcjqoch88yhjkuUw
        fwYmvrfA==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:35240 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qnoz3-001Tcu-2P;
        Tue, 03 Oct 2023 18:39:21 -0500
Message-ID: <87a74ca5-13fc-f8ec-5e54-66836532ada7@embeddedor.com>
Date:   Wed, 4 Oct 2023 01:39:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] i40e: Annotate struct i40e_qvlist_info with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Gurucharan G <gurucharanx.g@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
References: <20231003231838.work.510-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231003231838.work.510-kees@kernel.org>
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
X-Exim-ID: 1qnoz3-001Tcu-2P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:35240
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCyhTZFhh7o58gz2hYzx94XPU16YGcf/dm58AEm6vC5xUlhEM5x75X+LslVnyCwqPLoT2gLrk1TVrVxiu9ARNcMt5CUrG4hJ/2NvhuiPPqGH1lNBnyUs
 Fgks3WUbw5286WwC9y3AjJcaVIyWKqAsVKssOyBQ+nceOIMc/IljhgSO2dS7XjIPHqgn2FWGDsr0vOMUTf7fbM/Dv4ZwnitwbqLG69MyTsI29u8AjCmF3jWh
 uZx331URXzAbyC4MHiyf1QpDW004A59D0A0bDvEbXXk=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/23 01:18, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct i40e_qvlist_info.
> 
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Shiraz Saleem <shiraz.saleem@intel.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Cc: Gurucharan G <gurucharanx.g@intel.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   include/linux/net/intel/i40e_client.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/net/intel/i40e_client.h b/include/linux/net/intel/i40e_client.h
> index ed42bd5f639f..0aa4411528fc 100644
> --- a/include/linux/net/intel/i40e_client.h
> +++ b/include/linux/net/intel/i40e_client.h
> @@ -45,7 +45,7 @@ struct i40e_qv_info {
>   
>   struct i40e_qvlist_info {
>   	u32 num_vectors;
> -	struct i40e_qv_info qv_info[];
> +	struct i40e_qv_info qv_info[] __counted_by(num_vectors);
>   };
>   
>   
