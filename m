Return-Path: <linux-kernel+bounces-155272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC228AE7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14062B26A50
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43997135416;
	Tue, 23 Apr 2024 13:21:22 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11B6136E16;
	Tue, 23 Apr 2024 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878481; cv=none; b=jqg+Xn1Iv9e6P+eRTMechAh9VL/e51RUR1Gpz9vwKBnzRTAHmXpyiYnDv90pzyQTp6YhAweWuGxXk4FTRbMEROnrHe6P1jSlQNEga+xXLpKnBG0VcfuLY5/KpJPVj6yHYmO3EGWV8vISNS0zYduTGQvbXENH29lj4pnyhyGAihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878481; c=relaxed/simple;
	bh=UNQ179A3uNx1Z+YCWoQcxKHTSEKRUUeDsQHAMZSJzNU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HWoDzWqjrPzkwKikr2RyXoM6wcfYCobykoRHfPlyzBMimwdRT4nkQ/XMAeu07Pbwi0fXJKS3D5m9fUVwZRkfqSDB7amcFCZVmEYdMx1klIaikECTgMeke8QKO7v1jG+2B+AlPiGac9CSPjPktzA0dbJesGSLfePQGmaRDQTqlk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VP2Jz43lyz9xtSH;
	Tue, 23 Apr 2024 21:00:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 331DE140429;
	Tue, 23 Apr 2024 21:21:01 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBXShOwtSdmxNXQBg--.39207S2;
	Tue, 23 Apr 2024 14:20:58 +0100 (CET)
Message-ID: <a74b1c3c49b74aa6062c57bd99b48bdddc256ebf.camel@huaweicloud.com>
Subject: Re: [RFC PATCH v2 0/2] ima: Fix detection of read/write violations
 on stacked filesystems
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Amir Goldstein <amir73il@gmail.com>, Stefan Berger
 <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
 roberto.sassu@huawei.com,  miklos@szeredi.hu, brauner@kernel.org
Date: Tue, 23 Apr 2024 15:20:44 +0200
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
X-CM-TRANSID:LxC2BwBXShOwtSdmxNXQBg--.39207S2
X-Coremail-Antispam: 1UD129KBjvJXoW3CFy3ZrWDtFyDAr1kCFykXwb_yoWDurW3pr
	n8tFWDKr48tF17Gr15Jr1UXF17Ar1DAFyUGF15ua4xXF98Grn5Zr4jyry3tw17Ars8ur1a
	yanrXryaqr1UA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgACBF1jj5i3nwAAsF

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

I have hopefully a better idea. We should detect violations at each
level of the stack independently. And IMA should be invoked each time
overlayfs uses an underlying layer.

That is currently not easy, from the IMA policy perspective, because
there are filesystem-specific rules, such as fsname=3D or fsuuid=3D. At the
moment, I'm not planning to solve this, but I'm thinking to use for
example FMODE_BACKING to ignore the filesystem-specific keywords and
match the rule anyway.

For now, I'm only addressing the call to underlying layers. To make
sure that IMA evaluates every layer, I added a rule that checks the
inode UID:

measure fowner=3D2000 mask=3DMAY_READ


I just investigated a bit, and I made some changes (for now, I'm just
making it work, and you tell me what you think).

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 740185198db3..8016f62cf770 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -12,6 +12,7 @@
 #include <linux/backing-file.h>
 #include <linux/splice.h>
 #include <linux/mm.h>
+#include <linux/security.h>
=20
 #include "internal.h"
