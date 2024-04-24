Return-Path: <linux-kernel+bounces-156274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 553AB8B00A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16DE2282236
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADC1152E0E;
	Wed, 24 Apr 2024 04:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2MSAfj3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F27C28EB;
	Wed, 24 Apr 2024 04:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713933407; cv=none; b=mdXWdiRGrUh0mpWrVHfnwKXVlAdH4+CT6QjGrki/1QXQA8vMqGVqBL/WMPiSaQrtUpwXLltjzcW3mO7D9dDNTo2OE7LTEu64LR9nzBlX9GwynBdoBOj7QrTDNoDFKsyTK43RKz+T548plDaUrF6H1TUqJebCOAvax8FAlArwFa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713933407; c=relaxed/simple;
	bh=tuSpJeVelX2QtRfHSrv0QUZCsOHtMcWqiSaVBdtewZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zy3WeB0cToJm4J7IG2g+J4A7SaosMUfeod+EuZAtNOhDI7HzIKtMdDjnHAeqkSK+BQMWzKn5b7Us/x0Y1nNPCTV3+jiYLEkLtNECVSaiO6Qop5V4zatx1mEblz6DeO5O+r0Z9xdCHD8n+x+i5g8UedtUmunY9+pSFlrmwXnvNf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2MSAfj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3D0C32781;
	Wed, 24 Apr 2024 04:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713933406;
	bh=tuSpJeVelX2QtRfHSrv0QUZCsOHtMcWqiSaVBdtewZI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q2MSAfj3yxayUF9+Oz8+JlsgGXN7IugQC+IWyMJW76V4XmJwGE6Y6RXp5Q9CDGMZC
	 UngAqVu0X04kCxtyWogsQidX1VMkPGQqV8ccMEo5A64U6sd1a5a0EzgIfXDKTNWCMR
	 XzUsIn31WgWGCj1y4OzP+Iiux5QHbIofabX27g6k+IC+HjxGJICiqSOBUsxggec+Zk
	 +41oKkeyQe9RV01ZdXuy/o1y4g/ooHMDQjVAzIe5GySSXb0Sebm8nSj37voIq2SZP+
	 h6V7Nc8sKOehDY0hi/HNFSC0XrYq7xsv+6Mr6xx06bpiIkj5DjgfODuEo8jkOQJLWO
	 1/fQ4w8raZANA==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5af2358c7e5so1550172eaf.0;
        Tue, 23 Apr 2024 21:36:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHmwBXA1N/b5ptKpsNMqDyFfCUG56YYdB3HPDSQ4hLUxyPDDtRtubNnzxXyUNMGBnOYY9osU4K3STTCo/jeQ+imjp16hkV9GXxSu5Sx4e4Pqzm/si/EGul1eQZGcsVRIhRX607Y9XapjEfMvjxX+WhF5TrHEBc8C5d2agA2FZObRYozuOenemUpQ==
X-Gm-Message-State: AOJu0YydQk2IBcGjuN62zBDr4rNjFe4V6sjDLK2yOYA9Gmy/Sy7W85vY
	x8DX+X+0aMC3matQrnEGW0NKzGV4XP2a0XI0V9jfZLoMFwHl3mtrV+EaY0pZt1xWHo86XSqrgV1
	Vdi9o7147ZbxnQ7tunlEu9QN6Ybw=
X-Google-Smtp-Source: AGHT+IEg0W5Eme7ZwqVBNJB+djHMHMyVJwSm+D3dx88b5Z7CAy1prCkiEaSrwPv8JwvaqQt/nWjqOmAvcDEiczmpQmc=
X-Received: by 2002:a4a:987:0:b0:5ac:9efc:3b02 with SMTP id
 129-20020a4a0987000000b005ac9efc3b02mr1251950ooa.8.1713933405856; Tue, 23 Apr
 2024 21:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZihxUuQOkZ6Zz363@neat>
