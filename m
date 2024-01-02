Return-Path: <linux-kernel+bounces-14185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 236A98218E0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3AD01F2213D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757F7D534;
	Tue,  2 Jan 2024 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/1cHtG5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB95D515
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704187591; x=1735723591;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pv0siwkhM5WJdMGPEhHf+oy6L8ddnKkuRveKNn3okG4=;
  b=I/1cHtG5mW6yhu+7g9371ys+GFQ3s1U23DrQfjnNCWFjDuRfnQltkaQ0
   eQLMLwRjQqjAUPTt/qNANo4IwQCr8VJBgP5oiij9xACPJ+X7hWvTCa+8q
   eZKI8hucDtb83B5rUVbKxKFN75BgONUq4FR4fMSCbG0g5K+Yp0v1YRqd6
   tgWSis8lHDKDH7XQ386YGzilzORTlM6NSgjjPoMoYYUDN0XpHwaUvPsBq
   s+pMqOlU+tsyRjAPy/jstnqK+Vp2YfsYeRny1ETKiC9eFlepAzuVhPAOi
   ql3zADHfq3VqbJo1wVR3/zzf5G+noTELk8hjxCGLuY+TOIvDQRwTkEg0z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="376351536"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="376351536"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 01:26:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="1026727348"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="1026727348"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 01:26:28 -0800
Date: Tue, 2 Jan 2024 11:26:18 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Marc MERLIN <marc@merlins.org>
cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
    Rander Wang <rander.wang@intel.com>, 
    Bard Liao <yung-chuan.liao@linux.intel.com>, alsa-devel@alsa-project.org, 
    linux-kernel@vger.kernel.org
Subject: Re: sof-audio-pci-intel-tgl/soundwire 6.6.8 kernel outputs no sound
 on speakers but works on headphones
In-Reply-To: <20231223234430.GA11359@merlins.org>
Message-ID: <alpine.DEB.2.22.394.2401021117370.14041@eliteleevi.tm.intel.com>
References: <20231223234430.GA11359@merlins.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

On Sat, 23 Dec 2023, Marc MERLIN wrote:

> Howdy,
> 
> First, apologies if I'm not sending this to the right place, I could not
> find an approrpriate soundwire/sof mailing list, please redirect me as
> needed (I had to find an old soundwire message for reference)
> 
> laptop; Dell XPS 17 9730
> 
> merlin:~# lspci | grep -i audio
> 0000:00:1f.3 Multimedia audio controller: Intel Corporation Device 51ca (rev 01)
> 
> stock mainline 6.6.8 shows the device, but no sound comes out, as if it
> were muted, but I do not see anyting muted in alsamixer. If I plug in

we'd need a bit more info, especially alsa-info output, to figure out 
whether this is an issue with the mixer settings and/or the drivers. 
Instructions how to get alsa-info output availbale at 
https://thesofproject.github.io/latest/getting_started/intel_debug/suggestions.html

Please file a bug at 
https://github.com/thesofproject/linux/issues

There was one bug affecting 9730 variants, but I don't think your case
is the the same:
https://github.com/thesofproject/linux/issues/4380

Br, Kai

