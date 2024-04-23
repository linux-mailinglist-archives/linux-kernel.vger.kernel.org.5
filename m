Return-Path: <linux-kernel+bounces-155770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B3C8AF6EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A443B2868ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C87613F459;
	Tue, 23 Apr 2024 18:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KakpBc77"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C14113DBB1;
	Tue, 23 Apr 2024 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713898665; cv=none; b=fYUJ89xNP7vPrePG1qDi34hmBCqoqMVA0KUBVLXRZan8wksA5CVna1SY8ORiU6j1PWHgqOogoWqx4PVqFwOj1j0VRtvJPD5c9aXZl58r2uNH6dZktsYwdI921k5qAIxBRyj6iDAIltzc+CwE/5bO2pMKBIH/zyXHc8YK0hDruew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713898665; c=relaxed/simple;
	bh=+2kzb4WKU7aALeByjwgZnAVJbH2zBMaXXdVsv6eW8vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3VRyec36na5cpgzEqcSDijffGpFlmzaN+AiT5za7ILcdNfnoPym7AtltWLeNhlGkOp4r2CeWw0q+dxKJtB6OjD180VUj+gs+7yAvdi85SkZnhg565IBNDofPWvzZWVa5I6A47fiXedgOiKsBtclyshwor1u72i2u5SpOfYzxY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KakpBc77; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso91652041fa.0;
        Tue, 23 Apr 2024 11:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713898662; x=1714503462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsPyp10OeuKCiKp5cBxCcE/H7nRREeJ5Tm8uW6q5gxA=;
        b=KakpBc77mbis/sxyVIZYH194CVo1hqeHzon+6ZMP8NHnvw1pahea4b22t2saztuZoy
         S1xmc6tkwW1HHDyGrYE9WhIFZBIzrMCJTBAvVYYDYi4grOfJVFusFgoXKte3TJUaRzq3
         w3Cx2j5dc7C+gsDCkZ4Ahfzu+byo2+/qDmNgX4no9rzGQn0O9MjloqWtFZgPO0yfptUC
         Me+B8sUTD8A+bBAYo+cNa1gAyqZsH1V1Ran+SYi1dHmLA2pBde3HpzcVg2zuyt78U99t
         O1YLR3WJGFNoCOWtVeUltTCD0aGY4n7VuvMjMc4qe8zMpXePBRQt76sw9WwK9Q+kS5O9
         b1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713898662; x=1714503462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsPyp10OeuKCiKp5cBxCcE/H7nRREeJ5Tm8uW6q5gxA=;
        b=nVlCQ9RCBOe1s9pK4XRiCYc2pG+l4jjHlZi11MckTfmufGHbFNbkjIJDi/TI2bgLC9
         aFboKtAtrZvaZLFvhLjU6gGWolEN/WVW8zGuLv9IwJlYBsAgB6TqkithHuFnh/fa0+hu
         2nagOd0stAqtnMlV3rB3kLZ9kB52RmT/odMRQ8RO+8llemxw/mxabY6h+6o1tUzGQU0H
         cAkooE2ZqQW9SlKd18RLjCi3CuIQJCv9IJUhQQ2GQY5b+yucG5N6oRDMbLSZyxH14Y2j
         5CNjK4ygYsOHDYY4MOpkujei7JgatS/6H22o1o8tb28iaQZjyTwW3T7BtLbEqt3j2ipo
         76Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWULU8E+qlbUPFE7wSJ3Qzf/luQYT/vzTsGQaTW+9nttyvDe87V31Ked7rtAclk4/NexhClpT2FoLRJm+1PnwsJcwo05nJsQOLLoRuq9HkOZqrNS4hS7MnaxW7dUQEmQq8pKw==
X-Gm-Message-State: AOJu0YxBvtvwnrjCqfJoxluXRHSGzn4Cub3T+lU3uxLgnQ5LPEDcPHtX
	+CxUINwAHjKW6I+xq82LI93WUSKJ3CzQ0zOLbwNn3WChrTovs//ASPdkU57vXs0mXYWONsPKP8a
	GAO6VGe1HMMz1cpKuyF8jUFC9veg=
