Return-Path: <linux-kernel+bounces-32019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930AE835562
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B401C20B48
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C957736AF0;
	Sun, 21 Jan 2024 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="a0gXouY9"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6BD36AEB
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705835071; cv=none; b=QHhMQLHKmlDlaXiXWYmL7oSOr00XnGEdvW9ZHCulnY1UG15xNfCsH9ShetXxvLAZlG9JazbmFJi4cgeahL54jyz4k903RwbeozApKz9CneFp6Gxtn8CiNeSpkI8YD2MigP+vES5DUwVak8O6F1BUXg1yK/5WMEpi8JGji09tIvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705835071; c=relaxed/simple;
	bh=ZBf5wsr0zVlRl65bLe/eDTt74wMuP9MVSgGfpJd5uQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0sFXCKv12yV7s+95uu3uLHJmkvYll7UMTWZZ2ezRlMSw9F6AegVXEwTP+bFGysR59LF1n8oOZutHX8WrOesTeq9PlQQ14rwuY/3snIrlGN+wz29QQbwa9/YQSOpyYeCN+SxKtZFSG7yR8ZTDkrqnf4qrhN9IIkCgGgYdAvW1l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=a0gXouY9; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705835057; x=1706439857; i=markus.elfring@web.de;
	bh=ZBf5wsr0zVlRl65bLe/eDTt74wMuP9MVSgGfpJd5uQM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=a0gXouY9MXY2SSbkxiwUbIR+pAywqxkENiFDsYUK0H9pntG7Zm8NmkGHAD0oNdL/
	 kPhZvbPw1bJIB+5UL0v4/FFsIguUkVokSOcckPHJ/3XfIRT+etxKqIIjCRJUPtBf7
	 krxHoyJ6Y1wVBALOWhCui9BTrpWNEUREkCJJ2/MfKY1nSDGjsJ6FiYtZRgay59I3S
	 O6zod7PtPhpWUEfjcnM/U4sS1wMOb+VulhITKN5TUNbGyELKfBOaBCYFWfWlqguah
	 WdGujMMKU4Nhvp7lfFB2l7AfB7Bs85x46WessfMQN+T9ThWJuJNhKG6pV4/a5BC/u
	 DFD+/LFPQYzfSexiag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mc1VL-1qph6N3jOZ-00dUho; Sun, 21
 Jan 2024 12:04:16 +0100
Message-ID: <161c3be1-011c-4ffd-8646-1b95f1a461eb@web.de>
Date: Sun, 21 Jan 2024 12:04:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [v2] coccinelle: device_attr_show: Adapt to the latest
 Documentation/filesystems/sysfs.rst
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, Li Zhijian <lizhijian@fujitsu.com>,
 cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>
References: <20240119062057.4026888-1-lizhijian@fujitsu.com>
 <alpine.DEB.2.22.394.2401202217550.3267@hadrien>
 <f34231dc-186b-4cb9-889b-b3be9224c5a9@web.de>
 <alpine.DEB.2.22.394.2401211159350.3743@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2401211159350.3743@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WeXwUX6Svf5TPxoWwSCSwc03iGGWuP3zbVSv3X8Ju9LtW/rAIF0
 imChZZIHPUfTQEsqZLxBFRS1QMwie8AM8qh3FwTsqt198cMYhwd9bHhp11crr1XZaWCncng
 dM+n0tgfVzGuCNKX9Hn1PFx1K7PG/QC1XUpvzN7oeWUYQRxy7GrCTtg47osDazoLvlewT42
 p3q58llW/wKW+j6SUStvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q2jDmcDuYwQ=;C+mzgigO59RSMKBk0llp7W3YQ+A
 hJ6HTdXytOXxE9yN9osp7WJRJxVJB1z0akKW/hN/vWzuV6H8bHFl8Fo2iyxYjRtBLyQLiekTJ
 nJDak9MzxCS4UMWunPzRR5NLe2zwCHfvgnpALqG0hQd3L6Ikk964O2vGabM3rOA4d7J5pWeDE
 9e/wHmWP+GXQGtNR3+/3e/kKhdC2s2I/+ezevTTSpJNyU69bVsvDj5vtv3D5WY6rthRsZaSGy
 yJsQ7jMQ6U3ZaDCFFP+tKwLd/qsbnLO+8zikAPYj2XThyiSaf6xkS8cejW+Hvf/mYLp2n1nch
 AMuMeWtAsbdwKjshf/R61ics7iJaDzN7o99J6HsEx2haTFLWC1iAajZIaWOzcfpWijXiRR+6W
 SUo7hS0fFgeamlkTBzFMLfBXykpK5YGC1pcg1wLPVInSqgyXTQhV7oV8c6roobUBKu5d7wz6i
 SkS3FDObDPortdVtDTXJNl306DVkIHPOz432I0is0YPZmDCjpx8bcNhL63powUTdjrsU+OINs
 PRcFCWmzpXwhoSDw38iI19+L/41iZZAM/OR+Ec6nmWHOVsvvrdCOBLLlzr7UJvQ03ShZQ5Eqc
 co1liF8YRgIe8agUJabA5q5cHOMS6E2CTaD4M1hlqRyVD1bmsksaua5xGBT1xy1jZX2SIebyj
 eKxHkOCT/uAeeR7F13Wg7qNNXzfdE2cCQX8UWpMIPwpv3OnUK5HuBk7RT0ZBj7SY+C5SzL1GX
 i83sHEaTbjQjsvoRYpSakZV3nOP2/l9yrr5LGxK/JKPOxMepLKmuIudYZzKdraKkBwWu1gs+N
 SiE/FFiyqmQjYr5C6mRRMsyGveoYTDG37oPGwr3H6qt0SjFCMEdQgpNWG5stoCgSi79JG1aOZ
 W6pZwECEJ39FhO/VpaNcMzygNvd8CF2fcaRKN9tiLtjRSduIToK1vqGxp3aolhqIw6LHRrqLd
 5YICEQ==

>> Would you like to consider the application of the following SmPL code v=
ariant?
>>
>> -snprintf
>> +sysfs_emit
>>          (BUF,
>> -         SZ,
>>           FORMAT,
>>           ...
>>          );
>
> It's ok too.

Are you going to integrate such a transformation approach?

Regards,
Markus

