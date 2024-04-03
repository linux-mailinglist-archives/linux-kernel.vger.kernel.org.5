Return-Path: <linux-kernel+bounces-128997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC8C8962E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D011C22C6D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7066225A2;
	Wed,  3 Apr 2024 03:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="NpflSBWd"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A291BF5C;
	Wed,  3 Apr 2024 03:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712114486; cv=none; b=f4EhIO5AVUtos58HNdJGAs7JK7y7VawKdmAgfgvnGDbwZGULnJRkdzEWPJ+AHY0Mf5uBBKuN2mkKNRlk+qzKY9W37Um3cf/qzKM3FbL6LwenQG57TY6Bbhra5/BPbIJvQpCmdNH+y2AmbLgNnFp87/ragyoOv2Ri3YvC34WYwDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712114486; c=relaxed/simple;
	bh=un05Zp/ImXKjgDyQu270iLtmkuoxwls6ndISI3iH85E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BYJduHd/LxiFhQfX5EtLzIgeIl26hvBcavADR5qZzAM9cFKS/DC836LXBU1Xtw+izfGFvIYLI6/Kz/rr2rek4Im6/9xj6QbQ3BbkQSq50B1Dfw1r526s4lA19sTENry1BX64wn4mzsqgO5xxYQK6edLTKI1sRe3lEZwWZleQGr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=NpflSBWd; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-182-70.adl-adc-lon-bras34.tpg.internode.on.net [118.210.182.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1806420075;
	Wed,  3 Apr 2024 11:21:07 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1712114479;
	bh=ihCa6WKSA/WbdOR35DutY2Up4nYKVpfJqb5uMJHHlDg=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=NpflSBWdGcgyEymG4qxPXgsd6Po5FikbCaLFEFc+dFj6qiCmHRtAelZtJOC6mtkOT
	 XoqEuPXAcdkwvNtRTbCZDNk5jwT3HVPEAWXTkJ+MQLXuX7zqy61sHBmCty1Vy+nUHS
	 Xizu2sPyHorbKBXLiCqUY4XOwdv4VvN1UeJ9yExMJWiDk5OrqZrLIuCdKVACeRQQJy
	 rH+iNXy6DY/hgdxtHGqzdzywjfvWY3wjC2zmYD66Vn51kjRnO6MYhz7gsH/uLwVeol
	 a26xaqyKvPMfiukImhUYN07ZoAzeWxoKcTsEkkMxhWbdcCJi+cTMEV4onc1IAb0SgC
	 FcMZp7vi8ouug==
Message-ID: <5f1c7ac66f0ae68bbab0011c1ab5b020ecdb16b6.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/3] ARM: dts: Modify GPIO table for Asrock X570D4U BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Renze Nicolai <renze@rnplus.nl>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, arnd@arndb.de, olof@lixom.net,
 soc@kernel.org,  robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 joel@jms.id.au,  andrew@aj.id.au
Date: Wed, 03 Apr 2024 13:51:06 +1030
In-Reply-To: <20240329130152.878944-2-renze@rnplus.nl>
References: <20240329130152.878944-1-renze@rnplus.nl>
	 <20240329130152.878944-2-renze@rnplus.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Renze,

Do you mind running this patch and the others in the series through
/scripts/checkpatch.pl? Generally patches sent to the list should not
generate warnings.

It looks like these patches are generated against Joel's bmc/for-next
branch. He's applied your original X570D4U devicetree patch there,
(though that also causes checkpatch warnings).

On Fri, 2024-03-29 at 14:01 +0100, Renze Nicolai wrote:
> This commit removes button-nmi-n, this board does not have support for an=
 NMI button.
