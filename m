Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB157795C3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbjHKRIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbjHKRIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:08:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED63211C;
        Fri, 11 Aug 2023 10:08:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDUUFn014430;
        Fri, 11 Aug 2023 17:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=58EY2p5DeyatZjE4dKQjGZFTt8sWnd82VgrLR0qC3IQ=;
 b=R4v3fq3pn8MeR+GUHSbusfedC8cKy0vymUn59kf/0iBDxAGSO1Trfm7HT0mg8mB7jv5L
 BNbamqXdctF4SZIg2cOjawCf0QMRAX6YW4hSXFPjx3In61zFMberMrlhyhhuxvGiSNZM
 2Cjoi3gs3nT+JqDA+5MHhytU5hGZI9jGD54p+8P+AAwUTKUTn3vo0I9MC2PcuBwl3pPB
 fRr+2pp3OoSmvcbqRPmmzGTNg/9Ta9zCSYs1o2FEZml9Iwvhc/VVEf04VQMhBvlTePhM
 G6Kdly9K/+IVsrfXqrMtzRap94UDyq40Y+0aUrH1FQox8/rk3pO4ydPrZ6PJyi4tWYAn ng== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8y3sg0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:07:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BGQVTp000953;
        Fri, 11 Aug 2023 17:07:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvgj03u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:07:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bu4KczXbLoTt4ffKLKkJtKPw+2+iCjekBEOVVqmb1XuGNvNtU5YqnevZZEkqp5x/9BizJQ6cxxT4EWWYlWlmDAxRmEJlJXdDZlnKO8Yw16YYzsc2i6sSSHbN9QN540S5dWXkPEyMVpBGDKau5MsFnFMj02tnaleCTPzDVq7jwA8vrJjq8dLGeRkuZcJwhl97A5Qjm0PynBYmYqzbi6IDt0aZ64LPneClIGQXTO/ThsXyRsE4eDGXQz4+hHr8MM6Mc1VYzxCS8zsFm4z5ul2E1kBg62hjisgBcC6fwkYyDPtzhadJ8MlJNDzGxWoHuSeXLFAsqP+oDqiuYVzrdkRo8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58EY2p5DeyatZjE4dKQjGZFTt8sWnd82VgrLR0qC3IQ=;
 b=FmJF6dpRDDaq6fhNxsdT4nX8+oRNjxgURCiuuVshlhs6/W30RDKBLi+PGPwUbJVA1670khz3ehXG4QiKVvgql+X2p8ABLsaD35Vpxl4tg7d3M9a4if6QU0ngrX4d4DjuiXNUa9er58dJquZZ9SG1ZBTyAx3XS/qsOxC8DHROHrc6DqjUjU+Alcm7X9V1iXgBD3gMSk+1awXHQMT8rVmXMnVvtfr4Jrr+4/nfXSWHdiciHJ8qCgWytj8sqPVgCbx1sFGVPu8EjdgsOyvhpIWfTpW9cxgHj4rhekx6y4zi22OrnbrvLtHzrd1ZtwNChMepDFJEi6FqxYq0TkzN0lwDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58EY2p5DeyatZjE4dKQjGZFTt8sWnd82VgrLR0qC3IQ=;
 b=XKJqksdYtfn7hZUybrOS1OJ+7GkKt5PIfbepwcpjUhJfQVvEaeOF5zh0dUo03FqazmoGJYVMVcBcOOuf8pS1ZMyApJ7xeCvJctTMLfRMaCokxEBTfpJf0mn2qHeN7WK3gb7uO0KEqUlwVwLfgZi7qYMIBuschPb7nyewxitWx2U=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ1PR10MB5978.namprd10.prod.outlook.com (2603:10b6:a03:45f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 17:07:04 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 17:07:04 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v27 4/8] crash: memory and CPU hotplug sysfs attributes
