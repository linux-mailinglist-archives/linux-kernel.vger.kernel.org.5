Return-Path: <linux-kernel+bounces-79310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BC58620A1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9CF1C2251D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F5C14DFC6;
	Fri, 23 Feb 2024 23:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="Cshe3ZZA"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D963814D432;
	Fri, 23 Feb 2024 23:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708730811; cv=none; b=Brd/weRyrSfubVyqDa/PrBXzemJUT1m2ZUQQ4oIUs3LFveoW8aBqiqd7oxcz6xFQIKgtGZngTKMT7Sl+K8ew0ZwYwbY6MbnWJ/xmnZm+mqQfgY5IYaFTFf0+1+Xo9uO9ImbJtnCI/lpMjO/TcLvBONs2OzX4/wTa23JSivbw+r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708730811; c=relaxed/simple;
	bh=4zYtnwamesCmZ23tK3MomVr0LVGplK4mXXqNXQBE1mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fglD/UMzOIcMUtmPsrlIL4oz47ws9wHJZh/sfBmpBQTMyXc1d8WbVbO1taQjemjBHYNI0PA4S2RXyiNYtQF3jTc12Vf05pIs9zurKsNy/0+vW9vOWgRDlvLUyaZWZiL2K0o3nSgy7pzA2ABWaO9EFBSctxENsEhRF9bWCoZUB1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=Cshe3ZZA; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id BEDDC432C;
	Fri, 23 Feb 2024 15:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1708730809;
	bh=F4lJYG4kSAB2qe69Q4ayANoz62/3Dr0HII+1obeivrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cshe3ZZAEwvk/gnlT5/fOGTtbjtKYmxX47GEVe31kvEaHWjqpmauiCXLg0e9GHK6a
	 jG2M+YBzL/omtWQR2S3G3FBy68HiLrIjtHqr+Vk3/kigedkvzS+ZHMbuhdha+sEBGl
	 bXKEOZvAclzp9xbbAkI7YtL6w29iK7oH/yIgctY8=
Date: Fri, 23 Feb 2024 15:26:47 -0800
From: Zev Weiss <zev@bewilderbeest.net>
To: Conor Dooley <conor@kernel.org>
Cc: linux@roeck-us.net, Conor Dooley <conor.dooley@microchip.com>,
	Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Naresh Solanki <naresh.solanki@9elements.com>
Subject: Re: [PATCH v2 4/5] hwmon: (pmbus/lm25066) Use PMBUS_REGULATOR_ONE to
 declare regulator
Message-ID: <2a06f633-9dd2-4ef0-8cb8-901348ef404a@hatter.bewilderbeest.net>
References: <20240223-moonrise-feminist-de59b9e1b3ba@spud>
 <20240223-player-buckskin-01405c5889c4@spud>
 <684ee927-2287-420b-aee5-f323e05ada47@hatter.bewilderbeest.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <684ee927-2287-420b-aee5-f323e05ada47@hatter.bewilderbeest.net>

On Fri, Feb 23, 2024 at 03:16:28PM PST, Zev Weiss wrote:
>On Fri, Feb 23, 2024 at 08:21:08AM PST, Conor Dooley wrote:
>>From: Guenter Roeck <linux@roeck-us.net>
>>
>>If a chip only provides a single regulator, it should be named 'vout'
>>and not 'vout0'. Declare regulator using PMBUS_REGULATOR_ONE() to make
>>that happen.
>>


>
>Given (AFAICT) the >lack of any combined dts & driver patches anywhere 
>in the kernel git history I guess maybe doing both atomically in a 
>single commit might not be considered kosher, but could it at least be 
>included in the same patch series?
>

Ah, except I realize now I neglected to pass '--full-diff' to 'git log' 
when checking that, and after fixing that I see there is in fact some 
precedent for commits changing device-trees and driver code together, so 
ideally that would be my preference here too.


Thanks,
Zev


