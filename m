Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6E275E50A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 23:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjGWVl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 17:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGWVl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 17:41:58 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED67DE45
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 14:41:56 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a5abb5e2aeso948681b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 14:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690148516; x=1690753316;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oQyAvcaWHWv3RJcgIfZb6x+KSjpzqCRmKiuGw9VJrqY=;
        b=irzyAbUDOUBFInrJkC1J2ixfp2i3kv7rPTJCTtpR3qjGvmBrk2EdDpeP2R7OnfuX0b
         k6jCVexGkHnRMthfFky/C3Egc4HfJN7YZC5UVV2LusaA5MuaT7wj6hmxrfxxXng8V5O4
         RF2ADRLK7OMfpyPL9psRh0MVwCI/YcyU8QG6Q6qEPXm5nh6CXSjOUsPNvpd6Pue3dy+h
         JN4dz9NxPi9WGKdXhFAOPfMPHsSccWDRPDtwABjh3+PyhVC+m3NapevFva/EUooWDhA9
         kqZ/ocucNaRBsITy99FSUDaFZOA16GRS3gMjIOtf/+4ID8g37CLxYCl73AOfSQUiKIaq
         61JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690148516; x=1690753316;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQyAvcaWHWv3RJcgIfZb6x+KSjpzqCRmKiuGw9VJrqY=;
        b=ODSLnspUlKiCLhROMA9W3mTR+sj9MzHb6LYdvouu10bbN5g4zuKDwuwkI8Eo/9K/Z+
         8H0L3oPZETNriscoY6J0c50io23XHJA5VPnJQ8MEUzrRWOyAtTeZfkpieU0TeqGtGuV/
         xRxJZiR3E4LE6AQfINDzZ4agGW8fWWownxO5jjb2vc7Hxs3GuBqLSnozQbNHsGXzLBwq
         kPt489a/64zR7RvPXlYZHfzvnIcD0O97S0qbiqULhWQcaMHyTyoxGlyeskeP/3YjEUnU
         c7uUSptecymorhQHvLz4HdIL/rqzShiBlOymvDuaznLMdchwM7HLDW0giu/kL8xvuW0i
         Q82w==
X-Gm-Message-State: ABy/qLbo3X/ab6AVPfKW5u29vEFqQ8WnRN13EOj7WmxRWDCSvR3f8i7n
        GcPHzIrF1vWtD4a//K63j/kpCQ==
X-Google-Smtp-Source: APBJJlGGfLBbo66K53/3ZS8TbcpoVaZTjIVUfiH/F7Y+dKv2Lj3f3WSp3vu2SNgjZC8c/1bYee9OlQ==
X-Received: by 2002:a05:6808:ecc:b0:39e:b834:1859 with SMTP id q12-20020a0568080ecc00b0039eb8341859mr8622714oiv.29.1690148516185;
        Sun, 23 Jul 2023 14:41:56 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c1:6d75:166e:2197:2c44:331b? ([2804:7f1:e2c1:6d75:166e:2197:2c44:331b])
        by smtp.gmail.com with ESMTPSA id u43-20020a056808152b00b003a1eae6ff73sm3493688oiw.36.2023.07.23.14.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 14:41:55 -0700 (PDT)
Message-ID: <fe7cba2c-a0da-b1bd-1f0b-c6ecfa10de81@mojatatu.com>
Date:   Sun, 23 Jul 2023 18:41:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] net/sched: mqprio: Add length check for
 TCA_MQPRIO_{MAX/MIN}_RATE64
Content-Language: en-US
To:     Lin Ma <linma@zju.edu.cn>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230723075631.3712113-1-linma@zju.edu.cn>
From:   Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20230723075631.3712113-1-linma@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2023 04:56, Lin Ma wrote:
> The nla_for_each_nested parsing in function mqprio_parse_nlattr() does
> not check the length of the nested attribute. This can lead to an
> out-of-attribute read and allow a malformed nlattr (e.g., length 0) to
> be viewed as 8 byte integer and passed to priv->max_rate/min_rate.
> 
> This patch adds the check based on nla_len() when check the nla_type(),
> which ensures that the attribute has enough length.
> 
> Fixes: 4e8b86c06269 ("mqprio: Introduce new hardware offload mode and shaper in mqprio")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
>   net/sched/sch_mqprio.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
> index ab69ff7577fc..7bd1d261d8e7 100644
> --- a/net/sched/sch_mqprio.c
> +++ b/net/sched/sch_mqprio.c
> @@ -285,7 +285,8 @@ static int mqprio_parse_nlattr(struct Qdisc *sch, struct tc_mqprio_qopt *qopt,
>   		i = 0;
>   		nla_for_each_nested(attr, tb[TCA_MQPRIO_MIN_RATE64],
>   				    rem) {
> -			if (nla_type(attr) != TCA_MQPRIO_MIN_RATE64) {
> +			if (nla_type(attr) != TCA_MQPRIO_MIN_RATE64 ||
> +			    nla_len(attr) < sizeof(u64)) {

Shouldn't the check be nla_len(attr) != sizeof(u64)?
An attribute with a bigger length also seems to be invalid.

You could also separate this check into another if statement,
so that the error message is clearer in regards to why the attr is
invalid. Something like:

if (nla_len(attr) != sizeof(u64)) {
         NL_SET_ERR_MSG_ATTR_FMT(extack, attr,
                                 "Attribute length expected to be %lu",
                                 sizeof(u64));
         return -EINVAL;
}

>   				NL_SET_ERR_MSG_ATTR(extack, attr,
>   						    "Attribute type expected to be TCA_MQPRIO_MIN_RATE64");
>   				return -EINVAL;
> @@ -307,7 +308,8 @@ static int mqprio_parse_nlattr(struct Qdisc *sch, struct tc_mqprio_qopt *qopt,
>   		i = 0;
>   		nla_for_each_nested(attr, tb[TCA_MQPRIO_MAX_RATE64],
>   				    rem) {
> -			if (nla_type(attr) != TCA_MQPRIO_MAX_RATE64) {
> +			if (nla_type(attr) != TCA_MQPRIO_MAX_RATE64 ||
> +			    nla_len(attr) < sizeof(u64)) {

Same as the previous comment.

>   				NL_SET_ERR_MSG_ATTR(extack, attr,
>   						    "Attribute type expected to be TCA_MQPRIO_MAX_RATE64");
>   				return -EINVAL;

cheers,
Victor
