Return-Path: <linux-kernel+bounces-101097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3F587A23E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41B7282845
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CA810A36;
	Wed, 13 Mar 2024 04:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJVj1TCi"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D028910A1A;
	Wed, 13 Mar 2024 04:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710303489; cv=none; b=f//actbLMPB7HZkMJ/JmcKy2AugbOf9gtsC9ZcQKdqigW88bZJdM5e9auVYdoamsINSENjbVR6o1chyyZyACOIcXUDt5ojTsKQy0Xp59BQe/2MHsKRAogFULWY8Kczzq6V8RjlNhCCU0nYWOD5fxgmiqeq8Jg7vlHW/V7/9gitk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710303489; c=relaxed/simple;
	bh=uK1id0ZrYsd4elRJu9nJcz+rzsASnXBfoVjJM+jYmtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kz514JcbVvQBxv6nTkarJMFWUK0FT4FOQ0MYnzarTEJ2hrTpddHGYCTEpPogp/OQFHRdnThllWU8oEQSsNj8rAEhk4FgMb9bAsQYWaTRThcVxJNKbAtrpuKVj+wTiIIDXbPA8p8a/7uJ/UHYuqa0DZNuP6Uowewt6lcP95DsLyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJVj1TCi; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5682360e095so7743380a12.1;
        Tue, 12 Mar 2024 21:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710303486; x=1710908286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zc3fQsSxMla69nVL70RBeoIgzvmNwa/sNQ4rxRM5xy0=;
        b=MJVj1TCil37mLgmv9eNldsAj4tgjUIKYQ+IzCfMt2LZONAOHhWSfwvqADKrRCZWP5K
         uhs8SzInQceTGz61DFOnzjIb39M28mfzo+aiiBKNZVbRyb2VVUHRvszxYAIePVtbIDms
         6YfnUgCg4mmciEeQYZXdVkwSk3j8vy8ZM5feCs3RfJQ/6hxob3FWRjgrUGPRhbZKbSuF
         jSWX0vjLsbfdzCNEST9xMwQL3Ex093d/bu6OZuC6O64GUdqfv60m5eJ/Bn87GodnCXhs
         3dwAVafjySRWVk/1E4U/bMpYYB1BWphVV+Y3ak+1YjnShSBPCRh5FZ3H3zaUgjvR8QQv
         KiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710303486; x=1710908286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zc3fQsSxMla69nVL70RBeoIgzvmNwa/sNQ4rxRM5xy0=;
        b=IYDOgMQSM9ECxZlTR8Lz3B8s44MrEhkkKRMCRmTlJqijuyCI/vibJ65JVbJIT4cJ7n
         S3rjxfb4+zJNV/RXjUY2sSesjg2+V33cpnpdDGPyLnjYX8ZNfkg4m+9fTQNvIosHiUlR
         bO9Qs99ba9WYlnv4RegxVTa6UqQX93nQi6PFLRoshjFNWe8qA5VM8EM6oQNr4cRgCiA2
         T98hSL8pqC/If52NXiRHmdWQDa11gPAU2DS9WwuufO/zuz65So3pzw3YnmvuRLWx01G2
         BtE4KMjf5WyrTBhGslOqi5X0cZZMx3AJoR53psqXfGBjLnXX/kwlM7b4qJC4WdF5iA/D
         06HQ==
X-Forwarded-Encrypted: i=1; AJvYcCU66PBl8woXFwUX87oApDfEZefAxgMyZiWIIM7aE4r0oEy5uQsNO+Ywm7afLWziANejEDXbHOADTtUQFdVy+Alnb/3Mui/kQ8mHsy9dW8nDjd2rQgGG3630nl2e/6iz4K9pERQZfFcKwA==
X-Gm-Message-State: AOJu0YzFy2Jt5hoPbOzM5tcLD9jxdnGIMbnzV/HPCh9ZRSB7M38SB2Dd
	8V1DMDoUK6Kl5eFQ6Q8wPUPQTESPNMvdysJtWlG9M/CORtOKDGS+Y6fNyQcN8lqcsgfayxQZ94l
	LFILjN4I+XntaUouG5oyxnKGlcWfPRSnS
