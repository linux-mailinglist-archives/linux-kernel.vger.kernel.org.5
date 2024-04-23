Return-Path: <linux-kernel+bounces-155873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF0A8AF842
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45982B27447
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DF5142E88;
	Tue, 23 Apr 2024 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="hLyi+lnu"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D10F1D52D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905385; cv=none; b=Du1j+1KzX6yLe7NIxRDMfsxhlaN76esfM43jvC05JoFTNyLPX9QKerZdsQm6IZgdpVEt46B1VPcV7U6PYFRXwfwVyhM3s+x38+wc1PusUYz4HRSVGhkCB0s5sHh8R4JFAyqx46HPs5m+mPgsZvjDRczXNKH1o6UdNhAt6kqzIyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905385; c=relaxed/simple;
	bh=Licbxkqz8RIW1Ax6WTrb+k9Q0P7nu7C6uqwnePM6J7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMybuKOxqFiHBj8qs8V7+7jkDgstDQe/fH7HalwpwRumM7NIp7NcodxW9aeCulxGqLuC54NUUPdKNNgbrHtDn05IE6ZFXS5P+nj5aqMoRUDkgON9uvA1sOQ6y77XmszP+H3TzEuTl2hWacACaNBF+F05D5XdiwvfOIRR7CNr5YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=hLyi+lnu; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id zKZxrnNCKtf2QzN3frXZow; Tue, 23 Apr 2024 20:48:07 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id zN3dr2WG3r1IfzN3erRWy6; Tue, 23 Apr 2024 20:48:06 +0000
X-Authority-Analysis: v=2.4 cv=BawT0at2 c=1 sm=1 tr=0 ts=66281e86
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=m+g+Fs1a0yfSFFEminThaA==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=_Wotqz80AAAA:8 a=NEAV23lmAAAA:8 a=NTmM5WzjnA5bdhkKqE4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=buJP51TR1BpY-zbLSsyS:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sIXZ4t/HfQ/J01SNyHJA3mxHSf7XQU6u8d9yAoAnmEM=; b=hLyi+lnukOH//ih9+hTEWVR/aG
	hcZciyOh4N2sBgHNFgfBumydGsquQcl2muRXtF0Kv076a/F4ZPZZcimDtWgYreRv9EwTs0E7QNQOc
	SEMM7ljFWNxJHP3klF9DxBnDNz1W1soSc1EAUwb6D6mVUddb29piAuoJiwfP+NXg/7rZWiwiDrDy+
	jhnaM2MSsxCe2OoCOJmuN0iuh/QKK/OyLxjz1BKnoaLSGS2ikGQsQtYkRupDbQWAjJ9XTG6fGmkDc
	LFYyS5LeVCa4ViE5PzQAeu/vXuvAdrfN4/af12e8jfQx/8ushcTRx0SpeXFetR25/TZtjUqbF2igz
	4h0z9/FA==;
Received: from [201.162.232.90] (port=55692 helo=[192.168.5.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rzN3V-0027ed-39;
	Tue, 23 Apr 2024 15:48:04 -0500
Message-ID: <7789881d-a709-48f4-8c14-259acbce813a@embeddedor.com>
Date: Wed, 24 Apr 2024 06:47:47 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] smb: smb2pdu.h: Avoid
 -Wflex-array-member-not-at-end warnings
To: Steve French <smfrench@gmail.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Bharath SM <bharathsm@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <ZhgDTj1nwLEtSd9h@neat>
 <1166494b-3e34-4919-9998-141540a948b3@embeddedor.com>
 <CAH2r5msZaV1kHqQw8Sb_3wQfGBj4aU+tSCR5E0YJ8fCH6ODB4Q@mail.gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CAH2r5msZaV1kHqQw8Sb_3wQfGBj4aU+tSCR5E0YJ8fCH6ODB4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.232.90
X-Source-L: No
X-Exim-ID: 1rzN3V-0027ed-39
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.5.44]) [201.162.232.90]:55692
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKAicbDVXRs3oPKNN3BCJGwWYKwOrYeZ/b8J0mRsRkf5AWM/5pJ1IVuqDYqAvSa3LKkH0aXtodk9JU+raWZeMwZ3nhk1O3kWCZ3BZ/ZOpU6bcE+j8jZx
 HsUJgFjVHEFGlGXgMzw6e8bkJ6P9YbJEfz4+SiX1Qr1KI9rXnXRKGxMRr145hJAIJBCkx1Lc8gLJdfBvvwdnCxypwPS3proxTZbdIMYlQqXQRbVZzm2NieYq



On 23/04/24 14:15, Steve French wrote:
> This looks reasonably safe (running the usual regression tests on it now).
> 
> Reminds me though that we have to be careful (e.g. the recent fix for
> regression caused by cleanup).

mmh... it seems that the offending commit was never CC'd to the linux-hardening
list, hence it wasn't reviewed by us.

After reviewing both, the offending commit and the fix, both seem to be wrong.

for __packed structs, you should use __struct_group():

__struct_group(network_open_info, group_name, __packed, struct_members);

