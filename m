Return-Path: <linux-kernel+bounces-102941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C7287B8BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65BC1C2282D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEB75DF27;
	Thu, 14 Mar 2024 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTUJwV4g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD6C5D47F;
	Thu, 14 Mar 2024 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710402530; cv=none; b=aWPGrGhiOBhpPopXtJw4TdGLfBtEnRZ8THkGTjw0tWdRIucQ/YTmCCjXJcGZ4bTKCpni+6Xzij0GGFIBbhzOFV1Nk3/4sKO2rsKiolH+FBV0MjVVqA7PrEwR9JM1ngHQ67/yyNoZc41MLkBelw+Ca6/vJpN60rZfXqukYT+fESs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710402530; c=relaxed/simple;
	bh=F9FJ272hRWLSxHq8Ly87eevMmmeFD+m/E2C43x/bm7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n26TygfGKTimSIjynVddUN44jV11JLyTT6UxB6tTIqbXnXWsbox9wIpbWHS1brtjm5iCysLRXQu4ZWs2iBpUm6LUfY8m6k5ma4RGsoskgP7i5iHjNoWM2B+MyrEYNZ3LhXwUYFm126lHNSjshUWoogVCKOYuwdPVj5H/da7Zgq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTUJwV4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2636BC433F1;
	Thu, 14 Mar 2024 07:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710402530;
	bh=F9FJ272hRWLSxHq8Ly87eevMmmeFD+m/E2C43x/bm7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LTUJwV4gSBnUIbY57lAFi3z74adpgcOcpoWgJz+yXbscJyJGVsdzNCjV15f9c/hLf
	 0WAOY1iM7Gbo0dArK1L2ngk/P1Y1NrUFCNUrvvg7fbRmwLt3hotUToV+jospv8/3fG
	 QAtgMEEtFzSx6ZdEaRHMJpZVq+trY3h0uxDGcN7J3LHMbw56MqVpJm8wYnJvhvhwyb
	 1rZNuMtIf49gc7dzJhNQC0DlVd8lhyzuldkMR+4IIyaCFlDFS33coLzVGH49dBAK6+
	 3W1FpjRhOA9lBtrR0C646x3KCYQRUqFBx0Oo7UKFMlEQ+tqK6vZdTtod/lvrTNVl6O
	 gelZqlqtQZSHw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rkfph-00000000869-3TZL;
	Thu, 14 Mar 2024 08:48:57 +0100
Date: Thu, 14 Mar 2024 08:48:57 +0100
From: Johan Hovold <johan@kernel.org>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: greybus: add comment for mutex
Message-ID: <ZfKr6Tnq3QYg3ZQC@hovoldconsulting.com>
References: <ZfHuokO3pQXMOxcC@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfHuokO3pQXMOxcC@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>

On Wed, Mar 13, 2024 at 11:51:22PM +0530, Ayush Tiwari wrote:
> This patch adds descriptive comment to mutex within the struct
> gbaudio_codec_info to clarify its intended use and to address
> checkpatch checks.
> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> ---
>  drivers/staging/greybus/audio_codec.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/greybus/audio_codec.h b/drivers/staging/greybus/audio_codec.h
> index f3f7a7ec6be4..1f97d4fb16cd 100644
> --- a/drivers/staging/greybus/audio_codec.h
> +++ b/drivers/staging/greybus/audio_codec.h
> @@ -71,6 +71,7 @@ struct gbaudio_codec_info {
>  	/* to maintain runtime stream params for each DAI */
>  	struct list_head dai_list;
>  	struct mutex lock;
> +	/* Lock to protect register access */
>	struct mutex register_mutex;

No, please, don't send these kind of patches.

It's one thing thing to learn how to create and send a patch upstream by
removing or adding some white space here and there to drivers in
staging, but the above is not the kind of changes that people unfamiliar
with the code in question should be adding (and the comment in this case
adds no value at all).

Johan

