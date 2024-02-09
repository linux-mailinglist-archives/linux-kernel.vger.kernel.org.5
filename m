Return-Path: <linux-kernel+bounces-59378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C3984F616
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC720283B18
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AFE2E652;
	Fri,  9 Feb 2024 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEOyf1O2"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE7538388;
	Fri,  9 Feb 2024 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485850; cv=none; b=WAnofjBpe84yYaaDcBCrbQVCZ1gib/7xznAdocn+JHfMQSZsHSSwWrkpIZgr6T/lyVtfr7qQVbQ/y+3WB9kwsH117dAAYuwOFT7j0Ta/kPVL+MbQiC7E8T2vRQgiHv/lX8bttmtbO3oTdeFXkyswAU2WXU2e5XMMUBwpabpOitY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485850; c=relaxed/simple;
	bh=nCDRSi5fuNvnVfeHvc8gHPOlDxG9J2HzLW0aZ3aJDpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4unWMyMzn/JxC3ag4Zu9JR8yImrVa+vJKYNG2TRyLYkntf7r1qaC9mqhKw3vPgetoius7TWFTLyB330FBqLJBbrtA1+s7Izr3M8YhWMYEtl5kdP9rq31sEAXmmUer/KqbLmaNh6dmJIh9KLUSHrE2atYP05f2OUALDXF3MQ0vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEOyf1O2; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d0d95e8133so11945461fa.1;
        Fri, 09 Feb 2024 05:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707485847; x=1708090647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdMFIWsVbpXKdg1uzGMEB3Krt6UJuq96Wxd52+lxyAY=;
        b=aEOyf1O2I80HuN8uhANUeGzZO+bByLsMGnnL17UU1DTudsU8pivFVFnhtk/ugnBBbC
         1TViBgsUXjdublMpw/yG+xgJH9o2M5NCqrW1cBhjL5wYiDLcUxZQZorJGHnnGQosRxgu
         JJapmlErclH+tFT80uvezW87cThWKiOqg95luI8A5YO8nIPVEod2DEynuWBNPnUH6g2b
         WaCCnbWVvdaqByNAf2kiRqiQfW3JdX8ynN5p0V5GO9GIYTaxR2BcfxTkxjWs3A+gmsve
         6hZ3eJHZNgjf90um1E9xGWRGYRHZHSdlNoHtrC1PR3FDncA26w/PIfK1ZgEveO9uEQiw
         1jfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707485847; x=1708090647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdMFIWsVbpXKdg1uzGMEB3Krt6UJuq96Wxd52+lxyAY=;
        b=vWvFZrCF5yz3ohtHtH2yYBlCcY2DJatHeKxj27539Yl4JZj3+QA4uhVbXVLRZSMQP0
         iT2lQ//rGBtkQwe2kgXmqFqjy77pIetPLwsx09aGB4NLnBi7gfoJeLR8XhKjLBm4ufen
         H101HHKHpco0t6GoR72ICGxhYNHzpaj0D84lJ1DKiYwYhClnlmTaZ884Tv3yIULWcJIS
         xMI11Vg5vrTVEWa2ys9ybVI8UFoJqBi6Ja+JwY8LLQBN84blFF8NU/MEEWYrCtscuzFh
         +RDbpqUXd9P+3bb801CfRr/fIzHfotW4D7EIWyqKSuw0VitX4oxdjQ++fJrW5DiD+wVz
         ijCw==
X-Forwarded-Encrypted: i=1; AJvYcCUpmTaByRW/m535GOWfO8g5274v+H387IsnP23/nnS3oZcQOomIrwgtTmuAF9dHM5I7JItwfim3KNcQ/R1x64HUVZeAnuTI3cpNbRm5ydzxP8AQDipCcNFSqHJqRJQW16l/vvkgpppG+g==
X-Gm-Message-State: AOJu0YzkaUDAz3RRLvXBcPt0fdpfvniSi+6dDa562PWvcjVIY1haS4RX
	sKOoyf5pfFf8LS7D7suI7NHbFS0ox9oVLXAmiQIONsAvNUfSZcfQ61QDFpDO3YDIOeMBktiuQno
	eom3K2zOJg4E7/eILDo4+ysoy3VprKp2FLLBbtA==
