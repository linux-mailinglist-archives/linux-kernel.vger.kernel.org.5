Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B27756C12
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjGQS3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjGQS2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:28:01 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFD31FFC;
        Mon, 17 Jul 2023 11:27:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689618414; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VljLj4OVMxfm78yJkQUtYu4wDlICS181Tw+EJBkTZfH2uTeG3Y0buvZT/WiPqcK4wJ
    9gRIamkL39lZQtVPKOL4eFw+E5sEwDpuV2lzBaNS8lOY0FfvAF1Nfs1yuKisRYPpN5jA
    8djrt+ZB5cM88zC/W4rzsX87zoPYKljPTq8qs5XD94zjmNYJgYGDq3T/1r2Lw3I9aM1p
    SqWg1iHiuT5rx6hwuAf+bKVBZ6nGFzocglKNPM1P8QQY6Ndrc1rqNiu9a5FZNg+ysEX8
    PS5QdyOv+b5ZkIBaaU4go0z1viqD4XUAxtA0caHxtljMXQUj4sFtLbetTZhbpfFrnXiC
    UC4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689618414;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=FGH/oUaQ4RyjF+KveTDJrIq7bF1n+Vvfi6tgzGQ25mA=;
    b=dMi55pBa5IX5eFMC8iB5LgB8kGDK8yXyHSaVUD7zyOcZCZmvLbgnaHvbB9Iok1PQMs
    1/47lfKoO+96U6RxQhCIHNk6InfzaCN6tzqLAaDmMV+gHMfdcpk66+tZ4W5JzvZrdDzv
    d08M3bTwe5HiorwO88wWI+hLqbVXDmc5NCqn6F8vuv6JDLVhewdwrfHScsMWpCNQ52Yo
    5IWFkIXkZr+TJ6SeAzn+4oLfouMmsldtQ7OZFKdkNrroPRM9fcpTn3K+QKN+X/M6Nhso
    fkmZtLymX97100gklpyfwKmGYaCZygUnxa90IvCilJBYih+4vlhf8BsFo9VR5QwsRWc0
    8vCg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689618414;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=FGH/oUaQ4RyjF+KveTDJrIq7bF1n+Vvfi6tgzGQ25mA=;
    b=Yj+Efc/2sKWi83nVQPskIXq71Kp8I02u2Iz6W5JSdMn7PSAwVfzKX1nSMoXKtbyeiF
    Q+2zYE/6zpvdATX+hnya4nhcDE9WE/6VV5CiE66P9L8AKhsKZ0n7snADyYgxeBcHwzFe
    efWpAo1Lzr01EGVqujOydofiMMFycxeV4yAVIrsPuqYg7GRiZpVirwpmM+Bc9YMak7Xq
    LhLQGonjizsdX/wDaRTNRyV16UsxCI8Uap0nVw6e4AYg9dOXAl3gexU0v/z6akF4Krs9
    K8hhqwPkQkcVyA+JJ5qR29C0BTwQkGJZhOfYFOzOcDxvHVfjooDlJE3roNXBMbMqIF+n
    MsqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689618414;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=FGH/oUaQ4RyjF+KveTDJrIq7bF1n+Vvfi6tgzGQ25mA=;
    b=YO7q5onkXqMFwL261aNMdoM1cWWRHqGTGJJurFROnp+bmi3rNn9p5pjv2cQbTHP6od
    JkmtsDziZeovY4Ga3fAA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z2L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z6HIQrZM7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 Jul 2023 20:26:53 +0200 (CEST)
Date:   Mon, 17 Jul 2023 20:26:37 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        quic_schowdhu@quicinc.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v8 3/4] arm64: dts: qcom: sm6115: Add EUD dt node and
 dwc3 connector
Message-ID: <ZLWHwnjjMkJx_ACH@gerhold.net>
References: <20230717103236.1246771-1-bhupesh.sharma@linaro.org>
 <20230717103236.1246771-4-bhupesh.sharma@linaro.org>
 <ZLUbyocjNT2bGvVt@gerhold.net>
 <CAH=2NtzM=jaVtjeHHO0rY0_wHu9==Jpdz4zx5nCK3gBh2kpL=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH=2NtzM=jaVtjeHHO0rY0_wHu9==Jpdz4zx5nCK3gBh2kpL=A@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 11:33:40PM +0530, Bhupesh Sharma wrote:
> On Mon, 17 Jul 2023 at 16:15, Stephan Gerhold <stephan@gerhold.net> wrote:
> >
> > On Mon, Jul 17, 2023 at 04:02:35PM +0530, Bhupesh Sharma wrote:
> > > Add the Embedded USB Debugger(EUD) device tree node for
> > > SM6115 / SM4250 SoC.
> > >
> > > The node contains EUD base register region, EUD mode manager
> > > register region and TCSR Base register region along with the
> > > interrupt entry.
> > >
> > > [...]
> > >
> > > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sm6115.dtsi | 50 ++++++++++++++++++++++++++++
> > >  1 file changed, 50 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > > index 839c603512403..db45337c1082c 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > > [...]
> > > @@ -789,6 +801,37 @@ gcc: clock-controller@1400000 {
> > >                       #power-domain-cells = <1>;
> > >               };
> > >
> > > +             eud: eud@1610000 {
> > > +                     compatible = "qcom,sm6115-eud", "qcom,eud";
> > > +                     reg = <0x0 0x01610000 0x0 0x2000>,
> > > +                           <0x0 0x01612000 0x0 0x1000>,
> > > +                           <0x0 0x003c0000 0x0 0x40000>;
> > > +                     reg-names = "eud-base", "eud-mode-mgr", "tcsr-base";
> >
> > TCSR is a separate hardware block unrelated to the EUD. IMHO it
> > shouldn't be listed as "reg" here.
> >
> > Typically we describe it as syscon and then reference it from other
> > nodes. See e.g. sm8450.dtsi "tcsr: syscon@1fc0000" referenced in &scm
> > "qcom,dload-mode = <&tcsr 0x13000>". This is pretty much exactly the
> > same use case as you have. It also uses this to write something with
> > qcom_scm_io_writel() at the end.
> 
> That was discussed a bit during v1 patchset review. Basically, if we
> use a tcsr syscon approach here, we will need to define a 'qcom,xx'
> vendor specific dt-property and use something like this in the eud
> node:
> 
> qcom,eud-sec-reg = <&tcsr_reg yyyy>
> 
> which would be then used by the eud driver (via
> syscon_regmap_lookup_by_phandle()).
> 
> But for sm6115 / qcm2290 this would be an over complicated solution as
> normally the eud driver (say sc7280) doesn't need tcsr based secure
> mode manager access. So defining a new soc / vendor specific
> dt-property might be an overkill.
> 

IMO a vendor-specific DT property is still better than messing up the
device separation in the device tree. The same "tcsr-base" reg would
also appear on the actual tcsr syscon device tree node. Having two
device tree nodes with the same reg region is generally not valid.

Something like qcom,eud-sec-reg = <&tcsr_reg yyyy> would at least make
clear that this points into a region that is shared between multiple
different devices, while adding it as reg suggests that TCSR belongs
exclusively to EUD.

Thanks,
Stephan
