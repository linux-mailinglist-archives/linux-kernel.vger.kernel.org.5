Return-Path: <linux-kernel+bounces-93064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 902FD872A5C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25EC1C24A5A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A1212D1F3;
	Tue,  5 Mar 2024 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6Xg1ODR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C8818AE0;
	Tue,  5 Mar 2024 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709678613; cv=none; b=quZ3npHf/MpJ97T1qI0CBt0Z5/DJyy5GzgnwHlmmPgs5Aw8aZkJxqSzF74RXcG/2X9GbA8L119Q3cPIgwWXjYvEsuMNfKb4pgQE+oc19e0k0AxLJnz5Zc68uWpJ8uYR7KHgsC6kwp3zDuzTHe6qAjTYK85aLHqrFk4LcJu4RgbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709678613; c=relaxed/simple;
	bh=C1jm29FkASamL71zm7y/fD9Cy5RVlI8wo9G0DKX9sv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHXKAaoIQdd+ZurfBRvuZn5Ey6v3mPSd4sQL9dprdU3zFriPFmcakoetGjISWG3ifOfI4D1OcxeYLwzoq2DmPnvzGff8sqGIM3f/Y5uIucrX7RDjtIk71yYcVHOYYmReBppGfR2L0T5p4q8Wb9feL470gYo/DWdOAI2JkgM1FsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6Xg1ODR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14853C433C7;
	Tue,  5 Mar 2024 22:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709678612;
	bh=C1jm29FkASamL71zm7y/fD9Cy5RVlI8wo9G0DKX9sv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N6Xg1ODRIdZQ2MTbPFj0F07nB00h7iTaHHmUlL/WZT6xlhRhK5xcokEnTEbcx/jrv
	 kwUgmo60G2A5KBBq3S4yzwCLFw+xfglVZLhTW8uVtrJql41U63Bhh8/vJIj2RF6Eum
	 rGEkl9Uf+HZ2qr8iK7/cBzHXFtojgyDY3AKaJq7SkMYxzadsN9y58PM/TKR4+REm9i
	 ovli+asKXgaN2hdG1bJfNgztuRAf+r9friNgK1wjAbGEB7N4z3JkjctDEezOH/qQez
	 qtb7F4oWdgChoZ6AU5c4YqNeBKKKUQBvBO9j/XcAS8yuuVHJQ2TYgy0xyJIm85hT7O
	 CMx6FiaPUSRLw==
Date: Tue, 5 Mar 2024 23:43:28 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Young <sean@mess.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 0/5] media: ir-spi: A few cleanups
Message-ID: <bjvrsyrv7e53tnwvtuhmqcjyjhb4mqe2svvatfdwnqagfb6btv@c6rborytz3gk>
References: <20240305174933.1370708-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305174933.1370708-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

On Tue, Mar 05, 2024 at 07:48:25PM +0200, Andy Shevchenko wrote:
> While removing of_gpio.h where it's being unused, this driver seems to 
> deserve more love. Hence this series.

ehehe... thanks for the cleanup!

Andi

