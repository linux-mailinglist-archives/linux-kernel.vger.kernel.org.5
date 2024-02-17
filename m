Return-Path: <linux-kernel+bounces-69671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEC5858D1A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 05:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD31B2238E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 04:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F4D1BF20;
	Sat, 17 Feb 2024 04:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dVgOu8IX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZEE6TyZd"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400A623D0
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708142467; cv=fail; b=R52fRYiOGQVNEMQ3v4sPNwF1+3XCJfAMV2hf9am+KI2wYLIIlJoXM7f5oA02OM9E8vkBnOs0VXNJkKoruuj8Mwfkeq8DlBmBp+Ud66RA+IUXDkKH82qzB88I4OxtULGXfwReIC+W8qDUPn0Khnaxvt7ZE8nBL489JohsEJPSflo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708142467; c=relaxed/simple;
	bh=ZUkmoiNLl0Y8wo7KpkQe2zGTookhU3PUKt6MfH4mwJM=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=NjKw92lx6Dxg2hQZqRiy28Q4sjeyJVt+zKLlX2+4oaCH8TQMXv7chp0yLZmgdA9Xaa60WwycZc96t8x6QrHg4Lqm73B7BGPcLyfSK72Z92Bm81Wa3xgr4iZHrhcADkPqb6eTijQUx1WHuDPUmtV806j5g3KISaayYymUVDcYmCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dVgOu8IX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZEE6TyZd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41H25seq024282;
	Sat, 17 Feb 2024 03:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=4oRuAp2EAdQZi4hsvVj5Bsu1fZLjSWsXdJOzILNl9P8=;
 b=dVgOu8IXZ51szlEiCvGPuL57IGzVZcqdl7x70gZ9lePR/tSm23/4anaX9UdtTPf18UvA
 Hew4n9fYAIT80kCxa4MFWKJBiJvKrUezz5sgJD3lZuzD5zECTfKPB1omjCeB5fkZqoAg
 PtbrlVWaRssNiiNRdRdVIOapvyG5t/9DAMHxurLEokfssE/X1fOc5l4znI/UEguxUhKP
 dpxCxnJd73Fa3/UFAMFqZK8PEGhNXjGdwIqJ9JPJ1Br96xwxt6jON1jesqkJHsbBFLqc
 4MLMIbJGUsFH3svEJ5OoQclgkyUJB9DiQF36Olx58/FUXNTBKVoZvAIZ/03ijNkIhO/e Jg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqc043a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 03:59:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41H1X7v8007693;
	Sat, 17 Feb 2024 03:59:28 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak83jndg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 03:59:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMn+2YJmfR4mD1chhmK90Dpkw7cQxhAsVcCAbm7UmbnpMZf1r9W+kJ7F4lVRDAxKjE23Djz5Tg+yqHm0is5aflcKK4SSdWdS6SI2FuAY0XFWCXUB1XrnG67saQ4g8Z3k+Kcf9+EET2VMIhHsqbHKr9K4NQY4huTut2jg8Buzwem+QRjFicCaHDBOc3UDJxII+IS/fhfqyjPjvgz4mvp8FqiYTXF7K0XclhoSiqQSHnY1CcYn7vRilEwZKD7l1JgLeNuFrIuG79DBfR6/YiupQ9w6yveRBZJTLbXN3IkotMxpXLxTehryQKSFZALN7h9tP1v4obb/aA3r3QH4Zxbdbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oRuAp2EAdQZi4hsvVj5Bsu1fZLjSWsXdJOzILNl9P8=;
 b=UaQ1G0hchWebGCMk5p8LnRC72g5EZ/Cv5y+a9jjSCkeze3QBvIvpnWTQYzyQZHDeOBxzlh0tJJc4SQWZbdGGS9wk9ZyAT9YSoU2vUjxoG4D2+EghwfC73z//NgouFxqVtgfrrS9ozRT2GpVSVdS7+2oiqfAr3y4JUN/Bb3Z0UYlUzB1wJBw25w+bwbcP4NzWhUhnQT/iCbGODO/XxJbe1ODzTMXx+14S+5avv15e7cEvJo7P6lLKJ/ceHlGBF1KcrOIKJTzN3EP1EjU16zoOjVnHUPy31Rh5c5u7LsOpvbI+efStBSMwN5j9qMOkpJZ/MnQGvhIZOyYApYuJ52eClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oRuAp2EAdQZi4hsvVj5Bsu1fZLjSWsXdJOzILNl9P8=;
 b=ZEE6TyZdCSZhTUZFpe3qrVfiuIjc8Qjn1I6iDTKikw1loIQyirZWQpaNHZNs76LmYnLRYu+vqVf9KiKuug9sysaApZ9RdC8YFJkZgwIPf7IEHkxK4wxdtFVv4CdIjn9J65XWasveORMqAtvRZT/2FpyypytIBBDL7c95LbG2zo8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB7742.namprd10.prod.outlook.com (2603:10b6:610:1ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Sat, 17 Feb
 2024 03:59:25 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 03:59:25 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <a7e785f8-d4c3-4b1b-9abe-36ac0b971e44@paulmck-laptop>
 <87le7mpjpr.fsf@oracle.com>
 <4e070ae0-29dc-41ee-aee6-0d3670304825@paulmck-laptop>
 <0d4a4eec-ce91-48da-91b6-1708a97edaeb@paulmck-laptop>
 <871q9dmndg.fsf@oracle.com>
 <9916c73f-510c-47a6-a9b4-ea6b438e82c0@paulmck-laptop>
 <87le7lkzj6.fsf@oracle.com>
 <4bc4ea06-e3e9-4d22-bacf-71cae0ba673d@paulmck-laptop>
 <0be4df28-99be-41a3-9e24-2b7cfc740b4a@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: paulmck@kernel.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
        andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
In-reply-to: <0be4df28-99be-41a3-9e24-2b7cfc740b4a@paulmck-laptop>
Date: Fri, 16 Feb 2024 19:59:45 -0800
Message-ID: <87r0hbkafi.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0287.namprd04.prod.outlook.com
 (2603:10b6:303:89::22) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 13493258-729e-4c5d-e244-08dc2f6cd4ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Y5SMyIZH9Xn2d0rMIss/aDgZtnqymfRJva32cYOk6/u9jRhWMI1Y8GY6zD8ImYAJzEYTiS3bGgZi6U8oyFZMHkrFalhnBRsqjmkfacMpmRyzLQ0zAH9ffj6IDrg27zwy8Kd9iDGkR2PljbNBS0Cuzet719m45tEmsDxrXiPnyolvoefctRCmE+NwtYP8bHnfMXUa29QDgNh+y0Ehp3xKiDI4HyNR9UIPAI1JobQU2cIRJLfQsYZN/OpW/0BQeunyLyJs8DqHFISkJs40z60awQS7xFrA4AuLZ1D1YnTYaFR7C2JpP7jangxVY2t1PyleVaHgH+pO05OJYwyG5ryxdrNbaTWBc81F4bs7nRsb4pyfrZy7RRoFie4SqBAYuX6l83rh+Bk1RKOwAwJoIA1f9uQEREKthigANQguGoFwmeO2XWQaNYgnH+s8VLFHQwnqvDw5PV5kzJ/4Xavbsnj6uQ/tuJxKrv7/drNlxmHGx0ozPTAFDAUxqHZdzXvLAg+lZf0UN1/70OoQe7rvNqt95u1Psp1IQ7BoEgmGT99bdp7rdlUZ6JVD+ShJh5uRz7I6
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(7416002)(2906002)(7406005)(5660300002)(4326008)(8936002)(8676002)(86362001)(26005)(83380400001)(107886003)(38100700002)(66556008)(66476007)(36756003)(316002)(478600001)(6916009)(66946007)(6486002)(2616005)(6506007)(6666004)(6512007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rF5KFuSYyz0mfRQdkJ2ZYgRFUpe4DYxuW3ZBJkXA6SgGEh0/uobfN1qyTPEY?=
 =?us-ascii?Q?aEpOaWPz08/Br2NTlcDc89Lxzobg8h+EepPjBHC1ATiJguKsAQwHrUhRou0j?=
 =?us-ascii?Q?3zzXxvZMCIYe0omomNVVdHwKi0SZF3RgczuBT9+l/tpvf8urjBruj3qJVx4G?=
 =?us-ascii?Q?EXlHHJzwTO0ZGVvURP28wmobcCNPn8TsxyIXkglgUjBpEuGaopU3/44x7URS?=
 =?us-ascii?Q?eU/Drt6jBmXDbQtjBguDU+dQ1u/LIIxlK3rXJd9L5zCBhtKkFBiy+i0xlBac?=
 =?us-ascii?Q?jqlaxsCp8YyJftYPNS8cgeHKqweo5kF0mMm2cg+wcQNsEfmXWOguvIwTpAAs?=
 =?us-ascii?Q?3RH1OIvCOex8B7/FDpr1POg0otEs5LkUr0NbQRXKCSTidX1oXwe+8mxVxjwo?=
 =?us-ascii?Q?KqwnwTojEpvsOv5JuNWB7Ibl0bsy204aybLB13LruEXVUmm5oCkQL6QW4CGB?=
 =?us-ascii?Q?x3Un526JZMYMzgszXpbv+3rak6dGAY4QQkgdPc4o67PwDxN9LVbjCfJXEVgG?=
 =?us-ascii?Q?FFTFv4pmBCNhvKPozb/el9h2rKQzvxetTuAURkGxDPoSYP8ZtEbPs4vXD8UG?=
 =?us-ascii?Q?urJFWoLGN41jFTYfxBvff7aJxF1iBNi6zDk1EJebM+xTrTYU1OshZbol+D9t?=
 =?us-ascii?Q?Bn0PqeNa17QNQ+tiVX9K1Qp4My29vwijHdVTxyXBLf04hufncw/xMbTxjJEl?=
 =?us-ascii?Q?CW1DJ/j3VmWCc9sPhyOnpZSlSCvBqXcSIfhpfPQI3y50Wm7vLFYOJmvg5Ja8?=
 =?us-ascii?Q?7Xpk1SekIqUTbviRF+4gqUll0xnabahbpkCSnTn+Px/nngxPLGYQ5R5/mKDk?=
 =?us-ascii?Q?az+vPHZhqyzZAOZB57+RXRcwuxRiXEDr7O/4Ai3wq+3HTtSHqLZMXncrDH2B?=
 =?us-ascii?Q?uXJIJLK3IUJSlznx4m6JOJx0Nv67fK7+qW4C3uomU1zd60Csp0rPJ5Ru87UB?=
 =?us-ascii?Q?oHwA9B0JR2efpUqVkuD52uNNIv2M2AxokYAIikCv0F9jYFvuwHGZ13iqAL/O?=
 =?us-ascii?Q?/pEwHYgGqiV+3jJOxy67cBBx3EDDkiLvADQjpj6MagxlTG+r51AdHFHbv7dX?=
 =?us-ascii?Q?iERJnh68iy93DQQqMHfc9NtViQaIh0x7QE09WwazOz9ODGojT/rMm/uG36KV?=
 =?us-ascii?Q?KCbWE0R5sYh5dbw/DwMmWUG/J/+41S6JK64rIyi3cWP/zzNyN5LOetvva23j?=
 =?us-ascii?Q?HowzhQGWWuIl8SVIxQzXyi2ekgfOkeWnfvhdjDZnsihpyFsupkrFWgeqRNrP?=
 =?us-ascii?Q?fZFDOb/FngRWlDLGDalRoelJEmolO4JmTbYL3IC64YVixCKCPlwuGB3/LAI5?=
 =?us-ascii?Q?SuP8dFFNKD2oWN2JR7XgFBGpeLwgkWCmIT8peR7OOdbIy6USZ3uljzCYK2G2?=
 =?us-ascii?Q?KStbOJb2p0/xuW9GbKRdkCjhL4bKE5UjDJuCS2df3KObjYIQBrOkLMrN1Rg7?=
 =?us-ascii?Q?djZeineRPRAdFRNYlTAX570OqnAkzobsTnbCOUa9yV+96uaqbcVqfGp0yjmt?=
 =?us-ascii?Q?qZyxawnfQnD9dON6ZS8CYN1x65zBGBnb7rX5x56vlKt54tfkCk3biFC/zwuw?=
 =?us-ascii?Q?caqK/2b2qr5K/xdMtIHTiFUiXzmuUoF7MM7Qx8Jp1BBFbiBIh5BxZ2Mm58OC?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Hf+ifcFcjTMxRjbfez6KKgH+KH+aWgNrG35AK73mgbtty8ilqceKDjBgKN+NoLU2Jt5wWXKHCOQx1sNscrgI3zK86Y7vHZaHMY7r2MAPrzAZO6wZQjX0IWJGVqvHs6MgRxVgTIyfGXd1+ok3EQeH0gFYBbxNI+e2PL7UqNHKcHBYUPkm1MN8AWeuMYcKFTi3lIRE23LcZ7VVFDGeh/Kcw/em5ACp6NGmCAOEVWSPzZP2stQXt1zwtv8VhxL0FWIu3Ybb+0TvCcVVB6BGQhGlDRgM8ZKPw3a4GClpYmfsS/w9jyUA5ouAOeWPIT6XNLU2Hyxd8AeCfkfE3j112HJw8DMw7YmGeLA6I1E54oTfSNl4pZTEzToXfCW+5ef0rDk/I95zR4PlNALRzonLFk9kHcCNyoPuLSKmhvhgaBVPbw9GbyyAKmD3q+7UOcY2xNfUJJ23WitVMpzAPeTY1nmAuZKajFtB7XaDW9f/Wa21q84z0+OLODn48VNEmF3Fh714rVD/E5G0OdI1TAJtLDjwLD30o2fccXNA/SjWBFVTKmHjh0QJqhdUYvyyqglE6U2bmxmX6NjdV4UQuvnmYmMElTQ8StLfSLNHtSAxBz/qQ4k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13493258-729e-4c5d-e244-08dc2f6cd4ab
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 03:59:25.2740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSFEvgTSo6cg88OQsRZtZXzOHxlLqfO/yoBpxUtsrKe0wxHPwNY/Hr/5baZq5dP9h0/eE3Nlff5VQOm7X8LUpSdd5kKTLka93RarUwyLBjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_01,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402170028
X-Proofpoint-GUID: -mgPLSHMbWkVD5CGizagaLNIR7Ut73NG
X-Proofpoint-ORIG-GUID: -mgPLSHMbWkVD5CGizagaLNIR7Ut73NG


Paul E. McKenney <paulmck@kernel.org> writes:

> On Thu, Feb 15, 2024 at 06:59:25PM -0800, Paul E. McKenney wrote:
>> On Thu, Feb 15, 2024 at 04:45:17PM -0800, Ankur Arora wrote:
>> >
>> > Paul E. McKenney <paulmck@kernel.org> writes:
>> >
>> > > On Thu, Feb 15, 2024 at 01:24:59PM -0800, Ankur Arora wrote:
>> > >>
>> > >> Paul E. McKenney <paulmck@kernel.org> writes:
>> > >>
>> > >> > On Wed, Feb 14, 2024 at 07:45:18PM -0800, Paul E. McKenney wrote:
>> > >> >> On Wed, Feb 14, 2024 at 06:03:28PM -0800, Ankur Arora wrote:
>> > >> >> >
>> > >> >> > Paul E. McKenney <paulmck@kernel.org> writes:
>> > >> >> >
>> > >> >> > > On Mon, Feb 12, 2024 at 09:55:24PM -0800, Ankur Arora wrote:
>> > >> >> > >> Hi,
>> > >> >> > >>
>> > >> >> > >> This series adds a new scheduling model PREEMPT_AUTO, which like
>> > >> >> > >> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
>> > >> >> > >> preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
>> > >> >> > >> on explicit preemption points for the voluntary models.
>> > >> >> > >>
>> > >> >> > >> The series is based on Thomas' original proposal which he outlined
>> > >> >> > >> in [1], [2] and in his PoC [3].
>> > >> >> > >>
>> > >> >> > >> An earlier RFC version is at [4].
>> > >> >> > >
>> > >> >> > > This uncovered a couple of latent bugs in RCU due to its having been
>> > >> >> > > a good long time since anyone built a !SMP preemptible kernel with
>> > >> >> > > non-preemptible RCU.  I have a couple of fixes queued on -rcu [1], most
>> > >> >> > > likely for the merge window after next, but let me know if you need
>> > >> >> > > them sooner.
>> > >> >> >
>> > >> >> > Thanks. As you can probably tell, I skipped out on !SMP in my testing.
>> > >> >> > But, the attached diff should tide me over until the fixes are in.
>> > >> >>
>> > >> >> That was indeed my guess.  ;-)
>> > >> >>
>> > >> >> > > I am also seeing OOM conditions during rcutorture testing of callback
>> > >> >> > > flooding, but I am still looking into this.
>> > >> >> >
>> > >> >> > That's on the PREEMPT_AUTO && PREEMPT_VOLUNTARY configuration?
>> > >> >>
>> > >> >> On two of the PREEMPT_AUTO && PREEMPT_NONE configurations, but only on
>> > >> >> two of them thus far.  I am running a longer test to see if this might
>> > >> >> be just luck.  If not, I look to see what rcutorture scenarios TREE10
>> > >> >> and TRACE01 have in common.
>> > >> >
>> > >> > And still TRACE01 and TREE10 are hitting OOMs, still not seeing what
>> > >> > sets them apart.  I also hit a grace-period hang in TREE04, which does
>> > >> > CONFIG_PREEMPT_VOLUNTARY=y along with CONFIG_PREEMPT_AUTO=y.  Something
>> > >> > to dig into more.
>> > >>
>> > >> So, the only PREEMPT_VOLUNTARY=y configuration is TREE04. I wonder
>> > >> if you would continue to hit the TREE04 hang with CONFIG_PREEMTP_NONE=y
>> > >> as well?
>> > >> (Just in the interest of minimizing configurations.)
>> > >
>> > > I would be happy to, but in the spirit of full disclosure...
>> > >
>> > > First, I have seen that failure only once, which is not enough to
>> > > conclude that it has much to do with TREE04.  It might simply be low
>> > > probability, so that TREE04 simply was unlucky enough to hit it first.
>> > > In contrast, I have sufficient data to be reasonably confident that the
>> > > callback-flooding OOMs really do have something to do with the TRACE01 and
>> > > TREE10 scenarios, even though I am not yet seeing what these two scenarios
>> > > have in common that they don't also have in common with other scenarios.
>> > > But what is life without a bit of mystery?  ;-)
>> >
>> > :).
>> >
>> > > Second, please see the attached tarball, which contains .csv files showing
>> > > Kconfig options and kernel boot parameters for the various torture tests.
>> > > The portions of the filenames preceding the "config.csv" correspond to
>> > > the directories in tools/testing/selftests/rcutorture/configs.
>> >
>> > So, at least some of the HZ_FULL=y tests don't run into problems.
>> >
>> > > Third, there are additional scenarios hand-crafted by the script at
>> > > tools/testing/selftests/rcutorture/bin/torture.sh.  Thus far, none of
>> > > them have triggered, other than via the newly increased difficulty
>> > > of configurating a tracing-free kernel with which to test, but they
>> > > can still be useful in ruling out particular Kconfig options or kernel
>> > > boot parameters being related to a given issue.
>> > >
>> > > But please do take a look at the .csv files and let me know what
>> > > adjustments would be appropriate given the failure information.
>> >
>> > Nothing stands out just yet. Let me start a run here and see if
>> > that gives me some ideas.
>>
>> Sounds good, thank you!
>>
>> > I'm guessing the splats don't give any useful information or
>> > you would have attached them ;).
>>
>> My plan is to extract what can be extracted from the overnight run
>> that I just started.  Just in case the fixes have any effect on things,
>> unlikely though that might be given those fixes and the runs that failed.
>
> And I only got no failures from either TREE10 or TRACE01 on last night's
> run.

