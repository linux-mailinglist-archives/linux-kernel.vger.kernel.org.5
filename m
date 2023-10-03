Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2A27B6403
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbjJCIZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239391AbjJCIZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:25:13 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A08DAD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 01:25:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9ad8d47ef2fso102692766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 01:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696321508; x=1696926308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2bY6XDMCFjLMddJSy0fwcwvyfFdNKLzGzXuO6BPqp9o=;
        b=gPpNwUvb5cA4dwqT45DcJZhICHMOjRLuYT17CuHhxTHJulUxvhr13QNXuv98hCAyqF
         VcmS0XkllF6zBF00KMdc0lSOOgP3OKDZhiBW4b9BQBPcSJglCutoLS6qjR9Vm56Nklqi
         YYgbnGwuDMv8ofRaOU6A7/TfwlmAu6SzYfb04SN0xI/1SqVBlDb+1wdKfpZagn4sS44h
         Hne9I6Nh3qDheXGKImV25zdyQq9UIHdtpC+doSzs5Opdjwe8kvOT2YOdkIyY3EQGQM/A
         GkpiN5oJXg+5MFjXNKvwCPTxH8hI9STJT/fZVQBDK2Rqn1NPaEvICAy2TOKS9otYWkS/
         CbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696321508; x=1696926308;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bY6XDMCFjLMddJSy0fwcwvyfFdNKLzGzXuO6BPqp9o=;
        b=Y24dEhLN3Xkxz+mndqSNxaaYEO/ygQE2qqZTyMaduC/ces/uD66FkZJIDaLH0NDDw0
         ANdO8QScbMPVpJ8Ppuq6UNoixB2u7ArP8KS2XyujLgfUFayAOpzkJYm5axgk0np2RGIZ
         v4YlFkpC7KTO3Mysy06GnU3DnovTDNFDp4RIQfbaoEU83y70O5jdbelLwzPZ99CRAEV9
         /IdpxXcUoQfOPa8zWMGiHF2fiys0fURy7+EENz6a5unmhB/kAV2rxXgknGOGuNTwwIJ8
         QjarMKLfMNYg05NCI+5z7mkG9HlCO/59Kv5WprBfuuGcCMDMOpCOKHMTcIiAkrJyBeL4
         HqSA==
X-Gm-Message-State: AOJu0YzEooTWEn+vtx4vXfCJ8Sn2vNYodICrsix5lq2awJhF7xf2sbin
        jgNsDKzTITWUJ47aMPEin8U+nw==
X-Google-Smtp-Source: AGHT+IFPS5aaphSwTiaqvTpYX4YmdYc5Gnqgp71R3ewY6X7RESlyVZPE+N2HYue90Jmz98vSOUP7mg==
X-Received: by 2002:a17:906:214:b0:9b2:7367:a699 with SMTP id 20-20020a170906021400b009b27367a699mr13148269ejd.42.1696321507781;
        Tue, 03 Oct 2023 01:25:07 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id sb8-20020a170906edc800b0099cf840527csm639065ejb.153.2023.10.03.01.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 01:25:07 -0700 (PDT)
Message-ID: <50a0de57-db28-424a-915d-fc6e00ae4758@linaro.org>
Date:   Tue, 3 Oct 2023 10:25:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] greybus: Add BeaglePlay Linux Driver
Content-Language: en-US
To:     Ayush Singh <ayushdevel1325@gmail.com>,
        greybus-dev@lists.linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vaishnav@beagleboard.org,
        jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, johan@kernel.org,
        elder@kernel.org
References: <20231002182454.211165-1-ayushdevel1325@gmail.com>
 <20231002182454.211165-3-ayushdevel1325@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231002182454.211165-3-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2023 20:24, Ayush Singh wrote:
> Add the Greybus host driver for BeaglePlay board by BeagleBoard.org.
> 
> The current greybus setup involves running SVC in a user-space
> application (GBridge) and using netlink to communicate with kernel
> space. GBridge itself uses wpanusb kernel driver, so the greybus messages
> travel from kernel space (gb_netlink) to user-space (GBridge) and then
> back to kernel space (wpanusb) before reaching CC1352.
> 
> This driver directly communicates with CC1352 (running SVC Zephyr
> application). Thus, it simplifies the complete greybus setup eliminating
> user-space GBridge.
> 

...

Thank you for your patch. There is something to discuss/improve.

> +
> +static int gb_serdev_init(struct gb_beagleplay *bg)
> +{
> +	u32 speed = 115200;
> +	int ret;
> +
> +	serdev_device_set_drvdata(bg->sd, bg);
> +	serdev_device_set_client_ops(bg->sd, &gb_beagleplay_ops);
> +	ret = serdev_device_open(bg->sd);
> +	if (ret)
> +		return dev_err_probe(&bg->sd->dev, ret, "Unable to open serial device");
> +
> +	speed = serdev_device_set_baudrate(bg->sd, speed);

Unused value speed. Probably this results in warnings. Plus it is a
confusing code. Check the return value if it is relevant. If it can be
ignored, skip assignment and drop "speed" variable.

Rest looks okay to me after glance (I did not perform full review).


> +	serdev_device_set_flow_control(bg->sd, false);
> +
> +	return 0;
> +}
> +
> +static int gb_beagleplay_probe(struct serdev_device *serdev)
> +{
> +	int ret = 0;
> +	struct gb_beagleplay *bg;
> +
> +	bg = devm_kmalloc(&serdev->dev, sizeof(*bg), GFP_KERNEL);
> +	if (!bg)
> +		return -ENOMEM;
> +
Best regards,
Krzysztof

