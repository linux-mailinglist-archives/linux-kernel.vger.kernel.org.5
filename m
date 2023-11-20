Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAC67F19FB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjKTRbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjKTRbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:31:44 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF1FBE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:31:40 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54366784377so6438066a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700501499; x=1701106299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OK2jRVTH3s/9IJ77qC5XouhjycD6j4AtAkG2Q+TlqT4=;
        b=jHfP1ScE6ABH/S1n++UGPgDloRhi1FZ+FcNUKH3SaNHdxBh/wSZqfPhlLWqp6K2C46
         HlLScuZbJkQ5Kn3CfFJgRpgv8bhu6lnTkuYavsz7SKFSHYPJvNyrWVYRKL9t/K+5Zvip
         AW+6b3n6MU9PwQQhgd79zHM6Qd+OLA7ETeL9Zxv+p1GZzoOjhNsR/nECMRlLA4lLo1/h
         3u/pFh9qCkJwTjAWpOD1lOM53GjTRn2KIyp8vuwFVnTU9dBX4bAX5WTLYGdgnsdhIj0k
         pGclziPgff3GaeIB3SByXI/LeJRoCVMO7VHYIaihxlcyOlS2l8gx69eb2d3J4LU1igQv
         Gxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700501499; x=1701106299;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OK2jRVTH3s/9IJ77qC5XouhjycD6j4AtAkG2Q+TlqT4=;
        b=a4r7Jid9Y6oL+8dBNaCpJaCiDC9UPqdbWQz1JOdv+WcU6ycadYPiIqs3NZvEzkGjwU
         ghuZOOF3LLhGQ5/RfjK+S7txf2k8wufSfHEBn4BAdlTPXXaaDicpICtFTnHEl6XgO9+n
         tVyyxb7yboQFdI//IyVmTurBDwCkASXw0oQHx00bFbXNZgbeepeGY3zah4aPgXmqWS3v
         x2j/XFn5J7fb1twly2hCacno50IbiHL3MF0HHpw9PQgD1ZJJAIaiih8f7vcjSXe5cDD4
         K1zC8O6fe1yBZ1McGDpZvNPHPnCYkSqBYtRM5QnAZ+ovV4+EXo9XL04uPhhnYu7yBA6L
         qeeQ==
X-Gm-Message-State: AOJu0YzGXqUNvdS/e9kFFMvU/uXLDy57QMbwdjEOVrsbJHeJ+vyTnTZe
        QHsLTUQTtrNU3FilyxOYq9v85g==
X-Google-Smtp-Source: AGHT+IGaFlQo07kw+f8vzV1cM5QYBugS/zxNyeV+GjknxBlj6uiswnvJi/rJD5mOJlpYxAk9rwuvXQ==
X-Received: by 2002:aa7:d409:0:b0:53f:a017:7526 with SMTP id z9-20020aa7d409000000b0053fa0177526mr40428edq.40.1700501499025;
        Mon, 20 Nov 2023 09:31:39 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id b8-20020a50ccc8000000b0053ff311f388sm3950277edj.23.2023.11.20.09.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 09:31:38 -0800 (PST)
Message-ID: <d84e400d-7f76-4b4d-8960-f1338f37b8ac@linaro.org>
Date:   Mon, 20 Nov 2023 18:31:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] usb: cdns3-ti: add suspend/resume procedures for
 J7200
Content-Language: en-US
To:     =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>
References: <20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com>
 <20231120-j7200-usb-suspend-v2-4-038c7e4a3df4@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231120-j7200-usb-suspend-v2-4-038c7e4a3df4@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2023 18:06, Théo Lebrun wrote:
> Hardware initialisation is only done at probe. The J7200 USB controller
> is reset at resume because of power-domains toggling off & on. We
> therefore reconfigure the hardware at resume.
> 
> Reuse the newly extracted cdns_ti_init_hw() function that contains the
> register write sequence.
> 
> Only focus J7200 as other SoC are untested. If the controller does not
> reset we do not want to redo reg writes.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/usb/cdns3/cdns3-ti.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
> index d4232b440e4e..84f93c2fcd5c 100644
> --- a/drivers/usb/cdns3/cdns3-ti.c
> +++ b/drivers/usb/cdns3/cdns3-ti.c
> @@ -58,6 +58,7 @@ struct cdns_ti {
>  	struct clk *usb2_refclk;
>  	struct clk *lpm_clk;
>  	int usb2_refclk_rate_code;
> +	bool reset_on_resume;
>  };
>  
>  static const int cdns_ti_rate_table[] = {	/* in KHZ */
> @@ -172,6 +173,7 @@ static int cdns_ti_probe(struct platform_device *pdev)
>  	data->usb2_refclk_rate_code = i;
>  	data->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
>  	data->usb2_only = device_property_read_bool(dev, "ti,usb2-only");
> +	data->reset_on_resume = of_device_is_compatible(node, "ti,j7200-usb");

No, use driver data for this. Don't put compatibles in the code. It
makes it unmanageable soon.

I am repeating this issue from time to time :/

Best regards,
Krzysztof

