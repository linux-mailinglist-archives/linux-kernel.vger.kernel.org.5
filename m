Return-Path: <linux-kernel+bounces-41589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF5883F507
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 11:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC794282D08
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 10:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B351EB27;
	Sun, 28 Jan 2024 10:45:06 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528761EB22;
	Sun, 28 Jan 2024 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706438706; cv=none; b=typLjl2PKjdmf2iNUMPHQny2nhQl2S6b2i205jZRVvdHfPoclIyVUWs7NujSZKjpnKQkmHCK5ezjdOMVRu343Wf9xRLgYCQxWmigAL77LOKENz5b5skQwNZwSf5GkM5YOCspL78dyjXiL9VOVURw6BbAVi7Gi14kJ053VEuBt2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706438706; c=relaxed/simple;
	bh=vWgBmtN5r1x/+vZe5ixDzVsC5yf2JtZ+Ksoi0M64AOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kv/HV1Oe9/WFbu59lcWs0YWOZJWZTC2mbb6cMhDWGwOY/WnFsxfuRHAjfavTWOutwBE86PuWRhuU9+RMehMMin6jMAXGPOdK65ZHzEylspMrnWX00Gk5E1YAdOUwPVqCQNhvLhhNRc0lL9cCkLE299MPRwEjCQX1ixLgbBbACSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rU2eq-0004bW-4H; Sun, 28 Jan 2024 11:45:00 +0100
Message-ID: <acf203a8-b612-437c-a464-228f45e1c694@leemhuis.info>
Date: Sun, 28 Jan 2024 11:44:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1061449: linux-image-6.7-amd64: a boot message from amdgpu
Content-Language: en-US, de-DE
To: Salvatore Bonaccorso <carnil@debian.org>,
 Patrice Duroux <patrice.duroux@gmail.com>, 1061449@bugs.debian.org,
 Lewis Huang <lewis.huang@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 Phil Hsieh <phil.hsieh@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <170612149675.7169.757906919183146487.reportbug@kos-moceratops.home>
 <ZbUB0YWxEET3Y0xA@eldamar.lan>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZbUB0YWxEET3Y0xA@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1706438704;8ccd8eb5;
X-HE-SMSGID: 1rU2eq-0004bW-4H

On 27.01.24 14:14, Salvatore Bonaccorso wrote:
>
> In Debian (https://bugs.debian.org/1061449) we got the following
> quotred report:
> 
> On Wed, Jan 24, 2024 at 07:38:16PM +0100, Patrice Duroux wrote:
>>
>> Giving a try to 6.7, here is a message extracted from dmesg:
>> [    4.177226] ------------[ cut here ]------------
>> [    4.177227] WARNING: CPU: 6 PID: 248 at
>> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c:387
>> construct_phy+0xb26/0xd60 [amdgpu]
> [...]

Not my area of expertise, but looks a lot like a duplicate of
https://gitlab.freedesktop.org/drm/amd/-/issues/3122#note_2252835

Mario (now CCed) already prepared a patch for that issue that seems to work.

HTH, Ciao, Thorsten

