Return-Path: <linux-kernel+bounces-128293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8238958EC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5971C2367B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771C7136652;
	Tue,  2 Apr 2024 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QeCYUDM1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GktGNeHD"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACB6135403;
	Tue,  2 Apr 2024 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073125; cv=fail; b=gDlSHkq1EUMHDhnNR6F4LGaUwSkVO88qbYtBWHhvBeqeMXWkeWf6l9iJTVicdyS87eFa1rFtvxO9DUVTYKuWoIV8stfv4DyR1xk/EYCg+/IxwvnkXd3Yazl4pL5n/m2+pXZMEIpzr8wgw/tTBjx24G6LHcJtek16H05Xe1bV8MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073125; c=relaxed/simple;
	bh=fZuZ3AsCJOd40SvXK7qWSRFHl6HSlqLeCyuq71NedAo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=squr5AtduuMbrvV7YrIxME6ivMX/IHz7I5/KvmG3twRbu1k2n65TCvKlLV422p6mrVin3HJYqM6EhlCgAGm5Nf6NbjRbrAaW1LtH/qphSuR7n7avoiwRS9HsSG3mz1lk9zK3g0N98JxpFQ7Dxb2MXig6QzpUu3Mobl5PrqTVd3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QeCYUDM1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GktGNeHD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 432FDuZi021239;
	Tue, 2 Apr 2024 15:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=k9uVpFVd6VBj8gbal7F6xnBRZl4eZ7QCP/UM5raV0jE=;
 b=QeCYUDM1S1yKo/dNZNVw6NDNXpr9V3iuVhWeL0yiroZ5IuM1n/BJDGo0OdpRTCh4atbG
 +wkPco9IUq53lu5Aqe1EgbAuaOGXsjTJYARLlVOKh5aOZ0d4IXu8HoVp8Er6hXTmjve3
 cH8lwJLO3CR5TiuUZlbNYuMPbMzPMWFAkkpCpwPOeeHbdrAb2GCJiOQN7G6Kp348sntl
 9e/nTtJlKOrWjp/es0NWT5iDwJ1Pn2kK8b/NEvyhwulOOZ4ytP76v308G50OfGfglKN/
 TXcO/JAyZtR8xAcGMuKdDjmeioXR/APfWtwvoE7ajH0TOkgeL3vVmqEWEixE4INJs+el ag== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x6abud0kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 15:51:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 432FgsXg016172;
	Tue, 2 Apr 2024 15:51:57 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x69670mug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 15:51:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGPQiViKE/uIT/jzt4kyfHyZFopvegTzu0x4lbuv9y/AculTnsP9n3dM/Hga8U6V5TVj3unnWYQbndBnC+INl6mlcQLNYOIInZSDUi7FN8iXEQRoB37SqmhFd6mZWINuHple6sVlpKVHUBgiCJ1CKUZx47EX+obhqitOJ4QCY4ODHNpUJ48mEI9mmy76U7nqiDNZSJ1drchufrU5cCgTIW2B6kgcTAkPWw4VKuy3G4D4qHZSqZ9fQrHMffvz4V3tFBtKXdgytZ86bHpR3hryo4gX7XP6iHh9CSmXYX7VRSdAWrP1OS8dEhDL/I1Z7zf9R5ToqEa0DnVrdiF12ySrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9uVpFVd6VBj8gbal7F6xnBRZl4eZ7QCP/UM5raV0jE=;
 b=XDKl8IV6w+tve6+3PnMqJ4wTjE+HZetGzRQtQTbdUJ3kyB2U1hizLxuZPk6f67r1qiRHd6d8OOMHz32w3a9lEvGnfysgsOV6HOcOIyWOC/OS53clyNliu06JHFQyPUlcwFcJnIK7beBombLx9hbZ34Trp6udVX8ACChyfe3mgPKM9VGBSsGCzecj0ZYg7KNfQD6NLp/D3N8SxaY6PRIsv/z0sp2C66dbRVux/WU+Wl/LJC3Jff+5+f0TUjcIfUJZaWgkWZE0P3TSvGWQ0j+mxj2kzOKoRR3bttB9U5oi9tc7ezW8WiXvEPdkFcccN8+VGu0xgwG5R9VaMlkhmB/yOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9uVpFVd6VBj8gbal7F6xnBRZl4eZ7QCP/UM5raV0jE=;
 b=GktGNeHDXmC+JXOE9gwusrBL5RLy8OIyfXts5o9Wc+PEZi+FBfoImbUlpyVtA8x++klB09giCvlcKnENR3lZEsvFKtPrvx/iLpGOp4SpgWE5jh/kgQYdBCO8RV3oHF2L4nxseinEoiUrG+zC/e2v0tQXulgxa23o4c0TGnGqMw8=
