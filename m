Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A389E811D42
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjLMSr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjLMSr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:47:26 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2399BDD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:47:33 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50bfd8d5c77so8443941e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702493251; x=1703098051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oLN2dhkia1LQwK8gimJQPztmO5+yH/eFHely6bd0W6U=;
        b=tqRKP0Mauw7qtoq3BZxp0H8mtDNhWxs8X8mho6Wy7/XH3470ZAkRay6HHI5omvhKR6
         adY1GMCS7g+GUmADmn2ELCIQax4OFq3yjBMRA+b7IfH0mS4XMF4SJbLtfrhafn36hFgd
         njdndNDAZgflU0YdxeP0jDQl573MM4LI4VPZH4lSbZk2ePMkXHsyj8mIyafDv0TRIaWb
         37KhJbnsHQf8iaBg34fvDrXpmhGJ4hTF8vMGiUpTvH5RBF9QgkhRHLebDsIigj8qQTt+
         FmAhQI/R9ODUWc2RHRYr7oFmtSGaMcmfN8P8PAbGL0xOlqF3X5BNv11ukggtq/RO3zFY
         Cv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493251; x=1703098051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLN2dhkia1LQwK8gimJQPztmO5+yH/eFHely6bd0W6U=;
        b=d5u7VvHpIQxzeIcWV0BHdVRlxrHnuax5T85BSUfv94NI3TYU7GTRDGMm2zM2wNpxaV
         +47vkApIzHgQmTaRqTmFrXvumGR1yX7+Dtl24ERfpk7rEkIVALP6XBUzcDBkzvFZYTtd
         EsvMS9r6vwJSf6t+lXt3DW1m5kmITQcXMXfsEmjNdXFymbm/u9Wr7XRVrM7htBrMANy5
         SXjg6rnBAXBx26AscvrfXnxJmgzdBX05q0EU5U6NiVFK9RA1/u7pVfwRXm0RW6vPWHKY
         qDUI4ZQQVQVZeArtTHkPgpalGEqcBtbGGSJIzLMR3pf353K8aou8bDvIx+g4TP6/bX7U
         5DpQ==
X-Gm-Message-State: AOJu0YztqoKq7FdSJaEcaqqqvwW2uqBMHbJZG1V1nRWmD8frjL7kmYym
        qlycHu+62D9F5fpCDKZl7dsyyg==
X-Google-Smtp-Source: AGHT+IEaqMvOYhvY8FE/3LLDRyRP+xGD4h1A37XVeFl3tBKn9LZnhoj+UYXbCVzinqUDMG8CZp6KHA==
X-Received: by 2002:a05:6512:21cf:b0:50b:e29b:2f01 with SMTP id d15-20020a05651221cf00b0050be29b2f01mr1775813lft.264.1702493251329;
        Wed, 13 Dec 2023 10:47:31 -0800 (PST)
Received: from [172.30.204.126] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id f12-20020a19ae0c000000b0050bdf00f688sm1653687lfc.299.2023.12.13.10.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 10:47:31 -0800 (PST)
Message-ID: <56280966-834f-4410-b055-a314583a64e5@linaro.org>
Date:   Wed, 13 Dec 2023 19:47:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ARM: dts: qcom: sdx55: fix pdc '#interrupt-cells'
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
References: <20231213173131.29436-1-johan+linaro@kernel.org>
 <20231213173131.29436-2-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231213173131.29436-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/23 18:31, Johan Hovold wrote:
> The Qualcomm PDC interrupt controller binding expects two cells in
> interrupt specifiers.
> 
> Fixes: 9d038b2e62de ("ARM: dts: qcom: Add SDX55 platform and MTP board support")
> Cc: stable@vger.kernel.org      # 5.12
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
