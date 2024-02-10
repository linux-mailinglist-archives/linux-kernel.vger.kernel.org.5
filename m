Return-Path: <linux-kernel+bounces-60448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B01850512
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DDF91C218A0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35E65381A;
	Sat, 10 Feb 2024 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqjb9FaP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23739364BF;
	Sat, 10 Feb 2024 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707581674; cv=none; b=FtkCQgJAHG/MZEvSpSPHdT7YOZV741MY/b5hXzdBzL551YmFk5ds4AL21r00Edh6869UV4WONrfv1wSEnVzNsaQzV3YG0m/FFMZZJsk7gk0qExBKAgzzplxc0NUFv4HTpm6iOP8G8/sjhmoucr0wPs8mxjk6Jv7HwkBMrO09ju4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707581674; c=relaxed/simple;
	bh=+dIM/YtKITESNs1bx14AElMSDus7Vy/zYBTG4fA0Sb4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WfvDy5NkXUjLSrNv0MMb+GfjXbZ0Gm9WhLpyRGlDM/zN6Eoox+IKnncwDp9zFRsj4JEU0kwkqo31niFPxzdlmznYAmCNNGJKxT0dVM38ukpn+000YDjYDeKvRfuyA73XYfKTS9wKDz/P4sPcgeEda2KgPgmLt6UI+Sd4yaLMDFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqjb9FaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED027C433C7;
	Sat, 10 Feb 2024 16:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707581673;
	bh=+dIM/YtKITESNs1bx14AElMSDus7Vy/zYBTG4fA0Sb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jqjb9FaPu/j5gmTazMy0pzaqzDbuc8HUxwhEvqKPsQo6zCCNXc8Hqm4SbEokyrraN
	 jzoN20VAPbKEMKDin+DU7Jzg3c5hJQRtsdw41dO5C3e6lrdNTVROlgMT/AintsRYTm
	 ggiXhDMePeB5/0pP4kbk5IMCBCuPoSt7AkKgZgOeHdTJzR94sZOhaPIlJOa0djW37F
	 KV7fb04x9tanVmGpZ8wdE/aPiauFLosD5zkRww5sCZlGy5PYFi6mflI/TAszo+cRSt
	 1wGg6T/tRA5+IKQVNFIwV66GgszwBw8b7i7IXoJ6zwrM+bnpNbsBqNT2mtp6Me1ca8
	 Gz5e+fWCb/bBQ==
Date: Sat, 10 Feb 2024 16:14:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, lars@metafoo.de, Basavaraj.Natikar@amd.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Add support of color temperature and
 chromaticity
Message-ID: <20240210161422.22e67983@jic23-huawei>
In-Reply-To: <20240205185926.3030521-1-srinivas.pandruvada@linux.intel.com>
References: <20240205185926.3030521-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Feb 2024 10:59:22 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> The original series submitted to 6.7 (before revert) is modified to
> solve regression issues on several platforms. There are two changes
> introduced before adding support for new features to allow dynamic
> addition of channels.
Applied and pushed out as testing for all the normal reasons (0-day
gets to play with it!)

Thanks,

Jonathan

> 
> v5:
> Change als_scan_mask to per state instead of global
> v4:
> Addressed comments from Jonathan and Basavaraj
> v3:
> Addressed comments for v2, details in each patch.
> v2:
> New change to add channels dynamically
> Modified color temperature and chromaticity to skip in case
> of failures
> 
> 
> Basavaraj Natikar (2):
>   iio: hid-sensor-als: Add light color temperature support
>   iio: hid-sensor-als: Add light chromaticity support
> 
> Srinivas Pandruvada (2):
>   iio: hid-sensor-als: Assign channels dynamically
>   iio: hid-sensor-als: Remove hardcoding of values for enums
> 
>  drivers/iio/light/hid-sensor-als.c | 122 ++++++++++++++++++++++++-----
>  include/linux/hid-sensor-ids.h     |   4 +
>  2 files changed, 108 insertions(+), 18 deletions(-)
> 


