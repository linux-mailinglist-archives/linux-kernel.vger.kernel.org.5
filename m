Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FB47FDF34
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjK2ST6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2ST4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:19:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66280A3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:20:02 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATFme9s031484;
        Wed, 29 Nov 2023 18:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=BvLXcIhYzYqa7Gs9WyLjXSGdjRauOsEmT8F/05xG+wY=;
 b=kxToQIHCdCmBJ7UKRLzPlybXYwkkmeZuqWRr6n6Y7iV+w5YlrkFxvwIC23MxJPZLYlvx
 rDn3VUqxSnSKzSweqBJB5ovJMnN+eG4DOq0Hq/nBrVZlkPLLzV5SqItrQoVkKydpDfqp
 lhPkmGsJxBzLuF9ACY+isI11PK1VbYOVfj0QI7d5h+ID9MOB5W7De+QmEx3fMYreDpM8
 51ZJKX345oqS3jFAAj4xv9K2A59mj5n8M5pwDlngJOBaUrUOy17DHcUHp4THkCuf8yBA
 UhXzzEluVzqJVXB0eUm1m6NoW8FJzfS5iS2ypqoijWUgm0Ap3MB1W0TWXymF/TW0laRu eQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk8yd9q7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Nov 2023 18:19:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATI5trj014116;
        Wed, 29 Nov 2023 18:19:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cerya7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Nov 2023 18:19:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSBk2utf7kYlFbMfOeweAZTZl7qYV97hy4C1S0z4cmKVbroOWXG6Dj2DKd8cFs9f3KmPrILrePHLdO0vsXyhwANQIYVHhQzl6Kxm0A1xzpALETDvbjfslctK1Hznc4fB4lAN9KWpRN59/MDnBF3gwA/7mvjM/SmPv63wwlG1iTuoKO+nj406PcgALp0tUu24v4M+P0DmTaUMFrNJOwa7h0a2bwXs1c8tgDZZTsH0zmI8KQklF/bwI580ARDSYNt/H2t5yNCLMlWhlFsD34j9hLLg2ETXebhXUYfiQkFa16eCpC7LfbM+PmFcoz4XztuyG0Qvntf5ynq3FjmUnkgNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvLXcIhYzYqa7Gs9WyLjXSGdjRauOsEmT8F/05xG+wY=;
 b=MlhLpv9IDsTrWx6qtdOtXPEnDF0/rTtF4gg3AKujBYa/pYT2LYmXUeDdd+07PycCJX3jiZAZD+j+P1CQTOjk1oTjoNMr+r14MR9Y/qkWrDp4lhZGVmOAUIWLT4V2pbjoda1eXhhY34/E9Y9ji1xEFnYCzEC4LRSPaNSP2kVPWH65d7TEv8fJ0yw0771Jdg7UuzAzATSMjAOn5rirBYA1asTeHWjJbp+/mgvMWDcbRNDJMBL80HJvll+jDnpp00xORgCkc0MrJtt5Xg/4aDb4pabc2XhI1EhBQALYpboZzW8wuFnaeHg6/odSc8Er6bd6kRnMAMS+RxJCtOMy4msNBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvLXcIhYzYqa7Gs9WyLjXSGdjRauOsEmT8F/05xG+wY=;
 b=qgMbhNKuzyFopLpc1o+bvTB7bB41LKZeeamFpImpw1FMJERbvVt5qPyPv0L3ZYaihF1/yE1xswu8o134fNCJk3kaHL2ziJhhWIOrKQlyXxKvbHUbMGz08WlvcKy/ega8lr9csM0GDeC65m4wCKag50w6KqV70VUoYS+PinO7JBU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4414.namprd10.prod.outlook.com (2603:10b6:a03:2d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 18:19:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc%7]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 18:19:01 +0000
Date:   Wed, 29 Nov 2023 13:18:58 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [fork]  6e553c6bcb:
 will-it-scale.per_process_ops 94.7% improvement
