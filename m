Return-Path: <linux-kernel+bounces-119809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57FC88CD38
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5F9AB22E8F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD01A13D24E;
	Tue, 26 Mar 2024 19:29:52 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA2D13CFB7;
	Tue, 26 Mar 2024 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711481392; cv=none; b=Wp8DXIr/ieF8TEv5bMABsJB3LvrG3fFDgW/02Cm/Gd0zvV+8DjNGnbAzyJR9FXHVCPheRD1Os81yG5IZAmCFkTb08ujT/c9HLSNdrEa7WEigAxmW6Fb8nyw00cLoqL9wjAhAo2yxMzCDb5Nfszo22FGqhDpP3n2BdurwLifxbaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711481392; c=relaxed/simple;
	bh=YW01FOTBgQuTjpZIEOnxXCe1aGb2AMOheChci7COxn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhUN4es0UrRY+9q2cRzCtm+0FKHTckISmpQ90O4idS6SSRoIe14Ju2qV4nPizFWJnieWOolKszLuJMRYavhAQ3LYZzxBjnORqKgnQsVywdYVuUYEyj6nCVFoJgt7KnVcJPIddh7AhC4pYN8y3MwOtQ9EuUHHIM2fZtF2VYA69M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875aaf.versanet.de ([83.135.90.175] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rpCUM-00073Q-7n; Tue, 26 Mar 2024 20:29:38 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: hjc@rock-chips.com, andy.yan@rock-chips.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] dt-bindings: display: rockchip: add missing #sound-dai-cells to
 dw-hdmi
Date: Tue, 26 Mar 2024 20:29:37 +0100
Message-ID: <1994969.8hb0ThOEGa@diego>
In-Reply-To: <5fb55234-4afd-4e6a-9763-4d2e344e0ce6@linaro.org>
References:
 <20240326172801.1163200-1-heiko@sntech.de>
 <edc0bfa2-7984-4d9d-ba25-4805ee0be679@linaro.org>
 <5fb55234-4afd-4e6a-9763-4d2e344e0ce6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Dienstag, 26. M=E4rz 2024, 18:50:37 CET schrieb Krzysztof Kozlowski:
> On 26/03/2024 18:50, Krzysztof Kozlowski wrote:
> > On 26/03/2024 18:28, Heiko Stuebner wrote:
> >> The #sound-dai-cells DT property is required to describe link between
> >> the HDMI IP block and the SoC's audio subsystem.
> >>
> >> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> >> ---
> >>  .../devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockch=
ip,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockch=
ip,dw-hdmi.yaml
> >> index af638b6c0d21..3768df80ca7a 100644
> >> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-h=
dmi.yaml
> >> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-h=
dmi.yaml
> >> @@ -124,6 +124,9 @@ properties:
> >>      description:
> >>        phandle to the GRF to mux vopl/vopb.
> >> =20
> >> +  "#sound-dai-cells":
> >> +    const: 0
> >> +
> >=20
> > Then you miss $ref in allOf to /schemas/sound/dai-common.yaml
>=20
> I meant, except your change you should add also above $ref.

sorry about that, will fix that.

Thanks for the pointer
Heiko




