Return-Path: <linux-kernel+bounces-128358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B558959D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F1D2838B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A332D1598FB;
	Tue,  2 Apr 2024 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="lPq4wiNU"
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6E05B692
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075873; cv=none; b=qkkcEk1qNw/dJ1znh8gnQTFYuDANCmMTzir2/5neh6SYYM1CZUop5gWYwV13HCLHogEf9MBxkZ0ZzGlIS+R4X1r1FI7S/bcv7vHOVr63PQieBoCcw2rfaAZjZSFmDFDydSHoug31nfyXbww7Lt3oob7uX0geGZrHQH5qvmJL2N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075873; c=relaxed/simple;
	bh=QOPyNTNoewg1HwPS32UY2eGIGT/iuEIolnKwc/oKe7Q=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=bwwwFIdg5DrRH4/scqcJMjnl8JkqcXduKob0pNIj9MTeExprw0goeKE2i2N+HwIKCJa+MlhKm5m57LNOj5zraYvtxJujCKzaDO4dunv88KAgZXSXBHHPoGgM90s2MjRluw2HpEiD+z+9qY6P4eRWDvBO/K0OQADTJNyoNUBwTRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=lPq4wiNU; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7A702AC0095
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 16:37:44 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 086D013C2B0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:37:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 086D013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1712075864;
	bh=QOPyNTNoewg1HwPS32UY2eGIGT/iuEIolnKwc/oKe7Q=;
	h=Date:To:From:Subject:From;
	b=lPq4wiNUOGzEFOCMXUQXicXNQeKmG8N8Eto6TgfKvKea0s8eErWpmcwfQqnLX4ECA
	 3Ds0VsIMxsYMLFZuUVv1sFyFm/CNmCYJ2nNUzjz54Q4+WEER3sAO/Wazp9g2DQ948v
	 hu5c5566VaBtOUXiI0pGb6/dn57SGc75kzevBfh8=
Message-ID: <30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com>
Date: Tue, 2 Apr 2024 09:37:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: LKML <linux-kernel@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: 6.9.0-rc2+ kernel hangs on boot.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1712075865-cIxxIcZTND8c
X-MDID-O:
 us5;ut7;1712075865;cIxxIcZTND8c;<greearb@candelatech.com>;c71d53d8b4bf163c84f4470b0e4d7294

Hello,

Sometime between rc1 and today's rc2, my system quit booting.
I'm not seeing any splats, it just stops.  Evidently before
sysrq is enabled.

[  OK  ] Started Flush Journal to Persistent Storage.
[  OK  ] Started udev Coldplug all Devices.
          Starting udev Wait for Complete Device Initialization...
[  OK  ] Listening on Load/Save RF …itch Status /dev/rfkill Watch.
[  OK  ] Created slice system-lvm2\x2dpvscan.slice.
          Starting LVM2 PV scan on device 8:19...
          Starting LVM2 PV scan on device 8:3...
[  OK  ] Started Device-mapper event daemon.
iwlwifi 0000:04:00.0: WRT: Invalid buffer destination: 0
sysrq: This sysrq operation is disabled.

I can start a bisect, but in case anyone knows the answer already, please let me know.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


