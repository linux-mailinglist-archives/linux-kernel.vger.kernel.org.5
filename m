Return-Path: <linux-kernel+bounces-158448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A558B2048
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C61E1C23361
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9CB12C465;
	Thu, 25 Apr 2024 11:30:34 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E472412BF2B;
	Thu, 25 Apr 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044634; cv=none; b=kPHNlZkJXhu/phhZYD2vcNlbGVXqWiimf6AmHK5fsw2M/LOr92T7ZlDFnM6yxsfCWOdcl8h+Qz+ZvSCnRd007XTLRspla56cY3LFhhc7FKTtX5XhqwJW/F8ymzVg4KhJbJkllIs5/7m/l+h9xnUQ04Rw7u/ggcRk3ZyFF7cpQQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044634; c=relaxed/simple;
	bh=LgoIlQ5T90IHkhHEerbeuXbXygpVsEigqFOVt7bxvEI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZRNSGwyahRjG5caaqiNgyL9922YpGHPYQcCOYu9ZbKOy+SHz5GUYAoxumAPArif4tNZAsQT9Hj4RLhOlVOsJzxwN8utfIMyCERp25Iyw0PSCPjKbvg9atg+OIfKZ7kKeJ8ELUsrUEixpgM4LY47WuTQKYVOJRXwLEFGTFD1J6ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VQCsL3yysz9v7gh;
	Thu, 25 Apr 2024 19:13:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id A9C811406BF;
	Thu, 25 Apr 2024 19:30:19 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAXTSHAPipmeWvpBg--.45375S2;
	Thu, 25 Apr 2024 12:30:18 +0100 (CET)
Message-ID: <a8da6b9f57095be494b8c38ca46e2a102b8eafac.camel@huaweicloud.com>
Subject: Re: [RFC PATCH v2 0/2] ima: Fix detection of read/write violations
 on stacked filesystems
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Amir Goldstein <amir73il@gmail.com>, Stefan Berger
 <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
 roberto.sassu@huawei.com,  miklos@szeredi.hu, brauner@kernel.org
Date: Thu, 25 Apr 2024 13:30:04 +0200
In-Reply-To: <CAOQ4uxgvHjU-n56ryOp5yWQF=yKz0Cfo0ZieypWJhqsBV4g-2w@mail.gmail.com>
References: <20240422150651.2908169-1-stefanb@linux.ibm.com>
	 <CAOQ4uxgvHjU-n56ryOp5yWQF=yKz0Cfo0ZieypWJhqsBV4g-2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAXTSHAPipmeWvpBg--.45375S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1UGr1fAw1kCFykAFykAFb_yoW8trWDpa
	yruFZFk3s0qFy2qr92y3WUXF1rZws8AFWUZ34j934UZFy5ur9IvrWSk34Yq342yFZ5WryF
	qa9FqFykZr1DA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBF1jj5zK0wABs0

On Tue, 2024-04-23 at 09:02 +0300, Amir Goldstein wrote:
> On Mon, Apr 22, 2024 at 6:07=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.=
com> wrote:
> >=20
> > This series fixes the detection of read/write violations on stacked
> > filesystems. To be able to access the relevant dentries necessary to
> > detect files opened for writing on a stacked filesystem a new d_real_ty=
pe
> > D_REAL_FILEDATA is introduced that allows callers to access all relevan=
t
> > files involved in a stacked filesystem while traversing the layers.
> >=20
>=20
> Stefan,
>=20
> Both Miklos and myself objected to this solution:
> https://lore.kernel.org/linux-unionfs/CAJfpeguctirEYECoigcAsJwpGPCX2NyfMZ=
8H8GHGW-0UyKfjgg@mail.gmail.com/
>=20
> Not sure what you are hoping to achieve from re-posting the same solution=
.
>=20
> I stopped counting how many times I already argued that *all* IMA/EVM
> assertions,
> including rw-ro violations should be enforced only on the real inode.
> I know this does not work - so you should find out why it does not work a=
nd fix
> the problem.
>=20
> Enforcing IMA/EVM on the overlayfs inode layer is just the wrong way IMO.
> Not once have I heard an argument from IMA/EVM developers why it is reall=
y
> needed to enforce IMA/EVM on the overlayfs inode layer and not on the
> real inode.

Ok, I try to provide an example regarding this, and we see if it makes
sense.

# echo test > test-file
# chown 2000 d/test-file
# ls -l a/test-file
-rw-r--r--. 1 2000 root 25 Apr 25 10:50 a/test-file

Initially there is a file in the lower layer with UID 2000.


# mount -t overlay -olowerdir=3Da,upperdir=3Db,workdir=3Dc,metacopy=3Don ov=
erlay d
# chown 3000 d/test-file
# ls -l d/test-file
-rw-r--r--. 1 3000 root 25 Apr 25 10:50 d/test-file
# ls -l a/test-file
-rw-r--r--. 1 2000 root 25 Apr 25 10:50 a/test-file
# ls -l b/test-file
-rw-r--r--. 1 3000 root 25 Apr 25 10:50 b/test-file

If I have a policy like this:

# echo "measure fsname=3Doverlay fowner=3D3000" > /sys/kernel/security/ima/=
policy

there won't be any match on the real file which still has UID 2000. But
what is observable by the processes through overlayfs is UID 3000.

Roberto

> I am sorry that we are failing to communicate on this matter, but I am no=
t
> sure how else I can help.
>=20
> Thanks,
> Amir.


