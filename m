Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9DF76FC3B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjHDIoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjHDIoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:44:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDF630F8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:44:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe2bc2701bso17591415e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691138652; x=1691743452;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GIjNdj4JuQxUdzoSWDRGT3Y0i+UGrI7BPvjCgMi7Q1s=;
        b=KcjvaeW5ImhkBzfV1yluLkYW8Dk7LKT75FPdFHktnYNgFXQSkUD0Jj6ygSZvobSR93
         J776H1HwUFcdIJLoZUfDA1EWhCTDzMcx/vFOUcTu2JAByAgmfOHjkZkZWZX88JRU3eEb
         TybI7qGk5E8mNME6rDj1VsnzuxB8iMdgRzp4J88746zJBRsnR5E9LF9An9RMQsYefdHl
         SnSUux/latyvhc518U7V2SHydsHUaa934NvXfl857PoJG7xcVWXUUODcKqONTBxcTPLF
         61XJ6q7NAf41rSNk9AVJNCOLkXaKQlHyuU9eKyvC0DnQZr8w+37XjEGD2rEPIHtp9Pco
         QUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138652; x=1691743452;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GIjNdj4JuQxUdzoSWDRGT3Y0i+UGrI7BPvjCgMi7Q1s=;
        b=H6x/KN1ZoW5RIhKas8TN0H7rWxeAAWbUpnlvVpFIoS6XAwJgOH4NHZ5c+pMsML/nM8
         zZNQXo/QPeTzJxz4dfhUi4NdnU+4IVO+HXWtdeVRGkBwS2oQ9TcVUGRQDZ+IKM9ovxyr
         WMJHy2yfF2G4ziA9yd02UAZLeGCUbUK1qkJ+n2g3HrwR0uLm1W/hyf4kbUtiElXRil/D
         z/bCe9g/ldzNeekPF+GbW5Fo8m6G471cLGuxx3tLpBHhsruaEzbgBDeAP+FmuPjEd2bA
         03rXaFIOmda0xq++ePg+MxHpIU25jJK0JkSFhqOYqsmxyC9WRHazcH2bh6qfPeGBmqJN
         sJEw==
X-Gm-Message-State: AOJu0YxhZ/MPmHoJnQGoBxedttK2qqWLFXEL3dq94Pu3voLGLHMdYHV+
        28My9OwgURisakYs5zY17Q8xFUM2rUlGIeuzn/K20g==
X-Google-Smtp-Source: AGHT+IEAPU5SQIxnbMvwbEmJ5WnR8hp8muvDpqD+rDOvenYDw86jGu3Z1m9H0TJBl6KG4FAYBCvn5Q==
X-Received: by 2002:a05:6000:1081:b0:317:64f4:5536 with SMTP id y1-20020a056000108100b0031764f45536mr660139wrw.44.1691138652147;
        Fri, 04 Aug 2023 01:44:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b526:9083:f5a6:4af1? ([2a01:e0a:982:cbb0:b526:9083:f5a6:4af1])
        by smtp.gmail.com with ESMTPSA id s18-20020adfeb12000000b0031779a6b451sm1924588wrn.83.2023.08.04.01.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 01:44:11 -0700 (PDT)
Message-ID: <36acaa5c-f41a-af88-78dd-cd3714301c12@linaro.org>
Date:   Fri, 4 Aug 2023 10:44:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] net: phy: meson-gxl: implement meson_gxl_phy_resume()
Content-Language: en-US
To:     Da Xue <da@libre.computer>, Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <CACqvRUZRyXTVQyy9bUviQZ+_moLQBjPc6nin_NQC+CJ37yNnLw@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CACqvRUZRyXTVQyy9bUviQZ+_moLQBjPc6nin_NQC+CJ37yNnLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Da,

On 04/08/2023 05:07, Da Xue wrote:
> After suspend and resume, the meson GXL internal PHY config needs to
> be initialized again or the carrier cannot be found.
> 
> Signed-off-by: Luke Lu <luke.lu@libre.computer>
> Reviewed-by: Da Xue <da@libre.computer>
> 
> ---
>   drivers/net/phy/meson-gxl.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
> index bb9b33b6b..c4a07e6f7 100644
> --- a/drivers/net/phy/meson-gxl.c
> +++ b/drivers/net/phy/meson-gxl.c
> @@ -132,6 +132,18 @@ static int meson_gxl_config_init(struct phy_device *phydev)
>    return 0;
>   }
> 
> +static int meson_gxl_phy_resume(struct phy_device *phydev)
> +{
> + int ret;
> +
> + phy_clear_bits(phydev, MII_BMCR, BMCR_PDOWN);

Call genphy_resume() instead.

> + ret = meson_gxl_config_init(phydev);
> + if (ret)
> + return ret;
> +
> + return 0;
> +}

Please re-indent this function.

> +
>   /* This function is provided to cope with the possible failures of this phy
>    * during aneg process. When aneg fails, the PHY reports that aneg is done
>    * but the value found in MII_LPA is wrong:
> @@ -196,7 +208,7 @@ static struct phy_driver meson_gxl_phy[] = {
>    .config_intr = smsc_phy_config_intr,
>    .handle_interrupt = smsc_phy_handle_interrupt,
>    .suspend        = genphy_suspend,
> - .resume         = genphy_resume,
> + .resume         = meson_gxl_phy_resume,
>    .read_mmd = genphy_read_mmd_unsupported,
>    .write_mmd = genphy_write_mmd_unsupported,
>    }, {
> --
> 2.39.2

Thanks,
Neil
