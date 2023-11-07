Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F957E4B3E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbjKGV7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjKGV71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:59:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4151A10E4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:25 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJdAA029149;
        Tue, 7 Nov 2023 21:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=NTfjEQR4AMJt6yyeprogGA5Jroe7rXtQxKX8KmYRzE0=;
 b=22e6S27f45NCH/iZ4Yx8cFAHRCb9YqptVAsTzEjWoxlrSbDLJs3aA/LvlDzImfNLIaM8
 SCCmEL4037P5i9vPiXpYZAXOUQnygF8zqzQ2KVhMJipk24nB5BL/8u8ujJ3oHrm62dmq
 uJWYM4+Dmob2GBlTo47L9Cduixn8mo9xWJ100dJ7U52C7Ny2e+7TLaKuGDkyhY79ilxX
 Q73LO15V3+v9QjBJSJpPXpNMfg4soUbo5hNPHIuS4LT29c77DBjxmmj7ebTsWl7+5zt9
 C2tH7a9vIB/I5/zzq2NX/zvirfTvbk/eLhDYnqGWBZHSqORjmfIltZf+UVAuiYsODXwY kA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2302ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIsFb003945;
        Tue, 7 Nov 2023 21:58:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vshv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTQPrGhwIwxjg/L105hkN5Ll2q+d5Nw6ko8eehrndNWm2oVDZOrggmRu0bknR+6Gm73Rsw7AhD0G6cXbf7HXCBBOsc7tCxPN5pYTC+WVhNjXmDDlt/+DGpmxa3ZXoetIyOQRxY77bmsePUSMBjUTgokvLKBSmq4KVQ5xgkyMButP8OG0vZ2GrTLRC3JqUTVPTSnnwe8a2cQen/oCb+1yN9bz+mO3xqUUH0Sf2YNxKiamTK+z2sDX7UKQLWPdHPXrVALiKRi4ztBD6P29AvTx6vlsXRu42EBGD6XdQG0wbiZXDITa6iPuzTgsOx7NtDIbQx+FzK8TYhMlWwt/0yQGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTfjEQR4AMJt6yyeprogGA5Jroe7rXtQxKX8KmYRzE0=;
 b=QYSLX5r5H4FrZevS7mInBf0xPqaXP0rHosLtzUKS9AUrk+APnpRcCAHLqN+VPX+Xlim+Oc9c/CCeqpY3qQmWsII9y1Y2EG+pWYFCrEQaOGcnb0OPW8KzJWXDjs+NfHHy02FaVbHMiLMJCVccsmGYgfRMddAJFMf0tI+BjfUy0UL/XJa0wyfDxJcYeURmoQTgxFnkaKTaU9c9jh1+anaIgi40fT8WbIEajFm98LeYIF4Q8p3wbhjZ+zXqAXwhkoDC4+hpRbZ+t4/woInEiOgHWYs1IzTrJ9ykS0cfE8QX1eoXDyXcDGOWicFAAEvtr7IgsY/DNLD4vSVQQDGGktg1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTfjEQR4AMJt6yyeprogGA5Jroe7rXtQxKX8KmYRzE0=;
 b=VwyEexzWdNLTNSdUtqscg1tvSaUOzxoBmhsad2TB8rPYx0qhMJa0QONivVSszzdIbgM8ZJUewkWCRBjBzXKXk17a3r+9AXDgEPWBXybld/cLoXmIrgiIM79MTZ+5wklOSOd6cmyHVhLCE+WEu6wijTpJdm6A/bVYclayUsvgc+g=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5048.namprd10.prod.outlook.com (2603:10b6:408:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 21:58:33 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:58:33 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 17/86] sched/preempt: remove PREEMPT_DYNAMIC from the build version
