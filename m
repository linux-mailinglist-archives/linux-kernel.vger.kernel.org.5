Return-Path: <linux-kernel+bounces-158618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A7A8B230A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1842285361
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791CB149DF2;
	Thu, 25 Apr 2024 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hW2IKNrm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2CC149DE9;
	Thu, 25 Apr 2024 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714052655; cv=none; b=FKuO+b5T0ikJhYyS0p3SoC6LGOIpH91mIYVTlxbgYkZnseypCG77XmgisEn3oyinuKNj9BtZyDAOpAgUrADh6XqDpWgG6sTY3mFwN9KKOCKThpwc9f0tzrVJvyH10UkvYDLnIlw7KE94N5ZLWxQym9WyY0ZjJbXywNphTeTmaqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714052655; c=relaxed/simple;
	bh=sevXQPHqwt+0Ww7Ab9Mk8uFLSxt6KOf9Ig3smUYioLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YINRKJnckh3veK/aW7alfPojaW50ieI0N0Z4T4I/xaxP/UzlUK9bHNpohnUhB41hHn/3GbNcugEOlUEs9uprc0hNVezCLYlWI44Y3RL6dk8NGDsRkCf6LBX3LZfzYYk9kNKEKtH+KGo8g9cfmMUnkPCkLTgGWT8solKMOjVi2jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hW2IKNrm; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714052654; x=1745588654;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sevXQPHqwt+0Ww7Ab9Mk8uFLSxt6KOf9Ig3smUYioLc=;
  b=hW2IKNrmAL43jO5tc892Tml9io+6se4xF3gpOR50e3k3wGUukp1CSCJG
   CcJTK3PtHeKR9PCxqYlp+Pr3WPZSjd7P8tIUx7aR9x9y+5S+GxJ612oee
   NWnnvVYZwynouoEM0B1PpDNXoM8YvVNLL4PqU0o4lvGoZrNHtOcSGvL2x
   ePQZITJT/bOcU1IDl6Otnnj4Ygw478fauIb7/sNWV+5sS6NS1NrILSlOI
   dQK4GtToslDuFczXxjp6hpn57L47EXDINybb5Wo8UNisu3JDo0s55Ja+A
   wNh1FpBcaPgQPXecxF1ntsoCRjiEeA8kAtqWlatDw0VMITSmDOFsGvxmb
   Q==;
X-CSE-ConnectionGUID: M7HVa8i8QQ6IIdJWx2Asgg==
X-CSE-MsgGUID: +LlEjvW1QHS1GFfI7TAIiw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9587385"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="9587385"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 06:44:13 -0700
X-CSE-ConnectionGUID: 7OVoDDweRre70A69GO9ozQ==
X-CSE-MsgGUID: mlJfMqBPSgudVBltKqVGDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="25564915"
Received: from shivapri-mobl.amr.corp.intel.com (HELO [10.209.176.73]) ([10.209.176.73])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 06:44:12 -0700
Message-ID: <59f78ca7-ea09-41d7-9e6e-b0ce1af484e4@linux.intel.com>
Date: Thu, 25 Apr 2024 08:43:20 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] ASoC: codecs: wcd937x: add wcd937x codec driver
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
 quic_pkumpatl@quicinc.com
References: <20240425091857.2161088-1-quic_mohs@quicinc.com>
 <20240425091857.2161088-3-quic_mohs@quicinc.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240425091857.2161088-3-quic_mohs@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


> +struct wcd937x_priv {
> +	struct sdw_slave *tx_sdw_dev;
> +	struct sdw_slave *rx_sdw_dev;

Does this mean that the codec has 2 SoundWire interfaces?

If yes, aren't there merits in splitting the implementation in two
separate drivers, one for each interface and probing on the relevant partID?

This is how the RT713 was handled. The mic function was exposed as the
RT1713.

By representing the device as a single entity, things could be fun
because the two interfaces are really independent. things like clock
stop are handled at the interface level.

The code in this driver is difficult to review, for example in the probe
you wait for the TX part to complete the enumeration/initialization, but
there's nothing mentioned or stated on the RX part, and there's really
nothing related to the detection of this device. I don't actually see a
sdw_driver at all, it's a platform driver.

Would you mind adding a paragraph on how the SoundWire interfaces are
handled and how the SoundWire bus is involved if there's no sdw_driver?

Thanks!