Date:   Fri, 11 Aug 2023 13:06:38 -0400
Message-Id: <20230811170642.6696-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230811170642.6696-1-eric.devolder@oracle.com>
References: <20230811170642.6696-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::8) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ1PR10MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 45421ae9-61c2-4030-dc68-08db9a8d62bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yzZ1it+4Vnavit08LD2mAG4Cux7Y4eB+u4D8sWhD9/dZS63UNfJV66KyPDXvz6M4hrxKDa04trTYMvGyOo0lzUN03EMxHackHU/LRQJCVHKkbYaQIUEgHi2fuA0l/+woKTbHZQJBcQDbwAjOAvuklkj6PbC3mzsg8mjGBJtW+pZ9pK4t5TjxIkXJ5gFk9l2wwTxytYJm+urMHUUuY0G/grFOTz/CzBUq+WrOvAsAlMCFhXG1CD+r0vrF+mor1Ed/SWltqB1Otq4hyTcVf+m19+6Mdvaij7VQOdu8TApm3puFne1LNoB6nwKCNIYdfGOTVVlvgeCW4gMgRcfakZBIu7QmcD1prjVxd/TmrwABn+IV1beJZEscAnQKAatVEujegAhdwtTirxFbrQaSMLq3KjkQYgy/6YzPHY+962m9z5xXEdf47rwe680AF5GvqnXC2tYH0KBdfglQB3V249pl8Gq5Vl8BKjYCZ7VTu/zVEi5jbawKoaKIANFZEGRfD5nBJYMJPfsgZUjFZ4QoBSr412UDrJWRtWYGQvdRsj/jwF+JhUckYMLHRBhCGvB15NSd5pPBQhpMQn1vrQ0dXBC9mQDRc+iifY0+UdotFB79Qwk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(1800799006)(186006)(6666004)(6486002)(6512007)(478600001)(2616005)(6506007)(26005)(7416002)(107886003)(2906002)(1076003)(7406005)(66476007)(4326008)(66946007)(66556008)(316002)(8936002)(8676002)(5660300002)(41300700001)(38100700002)(86362001)(36756003)(83380400001)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LCjmMCAuDfwiikr3tqhiK/xnjkwegErjJquxwBAmAGk1juN8aBkpW8prYNYi?=
 =?us-ascii?Q?ma2gEBgga2OZjauiwt79Ic/pr4feXqfpWZlvxIS5BsJcXOy1eppw8xO5RLhg?=
 =?us-ascii?Q?5bLJc9I6RWxzbrJX6tQO5cZfKpF2JtC342TWjqmpvPCAzxJnDsrGBo5E+SYg?=
 =?us-ascii?Q?5+6F8wfx2H/7B98a2IFECNQKavWisQEIawE7bcHxlsPKPIn6bOtB0YVsJAVn?=
 =?us-ascii?Q?OWijKUfgdoyzqYfH90kC28hV5sTthZSP1yT2lS/bOSAomQNMplawLDhsMs6K?=
 =?us-ascii?Q?aQIMKZ1FR0lKtCZg8Ki9OCXKU8dbsecfEDn9W/4pEiErCzD52jcKi1z2GmzH?=
 =?us-ascii?Q?ZbfatYR+u8Tz0QKXaVjuYtyOy3Ng8bxzJBktGtGyB94A+4X6F4XbUVO0LN9Z?=
 =?us-ascii?Q?rZ73Lo/JZXMMUETASCrzcKKuDhWGTBZKI9qmyJsYJAFKv6hFnNCDFnKHvfxa?=
 =?us-ascii?Q?PzH8RxeU1OOqLoTWqVOhgwpHnMwEJsIGeKetFhfz3JZpSI5+JrROF6AjZOiq?=
 =?us-ascii?Q?P/vXeOSeRLbDpMuKTgrkzXFHmRpyztHupu3lrb2e1chXQrS3pYBKUM9Vsf0s?=
 =?us-ascii?Q?kG6tqwF9aevT69xBeCvRHpmJfw/dnzHvYFZhl5RAsIK7A/Lp5e83jVM56Tto?=
 =?us-ascii?Q?kMZFGkcIZjVBwsG1xkuFyHrMULkrnmzYxukdXWZc+bePHR+Qcdb86yH75+ZO?=
 =?us-ascii?Q?klOHsA+QNNGMO/4ARwO1Y7wspukecbGGu4+hog1na1WunPRqRGGPFMkvDJhb?=
 =?us-ascii?Q?YUAwJErVY/71VCV4bR0wZjJyJeXbkdJyUZ7NZivlhBNaCM0Jb1t/SJ/opm3m?=
 =?us-ascii?Q?0KW1+6rpYQOuLab+pfhAAV7PKYjSSy71Bq4YCtHaY6ySi9507+1/UetyQW35?=
 =?us-ascii?Q?GP5lEPI1Xek3MdM8lcGCH0UX30Za2iF9avgIbngt9dANyF+KTZbHvfUkTnIn?=
 =?us-ascii?Q?8cwQt3Ky32kO1Az8N+gTCquwvb8zbAZsMWDaJnR3pvuJ+7FdEqMNsjpriVW6?=
 =?us-ascii?Q?KfyN3mCSFIPb9Qcn+uPdI805jIrbNeC3h8fyPhzfC6g/dTNNgW4ybV0CGPxM?=
 =?us-ascii?Q?Gc+yhb3MgzL4cInhnujKY1ngTrz6C8Bl3kzceeDC7tovSzP0GDG2zGM7Hk/0?=
 =?us-ascii?Q?GXucfvW0tFydAlEvDTqqibL8Fb2v67GmB70RfZKvmhMBf0rOPmnvn/KynK9f?=
 =?us-ascii?Q?6Aixv2Hjq4IGc6VxlcQsB/VEwe1mYVju0okJ4EuHNrQSVEe9g/WiDBMd+/2m?=
 =?us-ascii?Q?azcZigtFQXeAuncSKEr+9vz1egE9mLZAa3vT0h8RMSAu+tjoWiRxZnWN9fB2?=
 =?us-ascii?Q?PKmGPaFHDv+DFjXTEg3mbn5krX+slWi5U+m7/BsgXkUgqA9Zja0RdmHxYLCg?=
 =?us-ascii?Q?efEBkdsk9tqTnJ9IUpNdnCDJX388D0mnbuOFjAkPgbhwhDV1bVvULBSZetdq?=
 =?us-ascii?Q?A0E8pXsxGwJ2uP91fYpzY/hJd8AebyNyPaG/Mqx1NKfn04d5jyufmq8cTfdr?=
 =?us-ascii?Q?G0q7CqYitjVNHXZUMhetr6MtD4lXqlDJSk58Kpb4p+nYnOeHbTtcs9f2a6Sf?=
 =?us-ascii?Q?Rv3/Vn0ofIfNPKR/RW/ESqXuPOrl0vSpYVubUGIj8Y94Ivy7E788HtFAvRWZ?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?7jLo0xTLHg/o/rygK97+2/N9ZMPC70H8gT63Aw6snDYN1X2T3YeeHAvEKveY?=
 =?us-ascii?Q?xSw+CykjjxKqxCJsw7rlTSoVg9Jz17w5jOnU4+BHN3pY4TSt1fjo1CQp9L3T?=
 =?us-ascii?Q?XDTzMImaiDqdCF6ybFv0/1T4yT7hiIWcA6OndFsM7nfBdQheU854CiBME4Fd?=
 =?us-ascii?Q?3HcwiVGel2b0kCTavSkWbXfP4gRNz4N9a+pFIieGx7OHq3cwmUGCJKwmdhJl?=
 =?us-ascii?Q?LMJHx/i8sM8MDhgoCyCNNpJEJDRGot7FQ5b4hJeD+ZkJrtIDR7QKcag3U7Z2?=
 =?us-ascii?Q?H2mVD6rOLta80Dmy5z/sBfDmnN1mC8aPqSZ3tO1FlNUefpshRItv1XIZlYpN?=
 =?us-ascii?Q?2xcbtfjNLwNe+EcDYu3XLWjN5kc8sv8iNhRmPJ6h/gdySAtj+i0kPNTBHg7b?=
 =?us-ascii?Q?0za2Pq1Yx2OIwcBBhrveXo9Lku9gNjkJRDpFjfh0OFhJe8M6pYcxY3WWw6bD?=
 =?us-ascii?Q?zPnzDmFkBhKEgNgazMwBzaQ+lZtznl4eypY9qCQbu8qu+qYRfuEKhLA3LhXb?=
 =?us-ascii?Q?9xCEFSW6UMASkeAZZCPtQ9LkjOJK1OUUp9mQBFel0h44wjwwGdUqiQE3lBVf?=
 =?us-ascii?Q?Q6ZxULxnhux7nSCwXeLBJ0xCsAB7LMpYYrx1y75WfD242AuF8SMazn2Z7Sav?=
 =?us-ascii?Q?dafe+sKRuGskjrSnF579wX1L4ou62vd7k4Mjm9muh+1QBneu/50Kda+Ud7yY?=
 =?us-ascii?Q?jCaD9ofL09tq+ZUAehxlVatm0bWSJl31TAbYqsXklFMYowBbmGRupN/zmheY?=
 =?us-ascii?Q?iVjKIdn/IBko5gm+i5brFKHQsbbUYbclv9vB9/j8eS8N9qEjL8OjPEjrvxJf?=
 =?us-ascii?Q?nzlzL0DHx2LNsjNvzMbX+PLYZISM3vsTtg2ZmBkcSeaQSt/RguzW10z2WATQ?=
 =?us-ascii?Q?btrQ3gRQg5FM9WEnF2tktk4AvZsvjfmgpiflNo9+T9YpGQqWi6iEWdiToMp+?=
 =?us-ascii?Q?53Yqiov48iw9kC2+k5AKBeYKhhYGTJIK7AUJnBVnprcE9VdPLfYfVAkZZfoV?=
 =?us-ascii?Q?kG9zYvNYIRagdaOhn/yutkSto7DqBJZcu8DXtx2IQ3qcXTIviaL3epZ6lptI?=
 =?us-ascii?Q?zURisdrOGygVxzsKbtDKHD79NF6qyq8ULF4JN3LLKSKwOTGtWh2Lqrdeqvc6?=
 =?us-ascii?Q?LDISS6T/pMjaKr6usY3ADfnqtwMvv0m3vLgb2tS9bff3EngQLEj9mjUFE9De?=
 =?us-ascii?Q?OiDVRPY9Dz0c4EulzBmm0i1WGx0R6cihTc2++lo8VPgiGBD9xw7JqT2APnTS?=
 =?us-ascii?Q?oh9tipvuHqHyVo4U+GxIB621SG5IIwG9tajcw47/0CHTdBgK+jENIrHiYEif?=
 =?us-ascii?Q?sLLuPsBAODrLqw/IoPU/XVZmLDULkuHmWqMXsVneD7nGCnkNpO4duoGXdcSM?=
 =?us-ascii?Q?d1ODx8fnAVZMCs9elL9ArkbAH4LFjdRsU+WE3PdFuuM5/+DpAGwZoeaY3UDP?=
 =?us-ascii?Q?uHiz30SXJv0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45421ae9-61c2-4030-dc68-08db9a8d62bf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:07:04.3284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQXcHcm+PNSCJW+TY112MjrPtHnf97ywZ4yP1gwmSVO9PPfax8x1Tu4gn++PXsQOw/A5snf86ixaWIOrAhtHpMAbH4jMh61KVPFb1eOmG3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110156
