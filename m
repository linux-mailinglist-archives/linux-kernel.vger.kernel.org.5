Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40427E4B9E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjKGWVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbjKGWVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:21:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9776C3AB8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:01:30 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJQ9H014468;
        Tue, 7 Nov 2023 22:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=e/s78Q0cIAeUu7C8BHyZikkXhbxwwbevLSilCf+E3nM=;
 b=2p1Mugt3V654BvWLhjjk3KRjMWyBEBuo8JB2k/UTUPl7nISU2k0LyBh1OcOTtI4HUbe6
 vjBXSRKYSSK83gCceyC2MK/uGeFoOCML/oV82ZJgCLF6kg973/zvGQNwhQAWC1JqQGHK
 7zMrIFUm41pU8g6DXljD0V4YnxQKSx1oMokCch1juhdjzzq3yhWjA2qBZbX+wykdiPJS
 vSZ3BzVrcheALNNw3yUUtF7niHcR2c1NV58tBmPm5MsVET5lNwaxX2kVf3VcmIueBQSt
 B2HRpBhvqWhcEl3YJ3o+cr5vWKBwCbRyTLtO0N/YUZkjaJq+CpkRif4/kj7RjzhuoJhb UA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w26r2fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIgdR011085;
        Tue, 7 Nov 2023 22:00:26 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1tskeh-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzSFR0T5iVurd8peUNAs2roUn7IlkEDJJd0p+0Mop2gcH5gra/4F8Z20SbNMcrZdU+rPxDdabFsSBMnrAnW+gsiheLO8gU7L1LkSIUAwXyS63LL5OGap3ObYTCQP7MW6Ijl8DxdNU48FXKXPbGEf0CE2lbb3qO9tOVw8vSNVS97a7BIV72HbIQgDe/fz6rzosr6SBfzVUi/7vsxqMdRXuK1CPd96Qb4Y2WN5RO75Rl24P2gllZzhTMCUUUGrA8ABTjMY3fuAAMOAPnD2evuc//3NBPyk0AxVkj8kcPUEps5bhGNRKaheOP9ApPfmpetwX38lm7suxWiWG8K/IDBzCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/s78Q0cIAeUu7C8BHyZikkXhbxwwbevLSilCf+E3nM=;
 b=beFkGc6dwpQ6ck2tv8dcaM8f4LpTLpnq6hyadw0Hoynt1ZIKzvseuy1wQpQKTFApLrG2Gx2dbY7+yftaPsxymRadsSBh/+CoBdwJx5pu/5TnJh+4XiO8sn7BXox6NAsVBzbbLoQ/ffsLgz3H/RX82WA6wvyalmZGyTePfJT0DHSOfM9I5WAhnYgflrcrQxNO0C81wxTDJAE/G1DU/4UxUNh8s28B9Hwr2omFWZXcJzD3xThWVXFGjqJ91/WM+SLthY1cNCd8dd3e+LHYjBDnzxMdYNRWU6PFZahhv/Lnk/O1NuENoJzLoNKFnLo1TSSmfJaRoa7pwNmA1/0jYVa0rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/s78Q0cIAeUu7C8BHyZikkXhbxwwbevLSilCf+E3nM=;
 b=ga8lMrZ7taDnOZQHksofO1/LFnnn9thKl2y7Fe5v8Zh3Ggy41y+5yAfSvTOxrB6NnvMyDSSCSBdzptJYXgbGzxyEqmorjN8eZ8tj/ZgW3l0cJltqfwfcX4Bz/EKOYfa8aPJtyQSmJRvoI+4YudUdLczLCLNm9UdVkcmjnVtBhLE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6275.namprd10.prod.outlook.com (2603:10b6:510:211::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 22:00:15 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 22:00:14 +0000
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
Subject: [RFC PATCH 50/86] rcu: TASKS_RCU does not need to depend on PREEMPTION
Date:   Tue,  7 Nov 2023 13:57:36 -0800
Message-Id: <20231107215742.363031-51-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:303:b6::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 34127c0c-eb61-479f-b627-08dbdfdcebda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/aEkEkKkiQ52ESldTybzDDLxqrbNI/PpLWzq1Q64sLQIu+EOesrEoNfxp6tYvBIHx3OM/pZYQgDEJW1Ma7s5yXhNuYx4VHpNJLsfCaJJJYMM3dXG8Yo8SdcRGm9IvZh1sP0v88vMQ16aKvwSwHGuQ/EVf/0cVbpS8pnPBBqAv23oZJ2kqZzya+7wAbPKdeoiDyiyqxoREZVa85Mosr4l1M6xj0TpW8xEy4DCt4OgxUZVqQ+4Vq9RAlv1VSADIV9sijSkk1rd83z2VZzKA0Bl/54g4NhLJg8lMqOB8LI0EWG34SHX9sQmkO/dtaMGYhHSpbc04q/xWGAzQyUUvyp3DoAfww/jtq64IpAQU3Bv9/B2aGHVnog8AOTbQ3nO3SvVeo4pjq1/uHoHob2l/jXbEqdfojthpvzBIBZxvOPBMx+sbIChy2GZSXvw+wBapZ0x2sN0MCK2CqS+ajggoT4U28r59MSkj2vNaFU99FWemAo03fsDXOGuj/TGI8pJHdrEUBDeEGZ6x8TQ7qcP6DrwbPA9a4omZvQm8ObIdGjYLERZWzk4/TZxyE1OOrdY1Ep
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66476007)(6666004)(38100700002)(6916009)(6506007)(316002)(66556008)(36756003)(5660300002)(7416002)(7406005)(41300700001)(66946007)(6512007)(103116003)(1076003)(8936002)(8676002)(4326008)(26005)(6486002)(107886003)(2616005)(2906002)(83380400001)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AMLm5WtQ4rgmtF/dB55CDlVNBcr+aqZcgSAH2aZ4zVO5UkjAug1E2coPzH8q?=
 =?us-ascii?Q?biQkpz1+PaosETppFQ3xdZmB7uTwkO86Vc8QAJ1bk2qYjqPWO8gqVJXUXZMm?=
 =?us-ascii?Q?Ol12vJpKrN0/yIx7qAn19L02yQYqvFmcH99bZE5sPoOdlA632ouXwmZEhkfp?=
 =?us-ascii?Q?Z2e5lTqIu4a7QzjS6KLww96FEXry9Yt8ALW6Qn3vdQ3XjBeHCbQbCasHJb4c?=
 =?us-ascii?Q?LXH/uymSDg7QZEo9J7rLuIn7YlOWpdN2fvW3KLvpEKZqcuxiA0/uGvQgDmL5?=
 =?us-ascii?Q?ThXd0Ar8HWgSdKlWnTdHpSBxHJreyALs8jNux4vUmcxLg8Q7eU6Tj1v8FNX+?=
 =?us-ascii?Q?pF89BSEubaB77PoAkjEN+DbQpsu3h/WCWCYAduXRuTgx9U/iC4cpa5KL9qwI?=
 =?us-ascii?Q?w/8egxtPXEBESmdwEtcKJgsbcadJIz8X56SzOYTe8nIxprZXrrKW5DxsI65e?=
 =?us-ascii?Q?2yMb638sYaNitXEI9TNIGeP8oHUe5U0BBW2ko+yqtJB6QuC9f3P9dUCNSsjz?=
 =?us-ascii?Q?0A3IKfJusQZObnevG6kRhEgdppQMhb0YJVxvUSrONCLUPNlyequoFmhds3aM?=
 =?us-ascii?Q?bTAPTwu03B48efz2U/nX1fWSJZXDDA2SDSU7lb4M3bwUbkHFCYFtqALuSI54?=
 =?us-ascii?Q?KM4vTSzupbJujwlH6YsmVMrKrZ4EMX5DlNH2hPqaPbfyxuZJoBqf4cREcq/p?=
 =?us-ascii?Q?b7VG8llCY1sWc6pB693+dCXMo7y+rAZJ0u+ILFf2DJzeimc0LQIbsbkAR8qZ?=
 =?us-ascii?Q?PUMZ7rpDhx7chDQ4luKfbyX1AFIwlxY10Pv/khEnk1TVvfCOmOnk6X//yHrp?=
 =?us-ascii?Q?ajlfN+7bYLzwvLHZQLo4VzMa1Ex4d1EqD+qhZgoWVZxvA2cVoO9DWTbOBlqw?=
 =?us-ascii?Q?Mwlg5VIWUzwtfihhejGW/ZpYfjlg4PboU6Uiw2Kg7DHzlhFmeDybeb5RVbZR?=
 =?us-ascii?Q?nzWVc5fC3Fg5rYk8gpnyy/qC73qYzaQGk1e/hbIxogi94CCJPRqzFE9j8zAp?=
 =?us-ascii?Q?RVlE1S/AqT8CpQueZeR3aDzBsChV9Rig+tRCqoCbkJMTCIfAwuH7uX2ZOUGu?=
 =?us-ascii?Q?6+RnPOooMZJosEcu3MgpHROWeRoBTh3t4YVKTQF5vQPL+bhUTuCCN3vo7+fI?=
 =?us-ascii?Q?TC0hWR9Li2fOgTcdF1lwl6sBZqEAc0UHhN9k083/2yGhJCND0W0qtzzpdVJL?=
 =?us-ascii?Q?1ne3QkB+bo/0cYa3HmoEleMvNNBq0mp95nJnlohXXPGa9Lf24vhQ7RZfIzK0?=
 =?us-ascii?Q?ShlqiH0+wUeaKFBcGA8T+LTLO4imTQTRjMtnRIStqD47hWZe1LQsPalnPQeW?=
 =?us-ascii?Q?NugXVScKyD+4NhhxuJ4RNS9Z5rB4Zeq74RyOY0zsFhe02uLXVQe9kOw+u6Zg?=
 =?us-ascii?Q?hWt41hh1dcKDNloAwAHgSMKLFonJGjyLEAyoO9LniRk/lwlJHFCfmxKm7vSp?=
 =?us-ascii?Q?sT+Mq7lC3+nlkRJvu0Xn2zRdmvBWmbU7t4KI6MetnfU3Cl6QZZsUXP3vRGov?=
 =?us-ascii?Q?a48H9wUbgCsjzHGWRRfAx4QMDRjCRwr7uIz8uAetZc0wJQxUoFDWmdZdFgye?=
 =?us-ascii?Q?vxul+ScoNn+O3nQM5X0wC6fGLK8+dNAidDheYSBvKKT/TtywALa6GhQ/KLOJ?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?H9p9Yn3asuw4qP6WnTuXAuCPIsCzVSu7kam5cKWbgaeD9es9zIwFrvhKrYOa?=
 =?us-ascii?Q?UjMqWRIiWB8sgB6sLUrOJ/v6efuq5E6fOIAPmYHoUy7G2JWVSQcvePQjj8mD?=
 =?us-ascii?Q?OJmj2FUvhKSzNwPlh+CpNLeD+S70KuVniktGo528+qkR68snz6X0Qs3i+4dZ?=
 =?us-ascii?Q?e5oyCgCGc8uuKfE+oPiGtkoHZe862LSWpxsbM5nx1SXcAg/HPuro4+qqQeuF?=
 =?us-ascii?Q?a5zm2NeSLzbQ9GOvQBz5Dp/a8VGtAIf4NBbUbBhMKsccbCyxXLORLfd1It8J?=
 =?us-ascii?Q?0OlzrIxXhM+tWYCih/Ir319Bv9Iu7BwhL3w7LWriVFhcMF463YvGlCmbeI52?=
 =?us-ascii?Q?mG6sKHm6TK4iZa4emoPo6+5H/+HRpM/d8fxheHApswteoA5lxmikAETLPioU?=
 =?us-ascii?Q?eRdIg1m5wAHZnn9hrdRvax4YGayMSx9WjlhCWyh1lWyf8ZVDba380AfwlyM6?=
 =?us-ascii?Q?B5JZlZPDGWtRliiIgpWMHNMqaa1lWAOLStOjo+lwhL8SdIASwZMtVIuyJg89?=
 =?us-ascii?Q?Qv8ndkBcuJn9FU6vkvz2cUnUithlSquKPuIjFi6vqSai5L2A/Baz4JOtaEHT?=
 =?us-ascii?Q?8jgt+Sr+siXX9M8RjAJf4cxVjLmHltDSr1zKKpkrHdW9w6BlgP/SY+uR0X+Q?=
 =?us-ascii?Q?ntHCorEea/hEenQ9bVabsR+bwgkPxKSiN8og0trDxO08RJ6r1lRXcUSLOkfC?=
 =?us-ascii?Q?N51wP5fxgSlQ8wLYrUBuwGYvflGf27f8kbv28W/ZGW6YCZhZPlbrmcxsr1Tk?=
 =?us-ascii?Q?HRgWFeNK64bsq9qIXxJOBjbrMUxgap4aOAi0PwQZXztSiCVdr21gU1UsPkP/?=
 =?us-ascii?Q?olIW03LHBgbva0ADXmAzOAKs0yebbIcLrdqvSXBFHmYvb7q/qyPyuQAUd7ez?=
 =?us-ascii?Q?IYuSYMpboFiig7nHmJgn18l/iqWjixfcsNcjw7jQT4b8t3fQfGPXXLt2vcvw?=
 =?us-ascii?Q?7A9giwh9YRbz79t9xJjhiklnOMmVFskimpR/YTbAR74G3tSKil358EStLNAL?=
 =?us-ascii?Q?f9I2g/WYsJJ58UhfxXJV+89dLTCDuPFEB7IgjEL+DGqZ/t5v9hgjhDSZXjcw?=
 =?us-ascii?Q?vPKvjPwmsGk4Ern14y3GpIJSV/Z2vT3LSraNYSyZuySwrWPIY1aPMnkBYePw?=
 =?us-ascii?Q?TMShv84rEicv5VbYNgdQQq2EUtrthRUM12DREz8SnZDrZ21JtxSSFvjBQrbC?=
 =?us-ascii?Q?XllKykpVKhwFmdG4vSvPVCXKNZzIsgummHoAdE1NNdfsMWjEn9loJshmdTNE?=
 =?us-ascii?Q?lrTrEAVooHz5iZrmTD6r1iaEOrsEcig5Sw4WRu6uXc7ijhHsyCa6eQEZiuMU?=
 =?us-ascii?Q?ShEMsKxFvFMbbsYXGVRCVYOjj49SKPPDyMImZkYZ6wxBVaXbf72okT0hSJqV?=
 =?us-ascii?Q?YDswLQ73Y1Cjn281kPeTRYiBoYuUoqiA3I9AZ15jWbY3HkivqzufbuhKd4rN?=
 =?us-ascii?Q?AG5dvaFfJWyPXxrMbulEdEAUf1zBQ2GyIYawvixcCWtL5L18V7eXZ/4kztr4?=
 =?us-ascii?Q?sLskWEa+aHCOLulXP5+rL1IdCDl2DMN1AxQuev2v/9CuhShp/tGtfrkqPQ?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34127c0c-eb61-479f-b627-08dbdfdcebda
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 22:00:14.7199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HJhIJHpp7Wwg6oHfU2X97uT0i7UvUC0An0IX5MsFOxStl0i9Wz82NEU3NdajfchC5HzITOwWekBvk6UJ+opxskGpNXXl/7zaYeUcYmw2Ak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6275
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: 8T6UtcZGwHdYg-kln6NIFwyrLLVsOpCQ
X-Proofpoint-ORIG-GUID: 8T6UtcZGwHdYg-kln6NIFwyrLLVsOpCQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With PREEMPTION being always enabled, we don't need TASKS_RCU
to be explicitly conditioned on it.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/Kconfig             | 4 ++--
 include/linux/rcupdate.h | 4 ----
 kernel/bpf/Kconfig       | 2 +-
 kernel/trace/Kconfig     | 4 ++--
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 05ce60036ecc..f5179b24072c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -55,7 +55,7 @@ config KPROBES
 	depends on MODULES
 	depends on HAVE_KPROBES
 	select KALLSYMS
