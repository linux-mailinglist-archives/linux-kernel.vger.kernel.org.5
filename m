Return-Path: <linux-kernel+bounces-112700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B98887D20
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2021F213EF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E1218651;
	Sun, 24 Mar 2024 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVztc0Db"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1C518622;
	Sun, 24 Mar 2024 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711288577; cv=none; b=MJqZKPrH9wYp+vvvBaJlISKwyciIEJE+gmh3ueBWGGIWfszRExIFDAF38OmdJ3jZj06BRE2FYJPiL7i+r8jbxpG9uUoMFQrMAjSoZ493s0bXW13h/u+kwfaillTPFTYch82U8ulfpLRMrY6kUCsfNTxMi60RbmFoYmJ+3KT7ZKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711288577; c=relaxed/simple;
	bh=e0TNT9hvgC+8BnESH0czQ1VhFxeHzqWbWZrLn5xAYd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3f//U3rcgmC46IR/6NWVvsn4ormSYEn+uFp8eiFeuKGghzKS/4iK+9gllMt5/Iv2tQJ+tkbgtAfJ3lwMuxE7Hz/8AtRcM1IeFI4T3QLnVq5sOaaACU+7cdO1HeOm3xW4GM1feHSn/EOlU+Z2DRUQLqDQdQee/IYHJ6DtLWYP9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVztc0Db; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFB6C433C7;
	Sun, 24 Mar 2024 13:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711288576;
	bh=e0TNT9hvgC+8BnESH0czQ1VhFxeHzqWbWZrLn5xAYd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hVztc0DbRB5JJY/eLjUFyCa57frLkHN9uZ7tW++UahBQeIhB7nOVmKv+RHswWwLxv
	 ++yoJqA8L/BxdLBSCNNDsstpF/mY3V0UZYowEpAAV+swglq4naUf/2e8H9ranEy/Qb
	 cKUv7zyi5hg3pAQJOY0jURXlebB2HmSIYeDFRq79iZc8aSqzOnljnXfA+QUI5TsWIW
	 P2EzAcpWzHd5RvdjWUHpt5u3a1igcNoOUzKTJWjPGslHNCnXbcZPnd81Uw81UW2+aQ
	 NK0IIDTkMDlIX/4CAQw7JN+kjOxO8i8zfmhWRCKOvY9KhKEDlukYROj1xmp3zdj1VB
	 I39TWa+PJ78mA==
Date: Sun, 24 Mar 2024 13:55:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andrej Picej <andrej.picej@norik.com>
Cc: haibo.chen@nxp.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, lars@metafoo.de, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 upstream@lists.phytec.de
Subject: Re: [PATCH 0/2] i.MX93 ADC calibration settings
Message-ID: <20240324135559.1640551d@jic23-huawei>
In-Reply-To: <20240320100407.1639082-1-andrej.picej@norik.com>
References: <20240320100407.1639082-1-andrej.picej@norik.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 11:04:04 +0100
Andrej Picej <andrej.picej@norik.com> wrote:

> Hi all,
> 
> we had some problems with failing ADC calibration on the i.MX93 boards.
> Changing default calibration settings fixed this. The board where this
> patches are useful is not yet upstream but will be soon (hopefully).

Tell us more.  My initial instinct is that this shouldn't be board specific.
What's the trade off we are making here?  Time vs precision of calibration or
something else?  If these are set to a level by default that doesn't work
for our board, maybe we should just change them for all devices?

Jonathan

> 
> Since we had these patches laying around we thought they might also be
> useful for someone else.
> 
> Best regards,
> Andrej
> 
> Andrej Picej (2):
>   iio: adc: imx93: Make calibration properties configurable
>   dt-bindings: iio: adc: nxp,imx93-adc.yaml: Add calibration properties
> 
>  .../bindings/iio/adc/nxp,imx93-adc.yaml       | 15 +++++
>  drivers/iio/adc/imx93_adc.c                   | 66 +++++++++++++++++--
>  2 files changed, 76 insertions(+), 5 deletions(-)
> 


