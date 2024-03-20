Return-Path: <linux-kernel+bounces-108335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A9C880955
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310E81C2280C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346F379C2;
	Wed, 20 Mar 2024 02:01:09 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E8B6AB9;
	Wed, 20 Mar 2024 02:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710900068; cv=none; b=JqVlalIVKFcNvmT222V5lpoLCYdf/G6CTLZgYifKhQ3P/iwHW5Vv8mdI0c9adPFA9etq/nlEHIvRiVdEolSCXQdCpmbnHqu67HcHxtbFHkGTtqSjSA4bC7gLw6d/dI0p4y6wJkUTfTcZM2SWO9ccChHFspnMw4gB/GHGGRg3f4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710900068; c=relaxed/simple;
	bh=KHHjEJoPgy2BM/9wzr00d+uTFTJ2mlQ8A4+YmnEAnMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqwAZWFZG8PkzJLfSu2nZwbuDZlAp74Iayq1ARLRipPQMa0sBhYJxoZhnaalw90F6TJHThNkHNLaIqsA+VGN6W5DpMOc//+sF0GlZCif/rwxrsA1IFiiz0SC/Xbx/FO9QyymRi0K4wgj+2gNRq7S3DV8q/ZIiOpB01M/lZ66mxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ad81665f96ff428799e183e4eb3e3ba6-20240320
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:7a5a4c35-dd4b-408c-82ae-4696d61344e1,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.37,REQID:7a5a4c35-dd4b-408c-82ae-4696d61344e1,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:6f543d0,CLOUDID:c4cab281-4f93-4875-95e7-8c66ea833d57,B
	ulkID:2403201000570FJ81X2B,BulkQuantity:0,Recheck:0,SF:64|66|38|24|17|19|4
	4|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: ad81665f96ff428799e183e4eb3e3ba6-20240320
Received: from node2.com.cn [(39.156.73.10)] by mailgw
	(envelope-from <mengfanhui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 235439646; Wed, 20 Mar 2024 10:00:52 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 98962B803C9B;
	Wed, 20 Mar 2024 10:00:52 +0800 (CST)
X-ns-mid: postfix-65FA4354-583191200
Received: from [172.30.60.81] (unknown [172.30.60.81])
	by node2.com.cn (NSMail) with ESMTPA id B440CB80758A;
	Wed, 20 Mar 2024 02:00:50 +0000 (UTC)
Message-ID: <a38359d5-0fde-439c-bc04-3452a34482da@kylinos.cn>
Date: Wed, 20 Mar 2024 10:00:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] config/mips: support zswap function
Content-Language: en-US
To: tsbogend@alpha.franken.de, geert+renesas@glider.be
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240126075547.1521556-1-mengfanhui@kylinos.cn>
From: mengfanhui <mengfanhui@kylinos.cn>
In-Reply-To: <20240126075547.1521556-1-mengfanhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Who will be responsible for reviewing this? This is a necessary feature o=
f the kernel that many testing agencies need to test

=E5=9C=A8 2024/1/26 15:55, mengfanhui =E5=86=99=E9=81=93:
> Solution /sys/module/zswap/parameters/enabled attribute node
> does not exist issue=EF=BC=8Chandle zpool zbud initialization failed,
> open CONFIG_ZSWAP CONFIG_ZPOOL CONFIG_ZBUD configuration,manual
> zswap function by /sys/module/zswap/parameters/enabled file
>=20
> Signed-off-by: mengfanhui <mengfanhui@kylinos.cn>
> ---
>  arch/mips/configs/generic_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/mips/configs/generic_defconfig b/arch/mips/configs/ge=
neric_defconfig
> index 071e2205c7ed..14884df392f4 100644
> --- a/arch/mips/configs/generic_defconfig
> +++ b/arch/mips/configs/generic_defconfig
> @@ -13,6 +13,9 @@ CONFIG_CGROUP_DEVICE=3Dy
>  CONFIG_CGROUP_CPUACCT=3Dy
>  CONFIG_NAMESPACES=3Dy
>  CONFIG_USER_NS=3Dy
> +CONFIG_ZSWAP=3Dy
> +CONFIG_ZPOOL=3Dy
> +CONFIG_ZBUD=3Dy
>  CONFIG_SCHED_AUTOGROUP=3Dy
>  CONFIG_BLK_DEV_INITRD=3Dy
>  CONFIG_BPF_SYSCALL=3Dy

