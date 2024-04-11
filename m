Return-Path: <linux-kernel+bounces-139729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32BC8A06ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2042E1C22555
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A252F13BAF2;
	Thu, 11 Apr 2024 03:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMB06dxZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E487D13B58D;
	Thu, 11 Apr 2024 03:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712807391; cv=none; b=OmZ4FNe1ZA4JFTVMf2i37MB+q8lZuuokjpcBoIOZP8WfKBeZNiR7YPL10Eb7i5CvPIkrhsSzEUM2EjStTiy/R84/29eKXQF9Cb4CPacmGsnXm9QHMfvacdkEZyFEA2pCy9pZbDECGrtm7HXoNCA3TRh7oh/VOxk2JyUQ6vb+iEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712807391; c=relaxed/simple;
	bh=jncq167E+A7c/9mv2GMObRw2ajRb87w4vjjHtsLhEDU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=VM1NKKlnXntsw9bIw9TSmp3Xfh3AW+kv8jsZXcuew78EgyID99ojM8x2kin1dwMUL/1I8m/78KwnU266RCfN/ITVZYgDtg8qp1cjfNno8kjQsOkFTnjtbx20sfNfUwIio0oks4UpJfGK4ijW/knms8A2/nzNPqb4hsGoaJbWGHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMB06dxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD65C433C7;
	Thu, 11 Apr 2024 03:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712807390;
	bh=jncq167E+A7c/9mv2GMObRw2ajRb87w4vjjHtsLhEDU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ZMB06dxZAeP6Fh8v/d5cTELajQvG44msTGTutJyBVYVlACllHBEJ/U4R/k/Z9ds2t
	 069Zb3Pn39roSSei160kK47u/VY7WIZeIPH0GwclDUSh+HRbsmu6QIUv92ej10Jif+
	 2TJI5kBYfmM8Mj/sNgoXbqsJl0m3BGCtIJKiRo9ZeRpY98Oy5qKk7vHYbE9UvZwCFo
	 oF2n5PX9yYkTVKI6EGhEaB+eTZaVUpNU+EYkMoiuwxQc8vClqhcI3c2rx6llnI27aN
	 EaYshG/eqP+/P9Url3k9gj+UFWlBibXYcUyMJnpymMnuCUsWnyJTI0mEEpIep1Xs8+
	 XwpzEZhrtIiDA==
Message-ID: <e6ecf39d6b4378731f3aa19350e0d5b7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240308-mtk-fhctl-no-node-error-v1-1-51e446eb149a@collabora.com>
References: <20240308-mtk-fhctl-no-node-error-v1-1-51e446eb149a@collabora.com>
Subject: Re: [PATCH] clk: mediatek: pllfh: Don't log error for missing fhctl node
From: Stephen Boyd <sboyd@kernel.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, =?utf-8?q?N=C3=ADcolas?= F. R. A. Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, Edward-JW Yang <edward-jw.yang@mediatek.com>, Johnson Wang <johnson.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, =?utf-8?q?N=C3=ADcolas?= F. R. A. Prado <nfraprado@collabora.com>
Date: Wed, 10 Apr 2024 20:49:48 -0700
User-Agent: alot/0.10

Quoting N=C3=ADcolas F. R. A. Prado (2024-03-08 12:29:56)
> Support for fhctl clocks in apmixedsys was introduced at a later point
> and to this moment only one mt6795 based platform has a fhctl DT node
> present. Therefore the fhctl support in apmixedsys should be seen as
> optional and not cause an error when it is missing.
>=20
> Change the message's log level to warning. The warning level is chosen
> so that it will still alert the fact that fhctl support might be
> unintentionally missing, but without implying that this is necessarily
> an issue.
>=20
> Even if the FHCTL DT nodes are added to all current platforms moving
> forward, since those changes won't be backported, this ensures stable
> kernel releases won't have live with this error.
>=20
> Fixes: d7964de8a8ea ("clk: mediatek: Add new clock driver to handle FHCTL=
 hardware")
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---

Applied to clk-next

