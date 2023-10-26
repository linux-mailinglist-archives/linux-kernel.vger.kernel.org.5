Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B9B7D88DB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjJZTSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZTSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:18:02 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A62AC;
        Thu, 26 Oct 2023 12:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698347875; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MAyPAt6Fw8HBzoOrR3mTRFlSYcoTN/biTPt+LZ49ZNHY1AevjLZ+hOrFs7PIg/jxQq
    0Xe/AzW0EHyXJTZmudh3qqg8F/X45IPRCLd7RAZwyMkA2OrBhAl4YVQEmnXJ33WEs665
    uuHj9lMABoMFQyNldDPiiGLhnF62GfyeqDOOwYSo3fcd/JH3R4PJH71MTVMh1muP/y1u
    btbtWjx4exsW6jZKjA64XdA6qpU1H8bPfVff5Gse3YjnkWQUpobbqQwwMUB1CnQoeR5E
    whU7prFkAg9pXm+HkJJKtxSp7ROtk2rqcBhw+dmqHZB7z1YJESzsjaS5oXQl1erQb9vc
    A7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698347875;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3RRTbCKgym2ZKAfKmnEa/WEdD9osQqu4/PX3qrE8WD8=;
    b=eGUXKIxOK0rVVM85nLOb5L47o7IIcIhFFDTQgfuEPsGRA0dK3vKlhablGlWJ3Tm4HG
    eylRbPc5L+kZhAwE2W1IZKHgvXvKyvsdZL3zx4QNM/UxAg7XQ+MmfZUv3L66W4Pk2+yk
    7Lhmgga4K2Xdu0CfNXDFXg5iD14HOG9hAbbxjllOG9yyMfWRWEoiGkyX82eovfOwJLBC
    t6eBIvme1fQf8F/yF/IyoetcjwetJ9lg3Y0rS3mAd6SVcNXhpBl4wOozdpG1fVW+LzKR
    ump9pi4BP9djoYpBxdiNk+wWzdqkhEsRyopASw9sSfo870m4tC8lt29ot0vTi32VUO4K
    YFlA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698347875;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3RRTbCKgym2ZKAfKmnEa/WEdD9osQqu4/PX3qrE8WD8=;
    b=ReOeW7TnoeZqegJf5JfRuaRAn8UyaJKgkKvyku4ilimr1OcwczHexvCssg1vLmCldS
    R4NKuv5Kg2EefE+NAO7EA6LhfOLjHeegbmTq93tv7u7q4TswYgFJZ61d78E071SFjsZz
    RBdMdXDhj2pLFMR+GVFdB9pjMCT4LREbvQN9jXKpkTmkSosS3fw46OswbN+T8OCyUfc2
    Mx8nxrxGwiTxorjDxCuE+q3dzc+ZtnnC3+YuP0TYgCFtS56OyWrsjJC6dzCIx2bJgLre
    vYOT4EuArJ8rXpCF44CymJSCLpUjYNscaOdNDssNp63Xp1D6BT4Ze9Q7GSJEO9jSnKug
    uU1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698347875;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3RRTbCKgym2ZKAfKmnEa/WEdD9osQqu4/PX3qrE8WD8=;
    b=xsqt+VygVZfAOk6OK0oxcjaIseydbe43WzIKNFEaNonstiAHum+ybBY99SCsTc5rn9
    f4UJimc1W89HIbMBFUAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA95vh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Lbb8e2z9QJHs4iy
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 26 Oct 2023 21:17:54 +0200 (CEST)
Date:   Thu, 26 Oct 2023 21:17:48 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Nikita Travkin <nikita@trvn.ru>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: pm8916: Add BMS and charger
Message-ID: <ZTq7XGz4Ux8lYQho@gerhold.net>
References: <20231023-pm8916-dtsi-bms-lbc-v2-0-343e3dbf423e@trvn.ru>
 <20231023-pm8916-dtsi-bms-lbc-v2-2-343e3dbf423e@trvn.ru>
 <3dff444b-c439-4c40-9d21-1e390f449840@linaro.org>
 <b9c7f8662e4c02a4f9f275d27469f3be@trvn.ru>
 <f3c215a3-579a-4b4f-92bf-092c91234180@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3c215a3-579a-4b4f-92bf-092c91234180@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 08:54:00PM +0200, Konrad Dybcio wrote:
