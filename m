Return-Path: <linux-kernel+bounces-149626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8569C8A939D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDA7282693
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B4838F9A;
	Thu, 18 Apr 2024 06:58:07 +0000 (UTC)
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837ED36AF2;
	Thu, 18 Apr 2024 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423486; cv=none; b=NwgYk4l8REAjBbEa9jenxfPYVlLpwRkQrMlYdyywBOFZYGhC2ZeoE8fX6nYo0WIwpP9nVP0kquRyLFqabWUY7PFE6xVuPRWcSgX7AzsjqY8IVKk2TRq+iYbzZ690UDM8+2sI4gN+6qOm7gEplyhxj1QF0D6VmMCxi+WWWcZMLX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423486; c=relaxed/simple;
	bh=fE/M2BBdmiOv3+JeGI7/kOBvg7/Tz6STSa9jybDFZGs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pUGFzEGbBc6CIIezxyCuo8pKqKIjwYkc2ubxg+jhlXdabot700J24BoAKD7h/torMdsFug8ib2dFy7uW0ea/tt0OFUW/QRO3Oj/8DgJs98eG+MeShgg7iNJiW2EKujGipJlpwX/y77oAa74BOhI21of0fZVXe7far6hFG1E8HGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4fefc49c.dip0.t-ipconnect.de [79.239.196.156])
	by mail.holtmann.org (Postfix) with ESMTPSA id C3228CECC5;
	Thu, 18 Apr 2024 08:48:08 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v10 0/2] wifi: mwifiex: add code to support host mlme
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20240418060626.431202-1-yu-hao.lin@nxp.com>
Date: Thu, 18 Apr 2024 08:47:58 +0200
Cc: linux-wireless@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 briannorris@chromium.org,
 Kalle Valo <kvalo@kernel.org>,
 francesco@dolcini.it,
 tsung-hsien.hsieh@nxp.com,
 rafael.beims@toradex.com,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0ED16BAB-6E7D-487C-BBCA-E63FEF37C60D@holtmann.org>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
To: David Lin <yu-hao.lin@nxp.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Hi David,

> With host mlme:
> Tested-by: <rafael.beims@toradex.com> #Verdin AM62 IW416 SD
> Without host mlme:
> Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # =
88W8997-SD
>=20
> This series add host based MLME support to the mwifiex driver, this
> enables WPA3 support in both client and AP mode.
> To enable WPA3, a firmware with corresponding V2 Key API support is
> required.
> The feature is currently only enabled on NXP IW416 (SD8978), and it
> was internally validated by NXP QA team. Other NXP Wi-Fi chips
> supported in current mwifiex are not affected by this change.

I am a bit confused here. If this is just for WPA3 support, then =
wasn=E2=80=99t
this suppose to be solved with external_auth support?

Regards

Marcel


