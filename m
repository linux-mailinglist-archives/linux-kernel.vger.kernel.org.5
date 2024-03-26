Return-Path: <linux-kernel+bounces-119690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2833588CC15
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D564F325C86
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D321127B65;
	Tue, 26 Mar 2024 18:33:41 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6613684FDA;
	Tue, 26 Mar 2024 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478020; cv=none; b=b2WzxGllNCM/LcNSuqnRkpY55PfiiTCmKjw12chL680uWlC9bmHle10MpfTqzkhAE8OVgu7Msfl9Iup2KKaF9YF/JB9ygP4DE23E7UDHKPPgcW4gzElnujSXJcyel93iPYkmYO+axX5GMRRdEfmRGiICsL2a3EeD2f9fQx0IlPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478020; c=relaxed/simple;
	bh=XoAUvINpdZow5KuSqlBT5c/MnMr+VKpziMQ9puK0v+c=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=CSBhru1rmOTHiNjB59GfKkTPXayP5XYOyvVLiq3Su2nuT+9432BieW8p1c3Zg0NQzNxk68uDXn04OpcRYPRrRZvHtAEETI5PWtZ7gj5Wj+qTVadOqXSiKe9pg9mTm28+Wv5+Xl7i7/7vCCRrw1k2bglNggXagwdy3lfM7nEWVFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 9A5853780C6C;
	Tue, 26 Mar 2024 18:33:36 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240325115928.1765766-1-sashal@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240325115928.1765766-1-sashal@kernel.org>
Date: Tue, 26 Mar 2024 18:33:36 +0000
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de, "Gustavo Padovan" <gustavo.padovan@collabora.com>, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>
To: "Sasha Levin" <sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2882f3-66031500-1-427b5a0@124845371>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?5=2E15?= 000/309] 
 =?utf-8?q?5=2E15=2E153-rc2?= review
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Monday, March 25, 2024 17:29 IST, Sasha Levin <sashal@kernel.org> wr=
ote:

>=20
> This is the start of the stable review cycle for the 5.15.153 release=
.
> There are 309 patches in this series, all will be posted as a respons=
e
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Wed Mar 27 11:59:27 AM UTC 2024.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable-rc.git/patch/?id=3Dlinux-5.15.y&id2=3Dv5.15.152
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git linux-5.15.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-5.15.y for this week.

## stable-rc HEAD for linux-5.15.y:
Date: 2024-03-25
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3Dd978081b2581ae4e96c47d3427fffc95e13a15a9

## Build failures:
No build failures seen for the stable-rc/linux-5.15.y commit head \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-5.15.y commit hea=
d \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


