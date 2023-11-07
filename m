Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E4C7E4C88
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344174AbjKGXLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbjKGXK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:10:26 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A834A19B9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:10:09 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJlMc022696;
        Tue, 7 Nov 2023 23:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=2jD7WozsO3sS0iyfqYqPRu/00V2ZOC6HVnfrprImW20=;
 b=EhwtlKrLrvd6cEVBar6TXc5IuLxYWIuN+x2cBO2h+r8Wu7owtWz7dHDm//PSwE31y2Up
 XDi7Ajq9aYVAWGv6iJ/dm+V9rGN77YLGKXvqhah/ivzncbsVvxQQFolwh4pBM8o0AGii
 gf5WS8R7C53tW1lZ2ceMXNNm23KMrkwaN4BDi0M4jUx4qRQFtUQ0IYF6oG3IBCoDEoki
 0gDU6QQLN2UTxGc61PbPZA7uWa3/UpzyOokCAGKTzHiVDVLu1I/XVwjxv7Bxk9MU/O0n
 gjbw87d9UY8qK5lv0kDO566AVuElq6OenxbXStLu+47l5iHVa6DlnvaBuDkPZ2cww7VC TQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2006f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N31DE000659;
        Tue, 7 Nov 2023 23:09:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wvdcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhxaafEh1PxEsEmewSzicAsbTGYBbS+qTrbhCbG/9jJ7RrCdsT/rSq3qb6XzTvBWG5jDUE6EiDvFFHBaEv6dh/OvJRLQ+XTAemPniidqSHbNxCTOe+QJ553ZkCuw7WhwnRBk0Q29BgqfdF4ZL81tFGvrTgupmCyyPEUdZOIjvW5j13huHY7ntLa1mQu+4gMCxN8UDwx0tUR/ZpHfyQ6pt97aocSctpKHBEPi6EwmjHDlbt2sTBtuq8sA2zCgP+on4ieX3Afyu0lv/zuVz+yVZWSphMQqR8iq7YBzqC+bsziGBOY+ZpHZqYUmZqPWFje0wj/HEiTckT0WV/2xZvlm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jD7WozsO3sS0iyfqYqPRu/00V2ZOC6HVnfrprImW20=;
 b=guFr1ZxJsjNTzH2F8PPl2IrSJHHVztZsWCytv/OMyw3h4NGAMJalEN43ulsjfMuwv2vWMr4PwNAsmh/XNnC1mnBaQnnhb1CWbMDMxR6VZfZUNUNfNqLAv5PViMEOQkyiF2sy5FfM9f+sF/g5Xfj8gJ0aNOgEMF6c92ixeRhESH77D+aRE7+5IcKgIbimXfvoDjXuzOhPkcRAiBv50ZD4+XL/EzNIPJY6rnjCDO99o3jwMnPOVMa65IDqQu3jM+1PIneOGMD9sGH0lBcqdI9vIywMDvMwjgYCyo+WFVF8IpGtLVEd8MpVZA0nnNPXNZsA+MtwpE+FgOyLK+6RG7W4Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jD7WozsO3sS0iyfqYqPRu/00V2ZOC6HVnfrprImW20=;
 b=v1L7Z2RgmWsKziVrnAm6MU0E93ZHJvV3mOQYd75DwXWKDLmX1gqWExTiSMOlfP0NE/qRK9X1J/fZtKY/jUo1uiDu5nkksTvC5YTp4ZoPtZ1TbKECL57/VhojSRIEBa/Yo9aQUVYWo3lLgxQbltD7iYryXQE2llJQ1aod67CH8a4=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 23:09:05 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:09:05 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 69/86] treewide: io_uring: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:08:05 -0800
