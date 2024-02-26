Return-Path: <linux-kernel+bounces-80948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80954866E55
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1EC21C23C65
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819D846B91;
	Mon, 26 Feb 2024 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fivetechno.de header.i=@fivetechno.de header.b="JvuLnh4y"
Received: from wp725.webpack.hosteurope.de (wp725.webpack.hosteurope.de [80.237.130.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8392D5C5F2
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937229; cv=none; b=p3xgDirj2t6UUGTfPDgvMsJT2Cdtb4VRMYtRB8a+tNVtR2rkiUtPvpGrFdGhEqx3USHFbBUvRAmtmHwmW9d3Pmv8dMV8OOAO7RscJD1HGuy550PnBhhnuAwzqh6+L6Av9pdno+7vCT/WYffO41BEk0E8R0jhqWGBelSD6Yy2fqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937229; c=relaxed/simple;
	bh=kHanvvYcRx0MVPjLLF6An2HOqAFz7K2fbDWRfTHow6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AuNb/m801KWHMaIZKnE0M4EVIfRMZez0s5B1k9mefHlItd0v3pbEaXZrgAEza6KS+j6kG9PwAc+rsjFjQR5RvSzBMBSQW6tDpYsQyWbJodAhIgCLY2vQ4H9vEa1rA0bgqULqikCl/GAqNhKzHnLr0mqtci6kXHLnvRnn0SM6Wxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fivetechno.de; spf=pass smtp.mailfrom=fivetechno.de; dkim=pass (2048-bit key) header.d=fivetechno.de header.i=@fivetechno.de header.b=JvuLnh4y; arc=none smtp.client-ip=80.237.130.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fivetechno.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fivetechno.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fivetechno.de; s=he121032; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=KOYgHTclGDn2Bg+LUu3vk4T9YHqwzQOCJmLHdazZugY=; t=1708937227;
	x=1709369227; b=JvuLnh4y2VHIrsM/S9MTDt0Lt/3MzKsBslYfYZC6aQD1W7XOfok3D+rrBXuMT
	Lhok3LjOo2UlsWv2lgn1YqRyt8VoVd+z4xwKDgr0lETVmOVMQs80YmYxdAWsCxsp0a9d2FgUO7yPL
	lhFCi27r4VJxeCUm7r+Jzad0d4bmpZB6wgDeR/xGEDikxOwLK9JnOb1LNVg+1xeAX0M3HttTA/hkX
	2oTaXoo3N96oK7Ws/VacN1/wyjmeA7ROfpRu3pmIE/ZTUKvsxnzAnb3PME5vTAeFlEjFbrWL0DBSG
	BugM5OC9ClNm1C/8O61BszmolmghxsqcXxjL3sIoxrH1+XILQQ==;
Received: from p5098d998.dip0.t-ipconnect.de ([80.152.217.152] helo=hermes.fivetechno.de); authenticated
	by wp725.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1reW85-0004Go-Am; Mon, 26 Feb 2024 09:14:29 +0100
X-Virus-Scanned: by amavisd-new 2.12.1 using newest ClamAV at
	linuxbbg.five-lan.de
Received: from [192.168.178.100] (p508f320b.dip0.t-ipconnect.de [80.143.50.11])
	(authenticated bits=0)
	by hermes.fivetechno.de (8.15.2/8.15.2/SUSE Linux 0.8) with ESMTPSA id 41Q8ESZ6008535
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 26 Feb 2024 09:14:28 +0100
Message-ID: <23a1a9c6-ece4-4817-8e5c-6831d75eefd1@fivetechno.de>
Date: Mon, 26 Feb 2024 09:14:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] regulator: mp8859: Cleanups and enhancements
Content-Language: de-DE
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-kernel@vger.kernel.org
References: <20240225-regulator-mp8859-v1-0-68ee2c839ded@kernel.org>
From: Markus Reichl <m.reichl@fivetechno.de>
Autocrypt: addr=m.reichl@fivetechno.de; keydata=
 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
 ZnS2JHg/17+ErCtiUzuJ5EGMPA==
In-Reply-To: <20240225-regulator-mp8859-v1-0-68ee2c839ded@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1708937227;ad0ebb3b;
X-HE-SMSGID: 1reW85-0004Go-Am

Hi Mark,

Am 25.02.24 um 15:59 schrieb Mark Brown:
> I had cause to look at the MP8859 driver together with the datasheet and
> noticed a few small issues and missing features.  This series deals with
> many of these issues, the device also has support for interrupts which
> are not implemented here.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Mark Brown (8):
>       regulator: mp8859: Specify register accessibility and enable caching
>       regulator: mp8859: Validate and log device identifier information
>       regulator: mp8859: Support enable control
>       regulator: mp8859: Support mode operations
>       regulator: mp8859: Support active discharge control
>       regulator: mp8859: Support status and error readback
>       regulator: mp8859: Report slew rate
>       regulator: mp8859: Implement set_current_limit()
>
>  drivers/regulator/mp8859.c | 252 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 251 insertions(+), 1 deletion(-)
> ---
> base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
> change-id: 20240224-regulator-mp8859-eebd7c16c374
>
> Best regards,
Tested on rk3399-roc-pc.

Tested-by: Markus Reichl <m.reichl@fivetechno.de>

Gruß,
--
Markus Reichl


