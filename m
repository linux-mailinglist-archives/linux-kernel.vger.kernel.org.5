Return-Path: <linux-kernel+bounces-64021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2589185390E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD947287098
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169ED60871;
	Tue, 13 Feb 2024 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GU9IamEX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528A36086F;
	Tue, 13 Feb 2024 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846871; cv=none; b=SGOp/a6eFIMMAXR0RfjXcl74N9WM8zudUKEBwzmoCu2Y1g/29In9lQHRG+fId7yRtFilYNVLqkTjBhef0kI0L/+upB+w/ky6EcaPTw4DAFzpyVcnWAxiFNXm7JJVRNKrfH3D/y3V5um42NTMNkJvmSvHqSOeKl+BZFZgtMO8iz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846871; c=relaxed/simple;
	bh=lQKEhu/1EaRGJzq03PLQDWc0KpPhjlaPfa4t6ws4iIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1XNnHf6GaC/H6Ro9XKnUgXVqzuihnvqdkMtnVeFfTCsN4VyCScJqVmY9Eb80E0eeSL+auz0ONGq5tT0q07fzKmYWtapLGsTl4+YpqMafHoYfhJ+b8Ie9GmhNTpYWP9qO45gjbQ62axh4IaGnWRftZE5zQyz4mPluGxtQF0LA4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GU9IamEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6125C433F1;
	Tue, 13 Feb 2024 17:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707846870;
	bh=lQKEhu/1EaRGJzq03PLQDWc0KpPhjlaPfa4t6ws4iIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GU9IamEXkTxm02hiL1I7+qKJHuEzco0YKmm4AFkkEuVZbG0xDSiMqB9JuPTXUPYQj
	 2639rXB/l29ElL8BkTX2/gCOYj6aU2OdhD4lxw9aPZK1IA9twMmA6jTjKH1imMLuGm
	 py1HYSRB6QJXWLpDZ333KgDmsVy5+mT8GUZ1WBKM=
Date: Tue, 13 Feb 2024 18:28:11 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/port: make cxl_bus_type const
Message-ID: <2024021308-donation-sinless-4005@gregkh>
References: <20240213-bus_cleanup-cxl-v1-1-a601adabb391@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-bus_cleanup-cxl-v1-1-a601adabb391@marliere.net>

On Tue, Feb 13, 2024 at 11:46:59AM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the cxl_bus_type  variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