X-Proofpoint-GUID: 9lmk4W8VAyMJlMqejNZ-FlRFQGmgMdaY
X-Proofpoint-ORIG-GUID: 9lmk4W8VAyMJlMqejNZ-FlRFQGmgMdaY
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the crash_hotplug attribute for memory and CPUs for
use by userspace.  These attributes directly facilitate the udev
rule for managing userspace re-loading of the crash kernel upon
hot un/plug changes.

For memory, expose the crash_hotplug attribute to the
/sys/devices/system/memory directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/memory/memory81
  looking at device '/devices/system/memory/memory81':
    KERNEL=="memory81"
    SUBSYSTEM=="memory"
    DRIVER==""
    ATTR{online}=="1"
    ATTR{phys_device}=="0"
    ATTR{phys_index}=="00000051"
    ATTR{removable}=="1"
    ATTR{state}=="online"
    ATTR{valid_zones}=="Movable"

  looking at parent device '/devices/system/memory':
    KERNELS=="memory"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{auto_online_blocks}=="offline"
    ATTRS{block_size_bytes}=="8000000"
    ATTRS{crash_hotplug}=="1"

For CPUs, expose the crash_hotplug attribute to the
/sys/devices/system/cpu directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/cpu/cpu0
  looking at device '/devices/system/cpu/cpu0':
    KERNEL=="cpu0"
    SUBSYSTEM=="cpu"
    DRIVER=="processor"
    ATTR{crash_notes}=="277c38600"
    ATTR{crash_notes_size}=="368"
    ATTR{online}=="1"

  looking at parent device '/devices/system/cpu':
    KERNELS=="cpu"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{crash_hotplug}=="1"
    ATTRS{isolated}==""
    ATTRS{kernel_max}=="8191"
    ATTRS{nohz_full}=="  (null)"
    ATTRS{offline}=="4-7"
    ATTRS{online}=="0-3"
    ATTRS{possible}=="0-7"
    ATTRS{present}=="0-3"