X-Google-Smtp-Source: AGHT+IFLo/pWMJyF4jE2tljsLDr02wXcR4IvKrf2+dlsZSurBLetoXtD2gBSEjCQMifCIvkIvviQl644BzeBdtRjUYs=
X-Received: by 2002:a2e:8315:0:b0:2d0:c7a3:e971 with SMTP id
 a21-20020a2e8315000000b002d0c7a3e971mr1391358ljh.0.1707485846803; Fri, 09 Feb
 2024 05:37:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209131552.471765-1-meetakshisetiyaoss@gmail.com> <20240209131552.471765-3-meetakshisetiyaoss@gmail.com>
In-Reply-To: <20240209131552.471765-3-meetakshisetiyaoss@gmail.com>
From: Meetakshi Setiya <meetakshisetiyaoss@gmail.com>
Date: Fri, 9 Feb 2024 19:07:13 +0530
Message-ID: <CAFTVevVeRb-dKkQK2gVEhoDQH1QhJXh-xHZXz-GW35d26y--uA@mail.gmail.com>
Subject: Re: [PATCH 3/3] smb: client: retry compound request without reusing lease
To: sfrench@samba.org, pc@manguebit.com, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, nspmangalore@gmail.com, tom@talpey.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	samba-technical@lists.samba.org, bharathsm.hsk@gmail.com
Cc: Meetakshi Setiya <msetiya@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patch 2 of this patch series
https://lore.kernel.org/linux-cifs/20240209131552.471765-2-meetakshisetiyao=
ss@gmail.com/
aims to fix a customer reported bug by reusing lease key in unlink,
rename and set_path_size compound operations on the smb client. The
bug, its implications and reproduction has been described in the
commit message of the patch. In short, unlink, rename and
set_path_size operations can cause the server to send lease breaks to
the same client, on the same connection which hurts performance.

The aim is to have a fix in place for this problem without regressing
existing behaviour. Also, the proposed changes should go in smaller
batches so that they can be backported with relative ease. Patch 2
regressed a few operations on hardlinks (eg., xfstests generic 002,
013).  As per MS-SMB2, lease keys are associated with the file name.
Linux cifs client maintains lease keys with the inode. If the file
has hardlinks, it is possible that the lease for a file be wrongly
reused for an operation on the hardlink or vice versa. In these
cases, the mentioned compound operations fail with
STATUS_INVALID_PARAMETER.

A simple fix for the regressions would be to have a two-phased
approach and resend the compound op request again without the lease
key if STATUS_INVALID_PARAMETER is received. This would help patch 2
fix the original issue. Fix(es) for the hardlink-leasekey problem can
come in the next batch.

Thanks
Meetakshi

