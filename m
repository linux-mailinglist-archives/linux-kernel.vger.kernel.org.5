Return-Path: <linux-kernel+bounces-111927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BFE8872D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D861F24111
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5135C63408;
	Fri, 22 Mar 2024 18:17:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2121.outbound.protection.outlook.com [40.107.92.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8A633F4;
	Fri, 22 Mar 2024 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711131456; cv=fail; b=uesBeuGh8ZD8X9aa7O67KqM4SYkketbmSzTW3Il0jevdh2uEJDPrB3IvRkyQcCiHwWtapS43Q7vFKy87HdPbcA+TCh7CyFs2ivhSC2V5w6MfhGuwx/e/O9hqCovziraZBXyGCWSK4aoKBRWMBi49t4LBZjs9VWd5tarG0UZn1LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711131456; c=relaxed/simple;
	bh=PlvvT56FcpB2k1KIXYEmUJsf6MSP8wFhW5SDcNxm5Q4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=oRnonhNXBeRqgIRbKOI8h0um3g5ghoKzC9PFn+UK9srS5+8vdOcMQ+/Uy2hM5nIxJOP/GVYPe+/oy23jmZNQsiFn5DwWEqTaCjSU7tc8wBS2JRDic8WYU79vAUGlCOARJrELJdRTJL5RDpdI26a5H5M/U80j7VniyyDgmC59bmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.92.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7kZD+RVpt6q3CH4GQrBQT1RJXUW3gc0DMpj13NkxdA+mpvUGeA+0fwkeae4GXdQQ3d4B24uRsY/S58zoLlrOJ38CIkjPnOOboITmS4LAGkFfEqgTyR+2nmW0yWjgz+tuLycFb0EglcAnGMuF2go0ckuefCxR3fLVZsdBwot3NZViZpoDk4vWwZxJQNw61K2LInhP1pChQRjoEtMyhKMMB9ykY6T57WBqoaH5A/6O0+aXwcG1iDaOsFhElDnIr92+JoliTTwYzu5vpTpEJZaydPqRAljU9HkCLuq01N/+3BRBCPUotRFcZRNWGxLPOM4b8pVJq85YttTGWCGOr3+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlvvT56FcpB2k1KIXYEmUJsf6MSP8wFhW5SDcNxm5Q4=;
 b=beSc8a9OvG017oazFeNnKv3XI/Op4T3y08nBV1dAFcmkHhSVypeN/TQLmWsnSVdSG2A21g7Uh8vJ/7cFFJ/iPv0yGFgwmERGk8ir4dIjpqcz7ZYQuH5OQDhzfA48mefuQRUT1TOtHJx5AwcRrJpC4wol4nefTw1HZskZiLgCeHMwJeSB8dVBSRGQHq/LKFwxP39/Q8OEj4WQ+UDMxscK7ztMIEarDnEAJPPPhPtnHIzoUKRxEzw4OVzIiuaF8tV0BpjL6UadvS3chWDDqL8jGX/kJytfegZowMVIk/IU+Ebd0TnzzwiWbKX5Gg8JXSQz36KixOdTLUdo2Y3Qs2AgLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from CH0PR01MB7170.prod.exchangelabs.com (2603:10b6:610:f8::12) by
 BN0PR01MB6896.prod.exchangelabs.com (2603:10b6:408:16b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.15; Fri, 22 Mar 2024 18:17:29 +0000
Received: from CH0PR01MB7170.prod.exchangelabs.com
 ([fe80::260f:c1b2:616a:af0]) by CH0PR01MB7170.prod.exchangelabs.com
 ([fe80::260f:c1b2:616a:af0%6]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 18:17:28 +0000
Date: Fri, 22 Mar 2024 14:17:07 -0400 (EDT)
From: Tom Talpey <tom@talpey.com>
To: Steve French <smfrench@gmail.com>
Cc: Ritvik Budhiraja <budhirajaritviksmb@gmail.com>, sfrench@samba.org,
	pc@manguebit.com, ronniesahlberg@gmail.com, sprasad@microsoft.com,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org, bharathsm.hsk@gmail.com
Message-ID: <0a4cf834-c102-4497-a5dc-2bb44d6083f1@talpey.com>
In-Reply-To: <CAH2r5mt1X3wp89FLUN_VEzA1kCQmu8x8bVAyi0cdG7-b2V=Bmw@mail.gmail.com>
References: <ZfQC6Xk+E6HtCtsI@rbudubuntu.daqjip3ntomehmqy3wvpaa3zyf.bx.internal.cloudapp.net> <CA+EPQ67TC27FTmN30QRHji61ymrD=0y-NZ_CHOi7tAq2qcFWQw@mail.gmail.com> <CAH2r5mt1X3wp89FLUN_VEzA1kCQmu8x8bVAyi0cdG7-b2V=Bmw@mail.gmail.com>
Subject: Re: [PATCH] Retrying on failed server close
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <0a4cf834-c102-4497-a5dc-2bb44d6083f1@talpey.com>
X-ClientProxiedBy: MN2PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:208:c0::16) To CH0PR01MB7170.prod.exchangelabs.com
 (2603:10b6:610:f8::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB7170:EE_|BN0PR01MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: 588d760b-57d6-4834-5298-08dc4a9c4f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1g0n8DhTR7b29QdBZcZC61LwKlNXnCvxT8+mUwERovoFO/GP4uMZJbLIClN3lqFfJUsTsfgdIiZ2q8dSLu9F2s3pS/5UAxEu2qOBuZ+UTsRiVjJrSPPKRE6WdZBpo1/8Oy8Qrc7nBcZLlSllEpavE2ti19E/hmItFho2THoj/8uiXeeZItE3N+6b1mcKvhM6T5MJapIYUIsV2vL0NNRd36iFMkvJIE7JdFpL97/qIlorpd2+3yeEzN/Gf5hR5bSfZgjTgvoQxNAWZ0DmqEpKIjsflubfi1hf74Ls7p9gcKuaeAo7HNwMWogkWJ0kKTJl/SEw4WXCP9Xz6Bshp6aSO5mWqUAasOrLnbEyS6iiVgvxbhVXIQUwvPM+bFfJ86yDeWv1szKWfmuGotdWGq4BZFKynXaUkc7WEZ5Rf33p+2F/+r0GNh3OcjEgH2M7LiACR+u7ybKUU2XWLOV1XXx+E1i2u96toG097Hm3UbZrlfOgcmU9j7ynvMmVUh0vdNTLDcPbKVOarXA20Ex4bODvM0IhILUoJT56tc0NMdzWOAxp9rY9g3Fv5wtoYoSCqHjLE4HONVcPOPy6uUSbXXboBJSFkgaa41axYkVXtBFZ5S/7AeDyndpvingS4ApEaqnGEBqdvCsxvAE0OWHdSWwAJoGuZI9IwokoHzKlL+ZYylnCdKc24BoVcJklpXTYiaI+hKSyhmPUD7LVAg63BCpzQCm9KJBYUM7QL9sKQ/gSbkw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7170.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXFjZmZ0ZE40UHRobVdMUkRhb2xESXNLZklPVUhzRThjWHpibi8zTHAzWHZU?=
 =?utf-8?B?TjVlbVZTYitxM29HWXZHb0VaQnpHQXFFT2o5Wis5alByMmlDdWpNNGFmbFdX?=
 =?utf-8?B?akFVS2VaODlpNXQxK2x1MUZkTklxQzNZb3d2YjZjc3FEK0diUTAvVjA2VjZn?=
 =?utf-8?B?VlJUUWpPeU1LbFpTZ1ExbUhWNmFUVXVWdDFRRENGbHNpV3RHcFVXblhUbE95?=
 =?utf-8?B?dVpsd1JzZFd5M1hPYzUzRkhMMUZKTHBVS1VmVEZOWE9qNEk0VGdVL0xCWElG?=
 =?utf-8?B?Sjd3MUNGelRLc0wvck5hYi96K3dXME1jdzlnQnNaa2xyUkpwVGVleUE3aHQy?=
 =?utf-8?B?akpQRWVKM3NFWnprUkR4aHMxNU9TRWN0alBZTUZSeDM5cEpyK1E3NnhzVDY4?=
 =?utf-8?B?bE9weGNyNnVnYkFLRjVVeEtSR2s2dUhkb3NscHQwckkvdGtpVTVmbWdpOEhl?=
 =?utf-8?B?WVJQNGcvOGxOTGcyWlp6OXJwOU9USEt1SmVlTUh4ZnNKSmlqUEE1UnZXWGph?=
 =?utf-8?B?R1kzeUY2cjdjS3ZoSEV3V2dZZXNBeXNPc1lZd3BrQlhDUjZWRjBBaCt2Ymc5?=
 =?utf-8?B?NjhHM0pyMmlBdWpNZ3EvU3Z6bWMvblpSMStyaDMydElxOWxhdjNhQ2UrUkJE?=
 =?utf-8?B?blFJU1M0c1Q2cStsQlhHblBHWFFTeVZhdVp6dXU2YVRmNjh3T2JVRVlsc2Fh?=
 =?utf-8?B?WnhTQXo4L043NEptd25wVlVzRzh4ZkRkZUI3ajNxaTJLdEtKanBmcWVIVW1n?=
 =?utf-8?B?ZXByTWlNUUFJSzlnczRZdW5VcXJDVlV6TTVOMUpaK2JlTVRQTWQzWGwxOEU4?=
 =?utf-8?B?QVEwQ3VOVVpiWEtvYW9uWjhLTjdQVjNmZG5nU0pPb2JUWW5LRGdBYVV0encr?=
 =?utf-8?B?R3RnYnlDTkVxTjA2bmpzeVkwZXdBd3NOeHZIMGJOWllpdk41b2dYa2IxdXdH?=
 =?utf-8?B?N3RJUGhkWDNmN05ONDlQWktLVk56bDZsbFIzb0RSTDNZOFA5NVpNOVNwVkdY?=
 =?utf-8?B?ZW1odWdWNU1HOU9lbkpJM1gxWW1uTHhRL2tyV3l6S21QaXlPTWdWUCswT2Mw?=
 =?utf-8?B?ZGRoem14TXZMWVZzaisvcGpqYjB6cTNkMFNUSXdkM2NQWU5oQVRNWFVaWVZh?=
 =?utf-8?B?dVo0RUc0Mmo2L3B4cFZCWjQ4RFN2bXZIYXozaFdvTFYzd1pNQk5MSU1wazJC?=
 =?utf-8?B?VXVueU04M01SRlZ4TFFPMFZHWUJVYXRTVStsWlZqdjRjdjhiOExDT2Yzd24v?=
 =?utf-8?B?WDU0aGhCRFFBWkhnR1ZzNithdEVqSlpwNkFub0VOcDVHR3RzdFJzd2VyUHZi?=
 =?utf-8?B?UFZKbTYvOHpXa2dOLzYxQ21RUzU2QTQvVm1lQlJScUU3dllVeWl6bHB0ZmZU?=
 =?utf-8?B?M2FhVGp6SndteXAzMW9JM1F6QW9XN0lJM282UGVGTSt1d3FwTjQ3WWpSSXdM?=
 =?utf-8?B?S3BORVFGb0dKc3FqQm5lQWxFcEtrTnAwd1ZkRnhhOFdQR3ZOc0FiYkFnRUMz?=
 =?utf-8?B?eG5GMmhaS0hoTVowc2Q1REw0WkE0SGdWZ0QwdkZqKzZnQjNrTkNiUlpHT2tk?=
 =?utf-8?B?VVhRNFZoUFVjSThRTnVxZ3lucGJwSkJnSWdIaUg1VERZWVMzZEZWYWVMZGZr?=
 =?utf-8?B?cnc1WlhyWXZHVUlacVZNMDczNWdvaXBjeEZwS1ptSlJlNkNLZWc3azVhMisw?=
 =?utf-8?B?VzJzaXgzK2xkR2VaaDlUNjZObW4wZy83YmhmOTJMM2VCbnB1SlQ4Ry9LMlJv?=
 =?utf-8?B?MHV5cTB1YjBTM2pNT3E0NWhmdTVqK0dpNktwbFdnTWlGVEM3L0hlaGNKd2RW?=
 =?utf-8?B?Q0dxUnA2WUcwd2pQKzJiL1hYelpsY1RoS3QzVW02d2lsQTdWc0wxQ3oxSU9q?=
 =?utf-8?B?YzZxTmdYNmlLYlRpWXd4ZFJWK0RiZVVDTjFGWVE2WGpORUVnNjRJOVZZdm1l?=
 =?utf-8?B?b0ZwVUE3TVp4MWdBSmhwSVVJcFZEY3JheHhuazZCcW40NlVNSU5pWXAyTXhG?=
 =?utf-8?B?MnNCeDVQR1Z4YmRwWWJUMUJJdWlBRDFqUWc2S09zMnhzNmJQanUzZWxOY0Ju?=
 =?utf-8?B?V2Vlc2pUdGNaYnh1eWpXTHNoV2FJaUwwN2ZqWEdaMXBDNEdpYnYyMHRBYjRN?=
 =?utf-8?Q?FUq8yz/pcIT6RVkQvJku9DyXp?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588d760b-57d6-4834-5298-08dc4a9c4f04
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7170.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 18:17:28.9178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6l4hYt/j/j63zNssGp1GBhgzzB/Zrmqv1fWTEbZL0fB2Idf68uNwRBFsRGZS9TZJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6896

[resending as plain text stupid phone]

Aren't these local errors, triggered by failure to send the close? Servers =
can fail the close too of course, which should also be retried, if appropri=
ate to the error.

Tom.

Mar 22, 2024 10:50:10 AM Steve French <smfrench@gmail.com>:

> Do you know a repro scenario where you can get the server to return
> EAGAIN or EBUSY?
>=20
> SInce close is also issued from other paths than the one you issued
> retries from (_cifsFileInfo_put) - are there other cases we should be
> retrying?=C2=A0 e.g. error paths in do_create and atomic_open, cifs_open,
> cifs_close_dir, find_cifs_entry
>=20
> Also do you know a scenario where we can repro the negative total open
> files count?
>=20
> On Fri, Mar 22, 2024 at 2:33=E2=80=AFAM Ritvik Budhiraja
> <budhirajaritviksmb@gmail.com> wrote:
>>=20
>> Attaching the updated patch
>>=20
>>=20
>> On Fri, 15 Mar 2024 at 01:12, Ritvik Budhiraja <budhirajaritviksmb@gmail=
com> wrote:
>>>=20
>>> In the current implementation, CIFS close sends a close to the server
>>> and does not check for the success of the server close. This patch adds
>>> functionality to check for server close return status and retries
>>> in case of an EBUSY or EAGAIN error
>>>=20
>>> Signed-off-by: Ritvik Budhiraja <rbudhiraja@microsoft.com>
>>> ---
>>> fs/smb/client/cifsfs.c=C2=A0=C2=A0 | 11 +++++++
>>> fs/smb/client/cifsglob.h |=C2=A0 7 +++--
>>> fs/smb/client/file.c=C2=A0=C2=A0=C2=A0=C2=A0 | 63 +++++++++++++++++++++=
+++++++++++++++----
>>> fs/smb/client/smb1ops.c=C2=A0 |=C2=A0 4 +--
>>> fs/smb/client/smb2ops.c=C2=A0 |=C2=A0 9 +++---
>>> 5 files changed, 80 insertions(+), 14 deletions(-)
>>>=20
>>> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
>>> index fb368b191eef..e4b2ded86fce 100644
>>> --- a/fs/smb/client/cifsfs.c
>>> +++ b/fs/smb/client/cifsfs.c
>>> @@ -160,6 +160,7 @@ struct workqueue_struct=C2=A0=C2=A0=C2=A0=C2=A0 *de=
crypt_wq;
>>> struct workqueue_struct=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *file=
info_put_wq;
>>> struct workqueue_struct=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *cifs=
oplockd_wq;
>>> struct workqueue_struct=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *defe=
rredclose_wq;
>>> +struct workqueue_struct=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *ser=
verclose_wq;
>>> __u32 cifs_lock_secret;
>>>=20
>>> /*
>>> @@ -1890,6 +1891,13 @@ init_cifs(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out_destroy_cifsoplockd_wq;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>=20
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serverclose_wq =3D alloc_workqueu=
e("serverclose",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!serverclose_wq) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 rc =3D -ENOMEM;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto out_destroy_serverclose_wq;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D cifs_init_inodecache(=
);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out_destroy_deferredclose_wq;
>>> @@ -1964,6 +1972,8 @@ init_cifs(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 destroy_workqueue(decrypt_wq=
);
>>> out_destroy_cifsiod_wq:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 destroy_workqueue(cifsiod_wq=
);
>>> +out_destroy_serverclose_wq:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 destroy_workqueue(serverclose_wq)=
;
>>> out_clean_proc:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cifs_proc_clean();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rc;
>>> @@ -1993,6 +2003,7 @@ exit_cifs(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 destroy_workqueue(cifsoplock=
d_wq);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 destroy_workqueue(decrypt_wq=
);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 destroy_workqueue(fileinfo_p=
ut_wq);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 destroy_workqueue(serverclose_wq)=
;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 destroy_workqueue(cifsiod_wq=
);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cifs_proc_clean();
>>> }
>>> diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
>>> index 53c75cfb33ab..c99bc3b3ff56 100644
>>> --- a/fs/smb/client/cifsglob.h
>>> +++ b/fs/smb/client/cifsglob.h
>>> @@ -429,10 +429,10 @@ struct smb_version_operations {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* set fid protocol-specific=
 info */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void (*set_fid)(struct cifsF=
ileInfo *, struct cifs_fid *, __u32);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* close a file */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void (*close)(const unsigned int,=
 struct cifs_tcon *,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*close)(const unsigned int, =
struct cifs_tcon *,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cifs_fid *=
);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* close a file, returning f=
ile attributes and timestamps */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void (*close_getattr)(const unsig=
ned int xid, struct cifs_tcon *tcon,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*close_getattr)(const unsign=
ed int xid, struct cifs_tcon *tcon,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cifsFileIn=
fo *pfile_info);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* send a flush request to t=
he server */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*flush)(const unsigned =
int, struct cifs_tcon *, struct cifs_fid *);
>>> @@ -1420,6 +1420,7 @@ struct cifsFileInfo {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool invalidHandle:1;=C2=A0=
=C2=A0 /* file closed via session abend */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool swapfile:1;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool oplock_break_cancelled:=
1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool offload:1; /* offload final =
part of _put to a wq */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int oplock_epoch; /=
* epoch from the lease break */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 oplock_level; /* oploc=
k/lease level from the lease break */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int count;
>>> @@ -1428,6 +1429,7 @@ struct cifsFileInfo {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cifs_search_info srch=
_inf;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct work_struct oplock_br=
eak; /* work for oplock breaks */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct work_struct put; /* w=
ork for the final part of _put */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct work_struct serverclose; /=
* work for serverclose */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct delayed_work deferred=
;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool deferred_close_schedule=
d; /* Flag to indicate close is scheduled */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *symlink_target;
>>> @@ -2085,6 +2087,7 @@ extern struct workqueue_struct *decrypt_wq;
>>> extern struct workqueue_struct *fileinfo_put_wq;
>>> extern struct workqueue_struct *cifsoplockd_wq;
>>> extern struct workqueue_struct *deferredclose_wq;
>>> +extern struct workqueue_struct *serverclose_wq;
>>> extern __u32 cifs_lock_secret;
>>>=20
>>> extern mempool_t *cifs_mid_poolp;
>>> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
>>> index c3b8e7091a4d..c1379ec27dcd 100644
>>> --- a/fs/smb/client/file.c
>>> +++ b/fs/smb/client/file.c
>>> @@ -445,6 +445,7 @@ cifs_down_write(struct rw_semaphore *sem)
>>> }
>>>=20
>>> static void cifsFileInfo_put_work(struct work_struct *work);
>>> +void serverclose_work(struct work_struct *work);
>>>=20
>>> struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct fil=
e *file,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct tcon_link *tlink, __u32 oplock,
>>> @@ -491,6 +492,7 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cifs_=
fid *fid, struct file *file,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cfile->tlink =3D cifs_get_tl=
ink(tlink);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_WORK(&cfile->oplock_bre=
ak, cifs_oplock_break);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_WORK(&cfile->put, cifsF=
ileInfo_put_work);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_WORK(&cfile->serverclose, se=
rverclose_work);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_DELAYED_WORK(&cfile->de=
ferred, smb2_deferred_work_close);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_init(&cfile->fh_mutex)=
;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_init(&cfile->file_=
info_lock);
>>> @@ -582,6 +584,40 @@ static void cifsFileInfo_put_work(struct work_stru=
ct *work)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cifsFileInfo_put_final(cifs_=
file);
>>> }
>>>=20
>>> +void serverclose_work(struct work_struct *work)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cifsFileInfo *cifs_file =
=3D container_of(work,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cifs=
FileInfo, serverclose);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cifs_tcon *tcon =3D tlink_=
tcon(cifs_file->tlink);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct TCP_Server_Info *server =
=3D tcon->ses->server;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int rc;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int retries =3D 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int MAX_RETRIES =3D 4;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (server->ops->close_getattr)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D serv=
er->ops->close_getattr(0, tcon, cifs_file);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 else if (server->ops->close)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D serv=
er->ops->close(0, tcon, &cifs_file->fid);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (rc =3D=3D -EBUSY || rc =3D=3D -EAGAIN) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retries++;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msleep(250)=
;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } while ((rc =3D=3D -EBUSY || rc =
=3D=3D -EAGAIN) && (retries < MAX_RETRIES)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 );
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (retries =3D=3D MAX_RETRIES)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 printk(KERN_WARNING "[CIFS_CLOSE] Serverclose failed %d tim=
es, giving up\n", MAX_RETRIES);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cifs_file->offload)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 queue_work(fileinfo_put_wq, &cifs_file->put);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 cifsFileInfo_put_final(cifs_file);
>>> +}
>>> +
>>> /**
>>> =C2=A0 * cifsFileInfo_put - release a reference of file priv data
>>> =C2=A0 *
>>> @@ -622,10 +658,13 @@ void _cifsFileInfo_put(struct cifsFileInfo *cifs_=
file,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cifs_fid fid =3D {};
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cifs_pending_open ope=
n;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool oplock_break_cancelled;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool serverclose_offloaded =3D fa=
lse;
>>>=20
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&tcon->open_file_l=
ock);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&cifsi->open_file_=
lock);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&cifs_file->file_i=
nfo_lock);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cifs_file->offload =3D offload;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (--cifs_file->count > 0) =
{
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&cifs_file->file_info_lock);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&cifsi->open_file_lock);
>>> @@ -667,13 +706,20 @@ void _cifsFileInfo_put(struct cifsFileInfo *cifs_=
file,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!tcon->need_reconnect &&=
 !cifs_file->invalidHandle) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct TCP_Server_Info *server =3D tcon->ses->server;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 unsigned int xid;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 int rc;
>>>=20
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 xid =3D get_xid();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (server->ops->close_getattr)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 server->ops=
->close_getattr(xid, tcon, cifs_file);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D serv=
er->ops->close_getattr(xid, tcon, cifs_file);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 else if (server->ops->close)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 server->ops=
->close(xid, tcon, &cifs_file->fid);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D serv=
er->ops->close(xid, tcon, &cifs_file->fid);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 _free_xid(xid);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (rc =3D=3D -EBUSY || rc =3D=3D -EAGAIN) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Server c=
lose failed, hence offloading it as an async op
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(=
serverclose_wq, &cifs_file->serverclose);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serverclose=
_offloaded =3D true;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>=20
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (oplock_break_cancelled)
>>> @@ -681,10 +727,15 @@ void _cifsFileInfo_put(struct cifsFileInfo *cifs_=
file,
>>>=20
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cifs_del_pending_open(&open)=
;
>>>=20
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (offload)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 queue_work(fileinfo_put_wq, &cifs_file->put);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 cifsFileInfo_put_final(cifs_file);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // if serverclose has been offloa=
ded to wq (on failure), it will
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // handle offloading put as well.=
 If serverclose not offloaded,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // we need to handle offloading p=
ut here.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!serverclose_offloaded) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (offload)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(=
fileinfo_put_wq, &cifs_file->put);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cifsFileInf=
o_put_final(cifs_file);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> }
>>>=20
>>> int cifs_open(struct inode *inode, struct file *file)
>>> diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
>>> index a9eaba8083b0..212ec6f66ec6 100644
>>> --- a/fs/smb/client/smb1ops.c
>>> +++ b/fs/smb/client/smb1ops.c
>>> @@ -753,11 +753,11 @@ cifs_set_fid(struct cifsFileInfo *cfile, struct c=
ifs_fid *fid, __u32 oplock)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cinode->can_cache_brlcks =3D=
 CIFS_CACHE_WRITE(cinode);
>>> }
>>>=20
>>> -static void
>>> +static int
>>> cifs_close_file(const unsigned int xid, struct cifs_tcon *tcon,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct cifs_fid *fid)
>>> {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CIFSSMBClose(xid, tcon, fid->netf=
id);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return CIFSSMBClose(xid, tcon, fi=
d->netfid);
>>> }
>>>=20
>>> static int
>>> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
>>> index 4695433fcf39..1dcd4944958f 100644
>>> --- a/fs/smb/client/smb2ops.c
>>> +++ b/fs/smb/client/smb2ops.c
>>> @@ -1411,14 +1411,14 @@ smb2_set_fid(struct cifsFileInfo *cfile, struct=
 cifs_fid *fid, __u32 oplock)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(cfile->fid.create_gui=
d, fid->create_guid, 16);
>>> }
>>>=20
>>> -static void
>>> +static int
>>> smb2_close_file(const unsigned int xid, struct cifs_tcon *tcon,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct cifs_fid *fid)
>>> {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SMB2_close(xid, tcon, fid->persis=
tent_fid, fid->volatile_fid);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return SMB2_close(xid, tcon, fid-=
>persistent_fid, fid->volatile_fid);
>>> }
>>>=20
>>> -static void
>>> +static int
>>> smb2_close_getattr(const unsigned int xid, struct cifs_tcon *tcon,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cifsFileInfo *cfile)
>>> {
>>> @@ -1429,7 +1429,7 @@ smb2_close_getattr(const unsigned int xid, struct=
 cifs_tcon *tcon,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D __SMB2_close(xid, tco=
n, cfile->fid.persistent_fid,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cfile->fid.volatile_fid, &file_inf)=
;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return rc;
>>>=20
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inode =3D d_inode(cfile->den=
try);
>>>=20
>>> @@ -1458,6 +1458,7 @@ smb2_close_getattr(const unsigned int xid, struct=
 cifs_tcon *tcon,
>>>=20
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* End of file and Attribute=
s should not have to be updated on close */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&inode->i_lock);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rc;
>>> }
>>>=20
>>> static int
>>> --=20
>>> 2.34.1
>>>=20
>=20
>=20
> --=20
> Thanks,
>=20
> Steve