Date:   Tue,  7 Nov 2023 13:57:03 -0800
Message-Id: <20231107215742.363031-18-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d0db53-4d01-4aec-c504-08dbdfdcaf90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUPLLcVKLDDBAoL5Hqo8wVmAhMyZntpkcpe8IIFD76SGpT8KcEh2kCpQkF2+L9Wq7XLojqqqMUD9gqbs2z13D+Fy/0wiFwQOeRquu/MQ3NJFgaaDO86OJGmM/cY5tYPhV9qTSUQRLs5amNn18cVLc4R71Hi+1L9I5p0g3WwXkjgxgVNxDwDXuJha9DGGU95bRWwSIgMPZoB/VSWsnofe3IFd5VLdEBgb1IX4yaeaHIS1ysCTUy9/ImgHE8aXuQzExyT09eLpS0O6M8dghvBmy0G3Fg1/vI5de/FUSCb8HzSb7DUK0mQDesP7LHu7eV50GTTga+QPbci7Qq3T8yz7hkc+Fw00eNICzzBXO7YoFO+0jPKhIpxDlssNhQHPYwdMQxjNFge39ZKn/qmK9r6NFQWvY5ADcvREgAcJZ2odcE7rfSOzyC/JHzP+IugKiFx/Qf1pluImJOT9WrFVlu5Frm54swU5AEUffmsLOHjRplBSMxaBYVyeiTt2iBvTuMXAHqSEhLGd9tJtvn2AWdwY/2jJnCX9/CIEYsyZFYJlAGB6mdbFblFyz+nHgF2j6AwA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8936002)(4326008)(8676002)(66476007)(66556008)(316002)(6916009)(66946007)(41300700001)(103116003)(2906002)(86362001)(7406005)(4744005)(7416002)(5660300002)(83380400001)(107886003)(2616005)(26005)(1076003)(38100700002)(36756003)(478600001)(6512007)(6486002)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X0nsSWZmQ05bFPBpIOe4Lng0RXOBRlRGE0OoOo+l93kifBPW2AmHaE/RzK8k?=
 =?us-ascii?Q?Pla8nl0sTyWnKCrBN5wLg+pHg0rpG+V7g3LBz/AmtnyDMOjgEjnulm2dlAy+?=
 =?us-ascii?Q?9nwIOvrUWQHEXm9i9vqilAl/xfLATxUxcjOhXeJ20Mc8lA3KyTs/W2xzfddb?=
 =?us-ascii?Q?gujg6yXbwC4pC1TRYyIXoribAGYRDQNUPrJVNAyGF8kubfLYH1/QbRvPm1h0?=
 =?us-ascii?Q?oObXl8sFB1jmWqf3shMqxhO7dGLCUt1UDcqcr/5voyi77RLhbBWuNJEjetlW?=
 =?us-ascii?Q?4ctHloV29zbC/hoowIvQ46ctCjcsKY+42LOCjx+FkjyToA4wEAheCj/XWk4H?=
 =?us-ascii?Q?EhFa7I94HerH7mF/lYqBZkM4U38fLLyb+ZrSk+nZQBi/82r3QdMUgXTq1Eua?=
 =?us-ascii?Q?oYFhqnztwG+krnUoda/hDPmvsQryZX3xEzTeJEFeYEGX9GyKYZA7ONUe3WzF?=
 =?us-ascii?Q?1snN1BdenhjBeUV96IQOla9SP8ezHNxxa70JhS65eeHX/W83Vr9w7fs8EHJB?=
 =?us-ascii?Q?tpu4M6EWbM1gApvTr8mE7JmvmY8AGikvz5vE5OO9R5wRczHyDqABMaFn+ZTe?=
 =?us-ascii?Q?mmJx4xpG9mZS8lyY5FEDhqqG6uf1H0Ms5X1SzoDEccqvl1dPqtp/cmv0/6Px?=
 =?us-ascii?Q?57Ph/MJ0Cdr/hLFicZFV8aq/OzugAe2CIPsaq61ogIXNTqgmhunUWT6p6pJz?=
 =?us-ascii?Q?5ylMBBSpRTv4DO0TrmXq77uiMDjxd05SxeisHHnyUMCCQoTiYafhF62ilvzq?=
 =?us-ascii?Q?iTt9iy58r2E6jCQ4qtRf2UU6eamQO0ofpcam/7a+0HPTm7blGg0Ahnern/ke?=
 =?us-ascii?Q?xeXoVSTugF3KFVihQ6hSrJt9cC3wqajnOxODzgxH19UkDfY5kghNjsqwbCXG?=
 =?us-ascii?Q?Q3oo+IOQ/U83QLv5GNB0fcIVO/kG8G1JhyU1BItVS8SSl9a46/FKebH56Cd0?=
 =?us-ascii?Q?RlcoNAYEylUhyZlMmEN1pq13qFbbdtok9KPsX5ncXceuBRzl3Rjempoqx/Jn?=
 =?us-ascii?Q?z4Vwx9gYv5vAZsuvUGLUdr3PDJCZsJWSjkBruXfFR99kmLniQ9CSPI3XIrxL?=
 =?us-ascii?Q?mw0KIoPiXKpvXve1IIi9EeVYIktBQq9ylyp4tj+zU3GFwhq5fm7vLJnOL6Vc?=
 =?us-ascii?Q?cM+LaMZGxuKwrcTeakCmBWax9o52R19+WZn2RGfD1nUI7sO860NKKIDYp/JF?=
 =?us-ascii?Q?3l6fYU/8FteGktwpp+upgZj+IxqphYiO06H1fMP1n/Ga56Z66cbuSOb9v3r9?=
 =?us-ascii?Q?6fh8FplX10t3Lq/R9C4eqdJjNkYGcXA2FTFoGakcMJbM4dNhsV/LHKdB9SkF?=
 =?us-ascii?Q?9irZMWXpPTIktpj+KDionnSapj9aQMU7pA1l7hoPoAf3/0m8qT5VrmwzzeoV?=
 =?us-ascii?Q?f20rS7z87r2bbDwU7l43S2kYsTKJlds8BBmyb4ttro3hRuUBy3Fuqd2nlW+j?=
 =?us-ascii?Q?cl2/N6lPYD2ur5Om5ycP9nGU0bFqQEjEY4I7Tde7aAde53mjTbgH5bfPqh6S?=
 =?us-ascii?Q?pDoQXedM3B8lblnHV1neUvDZJJR6T2GErVYVpYyepqwWsQFIFhqnoqWt6kQy?=
 =?us-ascii?Q?ic+mKKwZfjwvdw8Ml9Fw+bGRuLE63PQRxKgriv6+AVAnbQavMQAItMUj3bmr?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?I5RAa1cE2RZTk4kv2e8Un7Zw5feYD3dNrUh1fMNk4jWY5VKcg1s11nj3aJhJ?=
 =?us-ascii?Q?RejC7YHYSrfAeBkCAEFMPX2bVlPiS9GYaxbtl9BPztkghNNjxDgAFZHsKhiC?=
 =?us-ascii?Q?iqH7tujSX5dMjPOMk1C5UzGZC38PckBeYgAk7Sa2AN9GdW62pIxvtVsUji7e?=
 =?us-ascii?Q?n60DwSkK+tSCs+pTLhMzdeHGqRzzpk0yNDXwmZM+RYF7ljzFhvaC9fe5D82Y?=
 =?us-ascii?Q?+rb12Itwq1IFVgRREmNqhbB9jxN8o9sEA20WrTqptTxLLvPXX6PX6mRGAARU?=
 =?us-ascii?Q?yX7zvkscAi1api8J6Hwgg7c0vPrk/pvbuoQC4AmrK62YFRfhao7s62l7T+u7?=
 =?us-ascii?Q?oDC6qNQKzms0ofhjkjS7XbI8YpACluLyQdM5dSC/ZNC/Vj0jrIX4AU7DZOyO?=
 =?us-ascii?Q?LNHx8dCjES/20tY/uJ7zIMKc/dfBw277DqlrcDYmwCryG4wupOzOtymMTZy6?=
 =?us-ascii?Q?E0wt5TnNeqotvecHzinEFZ4ZOoMu9hQWLv/Ep9uXvsy2aVNuvfbA1woKoGhO?=
 =?us-ascii?Q?tuKfSFDK0s/TNoPLqsfAZA+ZGYL5C4ZnfwEy5jzjNUyUdGBSl8bSrKtHKcwZ?=
 =?us-ascii?Q?0XYJtJv3GV9YDJjEvLeRH7u1NGSqHVXgQyqKJQioKssm83unq8z4CTpvVpZN?=
 =?us-ascii?Q?QDtiGKxK9LW+p/ZVPHcJGRIhPXjnk0FRuGRDHy59jgF4JEdhdPqqsISo+ZqL?=
 =?us-ascii?Q?4qdAX5PrCnkSHR303kbBlp3AQZ2SSqjPXzAegyXGrpwD+kSIYvkY69xhWg4B?=
 =?us-ascii?Q?1XNAfQcNIhNhsmB7m+u7MGlyhKa2h22ByWC9fPbwToWyWplnXf12crdO1nPT?=
 =?us-ascii?Q?YTbiYinUGhPcrKr+3SAz9iDi6RXyZZPBbXLP2UibUUKr0uMKb3xIxMqY1Hjj?=
 =?us-ascii?Q?GjvAImT9nWpkEmG5IEYHEO7txU1q0igPybACqUtWaEp5y2FQdrVbvxQ45Pmw?=
 =?us-ascii?Q?W36YNU/tdrjptybUiX8SOzKm2ryZJR4vsp+n0bh+wNfdslcDsXHq/Wf0cKeq?=
 =?us-ascii?Q?v+ubYgXfFQAYFNl7S1b62TMs7GRNpyLggpiiHWLLXHZ0c+/poJ6qc/gfTEJq?=
 =?us-ascii?Q?gapmtMDFU9CR17xt7IY12IoA/zI1napb8oMftz5XXAiP0V1MWEAJLHIBgiuS?=
 =?us-ascii?Q?+G2zENdHaR3uhvsT2u4cPpGvjBC+SgkMl4t+3i1NsM0YBXnxUn/NQbe/dOYR?=
 =?us-ascii?Q?fsiHYX/BbD+h7tSDYng/eSQkTZcce3ufbAkuoysE02iav8Aew68QdY1lgB0+?=
 =?us-ascii?Q?Dl3c6SaJVXYUvJyF2SjKhwEXfs3MfbtkihcAJoqWjJkdNyUGz7vniM9A+pka?=
 =?us-ascii?Q?G8Hde9GA5HL/k3wcJ+NbuTjzDRYTnG/MmWpwhiJdp1ynrCeZzjrVXlCsRtBv?=
 =?us-ascii?Q?rFCvC5uM4ZC7X6/SKH8MYan6Z75oJ64zbbz8TdqqyYt+xSh0L39S33jxxjcB?=
 =?us-ascii?Q?Mlz0P2W4qHDBV+2nJb8pi2DIVn4fZY6Bkrvv9Ze9PH4DyZi5gfa4qOxOYago?=
 =?us-ascii?Q?UG9uNtI9mFggvps73t5L9dvn/sPc5q5QkyobScxqteT+pSsEVuB4713edw?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d0db53-4d01-4aec-c504-08dbdfdcaf90
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:58:33.5927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDI1hXQrN+7m3kMGTYc8NbUz1MvusiwteEx4H+PIdQ9kUWjYQLr7BHhdOYcL/bQ+LozahYDGubrIS3Or9P9n3FL5d0hv7uWDMFYBs+HV3oM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: UzzuxG8LG7qRi1b78612fWk3z4lRHVPS
X-Proofpoint-ORIG-GUID: UzzuxG8LG7qRi1b78612fWk3z4lRHVPS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the PREEMPT_DYNAMIC logic is going away, also remove PREEMPT_DYNAMIC
from the generated build version and go back to the original string.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 init/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/init/Makefile b/init/Makefile
index ec557ada3c12..385fd80fa2ef 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -24,8 +24,7 @@ mounts-$(CONFIG_BLK_DEV_INITRD)	+= do_mounts_initrd.o
 #
 
 smp-flag-$(CONFIG_SMP)			:= SMP
-preempt-flag-$(CONFIG_PREEMPT_BUILD)	:= PREEMPT
-preempt-flag-$(CONFIG_PREEMPT_DYNAMIC)	:= PREEMPT_DYNAMIC
+preempt-flag-$(CONFIG_PREEMPT)          := PREEMPT
 preempt-flag-$(CONFIG_PREEMPT_RT)	:= PREEMPT_RT
 
 build-version = $(or $(KBUILD_BUILD_VERSION), $(build-version-auto))
-- 
2.31.1

