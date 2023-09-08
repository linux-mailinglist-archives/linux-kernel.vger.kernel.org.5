Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8223D798734
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 14:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbjIHMl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 08:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbjIHMlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:41:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2B519AB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 05:41:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31c6d17aec4so1929537f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 05:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694176910; x=1694781710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYbVbSjfXgkpf7yJkxmAIbzELrFKIsBKHyf6u4lRyms=;
        b=MVwCBnN5u1cq/3wWwFZT/0SHvCFMODJjmi24iNer6GA8i1kRX2qZrUW5ItjIS8JE8Q
         +v08BbUhQS39oERccQYEpLtRHaVgccx55+K5k81dPyN2hk57QsTq/2B84omveN+uGLyc
         pLu36kPz1Ysjsz93xSl6kfyaBsVLQsu7PnCjB3s5kZ1zR4j/AJKZzg+JgwFrJuRo3iAf
         dPCED9Q+wT7aD50rPC0RBYzLABtF3iDQYPXAKQxPDfbMcGNf5MdMGvOu17m2anjOAQqM
         ZWh6BqJKnOeZqGGo0/oDQzCCyJqtlMrO9cGkzKbaLjAnAbNHHy0Gkmg0Zuc5931dOKEi
         zuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694176910; x=1694781710;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SYbVbSjfXgkpf7yJkxmAIbzELrFKIsBKHyf6u4lRyms=;
        b=lPNv6i+abMnjso2lPN1M6JJZ/AaEo0otJLb4NQ90DF7u0I/o1F+/NVRTjZvBjLB3Kt
         aAXuJEL6B1xzd9kfd91ZJwFQtjbjWYkkhdm7Nw2xpqonoUp+gs/cELEg5uhrN/jNlBgi
         wUBlMv9mtl+rYIabz2S3jb0ikujm7nVHa5oOTZCBquE20EEc7w+u7noO2R7tUoxU7ELF
         ceKCwYe4hziuwbBtQ8PF7a3NVELbtmg1K/NTd+nDgB5BWbToskNRK5HX4ykwOBqRmmKG
         6IdYRZBCbkM790+vyuNakf+bauxpxzX2qD5NdNFUG+Jrg/vWvuQUI19OJyWbJsY2szJE
         tbxw==
X-Gm-Message-State: AOJu0YzPDLYgmnhY9yP5TMz+U0YpRlpbsAJrs2M6OFSC+jxpnVRVrkIL
        U6fVcn6quS0NYrh8d3X/+jLC7w==
X-Google-Smtp-Source: AGHT+IFcD5sRcgndbFlYk7K0tikRKDSmEAuT4GWiMUf+A87UYfKZ5sw/KGPGYEo+I7WGou7kv2q9wQ==
X-Received: by 2002:adf:efc7:0:b0:317:393f:6e6a with SMTP id i7-20020adfefc7000000b00317393f6e6amr1832671wrp.59.1694176909835;
        Fri, 08 Sep 2023 05:41:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5f1a:ed04:d131:cda4? ([2a01:e0a:982:cbb0:5f1a:ed04:d131:cda4])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b0031c6581d55esm1988726wrp.91.2023.09.08.05.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 05:41:49 -0700 (PDT)
Message-ID: <a020e7a9-d91a-4a15-86ef-fdb05c78ae3f@linaro.org>
Date:   Fri, 8 Sep 2023 14:41:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] drivers: meson: sm: correct meson_sm_* API retval
 handling
Content-Language: en-US, fr
To:     Alexey Romanov <avromanov@salutedevices.com>, khilman@baylibre.com,
        jbrunet@baylibre.com, miles.chen@mediatek.com,
        martin.blumenstingl@googlemail.com, narmstrong@baylibre.com
