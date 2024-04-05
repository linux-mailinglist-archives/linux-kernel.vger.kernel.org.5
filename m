Return-Path: <linux-kernel+bounces-132535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC543899661
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BA65B22568
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732D22D05F;
	Fri,  5 Apr 2024 07:17:24 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1122.securemx.jp [210.130.202.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29CE2C69F;
	Fri,  5 Apr 2024 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712301444; cv=none; b=XC3T8apiow0ZrRCO0unQiSk+yM23QgruI71A5Rp9B5zfqsnk+dvoAPt3Shqq/7YZAcU+nm/g5RmP4au5/2QaTiqkRNGCSBvDNDsduh8haedTtqCOacFjFZxjnEBRq0ZHwcBfg/OPnY2WYJ4/wlaMPfElwxynTlWXnIg8+rT4snc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712301444; c=relaxed/simple;
	bh=aWuYLQx3cT3sMqjyLNuhSw0YnpRhPP9iVZTnefmVILg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LVmhkeVTyYE88m5cuZarHKAO5W9cCzmdw0+SnW5z5ODYotmvbPYLljwDSW3c2t5pMck6oCU744j3Fr85lnsol/4Ck4ATAWHnjqTERhhwDSOzXuqFP7DSxRH2f/uLL/CZ6I5u4iwb7pT/HHRkQFtzo3Rpx5x8NOq0Eb5yz9YXJNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1122) id 4355bqJ21399056; Fri, 5 Apr 2024 14:37:52 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 4355bKPr2321699; Fri, 5 Apr 2024 14:37:21 +0900
X-Iguazu-Qid: 2rWg9o4uj4bd4uUMYT
X-Iguazu-QSIG: v=2; s=0; t=1712295440; q=2rWg9o4uj4bd4uUMYT; m=qaukDK6/RdB2jfGj6npjkS5B4Zl3dh7LPkYmq44zB1o=
Received: from CNN1EMTA03.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1120) id 4355bIiq1330523
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 5 Apr 2024 14:37:19 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA03.test.kioxia.com (Postfix) with ESMTP id 8B45C2F603;
	Fri,  5 Apr 2024 14:37:18 +0900 (JST)
Received: from CNN1ESTR04.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id 463861900001F6;
	Fri,  5 Apr 2024 14:24:45 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR04.kioxia.com with ESMTP id 0003QAAAAAA01FJ0;
	 Fri, 5 Apr 2024 14:24:45 +0900
Received: from CNN1EXMB01.r1.kioxia.com (CNN1EXMB01.r1.kioxia.com [10.232.20.150])
	by Switcher-Pre_Send (Postfix) with ESMTP id 3A808A2A9BFD5;
	Fri,  5 Apr 2024 14:24:45 +0900 (JST)
Received: from CNN1EXMB03.r1.kioxia.com (10.232.20.152) by
 CNN1EXMB01.r1.kioxia.com (10.232.20.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 14:37:17 +0900
Received: from CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) by
 CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) with mapi id 15.01.2507.035; Fri, 5
 Apr 2024 14:37:17 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        "oe-kbuild@lists.linux.dev"
	<oe-kbuild@lists.linux.dev>,
        "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
CC: "lkp@intel.com" <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>,
        "linux-raid@vger.kernel.org"
	<linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 06/11] md: avoid conflicts in active_aligned_reads
 operations
Thread-Topic: [PATCH 06/11] md: avoid conflicts in active_aligned_reads
 operations
Thread-Index: AQHahQix9h4wjYrA/ke63gQzkJ761bFZJ/ew
Date: Fri, 5 Apr 2024 05:37:17 +0000
Message-ID: <d843796bc3634fa691685ee63aa68357@kioxia.com>
References: <ffb112e756514a0eaab891379df0d834@kioxia.com>
 <a35d6b54-8e63-4b0b-be18-bb5ab7d12bdf@moroto.mountain>
In-Reply-To: <a35d6b54-8e63-4b0b-be18-bb5ab7d12bdf@moroto.mountain>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28298.001
x-tm-as-result: No-10--23.847800-8.000000
x-tmase-matchedrid: zwpC2WOSP9WmagT1k9kBpu5i6weAmSDKKQNhMboqZlo02EZLYIEwCyj5
	3aEB5qDLe+eZU8eiw0YjkzXjqrWT+yK2CVtnYH0ynVTWWiNp+v9uwUsg2ZgJ8QMn8l3DFl4Q8oG
	xyJMM48B7A20xaD5o5nBKGzyAWTMW9R7dwXny/be7LWwix27pUtOUg7tlBn3vStxxn32stFhjGq
	ZxQuvF5r2jand2PRF8QjRHotpINbQf0H3tYJmWPU2xVQmDwU6mwMc7ZZ8e7/c0DNPwjqLncPGG5
	PZMzxFoCpt1CXXJsmrhQDopaw5doU1QH6PUk2DD3QqJN4m15UGuLG21Eb4T8wZZ8N3RvTMxo8WM
	kQWv6iUDpAZ2/B/Blrew1twePJJB3QfwsVk0UbslCGssfkpInQ==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--23.847800-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28298.001
x-tm-snts-smtp: B85BA37545B82BF712B2F42B98231C28DF19BF716B56D57B32176A8C34120EBC2000:8
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB01.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB01.r1.kioxia.com

> Hi tada,
>=20
> kernel test robot noticed the following build warnings:
>=20
> url:
> https://github.com/intel-lab-lkp/linux/commits/tada-keisuke/md-add-infra-=
for-active_aligned_reads-changes/202403
> 26-201827
> base:   fcf3f7e2fc8a53a6140beee46ec782a4c88e4744
> patch link:    https://lore.kernel.org/r/ffb112e756514a0eaab891379df0d834=
%40kioxia.com
> patch subject: [PATCH 06/11] md: avoid conflicts in active_aligned_reads =
operations
> config: i386-randconfig-141-20240328
> (https://download.01.org/0day-ci/archive/20240331/202403312116.Sh5vFCWf-l=
kp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009=
708b4367171ccdbf4b5905cb6a803753fe18)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202403312116.Sh5vFCWf-lkp@intel.com/
>=20
> New smatch warnings:
> drivers/md/raid5.c:7680 setup_conf() warn: passing zero to 'ERR_PTR'
>=20
> vim +/ERR_PTR +7680 drivers/md/raid5.c

Thanks for reporting.
I forgot to keep the error code.
I will also fix another issue and submit v2.
https://marc.info/?l=3Dlinux-raid&m=3D171184328530325

Thanks,
Keisuke


