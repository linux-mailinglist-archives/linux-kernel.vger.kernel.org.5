Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108BB7F2DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjKUMzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjKUMy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:54:58 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418C3D49;
        Tue, 21 Nov 2023 04:54:54 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cb7951d713so1727287b3a.1;
        Tue, 21 Nov 2023 04:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700571294; x=1701176094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=APDg0JFczp621Nji+tuh/Qlng7+/H1U7mmX2HOaGoF0=;
        b=T/DgohbMfHGqCauD9/iwE3l22qXiHqShX0T8n7n3OgdTUf+dByouwfG4D1yA88UggH
         g2Bez5CO6m3OHVlOvsfck9o4ipsS6le3/fsc4jQGcw0fJzzcCBKs4RzV+J3ILKEcsfMU
         iRM/x1A6+l89ec+Zk6o12LapM8I44+EfVbHaU4Xpn0UXvWq1V3jRxOxBbiby+Ikp0Nqx
         ZgblVIPZYSV8v+8TZS+MZsmmqH353PQ/sp29VFXa0MTCYe/suy3MlHqQn1YmHQUXwTBX
         QjAuEVUs3TYcFUzvkyOS8Hf5vrBUL11pWbfmL32OOm3nzzZE1ierGEJemyeQRpm8WfzT
         6pTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700571294; x=1701176094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=APDg0JFczp621Nji+tuh/Qlng7+/H1U7mmX2HOaGoF0=;
        b=m/2lrwPK8tVIK+ZiMwvfvNF1/o2rPC7rUJZcoykeHJ8eSL830of6bP1sS/OEN6UTiY
         S/F8v/qlZOpqm/FBDefmu5dcpf60PYR/+fZ+e9S8qBFuOTLMdfwjxnnfnqKu6uHfUVHX
         LUDQ5A9+M+p9X1QpXNmp6rqXKeqak7YeiHQ5P2yU3+lWk7czdJpYOCcpKjno8XYBL7XU
         jGM9D5VXG8DFK31AByRTtg+X+YNn1wJJRiMycFRysOEyjYlVQCVX9mqdxWU9vHD78KEh
         d7U7F0KBBpx33SfOiXAPWzw0T5dh20IArv6kMwCZfcgrT1hNXQxigDf3AO21zv8yviHw
         nzaQ==
X-Gm-Message-State: AOJu0Yw6Mf69Wy6Do3C/z/LjvQoV6M35CFoC18mDEsP6kyWcysFI8qlS
        NRlvXM51thxUGM2DjAi+aro=
X-Google-Smtp-Source: AGHT+IEngvPw3d1IsOspFoHzqgu/DzbyLuPYIK3Y1V0BGB6MjVoi327NxD54joKaxDn6U5QAvanzfA==
X-Received: by 2002:a05:6a00:1486:b0:6cb:440c:1f60 with SMTP id v6-20020a056a00148600b006cb440c1f60mr3775560pfu.13.1700571293618;
        Tue, 21 Nov 2023 04:54:53 -0800 (PST)
Received: from [10.3.171.174] ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id u9-20020a62ed09000000b006b8ffc49ba5sm7828157pfh.38.2023.11.21.04.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 04:54:52 -0800 (PST)
Message-ID: <bb6d239d-0fb9-4353-b262-92810861b8e8@gmail.com>
Date:   Tue, 21 Nov 2023 18:23:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/2] dt-bindings: input: bindings for Adafruit Seesaw
 Gamepad
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jeff LaBundy <jeff@labundy.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20231121123409.2231115-1-anshulusr@gmail.com>
 <1bd2a6cc-aa01-4370-be19-88ffa524086e@linaro.org>
From:   Anshul Dalal <anshulusr@gmail.com>
In-Reply-To: <1bd2a6cc-aa01-4370-be19-88ffa524086e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/23 18:22, Krzysztof Kozlowski wrote:
> On 21/11/2023 13:34, Anshul Dalal wrote:
>> Adds bindings for the Adafruit Seesaw Gamepad.
>>
>> The gamepad functions as an i2c device with the default address of 0x50
>> and has an IRQ pin that can be enabled in the driver to allow for a rising
>> edge trigger on each button press or joystick movement.
>>
>> Product page:
>>   https://www.adafruit.com/product/5743
>> Arduino driver:
>>   https://github.com/adafruit/Adafruit_Seesaw
>>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> 
> Previously you sent untested patch. Did you test this one?

Yes, I have tested this one.

Regards,
Anshul