Cc:     kernel@sberdevices.ru, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230830140850.17130-1-avromanov@salutedevices.com>
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
In-Reply-To: <20230830140850.17130-1-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 16:08, Alexey Romanov wrote:
> 1. Following the ARM SMC32 calling convention, the return value
> from secure monitor is a 32-bit signed integer. This patch changes
> the type of the return value of the function meson_sm_call().
> 
> 2. Now, when meson_sm_call() returns a 32-bit signed integer, we need
> to ensure that this value is not negative. It is important to check
> that the return value is not negative in both the meson_sm_call_read()
> and meson_sm_call_write() functions.
> 
> 3. Add a comment explaining why it is necessary to check if the SMC
> return value is equal to 0 in the function meson_sm_call_read().
> It is not obvious when reading this code.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/firmware/meson/meson_sm.c       | 20 +++++++++++++-------
>   include/linux/firmware/meson/meson_sm.h |  2 +-
>   2 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
> index 798bcdb05d84..27a8cd4747f8 100644
> --- a/drivers/firmware/meson/meson_sm.c
> +++ b/drivers/firmware/meson/meson_sm.c
> @@ -67,7 +67,7 @@ static u32 meson_sm_get_cmd(const struct meson_sm_chip *chip,
>   	return cmd->smc_id;
>   }
>   
> -static u32 __meson_sm_call(u32 cmd, u32 arg0, u32 arg1, u32 arg2,
> +static s32 __meson_sm_call(u32 cmd, u32 arg0, u32 arg1, u32 arg2,
>   			   u32 arg3, u32 arg4)
>   {
>   	struct arm_smccc_res res;
> @@ -102,9 +102,10 @@ static void __iomem *meson_sm_map_shmem(u32 cmd_shmem, unsigned int size)
>    * Return:	0 on success, a negative value on error
>    */
>   int meson_sm_call(struct meson_sm_firmware *fw, unsigned int cmd_index,
> -		  u32 *ret, u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4)
> +		  s32 *ret, u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4)
>   {
> -	u32 cmd, lret;
> +	u32 cmd;
> +	s32 lret;
>   
>   	if (!fw->chip)
>   		return -ENOENT;
> @@ -143,7 +144,7 @@ int meson_sm_call_read(struct meson_sm_firmware *fw, void *buffer,
>   		       unsigned int bsize, unsigned int cmd_index, u32 arg0,
>   		       u32 arg1, u32 arg2, u32 arg3, u32 arg4)
>   {
> -	u32 size;
> +	s32 size;
>   	int ret;
>   
>   	if (!fw->chip)
> @@ -158,11 +159,16 @@ int meson_sm_call_read(struct meson_sm_firmware *fw, void *buffer,
>   	if (meson_sm_call(fw, cmd_index, &size, arg0, arg1, arg2, arg3, arg4) < 0)
>   		return -EINVAL;
>   
> -	if (size > bsize)
> +	if (size < 0 || size > bsize)
>   		return -EINVAL;
>   
>   	ret = size;
>   
> +	/* In some cases (for example GET_CHIP_ID command),
> +	 * SMC doesn't return the number of bytes read, even
> +	 * though the bytes were actually read into sm_shmem_out.
> +	 * So this check is needed.
> +	 */
>   	if (!size)
>   		size = bsize;
>   
> @@ -192,7 +198,7 @@ int meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
>   			unsigned int size, unsigned int cmd_index, u32 arg0,
>   			u32 arg1, u32 arg2, u32 arg3, u32 arg4)
>   {
> -	u32 written;
> +	s32 written;
>   
>   	if (!fw->chip)
>   		return -ENOENT;
> @@ -208,7 +214,7 @@ int meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
>   	if (meson_sm_call(fw, cmd_index, &written, arg0, arg1, arg2, arg3, arg4) < 0)
>   		return -EINVAL;
>   
> -	if (!written)
> +	if (written <= 0 || written > size)
>   		return -EINVAL;
>   
>   	return written;
> diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
> index 95b0da2326a9..8eaf8922ab02 100644
> --- a/include/linux/firmware/meson/meson_sm.h
> +++ b/include/linux/firmware/meson/meson_sm.h
> @@ -19,7 +19,7 @@ enum {
>   struct meson_sm_firmware;
>   
>   int meson_sm_call(struct meson_sm_firmware *fw, unsigned int cmd_index,
> -		  u32 *ret, u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4);
> +		  s32 *ret, u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4);
>   int meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
>   			unsigned int b_size, unsigned int cmd_index, u32 arg0,
>   			u32 arg1, u32 arg2, u32 arg3, u32 arg4);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