On Fri, Feb 9, 2024 at 6:46=E2=80=AFPM <meetakshisetiyaoss@gmail.com> wrote=
:
>
> From: Meetakshi Setiya <msetiya@microsoft.com>
>
> There is a shortcoming in the current implementation of the file
> lease mechanism exposed when the lease keys were attempted to be
> reused for unlink, rename and set_path_size operations for a client. As
> per MS-SMB2, lease keys are associated with the file name. Linux smb
> client maintains lease keys with the inode. If the file has any hardlinks=
,
> it is possible that the lease for a file be wrongly reused for an
> operation on the hardlink or vice versa. In these cases, the mentioned
> compound operations fail with STATUS_INVALID_PARAMETER.
> This patch adds a fallback to the old mechanism of not sending any
> lease with these compound operations if the request with lease key fails
> with STATUS_INVALID_PARAMETER.
> Resending the same request without lease key should not hurt any
> functionality, but might impact performance especially in cases where
> the error is not because of the usage of wrong lease key and we might
> end up doing an extra roundtrip.
>
> Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
> ---
>  fs/smb/client/smb2inode.c | 41 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 3 deletions(-)
>
> diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
> index 69f3442c5b96..c0d099a9e1ee 100644
> --- a/fs/smb/client/smb2inode.c
> +++ b/fs/smb/client/smb2inode.c
> @@ -154,6 +154,17 @@ static int smb2_compound_op(const unsigned int xid, =
struct cifs_tcon *tcon,
>         }
>
>         /* if there is an existing lease, reuse it */
> +
> +       /*
> +        * note: files with hardlinks cause unexpected behaviour. As per =
MS-SMB2,
> +        * lease keys are associated with the filepath. We are maintainin=
g lease keys
> +        * with the inode on the client. If the file has hardlinks, it is=
 possible
> +        * that the lease for a file be reused for an operation on its ha=
rdlink or
> +        * vice versa.
> +        * As a workaround, send request using an existing lease key and =
if the server
> +        * returns STATUS_INVALID_PARAMETER, which maps to EINVAL, send t=
he request
> +        * again without the lease.
> +        */
>         if (dentry) {
>                 inode =3D d_inode(dentry);
>                 if (CIFS_I(inode)->lease_granted && server->ops->get_leas=
e_key) {
> @@ -867,11 +878,20 @@ int
>  smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *=
name,
>             struct cifs_sb_info *cifs_sb, struct dentry *dentry)
>  {
> -       return smb2_compound_op(xid, tcon, cifs_sb, name, DELETE, FILE_OP=
EN,
> +       int rc =3D smb2_compound_op(xid, tcon, cifs_sb, name, DELETE, FIL=
E_OPEN,
>                                 CREATE_DELETE_ON_CLOSE | OPEN_REPARSE_POI=
NT,
>                                 ACL_NO_MODE, NULL,
>                                 &(int){SMB2_OP_DELETE}, 1,
>                                 NULL, NULL, NULL, dentry);
> +       if (rc =3D=3D -EINVAL) {
> +               cifs_dbg(FYI, "invalid lease key, resending request witho=
ut lease");
> +               rc =3D smb2_compound_op(xid, tcon, cifs_sb, name, DELETE,=
 FILE_OPEN,
> +                               CREATE_DELETE_ON_CLOSE | OPEN_REPARSE_POI=
NT,
> +                               ACL_NO_MODE, NULL,
> +                               &(int){SMB2_OP_DELETE}, 1,
> +                               NULL, NULL, NULL, NULL);
> +       }
> +       return rc;
>  }
>
>  static int smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *=
tcon,
> @@ -912,8 +932,14 @@ int smb2_rename_path(const unsigned int xid,
>         drop_cached_dir_by_name(xid, tcon, from_name, cifs_sb);
>         cifs_get_writable_path(tcon, from_name, FIND_WR_WITH_DELETE, &cfi=
le);
>
> -       return smb2_set_path_attr(xid, tcon, from_name, to_name, cifs_sb,
> +       int rc =3D smb2_set_path_attr(xid, tcon, from_name, to_name, cifs=
_sb,
>                                   co, DELETE, SMB2_OP_RENAME, cfile, sour=
ce_dentry);
> +       if (rc =3D=3D -EINVAL) {
> +               cifs_dbg(FYI, "invalid lease key, resending request witho=
ut lease");
> +               rc =3D smb2_set_path_attr(xid, tcon, from_name, to_name, =
cifs_sb,
> +                                 co, DELETE, SMB2_OP_RENAME, cfile, NULL=
);
> +       }
> +       return rc;
>  }
>
>  int smb2_create_hardlink(const unsigned int xid,
> @@ -942,11 +968,20 @@ smb2_set_path_size(const unsigned int xid, struct c=
ifs_tcon *tcon,
>         in_iov.iov_base =3D &eof;
>         in_iov.iov_len =3D sizeof(eof);
>         cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile);
> -       return smb2_compound_op(xid, tcon, cifs_sb, full_path,
> +       int rc =3D smb2_compound_op(xid, tcon, cifs_sb, full_path,
>                                 FILE_WRITE_DATA, FILE_OPEN,
>                                 0, ACL_NO_MODE, &in_iov,
>                                 &(int){SMB2_OP_SET_EOF}, 1,
>                                 cfile, NULL, NULL, dentry);
> +       if (rc =3D=3D -EINVAL) {
> +               cifs_dbg(FYI, "invalid lease key, resending request witho=
ut lease");
> +               rc =3D smb2_compound_op(xid, tcon, cifs_sb, full_path,
> +                               FILE_WRITE_DATA, FILE_OPEN,
> +                               0, ACL_NO_MODE, &in_iov,
> +                               &(int){SMB2_OP_SET_EOF}, 1,
> +                               cfile, NULL, NULL, NULL);
> +       }
> +       return rc;
>  }
>
>  int
> --
> 2.39.2
>

