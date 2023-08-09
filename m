Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33CC77628B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjHIOcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjHIOcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:32:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E949E1FCC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:32:12 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe463420fbso10737589e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 07:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691591531; x=1692196331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/OG3bQtj/ll/T2r9Vb1o3dNddjqQUv8KGzg4KrsLv8=;
        b=VsB2jlDnA/AkMPj8Mjslq1th2E+vn+FFKYjv3ISKBl7lBvUvFSAFliQs8vmKn2N8PY
         hmhsNaIzZjI+86PsmNUwrRpM0c6scD+N8qxh+424MU9eUr5+r9nWecxRMxT3sFIzPqpD
         pKQAYxxD/UV61bwNYeMyN6mrGulRZ0MXRKF6nqLAcSLnpBjoQqLF/9YKXh1vyorQP/jB
         rUs0f4YzoZ8AdDYvYZE4LSVaEKhGrf9fzRGmQb0XRfWKh7ZFLHSR6cx9Suq50PBJ1k3A
         hMshTUalZK/V6ERY/FTCPxNYp/akRtFHZJ0ugrQx2m758g5+Lm0AyqDQKiM3Kp9jemw1
         gMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691591531; x=1692196331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/OG3bQtj/ll/T2r9Vb1o3dNddjqQUv8KGzg4KrsLv8=;
        b=IdaF7T3p3E97qs3c9fRFAZ9hhfYO2tn/8UzzY724DD6Pl2g6MEl2Jlxmp4mSK+/f6J
         RxGHQQNE73hQCIYD1FtuNV4i3J1RElgIdSCXdoF6NPckxBzSYFYEou8XwXo9joYpaTRz
         hTihSVQKgoQylxrVjni0VeHLBhFiewl3yc7fOk0i6U9UqwgKZNtMjrsHP4Ohw4YZSe3E
         FwFk7CraLx9KGQhGRcriCUx/DGgBBK8+a2Nb2KAWGxyWXybnMXXe9Zywo97a+o4iJwxc
         rSGSdJEN7HGq6dL8TNRHYOZi4OPdMuR/NaCiWuo4Lo3EB6XYTWErfPwvFl0oGtVgPJHy
         ui4A==
X-Gm-Message-State: AOJu0Yx7MmB6BQ/8VNQ8Ke5nkdtYD1yD3R5fdLVu+m5oIwKpyIHcn5gs
        Hr3Qbj7hyrVbhw7R6/zrp0urYg==
X-Google-Smtp-Source: AGHT+IGXwAreNMmFrscF59xHDK7lL6L89Vhhpntx/ksib8+sJNO2vJ+FfhPoXfnf/pjW2MCSGUiMwg==
X-Received: by 2002:a19:675d:0:b0:4fb:8aeb:d9be with SMTP id e29-20020a19675d000000b004fb8aebd9bemr1945026lfj.30.1691591531057;
        Wed, 09 Aug 2023 07:32:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c231100b003fc01495383sm2211700wmo.6.2023.08.09.07.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 07:32:10 -0700 (PDT)
Message-ID: <5d9ff125-e633-9522-187a-cc61f82caec0@linaro.org>
Date:   Wed, 9 Aug 2023 16:32:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/2] Input: cs40l50 - Initial support for Cirrus Logic
 CS40L50
Content-Language: en-US
To:     James Ogletree <james.ogletree@cirrus.com>,
        dmitry.torokhov@gmail.com
Cc:     Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Jacky Bai <ping.bai@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Jeff LaBundy <jeff@labundy.com>,
        Eddie James <eajames@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jean Delvare <jdelvare@suse.de>, Joel Stanley <joel@jms.id.au>,
        Peng Fan <peng.fan@nxp.com>, patches@cirrus.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230809135313.731706-1-james.ogletree@cirrus.com>
 <20230809135313.731706-3-james.ogletree@cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230809135313.731706-3-james.ogletree@cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 15:53, James Ogletree wrote:
> Introduce support for Cirrus Logic Device CS40L50: a
> haptics driver with waveform memory DSP and closed-loop
> algorithms.


> +static const struct of_device_id cs40l50_of_match[] = {
> +	{ .compatible = "cirrus,cs40l50" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cs40l50_of_match);
> +
> +static int cs40l50_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct cs40l50_private *cs40l50;
> +
> +	cs40l50 = devm_kzalloc(dev, sizeof(struct cs40l50_private), GFP_KERNEL);

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.


Best regards,
Krzysztof

