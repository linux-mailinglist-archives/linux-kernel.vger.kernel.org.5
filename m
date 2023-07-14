Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AA7753F68
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbjGNQAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbjGNP76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:59:58 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF3830F8;
        Fri, 14 Jul 2023 08:59:57 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-78666994bc2so84840039f.0;
        Fri, 14 Jul 2023 08:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689350397; x=1691942397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhWilL1LDJclcIynNiV1DfwyLs7Tb6ThykZ+9i/Tj/s=;
        b=AyQCq31PWcf+xJWbX3WPnMVFXenety75Jgmny6/rMC7YS4Bt39gNOPCQMPmzYs2vVG
         zgI7lSEW77jxZN/FbL7DwHILwX3UB3N5KP1F9bt9eEAm3USBOW+c6ksXLGOVSz6WJhSg
         Hyf8vtJ4yfbga2zHb0F9+sJ0RIL4gIjkYF5N5OZdhqfirci+iT2tCgnKxxxR+PSrKK/m
         7SCY2Znxvili4PECdOlxziWTxYwyySoYQa/ms0ZZJ++R9juNBdORpOr6emB8k9M8jZY3
         5ksa+CwZ2OjD6pUDbJU1laB6xxdCokx3x55KGbZpD4NZKIX2AVgECQFqSv+m4UhhvId7
         +q/Q==
X-Gm-Message-State: ABy/qLZmje//VacPH3qPqbmlFHpkC7C8WDAzm9S06dBAjvk3VSGHpDBj
        zVH0gf0iPvT+upY+6mUWtg==
X-Google-Smtp-Source: APBJJlHl4igHd55kIg5JA+/Gp6qSaP9UI5ls1BVwtIgtbGzvXbIWy/f2aaX7CDOchUR55xiohqRasg==
X-Received: by 2002:a6b:4906:0:b0:786:71d0:ff9b with SMTP id u6-20020a6b4906000000b0078671d0ff9bmr4867420iob.10.1689350397087;
        Fri, 14 Jul 2023 08:59:57 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id cu5-20020a05663848c500b0042b37080b23sm2526351jab.73.2023.07.14.08.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 08:59:56 -0700 (PDT)
Received: (nullmailer pid 3920717 invoked by uid 1000);
        Fri, 14 Jul 2023 15:59:54 -0000
Date:   Fri, 14 Jul 2023 09:59:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kathiravan T <quic_kathirav@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, quic_saahtoma@quicinc.com
Subject: Re: [PATCH V2 1/2] dt-bindings: arm: qcom,ids: drop the IPQ5019 SoC
 ID
Message-ID: <20230714155954.GA3919199-robh@kernel.org>
References: <20230712041912.398724-1-quic_kathirav@quicinc.com>
 <20230712041912.398724-2-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712041912.398724-2-quic_kathirav@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 09:49:11AM +0530, Kathiravan T wrote:
> IPQ5019 SoC is never productized. So lets drop it.

You need to remove the user before removing the definition.

> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
> Changes in V2:
> 	- Updated the commit message with the precise information for
> 	  dropping this ID
> 
>  include/dt-bindings/arm/qcom,ids.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
> index bcbe9ee2cdaf..179dd56b2d95 100644
> --- a/include/dt-bindings/arm/qcom,ids.h
> +++ b/include/dt-bindings/arm/qcom,ids.h
> @@ -250,7 +250,6 @@
>  #define QCOM_ID_QRU1000			539
>  #define QCOM_ID_QDU1000			545
>  #define QCOM_ID_QDU1010			587
> -#define QCOM_ID_IPQ5019			569
>  #define QCOM_ID_QRU1032			588
>  #define QCOM_ID_QRU1052			589
>  #define QCOM_ID_QRU1062			590
> -- 
> 2.34.1
> 
