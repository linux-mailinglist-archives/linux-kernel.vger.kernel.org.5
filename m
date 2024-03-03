Return-Path: <linux-kernel+bounces-89913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997A186F736
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2238BB20C98
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171207A706;
	Sun,  3 Mar 2024 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O9CEudH8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2864829CE1
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709501598; cv=none; b=GIsxcQjbmz1tH3YXvaxZkrlrdKR7+H7sdTMD16UwaJ7R7Uwbse34zlBvt5+5yVd+TdI5fC3Aa2ySHek//93R2VsNM4YDyJ9UNABP1Q85zhBqlICM/Q1XJriWdo7i5X0yh86fP7CHuarVaURaQXIZPEg19qGQ4NptYRsOd5/dpZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709501598; c=relaxed/simple;
	bh=obTV5TTH9kmE4OBYAyNzzEkwDDH3N9hdBdw2ZrMrDiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9XCl+aVwiB0LsVrf+VdJfrrXfR3SEirI14Zn0q526ucJPlAUI5N7VX0m8Q+SkhYl9PMdVR89MTloIoD/jwksGe5VHnc0RcxXzlKSVuGYUnitF5pKDHyzWRyilNyRarWT/ETNlxV5ZvFdc34hZpKToFvfqjZaUIPhO0CuFM/faQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O9CEudH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1376AC433C7;
	Sun,  3 Mar 2024 21:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709501597;
	bh=obTV5TTH9kmE4OBYAyNzzEkwDDH3N9hdBdw2ZrMrDiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O9CEudH8ybKVRhyQ7SV2qsaVQSsMP9LIWRtHp+COREXp+Xpi+1V7iV3sYaFww3BNC
	 EYX0K+d2GRrLnrQUrIaU4i10+9TO+I6dpj1IFBMi8jbI0ZlS+L/yec7yqxzcRW6Ohx
	 jVZgHNEiXI5dKjJtt4rQiN7knBeqyRo9QYbQxZls=
Date: Sun, 3 Mar 2024 22:33:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Aman Sharma <210100011@iitb.ac.in>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: pi433: Updated bitrate range from datasheet
Message-ID: <2024030301-busily-composure-784e@gregkh>
References: <ddbd681a7504ae8b8fd4dc69270e804d@iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddbd681a7504ae8b8fd4dc69270e804d@iitb.ac.in>

On Mon, Mar 04, 2024 at 02:28:02AM +0530, Aman Sharma wrote:
> From a0528708b209739f0d566401bdd428e215abf366 Mon Sep 17 00:00:00 2001
> From: Aman Sharma <amansharma612002@gmail.com>
> Date: Mon, 4 Mar 2024 00:44:06 +0530
> Subject: [PATCH] Staging: pi433: Updated bitrate range from datasheet

Why is this all here in the changelog?  Also, please use
scripts/get_maintainer.pl, you have sent this to an obsolete email list.

> 
> Updated bitrate range for FSK and OOK modulation from datasheet.
> 
> Signed-off-by: Aman Sharma<amansharma6122002@gmail.com>
> ---
>  drivers/staging/pi433/Documentation/pi433.txt | 6 ++++--
>  drivers/staging/pi433/TODO                    | 1 -
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/pi433/Documentation/pi433.txt
> b/drivers/staging/pi433/Documentation/pi433.txt
> index 4a0d34b4ad37..9ce7282ef6f8 100644
> --- a/drivers/staging/pi433/Documentation/pi433.txt
> +++ b/drivers/staging/pi433/Documentation/pi433.txt
> @@ -78,7 +78,8 @@ rf params:
>  		Allowed values: 433050000...434790000
>  	bit_rate
>  		bit rate used for transmission.
> -		Allowed values: #####
> +		Allowed values (For FSK): 1200...320000
> +		Allowed values (For OOK): 1200...32768
>  	dev_frequency
>  		frequency deviation in case of FSK.
>  		Allowed values: 600...500000
> @@ -169,7 +170,8 @@ rf params:
>  		Allowed values: 433050000...434790000
>  	bit_rate
>  		bit rate used for transmission.
> -		Allowed values: #####
> +		Allowed values (For FSK): 1200...320000
> +		Allowed values (For OOK): 1200...32768

Where did these values come from?  If you can explain that in the
changelog text when you resend a v2, that would be great.

thanks,
greg k-h

