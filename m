Return-Path: <linux-kernel+bounces-66918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9640856393
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C0C1C218C6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF15D12DDA7;
	Thu, 15 Feb 2024 12:46:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22BF12DD85
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001189; cv=none; b=DmbHmXHaCRU6YwBmaUeg2L2z03cJbNjQsXPcHYwZMoykmwhFrBl4adkvVrYSrXWLtAr3S+R4HxVQ9QE/2aii1kGnF8AqYt/dCbO3pnSgUXVbQPVDTp09fQx+Wv2SJkIRUmnFyVYb3XIOAA11tGbAv2M1MMeQCUJpkNnf23YkVdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001189; c=relaxed/simple;
	bh=JWD/gC44BPMpo+4SCSu+0tYfdw7qofXROJUgb4GlD3M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XcttoRLwbTTg1Gleub4EKIMpsuZubsW+CJR5B0eg2kZYiYFdjohO6weaKNUSv4yA0hQoz/bzYDp6MJdXzQoGXhxSPkfR4MWw+UY0UV+QD6VLFotpKb1no3WtOf/8lpa78QmzURreYsK/r2LuYEeJLYOk8hzok6Eb4byl/hVUNYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rab8C-0003tl-Hz; Thu, 15 Feb 2024 13:46:24 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rab8B-000t60-3w; Thu, 15 Feb 2024 13:46:23 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rab8B-0007kP-08;
	Thu, 15 Feb 2024 13:46:23 +0100
Message-ID: <4a1a0b142ca58e1c22ba246991d4ee657a4ee91f.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/4] reset: simple: add support for Sophgo SG2042
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Chen Wang <unicorn_wang@outlook.com>, Chen Wang <unicornxw@gmail.com>, 
 aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com,  robh+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com,  xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org,  inochiama@outlook.com
Date: Thu, 15 Feb 2024 13:46:22 +0100
In-Reply-To: <MA0P287MB2822E03B61DF33B4438833D9FE4D2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
References: <cover.1706577450.git.unicorn_wang@outlook.com>
	 <1cfd7b3ba447942784c4f7aa595e962399e9f617.1706577450.git.unicorn_wang@outlook.com>
	 <MA0P287MB2822E03B61DF33B4438833D9FE4D2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
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

Hi Chen,

On Do, 2024-02-15 at 16:59 +0800, Chen Wang wrote:
> ping ~~~=20
>
[...]
>
> hello,=C2=A0 Philipp,
>=20
> Can you please have a look of this, I have fixed the issue you raised in=
=20
> last version, any question please feel free let me know.
>=20
> BTW, will you pick this for v6.9 if it is ok to you.

Yes, I intend to do this tomorrow.

regards
Philipp

