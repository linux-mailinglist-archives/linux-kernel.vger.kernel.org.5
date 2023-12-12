Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8007780F25D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjLLQWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjLLQWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:22:36 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEFBE4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:22:42 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50bf3efe2cbso6760612e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702398161; x=1703002961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rIMOgJELoYzb7wiNwf62z7Kl2Dio0qgPcZXUZG0LhA=;
        b=ZTgcnQUeqbkqww46jnCJ/dYcQgOtGVztShtd4F3kzE4OfYUh6Z70TTps05hkFO0rUg
         W21ohjbDXj3eCSt5dElCtP4tCFFlqAlfwZcUtSAXyTc0H83jV9/jd7wrCIkfIUwUfjZf
         tjJrXOq5MskRDMqSzJoB23t/3ZNci8+RBrOQ9Xi8+sJ0AOJ3DjQmC/MEy+wD9xeKcpIJ
         rH0HUBiBP3gfojnBjuK2ozkpm4Gn3Chlvr42gbUR/TaOUgfoKcx6mRVr7EiIMBjzWa0Q
         xTOOIz8X7dOARaAUEc9iczoaJznvnJFXjvO/ry7SZIDEAasvSqWr1zi/aFgwVZQDPtcq
         5u5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702398161; x=1703002961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rIMOgJELoYzb7wiNwf62z7Kl2Dio0qgPcZXUZG0LhA=;
        b=uWn/p0puq3l0IcTOeY5nQ19hQ1O4qhfpcjUZ/+WN7GHF+HD3iAjcapbuIufBe3kesY
         eyxKQow6qsRFYV5Nzs9a4xZo93JP0uCy8XVuAccqDY2+LcxtXlAk0FLJBDRa0hJHM5zH
         QJx6fxJ19HqgPWhiYGmHfeeiT5GIJbHPxZQOTCb/jkQhbOlaDdxnVmDV5urQ/xXh56uy
         oZ0JCWNy9LBO15fn2LgHpDNpbcS03dQZ5F4z56/4GTlzVfHBH9d75fTm3xU9ru6FlH8y
         cRsDNt3EkAtQ9dXhDRXEvAEND7FRncF2rOwJHP4H3IT6ZTIemKT3gCvQdpmcytGEOvKG
         aoGg==
X-Gm-Message-State: AOJu0YwQ/92DYx+tBkMeyYftTpFtKttwoLOC6UmPsg5uGbM0NzZC+TpS
        hxlBPTzo7Ikg1xiJ/hTZmZMe8A==
X-Google-Smtp-Source: AGHT+IHsUDU7BTze8ti+y5I5/DuKnoBA/50hWRceCV0DyXBALJk4vmUkpqm9pO1iXitAVzNrUDFxAA==
X-Received: by 2002:ac2:58ca:0:b0:50b:debe:d35d with SMTP id u10-20020ac258ca000000b0050bdebed35dmr1450754lfo.133.1702398160591;
        Tue, 12 Dec 2023 08:22:40 -0800 (PST)
Received: from [172.30.205.64] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id h8-20020ac24da8000000b0050beffaa549sm1368848lfe.255.2023.12.12.08.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 08:22:40 -0800 (PST)
Message-ID: <fccf0f17-edf4-4f9e-b284-4ccc5e1a8167@linaro.org>
Date:   Tue, 12 Dec 2023 17:22:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e80100: Add missing nodes for CRD
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <20231212-x1e80100-dts-missing-nodes-v1-0-1472efec2b08@linaro.org>
 <20231212-x1e80100-dts-missing-nodes-v1-2-1472efec2b08@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231212-x1e80100-dts-missing-nodes-v1-2-1472efec2b08@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/23 11:24, Abel Vesa wrote:
> Add all missing nodes for the X1E80100 CRD reference device.
> 
> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> Co-developed-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
[...]

> +
> +	kybd_default: kybd-default-state {
> +		int-n-pins {
You can remove this level of indentation

Konrad
