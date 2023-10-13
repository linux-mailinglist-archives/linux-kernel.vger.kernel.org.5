Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58EC7C8783
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjJMOJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjJMOJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:09:28 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406D2BD;
        Fri, 13 Oct 2023 07:09:26 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3b2b1a6fd5eso321281b6e.0;
        Fri, 13 Oct 2023 07:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697206165; x=1697810965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32q64sOF2d1XvMlGkpm0O35o7axtMas1mV8rP6bTVn8=;
        b=iw2k+HAuEPDhkAuHndh1Z9Uj5WBQ4OongTYhFJlddtTIlntpd+2nxt/bBcndzM82MR
         VTrOHtGmcxV9KUrOVmnAFAeepuDiPnFS0appF0iNbIHu5mcfGP64LlPPUTuzLkmUskF5
         KwZH+EK6+uUEgPKPtiOeVQ6qlct/rPglDWQPoCvTVyNoAocojp08PMA5JVht/WhwaR1W
         otdiT2nrzxScEjEGR6dPcNJBJIRGGsZl26GkdoaXN/DN/tx4BWVAps4/ryv5JV1rKMhu
         0k7MApEkDjDn8vrroPkJ92oNYonBZ2Fm0z3f2PkwaglhH5Pcu/b5sKwTKnfTdhPjkc0Z
         qeXg==
X-Gm-Message-State: AOJu0YzAnYZ6Y6n4qTVouyd3WVgau7WAAn4yxCgs518j+Wp0L/ibo54j
        SH4gvBBQId7I2TaLkB82kAhmGElLHg==
X-Google-Smtp-Source: AGHT+IE3WfnWPCV4ZgQOO+7n+hC2sS/a0WY7WfHDYyEnWNzabar4DxPdMiXBJQCW6Gy4BMVdliteAg==
X-Received: by 2002:a05:6808:1302:b0:3a9:9bb4:485c with SMTP id y2-20020a056808130200b003a99bb4485cmr37530634oiv.8.1697206165505;
        Fri, 13 Oct 2023 07:09:25 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o15-20020a0568080f8f00b003a747ea96a8sm747696oiw.43.2023.10.13.07.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 07:09:23 -0700 (PDT)
Received: (nullmailer pid 3793059 invoked by uid 1000);
        Fri, 13 Oct 2023 14:09:21 -0000
Date:   Fri, 13 Oct 2023 09:09:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        dmitry.baryshkov@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 3/4] media: dt-bindings: media: camss: Add
 qcom,sc8280xp-camss binding
Message-ID: <20231013140921.GA3773179-robh@kernel.org>
References: <20231012113100.3656480-1-bryan.odonoghue@linaro.org>
 <20231012113100.3656480-4-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012113100.3656480-4-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 12:30:59PM +0100, Bryan O'Donoghue wrote:
> Add bindings for qcom,sc8280xp-camss in order to support the camera
> subsystem for sc8280xp as found in the Lenovo x13s Laptop.

You don't need 2 'media' in the subject.

> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> This patch depends-on:
> https://lore.kernel.org/lkml/20231004161853.86382-2-bryan.odonoghue@linaro.org/T

Who is supposed to apply the above and this patch? Normally, this would 
go thru the media tree, but you didn't send it to them or the media 
list. You did Cc the clock maintainers which seems weird on its own, but 
I suppose based on the bot error that's because the above patch is a 
clock patch. But why would the clock maintainers care about this one. I 
can only guess your intent is for all of this to be merged thru the QCom 
tree. We shouldn't have to sort thru these series and guess though. You 
should state that unless you really don't know, but I'd expect you've 
been around long enough to know.

Rob