> Input status-locatorled-n has been renamed to input-locatorled-n to bette=
r indicate the signal type.
> The suffix -n has been appended to the name of control-locatorbutton, but=
ton-power, control-power, button-reset, control-reset, input-id0, input-id1=
, input-id2, output-bmc-ready to reflect the inverted signal polarity.
> GPIO output-rtc-battery-voltage-read-enable has been renamed to output-hw=
m-vbat-enable, input-alert1-n to input-aux-smb-alert-n, input-alert3-n to i=
nput-psu-smb-alert-n, input-mfg to input-mfg-mode-n and input-caseopen to i=
nput-case-open-n.
> And GPIOs input-bmc-smb-present-n, input-pcie-wake-n, input-sleep-s3-n, i=
nput-sleep-s5-n and input-power-good have been added.
>=20

For instance, checkpatch warns about these lines in the commit message
being too long. They should be wrapped at 72 characters.

Additionally, the description forms a bit of a list of things the patch
is doing. Patches are easier to review when they only do one thing, as
it removes the need to assess whether there are subtle interactions
between the several things, and if so, whether they're expected and
correct.

I'd prefer this change be split up so there's no need for such
concerns.

> Signed-off-by: Renze Nicolai <renze@rnplus.nl>
> ---
>  .../dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  | 116 +++++++++---------
>  1 file changed, 58 insertions(+), 58 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts b/arc=
h/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
> index 3c975bc41ae7..34bc382bf492 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
> @@ -79,64 +79,64 @@ iio-hwmon {
>  &gpio {
>  	status =3D "okay";
>  	gpio-line-names =3D
> -	/*A0-A3*/       "status-locatorled-n",                    "",          =
            "button-nmi-n",          "",
> -	/*A4-A7*/       "",                                       "",          =
            "",                      "",
> -	/*B0-B3*/       "input-bios-post-cmplt-n",                "",          =
            "",                      "",
> -	/*B4-B7*/       "",                                       "",          =
            "",                      "",
> -	/*C0-C3*/       "",                                       "",          =
            "",                      "",
> -	/*C4-C7*/       "",                                       "",          =
            "control-locatorbutton", "",
> -	/*D0-D3*/       "button-power",                           "control-powe=
r",         "button-reset",          "control-reset",
> -	/*D4-D7*/       "",                                       "",          =
            "",                      "",
> -	/*E0-E3*/       "",                                       "",          =
            "",                      "",
> -	/*E4-E7*/       "",                                       "",          =
            "",                      "",
> -	/*F0-F3*/       "",                                       "",          =
            "",                      "",
> -	/*F4-F7*/       "",                                       "",          =
            "",                      "",
> -	/*G0-G3*/       "output-rtc-battery-voltage-read-enable", "input-id0", =
            "input-id1",             "input-id2",
> -	/*G4-G7*/       "input-alert1-n",                         "input-alert2=
-n",        "input-alert3-n",        "",
> -	/*H0-H3*/       "",                                       "",          =
            "",                      "",
> -	/*H4-H7*/       "input-mfg",                              "",          =
            "led-heartbeat-n",       "input-caseopen",
> -	/*I0-I3*/       "",                                       "",          =
            "",                      "",
> -	/*I4-I7*/       "",                                       "",          =
            "",                      "",
> -	/*J0-J3*/       "output-bmc-ready",                       "",          =
            "",                      "",
> -	/*J4-J7*/       "",                                       "",          =
            "",                      "",
> -	/*K0-K3*/       "",                                       "",          =
            "",                      "",
> -	/*K4-K7*/       "",                                       "",          =
            "",                      "",
> -	/*L0-L3*/       "",                                       "",          =
            "",                      "",
> -	/*L4-L7*/       "",                                       "",          =
            "",                      "",
> -	/*M0-M3*/       "",                                       "",          =
            "",                      "",
> -	/*M4-M7*/       "",                                       "",          =
            "",                      "",
> -	/*N0-N3*/       "",                                       "",          =
            "",                      "",
> -	/*N4-N7*/       "",                                       "",          =
            "",                      "",
> -	/*O0-O3*/       "",                                       "",          =
            "",                      "",
> -	/*O4-O7*/       "",                                       "",          =
            "",                      "",
> -	/*P0-P3*/       "",                                       "",          =
            "",                      "",
> -	/*P4-P7*/       "",                                       "",          =
            "",                      "",
> -	/*Q0-Q3*/       "",                                       "",          =
            "",                      "",
> -	/*Q4-Q7*/       "",                                       "",          =
            "",                      "",
> -	/*R0-R3*/       "",                                       "",          =
            "",                      "",
> -	/*R4-R7*/       "",                                       "",          =
            "",                      "",
> -	/*S0-S3*/       "input-bmc-pchhot-n",                     "",          =
            "",                      "",
> -	/*S4-S7*/       "",                                       "",          =
            "",                      "",
> -	/*T0-T3*/       "",                                       "",          =
            "",                      "",
> -	/*T4-T7*/       "",                                       "",          =
            "",                      "",
> -	/*U0-U3*/       "",                                       "",          =
            "",                      "",
> -	/*U4-U7*/       "",                                       "",          =
            "",                      "",
> -	/*V0-V3*/       "",                                       "",          =
            "",                      "",
> -	/*V4-V7*/       "",                                       "",          =
            "",                      "",
> -	/*W0-W3*/       "",                                       "",          =
            "",                      "",
> -	/*W4-W7*/       "",                                       "",          =
            "",                      "",
> -	/*X0-X3*/       "",                                       "",          =
            "",                      "",
> -	/*X4-X7*/       "",                                       "",          =
            "",                      "",
> -	/*Y0-Y3*/       "",                                       "",          =
            "",                      "",
> -	/*Y4-Y7*/       "",                                       "",          =
            "",                      "",
> -	/*Z0-Z3*/       "",                                       "",          =
            "led-fault-n",           "output-bmc-throttle-n",
> -	/*Z4-Z7*/       "",                                       "",          =
            "",                      "",
> -	/*AA0-AA3*/     "input-cpu1-thermtrip-latch-n",           "",          =
            "input-cpu1-prochot-n",  "",
> -	/*AA4-AC7*/     "",                                       "",          =
            "",                      "",
> -	/*AB0-AB3*/     "",                                       "",          =
            "",                      "",
> -	/*AB4-AC7*/     "",                                       "",          =
            "",                      "",
> -	/*AC0-AC3*/     "",                                       "",          =
            "",                      "",
> -	/*AC4-AC7*/     "",                                       "",          =
            "",                      "";
> +	/*A0-A3*/       "input-locatorled-n",                     "",          =
            "",                        "",
> +	/*A4-A7*/       "",                                       "",          =
            "",                        "",
> +	/*B0-B3*/       "input-bios-post-cmplt-n",                "",          =
            "",                        "",
> +	/*B4-B7*/       "",                                       "",          =
            "",                        "",
> +	/*C0-C3*/       "",                                       "",          =
            "",                        "",
> +	/*C4-C7*/       "",                                       "",          =
            "control-locatorbutton-n", "",
> +	/*D0-D3*/       "button-power-n",                         "control-powe=
r-n",       "button-reset-n",          "control-reset-n",
> +	/*D4-D7*/       "",                                       "",          =
            "",                        "",
> +	/*E0-E3*/       "",                                       "",          =
            "",                        "",
> +	/*E4-E7*/       "",                                       "",          =
            "",                        "",
> +	/*F0-F3*/       "",                                       "",          =
            "",                        "",
> +	/*F4-F7*/       "",                                       "",          =
            "",                        "",
> +	/*G0-G3*/       "output-hwm-vbat-enable",                 "input-id0-n"=
,           "input-id1-n",             "input-id2-n",
> +	/*G4-G7*/       "input-aux-smb-alert-n",                  "",          =
            "input-psu-smb-alert-n",   "",
> +	/*H0-H3*/       "",                                       "",          =
            "",                        "",
> +	/*H4-H7*/       "input-mfg-mode-n",                       "",          =
            "led-heartbeat-n",         "input-case-open-n",
> +	/*I0-I3*/       "",                                       "",          =
            "",                        "",
> +	/*I4-I7*/       "",                                       "",          =
            "",                        "",
> +	/*J0-J3*/       "output-bmc-ready-n",                     "",          =
            "",                        "",
> +	/*J4-J7*/       "",                                       "",          =
            "",                        "",
> +	/*K0-K3*/       "",                                       "",          =
            "",                        "",
> +	/*K4-K7*/       "",                                       "",          =
            "",                        "",
> +	/*L0-L3*/       "",                                       "",          =
            "",                        "",
> +	/*L4-L7*/       "",                                       "",          =
            "",                        "",
> +	/*M0-M3*/       "",                                       "",          =
            "",                        "",
> +	/*M4-M7*/       "",                                       "",          =
            "",                        "",
> +	/*N0-N3*/       "",                                       "",          =
            "",                        "",
> +	/*N4-N7*/       "",                                       "",          =
            "",                        "",
> +	/*O0-O3*/       "",                                       "",          =
            "",                        "",
> +	/*O4-O7*/       "",                                       "",          =
            "",                        "",
> +	/*P0-P3*/       "",                                       "",          =
            "",                        "",
> +	/*P4-P7*/       "",                                       "",          =
            "",                        "",
> +	/*Q0-Q3*/       "",                                       "",          =
            "",                        "",
> +	/*Q4-Q7*/       "input-bmc-smb-present-n",                "",          =
            "",                        "input-pcie-wake-n",
> +	/*R0-R3*/       "",                                       "",          =
            "",                        "",
> +	/*R4-R7*/       "",                                       "",          =
            "",                        "",
> +	/*S0-S3*/       "input-bmc-pchhot-n",                     "",          =
            "",                        "",
> +	/*S4-S7*/       "",                                       "",          =
            "",                        "",
> +	/*T0-T3*/       "",                                       "",          =
            "",                        "",
> +	/*T4-T7*/       "",                                       "",          =
            "",                        "",
> +	/*U0-U3*/       "",                                       "",          =
            "",                        "",
> +	/*U4-U7*/       "",                                       "",          =
            "",                        "",
> +	/*V0-V3*/       "",                                       "",          =
            "",                        "",
> +	/*V4-V7*/       "",                                       "",          =
            "",                        "",
> +	/*W0-W3*/       "",                                       "",          =
            "",                        "",
> +	/*W4-W7*/       "",                                       "",          =
            "",                        "",
> +	/*X0-X3*/       "",                                       "",          =
            "",                        "",
> +	/*X4-X7*/       "",                                       "",          =
            "",                        "",
> +	/*Y0-Y3*/       "input-sleep-s3-n",                       "input-sleep-=
s5-n",      "",                        "",
> +	/*Y4-Y7*/       "",                                       "",          =
            "",                        "",
> +	/*Z0-Z3*/       "",                                       "",          =
            "led-fault-n",             "output-bmc-throttle-n",
> +	/*Z4-Z7*/       "",                                       "",          =
            "",                        "",
> +	/*AA0-AA3*/     "input-cpu1-thermtrip-latch-n",           "",          =
            "input-cpu1-prochot-n",    "",
> +	/*AA4-AC7*/     "",                                       "",          =
            "",                        "",
> +	/*AB0-AB3*/     "",                                       "input-power-=
good",      "",                        "",
> +	/*AB4-AC7*/     "",                                       "",          =
            "",                        "",
> +	/*AC0-AC3*/     "",                                       "",          =
            "",                        "",
> +	/*AC4-AC7*/     "",                                       "",          =
            "",                        "";
>  };
> =20

I'd like some discussion in the commit message of whether these names
align with net names in the schematic, follow the OpenBMC GPIO naming
guidelines, or use some other strategy entirely.

Also, the columnisation of the names leads to more warnings from
checkpatch (due to line length). Other Aspeed-based devicetrees tend
not to make the whitespace so significant, and generally group the
GPIOs by complete banks. I prefer that the X570D4U devicetree is
consistent with the others.

Andrew

