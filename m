Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78AF7E4B68
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbjKGWEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbjKGWD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:03:26 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8A410FE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:00:37 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LKCxV023477;
        Tue, 7 Nov 2023 21:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=YmgAgvFBQBQ1RlnhG7sJhAFaYMeGOMdlXGUigYIR6iM=;
 b=ecT3GYc+Faq5fuJh0NylaCiuGTae2PBIPMnefpaYnXAO3PWeE0W4FG683HdL0cB/cIkA
 Eg6hxxu14yqCMssEa2qDywazxHI0VGe3pT9f/vst7Ufi0Ko28YzOzmCIsUJspe7x8OOG
 r0F10JgUj1sRS9TU9FxYN3wEnQF/j5qzzkKyaVlmCSDDPUchLeiVPuJJenER9Tz97a4q
 CG3RRy6+lVwY8OL7qNqxFUsci+Xdfp09LH3Xy5Our5IBqWYC262dWw8UVn+ZnkWRTMHt
 21ARJVUPpV3Al/XrvXwk7XqAGfYclzv9Z/ETXiloW9moDSoILw4ac9biAGVTd32qxxwr RA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2002hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJIKj023748;
        Tue, 7 Nov 2023 21:59:38 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w241ghy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgNMgA8UJr5MQBUNIvf28Kdgtu7+fgAZG3qhBXI9exlIgq/7nB/HUAAV9LNd7C4LRbLlmiaDex5IkdlXuxu8Nd2/qyy96TSIWaWcl+uzWdH5aqjfsN629SSFLcXpiXMY6jVaLWeCrzAAB1Hx3E51axhmFvvplk9jCe9QR42uEedkciMeQNVyqPEPAdEFzhee702jPj/MQ4QCGPwV+Kffwloq70BuWf796GRON+O+tbyml/2Gq2z0Vx3HDrf9jPCQK5+Q35GUvD5VQr5XeK4/n2U3uDIkCBvoA++brqE9gn+uwVkFNgjLSe6Hahp03ynqvBNgQlNDQS74EQH3z2tN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmgAgvFBQBQ1RlnhG7sJhAFaYMeGOMdlXGUigYIR6iM=;
 b=m94W/3r42CKM6NTbLBuzuh33HNbI0x/WUBljNZWXFu+b2UwFQrUUM9gArZ+5LImTxqDgcl6G0pRxE5ECtpKJj65CfwH6oh9x+SzPOCiIOC7Z351fi3p0eOQtCWkBPz6fxa1aOP1nO4IineF/PAIHwoHJGFOuYpWVmxfZKX48GT2ByuQMBG1J1P2vI/vpdaMeJxFDZvN1t6fV6fqGrrq7+2IO2Jd4O5WYEJCGfKzQ2LB36MYrM+GWvRjoqvPZrGIVbW8dIbzZ/rxS0L7ljUz9VHPBI2NqhSAwXm8vZUltRLm3Lg28l1nkyD+vmtdxZjScGydYnv4f/gDj3NL1A8Q8qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmgAgvFBQBQ1RlnhG7sJhAFaYMeGOMdlXGUigYIR6iM=;
 b=e0z9IIWFtpRFOZ/FqYi+9nwXYIf7dtq/vW2XcMJHVrJDdHNdxxXWsbvKERC3kEpiJ4Hc5hcDp9GDYWTKmlrqRVp6kjg5nZMwnvSlIsTnsYpKvdg0HSRXGVHCwIvsCd4D3A5xbH46soOawvmO3Arq2dvTSyGlXsWf+4ZTbARlhP4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6141.namprd10.prod.outlook.com (2603:10b6:930:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 21:59:36 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:59:36 +0000
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
Subject: [RFC PATCH 37/86] sched: make test_*_tsk_thread_flag() return bool
Date:   Tue,  7 Nov 2023 13:57:23 -0800
Message-Id: <20231107215742.363031-38-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd9d6ac-9e76-44f0-6df5-08dbdfdcd4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXfE7riqVCjzop+7ucH/vYW89KbduvzqXACrrb8f6x6X+aS2wlx10yJhEDYgZPc1Vd+heF7gQTopC1VzZHDe0RY4MtRwzAORi6esYZj2eT1eX7BQJZjvf1WWYTDu0/xmNZle5umq0ORqDF4EPCYghxVZpzKapIrPnZHY68EVNk3+j6InlI/2ddiOiL98gqnf5SZDleH0KxqokqoOQ7Hsj6pnqKQI7g8kaBiEWzIgIlH5TDBUcnF5G0DnObHkmfIUarVyHXWUCICiBhjv1/JCOcHXpc3GNccv6R5i4GfCrXxPb8FpbUATBgxnIwNXCXBMnVM4MXwT+jjJ+v6s8U7qYT6ZAu0A1ciUa4UP8RkgCDIFw+vxgiuZgLsxkjoGdFgC+N+ll/kMcOE7u8lqowWfEB1lywZ535Copu5YpsmP6TDBP1Nk/KEFvPntOKv2CACdNkGf+V5FdD9Hp7+/TJEKgYBJU8YopXtU4GCAUH+krVBiUyzAadtTq2Owa8YX8fbHULfk3OUJ+EjNH4mSKBs6Sr8VjeeqH618tlR51ed/3uERiUWXFRQjXvkrFEm1+ptn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(86362001)(103116003)(8676002)(478600001)(8936002)(6486002)(4326008)(6666004)(38100700002)(1076003)(5660300002)(36756003)(6512007)(66476007)(6916009)(66946007)(66556008)(316002)(2616005)(7416002)(107886003)(7406005)(2906002)(26005)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v8DLRKStTdgyE3NWw+DN02EqygQ56aEdrfTqr0Kt9JHX4yO9o2jaqSvWNzOQ?=
 =?us-ascii?Q?nQx17Ibj9jnt+fDnm4+9KWGIBN6uSYdzuV5pn7wqlISLOSM6rOs0hZRjPibY?=
 =?us-ascii?Q?GpWHKEkpq0uVP6m5fE5/17sWsqIKrAFyXKePM/3dFmGHAGRrhh3sHMIbcnan?=
 =?us-ascii?Q?4pOyJXma2ANCR8OA2ay47FNm/m/cRm08n4xC6VVZkFyrreev8Sgo7EFi7miU?=
 =?us-ascii?Q?ilxWFNHF+vGVBKMVoQ62S5i0H7xejkN2wrrerrfwFcAFllEFl99AKL7BNRgk?=
 =?us-ascii?Q?Opx9LmOTH3/yOEzeX/CObc0vbBP6F+1IGIiGH8jLQgJ3p1hPskhqENrK9/9G?=
 =?us-ascii?Q?+MAEa8UGeQDR2MWz1JykqkOlPsPwYdKMWr9Hkew2tWKec8Z98YpjoankJenT?=
 =?us-ascii?Q?9r6DPVZ+MnHX/U8gEYl6IFdOH5N8YoRTGTsdMSN1jGFNDBNjh+b66zq+6VTS?=
 =?us-ascii?Q?ruw0+8YQJtjmx5zgnqF7o+GvEcfgLv90WF+OwxpGQopU20QA9SGPd1rbbClG?=
 =?us-ascii?Q?cz+vnDa7W6x0miQ+SQXxDTXKHLcV7zsKXGi2nFnqI6EWn/e6hRxVMljajORb?=
 =?us-ascii?Q?bkKE3r9EYYJv9NeG3ACtQwUKODJd5wmqdM3+ItY3JeWsZmbsNEG6d1Fv3xpY?=
 =?us-ascii?Q?ZEuKwPfRVbhLsdYTxk6V3BqPu+2kOIDSSI564RaEbZ3BabJLuaiG82U0P39r?=
 =?us-ascii?Q?EsYcPvNXpU49l+TqBxiT6f/+GFhMFKepTuohPTL8QGNUHMn95i5sXEO0MH6q?=
 =?us-ascii?Q?6mE9frkkqFeQ1azjcw/6jBtHwutP45TWXgB2JgFbw4SIRCcE1KBvmtn3j1eE?=
 =?us-ascii?Q?PnPBvY23x4VA+p3hHNOomS/SXKCfmj4tKJbIlSpl5zekZU/WpeU/OX4Futno?=
 =?us-ascii?Q?mhArYXJzcvsRo7oPlvJrecTR/vf1KRjVhqjMAFo5q4d6yWlLe6hnyaSGnsD5?=
 =?us-ascii?Q?+FLChEDgEODozBQ1AcBM8xmq0ulfU8ZUOjdSWU0Lj+QIugqrBAJSeqaSQE8L?=
 =?us-ascii?Q?97o1itN1pbnd4n5aDkScd9iQjEQEpLVb82PFC0+lK/XIzuIimC+aSgK0yOQI?=
 =?us-ascii?Q?tqQBiJAky7EFr5na4L0R3cGJDSa/E0hQhvqkdJ3EyTYpn9stvCxhwcpj8WhE?=
 =?us-ascii?Q?/qeA4jqHbPBBV7UEXFiHno9O6bFBE/vVZOAYnZ95veNBzLVXUw1FPsaS/qPq?=
 =?us-ascii?Q?ElHSeX4uodzAuBbugkGQet/kL+WSNKQObCPb/nZti9GWYwe+KvC269HVI/Lu?=
 =?us-ascii?Q?H9ZF0zCOKeGWxeBrhxW7uvVn259me9sr+U5aZcCfoiTdTd2xa2W5kohumEbW?=
 =?us-ascii?Q?IfGvgXd/EILJGxBQP7If6eeR6FQxXhL+L21hdbZiRWj6Ls21a6iBUJbkdjdn?=
 =?us-ascii?Q?d5dOobj0xGd0uaxqLQpVAOpdoGoYFGiHnfVc8lN2C9tYsufx6cosufY6wg/O?=
 =?us-ascii?Q?GvH5VKQRZYPT0E3dXZbZtIeYW/9LvfUGK9hgzIVQSzcraDgIhpmxYWHlDpF2?=
 =?us-ascii?Q?aBHX6DKhPXUF2YlGhXYKWe6tmiGDg6dGZdW5N7mlN0WrQfMk2Hyp8xNPExqh?=
 =?us-ascii?Q?/JdUSQMrtOejoIPgGhmg37UWpHBF7np/GEnaw9mP8tp91k21ZLNbiuqlXVlh?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?rNFMAVWeaH7gpV5GCuP4CzZvGr/h3QgYljwE0xIft5YUlGDm/smyxhg8dRPk?=
 =?us-ascii?Q?+PsbuGgmjil5/saqhPyB5GqIIdl0fauhb/ipaLl7j5RCqnHss3d7ySwDlqAh?=
 =?us-ascii?Q?ocfxC0EkU9b1Z4+CO+6jOAT44e+OBLySCI0hvtPvUaRzbjcF+RmTfveuqkXn?=
 =?us-ascii?Q?z8AyfkaJQ9gEpyKnPfvlcxYVbbX3vTvGsdgPZWCr2khFF4eI6SuZ5ZDRZ4bw?=
 =?us-ascii?Q?1wbw/OSbiPuJkqXKPl1TQEFIRC/KcX2VwxzlqvvVV8OJCurx69R6c3QxTf3d?=
 =?us-ascii?Q?pv2NrNfWY7ngMmwdFY3Zxcs9IQfeD8pNE+BU9sa1Ry3gjvdPp3nQ7hXUE0fE?=
 =?us-ascii?Q?CLNBVLcoR2wBLLCb/2M6jN73zhKFXrJQpBpHVwd4lsIe1qZ+LYUUsxWW8hF8?=
 =?us-ascii?Q?LvaJ0mI0Zctjei6FtR52H/9NL1SQGcccnNojMBOfxD1Nf9HpVTmAW98v3lHO?=
 =?us-ascii?Q?rr4Wblo3BR/hLLrbPc2Cwmln6aaXxW8KEoLZ9/f4oJf/DUFZqZSbEoudSrt+?=
 =?us-ascii?Q?UKjYufLCuEaVPX/bBpyW9rruUrOCqKE1ojiOfu0EYWv50QLIaMOh/bPciOwn?=
 =?us-ascii?Q?VwDGw8NUc5W1PzrEKOrRreC0nrSELxnzAy1SF//C/EFfg7sXuWU8AwtckHSq?=
 =?us-ascii?Q?/coAXSfrO0CvG6PuDSSlpu66mMxwryNDFCLhsh1XvkcVmFh7JwyHbgivKBdl?=
 =?us-ascii?Q?9FU4aCwwJMtrUazdpF0bcT8P5VrKImT3L1LbknoJw7x7DKy4SViHnGM/1W5O?=
 =?us-ascii?Q?0t9GW+HQSjTWFBMGMUw6LjT6QG38NXry2Y832PaP48fXMGTM6ltxx6GfSa7C?=
 =?us-ascii?Q?+EvVq+oWgIgQY/uT0hzRTn2fDVO8b/p50R9t1WQp6F3IT1DtBAIirT5mBY5C?=
 =?us-ascii?Q?iXzp3Z227f9DU/KLY6f9QLooZYZUktnZCIbgVA4RKC94DKnN1UKTF9kRICOQ?=
 =?us-ascii?Q?7jnV1d0JlQ7rqU08mgJxJyIchAo0Z46mcVMRlkjglvFdnduugWCTJvZkFllH?=
 =?us-ascii?Q?/KZpPt4Arl7IWctxeZlq5ELEthWWyT1kxjePeenzZNG1sPr6LPkOO/BC9YNu?=
 =?us-ascii?Q?gi1rf4B1FOtqZoIp/Jy+LkN8PMybvTJQp2viP/c9dPS2ILsFUrUfEtr0/JKC?=
 =?us-ascii?Q?G3TTAUnql/+PXxUIOPC3aSfTxfYxH8vaHPXyATJSR00GWajVH35Hhqv61mmT?=
 =?us-ascii?Q?WLJt4P9TeyCMYXwaqdFO+sSlScK3lqc40er1oYMEfC8EkvxLTk9d56jNgYOm?=
 =?us-ascii?Q?Be7ffD0y1Q+PE8bftTpuXm5x869PqL26sg7A/WvVnQWON32OTmbpA2zzwEmW?=
 =?us-ascii?Q?mRFSt1yof4CosUUEVDkP6v+uM4p3bsbNCuW/QRTEWxj8wd3BZuK1XZg/4MdC?=
 =?us-ascii?Q?d2DaqgCe6sU6U8q01x3OIk49Ol8GXWtfcq0zKu03jwhMYo9pYm6DBtGGmmPw?=
 =?us-ascii?Q?izfOgEJUKdy6lWDX916zrMrZzCxdhOqB2HCCtwduVQfcMrP+VLhBXbGtsR/4?=
 =?us-ascii?Q?GqMZVm+wU87p14rRZBBK1UguTMsjn/Q8bjhK/4VIbsO4Zd7K4raizFup6g?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd9d6ac-9e76-44f0-6df5-08dbdfdcd4cd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:59:36.0638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3p7NUjtuXMOExkHH9+VdXxixp7nHdA19JM/+tDnk653+ypcYR9TzUQRSXY0nhzUasLSlk9M38v9khg9U6r1rhroYYDVpNOVRioU0CUP+rU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070182
X-Proofpoint-ORIG-GUID: 8om7VioEVbVJLYwRjxkNJX-KMP13eo9T
X-Proofpoint-GUID: 8om7VioEVbVJLYwRjxkNJX-KMP13eo9T
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users of test_*_tsk_thread_flag() treat the result value
as boolean. This is also true for the underlying test_and_*_bit()
operations.

Change the return type to bool.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/sched.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5f0d7341cb88..12d0626601a0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2045,17 +2045,17 @@ static inline void update_tsk_thread_flag(struct task_struct *tsk, int flag,
 	update_ti_thread_flag(task_thread_info(tsk), flag, value);
 }
 
-static inline int test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
+static inline bool test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
 	return test_and_set_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
-static inline int test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
+static inline bool test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
 	return test_and_clear_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
-static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
+static inline bool test_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
 	return test_ti_thread_flag(task_thread_info(tsk), flag);
 }
@@ -2070,7 +2070,7 @@ static inline void clear_tsk_need_resched(struct task_struct *tsk)
 	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
 }
 
-static inline int test_tsk_need_resched(struct task_struct *tsk)
+static inline bool test_tsk_need_resched(struct task_struct *tsk)
 {
 	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
 }
-- 
2.31.1

