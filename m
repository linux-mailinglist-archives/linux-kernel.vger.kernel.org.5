Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4BA7D6B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343648AbjJYMVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbjJYMVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:21:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F84137;
        Wed, 25 Oct 2023 05:21:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F330C433C8;
        Wed, 25 Oct 2023 12:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698236490;
        bh=Okz7c5dGviB2uHQSZqH4cKSK6Sowbf5t1NKnOKrQ7hw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IkXkYfyS3NZWmbxzxm3uLKvX7SCxiEwxnoMdBNTx2FFRQ3GvZxLWZ6Kpd/1+VlSdT
         giw07NoUWUHq03K3+USdePtGfOarLh0Gp3E264Q/6f9x2QCBuLAX6nEBymy6EGY3JE
         LzyLVlHq7LSQQWIhfHTDVSp7wUy/pGubLjuoCiTVGYZj6rl5cwE+vs0gkW8Mt42GHB
         Z/59EbxnQYi5UMB66yOUtPmTEv295OnXWzGYbKs70pRM6GP/nrXDoPxecLB5wY1v6B
         B0OFBGEdRtX+3q8SUHv0687Dp5PBEd+GeaPWDkKNOPBJGBn1AG1PHFlM/YgpR9Y2R3
         wvw+0QwNv/Blw==
Date:   Wed, 25 Oct 2023 13:21:24 +0100
From:   Lee Jones <lee@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     Rob Herring <robh@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: qcom,spmi-pmic: Add pm8916
 vm-bms and lbc
Message-ID: <20231025122124.GO8909@google.com>
References: <20231023-pm8916-dtsi-bms-lbc-v2-0-343e3dbf423e@trvn.ru>
 <20231023-pm8916-dtsi-bms-lbc-v2-1-343e3dbf423e@trvn.ru>
 <169808265626.861066.13083505051202182067.robh@kernel.org>
 <53474576e3c860a1bb93f811cfe3964a@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53474576e3c860a1bb93f811cfe3964a@trvn.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023, Nikita Travkin wrote:

> Rob Herring писал(а) 23.10.2023 22:40:
> > On Mon, 23 Oct 2023 11:20:32 +0500, Nikita Travkin wrote:
> >> PM8916 (and probably some other similar pmics) have hardware blocks for
> >> battery monitoring and charging. Add patterns for respecive nodes so the
> >> devicetree for those blocks can be validated properly.
> >>
> >> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> >> ---
> >>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml:
> > Error in referenced schema matching $id: http://devicetree.org/schemas/power/supply/qcom,pm8916-bms-vm.yaml
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231023-pm8916-dtsi-bms-lbc-v2-1-343e3dbf423e@trvn.ru
> > 
> > The base for the series is generally the latest rc1. A different dependency
> > should be noted in *this* patch.
> > 
> 
> Somehow I missed the memo and thought it tracks -next...
> 
> This patch depends on 7f590e3831 and 5cee843d56 in linux-next.git
> They were applied in [1].
> 
> I'm wondering if the bot just bails out when the "depend" is present
> or there is some more sophisticated logic to suggest the base to it?

So is this good to go, or not?

-- 
Lee Jones [李琼斯]
