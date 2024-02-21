Return-Path: <linux-kernel+bounces-74054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C36D885CF5B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2483B2372A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D0F39877;
	Wed, 21 Feb 2024 04:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2xN5EgP"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22030A35;
	Wed, 21 Feb 2024 04:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708490690; cv=none; b=gSqNlJBw0zjAWFc4gq3YIrkEDF9Z6zZQHgcPuBoXmBIlseT2jpRvn0B5tU8GOPBf4vlV9qCTiUNC8R4vbts7ZzhhovKn56xT/FpVrqX5QJihTZL2uvFwp0kRHEdiG2n8QKS0AiD/U9PoS+p0rQPmzjsZNScxhAxTfrDNffhsS18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708490690; c=relaxed/simple;
	bh=yfKqhho4HIvDnnEOK87jRtYnLkNcK6xtZ06iKyV+JwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMRhoEqtm5C9dGToxo59WBcv6Rt/V3CXnUM6U5/9ZPF2AArrwSjOEf2OH/Pr3vnNs+5z/SF49ewQvthtbObWHBmxJJy0GpJd7cFrMq6JAqREtVVBPf3G9yiFS+zxCPxKwnel1vev02bQ0SQvpJmZDjWMXKtS8zwr0NylOEY3+V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2xN5EgP; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3e75e30d36so545030366b.1;
        Tue, 20 Feb 2024 20:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708490686; x=1709095486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uU1/KbaQaUX9WUdbqhUGxWALs004DZHh8NLJe4GRYfc=;
        b=J2xN5EgPVHR/2KDcMjlbaqDbG/YqQ9h5GKAPMlLvniTviMgvbkUX5sr566jqIabB/u
         Ps0IlWX8/Rm/Fq+Uf9lkSeDD7Q6Gf0VrP6BFA4zcMHPtDS7F7Gr4P10FCGBtbeBxDYA8
         nZa06XSRtIsfpdzAJCiWLelt+8YY/+yWgGYJemhXKPt+Chf0FlF48gsR4CY5Fu4qmj/t
         XwShukHv6X4oMVArlgAnFT3TTJNvOzq2NNsCqCLhJGJX+WBdKrx1akSOyGxhw1Yhjp+7
         689CEChqEhj5X155bVcjMLLZulbpjF/0k5dVgQ8IFiyZyF5FnOeF1eYwJ4jHPyPOis7N
         g3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708490686; x=1709095486;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uU1/KbaQaUX9WUdbqhUGxWALs004DZHh8NLJe4GRYfc=;
        b=Yv/FyGGHA4pht7IiH0IlrGpcHI4vpZzpzVKwseSx7bTuPztscm6iuUYpTK+Qqb2zRS
         g69MZblPqy6y5DB2dszftNz8T5vbddbis5z5RL3bQm2rgnqs4T5CfMK6qCsBL2iiSIyV
         YaL222SGfR8u1k/55iUqXU/y70hUmuqjfdtAXn2YiHa25tgmzYs9uHC8GswrT2MqGoNz
         oAeo/JIxyqBsfKEVRlpcmSo05Kcu5R9zZCAviqD+bV54Of6btQ/wvDPXKirncPMiwAu5
         GA9U2o9YCh2zQHVQhAyrtKd1js+4UeQ46qyvf8n7EP6n9CuTsVtpNUXTcGwK9D+1P8fY
         +HjA==
X-Forwarded-Encrypted: i=1; AJvYcCVaUEqZUFRUwEuFVb+65RjGqNVo3vmVqZzUtUaIAh4+55fRUDAztEGpD41B2Q4HZM+B1J7yE7LzTT5kg5FlS3cJ2tt1QlB3AYlN8Kie69R9lfMyNsmFZR7FPYu/YFS8ravrLUs3zMwsdA==
X-Gm-Message-State: AOJu0YxpxXeBasxXEIl0/zuAl2aDxj3mHUgrTR7qMmBFzWi1ZvbuDf1p
	8pEoDkR7pcj9XrBQ0vpZbnPn1gyHwp4ySUrjyf73Q/60oVh03x1I09GTew6WL5Mh5Xrl1DxsgQR
	Afe9fYXzHJLuuCoVrSRVtfDhlvJs=
X-Google-Smtp-Source: AGHT+IGQC1L+OIdhzCcUTW1YOZ3qyLowIS1/VsXXoqCjs8y5s8DEiC1L9+265vPYnDWQxVpSJHVVbiciIGxQLSLf/w0=
X-Received: by 2002:a17:907:9405:b0:a3f:1bb8:3b5f with SMTP id
 dk5-20020a170907940500b00a3f1bb83b5fmr3042338ejc.0.1708490686232; Tue, 20 Feb
 2024 20:44:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209131552.471765-1-meetakshisetiyaoss@gmail.com>
 <CAH2r5mtdebsVFbOoQeYYL79GVXe0wn=GfdgVE1RkQrnowHOO5Q@mail.gmail.com>
 <CANT5p=p+TYwH7yLH9+kvum0O5KjxKc9MrWtERCc7WCv_wzODQg@mail.gmail.com> <CAH2r5mumpNgm62mSFQmtMANm-njH1VJsv4ZT50Cww9dTCed3XQ@mail.gmail.com>