Message-Id: <20231107230822.371443-13-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0038.namprd11.prod.outlook.com
 (2603:10b6:a03:80::15) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 037a34cc-5da8-46f7-22ef-08dbdfe689e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6HAp59nF5hzeS0imqUZMsnhLBbyHRKlOz/Fm8KHZfM89LujnA66rZb2grngam+KCaaTGNkXs3goCMupTPfJbbT0A0MEvS3GtWn3dGq3yU0KqBCBvyze0Np0Dod/JmdIW8QTQ4Wv52uWLjkfsGXVnuo/hDfOi+yDJ/QuBKd6b2Ae385FIi0jv3Q8KAGbcGgiGS7paXMHSvWMdYfFJkesBA2BkhUfNqX4hp/Gsh9wG+6PGHdAkY1RoYvxwBOXASvDlGIFE5F6zZLfWrwjjEdeQ8t0b6g/suHxyDNJJ8WD5U3XkoOlLuuGGBc9Y/wp8OBsS+AHVC0jazjCB8s0W+Vs/aDIz/QrmYzxhlAp9PPFeh2P6Nm6hlxFxDQksNe6GS0cygM5RNAv50Z3BQ/PA85WQXhL4EMY7s+/F2ZpSKPvMlS/+0pWFgTxzujJ2tLfsQ6QC99PQxgtI+PUJ0l2RXSUg5amunqDJ2qyNqtpckbmA9GM/oekjC3LL7fw45JjbO0IpQrd+kL9hlZOIQrqYY5EbXB1k8lz6reAx1sFRjZ0pHz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(6506007)(478600001)(6512007)(2616005)(6486002)(966005)(7406005)(36756003)(103116003)(38100700002)(86362001)(1076003)(41300700001)(7416002)(5660300002)(316002)(66556008)(66476007)(83380400001)(2906002)(54906003)(26005)(66946007)(6916009)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?07RocDaw0M+5QCCN1Q+HwGsucKRA6Xk9wKBG3KgpT/PmB0K3NnKl53C9ydqW?=
 =?us-ascii?Q?X+3nqgAyK7935NvVlRICoen6V4YwnP0/2CIxdtfGhg3tjcuZ8t6UA/wOnTLF?=
 =?us-ascii?Q?DIEq/sA1g65u+FS+buXFL6P1LzF9i4BbkHAUdtIS5Le1jhkWTCcqvLuuHL1P?=
 =?us-ascii?Q?2a7zHR17jIU2I5uUy6f2pHTou9EpeyohkLiaUD/XQHcby8zxqqe+h/CPoXJt?=
 =?us-ascii?Q?rZFRzbbmc8y+KlTA+xWdQg5QVxpX4RoSRC56scrdSwgrPPTmL217go1KPUhf?=
 =?us-ascii?Q?PMRVlI/r3rwamhtg1yZUzsxEA2/YiyISOnemwaGd11FpwB+z4u6s68ViIyRe?=
 =?us-ascii?Q?WK9HNOQIGwVDOU+Ku5J+7CoRNus6moaghZ6XHj1YJdBelCGu7ky+4YtDS+Bc?=
 =?us-ascii?Q?KUHN8Ash7O8kMtwAMy94ZT3mslYtu/ctyzPpr9VUQuanTTUvbcrPFjPcKUHe?=
 =?us-ascii?Q?QNI3kvegIAFU4X9E5c/BkTZVI55uYQTIWSSeO4OB42J4UJu1n1nlh8MBqKJ+?=
 =?us-ascii?Q?N1FduTeRM1Oei4xQ3hHC7eFB0EQgtYpOeqFCxn2w9kUf7NR1d0gcSQT9rI2m?=
 =?us-ascii?Q?94cIVBQYEwhaX0tLxpvVcpLlfVsZwwQklpxboSHNj+pAC6tCiFKiXx28JXfX?=
 =?us-ascii?Q?+sm+2A38ssbS8WIcVGuBRV5/s3cNeMvLsj8+otPVU7+Mn2G5Yya81gdNQd5X?=
 =?us-ascii?Q?4uLucR8vpQfshS5124lXrvIhxGJgVXbrSgb/A4Sc+o3JR0GaCY6NQxNobHm3?=
 =?us-ascii?Q?lg9xOL7z6OyIJHhc2Tjl1WyGmjVzevnXf4q6WTeli/J8l04jadVAKnECIHPY?=
 =?us-ascii?Q?hFAltXwWaV/nULJmKHH26QtWt/rpY+l0oc+k/+FqusbYGBCyqb0J94NbYHB9?=
 =?us-ascii?Q?H9CkeQNROhXtDRsTFHgSmprff4uqZV59KJSMM5ORJMtLQCYrJ8uUtkB1kCo+?=
 =?us-ascii?Q?R3WdTXCKjCFR8nLRJmkrGzii12m+i8LqwMYksORUAMzkR/W04ybjkrWMhF7E?=
 =?us-ascii?Q?xmqFF6DTFklAWUfjRmuTH1gi1yUkRizkXs+uOLlKfdMtBg5rpvJ7HOFryl/R?=
 =?us-ascii?Q?I9i+Xvo6E2pFki90NqwhosxnHC1f/0DlA7woTwlIMrN7/SMgWeCFmIq8dEyO?=
 =?us-ascii?Q?t0O/lvU6qmrhqS0c8R6PuNGPMuvKXGyHbpj2VVQXk3BfZn7yV+pRAUUujseG?=
 =?us-ascii?Q?ptV2tld2MKrMy2XWy+vdtWpaVXaMOaLaVFw4GJMamywU16Z4IIfcJ/1HxaSE?=
 =?us-ascii?Q?u+20sTpeomPmMGdp0jhespA1n9GdVWUjgmx6SNgo3+4GdIQO0C3cvCw6COBS?=
 =?us-ascii?Q?q+K+OlMAts9Ha5IJhy7ve5BUT0wpyjxmcI9n3lc/UMsHdWKgbxYPcJnrpByz?=
 =?us-ascii?Q?IiqI/35yWNYqe+nVyj6G3kPkcdx29E2ge2DZBIQL9bWk00h8YG5Mmy7bPT6a?=
 =?us-ascii?Q?vNBQtHMRGF1kj96wzalzPSqJG7U/wDFLDhI3xmXZ5Lv257O7vmMIIimmdpuy?=
 =?us-ascii?Q?Lm0AviFdgRTbzRfXMsIdz2wotzupFWo241YdAA+mxm9n4M5QaSwL6X9e1VrY?=
 =?us-ascii?Q?sJ0B+1yhARNO5cGOIdCPsHq/Sldk9TqfWcudVfCcu//Le3wZRM7eSMqk9Ttp?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?uxEVwVFJMv3ahOu6AXyroYuJ9Mw5ND5OZBRQIxNO9dFvjBZPELh3jJMKOVAs?=
 =?us-ascii?Q?Im/muYE0ILQYMrDh3eD2IFLfsA3AdNX6x5DSrd1w8GPYhOM9s9NVOT7By13Z?=
 =?us-ascii?Q?kEAgNazmrmrfhwz36CLsgGfBma7HlZP/X199mR0jMxU371vW1mFeeCyOMYbX?=
 =?us-ascii?Q?w6l+wzWorApIA/LwnFYFGgJxSwjH57wxeUJzg5byhfucA1TkUZF4/sBI0s/+?=
 =?us-ascii?Q?2CM1S9UcD1GW09HbyMm4V3F1J7B337PZJ45Ve3dINpEs0WbbFAIevyvrHqQt?=
 =?us-ascii?Q?ilSuL2DwRZYVrranTDSmRh1El791v5lZdiUzWymjiu55O0zU8JUON3E8RJ1X?=
 =?us-ascii?Q?/IQXofHGWXVv9kIQA9hhaIfgYeAEH1NgFuHKCxUWYwRVv3MHnF9j+lWOiLwH?=
 =?us-ascii?Q?NrFwbgp7/o767HukAWPxVq8na9tYK4D+dEXqB84r7jhsHyJUJyEf8pZbsgCl?=
 =?us-ascii?Q?iT5iNaU8tlWaoWaxmD/hMz+LHNrgoXO5x/B9Td1pEDyLejXdMf2fyd2iQLOV?=
 =?us-ascii?Q?xvmoi+RiRIOlWvokNAJwqEZuWmId2cFBN9A8gmEeYRBG/h0BuOGC1S2HcUnd?=
 =?us-ascii?Q?HFQLwSjUHqdWff2ow++AFEY1bSLopzxF+JU9xnvCjopO6jj9mWPaWeq+u8Pd?=
 =?us-ascii?Q?lf9pFwmPeZCubedrJkQF7CMoS8vdiP1pT6uRybp7/QVY9yVYYK+yEgfCTto8?=
 =?us-ascii?Q?Mb7pho+X08mBUXFparMJ9ox622rebabeQStGT5f9X7vdO02KrDJjj9yM0rEX?=
 =?us-ascii?Q?psartyUiSpKf2CNTgvqPKK0joWX3Np86oC54VmcEvVvvFJLH+kI5lfIdTBLf?=
 =?us-ascii?Q?3SRe9e8GtMv0NvEylr7cuGykKP0HoB1odqyDQf5hb0pDTmx2y/14PLDLoGKf?=
 =?us-ascii?Q?/BMFSxCGC/O8epDpGdDSfYSoPOXJiYWkHr/ymccHqwMrCkxrnI38iYsvL8ar?=
 =?us-ascii?Q?8mZKUwTjXL8IXyADfngA6kL82Yi/lvX57EUzrXSi77wS1RzpKjDL1+Z6VpjL?=
 =?us-ascii?Q?QRuKLJ3R6DrrkCJg6W3x6knsvXrK7EsdWv4eNgYlc8itlzCNZq8+YoHEPakY?=
 =?us-ascii?Q?ZL7JfGqD7k4wHPplR6A3T53DamZAaARUxYCv4jXxmEdNYgpMGQEnSDvFWRcy?=
 =?us-ascii?Q?OSYXaO005684kQHji9aJcGltfaOlMsciU9aAg7du+eRg9Qg1isnTAe2ajgKN?=
 =?us-ascii?Q?wV/QqCkMUV8j99+RDqByjbnUIphLNdMVxGLnwCwfZUWUmwBs/wmqDJQsO2+o?=
 =?us-ascii?Q?ni5NtIS4W1zKCF3iF09fj77cndPIZ2mEJM1PXJoOzRcSySPadyiFeUNi7Zjo?=
 =?us-ascii?Q?GP0FtVkAC3GcBQLUsvF2LmYgmDxUCvmKCEDjzz0JO0UQA/MpeEbrsrlTE5tm?=
 =?us-ascii?Q?Y7TuOvsaGm7styHgFnq963XaO+qKejuWJaBDD46SpXEBJuqZ0Ot0CMjQHJAH?=
 =?us-ascii?Q?TVRQ2fOLa3mGKqbi3UwRMM/wgmuqbrfsRP71gQ8BnTsz2BIZjfLopQRBh2Sk?=
 =?us-ascii?Q?b+v6+FUC3sKnr8JQmpeTlm5lDNa6QnoEbBo/w45fUJXc43Gvmo1YFRE4ASOl?=
 =?us-ascii?Q?lFrwCtO0mAfd8EAJ2CY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 037a34cc-5da8-46f7-22ef-08dbdfe689e9
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:09:05.4180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYrSngIXJnnJKtafpAIa0RwpROW+Bgot+DXJbLp9pZEgvkLm+5VUR1w1OcJAunB3ehHRUteZIYIVQq/ogOFl9R6acaX1FsZtdafbUSM6yg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070189
X-Proofpoint-ORIG-GUID: ZIktjL8K13Zfb5YT99yWNidmuPLZEr1J
X-Proofpoint-GUID: ZIktjL8K13Zfb5YT99yWNidmuPLZEr1J
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are broadly three sets of uses of cond_resched():

