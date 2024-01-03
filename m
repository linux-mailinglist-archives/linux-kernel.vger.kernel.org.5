Return-Path: <linux-kernel+bounces-15741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87388823131
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B900B2193A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC751BDCF;
	Wed,  3 Jan 2024 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrn5Qwct"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5AC1BDC4;
	Wed,  3 Jan 2024 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704299046; x=1735835046;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e7A5dG1jEF9eZADbVxTs8U3CR1jOZzXgY4h4AvHFeh0=;
  b=jrn5Qwct0EOdbGy5frkYpYLklkqEGNT6xuBnbq6GW56F+Iu3ss/7mCEa
   rGFgHpEfgJ80N0qWAVSWHBSQHuJuNc5b8gPS7SRSlC9McmyxOQdglJ9qR
   0VsnT05SUEUlowqg7UOoQGlgu278o97fBUR50QPyESa9qrDUy5E3LVkRl
   ZGdGp5dFMj5B26upQX9nfVEKlBsMRaeyC/ixBdUVhuLHdRdzLquCuaiGb
   ho84Ul67iwYVmhsfdIv5DcveHFiH/p/vQ+rWbp9tTkf+/EVfCtcgNsxg2
   NPedJ2Rd0tL5dqZ07ZFXzKH7RL9hRDQk/M8LsZa3GZ+UMzr6RJ9w5mrVL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="18553021"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="18553021"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 08:24:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="780026987"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="780026987"
Received: from homichel-mobl2.amr.corp.intel.com (HELO [10.252.51.214]) ([10.252.51.214])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 08:24:01 -0800
Message-ID: <d61245f1-cd4a-4369-9d32-087b892cf4fa@linux.intel.com>
Date: Wed, 3 Jan 2024 18:24:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Oops in hdac_hda_dev_probe (6.7-rc7)
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
 Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <ZYvUIxtrqBQZbNlC@shine.dominikbrodowski.net>
 <87sf3lxiet.wl-tiwai@suse.de> <ZY7kosArPqhlCfOA@shine.dominikbrodowski.net>
 <874jg1x7ao.wl-tiwai@suse.de> <ZY_Gb8-rncuOjRq-@shine.dominikbrodowski.net>
 <87plyovwg7.wl-tiwai@suse.de>
 <3260e806-a708-4462-9d4e-346e54143a65@linux.intel.com>
 <87y1d8ulxv.wl-tiwai@suse.de> <87o7e2a3hr.wl-tiwai@suse.de>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <87o7e2a3hr.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 03/01/2024 16:36, Takashi Iwai wrote:
>>> Mark, Takashi, can you pick the fix for 6.7 (it is in -next)? I think we
>>> might have time for it to land?
>>
>> Oh that landed to Mark's for-next branch, i.e. only for 6.8.
>> Mark, please cherry-pick and send a PR before 6.7 final.
> 
> I ended up with cherry-picking by myself now.
> 
> I'm going to send a PR to Linus for 6.7 final in tomorrow.

Thank you, I really appreciate it!

-- 
Péter