> On 10/24/23 11:29, Nikita Travkin wrote:
> > Konrad Dybcio писал(а) 24.10.2023 13:34:
> > > On 10/23/23 08:20, Nikita Travkin wrote:
> > > > pm8916 contains some hardware blocks for battery powered devices:
> > > > 
> > > > - VM-BMS: Battery voltage monitoring block.
> > > > - LBC: Linear battery charger.
> > > > 
> > > > Add them to the pmic dtsi so the devices that make use of those blocks
> > > > can enable them.
> > > > 
> > > > Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> > > > ---
> > > >    arch/arm64/boot/dts/qcom/pm8916.dtsi | 48 ++++++++++++++++++++++++++++++++++++
> > > >    1 file changed, 48 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
> > > > index f4de86787743..4b2e8fb47d2d 100644
> > > > --- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
> > > > @@ -41,6 +41,35 @@ watchdog {
> > > >    			};
> > > >    		};
> > > >    +		pm8916_charger: charger@1000 {
> > > > +			compatible = "qcom,pm8916-lbc";
> > > > +			reg = <0x1000>, <0x1200>, <0x1300>, <0x1600>;
> > > > +			reg-names = "chgr", "bat_if", "usb", "misc";
> > > > +
> > > > +			interrupts = <0x0 0x10 0 IRQ_TYPE_EDGE_BOTH>,
> > > > +				     <0x0 0x10 5 IRQ_TYPE_EDGE_BOTH>,
> > > > +				     <0x0 0x10 6 IRQ_TYPE_EDGE_BOTH>,
> > > > +				     <0x0 0x10 7 IRQ_TYPE_EDGE_BOTH>,
> > > > +				     <0x0 0x12 0 IRQ_TYPE_EDGE_BOTH>,
> > > > +				     <0x0 0x12 1 IRQ_TYPE_EDGE_BOTH>,
> > > > +				     <0x0 0x13 0 IRQ_TYPE_EDGE_BOTH>,
> > > > +				     <0x0 0x13 1 IRQ_TYPE_EDGE_BOTH>,
> > > > +				     <0x0 0x13 2 IRQ_TYPE_EDGE_BOTH>,
> > > > +				     <0x0 0x13 4 IRQ_TYPE_EDGE_BOTH>;
> > > > +			interrupt-names = "vbat_det",
> > > > +					  "fast_chg",
> > > > +					  "chg_fail",
> > > > +					  "chg_done",
> > > > +					  "bat_pres",
> > > > +					  "temp_ok",
> > > > +					  "coarse_det",
> > > > +					  "usb_vbus",
> > > So, both the charger and the USBIN driver use the same irq? :/
> > > 
> > 
> > AFAIU the usbin extcon driver pretty much just tracks the state
> > of the IRQ to report extcon. It happens to assume the same part
> > of the pmic though, yes, which also means there will be no user
> > that would enable both charger and vbus extcon, since charger
> > driver provides this functionality as well.
> So, should USBIN be removed from PM8916 dt since it's essentially
> a part of the charger block?
> 

The "USB_IN" pad of the PM8916 seems to be connected on pretty much all
devices, even if they are using external chargers and the charging
functionality of PM8916 is completely disabled. For those devices, the
&pm8916_usbin device provides a convenient way to detect the USB state,
even without a working charger driver.

While we could modify the PM8916 charger driver and DT node to have some
special mode where charging and battery monitoring is completely
disabled and only the USBIN extcon is provided, I'm not sure if that
would provide a significant advantage compared to just keeping the
simple &pm8916_usbin node with the existing driver.

Thanks,
Stephan
