Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E777A9766
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjIURXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjIURXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:23:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122B32AC62
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:11:46 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KKJ6hC002744;
        Thu, 21 Sep 2023 04:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=DUEcIq6qXp8UcPtnZSvOPAkyihT0qZjqqVLJM8CyKzw=;
 b=voQE5bET/lfd+Z/WWj4LfHQfbAZweTIEeH3IrQi4sx4CjkGtx9ANbG046vPLfF0Gyx0w
 b7nqrSevuGOa9bw7VlP8c76mCZ7lALmKL0p+ETp0Mr3TY6eIuYvuXlYCM1czd8W6+z8X
 p2MZ1h4K8p6o+JIUjsR0bEE/qVvi8lTUptZ6VXuZu5Hm+fean47GFjKDAbm3EoFJiuU5
 6+R6iSQiBoDLgS+4+258ik6bS0vyrgZaGUGmd7NvPP21gqlw1f2pg/b/6K+KWltc9yhy
 agCEGRYFCgHTUUEXsj5VyG6vq37F+nYFy4fH/hYasz351lfQnXTCIi/TG1dG4xLrsXBH 7A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54dd8t2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 04:16:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38L2YdGA027313;
        Thu, 21 Sep 2023 04:16:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t87nac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 04:16:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nV9x/BT0PP/rWvTeJZBGMM4RZEEM0sEGsr0A0woeDGW37OW0n3VUQtAx15IpgmCGbu7rs0aw4qrQBVyQ/XoTC4AebcAZqH9CBPQ2SKwB818aa7/vHu3ZJfIFHQsIPGaYh6baQukDfcOHhuSzXSiUIw5Ndcnd46t0eFlEsKJTk0xDxwUCq9rm6uNiKarCYnN6B0uKmIFWGu3fGO+qzVmY/rMK9dk+FcH4zNCSaZVoKFEGwwVJI7s/l/bpANTk8r4l+dOfQ3HXUMUt9Ta8BV/gwLunqgzXgoH1j+Vly4J8DmgVvu0XyS+pYRF+Uv7CkKlcKGDKfg7fdG+GNWH/bW5CPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUEcIq6qXp8UcPtnZSvOPAkyihT0qZjqqVLJM8CyKzw=;
 b=asE//oQ1hXmJdwJz9pY0DoC2HQFkskTLRCpyFofz5GUjplWr56NS6TSSZThRK8HRts134DnRmQYM92G6gRVf+kznn5VduX+M7Ficb30CUpOQRofvQ+k7F0KfnYMYjGaJZjMVTX9V31g9TJLf9nfICapevlYoaNgkDGhB7CLIpcNEJ6Kyhqdo/gkTIyv0bx4H1lMifq4UkvdbBWnTL5HV7hjxO/7u3Fxx9yEM2ry+RrG9OiF+B5j/EGcDQLKigLzz+NNd0t+P21SC2sI0Jp+erXKJTebaMODcyabadjol828Nu7wbmIRldlyQU/v1E0wVn4XxePcLb4DA8uvcHQQsKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUEcIq6qXp8UcPtnZSvOPAkyihT0qZjqqVLJM8CyKzw=;
 b=c4IuVEtCdECeND911n/iucW0RsIWeJOL966iqaaNg0Pmb1cko8xUCK1QkP5BXER2Iu4rhwg8LU4l/renXLD0Tu/k3wXhH015g5I2OIpik3oDOLv2nWcvt2GV9qMxvSdcflkN4CMiir+SjrIG+fClkM9pl7UOzcT0Ig0C7lS7M5c=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6996.namprd10.prod.outlook.com (2603:10b6:8:152::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 04:16:19 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03%5]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 04:16:19 +0000
References: <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <8734z8v1lo.ffs@tglx> <87edisibrp.fsf@oracle.com>
 <87ttrothbb.ffs@tglx>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-reply-to: <87ttrothbb.ffs@tglx>
