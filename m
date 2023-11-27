Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F78F7FA77F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343496AbjK0RGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343820AbjK0RGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:06:21 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7EB3C16;
        Mon, 27 Nov 2023 09:02:23 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ce2b6b3cb6so2739406a34.3;
        Mon, 27 Nov 2023 09:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701104543; x=1701709343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egdCKcTL5F1nxl2XwDwu8DS/+z9OxCWFUwjLPJGVEYM=;
        b=urHBs7tqGEgjp5TNs8Qa41tId4Fco5Y8T4iJs1dYSx30hJ1duG9k+k28ZrDBi7ofwd
         hsXtTmrHrOfMAgVLegk4/12Y4+R1+XRmYH/rYW9gt6VG1WLqZLoHE2OoXjbKBWyTR8B5
         FCCyFIkn5mgALEuY3MoCmrLSptDKBt0bfbbLs+0aXQ+8wylZbxC29HDy7FBiaiZo5Mhq
         Biuz+MONScMgPud3qt7d7bQGTxvzlDYuPNn8nHRcvJ2988Z7yl9Tm5aUGSv5F/BFTQgu
         5bj08/r+YshEmVYc2nrYqQ6DLaPj12OwH/wSAqmCSXqXzQs/MGWdwOuzstZVVYY8kWN5
         CW0Q==
X-Gm-Message-State: AOJu0YzwORhZKnTfcmW8Cq7mYWKHwsBMdmdk6MasKh3pxtEzNan+9Puo
        ys31yB0jpJEF//3Oi2E7ZrDJBXXMyA==
X-Google-Smtp-Source: AGHT+IGu7+X9A7HDeL5cLIqKrFNpUqAS8XGhG7FU7efpiBVxtKmwRfmvKUAtyTz1NNkDSJZWu0usIA==
X-Received: by 2002:a9d:6944:0:b0:6d8:11f1:de4d with SMTP id p4-20020a9d6944000000b006d811f1de4dmr8299962oto.32.1701104542837;
        Mon, 27 Nov 2023 09:02:22 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i14-20020a4aab0e000000b0057327cecdd8sm1529024oon.10.2023.11.27.09.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 09:02:22 -0800 (PST)
Received: (nullmailer pid 1424446 invoked by uid 1000);
        Mon, 27 Nov 2023 17:02:20 -0000
Date:   Mon, 27 Nov 2023 11:02:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Conor Dooley <conor.dooley@microchip.com>,
        andersson@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        konrad.dybcio@linaro.org
Subject: Re: [PATCH v5] dt-bindings: interrupt-controller: Add SDX75 PDC
 compatible
Message-ID: <170110453222.1422827.15955753691131343417.robh@kernel.org>
References: <20231117082829.609882-1-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117082829.609882-1-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Nov 2023 13:58:29 +0530, Rohit Agarwal wrote:
> Add device tree bindings for PDC on SDX75 SOC.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> 
> Hi,
> 
> Changes in v5:
>  - Rebased on 6.7-rc1
>  - Removed all the applied patches from this series.
>  - Link to v4: https://lore.kernel.org/all/1686311438-24177-1-git-send-email-quic_rohiagar@quicinc.com/
> 
> Changes in v4:
>  - Addressed some of the dt bindings check mentioned by Krzysztof.
> 
> Changes in v3:
>  - Clubbed all the dt node into a single patch as suggested by Krzysztof.
>  - Removed the applied patch.
>  - Addressed some comments from Konrad and Dmitry.
> 
> Changes in v2:
>  - Added the CPUFreq support patch.
>  - Collected the Acked by tags.
>  - Addressed some minor comments from Konrad.
> 
> Thanks,
> Rohit.
> 
>  .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

