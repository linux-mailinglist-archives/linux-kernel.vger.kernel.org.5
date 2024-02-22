Return-Path: <linux-kernel+bounces-76167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7301585F3BD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31591C21445
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ECC37152;
	Thu, 22 Feb 2024 09:00:18 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D41E33CD2;
	Thu, 22 Feb 2024 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592418; cv=none; b=Y8Ib2Nc/POw2JLXFjIYypAWSW3PqUfAqkeJPWkFhG40sWn0vwLGNFh59tuDbsGrCSHV8XGaMiW8hPF5VBfKUxqVObz09EceU6TjIxFUqz7QGn+PWPPlBWN6f8HOQmmO2tsIBU/vNjN7qACx+JN00KDYVATzqFEOuE8jjiJakg6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592418; c=relaxed/simple;
	bh=9MXRsYld5gcuz4m2kWsdfnPBgyE1kvb6DCbkC5BZlSs=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=Zi6YFBkfNqlTaSEVKSdN15GrLVC7C4CowsWZXZFrOXB19+C9Nr0CGUSU5rDKgdKbAeoKvsBFL/WQQgxDtZ/S332/huLuoC8U5dwealrmks+QbLfb6qzmPr086cq1XLOdr13zpJcd3IhkZkHT1Vo1lU7e13lWc84+pz3a5avPOdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id AFBF537820C7;
	Thu, 22 Feb 2024 09:00:07 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240221125951.434262489@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240221125951.434262489@linuxfoundation.org>
Date: Thu, 22 Feb 2024 09:00:07 +0000
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <10af46-65d70d00-1-46243c80@141388435>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?6=2E7?= 000/313] 
 =?utf-8?q?6=2E7=2E6-rc2?= review
User-Agent: SOGoMail 5.9.1
Content-Transfer-Encoding: quoted-printable

On Wednesday, February 21, 2024 18:31 IST, Greg Kroah-Hartman <gregkh@l=
inuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.7.6 release.
> There are 313 patches in this series, all will be posted as a respons=
e
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7=
6-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
git linux-6.7.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-6.7.y for this week :-

## stable-rc HEAD for linux-6.7.y:
Date: 2024-02-21
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3D028924d29f01deaa6bfdb53b7e5408948c909d91

## Build failures:
No build failures seen for the stable-rc/linux-6.7.y commit head \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-6.7.y commit head=
 \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