Date:   Wed, 20 Sep 2023 21:16:17 -0700
Message-ID: <87wmwkcga6.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0003.namprd21.prod.outlook.com
 (2603:10b6:a03:114::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ca5c46-c8af-418f-b6f9-08dbba59814a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyLR6HrSL4N0xvMTY2UiVaWZxNsdtcN0fZ4vkehNb1yGMMCpTlNnX4djDgsTnS4uDoOGoncstFJiWCNRir7r6Puejkc2INbAsE6zrSVEv9LhYxa5Toc8Bycl2GLSAyoXsrEWwFJyyvxpQrLVMJ1bNTzoo7LDY4ibDCw74jqzhjSAg8Gd2iLLCx43T3FPlxPPy1eCVXVBnF59QDMHrfRC73cKKzbZDZ7NI+3RRqTonPdkvk81nSyORboZws36dRZRiSdZn0CRv170umxdppn62v3/00ScGybinzCxqKjaGTbEKu0iGeaTOT9NoBttYXj10O7+Pxo6b4D1gZIoHuTcBxaHVBJLlnYsSlTnum4nW7rRF0y68gcP/meRzwvefxmvNXD5d1JiVCt2PVl+pTcS8t0cRHmKY9nXxZd/gwhzNhP3QpdTDJa/t3eM/ffTqABvxqijgDBF6InsUP2RxHxT867bnqYLLUmJd2HTDehr4crz2tikI37ozdToSKIKZMk9kcKn5yNX2v3C/XZRMMDAe+ABQM5K+dECKhlEMDGUOL+ESKD7HAGoc50Ce45PWvES
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(186009)(451199024)(1800799009)(478600001)(7416002)(86362001)(41300700001)(2906002)(5660300002)(66899024)(4326008)(8676002)(38100700002)(8936002)(54906003)(66946007)(66476007)(66556008)(6916009)(316002)(83380400001)(36756003)(26005)(2616005)(6486002)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kXHGjwSSlxmb8pP9ekIFqipvOxTx3pphxodOLjkTUYRFiSBT1l38KFJ6ZwOY?=
 =?us-ascii?Q?Md57eKAL5OzNiyw3ICqKE64FVzqs08ZGFCX+6DcMLkRK93bfmmXoiAjIWF96?=
 =?us-ascii?Q?Il3XB1VOmbGMAfxjfHY5ig1Hm1s8W7JUC0sMnjGrCyuwMX3XI+1y17hDjNV1?=
 =?us-ascii?Q?oBJMmOx1IhRWPETvyUH/smh0pNcyHWfA3iO3tIdPq2tHGKVdSRhCMePQVs3N?=
 =?us-ascii?Q?O8uWL28n3R8dexCwS3FZosgMskDpFT9+vDsaYQNYyOxQkwHxJoEGUYH11ztb?=
 =?us-ascii?Q?dpAlTVlMDXehOgLJ4BkvQI3bjugRonNoGGb9f7NMy8/McbRuN6N5HdfkX2z9?=
 =?us-ascii?Q?NsXKmtj1EPbHJ72LEhDeIvS9bzEhKIOVWKvWAGiowcCn07STdwOkAiVjgMgX?=
 =?us-ascii?Q?f5cEnCdTPeKhLDD1GffplAzVb4klOtQtbGyCUlVmP5zAhMg57sQNWl3ioOq5?=
 =?us-ascii?Q?n3wAieSrR5UeYsx+ps6OKwC4wQfgcKehuymGRcSJ+K/Rkpo3QuzscPmuON5l?=
 =?us-ascii?Q?jB9A/G7/82MemnBsfjVVJyBYSmKWoTtsxYsvg2n/zGzPH5GtHoF8AQG1LNVF?=
 =?us-ascii?Q?12gvNeuBDuW2+KLuKK/B69QTYlv00Ier9uJFxxdtDNSdmur4alUaWcN2JEqZ?=
 =?us-ascii?Q?L4ZQVX6+r58uuQS3kc2ThX5gHP1T2KO/de4jk2qPcrET8D68HwBgbzB7JUr0?=
 =?us-ascii?Q?AGZ0eXoSNfiBra/I00i31Ya5UaAwEB6NUvujKBeV1ewSAtbMVzyxUcHyw0fN?=
 =?us-ascii?Q?4G+kc7mTmOUMD3EnXnr4hGmmlW/y+PkF3/5RgxnVd9plgD+2sTyGJAlnNlt4?=
 =?us-ascii?Q?JkXoLsjh/YHkI3MojW0FrKq9eBI6wsDSdZord2XTAjc5oKqoP708HpVHZWAf?=
 =?us-ascii?Q?EhbqBJzvbZifA+VEYiHWnMhssUVIsSboLODoCRWB/VdvsjFr46sdKIdKf9gG?=
 =?us-ascii?Q?13LWc7S9EKlvREnCrnioYB2JFbBbG49jTtV+vhJYomVoVzn1thQ5dE3RWcDh?=
 =?us-ascii?Q?Xm3CPFQ/ayitWPSsV3P2lag0kNQY1Ae53LTdutM90oNU2dFWeyTLfVjiGWLc?=
 =?us-ascii?Q?ei86C1ankPg6HB10CrRSEcslGFMCeNBH02UmQKvTTZQ8AfeobIll9PZbmPxP?=
 =?us-ascii?Q?C8KxCbUUUgEUQg0dxxG+2z6DVl+kmat0K3ImRbP1PUzQS53hlnRs5A4E6xXs?=
 =?us-ascii?Q?Fm6EFviiMRM8PRaAQ5xMnrRlQVObIN605LzPSz9QiX7xFl7RrlIzV0NLlK/8?=
 =?us-ascii?Q?wsOfSjAAsEVagWRYg7c59hQR3XvRHigKmUm/UF9LkqVfNQsFELBWdXOznd3l?=
 =?us-ascii?Q?KMxdV8cLiGiL9mU3ZIWUlbMAopnh4Q0z2lELjCfpg9fBnyE+ZVRg0S/igVJM?=
 =?us-ascii?Q?6o7+4H2krp2PSWkNgaS/aud8Kx1h9lynqaMsUX3kqvUoq+gAmcFfyXQJqupy?=
 =?us-ascii?Q?w/Wc7elShy4c87e50zLOt8DJO/IdcliXOOv03U5wTKPb7wT05sp2ZeOba5vQ?=
 =?us-ascii?Q?CKLwmgMry1r8B87i8VfIZuiF0oh+naoYAnDy8b230OgZJMirsYndVpTrytVO?=
 =?us-ascii?Q?9z5M9UUEnFb0s8yqReTMipU+UkUfmA5SVpaExx1mjoecSjlgvI6vNOhjdhJW?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mcCx267RabKKbK8lgE/f8a7pu3VdAtvvR4ABqJTQ5BEmLbLQhoZT9ObG8RbO?=
 =?us-ascii?Q?qZM15AMGQ4tpGWcLywbWN2GfEGkRrRyqoRNBGKV2XjzihE/XkxP0WDA8KPeN?=
 =?us-ascii?Q?5aE0Tt98uuitksCdlMhwLMwDBGCUsjuhFMu8u4Iy54AM01mG1ScCgIlmFRmh?=
 =?us-ascii?Q?ovub+6j1Y4sgWZlPKHgJLHBH++J6v90b2IzuUcLafxXIFLUPmHFlj4hYnLAf?=
 =?us-ascii?Q?bvENry632dUpIuqQHFnHdxi6v3rqSfCcIC5MAwKx3mC3R3w+B8Em3dK6dQre?=
 =?us-ascii?Q?CioXKSaTNzNy6NmUHyNC3Rg5rH+/2ud5Ad0S86ZK1R7X8JHH0RC2P5UlgZKn?=
 =?us-ascii?Q?qE0p1Y1L0tPonGcVZdKNMpwYyoIxjy1pJv8NLLX3R5teg7ZQcdcq4Qu/bVVf?=
 =?us-ascii?Q?nPXk5Vn+c1wZWBF8AjZ5b4p+tzb49EAQB+LGZlDDYaUAabN8RCkjFe2NSW95?=
 =?us-ascii?Q?1JQ6T8Q732LBQat1w8+MJOvk2f+EwdR4IAo9zY4LyXmE7zbDHodt8tnMytXS?=
 =?us-ascii?Q?qqYikb/VqrtKLGlM/atGx+4cbK/rCdzswCNOpaDPlbdNZI9mHZIVSpMEXz92?=
 =?us-ascii?Q?dWyXKXADGUqzpkHTUXFB51+9yQ3W4xdSrIpGiaLXvyrlBjBtvgopXISvXMml?=
 =?us-ascii?Q?tsdiHsdfi5/tUGswQ+kxsNoqIpL6naFElBEBX5ETotRXguTMA5dy/chwvYPJ?=
 =?us-ascii?Q?IlJeaBgedDdSVZUDfFwPI4xHzcR96nYMn4Ww65Vf/P7QlR57AqVfVHe4Bj37?=
 =?us-ascii?Q?r5CzfqSOwrvk86FwdqWT+0RTAhB15i37zHBUINChOnt7S78z54u4Ja1VMRMG?=
 =?us-ascii?Q?GJlL9jHBLfGZS3khQ/rHHi0plyKA8wOkbuQ4P2m+PvVMj8j1mAPQabw7ouzv?=
 =?us-ascii?Q?j4pC6iQdcCL8saxLtm7sbJRr4jUOybiLfHlabTXzGmyI5ZiV5ErsdzrJSaai?=
 =?us-ascii?Q?IbmgyzcMmz/tV9xLTikD6Arhin4/oD0d6Czw7GGk7VoTO/SnYpdC9idH63DV?=
 =?us-ascii?Q?kzFoOQwc9iZBv1Ofw4jJPIqykP4e0492IhV8KqiGhir6bmfHZGK8L4xhLIid?=
 =?us-ascii?Q?JmV0RkvLRxuk5lZTNZGQHW/tbl0a2EuGVhg/27O0Ya4icHV8OupV3POuDz/D?=
 =?us-ascii?Q?H4Z6HWSLilj7SV1cXjFnmYKpujx+sZ8xCWRaNuwHj767zw3WhplMGieOxQiW?=
 =?us-ascii?Q?6r7/aVXyLhR6fbBAVP/I6gV7p7Y7oyb3cT0KvUyP4XlHJabUN8CEX0jIJMx0?=
 =?us-ascii?Q?gCgfeCQddxcmb+3OE/Kx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ca5c46-c8af-418f-b6f9-08dbba59814a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 04:16:18.9970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0C0z8LgZtAoWFpqDkcY2FowXWKvH6NoU9vGnWrMM//+4CbygbYO0m5ydoABAdeM3KaMg4FZBCsY6F35rI8lo6eq+m1xi4Y/t/RZ4r4YZLh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6996
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-21_01,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309210035
X-Proofpoint-GUID: 11OBRQ_WE4MruB1ZQe7Atl3DrXsk230M
X-Proofpoint-ORIG-GUID: 11OBRQ_WE4MruB1ZQe7Atl3DrXsk230M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner <tglx@linutronix.de> writes:

> On Wed, Sep 20 2023 at 17:57, Ankur Arora wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>>> Find below a PoC which implements that scheme. It's not even close to
>>> correct, but it builds, boots and survives lightweight testing.
>>
>> Whew, that was electric. I had barely managed to sort through some of
>> the config maze.
>> From a quick look this is pretty much how you described it.
>
> Unsurpringly I spent at least 10x the time to describe it than to hack
> it up.
>
> IOW, I had done the analysis before I offered the idea and before I
> changed a single line of code. The tools I used for that are git-grep,
> tags, paper, pencil, accrued knowledge and patience, i.e. nothing even
> close to rocket science.
>
> Converting the analysis into code was mostly a matter of brain dumping
> the analysis and adherence to accrued methodology.
>
> What's electric about that?

Hmm, so I /think/ I was going for something like electric current taking
the optimal path, with a side meaning of electrifying.

Though, I guess electron flow is a quantum mechanical, so that would
really try all possible paths, which means the analogy doesn't quite
fit.

Let me substitute greased lightning for electric :D.

> I might be missing some meaning of 'electric' which is not covered by my
> mostly Webster restricted old-school understanding of the english language :)
>
>>> I did not even try to look into time-slice enforcement, but I really want
>>> to share this for illustration and for others to experiment.
>>>
>>> This keeps all the existing mechanisms in place and introduces a new
>>> config knob in the preemption model Kconfig switch: PREEMPT_AUTO
>>>
>>> If selected it builds a CONFIG_PREEMPT kernel, which disables the
>>> cond_resched() machinery and switches the fair scheduler class to use
>>> the NEED_PREEMPT_LAZY bit by default, i.e. it should be pretty close to
>>> the preempt NONE model except that cond_resched() is a NOOP and I did
>>> not validate the time-slice enforcement. The latter should be a
>>> no-brainer to figure out and fix if required.
>>
>> Yeah, let me try this out.
>
> That's what I hoped for :)

:).

Quick update: it hasn't eaten my hard disk yet. Both the "none" and
"full" variants are stable with kbuild.

Next: time-slice validation, any fixes and then maybe alarm-clock
deployments.

And, then if you are okay with it, I'll cleanup/structure your patches
together with all the other preemption cleanups we discussed into an
RFC series.

(One thing I can't wait to measure is how many cond_resched() calls
and associated dynamic instructions do we not execute now.
Not because I think it really matters for performance -- though it might
on low IPC archs, but just it'll be a relief seeing the cond_resched()
gone for real.)

--
ankur
