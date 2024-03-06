Return-Path: <linux-kernel+bounces-94056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5FB873933
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A3DBB230B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77C0133402;
	Wed,  6 Mar 2024 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="PDOM8VVm"
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC215B03B;
	Wed,  6 Mar 2024 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=167.235.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735523; cv=pass; b=K68HsiiXL4o0hQNp0vp4tlcGqeKKfYPrLizYxI6zV2dIC2WyeQAgnfbvDCoI/2fTb9tvZEloSxtYB+YNZwPoRnE/uDuC/HzBuF3SAtxSShG/KQdbikXT8KQi5sWkXFj/O/kn21UdW7Crcg5SjEs0EFJFH+79Yf6GDgg4tAwiexY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735523; c=relaxed/simple;
	bh=O5o5/OA7JuN94HF72oh+BTl554LZzCHZf0lK5td3uKg=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=rYG0F6wL8q+j4K30+bV/RGjTIVOduJcVRV3WfVhhdokhPmjbYYK+R9oaz5iT4hdz/Ddk3iZfcGrBLdMD+BWsK9LY5BL6XmFhSu0b11mNMaTqpNFEGwe3izM5vjJWi3NJj5ehnORyYoQt00XN/eEMlVOLv/f2evjbatjda1CcCes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=PDOM8VVm; arc=pass smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <8e729f88f285fefaa8a089da09484ed2@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1709735512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUsDDiQHbmberqEw7P+uyxdapk5dWId2FXk+DJYvkNo=;
	b=PDOM8VVmK+dA94QTLqGKu5HQNdyoDZErJzR4z7BH4pTmZ1yls9Ef78Gy0tQbhx3wki0jMQ
	bKokoSi01Z5mW5+5npMKEMmL0WZ2BXLqUzVtixzhKlIaTG/6daAvCPpmyZCdUzvKv096an
	E5nVjODhM1IV2Nj7xOHezrYDj7JYs7TJ176FaOep9KcdqmCqyJXUJk3jHXQpDE6YBbnmjm
	yTh9WA1WYxM0jOgAoPgeF/BiKlR5XQSoYDSomHj0XXFyFHf+igRb1DJeWtqfFK5gxzhP+p
	LAJnqx6n5v/4ZGyc2ootXMchCbwgsagaNJuIpw9Z6adcZGJ+v18d7ba6RZrojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1709735512; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUsDDiQHbmberqEw7P+uyxdapk5dWId2FXk+DJYvkNo=;
	b=o5+1wqzA4JcV+8ZVNtYjv0YS4jgozP0rk2FmEEtvkCbIX+6I5KxzyoS6kdfdkq5f+sFPjV
	l88XrkPm3hsmJXYRuC6RjbV39UTceTvFamOOmOoSJ3S8LdaRtpA5kyYZsESRM/NDKp4C8v
	atWWKd7i79vwnbFUBIepSFpBpikNnevsweRs/FkAEIAlxpd/m3j/ZajNeYUlpgWEpmql6g
	aaWREcA+9Di4/3Oaw9/RPplBcIyNa/U6jQXA33vPL/SyWGAOd+gpqler5reNbE+CgwbXaW
	ub8v72Q45Pr2KSEgf9C42sUcj5Blf+AttPO8PhqR2If4eA3ShcHsVXykn1iEjg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1709735512; a=rsa-sha256;
	cv=none;
	b=YkDDd74Db54F3nw6gr6hbVWeVbLjw2J9WdH4c/S63RZD/5XHDeCurWAsYCE1ub+oVbj+66
	orSjB9xLepIurz0hXubtrpXUy/75HvO3DuFxmdrxWTVgZVu38uOZd9HJiZmHqzRxwt2fVO
	H59SBZ0pZvUkJkCiNrsmw+2uJq2bDESP69FetvZfwCxQr5XHVYmO/va3sg+pj6V+SDx5ue
	C2oI3Uut6zn1b/IfKU8lC2iUwVU10ENmMR6ZlAYSfw/iy94SBW62KvsK/JvmbdaZ77NAed
	fSyIECGDUY+LholIRUbqnNvJnVOYZnzkOGx9hcaW6NFGm7PUeAPdw/9eydtFQQ==
From: Paulo Alcantara <pc@manguebit.com>
To: meetakshisetiyaoss@gmail.com, sfrench@samba.org,
 ronniesahlberg@gmail.com, sprasad@microsoft.com, nspmangalore@gmail.com,
 tom@talpey.com, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
 samba-technical@lists.samba.org, bharathsm.hsk@gmail.com
