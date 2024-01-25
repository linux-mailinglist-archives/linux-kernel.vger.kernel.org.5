Return-Path: <linux-kernel+bounces-38886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7914783C7C6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0788D2953F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066E51292F1;
	Thu, 25 Jan 2024 16:23:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63088129A63
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199779; cv=none; b=LqCMIev+q1Btt3rPksDmtHP2TTbKQZep9usHPHlROE0DfA6Zr2DqVnnB8z2IMv4ehIBZgfa10T0pWz3vxM/f/EMpmJFXXrSKKgt2UPdBTIGek1UsrFubuKZ+mM7ZR/kNfE8WYYRsAP2MRFvJokAB3TprJ2maYrGrgbqCq3RkyeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199779; c=relaxed/simple;
	bh=948OdpEqmILp3RdOk6qnPZ/ZraA5lgrxD60yWTcbN7U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KKsFZp/GzIOj6H5YGDMz5pU8LKjM8KQW5C/Yrl3GdqtNKFy/YQwbN248wxIC01/qohKi5KIZfg3LufWTNqzBJmVqPiyj4U5Qr/OIiSJkfC8ws0YoCpE1441PGoZERWG2FuNC4x7syzeoSGg7ig9Drq8NwEF4m61WMFsjahwJvzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rT2V4-0000zy-GW; Thu, 25 Jan 2024 17:22:46 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rT2V3-002KHN-PZ; Thu, 25 Jan 2024 17:22:45 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rT2V3-000F7e-2L;
	Thu, 25 Jan 2024 17:22:45 +0100
Message-ID: <7897d74f90aa516f6b8e753e9e9befc64c113a69.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/3] drm/etnaviv: Update hardware headers from rnndb
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, Russell King
 <linux+etnaviv@armlinux.org.uk>, David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,  linux-kernel@vger.kernel.org
Date: Thu, 25 Jan 2024 17:22:45 +0100
In-Reply-To: <CAH9NwWdXVCfzUy88n49g0ZqaC9KVLuw7Des9JpT5t1sif7qy5Q@mail.gmail.com>
References: <20240125-etnaviv-npu-v2-0-ba23c9a32be1@pengutronix.de>
	 <20240125-etnaviv-npu-v2-1-ba23c9a32be1@pengutronix.de>
	 <CAH9NwWdXVCfzUy88n49g0ZqaC9KVLuw7Des9JpT5t1sif7qy5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Do, 2024-01-25 at 17:14 +0100, Christian Gmeiner wrote:
> >=20
> > Update the state HI header from the rnndb commit
> > 8d7ee714cfe2 ("Merge pull request #24 from pH5/unknown-3950").
> >=20
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>=20
> You missed my R-b from the v1 series for this patch - please include
> it the next time!
>=20
> Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>

Sorry,=C2=A0I'm trying the b4 prep/send workflow and hadn't internalized ye=
t
that "b4 trailers -u" is still a necessary manual step.

regards
Philipp

