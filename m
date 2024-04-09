Return-Path: <linux-kernel+bounces-136690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5261789D725
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0922D1F23B7D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E382083A08;
	Tue,  9 Apr 2024 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FO6xihnl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7F37F47E;
	Tue,  9 Apr 2024 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712659195; cv=none; b=cCD9557oRQS48QbLjnS9JVUhFalf5cx1TwDgXglzLU1nPYEYVDh8Ir+0rJTdz5v/ghhjlL6wDPVAIzYX3n5OA0fAuzHFCPXa+fwoTpdar88ZHmn+mLHb3o1Z1p+wXlo82uL5s0DgexAc7u1Jdqe+A1XKTfhu1LjsyDfMCrdcpUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712659195; c=relaxed/simple;
	bh=yOkT4eYUGOe395yXz4fVpwh16R12BAAxxOJJcmpDYRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3Ail7WJ25e0CBevW4sXhPSZ8Mfsc4h85VlcP0b1LlRw83tYqToI5xoP8RxHyW0bD9kVIDgu11AqKO6LlbHuIN/Ji9/H9y8ms2wDiEvwiTIKbFiwCE51Xtx6NFcQT04co9urQ6xI2YIiKLbLjjdURRjHdDpJzJURaznbFeF+f70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FO6xihnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E62BC433C7;
	Tue,  9 Apr 2024 10:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712659195;
	bh=yOkT4eYUGOe395yXz4fVpwh16R12BAAxxOJJcmpDYRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FO6xihnlR5ZmS8bUJLGCGBcZc+pXYQUAAYLJUvCY/7ol0UMDJfXECyKmQfNAKbIN0
	 bZBdjPiDNl1snVxE2FY01EW53ZQX30ucngsd+Dy3DJ9VrYANRnQUFYL38t0hnZhDLD
	 KMCHDbS4dVhWRUs64zUI5QfhQaRJRWDeTS8m+ovZdoCEUFitORU+XScLi526kntptI
	 e7s/5+qys2b2lXADKMOU3v9+IRB0WRFXzSgRjvsUfZgQQNKrMDdKkLAMyVq9W/z+KN
	 2FsPhihvHYIBbdwSIpjD5Z/4FYHjQq/BihQSVYaSzf3fEov3oal0k/eng/Ad/Eee8k
	 ThRe2KM9ZaoKA==
Date: Tue, 9 Apr 2024 18:39:51 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Pavan Holla <pholla@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v3 2/2] usb: typec: ucsi: Implement ChromeOS UCSI driver
Message-ID: <ZhUa91g0B9-oj0po@google.com>
References: <20240403-public-ucsi-h-v3-0-f848e18c8ed2@chromium.org>
 <20240403-public-ucsi-h-v3-2-f848e18c8ed2@chromium.org>
 <ZhOnKWcNllls6gdA@google.com>
 <CAB2FV=4_TYP=uBHjJLDwKOdnyfdurX5k5LqqtOPpX4er1fKiZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB2FV=4_TYP=uBHjJLDwKOdnyfdurX5k5LqqtOPpX4er1fKiZg@mail.gmail.com>

On Mon, Apr 08, 2024 at 07:47:35PM -0700, Pavan Holla wrote:
> On Mon, Apr 8, 2024 at 1:13 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > How this driver get probed?  From drivers/mfd/cros_ec_dev.c?  If so, there is
> > no "cros-ec-ucsi" in the MFD driver yet.
> 
> Yes, this should get probed from drivers/mfd/cros_ec_dev.c. However, the
> corresponding change in the EC is still under review. I was planning to send
> it out once the EC change lands. Please let me know if you think that this
> review should wait until then.

I see.  The mfd patch is independent and can be sent later.

I was asking because the patch (and the series) don't reflect the message:
"This driver will be loaded if the ChromeOS EC implements a PPM."

However, include/linux/platform_data/cros_ec_commands.h (the previous patch in
the series) usually follows include/ec_commands.h[1].  We should wait until
the corresponding EC patches land.

[1]: https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/include/ec_commands.h

