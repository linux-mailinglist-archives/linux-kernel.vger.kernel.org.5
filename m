Return-Path: <linux-kernel+bounces-51744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA440848ECE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B657B216C1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1E5224F2;
	Sun,  4 Feb 2024 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMDiEiCo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3A8224E3;
	Sun,  4 Feb 2024 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707059338; cv=none; b=dSXsFCQAR939n75qL9tfwkudycDlMKK92tra5UCMsQC5cDCvbm7hCXNv465gLDm/8xc0aE7BH84WkxqevLvAVz9nbP2Z1FKbdhKR//XbLf9AVNTE9F5uHBUDkEsMcXzpqKLmTaAVErF+RzAq6ceVUQjEsdn1KkSk4sdXIds/nt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707059338; c=relaxed/simple;
	bh=diWs3n7BcEuYEZpCWt4QRWyW21+UNJGnGq5SYsQ7F/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D0d5552CJDnsPaW9NWZVS21IguIJcozWy0Vt/LZ7M6iomqNvK8XEOhEueUWYRvN2igkZMCO1g/EMn4CyrqS/eZ+53hTpExcKIucrAVt5m8r2ykNwKHeRD3SnxhVbQpi9sxTdYztGXmgwzEU1M4vGK2QHUbn3RpVR7VsT0PSSF9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMDiEiCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712F9C433C7;
	Sun,  4 Feb 2024 15:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707059337;
	bh=diWs3n7BcEuYEZpCWt4QRWyW21+UNJGnGq5SYsQ7F/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CMDiEiCoShhFWaDKBgKT3zcw8DLeWsPhdrEwqM8OV5nPqcRGY4Sas8LTHorAY9GOE
	 1od/nEiNUobZGmSraGcd7naeGZesBdZHvVlHL/VvwWbK/0DR8Z4yIq5giSZKfL3JAr
	 BE5Lw1HWn2BhAMabGwlkTuA9IvC0OhN77hcYpYhkxaWHaLz0TocbHy6ZG10Zzpua50
	 +5gVWF757qcXYvgZyJLnNm1fbDa7DAJnvPVZ/FahYy+98oM/TTHs/FmmB1YFxAVwF/
	 LzhyxG8dBnJ9GTQv9lcwDGKjy2o6hyClFvn7ztm3To5rOslG07QpbcH9Dfw56OHgdX
	 WJByZlA4FhFiQ==
Date: Sun, 4 Feb 2024 15:08:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nikita Mikhailevich <ermyril@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mxc4005: new ACPI ID for the MXC6655
 accelerometer
Message-ID: <20240204150843.79f76071@jic23-huawei>
In-Reply-To: <20240201151848.1666245-1-ermyril@gmail.com>
References: <20240201151848.1666245-1-ermyril@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Feb 2024 16:18:48 +0100
Nikita Mikhailevich <ermyril@gmail.com> wrote:

> New ID was introduced by Chuwi on Minibook X 2023.

So interestingly MDA is a valid PNP ID. But an old one from 1997 for
Media4 Inc. 

Let's hope they never used that device number in a way that will bite us.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to play with it.

Note that if anyone has a path to Chuwi to educate them on how to do
ACPI ids correctly then feel free to pass it on!

The MXC ones are also invalid btw - in that case there is no such PNP
ID unless it's been very recently granted which seems unlikely.

Jonathan

> 
> Signed-off-by: Nikita Mikhailevich <ermyril@gmail.com>
> ---
>  drivers/iio/accel/mxc4005.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> index 82e8d0b39..09764ef8b 100644
> --- a/drivers/iio/accel/mxc4005.c
> +++ b/drivers/iio/accel/mxc4005.c
> @@ -472,6 +472,7 @@ static int mxc4005_probe(struct i2c_client *client)
>  static const struct acpi_device_id mxc4005_acpi_match[] = {
>  	{"MXC4005",	0},
>  	{"MXC6655",	0},
> +	{"MDA6655",	0},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, mxc4005_acpi_match);
> --
> 2.43.0
> 


