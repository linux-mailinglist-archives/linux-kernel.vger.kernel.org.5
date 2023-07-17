Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C18756E73
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjGQUjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjGQUjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:39:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC56DE6F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:39:11 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-992acf67388so615886666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689626350; x=1692218350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gmNkfDah6O+uPw4Ib3W9slf1ycVoQFYR0H5sgdKTjwI=;
        b=Qe2A4+QegpFejdVnrN5POOEeWtjx8ab8C0UDC1TZ/2ISJ+fKzl8uf1A9x+LeQK3WR7
         s/LjpJUWuYe4u0IITKRiqrf8gojjrfn4ES9GmnFqrQtmWFG0wggg5aHuzV6QqfkMT4UY
         NrAaN3avPkOXX7iPde8eJkKI+W0QxIhj5v3TjH0/73Qkd0dS+jeZ9IKg5zgCjcOAcTfz
         Ht6HEmCWTU4eFRRxZOT4zXYUR8TRa6JBECdQ6JfDA2phRot1PQ4L411I+IlIkUnC7NXh
         qAl+CxwurmcfYZJskg2VFhtnJTWhpIqOOxXoDtG5SjbIySfI5fp3ZOihTFhpKXk7pbWg
         ylKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689626350; x=1692218350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmNkfDah6O+uPw4Ib3W9slf1ycVoQFYR0H5sgdKTjwI=;
        b=FqKmgIcB2GIkUIO9kvSC1T1XljM43Mc5kqBCKXhJFeozLNXyin2W1O5LmqbCT0j9V6
         6fMfX3RNhe+TAPdw/U2AkxthKXBizeLgG7Ob3keJ0SKpq2POidOEw+6g5mAG2lSF/TjY
         vWktHKay4Hs5YtgbZOjsjgyQixRSGGjGAwjOdrCSZLdlAhROqjGYeJ8OqZ0nYI+g/j2G
         zBEa4Dg9gI46wUcLZ8cLtbiJPKIro2ebhLJwCXb6FT+8rWfWRhkDNH9Dt+E7FIM41LwP
         OnsnXO2qAVzzQrCnzt/kxNBSYDmmzOvN/TYp+s0UBVulHV4xraNbOl81G3TDLqmOPQse
         +yYA==
X-Gm-Message-State: ABy/qLa549hsHg+sWY4QCl0NZhM0PjIZyvl0YJWsHa1TY9Kh0uM7gsr6
        78pGx5pymZDvJnxNiqNDX2TfaA==
X-Google-Smtp-Source: APBJJlEcyhWZAO0MBPswLPa/ZIbl8mavuG7TjjlAudVH8Oks+LQPu3vA+mJ81Wq/x+wex65JIo+xbQ==
X-Received: by 2002:a17:907:b0a:b0:993:6382:6e34 with SMTP id h10-20020a1709070b0a00b0099363826e34mr9815665ejl.72.1689626350230;
        Mon, 17 Jul 2023 13:39:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id s1-20020a1709067b8100b009875a6d28b0sm141129ejo.51.2023.07.17.13.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 13:39:09 -0700 (PDT)
Message-ID: <4ef0d83e-b0c9-1f6e-c1a4-24d650630fe4@linaro.org>
Date:   Mon, 17 Jul 2023 22:39:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V1 2/5] ASoC: codecs: aw88261 function for ALSA Audio
 Driver
Content-Language: en-US
To:     wangweidong.a@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        rf@opensource.cirrus.co, shumingf@realtek.com,
        herve.codina@bootlin.com, flatmax@flatmax.com,
        ckeepax@opensource.cirrus.com, doug@schmorgal.com,
        fido_max@inbox.ru, pierre-louis.bossart@linux.intel.com,
        kiseok.jo@irondevice.com, liweilei@awinic.com,
        colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yijiangtao@awinic.com, zhangjianming@awinic.com
References: <20230717115845.297991-1-wangweidong.a@awinic.com>
 <20230717115845.297991-3-wangweidong.a@awinic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717115845.297991-3-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 13:58, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> The AW88261 is an I2S/TDM input, high efficiency
> digital Smart K audio amplifier with an integrated 10.25V
> smart boost convert

It's the same as in patch before. This does not help and does not
justify having one driver split into two.

> 

...

> +
> +static void aw_dev_i2s_tx_enable(struct aw_device *aw_dev, bool flag)
> +{
> +	int ret;
> +
> +	if (flag) {
> +		ret = regmap_update_bits(aw_dev->regmap, AW88261_I2SCFG1_REG,
> +			~AW88261_I2STXEN_MASK, AW88261_I2STXEN_ENABLE_VALUE);
> +	} else {
> +		ret = regmap_update_bits(aw_dev->regmap, AW88261_I2SCFG1_REG,
> +			~AW88261_I2STXEN_MASK, AW88261_I2STXEN_DISABLE_VALUE);
> +	}

You should not need {} here and in multiple other places.

> +	if (ret)
> +		dev_dbg(aw_dev->dev, "%s failed", __func__);

Why you are not handling the errors properly?

> +}
> +
> +static void aw_dev_pwd(struct aw_device *aw_dev, bool pwd)
> +{
> +	int ret;
> +
> +	if (pwd) {
> +		ret = regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
> +				~AW88261_PWDN_MASK,	AW88261_PWDN_POWER_DOWN_VALUE);
> +	} else {
> +		ret = regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
> +				~AW88261_PWDN_MASK,	AW88261_PWDN_WORKING_VALUE);
> +	}
> +	if (ret)
> +		dev_dbg(aw_dev->dev, "%s failed", __func__);
> +}
> +

...

> +
> +int aw88261_dev_fw_update(struct aw_device *aw_dev)
> +{
> +	struct aw_prof_desc *prof_index_desc;
> +	struct aw_sec_data_desc *sec_desc;
> +	char *prof_name;
> +	int ret;
> +
> +	prof_name = aw88261_dev_get_prof_name(aw_dev, aw_dev->prof_index);
> +	if (!prof_name) {
> +		dev_err(aw_dev->dev, "get prof name failed");
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(aw_dev->dev, "start update %s", prof_name);
> +
> +	ret = aw88261_dev_get_prof_data(aw_dev, aw_dev->prof_index, &prof_index_desc);
> +	if (ret)
> +		return ret;
> +
> +	/* update reg */
> +	sec_desc = prof_index_desc->sec_desc;
> +	ret = aw_dev_reg_update(aw_dev, sec_desc[AW88261_DATA_TYPE_REG].data,
> +					sec_desc[AW88261_DATA_TYPE_REG].len);
> +	if (ret) {
> +		dev_err(aw_dev->dev, "update reg failed");
> +		return ret;
> +	}
> +
> +	aw_dev->prof_cur = aw_dev->prof_index;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(aw88261_dev_fw_update);

Why do you need to export this? Where is the user?

> +
> +int aw88261_dev_reg_update(struct aw_device *aw_dev, bool force)
> +{
> +	int ret;
> +
> +	if (force) {
> +		aw88261_dev_soft_reset(aw_dev);
> +		ret = aw88261_dev_fw_update(aw_dev);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		if (aw_dev->prof_cur != aw_dev->prof_index) {
> +			ret = aw88261_dev_fw_update(aw_dev);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	aw_dev->prof_cur = aw_dev->prof_index;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(aw88261_dev_reg_update);

Same question. And in all other places as well.


Best regards,
Krzysztof

