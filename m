Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6103C78986A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 19:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjHZRcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 13:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjHZRbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 13:31:42 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBC11A5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 10:31:39 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b974031aeaso29621781fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693071098; x=1693675898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2rKCSZsu8/cjHlt5rvny4PL6NtTe+upkivFRUnpx0M=;
        b=Sfrkbp2WO5UZ4s7fvSATxmQVfafN3gdvAubgBwTMywsS7OSelTX/DaXC6INNMsasHF
         uMPZYL5l9RcDkb5Ymuqj+/EGRpT0RUTdzKX8tYEsxdgetDBey8E1ntZSElFAFWUx5RsF
         QUd5FbluY8iOXyrqvyOQQ+6Akwi3qJFlNLzd8xRYJSe0eo/KMZf06uy6k2xEUUm0E3GP
         IWUh/sCuCnYb4ozQ3fbUW26dINL4QX9XilChawQZR+1BXK7athc43Rp7lXm3kjOiueBd
         UbpgNFZPu8Nl4us7OSoYTvatrW2dHyuXacZ6VXg7IJ5ANT9y7QGqvCUWuKoJpQZFmg0C
         +bpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693071098; x=1693675898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2rKCSZsu8/cjHlt5rvny4PL6NtTe+upkivFRUnpx0M=;
        b=eC3wszU/m9+9LHIvIhqS3Q06v6Q1+JllsiURiwhfubjSZ27I8zU/txlYMDP5MCIvAc
         gYH3WfeQyb88NYImHKb1Ukl7FomsJ5C4GqGij7nE1Di1RWQZnzWG0vqRp5HMApMuZWij
         +4g4yL7KYy/bcZVBDBGpa5Rp3EYxdBXZDXcJ/3L8TcwFsQOlt0yAt75yzat5vZjDANSI
         m0DatHz2+vksiQPxaH31S3HykRRs+a/2uS4hEzCpIIJqHpFbqeUrbBjRNTs8tgbZGEqB
         Z2i2s215XXp66V5aiXjCqz8d0EQrjTLiMC2ccN7p1RBm8YZbcRm2+9fwHN5VwpB/m1Ya
         05PA==
X-Gm-Message-State: AOJu0YyB4pph+VKH1K0BT5a1DdDzY/WPslOVaJK4QlmKHWXE7CVUHe6/
        hV4MdUW3d2Mb1WowFuDmrdsY7g==
X-Google-Smtp-Source: AGHT+IG9DjB0A++FAUKlFtKnVs7soasltg8AxGuvsxRAUqvxAEnosyk2s9yePUFBDzY+a78jDRIuhg==
X-Received: by 2002:a2e:9d08:0:b0:2b9:b4eb:c39c with SMTP id t8-20020a2e9d08000000b002b9b4ebc39cmr14967716lji.8.1693071097760;
        Sat, 26 Aug 2023 10:31:37 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id n18-20020a170906841200b0099ce23c57e6sm2401208ejx.224.2023.08.26.10.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 10:31:37 -0700 (PDT)
Message-ID: <4e2c18e3-b1ed-6361-3998-5de060d2bcf0@linaro.org>
Date:   Sat, 26 Aug 2023 19:31:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
To:     Shenwei Wang <shenwei.wang@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <CAPDyKFqsn6kVjPFUdVyRxNDiOaHO9hq=9c+6eAK4N-v-LVWUPw@mail.gmail.com>
 <PAXPR04MB91858254554272C90822FED1891DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <CAPDyKFoV2Z=-WUiF3SgXqhF+K+r5QqsLgz8_hau0WKfZxTzYpg@mail.gmail.com>
 <PAXPR04MB9185F6AA20B0440B8FAB847789E3A@PAXPR04MB9185.eurprd04.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PAXPR04MB9185F6AA20B0440B8FAB847789E3A@PAXPR04MB9185.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2023 17:44, Shenwei Wang wrote:
>>
>> The genpd provider then needs to be a consumer of the resources it needs. In
>> this case a couple of regulators it seems like.
>>
> 
> If I understood your reply correctly,  it seems that the current implementation of 
> regulator-pd is what you have described. Please correct me if I'm mistaken.
> 
> The following are the diff of scu-pd and this regulator-pd.
> 
>     power-controller {						    power-controller {
>         compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";      |	        compatible = "regulator-power-domain";
>         #power-domain-cells = <1>;				        #power-domain-cells = <1>;
> 							      >
> 							      >	        regulator-number = <2>;
> 							      >	        regulator-0-supply = <&reg1>;
> 							      >	        regulator-1-supply = <&reg2>;
>     };								    };
> 
> Are you suggesting to move the regulator-pd to the imx directory and add a company prefix
> to the compatible string?

There is no such part of iMX processor as such regulator-power-domain,
so I don't recommend that approach. DTS nodes represent hardware, not
your SW layers.

Best regards,
Krzysztof

