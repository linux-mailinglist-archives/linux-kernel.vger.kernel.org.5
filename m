Return-Path: <linux-kernel+bounces-62965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 437B685286E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26137B263FC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7221B273;
	Tue, 13 Feb 2024 05:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O0WXBb6q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cqIlgWAt"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E562C1799E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803824; cv=fail; b=BuVXZnTSiUEjEsF0n+j9/4sZxXkLcpU16U5tkOMCJ86CNTYdrkV+m6R3jNAjFjYi+drVMyRmPNtret2I8zBmKq9RS0BiEuPmwZnVFL3LH9lM9+cGB3QDfMkELbw0gDOZmd2M5BUOcMHWglpV1oei0HokCPjDLRTWnsaS14NJ9+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803824; c=relaxed/simple;
	bh=DnGMedV1Ansg9quglE5C3m0NylP3ymfVefhffZLDrUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgbb31eCtg8CSuHWuJjcksfG6hq+aM6KkSfqt9RYMOhEztFru1Jtct+Ett1kwE4FugsBMsFey2koojTFRFfOBM6cwAGGG/ik3Iw05hqFoIsvjUyYN15GoArHP64f/rh+AbJbViri652C6oP1OQY6zWeG6E1INM1KeiDtcgArrKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O0WXBb6q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cqIlgWAt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D50FvZ000842;
	Tue, 13 Feb 2024 05:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=+8Ea2qu9i3Vi60pd8gLPWOE6K0mWMB9i6eUsA1V3088=;
 b=O0WXBb6q/Zf0/lyWG9z86KBOfuqEBJIIkYJRIBFBPSfdA+raNABe3NwX6r69tMNi/0iO
 5UdaWDs4CFJax1G2r+hc477Mly4bWtxcRoHK7QSLvVbrj03GbOeRDIJ0JAu4yXs0sTXm
 qKOtAAmnJsOmmKETkR92WXUCAi6ybeTjfa+9lb2SflkkBw0zRAs+JJzS1agqAzlGtk0C
 RKrPN3ZJQZezQkudsk+kRMw3FPHiYnHlIpozJwpA9L3bo5sdX3LVPcequaM7WO6QrpJS
 NzeGjt80IYT7UAEQZaiSQcoGV3w+w74cpufrbWjrEAXREZxFoHnSsv2PBRRMXxQO28Tj 6Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w81vm8353-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:55:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5KFIL014988;
	Tue, 13 Feb 2024 05:55:42 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6k80v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:55:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cG/9/iLUFbdqid/9N3f2MpmC4aDdCJBK2bY+YDmRqtBI4P6PekRejdLJnEqJhUox+Wc92p+1jEkxQvFUNJHQUxzY3Zf32KNJn6rpAL1sElYU3zczdp0Vz17zCeHeAH+i11hxX9b83hySIIHZfJmMZr46lY/eV3VfBq2cczjjgyc/l9yiJyeJORgDFGcDRTK2N6I1li+yRND94QH0UOw+Lj5A2MbacfhvHgzl+XPGMS7znddWDgz9SHGzGVLiXKNIQEwKkrol3FlLZkkWON0XSB/4HmhXuCq5GJWprejh616kc7N+fmKoSrKWH/pusyDjehwUhMrwXANAtT2PFjq9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8Ea2qu9i3Vi60pd8gLPWOE6K0mWMB9i6eUsA1V3088=;
 b=PHpb+casZtIEQQ3xmP53D4Vzs55wtizbqyUgRcPYcTWDJjhJZemy3e2TCUmrn+Sd/P5oMW41PGAts0zl1joHOl4jUMNN9szCrgj6U0OCe2xPX2zSHXc5W74C9rSpOSzAZy1Ap5x6A0P9QQCN8VUOAvPXis3JGcULccG5i14tyDB7zfHn2+JzomX+wgLiyxi9NAbbnICYkdffAcN/6JOgjY72/lnceDIXhBtvIRbOULMdHRKf0dDssBmGxt6ZnEN3H5FE+FrmxQsCsrqt/QBRL0UfVAkFQPBm10blmo9e74uOkbI6cF0LLhiZ0hDRA58e/LBB2nwTx0DdMBHKjvrclA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8Ea2qu9i3Vi60pd8gLPWOE6K0mWMB9i6eUsA1V3088=;
 b=cqIlgWAtpHIcKXP2/3+9LhezJIkDC809+JJDOBWnc296WVrtNZiwfQZwfHq83TKgPtMU0ZtucbP5PTfOMR7zwEWH6gHpJr5EC70pLZEje1X37eCk8fE2pPtbUNHLPgfZEfdRvrNxGqPThKBY/ajJUwJxMpmuJeSr7zP+BbUHU9c=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CO1PR10MB4642.namprd10.prod.outlook.com (2603:10b6:303:6f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:55:40 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:55:40 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
        mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH 02/30] thread_info: selector for TIF_NEED_RESCHED[_LAZY]
