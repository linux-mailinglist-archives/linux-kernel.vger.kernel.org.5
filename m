Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6E077FAC1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353216AbjHQPaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353211AbjHQPaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:30:09 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4745F19A1;
        Thu, 17 Aug 2023 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1692286204; bh=6Xe6LtKQ+jTcxQ2HiaGji+K67ppcyiOEj2K0oAshaDA=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=mqpakAfBYWNGV59GPxS6ytXr73ZE3aLYCrbRdphkEBDAdyKy38kuLzOU0ZSntMFkm
         wOu8oIu6Zup7Cm3ccg6YzrzBdSAJqpIQ9749WmSxKUerSo8j9f7RvTLDTimNFSfQiZ
         CZNqFDtE2CtMY6aInr7kCi75J0nC/v+778Oj0lrw=
Date:   Thu, 17 Aug 2023 17:30:03 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Muhammed Efe Cetin <efectn@6tel.net>
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        sebastian.reichel@collabora.com
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Orange Pi 5
Message-ID: <czvylysw2shlmvryimwtaquz747jel5k4dzfel6kgijmome7py@d4exzabfp3ig>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
        Muhammed Efe Cetin <efectn@6tel.net>, conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de, 
        krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org, 
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, robh+dt@kernel.org, 
        sebastian.reichel@collabora.com
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <dz2i6ix6dphyu6dwsqgvx7byoxegmdlsc6dwhyxd3uffqus6jo@r6jnxz7jprdv>
 <20230817145756.161970-1-efectn@6tel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230817145756.161970-1-efectn@6tel.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 05:57:55PM +0300, Muhammed Efe Cetin wrote:
> 
> Hi, Ondřej
> 
> On 17.08.2023 16:57, Ondřej Jirman wrote:
> > Hi Muhammed,
> > 
> >>>> [...]
> >>>
> >>>> +	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
> >>>> +		compatible = "regulator-fixed";
> >>>> +		regulator-name = "vcc_1v1_nldo_s3";
> >>>> +		regulator-always-on;
> >>>> +		regulator-boot-on;
> >>>> +		regulator-min-microvolt = <1100000>;
> >>>> +		regulator-max-microvolt = <1100000>;
> >>>> +		vin-supply = <&vcc5v0_sys>;
> >>>> +	};
> >>>
> >>> There's no such regulator on the board.
> >>
> >> It's connected to PMIC https://i.imgur.com/sVJdC5K.png
> > 
> > It's not a separate fixed regulator. It's a PMIC output from buck6 https://megous.com/dl/tmp/8630fa17407c75b9.png
> > 
> 
> I think it should be fixed regulator. It's used as vcc13-supply and
> vcc14-supply regulator on PMIC and it's same as other rk3588 boards.

Yes, BUCK6 output is input to some LDOs. If you make this a regulator-fixed,
BUCK6 will not get enabled when those LDOs are enabled, and the LDOs will not
work because they'll lack input power.

Your regulator-fixed does nothing to enable BUCK6 which is where vcc_1v1_nldo_s3
power rail is connected.

It only works for you now, because dcdc-reg6 is marked as regulator-always-on,
so it's already enabled when you need those dependent LDOs.

regards,
	o.

> > So this is VDD2_DDR_S3. If you want to keep the alias, just add extra alias to
> > dcdc-reg6 like this:
> > 
> > 		...
> > 	vcc_1v1_nldo_s3: vdd2_ddr_s3: dcdc-reg6 {
> > 		...
> > 
> >>>
