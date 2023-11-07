Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8167E4B4A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbjKGWAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbjKGWAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:00:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4861A1719
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:37 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJdAB029149;
        Tue, 7 Nov 2023 21:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=fKRDx+uw2jyDRgUp71qjdHwT8NWG/kxW3t5ad5n6A4A=;
 b=kdd4acaPmGwx0f99J4PXoPpZN2jKoR1D7LrujC57dvMGnT4L5imbnELeItWef4Y3KEwU
 e8Dz+pROzkl0szquZmSaX4WFaZ0oG6barG8Lie/pNibzf3xE2sWoGz3K01dOJreqT7/e
 A+ozcFrNqFof0CUEXiFMCZacM7ojiITo80TgrCQRtjUnTmr3MaePi68corrmEjXLVa1G
 9e5sZC+D/bASzpkOgLUdl488RjgmoQF97Wx+23dcW39Q67kYP1sBZDrTS/eQ+2/IoO/f
 B5cjGht1onnDHi4+CYklQurSI2zpksgQpitUOIhcy5EAv2iCJD7IxcFLV8vGApjwYFvo fg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2302aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJWws023940;
        Tue, 7 Nov 2023 21:58:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w241fjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdLJHAyspE0EhQsAOTFbiKy6839fzqUfK3paYokdZ+F6d9jZ7pxlXVoGGGZeikxSr46jS1ZrJlO//F1TLyZkMRJx/55nEXch5lrJUYWgS+uvoWziooUp6URIPNXKSrqInn1JoxuaT9G+QM1kuMyyvctyptRPOyajjVzbxWlELUx5T8XxfM4tdzdjwyu+GbOBKksqbo3/DXSWBcShg7daf9Cat8gGQMPeLapfpqOIGNRTOXcFXZ1kZEFMxF8mlONY/fwZStXdTBoUcchyKrHSNiWXu6YwN/XSgWI0pHKJiZSLunAZiFSqpVXHCCk0WJScjGkZ7AgvxTAUdwnPHoZoOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKRDx+uw2jyDRgUp71qjdHwT8NWG/kxW3t5ad5n6A4A=;
 b=BqPQIunDol2XTAQFTCNdTp9OTtw/4dZh9gJ48KlKcdILohePCBQql7iJQksCZ+gFIIPRZ1/izTPrtXixp0DNdibuc/01jeweA4AcHtZ3Kjfute59ug+bwY52bpBfnOwIRxHqTCrob7CA2XOOFmP/fNtCB+7/5aKcZ5qoas9TU6k1G8McEKFD8y39wYYKDAxKeaqtKhjFsR3OlO1+J5GmbAgWFPIU8RtHGPbBAC1qgOKsy7ki5+I3+pEhzHDDnhG5RRFuuU45TZJuTTXhSdR7QXNqUCjMz95pH+/VwrzRZHx7rRhCq90HWbzq5KSiJnNVAsxtYwPBCxHg/KkFofA09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKRDx+uw2jyDRgUp71qjdHwT8NWG/kxW3t5ad5n6A4A=;
 b=oY5tJreq6VeMQHQM/wxX+zYDL+6lqjSfq6KSbBRPigwkXsrZ2FM6h0QfZ0LUJIxT5I+ydmPlvNIyuGPpyrcOwP4t8PWpUlqpZk+3rreaYRQqweGMWx8c7OVwHcTDAs9orJzJ1Mblj6x7KITDMfOAW18S9wPCLPKR65krOAUFq2I=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5048.namprd10.prod.outlook.com (2603:10b6:408:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 21:58:43 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:58:43 +0000
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
Subject: [RFC PATCH 20/86] Revert "static_call: Relax static_call_update() function argument type"
Date:   Tue,  7 Nov 2023 13:57:06 -0800
Message-Id: <20231107215742.363031-21-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0195.namprd04.prod.outlook.com
 (2603:10b6:303:86::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 532b585b-b3fc-4425-270d-08dbdfdcb52c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yf4xMFmLFiK3DShR4B9LmDnoIdNppEoP18SvtFDC8M1IUSxBMh+yaB5EP06/ac7JUgR4o0rcO6HoHXC+Pvz81WZps/fN+cIvq+FyZeMa4tv5U7DJ+kibp7VejbRxFkLGHScrcWAR7wRoFbOwoXbk1B6Obz2cqKBVVnylOexXeFDCfxyauCU7Lp0Ca5r4aRCt4OeaDsPdg/XwXodL5E0XcW6wQ01Wjs9S3nb9PdXqA8PItsaHQnLIlEhS5CFdp5oME6bsShjCG9oBZdQahnJp+c0fAFlam83G6jUKZD+0z9bBwc3jissjJf3Dl1O/SCkt8+p2GSO3T0xe5FQ5+g2yZD/80T4fAPO7bX8s1f9EBB5C4sbO3UIRCQJ/ZfJHXfcSTOD27Q7uI/m1sYKJhIM+SZAseYGMqWw+t+Mxe9vPyMjnwWf/3TmrQRhGu5UAjpTDT5QgxPik0nn4Whrp3mIOYq8U1ZhSDvNjJGil/2lggZc2FaDIlO5e49YGMCpfju/iLYd3atriMrQwcgLFMyhfQJ6aiVwFw444exmWZ7jZLVrQAFJlqg5Pen4WOHWTT+E6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8936002)(4326008)(8676002)(66476007)(66556008)(316002)(6916009)(66946007)(41300700001)(103116003)(2906002)(86362001)(7406005)(7416002)(5660300002)(83380400001)(107886003)(2616005)(26005)(1076003)(38100700002)(36756003)(478600001)(6512007)(6486002)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iVI8N7LDCvyKXab/Zsn8eqwbDpdIc3L/dqdLxCDcxIzNyqqqS4M5HFsM5Zks?=
 =?us-ascii?Q?1b68/tYQVVFaQQ7jDPWqsHNaY28g3jhyOwEtxKrRZSPAYzME/lxRwGG+RLD6?=
 =?us-ascii?Q?BO0aNSCUr9Bt2lAj1QGLZLYUqQz/SsEiwXLSziVTyG2ZKX6DewkZu6BzPdiO?=
 =?us-ascii?Q?ovPHyl57hSM2iSgtSS77TtIL3DpW/x2OmeTA8ES2XdAHDrgIrVyxfG8SX13+?=
 =?us-ascii?Q?VkZ8l+c5ptpL+DMYY6xIlcO726yfh1Aaxv8ZCZwLHrtfSQGwaKEdY1w0mFrc?=
 =?us-ascii?Q?sbqwB1DZpVOMBWDLYxyus9reTft1Ym4h9X6jlnhp7QkFX0o95pR+qYvUiX7e?=
 =?us-ascii?Q?plo4Yj+7BPU0I3OrTwhagKEixcRw3tcXA0SCLoWN45OZ6ok8rx0EJfOTTAsi?=
 =?us-ascii?Q?Il13WV2cDf7OLdS/YJw0g/He41x1q+ibszBuEKDX5WRmosFiQspizn9YZVix?=
 =?us-ascii?Q?iocq+tDs1qfepyGJ9aXIZBI8fMJoeKZClRXgOUyAc1R+cGWruvnjocQ4o3XJ?=
 =?us-ascii?Q?0kDjelpqAHOcQZCrDSI0yiL+SDcQHy4UZi6qzKJnU3ARU9V8raugbrOvpFhv?=
 =?us-ascii?Q?GYUe+uXpSYmX0J0kUFSCwJQkvoVnugDcO+xQ+URpkG0KHa+Jw8/w3j3eOZa2?=
 =?us-ascii?Q?0sIVusEUpisHt+tWNImkGoYHxVi9V76JNpvb/Cq9aIXpt9swgS652Q8egz0v?=
 =?us-ascii?Q?qCSxuA5ZPP2NetFRi04o70d4QudynXi1xKA8/vg1LVbeD5AQm3fY1RFd/pY6?=
 =?us-ascii?Q?6meAnrhLKYHBbPQUlXpI8Afxxkxe1IWHddnFrt388jqnY8+G/DZ3RLjhEZvt?=
 =?us-ascii?Q?IdSLX6a54b03bLiXKI/pDUkK0sK+YfM9NF2VGALWhkBA4fgwEJ4rQM5xRbsF?=
 =?us-ascii?Q?NnEfewO8QkVkK+Eff8yqqmxj7yqlY7IjucyURYiXCR82rNHH1voKt10NiKuf?=
 =?us-ascii?Q?h2DRxF8hDJu21OqM3Ag4FH0WBSzNIQ0Cik0KZQhJQvDDqn3yQJATHKoDwdxm?=
 =?us-ascii?Q?ue4LmkkGNsLSDGKYLoHYjMljdcql5hd+KhtbUIRJtgmVox/C69o2Uk2TUHa/?=
 =?us-ascii?Q?jLxHQjgTxT3ptw3Cd0bq4jBQFWRkzkLU/Rv8eClWX+RuGP6vG3p4ee4Pn6uF?=
 =?us-ascii?Q?EQImNe/bFpdO1EHitmft11e8h34jFwImMe3jMtK7EGB8k7HhNfklf+iTMRs+?=
 =?us-ascii?Q?IaFQN3drOXcY6EFrlFNpJ2RiCqBi9GbbMHBwml3xa0XIY/g4tbhJgIFGOGrp?=
 =?us-ascii?Q?CjeNtfCNUMkZ/Rat8zmlnLW5otXLY1huLKJzIZePAMqoFW248RZ/vZEEE80m?=
 =?us-ascii?Q?O5nElgEVH+jywBg3MVYuue2GtZagCKooMXo76c99RycYeXfz2UDHUQ7AAdCs?=
 =?us-ascii?Q?plu92hWcdY/LUlCa0712JEstlK0kLAUWTOme3CYwCzqg14VQshAyXrOUpske?=
 =?us-ascii?Q?BJ5VtfPMrb6BTMZXPh3cj43OK5KIOth1GB7IfatvTTZJma4Siw/aU/B3g6m0?=
 =?us-ascii?Q?H6d8r0ri7GGVKW8Urvn7ZB+oZv87uoXB+pyy9nq7vrFiG5dtvNw3u8e0idRr?=
 =?us-ascii?Q?PBb0iFss2YWG2Rr4Yf1sJhIFrtVX9boITckNnX/Z8tC3dCQBG1RRMG+pAZgY?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?FbG4+Hi6PEYRpDIWFqcHDrSvJL3VrzbmrcVLsWCQS3tYNC4yFBDa/db9JQmi?=
 =?us-ascii?Q?SVRfCfYtrz8+8Z7z5+rCkYkYTva63KOvDGjh7n/WfIAykfWMHs8u+/p0817y?=
 =?us-ascii?Q?+htnW+0Rzkpy17LnKlRM7Q0XrUyPjOD6a5ldlx7xuRIHFay89Lru9xKcDPu+?=
 =?us-ascii?Q?4fgPakivGI2h6IlZsbdtbF1y5+LrE1R3qrpX10uQZ2eKpjarV+CJ0NzeURtT?=
 =?us-ascii?Q?pL2fQwU+2A+a9WHfLIAzdIQSPBC06bjhmypRvIk1/5lVkEbkfWDzo1W0KbIk?=
 =?us-ascii?Q?BgaDkxmJmpkKoGX4txHeWpGJALQgOdYYFVBAedd7KmySrssMY1Wrw0rxzVW4?=
 =?us-ascii?Q?qK3UZz5nasmT5sVHlU0QkkC3tPmIbLjaU7n2yBlcQarBMTS2zHl1gcL/ot6W?=
 =?us-ascii?Q?E6f/JbiFoTRJlx51rtLfkEsfKww7PwJX3iHvLbrMJNOJJplk3qEjpCQ22xWw?=
 =?us-ascii?Q?eac11JuHLNynOzAPRfeJaJ1tLbl6kaHM1B10HyhXnuLPgPAUltltKygKmvuU?=
 =?us-ascii?Q?PLuaE9egnL6C8RWRNodS8UQrSjxFL7lQNV1URCjHtCfQDhH+k1unMJQ/1gSQ?=
 =?us-ascii?Q?mkj4hzSjsVfaWwkJOaAyOaYQAnhm8sh8OOjD0W0qlE7SYVEA2Va2LwNN1dT8?=
 =?us-ascii?Q?F7PYeJ5nDEQVMPU2aQqiATuFcy2RqqujO0lLU+BrkXGHj2K1rPxeqTC6Ythi?=
 =?us-ascii?Q?FSXdTQW4EPMnQ6USkdjVM+/2pgHAP5Psd/MUHyfn8HarTWCn+MTQK2wEqRuA?=
 =?us-ascii?Q?4PtLgtf7IEbAr4htizeux1GHydpMEO8VCryOK+FWKp6WaYUjXNsJNvvF8lqD?=
 =?us-ascii?Q?lLtYhw/yLX3opkbX9elNxBAFEPSAa+o/0xpi31amFBCdBA4Ee8RVqo6oneLP?=
 =?us-ascii?Q?gY5oczmQR4tXINMf1Eph15/qrqWhz5jZr465om0C8FKst0YBS/kcl3Dn+dh4?=
 =?us-ascii?Q?5Et5lPy1Fye4J5a/eOgshMUY8VdEJ5wa8tL9GmoSRXutRYatdjEDT67wjHGh?=
 =?us-ascii?Q?y0bdMKtEG4nL3eEi2I/2e6NhqIZOciM6cFYL6uXllf+1cUYYKS2Ypgkx9ljW?=
 =?us-ascii?Q?CtpOwZvTvd8oBs/DStvydu9ib8fNXCZzSMwdA3vcELRSk+6pucLqxj2hF6KH?=
 =?us-ascii?Q?jTqii+txYW9JXApugpN/boohTbYdi6YsnsCR7uoZNqwWd5NIzDQPaLHRCMKf?=
 =?us-ascii?Q?67phUmTydgohV8nOdWeudGiMgDfDxkAmftdbwRIRAOBFDZK+Dxu6jKH2yIIZ?=
 =?us-ascii?Q?HB1PHZHDrBJe4BC8PTQcOMfe86JdrUQ8bHIeYbzcToeUUKD+mIPEUvA2dayP?=
 =?us-ascii?Q?Jfyens7Q9kP4gDhtrPocDq1JAUuvlFJX52UIUUwibUGlLEzpwr7Si1oO5HoT?=
 =?us-ascii?Q?BtbkaYC8BirgI0I2O+dF4xcErSe9V9F2amxrW9i8TSOJOtWmtojsI/fdxxlI?=
 =?us-ascii?Q?ii1Ox4M5dIMfxz3lFwsITHqvXwVuMFd6c4bKcTv5IlmOf/cDwqY1q/ekE5TP?=
 =?us-ascii?Q?hIGpyy32zHoUWclgdJKxpqLmROsvwwEz2LazjIK41Qbo65PcYXjLB2dgQA?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532b585b-b3fc-4425-270d-08dbdfdcb52c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:58:43.0906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9nuEOnf6vkSt4J8EItg2d2lx2F8rh8Un51sEwch5QB9i086pEHJV5pxqUoX7Q1QnNeuiu+rLZujYeBs4yi9+Gf6YvluBNKvGi5pwpf7CWwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070182
X-Proofpoint-GUID: UVGXckBUdH_1Q8sPGEAs3KcQ8aoyAwzU
X-Proofpoint-ORIG-GUID: UVGXckBUdH_1Q8sPGEAs3KcQ8aoyAwzU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a partial revert of commit 9432bbd969c667fc9c4b1c140c5a745ff2a7b540.

We keep the static_call_update() type matching logic which is used
elsewhere.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index abc95dfe0ab4..e0bbc2b0b11e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7027,25 +7027,25 @@ static void sched_dynamic_update(int mode)
 	switch (mode) {
 	case preempt_dynamic_none:
 		static_call_update(cond_resched, __cond_resched);
-		static_call_update(might_resched, (void *)&__static_call_return0);
-		static_call_update(preempt_schedule, NULL);
-		static_call_update(preempt_schedule_notrace, NULL);
-		static_call_update(irqentry_exit_cond_resched, NULL);
+		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
+		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
+		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
+		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
 		pr_info("Dynamic Preempt: none\n");
 		break;
 
 	case preempt_dynamic_voluntary:
 		static_call_update(cond_resched, __cond_resched);
 		static_call_update(might_resched, __cond_resched);
-		static_call_update(preempt_schedule, NULL);
-		static_call_update(preempt_schedule_notrace, NULL);
-		static_call_update(irqentry_exit_cond_resched, NULL);
+		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
+		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
+		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
 		pr_info("Dynamic Preempt: voluntary\n");
 		break;
 
 	case preempt_dynamic_full:
-		static_call_update(cond_resched, (void *)&__static_call_return0);
-		static_call_update(might_resched, (void *)&__static_call_return0);
+		static_call_update(cond_resched, (typeof(&__cond_resched)) __static_call_return0);
+		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
 		static_call_update(preempt_schedule, __preempt_schedule_func);
 		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
 		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
-- 
2.31.1

