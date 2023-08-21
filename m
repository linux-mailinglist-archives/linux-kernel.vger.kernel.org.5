Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A893E783673
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjHUXng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjHUXnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:43:35 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C40E4;
        Mon, 21 Aug 2023 16:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=LdvLVb5DAXlAUlNtT5bsTEsSceaW3GSYZ3+U9Zyp0Ro=; b=qK
        bybjSh/lK30OQgppaDzK6Y6lhKLUGdzkcxugh6jz6BaDfO3rflgwASCzuZtdZbxzC7eewsBZNmAkb
        9dGvdwB/AkiFgeHC5fdrzVB0/DQpv7nVdM8ZPdZC6I/ONjMPRyxXasjjMI8E7fHajg0ANe4ttgAqa
        Z/bVFuP6oMAqjps=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qYEY8-004jcc-PR; Tue, 22 Aug 2023 01:43:08 +0200
Date:   Tue, 22 Aug 2023 01:43:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] arm: marvell: Fix maxium->maxim typo for
 brownstone dts
Message-ID: <7336acfc-eea8-472c-8b04-c04b4c401fe8@lunn.ch>
References: <20230821-brownstone-typo-fix-v1-1-277983372d3a@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230821-brownstone-typo-fix-v1-1-277983372d3a@skole.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 10:09:30PM +0200, Duje Mihanović wrote:
> Fix an obvious spelling error in the PMIC compatible in the MMP2
> Brownstone DTS file.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---
>  arch/arm/boot/dts/marvell/mmp2-brownstone.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/marvell/mmp2-brownstone.dts b/arch/arm/boot/dts/marvell/mmp2-brownstone.dts
> index 04f1ae1382e7..bc64348b8218 100644
> --- a/arch/arm/boot/dts/marvell/mmp2-brownstone.dts
> +++ b/arch/arm/boot/dts/marvell/mmp2-brownstone.dts
> @@ -28,7 +28,7 @@ &uart3 {
>  &twsi1 {
>  	status = "okay";
>  	pmic: max8925@3c {
> -		compatible = "maxium,max8925";
> +		compatible = "maxim,max8925";

Maybe a dumb question. Does I2C core still ignore the vendor part? Its
a long time since i did anything with i2c, but i thought for
historical reasons it ignore the vendor?

If this is still true, then yes, this is just a spelling
error. However, if the vendor is being used to match device to driver,
this is more than a spelling issue, and should be directed to stable.

     Andrew
