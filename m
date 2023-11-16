Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80A97EE37F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345373AbjKPO7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345328AbjKPO7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:59:20 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF9AD53
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:59:16 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a3b8b113so1302501e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700146755; x=1700751555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wuJsJjmUw2d9PtB+l9SB05xhzzeK1y0VQYZA7F3rrLU=;
        b=wCwI/Z557/DsPIG7DlLAAp/JZuaNWlcJ2VoDWqyB0TV2ibTsKRh7VehWEBmEJQ62qc
         CZLhNLfFwOIXDeWS9FQ7gx9xvoGHqwY87SHUcdA1NGeAPjp7czPKYP8xPgDEhnI8oVpR
         ZQZfgHWtV28faUSILCdIdlwqvaa7kYHD9E62phgY91YYOAy04OPv5a/ok/X68CHtPUt3
         +EG9JrQvx+iD6J5xpWVu7wWE5xL/Ptwpt3vKvrGDF/S8G8hJOYbNv5ewvTmzpETRTB5v
         8ajKVNa/qQnKhNeI5PoULewDVppI7eK4wMO9eY4paCoxuPxEy8e6/DUWkCg4PPvNeio/
         uMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146755; x=1700751555;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wuJsJjmUw2d9PtB+l9SB05xhzzeK1y0VQYZA7F3rrLU=;
        b=GeLkFnakvm1ejsYtbbYejhtW9FgE24Px7vDwrotbzcBQXuwJae3Cwmqxa2M/RM8o1i
         nPpcFmY+nhmvJiaGaWm7uT4stbf1YBaXYYFtSl1Ru6bDAlsQn1c+d5mz3BTD3pSqjyXD
         c2ZbgnfnF4Z/sgv/VqENaHqalolfmrc91ckYgWTQrDVDR6qiyxEcmwJxR6iojAm/Rbv1
         1ZWHzq3boon3N7Q1blKYNRtp976YwZPK8iTjaU4YrIcotbOXFf1+HFkPpdVP2ZzqN7jT
         IYyyX1FVvkthdNQCj/eE7NPZ9GbH/am0gGgY5QPfVDdmJG/QE5f/ifJuRdHpgb4vGkoN
         kzYA==
X-Gm-Message-State: AOJu0YwUj4sFrO1V2L8+gKJg4BNJMeh8tXNN4kv2rbGXfgSylYugUsP8
        9qIleG1f1YFWdQ0oOd0neK3fig==
X-Google-Smtp-Source: AGHT+IEf8+qrlVb+GbRjYPGoEKsgRRhuDHuoMBNbQOIWd8XcfdkT2zFsm1SHWPJgOwBGPeC3uPrVUg==
X-Received: by 2002:a05:6512:247:b0:507:9e56:5b1c with SMTP id b7-20020a056512024700b005079e565b1cmr10925871lfo.13.1700146754757;
        Thu, 16 Nov 2023 06:59:14 -0800 (PST)
Received: from [172.30.204.128] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id y2-20020a199142000000b00509463003e7sm17278lfj.186.2023.11.16.06.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 06:59:14 -0800 (PST)
Message-ID: <32aacdd3-6d3c-40a8-8952-68e23d81dedf@linaro.org>
Date:   Thu, 16 Nov 2023 15:59:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable
 various remoteprocs
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231113-sc7280-remoteprocs-v2-0-e5c5fd5268a7@fairphone.com>
 <20231113-sc7280-remoteprocs-v2-10-e5c5fd5268a7@fairphone.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231113-sc7280-remoteprocs-v2-10-e5c5fd5268a7@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/23 09:56, Luca Weiss wrote:
> Enable the ADSP, CDSP, MPSS and WPSS that are found on the SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
