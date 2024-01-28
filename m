Return-Path: <linux-kernel+bounces-41591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C07483F513
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCD3282F50
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 11:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D881F615;
	Sun, 28 Jan 2024 11:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RkhbdvRH"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17441EB29;
	Sun, 28 Jan 2024 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706439687; cv=none; b=beHcnUJgHuwHMojO0k+EvudNgzDLIEikNHgVUzpsvvmUg14SKUx8rONg1AVOdoMQTFEno1sZ+SABs9yZ5cWBlXOzSROSeqXsIr1xg938p1bVHbPu2WcketHu1hWjS0IfxSlvapNo4RQVWMLHQ5u95JoEzHLkGzOTnAjuJcWWbgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706439687; c=relaxed/simple;
	bh=5srCU8mALld93XXZWkuO9wczxnN7Mp+AiQKKleufIJY=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=rwOfOLc3St7J5m69Q2K50nggWfiydnOqYr5Rb0IvRDFrPwyW7RWsvUR1M5JO4qg7elUgiPKlj64SamdozKZFuRqF6OhJOBsJzPrvLg4nvmomQO/ZuZaqdVsOhU+nmLvCgCym5z+dfixZf+vguxx36pjYJqvzu8HdwpzownEOu90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=fail (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=RkhbdvRH reason="signature verification failed"; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0639A3D9;
	Sun, 28 Jan 2024 11:59:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706439599;
	bh=5srCU8mALld93XXZWkuO9wczxnN7Mp+AiQKKleufIJY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=RkhbdvRHlz1v8jg4VujoVEvuFFQwER/Of6VU8hgYvGxSJ6sauMOpigUM9jwIZggbM
	 ovsTDbzG216rVaHmdrHBTfja6Y/1kngp8TZl25L/sIL9hjrprl+/lEEC7ofAXjaoqi
	 ogP2fskaRCqFSgwLOtdxTIoWzpGtryil4ewfj2mk=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240126-gix-mtk-warnings-v1-7-eed7865fce18@chromium.org>
References: <20240126-gix-mtk-warnings-v1-0-eed7865fce18@chromium.org> <20240126-gix-mtk-warnings-v1-7-eed7865fce18@chromium.org>
Subject: Re: [PATCH 07/17] media: i2c: adv748: Fix kerneldoc
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-staging@lists.linux.dev, linux-amlogic@lists.infradead.org, Ricardo Ribalda <ribalda@chromium.org>
To: Alim Akhtar <alim.akhtar@samsung.com>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>, Andrzej Hajda <andrzej.hajda@intel.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bin Liu <bin.liu@mediatek.com>, Bingbu Cao <bingbu.cao@intel.com>, Bjorn Andersson <andersson@kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hans Verkuil <hverkuil@xs4all.nl>, Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Philipp Zab
 el <p.zabel@pengutronix.de>, Ricardo Ribalda <ribalda@chromium.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tianshu Qiu <tian.shu.qiu@intel.com>, Tiffany Lin <tiffany.lin@mediatek.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, Yunfei Dong <yunfei.dong@mediatek.com>
Date: Sun, 28 Jan 2024 11:01:13 +0000
Message-ID: <170643967334.1879520.13311953581412781310@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Ricardo Ribalda (2024-01-26 23:16:06)
> The field is gone, remove the documentation.

Looking at 3e89586a64df ("media: i2c: adv748x: add adv748x driver")
confims it was never added. Must have been an old leftover when I
upstreamed.

Thanks for the fix.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/i2c/adv748x/adv748x.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/media/i2c/adv748x/adv748x.h b/drivers/media/i2c/adv7=
48x/adv748x.h
> index 6f90f78f58cf..d2b5e722e997 100644
> --- a/drivers/media/i2c/adv748x/adv748x.h
> +++ b/drivers/media/i2c/adv748x/adv748x.h
> @@ -173,7 +173,6 @@ struct adv748x_afe {
>   *
>   * @endpoints:         parsed device node endpoints for each port
>   *
> - * @i2c_addresses:     I2C Page addresses
>   * @i2c_clients:       I2C clients for the page accesses
>   * @regmap:            regmap configuration pages.
>   *
>=20
> --=20
> 2.43.0.429.g432eaa2c6b-goog
>

