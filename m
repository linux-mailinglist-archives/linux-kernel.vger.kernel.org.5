Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAB576345B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbjGZK4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbjGZKz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:55:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F71113D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:55:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso55844705e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690368955; x=1690973755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iegk/2TKL5Rj456XBjxdhlF2YFlmLFdSyPtT2uk62mo=;
        b=CW3jL5pMUrmOUizoS1E9Hcsvtp4BD/g7xIZqvjeEkiUm4QBhFwTSenULu7s0INr9iJ
         zQysgQPFzzAVrqets21G+KcdMXNDWvaj9TwVMnDuA/v4sGB1JgcKYEF4cErb4lNceJ+2
         YVE6eDM18TkSiSu4iJfWA/Ku+F+wohEkxQgbqJuieY0qLQv1e8ZYLf/FY/BaKem8B936
         PdG2Z39Rxp+xEfrzkebV4lh0v083vpRRmnFRTIW+Kyfr+rB3xFJLS1yHpobQYxZbtkhC
         rywe5ncdgxjclxQMKOK0X5tJhU/o+KgtRF2F4GQhNwTe3EUKY1Gt4rriLeBpkloQS8X/
         wCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690368955; x=1690973755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iegk/2TKL5Rj456XBjxdhlF2YFlmLFdSyPtT2uk62mo=;
        b=HCcbLOTi2MhWPTtADWww5oRfezXNldyqvnUn7a+GmhHah8idTWealudtWzUaNwAesH
         Jmj6jpgxOXuOB29YkmtiXoLtbFv07pXU2P7AemHnJccHu3TIhkJn052HqG4i2i66kPeJ
         ORmpN4/tLPclI9ZE2QsE5hWZSoqw1dS+/BqyXJT7xC23E5+dUZMEXZdYnlpObU0A3BeS
         Fjo79NSnftB7v3xDy1kHb4nzJhT0mVBPq+4y/wJb3Bt/vDTxJeakHJIAjrBLcIfIKwpg
         +DXc1ZVqePKinDMhVc0d2H+N6h9mClxWblIBBN4g580iyMkEjdNv1snRIH2JqInso3V4
         bN5g==
X-Gm-Message-State: ABy/qLYsVAWTK8+dO0CQByZ9MKbFvx+spTNDhFLR24scad48f2QrvhuQ
        9nCVGUHuxny8WzUSuMaxOL74rg==
X-Google-Smtp-Source: APBJJlG6UyprMnFMQm4Ei76lg009+z+sJ9pxlVFtN/IZb2oMNBA6ouM38riQicLc05GMonaqkYMTWw==
X-Received: by 2002:a5d:558e:0:b0:313:e9f6:3378 with SMTP id i14-20020a5d558e000000b00313e9f63378mr1003950wrv.4.1690368955338;
        Wed, 26 Jul 2023 03:55:55 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o26-20020a5d58da000000b0030ae499da59sm19353583wrf.111.2023.07.26.03.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 03:55:54 -0700 (PDT)
Message-ID: <eb8ff364-1c49-28b4-242d-168828ca7094@linaro.org>
Date:   Wed, 26 Jul 2023 11:55:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 3/6] media: starfive: camss: Add basic driver
Content-Language: en-US
To:     Jack Zhu <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, changhuang.liang@starfivetech.com
References: <20230619112838.19797-1-jack.zhu@starfivetech.com>
 <20230619112838.19797-4-jack.zhu@starfivetech.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230619112838.19797-4-jack.zhu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2023 12:28, Jack Zhu wrote:

> +static int stfcamss_of_parse_ports(struct stfcamss *stfcamss)
> +{
> +	struct device *dev = stfcamss->dev;
> +	struct device_node *node = NULL;
> +	int ret, num_subdevs = 0;
> +
> +	for_each_endpoint_of_node(dev->of_node, node) {
> +		struct stfcamss_async_subdev *csd;
> +
> +		if (!of_device_is_available(node))
> +			continue;
> +
> +		csd = v4l2_async_nf_add_fwnode_remote(&stfcamss->notifier,
> +						      of_fwnode_handle(node),
> +						      struct stfcamss_async_subdev);
> +		if (IS_ERR(csd)) {
> +			ret = PTR_ERR(csd);
> +			goto err_cleanup;
> +		}
> +
> +		ret = stfcamss_of_parse_endpoint_node(dev, node, csd);
> +		if (ret < 0)
> +			goto err_cleanup;
> +
> +		num_subdevs++;
> +	}
> +
> +	return num_subdevs;
> +
> +err_cleanup:
> +	of_node_put(node);

Where is the _get() for this and if you are releasing it on the error 
path when is the _get() released on the non-error path ?

> +	return ret;
> +}
> +
> +static int stfcamss_subdev_notifier_bound(struct v4l2_async_notifier *async,
> +					  struct v4l2_subdev *subdev,
> +					  struct v4l2_async_subdev *asd)
> +{
> +	struct media_pad *pad[STF_PADS_NUM];
> +	unsigned int i, pad_num = 0;
> +
> +	for (i = 0; i < pad_num; ++i) {

Does this loop ever run ?
I don't see how it can..

---
bod
