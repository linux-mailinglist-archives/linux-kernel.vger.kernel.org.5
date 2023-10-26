Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6287D8900
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjJZTgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjJZTgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:36:31 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A261AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:36:29 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c59a4dcdacso21585241fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698348987; x=1698953787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OTgf2Dvow9ZuXFPqFfbC0fdxBZgN8QcR7Q24NuIsbkQ=;
        b=oCsUUWNf40nDNxPhrbehQjJH3/sMUd6nty7cLyO9bQyEiopL6LnZcGj/BaMrtQcc1i
         VVYfzS1tY2XxR46oByRBoxpukYsHpqX2xCnVepJEc8oUQe5hAJ4Nk72PI3/WOjZdWR3q
         IVGA+rSxklLeUZWB3v643KL1pmgDIkr2hkDZfTQGUu9xG6LIj93Ri0e1+lbu1gSGABWI
         3DtiecyqAw/naTc4o3kdenCOBK1I04kZ9KF9nkwn10/4h5/hitq0HxwT/PRtEospTz1p
         PCdEulzEqqYRT1DXaObr16E44tzoRLXQ7N9Hq6UH+yz0V3lUsElRlV2+uogjGQzIGU6C
         n7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698348987; x=1698953787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OTgf2Dvow9ZuXFPqFfbC0fdxBZgN8QcR7Q24NuIsbkQ=;
        b=eWv5tRCnqVvd+IEZbYGg5HDGT6F8WWzscz7iw6fRq40uDPMXeVjFR+uOoi4mLKT821
         ZbFkIlg1zOLfkIV2ui//l/qrBtAuMCsfr9qQIOfSbc2LCNtMDMh6hqDo7E7ZsqWp2dJ6
         GcGNswTgVDRVTQXNU3t8sTYWPXtsbZ9e7rff/f1ZrEoyn9oBFe9LU3CHw4lFEsGlI3lU
         5WpueE7+tK+z+xQ5eLRzatKWN+fATmXAMpnxCoVwGx2ycCGjDTiU2Qaj5P8S3nbbRV9V
         KQ2AK6uTzeKv1zSxQL3pBejuw/T8IZS9o2pVlit25i98EwQXclYHiieYhBPNtAdnPp5E
         QlSw==
X-Gm-Message-State: AOJu0Yxv8BAp/pj7i9dwZM8fC1w4a0drYsffx3nd5iCekAifrqoRBGB3
        W9qKGmWryc2erbazFd4ey+hAJA==
X-Google-Smtp-Source: AGHT+IFOlZ4mUTLecLw/FO20DFaae9bB4NAnizYV3Y4IKYS/iIm9yXm0Ntj2T8hWdq/pC8rojnFjgw==
X-Received: by 2002:a19:a411:0:b0:507:a089:caf8 with SMTP id q17-20020a19a411000000b00507a089caf8mr233719lfc.67.1698348987253;
        Thu, 26 Oct 2023 12:36:27 -0700 (PDT)
Received: from [172.30.204.84] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id n30-20020ac2491e000000b00507a0bb04efsm3086919lfi.195.2023.10.26.12.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 12:36:26 -0700 (PDT)
Message-ID: <2d191492-7fee-44f9-9de2-92821afa30d4@linaro.org>
Date:   Thu, 26 Oct 2023 21:36:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ARM: dts: qcom: Add support for HTC One Mini 2
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20231024-htc-memul-v2-0-8912940b6f95@z3ntu.xyz>
 <20231024-htc-memul-v2-3-8912940b6f95@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231024-htc-memul-v2-3-8912940b6f95@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/23 22:57, Luca Weiss wrote:
> Add support for this smartphone based on the MSM8926 SoC, codenamed
> "memul".
> 
> Supported functionality:
> * Power & volume buttons
> * ADSP
> * Magnetometer
> * Accelerometer
> * Touchscreen
> * Vibrator
> * SD card
> * Charger
> * USB
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
sdhci vddio should have regulator-allow-set-load

otherwise:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
