Return-Path: <linux-kernel+bounces-1283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D36A814CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A03028237F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE753C479;
	Fri, 15 Dec 2023 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="XnQLs3DJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA17381C8;
	Fri, 15 Dec 2023 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1702657234; bh=gxIU+Cnud2j3bNARAoIX3HgvhIYjXRvzI1SwQ9YSFug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XnQLs3DJk/8GvBEHSCEaONRRri1iImcp2JcuA3XM2XBIc6Xz+GTX00I+ZlGIyYmXE
	 +k/eelNYt3bph8Mmnfr1FugHH3LeLbjYWVapfKVOnpmK2EZloshTt1MiLg393eYSUn
	 CqLW+LvMLunnQf7VeHExvdKJQ+AZwXQsTJkNc+5c=
Date: Fri, 15 Dec 2023 17:20:32 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, jic23@kernel.org, lars@metafoo.de, 
	Basavaraj.Natikar@amd.com, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: hid-sensor-als: Avoid failure for
 chromaticity support
Message-ID: <9be8369c-4e23-4fa0-bc26-b236de669c8c@t-8ch.de>
References: <20231215160159.648963-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231215160159.648963-1-srinivas.pandruvada@linux.intel.com>

On 2023-12-15 08:01:59-0800, Srinivas Pandruvada wrote:
> With the commit ee3710f39f9d ("iio: hid-sensor-als: Add light chromaticity
> support"), there is an assumption that the every HID ALS descriptor has
> support of usage ids for chromaticity support. If they are not present,
> probe fails for the driver . This breaks ALS functionality on majority of
> platforms.
> 
> It is possible that chromaticity usage ids are not present. When not
> present, restrict number of IIO channels to not include support for
> chromaticity and continue.
> 
> Fixes: ee3710f39f9d ("iio: hid-sensor-als: Add light chromaticity support")
> Reported-by: Thomas Weißschuh <thomas@t-8ch.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218223
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/iio/light/hid-sensor-als.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)

Thanks!

Tested-by: Thomas Weißschuh <linux@weissschuh.net> # on Framework 13 AMD

