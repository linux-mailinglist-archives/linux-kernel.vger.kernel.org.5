Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0D8777458
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbjHJJVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbjHJJVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:21:38 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414545273;
        Thu, 10 Aug 2023 02:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1691659207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cxvgd7KEPdRFvLppPHwdt3/66MA1MYdo2I92LCsqcJw=;
        b=yJmYb7pXHr2AwACbS3+BVJGdag/qTfZ+8AVnC3mjDxldrx/mxTJMwP9jwvGwnjNAGJE1XX
        o/MxaYG4zJh2olZ/32e48x5Z17uWbu2GxftPPa4qsFBuC33pmmE+Ro1WRLORwcOTeIKmhp
        iAadRqo8Aka0JuPQBlCq7e5Rc90c5ZM=
Message-ID: <a4c76fa5f119fcc93c3b87a11dd6de973387e72e.camel@crapouillou.net>
Subject: Re: [PATCH] ARM: dts: exynos/i9100: Unconditionally enable LDO12
From:   Paul Cercueil <paul@crapouillou.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Date:   Thu, 10 Aug 2023 11:20:05 +0200
In-Reply-To: <a1545e38-62fc-b5a1-e4c2-9f32b28e40f1@linaro.org>
References: <20230808110341.57891-1-paul@crapouillou.net>
         <a1545e38-62fc-b5a1-e4c2-9f32b28e40f1@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 10 ao=C3=BBt 2023 =C3=A0 08:21 +0200, Krzysztof Kozlowski a =C3=A9=
crit=C2=A0:
> On 08/08/2023 13:03, Paul Cercueil wrote:
> > The kernel hangs for a good 12 seconds without any info being
> > printed to
> > dmesg, very early in the boot process, if this regulator is not
> > enabled.
> >=20
> > Force-enable it to work around this issue, until we know more about
> > the
> > underlying problem.
> >=20
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > Fixes: 8620cc2f99b7 ("ARM: dts: exynos: Add devicetree file for the
> > Galaxy S2")
> > Cc: <stable@vger.kernel.org> # v5.8+
> > ---
> > =C2=A0arch/arm/boot/dts/exynos4210-i9100.dts | 8 ++++++++
>=20
> The path changed long time ago. Really, please do not work on some
> outdated pmOS or whatever downstream drivers.

That was on v6.4.2 yes. I simply forgot to rebase on the latest RC,
sorry about that.

I'll send a V2, and I now have some more patches touching that file
that I can bundle with.

-Paul
