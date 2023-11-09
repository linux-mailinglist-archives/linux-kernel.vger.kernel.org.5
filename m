Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6AE7E746C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjKIWh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjKIWh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:37:56 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344683C01
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 14:37:54 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MZPH1020967;
        Thu, 9 Nov 2023 22:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 mime-version; s=corp-2023-03-30;
 bh=asO1MUvC7kVnqe1H+1uFWJXGl6CaV0rdqY8x6Mugy6s=;
 b=kKnfm+BVZ+nGhO7nVCGj70RL8QVucP0lcN2xnnwtwFZ5/gLTojlSAdrnWEcmIQVr/qS3
 5qBj5NiAaFGSy9jxLhYOhVpLr9ceNuivlMcfCDfsFL5RU3zLOJ4aQf4sql0bQ+5Ac537
 qRReAwiPxTw63Tov/Ep8RzXdTSSJFOE7Wyn4pwb7IrONoZneteg1vdPTRGycnVtBHjld
 OKksIoFbAh4WglUr5bto05uzF9hrliVgUcBPfEgeAwZ7ukrarZZojSbPMPwrMq614vE/
 /6mpsjt0GMwNmajyP+J0k2oVQWrFYk2pERY8Q6uUauvMU9a3EnLagdMjwevz1EbGqshy 6Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23n3mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Nov 2023 22:36:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9LkAwO017518;
        Thu, 9 Nov 2023 22:36:21 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u8c012cg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Nov 2023 22:36:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bErgIepCFpvI0897gwtJVaq6wGyVftQjsCHEXaLCBcVAnEDI+GSakLJhWqA8MpQlKZVHr6jnq23TZ8QEkNx8pVKnXJW5LxP5TsyH293l8RcFoVWYHzyzqfmROG918U0urH/32bR94UVTIOue4WnShRCl4irNmmWToQmUOYBtx/qkgW6Wc92LIwLqaZEpqdMrWbCySw79hA5aU3Ywo7TLPS4AgfbHoYcKN3681SrIUaioRhI/RN+djQ/k5g7KvGjl3y2i9hpyj6CPaSNqMuX4cb/Yf6hrVxKtGP0RmVn/mJKvzVGEa1EXkLXXaSxiaJBHzrtd2UuzXi+gZXbxWmbJ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asO1MUvC7kVnqe1H+1uFWJXGl6CaV0rdqY8x6Mugy6s=;
 b=blk9n+oECpf4zJO3/y4MWMIq2gL6MbNgHSK+imen2pNwh9V3dzyQ+c+oThnwg9r20NIbeisYkxw24fDX8m9Y0mOMqAadcSBLVWEcnrcSLprKZ+bb5ekUvZkFG/4EWWioFPY3OEqyddhsH1YHQPnWKtC44pa+EH2hSnIDABzr1c9HKm1j7XW9uUF+T04zcpmc+6e+62ApfHuX1zSmkfuEe/T1e7ASGjXWWx4pplnRKM2hu+5/ghQjazWfW0HZn5vyDoV0IF+As5GBn9+ru4YkayukuAXvJlEpcfG2nTL9hl7bfEYmzmtOQdcOZnkxTnu8fhDAPk607MTqBeXcajJvbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asO1MUvC7kVnqe1H+1uFWJXGl6CaV0rdqY8x6Mugy6s=;
 b=wdM+QaDhycsJzNLk0GVDh56wx1MABbP+lStpZNJwglf+uNVth3XaSMjosfm73/qYbauTRgtQfCF/LTtMW1JUl5NzV+anLt22rduKCZRXZBU0ms9ppnRuH3OqR/gIMdn4/aPed/XbKfZW/lhMjAaVtH/Vd+AkvgyGSUPiRCUk6WY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB6788.namprd10.prod.outlook.com (2603:10b6:610:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 22:36:18 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 22:36:18 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <ZUu4Z8a8dPLfW7Ru@FVFF77S0Q05N> <87o7g3epcu.fsf@oracle.com>
 <ZUy71lC6mxP7ft-t@FVFF77S0Q05N>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
In-reply-to: <ZUy71lC6mxP7ft-t@FVFF77S0Q05N>
Message-ID: <877cmqd066.fsf@oracle.com>
Date:   Thu, 09 Nov 2023 14:36:17 -0800
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: bb083387-29d6-45fa-dbe8-08dbe1744a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mBTCTvvZdTDf+F3hL4v2ggHxx+p7auPz8CbKibcOUkSXQxHXE+i7eVVlIUplR15cgWMcATwKQYnE0ML7Iw0I4tbBusBKDadtSRN4QsPqEqnHEFjMo2riTMunjDg6F1nLSzzF61EhVbQRiZLzIN0Dh5nNVF9TYATcL0NFO6j+Vip8PafeIcPcWf/cArbwdg3pd97irp5G5NxmlRijruotqYjBU/7jI8XxTZCg/wCRNymUHs37KdNVUPyPjVYvkn81JWEVAM9hDnKhy6LSp5hvhS8w/LSdcOiR+kfG4q+7Hsgh5Bca4vVBGyFeZJh12A/w9Y0htbFwu23xV9r+xvNZzSUGYohN638BZJ6P/cbYzPSh9SqZq+uNJKVySCVFJ9pY+UTHM2PmPAb8CfbGnu70HHYUMb9MfA+59EYKE/oBNeLMWwuEfs5H6UcWrbW0TDXfmIJS3sgou8SYlLMOMG3pA7eIRY0IEvKysajLUzR1jcjcSwSD1jHT1MNG4AT9qJIy6EJ5b9MVTXoqL0uG4UPsSwzkDNjcrI46vT/lI/+Xa+rgOQExqfUb60K4FD9hUdJg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(8936002)(8676002)(4326008)(36756003)(38100700002)(6512007)(86362001)(316002)(2616005)(6916009)(6506007)(66946007)(66476007)(66556008)(41300700001)(2906002)(6486002)(7416002)(7406005)(26005)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bNllDXo6fLpbjLcfe1S5scCEQJOvwutDBHJEHAHAiKig+/khndhbwCmGJB5E?=
 =?us-ascii?Q?ASWDTyBy6ATMx/U5qKziP96G7KEsMIK7xFpw/X9OTxwRqoBeRIgdDWIctLg0?=
 =?us-ascii?Q?jRGKVL7iOnQZCjodFEVfpvEgcN3EnyuI7c0QGflh/zzYk4qiQJmj9yKWLgYS?=
 =?us-ascii?Q?FGUnHuJkkj7hV4TbaVnh88M9DNmdlYm4mYM8pe69gUbCWdWwGlB1oytBBYOQ?=
 =?us-ascii?Q?nj2B1ZKcTnOXTEWU9Rz5uX1kF96HkvFZiFFtY4qe7PxcAE3RHOyuaMDhkQdL?=
 =?us-ascii?Q?nBR26vsgCbFQuqSg0HDcy6Y49ZWcOn79QWKBv4S1bL3gF56UJ/v8I9DX+m/h?=
 =?us-ascii?Q?efzwOxQR4SSe9zmMv4nRh1BVVn0lC+ZUHE97gkql10dw+DyZBI9Ft4Ve/V1P?=
 =?us-ascii?Q?Mj7DTOlOm7ne0QJA3vpvoA6aCyWE7krxKJSA8Rd6fXrky4JIO89StJHJU535?=
 =?us-ascii?Q?rcTHSI+Jz3c18n24wveWtH+L6kVA3kZzi8Raj6xiRyAf4XSd3xaweE3B408m?=
 =?us-ascii?Q?SzClSl3JsRZcDUYc5bdIsSCHsFyTwpEpmLrtbAOqQXeFQCR65oOfJQ7vLwlN?=
 =?us-ascii?Q?ikrqRrRyFwDx6xJM0xT6xh7HJbUGfEYFQQ0n0rxTRhoL8vOow9pV7ku2ixiS?=
 =?us-ascii?Q?LO/Dv3G+op0VIuqnvikv59uBqfOq+DzxHgo8h3ePcJN7HDiZI18G5ZOnaA71?=
 =?us-ascii?Q?SaUWsz2vBO1Gvdv51v6SI3ACsnYK8PtWZaaaLVbgfya+lzgz651pJ75Qrk9K?=
 =?us-ascii?Q?YEAH63KVjLkokXqUrmnn6EhWBSb5HEusZa3WGBewgyOCypA0X36KNsNjA7Fb?=
 =?us-ascii?Q?h1oi6YY74IiM28Qa9a3DLQcLclZ3GbMZKNm67ScK6ocZhr2logKx3XXYsdK3?=
 =?us-ascii?Q?YNm2eDc2yDaTlZL1cBouUr6BI9/7XWThqkjXDtaBuJGsqdNA8dU3Bq/zJBdQ?=
 =?us-ascii?Q?icbr9+8OzXCzkNiWBDsVVvAyF2RqO1pRO984k5yqlaVCOgZOhsPTd/+pXhtJ?=
 =?us-ascii?Q?b1ylD6Tnn2xeubfhzz3cCE2OvjUuDpMbsGRXuJB2zA/ec9ijHbnxXQcvbph4?=
 =?us-ascii?Q?OW78EiUqY/lvYNf7dDlgubx9zQ/AEC+7z2Nx+j2fGR9Zj4mS70riAujVUpIg?=
 =?us-ascii?Q?IMpgBh5dScOwfkfhj7Nx8d2nERelA0DQKf9P/kPRPeYcdOLZLCzSpXfLLo4f?=
 =?us-ascii?Q?QPtNV6YtXQ6o77z0cFNY0hO0/QtYk2YUQplr3t7Pl8UEX+k5D4FO76YCM2dk?=
 =?us-ascii?Q?SI9Zj7+d31MVSHWx5wvRWchKTRmcZJyHr2FrJ6K+DqHkhALnevuRH1Povza/?=
 =?us-ascii?Q?NeGdz6IBkIsHcsaCL4KpTWWYyKZpAPym8/UOgDSR+MCDXlt9UbC0NYe92NSC?=
 =?us-ascii?Q?BONjB0P88fOnpQ6orHn6CmffUIvPddEfBQ94q8BVSRz2akKQtUnDqD7qc2I+?=
 =?us-ascii?Q?6IUbrMV7QZYENeS8ikDR0taAMDGOE1HRR+iCb3IymnUTKLSHG+/9TolHY4dR?=
 =?us-ascii?Q?HyibUhpzHyH4OTZV3paJdBlOk3C7tB0GubrP8N3CaEk932J1PMrCZjT3I1Da?=
 =?us-ascii?Q?Ef08ZLMVCxarbN9DhKhypCb3Sd2dbTJPIdSm8CBm1OVNFXA4rsJjyc2AH87E?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4jcK2q3Yvms7bd+oXIqTvn9Lwv9ih5G0g8fRoZJr2IZuc2MN+WZK4qcq3PJw?=
 =?us-ascii?Q?yIuR9TurM5RWEBA4ppPfDKi8mFZtyl3n9nsn18F7IuYMNX6/Bc367ZEO96VZ?=
 =?us-ascii?Q?JGrmPWR5ndubvif4w7UFWDlAHpwVNaH+R9Vk5lhaTV6G0hvG+wAqDg5qIybd?=
 =?us-ascii?Q?gARMSQZUK1uUzPTHT0IIg8NlaOUnuMi8AotX7IiYG5BPmoae/tc5QREzrh+M?=
 =?us-ascii?Q?2x64AO0XS6Ff0FEFVhS6E4AQKuiqcLHqTPzjGgEKCO1SH9q0lvx2kWtSE3K7?=
 =?us-ascii?Q?K/Y7p6aDwc7m14Q4wg92UVG1Y/DUIfOAW9df3wsD6wKsXTdkBh5ayuwNKHew?=
 =?us-ascii?Q?UR/vbVaBz75tey/Y7LfHiBCboSEsiP0Wd33PPyQX1aZ4Q19m9p/lihW9Gxhh?=
 =?us-ascii?Q?040XSDT7+S5sYbQu6DhyypatFsOVCmSlcR+3eIM6XLWVHN4+dXU08KVrQKCX?=
 =?us-ascii?Q?JWFaypXXz4MpMhpFy9cVDloy742KERjXNojeFVGsYBrl4GSUG5mm2oGv5SCD?=
 =?us-ascii?Q?U1yAjQmHqAbhRhl09WfF/+moT7xe1JZBDrvpy7g5pQPds38bZXk4nrToNsqG?=
 =?us-ascii?Q?hZVQxFMcWyycZVS71rRlZm5DuoI3YMG2d9DVoT6lNgc5nfC6oQSPu0QNCjHy?=
 =?us-ascii?Q?Oc822+7F01BTwkEgOYwFT00Aer1PLvqv5jrILSVebjviG7ugQnWgSMVOMR06?=
 =?us-ascii?Q?FqfXOwZwiDvAOfPUakOd8AB/UnnMj0oAnGsxJFZEmSDVd7PzY0s4HxdrNLaQ?=
 =?us-ascii?Q?kN0/+ynYzZXCTBtzLCR6r8e2tKCmcmuUhn9RfJTtgH4fkXPy4qvuSeXytSBX?=
 =?us-ascii?Q?Z817Fw01XEF0aOBiTszxrvm+ADCOcbekFhanpq90hcGlbkDC2uoMIh7DR4to?=
 =?us-ascii?Q?OItak2D/pz5y5KkEiODPREaqtqdDvaJo18zYWU8CyWnKqpDQgkFK2orPSWYh?=
 =?us-ascii?Q?EhZUbUymTnjUMOhOnCu8n7kK8mnnRTlkgv+z9JGMc2vZHqkFdNzHviYk9Z72?=
 =?us-ascii?Q?FJkIHN4/BTjVULbgAthay9zl8eTON84H84GWHiPcFuvGCTIXayIHQk9p9ii3?=
 =?us-ascii?Q?mAzsdJMVf21ufw945gv+Uk1CjAD6J00ZCqJEtt23bZAHdQ6xvtRy1NUvG5ZP?=
 =?us-ascii?Q?0ZKyXPBvCopM1K4ky33VSWADmwkDiZGlp8lYnIWsoz8miknaKtySV5L5FhrM?=
 =?us-ascii?Q?MD3mPdadeO52jekZV7uJWvrPcakjAHTdmnieC5GbLbtrTi3tDI3UZ6jzCr0V?=
 =?us-ascii?Q?f6kzhYOz9/1fMiI/ojtZgQNJH+VYVoGs4WC/1My6QNrYkKhGRWjUaVSgAO7+?=
 =?us-ascii?Q?eBEqiIzdZzIxzQLAqejRV1+V6XJPlFpsTiMX7+CpQrgZlB8YqsDvYHdFDEGA?=
 =?us-ascii?Q?lyy33yMr6UoIjxSAaCUtjpBIvvwHoGBrxQZqUCRykjz/KME8QgweU7kowCSc?=
 =?us-ascii?Q?OiTbNatGOBq78Fm3skU3jlvqy6rFPuewG4Egoys9lfNVCilYZpMxOnkkQOWx?=
 =?us-ascii?Q?VUQFsul+wVZgdyAFpURcD+Gt82r08N1wVCcJRymfHRTk0NlWKgqeY0utaT5z?=
 =?us-ascii?Q?YS4SInNQ+staiya5CLM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb083387-29d6-45fa-dbe8-08dbe1744a6c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 22:36:18.5542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4J4fhh7iXNKPV/BscxLkVIkfCr4hFbvzIz1gsmXPjWnYONFV0tl7jd3AUaS9KWhuJpw+vvf50I8iBzmP7Fu0PWjWMrlHsg4CdtuYOFOMwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_15,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=386 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090164
X-Proofpoint-GUID: 225g_zMv69bIZ7a4hh_W6NHeSUAbxeYz
X-Proofpoint-ORIG-GUID: 225g_zMv69bIZ7a4hh_W6NHeSUAbxeYz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Rutland <mark.rutland@arm.com> writes:

> On Wed, Nov 08, 2023 at 04:34:41PM -0800, Ankur Arora wrote:
>> Mark Rutland <mark.rutland@arm.com> writes:
>>
>> > On Tue, Nov 07, 2023 at 01:56:46PM -0800, Ankur Arora wrote:
>> >> What's broken:
>> >>  - ARCH_NO_PREEMPT (See patch-45 "preempt: ARCH_NO_PREEMPT only preempts
>> >>    lazily")
>> >>  - Non-x86 architectures. It's trivial to support other archs (only need
>> >>    to add TIF_NEED_RESCHED_LAZY) but wanted to hold off until I got some
>> >>    comments on the series.
>> >>    (From some testing on arm64, didn't find any surprises.)
>> >
>> > When you say "testing on arm64, didn't find any surprises", I assume you mean
>> > with an additional patch adding TIF_NEED_RESCHED_LAZY?
>>
>> Yeah. And, handling that in the user exit path.
>>
>> > Note that since arm64 doesn't use the generic entry code, that also requires
>> > changes to arm64_preempt_schedule_irq() in arch/arm64/kernel/entry-common.c, to
>> > handle TIF_NEED_RESCHED_LAZY.
>>
>> So, the intent (which got muddied due to this overly large series)
>> was to delay handling TIF_NEED_RESCHED_LAZY until we are about to
>> return to user.
>
> Ah, I missed that detail -- thanks for clarifying!
>
>> I think arm64_preempt_schedule_irq() should only handle TIF_NEED_RESCHED
>> and the _TIF_NEED_RESCHED_LAZY should be handled via _TIF_WORK_MASK
>> and do_notify_resume().
>
> Digging a bit more, I think that should still work.
>
> One slight clarification: arm64_preempt_schedule_irq() doesn't look at
> TIF_NEED_RESCHED today, as it relies on the scheduler IPI calling
> preempt_fold_need_resched() to propogate TIF_NEED_RESCHED into
> PREEMPT_NEED_RESCHED. That should still work since this series makes
> preempt_fold_need_resched() check tif_need_resched(RESCHED_eager).
>
> I was a bit cnofused because in the generic entry code,
> irqentry_exit_cond_resched() explicitly checks for TIF_NEED_RESCHED, and I'm
> not sure why it does that rather than relying on the scheduler IPI as above.

Yeah I found that confusing as well. I suspect the reason is that not
all archs do the folding and we need the explicit check for those that
don't.


--
ankur
