Return-Path: <linux-kernel+bounces-53455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1227E84A439
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445D91C24D10
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A150213C1CA;
	Mon,  5 Feb 2024 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F1zSWBPJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B846134759
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159820; cv=none; b=P9dHgOh860t1PPPejlC2ohHh3twaC3ze+ZeRdWP71aT1QumHCLuqCvh0aEFxRJTHwpB/SXswbD20+ZQCjk4jpkRVcTzDKXZ4WUIIsicn4mim37KLnBGLI7VMjWpi2xOvVjz1ZY/1Profe53cfP3yYU+8loiM/0YVL+u+GhoSF4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159820; c=relaxed/simple;
	bh=ES8p9LauLrAHUMV4ASKY0YXyfJqfS78JihNa/CG3BrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uqq2ApqBTSh8o1EalCxSgIL3+QlHJd/a4NZHuazVSWcxeaAa9fzsJjL6bMY6A7oB1yLstMxQGISshXixrHPXr/11psbCJVTnLP4SrrlB4yg6qEA9AJCstGqyWMy642pSk2y3JzxZDyuk0B07QMQeIVzsg4eDqKnfrxG7hXFIsjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F1zSWBPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26A0C41679;
	Mon,  5 Feb 2024 19:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159820;
	bh=ES8p9LauLrAHUMV4ASKY0YXyfJqfS78JihNa/CG3BrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F1zSWBPJeKCZZYfkmDZxvAsIAF/iPNgRsxX/uT//ChKlG7uWzV9OhDHpcUzCWsHx6
	 xV7OF9moGbVQtYF5JyqGKfgfRXyRDr+GZZH3+qedr1z5hzqAx3Kq9gDWhQ/uuYAi0T
	 H7+3+h4AjOcSPIEkZsenKgpZEcYYGfOV9KXLQGCc=
Date: Mon, 5 Feb 2024 04:45:41 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] const_structs.checkpatch: add bus_type
Message-ID: <2024020554-brilliant-slug-1d12@gregkh>
References: <20240204-bus_cleanup-checkpatch-v1-1-8d51dcecda20@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240204-bus_cleanup-checkpatch-v1-1-8d51dcecda20@marliere.net>

On Sun, Feb 04, 2024 at 07:39:57PM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct bus_type
> a const *"), the driver core can properly handle constant struct
> bus_type. Make sure that new usages of the struct already enter the tree
> as const.
> 
> Suggested-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Note, there are a handful of in-kernel instances where this will not
work, but it's not worth special-casing them, they will be obvious when
attempts to change them happen.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

