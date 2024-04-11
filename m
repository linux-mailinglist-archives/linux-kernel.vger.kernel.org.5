Return-Path: <linux-kernel+bounces-140478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0656C8A1536
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DEE282402
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED0A14A4E5;
	Thu, 11 Apr 2024 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s6amwz0n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4750D634EA;
	Thu, 11 Apr 2024 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712840613; cv=none; b=tMd3Zr5eh5VdXiNCXvr7ArblJLx50uUnZ1EVE9JaFr5oC0Fvk5FwgurdV6Hi7mWOnxBAqIcqdwX1qpsDPLppzk0Uy+V3GDAqI0r1NYo7eQwIgDdQ7aBCNqIOMGs+A/t72gF9EOs8HcqYtWzOGz9WSqI117PNiH6LFZbdOtH4orI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712840613; c=relaxed/simple;
	bh=zU/kfADijr6TZDGC9HVf3SLG86X1f/kISTrnOErlmYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1O3V1blYNf2N9447UAsVwcm96CxEekArIZW4bqVF0/Q8q9RlGHUKDPISOzKeYDMgWJqQ5gdIdIJEE1HKv3maArUkPioGc06KZysDwPqDnUWQlTnXJzd/yN0ElGudSqjOnqj03g9c0z4Iv05x0fsz9RUK9ngwWBu3OeHlYQdi6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s6amwz0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CBEC433F1;
	Thu, 11 Apr 2024 13:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712840613;
	bh=zU/kfADijr6TZDGC9HVf3SLG86X1f/kISTrnOErlmYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6amwz0nM4hhjx4LtlRlhXaDxBcgLv3DdkMfZQqzNmLRnjTx/eVnQbjVsKpQv/Fge
	 Fcg2TTe/uFLZwFWrfJT5lBiWkxKYMPMaG/3YH7R5iXwc10VRaSXCbyynYC1HPq+4i8
	 9N7QEJ5oOwok7/1JA/T7FWgBDplQqf9l/yhzMVJU=
Date: Thu, 11 Apr 2024 15:03:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
Cc: linux-kernel@vger.kernel.org, m.nirmaladevi@ltts.com, lee@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jpanis@baylibre.com,
	devicetree@vger.kernel.org, arnd@arndb.de, lgirdwood@gmail.com,
	broonie@kernel.org, linus.walleij@linaro.org,
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	nm@ti.com, vigneshr@ti.com, kristo@kernel.org, eblanc@baylibre.com
Subject: Re: [PATCH v6 08/11] misc: tps6594-pfsm: Add TI TPS65224 PMIC PFSM
Message-ID: <2024041122-fever-record-8cd7@gregkh>
References: <20240408124047.191895-1-bhargav.r@ltts.com>
 <20240408124047.191895-9-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408124047.191895-9-bhargav.r@ltts.com>

On Mon, Apr 08, 2024 at 06:10:44PM +0530, Bhargav Raviprakash wrote:
> Add support for TPS65224 PFSM in the TPS6594 PFSM driver as they share
> significant functionality.
> 
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> Acked-by: Julien Panis <jpanis@baylibre.com>
> ---
>  drivers/misc/tps6594-pfsm.c | 48 +++++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 13 deletions(-)
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

