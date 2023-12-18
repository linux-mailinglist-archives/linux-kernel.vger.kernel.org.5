Return-Path: <linux-kernel+bounces-3314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC82816AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ACD71F24ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BD813AEE;
	Mon, 18 Dec 2023 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="z/8ZGLDl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C413913FE6;
	Mon, 18 Dec 2023 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702894798;
	bh=glj7Dyp4bvg50e13V69m9SNRz5l9Yow0xdICkF4cdqU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=z/8ZGLDlYg0vi8xNIMJN2DMeOyyQaEmxCOrYeEjaVpITA2cZ6hHenXI3ycSnOQlBv
	 7XlQvginATUyMhRcPJ4Ejw458otcjAbXPn2hT+QRY53wIsRCjTVEmSSiuRXxyg0omC
	 +WDE1Sn7ev0O02zyfXzAOtIBqPr3XOb8m94m14BU07FpGo1vPw6Bogj9RtzLMaS0hv
	 iSvHVoUs6JpmI8TDSIKoUg5odOnWt3ko90H9zQ8i6//LcRxvhAjTRCQKb4u7PhnkJY
	 ItdneyilXidvfxU735ykRp+awN9e/vPbHtNSjlozNiA9JevfA9J2MGykD5U3yqDC6O
	 KYuvIOo+RE5Gw==
Received: from beast.luon.net (cola.collaboradmins.com [IPv6:2a01:4f8:1c1c:5717::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D59CA37809D0;
	Mon, 18 Dec 2023 10:19:57 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
	id 672D49900106; Mon, 18 Dec 2023 11:19:57 +0100 (CET)
Message-ID: <6c93241c35153cfb718db1d81e99e01bfb6dede5.camel@collabora.com>
Subject: Re: [PATCH v2 0/3] Moxtet bus fixes
From: Sjoerd Simons <sjoerd@collabora.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>, Marek
	=?ISO-8859-1?Q?Beh=FAn?=
	 <kabel@kernel.org>
Cc: kernel@collabora.com, Andrew Lunn <andrew@lunn.ch>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Rob Herring <robh+dt@kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Date: Mon, 18 Dec 2023 11:19:57 +0100
In-Reply-To: <87fs03cyki.fsf@BL-laptop>
References: <20231128213536.3764212-1-sjoerd@collabora.com>
	 <87fs0ceoif.fsf@BL-laptop> <20231208161724.5f4f626a@dellmb>
	 <87fs03cyki.fsf@BL-laptop>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-15 at 15:47 +0100, Gregory CLEMENT wrote:
> Marek Beh=C3=BAn <kabel@kernel.org> writes:
>=20
> > On Fri, 08 Dec 2023 15:51:20 +0100
> > Gregory CLEMENT <gregory.clement@bootlin.com> wrote:
> >=20
> > Gregory, as of yet I've never done a pull request. If you are
> > willing
> > to take all 3 patches now, please do. In the future I would like to
>=20
> OK I applied them on mvebu/driver.

Thanks both for moving this patches forward; Gregory looks like you
only applied two of the three patches (missing the dt patch), are you
expect that to flow through a different tree or ?


Regards,
--=20
Sjoerd Simons
Collabora Ltd.

