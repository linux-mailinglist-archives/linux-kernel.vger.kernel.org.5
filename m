Return-Path: <linux-kernel+bounces-119682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5B188CBF9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC251F83DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C6D86AC6;
	Tue, 26 Mar 2024 18:25:22 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7A9482EE;
	Tue, 26 Mar 2024 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711477521; cv=none; b=bVQX0bDTeImgxlK8Nw4KLp92hiIhhrQ28x7gPVl1p38KujzTDMU2UaM12vzcs0pvYGdzIPMPlFx3LwY55SzierPp0cqI3xvqxebWzwt1bDA0BHHhPUO1AOPGU4GIyVrLWIeRhhGgKPgCTVSoPJfPtMrGUpbB9aB7PQPjudwr2L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711477521; c=relaxed/simple;
	bh=PS4v8wUt8nGUndi43RCDdFlDiRKh22UGvcJwOMISI4M=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=dJJUhVUw4DUHutxVA9U2op/2Ih8KH5LM+8GtS/6MLVmdR5OfCvT1GJ9p4RFvuyEtP9X0z+4RsUJKvHt22n+rkDDuAvWKMxqwUOg06Dur2eseQ2bKC8KSJwk0mH3KD/hqewNOZLt1VsW/km0gvNgV5F0t9ArhqCa3+0OfbCFcY6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 27C403780C6C;
	Tue, 26 Mar 2024 18:25:17 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240324234027.1354210-1-sashal@kernel.org>
Date: Tue, 26 Mar 2024 18:25:16 +0000
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de, "Gustavo Padovan" <gustavo.padovan@collabora.com>, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>
To: "Sasha Levin" <sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <28824a-66031300-1-3bb0ad80@260002568>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?5=2E10?= 000/238] 
 =?utf-8?q?5=2E10=2E214-rc1?= review
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Monday, March 25, 2024 05:06 IST, Sasha Levin <sashal@kernel.org> wr=
ote:

>=20
> This is the start of the stable review cycle for the 5.10.214 release=
.
> There are 238 patches in this series, all will be posted as a respons=
e
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Tue Mar 26 11:40:23 PM UTC 2024.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable-rc.git/patch/?id=3Dlinux-5.10.y&id2=3Dv5.10.213
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git linux-5.10.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-5.10.y for this week.

## stable-rc HEAD for linux-5.10.y:
Date: 2024-03-25
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3Dbbdc0ccf6f1665aabba4a0a227f9c118e86804eb

## Build failures:
No build failures seen for the stable-rc/linux-5.10.y commit head \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-5.10.y commit hea=
d \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