=20
@@ -40,12 +41,16 @@ struct file *backing_file_open(const struct path
*user_path, int flags,
        if (IS_ERR(f))
                return f;
=20
+       f->f_mode |=3D OPEN_FMODE(flags);
+
        path_get(user_path);
        *backing_file_user_path(f) =3D *user_path;
        error =3D vfs_open(real_path, f);
        if (error) {
                fput(f);
                f =3D ERR_PTR(error);
+       } else {
+               security_file_post_open(f, ACC_MODE(flags));
        }
=20
        return f;


Setup:

# mount -t overlay -olowerdir=3Da,upperdir=3Db,workdir=3Dc overlay d

open is a tool with the following syntax:

open <path> <perm>

It performs the open, and waits for user input before closing the file.



ToMToU (Time of Measurement - Time of Use):

Same fs (overlayfs)

# /root/open /root/test-dir/d/test-file r (terminal 1)
# /root/open /root/test-dir/d/test-file w (terminal 2)

This works:

10 35435d0858d895b90097306171a2e5fcc7f5da9e ima-ng sha256:0e4acf326a82c6bde=
d9d86f48d272d7a036b6490081bb6466ecc2a0e416b244a boot_aggregate
10 cef529d5d1032ffb6d3e2154664c83ba18cf2576 ima-ng sha256:f2ca1bb6c7e907d06=
dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 test-file
10 694277487b9753db78446192231b59b7be7c03ad ima-ng sha256:f2ca1bb6c7e907d06=
dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 /root/test-dir/d/test-file
10 0000000000000000000000000000000000000000 ima-ng sha256:00000000000000000=
00000000000000000000000000000000000000000000000 test-file
10 0000000000000000000000000000000000000000 ima-ng sha256:00000000000000000=
00000000000000000000000000000000000000000000000 /root/test-dir/d/test-file

This is the result of calling IMA at both layers, and the violation of
course happens twice.

This is also confirmed in the logs:

Apr 23 14:52:45 fedora audit[994]: INTEGRITY_PCR pid=3D994 uid=3D0 auid=3D0=
 ses=3D3 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=3D=
invalid_pcr cause=3DToMToU comm=3D"open" name=3D"test-file" dev=3D"sda3" in=
o=3D995512 res=3D1 errno=3D0
Apr 23 14:52:45 fedora audit[994]: INTEGRITY_PCR pid=3D994 uid=3D0 auid=3D0=
 ses=3D3 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=3D=
invalid_pcr cause=3DToMToU comm=3D"open" name=3D"/root/test-dir/d/test-file=
" dev=3D"overlay" ino=3D995512 res=3D1 errno=3D0


Different fs (overlayfs, btrfs)

# /root/open /root/test-dir/d/test-file r (terminal 1)
# /root/open /root/test-dir/b/test-file w (terminal 2)

Again, this works despite the read is in overlayfs, and the write is in
btrfs:

10 35435d0858d895b90097306171a2e5fcc7f5da9e ima-ng sha256:0e4acf326a82c6bde=
d9d86f48d272d7a036b6490081bb6466ecc2a0e416b244a boot_aggregate
10 cef529d5d1032ffb6d3e2154664c83ba18cf2576 ima-ng sha256:f2ca1bb6c7e907d06=
dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 test-file
10 694277487b9753db78446192231b59b7be7c03ad ima-ng sha256:f2ca1bb6c7e907d06=
dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 /root/test-dir/d/test-file
10 0000000000000000000000000000000000000000 ima-ng sha256:00000000000000000=
00000000000000000000000000000000000000000000000 /root/test-dir/b/test-file

The difference from the previous example is that now there is only one
violation, which is detected only in the upper layer. The logs have:

Apr 23 15:01:15 fedora audit[985]: INTEGRITY_PCR pid=3D985 uid=3D0 auid=3D0=
 ses=3D3 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=3D=
invalid_pcr cause=3DToMToU comm=3D"open" name=3D"/root/test-dir/b/test-file=
" dev=3D"sda3" ino=3D995512 res=3D1 errno=3D0


Different fs (btrfs, overlayfs)

# /root/open /root/test-dir/b/test-file r (terminal 2)
# /root/open /root/test-dir/d/test-file w (terminal 1)

10 35435d0858d895b90097306171a2e5fcc7f5da9e ima-ng sha256:0e4acf326a82c6bde=
d9d86f48d272d7a036b6490081bb6466ecc2a0e416b244a boot_aggregate
10 d7a692e19158820d2755542a8d31b49ac7ac2729 ima-ng sha256:f2ca1bb6c7e907d06=
dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 /root/test-dir/b/test-file
10 0000000000000000000000000000000000000000 ima-ng sha256:00000000000000000=
00000000000000000000000000000000000000000000000 test-file

Works too. There is only one measurement, since that is done only for
the upper layer.

Apr 23 15:05:40 fedora audit[982]: INTEGRITY_PCR pid=3D982 uid=3D0 auid=3D0=
 ses=3D1 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=3D=
invalid_pcr cause=3DToMToU comm=3D"open" name=3D"test-file" dev=3D"sda3" in=
o=3D995512 res=3D1 errno=3D0



Open writers

Same fs (overlayfs)

# /root/open /root/test-dir/d/test-file w (terminal 1)
# /root/open /root/test-dir/d/test-file r (terminal 2)

10 35435d0858d895b90097306171a2e5fcc7f5da9e ima-ng sha256:0e4acf326a82c6bde=
d9d86f48d272d7a036b6490081bb6466ecc2a0e416b244a boot_aggregate
10 0000000000000000000000000000000000000000 ima-ng sha256:00000000000000000=
00000000000000000000000000000000000000000000000 test-file
10 cef529d5d1032ffb6d3e2154664c83ba18cf2576 ima-ng sha256:f2ca1bb6c7e907d06=
dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 test-file
10 0000000000000000000000000000000000000000 ima-ng sha256:00000000000000000=
00000000000000000000000000000000000000000000000 /root/test-dir/d/test-file
10 694277487b9753db78446192231b59b7be7c03ad ima-ng sha256:f2ca1bb6c7e907d06=
dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 /root/test-dir/d/test-file

Apr 23 15:10:46 fedora audit[983]: INTEGRITY_PCR pid=3D983 uid=3D0 auid=3D0=
 ses=3D3 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=3D=
invalid_pcr cause=3Dopen_writers comm=3D"open" name=3D"test-file" dev=3D"sd=
a3" ino=3D995512 res=3D1 errno=3D0
Apr 23 15:10:46 fedora audit[983]: INTEGRITY_PCR pid=3D983 uid=3D0 auid=3D0=
 ses=3D3 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=3D=
invalid_pcr cause=3Dopen_writers comm=3D"open" name=3D"/root/test-dir/d/tes=
t-file" dev=3D"overlay" ino=3D995512 res=3D1 errno=3D0


Different fs (overlayfs, btrfs)

# /root/open /root/test-dir/d/test-file w (terminal 1)
# /root/open /root/test-dir/b/test-file r (terminal 2)

10 35435d0858d895b90097306171a2e5fcc7f5da9e ima-ng sha256:0e4acf326a82c6bde=
d9d86f48d272d7a036b6490081bb6466ecc2a0e416b244a boot_aggregate
10 0000000000000000000000000000000000000000 ima-ng sha256:00000000000000000=
00000000000000000000000000000000000000000000000 /root/test-dir/b/test-file
10 d7a692e19158820d2755542a8d31b49ac7ac2729 ima-ng sha256:f2ca1bb6c7e907d06=
dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 /root/test-dir/b/test-file

Apr 23 15:12:58 fedora audit[984]: INTEGRITY_PCR pid=3D984 uid=3D0 auid=3D0=
 ses=3D3 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=3D=
invalid_pcr cause=3Dopen_writers comm=3D"open" name=3D"/root/test-dir/b/tes=
t-file" dev=3D"sda3" ino=3D995512 res=3D1 errno=3D0


Different fs (btrfs, overlayfs)

# /root/open /root/test-dir/b/test-file w (terminal 1)
# /root/open /root/test-dir/d/test-file r (terminal 2)

10 35435d0858d895b90097306171a2e5fcc7f5da9e ima-ng sha256:0e4acf326a82c6bde=
d9d86f48d272d7a036b6490081bb6466ecc2a0e416b244a boot_aggregate
10 0000000000000000000000000000000000000000 ima-ng sha256:00000000000000000=
00000000000000000000000000000000000000000000000 test-file
10 cef529d5d1032ffb6d3e2154664c83ba18cf2576 ima-ng sha256:f2ca1bb6c7e907d06=
dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 test-file
10 694277487b9753db78446192231b59b7be7c03ad ima-ng sha256:f2ca1bb6c7e907d06=
dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 /root/test-dir/d/test-file

Apr 23 15:16:37 fedora audit[983]: INTEGRITY_PCR pid=3D983 uid=3D0 auid=3D0=
 ses=3D3 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=3D=
invalid_pcr cause=3Dopen_writers comm=3D"open" name=3D"test-file" dev=3D"sd=
a3" ino=3D995512 res=3D1 errno=3D0

Roberto

> I know this does not work - so you should find out why it does not work a=
nd fix
> the problem.
>=20
> Enforcing IMA/EVM on the overlayfs inode layer is just the wrong way IMO.
> Not once have I heard an argument from IMA/EVM developers why it is reall=
y
> needed to enforce IMA/EVM on the overlayfs inode layer and not on the
> real inode.
> I am sorry that we are failing to communicate on this matter, but I am no=
t
> sure how else I can help.
>=20
> Thanks,
> Amir.


