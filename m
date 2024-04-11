Return-Path: <linux-kernel+bounces-140403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693A88A13F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACAE1C20924
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDB814AD31;
	Thu, 11 Apr 2024 12:05:54 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035CA1442FF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837153; cv=none; b=RETMjlkg9nk9dHKWf6BEtUmKziALjILPlC4eU6HqhAN6Cginw5m7H8RFP+v5+U+LaFNh3xaR9iPmMxfqwI4cAMOHHj0bT8VftKyhck27cl8CbEqYKMyyHamyRHmuz+2mIj3BdtpTZhhnbYCMcfBSDK7oUUHAQhTqU/BTGWlg7XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837153; c=relaxed/simple;
	bh=HdYNqVCEe0x2X0F2EaUSXwNmY01gm1OpopI72QHOmK0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yh8Q4PmFK1WC0f3WNU01QeNJ89YRBhCruDc/dKeHI74f062GZBPTfk8kTE00YwCf419LW/AQbG8sZPCSBG3Xu47KS3qJPrAbzjqTQBXnraNhxbEBz6XKyD8SJ7AOz/21YGgSOmUqeoahYco+KtBDtUlaKJKeF2OtJWaTKQwECNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VFdcm0dhXz1R5XH;
	Thu, 11 Apr 2024 20:03:04 +0800 (CST)
Received: from kwepemd100010.china.huawei.com (unknown [7.221.188.107])
	by mail.maildlp.com (Postfix) with ESMTPS id B2D16140EA2;
	Thu, 11 Apr 2024 20:05:48 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd100010.china.huawei.com (7.221.188.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 11 Apr 2024 20:05:48 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.028;
 Thu, 11 Apr 2024 20:05:48 +0800
From: duchangbin <changbin.du@huawei.com>
To: duchangbin <changbin.du@huawei.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/cputime: remove unused vtime_account_kernel
Thread-Topic: [PATCH] sched/cputime: remove unused vtime_account_kernel
Thread-Index: AQHajAKDIkVvBXkJoUKksEBvgpwDs7Fi+RMA
Date: Thu, 11 Apr 2024 12:05:48 +0000
Message-ID: <b1befac0501944919cd99f20c4bcecaa@huawei.com>
References: <20240411112212.2061899-1-changbin.du@huawei.com>
In-Reply-To: <20240411112212.2061899-1-changbin.du@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemd100011.china.huawei.com (15.02.1258.028)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="us-ascii"
Content-ID: <02E6C0AB2AB5CE48B135099171E224ED@huawei.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

The vtime_account_idle() can also be removed. Will update this change.

On Thu, Apr 11, 2024 at 07:22:12PM +0800, Changbin Du wrote:
> This removes the vtime_account_kernel() function in generic vtime
> accounting. It's never used anymore.
>=20
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  kernel/sched/cputime.c | 12 ------------
>  1 file changed, 12 deletions(-)
>=20
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index af7952f12e6c..29320e66abdc 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -709,18 +709,6 @@ static void __vtime_account_kernel(struct task_struc=
t *tsk,
>  		vtime_account_system(tsk, vtime);
>  }
> =20
> -void vtime_account_kernel(struct task_struct *tsk)
> -{
> -	struct vtime *vtime =3D &tsk->vtime;
> -
> -	if (!vtime_delta(vtime))
> -		return;
> -
> -	write_seqcount_begin(&vtime->seqcount);
> -	__vtime_account_kernel(tsk, vtime);
> -	write_seqcount_end(&vtime->seqcount);
> -}
> -
>  void vtime_user_enter(struct task_struct *tsk)
>  {
>  	struct vtime *vtime =3D &tsk->vtime;
> --=20
> 2.34.1
>=20

--=20
Cheers,
Changbin Du