1.  Calls to cond_resched() out of the goodness of our heart,
    otherwise known as avoiding lockup splats.

2.  Open coded variants of cond_resched_lock() which call
    cond_resched().

3.  Retry or error handling loops, where cond_resched() is used as a
    quick alternative to spinning in a tight-loop.

When running under a full preemption model, the cond_resched() reduces
to a NOP (not even a barrier) so removing it obviously cannot matter.

But considering only voluntary preemption models (for say code that
has been mostly tested under those), for set-1 and set-2 the
scheduler can now preempt kernel tasks running beyond their time
quanta anywhere they are preemptible() [1]. Which removes any need
for these explicitly placed scheduling points.

The cond_resched() calls in set-3 are a little more difficult.
To start with, given it's NOP character under full preemption, it
never actually saved us from a tight loop.
With voluntary preemption, it's not a NOP, but it might as well be --
for most workloads the scheduler does not have an interminable supply
of runnable tasks on the runqueue.

So, cond_resched() is useful to not get softlockup splats, but not
terribly good for error handling. Ideally, these should be replaced
with some kind of timed or event wait.
For now we use cond_resched_stall(), which tries to schedule if
possible, and executes a cpu_relax() if not.

All of the uses of cond_resched() are from set-1 or set-2.
Remove them.

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 io_uring/io-wq.c    |  4 +---
 io_uring/io_uring.c | 21 ++++++++++++---------
 io_uring/kbuf.c     |  2 --
 io_uring/sqpoll.c   |  6 ++++--
 io_uring/tctx.c     |  4 +---
 5 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 522196dfb0ff..fcaf9161be03 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -532,10 +532,8 @@ static struct io_wq_work *io_get_next_work(struct io_wq_acct *acct,
 static void io_assign_current_work(struct io_worker *worker,
 				   struct io_wq_work *work)
 {
-	if (work) {
+	if (work)
 		io_run_task_work();
-		cond_resched();
-	}
 
 	raw_spin_lock(&worker->lock);
 	worker->cur_work = work;
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 8d1bc6cdfe71..547b7c6bdc68 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1203,9 +1203,14 @@ static unsigned int handle_tw_list(struct llist_node *node,
 		node = next;
 		count++;
 		if (unlikely(need_resched())) {
+
+			/*
+			 * Depending on whether we have PREEMPT_RCU or not, the
+			 * mutex_unlock() or percpu_ref_put() should cause us to
+			 * reschedule.
+			 */
 			ctx_flush_and_put(*ctx, ts);
 			*ctx = NULL;
-			cond_resched();
 		}
 	}
 
@@ -1611,7 +1616,6 @@ static __cold void io_iopoll_try_reap_events(struct io_ring_ctx *ctx)
 		 */
 		if (need_resched()) {
 			mutex_unlock(&ctx->uring_lock);
-			cond_resched();
 			mutex_lock(&ctx->uring_lock);
 		}
 	}
@@ -1977,7 +1981,6 @@ void io_wq_submit_work(struct io_wq_work *work)
 				break;
 			if (io_wq_worker_stopped())
 				break;
-			cond_resched();
 			continue;
 		}
 
