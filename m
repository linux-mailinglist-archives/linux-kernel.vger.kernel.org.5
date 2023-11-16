Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466A77EE29D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344612AbjKPOU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbjKPOU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:20:28 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDE7B7;
        Thu, 16 Nov 2023 06:20:24 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 91DA5660734A;
        Thu, 16 Nov 2023 14:20:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700144423;
        bh=ZMRVAirW+Pu2sFESR0obPaFqwe7OSdUCQUq2ssj/2yQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JObB02V8WU+UpDz1JIJ+vhbd6xHmLx0ZPw2KUzl5TrGm0RAYNe68af6NSnnD7a9KJ
         YCfJgZIY/QWfYWIWt5gwHUvHYqahT3DDvbQ/o7P9st16hj8OfMHeJ43ZMJ4+sLYeuQ
         JvPdbfPuF4xbudSvACvRzXnvjYPMMSQpj+VO8XzUTQb48IDpIBB3Pn2K+bshuOfXaP
         eoUx9X9BbUF2ZfDATL3R6FyYpJAk/AqTNcZVNMzC4rBgtsRiJimpfFfNr6JyjrW9Fh
         4NVtvIi3K1odj6+qXlDQZ0qFfvVRjc2yAcJggUf9iwNMj4LkiIGPgmRxf+RybYUfsM
         U9zME0yMW3Dxw==
Message-ID: <4118d15a-a70c-457d-8f62-d4f61f1157de@collabora.com>
Date:   Thu, 16 Nov 2023 15:20:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: idle exit_latency overflow
Content-Language: en-US
To:     Bo Ye <bo.ye@mediatek.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     yongdong.zhang@mediatek.com, mtk24676 <C.Cheng@mediatek.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231116132619.69500-1-bo.ye@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231116132619.69500-1-bo.ye@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/11/23 14:26, Bo Ye ha scritto:
> From: mtk24676 <C.Cheng@mediatek.com>
> 
> In detail:
> In kernel-6.1, in the __cpuidle_driver_init function in
> driver/cpuidle/driver.c, there is a line of code that causes
> an overflow. The line is s->exit_latency_ns = s->exit_latency
> * NSEC_PER_USEC. The overflow occurs because the product of an
> int type and a constant exceeds the range of the int type.
> 
> In C language, when you perform a multiplication operation, if
> both operands are of int type, the multiplication operation is
> performed on the int type, and then the result is converted to
> the target type. This means that if the product of int type
> multiplication exceeds the range that int type can represent,
> an overflow will occur even if you store the result in a
> variable of int64_t type.
> 
> Signed-off-by: mtk24676 <C.Cheng@mediatek.com>

It all makes sense, but "mtk24676" is not the name of a person, what's going on?

> Signed-off-by: bo.ye <bo.ye@mediatek.com>

That's the same, you perhaps wanted to write "Bo Ye", not "bo.ye".

Regards,
Angelo

> ---
> 
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index d9cda7f..631ca16 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -187,7 +187,7 @@
>   			s->target_residency = div_u64(s->target_residency_ns, NSEC_PER_USEC);
>   
>   		if (s->exit_latency > 0)
> -			s->exit_latency_ns = s->exit_latency * NSEC_PER_USEC;
> +			s->exit_latency_ns = (u64)s->exit_latency * NSEC_PER_USEC;
>   		else if (s->exit_latency_ns < 0)
>   			s->exit_latency_ns =  0;
>   		else

