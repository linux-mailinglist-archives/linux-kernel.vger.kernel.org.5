Return-Path: <linux-kernel+bounces-17209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 207A78249D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37E4287B1A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297772C1AD;
	Thu,  4 Jan 2024 20:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="CS2ViA3A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA7F27451;
	Thu,  4 Jan 2024 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
	s=s31663417; t=1704401681; x=1705006481; i=frank-w@public-files.de;
	bh=SKkSJVBzIOnKnn+RMuSC3/60nyMBWnquf6LcANeBPSQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=CS2ViA3AGo92P0jwir5NIAVAgbg6yV/+1DM8ORA/rlVp8n/46+3FpFHhG3b3oDXu
	 cuSQfVCACQpt2XO/1SIKwDEWf8+7CXPyh2g51AhADAaEvRJspB7C9dMZugSvCx/wf
	 dqOleA4miuHaV7LzdRjZ9MKoVxTNTZGgApFdXmf50Y6MR9SnlCd7CODPj+0V8YkO1
	 jDaGg8yPxeZaVhMLxmhx3QwSsT5lbLMbZITqKwUvMOBjnEBCk9zGSxCE7OSbS1p61
	 dRMtq3jhAdQtWjyMhFbUgyqCmTzbWZfjCjH4g+eBuemcngs/5pLg69kRRCA8ejRWi
	 xcCEOwOsEdcaW/DCCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [157.180.226.237] ([157.180.226.237]) by web-mail.gmx.net
 (3c-app-gmx-bs29.server.lan [172.19.170.81]) (via HTTP); Thu, 4 Jan 2024
 21:54:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-940b6e7e-1246-45f8-af65-f5048bc2265b-1704401680934@3c-app-gmx-bs29>
From: Frank Wunderlich <frank-w@public-files.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Daniel Golle <daniel@makrotopia.org>, Frank Wunderlich
 <linux@fw-web.de>, linux-mediatek@lists.infradead.org, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Sam Shih <sam.shih@mediatek.com>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Aw: Re: [PATCH 1/2] dt-bindings: reset: mediatek: add MT7988 LVTS
 reset ID
Content-Type: text/plain; charset=UTF-8
Date: Thu, 4 Jan 2024 21:54:40 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <3e3455a1-c540-4323-9d9d-95289a395c3f@linaro.org>
References: <20240104173930.13907-1-linux@fw-web.de>
 <20240104173930.13907-2-linux@fw-web.de>
 <ZZb0-pFWxuQlEm7q@pidgin.makrotopia.org>
 <3e3455a1-c540-4323-9d9d-95289a395c3f@linaro.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ZLdxy+zk76HP1t6Fqt05SLqZ3emcYLI8IAqKeFvSrgvBnnBbjqewMQxqbTy69hsc+QjMq
 lffypJx3P8BsU3PPzXiNZ5iojUA+7zknLAIk7XF3U36Z+N7bEAwaU2K1eV7NAKq7kmSd4mpUPK+T
 vDzWopQ/zM2pdfMPWYpXpoCVWNC9FZ11a6/jlaAyfC76iBU43/oW6nF4ftAFkpAuDk1VQifJsRRt
 /DPKTi1eHs5BVsIJjmVGcHVGXxFgQAf+CLejc8zBq1p4omlNorq+qAWl9EbZnCR7WpMLsaSSMCrg
 eA=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tB+ieJbTebQ=;0WICBO5JQdiX9M3vSS+T9ckm3a9
 bGtqXX18GHN6TYSLML7cneFFD2QCV0i55WJmMuU6C3NnsZzm7XZGNPSL2fVmEnaarxkfVGXtH
 u0nyxo+FCXPVprhuYZwKluLsQBI3+AXoNTKEC1lxjGM4TAqbZdgH/dudmrYqXpk41uBE9I7az
 28FsvUElYvWBgGO3d4PSJIV07+q+uNKtXYoVq0WXrDRc7Lv/Q9dVYqrqkS0aOU+htULnJ7gnC
 W4vYjamfWlb1Y5LFMNu5YnNeMTNB6frj+XOUNOB7mjf2rz1sMJWg/sKW6xDIkO0kFrtCm5k1a
 F11TBoh2WrGmunSRhCxHPFEQGJrFQ8B412mqr5ubbuLZ2GCk9dtUuen9PapKyofzttvcPrQpw
 j43qPTxTVd8R1zxscAxHJpb/ivgBL8Mqj69QbRe4ldLrHCwG9yQKJrAIu9jVR4UMg2vqkcj5L
 MW7ijNCAOaO7maqwa9Ab3t80RzVf5gR0ljoMBy6yT0dKFAJdpaVsTXC2FrNMZB69CkB2oZvBo
 gg15EsOhF7obUIWzF9KufGYYGe450auwNceaiXv6HkQkER69bQ0Tu+sa5Aqwi7iUWKM5Xmdcb
 oIQIk0KRkBriUvzo9BohB5dUnA4bO/Hz6B8OkZGDra9DdSQJEuz22LiDCotNZpdcmvmVl0zXS
 UX33TFUhPKS+oQYZPEzeiXoZ075J/2FfTS/iCboU/HXZCuIlgNIY6oYNRD1MYIzyz8+axCWPZ
 N1f6B/PcyoF1JfUlNwKCQc78IOgdR2C7ZopRmhPBJTDir9ozPjav8PFHiwGrD6Hbw9JOFQR00
 VTrNtPB/zjBe/yMvvEQ7lLkyiSPb2CATLh6gaNXrFcPOk=
