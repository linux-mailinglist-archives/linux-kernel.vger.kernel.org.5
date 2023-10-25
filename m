Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424F17D6C78
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjJYM53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYM52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:57:28 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A2C8F;
        Wed, 25 Oct 2023 05:57:25 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id EC8D0401B5;
        Wed, 25 Oct 2023 17:57:17 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1698238638; bh=JzCgUGweZjRuxxNU1g3eIRDVzT4P0AzRXtHxoGPZHgY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BJxvSeoPB8gqOmJj4wyYR8fTLT5fJgrw2rumFOHlm2mWm1D9LBquF40UE68tag0e0
         gE13ZzabJCcd75kUGBBR5qhITZha5c4Hq6RlCJTRKGo7nqWxUQqSxHMLTFkpZZsieK
         qIM+RGw7wGqCwAzCNecDRCeU+Iq8HBmN/0WmoZCIcMDoCnD1DIgdkCZyA1ofEX5G8l
         1Lu37MoYZnlpeYiXwZ6swUTQUL3rpx4RGT54u19+40Fl6KpdIf4AzqC1aZNj05T6lE
         jftmKGyBPlBN36GUnxri26i5VWxxQ8L1ScmsPhmEpmLX0ehuPzxMgpVlV7LfKcO/zc
         qTz8Kf1+buwug==
MIME-Version: 1.0
Date:   Wed, 25 Oct 2023 17:57:17 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Lee Jones <lee@kernel.org>
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
In-Reply-To: <20231025122124.GO8909@google.com>
References: <20231023-pm8916-dtsi-bms-lbc-v2-0-343e3dbf423e@trvn.ru>
 <20231023-pm8916-dtsi-bms-lbc-v2-1-343e3dbf423e@trvn.ru>
 <169808265626.861066.13083505051202182067.robh@kernel.org>
 <53474576e3c860a1bb93f811cfe3964a@trvn.ru>
 <20231025122124.GO8909@google.com>
Message-ID: <eaa4a6e2d8539a0a772286f7f13ccc2c@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones писал(а) 25.10.2023 17:21:
> On Tue, 24 Oct 2023, Nikita Travkin wrote:
> 
>> Rob Herring писал(а) 23.10.2023 22:40:
>> > On Mon, 23 Oct 2023 11:20:32 +0500, Nikita Travkin wrote:
>> >> PM8916 (and probably some other similar pmics) have hardware blocks for
>> >> battery monitoring and charging. Add patterns for respecive nodes so the
>> >> devicetree for those blocks can be validated properly.
>> >>
>> >> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> >> ---
>> >>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 6 ++++++
>> >>  1 file changed, 6 insertions(+)
>> >>
>> >
>> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
>> >
>> > yamllint warnings/errors:
>> >
>> > dtschema/dtc warnings/errors:
>> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml:
>> > Error in referenced schema matching $id: http://devicetree.org/schemas/power/supply/qcom,pm8916-bms-vm.yaml
>> >
>> > doc reference errors (make refcheckdocs):
>> >
>> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231023-pm8916-dtsi-bms-lbc-v2-1-343e3dbf423e@trvn.ru
>> >
>> > The base for the series is generally the latest rc1. A different dependency
>> > should be noted in *this* patch.
>> >
>>
>> Somehow I missed the memo and thought it tracks -next...
>>
>> This patch depends on 7f590e3831 and 5cee843d56 in linux-next.git
>> They were applied in [1].
>>
>> I'm wondering if the bot just bails out when the "depend" is present
>> or there is some more sophisticated logic to suggest the base to it?
> 
> So is this good to go, or not?

IMO this patch should be good, it passes the check on today's linux-next
on my end.

The only concern might be that if someone runs dt_binding_check on
for-mfd-next, it would skip that file with an error since there is no
dependency yet.

If this is critical to you, I was going to respin this after the -rc1,
but if you can pick the schema now, I can respin the remainder earlier.

Nikita
