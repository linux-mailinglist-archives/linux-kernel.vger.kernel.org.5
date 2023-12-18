Return-Path: <linux-kernel+bounces-3845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B186B8173D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572B228172F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E92C3A1A8;
	Mon, 18 Dec 2023 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLKOMdyd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D950137885
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD35C433B8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702910322;
	bh=kSzzS+rE3ZFEys64qw4zoAxJseoPrLHcYBpQolk4UeI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OLKOMdydbi6vyVhuOEDgdeX5gGnEoJCNZi1PkTEUWYWpp/b6ddUKbFq2O+Yneo5+O
	 /BuXAQ5+QWgW+oOfUZjE6aRujhz5uiXERoAdmu/dmvueV6u5LtQnQa+5tEZeR0/1Wu
	 Dbbqmt3/GTQtKP9MqNJoH7XkyINUAhO1/RlR62UcjlmO3HbgnoS7M1wqT9azJULsk7
	 ehKKzlAfbp0j7y7550kXk4IGR0/8UP+89YRYhP4x9mMQbYda3pjN6ulj8Rsibo69x+
	 7GcA0/w4BQeGKZBf+ju3QBuLhRHlYtbONRjBNCnBKmKWQqJYNDvbKCow4zP2K2Rtxz
	 rSFEePnWh4BUQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e18689828so3488592e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:38:42 -0800 (PST)
X-Gm-Message-State: AOJu0YyJffiTLbvChSm04ID5csg2+MPLEO3V/84t5KG54gwRns15PUCb
	g8KTu2sOsk7ZtwOEP0bwNHm3fG8yT3DpWW/Ohw==
X-Google-Smtp-Source: AGHT+IFVvXy/HULTWkwoWcQfaNrNUCb4i1BcigWcwb36HZhNpUO1zDKEOTu4PVk3/ddgjO9u+X5Q9oQvmLo6pfDG8Dc=
X-Received: by 2002:a05:6512:3044:b0:50e:1daa:6705 with SMTP id
 b4-20020a056512304400b0050e1daa6705mr3478799lfb.6.1702910320486; Mon, 18 Dec
 2023 06:38:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121142938.460846-1-nfraprado@collabora.com>
In-Reply-To: <20231121142938.460846-1-nfraprado@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 18 Dec 2023 22:38:29 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9g-9qTaja6dV5uD4Gbjw3fusRVnmucUeKUYtMpreVORg@mail.gmail.com>
Message-ID: <CAAOTY_9g-9qTaja6dV5uD4Gbjw3fusRVnmucUeKUYtMpreVORg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: dp: Add phy_mtk_dp module as pre-dependency
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, kernel@collabora.com, 
	Bo-Chen Chen <rex-bc.chen@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Guillaume Ranquet <granquet@baylibre.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Nicolas:

N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com> =E6=96=BC 2023=E5=B9=
=B411=E6=9C=8821=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:29=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> The mtk_dp driver registers a phy device which is handled by the
> phy_mtk_dp driver and assumes that the phy probe will complete
> synchronously, proceeding to make use of functionality exposed by that
> driver right away. This assumption however is false when the phy driver
> is built as a module, causing the mtk_dp driver to fail probe in this
> case.
>
> Add the phy_mtk_dp module as a pre-dependency to the mtk_dp module to
> ensure the phy module has been loaded before the dp, so that the phy
> probe happens synchrounously and the mtk_dp driver can probe
> successfully even with the phy driver built as a module.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@colla=
bora.com>
> Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort drive=
r")
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
>
> ---
>
> Changes in v2:
> - Added missing Suggested-by tag
>
>  drivers/gpu/drm/mediatek/mtk_dp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index e4c16ba9902d..2136a596efa1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -2818,3 +2818,4 @@ MODULE_AUTHOR("Markus Schneider-Pargmann <msp@bayli=
bre.com>");
>  MODULE_AUTHOR("Bo-Chen Chen <rex-bc.chen@mediatek.com>");
>  MODULE_DESCRIPTION("MediaTek DisplayPort Driver");
>  MODULE_LICENSE("GPL");
> +MODULE_SOFTDEP("pre: phy_mtk_dp");
> --
> 2.42.1
>

