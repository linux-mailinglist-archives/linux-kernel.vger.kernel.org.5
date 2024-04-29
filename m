Return-Path: <linux-kernel+bounces-161899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA818B52F6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94F01F2132B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6721756A;
	Mon, 29 Apr 2024 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDVGr6Xc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDFDEAE5;
	Mon, 29 Apr 2024 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378728; cv=none; b=tINW8JNysuOlMYywjvcgnI3XdrAc9h1jK4gi+K0yEfvM1HB46+WAXFNnWJp22q9kYl3dOP9R/s1K4K+86zMdjs0h5vhMuYT16DRrjA43Igmj/TBcQ0m8g0SXOjFFsXNJkqTx+7SvDvODGKtMBtDDZn7ltP0NBCetUR76W2BUkCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378728; c=relaxed/simple;
	bh=apDk5Y09trU/q/jiwMgmxsgRcvjx2BN29f0YaHToZuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJYJJ1PBUeurBcfis5jQX2k6GJctvnWXMZSazCeoukALDWjbymXV7LSMifZRLQtNgXgcqMgOiMjxdrvq/ODOT6/aYnPJ51kVXkprNGXGZYkgobYAvwdSKHiKLU+HUBsYVH5jP+uYaxLv0kv/GHR6c/9XdWcCWY4AEpeD0SZ6FXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDVGr6Xc; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714378727; x=1745914727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=apDk5Y09trU/q/jiwMgmxsgRcvjx2BN29f0YaHToZuw=;
  b=SDVGr6XcrM9A4TMhXDLR7TnbYQuH7BjEGgxK5xwS9N4vOf7CTzYYLv9W
   wTi/ayvqNGioKHcjSzJ4jcASC1QtwoKsXFu8BFCo9iyyNRzXs7TJOl+xs
   omTxL6OWq9EkXheOseQ35rG+f3MYTg+Hjqp7RpgLi8DN7jOAerkksMbjS
   tgu1ZUCIy3l3MQZ5jlst8iYLSp/AM8RD+TYrjLPtFfpcW+3oeqRGRkMvP
   AFDhMH7v7kn/BL48iFsP86huXk87/ghcYbFK96/LRp1wjgMgHoxRk2Yo3
   Lq4FLxJVuMSLPzB3dAIRvT5wZif+PAWh/YJizomReFS/Rp6FYntDpS27L
   w==;
X-CSE-ConnectionGUID: ior1JyNcRCyQZJOmtO0wFA==
X-CSE-MsgGUID: Awv5NrgyRTCWolhJQBiRIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="27547161"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="27547161"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 01:18:45 -0700
X-CSE-ConnectionGUID: 6f9FY82wR5W2Zz22mQvmBg==
X-CSE-MsgGUID: CGxf2a0zREebCyBJI1E7HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="30510286"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa005.fm.intel.com with SMTP; 29 Apr 2024 01:18:42 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 29 Apr 2024 11:18:40 +0300
Date: Mon, 29 Apr 2024 11:18:40 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org, hdegoede@redhat.com,
	badhri@google.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: enforce ready state when queueing
 alt mode vdm
Message-ID: <Zi9X4DH+zNAd/mrw@kuha.fi.intel.com>
References: <20240423202356.3372314-2-rdbabiera@google.com>
 <ZionHYcUvvc865z4@kuha.fi.intel.com>
 <CALzBnUHL4kWTQEncWfzNyze25_Ss_Pf8pyR2FOauyoLwNRrrMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzBnUHL4kWTQEncWfzNyze25_Ss_Pf8pyR2FOauyoLwNRrrMA@mail.gmail.com>

On Thu, Apr 25, 2024 at 10:37:21AM -0700, RD Babiera wrote:
> On Thu, Apr 25, 2024 at 2:49 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> > I'm probable missing something, but wouldn't it be safer to check
> > port->state after grabbing the lock?
> 
> I could have been more explicit in describing the deadlock, my bad.
> But there are two
> threads here:
> 
> Thread A starts in the TCPM. It is the port state machine that
> transitions to DR_SWAP
> and holds port->lock. When it unregisters DisplayPort Alt Mode, it goes into the
> DP Alt Mode driver and hangs until any DP Alt Mode work is finished.
> 
> Thread B starts in the DP Alt Mode driver. It attempts to call tcpm_enter_mode
> and the call to mutex_lock in tcpm_queue_vdm_unlock hangs because Thread A
> holds the lock. Thread A will never drop the lock because it waits for Thread B
> to finish.
> 
> So, the check is done before grabbing the lock because the thread needs to avoid
> grabbing the lock in the first place. If port->state changes between
> queueing and
> sending the message, the VDM state machine will drop the message anyways
> because port->state isn't in the ready state as well.

Okay, thanks for the explanation.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

-- 
heikki

