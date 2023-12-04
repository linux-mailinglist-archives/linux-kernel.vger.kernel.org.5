Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8513802E71
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjLDJWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjLDJWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:22:22 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578BBC3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:22:28 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c09f4814eso12239175e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1701681747; x=1702286547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nr4Vt64RYXhRYcPjjM40iMIdhnoStkhytq2aXTjQ4Bk=;
        b=YFAyG4e+JoYvfq87anD5wXI7MDNUP1o5iCo8B9zjwfyqYxyRbtAxsOoeOYNmdBCR47
         luQyyn9OQjL4Y/C/RdMNlqx8X+ZWEZQDcZzJmZ5NkFu8PgzA1YeVGM2jRD1ETBuijqcU
         lVsvRatKBYPL+uak+1G1CmIIwtZjLzurLUtP/2DJnp3u3m1zm9O2taYEjER3CWfLc4WF
         +g0F9rhgdC6RpvodY2gmW9yb9Jg7+vVd52fmtt+KCx9A4LT7sDtE3twba8g/VB7ifK1U
         vNcBebaHZhrMDidK4xkymw5tUkCu0GLRMS2WkHsf0McrxfE8N/AYsvXMMxS7kkKccIja
         CbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701681747; x=1702286547;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nr4Vt64RYXhRYcPjjM40iMIdhnoStkhytq2aXTjQ4Bk=;
        b=Ukf5YNqT7jIs/IsOpEfCuYJUOR/6VcOdP4UZtwxishaqGi+7D27jwHHLyG+kcbeX/y
         jC6YeyTw/OPqnmDWRwJ1vZTsc4jmETmSBuwpfEPhppus3p1EjUCOJeBFw8SmtmoeWebj
         XZaW8/df5dwLpad1dKjSDRebGFmCRWo2YBYhRxEYeK2D6uRPI24t7rGaj7R7YzPGqNgo
         XWXiyajURqsaQf5I0ifCDJbnu44jLL2dgWnwMQuMtXc62AnQveVcRwcNv297azQ7AIwM
         TT1fyygMKJ/TrKl5UjoMk9veU85O0chSsGnp5Ul1HjtuRUb7TCXckAgcQQLOBolob69v
         O3WA==
X-Gm-Message-State: AOJu0YxIPYGE25xkC9saWRosO3KANqWzmWSSWJSRQjjjPF92Cx3ijBWT
        3SwQc+aVxAnRuP1htaz42qiQfg==
X-Google-Smtp-Source: AGHT+IHc8ghBLDwEQZ9LHRTaRvJqKyyww6iDAhCA/KMKVHZLs237HfM1H6xRzFz1GtBS6dSD0eG9aw==
X-Received: by 2002:a05:600c:acd:b0:40b:38a8:6c65 with SMTP id c13-20020a05600c0acd00b0040b38a86c65mr1664855wmr.26.1701681746784;
        Mon, 04 Dec 2023 01:22:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:6cba:8826:daed:6772? ([2a01:e0a:b41:c160:6cba:8826:daed:6772])
        by smtp.gmail.com with ESMTPSA id bg24-20020a05600c3c9800b0040b3d33ab55sm18093140wmb.47.2023.12.04.01.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 01:22:26 -0800 (PST)
Message-ID: <95924d9e-b373-40fd-993c-25b0bae55e61@6wind.com>
Date:   Mon, 4 Dec 2023 10:22:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v2] netlink: Return unsigned value for nla_len()
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Michael Walle <mwalle@kernel.org>,
        Max Schulze <max.schulze@online.de>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20231202202539.it.704-kees@kernel.org>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20231202202539.it.704-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 02/12/2023 à 21:25, Kees Cook a écrit :
> The return value from nla_len() is never expected to be negative, and can
> never be more than struct nlattr::nla_len (a u16). Adjust the prototype
> on the function. This will let GCC's value range optimization passes
> know that the return can never be negative, and can never be larger than
> u16. As recently discussed[1], this silences the following warning in
> GCC 12+:
> 
> net/wireless/nl80211.c: In function 'nl80211_set_cqm_rssi.isra':
> net/wireless/nl80211.c:12892:17: warning: 'memcpy' specified bound 18446744073709551615 exceeds maximum object size 9223372036854775807 [-Wstringop-overflow=]
> 12892 |                 memcpy(cqm_config->rssi_thresholds, thresholds,
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 12893 |                        flex_array_size(cqm_config, rssi_thresholds,
>       |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 12894 |                                        n_thresholds));
>       |                                        ~~~~~~~~~~~~~~
> 
> A future change would be to clamp the subtraction to make sure it never
> wraps around if nla_len is somehow less than NLA_HDRLEN, which would
> have the additional benefit of being defensive in the face of nlattr
> corruption or logic errors.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311090752.hWcJWAHL-lkp@intel.com/ [1]
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
> Cc: Michael Walle <mwalle@kernel.org>
> Cc: Max Schulze <max.schulze@online.de>
> Cc: netdev@vger.kernel.org
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  v2:
>  - do not clamp return value (kuba)
>  - adjust NLA_HDRLEN to be u16 also
>  v1: https://lore.kernel.org/all/20231130200058.work.520-kees@kernel.org/
> ---
>  include/net/netlink.h        | 2 +-
>  include/uapi/linux/netlink.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/netlink.h b/include/net/netlink.h
> index 83bdf787aeee..7678a596a86b 100644
> --- a/include/net/netlink.h
> +++ b/include/net/netlink.h
> @@ -1200,7 +1200,7 @@ static inline void *nla_data(const struct nlattr *nla)
>   * nla_len - length of payload
>   * @nla: netlink attribute
>   */
> -static inline int nla_len(const struct nlattr *nla)
> +static inline u16 nla_len(const struct nlattr *nla)
>  {
>  	return nla->nla_len - NLA_HDRLEN;
>  }
> diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
> index f87aaf28a649..270feed9fd63 100644
> --- a/include/uapi/linux/netlink.h
> +++ b/include/uapi/linux/netlink.h
> @@ -247,7 +247,7 @@ struct nlattr {
>  
>  #define NLA_ALIGNTO		4
>  #define NLA_ALIGN(len)		(((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
> -#define NLA_HDRLEN		((int) NLA_ALIGN(sizeof(struct nlattr)))
> +#define NLA_HDRLEN		((__u16) NLA_ALIGN(sizeof(struct nlattr)))
I wonder if this may break the compilation of some userspace tools with errors
like comparing signed and unsigned values.


Regards,
Nicolas
