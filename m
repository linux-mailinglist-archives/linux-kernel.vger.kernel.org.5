Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565E97B45AE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 08:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbjJAGnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 02:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjJAGnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 02:43:51 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C153BE
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 23:43:49 -0700 (PDT)
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
        by cmsmtp with ESMTP
        id mm6OqmEFFaLCxmqBAqyBMm; Sun, 01 Oct 2023 06:43:48 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id mqB9qnwFw1J29mqB9qxDhP; Sun, 01 Oct 2023 06:43:48 +0000
X-Authority-Analysis: v=2.4 cv=Ko9eZEaN c=1 sm=1 tr=0 ts=65191524
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZuglWOHeRktdc1SI7fZMrBNHt7pae0GyCoYbfoLsddc=; b=GFdvOHVqx5Ih/kinRsGsl14I4H
        XwgD7x624J2I2bdWybbFp0blj7IipDqTb2ve8qeM1Zr6SStvdA1RDj4fLKTA+gu+Px53PQkTEfhPA
        F8Tdj5L0w+fk1NcqtKULEGRfDKe/H/V3lDCCDS81uwTDIVSeCIwuGj/Rr51EDxyHU4mQoTYnjRS7z
        Een0yBKUVeStFKGXsILzuV55OhL0zibUcfe4sRvsi54GMD5jthFMPrKwLdJY4gHBpPRkyP8SvuaFJ
        ZOO2FqckXRE0UWVQngqNNafYK6Jhr8b7I5R4gQhhYBNf/529jWdDw2iPKECUyLMULWp7JFPZM4X6r
        KLmBhQDg==;
Received: from [94.239.20.48] (port=48958 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qmqB8-001P7H-25;
        Sun, 01 Oct 2023 01:43:46 -0500
Message-ID: <935d0577-4a6a-eb84-6ae0-f1efa4352b5b@embeddedor.com>
Date:   Sun, 1 Oct 2023 08:43:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] comedi: Annotate struct comedi_lrange with __counted_by
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
References: <5c3b7459b820e22e2ac6ce892d4aadcc119cc919.1696065263.git.christophe.jaillet@wanadoo.fr>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <5c3b7459b820e22e2ac6ce892d4aadcc119cc919.1696065263.git.christophe.jaillet@wanadoo.fr>
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
X-Exim-ID: 1qmqB8-001P7H-25
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:48958
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 74
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFvCx0n8uqFRLdcr1B1V85l6hz8vm+soMv7BEoMrbY6SxEw4j4NvcKF7LEPM4g+rrfHxrPszJivqXJdSHiRhQcRXnYUiR+DvykPXc2O07zwY4+C8DoIi
 HNOAkoX4Ig6bQ4voXxyz55esckoPersTaFs2PwB23jRggYSBLHkNZtieAzY/WylJ6y8Un8xUfEkb5O1On8QXVlbTeZEOqRTRSKOYDcNXmVtLudeK9gaK1XE8
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/23 11:14, Christophe JAILLET wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
> This patch is part of a work done in parallel of what is currently worked
> on by Kees Cook.
> 
> My patches are only related to corner cases that do NOT match the
> semantic of his Coccinelle script[1].
> 
> In this case, it is been spotted because of comedi_alloc_spriv().
> All other usages of struct comedi_lrange seem to be static definition of
> the structure that explicitly set the .length field.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> ---
>   include/linux/comedi/comedidev.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/comedi/comedidev.h b/include/linux/comedi/comedidev.h
> index 0a1150900ef3..c08416a7364b 100644
> --- a/include/linux/comedi/comedidev.h
> +++ b/include/linux/comedi/comedidev.h
> @@ -633,7 +633,7 @@ extern const struct comedi_lrange range_unknown;
>    */
>   struct comedi_lrange {
>   	int length;
> -	struct comedi_krange range[];
> +	struct comedi_krange range[] __counted_by(length);
>   };
>   
>   /**