X-Google-Smtp-Source: AGHT+IF+MfmQ6NUJ9mgf2xbt3ra3Zscd3WwBqJGZ8ecbQAa6q8MtBBcguL1I8GRsGhhirb2sO3+kq5lN29Q3qHpD9Hk=
X-Received: by 2002:a05:6402:5c4:b0:564:5764:a5d8 with SMTP id
 n4-20020a05640205c400b005645764a5d8mr7701491edx.25.1710303485899; Tue, 12 Mar
 2024 21:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306034353.190039-1-meetakshisetiyaoss@gmail.com>
 <20240306034353.190039-2-meetakshisetiyaoss@gmail.com> <8e729f88f285fefaa8a089da09484ed2@manguebit.com>
In-Reply-To: <8e729f88f285fefaa8a089da09484ed2@manguebit.com>
From: Meetakshi Setiya <meetakshisetiyaoss@gmail.com>
Date: Wed, 13 Mar 2024 09:47:54 +0530
Message-ID: <CAFTVevUNkkputV3SWJzh8D4Fw3b9e_fGHb=R-Mk+C-QrhC1uQg@mail.gmail.com>
Subject: Re: [PATCH 2/3] smb: client: do not defer close open handles to
 deleted files
To: Paulo Alcantara <pc@manguebit.com>
Cc: sfrench@samba.org, ronniesahlberg@gmail.com, sprasad@microsoft.com, 
	nspmangalore@gmail.com, tom@talpey.com, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, samba-technical@lists.samba.org, 
	bharathsm.hsk@gmail.com, Meetakshi Setiya <msetiya@microsoft.com>
Content-Type: multipart/mixed; boundary="000000000000bc552d0613830f84"

--000000000000bc552d0613830f84
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

PFA the follow up patch after the above revision.

Thanks
Meetakshi

