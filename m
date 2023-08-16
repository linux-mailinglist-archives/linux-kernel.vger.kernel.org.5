Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3BE77DB88
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242506AbjHPIAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242630AbjHPH7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:59:55 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DB42690
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 00:59:52 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9cdbf682eso93856271fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 00:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692172791; x=1692777591;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+trWIdlrzpqniw9b5ygOEC/+6S3W3oWFAOX3CKxYQ8=;
        b=znZ4XxE+b16iEkyCx1xs5HCgx4VUI6h4qH4j7/7nV9Du3jSFLqNp5GrkYLSc/sC1ek
         oWboENGFyx5ncRJIDAGTLX54E8Ilrx+ONZQoCTcyQuDZWcITrvcPtfvY17Sc8oADWdEB
         Jw9V2xiXpb3cZuUX+MiygP6vX1OGhYdg6p35gIYtD6JQ7rzspsyGK2cUh3ae1fQlKF6A
         mu1QDmL1uTZU9BqWpv0+7rsBOFDwYnp/npcpyizhB2Ab6erH8+E/eC2Rh6Yg+X8TFwYi
         6HnUldC6qzdWy5NAXWYdCEeir0+nVKdkm24g9tKC1bf1fqgW6AI8HyRSErz+A7OHVQnA
         riYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692172791; x=1692777591;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R+trWIdlrzpqniw9b5ygOEC/+6S3W3oWFAOX3CKxYQ8=;
        b=MN41evZjLOG0hUFPCb5DfdtGOcwcLMsTT1yuU8Vupo+9u4wNTk1oU3piAOO0BObGbn
         4762Apn9wzHfsLBa6BqW0YDMBtN4KdAtYkqBgvgzUhkr4SAQJNAzQ5KmPMy+nvxaq61O
         yg3rrBU06RBdcY/Uu4h4iSOYnRBRi9cX8pKAdtQKBktxjZV7A4WzifcHIZxcQ32kO/Sc
         xwHZ9J+V5NvYngl3cVAupl9uK4t9+E8eRN670k8T0PiX4DP+/EigOelg9/L4OIFGp8W1
         +u35exUo32WUZdHVAQSubEE3EdewAiromvuohM60cLqXcn3D0t7lmPOuZIVQiGG6T3CB
         oFxw==
X-Gm-Message-State: AOJu0Yx455vn8e5+6jfawKnMFGh0M1GqF3ah5Zo7OcOK2DndHqOcpji7
        F2URnolr3NH0W9de+AqG6e9BpXSvKBXrKtcj3SubQg==
X-Google-Smtp-Source: AGHT+IE5jRJ8LzB8iTS4v9CCGNFjalN+bplijt9ZP8QfzALe7jbesl9Ju7o3DJqqq0Szk5HlF8uScA==
X-Received: by 2002:a2e:9085:0:b0:2b5:7a87:a85a with SMTP id l5-20020a2e9085000000b002b57a87a85amr856726ljg.13.1692172790668;
        Wed, 16 Aug 2023 00:59:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:60eb:1b42:890:194? ([2a01:e0a:982:cbb0:60eb:1b42:890:194])
        by smtp.gmail.com with ESMTPSA id g7-20020a7bc4c7000000b003fbdd5d0758sm20196401wmk.22.2023.08.16.00.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 00:59:50 -0700 (PDT)
Message-ID: <f8c7d1f4-a8fb-4b3d-9b3a-17eb7d1561b4@linaro.org>
Date:   Wed, 16 Aug 2023 09:59:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: linux-next: duplicate patch in the amlogic tree
Content-Language: en-US, fr
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kevin Hilman <khilman@baylibre.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230815113822.613b514b@canb.auug.org.au>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20230815113822.613b514b@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/08/2023 03:38, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the arm-soc tree as a different commit
> (but the same patch):
> 
>    b18226ffd080 ("firmware: meson_sm: fix to avoid potential NULL pointer dereference")
> 
> This is commit
> 
>    f2ed165619c1 ("firmware: meson_sm: fix to avoid potential NULL pointer dereference")
> 
> in the arm-soc tree.
> 

Sorry about that, it's now fixed in the amlogic for-next tree,

Thanks,
Neil
