Return-Path: <linux-kernel+bounces-2976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FB2816572
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8025B1F21FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BB463C0;
	Mon, 18 Dec 2023 03:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DdpNuqiG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B53663AA;
	Mon, 18 Dec 2023 03:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxQKMh+jrJ7FdJmELh6XFKIAuU20oG6V028L4KSK2fxXPk0U0mIh1clbuRSlC59vxkPSH8z9n9blLUsUgcBltb/hi+3z8Ewp8rttyPOmNnqQTnsHhwy/qTxrqCo9fYwKpumH0jV7MmiYScdbwfg1uj0Ceqcxtt5aB44fPFGmfa17RXewNjHDoiKIZQqffPTbKPhkEj8zIfUlPIa4VaeJ81ufTh+Dq0/OvFxxI83Aa8zx9WQFP7gy5RM/meWhncj7+nJglk/V8dNLpnosH00yPDFtHqkSFx5D/64IA9h/rDj3L+5JGZU518gHo1KSnUrZ3dhhykTMfCPfWGJrVX07Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7LcaDiwEE+5epWB0c3Ot+ju47zO+ahh1oFZKFI0vRY=;
 b=S3Fh1Mpjv6EHGM0+scI6ddl3t1/vHDJI6flk0z+3/Ni8GkzB2tN7vkV/2SgjmCvsNoApIEi6Gk2s30QPjq68EkAsEMuHRK/2Kth1MYGdaG+gEB4kVxKrNox8MMdji6+d+Ym/qQReOoHVPSqv/pt5v+13hoh9H5PDN5EIoNuyMma14mxBLxVfzrUdq+3iB4uAkOAVodxgkCaylWK4INgiyxb3P32sJKvj+QQScZ/Ntr/2+mzjX2Ag3IquQZNL2MzB7elqn4ldDtODcP+JpSV42rOj+IPMgnRmcjAMMmyVBQ9SUeP6VPuYLUvH2BgxoKnRpJ0YfpRSnlcLLROHfvNgEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7LcaDiwEE+5epWB0c3Ot+ju47zO+ahh1oFZKFI0vRY=;
 b=DdpNuqiGQv7XAriiTcW1wuYTB3q3Gu7JiCFpCCq8wr+biGMGqj17ijtU+ZjWNs1cTFzh2DisMxcEuQHXyotRIrVbPBG3SR3z0LDRwLeRl4x8WoKSzoy+lzJe7melO2zsEOYWKDR2aIzWmTTZiTEsJbhAhHDhLzHCYePCh2/RAmRY4vtg3d80oktZriFusR1j3el2z3s7xcJjDs68VMJxrGgc9NFkIYDaj67uoRnfQPLjW3aIXYglRAstsIZu1jUOcO5r7/tH2i4mHVBFtiT9iI4Mt2RyByV5nCMt74MmnHWIY5THA9t+Sn+/gOc0TxgSHkXJZt6DAQLHZyIsGTy55Q==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA0PR20MB3405.namprd20.prod.outlook.com (2603:10b6:806:70::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 03:42:02 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 03:42:02 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Conor Dooley <conor@kernel.org>,
	jingbao qiu <qiujingbao.dlmu@gmail.com>
Cc: Inochi Amaoto <inochiama@outlook.com>,
	a.zummo@towertech.it,
	alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlan@gentoo.org
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: sophgo: add RTC support for Sophgo CV1800 series SoC
Date: Mon, 18 Dec 2023 11:41:52 +0800
Message-ID:
 <IA1PR20MB4953BE30DC29820912321C07BB90A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217-swept-uncorrupt-92ac058dba4b@spud>
References: <20231217-swept-uncorrupt-92ac058dba4b@spud>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Jb0HqSOq7LgehUe6RPZqeIy4AFb9yMo8NjF6K/4uIqI=]
X-ClientProxiedBy: TYCP286CA0337.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20231218034153.562704-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA0PR20MB3405:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b9b1ea-7334-4e1b-c79f-08dbff7b4b85
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b7MuOhDQZ7qXeUGgl/GeRj6UUuSjORV27bXoWDO/Hb791U9yMDQTwcchUhYgeAoTisSeFibxnkjb/X7fEm8984EcBYNmaimE4aHioThnmNzloeUlYP05eCRpAKx91tN6fZdksjN66QJwnk3CrhZny3j5DMoVGp44ICZYz1UC1clAybyXD0nrJyKw1vIHqeP63D8vWqYdpJFvMLMHnhwqAEl6zWwIBfyPYu7SHgYf/5NRvT+5XcCG+kUySY39XFad3KtNyW4DYwzyM7ERYy/Tp7Am/J0tNy8Jfr0IQ8pixI8FRsVQcUd4evwHpOv6VRkoj38/NR9TZBoSK6nQkjQ3qtZeeszitguvqNUPU1xpKx2LFO9CGlVWX0SwfQpFtf7q9kSsHsSABsXJC9CtZlywVT/sqL2DjqDQeLCtNVrdWakaD8/Rv2HNMIEYkrq+voBvFDdDrF2ja4cTl9yxwlDq6doxAPPLJ7CPA4ez8Ayx9w7pxtPeforUvb2YAsrhWRM3X3ORRHBp4W259VZD0wv3Y54o8C+tvbzA89NGvT2zoU87y2z69jC2un93IgAWiufXYZn7swe3aKSOblMwTsveDG0VPEBHOikvy8jhwO1NS+c=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qw07aoooew7z6RDFsQhqlzGOKbRLtprYrHiXMdvKitO1mJU6n+IHAgUqXaEZ?=
 =?us-ascii?Q?kAhioXPYXMp0c/At0C9zabzlsnkFvbCrOzKj/GlMe+p+gh9HOkT5cxsK5sXC?=
 =?us-ascii?Q?8m8cLzYRattGMaiKa3aZCjx+w45ZwiUl+pUG5WiSIzXXoU3qVjKX01BcnoUL?=
 =?us-ascii?Q?qbxqqHEt5oWDtVeNIm3vVCoXdownBasPpteEArBzKlsI2UxIQBB7fF9TtET6?=
 =?us-ascii?Q?QnzSy+yfDEsB6jPqT53zYJ+j9XVGJ+3fQxZhploUefYIvYGfUrdVI+8Nbwxu?=
 =?us-ascii?Q?xtH1herPb8s2OfqofORoHxHhUMcPiQDHSUa4vv1pkiD5V+etDNWbi6SCgYqh?=
 =?us-ascii?Q?AeMBJ2THi7phvggD7zRWAEVRLyH8Ybmo8CNoBMo7oAxgw/2IGG4o8qif9tgQ?=
 =?us-ascii?Q?WBPfQ8Uzax3BFYr+RvDWvs2eiQs5i70DacqcPVrApdOJ8rwBPU0+D0Z2EOIb?=
 =?us-ascii?Q?78I+IBhlM2MoDoIEd8eqrQtibyvSW3OLfyLsGE82NwRcPJJ87deER7MwmTuU?=
 =?us-ascii?Q?6jrU1x6othZAkKe8pA/729Sh2a61dT3cDUfawph18/Fd2n8xEj7OQudAjMoy?=
 =?us-ascii?Q?4AI5CC8sAa5+6V0Ynles2/kMNhK6gQplL+SrliKeZqPJYYrMnZ8uDG6DS8Ec?=
 =?us-ascii?Q?2B7aeaYgbV7w1zNECIuIMYwrBb/Jf5SUTmtIqYRWwerwzkZ064NpoPWlC90a?=
 =?us-ascii?Q?FJj8ux4jFqrd4HBYEiHk8+o4lhfSy8j5LgynQd4/T/Sn62wGL9XLrkB9G15/?=
 =?us-ascii?Q?tA1zm12GKWRYHyQGh9h5vwAY63t+GN2kroT+J5eIsjPhShKSjn/9XUVWSs/g?=
 =?us-ascii?Q?HV7gQOLbQo+NkHoz+kSsYmsSN79oNVdwA5T2cdlzGWXhNCyFQyxs88DcUZ2E?=
 =?us-ascii?Q?77a8LyNCgyccJv3dCSuWRPbgAOzeXVhU82yFW5flm2Lr52FYWZrw6Iy1HaA4?=
 =?us-ascii?Q?D/NBe7TT4Splnpb6jqYPfe1oRPznRxQqC9jrFgCbCA47MKya4iVkJtVx5mZH?=
 =?us-ascii?Q?wgEX3RS2sPdswjl5qsINROpKiOOQmK4H7WJTEJRP9NpU6C4XtuBLWEeGEKwY?=
 =?us-ascii?Q?0QA8TBOZpvrCzypjUgw1ABhQhnpdXbY0VsD9rudcp3RBL3MTE4rRh/fsBmOU?=
 =?us-ascii?Q?TlXbjYzz7gSZZDWF673Twk88K8O5iG1KR4cgfzl78ojOuSoY2WA8txFByY8r?=
 =?us-ascii?Q?NSikcFMtxSQfQricXFDo3VbfAA0g77LMy+xEDR0ZIudw2yga+pAgjYYG5Fc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b9b1ea-7334-4e1b-c79f-08dbff7b4b85
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 03:42:02.0448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR20MB3405

