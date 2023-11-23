Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6987F5CE1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344829AbjKWKu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344819AbjKWKuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:50:20 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFA11B2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:50:24 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-548f35e6a4bso1025845a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700736623; x=1701341423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OWmsEY1Lz0iuLAhKZp25wl97iTeJOnsV2iHbTLKdd7A=;
        b=wOEoa3ftwf0/QNhrOjF+Lr2PWC16AByfxoW6U+BRRovXRjxIMP/5bBrRoLLV2uyI57
         EZtzFLZxfMAS8BlXt7ql6ID22qIiTpD+xL0/IizinUusG4K53CKeanp+2uFQDj6jk+6V
         rnl6iCPKJA/26WbKixGLyAG6kVK21y+3b5fXUc5ACu0vlXIRELb3gmS7UMj8CNJ2pBPm
         vodSKoG9ON3izOSsmKRRjg7koK4hDC5gqV9quIFrLZoPLbGZSwlguNSeNQrbMmix0c3X
         AImZ6/pin6ZbcO9QBhUNFnmjM/NiR0hf91XzUs4R0JX7BCxcOpyiBH4xbknsFveQtTzg
         NBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700736623; x=1701341423;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWmsEY1Lz0iuLAhKZp25wl97iTeJOnsV2iHbTLKdd7A=;
        b=Z/qwIrAULKUCe/8dwazovp9gftp4zF35eD4EdAUyz2dl2YoTGBFbPpvk6tKv3YtIQh
         XdN455xsO/ND88KTJ5hfRyVXfehYLvcs3vjxh6irrWrl3OX/Fawtq7EX8aCuIGnZfSbw
         Ahbh3uyzS78A0H2pTjQudzn0JhqCRtedKp9neLvIiReCW4Al38J8oKjVVMjQwD3d7rTx
         JT9cYTiAHqZQkDHDVvblqQqObtiPhNXR17OStle3NJrFHXu+9J65ki+Qa8kq4SMR12L8
         UjjozKVmhGAFNeN3ljctK46S0VHL4BZ0X/Ye30HVLBeXcmsp7I4/l53CzBI65Z+l6hu1
         W9HA==
X-Gm-Message-State: AOJu0YwRvGCEalEOueG/hFVmG9ZCAtextdsZW+PZXO52dI5ELBFArW/q
        51sj+v/2g1svO9QdIVSeTU3sjg==
X-Google-Smtp-Source: AGHT+IEraM1i8wpahcqSKpNjXQf1ubzx9722VwGXlJdd0hjgZjfDv9ahWVogiErf9rtLA+YfTT4uCA==
X-Received: by 2002:a17:907:d046:b0:9b2:6d09:847c with SMTP id vb6-20020a170907d04600b009b26d09847cmr4337532ejc.10.1700736623254;
        Thu, 23 Nov 2023 02:50:23 -0800 (PST)
Received: from [192.168.86.103] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id j27-20020a170906255b00b009e5db336137sm619208ejb.196.2023.11.23.02.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 02:50:22 -0800 (PST)
Message-ID: <11e09282-186b-43bd-b7ef-a179a4fe8f03@linaro.org>
Date:   Thu, 23 Nov 2023 10:50:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] soundwire: bus: introduce controller_id
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
References: <20231017160933.12624-1-pierre-louis.bossart@linux.intel.com>
 <20231017160933.12624-2-pierre-louis.bossart@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231017160933.12624-2-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pierre for the patch,

On 17/10/2023 17:09, Pierre-Louis Bossart wrote:
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 55be9f4b8d59..e3ae4e4e07ac 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -1612,6 +1612,9 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> +	/* FIXME: is there a DT-defined value to use ? */
> +	ctrl->bus.controller_id = -1;
> +

We could do a better than this, on Qcom IP we have a dedicated register 
to provide a master id value. I will send a patch to add this change on 
top of this patchset.

--------------------------------->cut<-------------------------------
 From 78c516995d652324daadbe848fa787dabcede73f Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 23 Nov 2023 10:43:02 +0000
Subject: [PATCH] soundwire: qcom: set controller id to hw master id

Qualcomm Soundwire Controllers IP version after 1.3 have a dedicated
master id register which will provide a unique id value for each
controller instance. Use this value instead of artificially generated
value from idr. Versions 1.3 and below only have one instance of
soundwire controller which does no have this register, so let them use
value from idr.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
  drivers/soundwire/qcom.c | 6 +++++-
  1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 8e027eee8b73..48291fbaf674 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1624,9 +1624,13 @@ static int qcom_swrm_probe(struct platform_device 
*pdev)
  		}
  	}

-	/* FIXME: is there a DT-defined value to use ? */
  	ctrl->bus.controller_id = -1;

+	if (ctrl->version > SWRM_VERSION_1_3_0) {
+		ctrl->reg_read(ctrl, SWRM_COMP_MASTER_ID, &val);
+		ctrl->bus.controller_id = val;
+	}
+
  	ret = sdw_bus_master_add(&ctrl->bus, dev, dev->fwnode);
  	if (ret) {
  		dev_err(dev, "Failed to register Soundwire controller (%d)\n",
-- 
2.42.0
--------------------------------->cut<-------------------------------


thanks,
Srini
>   	ret = sdw_bus_master_add(&ctrl->bus, dev, dev->fwnode);
>   	if (ret) {
>   		dev_err(dev, "Failed to register Soundwire controller (%d)\n",
