Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488AF758DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjGSGj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjGSGjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:39:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5561FFD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:39:22 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52165886aa3so7487476a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689748761; x=1692340761;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FkYcA/qG9jmDR//bHA4TMNeynT6TeOA+h1nLtEf6hYw=;
        b=JjlB3wjWE06Kz96Bwnsiuf10N99M+n4lkVQzefLjb/9vTzHznBONpd+6Qji16CkyT6
         kNIh4Y2d5xOsOWj0jVRyhH5STDoLXBit8aXZkw/ztDSPpfQxGc/uvmtiUS+/mX1ZKv3p
         PbaxGm9pWLFUNRxY5enilifh765Kk8HX9JGESqfl+LbjqDB9JmM+tILofgD64OccmNaE
         35TYRpCehDVBIdbHK1GaUld57csHY1RefRRo2CmPq8GRqGyEp1fkZN6QtXXTSqvLvQjo
         rPxKAJXDycMQHoSrVdiWpwQ8zxpORiHCZ1DPntyBFWHDQngAdwBy1OU4GwXH7D5des68
         XB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689748761; x=1692340761;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FkYcA/qG9jmDR//bHA4TMNeynT6TeOA+h1nLtEf6hYw=;
        b=Iy+wwo9BXhY861S4FOPvo0Iam6Q7MgRi+xlDLNllgR2p03q9JY46d0lxLzisrc22Qz
         CILq9b1pZuimRV2/N+kRPuyMPW2RDKO3f8KHwmlPw4eyisSyW6XopTznXtZF2Xy1HlUb
         nKbBzYK9XgPToeRhQnVhLJOc/Nxtcvec2rp7/XSR5j9u7HiAWrtDcVXHT5fuyKMXXw9H
         vGknOPnIrryx/j/KAFCwVYkq4/rl6aJ2XuRIStOhSUlkK+A0b3ZzDgq0eoezEChnoCD5
         Oc2Cp+zrkRvb6HM/UhTuoJM/GwIwL8s/qx7EIGtr7fS63nJIYlAUG2Nr+2CyX/E4nEhu
         ZSGQ==
X-Gm-Message-State: ABy/qLZzEm1GWsg+44Nx3iE6zOkf522S460FEGTv1D9AJ14seJ5YyePy
        9t+q4Y356gYdgWAHVBsHxU0kYw==
X-Google-Smtp-Source: APBJJlFeM5UlgZygOPuiVhdu1mcPY3p3Gj/OOrFdxdWDZUSCCBvwFF58vuybpXJ6JQqTIHleL9Am7Q==
X-Received: by 2002:a17:906:2457:b0:987:5147:7498 with SMTP id a23-20020a170906245700b0098751477498mr1651514ejb.32.1689748760757;
        Tue, 18 Jul 2023 23:39:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id p1-20020a1709061b4100b00982a92a849asm1894498ejg.91.2023.07.18.23.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 23:39:20 -0700 (PDT)
Message-ID: <488835c0-e08e-c0cc-abac-192f658b093f@linaro.org>
Date:   Wed, 19 Jul 2023 08:39:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] dt-bindings: usb: dwc2: add compatible
 "intel,socfpga-stratix10-hsotg"
Content-Language: en-US
To:     Meng Li <Meng.Li@windriver.com>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dinguyen@kernel.org, hminas@synopsys.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20230719025509.3007986-1-Meng.Li@windriver.com>
 <20230719025509.3007986-4-Meng.Li@windriver.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719025509.3007986-4-Meng.Li@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 04:55, Meng Li wrote:
> Add the compatible "intel,socfpga-stratix10-hsotg" to the DWC2
> implementation, because the Stratix DWC2 implementation does
> not support clock gating. This compatible is used with generic
> snps,dwc2.
> 
> Signed-off-by: Meng Li <Meng.Li@windriver.com>

Missing changelog, missing versioning. This is v3 or v4.

> ---
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
> index dc4988c0009c..f90094320914 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.yaml
> +++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
> @@ -51,6 +51,7 @@ properties:
>                - amlogic,meson-g12a-usb
>                - amlogic,meson-a1-usb
>                - intel,socfpga-agilex-hsotg
> +              - intel,socfpga-stratix10-hsotg

So you just sent the same patch as before. I pointed you to the proper
solution with compatibility.



Best regards,
Krzysztof

