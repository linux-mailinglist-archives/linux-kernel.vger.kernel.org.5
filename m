Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15C47F8E01
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 20:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjKYTeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 14:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjKYTeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 14:34:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F357182;
        Sat, 25 Nov 2023 11:34:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FDBC433C8;
        Sat, 25 Nov 2023 19:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700940855;
        bh=ErjCfl4uXkdScmDZgG34jOu3Ae6PwvX0QAhlDCF/QmA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F0TKJUgqGIaoVdzZLpXtYi8tIvDIWpnmJYL0TIQTb3pnOec5C/I0n4mlLi2URZFzl
         t3JMaQV1nWYoeI6zKdjRIBAG3mcYHSDw7JT/0l+VdQFxb3w7AULO7hBuUImHhJ2/zP
         LcJvF6p4cyZHZDVZ8foGDPPCEQSYrTGNaPdGW5NrtDs3GLpvah5mbzNTovZjqHRxTt
         lbu5Z4czpHy/eb1yD+tk6RUVoVBOkWFIqIhYBiZfU7xvzH1yNTc5a4f0cn6jF/654F
         O+Ex4IBbZyngjuYmeeNyGZ2pcuj+oVsnNu7Dppk0Zy6Cn/gZmxTmZgIF8W8HFCDO1e
         pdWjGOgfVbxDw==
Date:   Sat, 25 Nov 2023 19:34:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        daniel.lezcano@linaro.org, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
        quic_amelende@quicinc.com, quic_kamalw@quicinc.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        marijn.suijten@somainline.org, lars@metafoo.de, luca@z3ntu.xyz,
        linux-iio@vger.kernel.org, lee@kernel.org, rafael@kernel.org,
        rui.zhang@intel.com, lukasz.luba@arm.com,
        cros-qcom-dts-watchers@chromium.org, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        kernel@quicinc.com
Subject: Re: [PATCH V2 3/3] dt-bindings: iio/adc: Move QCOM ADC bindings to
 iio/adc folder
Message-ID: <20231125193403.77400aca@jic23-huawei>
In-Reply-To: <CAA8EJprn7NfYAPGygus-Yxyu=kCiGYyEksVv9S3QkP5HNwVzVg@mail.gmail.com>
References: <20231116032644.753370-1-quic_jprakash@quicinc.com>
        <20231116032644.753370-2-quic_jprakash@quicinc.com>
        <f7065032-206f-423e-bb03-0b808ff16868@linaro.org>
        <CAA8EJprn7NfYAPGygus-Yxyu=kCiGYyEksVv9S3QkP5HNwVzVg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 17:27:53 +0200
Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> On Thu, 16 Nov 2023 at 13:44, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 16/11/2023 04:26, Jishnu Prakash wrote:  
> > > There are several files containing QCOM ADC macros for channel names
> > > right now in the include/dt-bindings/iio folder. Since all of these
> > > are specifically for adc, move the files to the
> > > include/dt-bindings/iio/adc folder.
> > >
> > > Also update all affected devicetree and driver files to fix compilation
> > > errors seen with this move and update documentation files to fix
> > > dtbinding check errors for the same.
> > >
> > > Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> > > ---
> > >  .../devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml       | 4 ++--
> > >  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 2 +-
> > >  .../devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml  | 2 +-
> > >  .../devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml    | 6 +++---
> > >  arch/arm64/boot/dts/qcom/pm2250.dtsi                      | 2 +-
> > >  arch/arm64/boot/dts/qcom/pm6125.dtsi                      | 2 +-  
> >
> > NAK, bindings are always separate from the other changes.  
> 
> In this case I'd even try to appeal :-)
> They are doing `git mv` and then fixing the failouts. I think this
> should be fine.
Agreed.  The only easy way around this would be to put some dummy headers
that include the new ones in old locations temporary basis then delete them later.
I'm fine with that if Kryzsztof prefers it that way.  Not too disruptive.

Jonathan


> 
> >
> > Please run scripts/checkpatch.pl and fix reported warnings. Some
> > warnings can be ignored, but the code here looks like it needs a fix.
> > Feel free to get in touch if the warning is not clear.
> >
> > Best regards,
> > Krzysztof
> >  
> 
> 