With these sysfs attributes in place, it is possible to efficiently
instruct the udev rule to skip crash kernel reloading for kernels
configured with crash hotplug support.

For example, the following is the proposed udev rule change for RHEL
system 98-kexec.rules (as the first lines of the rule file):

 # The kernel updates the crash elfcorehdr for CPU and memory changes
 SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
 SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

When examined in the context of 98-kexec.rules, the above rules
test if crash_hotplug is set, and if so, the userspace initiated
unload-then-reload of the crash kernel is skipped.

CPU and memory checks are separated in accordance with
CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG kernel config options.
If an architecture supports, for example, memory hotplug but not
CPU hotplug, then the /sys/devices/system/memory/crash_hotplug
attribute file is present, but the /sys/devices/system/cpu/crash_hotplug
attribute file will NOT be present. Thus the udev rule skips
userspace processing of memory hot un/plug events, but the udev
rule will evaluate false for CPU events, thus allowing userspace to
process CPU hot un/plug events (ie the unload-then-reload of the kdump
capture kernel).

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 Documentation/ABI/testing/sysfs-devices-memory |  8 ++++++++
 .../ABI/testing/sysfs-devices-system-cpu       |  8 ++++++++
 .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
 Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
 drivers/base/cpu.c                             | 13 +++++++++++++
 drivers/base/memory.c                          | 13 +++++++++++++
 include/linux/kexec.h                          |  8 ++++++++
 7 files changed, 76 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-memory b/Documentation/ABI/testing/sysfs-devices-memory
