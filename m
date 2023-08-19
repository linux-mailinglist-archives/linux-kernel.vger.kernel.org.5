Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475B1781995
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 14:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjHSMqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 08:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjHSMqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 08:46:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CD827822
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 05:44:46 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bdcade7fbso223304966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 05:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692449085; x=1693053885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=arWBzm2lSdJvcDhKXyDgEJyaUTijpzfIgfzXmJq3v2w=;
        b=p7EnsZFpG52j+1WRRl9BIRh2jZnUOl76vfLXvHboqubqktoMbw+UTeI8iw3aw8mKB5
         6+YCifIMP4/MkOJQufRZD/pcxD91aHFeZ6BrXGCLRvfQJP/5e/JXQe0CvRy34txS8ONN
         jHs601wKZjOU1dU5376JVZMDgil2zTHKkNeIkP4m3mqoFKMckOAJVTxueB6788vVlekq
         2GkbmtMuqOZ4FzfcymRwHuhX5uv+EqcHgxC4FP5qiWp6CDLt3x7ZnIvUa9vKu38jKqTI
         6vxRrjR606adboSfiHdsjjq3lo/Uo5EC6zdeVEo5PHHfC6srBR4QclTJU7fuifqZTl1k
         P68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692449085; x=1693053885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=arWBzm2lSdJvcDhKXyDgEJyaUTijpzfIgfzXmJq3v2w=;
        b=QRhfX/MUjJtyQJzEOZZ7DH0EUoHrpbN/srm6Ca6R1oOkveGbvHxQKoIN98PRHFdE4W
         L8J9lnsdobEG1qulJ2eHgPLfezjmUUGgyLdvUce9ujkuqu8Pwhv4WGn9zvwZqGIMEfMA
         xKbBcLHcOOKT+CnO2RoYRDPDveFzgxYDAF39Ftpj3WhBfidG+H7vKMEu+snR+e8m8OYc
         TvoWB28Cvr8kS8IySD00L8Big+cGeLg60ic5Sd/AZ0TVdrygVza+0sL02vU0q6wx6Zcc
         x4JYfOZ4tBfXPjJbrFKxW5hOIZ/PrLOZXcAzilvR28RDQysO39yNWyUDq04RGSKpUaEE
         GLRA==
X-Gm-Message-State: AOJu0YwjbVnNFzklouJ2/2tf13AX7W8PGSOzobM9d60wy0YD+UScZqRz
        HU0D3MqO1iqkHVzjOHebdhAIWA==
X-Google-Smtp-Source: AGHT+IHvQxA4hlWFTt4BSzB1BqWX/6SlPVXie6wgDpgyFB25IZIfLMOVL9alTMwQyByQwYauGfVdiw==
X-Received: by 2002:a17:906:23e1:b0:99b:f3d1:7735 with SMTP id j1-20020a17090623e100b0099bf3d17735mr1204090ejg.29.1692449084419;
        Sat, 19 Aug 2023 05:44:44 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id c17-20020a170906695100b00992a8a54f32sm2635367ejs.139.2023.08.19.05.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 05:44:43 -0700 (PDT)
Message-ID: <481ac6b3-1dda-1e9e-7339-e39a17d2eed9@linaro.org>
Date:   Sat, 19 Aug 2023 14:44:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V2 1/2] dt-bindings: phy: Add QMP UFS PHY comptible for
 SC7280
Content-Language: en-US
To:     Nitin Rawat <quic_nitirawa@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230819115223.9479-1-quic_nitirawa@quicinc.com>
 <20230819115223.9479-2-quic_nitirawa@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230819115223.9479-2-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2023 13:52, Nitin Rawat wrote:
> Document the QMP UFS PHY compatible for SC7280.
> 
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

