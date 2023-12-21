Return-Path: <linux-kernel+bounces-9150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DE081C19F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02D39B24E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DC278E9D;
	Thu, 21 Dec 2023 23:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="GVv+oPsR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5B57608D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1703200132; bh=YJPwFFu7kv9a7ZX/yOSk5YbQRwVbRvOaOJ5O6QREgno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVv+oPsRj/tthwaDm+sMDGKT1AglV5OjKJUsIwYVltOoF1CCJTpiar1egDurPAkkZ
	 Ql0G5Ac7KOQn7mecyIcGVcGaWXml9YwxUdKiZNUFmqqEUZyDT14lW3MSF56La6AW/c
	 iyI1BN59pzvj2zQgRAm23vKmovlRFXQ0TTU53zRU=
Date: Fri, 22 Dec 2023 00:08:51 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] pvpanic: Don't use "proxy" headers
Message-ID: <f3e4f74b-c532-48f6-990f-232208268c04@t-8ch.de>
References: <20231221144447.2762077-1-andriy.shevchenko@linux.intel.com>
 <c37fecee-f5b2-497f-a48d-2a2faf6697d9@t-8ch.de>
 <ZYSD3C6fKvWUulXC@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZYSD3C6fKvWUulXC@smile.fi.intel.com>

On 2023-12-21 20:28:44+0200, Andy Shevchenko wrote:
> On Thu, Dec 21, 2023 at 06:48:49PM +0100, Thomas Weißschuh  wrote:
> > Dec 21, 2023 15:44:55 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> > 
> > > Update header inclusions to follow IWYU (Include What You Use)
> > > principle.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> Thank you!
> 
> > Note:
> > This also drops the unused include of the UAPI header
> > which could be mentioned in the changelog.
> 
> Isn't it implied?

It's not covered by the subject. The message itself is fine.
But it's only a tiny nitpick anyways.

