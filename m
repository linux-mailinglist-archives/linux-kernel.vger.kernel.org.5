Return-Path: <linux-kernel+bounces-74765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBE885D944
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865A11C22EEC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754247641B;
	Wed, 21 Feb 2024 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHH1lJU9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32CE2C9A;
	Wed, 21 Feb 2024 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521381; cv=none; b=BFmvJBvav9+bzShAtXL+yeqfa2J8UH+C+2Zsq2vLZ41BpDKo+N77WmXuhzA3bKbTcnY6iV0bAaaydgCYw+rUYFcXDJoVNuO2oAfX2hmqw5wV28TaW+auoJdxUH/8uFXClyEEhNlOqlLl1us8GNbGZ3mCX85t3H2hegpi9ys2lR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521381; c=relaxed/simple;
	bh=CzNNwBJXqJo8+OeoGkqFUliEc/7tS1hf8ZqDIk6i4dc=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=V7CaApLaL1zZH1EBJnjU/aU9n3xQiq9YimRfjZkYkUw4q0aPheQiT/bECFjmZ1sWwUQKLK8p1JomZS2aDnfdDf8Wi/09TkZWd4j09CyOGNX0bXRuHQ6SSiWmueezTxbR7SrUYdL3qyite32KfrdvIUpB6k+gJRPSqUVr56opa70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHH1lJU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9D4C433C7;
	Wed, 21 Feb 2024 13:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708521381;
	bh=CzNNwBJXqJo8+OeoGkqFUliEc/7tS1hf8ZqDIk6i4dc=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=NHH1lJU9bkBJUiUtuhcFE+K0A2Bahbpo8q/yd3K+pm4+qd6baPUdX506iiSi9LqsK
	 XO8+DpTgBXcnBuSwJE5JqJIbJy8R+LGDOrLVOjbRU/1B92mcQmSPTssS6Y1ijka2XR
	 g8JW2GqTjezqkzF+7zOUqAbD+H8DygS3bOQzp0BtYbcLrYLzFvOTSJprODReef42Wp
	 xPNgOv5bfRAhhEtrkR5jfC5PaQxAs8IBRBhl5qOirhytkTyVy68Fo0itNv+rjQRPFf
	 8UjdTQseGSyWOR/qHhdEWdtc6DQFUcY1O52px197vlc6l/VinIEVuw1DeARD1vPV7A
	 a7moLGEUOq7/w==
Message-ID: <ae3aed3ae64fb4d3ba1f3a063c3b1733@kernel.org>
Date: Wed, 21 Feb 2024 13:16:18 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: =?utf-8?b?T25kxZllaiBKaXJtYW4=?= <megi@xff.cz>
Subject: Re: [PATCH 1/3] drm/sun4i: Unify sun8i_*_layer structs
In-Reply-To: <20240216190430.1374132-2-megi@xff.cz>
References: <20240216190430.1374132-2-megi@xff.cz>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, "Chen-Yu
 Tsai" <wens@csie.org>, "Daniel Vetter" <daniel@ffwll.ch>, "David Airlie" <airlied@gmail.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Ondrej Jirman" <megi@xff.cz>, "Samuel
 Holland" <samuel@sholland.org>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Fri, 16 Feb 2024 20:04:24 +0100, Ond=C5=99ej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
>=20
> These structs are identical, use a single struct to represent private
> data for the DRM plane. This is a preparation for configuring layer
> routing from the CRTC (mixer) instead of current approach of setting
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