-	select TASKS_RCU if PREEMPTION
+	select TASKS_RCU
 	help
 	  Kprobes allows you to trap at almost any kernel address and
 	  execute a callback function.  register_kprobe() establishes
@@ -104,7 +104,7 @@ config STATIC_CALL_SELFTEST
 config OPTPROBES
 	def_bool y
 	depends on KPROBES && HAVE_OPTPROBES
-	select TASKS_RCU if PREEMPTION
+	select TASKS_RCU
 
 config KPROBES_ON_FTRACE
 	def_bool y
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5e5f920ade90..7246ee602b0b 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -171,10 +171,6 @@ static inline void rcu_nocb_flush_deferred_wakeup(void) { }
 	} while (0)
 void call_rcu_tasks(struct rcu_head *head, rcu_callback_t func);
 void synchronize_rcu_tasks(void);
-# else
-# define rcu_tasks_classic_qs(t, preempt) do { } while (0)
-# define call_rcu_tasks call_rcu
-# define synchronize_rcu_tasks synchronize_rcu
 # endif
 
 # ifdef CONFIG_TASKS_TRACE_RCU
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index 6a906ff93006..e3231b28e2a0 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -27,7 +27,7 @@ config BPF_SYSCALL
 	bool "Enable bpf() system call"
 	select BPF
 	select IRQ_WORK
-	select TASKS_RCU if PREEMPTION
+	select TASKS_RCU
 	select TASKS_TRACE_RCU
 	select BINARY_PRINTF
 	select NET_SOCK_MSG if NET
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 61c541c36596..e090387b1c2d 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -163,7 +163,7 @@ config TRACING
 	select BINARY_PRINTF
 	select EVENT_TRACING
 	select TRACE_CLOCK
-	select TASKS_RCU if PREEMPTION
+	select TASKS_RCU
 
 config GENERIC_TRACER
 	bool
@@ -204,7 +204,7 @@ config FUNCTION_TRACER
 	select GENERIC_TRACER
 	select CONTEXT_SWITCH_TRACER
 	select GLOB
-	select TASKS_RCU if PREEMPTION
+	select TASKS_RCU
 	select TASKS_RUDE_RCU
 	help
 	  Enable the kernel to trace every kernel function. This is done
-- 
2.31.1

