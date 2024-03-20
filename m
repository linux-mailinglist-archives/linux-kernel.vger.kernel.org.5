Return-Path: <linux-kernel+bounces-108508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86CE880B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B5BEB21954
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B143E37160;
	Wed, 20 Mar 2024 06:50:04 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AB936AE4;
	Wed, 20 Mar 2024 06:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710917404; cv=none; b=QafIlcjiI/O0nBA5KN5OBnKvS8Zr8SpPnKU22GE/JO0Q0boT1DEv3rMrfr3sEbF47FTYYmqlPohavuvLFAMops4YgZEUfe0EFjponnKQI5rPDOxOPVbWcuTBi6zKtuV6kawWsfXTfSGkbIrCxsEEomejDZaK7I1a/LPWFRZ2sh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710917404; c=relaxed/simple;
	bh=qXzaMmUjLgtfU6ksOSl/6Quc/HlC9r7F3efPpkAMX30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TL2hF0fVxLJ6LdF+kyYYXX1lKhG9JFsmbtIGInVbArToJ2Y2UWp9Eiq+EX9IiUlPuDS65cIXB0LCtOrRdZ26bM+3JVM1AMK4O2vum90zGL1kM4nucjXH8BjUUDezNRwKX+tV9mfIDxnyD3GUwRtr21ihnf2H4iqnEjr9Wfsz+G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: de7c52fd4db04ec0b22eddd14bf9b6b8-20240320
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:cf5866be-525f-4540-8c20-3d27b7a82ea4,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.37,REQID:cf5866be-525f-4540-8c20-3d27b7a82ea4,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:6f543d0,CLOUDID:6b169d90-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:2403201000570FJ81X2B,BulkQuantity:10,Recheck:0,SF:19|44|64|66|24|17|
	102,TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:40,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_OBB,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,
	TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: de7c52fd4db04ec0b22eddd14bf9b6b8-20240320
Received: from node2.com.cn [(39.156.73.10)] by mailgw
	(envelope-from <mengfanhui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 278497469; Wed, 20 Mar 2024 14:44:25 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 0C9FCB80758A;
	Wed, 20 Mar 2024 14:44:25 +0800 (CST)
X-ns-mid: postfix-65FA85C8-997272164
Received: from [172.30.60.81] (unknown [172.30.60.81])
	by node2.com.cn (NSMail) with ESMTPA id BE370B80758A;
	Wed, 20 Mar 2024 06:44:21 +0000 (UTC)
Message-ID: <021efce7-1e40-43a6-9bfd-0d968bfcd5a8@kylinos.cn>
Date: Wed, 20 Mar 2024 14:44:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] config/mips: support zswap function
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: tsbogend@alpha.franken.de, geert+renesas@glider.be,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@vger.kernel.org, hannes@cmpxchg.org, nphamcs@gmail.com,
 chengming.zhou@linux.dev
References: <20240126075547.1521556-1-mengfanhui@kylinos.cn>
 <Zfp7Y9x2iOE_prpp@google.com>
From: mengfanhui <mengfanhui@kylinos.cn>
In-Reply-To: <Zfp7Y9x2iOE_prpp@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Zswap and zsmalloc are compression methods, and kernel configuration can =
be configured simultaneously.
zbud is an algorithm, and users can use that method if they want to use i=
t.It won't affect each other.

=E5=9C=A8 2024/3/20 14:00, Yosry Ahmed =E5=86=99=E9=81=93:
> On Fri, Jan 26, 2024 at 03:55:47PM +0800, mengfanhui wrote:
>> Solution /sys/module/zswap/parameters/enabled attribute node
>> does not exist issue=EF=BC=8Chandle zpool zbud initialization failed,
>> open CONFIG_ZSWAP CONFIG_ZPOOL CONFIG_ZBUD configuration,manual
>> zswap function by /sys/module/zswap/parameters/enabled file
>>
>> Signed-off-by: mengfanhui <mengfanhui@kylinos.cn>
>> ---
>>  arch/mips/configs/generic_defconfig | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/mips/configs/generic_defconfig b/arch/mips/configs/g=
eneric_defconfig
>> index 071e2205c7ed..14884df392f4 100644
>> --- a/arch/mips/configs/generic_defconfig
>> +++ b/arch/mips/configs/generic_defconfig
>> @@ -13,6 +13,9 @@ CONFIG_CGROUP_DEVICE=3Dy
>>  CONFIG_CGROUP_CPUACCT=3Dy
>>  CONFIG_NAMESPACES=3Dy
>>  CONFIG_USER_NS=3Dy
>> +CONFIG_ZSWAP=3Dy
>> +CONFIG_ZPOOL=3Dy
>> +CONFIG_ZBUD=3Dy
>=20
> Any reason for choosing zbud over zsmalloc, the default zswap allocator=
?
>=20
>>  CONFIG_SCHED_AUTOGROUP=3Dy
>>  CONFIG_BLK_DEV_INITRD=3Dy
>>  CONFIG_BPF_SYSCALL=3Dy
>> --=20
>> 2.25.1
>>

