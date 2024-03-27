Return-Path: <linux-kernel+bounces-120184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C14B88D3E5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6A81C24746
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3171D558;
	Wed, 27 Mar 2024 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ibmSNmFg"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931BE18C36;
	Wed, 27 Mar 2024 01:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711504171; cv=none; b=fIVoQYS2hJE6nS3aTyhC5KnTw4Mo875qfvm0TUcIgq1DHcdZtmEhYB+VZpxUdafoQLktJ9g1P81WoJYMjLEyzSpkpOb9WrjFQmateKK2ftzW8yI7dcyMUUybZR2ZS5utUJAcq8fCN+nqyvOdHlCIoJeCd4RVttCtI1X2OODms8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711504171; c=relaxed/simple;
	bh=Knk/S3SoxY++zeN/rrHN9d4zhOSUSYp+BbabZ+JnQ0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ya0RmR472r0oYcU+RfGTy94r2fSwEUUswHuOJSbMJmZuKS1Ba3naikioqoUUw05KHQuRI/ZULbo5s4ejifV1sM3s9bL1Pns4CnzmrCefZMq+6Kk2Bcs9FQcxKuf1+QfLszyalnCuUYdgKms1oceeY67feAijSByYSqIcxA7MAug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ibmSNmFg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 462472084326; Tue, 26 Mar 2024 18:49:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 462472084326
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711504170;
	bh=bRFCliWNZCRPL+EB2cMQ7KcOwPKGiK2WP1VO8l41jVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ibmSNmFgLdX/VxY4mW0dO2sAZE8K/T2sSeXBU+Hmm4oXTwLdEOU151AE8WovKXSrn
	 izHWfr294UMNyC5K5pzG7D4kNW1S/Byd6mf8xtiSR/P/skQyR2DzP1Yaqmw4WjFoa5
	 06SavVxwChkMUwVmw+iZr09dkqzOv9RbGBWB974M=
Date: Tue, 26 Mar 2024 18:49:30 -0700
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 6.1 000/444] 6.1.83-rc2 review
Message-ID: <20240327014930.GB7502@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240325115939.1766258-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325115939.1766258-1-sashal@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Mar 25, 2024 at 07:59:39AM -0400, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.1.83 release.
> There are 444 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:59:37 AM UTC 2024.
> Anything received after that time might be too late.
> 
No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you. :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

