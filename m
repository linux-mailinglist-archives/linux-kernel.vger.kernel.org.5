Return-Path: <linux-kernel+bounces-120021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E9D88D060
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB591C39626
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9FA13DB8D;
	Tue, 26 Mar 2024 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="COQ/ROch"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3FC13C9CD
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490261; cv=none; b=ZelTwXebqpV6xj3O+lwRj/Z3/YJ6o2q8/GWW2Mpp/ckXnGfV7xyJNXn9IiqNMUkYmqI070p80AjxmIZBritM2T9j9EWHnU3GALbvzSzMXqrv+lToyK4zUqHU1ijKZjz6pMNc0v1mNJOrxCtWY2zWd2WYlOkSIvjlDVplAIwnnr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490261; c=relaxed/simple;
	bh=UoR0o32MKIvmAp1ANiKOl+9qFONvSJ8UPsF1pvgXFFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFxgvocBKh8puiUNlWIic8t32VYqFMEqsvti4l6aqfr4qwOZr43it+SiotzrhNQLgb/6kHx5r67lH0XZZysJOEgV3PnIKooCQDYPXlRxY8o6+oSMK/HMFs8mTqgr4HkYq0K11DclIJpeztAzUGrzjEIi4WGknr6N5ZYdHzrTyH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=COQ/ROch; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id omuFrLieaPM1hpEnarlqX2; Tue, 26 Mar 2024 21:57:38 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pEnarvtM8bhc1pEnarwoeS; Tue, 26 Mar 2024 21:57:38 +0000
X-Authority-Analysis: v=2.4 cv=Z7bqHmRA c=1 sm=1 tr=0 ts=660344d2
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=XAy_j3ZW5y_KvujfpI8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6DCdr4eyAU+kRAslFEtTKuTG/6MkQfr4djJhxLPnJfE=; b=COQ/ROchJF4TuJOB4+r/1/QuSH
	X3OzD9awPFkyrQ3YdmdmMZUF76or3NNG0Wp040P/9fI04rlK20/GlxuBfl0mbcl6Di0xHyB71GDO4
	gVJvJyj887HRbN/aQEDqF4JCLh3OvFZ9iFiJMKHN+l1oVxOrbs3GjBpSicTCN/GCkxuDEzuXaP6r+
	DQcKou6pkKZOjIYJRgJ3l82MPnaun4TR47SxfStouuA8Hi9S72fh42iy9n4u4bOXc3wvawD9WPOz4
	gqC/0IjRMpEDcH6lud0T+GC2PKjGhm4/07xKE8TKTfpojAXOTOwJKVgBJxBH5hhwCYc4tMoLGqwEH
	wxBnJRBA==;
Received: from [201.172.173.147] (port=54206 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rpEnY-001gBp-1E;
	Tue, 26 Mar 2024 16:57:36 -0500
Message-ID: <e583503b-6964-4ca3-bbed-2fafab54a0d8@embeddedor.com>
Date: Tue, 26 Mar 2024 15:57:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] Bluetooth: L2CAP: Avoid
 -Wflex-array-member-not-at-end warnings
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZgMpynzZ8FltPCi3@neat>
 <CABBYNZ+N5UM3pvTiMSNx-EhhTOOXwEziO7BQoYK+u8=TtSQEnw@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CABBYNZ+N5UM3pvTiMSNx-EhhTOOXwEziO7BQoYK+u8=TtSQEnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.147
X-Source-L: No
X-Exim-ID: 1rpEnY-001gBp-1E
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:54206
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKu7G9WPsRguVGyHISNVGK/XSOIN+vSSJmes4r2myeP/6vW+8tQf+fbqxTJCP+/MZsCU4ikuLctpGf+8lfyTD/l8GLSnUEGlJwkL4Jpp4KvM8ENAYqJH
 DmOakWVLmFdG8p2wYo/iO/7Qsq9oUoBruoEXdDMoifWdv5EQv7NswuSU0EKs9UozKf0UoFizNISpyAItf7eeEOErmmI3qqWwQf5YY5xPqec0Bka5f6mMf4My



