Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8824D7E5F25
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjKHU2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 15:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjKHU2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:28:19 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C91213B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 12:28:17 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8JiVwA023450;
        Wed, 8 Nov 2023 20:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ihQpT/gipM2i3jnQ3DCW53Y9tSpKXimiRfdW3FZ2e3g=;
 b=o/z7jUrVY1cMCSAwCreIiG3TJ8Z5jYDsfDblLrfUHNEqGD1xzf/1G83rDHSCXrhmttsk
 EqfvAcYBVKf0VUHyyfYDD+ZRUFX49cr4stg1OQQEscdP5WHSNWjFpbHCdL6X6qVLMFja
 wb3VZ5sKUXSHSgWNo/A8320UFVMa5ItTrM4p6n/0Uw6E7mN51bkToZ5wEu63cPiVxPm1
 gChxpAnG6cZ6SWTn6A6v5bafMW+zwbEU767trcFXZlwBGtUAggMgKVsMk1GwurKFjOvk
 HecMwb25VtOZYqc1qJcb+lKtRMd6l6kFpgLt/8W6zAH2rVylYLpcp25AYk6hGJMAuktc Xg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23jg2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 20:26:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8J5uku003932;
        Wed, 8 Nov 2023 20:26:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1xbb0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 20:26:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmaDGzJyOd/8gk2XKsaBkYJZXn+qNncPHdErBNRNnRVaheA8dv0hqZehKrr+v03unvk9Xu3bCZwxX9K/umjT2qc6mpwwCSc1LNO7vyL8H8l4FgnRJ7MjxJP3sAkLp2h2N15quLKocldqep8fLXp+fMghjaLrSh+nbjBMxt1IIz09uJSOld6K+xTcsW/4JJB66yhlUJGP0v+Svtg4yL1kZOrocND7aEIAInHNd+pLrSpogx9sfsHgnpyzH7zP8Ijsj+CxtdSBUGs32WDicQtxjH334yORvxn3bdgd94j4Dghec6VAhX7xsVbVtFMGWi7vIAMgj/kPz81W7gYwYV9zEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihQpT/gipM2i3jnQ3DCW53Y9tSpKXimiRfdW3FZ2e3g=;
 b=G4RA5H+odr2pBDJezgbHHV1TFtTlVi43HGa8AXV/ZyDPoSFgRZGahffE8uA6+PshfV16D2ZCZyCirf5a97v+neLjLmNGMOAbqLNKl3sr6urBckBkjR14ssfQVgQEbuD6htpSVpycMGibMZPeVmKFm0xhz39ObtLrbbm5v9I23+k1fmKHS5euRnZWAlEBeEiy7zMJbJz8lPiqggb13FrfXOXVucFkQ+JIDQnMzzTgu3/OfE4cgJ5gMlG7zegWFuDR6VG6clla1xfmKCF2GzF/vXM5Jf4YWt4up+R7aRKib8tjSK/0NrooLal3Vgxo5YOQE+2jlVlJoZLDZsPXDC/4fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihQpT/gipM2i3jnQ3DCW53Y9tSpKXimiRfdW3FZ2e3g=;
 b=xF96FEXdZeuMBQxAYINpKBuG0bty+mNDDRYs8suprZQP8glnPF6OUoqh9t6TpL6w1Zlj6jfCnWMhaIUWqtgbeFD+GgT3OMQEF0MWQghIhm9uKDd5DYTNDMxBy79g+arqRuzKenQJD/SNkFGldVVWb/uiM3NCNE+fHAUCZ7SucAI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6200.namprd10.prod.outlook.com (2603:10b6:8:c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 20:26:25 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 20:26:24 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231108085156.GD8262@noisy.programming.kicks-ass.net>
 <87bkc4lfxp.fsf@oracle.com>
 <20231108101330.GK3818@noisy.programming.kicks-ass.net>
 <877cmsgsrg.ffs@tglx>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
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
In-reply-to: <877cmsgsrg.ffs@tglx>
Message-ID: <87sf5ggff5.fsf@oracle.com>
Date:   Wed, 08 Nov 2023 12:26:23 -0800
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0350.namprd04.prod.outlook.com
 (2603:10b6:303:8a::25) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d6229f-c7a5-4fd3-dd8d-08dbe098fa87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8trl17HymhhRlsTDbwvjz56MJDGdgLCll/ZWGhqmBT1lNr9z3ixfJ12aXAK46fB9MHqNo4oSqa5mAxtEkyEWX2VcKU1uPCy2nF2TiAz1aAPmK7DeiETra9c/SkwOMUYxums0J4u7RBFQZruQjxIWfdhmNmQN7VH0S+pXKTvqERhY/Vf55+bWSdj9mKd11am9mbI6DyLhsoxaVYG11Lru2ZAeIQTXevi1XYO0RNPy90veMyuAKsRZ7b4JpaKJW1BX5wVcYrgCeZDI5DtAXoiKauPE3iJoph8YpUkHR70Dn8osVCwYP+SviUn/DShv+QgPDDYOeUNZ5zNfuTIYk4yU26LxhPQ8y+ACGv3Xf5l2ewBPctXdcSE8UuPSs5TBgvgefFIq0dldkC+Y/9sd3Hg77j+LrNE/2pntDBe91yRHn8XbM3z+guDTEZ+jFWeZL9ipoKeFZT44TGjAsBVg8PAYrUcifg3Ds6JQIAYQ1bKUHHb9jlbrEqcHpb9rvB2jqZWQnwJn/62mwLdXh8bokIPJKtcdiwmwFaOJgdSURED+pQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(66476007)(8676002)(8936002)(4326008)(2616005)(6512007)(7416002)(83380400001)(7406005)(2906002)(5660300002)(6486002)(478600001)(966005)(26005)(41300700001)(6506007)(54906003)(6916009)(66556008)(316002)(66946007)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fWA19n/97QfUVwAzpxVCFbjja6w0Jsyfrmfl2RtFt2ma7/7ogm9xnDVqr66x?=
 =?us-ascii?Q?A9axY+XbiDnn27UEwZbydS3iTanB9wIG2qgZQMjDhNrECZ9gbBG2ArpEOmSc?=
 =?us-ascii?Q?qYJxJxuEZ3wnPlD1h9lZh84KZ3UdKZkdIj+DlTkj7qdlKKE+OgUQWpiHWlRx?=
 =?us-ascii?Q?fVPoI1vgooINbtKfIf97If/KHRZHzgQuENWWklPlWefD0mmRIMjtgSMzE45v?=
 =?us-ascii?Q?pd6lvM8+HgayHKC5ve4v4RXoN3F/de7FBdFFhP5mW6JGp36GYCV4cfdKGaH0?=
 =?us-ascii?Q?L0rm5qQ1EtsBAfqpUXmpxqwgDesSDfxC2h+LFCkeircS9NwDI5gbqZWZz/R5?=
 =?us-ascii?Q?ZBqYu+UDSN+3d7DAQJYuuTXlIpYtn1eP9KQM/vinUph1tmK+rreec5Y9AYOo?=
 =?us-ascii?Q?Jg4adwZdQXWaQ+5k7My06eUmBy0HwZycxNbnVrO3j5EPX9c24kia9swUJML8?=
 =?us-ascii?Q?WG0eUz0NGNcRyzoH6YqLho/7yhSzxobk2wzaDbZSFLORwULpsxSMyB8SkejA?=
 =?us-ascii?Q?qvcDBfN6DIRPNn+CiwFMBqqNy/znFNnOXl2qxo+DWBi+O6DtmeoYNxmbtA64?=
 =?us-ascii?Q?98PgirT0W4btInmX1EFYdoODgNPC7/cWll1y1XstgKOUTqYPwku+obqOjgWf?=
 =?us-ascii?Q?7H5IiXwZbDohjHdVDUDpcrA24o62qQLP+aRPBeBkqe1agSHx7vBsNHuYWNBX?=
 =?us-ascii?Q?P9AkiLOmCSX4egFPkolVox4FN7x09+tBN7UVu0JcDAa/p5VPXgC2Fj/5TnyP?=
 =?us-ascii?Q?/yIAmKoK01qEEpKD39mdlED52PsopLAd+YlXymHY2oOi/vbT3ERkyBvLKkNq?=
 =?us-ascii?Q?m++buxRhZO3lqyLRqlxIqOHxHBKSgWOsdrWMGhY8AXmXtNzmyqhygdI/fe9O?=
 =?us-ascii?Q?gfpJlxnE2CvyBSoHguvHoSMhs2U8kFL7Hqd2bC/8wepmsIhHICXSz8ZxkLo+?=
 =?us-ascii?Q?y3cMjZQZhkNmeetisX/pl3CorcOjAyWTxsbzI/sRG4pJ8cB2yeTvdHwm3DMr?=
 =?us-ascii?Q?hGkrTo68YKJ+wP3RR7qHY0bYAzR5otFSz4Ay4goaFOzq4wYQtKT7/eWJreWl?=
 =?us-ascii?Q?iiLc3cMPnoZq1PE9L7qlI/4XBastcbBrLtPImHRl12nUDQO7E64T4hIHkD0i?=
 =?us-ascii?Q?yGs6rbKU68YzNsxJPd2SrkKgqSSGSzwqnCv35u4iQZKzsDcnH+8Rcl8PqqAk?=
 =?us-ascii?Q?pm6zyj6ea782PMbqRoHXU++jgAWyAqWqaHV69TaiMKnlJyrojP4GeQ3IFntm?=
 =?us-ascii?Q?79QKrF7N0wju4r/xMCGcs1jV0/lY5jbMEY/8CwiSdtXWJkrFsC5nB2ENRNE+?=
 =?us-ascii?Q?w5ZSmg72Mi5W1uVf4k6JtX5psCo0mw5LBO3/aXx6l7TnRMiSmYklJzSQuhw3?=
 =?us-ascii?Q?Fg2CJ9P8V45gnYEugPot9mxbAYQgMLag1fGJCEURzhJ55ZrwKzK0WCHvGTvO?=
 =?us-ascii?Q?ITHBTDCkAcvHq0QxGcRO/7QDoctKFfMz0OTH6h39Ze43+1tH26c4dn9afVsv?=
 =?us-ascii?Q?XXC7DTYrK1tfD4xxqUv4wOhfBzGkCSgvkbKiyVZ2Zl5/TGtbOWRlmMCdzVKf?=
 =?us-ascii?Q?NR6Fn9E+0jklJG5LV5fvU3zRjEy74PjzhxsHLnZKDatK9MsJnlZPE3v6bh1D?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?OBy4HZCV6VAQmxxU3UKK2rjbdjkX0lYwT4wmdsHUUO353PuIBV595DI0Sglx?=
 =?us-ascii?Q?P2IQPz2SbWxOUd6oqMV/BkIi3pFiSM6a/UD+pToAu13uNBV2UjFqpVyTO5Wy?=
 =?us-ascii?Q?zPGauySxhG/8oSbaDsNKgL4vFID/gB6Ogm585r8f1KyP0nbqResuyVjqeWUI?=
 =?us-ascii?Q?voaAkz3Jgfavj8NzrKeHf5A1rxw/aRvzyaNykA6YnSUfg4kOaWPHbpA9nXyL?=
 =?us-ascii?Q?RMq0jqXFGeno7qdtInXzecdGdW7SR2uXJjcgZe8KBJRNl3HS34fFW7EOZi/F?=
 =?us-ascii?Q?0Ul+oAxkvRbddvugQ/cYHu/J87DoS44+CEoO9UnaBH5FNE++GD7AF6r+dRwo?=
 =?us-ascii?Q?MP+3jBUOOv32p0NvtheEwO87I2hu8JZVsDUnXUZxLjvu5c9cfX7hW+SMpTg+?=
 =?us-ascii?Q?AzpJKc8Z3CAgECXYCvCvKYwOVxrqdIMt5MDjoz9F2Hv0dY3yABQFkwkypokx?=
 =?us-ascii?Q?5H/vtAPe2dbiWqEzBl7c198Xfl6eilv0DZWNGSpOVVdfT77NPN4xDHW8Alvr?=
 =?us-ascii?Q?3CJPhZmiMufzQ/uJNhzWDRp8N+eJqkBTSVDjwSGCN8luL9xMEPr9bRyWIhIx?=
 =?us-ascii?Q?U5/uSPuIJBE06Qk1+tQ55uUuQqXfcIC5QNPUsfLVeSgiDwYlAUDAsSXiu9ls?=
 =?us-ascii?Q?a7ZTEbi2HeyLegHuZHzf7nbAwiiVEcyF0b9bdwzgkbGhPfKL4UST5APoibZj?=
 =?us-ascii?Q?sFGL2voSXdum7xeldaTwyRw/488lsnYSupf+1eqDyj6sKjnQTP6X3HApEe1A?=
 =?us-ascii?Q?YYDGpsaP0s5qtrNYwK6rtX8aCV8LAVhisTh8C/eibm9Zogk57W8flE0AgCzL?=
 =?us-ascii?Q?4y4UqiFwHIZmfygb0vdXKNqlzDaGHIt+w+N94doj28bJO/KvoyqF6SIFhR1o?=
 =?us-ascii?Q?NdlrWOGKVvbvEq3OPS+hy94uTjeDieFlHBnhdBvuETkG/xFcpi8z2GE+dhmA?=
 =?us-ascii?Q?R1GtvvOWJys8fsjGIzD8kDE1VBhFaPAtsON39PjO8QrkSyS5ZWerL5pcZbui?=
 =?us-ascii?Q?nRLNT6Gdxusb51wb2lwqnJnnzKUkucQjfegrarCC9y09i1xnOK8sFIbClF9Z?=
 =?us-ascii?Q?c+p0RKHLQxQ8XIBEd4UEwVWTRlNwtjN3hNCQTEze+66ixFQyUPPQqmOdf7lR?=
 =?us-ascii?Q?zdSy+tidamof3Ja2qqoXdukeTH9YNTd8TwqtkCNTLcXCzKA2vTGRAXeEadAB?=
 =?us-ascii?Q?AsGCShfCmKFDCiRiaQ0sk4AHLOIl/bE+BX4AaQdVkJkWGUZsqjjB+T13LRYK?=
 =?us-ascii?Q?OOEfm4xi6UI5mfFQWEhire7zweWBIcNPOZauUTl5UEWA+GnzpMkFA6FsXtku?=
 =?us-ascii?Q?VFT1V54QYGuKmBIGJ+2MMqnu5gDGUrc9yXH5WNrjOQJOG8c4HxZKO0N3QrlZ?=
 =?us-ascii?Q?XJDk7qlaDFnUJithjrmv11KS7DIzwcnTnv7QdgXQmWmhJDt57IsVGha+i7qm?=
 =?us-ascii?Q?JsVFZK4KiGifqYp7NrwvblpCFLZY6ZuybQRzkGkbLChks8aWBkzsdkabokwB?=
 =?us-ascii?Q?hOMqnR+drxSHgeeQFy1cDtpTF6wLnThgEhCnB4qYe7rcZRsvJIbUg456Gg?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d6229f-c7a5-4fd3-dd8d-08dbe098fa87
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 20:26:24.7674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+YTOFEjjlyyHBnDvRlqMk9OAB+rBsiw/JOqYh3UO9xrgUS0u2HJD5qZ6PDduNejsp7/1usSPHEdgVahNCJvJYy2WGrBb4fZZ90FFU+xULM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_09,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=4 bulkscore=0 mlxlogscore=143 mlxscore=4
 adultscore=0 phishscore=0 suspectscore=0 spamscore=4 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311080168
X-Proofpoint-ORIG-GUID: Q4y15YkQGDZf7jNur1SpukY7LJdOtFiI
X-Proofpoint-GUID: Q4y15YkQGDZf7jNur1SpukY7LJdOtFiI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner <tglx@linutronix.de> writes:

> On Wed, Nov 08 2023 at 11:13, Peter Zijlstra wrote:
>> On Wed, Nov 08, 2023 at 02:04:02AM -0800, Ankur Arora wrote:
>> I'm not understanding, those should stay obviously.
>>
>> The current preempt_dynamic stuff has 5 toggles:
>>
>> /*
>>  * SC:cond_resched
>>  * SC:might_resched
>>  * SC:preempt_schedule
>>  * SC:preempt_schedule_notrace
>>  * SC:irqentry_exit_cond_resched
>>  *
>>  *
>>  * NONE:
>>  *   cond_resched               <- __cond_resched
>>  *   might_resched              <- RET0
>>  *   preempt_schedule           <- NOP
>>  *   preempt_schedule_notrace   <- NOP
>>  *   irqentry_exit_cond_resched <- NOP
>>  *
>>  * VOLUNTARY:
>>  *   cond_resched               <- __cond_resched
>>  *   might_resched              <- __cond_resched
>>  *   preempt_schedule           <- NOP
>>  *   preempt_schedule_notrace   <- NOP
>>  *   irqentry_exit_cond_resched <- NOP
>>  *
>>  * FULL:
>>  *   cond_resched               <- RET0
>>  *   might_resched              <- RET0
>>  *   preempt_schedule           <- preempt_schedule
>>  *   preempt_schedule_notrace   <- preempt_schedule_notrace
>>  *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
>>  */
>>
>> If you kill voluntary as we know it today, you can remove cond_resched
>> and might_resched, but the remaining 3 are still needed to switch
>> between NONE and FULL.
>
> No. The whole point of LAZY is to keep preempt_schedule(),
> preempt_schedule_notrace(), irqentry_exit_cond_resched() always enabled.
>
> Look at my PoC: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
>
> The idea is to always enable preempt count and keep _all_ preemption
> points enabled.
>
> For NONE/VOLUNTARY mode let the scheduler set TIF_NEED_RESCHED_LAZY
> instead of TIF_NEED_RESCHED. In full mode set TIF_NEED_RESCHED.
>
> Here is where the regular and the lazy flags are evaluated:
>
>                 Ret2user        Ret2kernel      PreemptCnt=0  need_resched()
>
> NEED_RESCHED       Y                Y               Y         Y
> LAZY_RESCHED       Y                N               N         Y
>
> The trick is that LAZY is not folded into preempt_count so a 1->0
> counter transition won't cause preempt_schedule() to be invoked because
> the topmost bit (NEED_RESCHED) is set.
>
> The scheduler can still decide to set TIF_NEED_RESCHED which will cause
> an immediate preemption at the next preemption point.
>
> This allows to force out a task which loops, e.g. in a massive copy or
> clear operation, as it did not reach a point where TIF_NEED_RESCHED_LAZY
> is evaluated after a time which is defined by the scheduler itself.
>
> For my PoC I did:
>
>     1) Set TIF_NEED_RESCHED_LAZY
>
>     2) Set TIF_NEED_RESCHED when the task did not react on
>        TIF_NEED_RESCHED_LAZY within a tick
>
> I know that's crude but it just works and obviously requires quite some
> refinement.
>
> So the way how you switch between preemption modes is to select when the
> scheduler sets TIF_NEED_RESCHED/TIF_NEED_RESCHED_LAZY. No static call
> switching at all.
>
> In full preemption mode it sets always TIF_NEED_RESCHED and otherwise it
> uses the LAZY bit first, grants some time and then gets out the hammer
> and sets TIF_NEED_RESCHED when the task did not reach a LAZY preemption
> point.
>
> Which means once the whole thing is in place then the whole
> PREEMPT_DYNAMIC along with NONE, VOLUNTARY, FULL can go away along with
> the cond_resched() hackery.
>
> So I think this series is backwards.
>
> It should add the LAZY muck with a Kconfig switch like I did in my PoC
> _first_. Once that is working and agreed on, the existing muck can be
> removed.

Yeah. I should have done it in the order in your PoC. Right now I'm
doing all of the stuff you describe above, but because there are far
too many structural changes, it's not clear to anybody what the code
is doing.

Okay, so for the next version let me limit the series to just the
scheduler changes which can be orthogonal to the old models (basically
a new scheduler model PREEMPT_AUTO).

Once that is agreed on, the other models can be removed (or expressed
in terms of PREEMPT_AUTO.)

--
ankur