>On Sun, Dec 17, 2023 at 09:16:39PM +0800, jingbao qiu wrote:
>> On Sun, Dec 17, 2023 at 8:26=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
>rote:
>> >
>> > On Sun, Dec 17, 2023 at 07:09:50PM +0800, Jingbao Qiu wrote:
>> >
>> > > +  reg:
>> > > +    items:
>> > > +      - description: data register
>> > > +      - description: control register
>> >
>> > > +    rtc@5025000{
>> > > +      compatible =3D "sophgo,cv1800-rtc";
>> > > +      reg =3D <0x5025000 0x1000>, <0x5026000 0x1000>;
>> >
>> > Why are these two regions rather than just one, given they are located
>> > next to one another?
>> > Are they separate on one of the other devices in this family?
>> >
>> > Thanks,
>> > Conor.
>> >
>>=20
>> I think there are two reasons, the first one is to distinguish
>> different logical ,
>> REG_ CTRL (base on 0x5025000) controls clock calibration, sleep,and other
>> functions, RTC_ CORE (base on 0x5026000) has basic RTC functionality,
>> The second is the maximum address used by RTC_CTRL (base on 0x5025000)
>> is 0x0ac,which is much smaller than 0x1000. Therefore, the datasheet divi=
>des
>> it into two parts for introduction, and I also divide it into two
>> parts based on this
>> introduction.So do you suggest that I merge them together=EF=BC=9F
>
>If all of the cv1800 series devices have them sequentially, I would just
>make them one region.
>

I agree with using one region. The ctrl and core region are highly
releated.

Moreover, I suggest using syscon to describe this region, the reboot
device is also in this region.

