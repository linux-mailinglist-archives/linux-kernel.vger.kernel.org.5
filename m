Return-Path: <linux-kernel+bounces-98355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FE88778CF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC851F21724
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 22:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CC23BBD6;
	Sun, 10 Mar 2024 22:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c18A/qGC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z3aASWJR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE97B1DDC9;
	Sun, 10 Mar 2024 22:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710110390; cv=fail; b=QFy9XBJCR5ebnHQRnwPnC3liKkvDr5LyieCzxtDmMA0uWGYKIEjUAXI7vREzAaq4s4UmmQxOzkIH6S46m7rGL9iPrVYRaaJa1ZU7tWjk08lo9bT3RRPPM42KNtE53lTYSx9JadNW8ZnMUZPr1hjhosziyqTjUcl1VoA4oJJiitg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710110390; c=relaxed/simple;
	bh=8MFGryfuxXQBDl97bEDnvNSbkfIfZn+vByK3bGj8BtA=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=iWOYPOsD+bae8mFArzphkK4SuGC4TksfctSX9EvlrhKiwW96zLsOTF23/7Kt3HCXg9A5Da/F+0Oq2GKo5NxLiGqJ09JjrR2hyfR0lnVMdpM179AfxZxBRBYT7jutdydziAmjyAysMd1l7MoZAkmwJXDef7BNL27dEDJ11PVx0eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c18A/qGC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z3aASWJR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42AKQqPk030849;
	Sun, 10 Mar 2024 22:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=87nBSNvWhO+4FAExUBvm1kiPH3HPouJUHBtiv1txYCM=;
 b=c18A/qGC2IL9519p2wgSx6w8T6Eal59ZUF4nNnpY4Z8moqRYoKGIC61fG430FTJMo//w
 3SZgvphj9cqc7rWVteTXo88rih9aIq06EeDzy7BzRmbNZOV5JAtVlqk7j+9w66Ymtbzg
 1/zyL9gbFhOtz9SXhNQCubvWcN8nzFmU+DG3jKLkokh6/rhvxH3m4wrOQxQmA0lfShn7
 BcTaPvZ1Uwtf6dndwHBiSYAN/HRnHnkBSBjVFnctVv6LGkj7ToO1EYnPkd/gEnk+/6r3
 pkATzj0J64TlGxkwfLZJZBT2eX0g6CMat4U3HKuwExLGFw6T302XvaV7kJeJhenbngKz 6w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrepcsudy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 22:39:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42AJ5V2f038054;
	Sun, 10 Mar 2024 22:39:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7b7gfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 22:39:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSQXhD+0Ijno5re/vrA8ubqrQXg9TWA9DfAk0OyDXeuhlvegn3urBMo3w4hJ/syf70tvskXA5IWZW5fOlW60JxxVayeIknEhExU+JeY064AiTMMh2UZMA0XgJLL958nbheLTRUdo9dr0P5n5ylYfaZ26F1lhPS23Fom9IWWWo/dR1VgvlS/A1d/BbJePOPnl+pdWdoJ3J1b42xRf0GjeKMhizb6CqXesmJaxuXlmhXEgR6vlD9DWqu+IepBlKqyee5wOZSvrq6Nm8UWWKvwiht60mt/6oPzWtifyPG32p7dAbTSip4skR3UNe76IY4zvEXXPnSbI7JztV8rM4TGu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87nBSNvWhO+4FAExUBvm1kiPH3HPouJUHBtiv1txYCM=;
 b=YYudVKYAU/TLRRydNqHVCcKy85L9za0H7UuimhcT2b3n44EcFYXRSLWtOE4ElKzyNAbIxuLXGTTdhgQ46TIAyNEgnCet9J3odP+9U7g3LqVnZBn1wAYJ5hXlOrXqaHrmLphBB2c9K4AImwki9kIQ3VwVO2bFB58Jj5ddnDlvitSU22nfK/hZbFb1taM9tdkPiY8YtSgFYT1WqiU0QIlvQUt5rpM4ZAIYR45FtcHOa5gevXSlIl6fpOq3TfvcTT74j2gN85Omn8cOeA8oN8rw6yZVdKIcSasqa9kBrZJdBurrd1+D/pDacQ7gWijBmLflLxZ9d86pADdlhOvuV1DO9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87nBSNvWhO+4FAExUBvm1kiPH3HPouJUHBtiv1txYCM=;
 b=z3aASWJR8iDCzugcIAgwy+aqc/U6ig7wCa4hPcTwUGSg1dugBszZacuXOFNlfUVsf5OCYTSYqeyI/FGUojtgKflJe30lvlxnxIzysBzD0S8SMLFrdIr9APa1rPQkBl9fPRHOGeIx/wkrayp6e35uva+vFH4pUVK5NTPp3oxsoXo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH8PR10MB6646.namprd10.prod.outlook.com (2603:10b6:510:222::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Sun, 10 Mar
 2024 22:39:07 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7362.031; Sun, 10 Mar 2024
 22:39:07 +0000
To: Justin Stitt <justinstitt@google.com>
Cc: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Kashyap Desai
 <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        "James E.J. Bottomley"
 <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
        Ariel
 Elior <aelior@marvell.com>, Manish Chopra <manishc@marvell.com>,
        "David
 S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Nilesh Javali
 <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Don
 Brace <don.brace@microchip.com>, mpi3mr-linuxdrv.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        MPT-FusionLinux.pdl@broadcom.com, netdev@vger.kernel.org,
        storagedev@microchip.com
Subject: Re: [PATCH v3 0/7] scsi: replace deprecated strncpy
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-0-5b78a13ff984@google.com>
	(Justin Stitt's message of "Tue, 05 Mar 2024 23:34:35 +0000")
Organization: Oracle Corporation
Message-ID: <yq1edchd85j.fsf@ca-mkp.ca.oracle.com>
References: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-0-5b78a13ff984@google.com>
Date: Sun, 10 Mar 2024 18:39:05 -0400
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::40) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH8PR10MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: 94473565-6fc5-47ae-f949-08dc4152e592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aPVu1dFMZBZyeC45z4hpWDrvhXq7NjHlX6dUbJdh8kkmuXfK5uj+vw5F2mxHl1s6S59Gt00ehx6J5cNOowgJvLNsAxMRHg8jpHG1IPX6u49vyaWL3UHJWQdoY8sYrP6q8L9pQbWrQDe0Ybq0f1nv5Qbso9rjfwRvAVVFMblwdLyRbECgRvEJFW4dzDEMqw99Mkl9s0dnHDIVALxAjVttcyXzX8lvnh6IFFcKCKOrN9/CHx/lmNSmeLs2+bbvETyBxFdpjt2oHW6NV6YsRmmF3xrqyCtH5J0XD1P0SXCd/mTalpVsO3wc9ZV6tGb0t5hhyOzDvEaX/crg/ARIH7S1QA2UamNSsa0ZeRQ/tSHmkh36pRiqBDkY6SFYWDaPowT5hpr5qAygUQAKvi8wPqDoZVSYpYT8sCHjVGY6/HVJ+lfutnN8wzm+uKuvctw4bTyr8Wd3PK3aPPekai11PI+wml02SRJTpaqrpkv5KXpBFg/D6m/9/c4E9/2HLEhCkL2zRVKYataMwdcsGdOhQNXP/8/5hW/fbbefQrguWpkCu4gBuPE74Jz0qJy1Bqzg40jVezaVG6Z0AaDPCfHvGFDCgNgM97Z4qnZ3g98dwF1L0X5JubYJXS1xyB/h3EZsZhLgayF3Xl+85qSTMnrK+/IQCWZNAsBkMH37rd/KL7nluFg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+DO9xLWxtEFEhiMmnViLLwZ1esWsgyv/YnMc/qpuppcpIbwxuDO3VFTpVLfU?=
 =?us-ascii?Q?Lled4Sen/m3U8wKtYhOKmqE9xPXR8ntzVqfAxh7IQvy4pNnBFwRRZoWRnyQd?=
 =?us-ascii?Q?DBUuhHsvJbmrCGOHP4yJK4iuwFZiPcrHCSTy0eZbQWrfqv4volBkgWU2WJlg?=
 =?us-ascii?Q?JTs+ZxaOOLJc74i7fwfzh2+3cRdch1/0k3fY5gcWYjgISNSEkiv4BZ2F2EaX?=
 =?us-ascii?Q?JXnnh9285YaoZAM+LvcEpOpRFXJFBnvrlJgag0L43ownaafl/IfSQsLOdn5I?=
 =?us-ascii?Q?OoCxdvh6MbYi/vh2mjWsLneRJFfzmFuFJOl9+JeqNmzuxjC36KhJFrDNzspp?=
 =?us-ascii?Q?FVmgKFhaF/xR728U49VsBJc3uGZ2CtG8GkXL7rNYC+67QjdenRyc7H4EUrS+?=
 =?us-ascii?Q?82031d4fI4gaEkDAnzJSbVB9vdHlTzJsYBswwYy9rtXerUhfYA4sITJSSdbX?=
 =?us-ascii?Q?aTfqRuxwP735VsaGoIED54mTWtaPTqv+wih6uzofLPqQdoczb14cluM4eUGv?=
 =?us-ascii?Q?mnq2tr5Mj9umIj3b/DWauNKvR9P7rKy/3e5htSpiN5wpNF1KMhOSIQqFlrEp?=
 =?us-ascii?Q?Lcq3wPP51kNb4MoKF6+jeLbQKuTQYp7b66xp/+xtr8oOXnvmT7hYHfp6r6B0?=
 =?us-ascii?Q?EzJPu8V6XA/8u/wkiCwM8VDkwaJFI7weAGAFu4qA9ih1mKf0RGRL+wkx223a?=
 =?us-ascii?Q?qp3ONhX46hbkpmzxpRlXv6Lf1LGbw/Nm2eJ45gv7zVQSyv9Mknw6t8DcunAu?=
 =?us-ascii?Q?6SqKMpwWFapSk8UA4x0MqwLsahF1ij1zOwE5QPtFpKrrjKBKiqy0+My//BIC?=
 =?us-ascii?Q?p360xbg23d8IIxvwSKz0qLIDhGA3XCieShADn+MSmacBp6mN+Q2l3dAH39k1?=
 =?us-ascii?Q?Wdjf6dA8g3i7xQMRuCKT8nqt7riaVL5BlYHBaP1DoNhRjxOeHtMwlC4xXMgj?=
 =?us-ascii?Q?/hQN+wNgQilKnYRA0P4xB00kffhTnJlUu4QD/Rejk5pKES8uE+dkW+NS7XGo?=
 =?us-ascii?Q?50lH1pEJTGr0/Ig05NP3tQV/aX/6/40PWliU0YipwT2dJ1+2RxegCIyY8qsa?=
 =?us-ascii?Q?u+fAatlSmrvXWNHsNRPOlWxAs5MUIR4hRro59KlYN1rQu4IoIcKzrnxKLsDr?=
 =?us-ascii?Q?CMwjymX2XJBl9QBXobFiqr9n8gqBeRxnf1IkiwF6EoKeVVuXahxlGnWBvvWU?=
 =?us-ascii?Q?2MUAQPHfEs8nYGlwpjmPN5BrwUA0+gBZU+2nXbiWEkyKwPGcgrLwUA96rfq1?=
 =?us-ascii?Q?KdDEZf3o79Pyb82QoM9XZzqNFAXarPXiV6UP57Xl/m16t4rov5eLEvohMyBG?=
 =?us-ascii?Q?T2vD/UJcLZsheSXcvomlF6is1HBdz7qzgXSCovEbtRgbu1yHYk9r2EwcSwgQ?=
 =?us-ascii?Q?KDfhQ9YzTJQyYJ5Rv9Ls0zIy5pAent5lXpDS5KlPquhg2Si6JUdxjqCmn8GP?=
 =?us-ascii?Q?QGwnXuZXRYIl+oUXDLftvqGsw488n8/UGaPd4FfbStYon34/iExrTayeOrWV?=
 =?us-ascii?Q?uUdoK9imYbAwPrgEGfioffqB2qXcJWMjjYeerKLPgYD08ABA14WJUa/86vWK?=
 =?us-ascii?Q?L/a5eQVLkGbDHDZklUfv7qogMWVY7nIsGaaEpS83SWgvWMkjj66sdajlPsnZ?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LSMvlMPzdeWWgLsIXYNa+SWMCLOpMLov+2JE2MUZ+TPHtWWlkVu5hCznWHBk1pwuYidXBrh64tR7F1Fqn5Rg3l7NKsbvRTm+2yCnRC3WPJPvE7jWJZwTwDwdjxnp5J3KRIrD/7YtfzYX43LCCoXAarJ2fgFOuywVeDYnl6Qn7860QW8GfyA6DyGJUmBpcGAyRmoXGLYCkJkBTe3ga8KdgYFR2K17mZuKg/juRuZQUZn0lZ0F5bFufTI6bQR3B+0/JXBKGuIyq967fmXJo7FdL+jY9voyAedrbAKeKgwbj5XU8Z6en6xaHv8SEmZhqi4zQaOlTWJJoeE2yvC7Nfxk0wZa/0z9je2NtZ14pleRMoN1atpZlXgc6aOYdQxsrZhS1hxuZpN0jOZmVTFkSDSPCY9VSY3TlYRSZhlDC47V38r2E5uZuRgh99RkmwVgpDK45MYIg7syTxHDkY4MhYwWe5C298zOCcybn78ESYiuTnMMwGgkrv2tYIH0JlAsGwrploi3Hs2vUFlzbT8BirTaHsIzpCJy1XiLDwVz4QIlNVlviPgCyON9OK2kDqGAhypHQoSqL6HIk2WoYhcyH17Xq6AOjl8Pb9RXKq/vfYa4Ajk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94473565-6fc5-47ae-f949-08dc4152e592
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 22:39:07.5557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KsYb5GUjL7QGGXje7V9Iae4L/j8VyXnwPvSfX75luxrZTCFJbP8PkgyaQjEmypCfAsMmeRBq7nQC7qHMAASt91doccRdctan616zh5TPaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6646
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-10_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=909 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403100184
X-Proofpoint-ORIG-GUID: 2qKn8a0XkZJWm9YPMRmAiToL54MFcHAc
X-Proofpoint-GUID: 2qKn8a0XkZJWm9YPMRmAiToL54MFcHAc


Justin,

> This series contains multiple replacements of strncpy throughout the
> scsi subsystem.

I've queued this up for 6.10.

-- 
Martin K. Petersen	Oracle Linux Engineering