Date: Mon, 12 Feb 2024 21:55:26 -0800
Message-Id: <20240213055554.1802415-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0242.namprd03.prod.outlook.com
 (2603:10b6:303:b4::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CO1PR10MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd61c89-576e-43a5-c624-08dc2c586854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	q0sQEe1DVW6J/nWg4pakDKHGCVN/Jbz9jIDT0R1uuEKGbLeraN81I40MnGVwbvQkdNhJweRkQctwmI2pwosCkTzKDIfN5sRMbibsrwKz7OzhTfwbU+wOL7o/lOXK6k8StnQF3O8DizSU+V5yRU3xLgVMnGZjwH0I54Ym4Dx81jK2LZ4lggQwTG3l421rnr3UgDksXpRUqE4EHdtXEYNOtQfa+69gpJXFqg2NUZUpqcwEEDpPVKm1MKUnTX0yoC/XCq+HJg7Sw/aRGP0bO/58I+7r06tVMptdd+Nk7dR1D06qfDu4R/O3WsS7Dte54vU3H5+SU69u1g3xEv8BaNB2yBaQDNR3X2adW2dI07rtQd6jyoaRrOlwU3mWJGUCyOYNHAkbVipdHHNGU0bEcNEkapojwu+qz8+NI/xYj4rwTWTHMoOP7l02t6VJhE5D7nS5g+8UDdkKjGftCr2aCsWT8AEGIXoA7RXjafwRg1ZGgajzVUbPOu0vF2pebiZmGMyUI9LidkGTBGqODM8xlQW67P2zESRdL5NBgIGtUNwz/wI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6916009)(2616005)(41300700001)(26005)(1076003)(107886003)(4326008)(8936002)(8676002)(66946007)(66476007)(66556008)(6506007)(6512007)(6486002)(316002)(6666004)(103116003)(966005)(36756003)(38100700002)(478600001)(86362001)(2906002)(7416002)(5660300002)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ywXvu1QkMsGY+3pYohEGuqhJ+a86NDxG3huXjt6V4Ab6395jMu5wK4WjgqV9?=
 =?us-ascii?Q?lF//jQvmnRCoyLpXAkbxESZfjxZY4aLabv0fFObJYKZd94BniFM6gAjLmwI+?=
 =?us-ascii?Q?ZLsrV4w4xqESKUuf2ySl7MpOK6SZskZHR70TrxR7W9a9336IMm5tCM+cuzNr?=
 =?us-ascii?Q?VIwmKCaDv2BICchqsFNyDIEtTWr82PDiTFENk6NsLisa12mZG1ARGFDcvaAp?=
 =?us-ascii?Q?hm9s14boWndp4+czjfQesbVQ/L9DW4XWVCZeEVUXDJQZSfQxYTE4iRfZFMS8?=
 =?us-ascii?Q?HBeJsjylVvnVzqRlL0a7P3QPX6NTuOz6zKqmAWxwByLfmzny7WjWZ01J+5po?=
 =?us-ascii?Q?HjK/et6L9fV2hEYYoOcfU2mf58Fw+Cgd1EiotvsCRTRcNsFJMPGtBmZX03iB?=
 =?us-ascii?Q?bXrBlqxXgwo0PcVCYFsBFZau6EmHp3Yw2G+CQmf5w8DvuwJKdLaEQsAfcIsx?=
 =?us-ascii?Q?B45MtuFLti909YmcfnvyHsm+3xuFfD0yUwESUoGYFMFb7X6sftcV+B7MDWH8?=
 =?us-ascii?Q?GxKR6zt23pz+lDXb4wmRTqT0SWf6XtzcJDVIf4GlVWVxk1elSpnAOSPdtiUC?=
 =?us-ascii?Q?KloVB5DgZ1MVh6RuiDiTfSuB8ym3sMIl8wErNTpueTU0lV0jwEwm784rbd1A?=
 =?us-ascii?Q?kH9PDSvvmflwVVVgN3USlBryrgZedRdncbedvbl8xA19xqmcxvWPwQtyHahB?=
 =?us-ascii?Q?lx61K7XA1ABZShRUbuwolmTuXtGbhGSMpJyWCWs7nBeC8okIsfljs62q273u?=
 =?us-ascii?Q?3qyTZw29+G4IFcf0NUWSNBpZ8cnsiWyhZhdgdeW4JQD60yVsAQvETGZ2tx8l?=
 =?us-ascii?Q?50u1WIsr9ICteQFoli93JW1Bx0mbVz3djCNR9A7fHW/NC9l9wRiGviA8Lu/g?=
 =?us-ascii?Q?BkPm/ZKapwuF6tAt3jA1MQfWMkRjKgdHl7YOl515HtIHTvmW+MExdln1cIgR?=
 =?us-ascii?Q?frm98tvpMfaNzaW0HneYYoe3F3wLszeYxqLAJdC7vgKZyBMfAQUzQ7qMkfds?=
 =?us-ascii?Q?JEwiJ9ZtnZY1InsJrgWK8TXkhreyMpmgnGhNDs30XGBXP4ZYhf0U2w6wOtWn?=
 =?us-ascii?Q?v055QwTtdcPhSuhw0FSCbHsYwOJn3Gd4b8BImOJRnjJHCRtbJgVYYzA6FiTl?=
 =?us-ascii?Q?plX6kgZ6C+h+vWfM96tpkf+yykr3FJDZgp+2ETwp4kXKU8ayIUaCQMo4x4VX?=
 =?us-ascii?Q?efjIU9MJMqa8hH9mjgd3798AwNeXqBB0yTUimLaVGe/uMA7iAMfZLYl9Iw9Y?=
 =?us-ascii?Q?yZWJSTqNMhMh/5xWARm7hj0dUDDh6LCDgZLJUgC3v/wpK0xehV46zqRVwI7c?=
 =?us-ascii?Q?ORSwYp8SjHxXUFeJyNV2O4L9R1BarryYT5bNHkzfCHF1BCO8MLAfbQKv3URu?=
 =?us-ascii?Q?vDyXelFS/u8B0GWNo3Kp+u0zsltC+kMm/Wf83omtbcGt6bWZevJgGO7uH7J2?=
 =?us-ascii?Q?YLviM2ARm3sZN72JB3xk0WfIQpUmnRzD/cAGdTFFL8OySyoMUc45eLfTrDTN?=
 =?us-ascii?Q?LwUnsoPsNeq8cvhSZu3XvnqlDVrBieFR5A9g2CX62jf3/iqI2Jg733xoj+ma?=
 =?us-ascii?Q?5DiPYA9JvZv5k2eejMBLN8+NUJtEdfKnpUMW3eHr8C+V3snMHEcQ8G6ACdeD?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EWhBTv+Y3d8OvKIOYUHnQj+LCBh2aWPMgE+SJ7sRIiHaIEd5aGRxvBwdl11jAa48rrIKf+5w5lx1syaodEogeB4SFASv1l0/UEibTYLAXR1JeF8AKAfDZuWkqet8lun+/6DTYkEzfqUy0TM2c7MQdhXdMWMT/vIZnbfrB5c//k3bkUVIaUWDvdskPkmwR96sXza4m7hNiQgnR0tVpxzSDj5qQ9iRXLJLgcTGfzLnEmgMpejHn3DsCupjdLAsSAwyWObfZ8c3Uu/8czUd4sbQW1BxKzeeUX6jtvsy1PPWNRf73w/mHkM3ZCdGJh3c/5RjlpzuLqTmoYOB3sghQK6Vbbg6tVa0RazIzxTqQ6ewWkStTLGa8l/jbX32EyVXbHEpnJLkhdegeGGEa7BkbzW6bzCZBF0e3gvgPJospFoFe+r/ZtReVXvAzeh6CmqXvOHDCZ60EGKhdrrAWEHeFxUr87a2m/KCjzar78f5YB2cXMPRDyZHZ3D0RZRHZ1v1KJLnOiiUzMXorqOgYuONcrFQ/CauVBw8ZtTgaSlCcAqNTap6vXk/BgCwU5eI11xXLfIl1X2faMcDFoJNvsZL7LLIPhj1B3zT73cUcKJfBX3sT4Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd61c89-576e-43a5-c624-08dc2c586854
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:55:40.0232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMG2oJ+mHYvdGt2trS+6/jlDR/6aFsfUD7Clc23twGc1lzmJS7cPxCEePHZ/7EZZH4Fj5/6RbbUm9h3L3HRlUO7ZugrwUJfyMPfl1rCGgiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=879 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-GUID: wVdhc_L0mYVf_Y5b9n0fWsMjArRRlqKV
X-Proofpoint-ORIG-GUID: wVdhc_L0mYVf_Y5b9n0fWsMjArRRlqKV

