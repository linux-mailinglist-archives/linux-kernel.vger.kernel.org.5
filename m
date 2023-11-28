Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB567FC25E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346619AbjK1RvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346611AbjK1Ru5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:50:57 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10C219B0;
        Tue, 28 Nov 2023 09:51:03 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b843b61d8aso3406574b6e.0;
        Tue, 28 Nov 2023 09:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701193863; x=1701798663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtDiBDpbSsaK/40eNfowXr9JW3UeNKxQY42yopiiEic=;
        b=R2WMQFrqMTfzdaBcOy1kZ27dghURAf8QeWtTyll8DatTny6Oaa7UlSrqAHvK+W4lMM
         KTsp3d2x23XCtd5I7zXt/T5qr2A2lPWhtXkQeEOm68UGsEvzH16PeWYnk+Djf8rhh7N+
         hViweyNB3pYW2afZ95CxWxjlx4GtiQOcLeZhQYwNHdtop6LARGpupgv/L+TU31a9bqn+
         2eteOGepY3oEPkJ5Pq2pT/sNZSaf+145m/BI4f+RvnvMfNUrr0U4yI/T4EIXXzrEXHdA
         L4CfEutzB7ve7OG6Oz6Tasfi1aYGneW4G00s/auloncGkKuK4GDI6ovwpNJRcvK0mcsA
         FtyA==
X-Gm-Message-State: AOJu0Yz45RSpzGSzjRJFBek/iTVAFnVReoY229l5Qbl2tDDqM/nqDqJW
        nzLi3Xct1GobZNkXMTxU7w==
X-Google-Smtp-Source: AGHT+IGyrf3xV7VF9mmcR/1MNWmRUWyPFWgPE84xGDUfKPMTqGRzo9+FNmbBO0RjyNoK6EO1MYUi2g==
X-Received: by 2002:a05:6808:1488:b0:3b8:402d:578b with SMTP id e8-20020a056808148800b003b8402d578bmr23511881oiw.25.1701193863065;
        Tue, 28 Nov 2023 09:51:03 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s4-20020a056808208400b003b83bb8dbcesm896556oiw.30.2023.11.28.09.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:51:02 -0800 (PST)
Received: (nullmailer pid 3558571 invoked by uid 1000);
        Tue, 28 Nov 2023 17:51:01 -0000
Date:   Tue, 28 Nov 2023 11:51:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-i2c@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/3] dt-bindings: i2c: qup: Document interconnects
Message-ID: <170119386108.3558514.18152654833892721560.robh@kernel.org>
References: <20231128-i2c-qup-dvfs-v1-0-59a0e3039111@kernkonzept.com>
 <20231128-i2c-qup-dvfs-v1-2-59a0e3039111@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128-i2c-qup-dvfs-v1-2-59a0e3039111@kernkonzept.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Nov 2023 10:48:36 +0100, Stephan Gerhold wrote:
> When the I2C QUP controller is used together with a DMA engine it needs
> to vote for the interconnect path to the DRAM. Otherwise it may be
> unable to access the memory quickly enough.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
>  Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

