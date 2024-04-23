Return-Path: <linux-kernel+bounces-155374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEA28AE97E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCBBBB23CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B86513BAD7;
	Tue, 23 Apr 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUiclccI"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E1619470;
	Tue, 23 Apr 2024 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882668; cv=none; b=mvKSa9WvgJmAVR0njFVJu7mX6bMMBpcFaxqT49SeWkLfmLg48TrCKuiN2JSnuUaHnoXR0cuuzisTrcYKiaGBPkhtCF0xcnG5C1iXHYPD6wiTce7Xdh3x3RTPQ9/zNfiDi+Hg+lhrtZX5zD3xFKeLGy215BH6mdFpOXw6zra6Ip4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882668; c=relaxed/simple;
	bh=bDdVTHYMC6xp2ZNCjSU7RDVd7jmAAprTgZRLhUB6ohI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pn4AiJ8bHEVgP17kjUIZTmOvy/EsBSfbgOKAhCKQvCCmi1q64tOAKNpVIgrwLP+iaDkbm8B4BH5NmD8/97vfK+NCfGxYhByW+1DpLP19fAAnn46geJjhvVJFzX4GTk3S3lXui7INTQUa7Nfvu9Z7BEwRHkR7xE3yRkmUhLLQ20M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUiclccI; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c7498041cfso2461477b6e.2;
        Tue, 23 Apr 2024 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713882665; x=1714487465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4rogTfz1PuOKUeD658ovSxthpSU9NPMsbL72U+qc54=;
        b=QUiclccIG629MfQ+mtITsmrnuDziUV0HAfsJ1NeLEJY0ko4/KUwkwqekoImZTMcS8A
         O8S4sW0BpDAWQMOXLkJnIGg89Qt4lSHOyTSI5aaLgOQbJx5NrSHgUHKF7kztMJLbnxGZ
         SgktetJfZN+vwH/yRMzd8TCDDyokqFRHpoq0nrmru5V4PqgeTo+n13ykLJgP4/kzkvos
         FVWskpjLlrqE7x1OKq1L5gdzXnkTIo9Y4/zCTKkr78cXRSrTQJoOqTEzT7hETND28CLA
         IjUh5L4aY34l7uREdxt2j8jg2q0hwJpb1kMDgtbs9eaGDLZLJzCfzVWLLcqfVDiLmL9q
         wMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713882665; x=1714487465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4rogTfz1PuOKUeD658ovSxthpSU9NPMsbL72U+qc54=;
        b=LSH8FcxgQHxAXSNrBo7Xg6PuOcx0x876PzRTZ0VVF5NMLjNg4kb23bG30zvCQr6Wxk
         ly54oAQ5Pu5B02Q+z3zQbfqXIY4LohE2C1tP6+HKWh82XpRvW6oR66lIgk0syf3jlNVi
         hR2I+z3NWJbkCVM6uCy73EmttSPYtLZPrUwqCoXxg7WHuXK1I3N9rmWogn0zpop5Lnjo
         gboVx8cdzDDfGAXAi10ZF/IYi79+puNDvIjj3+4gtBXZoEgif/UZ12VhIUmzLhdQCYbt
         ixXVetg7eqfgrtWQjm3EwRs7TaUf3fk1jOscprwwoY6lKHhZpPP78d64qgJ8E6h3U/ap
         zF6w==
X-Forwarded-Encrypted: i=1; AJvYcCXhL/VZvqeI2/Ekiacp6eY0EllUbNBmO0Ts6VJSAW6xkU8kZsg0PbBoJN1pJ/Mt09CPOAIBd2uu6bjUdrTRaoqmqrWagVZouKlr/xtKmBOe8k39em8TAdLYiRG0s/eWM3y8MsZhEgJU0d/lYXBNAqIBKa8yXohMCcBRNUPJKuVZ9iJoGr3hS3gNx1CiVg==
X-Gm-Message-State: AOJu0YyF2Egj0gI83s49s5V1mLbkmTXTmP1L/WfW4uzwmJTZhYv00Fao
	4gWdWwyxBWKCMTYHSbh2ywXCzvN99i+oMoRAlzsCyWrNdH+e0z419WJ21W+2AQF3HDnlBvbtDA/
	Jvg8nV2iZelQrG2NQ5KH/+a7qBiM=