Cc: Meetakshi Setiya <msetiya@microsoft.com>
Subject: Re: [PATCH 2/3] smb: client: do not defer close open handles to
 deleted files
In-Reply-To: <20240306034353.190039-2-meetakshisetiyaoss@gmail.com>
References: <20240306034353.190039-1-meetakshisetiyaoss@gmail.com>
 <20240306034353.190039-2-meetakshisetiyaoss@gmail.com>
Date: Wed, 06 Mar 2024 11:31:48 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

meetakshisetiyaoss@gmail.com writes:

> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index b75282c204da..46951f403d31 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -483,6 +483,7 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
>  	cfile->uid = current_fsuid();
>  	cfile->dentry = dget(dentry);
>  	cfile->f_flags = file->f_flags;
> +	cfile->status_file_deleted = false;

This is unnecessary as @cfile is kzalloc()'d.

>  	cfile->invalidHandle = false;
>  	cfile->deferred_close_scheduled = false;
>  	cfile->tlink = cifs_get_tlink(tlink);
> @@ -1085,7 +1086,7 @@ int cifs_close(struct inode *inode, struct file *file)
>  		if ((cifs_sb->ctx->closetimeo && cinode->oplock == CIFS_CACHE_RHW_FLG)
>  		    && cinode->lease_granted &&
>  		    !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags) &&
> -		    dclose) {
> +		    dclose && !(cfile->status_file_deleted)) {
>  			if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &cinode->flags)) {
>  				inode_set_mtime_to_ts(inode,
>  						      inode_set_ctime_current(inode));
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index 3073eac989ea..3242e3b74386 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -893,6 +893,9 @@ cifs_get_file_info(struct file *filp)
>  	struct cifsFileInfo *cfile = filp->private_data;
>  	struct cifs_tcon *tcon = tlink_tcon(cfile->tlink);
>  	struct TCP_Server_Info *server = tcon->ses->server;
> +	struct dentry *dentry = filp->f_path.dentry;
> +	void *page = alloc_dentry_path();
> +	const unsigned char *path;
>  
>  	if (!server->ops->query_file_info)
>  		return -ENOSYS;

You're leaking @page if above condition is true.

> @@ -907,7 +910,14 @@ cifs_get_file_info(struct file *filp)
>  			data.symlink = true;
>  			data.reparse.tag = IO_REPARSE_TAG_SYMLINK;
>  		}
> +		path = build_path_from_dentry(dentry, page);
> +		if (IS_ERR(path)) {
> +			free_dentry_path(page);
> +			return PTR_ERR(path);

Now you're leaking @data and @fid if above condition is true.

> +		}
>  		cifs_open_info_to_fattr(&fattr, &data, inode->i_sb);
> +		if (fattr.cf_flags & CIFS_FATTR_DELETE_PENDING)
> +			cifs_mark_open_handles_for_deleted_file(inode, path);
>  		break;
>  	case -EREMOTE:
>  		cifs_create_junction_fattr(&fattr, inode->i_sb);
> @@ -937,6 +947,7 @@ cifs_get_file_info(struct file *filp)
>  	rc = cifs_fattr_to_inode(inode, &fattr);
>  cgfi_exit:
>  	cifs_free_open_info(&data);
> +	free_dentry_path(page);
>  	free_xid(xid);
>  	return rc;
>  }
> @@ -1075,6 +1086,7 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
>  	struct kvec rsp_iov, *iov = NULL;
>  	int rsp_buftype = CIFS_NO_BUFFER;
>  	u32 tag = data->reparse.tag;
> +	struct inode *inode = NULL;
>  	int rc = 0;
>  
>  	if (!tag && server->ops->query_reparse_point) {
> @@ -1114,8 +1126,12 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
>  
>  	if (tcon->posix_extensions)
>  		smb311_posix_info_to_fattr(fattr, data, sb);
> -	else
> +	else {
>  		cifs_open_info_to_fattr(fattr, data, sb);
> +		inode = cifs_iget(sb, fattr);
> +		if (inode && fattr->cf_flags & CIFS_FATTR_DELETE_PENDING)

You shouldn't ignore if cifs_iget() failed.  Return -ENOMEM instead.

Besides, calling cifs_iget() here looks wrong as @fattr is not fully
set, yet.  Why can't you use @inode from cifs_get_fattr() or do above
check right after cifs_get_fattr() in cifs_get_inode_info{,_unix}()?

