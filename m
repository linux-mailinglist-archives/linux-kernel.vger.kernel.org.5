Return-Path: <linux-kernel+bounces-157900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483858B185D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE1D28498A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4268E56A;
	Thu, 25 Apr 2024 01:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QQUmUijW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u1jkryAN"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1823CE;
	Thu, 25 Apr 2024 01:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714007643; cv=fail; b=PagZk3ijJCzUoGVNrTc4aCbksZPltIXw1aRax+Tp9dR2INwHW5pqqIU1wV1feYSJlpDnkG6tK8inI7a5QeppR350XrzNLRIMeYm9oNWohBcVQRcEMlEy4gkiFMBIwBAH6FMRzuzDMxOZF4Sff+SZQs1mFEw0hEQNKJgzVkM14yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714007643; c=relaxed/simple;
	bh=BttFo9H8G91Nrhvp/kt9uxPUeDeD9vbJqumWvUzxGlc=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=blFXUTOYJDIbnfv9QPwJpFR1uoU3b/r/fr468zL+Z9vk7gsjKM4N0owm0jh+5c4Cva1w9WcsdwNltariwzLZHH/pqNQ2vvgH2v86EEF57fiWekmj6k0vpCN9pinHQeX1fHObJCj7CEJQW3cBYlZVtj2bhzO4U9Ogr7ziUK3Hkko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QQUmUijW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u1jkryAN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43P0hu9q027478;
	Thu, 25 Apr 2024 01:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=pjg0gmbXuiuCiwjorsZWVfNVt9vLvlF2beI0kuz5oQY=;
 b=QQUmUijWUn49RXKHB+35bY3QEQ5mFmFexf2KT38bGNKvAXE1fWNsBvQWj2jXHVJGTVu2
 xgHWDurw3yyt8szPFlrJco94i1jFWDmK4zpAhv8G4vt28VbOtZQCyKGY8twWhm9wOf8q
 1VJ7dSMZd/C7UhVP47qHyPv306OPjgEEPhDMI4dYROwM0elM2RFDCeGK6FwZOm1Ljy/2
 IID58IhFSjtZLEqIqAtca485dq2cwxZ1t4MNGQIlqE8C2roYaRy/55xLDUURwJMEFJh1
 B8TnVnOYsyu5X+nLQ9olupXhQKvnGAeejZXAoaZhdBbyStI4EeFdQR6WJqXUthgam7/b DQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5re1h7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 01:13:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43P13QGs019972;
	Thu, 25 Apr 2024 01:13:57 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xpbf5mv55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 01:13:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjTPLxPhkN+kloO5fzSvpPMCIGm9tj09sY94szMfoo7TAj/w+EraAuXKBm8FuU739C1s50WJ/zoalpHqFhHQU2qHQce5MXVp+4jEE0IFn3uj1Fa8B6J0rxYAkmXZwL9Xlo/9RVZ/ZIN09rBfaxxm7du2rXDxyDdgoMhXB8c8Ap/GFifTdEnlVa+ZPcf/96zyxNJMaOi//ZokYIuQRxDhV6DTwdQvA1+Iz1G5Czd1M+e1s9Va/87OhQmZLfnPteIWwKYIMv3xFrV6XkaR2UtIRh4jdSCvmiBoup7NILS1x+yGmLb7gCBc1o3pV/9P8UzZPvb6V0wd95uDxY4XalJHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjg0gmbXuiuCiwjorsZWVfNVt9vLvlF2beI0kuz5oQY=;
 b=Bn5oZqCxhkwIqBo4w1LdKtsDpZ4UXsCYFRopziTvIJTxYTxFfK8RGfSSmi76xrkVplmTUixnjeYJQNxf1BIzsBdb7ATxotdDwctm/k+c1Zl/kIVWqPFNuo0/4NwSfrR/MogVJWINKUajbqQXoSkLxCfh85V6lLgaaQEmy6OsGzxxEnn/8CD7u8quK0fYnEFokaCUVa34pQOiGHwTFyICLXksZYPc4WEkqR4Xe/kukUgfjy3aiH750UxSn+Vta04NzWvn9InItJE571LeQOqQIp8KwWSA5+pWrQ+MgasEnPdbAnoChySr9ovouheggHUj/ECpvWL6v0PwFnr8OASeow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjg0gmbXuiuCiwjorsZWVfNVt9vLvlF2beI0kuz5oQY=;
 b=u1jkryANVbDBrCInXpM/2SxcVNzitFU6Xj88tTaBgy+ebf28QQqRVpuGzrzQa5rB5IrmctZWVS02CEGrMRFCT8re5DrW8TnT2jiQdPBsFcYlPmUSxAifJyGVfjzxMOEeiYBFxC9KOAossJu66G8SU0QD1FHgTaHvqi7Id7+1Dcg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 01:13:54 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7472.045; Thu, 25 Apr 2024
 01:13:54 +0000
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Saurav Kashyap <skashyap@marvell.com>, Javed Hasan
 <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E .
 J . Bottomleye" <jejb@linux.ibm.com>,
        "Martin K . Petersen"
 <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scsi: bnx2fc: remove redundant assignment to
 variable i
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240415104311.484890-1-colin.i.king@gmail.com> (Colin Ian
	King's message of "Mon, 15 Apr 2024 11:43:11 +0100")
Organization: Oracle Corporation
Message-ID: <yq1bk5y8cs4.fsf@ca-mkp.ca.oracle.com>
References: <20240415104311.484890-1-colin.i.king@gmail.com>
Date: Wed, 24 Apr 2024 21:13:51 -0400
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::32) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BLAPR10MB4835:EE_
X-MS-Office365-Filtering-Correlation-Id: b8301f54-a546-48c0-a961-08dc64c4f967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?OHWPlW2aHD67NEW5wUygP5u0YVRn0L4skdrW7ZyBa89ND3bO6+3cRLB/f3ke?=
 =?us-ascii?Q?yYuWuvp1f/y8AREQ9S0XrZlX3z3q6SmpR/GrFfEDzh88tSgeXKH2jwWsRXWX?=
 =?us-ascii?Q?jCjMroEOyN2jBmovgLxxTqkmUETqyyXiYzA8C41ofsNcsT6DkvlLFAjr6pIE?=
 =?us-ascii?Q?NRH8gyvEmoKeGrX/is2I34iVSTWLywD4YGjx4ns1UqGa5RoOGy5wLoRJhUzO?=
 =?us-ascii?Q?GfkTmbq+hi0A+DokoqQE5V/5uIT+8eqxaUzPCeQMvh/Pzx5t+I8ZTe7RzHdd?=
 =?us-ascii?Q?XTG89UZROHalmwptsUaa+4nABLZmcUO2Jb2g+1ZHNWZuxMDUxz/5yy8bWqig?=
 =?us-ascii?Q?l/KYCokyROsgWW4c+oN9L7/uLdvTysIUxvXIMOzPdyfrQ/ohg1eqv67whUGU?=
 =?us-ascii?Q?eybogcdEARnNi4mxK6DSPH59FFNYxeHA4DQnzt0wif4UVRMuraZDGR+wDdYc?=
 =?us-ascii?Q?eBh5NGNqYFUfyZsUOmgm71bLRy/byPH4wmsn/4fX5BcIe1BMUiNjccTUOcNs?=
 =?us-ascii?Q?22jr006NncEuXI5Fy4Y+VgDck0AvxP6jbk9lwVL/gLnO8CqQIisNPMVWUCsl?=
 =?us-ascii?Q?TydwxK2CFzsfRzqiO/cKX29tMv5+iMt4IBMSVrJy44I7uOKmpP9/NI8qeEZ5?=
 =?us-ascii?Q?r0lXyjZrmcbc6hvoFbp/ihf9TLdkUvQWPjqjWVQ9I8DrFPXtuTR3CDfGYvTA?=
 =?us-ascii?Q?o06at5B1kow9DthDTbyK8NiztM5xeABWm5u7a2wRO6zcp0f7v7hwRsi2gqRH?=
 =?us-ascii?Q?BHhs7Gz1DTjyCU3mwJkQYNqJ9nEO34f/9WKoXh7swcZ8HUTn91QIsGeSs2BE?=
 =?us-ascii?Q?J81bknDCGfET8ro6G14DV3WZu8joBVgfAXuhhQ3g+v/W8CT2Mkt98lfyqm1h?=
 =?us-ascii?Q?7Zs0m4AKYHayuE5qannnScnRoqrkTiQeQ1rN3VZni+zqfLG40rnlFkxG3/eG?=
 =?us-ascii?Q?m6cT49blFJKWIX+6xAPpdGIwywgH5gY0CPEy3spCblcOxN8sERUxmc7pTVyl?=
 =?us-ascii?Q?pWPEgGtMJFf+UsVedoKw/9RS3ktEdT2XzS+dGXvo7opilNHBJS6h4J+TseVl?=
 =?us-ascii?Q?nPR6NSxx9FlE4g33CQS/VNqbAi/G8G0mu1+32Dq+JC0TdPIDKI5Fw0E7x3i1?=
 =?us-ascii?Q?DkOGPloT32BVzyqWtCkmSuSyyA/JCBEUDHsmO1iL3nQZtWWXhne60jSknyLo?=
 =?us-ascii?Q?rvfTAUJX0PreAHqLuzRg7mJZDWo8TiZXXNWOQWtIsRYt9EIhdNxbBGzjVPBY?=
 =?us-ascii?Q?s3XbAAKJFf9C5kMR/Ty7jdZEEdj0bDz3kP1NQu0IPA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uxGzwhmXHxfSqev4TV+Os63OBZALWg0Ra+1x12takO25RwpZUOd2AfoUt/nX?=
 =?us-ascii?Q?VcL2Wyyrpq8+uIQWsrDHrqeKRsvE7r79n4QWt0NHc0r+34QXSunOeELfuLte?=
 =?us-ascii?Q?1WPGby08I9paVcWVw/soHb/q8lN3VBEnUA5c+47sUQt+pLKCfjhI91ULljjq?=
 =?us-ascii?Q?xSGeeX1GmHIN7nHH7a7zJ6gzFMplQ4VPGINJs0NcQ7gUiWx4A1WK47iMFgNz?=
 =?us-ascii?Q?xEu1skGCeueuVp84ajA0PUQ4uYEu42EjoX9A7i1ZRDzDtnf3tWfMhe8Euoat?=
 =?us-ascii?Q?SzAquKRh4lZ1VwfY9Tr0fVjSGokI6T52FJUhlAKofdh1oESwKBmwMa7fAL1n?=
 =?us-ascii?Q?syP9/GxudZ/U7PmhHQqB1gX852OxXv3ahPivrKxOLBL6EPR8aXAifzX+J/du?=
 =?us-ascii?Q?XTUJzhFvyrhMGmKFnwRxNbr89/d+rHFle9xGyQj5mSPonIk2Osw1MTBEj+do?=
 =?us-ascii?Q?fasD3KcZaz2JjtypdZ0Fzxo/U485qtJQ2egF0EwCozhs+F6+qqmtlkJfD/kc?=
 =?us-ascii?Q?9G0a/YdFOKRfcqt1mXwmbg3RwplbYlXhsrM/NW1oT9371G2JnhHBHlqY7cCL?=
 =?us-ascii?Q?0aNJnDTOgzrFXA9Jwpc5+eXe0xqLMbLa7SO1Mnz6qncduB4IL/hXl0hgQNr6?=
 =?us-ascii?Q?QeSDIBUziCfIThPDT8PexlcDThHpc8ZPA1pFX/hzZxoBA9tjP6Ey+Q2O38VL?=
 =?us-ascii?Q?JZqHynzoZxESKDChnNIsSorVqxh+LI3Nf+8YImA9Uk+L2Sk5pfkLJAFVKo/G?=
 =?us-ascii?Q?5wlQl/ZICr7z8UGVZOVnQ9l5CTRowUAdH0s49LeoSTF/86BdCyX/vHPEC+jR?=
 =?us-ascii?Q?DNgAxkeJ6zSsfE6zLeIdbqB6rMS6ZXsho8+b4NM0IewbS0J5tlYMPObk3Nsy?=
 =?us-ascii?Q?O4Yh70BxyRe9hIRaTddFb9hbBjeMyZnMBVj8Z2PBaEV8mal2Fu1fB101vxsm?=
 =?us-ascii?Q?4jRtsJP8hkTchNmSNiHuhP+larhEHa2zvNr5DePVh8O55O+PvhhjLZTDQsQo?=
 =?us-ascii?Q?SgCtGNTy1mN40Kn0HmMVXpnEBn9hC3Y3QTthEMqrM+Ol7910JOf3vjLhzZRB?=
 =?us-ascii?Q?bk4rJRmTbBxc7lhoJMAy1roRnIYZ3fnNLyJzBCmgGBJIIHWAzwJfn8So8DTx?=
 =?us-ascii?Q?eox8fUfDnRRPhPDvAKldiYsBs43/bYEEF56waoQ2GmcQnJ+SE45UbcJVN3AM?=
 =?us-ascii?Q?bpeHPwJWpo2fQYrM0h5TlyvDCemSLPzgwTJ8zHQnyhsdBUl5uSU8HW7XLUqv?=
 =?us-ascii?Q?s8jl9m1brMt8FzBrZVPYALSt5JK6YVzZOSbb1frHBrbKdwL137Dn7Y3WN98G?=
 =?us-ascii?Q?FJDmRiVVYAWLnh9O2tLdsUYkPZDtCWK/e+IU4QQzmqaQLfkkmRFBPTY9HxMy?=
 =?us-ascii?Q?QgB5Qjqm1fpy0xwIR+spuQ0mq5smPcCem4jkpYY9Yid7DnKD0b9aKpeXbtJ7?=
 =?us-ascii?Q?V04Y+hYIHT5qpBDieoXY5nLqAB/L7M6791/CXWROsnUP605uPeos1z5x95D/?=
 =?us-ascii?Q?LV0XAPiJsCURH6wqvMD6TVQ1QIebkxqqF11GM3dZfI1cTZXE+S+XkSdsBzfU?=
 =?us-ascii?Q?Fxr08Jjfl5mxSTB/YjnF1nXF4lbtnX0/vliLvkycNioPs6B+DbyJhM2psSIT?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gkG5APSyDbsFxLY3wvJJe5/Ly12FeBEYMr5UhC34stgZaOx7nkeL9JJojPTpkRy7BVTdm3aVGQ3I/Auce6OngIs2XPM3nUloE4qvcV9luRAod+UEgB+SRE7PetFemVmaIVeoTy0FHcjyhmYwA9GhhNYC5fFY9lfM2oJynkgT85cVJVdHuDs64RRfdudw6N1mbQduxepyIYzfehWTalReqnSB89iqkF0jQ2p1UN0GBDUYABvuZdhRJH90lIB47B8JpeyuahJugtDJiDj4M9Qygx9QqoLgt2nV8UYnrp8uEpYSA39dZZwe05gEyZouTowIlQBAtUPH6AbY1ckKJaE690IpgouCXE4URSr+klSTqSWUUPkbUt6hJ1rJaUXDV9VsjZP8CUbes+VNVRc15GHgd9OPLX0ocf64OoPuZdasOXjMafJi102MAxhSg5/vA28XA+YI6k2YCWQZQGTBZ5LplQCyVK2DXpHqNIwaUyBNBT0wEN4gUhSbjqzWVaVNkMdYATqBQkKy7hl/S6CrTrp5VwR599umXyFnb4z25z6I5oRnvFcRQXcxctKYEY3oXF9Y+SdQCqngWZqBbX2oc6J0okxpQBSd3tp92JBimT8aAYk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8301f54-a546-48c0-a961-08dc64c4f967
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 01:13:54.1299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v76QCwduvIKK/R90cZFMKakJOO7QiejTuvS/L5VI4bYDBJCBFoex+8dfiMrnr5qbKIjYLmyIk0mhZ5OyQ7rxd2RdV/+HuVj9tAS6ZBkStyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4835
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_21,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250007
X-Proofpoint-ORIG-GUID: tK7yBc-XM04ld3dxhcGa9p63hJ2nE2xm
X-Proofpoint-GUID: tK7yBc-XM04ld3dxhcGa9p63hJ2nE2xm


Colin,

> The variable i is being assigned a value that is never read, the
> following code path via the label ofld_err never refers to the
> variable. The assignment is redundant and can be removed.

Applied to 6.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

