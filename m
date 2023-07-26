Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708607640B9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 22:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjGZUpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 16:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGZUpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:45:31 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEED610DB;
        Wed, 26 Jul 2023 13:45:30 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9b9f0387dso3012921fa.0;
        Wed, 26 Jul 2023 13:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690404329; x=1691009129;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qGCqCU+TezLIUfpUCfOZVe0/fV0+wUaNn6X+yCvMglk=;
        b=lNNTh4PYpy1EsvS/52nqXdTfZcerS4ldeEFiGJlgaPcyZYHxaWWQeENoJaZkzhyvsr
         cyn/H40ulEnp8SkBAW8cRIQ6dmATRIiX0Y2IzODNLyItOlaE+w9+1ZADH/Rc4j+ANCmZ
         kUFmVU0Jyw1c9yAbAOxdPV5i/nAa8Y5hEOJZeoVw9tB4FQp3YhuxiYYkFICpv7Si1c1f
         KsalESTA7JU9o+ZcK6eGoIowgjP2iE5ZHZiaR9DDj30AklCLp/3S3a3OqKkrPQMAx+Ri
         InXLNdZgqxpA3tDn4nwkkRN9wSIH9YuHHW3fRy/5CB0+i9TNt4+oGfAjuvohN0YCMAdc
         iv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690404329; x=1691009129;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGCqCU+TezLIUfpUCfOZVe0/fV0+wUaNn6X+yCvMglk=;
        b=IbRapYEITWECe77hptxCxlEvBBKqf2k7F0jF0qgoyIJb2WIyTp/Labt7tOu9UyVbIM
         UeNSarJSmV3JDywSRDYdRmMLdozomYnZIw3Zi2+CNu2B0ejcBdDDMdf927AQzhcB/9ER
         MnX/FKSaR0oAZLXVYlGOxVGwMxbi3pBQWbR70NYLM63crTj63ClIcf7hYwSsqaRT2lwf
         R+GK9f3sN8/SvvtP0Ec/nsF6sX+ayL7B14KXQjx8LWwJpngBeoW9R6TUb5gKRj4KZC0K
         wdI/9W45l2sswcC5wck1Rb2I8aRn4+PymhCQGeTvKUwn1bLw/CAujw7hiOzJoxAIlAt/
         OJ1w==
X-Gm-Message-State: ABy/qLYH+1ujNQEjIroz8/iIrD+Ba8uwefAf3JlOimb2ot0eeJYy+1JS
        zhMQbpGqk6o7c7JGcvkk/d+B0CCC+oRd5vGXG+M=
X-Google-Smtp-Source: APBJJlH4LtWwe/HU8YemRgvsa1IGuLJxx5RnR8HJey8fqgicxFCJQhO6NCTMFIxODRaNkQ+2UVCUr+Cg2IF6sSY1WJk=
X-Received: by 2002:a2e:7315:0:b0:2b6:a763:5d13 with SMTP id
 o21-20020a2e7315000000b002b6a7635d13mr164823ljc.27.1690404328662; Wed, 26 Jul
 2023 13:45:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:dc89:b0:978:9011:58a1 with HTTP; Wed, 26 Jul 2023
 13:45:27 -0700 (PDT)
In-Reply-To: <20230726143419.19392-1-yuehaibing@huawei.com>
References: <20230726143419.19392-1-yuehaibing@huawei.com>
From:   Jay Vosburgh <j.vosburgh@gmail.com>
Date:   Wed, 26 Jul 2023 13:45:27 -0700
Message-ID: <CAAoacNmRXNbc5wZAjre3U-VwzKh_V==bmJZCoXLAHcWmNVW9Eg@mail.gmail.com>
Subject: Re: [PATCH 27/29] bonding: 3ad: Remove unused declaration bond_3ad_update_lacp_active()
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     andy@greyhouse.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jon.toppins+linux@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuhangbin@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23, YueHaibing <yuehaibing@huawei.com> wrote:
> This is not used since commit 3a755cd8b7c6 ("bonding: add new option
> lacp_active")

To be clear, it appears that the cited commit added the declaration of
bond_3ad_upate_lacp_active() to bond_3ad.h, but did not add the actual
function definition.  A brief search suggests that the function has
never existed.

Regardless, the declaration shouldn't be there now.

Acked-by: Jay Vosburgh <j.vosburgh@gmail.com>


> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/net/bond_3ad.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
> index a016f275cb01..c5e57c6bd873 100644
> --- a/include/net/bond_3ad.h
> +++ b/include/net/bond_3ad.h
> @@ -301,7 +301,6 @@ int  __bond_3ad_get_active_agg_info(struct bonding
> *bond,
>  int bond_3ad_lacpdu_recv(const struct sk_buff *skb, struct bonding *bond,
>  			 struct slave *slave);
>  int bond_3ad_set_carrier(struct bonding *bond);
> -void bond_3ad_update_lacp_active(struct bonding *bond);
>  void bond_3ad_update_lacp_rate(struct bonding *bond);
>  void bond_3ad_update_ad_actor_settings(struct bonding *bond);
>  int bond_3ad_stats_fill(struct sk_buff *skb, struct bond_3ad_stats
> *stats);
> --
> 2.34.1
>
>
