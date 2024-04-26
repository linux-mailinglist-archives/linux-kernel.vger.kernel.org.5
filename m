Return-Path: <linux-kernel+bounces-160048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6EC8B384D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC721C22506
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20159147C89;
	Fri, 26 Apr 2024 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6+UbjRT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93DF147C68;
	Fri, 26 Apr 2024 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137883; cv=none; b=F1IX81PQkOhfapm5eKQ1yB5FVZ5IS04yI2Pkt+fQJJNZVBZqyEoVV3V1iuQiNIPDFBGirJEkB+/cQsChrja+o+KWwnZF+DlvGXEihdsJM2KVxYbBMhcsth80lrovZWHBvcNZLZQHG+KZEx55Qr/JapDeFYEBNqkSY6hkRhCtTDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137883; c=relaxed/simple;
	bh=nkZWIXOQ8v3lhU9lnkLEQcsTys4fWZBE6NJ+JN8gKlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dw1Q9jyp+IkOz1NWPJBqMWFY7d49JMzqA396IJa+EIOyptYwSTAw4A37CeclZzHunLqJsap8Fo6/Gp3R0reVCemKplonEPhpAiUyFPfucJT4bfPsXefOniO6ZHE3nrwWJdFcdDqBEJKjp3TNZezYAKLQR3gia+3X4xURKdXKb3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6+UbjRT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714137882; x=1745673882;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nkZWIXOQ8v3lhU9lnkLEQcsTys4fWZBE6NJ+JN8gKlM=;
  b=Y6+UbjRT82yx7CVepdQ9WKjjJcnbAAqyiezU592j/XolaV8Hqmrcix/A
   +ae6/s7j59t5Fuuv8Mw5z/taa01U91eAPWBUVISpC1iIkpZ0J34WFj9FK
   e+RRuMKaybvXq2lTWrX1YccSvbGb/0CFsMAboGwCjY2wdFhAvedoAvJWW
   3Ic5wV1ruzWoQi1jMoqEZGatWYzK2/XHHQHGxyvvKOKYd7BMGQ1aUxkXv
   rGeDTldxkdHKB5jPtAhapcH9FRNFnMgNYqmaMwH3d91HgSAiE/RNr16fp
   2LQ4eqarfQIR/Wzk3eVNwD1kIX56/U7lF4NAO8pd7ibb+je03kuNyjn9z
   A==;
X-CSE-ConnectionGUID: WQDXmgQNQpaEtVFXsKM5fw==
X-CSE-MsgGUID: QhLjBRkYR5WVZCcJvFeJSw==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="27388380"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="27388380"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 06:24:41 -0700
X-CSE-ConnectionGUID: eFqTHEu4QYeZ6m+9HZqfjw==
X-CSE-MsgGUID: eAgXp2jQTXC9NQtWCSau/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="25302141"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53]) ([10.94.0.53])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 06:24:35 -0700
Message-ID: <60c17b0c-8069-4019-b062-3b3cb892297b@linux.intel.com>
Date: Fri, 26 Apr 2024 15:24:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 08/41] usb: host: xhci-mem: Allow for interrupter
 clients to choose specific index
Content-Language: en-US
To: Wesley Cheng <quic_wcheng@quicinc.com>, srinivas.kandagatla@linaro.org,
 mathias.nyman@intel.com, perex@perex.cz, conor+dt@kernel.org,
 corbet@lwn.net, lgirdwood@gmail.com, andersson@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
 Thinh.Nguyen@synopsys.com, broonie@kernel.org, bgoswami@quicinc.com,
 tiwai@suse.com, robh@kernel.org, konrad.dybcio@linaro.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20240425215125.29761-1-quic_wcheng@quicinc.com>
 <20240425215125.29761-9-quic_wcheng@quicinc.com>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240425215125.29761-9-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/2024 11:50 PM, Wesley Cheng wrote:
> Some clients may operate only on a specific XHCI interrupter instance.
> Allow for the associated class driver to request for the interrupter that
> it requires.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---

(...)

> -
> -	/* Find available secondary interrupter, interrupter 0 is reserved for primary */
> +	/* Find available secondary interrupter, interrupter 0 is reserverd for primary */

You introduce a typo in here.

