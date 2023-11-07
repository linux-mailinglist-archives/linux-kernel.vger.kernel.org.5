Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2613E7E4B61
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbjKGWDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbjKGWCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:02:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CE22D55
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:00:13 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJcBF005442;
        Tue, 7 Nov 2023 21:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ySNbSBBvAofKup/xKBYGGERhbB0ByCKuL3ZbZm62VAQ=;
 b=31So5Q92n9gRzdomvYIdViYdinz+j+kh45cpa2V0NH0cszc1IMM1vs4DY4663J4/AZpW
 bmZmh1DU/HtB82DRkxbKgJ7+X6frCoM5r1YVhfGJjHL97kRe1R67T6X9J73S/C0hWbjt
 NSPlS/qWRhNgSKp6e6WKJQ3nnu+Jr9zC0gEmIsKjdHwiOcRsuHnLYM7rDCXC2KU6ur01
 OB2NRK1xke0OpodpM74ddVRc1kOLkTzZ8s980pbOdDHPQ7tFY3DilOKxi33wXEXJsSUA
 VSgtjKHAKky/Z8Htsy/RfE35O5Qc+C+m6J20jVRwnI2RpAPRZtuiXbIM93RHmKhpW6gV nA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g2cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIbqW010946;
        Tue, 7 Nov 2023 21:59:09 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1tsj2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECmdtWgsHsYnzHbitMBgqy32vGWAeePT4/MCxB1Dhd6jF3xOX9fSRpZj9DwNCymKma+voVs50A0JDTSq15a4uHYf+WXDfIFwOF6J2bYfbbM+KhwXw2P8XbhttTjgkrnbs7RIQEe8QCpa0zvDg+Lb1pFr/1Dt7An5Y4x1/RLMBIRr6vFhchhB/XSTubTdicFrzhptx8rcj0rgfmcwlBXWjypfXTgBPYW1mOQSwnnTXnc8JM2aU5RTe0Ym2XcXDRKHhK4SzVWycx8kVJRWEMvHP2I03WukGOC2hP8whWTtSNbPzrAOHhF3l2JG22mPU5pTvPZd3OTfozMzuGDD5hXuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySNbSBBvAofKup/xKBYGGERhbB0ByCKuL3ZbZm62VAQ=;
 b=Ru2XnAwbyrBMRz2wFAySXlgFqniMtct9+ewU1xmFoWQdtwq3iSptAJr7hyfgM6ZJZX398XRg25bnM/w/+LcjYuYR7quv9O1zHPknjvY7ExG4fG/njwFs0xeggACh6oKKwFcj3/L1jaIbB+omvkCb7fbMmz1unbLNV6PncfF+IzIwx3IztLapChNPZWZPhDZR9v4/K5Shw1CAjGphi6k7AojmIMoh4tYjRmqR2hjli5Ed54bXF/zjdVCSRUioYsrgasue3qaw3uO2lr/BW2tk4sXVoxrB/JcapCWtGQK+aPN+emlbIpMHw3ExDlWDCJYmydO304F+mfFXfXTJHYR1MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySNbSBBvAofKup/xKBYGGERhbB0ByCKuL3ZbZm62VAQ=;
 b=nAmSiZrZS8ZDXAyAPR78t7qx27tkK+jbKocSaEsjksJi07P55UCgRwe03bX+NR+bYLBZ4QoyygJlF74IfBP9TZpiqxshOMk0/vG5iOjE9jYy/D+52H3HWzKlN4dcrzcHBIFDIkEFKQT24z/dk6N7hIy+Wye3FtR6Ul9pHEZFxbM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6275.namprd10.prod.outlook.com (2603:10b6:510:211::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 21:59:06 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:59:06 +0000
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
Subject: [RFC PATCH 27/86] Revert "preempt/dynamic: Provide irqentry_exit_cond_resched() static call"
Date:   Tue,  7 Nov 2023 13:57:13 -0800
Message-Id: <20231107215742.363031-28-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:303:b9::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f21137-b106-4433-8aac-08dbdfdcc2df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UsL8an5f/ZFmWfaMfAClggOHrryMi8xy7YKetYKcKVpyYCvqy7sUMzrowbL07WOmStLenX1TZhtgPexoo/pIaO/2zyra6p4Adrsum9SEU3zk1piPiImTvvH/Q1j8aNgpQx71LClT05L6z4xlh9s2EGkP8IOJpsDIOtoTEFXrSfjxpGathRRNPPbRex5WkGmhC8wounkfKyOiWb/zB3LHFdfbhVzbPn2xkTcQAR4WYFaO5ElYYMsoC4xFxS6btMMQd6CRc/UpjhL3+TpjFejaIljfzmP6GGWnu6Yo7Q+o4zywPY4cwYu78ooLNKN5QKVRniI+h35m5seR2m3i8VIOJYoJqoI9lbYNPifdbl0QY7RTw4yizAs+VErhcbavEmkZyktn2DBDvfuMU1hwPdWuZipp+KVhGVDyN87p995RoSuN9Lil/QvakjP0KaqwoBiKUyALsDmJYPhCOalJiQ/sHEzSaZ2xwH/U3yCBVJPS7fxbC2D4xYfRkMkwUicvGyZek5QXGAAEaBc+bmcmoBLAlvJsnQU5EWuslfH/pCOzoe6ySczd0QPfx46fQibXfNtJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66476007)(6666004)(38100700002)(6916009)(6506007)(316002)(66556008)(36756003)(5660300002)(7416002)(7406005)(41300700001)(66946007)(6512007)(103116003)(1076003)(8936002)(8676002)(4326008)(26005)(6486002)(107886003)(2616005)(2906002)(83380400001)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PeyfzO+eL+oCGH5gGH1s6LxS9uvMz/QjAOz7OxpnZnWiySPcanK8wx/goyay?=
 =?us-ascii?Q?bKQoF7QNLVZAGBNWdO/Cszw71u+TameLuB4OlxqCnWdBcHFPFtRhvQ5US+jE?=
 =?us-ascii?Q?Khbvv0h3xdl1RAQMlQc1P0N6jkdXP171AXZa6Bs36OK0c1v+wnLJOH0b8xtQ?=
 =?us-ascii?Q?bTs/4FhydFoPRN9f2xBks/glI6IkXzIPFQN2p0YdZ3YgR5Lqk1o/mQdxDFjB?=
 =?us-ascii?Q?F5O3PWacQqu5maVRPW7tmPRBjIljc7HC1ML7DycftEYdgfjvVlcHw9PaULnB?=
 =?us-ascii?Q?oh726bBePDoTL9VYgJvK9IbuQzLvfQQ9h2Yl8kcwoXpZi/g5W473mnrtIEcc?=
 =?us-ascii?Q?AlDF9q4LDxlrHNAmEWxkd3J7Cp8BzjoGn4dN1cZeH34U7CGkDYf4ScZP4Dvn?=
 =?us-ascii?Q?BNCbY0xdwUKoQucDwPh1SoiGXAtnk1F8c2xY+BNIWOrMrpbXBITZ1kx+O2Hp?=
 =?us-ascii?Q?32CGLrW6uaQ/O7UmRS3CkEvbrzq4L4AJQP7+vCyrNmdkKfeauZMPCLrl+E6k?=
 =?us-ascii?Q?IlP4VwdAbkaKyyIERbDSiWqVDvpGTAc6Pai3gddBe/l+IGHo2mVi91ma2gCQ?=
 =?us-ascii?Q?3mIdFHFSkUyt5oP7+XHCemb+zV04ek1mOR4Gq6d46suRAM0F6eMZgQuu/tit?=
 =?us-ascii?Q?Y18yrcthyILFkhhW1PesNvcTaRBCwJO/qDhjW4F64l2rMefP856mD1U3bdQ5?=
 =?us-ascii?Q?lyG76ovtPLonNpc/sT+K11ZToUgtp3OFQafrib3lQ3oFAIQXmcScEHukHZBs?=
 =?us-ascii?Q?FcH2KUaExgIhgUSpg6vCuKmpWOmnd07sq2F4MwsD7DmYuKFdUUHlEMGerovR?=
 =?us-ascii?Q?AZbNLtrpl9T5StTP6vOURYhx6/TMJsK87cP2QC6qrnCDJgBQMBXxkT4SEcuF?=
 =?us-ascii?Q?tIxUz59MtnPzvZQsHrd6GJmcNr2OWBDaKJbPeRpgHmL/w2naDLpyFLNsS5ig?=
 =?us-ascii?Q?n3q/ALb4zMiRgDgfLFFb2M+Px7RSY4FalzX3CSvweFyuMLWn7lc1uNr759j1?=
 =?us-ascii?Q?dv8OPzg5Zb+P9jqORRlKcqOmfQmsIt044Eyps/heTLWvVuLux/x7advOtUne?=
 =?us-ascii?Q?98VMQkud9j88HMRwbrVO0m7TRa5619AHCjDgrGbUn1ULJDxrmIuvUAd/FxfJ?=
 =?us-ascii?Q?L2BhwsXzor4Dp8AE3O/viQCYoGEA1bJGWcrlk70kSdUNwUqLbmq6Yjm7Uj/K?=
 =?us-ascii?Q?eNenAkMIGTfgw1LzKoccVO3MlppvVDaYfZ+8WHpf7rHcfcy1U03nqE45oUNX?=
 =?us-ascii?Q?e256pr+hue+OihPrgGfBOsOfJWcZkY8B6V+qtd8N/no7pGebODYYlUF2Dhs1?=
 =?us-ascii?Q?glhSQZKG8Xu58fHER85WTkggW0tHyVXgJmO2+VjmP3b09bK11RUwLnNSO0Et?=
 =?us-ascii?Q?+7c1p0ghwprOMGKhyngRb7r8ppAa5OE0KhNHYN8+oZglT5c/91Z/6KWHdJxV?=
 =?us-ascii?Q?YID3UkXjxicbzoNxV90oTVm2UpBp4ccrPFfAfkAgdSMGsFAR/MsmF4Ya9KIS?=
 =?us-ascii?Q?xhB+7GxO3N/erGPPG2eXOsou1Sdppf1PnAKf/khv6LsmDvZBDXjQE2vHPcCJ?=
 =?us-ascii?Q?ptHTJRkLYdkhleBEvp2Ej4W2Bls7g7v5VXOVjnGFngFCtQuBf0OO6bVm88vK?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?wZLV3LzB0MPyGC44HdZ8/nRy4w8x9ejPI/WE7LuWuAl+xyEa3yxFe8zQQTs0?=
 =?us-ascii?Q?Bm9aATeUX0ZcwhRh+EKUn1kFfemEkH0e3GctgnvjxRNXVgWUsBny2AUpeQvb?=
 =?us-ascii?Q?goMTSQiX+eo07Uec3x1GwRGhISi1Z/dziNgKh0ZbCM6O4NQOHiV2XxSSa+AA?=
 =?us-ascii?Q?GhBV0u8fa3RG1Cibe/9i0QYZyTJnrdsWy814cjQua/rRsewquqjxRY2wsSev?=
 =?us-ascii?Q?vDpEWLHEtvO+wpcJJkb9bd2u6XCahSgVfNKbf8O+/kdMavo8SSE12J+ye2C3?=
 =?us-ascii?Q?pwLiSGCuuaYtMEMXG0t2ukfhu3zNQ2+YU99C0loOPriRSEaB+CmNPDvtchfZ?=
 =?us-ascii?Q?qjAUSI4qWeG1qMws+Dw5Hw5f9b/7Vq6TCPwDih/YC89y0cBEhzbnWzWPngpU?=
 =?us-ascii?Q?+x6k1XoTesVBUtSlxBYA1O9ukcdwfwfdVr8QRvf/ZBzBn9L9vfNozSRcRV9y?=
 =?us-ascii?Q?GJYji+OeUjGjB+ftt9gV8AT7hofDtioS7N6vWgxlw+iSTeLds4eiX/O/Vixe?=
 =?us-ascii?Q?22QHjAe0Xzt5JBAPMo0KP3StOlFrvp9KGkIcNZHuWJ2igBb9CLyj5cnSlYnM?=
 =?us-ascii?Q?tyTT2IVbPV+ns6Vi2pPtKAdynfeGQkigRa2BBckpa9xyGPD42LyDGgc/kqBy?=
 =?us-ascii?Q?yWMCNxBKd5lmjT0MSHxLR4jk5IJZMh88WESU1fVterLB1cRgzHlTZ9PV4sjR?=
 =?us-ascii?Q?no4NHs2w2ltHfWYUJaREV9MRt9uvSZkFUQRyfZ/T/VYeLWs9J1yfV8zXGeRZ?=
 =?us-ascii?Q?25gl67s38BtsFk/7oVnWFbfG9syrNM3Q/L69bJzCQ/fwvhpF5/oYTvlu8sFp?=
 =?us-ascii?Q?qYXskYeAp6ZuhRxWXryf2FR2rBRD2dIAM+q+TcGcHkJ4+kp+/3c60BBrCM9u?=
 =?us-ascii?Q?OEcwBT2K7qKQu2xzwWkOGbTqnrb+fYvNpnU13kK7/4/YGlLjbwLQyhyJw6O9?=
 =?us-ascii?Q?fET7U7LGHYvd6Akab781Z+uD+87DF5esKy2Hn156z1RBSFVn114T9tcRubUp?=
 =?us-ascii?Q?cLBS5hwT+Ka1l4/d01ALI8F2DKx3i9IwIkVWerN9AEkldXwAmIr28VYoDYC6?=
 =?us-ascii?Q?MhQDlZxtX/kIuzZPhpMLd/O2Dg7pVibDaYZh4mvihsUov7u2eOeP9oJ+05ws?=
 =?us-ascii?Q?SQ2dxE8ri3wBr/GKnUqLZDxy4jPpB8BexN0uYvHZBf7VcXPsUGysC65Wkrvs?=
 =?us-ascii?Q?ncPH06U6gVF6e2H0ARyCeWB7KYkB+M09YjqnSoqGgfhKA939S0O09LLfw/OB?=
 =?us-ascii?Q?HHuQiTjPmfDDeV9qmLPJL6nzeW+HyyBbqu/l17cYuww+xudVJzT0hdWLk72t?=
 =?us-ascii?Q?W1VLMXXEq6nkdr7aa2dnGZzAG/uZlCWNiHLXRvxa60hVYDgG76M6bZyyAj0+?=
 =?us-ascii?Q?6oPuzk2loSCcOoVQQxZ9o6PXFMNWQHoIDd9uTl2E2OhVXZBXDZiIks6n95rI?=
 =?us-ascii?Q?KrEMfuVpb1BO41gZEYJTMuL30o1gi9WaJbSD2K/F7J9CYlAGGEnfuHiwfSGq?=
 =?us-ascii?Q?yCxf1modrTJjJ5F49Y09eEcAOU6+7Jm7mBckfAjaYibIuyrOU1Irz/PqSQ?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f21137-b106-4433-8aac-08dbdfdcc2df
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:59:05.9922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdkGNHTwMOaY8O2VMiUdhi/UIyGhMz50dLkh9X4gaTG6Nf2uwqLktE5sIXRhPeZiVgJYN5OgNS3uOBQNgSKyZaRgMKhkArstJa0JPIai+8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6275
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=754 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: TUW555Zy_SLIROHlA4PdPTstBnSoKQAr
X-Proofpoint-ORIG-GUID: TUW555Zy_SLIROHlA4PdPTstBnSoKQAr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 40607ee97e4eec5655cc0f76a720bdc4c63a6434.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/entry-common.h |  4 ----
 kernel/entry/common.c        | 10 +---------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 49e9fe9489b6..fb2e349a17d2 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -2,7 +2,6 @@
 #ifndef __LINUX_ENTRYCOMMON_H
 #define __LINUX_ENTRYCOMMON_H
 
-#include <linux/static_call_types.h>
 #include <linux/ptrace.h>
 #include <linux/syscalls.h>
 #include <linux/seccomp.h>
@@ -415,9 +414,6 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  * Conditional reschedule with additional sanity checks.
  */
 void irqentry_exit_cond_resched(void);
-#ifdef CONFIG_PREEMPT_DYNAMIC
-DECLARE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
-#endif
 
 /**
  * irqentry_exit - Handle return from exception that used irqentry_enter()
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index d866c49dc015..194c349b8be7 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -388,9 +388,6 @@ void irqentry_exit_cond_resched(void)
 			preempt_schedule_irq();
 	}
 }
-#ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
-#endif
 
 noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 {
@@ -417,13 +414,8 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		}
 
 		instrumentation_begin();
-		if (IS_ENABLED(CONFIG_PREEMPTION)) {
-#ifdef CONFIG_PREEMT_DYNAMIC
-			static_call(irqentry_exit_cond_resched)();
-#else
+		if (IS_ENABLED(CONFIG_PREEMPTION))
 			irqentry_exit_cond_resched();
-#endif
-		}
 		/* Covers both tracing and lockdep */
 		trace_hardirqs_on();
 		instrumentation_end();
-- 
2.31.1

