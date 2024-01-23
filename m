Return-Path: <linux-kernel+bounces-35938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD608398F3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E0B1F2C46C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A4E12BEBF;
	Tue, 23 Jan 2024 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=svenjoac@gmx.de header.b="q7jY+PFq"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E2612BEAE;
	Tue, 23 Jan 2024 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036098; cv=none; b=JPq5jULn6cl2krHXtiDn1wJZ1iDHgUyGO11AmnVOwdxnqRehCcvLDwv4SvnMtrQ1MksOsdlEBGNkoHyqWf20t4XlnBAVjp9hRJ7NCiHidJo7llh646FtT0rNP3KvLQ22r8yWtE/7WUx3A5Jb/nLLPnqc57xYbkhQhMcR+ZPCbJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036098; c=relaxed/simple;
	bh=Zq83BY/6gby8jx+0PqbiYFZI9HfPYSVZXXbRmBjHK0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hNtjO68jo2A4iNFbs41o7ULYGM/Xfd1gifSoCrVXBEPnXdihpPA/G/xDez4HMKh/Ydy2q4VLsCPX2vMXTH3CcygKK6wjJOCyYw/DfdP6ctKyWEko4fNf48eTrUlMSBti8YUuKc9D0QFkgcRJXtCTduYsfEb+1f12lPgCmA+MkDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=svenjoac@gmx.de header.b=q7jY+PFq; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706036070; x=1706640870; i=svenjoac@gmx.de;
	bh=Zq83BY/6gby8jx+0PqbiYFZI9HfPYSVZXXbRmBjHK0U=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:In-Reply-To:References:
	 Date;
	b=q7jY+PFqc27lMwwc9IChsZoxlq/bXZuI3jygYu6iPCeN53rVSbd8ZWBz0K6W5E3X
	 UBYLLMLN0Vlh6hKF6tUM7N1cQvz5zOoS3UmEfFGZEppMISphHDQogyDGChsvuXB57
	 9Hzr53WbZ4w1CEQZB+C7O70XDdzOA0cQcnkpCu8swmx/02vSjEYLOENuaSzqjfzft
	 EUGitjxy1RooT4N68vjWCNCCfO/ez71aMnx+Li9pymXMdQ5fPjHNARLBeKaUm9kER
	 FiM/TDIHecWvzE4N9EaSvla8T0YJep6y1tvFmjCLz58r3bUwZ1fy66q0u4qaRUqQ2
	 /ioA8Lq2JWFqRPnBcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.203.86.131]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MDysg-1rKgvy0Ylw-009zLT; Tue, 23 Jan 2024 19:54:30 +0100
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 65B7380110; Tue, 23 Jan 2024 19:54:27 +0100 (CET)
From: Sven Joachim <svenjoac@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,  patches@lists.linux.dev,
  linux-kernel@vger.kernel.org,  torvalds@linux-foundation.org,
  akpm@linux-foundation.org,  linux@roeck-us.net,  shuah@kernel.org,
  patches@kernelci.org,  lkft-triage@lists.linaro.org,  pavel@denx.de,
  jonathanh@nvidia.com,  f.fainelli@gmail.com,  sudipm.mukherjee@gmail.com,
  srw@sladewatkins.net,  rwarsow@gmx.de,  conor@kernel.org,
  allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/417] 6.1.75-rc1 review
In-Reply-To: <20240122235751.480367507@linuxfoundation.org> (Greg
	Kroah-Hartman's message of "Mon, 22 Jan 2024 15:52:48 -0800")
References: <20240122235751.480367507@linuxfoundation.org>
Date: Tue, 23 Jan 2024 19:54:27 +0100
Message-ID: <874jf3hod8.fsf@turtle.gmx.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:doAmV5KqM2/Cz0caglCAVH8AQTXpevCKwLUyqEu0d176D4SdO4B
 L3h5BhP84x8cP9EpIog+FuN2w8WBJlGKkoQCoV5FolAsgFiBKeHse7qZ33ly0kso4JvEXD5
 uMHQqOtWjlNXe9EvOs1R4y5+Xzc99hfd1bjkvsJnRhQQSDh3+NgxRQ5chzdr0Tptp2PO74I
 coc2EWDr2kQmhfOMrHnbA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DklUbd5GSsE=;JoZZEj5+xUKVIKh4T+CyjC3NgTx
 MtePDiA67uA8+xEUPDzMyP2siJ37OnpY2W9WCgc/R7cePVqPCsR7aE68/5zHQP2MR3hCxgyUH
 LbjwAThxswzz9gCE5Nm9HqN8jpWodp8CyEWryk0zlK3o2CV+Bv8H9coNDnFqhPLjpBL7Kvzqz
 OSzy+M+grQipkKo0FwXt0o5tRA6T/S1Wxoid8/w1I4Ij0brXTsZ2+BO/MqNKWa3vmQVgrA/Jt
 d23V7xtzJnCs/PPtS/M7awbezgWXJfS+Hqh3y+rEVIDmb6yLmlyODNZ/AanGs47vNtrMpTRfK
 Pnjf5zzgd9xbPASHTJq1jQzEsvli79sOkTzQjdE+YYu5DmF+ZIxi1LdTo+Alhynpt6hnMN2xX
 M9j0FSw4+x3bCy8PaH94Lk1Gh7c+lnrlZAKPi1jT2sg1O9VdHaKD9kp8yYwGKbdNq1xNhX2cP
 ZFbOTrniqHfCXWVFTTpalmNtvBLMnoQFCBbp58Q4RCaREfmGi+080NFmhZ3uj69Ifspg//GfV
 jjbEyWjyQWm5kaWRJ5iiB/KAJARLudZqe/yTW1Xo7tzUdfkhKP8CPG9eyHkrprCrW5+7ce5vN
 e9NDfS3s9OlGU5EvdIWiG6MxXVNkQrAbooXhQndXKGPOH7YhY5JdEntQBNBoIxXtaxe+rPI21
 Pf5ciuAvXkxu04Ba45So2bkTzFzZEUDlRC+yM2+090TDPjlfIxz/h1AXXUYe9eJoQgqObju5W
 PjJxl7pW+uq8rraYKz5PL7K6jekNJqUuC5uDYG/oKkolLLkxgTWfLa6r+p7i21U1oMewFUlbT
 Lq4sA+cJ71a5vf0JavBMUYSEpToBTcaXdKblN/XTjXl2Ep2KE7q2+nFz6c5rupSFJ94jZnZuD
 T+UNehTLpjeemF4JsdrL+emS8p2fEhquNragajMV39I6GirFtYipefbzaB7C7+vQ9t5YiUWlb
 T7vFiw==

On 2024-01-22 15:52 -0800, Greg Kroah-Hartman wrote:

> This is the start of the stable review cycle for the 6.1.75 release.
> There are 417 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Works fine for me on x86_64.

Tested-by: Sven Joachim <svenjoac@gmx.de>

Cheers,
       Sven