The _packed in the commit 0268a7cc7fdc is not an attribute, it's the name
for the group. So, it's not actually doing what the submitter thinks it does.

> 
> Thoughts about whether should be sent in rc6 or wait till 6.10?  51
> warnings does sound
> distracting though so might be worth going in sooner rather than later.

There is actually no hurry. :)

Thanks
--
Gustavo

> 
> commit 0268a7cc7fdc47d90b6c18859de7718d5059f6f1
> Author: Namjae Jeon <linkinjeon@kernel.org>
> Date:   Fri Apr 19 23:46:34 2024 +0900
> 
>      ksmbd: common: use struct_group_attr instead of struct_group for
> network_open_info
> 
>      4byte padding cause the connection issue with the applications of MacOS.
>      smb2_close response size increases by 4 bytes by padding, And the smb
>      client of MacOS check it and stop the connection. This patch use
>      struct_group_attr instead of struct_group for network_open_info to use
>       __packed to avoid padding.
> 
> 
> On Tue, Apr 23, 2024 at 1:58 PM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>>
>> Hi all,
>>
>> Friendly ping: who can take this, please?
>>
>> Thanks
>> --
>> Gustavo
>>
>> On 11/04/24 09:35, Gustavo A. R. Silva wrote:
>>> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
>>> ready to enable it globally.
>>>
>>> So, in order to avoid ending up with a flexible-array member in the
>>> middle of multiple other structs, we use the `__struct_group()` helper
>>> to separate the flexible array from the rest of the members in the
>>> flexible structure, and use the tagged `struct create_context_hdr`
>>> instead of `struct create_context`.
>>>
>>> So, with these changes, fix 51 of the following warnings[1]:
>>>
>>> fs/smb/client/../common/smb2pdu.h:1225:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>>
>>> Link: https://gist.github.com/GustavoARSilva/772526a39be3dd4db39e71497f0a9893 [1]
>>> Link: https://github.com/KSPP/linux/issues/202
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>>    fs/smb/client/smb2pdu.h | 12 ++++++------
>>>    fs/smb/common/smb2pdu.h | 33 ++++++++++++++++++---------------
>>>    fs/smb/server/smb2pdu.h | 18 +++++++++---------
>>>    3 files changed, 33 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
>>> index c72a3b2886b7..1a02bd9e0c00 100644
>>> --- a/fs/smb/client/smb2pdu.h
>>> +++ b/fs/smb/client/smb2pdu.h
>>> @@ -145,7 +145,7 @@ struct durable_context_v2 {
>>>    } __packed;
>>>
>>>    struct create_durable_v2 {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8   Name[8];
>>>        struct durable_context_v2 dcontext;
>>>    } __packed;
>>> @@ -167,7 +167,7 @@ struct durable_reconnect_context_v2_rsp {
>>>    } __packed;
>>>
>>>    struct create_durable_handle_reconnect_v2 {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8   Name[8];
>>>        struct durable_reconnect_context_v2 dcontext;
>>>        __u8   Pad[4];
>>> @@ -175,7 +175,7 @@ struct create_durable_handle_reconnect_v2 {
>>>
>>>    /* See MS-SMB2 2.2.13.2.5 */
>>>    struct crt_twarp_ctxt {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8    Name[8];
>>>        __le64  Timestamp;
>>>
>>> @@ -183,12 +183,12 @@ struct crt_twarp_ctxt {
>>>
>>>    /* See MS-SMB2 2.2.13.2.9 */
>>>    struct crt_query_id_ctxt {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8    Name[8];
>>>    } __packed;
>>>
>>>    struct crt_sd_ctxt {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8    Name[8];
>>>        struct smb3_sd sd;
>>>    } __packed;
>>> @@ -415,7 +415,7 @@ struct smb2_posix_info_parsed {
>>>    };
>>>
>>>    struct smb2_create_ea_ctx {
>>> -     struct create_context ctx;
>>> +     struct create_context_hdr ctx;
>>>        __u8 name[8];
>>>        struct smb2_file_full_ea_info ea;
>>>    } __packed;
>>> diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
>>> index 1b594307c9d5..eab9d49c63ba 100644
>>> --- a/fs/smb/common/smb2pdu.h
>>> +++ b/fs/smb/common/smb2pdu.h
>>> @@ -1171,12 +1171,15 @@ struct smb2_server_client_notification {
>>>    #define SMB2_CREATE_FLAG_REPARSEPOINT 0x01
>>>
>>>    struct create_context {
>>> -     __le32 Next;
>>> -     __le16 NameOffset;
>>> -     __le16 NameLength;
>>> -     __le16 Reserved;
>>> -     __le16 DataOffset;
>>> -     __le32 DataLength;
>>> +     /* New members must be added within the struct_group() macro below. */
>>> +     __struct_group(create_context_hdr, hdr, __packed,
>>> +             __le32 Next;
>>> +             __le16 NameOffset;
>>> +             __le16 NameLength;
>>> +             __le16 Reserved;
>>> +             __le16 DataOffset;
>>> +             __le32 DataLength;
>>> +     );
>>>        __u8 Buffer[];
>>>    } __packed;
>>>
>>> @@ -1222,7 +1225,7 @@ struct smb2_create_rsp {
>>>    } __packed;
>>>
>>>    struct create_posix {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8    Name[16];
>>>        __le32  Mode;
>>>        __u32   Reserved;
>>> @@ -1230,7 +1233,7 @@ struct create_posix {
>>>
>>>    /* See MS-SMB2 2.2.13.2.3 and MS-SMB2 2.2.13.2.4 */
>>>    struct create_durable {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8   Name[8];
>>>        union {
>>>                __u8  Reserved[16];
>>> @@ -1243,14 +1246,14 @@ struct create_durable {
>>>
>>>    /* See MS-SMB2 2.2.13.2.5 */
>>>    struct create_mxac_req {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8   Name[8];
>>>        __le64 Timestamp;
>>>    } __packed;
>>>
>>>    /* See MS-SMB2 2.2.14.2.5 */
>>>    struct create_mxac_rsp {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8   Name[8];
>>>        __le32 QueryStatus;
>>>        __le32 MaximalAccess;
>>> @@ -1286,13 +1289,13 @@ struct lease_context_v2 {
>>>    } __packed;
>>>
>>>    struct create_lease {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8   Name[8];
>>>        struct lease_context lcontext;
>>>    } __packed;
>>>
>>>    struct create_lease_v2 {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8   Name[8];
>>>        struct lease_context_v2 lcontext;
>>>        __u8   Pad[4];
>>> @@ -1300,7 +1303,7 @@ struct create_lease_v2 {
>>>
>>>    /* See MS-SMB2 2.2.14.2.9 */
>>>    struct create_disk_id_rsp {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8   Name[8];
>>>        __le64 DiskFileId;
>>>        __le64 VolumeId;
>>> @@ -1309,7 +1312,7 @@ struct create_disk_id_rsp {
>>>
>>>    /* See MS-SMB2 2.2.13.2.13 */
>>>    struct create_app_inst_id {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8 Name[16];
>>>        __le32 StructureSize; /* Must be 20 */
>>>        __u16 Reserved;
>>> @@ -1318,7 +1321,7 @@ struct create_app_inst_id {
>>>
>>>    /* See MS-SMB2 2.2.13.2.15 */
>>>    struct create_app_inst_id_vers {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8 Name[16];
>>>        __le32 StructureSize; /* Must be 24 */
>>>        __u16 Reserved;
>>> diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
>>> index bd1d2a0e9203..643f5e1cfe35 100644
>>> --- a/fs/smb/server/smb2pdu.h
>>> +++ b/fs/smb/server/smb2pdu.h
>>> @@ -64,7 +64,7 @@ struct preauth_integrity_info {
>>>    #define SMB2_SESSION_TIMEOUT                (10 * HZ)
>>>
>>>    struct create_durable_req_v2 {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8   Name[8];
>>>        __le32 Timeout;
>>>        __le32 Flags;
>>> @@ -73,7 +73,7 @@ struct create_durable_req_v2 {
>>>    } __packed;
>>>
>>>    struct create_durable_reconn_req {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8   Name[8];
>>>        union {
>>>                __u8  Reserved[16];
>>> @@ -85,7 +85,7 @@ struct create_durable_reconn_req {
>>>    } __packed;
>>>
>>>    struct create_durable_reconn_v2_req {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8   Name[8];
>>>        struct {
>>>                __u64 PersistentFileId;
>>> @@ -96,13 +96,13 @@ struct create_durable_reconn_v2_req {
>>>    } __packed;
>>>
>>>    struct create_alloc_size_req {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8   Name[8];
>>>        __le64 AllocationSize;
>>>    } __packed;
>>>
>>>    struct create_durable_rsp {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8   Name[8];
>>>        union {
>>>                __u8  Reserved[8];
>>> @@ -114,7 +114,7 @@ struct create_durable_rsp {
>>>    /* Flags */
>>>    #define SMB2_DHANDLE_FLAG_PERSISTENT        0x00000002
>>>    struct create_durable_v2_rsp {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8   Name[8];
>>>        __le32 Timeout;
>>>        __le32 Flags;
>>> @@ -122,7 +122,7 @@ struct create_durable_v2_rsp {
>>>
>>>    /* equivalent of the contents of SMB3.1.1 POSIX open context response */
>>>    struct create_posix_rsp {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8    Name[16];
>>>        __le32 nlink;
>>>        __le32 reparse_tag;
>>> @@ -381,13 +381,13 @@ struct smb2_ea_info {
>>>    } __packed; /* level 15 Query */
>>>
>>>    struct create_ea_buf_req {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8   Name[8];
>>>        struct smb2_ea_info ea;
>>>    } __packed;
>>>
>>>    struct create_sd_buf_req {
>>> -     struct create_context ccontext;
>>> +     struct create_context_hdr ccontext;
>>>        __u8   Name[8];
>>>        struct smb_ntsd ntsd;
>>>    } __packed;
>>
> 
> 
> --
> Thanks,
> 
> Steve

