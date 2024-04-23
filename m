Return-Path: <linux-kernel+bounces-155906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFB18AF8C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786F61F2609E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE414143866;
	Tue, 23 Apr 2024 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEHoa3cY"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81899142E85;
	Tue, 23 Apr 2024 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713906587; cv=none; b=XdCdqCtsJCm8udQBz53qHep0oX1V0JZ8JRGuDzIahK8pGShQToufAVqF31uemhF75i4wyciOLiRNo4huBHflr7X5c2w5hkvK9G3ttERTudtXhCc94igxpgmZSneqkt00Y4HyzAw3/xirE9DG6s7zoTwIRFz03aaboilvaYv+8lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713906587; c=relaxed/simple;
	bh=OS/kiw3paiAp2FnzXjw7/gldN7plhyYEwX8wXMyv5oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjgYdSwPUaH9s0sFl1D73xCi1y3KS33XctdKm5ava3nHIAVi+GoihUIeVIFTPJN2KVBPSfoqnJz64f+w1nU4fL/D5cX1Ac7ifp5uUwg+gf9CtUD1Q62W9x8Dp3ye1/0WVN3B7bwcoNfERz0zPbsO6XZGqqx3mIKR+kh7AvNNOWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEHoa3cY; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51b526f0fc4so3252645e87.1;
        Tue, 23 Apr 2024 14:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713906584; x=1714511384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z00xUgDb7chJiSdcTQzc2Jdww5uooukkIxk0IVOAZpE=;
        b=KEHoa3cYX1hWUZ2iZpi8kTBn5hMtJXDswqMs0W931zhGzDu33EDrQNQ8cmtOzySbp+
         nWjEqGEAuj9ufFvXB8Uc1b2JS7oSnL8M20hbG6ezletyb8GT8Owq1jkZjXUSoDMrMz0c
         1iQrMVOm+YypfUZsRgQ3hmCcmLRxQp5KXS5Q38XU/w4Gp2i1bGIovv3HinSdV7MiXpgg
         De3ICT6O3iZH8Bq1/wOO8dnyQRHsRqyRH2D0nXWX/sZNHOHda/nvbSL/LtEa0hOxAVJ6
         2HJUtYSPOyexgkRtC0tRNW1k9letGt6qEMp4Mm5kGR7Q0SqrBymiYPCpLCHh1/TY9BPS
         m8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713906584; x=1714511384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z00xUgDb7chJiSdcTQzc2Jdww5uooukkIxk0IVOAZpE=;
        b=LB/FxuXY467UV36kfsJ6M7lnnZFeOEBIzQIFRUmjJid0kWTSoNdTTaY03c3CB0q+UH
         5bOiC21SPPnxxcfQN3oj1clHaCacIcAqL7gVGRLp34vDr/Fp3AgaG4qG87cmrneuJUc3
         SsixGwBqQ7bTnIYMq6I3pDiqm8moag0tDN9wPBObgA52LrRNrMbdVmJbI8E8f35gVcSY
         TtMCCgAaprapYUCkP5dDhLXGqRpwuat1Eq0tw00+sv29JaDefCP4q8fXAdTL/4BY6qwc
         jJQcaAX0cBRpgze1QLFs/A2urnCN6srLi54aB8HkKnn0lbUHigkuQOBMh1XU+eh+ZyNC
         Saiw==
X-Forwarded-Encrypted: i=1; AJvYcCW7h1lFbtmazjP7yzBO+N8JWEQWdTGr1vkJpJw24iWzOWDOS84jUylH/b6UG0xE6PjgtUDabcidqtDbbhALkk90ijaYKVN6QT3DAaovGW/d7SHasDkZEzRLBpZ7rTU3eZQTlEdVOVXcbNyIHSKTxgESFxfYyLc6FSiVpe4IAfwjq2s/C+IZ3+tYuQ==
X-Gm-Message-State: AOJu0Yx/XEXZvP9nfZgG4XXAbabXMdDDt4OejMufoThXo18FAoNAn/ZE
	CKkTWS/YRm2jNXssE4PrJOZVxKeEXEr54Def/1JiWCXMzjBhsgQcBfRvA5cPiXm+0boU9LZt4tt
	CJbXWHwFF/N0Pq3JK/6VVFC0cxOU=
