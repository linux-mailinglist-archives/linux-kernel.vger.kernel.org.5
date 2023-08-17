Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA2F77FAD1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352228AbjHQPcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352320AbjHQPcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:32:05 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D31A2D78;
        Thu, 17 Aug 2023 08:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1692286322; bh=jhloUQX2E1J9+PoKe/QiW8FViWr4zfA5WBk4rOU7L6s=;
        h=Date:From:To:Subject:X-My-GPG-KeyId:References:From;
        b=llwTCSiy/meO+QCeWQcdDEJQ5tpXiV0KwZB3J88v8VDWtxp2VdxsS8cX9UmncP12U
         jmHW0NO+61zt91X/btYyoWKBl2Lfz3KyyxL6JhqNFtWhVX3h1nte8PNJrbwytF0pPt
         J1XCSFaxq0y0/YpklFws+VCQK38auNCD6z+ebeiI=
Date:   Thu, 17 Aug 2023 17:32:02 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Muhammed Efe Cetin <efectn@6tel.net>, conor+dt@kernel.org,
        devicetree@vger.kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        sebastian.reichel@collabora.com
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Orange Pi 5
Message-ID: <qqx5tay4etbepyyy7hqdp2prtw4t3m57esulruevggw2yi4xqf@63a7v5vzodhs>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
        Muhammed Efe Cetin <efectn@6tel.net>, conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de, 
        krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org, 
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, robh+dt@kernel.org, 
        sebastian.reichel@collabora.com
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <dz2i6ix6dphyu6dwsqgvx7byoxegmdlsc6dwhyxd3uffqus6jo@r6jnxz7jprdv>
 <20230817145756.161970-1-efectn@6tel.net>
 <czvylysw2shlmvryimwtaquz747jel5k4dzfel6kgijmome7py@d4exzabfp3ig>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <czvylysw2shlmvryimwtaquz747jel5k4dzfel6kgijmome7py@d4exzabfp3ig>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 05:30:04PM +0200, megi xff wrote:
> 
> On Thu, Aug 17, 2023 at 05:57:55PM +0300, Muhammed Efe Cetin wrote:
> > 
> > Hi, Ondřej
> > 
> > On 17.08.2023 16:57, Ondřej Jirman wrote:
> > > Hi Muhammed,
> > > 
> > >>>> [...]
> > >>>
> > >>>> +	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
> > >>>> +		compatible = "regulator-fixed";
> > >>>> +		regulator-name = "vcc_1v1_nldo_s3";
> > >>>> +		regulator-always-on;
> > >>>> +		regulator-boot-on;
> > >>>> +		regulator-min-microvolt = <1100000>;
> > >>>> +		regulator-max-microvolt = <1100000>;
> > >>>> +		vin-supply = <&vcc5v0_sys>;
> > >>>> +	};
> > >>>
> > >>> There's no such regulator on the board.
> > >>
> > >> It's connected to PMIC https://i.imgur.com/sVJdC5K.png
> > > 
> > > It's not a separate fixed regulator. It's a PMIC output from buck6 https://megous.com/dl/tmp/8630fa17407c75b9.png
> > > 
> > 
> > I think it should be fixed regulator. It's used as vcc13-supply and
> > vcc14-supply regulator on PMIC and it's same as other rk3588 boards.
> 
> Yes, BUCK6 output is input to some LDOs. If you make this a regulator-fixed,
> BUCK6 will not get enabled when those LDOs are enabled, and the LDOs will not
> work because they'll lack input power.
> 
> Your regulator-fixed does nothing to enable BUCK6 which is where vcc_1v1_nldo_s3
> power rail is connected.
> 
> It only works for you now, because dcdc-reg6 is marked as regulator-always-on,
> so it's already enabled when you need those dependent LDOs.

And if other boards have this same HW setup and user separate DT node with
regulator-fixed for this, they're broken, too.

regards,
	o.

> regards,
> 	o.
> 
> > > So this is VDD2_DDR_S3. If you want to keep the alias, just add extra alias to
> > > dcdc-reg6 like this:
> > > 
> > > 		...
> > > 	vcc_1v1_nldo_s3: vdd2_ddr_s3: dcdc-reg6 {
> > > 		...
> > > 
> > >>>
