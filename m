Return-Path: <linux-kernel+bounces-146555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EE68A6724
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BAC8B21FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C531B85954;
	Tue, 16 Apr 2024 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n59vF7jk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B793BBEC;
	Tue, 16 Apr 2024 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713259810; cv=none; b=T5GyJpaoYlpCCd0vharTxY8Irmpvm7UBtJ/StxTURr4DfwfofWVs9cGk5mnbYmPfU/GKJsAQKwDiTLcZ/3sQFzD4YUp+/sKlASyS1Fwl5BHlZQBO04yxSVO5qqr+pjWBWqXObjPc5lxmV7JCtv49moYHKjbKACpW1GLViWaYOKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713259810; c=relaxed/simple;
	bh=WkygNKfyFZB4KyWZpojMTvLTOsLkMXsRNu5G7hcxtJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLWDVQBvv0MKPUrT3qcwV86t3RSG9hjQIVKuoiyzVyiNjqUL57m5NI2w+b52g3sBHaL2141w53IqhcMx+eu1l+T/Tb+7CM7RQG363CVTiHZ3fT/nOiq9DGpvntYaOBBXUpyVP19+PnqawvJ3yWBPwOc6j/GS7mTMi5eCTMeYHC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n59vF7jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A813C4AF1B;
	Tue, 16 Apr 2024 09:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713259809;
	bh=WkygNKfyFZB4KyWZpojMTvLTOsLkMXsRNu5G7hcxtJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n59vF7jkTOHxBhiQopo58oqJUX/HHosM4W0a+Mp+n85wMirrCz4rrUheI+yiS0I2r
	 5WcC4aNMhD3lZMiv/qdz0lY+VvlbyVJLLo774Onj1+jB5cUCJstvLhM8U95+47e9uK
	 g2SxRJm7MFvL1PVzcru2Q+LtHqLBSN717oQE0PDUijJ1TBxduB4Y1SesFbxPfdEhJu
	 YU771e7Uy0yGES5DpCCSIgKSse6CCxIdgUQo9uvEa9nvp21MHrf4YMFlYdxj+ES1Ju
	 0+7r/1wJl/R8j5Z3MMG/ILAN872lKr/YPKkgCGPBrvxEnrRjDCNG0cOKELu7pkG7K2
	 BlvHInVxXMceA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwf8h-000000005Ye-3g2V;
	Tue, 16 Apr 2024 11:30:08 +0200
Date: Tue, 16 Apr 2024 11:30:07 +0200
From: Johan Hovold <johan@kernel.org>
To: Vanillan Wang <vanillanwang@163.com>
Cc: gregkh@linuxfoundation.org, bjorn@mork.no, kuba@kernel.org,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB:serial:option/net:usb:qmi_wwan:add Rolling moudles
 support
Message-ID: <Zh5FH5iblkjq9XEL@hovoldconsulting.com>
References: <20240416084409.21550-1-vanillanwang@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416084409.21550-1-vanillanwang@163.com>

On Tue, Apr 16, 2024 at 04:44:09PM +0800, Vanillan Wang wrote:
> Update the USB serial option and qmi_wwan driver support for the Rolling
> LTE modules.

> Signed-off-by: Vanillan Wang <vanillanwang@163.com>
> ---
>  drivers/net/usb/qmi_wwan.c  | 1 +
>  drivers/usb/serial/option.c | 8 ++++++++
>  2 files changed, 9 insertions(+)

Please split this in two patches (they will go in through different
subsystem trees).

Johan

