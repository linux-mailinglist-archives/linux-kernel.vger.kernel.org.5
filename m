Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA707FA868
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjK0Rzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjK0Rzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:55:39 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B0B186;
        Mon, 27 Nov 2023 09:55:45 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b565e35fedso2707974b6e.2;
        Mon, 27 Nov 2023 09:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701107745; x=1701712545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L26i2R31YBB32RHwf8xEa95wnS6W9yDbV0iLws6hOL4=;
        b=lPBmqeaDt0FwDc/LjvESwwy2aOFhGyFxjK77KJS39qAFQj4mFkTc+SPkbc3KXUx8sY
         gc/vRP29LwfWuSwGRPwT7xCjK2NZC/l2Jq5Ddix+BfNoqrsQn2QbdPBjbs4b7XACvnGP
         YIbq5RraazGc8zb6Xh0LiOt38arM3W9kNRdHD+uZkFnEAHTic5HV8OuRDIwC9WmySM8P
         tSJo4HLZhZzbtfWU5/uXeyuwJtQ8xCgAe1aiXl8iz4QQzwOTJYiYCuxRgGi4/deYbUpd
         HAmlcTx6bqVWqFBuOVJAxNVmyo/8wZnT9cw8uZmpcy1jhEQ5trAbgvrPgunzj4nm86GH
         fniw==
X-Gm-Message-State: AOJu0YxV9KwKDIaN2CtoVZasDHn7880rztDVoOT6rOwPShX1K2+QEGom
        wpFvnnHy2Fd+6ELhvaJk5A==
X-Google-Smtp-Source: AGHT+IHh5PLzpOWFfsx+tNMkyl2NpKyrg0r+4w5u4CMZNruFnsvNEiokfY7omCoyUGIRYIDk8GRdCQ==
X-Received: by 2002:a05:6808:10ce:b0:3ab:73a6:1469 with SMTP id s14-20020a05680810ce00b003ab73a61469mr18010811ois.14.1701107745157;
        Mon, 27 Nov 2023 09:55:45 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eh3-20020a056808274300b003b2e4b72a75sm1551295oib.52.2023.11.27.09.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 09:55:44 -0800 (PST)
Received: (nullmailer pid 1889222 invoked by uid 1000);
        Mon, 27 Nov 2023 17:55:43 -0000
Date:   Mon, 27 Nov 2023 11:55:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, vkoul@kernel.org, quic_gurus@quicinc.com,
        quic_rjendra@quicinc.com, abel.vesa@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        iommu@lists.linux.dev, quic_tsoni@quicinc.com,
        neil.armstrong@linaro.org
Subject: Re: [PATCH V3 5/5] dt-bindings: interrupt-controller: qcom,pdc:
 document pdc on X1E80100
Message-ID: <20231127175543.GA1880474-robh@kernel.org>
References: <20231124100608.29964-1-quic_sibis@quicinc.com>
 <20231124100608.29964-6-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124100608.29964-6-quic_sibis@quicinc.com>
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

On Fri, Nov 24, 2023 at 03:36:08PM +0530, Sibi Sankar wrote:
> The X1E80100 SoC includes a PDC, document it.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> v3
> * Rebased to the latest lnext. [Krzysztof]
> 
>  .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.