Message-ID: <20231129181858.qccz6m2id4bcog73@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        kernel test robot <oliver.sang@intel.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Mateusz Guzik <mjguzik@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
References: <202311282145.ff13737b-oliver.sang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311282145.ff13737b-oliver.sang@intel.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: 812938e8-dd80-489c-1f40-08dbf107a99b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5H7v3edL1DW7Pqi7lHvUth/HZ4FA0wfOcQv17w+CK2pI8C/e1WRgbu36DzNo+f+POrdVKxYbeRdYh52TjDD/lWiZpJch01+MadEaNZ9LvcD0eekqAXA8L8MEPZbZvx6pQ1A92BhH4E1SnwFYb+tnhcjmjCw9CAqwZVhb8Zk1nHsq+2ZaFZoiQy80a9BXW3PLhTa9Ab+HVD0LaYvbO2F3SiL+VEOAPpqSCDL+ngtMnCYOsxeRdstAB1NALcnA5KsKEimC0A0KVpM35IQsfiCxjvG6DHdg1zNSuhzh3kfhblD7IKcOhVN5jVjaSmtsq9Tksu6H7+ORvthE87AjMw9U6v3+A/ac9ual+RGoM0woq5CdtR2yLRvlYnG8x15Kkbi+DTqkvOPvNTeVOmn1S4Dkrt+2++NT5/q+AQXEBxN5zH6/SB0KbEjNUZjC2nehB/eahM22Igmts0EvH20D9lmFtuL/7fRX1OzP+OHdGKSnxcmDRT20Tqo45gidPS0Wl0TN2MQREvVAV+1rUQKYL9QAQoe63EPLHfzifofleOmIG3oZRImk24kkpRVsYOl+auNgWT0XW6DUclC0GfHlN3qN5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(136003)(346002)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(83380400001)(66899024)(316002)(26005)(1076003)(33716001)(66476007)(66946007)(54906003)(66556008)(6916009)(7416002)(2906002)(4326008)(8676002)(8936002)(86362001)(5660300002)(6506007)(41300700001)(6666004)(9686003)(6512007)(478600001)(966005)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AsUzjWC1vqii9IHeno51p0XUoivAFjWAZgRPft9MqmWsZ0jp3dccv6ZeKgq2?=
 =?us-ascii?Q?ZFpIStep2ZU7S88CoxQYpyZk2EVoQR9NbrksFyCk3vNlbK3S45JRk2CJ1Otn?=
 =?us-ascii?Q?qUfItZlFjj0aa8Cpyk9ousr/0F4zvJZfhEBdT0N+WwsbTmdCnqWbMdizRcab?=
 =?us-ascii?Q?fNVymchHLCSM7FQD70ERE8FG8NhEQDxV/4+H2tXLffSrGF6E0nRAwr+IEQNm?=
 =?us-ascii?Q?+6O3oeg1TzVgu2iEJX4PHrd9XzDb894U+4qcF4N9JRKKnbiFi5klcTrYa/dd?=
 =?us-ascii?Q?LWIT9uACbSRvpf1byNP3/WFlxJShRFTqR/OBbvoj3KWmvmpInq1DX+4NNr8E?=
 =?us-ascii?Q?PeIwVAlMy2Ash9+i67Xa/MaywaK8vC9j6ONNXQZNgEGYXUmF5AUyk4eOSx0c?=
 =?us-ascii?Q?DU6thRqqeyyYzv4rdOq12zP9EAQ38UXNLLkWYVNsaNiQupMHxQgLf0sN2VDI?=
 =?us-ascii?Q?zivkjCAYVBFAWkG5sYDiw+cMiCwOrFS7Y04TLYKJGGgcGlycHoZs2UerGDpj?=
 =?us-ascii?Q?DZTij17/7VqR0mPAXuPg+76+CQkqqC+u+tIx8V98VCehuMsn2AcCuMqHk17o?=
 =?us-ascii?Q?w0rxBl4gqy0ti424tVLRRF2USv6bTu/ZDGFNVbBL18/o2GiIaws8T0mtMAS+?=
 =?us-ascii?Q?d5qdqgd0dpsqSyaBWwohyG5xZI2G9u2BEM+f0hycenpSlW6YWHZZvikdW0VS?=
 =?us-ascii?Q?rypeTluhBNNBh+5X5/jWCk1gt0/qlcBOswH8+LOYX9je/JU/zNmVU0ZSaiVG?=
 =?us-ascii?Q?4OLUKdLo/clLBkJZTcakrDad/4XcmgwUQF/zJWwg2Gaumw8L7Xj6OM0p07Er?=
 =?us-ascii?Q?BNp59J8NJ8VXPePECc1Cvk3GxnQUAPkISvHmQ8FLPHiLJXZGNNg62L4PVP18?=
 =?us-ascii?Q?vDjMf4Uc3BhAZAYDaliBrDwAz9SUDgAfAYdKREXJwpWhQpTZSfIBuRW+Gy8N?=
 =?us-ascii?Q?KR+ZZFnqPZErDIUCYAnxoTYQ5o/J3hLRrp5YNw9j2WHqXdYVNkd0HXIeWqty?=
 =?us-ascii?Q?5+2sFXUHzs0GeY7zbXYrm8q/Zolk2LizGyD1EdRisgp8tObLnQBQCn/ID/IK?=
 =?us-ascii?Q?iUquRm7+R1ImKm/fzFDAptH3M7J3lEJBRW9rV1Iafp4Feailth25KgANbIQR?=
 =?us-ascii?Q?7BJbCbDPsz7pQ/05YepRIGYyP1aquPoSRyAyvyqT+1uYCcfSCXXdCCWsAZfn?=
 =?us-ascii?Q?xwhdgJnsCdv/qcyMW/fxnX3GRey96QTUhGOHEkGa0AN+6tSslgiCeNoos2ea?=
 =?us-ascii?Q?GZxfGQatFXVS97SEoBvDq8M/JdrA+TSZV5PjjKcWFnHThQER4WJWEtxfyFul?=
 =?us-ascii?Q?eNDuVyg1vdGlwuTRuN7BrEDwoXUfH4dm9Xe9CPbd3Cb9yIHLQ3nkFs1uKvWz?=
 =?us-ascii?Q?oYPVIt9+k1fuMvYItTMNbVBu8ATYSvqpsKoNw4FgQdKhAVdpZ80xWrRAyS/x?=
 =?us-ascii?Q?jYqt1Zftj89q7OvdbTt/4JLIH9Iw3u17dwbA0o01+HUELgLmHOlmoiEnNhfc?=
 =?us-ascii?Q?82uIpfmI+kc+bQyLWz3Zd1LQgkSedTdAeh3lfVflBkxocfHSxZaXiNCco3Qx?=
 =?us-ascii?Q?LB3cSkuER738mUS7bO7UaWcQCCLEnn+aoEcHLP2S?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lk6/EDfGaSxCkmlpYsb+lZdeQhQ+gu+KFfUhO45cPuuv3OFzeUIjDIiqmtRD?=
 =?us-ascii?Q?Z1MLP9taQBHKxeCr0qx8/0WiFogfQ2gcgbBwyLtn+yAXyKdFQwH7SwWl+NfC?=
 =?us-ascii?Q?++yjq00J7AZCFRY/14j2a14JygOHzHKKEusafI4F+VDZy4yL3mURGch30tDK?=
 =?us-ascii?Q?FaT6atWRLZ5lKWo7jB9ExUQ1dklaFZYNWiS83fWNVkru6lgcoNW1MTHxQtq3?=
 =?us-ascii?Q?8pDHVP+/X9siVBi9LonLuhha2lwcnmlUWCSivLaLlWudCY/G2F4kYbSNg7nL?=
 =?us-ascii?Q?NdU+Z5ezMYSh3+b0hF8kQtYNtHHWYMgb3+1mX3qnelys5vcsHEpqLXD/VMDh?=
 =?us-ascii?Q?0Ak/JbNyPdms425u6LPniT1Nd5eTW59KGWddpos7VfBwLJYF4G4aAhOShUGQ?=
 =?us-ascii?Q?w2JLeYDj6vFCau5RyFNm3YOjhKG8Nuo2LyS+T4YzzxoSzdAqpMRi/eViNXK0?=
 =?us-ascii?Q?Q1xfuF3UuZhmLyX6OYC2Aw/zjlM7L6jYR7OPQ+II0IZ3Inp0vsS8HnDt1o2N?=
 =?us-ascii?Q?hOFas6qp5gZ2Iw77Z1ZABOi8fpjIyD1V3ubMMcBi1SHyqJ1lGhvSzpiMzxha?=
 =?us-ascii?Q?Wp9iexOCJ8nVoChZf0QIvXbldGkfZv27dmvf8EtwZDNqUZnaq2AvwhC31TU0?=
 =?us-ascii?Q?MLvMyU/gPTHP+6JJBE+xjkbxSytVHJUvNJoZDzkEoU3SDEHQtZxkpT86n4T6?=
 =?us-ascii?Q?n0lpFMRWu0GIVl/d8+HDNV5ro5h33PagjcR6JtObT2EuiU1hDAeSMe8YqDRS?=
 =?us-ascii?Q?QbkHe7GHygUWIPdDUSJodf3ks2dopl2CtdFJChdJt+O5iriKUPHdFmwkGPgN?=
 =?us-ascii?Q?rT0Wb5CaapYZEU5vEy8qwkIR80nywX8zVZocjvvC/wK7g405a3tV7yjkNudp?=
 =?us-ascii?Q?Sabcox2rih4greBDyFfmnGf14wP3cvOz1RfictZiuJJIv0nmNeRIiu5q9pxN?=
 =?us-ascii?Q?JOP7cv3oLFz427touaM4ajrmYhrmOJnade9oiWkx+HgfqVezebEhdsbasIe6?=
 =?us-ascii?Q?dVS8B84exzIg0J3RTVeArqPVxCZEg2mLmUJ8SUidLHDGcpCdCZvFVjbMM1Se?=
 =?us-ascii?Q?23xL8uEiQWTJ/nJyos/uuUVxT3wMk8AO+R7eDTPdoSbpDOPoRCes5OmAGxph?=
 =?us-ascii?Q?3HTe1C5b3tKFQ3Gkd2WNgkWFr/E43YgppQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812938e8-dd80-489c-1f40-08dbf107a99b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 18:19:01.7200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IURnKzKEAtp3INSGdtELDtjq1YzZJFCPAO+hbb3oyjR+8MhpHFIcG60U1RjfzDhUpWMe/1igYkXcD3Qf4z5TwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4414
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_16,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311290140
X-Proofpoint-ORIG-GUID: o5RQzi2ldkvCAhQZz6Eb609ZE_AMLhqD
X-Proofpoint-GUID: o5RQzi2ldkvCAhQZz6Eb609ZE_AMLhqD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* kernel test robot <oliver.sang@intel.com> [231128 08:56]:
> 
> 
> Hello,
> 
> kernel test robot noticed a 94.7% improvement of will-it-scale.per_process_ops on:

