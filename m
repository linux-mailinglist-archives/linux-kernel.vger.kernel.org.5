Return-Path: <linux-kernel+bounces-142056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B188A26DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10531F21DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CAE44369;
	Fri, 12 Apr 2024 06:43:20 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12027168A8;
	Fri, 12 Apr 2024 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712904200; cv=none; b=XntNSv22joVfDUswl4IbOY1ZOhQ/zrSbSxLlJm5p4SBd+ElD2dZm81gNkk3PRSk/6PT3slYepjpD63+i1zKBJvI+86je4GWnfH3F8ty8tT0EdMgGC3y36dwrm4N0t5wvSrt4ehz6SIZ+iJn6t4nmXqvLrUoaZUAUD5SfhKK3LNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712904200; c=relaxed/simple;
	bh=KmsBlh6X0fVEerHCN0c8Qo3/DWdwma+/YNcAIv2VApE=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=h6OiC6rGKkKEFJ/LMXCVvLfZwPOlD0qqSlczCAXJ06dxvPMSxd6K54SufuZy5llNO51HPGq3HM6eJmcMdxhUnfu3Ek2+RX6SWyyIfdW6QkIn8QYkFEVi/s1REkWE7aaiTpyEEfB+Qk+2bAkIzWRAXCEJi/lleM6nHLP6df0rhyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id AAC133780C22;
	Fri, 12 Apr 2024 06:43:15 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240411095424.875421572@linuxfoundation.org>
Date: Fri, 12 Apr 2024 07:43:15 +0100
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org, "Gustavo Padovan" <gustavo.padovan@collabora.com>, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3c0c9c-6618d800-5cf-194ac52@77440464>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?5=2E4?= 000/215] 
 =?utf-8?q?5=2E4=2E274-rc1?= review
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Thursday, April 11, 2024 15:23 IST, Greg Kroah-Hartman <gregkh@linux=
foundation.org> wrote:

> This is the start of the stable review cycle for the 5.4.274 release.
> There are 215 patches in this series, all will be posted as a respons=
e
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4=
274-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
git linux-5.4.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-5.4.y for this week.

## stable-rc HEAD for linux-5.4.y:
Date: 2024-04-11
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3D82d3ef7640657b7e1fb7091841ba7a47a7a29ab4

## Build failures:
No build failures seen for the stable-rc/linux-5.4.y commit head \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-5.4.y commit head=
 \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


