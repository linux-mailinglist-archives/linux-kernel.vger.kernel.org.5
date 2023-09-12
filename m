Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ED979C86B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjILHnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjILHnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:43:04 -0400
X-Greylist: delayed 50446 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Sep 2023 00:42:59 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3464010C7;
        Tue, 12 Sep 2023 00:42:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694504577; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fjWlBWJFmqMV8lH9XejSDLefzNl9T7CIz29FZCK6TxM+4y2SYzBk8oTMoClIG2tjbk
    j+ujE3Cbta82mXZTEuvy9tMC8CXft/0YFp+bB6p9riYdXucqvsMoUXM0QFXCpsZ/NVuT
    DlsHnEQHFYiOzOHxhCvTFQWBHE7Yg91L8KfL27YYtV+DEzY3HyDWB4kfLYwqymnn9BN3
    KmkOowB1fcnxiv1IMwbbjPj90hXyjO4q4kFGHkD38J2ALtY9iy3LdACtacBWWDH0bCW7
    YoR0Q07dKy0rA7QWLp2LqlRFKd8hT3bsjPGskRLJzkAHI5IMyzSxZ+W5Eymc9LBegU7u
    etKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694504577;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Jerwlqu1OdkPEzyr0Hjo2diQ+WDDPo13il2Fhs+ym5E=;
    b=b7E2qdedm/5K/JatTDWMPjrCYyZcGBFHW+V8qhjaLkyhW8LPpBWQF+5bz0inv6Aons
    R8A52ZeP6cEAytIK38AjrTNV4VtslTWTWO0bCfKNafQsF4/ollF1l0+X2YC5BL4FxaPi
    uKKQl8jJBHyhD6SiEfN7fgtgSuAGJ9yN6ir/7lcZxJO6RS2KgWHeLn2NowYUqLc28wNI
    CWH6jttgjiI5W/cJj09xejBRN9osYjqgPlTJApk/Ai7nRRRV6DUbEzbl+j+q+/9grMna
    uvdG441sgaLqxCOSH8OQIDX0/ALcmmR2WMSKy28Cw8DmjX98uFMIUFiTrL/CIJoN/Yr0
    BOKA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694504577;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Jerwlqu1OdkPEzyr0Hjo2diQ+WDDPo13il2Fhs+ym5E=;
    b=KxNIYQCt01jsiwUgYxWMIkm376zV4eOgXHlDOrKqUWnNrPJhHTPF+gXYQjrqGlPEAg
    blR5DLYLhasS7EVnjXZCQ8flbJ/lZ3f4GqDfbAfM7eP6nl4Vl0duNezp8kv58EbQmd15
    Pjy2/xWpQx6wTN17DCwOBx0DAud3C5rt7G3WvMzgU38FTqqcqZtW72NL7d9vOXF//0MF
    ADqLiXQj7tB2sByq7Qr3lJQ6OkWyY4IMRpC1HAKgV7FyeluLDpd7quZoXYrwi3oGheJI
    V/zhcX4QX4RieRv+06JLmu/fxMBrrY25MdFnVKuRzxoY9tZlImcdCyV9VFmHXL5K4pDC
    +M3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694504577;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Jerwlqu1OdkPEzyr0Hjo2diQ+WDDPo13il2Fhs+ym5E=;
    b=5QVw6WNbkOQ1YBOh0deXtyIItppONq1zYvEz3wAhlGAQ0Z+IiyTVYSMh2YvxhhVVsi
    RwCiD57XFFazaq9VVxCA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z2L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id 60372az8C7gucHu
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 12 Sep 2023 09:42:56 +0200 (CEST)
Date:   Tue, 12 Sep 2023 09:42:50 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] arm64: dts: qcom: msm8916-ufi: Drop gps_mem for now
Message-ID: <ZQAWesjhnLzhnK5h@gerhold.net>
References: <20230911-msm8916-rmem-v1-0-b7089ec3e3a1@gerhold.net>
 <20230911-msm8916-rmem-v1-3-b7089ec3e3a1@gerhold.net>
 <d8a17496-d2b4-4ed5-8a25-e61fe38bd377@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8a17496-d2b4-4ed5-8a25-e61fe38bd377@linaro.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 07:36:43AM +0100, Bryan O'Donoghue wrote:
> On 11/09/2023 18:41, Stephan Gerhold wrote:
> > gps_mem is needed by the modem firmware for GPS to work. However, it is
> > accessed via QMI memshare [1] which is not available upstream yet.
> > Until it lands upstream reserving this does not provide any advantage.
> > 
> > [1]: https://lore.kernel.org/linux-arm-msm/20210319172321.22248-1-nikitos.tr@gmail.com/
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >   arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi | 5 -----
> >   1 file changed, 5 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
> > index c759c0544dd9..69f268db4df9 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
> > @@ -22,11 +22,6 @@ mpss_mem: mpss@86800000 {
> >   			reg = <0x0 0x86800000 0x0 0x5500000>;
> >   			no-map;
> >   		};
> > -
> > -		gps_mem: gps@8bd00000 {
> > -			reg = <0x0 0x8bd00000 0x0 0x200000>;
> > -			no-map;
> > -		};
> >   	};
> >   	gpio-keys {
> > 
> 
> Should this have a Fixes tag, should probably be applied to stable.
> 

I'm probably a bit "overcautious" when it comes to stable backporting,
but I think this is not strictly a fix but more like cleanup. It doesn't
cause any trouble to reserve the extra memory, it just wastes some RAM.

Thanks,
Stephan
