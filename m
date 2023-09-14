Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1037A094C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240914AbjINPcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240912AbjINPcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:32:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8B01FCC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:32:11 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EEFi5o004024;
        Thu, 14 Sep 2023 15:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=LVZaWf8eZJMWRqYO4aah5lQSARdc3bH8LRL5hkLLf9Q=;
 b=e73qgYrk2LjXVh9FI3Ms7jADUyMk3fbD35vgJG6tRqrki+DD0Jt4rdl6T1FDwRRiQoz5
 Z4fWdTTKmpW//m7W9YX+nfZyehveL9tlWGMQiCAgYEYvSwxXF0UY4wJE/9n6Y6r5qme6
 3ITvtTIkuqC8cUlKyhWaA5dbg2R/TayOdf06eywiqFrWB46J99NwTmoThZWPfNhjpiPK
 fgv+W2mHy0I6UmBdcisHfi1Knl9etOKfqBp85yU9JJKBfNmcMeO5dvGMnZ6O3G6n0f+t
 TUvrow3Rx8w6HA53xy7hOi52MSnAMPgWpTK9GW2NAA8JPysBkm6HhAjFSbmu/8E2xvh8 1A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y9kwp8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 15:31:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38EF0xTu007382;
        Thu, 14 Sep 2023 15:31:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f59kp1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 15:31:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qvcbgk+tHSpmYxW6J34PUA194OLijqebydNJQRJ0AyDx6h3FHIudJPeWiJF+02Mb1e7LWw1hWGcHU/9TreHJRbPfzXzBKVYQlij2AUv6fMlCJn7bwNCuqwQIumCHT+ls7b5GeLGLh5gGOBV1BjdJaD60sQE6xNepF5uS2/THpFUQkmAeNgoLFDzS0/8X7FEeR3anFiHowNpf+QIA9IkZLxESC64LcvR3xXaDcsqO0/6NpJdRuKmI5hUAtnqsuuAIS67H37blPZRASt8Tg3GMqFh7SumVGiXZpN6CtF96XqWnG9M1MgAZLokDz+rbD8xbY0eAF4CJoNdMMJu2viCQsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVZaWf8eZJMWRqYO4aah5lQSARdc3bH8LRL5hkLLf9Q=;
 b=H7DVK1FrUcIBambaOvT6wu5MrnvT2llxoqSVRSauVRASRjR1P+MHKCcd/WWBEom5Et7avTaKopapn27aiC7IZLqWUD/lT4aSxf/t5wEduvCnmd2ELSO8ixYea/884lDBW3Zeh352o/xYW02PcnHF3L6vO5yYcFbDWZZi01LOenHJhpOFGjx8GiOGDpPDznpWhyZYmmheRw7MI7HJQbetxDz+9bMHS6vP+O2Nu5/flTpb2+VaXqFbLTTNQyIkbF+gMhY002gRn+NhBLFmsYAgkdD+oeIgv5TvdZM4XBKLlih8IVQqaz/pXjBZybPKTqjpzL0ms2oDkbQPmnExOxvgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVZaWf8eZJMWRqYO4aah5lQSARdc3bH8LRL5hkLLf9Q=;
 b=iXBEzg0KxypatLtxky+4gdfxR1SOj3BtRad7Up/S2NaYpboHCRKari05AxEynCebiYMX8rh7H61QSJbTXVpCakE58nclVRr9L08j3BU3KjXunxcgNkkeWf2X9BiV2RtMpe7zvf18NVV87Lt0URk5sSDJnd0cnkHbrLHQHsKYi0I=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB7522.namprd10.prod.outlook.com (2603:10b6:8:15e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Thu, 14 Sep
 2023 15:31:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 15:31:26 +0000
Date:   Thu, 14 Sep 2023 11:31:22 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Jaeseon Sim <jason.sim@samsung.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: Re: [PATCH] maple_tree: use GFP_KERNEL on mas_node_count
Message-ID: <20230914153122.xv6asxuidnibmtcr@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Jaeseon Sim <jason.sim@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>
References: <20230907144924.272e2f2sckprbvca@revolver>
 <ZPlNPGpAPy+7oQay@casper.infradead.org>
 <20230907033914epcms1p61c5eed4d34d5c4212436c201f33292b3@epcms1p6>
 <ZPlIShWJWt+Kxt8x@casper.infradead.org>
 <06a8624e-00bb-a332-4271-860847faf4a3@bytedance.com>
 <20230907044119epcms1p3ff1dd04b02119ff11b77fe40b4842afd@epcms1p3>
 <CGME20230907033914epcms1p61c5eed4d34d5c4212436c201f33292b3@epcms1p2>
 <20230914024937epcms1p24be0b59caeefd7966bec81ac11feff8f@epcms1p2>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230914024937epcms1p24be0b59caeefd7966bec81ac11feff8f@epcms1p2>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: a4cfe58b-f233-42ce-142a-08dbb537a883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z1zi1Z5b5216Ulwl75zggWptgC+g5B8cWehzDiSfRHKghg52tZVdAja43cFpD0yUI5WbENxyUnbFCoszUeYUQiVjgRSE3GbcrSZTygyfWnktWw12lSNXaQEixqQDt1GkRfXFX8CfrAj5ll1vRv5BDcgYIL2RWqmeuJPpf6jexEzUbCAn9QgX1fPa7eSojc7+SRDBp8GR0c5T/fDYADRzjjH1TOfI4f6oeYPb3X8cCnP3pcUfijLl834Zh345x/P0CM0/68if9hgboB+EHS/2HR7Ceyyr+X9vdBUwYcSJN9hgxQpzW/Xqlf2mx1FESNJADdxjfBQEalMRHYg8lM2aCOjW0PXi7nv1SQdb3Z0kleUPwrEj5xJDab7BUvLohPt5mt8UG3gF6njg9G5e6QXWXLT1xgnw8yE5yeUOmWGuVdGHoFvC9MBrTxBCQo+IHpZCmRhK20PgGmFehXhAHPoXe103jpumHQpRwEB7mtu+QzB8IeYNq5dVtJCzgb1uSby/4CLDMwDVgjzEdnLWufeMrUunoIcq2yE82y00wuEPpIWz3sgC0j0RCmBpJ2JECNgW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(366004)(376002)(346002)(39860400002)(1800799009)(186009)(451199024)(38100700002)(86362001)(4326008)(66556008)(316002)(41300700001)(1076003)(66946007)(8936002)(66476007)(8676002)(6916009)(5660300002)(54906003)(33716001)(2906002)(9686003)(6512007)(83380400001)(478600001)(6486002)(6666004)(26005)(6506007)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnRWSEROZlg5ZURDY2hQZWJVS1dzYlVGUEROUzc1ZXpkSVc1eHNNUUZCN1NS?=
 =?utf-8?B?LzVBT2l3UU5Vc2RGKzRlZUdKbm4yRWtPV2RBRkRTUHU2SXpLaFNISW1hdTdK?=
 =?utf-8?B?ZW9FK2ZUV2xLMW1IRmdIZXQ3TXp1YmVnZzloSDY4Zmo4T3FKVFU1WXlLdjFJ?=
 =?utf-8?B?b1J1QWpVeGZuWFkyRjhoT2hsQVhOY1lQQXhGRWNSN2t5MUFOVzlsSytiMStv?=
 =?utf-8?B?QzRyUmE5S2dMZm94eUN3SVg2czg5UWJsUjIvUU81Qk9vb2NyTm8vLzA4ZjdM?=
 =?utf-8?B?dlhuUUtqNitlTm9nWWhDalFOelVuZm5LcnJwTTB1NGZTNGN0L0FsN1hBdGVU?=
 =?utf-8?B?czJCNW9COEM4M3F6cDNvYUJRT2hRM2VEMTVPUFZjamcwTjQ0SjRYdTBacE1j?=
 =?utf-8?B?NlduSElnQTFwaDlIWkpZWHl0Z2tRVFQ1ci9BdkJWb0dRVG9ETk9nTkk2RWFi?=
 =?utf-8?B?cWJSQ1BRNEF4Tk5nSzFXQXFPVEhsNElEc0J5T1pqMGFnbVI1aFFucDRaWldI?=
 =?utf-8?B?bElSSHJTZ2JvaUJ3OCtwS2xRTVVNSTY0cHZ5bDZwZ1htdm9CNUpMbWtBa0pZ?=
 =?utf-8?B?K3RXdGRKYjN1YlJjMG1hTzQ4OUtyOTkvQ0gxNTh2aEtJMFpaN0FNeUFBa0lk?=
 =?utf-8?B?N0NJeklFTVFmdnZNRGcyUVVtWDFHOFVkSDVIQzRTZWI1WUZrRm5SZnJMOG9i?=
 =?utf-8?B?ekpYTDh2Q0JmaEFVVzBOV0trTW1SMXhhSUswUitCL0NqVFE4YldCSVVaWDRD?=
 =?utf-8?B?UVM1NStFajlrRlptNW8vRWVHMFJYdVRGWG1rem5FLzNIdmliVTUrSUd6SFNW?=
 =?utf-8?B?STd3cGREcDg2R3FLOEVRd3dFOGlOM3Q3WmtEMzVhMi8xSnd5QXQvamFldE4y?=
 =?utf-8?B?S0U1VnNNc2NpZVREdnhaWXZIaVFHdFFkR2hSZ1E3T1ZZWmRDYW5pai84TDFQ?=
 =?utf-8?B?Z0VQK0RSTTlGSkdNb0p5ODNVT1pieDRVcEdSNXpEQStJcnkrYng2dUhIUG5n?=
 =?utf-8?B?Nk5xVlZiT1BCR3ZaVDV3eC91TmIwK3hLNlZBeFFacDJPRlJUcGQ1aE5uQWNC?=
 =?utf-8?B?SjBVODNGdTV3MHZFM1pSWDRIU2IzejNsU0FpZndrZ1QvYXlhT28vZFduSi8r?=
 =?utf-8?B?V2dZMDQzYjhvdmYvUzAwZWFaRTh6M2dIcWFnRFVQUVJHZWlHQmVDck9YTnNI?=
 =?utf-8?B?Vy83akVrSWtJTWZjZnpJNUkyYngxS3hLK1h3Zko5aWwxWENOL0t5R1ZBamE2?=
 =?utf-8?B?ei9iaVNieWUyL0J1d0xPc2pFaVBYUlN3cEc0RmxvZ0ZSdjBnaWlMdXQrSWdM?=
 =?utf-8?B?MTFldHFYdzJKcXgvaVNHdkh4eGJ5NHRFb2NBUWZiTnhFbzRpWDJ1aUEzb2to?=
 =?utf-8?B?K2VhT2xteDMyMG9aSUNsa2cxVGF1amtiVVlHRjBDcUl6Vnh0c1RCMUhNelh6?=
 =?utf-8?B?ZTFDR3FiWnpPNStyRzQxNFVpWFBzdzRFV0htNnMrZld2czQ2UVEwVnZpYkN5?=
 =?utf-8?B?T1diaHRHOU4wb2ljWkowdXBQaVZpY2Y3MFdweWRJSFFTVDlTMTFaamMvRU1E?=
 =?utf-8?B?MWNubFFJTGNlYW1GRzBSaVBvam0xT1BuN04xOHBxYVFoMi9jOEJWVzluNnVT?=
 =?utf-8?B?Z25OS0lRVjRITXhXVW1wT3dWYXF0WGJ0eXRQZ29EZnVlZVQyaGlYTjVJV3Nn?=
 =?utf-8?B?NFN2RENKVHI2SDZ1VWJtNkx4ZSsvemJhN2RyWTF4OW9YNmhqTGkvTndwakFC?=
 =?utf-8?B?N1VRanh1R3N5b1czQ3hmMGN1TnNQbWZHaGZpamFxTGkrendTRExsYkVaak1X?=
 =?utf-8?B?MEQ1WXBrRFM0YlJLL3RpSXY4RjdycW5TU3JOY29COHl5YTFvcnpHaW9rdFdU?=
 =?utf-8?B?MmdOK0dwYnF3ckRrR1VXbDFsNDF3eEtPNEJpNnNIZ0QyY2xURHJLNmdJaGE2?=
 =?utf-8?B?UnU5ckpHQjVhdkp5TWhNbTVhdnhYUXdBV2hxaGNraVNiZ2xCMmZwU25wdWNn?=
 =?utf-8?B?Wnozd0I4MjBXWTZlcFhPd1JrQm9FbXkwMUNFZU8yS3UvMytGaHJZOEhHcVYy?=
 =?utf-8?B?RjlLK3pxM1FvNXRCUVBaRVR4TVpPaWltY0RnekVrYVlJOGpxWnFhRExYcXY5?=
 =?utf-8?Q?6LGtRMwHGEpRQcMy5mStSqrUw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?L09DVUJsSSs2RzhWSXdhQ3lwQXpwb1M3YW1ST1U1RFU0clRVcVBsd2FJZk82?=
 =?utf-8?B?aHNDQ2pVc056MjUxZ2c1VlJqVHNwYTlpcVlzNHBSUlhCM0RTTFY1TFNZMTVE?=
 =?utf-8?B?L0N0c09zOEdhUXFzc29KNExoZU5MZVNoM1pyZFYvTUlyVHQzN05FM0xtem9L?=
 =?utf-8?B?S05VdnBvK3FtdXMzbCtDUXVhQzJSMmM5Vm0yRUxOT0d5b1dwZXNmNS95dFpN?=
 =?utf-8?B?MkpkVng1SG9OektKM2JvbDV3c3grZEVoSTlJZC9weXR3SWlhYzhvSlVneHMv?=
 =?utf-8?B?RWREYjR1WTAvQVBqZDVhMVI0RGdyQmt6U3FZdGJaY2hwdVFVS0x1ZnkzbWxh?=
 =?utf-8?B?M3JHWUpvWHU2aml3b3ViNWpCOVFTNDJ6c2RTZ3VkS3FHaEVMaEg1TFo4RzZx?=
 =?utf-8?B?ZVZQMUVlVDd0VTJJMkxiOXUwRDVWemwzRGJGNmRUS3drai8xUlJWV1Y3Z2l6?=
 =?utf-8?B?TXRKU2c4YkxURDRVYzJHN1E4YUVHbGsrZTVoMHc0ZFVkV2hJNWVpMDBDV3dQ?=
 =?utf-8?B?VjBQSlppRXdGYlc2U1pKN0V4VE14Nno0QzdFaURvQkFkbXB1QWZHbStiWXBT?=
 =?utf-8?B?QTZNQWk0cTkrbnp1QWdZcTJuN21qODNoZ1d3TSsydEJ2WjdJenI2M0xCbTJT?=
 =?utf-8?B?VGhUb1hOS2NPOGFXZW5sRkN2djJtTnZaNnoxNFdydjRFd2pTZU5YN2pKbURw?=
 =?utf-8?B?Wk5VN0Y5WThHdldqdThyT09VLzdEeXBCU2FpV2M1MXpXZmRQU0ZyTk5OWDQ4?=
 =?utf-8?B?NkRWWEo5c0VNcTlvTUxJVi9DS25DMStFeUVoYit0eFo3MGJoQ25UZzQvV1dE?=
 =?utf-8?B?NllINmpsNkhlNlRZVjdTbUFGM2RnM3AvVDV6akxKdEVpcXNpbE8vaXhYd0FL?=
 =?utf-8?B?R25VMjBaZjEwSzdjK0lMK3lDb0kyTkVrYTFsZlZubDNGdllJME13aFdMWHEw?=
 =?utf-8?B?NGw3YytXeG1GNXYzL3ZsVUd5N2NkTWo3eGdNaHJ3TVJXRmR0QWtua2JxNDVS?=
 =?utf-8?B?eUpyS25JSVR2VkRMYzRuNnVXUkQ0WTEwNkZOWjZPeUFkTWxwQ0tNYyt1VXp1?=
 =?utf-8?B?QXdvby9xY2hjdVNvUEhRZWYyU29IcDhtODhDTkVUWGs3c3YzZm1QQ3pSMGtm?=
 =?utf-8?B?cnUvR2lWdWE0SkVWWU1KMzdITGlzOXJzSzJwMzJrenA1UlNLYXZkbEh6RFhK?=
 =?utf-8?B?VGNlVlJBb0ZrZk1iY3lTbytDdEFZdzE4N1dwdGk0UFRVRVdCaUV6b0RLdnBL?=
 =?utf-8?B?UWZ3NTZtTDRSMnY5ZWNZSzZRUGZidmlpU3h4R0RlbjI4b1BQS05mcGx2RTZs?=
 =?utf-8?Q?MCqeKM3GvbcuO7J+Cua++RRoJQCotcV+rk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cfe58b-f233-42ce-142a-08dbb537a883
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 15:31:26.0074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IsisTKdBBrMXMb+C8x6DSjSCbU/81hUaPNIQFN9C8ake/eGHhC+mnmGGJIU/T2UfHtdAVYo493CuYpzk+Y0LlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7522
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140134
X-Proofpoint-GUID: mS1MSzEkzpEvEPLsiQKxx4uAqfoYOcHd
X-Proofpoint-ORIG-GUID: mS1MSzEkzpEvEPLsiQKxx4uAqfoYOcHd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jaeseon Sim <jason.sim@samsung.com> [230913 22:49]:
> > * Jaeseon Sim <jason.sim@samsung.com> [230907 00:41]:
> > > > On Thu, Sep 07, 2023 at 12:02:02PM +0800, Peng Zhang wrote:
> > > > >=20
> > > > >=20
> > > > > =E5=9C=A8 2023/9/7 11:49, Matthew Wilcox =E5=86=99=E9=81=93:
> > > > > > On Thu, Sep 07, 2023 at 12:39:14PM +0900, =EC=8B=AC=EC=9E=AC=EC=
=84=A0 wrote:
> > > > > > > Use GFP_KERNEL on mas_node_count instead of GFP_NOWAIT | __GF=
P_NOWARN
> > > > > > > in order to allow memory reclaim.
> > > > > There are many paths that call maple tree's mas_node_count(). Som=
e paths
> > > > > cannot reclaim memory.
> > > >=20
> > > > Right ... but we should be handling the ENOMEM inside the maple tre=
e and
> > > > allocating some nodes with GFP_KERNEL instead of failing fork().
> > > >=20
> > > > > > What testing did you do of this patch?  In particular, did you =
try it
> > > > > > with lockdep enabled?
> > > I did power on/off test with this patch.
> > > I did not try it with lockdep enabled.
> >=20
> > To accomplish the same result, but with a much smaller scope that will
> > work with lockdep, I would suggest changing mas_expected_entries() to
> > use mas_node_count_gfp() (which already exists) and pass in GFP_KERNEL.
> >=20
> > Since fork is the only current user of mas_expected_entries(), this
> > won't break other users and we can deal with changing it for others if
> > it is needed.
> >=20
> > If we do go this route, please add a note in the documentation about
> > using GFP_KERNEL.
> >=20
> > Willy, does that work for you?
> >=20
> > Thanks,
> > Liam
>=20
> Dear Liam,
> Can I ask you the reason why mas_node_count is using GFP_NOWAIT | __GFP_N=
OWARN?

Must users in the VMA space have complicated locking schemes which
require no sleeping during a store operation.  Most operations will drop
the lock and re-try with GFP_KERNEL when using the internal lock (see
mas_nomem()).

> I wonder if other callers for mas_node_count might have similar issue.

The external callers who need GFP_KERNEL are either using
mas_store_gfp() or mas_prealloc to set up a store prior to taking a
series of other locks.

During a mas_prealloc() or mas_expected_entries() call, we set the
MA_STATE_PREALLOC flag to indicate that there are nodes preallocated.
This is to catch users who call mas_node_count() and require increased
allocations when allocations should not be taken.  You can see this flag
directly below the line you modified.

>=20
> From your opinion, I'll post v2 patch as follows

Thanks.  Please test with lockdep but I don't see a nesting lock issue
with fork and this change.

>=20
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index ee1ff0c59fd7..b0229271c24e 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5574,7 +5574,7 @@ int mas_expected_entries(struct ma_state *mas, unsi=
gned long nr_entries)
>  	/* Internal nodes */
>  	nr_nodes +=3D DIV_ROUND_UP(nr_nodes, nonleaf_cap);
>  	/* Add working room for split (2 nodes) + new parents */
> -	mas_node_count(mas, nr_nodes + 3);
> +	mas_node_count_gfp(mas, nr_nodes + 3, GFP_KERNEL);
> =20
>  	/* Detect if allocations run out */
>  	mas->mas_flags |=3D MA_STATE_PREALLOC;
> --=20
> 2.17.1
>=20
> Thanks
> Jaeseon
