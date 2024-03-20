Return-Path: <linux-kernel+bounces-109426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BC58818F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E48B1C21048
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BCD85947;
	Wed, 20 Mar 2024 21:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="YYQQ23Hh"
Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1524F8B2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710969106; cv=none; b=rscGwokSVQWnx9z4PtMJ4vQymO0lIR4pzzoqPQefCnpzwXKTG9H1tpweyh6Coj0AVUIyC6NkHZqiZll1LnUu+eK9UU+nvbJl/QGQOfl2rmXE543X86uTP+WVDB//nZr+YAsN+4BotajKVds6RT5AxapMC5MeYgz19eBOKAS8kiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710969106; c=relaxed/simple;
	bh=i+5N/ZS/XeI5GzfDGnArxcE+rOdWbgceO5yJiYCBRJM=;
	h=Date:From:To:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=jOXwu65bBu2K3vNuCG3WGgGPRERezaTxoetM9B/adARPpWL+WMZR8g4Z14WYl1C5yjEamaCVo9gxNhyIDKYdWrSnjzdYer+uiCC/1tsGirjzvrQ3NzoO/zBrv00Apvn5XfcqU7YJsigA1i3rujL9uq9KajlQA6jYZ/Bst0BhOVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=YYQQ23Hh; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 5E2A54CD00
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 22:05:41 +0100 (CET)
Received: from zimbra54-e10.priv.proxad.net (unknown [172.20.243.204])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 54D0C19F5A5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 22:05:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1710968734;
	bh=i+5N/ZS/XeI5GzfDGnArxcE+rOdWbgceO5yJiYCBRJM=;
	h=Date:From:To:In-Reply-To:Subject:From;
	b=YYQQ23HhSFF0XdkZoLjOLsE/p37shF0bCAqbBfs+ZcTSIIQGNH6AIWMDl9rPpzxmJ
	 r/KyQheePWtQRE2AViSYf0+cwcr998VhyOSVwivAtP8CQnDSOcM6KXesS23+MYT4g/
	 POXgLlgOCjAfXx6TcUMy3ZYIZi2jabC4ApyR4O/+ay1mbaiMwLRGrqaCOMCsMVDS0G
	 eW/O9DLC680P1rOlWdMQI/bV6VLDHfDhpuhS2lgB+iTnuCclzs14c9QruyNpUNExMx
	 /a+JqI/Lz2IhfAULTgp/stZA80pNPLGlI4DriB4xiSlMkz75O2TGpv9PYY6vFcL5xg
	 Qn5v7tffbs/lw==
Date: Wed, 20 Mar 2024 22:05:34 +0100 (CET)
From: vincentdelor@free.fr
To: linux-kernel@vger.kernel.org
Message-ID: <566168554.272637693.1710968734203.JavaMail.root@zimbra54-e10.priv.proxad.net>
In-Reply-To: <978241829.272633099.1710968583886.JavaMail.root@zimbra54-e10.priv.proxad.net>
Subject: Increase Default vm_max_map_count to Improve Compatibility with
 Modern Games
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - GC122 (Win)/7.2.0-GA2598)
X-Authenticated-User: vincentdelor@free.fr

Hello,

I am writing to highlight an issue impacting many Linux users, especially t=
hose who enjoy modern gaming. The current default setting of `vm_max_map_co=
unt` at 65530 has been linked to crashes or launch failures in several cont=
emporary games.

To address this, I have opened a detailed bug report (218616 =E2=80=93 Incr=
ease Default vm_max_map_count to Improve Gaming Experience on Linux) availa=
ble at: 218616 =E2=80=93 Increase Default vm_max_map_count to Improve Gamin=
g Experience on Linux (kernel.org) .


We have identified that several modern games such as Hogwarts Legacy, Star =
Citizen, and others experience crashes or fail to start on Linux due to the=
 default `vm_max_map_count` being set to 65530. These issues can be mitigat=
ed by increasing the `vm_max_map_count` value to over 1048576, which has be=
en confirmed to resolve the crashes without introducing additional bugs rel=
ated to map handling.

This issue affects a wide range of users and has been noted in distribution=
s like Fedora and Pop!_OS, which have already adjusted this value to accomm=
odate modern gaming requirements.

For reference, here is the change for Fedora:
https://fedoraproject.org/wiki/Changes/IncreaseVmMaxMapCount

Here is a list of games affected by this low value in vm_max_map_count as r=
eported to Valve:

THE FINALS
https://github.com/ValveSoftware/Proton/issues/7317#issuecomment-1974837850

Hogwarts Legacy
https://github.com/ValveSoftware/Proton/issues/6510#issuecomment-1422781100

DayZ
https://github.com/ValveSoftware/Proton/issues/3899#issuecomment-1304397069

Counter-Strike 2
https://github.com/ValveSoftware/Proton/issues/2704#issuecomment-1705199788


**Steps to Reproduce:**
1. Install Ubuntu or other distribution with `vm_max_map_count` being set t=
o 65530 and attempt to run affected games such as Hogwarts Legacy or Star C=
itizen.
2. Observe that the games crash or fail to start with the default `vm_max_m=
ap_count` setting.
3. Modify `/etc/sysctl.conf` to include `vm.max_map_count=3D1048576` (or an=
other sufficiently high value).
4. Reboot the system and observe that the games now run without issue.

**Expected Result:**
Games should run without crashing or failing to start due to `vm_max_map_co=
unt` limitations.

**Actual Result:**
Games crash or fail to start unless `vm_max_map_count` is manually increase=
d.

**Suggested Fix:**
Increase the default `vm_max_map_count` value in Linux to a value greater t=
han 1048576 to accommodate modern gaming software requirements.

**Affected Games:**
- Hogwarts Legacy
- Star Citizen
- THE FINALS
- DayZ
- Counter-Strike 2
- Payday 2
- (and potentially others)

**References:**
- Fedora's change documentation: https://fedoraproject.org/wiki/Changes/Inc=
reaseVmMaxMapCount
- Various user reports and confirmations on gaming performance improvement =
with increased `vm_max_map_count`.

I appreciate your time and consideration and welcome any feedback or sugges=
tions on this matter.

Best regards,

Vincent DELOR