@@ -2649,7 +2652,6 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			ret = 0;
 			break;
 		}
-		cond_resched();
 	} while (1);
 
 	if (!(ctx->flags & IORING_SETUP_DEFER_TASKRUN))
@@ -3096,8 +3098,12 @@ static __cold void io_ring_exit_work(struct work_struct *work)
 		if (ctx->flags & IORING_SETUP_DEFER_TASKRUN)
 			io_move_task_work_from_local(ctx);
 
+		/*
+		 * io_uring_try_cancel_requests() will reschedule when needed
+		 * in the mutex_unlock().
+		 */
 		while (io_uring_try_cancel_requests(ctx, NULL, true))
-			cond_resched();
+			;
 
 		if (ctx->sq_data) {
 			struct io_sq_data *sqd = ctx->sq_data;
@@ -3313,7 +3319,6 @@ static __cold bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
 		while (!wq_list_empty(&ctx->iopoll_list)) {
 			io_iopoll_try_reap_events(ctx);
 			ret = true;
-			cond_resched();
 		}
 	}
 
@@ -3382,10 +3387,8 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
 								     cancel_all);
 		}
 
-		if (loop) {
-			cond_resched();
+		if (loop)
 			continue;
-		}
 
 		prepare_to_wait(&tctx->wait, &wait, TASK_INTERRUPTIBLE);
 		io_run_task_work();
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 9123138aa9f4..ef94a7c76d9a 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -246,7 +246,6 @@ static int __io_remove_buffers(struct io_ring_ctx *ctx,
 		list_move(&nxt->list, &ctx->io_buffers_cache);
 		if (++i == nbufs)
 			return i;
-		cond_resched();
 	}
 
 	return i;
