Return-Path: <linux-kernel+bounces-68762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E9C857FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F23A1C21E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DAA12F367;
	Fri, 16 Feb 2024 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAsXnPRv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573E7219E5;
	Fri, 16 Feb 2024 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095108; cv=none; b=gt4pEPFGOaHMjyxYEP3WdLUtRtiTg7Cx+BSothX81mZYm/W0zpCecxuewJlakq6Ay9UsPl+157uI3JpganwE2SzGXK08qoot0MWiIOirKBWYfquzXSQPQQ3yCCCpynlTUXE2u3mxmjxq4GKitMSCOEE7AkO8WzSbVBqTYzVYwrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095108; c=relaxed/simple;
	bh=8tIsQgTJQNuYJGMq2BuA0XxdAj2qyiBt8UDymJdjNls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVsyx8rjqi4xoEvJSOG7zLCsFzM9HsdExD5W2zs3ZdRvVE9hDfPDMwXF+mevJ+nRkXDnICOgoCrfE84FnE8E4vGq3dHnfxbW4QMXfzfLPrHLnVRsVNFnUer7SEj1acjh3xFtl2ldPmKRsRjth7q0QKGvITBEYP+bn2XHf7xPPJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAsXnPRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0BCC433C7;
	Fri, 16 Feb 2024 14:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708095107;
	bh=8tIsQgTJQNuYJGMq2BuA0XxdAj2qyiBt8UDymJdjNls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qAsXnPRv0ebRH+kgXZyquX3MHc22+uakHaNlD+Pqmq1r+e5M0JsRUNfHbF5QEXNb0
	 1yXtzpP9XjtW9R7LsVADFKhOVBQbeO4EwiJBqNPbrXVc84AfP1RqEwXLWruz6Uav6c
	 n79u+hV6rvXg6GVEvkWTxMscSCcqlDyGpCHiVLiy+66l6FE2PAK/aNWEOSjOMAVHhc
	 5Iavi7SB/RN8pfEAoN+8PWYduCycRYBnuQXnrJ6SNuZeI0ktAg2HzTozWxuSF4e20G
	 rUSmZrPzRzojy4PiCwoliVjmgWDNE3MME0wwIFEQ9fnI8MKBPQ96I3u9gWnR6O+v7S
	 wYmDS5qnq1btA==
Date: Fri, 16 Feb 2024 14:51:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: andy.shevchenko@gmail.com
Cc: Marius Hoch <mail@mariushoch.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 0/3] iio: st_sensors: lsm9ds0: Miscellaneous cleanups
Message-ID: <20240216145136.54991a09@jic23-huawei>
In-Reply-To: <20240211201526.1518165-1-andy.shevchenko@gmail.com>
References: <20240211201526.1518165-1-andy.shevchenko@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Feb 2024 22:14:31 +0200
andy.shevchenko@gmail.com wrote:

> Just a few ad-hoc cleanups. No functional changes intended.

All look good to me so applied.

Thanks,

Jonathan

> 
> Andy Shevchenko (3):
>   iio: st_sensors: lsm9ds0: Use dev_err_probe() everywhere
>   iio: st_sensors: lsm9ds0: Don't use "proxy" headers
>   iio: st_sensors: lsm9ds0: Use common style for terminator in ID tables
> 
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h      |  5 ++++-
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c | 21 +++++++++-----------
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c  |  6 ++++--
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c  |  4 +++-
>  4 files changed, 20 insertions(+), 16 deletions(-)
> 


