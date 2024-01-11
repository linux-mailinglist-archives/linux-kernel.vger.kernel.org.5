Return-Path: <linux-kernel+bounces-23021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E6682A66C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145761C230D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4FBEC9;
	Thu, 11 Jan 2024 03:22:02 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309A9EBB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7ba693d7b893478cb3666b0f55a16ff9-20240111
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:d96497ca-ea87-411e-bb5f-78c71e7f1c5d,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:d96497ca-ea87-411e-bb5f-78c71e7f1c5d,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:7fb4b882-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:2401111121497VF3I11C,BulkQuantity:0,Recheck:0,SF:64|66|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 7ba693d7b893478cb3666b0f55a16ff9-20240111
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 405513473; Thu, 11 Jan 2024 11:21:48 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 09549E000EB9;
	Thu, 11 Jan 2024 11:21:48 +0800 (CST)
X-ns-mid: postfix-659F5ECB-954882627
Received: from [172.20.15.234] (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 82634E000EB9;
	Thu, 11 Jan 2024 11:21:46 +0800 (CST)
Message-ID: <cc9b456f-31f6-46f0-a6e6-f553779a775b@kylinos.cn>
Date: Thu, 11 Jan 2024 11:21:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ubifs: Remove unreachable code
Content-Language: en-US
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: richard@nod.at, Artem.Bityutskiy@nokia.com, kunwu.chan@hotmail.com,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231111143314.1518314-1-chentao@kylinos.cn>
 <CAFLxGvzAncnBTEbHZ0pA-oF6n9P+wKFMugz8c+8UQKoPeBiYig@mail.gmail.com>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <CAFLxGvzAncnBTEbHZ0pA-oF6n9P+wKFMugz8c+8UQKoPeBiYig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



On 2024/1/5 23:55, Richard Weinberger wrote:
> On Sat, Nov 11, 2023 at 3:33=E2=80=AFPM Kunwu Chan <chentao@kylinos.cn>=
 wrote:
>>
>> Because there is no break statement in the dead loop above,it is
>> impossible to execute the 'err=3D0' statement.Delete the code that
>> will never execute and initialize 'err' at the start of the function.
>>
>> Fixes: 6fb324a4b0c3 ("UBIFS: allocate ltab checking buffer on demand")
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>   fs/ubifs/lpt_commit.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/ubifs/lpt_commit.c b/fs/ubifs/lpt_commit.c
>> index c4d079328b92..d4751628fe70 100644
>> --- a/fs/ubifs/lpt_commit.c
>> +++ b/fs/ubifs/lpt_commit.c
>> @@ -1589,8 +1589,8 @@ static int dbg_is_node_dirty(struct ubifs_info *=
c, int node_type, int lnum,
>>    */
>>   static int dbg_check_ltab_lnum(struct ubifs_info *c, int lnum)
>>   {
>> -       int err, len =3D c->leb_size, dirty =3D 0, node_type, node_num=
, node_len;
>> -       int ret;
>> +       int len =3D c->leb_size, dirty =3D 0, node_type, node_num, nod=
e_len;
>> +       int ret, err =3D 0;
>>          void *buf, *p;
>=20
> Now it is still dead code.
> A few lines later err will be used for the result of ubifs_leb_read().
> So you can remove the initialization of err completely.

Thanks, I will modify in v2 patch.

>=20
>>          if (!dbg_is_chk_lprops(c))
>> @@ -1646,7 +1646,6 @@ static int dbg_check_ltab_lnum(struct ubifs_info=
 *c, int lnum)
>>                  len -=3D node_len;
>>          }
>>
>> -       err =3D 0;
>>   out:
>>          vfree(buf);
>>          return err;
>> --
>> 2.34.1
>>
>=20
>=20

