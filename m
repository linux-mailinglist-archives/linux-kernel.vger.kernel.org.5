Return-Path: <linux-kernel+bounces-11585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D52281E887
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA651C20949
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5994F889;
	Tue, 26 Dec 2023 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQJxk12Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0784F61A;
	Tue, 26 Dec 2023 16:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DEFC433C7;
	Tue, 26 Dec 2023 16:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703609503;
	bh=WXuVzw/i2VPRJ5769EW7k1lg5vCW0bPilNIGTNQMMqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CQJxk12YM2r1TyiGjD7kbUqZbrompeUme7z+LQZ0c7ShIfmP8GYKv6XE0xm1HNSbd
	 3ZpCa9+y4NowPCsA3xDgeRWH/J6jivjdrR96wOj32rDXWElVWY7yr5/Y5BSvXVsmE9
	 EHfMG0RGQEX/9jJSEifwUiISogRqPOifmwN5nhy9s803NNxMRDR8c69XQGHReMkr3l
	 LIEsXDQnONtCCn9NXPNqtCU5hoi5ICfFRFp/HmPZiQGKyCuNyd54d+PsYgDRnRc826
	 2H7pKa0gNHJd0cWFujIZYutswc8pnOIK0nlxYaILRtT1gStLjNJijPLFXuNTwuATCs
	 MKMDeGKZp/1xQ==
Date: Tue, 26 Dec 2023 16:51:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Klinger
 <ak@it-klinger.de>, Lars-Peter Clausen <lars@metafoo.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Angel Iglesias
 <ang.iglesiasg@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 10/10] iio: pressure: mprls0025pa.c add SPI driver
Message-ID: <20231226165139.78dc2dc5@jic23-huawei>
In-Reply-To: <20231224143500.10940-11-petre.rodan@subdimension.ro>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
	<20231224143500.10940-11-petre.rodan@subdimension.ro>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Dec 2023 16:34:55 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Add SPI component of the driver.
> 
> Tested with mprls0015pa0000sa in spi mode on BeagleBone Black on
> slightly patched 6.7.0-rc6 mainline.
> 
> Tested with mprls0025pa in i2c mode on BeagleBone Black with togreg
> branch on
> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> (tag: iio-for-6.8a)
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> Tested-by: Andreas Klinger <ak@it-klinger.de>
This and previous patch look fine to me.

Thanks,

Jonathan