In-Reply-To: <CAH2r5mumpNgm62mSFQmtMANm-njH1VJsv4ZT50Cww9dTCed3XQ@mail.gmail.com>
From: Meetakshi Setiya <meetakshisetiyaoss@gmail.com>
Date: Wed, 21 Feb 2024 10:14:34 +0530
Message-ID: <CAFTVevU94O1NEJ1XzrUSDoC7b4=W=wciqRWX8LoB1X1=AUNZfA@mail.gmail.com>
Subject: Re: [PATCH 1/3] smb: client: do not defer close open handles to
 deleted files
To: Steve French <smfrench@gmail.com>
Cc: Shyam Prasad N <nspmangalore@gmail.com>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, ronnie sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	samba-technical <samba-technical@lists.samba.org>, Bharath SM <bharathsm.hsk@gmail.com>, 
	Meetakshi Setiya <msetiya@microsoft.com>
Content-Type: multipart/mixed; boundary="00000000000074939d0611dcfc99"

--00000000000074939d0611dcfc99
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

PFA the follow up patch that uses a boolean field status_file_deleted
instead of a bitmap to mark open handles for files that have been deleted.
Additionally, if SMB2 query info response is received with the DeletePendin=
g
flag set to true for a client, mark the corresponding open file handles
in this case too.

Thanks
Meetakshi

On Sun, Feb 11, 2024 at 2:34=E2=80=AFAM Steve French <smfrench@gmail.com> w=
rote:
>
> I lean toward using the existing attr field since it presumably could be =
set remotely and best to be safe and consistent and also uses less space
>
> ATTR_DELETE_ON_CLOSE
>
> On Sat, Feb 10, 2024, 11:50 Shyam Prasad N <nspmangalore@gmail.com> wrote=
:
>>
>> On Sat, Feb 10, 2024 at 11:29=E2=80=AFAM Steve French <smfrench@gmail.co=
m> wrote:
>> >
>> > could we make the "file_is_deleted" a boolean instead of using up more
>> > space making it an int?
>>
>> Meetakshi initially had it as a bool. I asked her to make it a bitmap,
>> just in case there can be other such flags that are needed in the
>> future.
>>
>> >
>> > Alternatively - would it be possible to simply look at the file
>> > attributes to see if it was marked as deleted (ie we should already be
>> > setting ATTR_DELETE_ON_CLOSE)
>>
>> It does not look like we use this attr anywhere today. (Am I missing som=
ething?)
>> Also, it looks like a flag that SMB uses in requests and responses.
>> I feel that it's better to keep a different flag for this purpose.
>>
>> >
>> > On Fri, Feb 9, 2024 at 7:17=E2=80=AFAM <meetakshisetiyaoss@gmail.com> =
wrote:
>> > >
>> > > From: Meetakshi Setiya <msetiya@microsoft.com>
>> > >
>> > > When a file/dentry has been deleted before closing all its open hand=
les,
>> > > currently, closing them can add them to the deferred close list. Thi=
s can
>> > > lead to problems in creating file with the same name when the file i=
s
>> > > re-created before the deferred close completes. This issue was seen =
while
>> > > reusing a client's already existing lease on a file for compound ope=
rations
>> > > and xfstest 591 failed because of the deferred close handle that rem=
ained
>> > > valid even after the file was deleted and was being reused to create=
 a file
>> > > with the same name. The server in this case returns an error on open=
 with
