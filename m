Return-Path: <linux-kernel+bounces-50030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2DC847354
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D081F26B4D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5473E1468FB;
	Fri,  2 Feb 2024 15:37:44 +0000 (UTC)
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684001468E8
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888263; cv=none; b=RjZzpJJTfwfubR0FSNXLFn1kLTuxP5+pwxnx4/bssV25M3+1v4mI4o9foxFP0GO35rwy4fVkFgnTw9OkmlMoJNQlT0AiCFufxzpw+HrbDgIPh0maiP5PawxbVd944o/rNnwX+xOVrO+YHvIQ4tysYSdPaz0BdjVl3gDE9BIh8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888263; c=relaxed/simple;
	bh=amxXWOA8shkwZCqq409xMVqZnLPj+Od52yEZEeelVY0=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type:Cc; b=gqUAeSjypYvlIBwT30ARKvQwBYdHd14Gc15cEzFmfFZMMVfnEQd26LZgb5g9tYB+2A8qf6d2hWx36r+4MRCu2BFrKnASKssNveZAr4TG7uH64gIsGCoEAuC8/C2JLvrWqAyri26DqFOttfA2bL6g5NyQ/bGd133+/hPXihGKoQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
	id 1rVvWp-0006F8-6z
	for linux-kernel@vger.kernel.org; Fri, 02 Feb 2024 16:32:31 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Holger =?iso-8859-1?q?Hoffst=E4tte?= <holger@applied-asynchrony.com>
Subject: Re: Kernel - 6.7.3 - failed to compile the module
Date: Fri, 2 Feb 2024 15:32:24 -0000 (UTC)
Message-ID: <pan$2ed7c$db97fd26$2ea3b30f$fdd2e024@applied-asynchrony.com>
References: <CAHOGJipx37tUoiSp87Np4b0qzREj60+FEkdi_0X0_JoQW8cYeA@mail.gmail.com>
	<ZbzwgtGUHK2Dj5eo@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
User-Agent: Pan/0.151 (Butcha; a6f63273)
Cc: linux-rdma@vger.kernel.org,netdev@vger.kernel.org

On Fri, 2 Feb 2024 20:39:14 +0700, Bagas Sanjaya wrote:

> [also Cc: mellanox maintainers]
> 
> On Fri, Feb 02, 2024 at 08:55:47AM +0100, Michał Jakubowski wrote:
>> Regarding: https://bugzilla.kernel.org/show_bug.cgi?id=218445
>> 
>>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp1_execution.o
>>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp1_transition.o
>>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp2_execution.o
>>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp2_transition.o
>>   LD [M]  drivers/gpu/drm/amd/amdgpu/amdgpu.o
>>   MODPOST Module.symvers
>> ERROR: modpost: "sched_numa_hop_mask"
>> [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] undefined!
>> make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
>> make[1]: *** [/usr/src/linux-6.7.3-gentoo/Makefile:1863: modpost] Error 2
>> make: *** [Makefile:234: __sub-make] Error 2
> 
> Do you have above build failure on vanilla v6.7.3? Can you also check current
> mainline (v6.8-rc2)?

No need to investigate further, this is caused by an additional non-mainline
patch that has nothing to do with the mellanox driver.

-h


