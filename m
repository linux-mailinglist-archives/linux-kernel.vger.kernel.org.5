Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200E17DC17C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjJ3VCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjJ3VCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:02:43 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D6EDD;
        Mon, 30 Oct 2023 14:02:41 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b3e7f56ca4so2750357b6e.0;
        Mon, 30 Oct 2023 14:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698699760; x=1699304560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7f1xtNDZ2uDSqBxTL8RZj3B3UCu3G/3InhqrWq5zmE=;
        b=EHN889V/7iU1eJNrtj8FEdvl0+Oun6scFR4S6u0gLSj2athWAKZamWJClvcqdC0tZY
         4f9L3pW0Gdu07Cg8lMRvUngLAAGVNAuE5owrFfMn4yVRZ5PyVfu1ftylJa7vK30oxW7F
         1gwWKvt9P17SPExvhSCQse/GB2kgEPAS+Y7iDwGefc/Wx8kutn5bdaUi0WMu+M6Xt3iE
         AGQzp1kMAy6uvTpT5rLvQkV8RToEhrjXGTkE7KADGKM3BupCN3NQ4HCVsBRSdHuxtbeT
         3awYiB2phlg1BFJD11655q+xqbWrEy5yeklw4arQL4+rqFIFgH+G1j5IC0I02FfNy6hz
         HrcQ==
X-Gm-Message-State: AOJu0YyqLl90bsuPILWDIzzBlOLhu14ghO+SlagrqfyoLvSH2Vvc1/7m
        2e53B2V7OXVM/B4jy9HG3j7AIbrMJg==
X-Google-Smtp-Source: AGHT+IEIAyLxg6HwrCzx3hlGBX4hCgvdOO1NyX+dV0BfyIjLzSLOUFRLFUBIowlOSbqHK1sdnH83zQ==
X-Received: by 2002:a05:6808:1526:b0:3a7:4878:235a with SMTP id u38-20020a056808152600b003a74878235amr11894866oiw.29.1698699760623;
        Mon, 30 Oct 2023 14:02:40 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0568081a1c00b003b274008e46sm1524847oib.0.2023.10.30.14.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 14:02:39 -0700 (PDT)
Received: (nullmailer pid 2457362 invoked by uid 1000);
        Mon, 30 Oct 2023 21:02:38 -0000
Date:   Mon, 30 Oct 2023 16:02:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Rao Mandadapu <quic_srivasam@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] dt-bindings: soundwire: Add reference to
 soundwire-controller.yaml schema
Message-ID: <169869975649.2457261.10866906758422041610.robh@kernel.org>
References: <20231016155537.2973625-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016155537.2973625-1-robh@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Oct 2023 10:55:37 -0500, Rob Herring wrote:
> The soundwire-controller.yaml schema already defines the form for devices
> in child nodes, so there's no need to do the same in the QCom controller
> binding. Add a $ref to the soundwire-controller.yaml schema and drop the
> child node schema.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/soundwire/qcom,soundwire.yaml       | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 

Applied, thanks!

