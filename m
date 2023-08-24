Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1928A7874A8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbjHXPyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238392AbjHXPyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:54:41 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FA4198E;
        Thu, 24 Aug 2023 08:54:39 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bf11b1c7d0so7859615ad.0;
        Thu, 24 Aug 2023 08:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692892479; x=1693497279;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CmbGvr8dlSzQPp0uZqliJftuaTSd53V9Yq7FG0s1paw=;
        b=f81K9UlcgRp3z2cXs+OYb/i54LlwzT/6HnlZRYKI1NUTnak3RFTlsL1aPnG8n4a2VE
         uEoppK6SwA7wJiMaADvPpmYQUcdE2eXecevJ3V1OcfPHDttfSenFIqNeUh9Ox0TFcsPn
         I/dgHJ+/iV9yzV2hezummqbwTKLZ95pj8rTVduIzZtaVk77UN1wU7d/mJlPyqtQmXuTX
         VklZn5XGVO7mv+htHllAXoLK2lmFcIsSseRsAp19pgwrzGS+a9MjTBSRDfzPH5xfG++D
         RQgNbCpRA0CTO0UOiYQALXffBCLSQgnfA0SG9rfmFVgiw0VcId6FIGkSQIw9FcDQn2JC
         KFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692892479; x=1693497279;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmbGvr8dlSzQPp0uZqliJftuaTSd53V9Yq7FG0s1paw=;
        b=MKZTY+ujZOW/wjau8p51tfd+aXz+Ok7rbm0z9OMMUhhiAUmV1wg7IIxqezmccL0mIu
         2dzofwip4gUMr11Nn+uwr3LzmbCMZNrW+UCS9ewEfM2c8Q3qJkCkPBPp6iIofChO5sFp
         MJ1k9P2JX9xVfndAhuGCIpNQfGAi5l9VhyvEFN2sxumvd/pOCRv4CRAYj9sIr9U0RCdB
         KvNhgVIrFBTRedQj0iMCrN2pQVJoCY6qCKHncOKGtruU1aLyZ4ntR4dYfXKGVPLch49f
         2h/AbgXlMw4oEBxBwb2nX01ZyYVg9qrVA/ZENaRfUD1FUZ5kZovx2gOMEhV7MXQmDqkO
         v3zQ==
X-Gm-Message-State: AOJu0YyHciCdAPOCTBjY23mzMl1EUA3WJIWe1aJYOKb+//wczPJDf3uE
        2lVPmDzvkSPb6a+7NPVDDKY=
X-Google-Smtp-Source: AGHT+IFaj/4PgFjSMAAkBJP6gUO2Btl570RIugj8pRiWh1qMu4ckG4UYYra05TLiIr7BWc9SGmXBmA==
X-Received: by 2002:a17:90a:6d65:b0:269:4fe8:687 with SMTP id z92-20020a17090a6d6500b002694fe80687mr24283202pjj.19.1692892478620;
        Thu, 24 Aug 2023 08:54:38 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id g8-20020a1709029f8800b001bc445e249asm12933625plq.124.2023.08.24.08.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 08:54:38 -0700 (PDT)
Message-ID: <9504d420-c137-2fde-312d-2c8e6f84ddd1@gmail.com>
Date:   Thu, 24 Aug 2023 08:54:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Content-Language: en-US
To:     Lukasz Majewski <lukma@denx.de>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com
Cc:     Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230824154827.166274-1-lukma@denx.de>
 <20230824154827.166274-2-lukma@denx.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230824154827.166274-2-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/2023 8:48 AM, Lukasz Majewski wrote:
> The KSZ9477 errata points out the link up/down problem when EEE is enabled
> in the device to which the KSZ9477 tries to auto negotiate.
> 
> The suggested workaround is to clear advertisement EEE registers
> (accessed as per port MMD one).
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>   drivers/net/dsa/microchip/ksz9477.c | 40 ++++++++++++++++++++++++++++-
>   1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
> index cb6aa7c668a8..563f497ba656 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
> @@ -1128,6 +1128,44 @@ int ksz9477_enable_stp_addr(struct ksz_device *dev)
>   	return 0;
>   }
>   
> +static int ksz9477_errata(struct dsa_switch *ds)
> +{
> +	struct ksz_device *dev = ds->priv;
> +	u16 val;
> +	int p;
> +
> +	/* KSZ9477 Errata DS80000754C
> +	 *
> +	 * Module 4: Energy Efficient Ethernet (EEE) feature select must be
> +	 * manually disabled
> +	 *   The EEE feature is enabled by default, but it is not fully
> +	 *   operational. It must be manually disabled through register
> +	 *   controls. If not disabled, the PHY ports can auto-negotiate
> +	 *   to enable EEE, and this feature can cause link drops when linked
> +	 *   to another device supporting EEE.
> +	 *
> +	 *   Only PHY ports (dsa user) [0-4] need to have the EEE advertisement
> +	 *   bits cleared.
> +	 */
> +
> +	for (p = 0; p < ds->num_ports; p++) {
> +		if (!dsa_is_user_port(ds, p))
> +			continue;
> +
> +		ksz9477_port_mmd_read(dev, p, MMD_DEVICE_ID_EEE_ADV,
> +				      MMD_EEE_ADV, &val, 1);
> +
> +		pr_err("%s: PORT: %d val: 0x%x pc: %d\n", __func__, p, val,
> +		       ds->num_ports);

Left over debugging?

> +
> +		val &= ~(EEE_ADV_100MBIT | EEE_ADV_1GBIT);
> +		ksz9477_port_mmd_write(dev, p, MMD_DEVICE_ID_EEE_ADV,
> +				       MMD_EEE_ADV, &val, 1);
> +	}
> +
> +	return 0;

You don't propagate any error, so make this return void?
-- 
Florian