On 3/26/24 15:12, Luiz Augusto von Dentz wrote:
> Hi Gustavo,
> 
> On Tue, Mar 26, 2024 at 4:02 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
>>
>> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
>> ready to enable it globally.
>>
>> There are currently a couple of objects (`req` and `rsp`), in a couple
>> of structures, that contain flexible structures (`struct l2cap_ecred_conn_req`
>> and `struct l2cap_ecred_conn_rsp`), for example:
>>
>> struct l2cap_ecred_rsp_data {
>>          struct {
>>                  struct l2cap_ecred_conn_rsp rsp;
>>                  __le16 scid[L2CAP_ECRED_MAX_CID];
>>          } __packed pdu;
>>          int count;
>> };
>>
>> in the struct above, `struct l2cap_ecred_conn_rsp` is a flexible
>> structure:
>>
>> struct l2cap_ecred_conn_rsp {
>>          __le16 mtu;
>>          __le16 mps;
>>          __le16 credits;
>>          __le16 result;
>>          __le16 dcid[];
>> };
>>
>> So, in order to avoid ending up with a flexible-array member in the
>> middle of another structure, we use the `struct_group_tagged()` (and
>> `__struct_group()` when the flexible structure is `__packed`) helper
>> to separate the flexible array from the rest of the members in the
>> flexible structure:
>>
>> struct l2cap_ecred_conn_rsp {
>>          struct_group_tagged(l2cap_ecred_conn_rsp_hdr, hdr,
>>
>>          ... the rest of members
>>
>>          );
>>          __le16 dcid[];
>> };
> 
> Wouldn't it be better, more readable at least, to not define the
> l2cap_ecred_conn_rsp_hdr inside thought? Instead just do:
> 
> struct_group_tagged(l2cap_ecred_conn_rsp_hdr, hdr,
> ...
>   };
> 
>   struct l2cap_ecred_conn_rsp {
>          struct l2cap_ecred_conn_rsp_hdr hdr;
>           __le16 dcid[];
>   };
> 
> Or was this done this way in order to maintain the same fields?

Exactly. But I can change it if people consider that's better.

