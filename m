Return-Path: <linux-kernel+bounces-52544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CEF849982
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578E91F21FC0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD331AAD3;
	Mon,  5 Feb 2024 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jusFcVTp"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE211BC22
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134569; cv=none; b=Jb4a6hyBWoT97njDMmcRlG28/3imUXbvIHwmirAemT6O6PAzIE6FKVL3EqtDnEO383HIpKBl/JiSeU5dGo0ecEntnIDh4DuWjpPGOkQHIqEdJz7h0vZsxF6RHpwAZAD+iyNpkX9PdLtN1lT0d+wtat82wU1FjjjoDKa65pXQ9Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134569; c=relaxed/simple;
	bh=IHuWzzoQnQ1LIc9paceiQ4UQUnyVWgqSLS2YPlzPrrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0OgyMVTOvHX7JdjREjYm6MDUenl8xcql7s6skV9zq1PlaWJxX8aTTjJfn3Q2pe6XkUYEHG9HozQHsB9JIVvW9s+GExvQitcUcExBvUwrq0XNL67oS2m5VxypOr/3JbGQX2t0bzG45aZbXf35gr1I0hIKeWflga87q63MihpPYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jusFcVTp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1707134562;
	bh=IHuWzzoQnQ1LIc9paceiQ4UQUnyVWgqSLS2YPlzPrrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jusFcVTpIpmVN7hePpiuXMCeXDry8AlRozcH8NTI8wHExMhWdHnc1zzC8DL2q4oxi
	 b6NpidCNbgwJG1vNpUXDDHNa+mZlDf3sRuEf1RnCHPVyia/W2FmZTRYocSI95CIr8k
	 W1EGHiOUBJf0Wujm+cmAt7kKpx38cGNFc2YDA3I8=
Date: Mon, 5 Feb 2024 13:02:40 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] const_structs.checkpatch: add bus_type
Message-ID: <bbe7fc00-53ad-4a4e-8335-514280104863@t-8ch.de>
References: <20240204-bus_cleanup-checkpatch-v1-1-8d51dcecda20@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240204-bus_cleanup-checkpatch-v1-1-8d51dcecda20@marliere.net>

On 2024-02-04 19:39:57-0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct bus_type
> a const *"), the driver core can properly handle constant struct
> bus_type. Make sure that new usages of the struct already enter the tree
> as const.
> 
> Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  scripts/const_structs.checkpatch | 1 +
>  1 file changed, 1 insertion(+)
> 

Thanks!

