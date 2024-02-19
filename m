Return-Path: <linux-kernel+bounces-70947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0BD859E94
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F27280E16
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235D42137F;
	Mon, 19 Feb 2024 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0yqVocF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565DB210E1;
	Mon, 19 Feb 2024 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331982; cv=none; b=ZmQpe1e3rBD38waFx2W9zzbYTl1mROvzFKFDpVXuFUyr0TiFeQt0GqgQfVuo9K0sFN1T2IqqKDktEGRqAvZwRhlUpSlnisEIphuWEjH1Tf3j9QDqP9fzb7YWi6Bcpcuodwqa6t7PRyHSFQ9FWWneut2OKUEtVtB+bKpKtIO4gVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331982; c=relaxed/simple;
	bh=crEQOFsZ0LiXnQXnd+HTFgulg92PQY/yu8OuVPtUikk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WddvLALnnzx/SbMCBsf7+PZdUFWg6KIt6NDh30hkebigx5lb43xUjP7sh5yAz3EgD4o1fkbXY4TiOfr+R6jZ0rHzdzXNmT/at1zp81mfnE1lpdDRXDlIzSUMddTFZKL+gbQfRwwvVCYFz4OPXJfWFwDqk3VdEQj6tjoM6l54UyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0yqVocF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDDEC43390;
	Mon, 19 Feb 2024 08:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708331981;
	bh=crEQOFsZ0LiXnQXnd+HTFgulg92PQY/yu8OuVPtUikk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0yqVocFIJEhQ9HbiG4+5G7+3VDenlt6KGMSXspuncofTEEmfjltgGudjYN+SEqtQ
	 g6puL38eAMH1zPUu7rLyS1pkz2ZOd6p42ZSGssL/qlh12uEsHI8nU/35ShBXOt6kxB
	 cJc257pU77VW0cN80wN51XMkWtlKKkceWHGH5quW0fhYtKUwvtR3rcMV05ugMfn7Xt
	 RQiDQ1BDOCQ8AZI/rDYuqA5mT+NhjVepoP9Wo1zhFWqPY/pAJMpBzloYjOVIX0fAH3
	 4G16G7sU4rvW5E/q37FrIn/r2P3ERMWTjk6+EEQhGB4rZ5KzCwADEpJrQpOfhcSqC1
	 qAn9bTpasdQWw==
Date: Mon, 19 Feb 2024 09:39:35 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH] dt-bindings: ata: convert MediaTek controller to the
 json-schema
Message-ID: <ZdMTx1CJzFR5uAzK@x1-carbon>
References: <20240213074747.26151-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240213074747.26151-1-zajec5@gmail.com>

On Tue, Feb 13, 2024 at 08:47:47AM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---

Hello Rob,

For device tree patches for
Documentation/devicetree/bindings/ata/

Usually, if we see your Acked-by, we queue the patch via the libata tree.
(If it is part of a series, usually you take it via your tree.)

We have a R-b from Krzysztof, but no Ack from you.


Kind regards,
Niklas