> 
>> With the change described above, we now declare objects of the type of
>> the tagged struct, in this example `struct l2cap_ecred_conn_rsp_hdr`,
>> without embedding flexible arrays in the middle of other structures:
>>
>> struct l2cap_ecred_rsp_data {
>>          struct {
>>                  struct l2cap_ecred_conn_rsp_hdr rsp;
>>                  __le16 scid[L2CAP_ECRED_MAX_CID];
>>          } __packed pdu;
>>          int count;
>> };
>>
>> Also, when the flexible-array member needs to be accessed, we use
>> `container_of()` to retrieve a pointer to the flexible structure.
>>
>> We also use the `DEFINE_RAW_FLEX()` helper for a couple of on-stack
>> definitions of a flexible structure where the size of the flexible-array
>> member is known at compile-time.
>>
>> So, with these changes, fix the following warnings:
>> net/bluetooth/l2cap_core.c:1260:45: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>> net/bluetooth/l2cap_core.c:3740:45: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>> net/bluetooth/l2cap_core.c:4999:45: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>> net/bluetooth/l2cap_core.c:7116:47: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> Link: https://github.com/KSPP/linux/issues/202
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>
>> Hi!
>>
>> I wonder if `struct l2cap_ecred_conn_rsp` should also be `__packed`.
>>
>> Thanks
>>   - Gustavo
>>
>>   include/net/bluetooth/l2cap.h | 20 +++++++++------
>>   net/bluetooth/l2cap_core.c    | 46 ++++++++++++++++-------------------
>>   2 files changed, 33 insertions(+), 33 deletions(-)
>>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>> index a4278aa618ab..92a143517d83 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -463,18 +463,22 @@ struct l2cap_le_credits {
>>   #define L2CAP_ECRED_MAX_CID            5
>>
>>   struct l2cap_ecred_conn_req {
>> -       __le16 psm;
>> -       __le16 mtu;
>> -       __le16 mps;
>> -       __le16 credits;
>> +       __struct_group(l2cap_ecred_conn_req_hdr, hdr, __packed,
>> +               __le16 psm;
>> +               __le16 mtu;
>> +               __le16 mps;
>> +               __le16 credits;
>> +       );
>>          __le16 scid[];
>>   } __packed;
>>
>>   struct l2cap_ecred_conn_rsp {
>> -       __le16 mtu;
>> -       __le16 mps;
>> -       __le16 credits;
>> -       __le16 result;
>> +       struct_group_tagged(l2cap_ecred_conn_rsp_hdr, hdr,
>> +               __le16 mtu;
>> +               __le16 mps;
>> +               __le16 credits;
>> +               __le16 result;
>> +       );
>>          __le16 dcid[];
>>   };
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index 467b242d8be0..bf087eca489e 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -1257,7 +1257,7 @@ static void l2cap_le_connect(struct l2cap_chan *chan)
>>
>>   struct l2cap_ecred_conn_data {
>>          struct {
>> -               struct l2cap_ecred_conn_req req;
>> +               struct l2cap_ecred_conn_req_hdr req;
>>                  __le16 scid[5];
>>          } __packed pdu;
> 
> Can't we just use DEFINE_RAW_FLEX for the pdu field above?

No; DEFINE_FLEX() and DEFINE_RAW_FLEX() are for on-stack code only.

Thanks
--
Gustavo

> 
>>          struct l2cap_chan *chan;
>> @@ -3737,7 +3737,7 @@ static void l2cap_ecred_list_defer(struct l2cap_chan *chan, void *data)
>>
>>   struct l2cap_ecred_rsp_data {
>>          struct {
>> -               struct l2cap_ecred_conn_rsp rsp;
>> +               struct l2cap_ecred_conn_rsp_hdr rsp;
>>                  __le16 scid[L2CAP_ECRED_MAX_CID];
>>          } __packed pdu;
> 
> Ditto.
> 
>>          int count;
>> @@ -3746,6 +3746,8 @@ struct l2cap_ecred_rsp_data {
>>   static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
>>   {
>>          struct l2cap_ecred_rsp_data *rsp = data;
>> +       struct l2cap_ecred_conn_rsp *rsp_flex =
>> +               container_of(&rsp->pdu.rsp, struct l2cap_ecred_conn_rsp, hdr);
>>
>>          if (test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
>>                  return;
>> @@ -3755,7 +3757,7 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
>>
>>          /* Include all channels pending with the same ident */
>>          if (!rsp->pdu.rsp.result)
>> -               rsp->pdu.rsp.dcid[rsp->count++] = cpu_to_le16(chan->scid);
>> +               rsp_flex->dcid[rsp->count++] = cpu_to_le16(chan->scid);
>>          else
>>                  l2cap_chan_del(chan, ECONNRESET);
>>   }
>> @@ -4995,10 +4997,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
>>                                         u8 *data)
>>   {
>>          struct l2cap_ecred_conn_req *req = (void *) data;
>> -       struct {
>> -               struct l2cap_ecred_conn_rsp rsp;
>> -               __le16 dcid[L2CAP_ECRED_MAX_CID];
>> -       } __packed pdu;
>> +       DEFINE_RAW_FLEX(struct l2cap_ecred_conn_rsp, pdu, dcid, L2CAP_ECRED_MAX_CID);
>>          struct l2cap_chan *chan, *pchan;
>>          u16 mtu, mps;
>>          __le16 psm;
>> @@ -5017,7 +5016,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
>>          cmd_len -= sizeof(*req);
>>          num_scid = cmd_len / sizeof(u16);
>>
>> -       if (num_scid > ARRAY_SIZE(pdu.dcid)) {
>> +       if (num_scid > L2CAP_ECRED_MAX_CID) {
>>                  result = L2CAP_CR_LE_INVALID_PARAMS;
>>                  goto response;
>>          }
>> @@ -5046,7 +5045,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
>>
>>          BT_DBG("psm 0x%2.2x mtu %u mps %u", __le16_to_cpu(psm), mtu, mps);
>>
>> -       memset(&pdu, 0, sizeof(pdu));
>> +       memset(pdu, 0, sizeof(*pdu));
>>
>>          /* Check if we have socket listening on psm */
>>          pchan = l2cap_global_chan_by_psm(BT_LISTEN, psm, &conn->hcon->src,
>> @@ -5072,8 +5071,8 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
>>
>>                  BT_DBG("scid[%d] 0x%4.4x", i, scid);
>>
>> -               pdu.dcid[i] = 0x0000;
>> -               len += sizeof(*pdu.dcid);
>> +               pdu->dcid[i] = 0x0000;
>> +               len += sizeof(*pdu->dcid);
>>
>>                  /* Check for valid dynamic CID range */
>>                  if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_LE_DYN_END) {
>> @@ -5107,13 +5106,13 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
>>                  l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
>>
>>                  /* Init response */
>> -               if (!pdu.rsp.credits) {
>> -                       pdu.rsp.mtu = cpu_to_le16(chan->imtu);
>> -                       pdu.rsp.mps = cpu_to_le16(chan->mps);
>> -                       pdu.rsp.credits = cpu_to_le16(chan->rx_credits);
>> +               if (!pdu->credits) {
>> +                       pdu->mtu = cpu_to_le16(chan->imtu);
>> +                       pdu->mps = cpu_to_le16(chan->mps);
>> +                       pdu->credits = cpu_to_le16(chan->rx_credits);
>>                  }
>>
>> -               pdu.dcid[i] = cpu_to_le16(chan->scid);
>> +               pdu->dcid[i] = cpu_to_le16(chan->scid);
>>
>>                  __set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
>>
>> @@ -5135,13 +5134,13 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
>>          l2cap_chan_put(pchan);
>>
>>   response:
>> -       pdu.rsp.result = cpu_to_le16(result);
>> +       pdu->result = cpu_to_le16(result);
>>
>>          if (defer)
>>                  return 0;
>>
>>          l2cap_send_cmd(conn, cmd->ident, L2CAP_ECRED_CONN_RSP,
>> -                      sizeof(pdu.rsp) + len, &pdu);
>> +                      sizeof(*pdu) + len, pdu);
>>
>>          return 0;
>>   }
>> @@ -7112,14 +7111,11 @@ EXPORT_SYMBOL_GPL(l2cap_chan_connect);
>>   static void l2cap_ecred_reconfigure(struct l2cap_chan *chan)
>>   {
>>          struct l2cap_conn *conn = chan->conn;
>> -       struct {
>> -               struct l2cap_ecred_reconf_req req;
>> -               __le16 scid;
>> -       } pdu;
>> +       DEFINE_RAW_FLEX(struct l2cap_ecred_reconf_req, pdu, scid, 1);
>>
>> -       pdu.req.mtu = cpu_to_le16(chan->imtu);
>> -       pdu.req.mps = cpu_to_le16(chan->mps);
>> -       pdu.scid    = cpu_to_le16(chan->scid);
>> +       pdu->mtu = cpu_to_le16(chan->imtu);
>> +       pdu->mps = cpu_to_le16(chan->mps);
>> +       pdu->scid[0] = cpu_to_le16(chan->scid);
>>
>>          chan->ident = l2cap_get_ident(conn);
>>
>> --
>> 2.34.1
>>
> 
> 

