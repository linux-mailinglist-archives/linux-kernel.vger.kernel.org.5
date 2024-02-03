Return-Path: <linux-kernel+bounces-51028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 840CD848531
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 11:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B784F1C21B59
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3295D8F3;
	Sat,  3 Feb 2024 10:36:34 +0000 (UTC)
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC3C48CC7;
	Sat,  3 Feb 2024 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706956593; cv=none; b=oFBRWhFetyj1SQ6A/uppu5cAxCi/2F8Sdfj9va/wS308Xf4FbsrCUEb+jAmMslV/sz63SnuO5kjB1YI5ZbjSuxW2Gw1+uGJOagnzolwzvIF+l0yewZm2xRQiiwc+G1k6LNeNSRYjfuPfnZ1nLELNb+D3uaXcFd8czg1xfZ2y0pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706956593; c=relaxed/simple;
	bh=//6EOTglFqOTTA2dxf/fckQDdFeuxwvhrqyoedDTnzc=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fezBwyFCLeqHLvwmaB+rDOz1AqsL9YI/1lPUiYs7zENKgl+4ZO2XJTfUVeuKLr81+xhuenQO1irBRuj4RBcQxMtHnEhdg5rx2+qOSjMM0dS8TMAnvgtOKoH2viEEJRzYkKijx0VIX84g8PZAdnLnKGuMMLk7UHfGPaEZtcyEmK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b2e8fde.dip0.t-ipconnect.de [91.46.143.222])
	by mail.itouring.de (Postfix) with ESMTPSA id 1A56CD015AA;
	Sat,  3 Feb 2024 11:36:29 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id E04EEF01604;
	Sat,  3 Feb 2024 11:36:28 +0100 (CET)
Subject: Re: [PATCH 6.7 000/353] 6.7.4-rc1 review
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240203035403.657508530@linuxfoundation.org>
 <9fa210ec-1086-615e-b972-f28a74df7b49@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <e07488c7-8375-5d03-d2b6-eba2a9769684@applied-asynchrony.com>
Date: Sat, 3 Feb 2024 11:36:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9fa210ec-1086-615e-b972-f28a74df7b49@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2024-02-03 11:18, Holger Hoffstätte wrote:
> On 2024-02-03 05:01, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 6.7.4 release.
>> There are 353 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
> 
> On my Zen2-based Thinkpad I now get the trace below on boot; this never
> happened before. The boot continues and the system seems usable.

.except for the part where reboot hangs, but whatever.
In any case reverting the patch makes the trace disappear.

-h

