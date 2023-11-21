Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5487F25E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjKUGqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjKUGqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:46:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE827BB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:46:15 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL6iXR9031392;
        Tue, 21 Nov 2023 06:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=VUfZqlNrcpigqxPVJMJFDwFijWP/7pDJJG1rGYHf228=;
 b=RGsqFu4o0kHbwhs0/EjistqQDhYA4p1r9SsJ0i+RwhFCGkMqLjIzLioOkk5DjNXdEGSd
 LZMcHh3KBRfFtr5iNxAuEvU9wHJYZWI+YrpfGTgwvpPTdY/7q7vDBqZ+bzQQegRYc1gX
 GR8oYOwywIFBj00wZEENopmReiVanOICPum8w5RUegGlQVcEcMRb6nQNSh1B80pQOvVZ
 jbdjWmNWXjC+D7Jre4N3T6e34Xp2fa5b5D0KkXRIJnoi7YZDYlnR5dSR/JHJ1WcwygOs
 USy3oq5wfXmCZCVTUvUJ3jtVU3Ds909WQs7RlE0GS9ytwBtX3susHpE7++6Hs0skKYEw tA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uentvcana-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 06:45:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL4qAtt040733;
        Tue, 21 Nov 2023 06:44:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq6873g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 06:44:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtO63F3rrG/GnZ/K9Y8OvYOBJ1vA6Uq+Wn7rwaiHbYVWiy2GatfG3UcMeKBraNrlmEVKi2MMk6oqk3/XwLbkxq5jp1rx+Pm9EhSxgFOuwkapQBcLV07OHOk9i+Ephufs5U6kz+TNTayJfagh7F+mpyupTEzTBJWBQgnwigBsz/bKRTYIysC43nOgTZOhbD4ys2shvFiBbcvum0DS5+Xy2ugrBrQ+hUAOQghv37izvw5DnbB/OBZPwH+YKMojbIdEaWUhBoz+YVoUKOv+Z8wc1McFQX45aPCuaqjbnwztlOg8tZGKqOK9C+O61fjYlSNXTuYQd3c2ElvKvCDWLYL57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUfZqlNrcpigqxPVJMJFDwFijWP/7pDJJG1rGYHf228=;
 b=X04NkhoMaeQF2iO/6aFmxJVN5+yzgxe13t3Sju8wuZXgSAVFviMseViPlfHsjS0D0Xo7B1scI4BBpSOTEVEYSXFlHHBNEhLEuSm2rLeJAGyLioda+TAXqoibGJcTYxcRkcnWEsorF4XbL2Dt/eSlLgQyIq39EY9nLylBfISGaMYWm14f9fsRIFBQhl8lf/PUi8qC+pQOqPxtG9bAdPUCUXXBJ65bIMNMZQZ9K987oNxwWGc3J1Nazxujs8g7c8vya9WR3xM2Bmg3LcV8+5Kz4UkJiG+JZ27XtuGz1Fei//nxl6F8kPg5ecra2yBA1dmO2/lYalMHuoH+HRlYC8RbwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUfZqlNrcpigqxPVJMJFDwFijWP/7pDJJG1rGYHf228=;
 b=At4G95VPcGePyi4PejTJ1g0iMvMNkccRu/Zv1zKj9IHJSmXHDSNMaCuT6PLO554lELOfeCy13tUEjZCyUMw7l4tQg8TCeaJuQ5nVsSCanLsIsbkxd2lnavDlRCK8lcjxNwfOQTKFJpisyNlVsFueWkEFrjV6S3K8LEN9Aq8K1DA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BLAPR10MB5236.namprd10.prod.outlook.com (2603:10b6:208:321::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 06:44:57 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 06:44:56 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-43-ankur.a.arora@oracle.com>
 <20231108095600.GM8262@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
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
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 42/86] sched: force preemption on tick expiration
In-reply-to: <20231108095600.GM8262@noisy.programming.kicks-ass.net>
Date:   Mon, 20 Nov 2023 22:44:50 -0800
Message-ID: <878r6ry599.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0065.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BLAPR10MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e366f6f-2916-424d-dfed-08dbea5d5fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M25MYjHdjAHU/mFwekUI0kYl8Fw6DBq0pSuPLAhhnngrtpGyJOBW4ClxGXePdVUT+DPzPiQVzMhU6Fjpsc2BOmN+SuYny4yWX3tuyFIJfDzAo+sVI/+6LXzur3/+uouuqp3/Nm+NzlZtH9PEImbKDo3ukzp0+Gsw5hN1Hn3tROcgeSsCY4MrYSl+ouOSHEjtk3K+ktv6DM3ZSIMqIFxdTbhZOX6hMNohm1f/FHWybSFjFIL8Xay6+dsDOoei+rp5ShUhxzbVfiuFT/F5lyPUFtZ7j18zbQ+sKsZmqFw7Zqtq6Yh0K8s60rmtBMNW4bNDdGDPYn8h/B7xHJG6/tCm4jlU2JENcpDTTurFlY1uKxig4rss2/wbE73O3D9/2hvK2ZEC0M4PSz8urVJfZ6+SzdKOaPdKLFa0juYa7cokkTAx6gya8OhX0lD7uzyDj1AsNldtc/CBdb+vNCqSCu4IkV7LNG5GiNSxdcaFxFORNnsJijTtHhnTUq0RcFYsxPlFYDnYi7bYcEOPkfcJhrVl8yhCCyAV2bx+i9rG4jpArtkeYT9Iqrwu2/SL3PyrQ9e/6YSxFt6Uji++PwwU2TGCByRpJiPFmA73wcx7kl9Gj5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(7406005)(7416002)(8936002)(4326008)(8676002)(2906002)(41300700001)(316002)(6916009)(66946007)(66476007)(66556008)(86362001)(478600001)(6486002)(26005)(36756003)(6512007)(6506007)(2616005)(6666004)(83380400001)(38100700002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jDJE5mdHOpOIw9VPdMSJNIjWelWhsDm2q04suI/47/FVT9YM79G1IUmOhR86?=
 =?us-ascii?Q?SqDFONng4hzaH81Rkir4abg5w4xZ34NzKL18g0lU8J+q9CTyllhduiJg8EH+?=
 =?us-ascii?Q?lRfsHmeQC9CbbZQXXX8d7gyrYDqkV9AG+0NWigzGDW6zBEmLVeSjcQoMQJS5?=
 =?us-ascii?Q?alNWGBpjJMHEbfLHdt9s8Em5tRNbmElYgpzPyjpHQl0w3SET/2eSadAiqd2/?=
 =?us-ascii?Q?h8ipbx3gXPlkvmcb2evutWbe2DrOIE9Q+cCuMMZA4YQu8BLz7cUxoa7Xol91?=
 =?us-ascii?Q?u2f3H4/Wzy9fSPSzQ38pBorxlsUWxNIFSJyyZwEsAWhQf8fWqaVHd06T9Wv7?=
 =?us-ascii?Q?TXfnEmK98hTnjOvMAUtA39yv6VF+v6sNNhOltdT4XEh1P5voTtyRYbYEdECg?=
 =?us-ascii?Q?I40ImQorFr7M8/l70Gm4LVqrGzT9iCYb7OH0wrnLAcGQmdlyOjQdgXaBVRWp?=
 =?us-ascii?Q?qtvAkt+ZPe8L71gU32IIEffTD9Ll6IScF31Jf9CpiY3pyrzp6TShLRWo20Kw?=
 =?us-ascii?Q?eQ0pjBj7VlNFBFx2UEMybe9w3/HLT/8ocSppNF1aOBl6QepwF+COIwzYpov4?=
 =?us-ascii?Q?1VRmrb8Z/iWckiUc88BEpXrutTkgKfO/xGKzqHIBctO23Dt1FC6/B2MzjONq?=
 =?us-ascii?Q?X72792eiCJ6y0NZs0+ngBiYnocMCzc09qX40upEHq+lpGxIbLmVuvcJTyJ0Q?=
 =?us-ascii?Q?QGVHL8dVH3VC5mydmr/fo0FNmyn2y5DzZYIEI2HMYRNnOlyYDCCueNA4HEqh?=
 =?us-ascii?Q?ryDPDD0bhahLyaWCVQXud1Z0shhBAfr1yD3vQ0btWuQHXqSQfLqZHtOny8NW?=
 =?us-ascii?Q?SVpHNs7DW4sejyubPayFmBsvyXYtxK3REyln+k3seT03gMIF+7GwmOVMU6T+?=
 =?us-ascii?Q?L9nlVf7cphwPbtkIpyvOtYoYnDKAWVR3dGebH67Bv03FPHO6jbT31/2cPjAD?=
 =?us-ascii?Q?Qh86W4vdlLiA+JPxO69Js6i6LunN+Ku9f1ByEUp5MwPnHoAv26FHbAi8hp/P?=
 =?us-ascii?Q?K3NBOK+yivJ5r4nd5ra9XQRetgd8QcHCQ7Nx7lUbZ5F+qdKJXcrCOWotGWQu?=
 =?us-ascii?Q?EfB8vc+qsma/XFkTX5plt3VzganT3a/T97SuK4CZF9JIoIE3jrjlnHpQSHLH?=
 =?us-ascii?Q?iqbhY7My+/E8fj9jjeKnW7Bggd5F3zPrgmgJGCvl8WRFz2gKJhxVUk6Hj2wK?=
 =?us-ascii?Q?UDi6IXe1D/xPn9Al8ZroXTQFdSDwIhdQPWL2HsXL1QagXE//mSumy3jsoW/K?=
 =?us-ascii?Q?anUO3d4Uu2hfIjXTbxwPLonr+mLoiXuK5iYwiSJTosQfDq8h9NX+9wnseVmB?=
 =?us-ascii?Q?3kMVI60xoZ4hPPIqq0rB3pDuznoL5f82RJrQdNGYYJdSe7vyJOQJeFKCRPya?=
 =?us-ascii?Q?2GE8VHBXsrAfX9riEkbjjhQ+uNdz8ZjQ+fqOgavhfIhfRhPXswcIUGit673z?=
 =?us-ascii?Q?BPWhJIzHKCA1+hk0NAMk2Y/kum2AJQGSI1rWnqUAzIJSTpXEr8zsahFlZwah?=
 =?us-ascii?Q?rUtIEVTMkUUCBIqCleblLUEYPzYciyTU3biqWWWS7VGTEP78mK5qdSSTu9N4?=
 =?us-ascii?Q?AnSVMRFk4IYIDCvPc02VhtPUqLvdv0huz1O1C5t6Tm3vvwCnz0/q3MIDIC1F?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?SAYSLRO91ha1hZNLSsN8U/3Lcy8SyRTTBIynapHR14DHzKzFjzmZGXGJd3fy?=
 =?us-ascii?Q?nwKu41/faWaZKi9/QLDsQ8N4h52di/vpWkca5wHL1KI3LlUxsPzCmWDyXyok?=
 =?us-ascii?Q?2j7dyX0ITeUFXDbHFK2wOFyc5xRCQViUuKcwoJl5b9E6kYNcrbKKZsXtjo77?=
 =?us-ascii?Q?R6CaC6BHHRMjJ+XPrefirPuWbY6vIhovptQdpSSDwnbdsobvyo1N6lKZU8ae?=
 =?us-ascii?Q?cZrZhh5nwrOOHXqzg432b+zuFDB87XcyLgRTE43p0egJ2cFLwwvak97NUT7y?=
 =?us-ascii?Q?KZZEnCPYgUhVoPT33I4CzhvO7QmO20IiBShnmLivbmfshghR0fHi2ifLr1hx?=
 =?us-ascii?Q?8s8zAASdXMFztxVpDMRVaMwPZxYDkeNmQvaGbFEnWkEPgu2/AMlfocup4rgc?=
 =?us-ascii?Q?qulmqabbaflVIOE9uL+VadvqzkInXCJoVwPLKnEEJ0Ybvjw8jcJb1boSU/29?=
 =?us-ascii?Q?HQwp/HruNQ/zCT5lr0yKhIlNDHG0Ka33OaXjiWUXHw21jDJNJnf+0URHJZbk?=
 =?us-ascii?Q?LbQa6L3qswCjjGNj+S37QMlt0Oi0LHcHgp0GH8OT/j2YvG6aHQZ8Xhxg2kF0?=
 =?us-ascii?Q?82D+Mmfh3SG0lB9h827TV6yP+0Q8/kS4t0BJlPkR9UgF5P6e5GBDfZVhYpgr?=
 =?us-ascii?Q?PZ45/eBdcocEFpOREBeXBWJF/1F8bY/DiExOGhVISJNiH6alIGctZSZoJ3xG?=
 =?us-ascii?Q?FvQJvSzEl+mcZ4AOFPsFT0tRqenxxmJR0Vsx/XgVLcamEIQjlXSoBRQEYp1j?=
 =?us-ascii?Q?RtSVuyEkVTArxdAw7SGKfnqXtcr8Rbvpmn0TsiQu8jnjdzWZZVz/vSXKfE3Q?=
 =?us-ascii?Q?4lK2R/mVuDJ4c1A6H0dhYKZmLvFz9B8EZ0da3vekPwKu0JPZLdEuzp6URi7c?=
 =?us-ascii?Q?yekmpcC3LLftkhyrTEXlX0Ixr9NARmmbeRqgd8asH1/vGWqZH2pkagMYwKGj?=
 =?us-ascii?Q?m9LfbbCXkndkNzFoWAbOU3ABw5PpuW/GcqUxSsfNBlbeuK76r496E33DZITz?=
 =?us-ascii?Q?Q8Z1nJLx9lOEVPwe76EUmVOung1psG/sDVMya+X7idbw/29TsEYTXXMvSvSV?=
 =?us-ascii?Q?q0GvWwjfu8C7TNH8sn+NuXQlkewRFtmvl6gK17kvBaRFE0UpGJfWQD0VNkcP?=
 =?us-ascii?Q?dl4EQT4DRpw60VPWJV//7dg2aqdoflt2MF7dvVVpfGIxykRAtJ6tKg8X2kh5?=
 =?us-ascii?Q?7baU0VknYnidnxOB4T9yFGJ6zi6uD1YhUfj00U8ePLPMkvz4OE9Rm535CT80?=
 =?us-ascii?Q?x/C+yVUSnaHF30bzKIXzLVJZI20Huy5FcI12nFacPMux9pzvlhxR1ax8t94i?=
 =?us-ascii?Q?560sqCVpq26FBud5q6hpFJ9esqJ1OX+OvPi7Om7fafOFqi7PLbgub8Sz9OfN?=
 =?us-ascii?Q?Z1JaJ1LxzbMurdJLKsDPgmltPnFSDC1UPhuJNlWfkZZfbyyjVmHnAt83PDau?=
 =?us-ascii?Q?9NOx6bT5ag+3h93XDwrg3mnenlNwcI+Eu4O//sbMHxIpC8VQEf1+C0OzxCO8?=
 =?us-ascii?Q?ALSLqnkWkovTFj78hcq3wqfD1LEiWZW7kM/NTXTqQr76PFyQ/pMN0E3Ehw?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e366f6f-2916-424d-dfed-08dbea5d5fd2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 06:44:56.5346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxXpbr8qfkc3fZJT8U6gSDioATGOF+kbRdo7IXlKCpFJjcUD3+LMhWTBTSTTzdMF9cuuQ/5el8TZr734oQaIi1PSDVpVsstuSW7CHwFEbT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5236
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_03,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210051
X-Proofpoint-ORIG-GUID: lQu77oHmS2Qg3wlAMQjIvGZ9T16vVnKi
X-Proofpoint-GUID: lQu77oHmS2Qg3wlAMQjIvGZ9T16vVnKi
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Nov 07, 2023 at 01:57:28PM -0800, Ankur Arora wrote:
>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 4d86c618ffa2..fe7e5e9b2207 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -1016,8 +1016,11 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
>>   * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
>>   * this is probably good enough.
>>   */
>> -static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
>> +static void update_deadline(struct cfs_rq *cfs_rq,
>> +			    struct sched_entity *se, bool tick)
>>  {
>> +	struct rq *rq = rq_of(cfs_rq);
>> +
>>  	if ((s64)(se->vruntime - se->deadline) < 0)
>>  		return;
>>
>> @@ -1033,13 +1036,19 @@ static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>  	 */
>>  	se->deadline = se->vruntime + calc_delta_fair(se->slice, se);
>>
>> +	if (cfs_rq->nr_running < 2)
>> +		return;
>> +
>>  	/*
>> -	 * The task has consumed its request, reschedule.
>> +	 * The task has consumed its request, reschedule; eagerly
>> +	 * if it ignored our last lazy reschedule.
>>  	 */
>> -	if (cfs_rq->nr_running > 1) {
>> -		resched_curr(rq_of(cfs_rq));
>> -		clear_buddies(cfs_rq, se);
>> -	}
>> +	if (tick && test_tsk_thread_flag(rq->curr, TIF_NEED_RESCHED_LAZY))
>> +		__resched_curr(rq, RESCHED_eager);
>> +	else
>> +		resched_curr(rq);
>> +
>> +	clear_buddies(cfs_rq, se);
>>  }
>>
>>  #include "pelt.h"
>> @@ -1147,7 +1156,7 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
>>  /*
>>   * Update the current task's runtime statistics.
>>   */
>> -static void update_curr(struct cfs_rq *cfs_rq)
>> +static void __update_curr(struct cfs_rq *cfs_rq, bool tick)
>>  {
>>  	struct sched_entity *curr = cfs_rq->curr;
>>  	u64 now = rq_clock_task(rq_of(cfs_rq));
>> @@ -1174,7 +1183,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
>>  	schedstat_add(cfs_rq->exec_clock, delta_exec);
>>
>>  	curr->vruntime += calc_delta_fair(delta_exec, curr);
>> -	update_deadline(cfs_rq, curr);
>> +	update_deadline(cfs_rq, curr, tick);
>>  	update_min_vruntime(cfs_rq);
>>
>>  	if (entity_is_task(curr)) {
>> @@ -1188,6 +1197,11 @@ static void update_curr(struct cfs_rq *cfs_rq)
>>  	account_cfs_rq_runtime(cfs_rq, delta_exec);
>>  }
>>
>> +static void update_curr(struct cfs_rq *cfs_rq)
>> +{
>> +	__update_curr(cfs_rq, false);
>> +}
>> +
>>  static void update_curr_fair(struct rq *rq)
>>  {
>>  	update_curr(cfs_rq_of(&rq->curr->se));
>> @@ -5309,7 +5323,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
>>  	/*
>>  	 * Update run-time statistics of the 'current'.
>>  	 */
>> -	update_curr(cfs_rq);
>> +	__update_curr(cfs_rq, true);
>>
>>  	/*
>>  	 * Ensure that runnable average is periodically updated.
>
> I'm thinking this will be less of a mess if you flip it around some.
>
> (ignore the hrtick mess, I'll try and get that cleaned up)
>
> This way you have two distinct sites to handle the preemption. the
> update_curr() would be 'FULL ? force : lazy' while the tick one gets the
> special magic bits.

Thanks that simplified changes here quite nicely.

--
ankur
