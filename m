Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6C77A21A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjIOO74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjIOO7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:59:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C0C10D;
        Fri, 15 Sep 2023 07:59:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52969C433C9;
        Fri, 15 Sep 2023 14:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694789990;
        bh=A21SBk79usPEjw1XUt9dSJPMgbCWV6UEMjwE6HhbYMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LlOn7YDxtz9tg+ngRqO/KxN8xHZl8JF3jNCBW7BlL5UBz6r8EZsBtAI5iFpz/A4Lf
         6tcdotMybw5J5x78GH2/Z6Vk3DyTn+/EzyaS01wMJi6P1oZMqOjak2V6P0spemllzD
         TbFVMqhjjdSEE+7SnDvFqmV8Tmx7sl3v5RPEXf8Yv7Glai2tbLbKDhilHamd39ljWk
         yOHz9BEIYql1JRKItl6uR6SLAP6RvB3T4Tzaub3IM65qih4LFsC3TJ946KlVjJ7pbQ
         w5Y99R2VMds4Xhk+D2Q/fWffT9vN92KA0MGcFfLEjyFZk3ZswpmOtMeuM0pJbCdF0E
         PyhbAwviYmXhA==
Received: (nullmailer pid 3718886 invoked by uid 1000);
        Fri, 15 Sep 2023 14:59:47 -0000
Date:   Fri, 15 Sep 2023 09:59:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tengfei Fan <quic_tengfan@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_shashim@quicinc.com, quic_kaushalk@quicinc.com,
        quic_tdas@quicinc.com, quic_tingweiz@quicinc.com,
        quic_aiquny@quicinc.com, kernel@quicinc.com
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: Add SM4450 pinctrl
Message-ID: <20230915145947.GA3716246-robh@kernel.org>
References: <20230915015808.18296-1-quic_tengfan@quicinc.com>
 <20230915015808.18296-2-quic_tengfan@quicinc.com>
 <6f40ee72-b763-c58d-44df-ea40d1309820@linaro.org>
 <35371580-8e5a-4f72-aec2-951268c296a3@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35371580-8e5a-4f72-aec2-951268c296a3@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 03:30:16PM +0800, Tengfei Fan wrote:
> 
> 
> 在 9/15/2023 3:04 PM, Krzysztof Kozlowski 写道:
> > On 15/09/2023 03:58, Tengfei Fan wrote:
> > > Add device tree binding Documentation details for Qualcomm SM4450
> > > TLMM device.
> > > 
> > > Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> > 
> > ...
> > 
> > > +
> > > +patternProperties:
> > > +  "-state$":
> > > +    oneOf:
> > > +      - $ref: "#/$defs/qcom-sm4450-tlmm-state"
> > > +      - patternProperties:
> > > +          "-pins$":
> > > +            $ref: "#/$defs/qcom-sm4450-tlmm-state"
> > > +        additionalProperties: false
> > > +
> > > +$defs:
> > > +  qcom-sm4450-tlmm-state:
> > > +    type: object
> > > +    description:
> > > +      Pinctrl node's client devices use subnodes for desired pin configuration.
> > > +      Client device subnodes use below standard properties.
> > > +    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
> > > +    unevaluatedProperties: false
> > > +
> > > +    properties:
> > > +      pins:
> > > +        description:
> > > +          List of gpio pins affected by the properties specified in this
> > > +          subnode.
> > > +        items:
> > > +          oneOf:
> > > +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9])$"
> > 
> > This is still wrong. How many GPIOs do you have? Please open existing
> > bindings for recent device (e.g. sm8550) and look how it is done there.
> yes, will update to "^gpio([0-9]|[1-9][0-9]|1[0-2][0-5])$".

What about 106, 116, etc.?

Rob