X-Google-Smtp-Source: AGHT+IHKJn3CRnTp/r2j8ypsLdO65kGG5yxh6I/FtmmzVjyJOFLk2w8F8hsAVweQIhWi+WTz1gbCQiGPJ47kueRm4wo=
X-Received: by 2002:a05:6808:124a:b0:3c7:51f:156c with SMTP id
 o10-20020a056808124a00b003c7051f156cmr18364959oiv.29.1713882663966; Tue, 23
 Apr 2024 07:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422150651.2908169-1-stefanb@linux.ibm.com>
 <CAOQ4uxgvHjU-n56ryOp5yWQF=yKz0Cfo0ZieypWJhqsBV4g-2w@mail.gmail.com> <a74b1c3c49b74aa6062c57bd99b48bdddc256ebf.camel@huaweicloud.com>
In-Reply-To: <a74b1c3c49b74aa6062c57bd99b48bdddc256ebf.camel@huaweicloud.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 23 Apr 2024 17:30:52 +0300
Message-ID: <CAOQ4uxitkN=Jchmp30RKGMVH-RDR5GGy-7J74vMQt0oecAK2bg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] ima: Fix detection of read/write violations on
 stacked filesystems
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zohar@linux.ibm.com, roberto.sassu@huawei.com, miklos@szeredi.hu, 
	brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 4:21=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Tue, 2024-04-23 at 09:02 +0300, Amir Goldstein wrote:
> > On Mon, Apr 22, 2024 at 6:07=E2=80=AFPM Stefan Berger <stefanb@linux.ib=
m.com> wrote:
> > >
> > > This series fixes the detection of read/write violations on stacked
> > > filesystems. To be able to access the relevant dentries necessary to
> > > detect files opened for writing on a stacked filesystem a new d_real_=
type
> > > D_REAL_FILEDATA is introduced that allows callers to access all relev=
ant
> > > files involved in a stacked filesystem while traversing the layers.
> > >
> >
> > Stefan,
> >
> > Both Miklos and myself objected to this solution:
> > https://lore.kernel.org/linux-unionfs/CAJfpeguctirEYECoigcAsJwpGPCX2Nyf=
MZ8H8GHGW-0UyKfjgg@mail.gmail.com/
> >
> > Not sure what you are hoping to achieve from re-posting the same soluti=
on.
> >
> > I stopped counting how many times I already argued that *all* IMA/EVM
> > assertions,
> > including rw-ro violations should be enforced only on the real inode.
>
> I have hopefully a better idea. We should detect violations at each
> level of the stack independently. And IMA should be invoked each time
> overlayfs uses an underlying layer.
>
> That is currently not easy, from the IMA policy perspective, because
> there are filesystem-specific rules, such as fsname=3D or fsuuid=3D. At t=
he
> moment, I'm not planning to solve this, but I'm thinking to use for
> example FMODE_BACKING to ignore the filesystem-specific keywords and
> match the rule anyway.
>
> For now, I'm only addressing the call to underlying layers. To make
> sure that IMA evaluates every layer, I added a rule that checks the
> inode UID:
>
> measure fowner=3D2000 mask=3DMAY_READ
>
>
> I just investigated a bit, and I made some changes (for now, I'm just
> making it work, and you tell me what you think).

I did not examine this up close, but this seems like a change in the right
direction.
Will need Christian's approval that this does not break any assumptions
made on backing files.

Thanks,
Amir.