Define tif_resched() to serve as selector for the specific
need-resched flag: tif_resched(NR_now) mapping to TIF_NEED_RESCHED
and tif_resched(NR_lazy) to TIF_NEED_RESCHED_LAZY.

Note that, for !CONFIG_PREEMPT_AUTO, tif_resched() always evaluates
to TIF_NEED_RESCHED, preserving existing scheduling behaviour.

Cc: Peter Ziljstra <peterz@infradead.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/thread_info.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 7b1d9185aac6..99043cbbb6b0 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -67,6 +67,30 @@ enum syscall_work_bit {
 #define _TIF_NEED_RESCHED_LAZY _TIF_NEED_RESCHED
 #endif
 
+#define TIF_NEED_RESCHED_LAZY_OFFSET (TIF_NEED_RESCHED_LAZY - TIF_NEED_RESCHED)
+
+typedef enum {
+	NR_now = 0,
+	NR_lazy = 1,
+} resched_t;
+
+/*
+ * tif_resched(r) maps to TIF_NEED_RESCHED[_LAZY] with CONFIG_PREEMPT_AUTO.
+ *
+ * With !CONFIG_PREEMPT_AUTO, both tif_resched(NR_now) and tif_resched(NR_lazy)
+ * reduce to the same value (TIF_NEED_RESCHED) leaving any scheduling behaviour
+ * unchanged.
+ */
+static inline int tif_resched(resched_t rs)
+{
+	return TIF_NEED_RESCHED + rs * TIF_NEED_RESCHED_LAZY_OFFSET;
+}
+
+static inline int _tif_resched(resched_t rs)
+{
+	return 1 << tif_resched(rs);
+}
+
 #ifdef __KERNEL__
 
 #ifndef arch_set_restart_data
-- 
2.31.1