X-Google-Smtp-Source: AGHT+IHyUbgmTQf8WX/KSODwBX8UO62Tz1THto0rGm8zXU1bsDSgxeFNTae5Mwrjovdr+Z0pnTT4lcY1hnZFn8QvvTo=
X-Received: by 2002:a2e:be8c:0:b0:2da:78e:f766 with SMTP id
 a12-20020a2ebe8c000000b002da078ef766mr94273ljr.38.1713898661255; Tue, 23 Apr
 2024 11:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204203514.2093855-1-sashal@kernel.org> <20231204203514.2093855-15-sashal@kernel.org>
In-Reply-To: <20231204203514.2093855-15-sashal@kernel.org>
From: Steve French <smfrench@gmail.com>
Date: Tue, 23 Apr 2024 13:57:29 -0500
Message-ID: <CAH2r5mt2gwyyAqotBv5U1esJQggGUbz8_J=6k_Z69X2dRRK8Ug@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.1 15/17] smb: client, common: fix fortify warnings
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Dmitry Antipov <dmantipov@yandex.ru>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <stfrench@microsoft.com>, sfrench@samba.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Note that kernels that backported this fix will also need this ksmbd
fix (fixes a bug when Macs mount to ksmbd)

commit 0268a7cc7fdc47d90b6c18859de7718d5059f6f1
Author: Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri Apr 19 23:46:34 2024 +0900

    ksmbd: common: use struct_group_attr instead of struct_group for
network_open_info

    4byte padding cause the connection issue with the applications of MacOS=
.
    smb2_close response size increases by 4 bytes by padding, And the smb
    client of MacOS check it and stop the connection. This patch use
    struct_group_attr instead of struct_group for network_open_info to use
     __packed to avoid padding.

    Fixes: 0015eb6e1238 ("smb: client, common: fix fortify warnings")
    Cc: stable@vger.kernel.org
    Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
    Signed-off-by: Steve French <stfrench@microsoft.com>