X-Google-Smtp-Source: AGHT+IGlJ8JGtkqwp0zGdANEDF7fFC0jTyWBeb4YVmcV0DWc0EGiRhw+7DSM8rqxmpo7JXL54TpqRRY19ENMrOMLnFs=
X-Received: by 2002:ac2:48b0:0:b0:515:d135:68f2 with SMTP id
 u16-20020ac248b0000000b00515d13568f2mr438335lfg.53.1713906583391; Tue, 23 Apr
 2024 14:09:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZhgDTj1nwLEtSd9h@neat> <1166494b-3e34-4919-9998-141540a948b3@embeddedor.com>
 <CAH2r5msZaV1kHqQw8Sb_3wQfGBj4aU+tSCR5E0YJ8fCH6ODB4Q@mail.gmail.com> <7789881d-a709-48f4-8c14-259acbce813a@embeddedor.com>
In-Reply-To: <7789881d-a709-48f4-8c14-259acbce813a@embeddedor.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 23 Apr 2024 16:09:32 -0500
Message-ID: <CAH2r5mu=HYqSnT3j=mdLA7XPyha5A27tBqzJcEZfMAU-yLunbA@mail.gmail.com>
Subject: Re: [PATCH][next] smb: smb2pdu.h: Avoid -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 3:48=E2=80=AFPM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
>
> On 23/04/24 14:15, Steve French wrote:
> > This looks reasonably safe (running the usual regression tests on it no=
w).
> >
> > Reminds me though that we have to be careful (e.g. the recent fix for
> > regression caused by cleanup).
>
> mmh... it seems that the offending commit was never CC'd to the linux-har=
dening
> list, hence it wasn't reviewed by us.
>
> After reviewing both, the offending commit and the fix, both seem to be w=
rong.
>
> for __packed structs, you should use __struct_group():
>
> __struct_group(network_open_info, group_name, __packed, struct_members);
>
> The _packed in the commit 0268a7cc7fdc is not an attribute, it's the name
> for the group. So, it's not actually doing what the submitter thinks it d=
oes.

Do you want to submit a followup fix to fix this?  Or let Namjae fix it?





> > Thoughts about whether should be sent in rc6 or wait till 6.10?  51
> > warnings does sound
> > distracting though so might be worth going in sooner rather than later.
>
> There is actually no hurry. :)
>
> Thanks
> --
> Gustavo
>
> >
> > commit 0268a7cc7fdc47d90b6c18859de7718d5059f6f1
> > Author: Namjae Jeon <linkinjeon@kernel.org>
> > Date:   Fri Apr 19 23:46:34 2024 +0900
> >
> >      ksmbd: common: use struct_group_attr instead of struct_group for
> > network_open_info
> >
> >      4byte padding cause the connection issue with the applications of =
MacOS.
> >      smb2_close response size increases by 4 bytes by padding, And the =
smb
> >      client of MacOS check it and stop the connection. This patch use
> >      struct_group_attr instead of struct_group for network_open_info to=
 use
