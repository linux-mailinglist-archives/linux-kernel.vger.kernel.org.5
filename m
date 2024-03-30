Return-Path: <linux-kernel+bounces-125606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B143E89298D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 07:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DF65B21D1A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 06:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4529D4430;
	Sat, 30 Mar 2024 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="EPFeAfPy"
Received: from mail-108-mta101.mxroute.com (mail-108-mta101.mxroute.com [136.175.108.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA95237B
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 06:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711780662; cv=none; b=VpnQ8FJ9uixjWp6u6/0sxTaGHCnIA/JLdmXYc/r0vNMrD+2yGOqdaB3WPm+5dEUq3j5dHCVa9dlGWoPSe8CcKPBO3zKKgTd0L6Tbo5yypohKwreOTO6lO43Yi1QQwFyEs4AiKrelKlC6DBW0Qpl/9tJ+J/5PrItU94iP/StyR00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711780662; c=relaxed/simple;
	bh=7xQ2ivu2mBMwc/QcrA9WEVxtlT624ZOcdgV5t+SROSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSnW93LWnKgx4AQuO1p6jrCL0EVUM3YINx2gmrOceCnepYwivwOmZzQODOFwcoqGo86/Lzq/3uvlohmWO4LGh1qqkodgVv1IOjGBCY92gvaM40b4dNH+/qP/KCjlYGcagtKWpKKy++6f59+j+Y4/6yftRLfzj8b58OcHgV862vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=EPFeAfPy; arc=none smtp.client-ip=136.175.108.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta101.mxroute.com (ZoneMTA) with ESMTPSA id 18e8e13daea0003bea.010
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 30 Mar 2024 06:37:29 +0000
X-Zone-Loop: 05b905db50100c034d950ee5a5f60de64cd09bb82f92
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c9wu6uz4/TTP9Z+1HqEXwIpJ2llylWk7CQEZxnmbusM=; b=EPFeAfPycmHXeSVlr523htye6T
	Vx4kZ+cOB9WGn55EZoSuasplHVbboila5B5NZXOKxR2ccL9VYQDMYhYAX9La8vcoblZqzfr+3/cr3
	DV3rKeYUY1yGH7gOUODXE3TlQnN1Q3zIlgUB+0SygJU/E1C5qiS2RmLAYXPH6ctjeH8vVqe6kJsK8
	asr3L1cG0Ba1WJgmztOC+95wTgvuHIVRNdBdGH68TIa8cFGr9AEucjFbUiEeJFs3b7rIGihf0O33Z
	EdjShJNMZigpD8dlP/SY1mJitBc7PPskavs+ptZPIMMxvD62/IY+0wkrWv9FDAcXE21P01qfjvB5g
	HD1+X3VQ==;
Message-ID: <91e71e28-5149-4041-a928-064448df93ab@luigi311.com>
Date: Sat, 30 Mar 2024 00:37:24 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/23] v2: imx258 improvement series
Content-Language: en-US
To: Dang Huynh <danct12@riseup.net>, linux-media@vger.kernel.org
Cc: dave.stevenson@raspberrypi.com, jacopo.mondi@ideasonboard.com,
 mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, sakari.ailus@linux.intel.com,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240327231710.53188-1-git@luigi311.com>
 <4599295.LvFx2qVVIh@melttower>
From: Luigi311 <git@luigi311.com>
In-Reply-To: <4599295.LvFx2qVVIh@melttower>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: git@luigi311.com

On 3/29/24 21:51, Dang Huynh wrote:
> On Wednesday, March 27, 2024 11:16:46 PM UTC git@luigi311.com wrote:
>> From: Luigi311 <git@luigi311.com>
> 
> The Linux kernel does not allow anonymous (or pseudonymous) contributions. You 
> should use your real first and last name.
> 
> See section 1.5 in "A guide to the Kernel Development Process":
> https://www.kernel.org/doc/html/v6.8/process/1.Intro.html#licensing
> 
> 

Ok I've changed my sign off to my real first and last name for the
next revision