>> > > STATUS_DELETE_PENDING. Recreating the file would fail till the defer=
red
>> > > handles are closed (duration specified in closetimeo).
>> > >
>> > > This patch fixes the issue by flagging all open handles for the dele=
ted
>> > > file (file path to be precise) with FILE_DELETED at the end of the u=
nlink
>> > > operation. A new field cflags has been introduced in the cifsFileInf=
o
>> > > structure to set the FILE_DELETED flag without interfering with the =
f_flags
>> > > field. This cflags field could be useful in the future for setting m=
ore
>> > > flags specific to cfile.
>> > > When doing close in cifs_close for each of these handles, check the
>> > > FILE_DELETED flag and do not defer close these handles if the corres=
ponding
>> > > filepath has been deleted.
>> > >
>> > > Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
>> > > ---
>> > >  fs/smb/client/cifsglob.h  |  3 +++
>> > >  fs/smb/client/cifsproto.h |  4 ++++
>> > >  fs/smb/client/file.c      |  3 ++-
>> > >  fs/smb/client/inode.c     |  2 ++
>> > >  fs/smb/client/misc.c      | 22 ++++++++++++++++++++++
>> > >  5 files changed, 33 insertions(+), 1 deletion(-)
>> > >
>> > > diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
>> > > index 16befff4cbb4..f6b4acdcdeb3 100644
>> > > --- a/fs/smb/client/cifsglob.h
>> > > +++ b/fs/smb/client/cifsglob.h
>> > > @@ -1398,6 +1398,8 @@ struct cifs_fid_locks {
>> > >         struct list_head locks;         /* locks held by fid above *=
/
>> > >  };
>> > >
>> > > +#define FILE_DELETED 00000001
>> > > +
>> > >  struct cifsFileInfo {
>> > >         /* following two lists are protected by tcon->open_file_lock=
 */
>> > >         struct list_head tlist; /* pointer to next fid owned by tcon=
 */
>> > > @@ -1413,6 +1415,7 @@ struct cifsFileInfo {
>> > >         struct dentry *dentry;
>> > >         struct tcon_link *tlink;
>> > >         unsigned int f_flags;
>> > > +       unsigned int cflags;    /* flags for this file */
>> > >         bool invalidHandle:1;   /* file closed via session abend */
>> > >         bool swapfile:1;
>> > >         bool oplock_break_cancelled:1;
>> > > diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
>> > > index a841bf4967fa..f995b766b177 100644
>> > > --- a/fs/smb/client/cifsproto.h
>> > > +++ b/fs/smb/client/cifsproto.h
>> > > @@ -296,6 +296,10 @@ extern void cifs_close_all_deferred_files(struc=
t cifs_tcon *cifs_tcon);
>> > >
>> > >  extern void cifs_close_deferred_file_under_dentry(struct cifs_tcon =
*cifs_tcon,
>> > >                                 const char *path);
>> > > +
>> > > +extern void cifs_mark_open_handles_for_deleted_file(struct cifs_tco=
n
>> > > +                               *cifs_tcon, const char *path);
>> > > +
>> > >  extern struct TCP_Server_Info *
>> > >  cifs_get_tcp_session(struct smb3_fs_context *ctx,
>> > >                      struct TCP_Server_Info *primary_server);
>> > > diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
>> > > index b75282c204da..91cf4d2df4de 100644
>> > > --- a/fs/smb/client/file.c
>> > > +++ b/fs/smb/client/file.c
>> > > @@ -483,6 +483,7 @@ struct cifsFileInfo *cifs_new_fileinfo(struct ci=
fs_fid *fid, struct file *file,
>> > >         cfile->uid =3D current_fsuid();
>> > >         cfile->dentry =3D dget(dentry);
>> > >         cfile->f_flags =3D file->f_flags;
>> > > +       cfile->cflags =3D 0;
>> > >         cfile->invalidHandle =3D false;
>> > >         cfile->deferred_close_scheduled =3D false;
>> > >         cfile->tlink =3D cifs_get_tlink(tlink);
>> > > @@ -1085,7 +1086,7 @@ int cifs_close(struct inode *inode, struct fil=
e *file)
>> > >                 if ((cifs_sb->ctx->closetimeo && cinode->oplock =3D=
=3D CIFS_CACHE_RHW_FLG)
>> > >                     && cinode->lease_granted &&
>> > >                     !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags=
) &&
>> > > -                   dclose) {
>> > > +                   dclose && !(cfile->cflags & FILE_DELETED)) {
>> > >                         if (test_and_clear_bit(CIFS_INO_MODIFIED_ATT=
R, &cinode->flags)) {
>> > >                                 inode_set_mtime_to_ts(inode,
>> > >                                                       inode_set_ctim=
e_current(inode));
>> > > diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
>> > > index d02f8ba29cb5..8121b5b1aa22 100644
>> > > --- a/fs/smb/client/inode.c
>> > > +++ b/fs/smb/client/inode.c
>> > > @@ -1900,6 +1900,8 @@ int cifs_unlink(struct inode *dir, struct dent=
ry *dentry)
>> > >         cifs_inode =3D CIFS_I(dir);
>> > >         CIFS_I(dir)->time =3D 0;  /* force revalidate of dir as well=
 */
>> > >  unlink_out:
>> > > +       if (rc =3D=3D 0)
>> > > +               cifs_mark_open_handles_for_deleted_file(tcon, full_p=
ath);
>> > >         free_dentry_path(page);
>> > >         kfree(attrs);
>> > >         free_xid(xid);
>> > > diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
>> > > index 0748d7b757b9..8e46dee1a36c 100644
>> > > --- a/fs/smb/client/misc.c
>> > > +++ b/fs/smb/client/misc.c
>> > > @@ -853,6 +853,28 @@ cifs_close_deferred_file_under_dentry(struct ci=
fs_tcon *tcon, const char *path)
>> > >         free_dentry_path(page);
>> > >  }
>> > >
>> > > +/*
>> > > + * If a dentry has been deleted, all corresponding open handles sho=
uld know that
>> > > + * so that we do not defer close them.
>> > > + */
>> > > +void cifs_mark_open_handles_for_deleted_file(struct cifs_tcon *tcon=
,
>> > > +                                            const char *path)
>> > > +{
>> > > +       struct cifsFileInfo *cfile;
>> > > +       void *page;
>> > > +       const char *full_path;
>> > > +
>> > > +       page =3D alloc_dentry_path();
>> > > +       spin_lock(&tcon->open_file_lock);
>> > > +       list_for_each_entry(cfile, &tcon->openFileList, tlist) {
>> > > +               full_path =3D build_path_from_dentry(cfile->dentry, =
page);
>> > > +               if (strcmp(full_path, path) =3D=3D 0)
>> > > +                       cfile->cflags |=3D FILE_DELETED;
>> > > +       }
>> > > +       spin_unlock(&tcon->open_file_lock);
>> > > +       free_dentry_path(page);
>> > > +}
>> > > +
>> > >  /* parses DFS referral V3 structure
>> > >   * caller is responsible for freeing target_nodes
>> > >   * returns:
>> > > --
>> > > 2.39.2
>> > >
>> > >
>> >
>> >
>> > --
>> > Thanks,
>> >
>> > Steve
>>
>>
>>
>> --
>> Regards,
>> Shyam

--00000000000074939d0611dcfc99
Content-Type: application/octet-stream; 
	name="0001-smb-client-do-not-defer-close-open-handles-to-delete.patch"
Content-Disposition: attachment; 
	filename="0001-smb-client-do-not-defer-close-open-handles-to-delete.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lsvb7o380>
X-Attachment-Id: f_lsvb7o380

RnJvbSAwNzY3YzFiZDNiMjU1NTliNDY2ZTJhZDUwNjlhMmI2MTZiZDVkOTgyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNZWV0YWtzaGkgU2V0aXlhIDxtc2V0aXlhQG1pY3Jvc29mdC5j
b20+CkRhdGU6IEZyaSwgOSBGZWIgMjAyNCAwNToxMzoyMiAtMDUwMApTdWJqZWN0OiBbUEFUQ0gg
MS8zXSBzbWI6IGNsaWVudDogZG8gbm90IGRlZmVyIGNsb3NlIG9wZW4gaGFuZGxlcyB0byBkZWxl
dGVkCiBmaWxlcwoKV2hlbiBhIGZpbGUvZGVudHJ5IGhhcyBiZWVuIGRlbGV0ZWQgYmVmb3JlIGNs
b3NpbmcgYWxsIGl0cyBvcGVuCmhhbmRsZXMsIGN1cnJlbnRseSwgY2xvc2luZyB0aGVtIGNhbiBh
ZGQgdGhlbSB0byB0aGUgZGVmZXJyZWQKY2xvc2UgbGlzdC4gVGhpcyBjYW4gbGVhZCB0byBwcm9i
bGVtcyBpbiBjcmVhdGluZyBmaWxlIHdpdGggdGhlCnNhbWUgbmFtZSB3aGVuIHRoZSBmaWxlIGlz
IHJlLWNyZWF0ZWQgYmVmb3JlIHRoZSBkZWZlcnJlZCBjbG9zZQpjb21wbGV0ZXMuIFRoaXMgaXNz
dWUgd2FzIHNlZW4gd2hpbGUgcmV1c2luZyBhIGNsaWVudCdzIGFscmVhZHkKZXhpc3RpbmcgbGVh
c2Ugb24gYSBmaWxlIGZvciBjb21wb3VuZCBvcGVyYXRpb25zIGFuZCB4ZnN0ZXN0IDU5MQpmYWls
ZWQgYmVjYXVzZSBvZiB0aGUgZGVmZXJyZWQgY2xvc2UgaGFuZGxlIHRoYXQgcmVtYWluZWQgdmFs
aWQKZXZlbiBhZnRlciB0aGUgZmlsZSB3YXMgZGVsZXRlZCBhbmQgd2FzIGJlaW5nIHJldXNlZCB0
byBjcmVhdGUgYQpmaWxlIHdpdGggdGhlIHNhbWUgbmFtZS4gVGhlIHNlcnZlciBpbiB0aGlzIGNh
c2UgcmV0dXJucyBhbiBlcnJvcgpvbiBvcGVuIHdpdGggU1RBVFVTX0RFTEVURV9QRU5ESU5HLiBS
ZWNyZWF0aW5nIHRoZSBmaWxlIHdvdWxkCmZhaWwgdGlsbCB0aGUgZGVmZXJyZWQgaGFuZGxlcyBh
cmUgY2xvc2VkIChkdXJhdGlvbiBzcGVjaWZpZWQgaW4KY2xvc2V0aW1lbykuCgpUaGlzIHBhdGNo
IGZpeGVzIHRoZSBpc3N1ZSBieSBmbGFnZ2luZyBhbGwgb3BlbiBoYW5kbGVzIGZvciB0aGUKZGVs
ZXRlZCBmaWxlIChmaWxlIHBhdGggdG8gYmUgcHJlY2lzZSkgYnkgc2V0dGluZwpzdGF0dXNfZmls
ZV9kZWxldGVkIHRvIHRydWUgaW4gdGhlIGNpZnNGaWxlSW5mbyBzdHJ1Y3R1cmUuIEFzIHBlcgp0
aGUgaW5mb3JtYXRpb24gY2xhc3NlcyBzcGVjaWZpZWQgaW4gTVMtRlNDQywgU01CMiBxdWVyeSBp
bmZvCnJlc3BvbnNlIGZyb20gdGhlIHNlcnZlciBoYXMgYSBEZWxldGVQZW5kaW5nIGZpZWxkLCBz
ZXQgdG8gdHJ1ZQp0byBpbmRpY2F0ZSB0aGF0IGRlbGV0aW9uIGhhcyBiZWVuIHJlcXVlc3RlZCBv
biB0aGF0IGZpbGUuIElmCnRoaXMgaXMgdGhlIGNhc2UsIGZsYWcgdGhlIG9wZW4gaGFuZGxlcyBm
b3IgdGhpcyBmaWxlIHRvby4KCldoZW4gZG9pbmcgY2xvc2UgaW4gY2lmc19jbG9zZSBmb3IgZWFj
aCBvZiB0aGVzZSBoYW5kbGVzLCBjaGVjayB0aGUKdmFsdWUgb2YgdGhpcyBib29sZWFuIGZpZWxk
IGFuZCBkbyBub3QgZGVmZXIgY2xvc2UgdGhlc2UgaGFuZGxlcwppZiB0aGUgY29ycmVzcG9uZGlu
ZyBmaWxlcGF0aCBoYXMgYmVlbiBkZWxldGVkLgoKU2lnbmVkLW9mZi1ieTogTWVldGFrc2hpIFNl
dGl5YSA8bXNldGl5YUBtaWNyb3NvZnQuY29tPgotLS0KIGZzL3NtYi9jbGllbnQvY2lmc2dsb2Iu
aCAgfCAgMSArCiBmcy9zbWIvY2xpZW50L2NpZnNwcm90by5oIHwgIDQgKysrKwogZnMvc21iL2Ns
aWVudC9maWxlLmMgICAgICB8ICAzICsrLQogZnMvc21iL2NsaWVudC9pbm9kZS5jICAgICB8IDIz
ICsrKysrKysrKysrKysrKysrKy0tLS0tCiBmcy9zbWIvY2xpZW50L21pc2MuYyAgICAgIHwgMjIg
KysrKysrKysrKysrKysrKysrKysrKwogNSBmaWxlcyBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvY2lmc2dsb2IuaCBi
L2ZzL3NtYi9jbGllbnQvY2lmc2dsb2IuaAppbmRleCAxNmJlZmZmNGNiYjQuLmQ3OWI1OWMzYjUw
YyAxMDA2NDQKLS0tIGEvZnMvc21iL2NsaWVudC9jaWZzZ2xvYi5oCisrKyBiL2ZzL3NtYi9jbGll
bnQvY2lmc2dsb2IuaApAQCAtMTQxNiw2ICsxNDE2LDcgQEAgc3RydWN0IGNpZnNGaWxlSW5mbyB7
CiAJYm9vbCBpbnZhbGlkSGFuZGxlOjE7CS8qIGZpbGUgY2xvc2VkIHZpYSBzZXNzaW9uIGFiZW5k
ICovCiAJYm9vbCBzd2FwZmlsZToxOwogCWJvb2wgb3Bsb2NrX2JyZWFrX2NhbmNlbGxlZDoxOwor
CWJvb2wgc3RhdHVzX2ZpbGVfZGVsZXRlZDoxOyAvKiBmaWxlIGhhcyBiZWVuIGRlbGV0ZWQgKi8K
IAl1bnNpZ25lZCBpbnQgb3Bsb2NrX2Vwb2NoOyAvKiBlcG9jaCBmcm9tIHRoZSBsZWFzZSBicmVh
ayAqLwogCV9fdTMyIG9wbG9ja19sZXZlbDsgLyogb3Bsb2NrL2xlYXNlIGxldmVsIGZyb20gdGhl
IGxlYXNlIGJyZWFrICovCiAJaW50IGNvdW50OwpkaWZmIC0tZ2l0IGEvZnMvc21iL2NsaWVudC9j
aWZzcHJvdG8uaCBiL2ZzL3NtYi9jbGllbnQvY2lmc3Byb3RvLmgKaW5kZXggYTg0MWJmNDk2N2Zh
Li5mOTk1Yjc2NmIxNzcgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9jbGllbnQvY2lmc3Byb3RvLmgKKysr
IGIvZnMvc21iL2NsaWVudC9jaWZzcHJvdG8uaApAQCAtMjk2LDYgKzI5NiwxMCBAQCBleHRlcm4g
dm9pZCBjaWZzX2Nsb3NlX2FsbF9kZWZlcnJlZF9maWxlcyhzdHJ1Y3QgY2lmc190Y29uICpjaWZz
X3Rjb24pOwogCiBleHRlcm4gdm9pZCBjaWZzX2Nsb3NlX2RlZmVycmVkX2ZpbGVfdW5kZXJfZGVu
dHJ5KHN0cnVjdCBjaWZzX3Rjb24gKmNpZnNfdGNvbiwKIAkJCQljb25zdCBjaGFyICpwYXRoKTsK
KworZXh0ZXJuIHZvaWQgY2lmc19tYXJrX29wZW5faGFuZGxlc19mb3JfZGVsZXRlZF9maWxlKHN0
cnVjdCBjaWZzX3Rjb24KKwkJCQkqY2lmc190Y29uLCBjb25zdCBjaGFyICpwYXRoKTsKKwogZXh0
ZXJuIHN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKgogY2lmc19nZXRfdGNwX3Nlc3Npb24oc3RydWN0
IHNtYjNfZnNfY29udGV4dCAqY3R4LAogCQkgICAgIHN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKnBy
aW1hcnlfc2VydmVyKTsKZGlmZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvZmlsZS5jIGIvZnMvc21i
L2NsaWVudC9maWxlLmMKaW5kZXggYjc1MjgyYzIwNGRhLi40Njk1MWY0MDNkMzEgMTAwNjQ0Ci0t
LSBhL2ZzL3NtYi9jbGllbnQvZmlsZS5jCisrKyBiL2ZzL3NtYi9jbGllbnQvZmlsZS5jCkBAIC00
ODMsNiArNDgzLDcgQEAgc3RydWN0IGNpZnNGaWxlSW5mbyAqY2lmc19uZXdfZmlsZWluZm8oc3Ry
dWN0IGNpZnNfZmlkICpmaWQsIHN0cnVjdCBmaWxlICpmaWxlLAogCWNmaWxlLT51aWQgPSBjdXJy
ZW50X2ZzdWlkKCk7CiAJY2ZpbGUtPmRlbnRyeSA9IGRnZXQoZGVudHJ5KTsKIAljZmlsZS0+Zl9m
bGFncyA9IGZpbGUtPmZfZmxhZ3M7CisJY2ZpbGUtPnN0YXR1c19maWxlX2RlbGV0ZWQgPSBmYWxz
ZTsKIAljZmlsZS0+aW52YWxpZEhhbmRsZSA9IGZhbHNlOwogCWNmaWxlLT5kZWZlcnJlZF9jbG9z
ZV9zY2hlZHVsZWQgPSBmYWxzZTsKIAljZmlsZS0+dGxpbmsgPSBjaWZzX2dldF90bGluayh0bGlu
ayk7CkBAIC0xMDg1LDcgKzEwODYsNyBAQCBpbnQgY2lmc19jbG9zZShzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSkKIAkJaWYgKChjaWZzX3NiLT5jdHgtPmNsb3NldGltZW8g
JiYgY2lub2RlLT5vcGxvY2sgPT0gQ0lGU19DQUNIRV9SSFdfRkxHKQogCQkgICAgJiYgY2lub2Rl
LT5sZWFzZV9ncmFudGVkICYmCiAJCSAgICAhdGVzdF9iaXQoQ0lGU19JTk9fQ0xPU0VfT05fTE9D
SywgJmNpbm9kZS0+ZmxhZ3MpICYmCi0JCSAgICBkY2xvc2UpIHsKKwkJICAgIGRjbG9zZSAmJiAh
KGNmaWxlLT5zdGF0dXNfZmlsZV9kZWxldGVkKSkgewogCQkJaWYgKHRlc3RfYW5kX2NsZWFyX2Jp
dChDSUZTX0lOT19NT0RJRklFRF9BVFRSLCAmY2lub2RlLT5mbGFncykpIHsKIAkJCQlpbm9kZV9z
ZXRfbXRpbWVfdG9fdHMoaW5vZGUsCiAJCQkJCQkgICAgICBpbm9kZV9zZXRfY3RpbWVfY3VycmVu
dChpbm9kZSkpOwpkaWZmIC0tZ2l0IGEvZnMvc21iL2NsaWVudC9pbm9kZS5jIGIvZnMvc21iL2Ns
aWVudC9pbm9kZS5jCmluZGV4IGQwMmY4YmEyOWNiNS4uMThiYTQwMzQwNjIzIDEwMDY0NAotLS0g
YS9mcy9zbWIvY2xpZW50L2lub2RlLmMKKysrIGIvZnMvc21iL2NsaWVudC9pbm9kZS5jCkBAIC04
MDcsNyArODA3LDcgQEAgYm9vbCBjaWZzX3JlcGFyc2VfcG9pbnRfdG9fZmF0dHIoc3RydWN0IGNp
ZnNfc2JfaW5mbyAqY2lmc19zYiwKIAogc3RhdGljIHZvaWQgY2lmc19vcGVuX2luZm9fdG9fZmF0
dHIoc3RydWN0IGNpZnNfZmF0dHIgKmZhdHRyLAogCQkJCSAgICBzdHJ1Y3QgY2lmc19vcGVuX2lu
Zm9fZGF0YSAqZGF0YSwKLQkJCQkgICAgc3RydWN0IHN1cGVyX2Jsb2NrICpzYikKKwkJCQkgICAg
c3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgY29uc3QgY2hhciAqZnVsbF9wYXRoKQogewogCXN0cnVj
dCBzbWIyX2ZpbGVfYWxsX2luZm8gKmluZm8gPSAmZGF0YS0+Zmk7CiAJc3RydWN0IGNpZnNfc2Jf
aW5mbyAqY2lmc19zYiA9IENJRlNfU0Ioc2IpOwpAQCAtODE1LDggKzgxNSwxMCBAQCBzdGF0aWMg
dm9pZCBjaWZzX29wZW5faW5mb190b19mYXR0cihzdHJ1Y3QgY2lmc19mYXR0ciAqZmF0dHIsCiAK
IAltZW1zZXQoZmF0dHIsIDAsIHNpemVvZigqZmF0dHIpKTsKIAlmYXR0ci0+Y2ZfY2lmc2F0dHJz
ID0gbGUzMl90b19jcHUoaW5mby0+QXR0cmlidXRlcyk7Ci0JaWYgKGluZm8tPkRlbGV0ZVBlbmRp
bmcpCisJaWYgKGluZm8tPkRlbGV0ZVBlbmRpbmcpIHsKIAkJZmF0dHItPmNmX2ZsYWdzIHw9IENJ
RlNfRkFUVFJfREVMRVRFX1BFTkRJTkc7CisJCWNpZnNfbWFya19vcGVuX2hhbmRsZXNfZm9yX2Rl
bGV0ZWRfZmlsZSh0Y29uLCBmdWxsX3BhdGgpOworCX0KIAogCWlmIChpbmZvLT5MYXN0QWNjZXNz
VGltZSkKIAkJZmF0dHItPmNmX2F0aW1lID0gY2lmc19OVHRpbWVUb1VuaXgoaW5mby0+TGFzdEFj
Y2Vzc1RpbWUpOwpAQCAtODkzLDYgKzg5NSw5IEBAIGNpZnNfZ2V0X2ZpbGVfaW5mbyhzdHJ1Y3Qg
ZmlsZSAqZmlscCkKIAlzdHJ1Y3QgY2lmc0ZpbGVJbmZvICpjZmlsZSA9IGZpbHAtPnByaXZhdGVf
ZGF0YTsKIAlzdHJ1Y3QgY2lmc190Y29uICp0Y29uID0gdGxpbmtfdGNvbihjZmlsZS0+dGxpbmsp
OwogCXN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKnNlcnZlciA9IHRjb24tPnNlcy0+c2VydmVyOwor
CXN0cnVjdCBkZW50cnkgKmRlbnRyeSA9IGZpbHAtPmZfcGF0aC5kZW50cnk7CisJdm9pZCAqcGFn
ZSA9IGFsbG9jX2RlbnRyeV9wYXRoKCk7CisJY29uc3QgdW5zaWduZWQgY2hhciAqcGF0aDsKIAog
CWlmICghc2VydmVyLT5vcHMtPnF1ZXJ5X2ZpbGVfaW5mbykKIAkJcmV0dXJuIC1FTk9TWVM7CkBA
IC05MDcsNyArOTEyLDEyIEBAIGNpZnNfZ2V0X2ZpbGVfaW5mbyhzdHJ1Y3QgZmlsZSAqZmlscCkK
IAkJCWRhdGEuc3ltbGluayA9IHRydWU7CiAJCQlkYXRhLnJlcGFyc2UudGFnID0gSU9fUkVQQVJT
RV9UQUdfU1lNTElOSzsKIAkJfQotCQljaWZzX29wZW5faW5mb190b19mYXR0cigmZmF0dHIsICZk
YXRhLCBpbm9kZS0+aV9zYik7CisJCXBhdGggPSBidWlsZF9wYXRoX2Zyb21fZGVudHJ5KGRlbnRy
eSwgcGFnZSk7CisJCWlmIChJU19FUlIocGF0aCkpIHsKKwkJCWZyZWVfZGVudHJ5X3BhdGgocGFn
ZSk7CisJCQlyZXR1cm4gUFRSX0VSUihwYXRoKTsKKwkJfQorCQljaWZzX29wZW5faW5mb190b19m
YXR0cigmZmF0dHIsICZkYXRhLCBpbm9kZS0+aV9zYiwgcGF0aCk7CiAJCWJyZWFrOwogCWNhc2Ug
LUVSRU1PVEU6CiAJCWNpZnNfY3JlYXRlX2p1bmN0aW9uX2ZhdHRyKCZmYXR0ciwgaW5vZGUtPmlf
c2IpOwpAQCAtOTM3LDYgKzk0Nyw3IEBAIGNpZnNfZ2V0X2ZpbGVfaW5mbyhzdHJ1Y3QgZmlsZSAq
ZmlscCkKIAlyYyA9IGNpZnNfZmF0dHJfdG9faW5vZGUoaW5vZGUsICZmYXR0cik7CiBjZ2ZpX2V4
aXQ6CiAJY2lmc19mcmVlX29wZW5faW5mbygmZGF0YSk7CisJZnJlZV9kZW50cnlfcGF0aChwYWdl
KTsKIAlmcmVlX3hpZCh4aWQpOwogCXJldHVybiByYzsKIH0KQEAgLTExMTUsNyArMTEyNiw3IEBA
IHN0YXRpYyBpbnQgcmVwYXJzZV9pbmZvX3RvX2ZhdHRyKHN0cnVjdCBjaWZzX29wZW5faW5mb19k
YXRhICpkYXRhLAogCWlmICh0Y29uLT5wb3NpeF9leHRlbnNpb25zKQogCQlzbWIzMTFfcG9zaXhf
aW5mb190b19mYXR0cihmYXR0ciwgZGF0YSwgc2IpOwogCWVsc2UKLQkJY2lmc19vcGVuX2luZm9f
dG9fZmF0dHIoZmF0dHIsIGRhdGEsIHNiKTsKKwkJY2lmc19vcGVuX2luZm9fdG9fZmF0dHIoZmF0
dHIsIGRhdGEsIHNiLCBmdWxsX3BhdGgpOwogb3V0OgogCWZhdHRyLT5jZl9jaWZzdGFnID0gZGF0
YS0+cmVwYXJzZS50YWc7CiAJZnJlZV9yc3BfYnVmKHJzcF9idWZ0eXBlLCByc3BfaW92Lmlvdl9i
YXNlKTsKQEAgLTExNjksNyArMTE4MCw3IEBAIHN0YXRpYyBpbnQgY2lmc19nZXRfZmF0dHIoc3Ry
dWN0IGNpZnNfb3Blbl9pbmZvX2RhdGEgKmRhdGEsCiAJCQlyYyA9IHJlcGFyc2VfaW5mb190b19m
YXR0cihkYXRhLCBzYiwgeGlkLCB0Y29uLAogCQkJCQkJICAgZnVsbF9wYXRoLCBmYXR0cik7CiAJ
CX0gZWxzZSB7Ci0JCQljaWZzX29wZW5faW5mb190b19mYXR0cihmYXR0ciwgZGF0YSwgc2IpOwor
CQkJY2lmc19vcGVuX2luZm9fdG9fZmF0dHIoZmF0dHIsIGRhdGEsIHNiLCBmdWxsX3BhdGgpOwog
CQl9CiAJCWJyZWFrOwogCWNhc2UgLUVSRU1PVEU6CkBAIC0xOTAwLDYgKzE5MTEsOCBAQCBpbnQg
Y2lmc191bmxpbmsoc3RydWN0IGlub2RlICpkaXIsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSkKIAlj
aWZzX2lub2RlID0gQ0lGU19JKGRpcik7CiAJQ0lGU19JKGRpciktPnRpbWUgPSAwOwkvKiBmb3Jj
ZSByZXZhbGlkYXRlIG9mIGRpciBhcyB3ZWxsICovCiB1bmxpbmtfb3V0OgorCWlmIChyYyA9PSAw
KQorCQljaWZzX21hcmtfb3Blbl9oYW5kbGVzX2Zvcl9kZWxldGVkX2ZpbGUodGNvbiwgZnVsbF9w
YXRoKTsKIAlmcmVlX2RlbnRyeV9wYXRoKHBhZ2UpOwogCWtmcmVlKGF0dHJzKTsKIAlmcmVlX3hp
ZCh4aWQpOwpkaWZmIC0tZ2l0IGEvZnMvc21iL2NsaWVudC9taXNjLmMgYi9mcy9zbWIvY2xpZW50
L21pc2MuYwppbmRleCAwNzQ4ZDdiNzU3YjkuLjRlYTE4ZGQ3YjFhOCAxMDA2NDQKLS0tIGEvZnMv
c21iL2NsaWVudC9taXNjLmMKKysrIGIvZnMvc21iL2NsaWVudC9taXNjLmMKQEAgLTg1Myw2ICs4
NTMsMjggQEAgY2lmc19jbG9zZV9kZWZlcnJlZF9maWxlX3VuZGVyX2RlbnRyeShzdHJ1Y3QgY2lm
c190Y29uICp0Y29uLCBjb25zdCBjaGFyICpwYXRoKQogCWZyZWVfZGVudHJ5X3BhdGgocGFnZSk7
CiB9CiAKKy8qCisgKiBJZiBhIGRlbnRyeSBoYXMgYmVlbiBkZWxldGVkLCBhbGwgY29ycmVzcG9u
ZGluZyBvcGVuIGhhbmRsZXMgc2hvdWxkIGtub3cgdGhhdAorICogc28gdGhhdCB3ZSBkbyBub3Qg
ZGVmZXIgY2xvc2UgdGhlbS4KKyAqLwordm9pZCBjaWZzX21hcmtfb3Blbl9oYW5kbGVzX2Zvcl9k
ZWxldGVkX2ZpbGUoc3RydWN0IGNpZnNfdGNvbiAqdGNvbiwKKwkJCQkJICAgICBjb25zdCBjaGFy
ICpwYXRoKQoreworCXN0cnVjdCBjaWZzRmlsZUluZm8gKmNmaWxlOworCXZvaWQgKnBhZ2U7CisJ
Y29uc3QgY2hhciAqZnVsbF9wYXRoOworCisJcGFnZSA9IGFsbG9jX2RlbnRyeV9wYXRoKCk7CisJ
c3Bpbl9sb2NrKCZ0Y29uLT5vcGVuX2ZpbGVfbG9jayk7CisJbGlzdF9mb3JfZWFjaF9lbnRyeShj
ZmlsZSwgJnRjb24tPm9wZW5GaWxlTGlzdCwgdGxpc3QpIHsKKwkJZnVsbF9wYXRoID0gYnVpbGRf
cGF0aF9mcm9tX2RlbnRyeShjZmlsZS0+ZGVudHJ5LCBwYWdlKTsKKwkJaWYgKHN0cmNtcChmdWxs
X3BhdGgsIHBhdGgpID09IDApCisJCQljZmlsZS0+c3RhdHVzX2ZpbGVfZGVsZXRlZCA9IHRydWU7
CisJfQorCXNwaW5fdW5sb2NrKCZ0Y29uLT5vcGVuX2ZpbGVfbG9jayk7CisJZnJlZV9kZW50cnlf
cGF0aChwYWdlKTsKK30KKwogLyogcGFyc2VzIERGUyByZWZlcnJhbCBWMyBzdHJ1Y3R1cmUKICAq
IGNhbGxlciBpcyByZXNwb25zaWJsZSBmb3IgZnJlZWluZyB0YXJnZXRfbm9kZXMKICAqIHJldHVy
bnM6Ci0tIAoyLjM5LjIKCg==
--00000000000074939d0611dcfc99--

