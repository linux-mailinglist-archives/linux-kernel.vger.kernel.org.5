Return-Path: <linux-kernel+bounces-136965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B002689DA66
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6D828CF8F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D2E12F5AD;
	Tue,  9 Apr 2024 13:33:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7423412EBF7;
	Tue,  9 Apr 2024 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669594; cv=none; b=QC3Yr2v0hp85a0OOkvVDpsRcmtPWG0VZYrwK4exsxNespWyAGLXJfwIVpPjPQ4IGNoSNX8Oee39Oo/SQOHhfpTuvm3hWudceTVkfYc6zJXBxpJ962LCamvKF+n8jdqi9uEJSaj68Q0OAMv+rHd/MBF6sclIw5y+kcvTOUzDc5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669594; c=relaxed/simple;
	bh=dIMLKmF8QMvsWVI+FEoCYWgHq7jZ/1UVqaTJ39fpZHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A66wcOSPuDyW2jJRXGBY1Heq5YN/ziu94NYPCjOxOiOOlo9xtLf3Ple7M738uafkaM23Vh0WKIQ1CqM2wmVyorETmPPYzqXfMF8KeAeD7nZ0LaUYUBU428RCTT9GuBhYnElYcaBLlEPFSsquTJaQ6+lUv8DSrqGwmsBRdDRCQQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: DHXifDb1StaVzDuwMDjTAg==
X-CSE-MsgGUID: qT7JqERoS+CCJ8vil5uI4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25424037"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="25424037"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 06:33:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915399959"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="915399959"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 06:33:08 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1ruBaz-00000002od9-1FNV;
	Tue, 09 Apr 2024 16:33:05 +0300
Date: Tue, 9 Apr 2024 16:33:05 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	Jelle van der Waa <jelle@vdwaa.nl>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	linux-input@vger.kernel.org, ojeda@kernel.org,
	linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
	Gregor Riepl <onitake@gmail.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: In kernel virtual HID devices (was Future handling of complex
 RGB devices on Linux v3)
Message-ID: <ZhVDkf0P6vRLy-Ql@smile.fi.intel.com>
References: <e21a7d87-3059-4a51-af04-1062dac977d2@tuxedocomputers.com>
 <247b5dcd-fda8-45a7-9896-eabc46568281@tuxedocomputers.com>
 <ZdZ2kMASawJ9wdZj@duo.ucw.cz>
 <b6d79727-ae94-44b1-aa88-069416435c14@redhat.com>
 <a21f6c49-2c05-4496-965c-a7524ed38634@gmail.com>
 <825129ea-d389-4c6c-8a23-39f05572e4b4@redhat.com>
 <adbfdf6c-fb59-4fae-a472-17b04dd8a3f6@tuxedocomputers.com>
 <1fb08a74-62c7-4d0c-ba5d-648e23082dcb@tuxedocomputers.com>
 <aec1d22d-9e59-4dfc-b108-5ba339b0e76a@redhat.com>
 <CANiq72kPXsTjzptK7tSC=RygEpWHJHz1-QXuZv8qPHfGLyzrDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kPXsTjzptK7tSC=RygEpWHJHz1-QXuZv8qPHfGLyzrDw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 25, 2024 at 07:38:46PM +0100, Miguel Ojeda wrote:
> On Mon, Mar 25, 2024 at 3:25 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > +Cc: Bentiss, Jiri
> 
> Cc'ing Andy and Geert as well who recently became the
> maintainers/reviewers of auxdisplay, in case they are interested in
> these threads (one of the initial solutions discussed in a past thread
> a while ago was to extend auxdisplay).

Without diving into this, just sharing my view on auxdisplay subsystem:
I consider it _mostly_ (like lim->100% mathematically speaking) as for
7-segment and alike displays, not any comples RGB or so devices. If
those devices are capable of representing characters/digits in similar
way, we may export linedisp library for them to utilise.

-- 
With Best Regards,
Andy Shevchenko



