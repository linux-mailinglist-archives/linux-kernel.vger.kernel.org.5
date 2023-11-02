Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC607DF7C6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376954AbjKBQem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347664AbjKBQek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:34:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79CC18E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 09:34:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so748798f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698942872; x=1699547672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pf6+egC7wEh4Nlc1mgScW1ILeruY7HuDBJxg1UYN0M8=;
        b=wOiwZgvYjp0ReUvC7YBIm7zrAbvhsX9u6tIY88Jjbi4O+9wV7ld+3jsEQEswvqh0H9
         zp++/Vt6Afq33RULvZujOdvwM1m40TwB8y86rMrl4wiBKUw5z8EBpeNc+arH9uLzGm90
         +QQ9nvAtzMxA6fXxBXTClxg5IStN5tJS8bXx6zxNPAGuWqI+EbbfUGN7AZrOh4QHHcPQ
         MFpLNxMHIXEGbgExIw35dNUXYM7m8lAjwWz1akGzeaiywwF+bmLOXdjQOfKGfBPWcTXs
         6kii7jC9qDL1YF9hECl9Nurh3gyPTiQ6M2LihI4cmG53hZQTIIs2yp5r8Lze9moau5Mz
         jUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698942872; x=1699547672;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pf6+egC7wEh4Nlc1mgScW1ILeruY7HuDBJxg1UYN0M8=;
        b=EFUONYw5xDc+A7dX9os4dtfVway75y6juqHn7sUq/nvg/gCu4pYMit1QEfjaxhcLfH
         bdKw6zeKs5jz1sqOr+BiBaB3hfi14Z8FbQwhKdzD50w90pNxBu+RSDwq1xJlShCF6Qiy
         HjZZe3R5MwRBCnPVvzHvjBVedbC1SkXBlvO8NS3lNK1oHXt0BoSgIkpli0VY2gLTnCck
         9vwx8/cHoyxw7mdlBdZAjAw61xcs1uBaynCZz2EAhpOnQmp9oSZMpFNswPqdovm0lAkf
         kMvDltbFGAx3NnlWXoUnpNOBDsguXqr64CQ+g8rpnr+ovUxhaw/Ws4YlfDbRkqV0PoGp
         RjNQ==
X-Gm-Message-State: AOJu0YxVoqBbWLhA6YqtIY1nDRB4dLX+Brw1RADIG+Lp+v3JlTRqcP87
        pmb0+LRY01YkF1rGGABwPe58dQ==
X-Google-Smtp-Source: AGHT+IGtoGUpxxIbCzigG2VX+swrGvRJcm+9x+JnerHx+hb4qtVy636oxKeC9OepR+OM/OtMm1CkVg==
X-Received: by 2002:a5d:6d06:0:b0:32f:8b51:3708 with SMTP id e6-20020a5d6d06000000b0032f8b513708mr34589wrq.2.1698942872155;
        Thu, 02 Nov 2023 09:34:32 -0700 (PDT)
Received: from [192.168.67.140] (92.40.204.238.threembb.co.uk. [92.40.204.238])
        by smtp.gmail.com with ESMTPSA id j20-20020a05600c191400b00407752bd834sm25019wmq.1.2023.11.02.09.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 09:34:16 -0700 (PDT)
Message-ID: <272a9764-1cae-4d86-88b1-00175de83333@linaro.org>
Date:   Thu, 2 Nov 2023 16:33:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/8] dt-bindings: usb: qcom,dwc3: Add bindings to enable
 runtime
Content-Language: en-US
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, quic_wcheng@quicinc.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_jackp@quicinc.com
References: <20231017131851.8299-1-quic_kriskura@quicinc.com>
 <20231017131851.8299-2-quic_kriskura@quicinc.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20231017131851.8299-2-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/10/2023 14:18, Krishna Kurapati wrote:
> Add enable-rt binding to let the device register vendor hooks to
> core and facilitate runtime suspend and resume.

Hi Krishna,

 From reading through these patches, it's not clear to me why this 
behaviour should be conditional on a new devicetree property. Are there 
some platforms where this behaviour would be undesirable? And if so then 
would it be possible to determine this based on the QSCRATCH registers?
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>   Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> index cb50261c6a36..788d9c510abc 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -151,6 +151,11 @@ properties:
>         HS/FS/LS modes are supported.
>       type: boolean
>   
> +  qcom,enable-rt:
> +    description:
> +      If present, register vendor hooks to facilitate runtime suspend/resume
> +    type: boolean

A Krzysztof pointed out, properties should define the hardware 
behaviour, not tot the implementation details. For this case the 
hardware isn't wired up to vbus, so maybe something like "qcom,no-vbus"?
> +
>     wakeup-source: true
>   
>   # Required child node:

-- 
// Caleb (they/them)