>
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index 740185198db3..8016f62cf770 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -12,6 +12,7 @@
>  #include <linux/backing-file.h>
>  #include <linux/splice.h>
>  #include <linux/mm.h>
> +#include <linux/security.h>
>
>  #include "internal.h"
>
> @@ -40,12 +41,16 @@ struct file *backing_file_open(const struct path
> *user_path, int flags,
>         if (IS_ERR(f))
>                 return f;
>
> +       f->f_mode |=3D OPEN_FMODE(flags);
> +
>         path_get(user_path);
>         *backing_file_user_path(f) =3D *user_path;
>         error =3D vfs_open(real_path, f);
>         if (error) {
>                 fput(f);
>                 f =3D ERR_PTR(error);
> +       } else {
> +               security_file_post_open(f, ACC_MODE(flags));
>         }
>
>         return f;
>
>
> Setup:
>
> # mount -t overlay -olowerdir=3Da,upperdir=3Db,workdir=3Dc overlay d
>
> open is a tool with the following syntax:
>
> open <path> <perm>
>
> It performs the open, and waits for user input before closing the file.
>
>
>
> ToMToU (Time of Measurement - Time of Use):
>
> Same fs (overlayfs)
>
> # /root/open /root/test-dir/d/test-file r (terminal 1)
> # /root/open /root/test-dir/d/test-file w (terminal 2)
>
> This works:
>
> 10 35435d0858d895b90097306171a2e5fcc7f5da9e ima-ng sha256:0e4acf326a82c6b=
ded9d86f48d272d7a036b6490081bb6466ecc2a0e416b244a boot_aggregate
> 10 cef529d5d1032ffb6d3e2154664c83ba18cf2576 ima-ng sha256:f2ca1bb6c7e907d=
06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 test-file
> 10 694277487b9753db78446192231b59b7be7c03ad ima-ng sha256:f2ca1bb6c7e907d=
06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 /root/test-dir/d/test-fil=
e
> 10 0000000000000000000000000000000000000000 ima-ng sha256:000000000000000=
0000000000000000000000000000000000000000000000000 test-file
> 10 0000000000000000000000000000000000000000 ima-ng sha256:000000000000000=
0000000000000000000000000000000000000000000000000 /root/test-dir/d/test-fil=
e
>
> This is the result of calling IMA at both layers, and the violation of
> course happens twice.
>
> This is also confirmed in the logs:
>
> Apr 23 14:52:45 fedora audit[994]: INTEGRITY_PCR pid=3D994 uid=3D0 auid=
=3D0 ses=3D3 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 o=
p=3Dinvalid_pcr cause=3DToMToU comm=3D"open" name=3D"test-file" dev=3D"sda3=
" ino=3D995512 res=3D1 errno=3D0
> Apr 23 14:52:45 fedora audit[994]: INTEGRITY_PCR pid=3D994 uid=3D0 auid=
=3D0 ses=3D3 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 o=
p=3Dinvalid_pcr cause=3DToMToU comm=3D"open" name=3D"/root/test-dir/d/test-=
file" dev=3D"overlay" ino=3D995512 res=3D1 errno=3D0
>
>
> Different fs (overlayfs, btrfs)
>
> # /root/open /root/test-dir/d/test-file r (terminal 1)
> # /root/open /root/test-dir/b/test-file w (terminal 2)
>
> Again, this works despite the read is in overlayfs, and the write is in
> btrfs:
>
> 10 35435d0858d895b90097306171a2e5fcc7f5da9e ima-ng sha256:0e4acf326a82c6b=
ded9d86f48d272d7a036b6490081bb6466ecc2a0e416b244a boot_aggregate
> 10 cef529d5d1032ffb6d3e2154664c83ba18cf2576 ima-ng sha256:f2ca1bb6c7e907d=
06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 test-file
> 10 694277487b9753db78446192231b59b7be7c03ad ima-ng sha256:f2ca1bb6c7e907d=
06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 /root/test-dir/d/test-fil=
e
> 10 0000000000000000000000000000000000000000 ima-ng sha256:000000000000000=
0000000000000000000000000000000000000000000000000 /root/test-dir/b/test-fil=
e
>
> The difference from the previous example is that now there is only one
> violation, which is detected only in the upper layer. The logs have:
>
> Apr 23 15:01:15 fedora audit[985]: INTEGRITY_PCR pid=3D985 uid=3D0 auid=
=3D0 ses=3D3 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 o=
p=3Dinvalid_pcr cause=3DToMToU comm=3D"open" name=3D"/root/test-dir/b/test-=
file" dev=3D"sda3" ino=3D995512 res=3D1 errno=3D0
>
>
> Different fs (btrfs, overlayfs)
>
> # /root/open /root/test-dir/b/test-file r (terminal 2)
> # /root/open /root/test-dir/d/test-file w (terminal 1)
>
> 10 35435d0858d895b90097306171a2e5fcc7f5da9e ima-ng sha256:0e4acf326a82c6b=
ded9d86f48d272d7a036b6490081bb6466ecc2a0e416b244a boot_aggregate
> 10 d7a692e19158820d2755542a8d31b49ac7ac2729 ima-ng sha256:f2ca1bb6c7e907d=
06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 /root/test-dir/b/test-fil=
e
> 10 0000000000000000000000000000000000000000 ima-ng sha256:000000000000000=
0000000000000000000000000000000000000000000000000 test-file
>
> Works too. There is only one measurement, since that is done only for
> the upper layer.
>
> Apr 23 15:05:40 fedora audit[982]: INTEGRITY_PCR pid=3D982 uid=3D0 auid=
=3D0 ses=3D1 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 o=
p=3Dinvalid_pcr cause=3DToMToU comm=3D"open" name=3D"test-file" dev=3D"sda3=
" ino=3D995512 res=3D1 errno=3D0
>
>
>
> Open writers
>
> Same fs (overlayfs)
>
> # /root/open /root/test-dir/d/test-file w (terminal 1)
> # /root/open /root/test-dir/d/test-file r (terminal 2)
>
> 10 35435d0858d895b90097306171a2e5fcc7f5da9e ima-ng sha256:0e4acf326a82c6b=
ded9d86f48d272d7a036b6490081bb6466ecc2a0e416b244a boot_aggregate
> 10 0000000000000000000000000000000000000000 ima-ng sha256:000000000000000=
0000000000000000000000000000000000000000000000000 test-file
> 10 cef529d5d1032ffb6d3e2154664c83ba18cf2576 ima-ng sha256:f2ca1bb6c7e907d=
06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 test-file
> 10 0000000000000000000000000000000000000000 ima-ng sha256:000000000000000=
0000000000000000000000000000000000000000000000000 /root/test-dir/d/test-fil=
e
> 10 694277487b9753db78446192231b59b7be7c03ad ima-ng sha256:f2ca1bb6c7e907d=
06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 /root/test-dir/d/test-fil=
e
>
> Apr 23 15:10:46 fedora audit[983]: INTEGRITY_PCR pid=3D983 uid=3D0 auid=
=3D0 ses=3D3 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 o=
p=3Dinvalid_pcr cause=3Dopen_writers comm=3D"open" name=3D"test-file" dev=
=3D"sda3" ino=3D995512 res=3D1 errno=3D0
> Apr 23 15:10:46 fedora audit[983]: INTEGRITY_PCR pid=3D983 uid=3D0 auid=
=3D0 ses=3D3 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 o=
p=3Dinvalid_pcr cause=3Dopen_writers comm=3D"open" name=3D"/root/test-dir/d=
/test-file" dev=3D"overlay" ino=3D995512 res=3D1 errno=3D0
>
>
> Different fs (overlayfs, btrfs)
>
> # /root/open /root/test-dir/d/test-file w (terminal 1)
> # /root/open /root/test-dir/b/test-file r (terminal 2)
>
> 10 35435d0858d895b90097306171a2e5fcc7f5da9e ima-ng sha256:0e4acf326a82c6b=
ded9d86f48d272d7a036b6490081bb6466ecc2a0e416b244a boot_aggregate
> 10 0000000000000000000000000000000000000000 ima-ng sha256:000000000000000=
0000000000000000000000000000000000000000000000000 /root/test-dir/b/test-fil=
e
> 10 d7a692e19158820d2755542a8d31b49ac7ac2729 ima-ng sha256:f2ca1bb6c7e907d=
06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 /root/test-dir/b/test-fil=
e
>
> Apr 23 15:12:58 fedora audit[984]: INTEGRITY_PCR pid=3D984 uid=3D0 auid=
=3D0 ses=3D3 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 o=
p=3Dinvalid_pcr cause=3Dopen_writers comm=3D"open" name=3D"/root/test-dir/b=
/test-file" dev=3D"sda3" ino=3D995512 res=3D1 errno=3D0
>
>
> Different fs (btrfs, overlayfs)
>
> # /root/open /root/test-dir/b/test-file w (terminal 1)
> # /root/open /root/test-dir/d/test-file r (terminal 2)
>
> 10 35435d0858d895b90097306171a2e5fcc7f5da9e ima-ng sha256:0e4acf326a82c6b=
ded9d86f48d272d7a036b6490081bb6466ecc2a0e416b244a boot_aggregate
> 10 0000000000000000000000000000000000000000 ima-ng sha256:000000000000000=
0000000000000000000000000000000000000000000000000 test-file
> 10 cef529d5d1032ffb6d3e2154664c83ba18cf2576 ima-ng sha256:f2ca1bb6c7e907d=
06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 test-file
> 10 694277487b9753db78446192231b59b7be7c03ad ima-ng sha256:f2ca1bb6c7e907d=
06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 /root/test-dir/d/test-fil=
e
>
> Apr 23 15:16:37 fedora audit[983]: INTEGRITY_PCR pid=3D983 uid=3D0 auid=
=3D0 ses=3D3 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 o=
p=3Dinvalid_pcr cause=3Dopen_writers comm=3D"open" name=3D"test-file" dev=
=3D"sda3" ino=3D995512 res=3D1 errno=3D0
>
> Roberto
>
> > I know this does not work - so you should find out why it does not work=
 and fix
> > the problem.
> >
> > Enforcing IMA/EVM on the overlayfs inode layer is just the wrong way IM=
O.
> > Not once have I heard an argument from IMA/EVM developers why it is rea=
lly
> > needed to enforce IMA/EVM on the overlayfs inode layer and not on the
> > real inode.
> > I am sorry that we are failing to communicate on this matter, but I am =
not
> > sure how else I can help.
> >
> > Thanks,
> > Amir.
>

