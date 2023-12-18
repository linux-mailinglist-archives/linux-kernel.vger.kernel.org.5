Return-Path: <linux-kernel+bounces-3210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB48816939
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DEF282FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B8D11720;
	Mon, 18 Dec 2023 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXBA8X2F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2875111A3;
	Mon, 18 Dec 2023 09:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FCFC433C8;
	Mon, 18 Dec 2023 09:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702890378;
	bh=4Kqu7Tflub3+Tx70K1IHzdsQJxsW8k1JryHMUncCWSc=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=gXBA8X2FwW/c3dXwWHfUBgx5jsMZaR8K/eukF0Ulra0mRotcMZRCSUVBINwoWB6D8
	 8hP/SA4WkT9IWHaY20F3UCf2+Lnqahe4WNNz2EePsDyGgJp9MgN3buzAjllp7jAHQB
	 zl/t/rC2uA1ZRMnwmXuijwsz6xKTlhARp77LkCntIaDQ1qJopS9zr3w+XyTdiH7wfo
	 sHgiuA690TvVE4VkNziHpaubpVzmwTan43mDLfE40aloWJ3miXkKuhuGReqvxt496+
	 h3KQJw7BhIrDtMPwO4BZJi/36dVFN8J/xd5YzpjqQiNhdTWLyncsFVFz0WN3PWkSGC
	 siZ3Y/AQwYeOQ==
Message-ID: <c272ee2efed850089ea05abaa8dcef94@kernel.org>
Date: Mon, 18 Dec 2023 09:06:15 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Alex Bee" <knaerzche@gmail.com>
Subject: Re: [PATCH v2 23/27] drm/rockchip: inno_hdmi: Add basic mode
 validation
In-Reply-To: <20231216162639.125215-24-knaerzche@gmail.com>
References: <20231216162639.125215-24-knaerzche@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, "Andy
 Yan" <andyshrk@163.com>, "Conor Dooley" <conor+dt@kernel.org>, "Daniel
 Vetter" <daniel@ffwll.ch>, "David Airlie" <airlied@gmail.com>,
 =?utf-8?b?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>, "Sandy Huang" <hjc@rock-chips.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Sat, 16 Dec 2023 17:26:34 +0100, Alex Bee wrote:
> As per TRM this controller supports pixelclocks starting from 25 MHz. The
> maximum supported pixelclocks are defined by the phy configurations we
> have. Also it can't support modes that require doubled clocks. If the
> variant has a phy reference clock we can additionally validate against VE=
SA
> DMT'srecommendations.
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