In-Reply-To: <ZihxUuQOkZ6Zz363@neat>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 24 Apr 2024 13:36:34 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-i3Fjv-7JmQa8bSrWD69yFfi8jqfBJV51JgyseA-yXFQ@mail.gmail.com>
Message-ID: <CAKYAXd-i3Fjv-7JmQa8bSrWD69yFfi8jqfBJV51JgyseA-yXFQ@mail.gmail.com>
Subject: Re: [PATCH][next] smb: client: Fix struct_group() usage in __packed structs
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Dmitry Antipov <dmantipov@yandex.ru>, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 4=EC=9B=94 24=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 11:41, =
Gustavo A. R. Silva <gustavoars@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> Use struct_group_attr() in __packed structs, instead of struct_group().
>
> Below you can see the pahole output before/after changes:
>
> pahole -C smb2_file_network_open_info fs/smb/client/smb2ops.o
> struct smb2_file_network_open_info {
>         union {
>                 struct {
>                         __le64     CreationTime;         /*     0     8 *=
/
>                         __le64     LastAccessTime;       /*     8     8 *=
/
>                         __le64     LastWriteTime;        /*    16     8 *=
/
>                         __le64     ChangeTime;           /*    24     8 *=
/
>                         __le64     AllocationSize;       /*    32     8 *=
/
>                         __le64     EndOfFile;            /*    40     8 *=
/
>                         __le32     Attributes;           /*    48     4 *=
/
>                 };                                       /*     0    56 *=
/
>                 struct {
>                         __le64     CreationTime;         /*     0     8 *=
/
>                         __le64     LastAccessTime;       /*     8     8 *=
/
>                         __le64     LastWriteTime;        /*    16     8 *=
/
>                         __le64     ChangeTime;           /*    24     8 *=
/
>                         __le64     AllocationSize;       /*    32     8 *=
/
>                         __le64     EndOfFile;            /*    40     8 *=
/
>                         __le32     Attributes;           /*    48     4 *=
/
>                 } network_open_info;                     /*     0    56 *=
/
>         };                                               /*     0    56 *=
/
>         __le32                     Reserved;             /*    56     4 *=
/
>
>         /* size: 60, cachelines: 1, members: 2 */
>         /* last cacheline: 60 bytes */
> } __attribute__((__packed__));
>
> pahole -C smb2_file_network_open_info fs/smb/client/smb2ops.o
> struct smb2_file_network_open_info {
>         union {
>                 struct {
>                         __le64     CreationTime;         /*     0     8 *=
/
>                         __le64     LastAccessTime;       /*     8     8 *=
/
>                         __le64     LastWriteTime;        /*    16     8 *=
/
>                         __le64     ChangeTime;           /*    24     8 *=
/
>                         __le64     AllocationSize;       /*    32     8 *=
/
>                         __le64     EndOfFile;            /*    40     8 *=
/
>                         __le32     Attributes;           /*    48     4 *=
/
>                 } __attribute__((__packed__));           /*     0    52 *=
/
>                 struct {
>                         __le64     CreationTime;         /*     0     8 *=
/
>                         __le64     LastAccessTime;       /*     8     8 *=
/
>                         __le64     LastWriteTime;        /*    16     8 *=
/
>                         __le64     ChangeTime;           /*    24     8 *=
/
>                         __le64     AllocationSize;       /*    32     8 *=
/
>                         __le64     EndOfFile;            /*    40     8 *=
/
>                         __le32     Attributes;           /*    48     4 *=
/
>                 } __attribute__((__packed__)) network_open_info;       /*=
     0    52 */
>         };                                               /*     0    52 *=
/
>         __le32                     Reserved;             /*    52     4 *=
/
>
>         /* size: 56, cachelines: 1, members: 2 */
>         /* last cacheline: 56 bytes */
> };
>
> pahole -C smb_com_open_rsp fs/smb/client/cifssmb.o
> struct smb_com_open_rsp {
>         ...
>
>         union {
>                 struct {
>                         __le64     CreationTime;         /*    48     8 *=
/
>                         __le64     LastAccessTime;       /*    56     8 *=
/
>                         /* --- cacheline 1 boundary (64 bytes) --- */
>                         __le64     LastWriteTime;        /*    64     8 *=
/
>                         __le64     ChangeTime;           /*    72     8 *=
/
>                         __le32     FileAttributes;       /*    80     4 *=
/
>                 };                                       /*    48    40 *=
/
>                 struct {
>                         __le64     CreationTime;         /*    48     8 *=
/
>                         __le64     LastAccessTime;       /*    56     8 *=
/
>                         /* --- cacheline 1 boundary (64 bytes) --- */
>                         __le64     LastWriteTime;        /*    64     8 *=
/
>                         __le64     ChangeTime;           /*    72     8 *=
/
>                         __le32     FileAttributes;       /*    80     4 *=
/
>                 } common_attributes;                     /*    48    40 *=
/
>         };                                               /*    48    40 *=
/
>
>         ...
>
>         /* size: 111, cachelines: 2, members: 14 */
>         /* last cacheline: 47 bytes */
> } __attribute__((__packed__));
>
> pahole -C smb_com_open_rsp fs/smb/client/cifssmb.o
> struct smb_com_open_rsp {
>         ...
>
>         union {
>                 struct {
>                         __le64     CreationTime;         /*    48     8 *=
/
>                         __le64     LastAccessTime;       /*    56     8 *=
/
>                         /* --- cacheline 1 boundary (64 bytes) --- */
>                         __le64     LastWriteTime;        /*    64     8 *=
/
>                         __le64     ChangeTime;           /*    72     8 *=
/
>                         __le32     FileAttributes;       /*    80     4 *=
/
>                 } __attribute__((__packed__));           /*    48    36 *=
/
>                 struct {
>                         __le64     CreationTime;         /*    48     8 *=
/
>                         __le64     LastAccessTime;       /*    56     8 *=
/
>                         /* --- cacheline 1 boundary (64 bytes) --- */
>                         __le64     LastWriteTime;        /*    64     8 *=
/
>                         __le64     ChangeTime;           /*    72     8 *=
/
>                         __le32     FileAttributes;       /*    80     4 *=
/
>                 } __attribute__((__packed__)) common_attributes;       /*=
    48    36 */
>         };                                               /*    48    36 *=
/
>
>         ...
>
>         /* size: 107, cachelines: 2, members: 14 */
>         /* last cacheline: 43 bytes */
> } __attribute__((__packed__));
>
> pahole -C FILE_ALL_INFO fs/smb/client/cifssmb.o
> typedef struct {
>         union {
>                 struct {
>                         __le64     CreationTime;         /*     0     8 *=
/
>                         __le64     LastAccessTime;       /*     8     8 *=
/
>                         __le64     LastWriteTime;        /*    16     8 *=
/
>                         __le64     ChangeTime;           /*    24     8 *=
/
>                         __le32     Attributes;           /*    32     4 *=
/
>                 };                                       /*     0    40 *=
/
>                 struct {
>                         __le64     CreationTime;         /*     0     8 *=
/
>                         __le64     LastAccessTime;       /*     8     8 *=
/
>                         __le64     LastWriteTime;        /*    16     8 *=
/
>                         __le64     ChangeTime;           /*    24     8 *=
/
>                         __le32     Attributes;           /*    32     4 *=
/
>                 } common_attributes;                     /*     0    40 *=
/
>         };                                               /*     0    40 *=
/
>
>         ...
>
>         /* size: 113, cachelines: 2, members: 17 */
>         /* last cacheline: 49 bytes */
> } __attribute__((__packed__)) FILE_ALL_INFO;
>
> pahole -C FILE_ALL_INFO fs/smb/client/cifssmb.o
> typedef struct {
>         union {
>                 struct {
>                         __le64     CreationTime;         /*     0     8 *=
/
>                         __le64     LastAccessTime;       /*     8     8 *=
/
>                         __le64     LastWriteTime;        /*    16     8 *=
/
>                         __le64     ChangeTime;           /*    24     8 *=
/
>                         __le32     Attributes;           /*    32     4 *=
/
>                 } __attribute__((__packed__));           /*     0    36 *=
/
>                 struct {
>                         __le64     CreationTime;         /*     0     8 *=
/
>                         __le64     LastAccessTime;       /*     8     8 *=
/
>                         __le64     LastWriteTime;        /*    16     8 *=
/
>                         __le64     ChangeTime;           /*    24     8 *=
/
>                         __le32     Attributes;           /*    32     4 *=
/
>                 } __attribute__((__packed__)) common_attributes;       /*=
     0    36 */
>         };                                               /*     0    36 *=
/
>
>         ...
>
>         /* size: 109, cachelines: 2, members: 17 */
>         /* last

cacheline: 45 bytes */
> } __attribute__((__packed__)) FILE_ALL_INFO;
>
> Fixes: 0015eb6e1238 ("smb: client, common: fix fortify warnings")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Looks good to me:)
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!

