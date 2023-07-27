Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989A57652C3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjG0LoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjG0LoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:44:07 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528341FDA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:44:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5217ad95029so1054762a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1690458245; x=1691063045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Pd52QAOVtNNbgDqHYQEjCrAzdyOOjihPSFq0M5Ik4Y=;
        b=Bbak6hOsd1TyATRGYe05W+0/rKMMCiOckHsDdv6SyfQ0uqHMfd3rafUSrblXXzZoyK
         FHmSWmyL7uuFub/fafa5s6Gam61mZI3IzRKmsHFU0ZiMqKVeVGtqm5DR7DqF7JXKTXUF
         aH+mx/OTorlYbaLSNJgaozLQQOD+gkVjFPJryET2EKavzdFF74BjnpzS0aMo5Q7aO3++
         DfWTnOH1fDDHf/iOk1+Vek4v6aZDcu8EJJ/ZEiXBsQtUnj/6LXvYIGvW1+7cYa3iH/aX
         NNhAbdaKjxHA33v71NGTz73iWZdfrmjAVdhuUqBoLHqsSK82OhCjmn5onGqGbvwAQWUf
         PGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690458245; x=1691063045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Pd52QAOVtNNbgDqHYQEjCrAzdyOOjihPSFq0M5Ik4Y=;
        b=IbZctikjHpXwuzAOHfLNLY5VPso5ys4V4EQVUzOmrS1A9ph14lNGPnaKwXbh6KdK5P
         CqqnwYW7eQzn3MwkROALy/60M7qq7u+Y9nZ8GLlxeSCx0KIJ1GRxFPt4uetY1kdhftzY
         +V01vbw+Ku4l95vWl5t/5+U3Ch9hXJmHPIC0ccSAxi8swMXXtgAF6uWWyRwHH4fKhYJO
         mxTgcNe2P7X11RQJIwOeNmQve9b93PQHO6np9z95gj9wF0oTm1b8ybH3zcIUZ/U+cOpG
         Vs/RBUrdIcGlnFQLrMdbYz2p7Rr1bRs19Cc9DC+CyCKRSDxP1MxOwLZWzRMs1CVeLIbh
         BStA==
X-Gm-Message-State: ABy/qLZ9We10EQaCYRlJ5g53FlNsYCYWz/lcYSu0h6ApHB8I2ZYWB41b
        PXswaP8DZXvqiu3+PE2TsGPJNw==
X-Google-Smtp-Source: APBJJlHxaXVKfTJi3HvDwrCK+UddDlp4jZfELrpULv5ukfq77Dm+KA3G/1qp1PoAPSnHwBXlpw+QCA==
X-Received: by 2002:aa7:d65a:0:b0:518:6a99:cac3 with SMTP id v26-20020aa7d65a000000b005186a99cac3mr1394418edr.31.1690458244681;
        Thu, 27 Jul 2023 04:44:04 -0700 (PDT)
Received: from [192.168.1.2] (handbookness.lineup.volia.net. [93.73.104.44])
        by smtp.gmail.com with ESMTPSA id d7-20020a056402078700b005221ce96801sm565226edy.35.2023.07.27.04.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 04:44:04 -0700 (PDT)
Message-ID: <bd9e39da-088c-976e-982e-f5e2d4f4528b@blackwall.org>
Date:   Thu, 27 Jul 2023 14:44:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next] bridge: Remove unused declaration
 br_multicast_set_hash_max()
Content-Language: en-US
To:     YueHaibing <yuehaibing@huawei.com>, roopa@nvidia.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, idosch@nvidia.com
Cc:     bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230726143141.11704-1-yuehaibing@huawei.com>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230726143141.11704-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 17:31, YueHaibing wrote:
> Since commit 19e3a9c90c53 ("net: bridge: convert multicast to generic rhashtable")
> this is not used, so can remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   net/bridge/br_private.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 51e4ca54b537..a1f4acfa6994 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -974,7 +974,6 @@ int br_multicast_set_vlan_router(struct net_bridge_vlan *v, u8 mcast_router);
>   int br_multicast_toggle(struct net_bridge *br, unsigned long val,
>   			struct netlink_ext_ack *extack);
>   int br_multicast_set_querier(struct net_bridge_mcast *brmctx, unsigned long val);
> -int br_multicast_set_hash_max(struct net_bridge *br, unsigned long val);
>   int br_multicast_set_igmp_version(struct net_bridge_mcast *brmctx,
>   				  unsigned long val);
>   #if IS_ENABLED(CONFIG_IPV6)

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