Okay, this *seems* awesome.  I expected to see results in
micro-benchmarks from Peng's patches - but not in this area.

> 
> 
> commit: 6e553c6bcb7746abad29ce63e0cb7a18348e88fb ("fork: use __mt_dup() to duplicate maple tree in dup_mmap()")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> testcase: will-it-scale
> test machine: 104 threads 2 sockets (Skylake) with 192G memory
> parameters:
> 
> 	nr_task: 100%
> 	mode: process
> 	test: brk2
> 	cpufreq_governor: performance
> 
> 
> 
> 
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20231128/202311282145.ff13737b-oliver.sang@intel.com
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
>   gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/brk2/will-it-scale

This test was written by willy to improve on the less-than-ideal bkr1;
forking has nothing to do with this test.  It is expanding and
contracting a VMA (as apposed to adding and removing a new VMA in brk1).
[1]

The forking changes should have zero effects on this test.  Does anyone
have an insight as to why we would see any change (let alone 94.7%)?

I would think that maybe the start-up time would change, but that should
be a very small amount of the tests overall time.

> 
> commit: 
>   ec81deb6b7 ("maple_tree: preserve the tree attributes when destroying maple tree")

The tree isn't destroyed in this test.

>   6e553c6bcb ("fork: use __mt_dup() to duplicate maple tree in dup_mmap()")

The process isn't forking in the loop.

...

1. https://github.com/antonblanchard/will-it-scale/blame/master/tests/brk2.c

Thanks,
Liam
