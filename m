Return-Path: <linux-kernel+bounces-118194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F4288B59D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C6D1F37048
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389EC8662C;
	Mon, 25 Mar 2024 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYwn6Q3m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABA184D11;
	Mon, 25 Mar 2024 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410661; cv=none; b=iPMfL7WNSxn1j/i6lxGUlYeEKTnZDzev44fP0FW8EUGqM20m2PXe48TtVbFaApdIGlPUDwkD+HfTbt8TD2hfQ/9p+gIT/MZv6UBAye9bm1C0W52fyYL3Ch+qd62x5SNfyVBhbX+fkbkuz2DPxLqR2n/r6P9YdylySHVRhdqHKeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410661; c=relaxed/simple;
	bh=Cf4w1MUJhBIbx0nj10MDiBNx1UQLuPX9ZY9wh2Chyxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtWPx8ddDcXnuMNM38aLxA/U2biNyO05DWmnXTjvs1CefTPFkYhGHlmI24b3PdO6Jcf/9/4dOXNoqaNiMzmgpM+zJ9yqkGHEWrzXTpTCeAYNEYpFP2V9RnYZACDFLD42vyj/zQUtL7q1uxwF7KTowTRXa6QV2421m8jaGOxoCnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYwn6Q3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954D2C433C7;
	Mon, 25 Mar 2024 23:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711410660;
	bh=Cf4w1MUJhBIbx0nj10MDiBNx1UQLuPX9ZY9wh2Chyxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYwn6Q3m4w2kPmIsWYXJt46NPNhTStCoD/D99jW4QaYeEZE3rAw8CHdWGPhKO5MRo
	 X6YwI3EEP6TZDSzgzyn/Uxe6d74dxccY6dxL0N5qZVvfxJ/BlI9bnu/33sBnFhODy1
	 vnW4IbNYXzGLJUqxEsPeDfdlJ+WBX366D/WZb/PKq2Kw/zX39wWzj6brMuHW08YmJG
	 K8xXGUebBO6zthhCTezcuoUNbasz37TdEE5t6mn//wzONxw1FBSqGgdICLvZM27vBQ
	 FJ2VZ/wcnxbm+U44U3vv7qAdTYbT2ISQr66SsHgrrBP0ImQuQSLZz8Ykag9zIt4oFi
	 KgBRldtl4zuMg==
Date: Mon, 25 Mar 2024 19:50:59 -0400
From: Sasha Levin <sashal@kernel.org>
To: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 6.8 000/710] 6.8.2-rc2 review
Message-ID: <ZgIN4zldW-htJ3lk@sashalap>
References: <20240325120018.1768449-1-sashal@kernel.org>
 <CAEUSe79J7w3=oRAkTks80HLR9CbbkzGXTnubOuzmBYpZBnnttQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUSe79J7w3=oRAkTks80HLR9CbbkzGXTnubOuzmBYpZBnnttQ@mail.gmail.com>

On Mon, Mar 25, 2024 at 09:18:03AM -0600, Daniel Díaz wrote:
>Hello!
>
>On Mon, 25 Mar 2024 at 06:00, Sasha Levin <sashal@kernel.org> wrote:
>> This is the start of the stable review cycle for the 6.8.2 release.
>> There are 710 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>
>A newer revision was pushed on to the linux-6.8.y branch a couple of
>hours later (f44e3394ca9c) with 707 patches. Is that on its way to
>become RC3 or is that Git SHA superseding the previous revision
>(eed20d88c6a6)?

Yes, superseding please - I dropped 3 of the bpf patches.

-- 
Thanks,
Sasha

