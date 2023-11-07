Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F3E7E4B3B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjKGV7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjKGV70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:59:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31C910D0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:24 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJP6G004600;
        Tue, 7 Nov 2023 21:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=lSHJYOhJH1cM0w0ObGeU30WtZ6GiFFGTdHFP6PoG6zc=;
 b=IszQ7sTj+o41AwIQwmnJ6fRqFwWje0XT+GjkwF7TO9heWpynVZUtS+iuqPgmBY5RnJ/p
 0PIuhPkC6YWmmuueGj4pu+2MoByUU4TmBbD6AOO8cRf29eAr5BK1D0ZxLDFsxQbehXoG
 L32rbMStmeTTkmEJNltos0ciwQ5Wd9QQUC2RU7p4juqFDhbsv1GVBgdy8qAmylzADw2P
 E67hV6BvUS2QTrXgk5F/ij+fa93LHNTK1LkP02Ke2JBBmpQFA5GgtKsKv5jysbcK+VKB
 wI3H8r+RPsfvN5oEcfv887qtJu1IUTghwsECbWC963QvN5158q6NNxJ4bHNXqGXfy9JH 3w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g2a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIrDN003912;
        Tue, 7 Nov 2023 21:58:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vsh7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwZtYe1YYYEvDail/OEjTq95yZ8vxFPqjbjT1vS6mJPhIH0ecWJg6EY0JdL1Lth3UBXJKdSVu7L7FGU7VMR1Ri9yWK7JKr49KsP9SSDIzzXc3Qtdm+tuDokXDrCQ91agDVcUjYN0b2HwL0yvKaZ1o7P+1edryRAYBlnKq6xBDL7zYfJeTGJv5fc+5Csj39f87z4aVb75j11OmGX6rBpM2R17HC7JwTwoN1SNGJEHCcuWeKAt2qLqyf7knwqHQmwHmMQccUVvOTwfw9Xdrt0bqAKmGDa4goYnyQJejTV0IRLA1ReQ/NCHL2/z7cWufUR1+TU6aDcMHuJ+ItSBTbIDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSHJYOhJH1cM0w0ObGeU30WtZ6GiFFGTdHFP6PoG6zc=;
 b=EtVyvGiTc6Qde+dmt5RhqfnUa6i53Fe7STMRVwStRcpyTziXVTd/XYRvuZATCq8IJzMe897/NB/8RUxOgEYq5tPKMg9WgSwfr8AE+Q8oROvhHGqBL0V5Y3hpmgDEfRJq66exxz36+Av2ysqo+O1/HbW6vYmibS6yIkVM7OjyxCzrTOOb2ahWI8mQtzY/Wn23w0nI6T9xDvofbCdZTOcs5WgKRmT7Femhw+5tCQvuBQy4A5fiJlEpDgPpdq0HFMNWw9d5l5ZK4MGSt+nheSU0rtHiCDdXjMMjRuzfyFLwyKsRc0ntAwkywIH1BGFh5jZZ7TJ/8PZjrA2sZox3GtYC1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSHJYOhJH1cM0w0ObGeU30WtZ6GiFFGTdHFP6PoG6zc=;
 b=qzKN2kIbyNzmUtgoP50iQ5Xj9bawtp7hDYbonHXuxtsRzKa5/+zqqMiuJpCNPYGCW5Y8ZRNlcE5oYkUU6UIS+9v1XXTfSktx52ozxTSO5k8fP1Qu4zKvCQUwHScwVNWa7SgQ3Eo+yTcXY1NRAF3GQWrCEWXRkc7x7oP9T2S7eKA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYYPR10MB7651.namprd10.prod.outlook.com (2603:10b6:930:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 7 Nov
 2023 21:57:53 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:57:53 +0000
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
Subject: [RFC PATCH 03/86] Revert "ftrace: Use preemption model accessors for trace header printout"
Date:   Tue,  7 Nov 2023 13:56:49 -0800
Message-Id: <20231107215742.363031-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0136.namprd04.prod.outlook.com
 (2603:10b6:303:84::21) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYYPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: e044a1d6-797a-4f21-d1b2-08dbdfdc9799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: viKks5iqpD6nVjDDkIOfRYuh0ef7bT7chs+Dozjxvyx79ZE/EM0h9EuPijZIYVycTJEVs1QpeYMJ1MeRf+xihrdsz4sO7Vib82DT9n98W4831jaDCX3el8E30vHEtCfTUJ2wSjB5An6fEosBMvCD/JzjEK21aNSLHfk23ckfgVfJNLVhq/+2xQS4wl+To+ixqPyD4HIETBDpCXaWFZxVRq/XXt6uQsZmjJhdyHSYOaMgfRpvVEcZNXnfavsOFKSjQxNt3ljCUjsXs80V70haIbJsr8KkJViO76gMML3oJbeLCM9A1466SGA2OhiY2LRKIcVczzoZlb6KzfO+ld82h6Nv/EaAgEYPl74woQJXYgv2y4mXTTQItQ0fWymhEhS65uh4XA7f94V+POJgVao2pBe9kL4k+O5SyP+/JPoWsrHDIPrkwyEL+dUCBmI9mnMQiNvqrHppxQ5rcKgIC2iLMAXMZx1H61Wr1tOXAfBt7DXdhfdD/FU3SxayWtySJ2BteJAW5J8LGhdBCg1HfUe6Q+5GwDh8QmW41OZOBTJ8MNklVdVniow6PipcfgYMVVJ8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6916009)(41300700001)(66556008)(66946007)(4744005)(83380400001)(7406005)(7416002)(66476007)(316002)(478600001)(8676002)(6486002)(2906002)(6666004)(5660300002)(4326008)(8936002)(6506007)(6512007)(26005)(1076003)(38100700002)(2616005)(107886003)(86362001)(103116003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?weBZYfqbZskq+X3vX8zDxufGKYDa+H8I5C/+RsWdHQu/zeykGB88oleyR00N?=
 =?us-ascii?Q?PvYnYLe/s/quL4CcxXzplINZTY1xh0pdnqoWxiE35cl/K5MQdbrJY8gYez6a?=
 =?us-ascii?Q?pxTau6Z2Quoez7VBof1XI73HwNqZaygo6/iBOOZsfgRkSjLY6e3WZjKPaIEs?=
 =?us-ascii?Q?RK0ysT8q4FMHZnPL+t5BMv7kbVSJq80OyJdvh4sEkaMcKvdktRWXdjcw2v/L?=
 =?us-ascii?Q?IYC1K5s+6pVtcfeZfo7LQKrru1FzY5aCZZCglj7RGDQRfY4TQwNgAw7G9VAZ?=
 =?us-ascii?Q?p5lKvTX6Uf4ECQ/lmIvOMxW7ThdMUuUCIzSgQJOxbqFm/bEVAM/1XPf0f+xg?=
 =?us-ascii?Q?UFxWDIp/G/YWmYWfvN+HsGJzaRMd58OPAj1CC2FlIZd1LQcpk0hlSK4/+TMZ?=
 =?us-ascii?Q?VDJOuJAVp8T7f+Z/sn7l/AvWM9uxIi+5rBFTVh4ZUN1RpF8LbQzQoUVebiZe?=
 =?us-ascii?Q?xpfvUI3+4sKfSFFKMIg882hJDZXwhK0xsFz+gGYVApzCrAQyV1jLX3VXN5L0?=
 =?us-ascii?Q?Xn3m5ZtIioI8rRhV0W4+9I6TrxCM+g0ybAlnzDMWeWR4FeU/rCstpUQ60s63?=
 =?us-ascii?Q?8Ij1Gja8Li/o2mTicvm7u5USPqXh0Y4rsUBiF1wo8vD6iVGTCTag6t3g3a70?=
 =?us-ascii?Q?0wpSMAWYRSb8YxnDemaLH2sFwADTAVLDAGlI0Z5Pya7MLGK1l5p915/Nl+Lj?=
 =?us-ascii?Q?jNigr49k7RcU0dp2gVKZEF44/E7CNO60B+BkvqS9wjLBst9nU1SfC4uFReq9?=
 =?us-ascii?Q?fwqBEPqA51ryoMGzds0RTQjDWDwuNVAZrr02I5rRalrI9DuW4Et1T5IRyF/f?=
 =?us-ascii?Q?cn4M4mwlpkGYp6JkXFusTPQGjdzTQQg0nD3jJ4BY2+86V8sji6L24ge3xkjb?=
 =?us-ascii?Q?GMx7/mHeaChfhCEFwGxfJLU5m7zZ98Y+8jDLqIgBKQt046wJznCvPlEAGVpd?=
 =?us-ascii?Q?u8zwzSoZ94VzAnp1rsVMBh5JLtRLiazkeYJjI4ENrruc6S++iN63SRNU4O/A?=
 =?us-ascii?Q?b8Iabt6JPTVMbveRJesiCk4hZnUVbtizqTVM9+wfEcbHXsxwgE+KF1+rP13J?=
 =?us-ascii?Q?yviWTOE2i0dX7yzP7MG8MUX7immBXJI8fdBUoV/Kquu3nlMxcasjpCQYtt3X?=
 =?us-ascii?Q?7Mf+LNQIkda3smi5i6TFmh4IW9GCSya1CZ2qPe/15L2+d8orS/IgzW0TtjeS?=
 =?us-ascii?Q?wQzTxew4gy6tp2HIT3nbS9/oua9E/UKd+ErFdp0KY0biD4FnurCdkEnCkVeY?=
 =?us-ascii?Q?Hj1vU35Ny/6c0nm1ce7v1c2UW5SWr51evA06jODqvS0zsclzMLtx3EPygfP+?=
 =?us-ascii?Q?UQqHsG8+KNkTJ+O3jn1Hrat2ddLYFJ10usO1Btw5JKt3pXG8EYazino5ZfJB?=
 =?us-ascii?Q?JyuRPQ36AWeNIi5xcfhcpnoHIuHM2nQTRp0HysQ+h3oyrVJe/pJIknrTH91X?=
 =?us-ascii?Q?l7JV10eIF0dFVVQKhV7PLHfqjuRaLOBb7knChbWCugIVBEnqIdKSAW1plUFW?=
 =?us-ascii?Q?2qGgVYkSV41ckzUpVFwVisFiaQKSPUMCa2OgB+FvNy+HvUNl+DS8Klwwkrfg?=
 =?us-ascii?Q?T2Bk5CTZwMcCioN4pOckJhjin3JCAFGP6E6WO9DVADtYPPy12/3X6lMrgOCA?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qJAYUBfs8oRhd15pCNI7F2fBv6Fb06ZSeRN4mbsJPvpiQh92EKVfczTAGO0F?=
 =?us-ascii?Q?5og8mmczEgNd+AxQ94acWA49wJt8D5dkD+Yh448UD3YWQndGuErn7UaQ+6bO?=
 =?us-ascii?Q?oUjU5mTYkhXIGtcuQFsFGHmN885vdJjEs0S0abedMZYatqy2O9ZM9eTjkGUi?=
 =?us-ascii?Q?yIUCy07NSlcfjE+6q9dinvdrFxGtbkoOKO0vHNIfzlt6tnCSAYGoHbv/GpPB?=
 =?us-ascii?Q?FBm6tkF1LOq11JFIn7TtGQ9MS4Eah9vknhX9QJXulUAfE23BaYGNz5YtRCfd?=
 =?us-ascii?Q?MV1OGSOoyOp1oeraOwOiSLuk7jzNEh3c0bdpuTp1YWPu/blZR7M9+3Sfp+aE?=
 =?us-ascii?Q?qNqqx0kU14FQSRT+c7qXE11ienC1hKtQHtU7sLowWstvI0kElgK5X/NhXPRy?=
 =?us-ascii?Q?t1gyC5SFHa/aNdsI0CQFca0xhRXOCr5voe0QzDiCCuQbpQuQ9aXJil+f82t3?=
 =?us-ascii?Q?tXGnRsufMaAHBRSWUs6XfjL7oHzq3avraPbM1tl/w1gCo4QtiMrpFDR057l+?=
 =?us-ascii?Q?oHutMZonwH9NGbAFH+AMWaNrxQZFy44P7aQEBiPRNjxKgLDrv22NBs8L3TWq?=
 =?us-ascii?Q?cEtXDc66G7b0UcEUjzsCIYaJ0TXTxFaFm4xSX5LmfNND4At0vQsEsNp2Rmlq?=
 =?us-ascii?Q?ise+kC4IZFdrribAse8CDIOKeERd3QPYuhshf4qDslO1c7glCKe3Yo82iUnr?=
 =?us-ascii?Q?+iGVR6jtJX11vUcr0LdQ06Gl5O1ExeIa7dH0oTN8DjwZiDbr5vjyRbXpa2ON?=
 =?us-ascii?Q?NCxHorX0AzElHaHsyTa2BtL4ZzIXw+sUIGSqPd1c843p/Q3VPR+XxNHpN7wh?=
 =?us-ascii?Q?f1lFVSLowo/WYLNTmvJTcW09AJ+NXknbd5+HaCQDlsjlgBwbBVhK82S69Vdr?=
 =?us-ascii?Q?VNBV+NYwbpvagRM91LbRxliWKrYHo+0WhFO0d2ji7yO5FC2rhXgL+Ai6ZNR1?=
 =?us-ascii?Q?jUKkxZg7H2eY6eCQp1eViqt4T+F2Xz5Jj+4d7ts8NKU+PmpIOxIw2874QVSa?=
 =?us-ascii?Q?EbuYgMhXnpyckbG4C78c7xQHGV03Hc1co2X6EEfAhA+F08o3p+dbLmS4J2rq?=
 =?us-ascii?Q?aroycZOQyZJ7sv6xSCA9TeVSURWbObjinlIoJ/G9ml1jTStuuiVk5LGjiRet?=
 =?us-ascii?Q?tX4yait2/uJkHL/KGf/+6KzmxIseXwJeTqlrMmUcsUB0Znj5ItkqZi1b2MwG?=
 =?us-ascii?Q?I6fLlaLmZU2m033FCZLeGLy2CB8A4o4qI0VvqrpVLc7VWG9Nd5npUroPo7VD?=
 =?us-ascii?Q?KWnFMT2HFMF4RmddYcCDz9lJsPz3x8BXMATGMHF9s3eN7Oh9Jfad7oM+lV8S?=
 =?us-ascii?Q?xK2Pqh03QdQuGQeuij37iSWZFZ34Trmhyuqk1DHqr2Zcj3l8u379kbhn1QMn?=
 =?us-ascii?Q?3Q5yvEME3+bie3xsddGfinlr4SZ7EOnv4hSAO+zzjBwUa8OEMtrFq3vXOEVk?=
 =?us-ascii?Q?NGAh5Ki+jWB28/2bt2XD40eDE545TO0Wlm5PUF1ETtW1qcoNKemsGxktYVHu?=
 =?us-ascii?Q?X/cwfPOgN4ggentRoPBQnAkPLyrJb58cWld2QMmg5+buYMHEVw+GujLkUA?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e044a1d6-797a-4f21-d1b2-08dbdfdc9799
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:57:53.4683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Y4+CxZBz0b2YXeDco/84I/fE3VrKfujSFKb1GdsytiX8L4wVmd6CxRopHdwX9np2Vn93jjSXGFUKxU2VpUrWrvjmEaJncXBCeTlSk4xTXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=888 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: wuMSjcSazq8RICIzAXl82AEvESFYohml
X-Proofpoint-ORIG-GUID: wuMSjcSazq8RICIzAXl82AEvESFYohml
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 089c02ae2771a14af2928c59c56abfb9b885a8d7.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/trace/trace.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index abaaf516fcae..7f565f0a00da 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4392,11 +4392,17 @@ print_trace_header(struct seq_file *m, struct trace_iterator *iter)
 		   entries,
 		   total,
 		   buf->cpu,
-		   preempt_model_none()      ? "server" :
-		   preempt_model_voluntary() ? "desktop" :
-		   preempt_model_full()      ? "preempt" :
-		   preempt_model_rt()        ? "preempt_rt" :
+#if defined(CONFIG_PREEMPT_NONE)
+		   "server",
+#elif defined(CONFIG_PREEMPT_VOLUNTARY)
+		   "desktop",
+#elif defined(CONFIG_PREEMPT)
+		   "preempt",
+#elif defined(CONFIG_PREEMPT_RT)
+		   "preempt_rt",
+#else
 		   "unknown",
+#endif
 		   /* These are reserved for later use */
 		   0, 0, 0, 0);
 #ifdef CONFIG_SMP
-- 
2.31.1

