Return-Path: <linux-kernel+bounces-51732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B5B848EAD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7920A1C21D97
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B953D225DE;
	Sun,  4 Feb 2024 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="subHmU2D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ED1225D2;
	Sun,  4 Feb 2024 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058332; cv=none; b=fGdIdt378Uh6YyQNn/vz+wcJ7ImEfvZRe4iJAFIVPXUCx+j+wRHWJKVK50Sj6eT2K158Npo4cMEXYR9T8OmdrBuZTyamLQWo8aKhvpzACWDTXpEwCu+qEM9/len6c6XIdEkE0TItxOvL0YcsTQ4mNY3N0XlfTENJ0Ps4uHnV8Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058332; c=relaxed/simple;
	bh=BtmloRZUgXVfHb0x5/aVljflOg83lmGIiy2KAPL2EAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agNQlaCKF9xkl6g/5UQn21cAcfM/K14UbQJE0MvnuCS8Mw/cqkYGcYO+Rdhs+OhR9pG+Oa4C8rodphY1sCzmvIZniunPqktHx3fkGaqqI4//laFzauK0jc7MOWw4DaW+aVoVG8666HV+NQRddx1GIgRQAXS9JzF/+gIhXpwoLv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=subHmU2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CC3C433C7;
	Sun,  4 Feb 2024 14:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707058331;
	bh=BtmloRZUgXVfHb0x5/aVljflOg83lmGIiy2KAPL2EAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=subHmU2DMReqtZf5MNFj4eVctJunencxiS+O2b44+0Yy13YO44XRsbU8536SmbvAY
	 Lnyqrqxgxj+7OQE1uBejvotYa+YvBEHLZb+ka3U1D/9+OMwdRt3vq7SIfwpzZgx7/D
	 4hf8hrpzuD5tfH2m6NNQy4zu5FCS5mAO9a3Zc3ak=
Date: Sun, 4 Feb 2024 06:52:10 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] platform: x86: struct bus_type cleanup
Message-ID: <2024020401-dictate-recant-0d2e@gregkh>
References: <20240204-bus_cleanup-platform-drivers-x86-v1-0-1f0839b385c6@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-platform-drivers-x86-v1-0-1f0839b385c6@marliere.net>

On Sun, Feb 04, 2024 at 11:40:15AM -0300, Ricardo B. Marliere wrote:
> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]). Specifically, this series is part of the task of
> splitting one of his TODOs [2].
> 
> ---
> [1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

