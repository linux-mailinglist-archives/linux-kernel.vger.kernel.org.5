Return-Path: <linux-kernel+bounces-129676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB1F896E56
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F4CCB26D2B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FDA14386F;
	Wed,  3 Apr 2024 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYlcQnui"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6808713666D;
	Wed,  3 Apr 2024 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144384; cv=none; b=earM92gmZhoFcOJZXAmkuoTP3D0Uj3UwhKe+HWXuOPjX/u3Bix7vHpx6iau+jzRpr26AAwPCFfq5Mch5plYWzjHJFnEqRGs5T1qK1ESN03/7kuhg8cR8R9rYeh51j/jTRn4JTdHPpiAecyHacW3DIN4GH+7ZRHfm0GYMxRGYC2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144384; c=relaxed/simple;
	bh=mvYZuBxJXxGpXB5wj+4WpCrpVjpVmOelNwKfdMONOlg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sqTRaaOUz+UCrKjTOi3m8o0ueL1LkoQhkI2G0kN0qi66kpM5LGXFaNOd1pEwkVBEve89SEgYxE3wmsIOpBVdoVRE19qWEGFbo92afOGeqIT2dNFdngnh+qO6JywKKsgjO9C4VxQ6Dtunv3B+loIGpU+5uFdkIn4cRTX1+yyQMVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYlcQnui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B629C433F1;
	Wed,  3 Apr 2024 11:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712144384;
	bh=mvYZuBxJXxGpXB5wj+4WpCrpVjpVmOelNwKfdMONOlg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=iYlcQnuiWGYuTwRM9hRLNqzEnt/VrSxn7VMrZmOwOvgYodb7vKGJV3nIHylOZB2Wv
	 NzAdIX9FTO5FuMSYZBgOwDwl3FZdsSKUeTcner1gIOePx12mwrbRjx6GyIbnZhsKvh
	 6xfUJUTuymv9SuHS6cI9HO/gnTUrvvBpojjIvJrCWPHikIU4C45BSaCld6H+3YSsLu
	 u6rr2mLI3uAyp/C08jvHlfnMnEaBbxDDStIyTDhkBfEy48EWkc7hN6zqqfsVEnZFhK
	 t4F4lrA2u6De5+GpqQBrGXAsoDGwRQhBD7Y54+u1Z+mk1/ZjhZhjKuTkt5OF91UtGp
	 sZWjAcaUpqUog==
Date: Wed, 3 Apr 2024 13:39:41 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Max Staudt <max@enpas.org>
cc: "Daniel J . Ogorchock" <djogorchock@gmail.com>, 
    Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: nintendo: Don't fail on setting baud rate
In-Reply-To: <20240315165729.17817-1-max@enpas.org>
Message-ID: <nycvar.YFH.7.76.2404031339350.20263@cbobk.fhfr.pm>
References: <20240315165729.17817-1-max@enpas.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 16 Mar 2024, Max Staudt wrote:

> Some third-party controllers can't change the baud rate.
> 
> We can still use the gamepad as-is, so let's do that.
> 
> Signed-off-by: Max Staudt <max@enpas.org>
> ---
> Changes in v2:
>  - Made hid_err() a hid_warn() since it's not a fatal failure.
> ---
>  drivers/hid/hid-nintendo.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 997c3a1adaca..395ed6b5ef59 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -2164,8 +2164,11 @@ static int joycon_init(struct hid_device *hdev)
>  		/* set baudrate for improved latency */
>  		ret = joycon_send_usb(ctlr, JC_USB_CMD_BAUDRATE_3M, HZ);
>  		if (ret) {
> -			hid_err(hdev, "Failed to set baudrate; ret=%d\n", ret);
> -			goto out_unlock;
> +			/*
> +			 * We can function with the default baudrate.
> +			 * Provide a warning, and continue on.
> +			 */
> +			hid_warn(hdev, "Failed to set baudrate (ret=%d), continuing anyway\n", ret);

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs


