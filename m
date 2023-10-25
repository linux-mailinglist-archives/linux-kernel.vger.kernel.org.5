Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615BD7D74B8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjJYTtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYTtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:49:46 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DC193;
        Wed, 25 Oct 2023 12:49:44 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1dceb2b8823so49781fac.1;
        Wed, 25 Oct 2023 12:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698263384; x=1698868184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlpnZS6vHRIFnFbC0pQo/A91UW+0pz54vArEwjVrVww=;
        b=LUyc8PU+GNTKhltVRNVptyX0JC3ROB1lDqdbTQvZ/Lhn9VUeUsL+gZIMnI+bUd01xC
         xXW7s3BYZS/NLL2oBLgIWlrgwyQDwGAjxdu0G7oOLJD2ZWHA+E6STkcf2AHFBrTGBsN4
         RTm7GeDskvW2QDy8363BCIY6d9FktI8/HwR460bU2nxjX+Nq8bLZJBLwjae/sjTzsu1Z
         oQbbyR+2A1QVIHq59kCYXKg3AWBnGitxyRZwHAP3dzMo3gENk1tnS6pEeSzAY4ydvM1/
         ab6v0HTyQH2m1Ef5x8wTim1vmxApe+8FcxjJoE6Rb/oqDag/GZ7LcvN7jXnLqX3ZEdKD
         gSiw==
X-Gm-Message-State: AOJu0YwjVSmHGNdLEftN8pK8dgISfZMO4nWTMLp/9ZZDtMCTUvHpAC2/
        V9ivHJkbh4VdPihLAmYnxw==
X-Google-Smtp-Source: AGHT+IGBHca4D69sq5SUb+4A1BYOlPKyV6+DnZxSCW2CC4ONvq8/C5HyP20X+NVQ6jOPYr1M+S+tgA==
X-Received: by 2002:a05:6871:34a1:b0:1e9:e413:b9d with SMTP id ni33-20020a05687134a100b001e9e4130b9dmr368135oac.2.1698263384044;
        Wed, 25 Oct 2023 12:49:44 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t1-20020a4aadc1000000b00581fc1af0a7sm124913oon.28.2023.10.25.12.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 12:49:43 -0700 (PDT)
Received: (nullmailer pid 1048139 invoked by uid 1000);
        Wed, 25 Oct 2023 19:49:42 -0000
Date:   Wed, 25 Oct 2023 14:49:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] dt-bindings: clock: qcom: document the SM8650
 Display Clock Controller
Message-ID: <20231025194942.GA1038327-robh@kernel.org>
References: <20231025-topic-sm8650-upstream-clocks-v1-0-c89b59594caf@linaro.org>
 <20231025-topic-sm8650-upstream-clocks-v1-3-c89b59594caf@linaro.org>
 <169824516120.243773.546101172844888564.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169824516120.243773.546101172844888564.robh@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 09:47:33AM -0500, Rob Herring wrote:
> 
> On Wed, 25 Oct 2023 09:32:40 +0200, Neil Armstrong wrote:
> > Add bindings documentation for the SM8650 Display Clock Controller.
> > 
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> >  .../bindings/clock/qcom,sm8650-dispcc.yaml         | 106 +++++++++++++++++++++
> >  include/dt-bindings/clock/qcom,sm8650-dispcc.h     | 101 ++++++++++++++++++++
> >  2 files changed, 207 insertions(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/clock/qcom,sm8650-dispcc.example.dts:18:18: fatal error: dt-bindings/clock/qcom,sm8650-gcc.h: No such file or directory
>    18 |         #include <dt-bindings/clock/qcom,sm8650-gcc.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/clock/qcom,sm8650-dispcc.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1427: dt_binding_check] Error 2
> make: *** [Makefile:234: __sub-make] Error 2

Looks like the series got split up in the delivery causing this.

Rob
