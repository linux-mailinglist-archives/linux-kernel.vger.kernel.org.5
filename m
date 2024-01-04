Return-Path: <linux-kernel+bounces-16752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5378824357
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A86286AD4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A14225A1;
	Thu,  4 Jan 2024 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vYsCuo26"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC76224D6;
	Thu,  4 Jan 2024 14:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBC2C433C7;
	Thu,  4 Jan 2024 14:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704377432;
	bh=uDth7KmyzATmC2kleWV3LLGBcLwN2Lie8klUXNSdqtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vYsCuo26GTHHBiYpln6c4SiZO4OHp5kbSH6bkGP6kAS+MVUVeyAs+jpuiF6XqKC5L
	 CueIAQ8YlylBtyd7fLTrcH1HMXYbVXP7IftWEfg9G59wEP9uTn+lrwvXEg02EDjltq
	 LnqEGt+bYii2aRbEq7wA4P+PU/h74UKib8xdAMJo=
Date: Thu, 4 Jan 2024 15:10:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] media: ucvideo: Add quirk for Logitech Rally Bar
Message-ID: <2024010421-habitant-scope-ba8d@gregkh>
References: <20240102-rallybar-v3-1-0ab197ce4aa2@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102-rallybar-v3-1-0ab197ce4aa2@chromium.org>

On Tue, Jan 02, 2024 at 02:38:45PM +0000, Ricardo Ribalda wrote:
> Logitech Rally Bar devices, despite behaving as UVC cameras, have a
> different power management system that the other cameras from Logitech.
> 
> USB_QUIRK_RESET_RESUME is applied to all the UVC cameras from Logitech
> at the usb core. Unfortunately, USB_QUIRK_RESET_RESUME causes undesired
> USB disconnects, that make them completely unusable.
> 
> Instead of creating a list for this family of devices in the core, let's
> create a quirk in the UVC driver.
> 
> Fixes: e387ef5c47dd ("usb: Add USB_QUIRK_RESET_RESUME for all Logitech UVC webcams")
> Cc: stable@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

