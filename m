Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1877A27FD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbjIOUWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbjIOUVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:21:37 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B2FAC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:21:06 -0700 (PDT)
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
        by cmsmtp with ESMTP
        id hFDFqQE20WU1chFJKqTVfB; Fri, 15 Sep 2023 20:21:06 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hFJJqfcJo7DhyhFJJqOyaO; Fri, 15 Sep 2023 20:21:05 +0000
X-Authority-Analysis: v=2.4 cv=fpfP2X0f c=1 sm=1 tr=0 ts=6504bcb1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=ag1SF4gXAAAA:8 a=pF3H81QlAAAA:8 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=6mx6MrwIfq_fzEhb4BAB:22 a=TjNXssC_j7lpFel5tvFf:22
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nfbBbmChWyKNzoVj9/7lddkMlBXcM7IRZVK5hnelGKY=; b=L0dzUqc2X5mdOQrmM9CUYp+Ptm
        W9pqrDo8YisAJrcQWf7OqliJM64b/It0e2DZEwZS9SgmMuTfGQpOrMGuQqqQdYQPZS0ggYPMJRlBS
        L2nDON/27v1LN38z9OQZDOlIDShRL39XIrhfsYHdX//UlZLT22A4e4d8L0ufSiZNuPUNHHmBamPIU
        YxqWO4WAyUrLDHuB1keNHFAE//OCHXaH3tHUqCOkf5FNPnrQla0zw4lOpHj2ihJ91CT501bC/3SiY
        y1myxqw6wFh+/FzeIXFfIoUNkAm8ybXGsLihM/KJ8RwRs2KMt0isryxYtgUBUMa2+fyrMrssgy2Ei
        xoz2Dsgg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:58950 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhFJG-002EO4-32;
        Fri, 15 Sep 2023 15:21:02 -0500
Message-ID: <0b48fe61-7d05-1520-d77e-81ad39bc80b4@embeddedor.com>
Date:   Fri, 15 Sep 2023 14:21:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] usb: gadget: f_fs: Annotate struct ffs_buffer with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     John Keeping <john@keeping.me.uk>,
        Udipto Goswami <quic_ugoswami@quicinc.com>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        linux-usb@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Jeff Layton <jlayton@kernel.org>,
        Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>,
        Yuta Hayama <hayama@lineo.co.jp>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230915195849.never.275-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915195849.never.275-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qhFJG-002EO4-32
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:58950
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 22
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDxC48b4Z9qSO7lYKGLBG2cBhu9mDX+IFN0gVryL9218YOiC1lpjCjXJcdKC6OWHZzYWroPsyUx9Bzb80bMk30zWRbURbp1TT86YEwzSakj/OSnwiCo3
 Np4eurVtI2rDwScs40g30YKnNFhjgSwlXq0D9Eahb3zp+t8fPJwutKnr5w3q1m0LK8ynnY7zyTm7XOqhA62lSJyc78+kU+h2nVbrAREVvfYqACBPSep92UHp
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/23 13:58, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ffs_buffer.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: John Keeping <john@keeping.me.uk>
> Cc: Udipto Goswami <quic_ugoswami@quicinc.com>
> Cc: Linyu Yuan <quic_linyyuan@quicinc.com>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/usb/gadget/function/f_fs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index 6e9ef35a43a7..af400d083777 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -202,7 +202,7 @@ struct ffs_epfile {
>   struct ffs_buffer {
>   	size_t length;
>   	char *data;
> -	char storage[];
> +	char storage[] __counted_by(length);
>   };
>   
>   /*  ffs_io_data structure ***************************************************/