Received: from CH3PR10MB7959.namprd10.prod.outlook.com (2603:10b6:610:1c1::12)
 by CH0PR10MB4860.namprd10.prod.outlook.com (2603:10b6:610:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 15:51:55 +0000
Received: from CH3PR10MB7959.namprd10.prod.outlook.com
 ([fe80::fccf:9a21:99be:ed8a]) by CH3PR10MB7959.namprd10.prod.outlook.com
 ([fe80::fccf:9a21:99be:ed8a%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 15:51:55 +0000
Message-ID: <e3ab1a65-5551-4a92-9972-14987426ea9c@oracle.com>
Date: Tue, 2 Apr 2024 08:51:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: qla2xxx: Fix off by one in qla_edif_app_getstats()
To: Dan Carpenter <dan.carpenter@linaro.org>, Quinn Tran <qutran@marvell.com>
Cc: Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Larry Wisneski <Larry.Wisneski@marvell.com>,
        Duane Grigsby <duane.grigsby@marvell.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <5c125b2f-92dd-412b-9b6f-fc3a3207bd60@moroto.mountain>
Content-Language: en-US
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle America Inc
In-Reply-To: <5c125b2f-92dd-412b-9b6f-fc3a3207bd60@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0120.namprd05.prod.outlook.com
 (2603:10b6:a03:334::35) To CH3PR10MB7959.namprd10.prod.outlook.com
 (2603:10b6:610:1c1::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7959:EE_|CH0PR10MB4860:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fAABU4xsW5KqTmKzDsVuYkLePUDX6n/wR8U0JrEmzrmqW8L2HpmBy/HEjQ8DOHLNCvnS3JPyE/Kbicgn+6g2gegran1pj6/YZP3EWXUwg1KwHFGJm2Djj9MYQHIA2crZ+0ZcbXn3Ubkbet9W40mVF0MMy4XcW2sWaVt05C3uYip5q7xZrzGE7XLfDGRC/ZaOEZbc/I+Hp+bafmI6ZKGH7Z1w5MKHfejwnmFx3ImXF3YjLK5NYuq82IrtAexie4AVM6hT49iFLmHtc2BrAgCukCY2IqsVlV0+6WtG6qsiTXgrO140SoNOjrSUICdnwSvpNFluk3z027+pKtvI3u9S/sp7XwAQRVmmCdONWluknD1AYc3C5kxu239F3xSuDOWb/1H60o/tLJOG2/SLhnbByb7aWmd2kJ5ln5HYyb8fnTVyvQWx0+QQz5t1AnPYZSFUVfh9YOdssWiMVXfvR4286dbJB8ceLHEi4ZSBnpdxcR0flkLzq5a0JDHOYdizIQ1dNj19FOMnoOEjoThNytziO/kiHMdZaLCUQRZ54S9v3p/D5SxVrIYcq+OyqF5uVS7+zZTWGTeg2kXRphMVyUWTZQq0C5c/mE1yp9JReB3RjsuPCOLXlJJzVifec5jb2AT4hkO2Bk2gCrxzKXyyIL30B/bHYu7YCYvXdEZ2GALV0lI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7959.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dm0zOUJPcVpnRlJCak5KYjJQS1ZWbEhTYytuZWRjekJPa2k5RTdWU1hKSUEw?=
 =?utf-8?B?L2FnSU1SOW1tUFMwOFl6MTNGUUZtaXBvQlMveGo0VHRyd0ROSUtFTThPc3Yz?=
 =?utf-8?B?czBWS0tVL0Jjd2VnTmd6UmdTU2ZPQzZjcmZHNUk2Q1RUUkVqenNoTEk0Q3FD?=
 =?utf-8?B?ZzZNaXFZQnFUbXk5aHE2eU5SNnNLVC9FdlBDNmRQbVJ4dVF5WXM1UW93SjYr?=
 =?utf-8?B?ZXBGVGd3b3l3S2Y4RzFiMktMVDZQakhWVDFVUTFWT2JoSllhWmcvbkt5cW1v?=
 =?utf-8?B?NityNjB4WHVITVU0eGJEYUFMOWxPaG1lL2tYZVZkbXRYS3NhUHA0cW56Nlll?=
 =?utf-8?B?bGVwZTZOeENaY1pLaDRmbURVNDk3ZzhrNjZDTkxVd09IS2k5bHlnb0VkOU5Z?=
 =?utf-8?B?a2FBSE9mUVhvL2F2bE5YRktmT0lrcGFFL2J0YnJoLzVKc0p3ZlJjazlpWnF0?=
 =?utf-8?B?UTF5OU1RdWcxazhjOUJ4OWRpMkR3RXNYdkkwcGIzNGFCbGw4cnNHNVFkV2c4?=
 =?utf-8?B?dzRMUEd1WDRwRGRkQzdSUEl2bUIwT2h4SmNvV3F2Sm9iM3huLzBHaXJDSjV5?=
 =?utf-8?B?RkJ0RXhHcTJPY2hhODJ6VVhvNnBjVlRVRmJSbjJKbHJhZm1ENmpVeHpWU1N5?=
 =?utf-8?B?bXc0VDZnMFp1T21kbEE4RkVCTXM3WVljSjBrNWRNek53OHN0dGc5a2tVdXBT?=
 =?utf-8?B?eloxZHdJQi9HclZoYUx5RHMrTERlM0w2UTY5bG1qdlNGeS9mNTV6OTFkZ0Vu?=
 =?utf-8?B?UXJxRUFZYXJFL2xNMXo0Wmk1c2QzL1pGRDFsRVdXSlFNUXN5eXNhS1dwYlRz?=
 =?utf-8?B?MnNNVzR1cG0rWEtQZy9rSDJ4SGNkTHROK1F2VGw1MGZGM3BITm5aNW5jWkdw?=
 =?utf-8?B?K3U0aW1hSkpKLzk2bXZwLy9wdXpSZmU4Syt3MS9GdWdJUjc2Yk9waEFVQ1d6?=
 =?utf-8?B?U3cyTjg4WVY0WEpQUVA2M250eXZWazVNQ2ZyTVNiTGxCMzNSSjYyd1JOOTUz?=
 =?utf-8?B?S1FWMnpRZUI3eWMvbGVlT0xLTjQyVEl2QXBGckpTZ29vOVlJKzhzRnFCeGdk?=
 =?utf-8?B?VmRzVUZDYURaclFCWWtaMjY5UzgrSE8vdmdNcVU5WC8rNXhYTTRUekdGa0Fz?=
 =?utf-8?B?UWcxVngvNmxXR3VYdkNRd1g2akZqYzFiZ1Uxb2p6bHlNRkpwU2hXN2E2NEI2?=
 =?utf-8?B?ZEpsQWRRMVZZbFFRY1ZTZkxIR2FMYXFaZ1IvbWtqTEowRlJDc1BoK2F0WEoz?=
 =?utf-8?B?SU9VVFdQOHdLa1hoL1dqUUdGMC81czM2NU0yN3MvbFJkc3o0Q01iWWEyQTg0?=
 =?utf-8?B?MExuNkdpU3NINjlDYjgxVkJaT2pPVm1BY1BHODF2alBzcXFIQUpHREpNVjVl?=
 =?utf-8?B?Zzg5VE80cVBPRUdIVmxFMDlTSFM2NTBlVXB0R29sYXZWQm83dlV4M2xKT0Mv?=
 =?utf-8?B?a3ZPZ3BRc1lKNFdQYXI5aWZaeldGYkJ3MXRhTVRGbnR1TU5qWXVoNWZOODRU?=
 =?utf-8?B?OG1EN3ZjSWprUEZVZ1VFcVUzMHhDb0dRZi9ialI5elRFSXlPOVlpcjZRRzVI?=
 =?utf-8?B?dTh1dlpmS1NjOVZ4bHVjMWhEaGxhQ082THlRRXMvUnJqS2VDcW00T0p3ejJS?=
 =?utf-8?B?RzVRZXZRcy90aVpmRnYwVWZFTXhBNnJJcjgwUndlcElLM2I4dUJxL1RGekFG?=
 =?utf-8?B?T1NaYnJtZkJIWXdwTE9ybTY4NWdGS1hHQjdYV3VHejMzQ0pXYS9WYlduMzhv?=
 =?utf-8?B?VFcyTzcyNUhXdHJ2NThBaGNXYUxSK0pOZmVYRGZpS0xRQnAxcXB2VnZDb1kx?=
 =?utf-8?B?Tkt2enBsT3JwaG5KZDdxb1oyc3lIU09Xc284WnhXcFB0cEo2R1VkOWZyQ1Ux?=
 =?utf-8?B?M2k4Q2lidmJaWXpTQmpXVHpaSVYrZmxqRVpKODkzWW9qWHJHRGdiTkdJWGdI?=
 =?utf-8?B?Zzdxa0RlaSswb2pJMXVtTUxOcFhZN2R4YjRWeUZ0WU5sUittM0orQUdzMWtT?=
 =?utf-8?B?OHZzY3hiOGJ6YkUxZHRXZWMvM1liUWZLOVRLL2I0d2FpVTZyYUlFTXFKUFBG?=
 =?utf-8?B?cVdxTDg0SHpIUHozRWN6VDJqbE1DUmlkbnFzMDBVUThydzhsN3VlYzRvUFNZ?=
 =?utf-8?B?cW1iL1N4cnVicURKaUFKU2dqa0hPcGNWNXp2Vlp0QlpFRzBQTG4rVHhpR2xw?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2HqcN6YXGjWi+QrszWG8NZG7WHeRg0BnVaOtl26e8zVSnAXLkMlVt+92azwi2+FEXFcdw5LnYeSgE/Rclj2IZmF51fX1o1+8r3kxATJKvXlbQxqBhHy/vmRE2bcAqQujnoWcOPw43LltdqYF6iOx9vrJwHvBbQerg36rG0xh3wdqS0MD09YrWl4SDrw1N8GGVUWoFefwLCVMn2n+anCBOpIZO98prXccd0drNi3ykOcfNVXZX7a1Si42U0s6y9fm02iKK+dN/MmR5P38hCH3BBjkUQxxtY6sEjlzuuGaB+2Mm3z0RUGLNjEm9cKeJ5CIvz4DkoPqDJiWnupb/crocO0i+6+8aZdXbY7vv/kfpnY7XDOS0iISmoQ8USOwPU+KYdkyZa2E8wp+nC4vNMIvw3RMEzbVGg1Qp4q5W8+RlpXur4VpIB5WVsSpmOYqwDzjniwl6FQa/bdDdP4oKJ+9b9jXixCxcIABJfCEH0fzxwTLXyXRR1IDHdMA67AhmrisRwdPVbrgT3neO+kwhwMvDtA7VynJ53hOsUHYh9SK1Wp+DIkMGLBV/OwKDbL6802X7GeBim0oIBeEszH2mNs1BL8ZC0sNLfr/IPpN/t2Mkvs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad323d8a-f63f-4bed-e5a0-08dc532cd252
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7959.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 15:51:55.3748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFJ6m/C2R7asGQsRXfndWPub9a8PfwhNYx93Em6veDlL6elISEXDiGC7yX46TfJE4W9JnsQBFYPTNP18bVLhHFZxSGMgjlyws8Eq6AlpYaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_09,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020116
X-Proofpoint-ORIG-GUID: armxdlEycsGCP7vNQU0Y9QJAW914f9If
X-Proofpoint-GUID: armxdlEycsGCP7vNQU0Y9QJAW914f9If



On 4/2/24 02:56, Dan Carpenter wrote:
> The app_reply->elem[] array is allocated earlier in this function and it
> has app_req.num_ports elements.  Thus this > comparison needs to be >=
> to prevent memory corruption.
> 
> Fixes: 7878f22a2e03 ("scsi: qla2xxx: edif: Add getfcinfo and statistic bsgs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/scsi/qla2xxx/qla_edif.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
> index 26e6b3e3af43..dcde55c8ee5d 100644
> --- a/drivers/scsi/qla2xxx/qla_edif.c
> +++ b/drivers/scsi/qla2xxx/qla_edif.c
> @@ -1100,7 +1100,7 @@ qla_edif_app_getstats(scsi_qla_host_t *vha, struct bsg_job *bsg_job)
>   
>   		list_for_each_entry_safe(fcport, tf, &vha->vp_fcports, list) {
>   			if (fcport->edif.enable) {
> -				if (pcnt > app_req.num_ports)
> +				if (pcnt >= app_req.num_ports)
>   					break;
>   
>   				app_reply->elem[pcnt].rekey_count =


Looks good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering

