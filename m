Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C157AC1FD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 14:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjIWMXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 08:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjIWMWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 08:22:48 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67121B0;
        Sat, 23 Sep 2023 05:22:12 -0700 (PDT)
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
        by cmsmtp with ESMTP
        id jjHeqfzSYOzKlk1eGqI31W; Sat, 23 Sep 2023 12:22:12 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id k1eFqvcESU8Krk1eFqtQqM; Sat, 23 Sep 2023 12:22:12 +0000
X-Authority-Analysis: v=2.4 cv=Qt9NYH+d c=1 sm=1 tr=0 ts=650ed874
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=NwbpVL58AAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
 a=foHCeV_ZAAAA:8 a=cm27Pg_UAAAA:8 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10
 a=tNWvAHffTtQgx3ZTRG8Q:22 a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
 a=h8a9FgHX5U4dIE3jaWyr:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MSqzGt9UPF/qfrZg382/BJIq8GRlN4t6fuaOHKqouVk=; b=h3eHSGppG8aL2sTqNmwGzFk8RX
        bCel+HJ6ZDApjZGTwxq6N6Y4051hjdcyd9Z/364iEtKUFRiodOhNGBiU9g0JmzsatzaMG7Vr+rmFk
        rEbNLVLT97eRpw57p7VaUE4JvXh/FByGB7FVtAbd9fCCmOBMWUznMij6EuaOb1b/WrzBa23gZZg27
        uIdBaDQVcrLzZ1DnI98JiaovZq+wJ6C5meVeTi5za/74sJ90ySNgsUdtaNXQrDAbd+rBCrVpeRYbf
        NU7AmJk7ac6oM7dJQqXfFKbna27k6FKOOXtpz9FurtiBD5p7NRnBofkQNypLKa2kLipwFOKSuYedm
        7EZUSL7A==;
Received: from [94.239.20.48] (port=49974 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy1T-003YxY-0f;
        Sat, 23 Sep 2023 03:29:55 -0500
Message-ID: <5b288203-e26d-9fd2-fc5f-e30e78f0202e@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:30:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ASoC: apple: mca: Annotate struct mca_data with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev,
        alsa-devel@alsa-project.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175050.work.819-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175050.work.819-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qjy1T-003YxY-0f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:49974
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBpVXSgdmsPgxA4z2d/LwNDnr5lkHH1cODO+NQmpSJYY6lrQBD27dJg9X/XYxQSAbF6U8/GWqUDFz6wpR4KidcJVsLSqh8+6oKQI9vpwCsdHVLuq615C
 ceLK/pASYDZ/IHoDnRf7FqeY8eOTkdCUM9vFjktNNkgMJIM8faM3ahl1J/BnBfXZSGM/96ePynvYtZV5ZTKBMhz0JMt1OhaTNPmUj19AqvN4fy0OVoKQpZwC
 TSbJoDvifB9hX4yFWlsIRhxEqD7d67h6/IrwkIIO0HI=
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 11:50, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mca_data.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: "Martin Povišer" <povik+lin@cutebit.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: asahi@lists.linux.dev
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   sound/soc/apple/mca.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
> index ce77934f3eef..99e547ef95e6 100644
> --- a/sound/soc/apple/mca.c
> +++ b/sound/soc/apple/mca.c
> @@ -161,7 +161,7 @@ struct mca_data {
>   	struct mutex port_mutex;
>   
>   	int nclusters;
> -	struct mca_cluster clusters[];
> +	struct mca_cluster clusters[] __counted_by(nclusters);
>   };
>   
>   static void mca_modify(struct mca_cluster *cl, int regoffset, u32 mask, u32 val)
