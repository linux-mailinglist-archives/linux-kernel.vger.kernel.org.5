Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF627E4B0B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343852AbjKGVnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbjKGVnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:43:13 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668AA10E4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:43:11 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507cd62472dso164576e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 13:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699393389; x=1699998189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/AXlSZgo6Ub17duhdLAffFaCrkSr2KsSchaKezTprak=;
        b=tC06FUe8Ib+cX2F52toMEsqZ373ILnVeNLBTwu2PD63fnwJzM357XmnG1zODq0skTU
         lO/wzSOqREUJp3fq/4x6/pQ8F50biKKAy86LUhcBUJ8LhKmRALlZlSD2j5bVFHFOvrRr
         0ql/cRUPpwF6ExGg9f8d8ZrMIYDg2lvEsq+dq3SaakzCNkxWABHOet4sIVyF0NluP19I
         lCSxIaYpgzmZUUpzrgBpVPC1ekyKxsgKDp3U49JwN2OkGrnaCjuE9Hc5pQbIYdrajMDD
         d3XbHprzZW2EW35gxQWCiKlJ3K5gzIIItGpFt5VImf3bihRV2f+yxOvDXyoU2HGvHmlH
         seAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699393389; x=1699998189;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/AXlSZgo6Ub17duhdLAffFaCrkSr2KsSchaKezTprak=;
        b=j372R4dE//5cHr3F+HEcCoExyDOEpjlilPoY3LVEcsGyqHulrM59Wal6Z7teoE3/ev
         8jsVnvyOt6+AppAHpC0ROw3CjrPg7WdEkCp88x1RkDR+ytJozjFigv8u+OQ4vM98cKM9
         AHdwn0YvA7DZPZtPM5quvnKa7PwEAEbU6ktYVXZvU9Pj0KJ8Zitv4ebFDfMoXTh4zTqI
         O5QR2XoVIQ2+/gPAtWX4g3UwtCaMXfWSfPPBbx51Nfrc88fi4OhgVg9a8LwPq7J56Cb5
         Zu7ipvkGrSZ16lm9wyjvO1pTHg4glmNny4WMOb+/cbORSK/mga/FzqivGfamGknUI0hG
         K4GQ==
X-Gm-Message-State: AOJu0YzVaoQFhZgtZqgJqSpLiCrYaV4pVicps3jD+WKwqcZUo/l1kXox
        nkuzqMK/Qzi/3zjBg/G2r/HZQw==
X-Google-Smtp-Source: AGHT+IHbFHwp/wiPt3tnJrzJHbNIh/1ZtBr0DHDmTnDnIKj7SfbwVlpDFFm25GM2jJqAisEvWw6Lcw==
X-Received: by 2002:a05:6512:952:b0:507:973f:a7dd with SMTP id u18-20020a056512095200b00507973fa7ddmr1203123lft.26.1699393389665;
        Tue, 07 Nov 2023 13:43:09 -0800 (PST)
Received: from [172.30.205.109] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k11-20020ac2456b000000b00509366f4f7esm460879lfm.121.2023.11.07.13.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 13:43:09 -0800 (PST)
Message-ID: <ff8532ca-fe74-4f52-bab9-b14f6a4599b1@linaro.org>
Date:   Tue, 7 Nov 2023 22:43:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] media: qcom: camss: csiphy-3ph: Add Gen2 v1.1
 two-phase MIPI CSI-2 DPHY init
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, vincent.knecht@mailoo.org,
        matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231105-b4-camss-sc8280xp-v3-0-4b3c372ff0f4@linaro.org>
 <20231105-b4-camss-sc8280xp-v3-3-4b3c372ff0f4@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231105-b4-camss-sc8280xp-v3-3-4b3c372ff0f4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/23 18:45, Bryan O'Donoghue wrote:
> Add a PHY configuration sequence for the sc8280xp which uses a Qualcomm
> Gen 2 version 1.1 CSI-2 PHY.
> 
> The PHY can be configured as two phase or three phase in C-PHY or D-PHY
> mode. This configuration supports two-phase D-PHY mode.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
Makes it sound like the current 2ph/3ph split is rather nonsensical?

Perhaps we should restructure it to match hw revision? Especially since
one can get it from the hardware itself..

Konrad