On Wed, Mar 6, 2024 at 8:01=E2=80=AFPM Paulo Alcantara <pc@manguebit.com> w=
rote:
>
> meetakshisetiyaoss@gmail.com writes:
>
> > diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> > index b75282c204da..46951f403d31 100644
> > --- a/fs/smb/client/file.c
> > +++ b/fs/smb/client/file.c
> > @@ -483,6 +483,7 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cifs_=
fid *fid, struct file *file,
> >       cfile->uid =3D current_fsuid();
> >       cfile->dentry =3D dget(dentry);
> >       cfile->f_flags =3D file->f_flags;
> > +     cfile->status_file_deleted =3D false;
>
> This is unnecessary as @cfile is kzalloc()'d.
>
> >       cfile->invalidHandle =3D false;
> >       cfile->deferred_close_scheduled =3D false;
> >       cfile->tlink =3D cifs_get_tlink(tlink);
> > @@ -1085,7 +1086,7 @@ int cifs_close(struct inode *inode, struct file *=
file)
> >               if ((cifs_sb->ctx->closetimeo && cinode->oplock =3D=3D CI=
FS_CACHE_RHW_FLG)
> >                   && cinode->lease_granted &&
> >                   !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags) &&
> > -                 dclose) {
> > +                 dclose && !(cfile->status_file_deleted)) {
> >                       if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &c=
inode->flags)) {
> >                               inode_set_mtime_to_ts(inode,
> >                                                     inode_set_ctime_cur=
rent(inode));
> > diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> > index 3073eac989ea..3242e3b74386 100644
> > --- a/fs/smb/client/inode.c
> > +++ b/fs/smb/client/inode.c
> > @@ -893,6 +893,9 @@ cifs_get_file_info(struct file *filp)
> >       struct cifsFileInfo *cfile =3D filp->private_data;
> >       struct cifs_tcon *tcon =3D tlink_tcon(cfile->tlink);
> >       struct TCP_Server_Info *server =3D tcon->ses->server;
> > +     struct dentry *dentry =3D filp->f_path.dentry;
> > +     void *page =3D alloc_dentry_path();
> > +     const unsigned char *path;
> >
> >       if (!server->ops->query_file_info)
> >               return -ENOSYS;
>
> You're leaking @page if above condition is true.
>
> > @@ -907,7 +910,14 @@ cifs_get_file_info(struct file *filp)
> >                       data.symlink =3D true;
> >                       data.reparse.tag =3D IO_REPARSE_TAG_SYMLINK;
> >               }
> > +             path =3D build_path_from_dentry(dentry, page);
> > +             if (IS_ERR(path)) {
> > +                     free_dentry_path(page);
> > +                     return PTR_ERR(path);
>
> Now you're leaking @data and @fid if above condition is true.
>
> > +             }
> >               cifs_open_info_to_fattr(&fattr, &data, inode->i_sb);
> > +             if (fattr.cf_flags & CIFS_FATTR_DELETE_PENDING)
> > +                     cifs_mark_open_handles_for_deleted_file(inode, pa=
th);
> >               break;
> >       case -EREMOTE:
> >               cifs_create_junction_fattr(&fattr, inode->i_sb);
> > @@ -937,6 +947,7 @@ cifs_get_file_info(struct file *filp)
> >       rc =3D cifs_fattr_to_inode(inode, &fattr);
> >  cgfi_exit:
> >       cifs_free_open_info(&data);
> > +     free_dentry_path(page);
> >       free_xid(xid);
> >       return rc;
> >  }
> > @@ -1075,6 +1086,7 @@ static int reparse_info_to_fattr(struct cifs_open=
_info_data *data,
> >       struct kvec rsp_iov, *iov =3D NULL;
> >       int rsp_buftype =3D CIFS_NO_BUFFER;
> >       u32 tag =3D data->reparse.tag;
> > +     struct inode *inode =3D NULL;
> >       int rc =3D 0;
> >
> >       if (!tag && server->ops->query_reparse_point) {
> > @@ -1114,8 +1126,12 @@ static int reparse_info_to_fattr(struct cifs_ope=
n_info_data *data,
> >
> >       if (tcon->posix_extensions)
> >               smb311_posix_info_to_fattr(fattr, data, sb);
> > -     else
> > +     else {
> >               cifs_open_info_to_fattr(fattr, data, sb);
> > +             inode =3D cifs_iget(sb, fattr);
> > +             if (inode && fattr->cf_flags & CIFS_FATTR_DELETE_PENDING)
>
> You shouldn't ignore if cifs_iget() failed.  Return -ENOMEM instead.
>
> Besides, calling cifs_iget() here looks wrong as @fattr is not fully
> set, yet.  Why can't you use @inode from cifs_get_fattr() or do above
> check right after cifs_get_fattr() in cifs_get_inode_info{,_unix}()?

--000000000000bc552d0613830f84
Content-Type: application/octet-stream; 
	name="0002-smb-client-do-not-defer-close-open-handles-to-delete.patch"
Content-Disposition: attachment; 
	filename="0002-smb-client-do-not-defer-close-open-handles-to-delete.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ltpahs4z0>
X-Attachment-Id: f_ltpahs4z0

RnJvbSA0MWM1OWZmZWI0NjAxNTlhZDA3OWI2N2Y2ZTIwMmM0MDllNGJkNWMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNZWV0YWtzaGkgU2V0aXlhIDxtc2V0aXlhQG1pY3Jvc29mdC5j
b20+CkRhdGU6IEZyaSwgOSBGZWIgMjAyNCAwNToxMzoyMiAtMDUwMApTdWJqZWN0OiBbUEFUQ0gg
Mi8zXSBzbWI6IGNsaWVudDogZG8gbm90IGRlZmVyIGNsb3NlIG9wZW4gaGFuZGxlcyB0byBkZWxl
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
aWVudC9maWxlLmMgICAgICB8ICAyICstCiBmcy9zbWIvY2xpZW50L2lub2RlLmMgICAgIHwgMzAg
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCiBmcy9zbWIvY2xpZW50L21pc2MuYyAgICAg
IHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogZnMvc21iL2NsaWVudC9z
bWIyaW5vZGUuYyB8ICA5ICsrKysrKysrLQogNiBmaWxlcyBjaGFuZ2VkLCA3NSBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvY2lmc2dsb2Iu
aCBiL2ZzL3NtYi9jbGllbnQvY2lmc2dsb2IuaAppbmRleCA1MGY3ZTQ3YzIyMjkuLmE4OGM4MzI4
YjI5YyAxMDA2NDQKLS0tIGEvZnMvc21iL2NsaWVudC9jaWZzZ2xvYi5oCisrKyBiL2ZzL3NtYi9j
bGllbnQvY2lmc2dsb2IuaApAQCAtMTQxNyw2ICsxNDE3LDcgQEAgc3RydWN0IGNpZnNGaWxlSW5m
byB7CiAJYm9vbCBpbnZhbGlkSGFuZGxlOjE7CS8qIGZpbGUgY2xvc2VkIHZpYSBzZXNzaW9uIGFi
ZW5kICovCiAJYm9vbCBzd2FwZmlsZToxOwogCWJvb2wgb3Bsb2NrX2JyZWFrX2NhbmNlbGxlZDox
OworCWJvb2wgc3RhdHVzX2ZpbGVfZGVsZXRlZDoxOyAvKiBmaWxlIGhhcyBiZWVuIGRlbGV0ZWQg
Ki8KIAl1bnNpZ25lZCBpbnQgb3Bsb2NrX2Vwb2NoOyAvKiBlcG9jaCBmcm9tIHRoZSBsZWFzZSBi
cmVhayAqLwogCV9fdTMyIG9wbG9ja19sZXZlbDsgLyogb3Bsb2NrL2xlYXNlIGxldmVsIGZyb20g
dGhlIGxlYXNlIGJyZWFrICovCiAJaW50IGNvdW50OwpkaWZmIC0tZ2l0IGEvZnMvc21iL2NsaWVu
dC9jaWZzcHJvdG8uaCBiL2ZzL3NtYi9jbGllbnQvY2lmc3Byb3RvLmgKaW5kZXggZWY5OGM4NDA3
OTFmLi4xZjQ2ZTBkYjZlOTIgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9jbGllbnQvY2lmc3Byb3RvLmgK
KysrIGIvZnMvc21iL2NsaWVudC9jaWZzcHJvdG8uaApAQCAtMjk2LDYgKzI5NiwxMCBAQCBleHRl
cm4gdm9pZCBjaWZzX2Nsb3NlX2FsbF9kZWZlcnJlZF9maWxlcyhzdHJ1Y3QgY2lmc190Y29uICpj
aWZzX3Rjb24pOwogCiBleHRlcm4gdm9pZCBjaWZzX2Nsb3NlX2RlZmVycmVkX2ZpbGVfdW5kZXJf
ZGVudHJ5KHN0cnVjdCBjaWZzX3Rjb24gKmNpZnNfdGNvbiwKIAkJCQljb25zdCBjaGFyICpwYXRo
KTsKKworZXh0ZXJuIHZvaWQgY2lmc19tYXJrX29wZW5faGFuZGxlc19mb3JfZGVsZXRlZF9maWxl
KHN0cnVjdCBpbm9kZSAqaW5vZGUsCisJCQkJY29uc3QgY2hhciAqcGF0aCk7CisKIGV4dGVybiBz
dHJ1Y3QgVENQX1NlcnZlcl9JbmZvICoKIGNpZnNfZ2V0X3RjcF9zZXNzaW9uKHN0cnVjdCBzbWIz
X2ZzX2NvbnRleHQgKmN0eCwKIAkJICAgICBzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpwcmltYXJ5
X3NlcnZlcik7CmRpZmYgLS1naXQgYS9mcy9zbWIvY2xpZW50L2ZpbGUuYyBiL2ZzL3NtYi9jbGll
bnQvZmlsZS5jCmluZGV4IGI3NTI4MmMyMDRkYS4uYmVkODZjYzhjYzIyIDEwMDY0NAotLS0gYS9m
cy9zbWIvY2xpZW50L2ZpbGUuYworKysgYi9mcy9zbWIvY2xpZW50L2ZpbGUuYwpAQCAtMTA4NSw3
ICsxMDg1LDcgQEAgaW50IGNpZnNfY2xvc2Uoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZp
bGUgKmZpbGUpCiAJCWlmICgoY2lmc19zYi0+Y3R4LT5jbG9zZXRpbWVvICYmIGNpbm9kZS0+b3Bs
b2NrID09IENJRlNfQ0FDSEVfUkhXX0ZMRykKIAkJICAgICYmIGNpbm9kZS0+bGVhc2VfZ3JhbnRl
ZCAmJgogCQkgICAgIXRlc3RfYml0KENJRlNfSU5PX0NMT1NFX09OX0xPQ0ssICZjaW5vZGUtPmZs
YWdzKSAmJgotCQkgICAgZGNsb3NlKSB7CisJCSAgICBkY2xvc2UgJiYgIShjZmlsZS0+c3RhdHVz
X2ZpbGVfZGVsZXRlZCkpIHsKIAkJCWlmICh0ZXN0X2FuZF9jbGVhcl9iaXQoQ0lGU19JTk9fTU9E
SUZJRURfQVRUUiwgJmNpbm9kZS0+ZmxhZ3MpKSB7CiAJCQkJaW5vZGVfc2V0X210aW1lX3RvX3Rz
KGlub2RlLAogCQkJCQkJICAgICAgaW5vZGVfc2V0X2N0aW1lX2N1cnJlbnQoaW5vZGUpKTsKZGlm
ZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvaW5vZGUuYyBiL2ZzL3NtYi9jbGllbnQvaW5vZGUuYwpp
bmRleCAzMDczZWFjOTg5ZWEuLjBjODUxMTM1ZTFmMyAxMDA2NDQKLS0tIGEvZnMvc21iL2NsaWVu
dC9pbm9kZS5jCisrKyBiL2ZzL3NtYi9jbGllbnQvaW5vZGUuYwpAQCAtODkzLDkgKzg5MywxNCBA
QCBjaWZzX2dldF9maWxlX2luZm8oc3RydWN0IGZpbGUgKmZpbHApCiAJc3RydWN0IGNpZnNGaWxl
SW5mbyAqY2ZpbGUgPSBmaWxwLT5wcml2YXRlX2RhdGE7CiAJc3RydWN0IGNpZnNfdGNvbiAqdGNv
biA9IHRsaW5rX3Rjb24oY2ZpbGUtPnRsaW5rKTsKIAlzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpz
ZXJ2ZXIgPSB0Y29uLT5zZXMtPnNlcnZlcjsKKwlzdHJ1Y3QgZGVudHJ5ICpkZW50cnkgPSBmaWxw
LT5mX3BhdGguZGVudHJ5OworCXZvaWQgKnBhZ2UgPSBhbGxvY19kZW50cnlfcGF0aCgpOworCWNv
bnN0IHVuc2lnbmVkIGNoYXIgKnBhdGg7CiAKLQlpZiAoIXNlcnZlci0+b3BzLT5xdWVyeV9maWxl
X2luZm8pCisJaWYgKCFzZXJ2ZXItPm9wcy0+cXVlcnlfZmlsZV9pbmZvKSB7CisJCWZyZWVfZGVu
dHJ5X3BhdGgocGFnZSk7CiAJCXJldHVybiAtRU5PU1lTOworCX0KIAogCXhpZCA9IGdldF94aWQo
KTsKIAlyYyA9IHNlcnZlci0+b3BzLT5xdWVyeV9maWxlX2luZm8oeGlkLCB0Y29uLCBjZmlsZSwg
JmRhdGEpOwpAQCAtOTA3LDcgKzkxMiwxNCBAQCBjaWZzX2dldF9maWxlX2luZm8oc3RydWN0IGZp
bGUgKmZpbHApCiAJCQlkYXRhLnN5bWxpbmsgPSB0cnVlOwogCQkJZGF0YS5yZXBhcnNlLnRhZyA9
IElPX1JFUEFSU0VfVEFHX1NZTUxJTks7CiAJCX0KKwkJcGF0aCA9IGJ1aWxkX3BhdGhfZnJvbV9k
ZW50cnkoZGVudHJ5LCBwYWdlKTsKKwkJaWYgKElTX0VSUihwYXRoKSkgeworCQkJcmMgPSBQVFJf
RVJSKHBhdGgpOworCQkJZ290byBjZ2ZpX2V4aXQ7CisJCX0KIAkJY2lmc19vcGVuX2luZm9fdG9f
ZmF0dHIoJmZhdHRyLCAmZGF0YSwgaW5vZGUtPmlfc2IpOworCQlpZiAoZmF0dHIuY2ZfZmxhZ3Mg
JiBDSUZTX0ZBVFRSX0RFTEVURV9QRU5ESU5HKQorCQkJY2lmc19tYXJrX29wZW5faGFuZGxlc19m
b3JfZGVsZXRlZF9maWxlKGlub2RlLCBwYXRoKTsKIAkJYnJlYWs7CiAJY2FzZSAtRVJFTU9URToK
IAkJY2lmc19jcmVhdGVfanVuY3Rpb25fZmF0dHIoJmZhdHRyLCBpbm9kZS0+aV9zYik7CkBAIC05
MzcsNiArOTQ5LDcgQEAgY2lmc19nZXRfZmlsZV9pbmZvKHN0cnVjdCBmaWxlICpmaWxwKQogCXJj
ID0gY2lmc19mYXR0cl90b19pbm9kZShpbm9kZSwgJmZhdHRyKTsKIGNnZmlfZXhpdDoKIAljaWZz
X2ZyZWVfb3Blbl9pbmZvKCZkYXRhKTsKKwlmcmVlX2RlbnRyeV9wYXRoKHBhZ2UpOwogCWZyZWVf
eGlkKHhpZCk7CiAJcmV0dXJuIHJjOwogfQpAQCAtMTE3MSw2ICsxMTg0LDggQEAgc3RhdGljIGlu
dCBjaWZzX2dldF9mYXR0cihzdHJ1Y3QgY2lmc19vcGVuX2luZm9fZGF0YSAqZGF0YSwKIAkJfSBl
bHNlIHsKIAkJCWNpZnNfb3Blbl9pbmZvX3RvX2ZhdHRyKGZhdHRyLCBkYXRhLCBzYik7CiAJCX0K
KwkJaWYgKCFyYyAmJiBmYXR0ci0+Y2ZfZmxhZ3MgJiBDSUZTX0ZBVFRSX0RFTEVURV9QRU5ESU5H
KQorCQkJY2lmc19tYXJrX29wZW5faGFuZGxlc19mb3JfZGVsZXRlZF9maWxlKCppbm9kZSwgZnVs
bF9wYXRoKTsKIAkJYnJlYWs7CiAJY2FzZSAtRVJFTU9URToKIAkJLyogREZTIGxpbmssIG5vIG1l
dGFkYXRhIGF2YWlsYWJsZSBvbiB0aGlzIHNlcnZlciAqLwpAQCAtMTM5OSw2ICsxNDE0LDggQEAg
aW50IHNtYjMxMV9wb3NpeF9nZXRfaW5vZGVfaW5mbyhzdHJ1Y3QgaW5vZGUgKippbm9kZSwKIAkJ
Z290byBvdXQ7CiAKIAlyYyA9IHVwZGF0ZV9pbm9kZV9pbmZvKHNiLCAmZmF0dHIsIGlub2RlKTsK
KwlpZiAoIXJjICYmIGZhdHRyLmNmX2ZsYWdzICYgQ0lGU19GQVRUUl9ERUxFVEVfUEVORElORykK
KwkJY2lmc19tYXJrX29wZW5faGFuZGxlc19mb3JfZGVsZXRlZF9maWxlKCppbm9kZSwgZnVsbF9w
YXRoKTsKIG91dDoKIAlrZnJlZShmYXR0ci5jZl9zeW1saW5rX3RhcmdldCk7CiAJcmV0dXJuIHJj
OwpAQCAtMTU2MCw2ICsxNTc3LDkgQEAgc3RydWN0IGlub2RlICpjaWZzX3Jvb3RfaWdldChzdHJ1
Y3Qgc3VwZXJfYmxvY2sgKnNiKQogCQlnb3RvIG91dDsKIAl9CiAKKwlpZiAoIXJjICYmIGZhdHRy
LmNmX2ZsYWdzICYgQ0lGU19GQVRUUl9ERUxFVEVfUEVORElORykKKwkJY2lmc19tYXJrX29wZW5f
aGFuZGxlc19mb3JfZGVsZXRlZF9maWxlKGlub2RlLCBwYXRoKTsKKwogCWlmIChyYyAmJiB0Y29u
LT5waXBlKSB7CiAJCWNpZnNfZGJnKEZZSSwgImlwYyBjb25uZWN0aW9uIC0gZmFrZSByZWFkIGlu
b2RlXG4iKTsKIAkJc3Bpbl9sb2NrKCZpbm9kZS0+aV9sb2NrKTsKQEAgLTE4NTAsMTYgKzE4NzAs
MjAgQEAgaW50IGNpZnNfdW5saW5rKHN0cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3QgZGVudHJ5ICpk
ZW50cnkpCiAKIHBzeF9kZWxfbm9fcmV0cnk6CiAJaWYgKCFyYykgewotCQlpZiAoaW5vZGUpCisJ
CWlmIChpbm9kZSkgeworCQkJY2lmc19tYXJrX29wZW5faGFuZGxlc19mb3JfZGVsZXRlZF9maWxl
KGlub2RlLCBmdWxsX3BhdGgpOwogCQkJY2lmc19kcm9wX25saW5rKGlub2RlKTsKKwkJfQogCX0g
ZWxzZSBpZiAocmMgPT0gLUVOT0VOVCkgewogCQlkX2Ryb3AoZGVudHJ5KTsKIAl9IGVsc2UgaWYg
KHJjID09IC1FQlVTWSkgewogCQlpZiAoc2VydmVyLT5vcHMtPnJlbmFtZV9wZW5kaW5nX2RlbGV0
ZSkgewogCQkJcmMgPSBzZXJ2ZXItPm9wcy0+cmVuYW1lX3BlbmRpbmdfZGVsZXRlKGZ1bGxfcGF0
aCwKIAkJCQkJCQkJZGVudHJ5LCB4aWQpOwotCQkJaWYgKHJjID09IDApCisJCQlpZiAocmMgPT0g
MCkgeworCQkJCWNpZnNfbWFya19vcGVuX2hhbmRsZXNfZm9yX2RlbGV0ZWRfZmlsZShpbm9kZSwg
ZnVsbF9wYXRoKTsKIAkJCQljaWZzX2Ryb3BfbmxpbmsoaW5vZGUpOworCQkJfQogCQl9CiAJfSBl
bHNlIGlmICgocmMgPT0gLUVBQ0NFUykgJiYgKGRvc2F0dHIgPT0gMCkgJiYgaW5vZGUpIHsKIAkJ
YXR0cnMgPSBremFsbG9jKHNpemVvZigqYXR0cnMpLCBHRlBfS0VSTkVMKTsKZGlmZiAtLWdpdCBh
L2ZzL3NtYi9jbGllbnQvbWlzYy5jIGIvZnMvc21iL2NsaWVudC9taXNjLmMKaW5kZXggMDc0OGQ3
Yjc1N2I5Li45NDI4YTBkYjc3MTggMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9jbGllbnQvbWlzYy5jCisr
KyBiL2ZzL3NtYi9jbGllbnQvbWlzYy5jCkBAIC04NTMsNiArODUzLDQwIEBAIGNpZnNfY2xvc2Vf
ZGVmZXJyZWRfZmlsZV91bmRlcl9kZW50cnkoc3RydWN0IGNpZnNfdGNvbiAqdGNvbiwgY29uc3Qg
Y2hhciAqcGF0aCkKIAlmcmVlX2RlbnRyeV9wYXRoKHBhZ2UpOwogfQogCisvKgorICogSWYgYSBk
ZW50cnkgaGFzIGJlZW4gZGVsZXRlZCwgYWxsIGNvcnJlc3BvbmRpbmcgb3BlbiBoYW5kbGVzIHNo
b3VsZCBrbm93IHRoYXQKKyAqIHNvIHRoYXQgd2UgZG8gbm90IGRlZmVyIGNsb3NlIHRoZW0uCisg
Ki8KK3ZvaWQgY2lmc19tYXJrX29wZW5faGFuZGxlc19mb3JfZGVsZXRlZF9maWxlKHN0cnVjdCBp
bm9kZSAqaW5vZGUsCisJCQkJCSAgICAgY29uc3QgY2hhciAqcGF0aCkKK3sKKwlzdHJ1Y3QgY2lm
c0ZpbGVJbmZvICpjZmlsZTsKKwl2b2lkICpwYWdlOworCWNvbnN0IGNoYXIgKmZ1bGxfcGF0aDsK
KwlzdHJ1Y3QgY2lmc0lub2RlSW5mbyAqY2lub2RlID0gQ0lGU19JKGlub2RlKTsKKworCXBhZ2Ug
PSBhbGxvY19kZW50cnlfcGF0aCgpOworCXNwaW5fbG9jaygmY2lub2RlLT5vcGVuX2ZpbGVfbG9j
ayk7CisKKwkvKgorCSAqIG5vdGU6IHdlIG5lZWQgdG8gY29uc3RydWN0IHBhdGggZnJvbSBkZW50
cnkgYW5kIGNvbXBhcmUgb25seSBpZiB0aGUKKwkgKiBpbm9kZSBoYXMgYW55IGhhcmRsaW5rcy4g
V2hlbiBudW1iZXIgb2YgaGFyZGxpbmtzIGlzIDEsIHdlIGNhbiBqdXN0CisJICogbWFyayBhbGwg
b3BlbiBoYW5kbGVzIHNpbmNlIHRoZXkgYXJlIGdvaW5nIHRvIGJlIGZyb20gdGhlIHNhbWUgZmls
ZS4KKwkgKi8KKwlpZiAoaW5vZGUtPmlfbmxpbmsgPiAxKSB7CisJCWxpc3RfZm9yX2VhY2hfZW50
cnkoY2ZpbGUsICZjaW5vZGUtPm9wZW5GaWxlTGlzdCwgZmxpc3QpIHsKKwkJCWZ1bGxfcGF0aCA9
IGJ1aWxkX3BhdGhfZnJvbV9kZW50cnkoY2ZpbGUtPmRlbnRyeSwgcGFnZSk7CisJCQlpZiAoIUlT
X0VSUihmdWxsX3BhdGgpICYmIHN0cmNtcChmdWxsX3BhdGgsIHBhdGgpID09IDApCisJCQkJY2Zp
bGUtPnN0YXR1c19maWxlX2RlbGV0ZWQgPSB0cnVlOworCQl9CisJfSBlbHNlIHsKKwkJbGlzdF9m
b3JfZWFjaF9lbnRyeShjZmlsZSwgJmNpbm9kZS0+b3BlbkZpbGVMaXN0LCBmbGlzdCkKKwkJCWNm
aWxlLT5zdGF0dXNfZmlsZV9kZWxldGVkID0gdHJ1ZTsKKwl9CisJc3Bpbl91bmxvY2soJmNpbm9k
ZS0+b3Blbl9maWxlX2xvY2spOworCWZyZWVfZGVudHJ5X3BhdGgocGFnZSk7Cit9CisKIC8qIHBh
cnNlcyBERlMgcmVmZXJyYWwgVjMgc3RydWN0dXJlCiAgKiBjYWxsZXIgaXMgcmVzcG9uc2libGUg
Zm9yIGZyZWVpbmcgdGFyZ2V0X25vZGVzCiAgKiByZXR1cm5zOgpkaWZmIC0tZ2l0IGEvZnMvc21i
L2NsaWVudC9zbWIyaW5vZGUuYyBiL2ZzL3NtYi9jbGllbnQvc21iMmlub2RlLmMKaW5kZXggNjlm
MzQ0MmM1Yjk2Li40MjlkODNkMzEyODAgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9jbGllbnQvc21iMmlu
b2RlLmMKKysrIGIvZnMvc21iL2NsaWVudC9zbWIyaW5vZGUuYwpAQCAtNTYxLDggKzU2MSwxNSBA
QCBzdGF0aWMgaW50IHNtYjJfY29tcG91bmRfb3AoY29uc3QgdW5zaWduZWQgaW50IHhpZCwgc3Ry
dWN0IGNpZnNfdGNvbiAqdGNvbiwKIAkJY2FzZSBTTUIyX09QX0RFTEVURToKIAkJCWlmIChyYykK
IAkJCQl0cmFjZV9zbWIzX2RlbGV0ZV9lcnIoeGlkLCAgc2VzLT5TdWlkLCB0Y29uLT50aWQsIHJj
KTsKLQkJCWVsc2UKKwkJCWVsc2UgeworCQkJCS8qCisJCQkJICogSWYgZGVudHJ5IChoZW5jZSwg
aW5vZGUpIGlzIE5VTEwsIGxlYXNlIGJyZWFrIGlzIGdvaW5nIHRvCisJCQkJICogdGFrZSBjYXJl
IG9mIGRlZ3JhZGluZyBsZWFzZXMgb24gaGFuZGxlcyBmb3IgZGVsZXRlZCBmaWxlcy4KKwkJCQkg
Ki8KKwkJCQlpZiAoaW5vZGUpCisJCQkJCWNpZnNfbWFya19vcGVuX2hhbmRsZXNfZm9yX2RlbGV0
ZWRfZmlsZShpbm9kZSwgZnVsbF9wYXRoKTsKIAkJCQl0cmFjZV9zbWIzX2RlbGV0ZV9kb25lKHhp
ZCwgc2VzLT5TdWlkLCB0Y29uLT50aWQpOworCQkJfQogCQkJYnJlYWs7CiAJCWNhc2UgU01CMl9P
UF9NS0RJUjoKIAkJCWlmIChyYykKLS0gCjIuMzkuMgoK
--000000000000bc552d0613830f84--