On Mon, Dec 4, 2023 at 2:36=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Dmitry Antipov <dmantipov@yandex.ru>
>
> [ Upstream commit 0015eb6e12384ff1c589928e84deac2ad1ceb236 ]
>
> When compiling with gcc version 14.0.0 20231126 (experimental)
> and CONFIG_FORTIFY_SOURCE=3Dy, I've noticed the following:
>
> In file included from ./include/linux/string.h:295,
>                  from ./include/linux/bitmap.h:12,
>                  from ./include/linux/cpumask.h:12,
>                  from ./arch/x86/include/asm/paravirt.h:17,
>                  from ./arch/x86/include/asm/cpuid.h:62,
>                  from ./arch/x86/include/asm/processor.h:19,
>                  from ./arch/x86/include/asm/cpufeature.h:5,
>                  from ./arch/x86/include/asm/thread_info.h:53,
>                  from ./include/linux/thread_info.h:60,
>                  from ./arch/x86/include/asm/preempt.h:9,
>                  from ./include/linux/preempt.h:79,
>                  from ./include/linux/spinlock.h:56,
>                  from ./include/linux/wait.h:9,
>                  from ./include/linux/wait_bit.h:8,
>                  from ./include/linux/fs.h:6,
>                  from fs/smb/client/smb2pdu.c:18:
> In function 'fortify_memcpy_chk',
>     inlined from '__SMB2_close' at fs/smb/client/smb2pdu.c:3480:4:
> ./include/linux/fortify-string.h:588:25: warning: call to '__read_overflo=
w2_field'
> declared with attribute warning: detected read beyond size of field (2nd =
parameter);
> maybe use struct_group()? [-Wattribute-warning]
>   588 |                         __read_overflow2_field(q_size_field, size=
);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
>
> and:
>
> In file included from ./include/linux/string.h:295,
>                  from ./include/linux/bitmap.h:12,
>                  from ./include/linux/cpumask.h:12,
>                  from ./arch/x86/include/asm/paravirt.h:17,
>                  from ./arch/x86/include/asm/cpuid.h:62,
>                  from ./arch/x86/include/asm/processor.h:19,
>                  from ./arch/x86/include/asm/cpufeature.h:5,
>                  from ./arch/x86/include/asm/thread_info.h:53,
>                  from ./include/linux/thread_info.h:60,
>                  from ./arch/x86/include/asm/preempt.h:9,
>                  from ./include/linux/preempt.h:79,
>                  from ./include/linux/spinlock.h:56,
>                  from ./include/linux/wait.h:9,
>                  from ./include/linux/wait_bit.h:8,
>                  from ./include/linux/fs.h:6,
>                  from fs/smb/client/cifssmb.c:17:
> In function 'fortify_memcpy_chk',
>     inlined from 'CIFS_open' at fs/smb/client/cifssmb.c:1248:3:
> ./include/linux/fortify-string.h:588:25: warning: call to '__read_overflo=
w2_field'
> declared with attribute warning: detected read beyond size of field (2nd =
parameter);
> maybe use struct_group()? [-Wattribute-warning]
>   588 |                         __read_overflow2_field(q_size_field, size=
);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
>
> In both cases, the fortification logic inteprets calls to 'memcpy()' as a=
n
> attempts to copy an amount of data which exceeds the size of the specifie=
d
> field (i.e. more than 8 bytes from __le64 value) and thus issues an overr=
ead
> warning. Both of these warnings may be silenced by using the convenient
> 'struct_group()' quirk.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/smb/client/cifspdu.h | 24 ++++++++++++++----------
>  fs/smb/client/cifssmb.c |  6 ++++--
>  fs/smb/client/smb2pdu.c |  8 +++-----
>  fs/smb/client/smb2pdu.h | 16 +++++++++-------
>  fs/smb/common/smb2pdu.h | 17 ++++++++++-------
>  5 files changed, 40 insertions(+), 31 deletions(-)
>
> diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
> index c403816d0b6c1..97bb1838555b4 100644
> --- a/fs/smb/client/cifspdu.h
> +++ b/fs/smb/client/cifspdu.h
> @@ -882,11 +882,13 @@ typedef struct smb_com_open_rsp {
>         __u8 OplockLevel;
>         __u16 Fid;
>         __le32 CreateAction;
> -       __le64 CreationTime;
> -       __le64 LastAccessTime;
> -       __le64 LastWriteTime;
> -       __le64 ChangeTime;
> -       __le32 FileAttributes;
> +       struct_group(common_attributes,
> +               __le64 CreationTime;
> +               __le64 LastAccessTime;
> +               __le64 LastWriteTime;
> +               __le64 ChangeTime;
> +               __le32 FileAttributes;
> +       );
>         __le64 AllocationSize;
>         __le64 EndOfFile;
>         __le16 FileType;
> @@ -2268,11 +2270,13 @@ typedef struct {
>  /* QueryFileInfo/QueryPathinfo (also for SetPath/SetFile) data buffer fo=
rmats */
>  /***********************************************************************=
*******/
>  typedef struct { /* data block encoding of response to level 263 QPathIn=
fo */
> -       __le64 CreationTime;
> -       __le64 LastAccessTime;
> -       __le64 LastWriteTime;
> -       __le64 ChangeTime;
> -       __le32 Attributes;
> +       struct_group(common_attributes,
> +               __le64 CreationTime;
> +               __le64 LastAccessTime;
> +               __le64 LastWriteTime;
> +               __le64 ChangeTime;
> +               __le32 Attributes;
> +       );
>         __u32 Pad1;
>         __le64 AllocationSize;
>         __le64 EndOfFile;       /* size ie offset to first free byte in f=
ile */
> diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
> index c90d4ec9292ca..67c5fc2b2db94 100644
> --- a/fs/smb/client/cifssmb.c
> +++ b/fs/smb/client/cifssmb.c
> @@ -1234,8 +1234,10 @@ CIFS_open(const unsigned int xid, struct cifs_open=
_parms *oparms, int *oplock,
>                 *oplock |=3D CIFS_CREATE_ACTION;
>
>         if (buf) {
> -               /* copy from CreationTime to Attributes */
> -               memcpy((char *)buf, (char *)&rsp->CreationTime, 36);
> +               /* copy commonly used attributes */
> +               memcpy(&buf->common_attributes,
> +                      &rsp->common_attributes,
> +                      sizeof(buf->common_attributes));
>                 /* the file_info buf is endian converted by caller */
>                 buf->AllocationSize =3D rsp->AllocationSize;
>                 buf->EndOfFile =3D rsp->EndOfFile;
> diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> index 847d69d327c2a..aea7770fb5631 100644
> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@ -3425,12 +3425,10 @@ __SMB2_close(const unsigned int xid, struct cifs_=
tcon *tcon,
>         } else {
>                 trace_smb3_close_done(xid, persistent_fid, tcon->tid,
>                                       ses->Suid);
> -               /*
> -                * Note that have to subtract 4 since struct network_open=
_info
> -                * has a final 4 byte pad that close response does not ha=
ve
> -                */
>                 if (pbuf)
> -                       memcpy(pbuf, (char *)&rsp->CreationTime, sizeof(*=
pbuf) - 4);
> +                       memcpy(&pbuf->network_open_info,
> +                              &rsp->network_open_info,
> +                              sizeof(pbuf->network_open_info));
>         }
>
>         atomic_dec(&tcon->num_remote_opens);
> diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
> index 1237bb86e93a8..8ac99563487c1 100644
> --- a/fs/smb/client/smb2pdu.h
> +++ b/fs/smb/client/smb2pdu.h
> @@ -339,13 +339,15 @@ struct smb2_file_reparse_point_info {
>  } __packed;
>
>  struct smb2_file_network_open_info {
> -       __le64 CreationTime;
> -       __le64 LastAccessTime;
> -       __le64 LastWriteTime;
> -       __le64 ChangeTime;
> -       __le64 AllocationSize;
> -       __le64 EndOfFile;
> -       __le32 Attributes;
> +       struct_group(network_open_info,
> +               __le64 CreationTime;
> +               __le64 LastAccessTime;
> +               __le64 LastWriteTime;
> +               __le64 ChangeTime;
> +               __le64 AllocationSize;
> +               __le64 EndOfFile;
> +               __le32 Attributes;
> +       );
>         __le32 Reserved;
>  } __packed; /* level 34 Query also similar returned in close rsp and ope=
n rsp */
>
> diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
> index 9619015d78f29..778c1e3b70bc1 100644
> --- a/fs/smb/common/smb2pdu.h
> +++ b/fs/smb/common/smb2pdu.h
> @@ -699,13 +699,16 @@ struct smb2_close_rsp {
>         __le16 StructureSize; /* 60 */
>         __le16 Flags;
>         __le32 Reserved;
> -       __le64 CreationTime;
> -       __le64 LastAccessTime;
> -       __le64 LastWriteTime;
> -       __le64 ChangeTime;
> -       __le64 AllocationSize;  /* Beginning of FILE_STANDARD_INFO equiva=
lent */
> -       __le64 EndOfFile;
> -       __le32 Attributes;
> +       struct_group(network_open_info,
> +               __le64 CreationTime;
> +               __le64 LastAccessTime;
> +               __le64 LastWriteTime;
> +               __le64 ChangeTime;
> +               /* Beginning of FILE_STANDARD_INFO equivalent */
> +               __le64 AllocationSize;
> +               __le64 EndOfFile;
> +               __le32 Attributes;
> +       );
>  } __packed;
>
>
> --
> 2.42.0
>
>


--=20
Thanks,

Steve

