Return-Path: <linux-kernel+bounces-148390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 999798A81E0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D2B282DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C0113C8F0;
	Wed, 17 Apr 2024 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vlOzN0OO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64A113BC00;
	Wed, 17 Apr 2024 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352651; cv=none; b=XLZo9EPmBkaS2jXWFRVWRyif+W4B7o/xSS0Hh3hn0biJ7pvfdKR5cwj3S+VTDOqe8rjaStGOXWSoqdiPHrWRxWfR6GlF8CRnVN/S+XHXYjYxkfSpQ7sHuonCP6INwWyB8Os2C3hqRMqsXSaHIcM5QZ1PyMgU8qvd6RwfJsstuVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352651; c=relaxed/simple;
	bh=D0RgMYoj6Ef/uU6l47mhhx98/uOw3uzb6irETR25xCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5zeubPHSFi+TJqPPRBjcEyKhrV2Ifns5PATo2GZfEYIpyBso35FPV7UFi4r2xBXoy+9QDEjLNgloJ4YypjkOBUJiPp8E+PRdzPz7f431NzIXKf67ORAjfXrJGBmJUtoxHpVrpiC51mqf1FGCfJtEOm+RnrCtpRb27it6pz+/Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vlOzN0OO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD35C072AA;
	Wed, 17 Apr 2024 11:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713352651;
	bh=D0RgMYoj6Ef/uU6l47mhhx98/uOw3uzb6irETR25xCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vlOzN0OO6TIbpzGDKTwRDaEPOp89EnjkNAmc12wkVwQ1LF8LxFhew7OuR5bc3AiU5
	 xkEI6ZWd8NSaYxTAHxMj7VHwtMR2aHgD3QoY6NMCZzqjfckCpSMWIyLV/eAMGf3/o7
	 aoDc8bmlRq0MGmBCe13bjiKTumVNY2SE3lluPofU=
Date: Wed, 17 Apr 2024 13:17:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Parker Newman <parker@finest.io>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v3 1/8] serial: exar: adding missing CTI and Exar PCI ids
Message-ID: <2024041756-aerosol-morality-41af@gregkh>
References: <cover.1713270624.git.pnewman@connecttech.com>
 <7c3d8e795a864dd9b0a00353b722060dc27c4e09.1713270624.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c3d8e795a864dd9b0a00353b722060dc27c4e09.1713270624.git.pnewman@connecttech.com>

On Tue, Apr 16, 2024 at 08:55:28AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> - Added Connect Tech and Exar IDs not already in pci_ids.h
> 
> Signed-off-by: Parker Newman <pnewman@connecttech.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 42 +++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

I took this one now as it's "obviously" correct :)

thanks,

greg k-h