Content-Transfer-Encoding: quoted-printable

Hi

> Gesendet: Donnerstag, 04. Januar 2024 um 20:19 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> Betreff: Re: [PATCH 1/2] dt-bindings: reset: mediatek: add MT7988 LVTS r=
eset ID
>
> On 04/01/2024 19:12, Daniel Golle wrote:
> > Hi Frank,
> >
> > On Thu, Jan 04, 2024 at 06:39:29PM +0100, Frank Wunderlich wrote:
> >> From: Frank Wunderlich <frank-w@public-files.de>
> >>
> >> ---
> >>  include/dt-bindings/reset/mediatek,mt7988-resets.h | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/include/dt-bindings/reset/mediatek,mt7988-resets.h b/inc=
lude/dt-bindings/reset/mediatek,mt7988-resets.h
> >> index 493301971367..3f1e4ec07ad5 100644
> >> --- a/include/dt-bindings/reset/mediatek,mt7988-resets.h
> >> +++ b/include/dt-bindings/reset/mediatek,mt7988-resets.h
> >> @@ -10,4 +10,8 @@
> >>  /* ETHWARP resets */
> >>  #define MT7988_ETHWARP_RST_SWITCH		0
> >>
> >> +/* INFRA resets */
> >> +#define MT7988_INFRA_RST0_THERM_CTRL_SWRST	9
> >
> > I suppose this argument applies here as well:
> >
> > "IDs should start from 0 or 1 and increment by 1. If these are not IDs=
,
> > then you do not need them in the bindings."
> >
> > https://lore.kernel.org/all/59629ec1-cc0c-4c5a-87cc-ea30d64ec191@linar=
o.org/
> >
> > As a consequence, as what you are describing there are hardware bits
>
> If this is existing driver which already uses such pattern, then it is
> fine. I usually comment this on new drivers which can be changed.

this is a new driver so i guess i should change this like daniel suggests.
As i want to use this constant in dts and driver i would like keep it as b=
inding in the reset header,
but because i use it only as index in the infra_idx_map array its value do=
es not need to have the value
needed in hardware. i kept it same to not have different values and for or=
dering purposes (when the other
possible resets are added).

so the way starting at 0 will be the preferred one for me, is this ok?

regards Frank

