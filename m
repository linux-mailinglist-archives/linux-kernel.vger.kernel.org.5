Return-Path: <linux-kernel+bounces-108517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF78880B99
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6D6283E9F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E7B1EB52;
	Wed, 20 Mar 2024 07:00:15 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCE31EB23;
	Wed, 20 Mar 2024 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918014; cv=none; b=tm2rGpltHfWvScovA9qKaNwqMIz9xb5iFGh9soDhWBmjGuZvjVTt7zrr07q2b6G3HJKFfvBlxMuITVgYYa1bHYmZGxGA9OeHDaTlnVEb0Y8LcEtMckSaG/1JTvX34abhxX1VJDglQjXqpP9nnObkE5k2de++akguySFvaCAK4NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918014; c=relaxed/simple;
	bh=HTTrM5twdcftVhagDn5lY0E4vILkVhvOdzJWy2xZXKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLVxemp4YuV7ITijsooLY0kHsRB7dpQJUrLt9U/0Kh9nDWsNIYSeEDq0bbqnAjfDpV1lclFp0wrnqghXoTv1GkKamf4jUDSXG8aidB4Txy1sNU0ynHDdbQ2tfJcO8wfu7kCZnGt6DncIZ3VdBOAS8cm+r9RDxCjq4Hnzmonh6Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a9e7b00a2d974b92a0c7a8672ac406fe-20240320
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:b5cb8324-fda2-4f02-82f2-1ea0cbe3fe92,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:5
X-CID-INFO: VERSION:1.1.37,REQID:b5cb8324-fda2-4f02-82f2-1ea0cbe3fe92,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-META: VersionHash:6f543d0,CLOUDID:9a161b00-c26b-4159-a099-3b9d0558e447,B
	ulkID:2403201000570FJ81X2B,BulkQuantity:15,Recheck:0,SF:17|19|44|64|66|38|
	24|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_OBB
X-UUID: a9e7b00a2d974b92a0c7a8672ac406fe-20240320
Received: from node2.com.cn [(39.156.73.10)] by mailgw
	(envelope-from <mengfanhui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 542372133; Wed, 20 Mar 2024 14:59:52 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 22D6EB80758A;
	Wed, 20 Mar 2024 14:59:52 +0800 (CST)
X-ns-mid: postfix-65FA8968-88231199
Received: from [172.30.60.81] (unknown [172.30.60.81])
	by node2.com.cn (NSMail) with ESMTPA id 97532B80758A;
	Wed, 20 Mar 2024 06:59:47 +0000 (UTC)
Message-ID: <7d925338-8646-4480-9c79-83af041de122@kylinos.cn>
Date: Wed, 20 Mar 2024 14:59:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] config/mips: support zswap function
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>, linux-mips@vger.kernel.org
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

