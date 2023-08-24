Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF9D78781F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjHXSjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbjHXSin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:38:43 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C3519B0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:38:38 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b974031aeaso1656991fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692902316; x=1693507116;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=En2iu839EqQpNqcAkzG5XBjEYnMGVZow4zgnldYb4JA=;
        b=sHx5bDpEepHLNUc0mEvKIgpaaI6oYKVExdB8uv5CQtZ+yi9KA/waolgk6D5ityUOdD
         R6663YJYXBqdkE2Dhxeijkf0J1rnIeAYYncTLpCKjOt4c8xpNMYiTOk2eL0A9Gd76/Ml
         b5foVrLUynpxJj0bdP6EX3yiou3gmhpThjk9OxOFQY56KzRS7awwquwUL1yysKg31o+2
         ipjVNTLio6dR8rdrh30SKQ3HzTRrN3/fSV1Su7KOFfJXtJd9Gbt0qiqCYhzbd2CBMPTf
         5MXsEKf78TQV+yMiLlJmXa4lccrygtKKDMn3gCqU5p/v3214Av5Mfo/DuwLcTyTH8OVa
         l8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692902316; x=1693507116;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=En2iu839EqQpNqcAkzG5XBjEYnMGVZow4zgnldYb4JA=;
        b=afqe3s3JPb612rMNOkDRq6QzLZ+/rKNaYbGBMFlN2Vh6wVEk4IOjtU3BlPJ45xsLX7
         pFeQSRq/HOVbat1+KYBfjrZtBlwjavAe1t7ipLc/+IagEumYBJdndGvQdh8Bb/oOvQkQ
         9GJ9Sb5GA40pENPIDYpngcx591/USzlT5Bs/2rFPeEFlJez0V7f2O0DDdgh0E0kIBCe7
         IQWSQlubqL2tjK7AuEmzMh+DYSFhLaS7+7nbnQJQISUlG5ywzKl0/CMnw9OnY/cR7Z5l
         3msVpM3MUa0NZyLjBRP/zAPEIXbda/3hj/DGnpV1vyXQloaUjisJMvLbiHenKKMkEy+R
         eGwg==
X-Gm-Message-State: AOJu0YweYiuolPw5dFDv++Zqun/H3QIyW4eJm3va1PrN8Q5PsI40xT5n
        1523WodiVQV4e1hrilpDuPs2qQ==
X-Google-Smtp-Source: AGHT+IEOWz8tiDwTWaanqHibok2oHyVgujQoY13FqBxm19IRl/RLbvgqU6TodBnf7BQzSGb8N7dELQ==
X-Received: by 2002:a2e:9d96:0:b0:2bc:ce85:2de2 with SMTP id c22-20020a2e9d96000000b002bcce852de2mr7286418ljj.37.1692902316406;
        Thu, 24 Aug 2023 11:38:36 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id k6-20020a1709062a4600b0099bcbaa242asm11117747eje.9.2023.08.24.11.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 11:38:36 -0700 (PDT)
Message-ID: <350def85-276e-0514-a5f4-24f95bedb375@linaro.org>
Date:   Thu, 24 Aug 2023 20:38:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 10/11] firmware: imx: enclave api to read-common-fuses
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, clin@suse.com,
        conor+dt@kernel.org, pierre.gondois@arm.com, ping.bai@nxp.com,
        xiaoning.wang@nxp.com, wei.fang@nxp.com, peng.fan@nxp.com,
        haibo.chen@nxp.com, festevam@gmail.com, linux-imx@nxp.com,
        davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
References: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
 <20230823073330.1712721-11-pankaj.gupta@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823073330.1712721-11-pankaj.gupta@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 09:33, Pankaj Gupta wrote:
> Added an API to read the common fuses only accessible to
> enclave-firmware.
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>

...

> +int read_common_fuse(struct device *dev,
> +		     uint16_t fuse_id, u32 *value)
> +{
> +	struct ele_mu_priv *priv = dev_get_drvdata(dev);
> +	int err;
> +
> +	err = plat_fill_cmd_msg_hdr(priv,
> +				    (struct mu_hdr *)&priv->tx_msg.header,
> +				    ELE_READ_FUSE_REQ, 8);
> +	if (err) {
> +		pr_err("Error: plat_fill_cmd_msg_hdr failed.\n");
> +		return err;
> +	}
> +
> +	priv->tx_msg.data[0] = fuse_id;
> +	err = imx_ele_msg_send_rcv(priv);
> +	if (err < 0)
> +		return err;
> +
> +	switch (fuse_id) {
> +	case OTP_UNIQ_ID:
> +		err = read_otp_uniq_id(priv, value);
> +		break;
> +	default:
> +		err = read_fuse_word(priv, value);
> +		break;
> +	}
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(read_common_fuse);

Missing kerneldoc, missing user. Sorry, this cannot be accepted. Don't
add such dead code.

Best regards,
Krzysztof

