Return-Path: <linux-kernel+bounces-130377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D6D897851
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19DA9B39A34
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2494015531F;
	Wed,  3 Apr 2024 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/IrVZng"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6948B155308;
	Wed,  3 Apr 2024 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712165458; cv=none; b=CZE5UfuGLu5vUFjwWYaNwSNP3wJD/q/LbF62z3CGclX4iefVxS+cgNWvnK3+SFYfQ2qOS0Sg8x3VLinik9r0y1BKz2pI813rgEoO0eYRRhk3h06LvjtJe4kiDWxfTbIyeeCr9NRm8A6/UKsO6xipo9VYvO6MY46dAqDUDiM25iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712165458; c=relaxed/simple;
	bh=fCq5u0P/Wl77vMxDnid45k6WLZ1g+bNRf2GHj07WRhc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Yqyhq+y8PiKSeoCuZE/L2g0FacN4fHuVoNRy1rM9uQeroxSROw0DJSoYCPUWp2897mYVhNQd9jKZZT9G5J4YL+3Ruurg8d7XHd/WKIA28yH5LtuYJYp8OzJGHYNrV9yemV+xWJaFfZahdSu4kY3B6KHV7C4ccWleXlxto4wWwX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/IrVZng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996B7C433F1;
	Wed,  3 Apr 2024 17:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712165458;
	bh=fCq5u0P/Wl77vMxDnid45k6WLZ1g+bNRf2GHj07WRhc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=m/IrVZng47+UpwuZiANRbG7J5jLq9EaAbRin8XvZ3QXwIiD+1nLZp45uJ/uKWveFf
	 /BKZl+jdVf0P3hYcGy8TESPqN7he/vVdqJYmUVuPLy+Fgr/F0qpAhKWvdLfzLTvzGY
	 Onwf1aggOtpGEnvrwsZGyK6ppNgEReFMeDolp5tQ0y0eVNYRbe/pWqBooV1+ivKIVJ
	 L2Z7QcFOGi+KBDDZDHgVbLtj6PS73ZFiij/nCUgqZZPz2JqfK61IlZnvAVbznlwzLb
	 riVqOFEEMldlov2Muqh0TpUkLyyGhgbnaEmbkcVTQhthUwLhNadKnXASh2vSeOJ8My
	 CUrGd5T1/VQIQ==
Date: Wed, 3 Apr 2024 19:30:55 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
cc: Yaroslav Furman <yaro330@gmail.com>, 
    Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    Lucas Zampieri <lzampier@redhat.com>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    "open list:HID LOGITECH DRIVERS" <linux-input@vger.kernel.org>, 
    open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] HID: logitech-dj: allow mice to use all types of
 reports
In-Reply-To: <02d348c8-4125-4f72-a431-e6d62b8533cb@redhat.com>
Message-ID: <nycvar.YFH.7.76.2404031930210.5680@cbobk.fhfr.pm>
References: <6713652f-9a44-422e-b6a7-45501093cb08@redhat.com> <20240403165425.114844-1-Yaroslav.Furman@softeq.com> <02d348c8-4125-4f72-a431-e6d62b8533cb@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 3 Apr 2024, Hans de Goede wrote:

> > From: Yaraslau Furman <yaro330@gmail.com>
> > 
> > You can bind whatever action you want to the mouse's reprogrammable
> > buttons using Windows application. Allow Linux to receive multimedia keycodes.
> > 
> > Signed-off-by: Yaraslau Furman <yaro330@gmail.com>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks to both of you. I've added

	Fixes: 3ed224e273ac ("HID: logitech-dj: Fix 064d:c52f receiver support")

and applied.

-- 
Jiri Kosina
SUSE Labs


