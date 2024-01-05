Return-Path: <linux-kernel+bounces-17743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1C78251E1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2691C22C72
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B3725116;
	Fri,  5 Jan 2024 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XVFfGJmf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6866E250F4;
	Fri,  5 Jan 2024 10:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837B5C433C7;
	Fri,  5 Jan 2024 10:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704450376;
	bh=s3mtJTvuYHdeyBQggl9EVdJFY7DVkC48wjvMymD/mdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XVFfGJmfT8stTQTdKj3Fr6OKIgnzmdjZ4HLdLx6KU2Rf2htGJ4voM36JBrLFCEEvh
	 sAE5cK1FtK5BmF1uwI6oI2iPh64K35rTipVd5ooO77lHae8cCx5J9Ien+ko7MS7kb4
	 qpP3qPdBV3sUh3Z9DQrFpHGyOoI6MkFcQfxwGKzM=
Date: Fri, 5 Jan 2024 11:26:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ricky Wu <ricky_wu@realtek.com>, arnd@arndb.de,
	linux-kernel@vger.kernel.org, frank.li@vivo.com,
	u.kleine-koenig@pengutronix.de, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v7 3/3] mmc: rtsx: add rts5264 to support sd express card
Message-ID: <2024010542-stratus-during-896d@gregkh>
References: <20231208032145.2143580-1-ricky_wu@realtek.com>
 <20231208032145.2143580-4-ricky_wu@realtek.com>
 <CAPDyKFrcUPtPrENW_0_H9F8Hq4YBuK_MTpMSi+CdnNycQ6LDFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrcUPtPrENW_0_H9F8Hq4YBuK_MTpMSi+CdnNycQ6LDFw@mail.gmail.com>

On Fri, Jan 05, 2024 at 11:16:52AM +0100, Ulf Hansson wrote:
> On Fri, 8 Dec 2023 at 04:22, Ricky Wu <ricky_wu@realtek.com> wrote:
> >
> > rts5264 can support sd express card, so add the id in sd express card init
> > to do rts5264 register setting when the sd express card insert
> >
> > Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> 
> Greg, unless you think it's too late to get this in for v6.8, feel
> free to pick this mmc patch too as a part of the series.
> 
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

These are all part of my tree, and have been so for 3 weeks now, and in
linux-next.

thanks,

greg k-h

