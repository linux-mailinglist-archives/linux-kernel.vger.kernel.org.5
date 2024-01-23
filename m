Return-Path: <linux-kernel+bounces-34880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC958388B4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9FF1F22FA6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB49A5674D;
	Tue, 23 Jan 2024 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pai4CYDW"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB3F1F60F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998017; cv=none; b=AyCtPizhTOBzCiITneDw7JhuXkSF6tzrf29dvKH6zo3Pj0OpTOiD80tz8baMwkGVWhjJW3J+Z/VzYitYnq620++tGH22dbGRYVMnXbdF1MPpjk0eVPqot5G4mtDSmNxP2rG5zPWEjc8seIQRfvsMelvnm4J7jpRgv6iFiPi318I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998017; c=relaxed/simple;
	bh=pWYjuVp7TeGhKmbksvD82QA7LeaebSptPXTW2lDqgHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYuBsuyIk21BXMw6YiSoHbM9CKv4d5Xf0dabBlfGvWqQw9tpJ14wh2J1+vqtrRKMZOHLeES/etgfVciix6sFRE3Ll2aUmd6OnO16OHXU+W5gCINdZ0JqLtAzNpibaIVZ13Q8nxWkUoBatzbM93kD4WWQQvYve0Lrj7oc/MQ8wHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pai4CYDW; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <95a7a0b2-615d-49ca-b568-1376a35493c4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705998011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVIkQhPcPlKe9b1S3Oh/Jh/ARelid6N/hSItWhRruMc=;
	b=pai4CYDWSFYrNAEz5Le4VbHGOdlkmeMmxX2x9egYjwZxK2QxyKjmbZoChEFKhKiEAhL//F
	TffwO4uNuajr5n7sZxJmzOGhKIkDLZmIQY15V2eyP+dOO1ws+2rAto5EnpKS/o+T7bsS31
	pC7n4hpvGcr8Uw8T6LNT16azEc7GHZ4=
Date: Tue, 23 Jan 2024 16:20:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] drm/bridge: simple-bridge: Extend match support for
 non-DT based systems
Content-Language: en-US
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240122163220.110788-1-sui.jingfeng@linux.dev>
 <20240122163220.110788-3-sui.jingfeng@linux.dev>
 <20240123012139.GD22880@pendragon.ideasonboard.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240123012139.GD22880@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/1/23 09:21, Laurent Pinchart wrote:
> On Tue, Jan 23, 2024 at 12:32:17AM +0800, Sui Jingfeng wrote:
>> Which is intended to be used on non-DT environment, where the simple-bridge
>> platform device is created by either the display controller driver side or
>> platform firmware subsystem.
> Could you give an example of a platform where you intend to use this ?


For example:

1) USB based display adapter, such as FL2000DX[1] which use
    the it66121 HDMI transmitter to convert the RGB888 to HDMI.


2) Simple 2D PCIe display controller, such as SM750(EMPV-1201)
    which using sii9022 HDMI transmitter to convert the RGB888
    to HDMI.


3) Some FPGA PCIe Board (sil9136)

4) Be able to run unit test of drm bridges on X86.
  
[1] https://github.com/FrescoLogic/FL2000