index d8b0f80b9e33..a95e0f17c35a 100644
--- a/Documentation/ABI/testing/sysfs-devices-memory
+++ b/Documentation/ABI/testing/sysfs-devices-memory
@@ -110,3 +110,11 @@ Description:
 		link is created for memory section 9 on node0.
 
 		/sys/devices/system/node/node0/memory9 -> ../../memory/memory9
+
+What:		/sys/devices/system/memory/crash_hotplug
+Date:		Aug 2023
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) indicates whether or not the kernel directly supports
+		modifying the crash elfcorehdr for memory hot un/plug and/or
+		on/offline changes.
diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 77942eedf4f6..b52564de2b18 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -687,3 +687,11 @@ Description:
 		(RO) the list of CPUs that are isolated and don't
 		participate in load balancing. These CPUs are set by
 		boot parameter "isolcpus=".
+
+What:		/sys/devices/system/cpu/crash_hotplug
+Date:		Aug 2023
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) indicates whether or not the kernel directly supports
+		modifying the crash elfcorehdr for CPU hot un/plug and/or
+		on/offline changes.
diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 1b02fe5807cc..eb99d79223a3 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -291,6 +291,14 @@ The following files are currently defined:
 		       Availability depends on the CONFIG_ARCH_MEMORY_PROBE
 		       kernel configuration option.
 ``uevent``	       read-write: generic udev file for device subsystems.