Oh that's great news. Same for my overnight runs for TREE04 and TRACE01.

Ongoing: a 24 hour run for those. Let's see how that goes.

> I merged your series on top of v6.8-rc4 with the -rcu tree's
> dev branch, the latter to get the RCU fixes.  But this means that last
> night's results are not really comparable to earlier results.
>
> I did get a few TREE09 failures, but I get those anyway.  I took it
> apart below for you because I got confused and thought that it was a
> TREE10 failure.  So just in case you were curious what one of these
> looks like and because I am too lazy to delete it.  ;-)

Heh. Well, thanks for being lazy /after/ dissecting it nicely.

> So from the viewpoint of moderate rcutorture testing, this series
> looks good.  Woo hoo!!!

Awesome!

> We did uncover a separate issue with Tasks RCU, which I will report on
> in more detail separately.  However, this issue does not (repeat, *not*)
> affect lazy preemption as such, but instead any attempt to remove all
> of the cond_resched() invocations.

So, that sounds like it happens even with (CONFIG_PREEMPT_AUTO=n,
CONFIG_PREEMPT=y)?
Anyway will look out for it when you go into the detail.

> My next step is to try this on bare metal on a system configured as
> is the fleet.  But good progress for a week!!!

Yeah this is great. Fingers crossed for the wider set of tests.

Thanks

--
ankur