@@ -421,7 +420,6 @@ static int io_add_buffers(struct io_ring_ctx *ctx, struct io_provide_buf *pbuf,
 		buf->bgid = pbuf->bgid;
 		addr += pbuf->len;
 		bid++;
-		cond_resched();
 	}
 
 	return i ? 0 : -ENOMEM;
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index bd6c2c7959a5..b297b7b8047e 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -212,7 +212,6 @@ static bool io_sqd_handle_event(struct io_sq_data *sqd)
 		mutex_unlock(&sqd->lock);
 		if (signal_pending(current))
 			did_sig = get_signal(&ksig);
-		cond_resched();
 		mutex_lock(&sqd->lock);
 	}
 	return did_sig || test_bit(IO_SQ_THREAD_SHOULD_STOP, &sqd->state);
@@ -258,8 +257,11 @@ static int io_sq_thread(void *data)
 			if (sqt_spin)
 				timeout = jiffies + sqd->sq_thread_idle;
 			if (unlikely(need_resched())) {
+				/*
+				 * Drop the mutex and reacquire so a reschedule can
+				 * happen on unlock.
+				 */
 				mutex_unlock(&sqd->lock);
-				cond_resched();
 				mutex_lock(&sqd->lock);
 			}
 			continue;
diff --git a/io_uring/tctx.c b/io_uring/tctx.c
index c043fe93a3f2..1bf58f01e50c 100644
--- a/io_uring/tctx.c
+++ b/io_uring/tctx.c
@@ -181,10 +181,8 @@ __cold void io_uring_clean_tctx(struct io_uring_task *tctx)
 	struct io_tctx_node *node;
 	unsigned long index;
 
-	xa_for_each(&tctx->xa, index, node) {
+	xa_for_each(&tctx->xa, index, node)
 		io_uring_del_tctx_node(index);
-		cond_resched();
-	}
 	if (wq) {
 		/*
 		 * Must be after io_uring_del_tctx_node() (removes nodes under
-- 
2.31.1

