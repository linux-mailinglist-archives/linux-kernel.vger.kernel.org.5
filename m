Return-Path: <linux-kernel+bounces-66484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2B0855DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E25C9B33F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393F91B957;
	Thu, 15 Feb 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="RDH3eo22"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEE31B953
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987826; cv=none; b=jrY+pJraGsbXzNnfeNOTNqhU50GB02z7P0pueXyxtjsZyxejvm/nMR1c5O810RIg4fb9gqc9Lg+jJFWWxs8Ah5V4nEFMfXNhZ814aMvTwTipwVPdMQ4Xk9sW4KXrpM0cGSckJcV6nTlMB7Qvvr+D8jhu6vRDz+Ai6jsOIH6rbUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987826; c=relaxed/simple;
	bh=zQrS4HbyreGN0s+IdWF/KCYWN7W7xmEy9D7hkjVlPjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXYr5/rwitUQRZiT6eNHEfHtjKdd9YpwLvuiHmHiJu+z5wR1q7y3EGPcl8iCmmE23Z4PHvBopuTA3hfy2i7vWvuUXFbvm/K3E/fGCxvlssaOkfIzm7NY2hlErlD0wlr8a+r8Crt3BCRiX65Q3HGbJfGLc1PPZ95xaq6dhmUvT/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=RDH3eo22; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1707987823; x=1739523823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zQrS4HbyreGN0s+IdWF/KCYWN7W7xmEy9D7hkjVlPjI=;
  b=RDH3eo22clDNCtVla1di1eQ8VSzHgRbKjLC9BqYHWMybg4rSaXSY2Yp1
   6UqlBvmfDhAJM4pNBJDU3Man/uYHWIKPTdjPdHITu2sLoI7DA6dn8+5rT
   h2ZceNHlecPt4g/5j2Gp0u4uOy69XnBfG2RBf9ADnsfFztPUSkN4Uc52H
   0Cu0oZ5GmsQoFiXBVhvfgeFu46oVxteDCByCG2yLdu3axmkVWvZVdClA7
   7Nqg3YIi3iCFYTFiqo7hBmvTa3hJGQRuORsBWX5Bd5/++GpO5Ybk0I0rj
   YZshxyPcmLg6jAdFgx+mmmUJrwXN9LY47XRalRV7KZRRCN/vGlpp4LG4/
   A==;
X-IronPort-AV: E=Sophos;i="6.06,161,1705359600"; 
   d="scan'208";a="35419042"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 15 Feb 2024 10:03:40 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id D8F34280075;
	Thu, 15 Feb 2024 10:03:39 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Aradhya Bhatia <a-bhatia1@ti.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org, marex@denx.de, Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] drm/bridge: tc358767: Fix DRM_BRIDGE_ATTACH_NO_CONNECTOR case
Date: Thu, 15 Feb 2024 10:03:41 +0100
Message-ID: <3277848.aeNJFYEL58@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <2f3bb86b-6f8c-4807-985e-344a0c47864c@siemens.com>
References: <20231108-tc358767-v2-0-25c5f70a2159@ideasonboard.com> <f6af46e0-aadb-450a-9349-eec1337ea870@ti.com> <2f3bb86b-6f8c-4807-985e-344a0c47864c@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi everyone,

Am Donnerstag, 15. Februar 2024, 09:53:54 CET schrieb Jan Kiszka:
> On 11.12.23 09:07, Aradhya Bhatia wrote:
> > On 06/12/23 17:41, Tomi Valkeinen wrote:
> >> Hi,
> >>=20
> >> On 08/11/2023 14:45, Alexander Stein wrote:
> >>> Hi Tomi,
> >>>=20
> >>> Am Mittwoch, 8. November 2023, 12:27:21 CET schrieb Tomi Valkeinen:
> >>>> These two patches are needed to make tc358767 work in the
> >>>> DRM_BRIDGE_ATTACH_NO_CONNECTOR case, at least when using a DP
> >>>> connector.
> >>>>=20
> >>>> I have tested this with TI AM654 EVM with a tc358767 add-on card
> >>>> connected to a DP monitor.
> >>>=20
> >>> Just a question regarding the usage of this DSI-DP bridge.
> >>> What is the state of the DSI lanes after the DSI host has been
> >>> initialized,
> >>> but before calling atomic_pre_enable? AFAIK this bridge requires LP-11
> >>> on DSI
> >>> at any time for accessing the AUX channel.
> >=20
> > + Marek
> >=20
> > Marek, Alexander,
> >=20
> > A quick grep tells me that you have added devicetree for tc358767 in DSI
> > to (e)DP mode on other platforms. Could you please test these patches
> > and report if you find any issue?

Sorry, I can't provide any feedback here. I've yet to setup the DSI-DP=20
correctly.

Best regards,
Alexander

> Is this the last blocker to move forward with these fixes? I'd really
> like to see them finally merged.
>=20
> Thanks,
> Jan


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



