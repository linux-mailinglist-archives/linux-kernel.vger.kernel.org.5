Return-Path: <linux-kernel+bounces-48347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D89845ABC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934E71C24B74
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2056215B;
	Thu,  1 Feb 2024 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H9oaUPXb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B66762145;
	Thu,  1 Feb 2024 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799544; cv=none; b=fCTJbNgJ0KK4eq9FGgeNQAvVK0jhRH+Mf7fvezJCHQnPuvDa5J/DPuajrw2oHNzsk7a5SRqkXqqI4R+x5xlWstfgYuGYRXIIsGVHiQRa5MyygTzr/C2JT+94Ou/sut7Txh9Noib5INw3DcEZgX8h+8hqZ3694xwsxJVmCig2ssc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799544; c=relaxed/simple;
	bh=utD8e2q1swSvNyntQq4hKbtFOMcI0nJaea91N/gOfK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R19GAun6ATDtWoTvIOuRzwoW3cgDI8H5ZKkaIyl1hrGOkqb2NTww2XV7jMTJnrg7BrzgIOtdku/ex3Sm4PqUGxXQjKjN3ET6OOzFaEN53h8+asOpZVZSseEsIbPPpwuqN7eNjH3citrwHGfTucPCySNFOPow79DBMG3W8G5b6w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H9oaUPXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D780C43390;
	Thu,  1 Feb 2024 14:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706799543;
	bh=utD8e2q1swSvNyntQq4hKbtFOMcI0nJaea91N/gOfK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H9oaUPXb+aUDB3oQebfIzSUMCMvEluMi2ZaY9pZFuWAY1pfzOrhlP5j6UyZ+MbpU0
	 qbXQ0MLf9EL78K8igyWpGDMvJt3ZakfbeM5EI7g5h1N56afKYOYO3hUpyD+WJH4gAg
	 /7LcEwBcCAwgj7awyT2NK+5b++8F1oy6N8dWddxU=
Date: Thu, 1 Feb 2024 06:59:02 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: phone-devel@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>,
	fiona.klute@gmx.de, martijn@brixit.nl, megi@xff.cz,
	samuel@sholland.org, heikki.krogerus@linux.intel.com,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: typec: anx7688: Add driver for ANX7688 USB-C HDMI
 bridge
Message-ID: <2024020126-emote-unsubtly-3394@gregkh>
References: <Zbt1dIByBZ2stzjm@mobian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbt1dIByBZ2stzjm@mobian>

On Thu, Feb 01, 2024 at 11:41:56AM +0100, Pavel Machek wrote:
> --- /dev/null
> +++ b/drivers/usb/typec/anx7688.c
> @@ -0,0 +1,1866 @@
> +/*
> + * ANX7688 USB-C HDMI bridge/PD driver
> + *

<snip>

Did this pass checkpatch?  I need a spdx line for new files please,
don't force us to go back and guess in the future, that isn't nice.

thanks,

greg k-h

