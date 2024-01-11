Return-Path: <linux-kernel+bounces-23214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F6382A908
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F98A289354
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3195EAD9;
	Thu, 11 Jan 2024 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQb58Du0"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997FBE55F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e5451c13aso21658105e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 00:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704961305; x=1705566105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+INtuCzXZMB5vPoBtDF4HGWZCz4QqAdQc9inSH6V3I=;
        b=qQb58Du0Wj8Q8giyu+BPdZTKvJaSRejOzDYezEyGnU2yMU06DMNUGQNxjyAF40URH+
         rKazTVUi3wyafvCQvq3fzcBc2YuGvVmXPtip1j7cWXM1+kFAUN9jQ2muHqtB/3FCyYdU
         QSUilQAbGSFwvcp5E8B935qz7YpajDbk3aObLV4ECP7S8ofTHob3P/HBGpOxfSJ/yFPc
         BCPs+im+5PX4DhyktIEDMZMsDrYp3OLOC4oR7J3hHXaT8aJ00bNIHAo32Bc2p3qRu6g1
         ooPqDqdiCnnukALOfY68aQAHHLGnBrZtEbAsHaW8iogJ9IANrnzWzf+4KQR7mG10vn4s
         nh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704961305; x=1705566105;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g+INtuCzXZMB5vPoBtDF4HGWZCz4QqAdQc9inSH6V3I=;
        b=KXU/ZZmdcWlFV9L4IzLnVqssXa2pEn4vWVT1atiV4w3rIacWcyqm0Oq7cixqouGHlF
         P2mYYF6wgdSUV/67/GyUmY6b/8X6yB1D4mh9KfZcz5DUn9w1FkpspjVIisum/12cOY1i
         7eDxTEsRKoZxidoc/DClyWOopRlpMloD0yNtor2QWSYMrvkNMhurGFKcX2g4i1u6tn0h
         RKdzpCyauS/gs5a4ogPxY02tj0K+sfaY3SVHIk+HGEq77uKZ3EUConyLKPmO3yjKkcNY
         PNWX7Ir57La1pfpIVR99ldtXzMKmoA6PLqBLCAntAO7t3Lr2+xjzH8cbECq7pa/Iqu+L
         xINA==
X-Gm-Message-State: AOJu0YzRxhxkBVnvSGs5hxEaeP1Frtnoo4lKud97JMFu7gy2X3yTckH6
	FQdJdsAUMbJbAHIdTu+NJre5SVYIFJWs3w==
X-Google-Smtp-Source: AGHT+IGKYSJFYYftTbEsXewabF8ly7Uq9Hr2T4UxRu3h0Kf1/AGZ26ERGkOmIN6op9zO12N2BBHMwA==
X-Received: by 2002:a05:600c:3108:b0:40e:5ebb:6af6 with SMTP id g8-20020a05600c310800b0040e5ebb6af6mr126557wmo.245.1704961304836;
        Thu, 11 Jan 2024 00:21:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a5aa:e466:ae57:5a26? ([2a01:e0a:982:cbb0:a5aa:e466:ae57:5a26])
        by smtp.gmail.com with ESMTPSA id j27-20020adfb31b000000b00336e32338f3sm550474wrd.70.2024.01.11.00.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 00:21:44 -0800 (PST)
Message-ID: <1a3b5004-751a-4479-be89-97265ca63d92@linaro.org>
Date: Thu, 11 Jan 2024 09:21:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 01/24] drivers: crypto: meson: don't hardcode IRQ count
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com,
 clabbe@baylibre.com, herbert@gondor.apana.org.au, davem@davemloft.net,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 khilman@baylibre.com, jbrunet@baylibre.com, artin.blumenstingl@googlemail.com
Cc: linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@salutedevices.com,
 Jan Dakinevich <yvdakinevich@salutedevices.com>
References: <20240110201216.18016-1-avromanov@salutedevices.com>
 <20240110201216.18016-2-avromanov@salutedevices.com>
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
In-Reply-To: <20240110201216.18016-2-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/01/2024 21:11, Alexey Romanov wrote:
> IRQ count is no longer hardcoded, and make it part of
> struct meson_flow. We need this for extend driver support for
> other Amlogic SoC's.

In this case you must make the interrupts maxItems lower for the new platforms in the bindings.

Neil

> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> Signed-off-by: Jan Dakinevich <yvdakinevich@salutedevices.com>
> ---
>   drivers/crypto/amlogic/amlogic-gxl-cipher.c |  2 +-
>   drivers/crypto/amlogic/amlogic-gxl-core.c   | 47 ++++++++++++---------
>   drivers/crypto/amlogic/amlogic-gxl.h        |  8 ++--
>   3 files changed, 31 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> index af017a087ebf..e01ed6347c3d 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> @@ -19,7 +19,7 @@
>   
>   static int get_engine_number(struct meson_dev *mc)
>   {
> -	return atomic_inc_return(&mc->flow) % MAXFLOW;
> +	return atomic_inc_return(&mc->flow) % mc->flow_cnt;
>   }
>   
>   static bool meson_cipher_need_fallback(struct skcipher_request *areq)
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
> index 937187027ad5..a5df061f9890 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-core.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
> @@ -26,8 +26,8 @@ static irqreturn_t meson_irq_handler(int irq, void *data)
>   	int flow;
>   	u32 p;
>   
> -	for (flow = 0; flow < MAXFLOW; flow++) {
> -		if (mc->irqs[flow] == irq) {
> +	for (flow = 0; flow < mc->flow_cnt; flow++) {
> +		if (mc->chanlist[flow].irq == irq) {
>   			p = readl(mc->base + ((0x04 + flow) << 2));
>   			if (p) {
>   				writel_relaxed(0xF, mc->base + ((0x4 + flow) << 2));
> @@ -103,7 +103,7 @@ static int meson_debugfs_show(struct seq_file *seq, void *v)
>   	struct meson_dev *mc = seq->private;
>   	int i;
>   
> -	for (i = 0; i < MAXFLOW; i++)
> +	for (i = 0; i < mc->flow_cnt; i++)
>   		seq_printf(seq, "Channel %d: nreq %lu\n", i, mc->chanlist[i].stat_req);
>   
>   	for (i = 0; i < ARRAY_SIZE(mc_algs); i++) {
> @@ -138,14 +138,32 @@ static void meson_free_chanlist(struct meson_dev *mc, int i)
>    */
>   static int meson_allocate_chanlist(struct meson_dev *mc)
>   {
> +	struct platform_device *pdev = to_platform_device(mc->dev);
>   	int i, err;
>   
> -	mc->chanlist = devm_kcalloc(mc->dev, MAXFLOW,
> +	mc->flow_cnt = platform_irq_count(pdev);
> +	if (mc->flow_cnt <= 0) {
> +		dev_err(mc->dev, "No IRQs defined\n");
> +		return -ENODEV;
> +	}
> +
> +	mc->chanlist = devm_kcalloc(mc->dev, mc->flow_cnt,
>   				    sizeof(struct meson_flow), GFP_KERNEL);
>   	if (!mc->chanlist)
>   		return -ENOMEM;
>   
> -	for (i = 0; i < MAXFLOW; i++) {
> +	for (i = 0; i < mc->flow_cnt; i++) {
> +		mc->chanlist[i].irq = platform_get_irq(pdev, i);
> +		if (mc->chanlist[i].irq < 0)
> +			return mc->chanlist[i].irq;
> +
> +		err = devm_request_irq(mc->dev, mc->chanlist[i].irq,
> +				       meson_irq_handler, 0, "aml-crypto", mc);
> +		if (err < 0) {
> +			dev_err(mc->dev, "Cannot request IRQ for flow %d\n", i);
> +			return err;
> +		}
> +
>   		init_completion(&mc->chanlist[i].complete);
>   
>   		mc->chanlist[i].engine = crypto_engine_alloc_init(mc->dev, true);
> @@ -215,7 +233,7 @@ static void meson_unregister_algs(struct meson_dev *mc)
>   static int meson_crypto_probe(struct platform_device *pdev)
>   {
>   	struct meson_dev *mc;
> -	int err, i;
> +	int err;
>   
>   	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
>   	if (!mc)
> @@ -237,19 +255,6 @@ static int meson_crypto_probe(struct platform_device *pdev)
>   		return err;
>   	}
>   
> -	for (i = 0; i < MAXFLOW; i++) {
> -		mc->irqs[i] = platform_get_irq(pdev, i);
> -		if (mc->irqs[i] < 0)
> -			return mc->irqs[i];
> -
> -		err = devm_request_irq(&pdev->dev, mc->irqs[i], meson_irq_handler, 0,
> -				       "gxl-crypto", mc);
> -		if (err < 0) {
> -			dev_err(mc->dev, "Cannot request IRQ for flow %d\n", i);
> -			return err;
> -		}
> -	}
> -
>   	err = clk_prepare_enable(mc->busclk);
>   	if (err != 0) {
>   		dev_err(&pdev->dev, "Cannot prepare_enable busclk\n");
> @@ -273,7 +278,7 @@ static int meson_crypto_probe(struct platform_device *pdev)
>   error_alg:
>   	meson_unregister_algs(mc);
>   error_flow:
> -	meson_free_chanlist(mc, MAXFLOW - 1);
> +	meson_free_chanlist(mc, mc->flow_cnt - 1);
>   	clk_disable_unprepare(mc->busclk);
>   	return err;
>   }
> @@ -288,7 +293,7 @@ static int meson_crypto_remove(struct platform_device *pdev)
>   
>   	meson_unregister_algs(mc);
>   
> -	meson_free_chanlist(mc, MAXFLOW - 1);
> +	meson_free_chanlist(mc, mc->flow_cnt - 1);
>   
>   	clk_disable_unprepare(mc->busclk);
>   	return 0;
> diff --git a/drivers/crypto/amlogic/amlogic-gxl.h b/drivers/crypto/amlogic/amlogic-gxl.h
> index 8c0746a1d6d4..e5cc6e028fa8 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl.h
> +++ b/drivers/crypto/amlogic/amlogic-gxl.h
> @@ -22,8 +22,6 @@
>   #define MESON_OPMODE_ECB 0
>   #define MESON_OPMODE_CBC 1
>   
> -#define MAXFLOW 2
> -
>   #define MAXDESC 64
>   
>   #define DESC_LAST BIT(18)
> @@ -62,6 +60,7 @@ struct meson_desc {
>    * @keylen:	keylen for this flow operation
>    * @complete:	completion for the current task on this flow
>    * @status:	set to 1 by interrupt if task is done
> + * @irq:	IRQ number for amlogic-crypto
>    * @t_phy:	Physical address of task
>    * @tl:		pointer to the current ce_task for this flow
>    * @stat_req:	number of request done by this flow
> @@ -70,6 +69,7 @@ struct meson_flow {
>   	struct crypto_engine *engine;
>   	struct completion complete;
>   	int status;
> +	int irq;
>   	unsigned int keylen;
>   	dma_addr_t t_phy;
>   	struct meson_desc *tl;
> @@ -85,7 +85,7 @@ struct meson_flow {
>    * @dev:	the platform device
>    * @chanlist:	array of all flow
>    * @flow:	flow to use in next request
> - * @irqs:	IRQ numbers for amlogic-crypto
> + * @flow_cnt:	flow count for amlogic-crypto
>    * @dbgfs_dir:	Debugfs dentry for statistic directory
>    * @dbgfs_stats: Debugfs dentry for statistic counters
>    */
> @@ -95,7 +95,7 @@ struct meson_dev {
>   	struct device *dev;
>   	struct meson_flow *chanlist;
>   	atomic_t flow;
> -	int irqs[MAXFLOW];
> +	int flow_cnt;
>   #ifdef CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG
>   	struct dentry *dbgfs_dir;
>   #endif