+``crash_hotplug``      read-only: when changes to the system memory map
+		       occur due to hot un/plug of memory, this file contains
+		       '1' if the kernel updates the kdump capture kernel memory
+		       map itself (via elfcorehdr), or '0' if userspace must update
+		       the kdump capture kernel memory map.
+
+		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
+		       configuration option.
 ====================== =========================================================
 
 .. note::
diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index e6f5bc39cf5c..d6d470d7dda0 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -741,6 +741,24 @@ will receive all events. A script like::
 
 can process the event further.
 
+When changes to the CPUs in the system occur, the sysfs file
+/sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
+updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
+or '0' if userspace must update the kdump capture kernel list of CPUs.
+
+The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
+option.
+
+To skip userspace processing of CPU hot un/plug events for kdump
+(i.e. the unload-then-reload to obtain a current list of CPUs), this sysfs
+file can be used in a udev rule as follows:
+
+ SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
+
+For a CPU hot un/plug event, if the architecture supports kernel updates
+of the elfcorehdr (which contains the list of CPUs), then the rule skips
+the unload-then-reload of the kdump capture kernel.
+
 Kernel Inline Documentations Reference
 ======================================
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 52df435eecf8..5fb0c89e1ad5 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -282,6 +282,16 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
 static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
+static ssize_t crash_hotplug_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	return sysfs_emit(buf, "%d\n", crash_hotplug_cpu_support());
+}
+static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
+#endif
+
 static void cpu_device_release(struct device *dev)
 {
 	/*
@@ -469,6 +479,9 @@ static struct attribute *cpu_root_attrs[] = {
 #ifdef CONFIG_NO_HZ_FULL
 	&dev_attr_nohz_full.attr,
 #endif
+#ifdef CONFIG_CRASH_HOTPLUG
+	&dev_attr_crash_hotplug.attr,
+#endif
 #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 	&dev_attr_modalias.attr,
 #endif
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index b456ac213610..15bb416e58ce 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -490,6 +490,16 @@ static ssize_t auto_online_blocks_store(struct device *dev,
 
 static DEVICE_ATTR_RW(auto_online_blocks);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+#include <linux/kexec.h>
+static ssize_t crash_hotplug_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", crash_hotplug_memory_support());
+}
+static DEVICE_ATTR_RO(crash_hotplug);
+#endif
+
 /*
  * Some architectures will have custom drivers to do this, and
  * will not need to do it from userspace.  The fake hot-add code
@@ -889,6 +899,9 @@ static struct attribute *memory_root_attrs[] = {
 
 	&dev_attr_block_size_bytes.attr,
 	&dev_attr_auto_online_blocks.attr,
+#ifdef CONFIG_CRASH_HOTPLUG
+	&dev_attr_crash_hotplug.attr,
+#endif
 	NULL
 };
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index b9903dd48e24..6a8a724ac638 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -501,6 +501,14 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
 #endif
 
+#ifndef crash_hotplug_cpu_support
+static inline int crash_hotplug_cpu_support(void) { return 0; }
+#endif
+
+#ifndef crash_hotplug_memory_support
+static inline int crash_hotplug_memory_support(void) { return 0; }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
-- 
2.31.1