> >       __packed to avoid padding.
> >
> >
> > On Tue, Apr 23, 2024 at 1:58=E2=80=AFPM Gustavo A. R. Silva
> > <gustavo@embeddedor.com> wrote:
> >>
> >> Hi all,
> >>
> >> Friendly ping: who can take this, please?
> >>
> >> Thanks
> >> --
> >> Gustavo
> >>
> >> On 11/04/24 09:35, Gustavo A. R. Silva wrote:
> >>> -Wflex-array-member-not-at-end is coming in GCC-14, and we are gettin=
g
> >>> ready to enable it globally.
> >>>
> >>> So, in order to avoid ending up with a flexible-array member in the
> >>> middle of multiple other structs, we use the `__struct_group()` helpe=
r
> >>> to separate the flexible array from the rest of the members in the
> >>> flexible structure, and use the tagged `struct create_context_hdr`
> >>> instead of `struct create_context`.
> >>>
> >>> So, with these changes, fix 51 of the following warnings[1]:
> >>>
> >>> fs/smb/client/../common/smb2pdu.h:1225:31: warning: structure contain=
ing a flexible array member is not at the end of another structure [-Wflex-=
array-member-not-at-end]
> >>>
> >>> Link: https://gist.github.com/GustavoARSilva/772526a39be3dd4db39e7149=
7f0a9893 [1]
> >>> Link: https://github.com/KSPP/linux/issues/202
> >>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >>> ---
> >>>    fs/smb/client/smb2pdu.h | 12 ++++++------
> >>>    fs/smb/common/smb2pdu.h | 33 ++++++++++++++++++---------------
> >>>    fs/smb/server/smb2pdu.h | 18 +++++++++---------
> >>>    3 files changed, 33 insertions(+), 30 deletions(-)
> >>>
> >>> diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
> >>> index c72a3b2886b7..1a02bd9e0c00 100644
> >>> --- a/fs/smb/client/smb2pdu.h
> >>> +++ b/fs/smb/client/smb2pdu.h
> >>> @@ -145,7 +145,7 @@ struct durable_context_v2 {
> >>>    } __packed;
> >>>
> >>>    struct create_durable_v2 {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8   Name[8];
> >>>        struct durable_context_v2 dcontext;
> >>>    } __packed;
> >>> @@ -167,7 +167,7 @@ struct durable_reconnect_context_v2_rsp {
> >>>    } __packed;
> >>>
> >>>    struct create_durable_handle_reconnect_v2 {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8   Name[8];
> >>>        struct durable_reconnect_context_v2 dcontext;
> >>>        __u8   Pad[4];
> >>> @@ -175,7 +175,7 @@ struct create_durable_handle_reconnect_v2 {
> >>>
> >>>    /* See MS-SMB2 2.2.13.2.5 */
> >>>    struct crt_twarp_ctxt {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8    Name[8];
> >>>        __le64  Timestamp;
> >>>
> >>> @@ -183,12 +183,12 @@ struct crt_twarp_ctxt {
> >>>
> >>>    /* See MS-SMB2 2.2.13.2.9 */
> >>>    struct crt_query_id_ctxt {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8    Name[8];
> >>>    } __packed;
> >>>
> >>>    struct crt_sd_ctxt {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8    Name[8];
> >>>        struct smb3_sd sd;
> >>>    } __packed;
> >>> @@ -415,7 +415,7 @@ struct smb2_posix_info_parsed {
> >>>    };
> >>>
> >>>    struct smb2_create_ea_ctx {
> >>> -     struct create_context ctx;
> >>> +     struct create_context_hdr ctx;
> >>>        __u8 name[8];
> >>>        struct smb2_file_full_ea_info ea;
> >>>    } __packed;
> >>> diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
> >>> index 1b594307c9d5..eab9d49c63ba 100644
> >>> --- a/fs/smb/common/smb2pdu.h
> >>> +++ b/fs/smb/common/smb2pdu.h
> >>> @@ -1171,12 +1171,15 @@ struct smb2_server_client_notification {
> >>>    #define SMB2_CREATE_FLAG_REPARSEPOINT 0x01
> >>>
> >>>    struct create_context {
> >>> -     __le32 Next;
> >>> -     __le16 NameOffset;
> >>> -     __le16 NameLength;
> >>> -     __le16 Reserved;
> >>> -     __le16 DataOffset;
> >>> -     __le32 DataLength;
> >>> +     /* New members must be added within the struct_group() macro be=
low. */
> >>> +     __struct_group(create_context_hdr, hdr, __packed,
> >>> +             __le32 Next;
> >>> +             __le16 NameOffset;
> >>> +             __le16 NameLength;
> >>> +             __le16 Reserved;
> >>> +             __le16 DataOffset;
> >>> +             __le32 DataLength;
> >>> +     );
> >>>        __u8 Buffer[];
> >>>    } __packed;
> >>>
> >>> @@ -1222,7 +1225,7 @@ struct smb2_create_rsp {
> >>>    } __packed;
> >>>
> >>>    struct create_posix {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8    Name[16];
> >>>        __le32  Mode;
> >>>        __u32   Reserved;
> >>> @@ -1230,7 +1233,7 @@ struct create_posix {
> >>>
> >>>    /* See MS-SMB2 2.2.13.2.3 and MS-SMB2 2.2.13.2.4 */
> >>>    struct create_durable {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8   Name[8];
> >>>        union {
> >>>                __u8  Reserved[16];
> >>> @@ -1243,14 +1246,14 @@ struct create_durable {
> >>>
> >>>    /* See MS-SMB2 2.2.13.2.5 */
> >>>    struct create_mxac_req {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8   Name[8];
> >>>        __le64 Timestamp;
> >>>    } __packed;
> >>>
> >>>    /* See MS-SMB2 2.2.14.2.5 */
> >>>    struct create_mxac_rsp {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8   Name[8];
> >>>        __le32 QueryStatus;
> >>>        __le32 MaximalAccess;
> >>> @@ -1286,13 +1289,13 @@ struct lease_context_v2 {
> >>>    } __packed;
> >>>
> >>>    struct create_lease {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8   Name[8];
> >>>        struct lease_context lcontext;
> >>>    } __packed;
> >>>
> >>>    struct create_lease_v2 {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8   Name[8];
> >>>        struct lease_context_v2 lcontext;
> >>>        __u8   Pad[4];
> >>> @@ -1300,7 +1303,7 @@ struct create_lease_v2 {
> >>>
> >>>    /* See MS-SMB2 2.2.14.2.9 */
> >>>    struct create_disk_id_rsp {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8   Name[8];
> >>>        __le64 DiskFileId;
> >>>        __le64 VolumeId;
> >>> @@ -1309,7 +1312,7 @@ struct create_disk_id_rsp {
> >>>
> >>>    /* See MS-SMB2 2.2.13.2.13 */
> >>>    struct create_app_inst_id {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8 Name[16];
> >>>        __le32 StructureSize; /* Must be 20 */
> >>>        __u16 Reserved;
> >>> @@ -1318,7 +1321,7 @@ struct create_app_inst_id {
> >>>
> >>>    /* See MS-SMB2 2.2.13.2.15 */
> >>>    struct create_app_inst_id_vers {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8 Name[16];
> >>>        __le32 StructureSize; /* Must be 24 */
> >>>        __u16 Reserved;
> >>> diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
> >>> index bd1d2a0e9203..643f5e1cfe35 100644
> >>> --- a/fs/smb/server/smb2pdu.h
> >>> +++ b/fs/smb/server/smb2pdu.h
> >>> @@ -64,7 +64,7 @@ struct preauth_integrity_info {
> >>>    #define SMB2_SESSION_TIMEOUT                (10 * HZ)
> >>>
> >>>    struct create_durable_req_v2 {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8   Name[8];
> >>>        __le32 Timeout;
> >>>        __le32 Flags;
> >>> @@ -73,7 +73,7 @@ struct create_durable_req_v2 {
> >>>    } __packed;
> >>>
> >>>    struct create_durable_reconn_req {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8   Name[8];
> >>>        union {
> >>>                __u8  Reserved[16];
> >>> @@ -85,7 +85,7 @@ struct create_durable_reconn_req {
> >>>    } __packed;
> >>>
> >>>    struct create_durable_reconn_v2_req {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8   Name[8];
> >>>        struct {
> >>>                __u64 PersistentFileId;
> >>> @@ -96,13 +96,13 @@ struct create_durable_reconn_v2_req {
> >>>    } __packed;
> >>>
> >>>    struct create_alloc_size_req {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8   Name[8];
> >>>        __le64 AllocationSize;
> >>>    } __packed;
> >>>
> >>>    struct create_durable_rsp {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8   Name[8];
> >>>        union {
> >>>                __u8  Reserved[8];
> >>> @@ -114,7 +114,7 @@ struct create_durable_rsp {
> >>>    /* Flags */
> >>>    #define SMB2_DHANDLE_FLAG_PERSISTENT        0x00000002
> >>>    struct create_durable_v2_rsp {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8   Name[8];
> >>>        __le32 Timeout;
> >>>        __le32 Flags;
> >>> @@ -122,7 +122,7 @@ struct create_durable_v2_rsp {
> >>>
> >>>    /* equivalent of the contents of SMB3.1.1 POSIX open context respo=
nse */
> >>>    struct create_posix_rsp {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8    Name[16];
> >>>        __le32 nlink;
> >>>        __le32 reparse_tag;
> >>> @@ -381,13 +381,13 @@ struct smb2_ea_info {
> >>>    } __packed; /* level 15 Query */
> >>>
> >>>    struct create_ea_buf_req {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8   Name[8];
> >>>        struct smb2_ea_info ea;
> >>>    } __packed;
> >>>
> >>>    struct create_sd_buf_req {
> >>> -     struct create_context ccontext;
> >>> +     struct create_context_hdr ccontext;
> >>>        __u8   Name[8];
> >>>        struct smb_ntsd ntsd;
> >>>    } __packed;
> >>
> >
> >
> > --
> > Thanks,
> >
> > Steve



--=20
Thanks,

Steve

