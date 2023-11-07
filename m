Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657817E4B47
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbjKGWAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjKGV7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:59:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E6710EA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:31 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LKCxM023477;
        Tue, 7 Nov 2023 21:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=wu+VhJ2pO1Rmf+cHLS8LckYKrJRdEsszQoPirKlYAKc=;
 b=eCzIHvo5uPpWQ/fdbpt+M2Iyq3FSVYWpIZAW2xlraj7tlxOu7rNDpNeX84L8sw+jM42R
 +dp8sj6/DFTNmYZ1a+llaYMh6teerNspI+533WjqVOdEWzLFi0vw9nVIf3pOJjPGl0Xr
 ofFdeR4cLAeQpxEHRxMcQXPShA6xaSAZsiCJWPsMSyFLt2d//mZc/eRvl731O/lrWj71
 CJWPu5BLwJXb1pZMqo5CIqX5Nu2qkcRXQSuH/2KuzuZlslyVx7AAqrC82qsmO112Flip
 JAfdJgNwHlmgUPvisxDpa/w27HO6PNmgtB7b8SQX538lNo7gfJ8BAydea5KY1iOUtyyh lA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2002ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:57:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJ1HY000739;
        Tue, 7 Nov 2023 21:57:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wsjd2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:57:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXinPCtEgUz3Of4k6r5tsOoGG17bgPKdOKvjuCO0G2n+2+u1QpgBaFr/DnHBV95LgHSBrx0//a+NawfEiIaAZlsUHDGXKbQM4tO4dmyfIDAsJofQtTmSH82yNaFNPNE012Z5LizuK3A33Wl2HQxstGdOu/I9k8t0Dt3bQXjBmbHPsvwuoQMO9XiKElZTm8WxF35yebk5s5GuIF5ZvRd3TKtTHFvEEhttcoROZxCzIQLGIl+dj8LdzRdzMjEpsn52Ebdjw2SR9kkxQ8HmVg9PN23NwrfdrN/TT5cgcYJX7lzonl70y8x/qm4t6NJs+p9AoraZLrpdNgFYXrklhNnxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wu+VhJ2pO1Rmf+cHLS8LckYKrJRdEsszQoPirKlYAKc=;
 b=j8Wv40y+GAkAmlnp6x8f1Vbkz8Ll2K0ekJnBg+8u/yQL//i97ud7KB0wiXekoJxO1WT503ZinIZhpYw2hbqv13HFHpXoIsULFJAPkgUAvOX0cwx1RZDJgCWVtujcSwczahyaU2PlURa3EGOd5xSkwQv8lfaSYto+f1tJD2MnnVulOUBdEpl3gidZfzeT8A57Qq2nR7Y3q6Xbp5bYWWhVXeyB7zEYrYAgJ+kVvlNaCo5mpYy1eZsGUZ9MwsDkpURRnMOpxkjxT62uVDnKfWPE0AXMqgGczwtQFuHLCMrsZW6M4GsCNaIXoO/5W+9zkODVyNdgSqAX03+fPe+Y/624xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wu+VhJ2pO1Rmf+cHLS8LckYKrJRdEsszQoPirKlYAKc=;
 b=Ij4C+Tg0/ncO3XleUZKsh43KqzlavLAratDYrl1c/aUUW0J6YcN7oDGBQYCv/ysD0Xy5AqTlYZGJ1cgOnt0JdgrhofohFATyATffSMMzyiXCwOIsKE6TigvwXTu/5Z7ST0WwpFfPg+0YsUP2T0GETP3eIg31pf6VrBkVpR+4hEw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYYPR10MB7651.namprd10.prod.outlook.com (2603:10b6:930:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 7 Nov
 2023 21:57:46 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:57:46 +0000
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
Subject: [RFC PATCH 01/86] Revert "riscv: support PREEMPT_DYNAMIC with static keys"
Date:   Tue,  7 Nov 2023 13:56:47 -0800
Message-Id: <20231107215742.363031-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYYPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 072ae498-3762-4139-efc1-08dbdfdc935c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+UYf5igqcXQyAZGxFtkYpvM3kwzH8JqEVue1tcsbyyBW5tWlb+LkKujZWwbhLj0DBFKTKY+QJ6U6apU41F0+wAAVQNmhQuxXBf3kNZ/Ioz6gBiL4oxSZThr+khtHkwthIzlBg0IU2s4zbxZ/scaecV7Xl7TqTtdCsQk4UWPNySDtWTZ6Eh8MIbZQWzYiUyf4K5SReqPrW7BMgBrLzggF70hpiuUWWMqGtva1q5xOx7n7gbnbJ7CjWG1lIdRcXB1Ic2fB0fwgE7t/okzO1TwUWa/YcPplrgKBT57QVE1R03m59KO8xR3LnldQtJwe/paw67hcPnIoM2wSAWdQJs7QZc3BQ5vQ/hstaUa1GKW2o15bFcuKE3vcgoYLO0udH6F/Wazg8mlkhRUN4mRX6PRpP6sA7n305APR1djhSO6IWWGAoJtGb9Pi/W0eyPkfDnQcaOVLb+iwwZ13xNat/MkybmAtLCjHpq5qWIw7xCG2dafrd7J1RIExNz/s8CeqIe4R9dma6U2EzZBN2N8BDHRvvt8BcC2BFBsLsmzdFgqhQP+/qdiJkuEnpElw/nFRzw2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6916009)(41300700001)(66556008)(66946007)(83380400001)(7406005)(7416002)(66476007)(316002)(478600001)(8676002)(6486002)(2906002)(5660300002)(4326008)(8936002)(6506007)(6512007)(26005)(1076003)(38100700002)(2616005)(107886003)(86362001)(103116003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GB0itXkc6TEWyZXo1N/VEZoYxf+SvDXedFRGElBtIZJ8n+GMpUKgHD5eBScs?=
 =?us-ascii?Q?qPPa6OAwWj29WWU8UOV52SbysbbMk6gbvDbsqtt1L/tr4G/DzZI38sZqMsyb?=
 =?us-ascii?Q?9k7vE7BFY+OuDv02R/sY7mvtLTm2uogC3L+CNAY8VxLK+t34CJYtKb1Xlr+Z?=
 =?us-ascii?Q?v/n94/roAFCDqvmVbVWyl6oJernZRVgr50v7ufBJ93H8RAmpkuLeAL21EOHo?=
 =?us-ascii?Q?fTG2kBp/Hk9ayWyOPZJldHXXdH3N182A57H2yVeWeSh4jnOj0kcO1N0uUhDV?=
 =?us-ascii?Q?SIYzh6OnqkkoHoP7N/lDRJeeBoJW/gyxooQn3DgWRZg+XJHpdXKQ0QHx5waa?=
 =?us-ascii?Q?gcJjjVfx6/annP1dObcnyPrb3N/s1U8FnFrpKUtyiVGRfFI/kYI4R0AEAMpW?=
 =?us-ascii?Q?qooHfcLtUxTR9m1NgEVwtepRzbMO7ny4xCmYf12NmMB1gxQ3RtPtvswETOn+?=
 =?us-ascii?Q?MjUOANs4SOc8o/9C9YwWFUzWtIVzCuOcyH3nTj/evWZyuvgIVNUbkxXUKMuG?=
 =?us-ascii?Q?APJZjCxE4yfXbsBMXg1lcrqI8MWEvUgfPV+UHGOOq7sTVyfdd497HHIltTQy?=
 =?us-ascii?Q?M36pK5utiSYLcEDRKUhN9kyonwkpUHejrJTtdIfNZOk7gzB8cl5s77WZqT0j?=
 =?us-ascii?Q?KDjcjkp6Xo19FVMec/QY0Tg9Zi/iEA7DRhUf0DrgZqtbvX//LKdm+YBPuY09?=
 =?us-ascii?Q?xBJQ6sFB4K0De2hgs1DgAW2QgQPkLgZhbLeG3yPeATw0rIt1VmllmI1f5bQl?=
 =?us-ascii?Q?snpuy3U9IyAkqA0a/QFLz+/bUEDO8y4h/KLsHCGVPf8/8dB7Iwl/FfFBsozN?=
 =?us-ascii?Q?HqYMeSghi9IvXKsEQVKx8SoXnh7BKrI2MSlvY0f/1RS891lKiJquT8c4Kvb5?=
 =?us-ascii?Q?DaPUQZb7IVzyXjCzsVPFj0ezzJ6Oug1fy9ASAxrDyLfBUWEnQjUcmAh73q+L?=
 =?us-ascii?Q?Qyhabbon/FFdShnAZhEMMC7/2Ec9o8LG64VmToMa8hwvZKkaha8Zaj9ewQAk?=
 =?us-ascii?Q?2Fo4iteUunidDBXNMSXpnfSVdQNRyLz/iFnrpDoRHR8dUqIVAM0ZExMzvtHp?=
 =?us-ascii?Q?df5nH5iZjStUiuN2GsV2GtL6+PtdvJQ+55vN4sQE3KF5GWQYg8BV7L6KBsw5?=
 =?us-ascii?Q?hqnZeETNnZptv8BLcSwJeLJen67gPcZVqHWcBZSa6FKu3bPlFsEynC95BfjQ?=
 =?us-ascii?Q?XxdYPscdhoeiOn3ZdCApWiOvOlkfb32brMGNS4XTXF3Zq6ZR2ItGBs8jVG9g?=
 =?us-ascii?Q?o/v9kO58Co566DB5dZ8ErxogEOnBmGX8cj6QoaCEb6j5HOfAaTncHqsyAFfv?=
 =?us-ascii?Q?MqBPNz+u9Uv20PHTxvmwoVqwHWz1F5J3Yw2Q8TZ9kDoAn9sGB7muh8tbmj/V?=
 =?us-ascii?Q?1ookLvFUUQ4Md3c5YshWycNQtWA62UK+aInelY3bUMx9k+bMHSk8w0eB5qxi?=
 =?us-ascii?Q?49i9UlODSG+O68f62yEFmXNUkMrRuu1LTRNPveX06ooJlf7f+t1NEa3n2gNm?=
 =?us-ascii?Q?hkZYyAkTcgZCoHWK9N+gJiDXgm+8T0+UHMgMKi6dxr5S7UJNnQ0SFdUmsz58?=
 =?us-ascii?Q?QONYcDLvGeWagmAdpyeox+xeHTBtIkZjYOnpCUHQNFYJvEMZvlSSXr04QKz2?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?SZNmfqv+Obopl5cJ1Oj+kOtsa2B3rpmWXYU6Lon/hwPL4nePzxyIe3b2UGbx?=
 =?us-ascii?Q?aHB4criIuw+kbegOR1iXgl/cegOQF7XbmKa5uQS/oqmrjQ/T4PO3+29rmJgo?=
 =?us-ascii?Q?8TaPU6agcnCKIe3jevVOtpTwev3g0beT4sT0e8mBCXRBH19If1Lp1LmeB0on?=
 =?us-ascii?Q?PApQ6r/UbGevCL091YFRsS594+SSN11TRS2WuAa184h91GP5cbhvl/zdByiK?=
 =?us-ascii?Q?4tbWLLyHOtzwYsglQBZQWUR00CW5NvJGmr2098Cy4//BJNrXKYBu9A7+2n3U?=
 =?us-ascii?Q?jNjYE80YkntkEaCMiGF+8/mDzaRwSM/OzyxaTjhHHFCbEJYDfSIH2KW0cb0O?=
 =?us-ascii?Q?tAP87gC304FKhp4smLp3M/EWgb7hyVKZDhOd6ktAR+TuI8dmAELhAqZ1mCZC?=
 =?us-ascii?Q?ZvMFZ1YFu4QCenO/zkaXirk4MVidbKBNGSLB6msLU+1AhK5IErUbimkCqbgQ?=
 =?us-ascii?Q?agFh2VYhleSJTlE5ReaSojpQDUBUkpW82Anw/E+hCK+Z9AU7qhB3SlY4aOEH?=
 =?us-ascii?Q?1GOlk9IvPbxlbXwIaWCoLFKepZmS/FW65P/vih50DiJOsewCzryPBlb+jx//?=
 =?us-ascii?Q?1Kezz8ZHtLWjYUw9+OsRXuyYOiV0a7RPr//l+YdMC42DUTLw/ADBK+QkkgoX?=
 =?us-ascii?Q?MJcvH2VwcOHN3BPLHW+NqbpxONcW26085MxU4eKQJB3ndMHM44MUXlGblMJH?=
 =?us-ascii?Q?Nzf1nF6KEj/krvyEvJuQhdgVjH82OUWA20fy976Cy3D28JE/NX7Yjo2i/Dcz?=
 =?us-ascii?Q?TtmtkAuJMp1srCw7VSr3aFatVtYr1WpydwG3JrLBIV+zRitMRp8HDsgo24Wb?=
 =?us-ascii?Q?HXrd2tOZywHHktcKHI7Y+h1zt15LTbiC/Wecwt9o82/6j7cxhyuQbiEPpS/r?=
 =?us-ascii?Q?8rMcUN0b1eQo8SOk5JJL5SHrkMsaNNlqre7JZCsFCxM8VfSZtw2R2w3nFNIH?=
 =?us-ascii?Q?ET37HQv9mEZs88297wPHyEF1Z8x0bIAeWTk6y2p6w81tc3tikMV4qx786RyD?=
 =?us-ascii?Q?kBwW/8TfepYe7yEuhL19BAV5u3nPt6kfK2eiQXONX5xIjQH+9qq2bsXTr3vs?=
 =?us-ascii?Q?kRq/UaXZxwiZZoqnivl73KYQFhHw5Ey866V41gmbFUAOfBGnIStYNJaejJW9?=
 =?us-ascii?Q?6ZG1am4kZrUk8mvG7OaxFocbSIp/Gy4fIIWuPrfet7VZoEOfwSI/3TgmwOx5?=
 =?us-ascii?Q?jOQpPT6R+Ae7ma/LOlwv3sJf9sJ25km0QqUGDWGYtkDMHn5oTVk9ax59NdT7?=
 =?us-ascii?Q?J7STQUIHrMhCKlFE+rP7c0ccmgpuGjPVFsJsit6NNkto2VtYqfy+y+1H5LqZ?=
 =?us-ascii?Q?9Co107Pc0IpGNuZ0F7+iTEr6q3rcxcWBVgNGEAXcV+T0ctAaH+8HHmm1h1KC?=
 =?us-ascii?Q?beH5yxRf1iCmr+h5vPUV4Y7hvCiBLzseYEwIzes5E/bEIhNM2p39j45Q+LTf?=
 =?us-ascii?Q?jaU3F16kmAFeq88uAj2yZOWf4OwODxqjM8vBEb2bt2MWWwNYoe3tMLGMXW6Q?=
 =?us-ascii?Q?YZESsqfHZci4tZVriEI8/uYlUO//iPnwOKhkepWnL0ibz9N2Isq9a6HAGw?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072ae498-3762-4139-efc1-08dbdfdc935c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:57:46.2734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Narz7qXoNeTwFsoprmgVQR/jmB3ec4bAAacGfkxUtsUa0zu1AAH7MOrrpU9fPvKxJpqka1Z4gj9oKfGmrax2IZBuNwzP0vYR9UTBil/nj5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=923 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070181
X-Proofpoint-ORIG-GUID: XFukDM7U-fr72DKERbj5hlazbtitA6w-
X-Proofpoint-GUID: XFukDM7U-fr72DKERbj5hlazbtitA6w-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a consequence of making the scheduler responsible for driving
voluntary preemption, we can do away with explicit preemption points.

This means that most of the CONFIG_PREEMPT_DYNAMIC logic, which uses
static calls to switch between varieties of preemption points,
can be removed.

This reverts commit 4e90d0522a688371402ced1d1958ee7381b81f05.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/riscv/Kconfig            |  1 -
 include/asm-generic/preempt.h | 14 +-------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 9c48fecc6719..4003436e6dad 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -134,7 +134,6 @@ config RISCV
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
-	select HAVE_PREEMPT_DYNAMIC_KEY if !XIP_KERNEL
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RETHOOK if !XIP_KERNEL
 	select HAVE_RSEQ
diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index 51f8f3881523..b4d43a4af5f7 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -80,21 +80,9 @@ static __always_inline bool should_resched(int preempt_offset)
 
 #ifdef CONFIG_PREEMPTION
 extern asmlinkage void preempt_schedule(void);
-extern asmlinkage void preempt_schedule_notrace(void);
-
-#if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-
-void dynamic_preempt_schedule(void);
-void dynamic_preempt_schedule_notrace(void);
-#define __preempt_schedule()		dynamic_preempt_schedule()
-#define __preempt_schedule_notrace()	dynamic_preempt_schedule_notrace()
-
-#else /* !CONFIG_PREEMPT_DYNAMIC || !CONFIG_HAVE_PREEMPT_DYNAMIC_KEY*/
-
 #define __preempt_schedule() preempt_schedule()
+extern asmlinkage void preempt_schedule_notrace(void);
 #define __preempt_schedule_notrace() preempt_schedule_notrace()
-
-#endif /* CONFIG_PREEMPT_DYNAMIC && CONFIG_HAVE_PREEMPT_DYNAMIC_KEY*/
 #endif /* CONFIG_PREEMPTION */
 
 #endif /* __ASM_PREEMPT_H */
-- 
2.31.1

