Return-Path: <linux-kernel+bounces-38190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0833683BC3A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 814AFB22215
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D5D1B953;
	Thu, 25 Jan 2024 08:45:03 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457B01FAD;
	Thu, 25 Jan 2024 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706172303; cv=none; b=isOspVrZ7rnO5EF6cauVWKePIbuqN4TFuf1A6F2zw+EHfHlZ6iqKM0qMWkdfoMZeQb2N/tG3+fj4ZECH7vGE4rJFzoOVOun/FQNFTA4NghsjGi35lNsCjtsLHUMx2JHecTh0puKYKPPeRfsRmAGgOETtwyrfgZN8fflkRnSsJYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706172303; c=relaxed/simple;
	bh=e1lLytdE3esV+q2A+H5apNBmQXAGgQaQISQJyeKhApA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fJnNLNBvuEMbNg+Shu8gwjWq0sjofmjuGfSYX45+L+VrEHpvajmRTP3eZ5Tl3QhZNWTr7bwK9nN2+6gWe1ZqEtu/n5HyN7UufCm8OfEosGDwYI+n+MHMLfxHIXaQfb/CAk4t10e3BvcYquIyo2MKtGj5hQ9eeHqHa1mtCHqGeGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TLDSC0ZCRz9v7cf;
	Thu, 25 Jan 2024 16:26:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id D3AB614073E;
	Thu, 25 Jan 2024 16:44:44 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXzhdzH7Jlaks4AQ--.36602S2;
	Thu, 25 Jan 2024 09:44:44 +0100 (CET)
Message-ID: <765e8c790f8521556dc6ce577529f71820494b8a.camel@huaweicloud.com>
Subject: Re: [PATCH v3 0/5] Smack transmute fixes
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com, 
 jmorris@namei.org, serge@hallyn.com, Hugh Dickins <hughd@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Date: Thu, 25 Jan 2024 09:44:32 +0100
In-Reply-To: <53897379-0c7a-4da7-870c-1eb7e822a129@schaufler-ca.com>
References: <20231116090125.187209-1-roberto.sassu@huaweicloud.com>
	 <53897379-0c7a-4da7-870c-1eb7e822a129@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDXzhdzH7Jlaks4AQ--.36602S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1ftFyrCry3Xr1Duw4rZrb_yoW5uFy3pF
	Zava4akr4ktF97Cr1Sgws8WF4SkayfCrWUJrsxJrn7AF1DAF1Fvr4xt3W5Ca4kXr43CryS
	qw47Zr9xWrn8ArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQANBF1jj5jsBQAAsI

On Wed, 2024-01-24 at 14:31 -0800, Casey Schaufler wrote:
> On 11/16/2023 1:01 AM, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > The first two patches are obvious fixes, the first restricts setting th=
e
> > SMACK64TRANSMUTE xattr only for directories, and the second makes it
> > possible to set SMACK64TRANSMUTE if the filesystem does not support xat=
trs
> > (e.g. ramfs).
> >=20
> > The remaining fixes are optional, and only required if we want filesyst=
ems
> > without xattr support behave like those with xattr support. Since we ha=
ve
> > the inode_setsecurity and inode_getsecurity hooks to make the first gro=
up
> > work, it seems useful to fix inode creation too (SELinux should be fine=
).
> >=20
> > The third patch is merely a code move out of the 'if (xattr)' condition=
.
> > The fourth updates the security field of the in-memory inode directly i=
n
> > smack_inode_init_security() and marks the inode as instantiated,
>=20
> I have taken patches 1-4 in smack-next. I'm still waiting on a convincing
> approval for patch 5.

Thanks Casey. I also hope to receive an Ack from the maintainers.

Roberto


> >  and the
> > fifth adds a security_inode_init_security() call in ramfs to initialize=
 the
> > security field of the in-memory inodes (needed to test transmuting
> > directories).
> >=20
> > Both the Smack (on xfs) and IMA test suite succeed with all patches
> > applied. Tests were not executed on v3 (trivial changes).
> >=20
> > By executing the tests in a ramfs, the results are:
> >=20
> > Without the patches:
> > 86 Passed, 9 Failed, 90% Success rate
> >=20
> > With the patches:
> > 93 Passed, 2 Failed, 97% Success rate
> >=20
> > The remaining two failures are:
> > 2151  ioctl(4, BTRFS_IOC_CLONE or FICLONE, 3) =3D -1 EOPNOTSUPP (Operat=
ion not supported)
> > 2152  lsetxattr("./targets/proc-attr-Snap", "security.SMACK64EXEC", "Po=
p", 3, 0) =3D -1 EOPNOTSUPP (Operation not supported)
> >=20
> > The first one is likely due ramfs lack of support for ioctl() while the
> > second could be fixed by handling SMACK64EXEC in smack_inode_setsecurit=
y().
> >=20
> > The patch set applies on top of lsm/dev, commit e246777e2a03 ("MAINTAIN=
ERS:
> > update the LSM entry").
> >=20
> > The ramfs patch potentially could be useful to correctly initialize the
> > label of new inodes in the initramfs, assuming that it will be fully
> > labeled with support for xattrs in the cpio image:
> >=20
> > https://lore.kernel.org/linux-integrity/20190523121803.21638-1-roberto.=
sassu@huawei.com/
> >=20
> > Ramfs inode labels will be set from xattrs with the inode_setsecurity h=
ook.
> >=20
> > Changelog
> >=20
> > v2:
> > - Replace return with goto in the ramfs patch, for better maintainabili=
ty
> >   (suggested by Andrew Morton)
> >=20
> > v1:
> > - Rebase on top of latest lsm/next
> > - Remove -EOPNOTSUPP check in patch 5 (cannot happen)
> >=20
> > Roberto Sassu (5):
> >   smack: Set SMACK64TRANSMUTE only for dirs in smack_inode_setxattr()
> >   smack: Handle SMACK64TRANSMUTE in smack_inode_setsecurity()
> >   smack: Always determine inode labels in smack_inode_init_security()
> >   smack: Initialize the in-memory inode in smack_inode_init_security()
> >   ramfs: Initialize security of in-memory inodes
> >=20
> >  fs/ramfs/inode.c           | 32 ++++++++++++-
> >  security/smack/smack_lsm.c | 95 ++++++++++++++++++++++----------------
> >  2 files changed, 86 insertions(+), 41 deletions(-)
> >=20


