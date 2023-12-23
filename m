Return-Path: <linux-kernel+bounces-10500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B228281D520
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536BE1F22082
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF98610940;
	Sat, 23 Dec 2023 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPporjS7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BECDDB7;
	Sat, 23 Dec 2023 16:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5E3C433C7;
	Sat, 23 Dec 2023 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703349620;
	bh=KS7YCRC4NCwBZglO7G2FfSSppkyOZ7I1bvshGs9NiHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gPporjS70QdVLlK5aMkwdcl64sVbOZvy/LJuNu0U9C2L0rmebH4y2Hqc43lxWrW/Z
	 2l2ZTiX/XoGF/uoVsKujQvl9P/begrmyFiO2sUShM8IjjfGjqXNkr/6xxNKg6s2DZG
	 4bHYPhhM1ZQTBNA5QpCJWY2ZBy74mwu7PUhxyoLE8kQMggVsKQOiym/lClE61O9f28
	 dhUmSIhuHefYwa2cY5fh5QDZFCBvZ73hkl+M7HlK5T7myjSAkI2oWxYq5f3/DTprp2
	 r7rMMNlcMxQ/+nRURIJo5BrNcLaHp0ZahUMc17IziZufbG75t3QRy4lIpXq+puJvNO
	 E9EAEHf7VyQOw==
Date: Sat, 23 Dec 2023 16:40:16 +0000
From: Simon Horman <horms@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Vadim Fedorenko <vadfed@fb.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v1 1/1] ptp: ocp: Use DEFINE_RES_*() in place
Message-ID: <20231223164016.GH201037@kernel.org>
References: <20231221140607.2760115-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221140607.2760115-1-andriy.shevchenko@linux.intel.com>

On Thu, Dec 21, 2023 at 04:06:07PM +0200, Andy Shevchenko wrote:
> There is no need to have an intermediate functions as DEFINE_RES_*()
> macros are represented by compound literals. Just use them in place.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks Andy,

this is a nice cleanup.

Reviewed-by: Simon Horman <horms@kernel.org>

