Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB1F7E4B79
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343784AbjKGWFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbjKGWFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:05:01 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3243AB4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:01:30 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJPwY028640;
        Tue, 7 Nov 2023 22:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=2hROQy3T2KGwySSKiDDCRkL0TyqotGIPGYYIK5MOBi8=;
 b=0maM7BjR2lf9NyBXEF4SuuHJ0c4Jt7hR9KnfzXOqy8BKtmeoVHi5NGIjmHhDGe9YP4pn
 0PZV5tcgRoW43vfqFLEigMUl6JZR7yzeQG2DHBYRbaXlZ9TT8wj5QWHuCGuxLtW2hRwD
 v62mzibLO6TZ/ZWuioc3YpCLX4HJSz25sykdlZiXxfcUupMNDtDmZuAECAeubKB31MTg
 6CuWkFgwL7/qIky3PyWSf1lQR1kSLep9PNJ4qKeBmHTtrxfPuRuZIIQkoX7sPoAaSQOV
 wJjW8AS4M6/45p/T2eZkzZv8WHtSLI/1T4NOZMRKHKd9lD3aqjaQPEVTwu2zSUVeFdhE +Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2302de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIhM4011105;
        Tue, 7 Nov 2023 22:00:28 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1tsmb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0pQM292epIzJFhbgFAAwGyRzx/fpBR25YX7pZRq+Cubk0zutxtI07654cbMtKJnAVDQP8ZBJHA8n0Kc1Y4cXQ8DShITws6lOYQG7YmLVR7+QJf95nRE5PYEluOTjYWDReEwoeJBOZXSAYz9/ndq6CeNYPiuhQOUG+GdibKR+bEBlUlizS/lsyoPJimAVj619F8CgmAJPnjP6HA/YYtfzEyqKb/VbvGhFa/SJBnGjswsNz2RljLruPYRK7Sy7I5D7rrE6j3/oO8axno39jsARtSl7DHUiNeF/A3/u2USJ1X2cHz8aNL+QC8DxtSJEvv0TvZZxlhzrY0oWr8UTXW7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hROQy3T2KGwySSKiDDCRkL0TyqotGIPGYYIK5MOBi8=;
 b=FS2SdSNDBm+kbctJmaQx5O8VGOYmR5AkZ6OMt6e9AfOwTXPs0BULS6EcUtK/oPzeX39PNyIukrBLLWqPtv3Hl4nAihwg7Ajug0XUTpT/Q+IetAO8egbnNsJmGieMta2wEJTK8DAxJhglom21eNKsLQ4dBcduZSheS7m3gzXAs2aBHPfToEgcabRXIwnA11GZdRTnca1OKRDFFKnfnZdEhBAAYwS0eAv7+XZnHv9FycxKTZK+qsaEjnUEtifkPH05e+eyss4BRyX6lu2Chb8J7fpTW7YPHsHRA5aEGjpENi4dPmN9fM6hgvXuupDip11kAwAfSCEwB4lM2qJZN8Or5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hROQy3T2KGwySSKiDDCRkL0TyqotGIPGYYIK5MOBi8=;
 b=bG4QqHaiYyafiFtOL7Y9ag5gMMQwc7mY7W8S9hwrZhz6b8JCqnm5GoLwsZ+bsiQWJOR3L6MZMJ4SGJuzmfOOzD3sbPB11VgJ4VLzBrwXImk01J6lYpZtJ4fWPU6WgtuKhhX/Q0J4oByn39oW72E4bvACyTANCxp1HyIGdBTLMfg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6275.namprd10.prod.outlook.com (2603:10b6:510:211::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 22:00:20 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 22:00:20 +0000
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
Subject: [RFC PATCH 51/86] preempt: disallow !PREEMPT_COUNT or !PREEMPTION
Date:   Tue,  7 Nov 2023 13:57:37 -0800
Message-Id: <20231107215742.363031-52-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0236.namprd04.prod.outlook.com
 (2603:10b6:303:87::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dfa16ba-43e8-48a9-78aa-08dbdfdceef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXC+865JkqWtgvRwhCdtjhbUXqOmpSbESQ5kybFO6HO/C5fC2czUOEOFPjyaDO4CoVDg9KRHbNLppPHxdwtxbimVbzO/HzkuidiIFnYjehk55aW5TQ6KxrujKebqpnwZKCydNA33Tego/Z3JPTHGWf74cHduvbNF9DYk9IP51bPpLGuPqahbV3j6yTmk7nWwvaq5DEi3mm0yCPinAyZ31xvAL5RD8CGUnCC70oGsXLLFb1oafieZMWFrvbodRd9IP2CZCNEofKN9tgaJpgZ+5OPA6ZeK8MDR6+v/vE04vkADF8Je8S9FQyJ8+1NyfdxWy2O7cAT5b4Xdi7B4qu3ymvOVh24n+06PckrHP/Af3bJGaAQYomBJeyTA+ZfhV9IP6CN4i8dx2mm1J6DsIJ7LfstP+4aFKbQBesiLwOxPaDFab6hy60QQ8D9tJ+PfDoXbtUBYa7l/SOnwDGLd7FuJOshw13AsaMpEzieKbf3EtUSkch5e80e8Q4NwfjOAHgxQ20z5/hSeEf2vAMeerHpvxmehK5VunycsbN6I2qsCeWNHz2B4seoquD0UvXA9VunM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66476007)(6666004)(38100700002)(6916009)(6506007)(316002)(66556008)(36756003)(5660300002)(7416002)(7406005)(41300700001)(66946007)(6512007)(103116003)(1076003)(8936002)(8676002)(4326008)(26005)(6486002)(107886003)(2616005)(2906002)(83380400001)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bHhcnIASHmV2Jvhem/2ACqML0CZlrq9obSSCtEU4l1p3Bzw2+A4gi5fqD+RG?=
 =?us-ascii?Q?bOOCBd67N1F3uxPgWFhgpvruBBXTvmGbnMyld84QY2ljFx+swi0adXZZh5wU?=
 =?us-ascii?Q?0neU78kvg2ltqXuRkqD0JBUhI7S32i1kTv2MfR+jJz5Wg9PpwhNGCYgSiEya?=
 =?us-ascii?Q?BvwpGDs1ztBZBWGb/tfYbfza9goJnF35JnfARN2dTHEZZe5ISMtx96GAhnr9?=
 =?us-ascii?Q?YE+12PxmPNq1l/PRtL3Yey4wt15Y5tXrAfuNeOheN8gNyyUreSRrqqMQJ+y8?=
 =?us-ascii?Q?6kPJDqmCDjDk50FFpNtz+1XINTqP5DAaJgmHL+xqW8UBAh2sN0th/r7X61cn?=
 =?us-ascii?Q?olnTnuTlJnVpliB/ZcD1NUxBUBriJJsvvL7Ni5WmyHtxabvZJ12WOa9DBmol?=
 =?us-ascii?Q?XqN7AN36jzR1XBPfetFQjdxdmEQ0/I9gVum7J2e4HTMLcwKZjgBmCp60GrLv?=
 =?us-ascii?Q?vwh1rVnc81gI4VouSeSeqyAEIvOqWtDw5WOEsmK9ZRXNa7GQ80e4IWRwFSdD?=
 =?us-ascii?Q?71ZEv3p+ycjRxOaB5KZ6Rm2L8oQwPN8KxZfLNsWcv/DT1VZultCkHyyGiVSy?=
 =?us-ascii?Q?kSi8U7bzBJf5HG3sgMyg8Kqjd5QhJ4MdF952Pe1g/yzhBl0evv2oNq0aWarQ?=
 =?us-ascii?Q?0+igiIIHpiIDTq8ayLZjVnmTVXxDo3vOyhTz7eI9EL7Vok9AAMnVFxZ2IW77?=
 =?us-ascii?Q?Pwv8CeqCK1I6ubdGJj2cbzJ6HEip5yvsYpDlUI4MBkbNpjss2eDy5k+HFsaW?=
 =?us-ascii?Q?TvUqTittU4QsY0d23cYoC30DDkP9wVCGsPIhQCWsDLRAi72DzYUJ0VRuBoxh?=
 =?us-ascii?Q?JFAye8ATmWD0bhrVJEAZ6SmkNPsrktycN5t3AUvlVd751yq8RgCVaOvzbacC?=
 =?us-ascii?Q?kEJfq7Xr6ZqdxK7CyjsRfUWfRRubxDge/YwFN603o8K0hd2dU/1gqA7nQqdy?=
 =?us-ascii?Q?Mh/ZE0Z4cmmHypn5EwDEF+YkDiEDFfGfgoBuK9m1E9xfkyCW9ZhQnoquccMh?=
 =?us-ascii?Q?bcqoXkGlKha858hQS05Z71UxaRS1avNsgX/K/6y7rQ/7ci4vDx9lPxRNcGFS?=
 =?us-ascii?Q?+6IwjCrLxWxlhg9LbW8ZHSq1JS6nVOeEfyQ5DoCJijJSKqQ80C1nxrdbKalr?=
 =?us-ascii?Q?DtG4qSBgkTu6DH3WLMnPOjMrHjh+BoAs3Nk16O2PJq+3IwwGh4uIiw9DJebU?=
 =?us-ascii?Q?s1PyDljCJNFSXtPKPEuwmZmv+cI+5m/nYqpitUYoB3TZa/i6kq7q1S50nhvH?=
 =?us-ascii?Q?29F/KeUcfBog9nE+TZQmmt5Lv3e8/LAtUiG1LSvZMGGGs+UePX0gqUiRo+G+?=
 =?us-ascii?Q?ZmlZooGLPIg8uLZXJ+drXpCrft6LRSexCbo9WRUZCsTO7pxZ1X+3FC65uKCo?=
 =?us-ascii?Q?hTla1DR3Ptwf0cKPcbwC5HvRvIfLVE53Qr5zFETYsk/CWKLexzVAxsl5dtfL?=
 =?us-ascii?Q?ebB/5P6Z14pj9YxokIkPhgPFEkB+Gga7TunJXp+ZKnRXtAjVqd3TfrFU1OlO?=
 =?us-ascii?Q?3c6BZ/ZFcCl9PrtuEpC0y79UOV0sxXeAjbEEhKDItsKuUfNNb1EOTs9e5EAO?=
 =?us-ascii?Q?E601PttDb/QiO7Z0wwymyueNFAMLX51Ta6Pwdb0B6KQgtReJJeMD3HoxSwDL?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?AHFN9OsC7GyrXdCphdGeSOXPsFaiQTxzlKyI28zcgAr4v9s0FDm6rouBr++f?=
 =?us-ascii?Q?j21F+wrnlAsmdAF9Rb867yK/Q90FV7ruXcdFAotKnY2zDwUmLHy9rlME5xiB?=
 =?us-ascii?Q?J8/qea5QGRRwxvOCFOAnT5HNOKn105KsGOUDXqbpyvKWoQwZH19+MJqfCdhR?=
 =?us-ascii?Q?IdUvKaR2jMgbYEh9h66vvTGn9rk28R4WfGdtt+oZRngxEX6/d5ts5L4/92zD?=
 =?us-ascii?Q?iuIZgfKXVhZwaUTYtt6zCVru40zTJY4LaGkSmVhEzgbI7kdVvTqB37s1bVFG?=
 =?us-ascii?Q?CGCvkTSmk6zHJJ5wb4C8xE2XSHoGymduwJ2cztLzewq9mNbq7OFfSVfBcZWD?=
 =?us-ascii?Q?sNDggQhD0YslccIh7VVaXY95vE0KjmEbW4muyoS5wfHgH3eurEnbLb6P9XaZ?=
 =?us-ascii?Q?80fO7ELuBCusfqoIbn7+G4/LSZt6r8P7EvTKf06TfbuIu+orzq+fhiSADqd+?=
 =?us-ascii?Q?q77oWXXmmmAmRB/6x2oELbEAwlbAAOLoJ6NdNkMA14kENehyJp/sHEq7cfRO?=
 =?us-ascii?Q?X88fb1fWKmNiih6aWjQRBQ/rNAozx90c72HpbKDM1nF5ZpAwpS+4YS9K4OKR?=
 =?us-ascii?Q?SXH/ji8NpISkHIPwCj9KMxcvBCIefSNsYKk4WLJ9EFgsyKqjw37hYoRJ29d0?=
 =?us-ascii?Q?IpzpvHrBlG7WC8DuPB4rIE3t59/zoXyVjuWoRHhvIxiQ4Q4ZDNXN0NdhtLcc?=
 =?us-ascii?Q?RxoPb/gJAVeI/o9ZVpriosTDL9RUCKt38PqcaXxBSfq0pOFiwZackus1u9V1?=
 =?us-ascii?Q?ECzxYHKjdEdn3MF+91xbrjjcS89+6Yo73Yuo1vP3MuzggN+DZ1I1b3PyHbIB?=
 =?us-ascii?Q?zufzwlQHy8WiL/KkHwc46m7UglunCFb8CFFbA7C1rVPV2shixp87j9HilH3X?=
 =?us-ascii?Q?npJKVCnfiSPwGiRUa743bcI51GUYbdYEjqLtut8gSB3LBGvtV216TKrh6Nsa?=
 =?us-ascii?Q?bGF8u3lTUKNN3CSrnZNwJMaYX38ZDzr/aId8l6b4+wzQTdz40rC5eGubmGQp?=
 =?us-ascii?Q?ZU/ann9pdXD9GAvuhrFqH5FsZs5EsQXYoJvSkzm3rP4z2R0MO5Gk8p/M5feJ?=
 =?us-ascii?Q?mvtiEtIX4vbtpmhe9kjNvdBULXmsnYWo1B5cgobxheixCenoiQaC0SJckIUE?=
 =?us-ascii?Q?Qd8XvxmuOJya3rH95UfGd2URPmsDBx7fwQgvah7LnST5ECXEX00wfN58Lssd?=
 =?us-ascii?Q?ybkYHPQHMheXyJpJp5vS5ldkICTWzvH7vhkEf7CbKU6hIQCd5Cry+ypn/qL1?=
 =?us-ascii?Q?gpXgmDV89fKwrqHEVciRDun6FnOqyv14CH0RHgqx/gFBL6qqHo5PrJdkLdL0?=
 =?us-ascii?Q?DuDjmM1QrMdeyHhXqGw72WvhrTtUzjKvg5YEvz72UtKW1N5H0D4mXeGMjFt9?=
 =?us-ascii?Q?7vK6wxsIphEcPjN2qQ0+1budvUR0OC42IsfS0vdv9O3LWG0+94vqHWas0rwL?=
 =?us-ascii?Q?nb3IToxQYUO6A3QvP77zMFFWj0zkDKNRflF6UREhaO2glqNvX5s6yFSn1ucI?=
 =?us-ascii?Q?mNLUkdEYAMSuNOKiAuYxz1+ifpcxE+pXQiflur/bt0kKwjhFOX7bYJfXHA?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfa16ba-43e8-48a9-78aa-08dbdfdceef9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 22:00:19.9640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJNgn9VEPm25E5E99iWpqs0xWNEyvTUhKQwjrrReNoGB3HMUFMv3ONMnkiitkZWo0I+MAVXT1/fg0rLZ4Y7wxkkq7Z01FawmdaZzmLV9/lQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6275
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=789 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: qWM1VpC8I6hVu-8CvrszkPFyS7xAhbUU
X-Proofpoint-ORIG-GUID: qWM1VpC8I6hVu-8CvrszkPFyS7xAhbUU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PREEMPT_COUNT and PREEMPTION are selected for all preemption models.
Mark configurations which might not have either as invalid.

Also stub cond_resched() since we don't actually need it for anything.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/kernel.h  | 11 ++---------
 include/linux/preempt.h | 42 +++--------------------------------------
 include/linux/sched.h   |  4 +---
 3 files changed, 6 insertions(+), 51 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index cf077cd69643..a48900d8b409 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -95,13 +95,6 @@
 struct completion;
 struct user;
 
-#ifdef CONFIG_PREEMPT_VOLUNTARY
-extern int _cond_resched(void);
-# define might_resched() _cond_resched()
-#else
-# define might_resched() do { } while (0)
-#endif
-
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 extern void __might_resched(const char *file, int line, unsigned int offsets);
 extern void __might_sleep(const char *file, int line);
@@ -121,7 +114,7 @@ extern void __cant_migrate(const char *file, int line);
  * supposed to.
  */
 # define might_sleep() \
-	do { __might_sleep(__FILE__, __LINE__); might_resched(); } while (0)
+	do { __might_sleep(__FILE__, __LINE__); } while (0)
 /**
  * cant_sleep - annotation for functions that cannot sleep
  *
@@ -163,7 +156,7 @@ extern void __cant_migrate(const char *file, int line);
   static inline void __might_resched(const char *file, int line,
 				     unsigned int offsets) { }
 static inline void __might_sleep(const char *file, int line) { }
-# define might_sleep() do { might_resched(); } while (0)
+# define might_sleep() do { } while (0)
 # define cant_sleep() do { } while (0)
 # define cant_migrate()		do { } while (0)
 # define sched_annotate_sleep() do { } while (0)
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 0abc6a673c41..dc5125b9c36b 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -197,7 +197,9 @@ extern void preempt_count_sub(int val);
 #define preempt_count_inc() preempt_count_add(1)
 #define preempt_count_dec() preempt_count_sub(1)
 
-#ifdef CONFIG_PREEMPT_COUNT
+#if !defined(CONFIG_PREEMPTION) || !defined(CONFIG_PREEMPT_COUNT)
+#error "Configurations with !CONFIG_PREEMPTION or !CONFIG_PREEMPT_COUNT are not supported."
+#endif
 
 #define preempt_disable() \
 do { \
@@ -215,7 +217,6 @@ do { \
 
 #define preemptible()	(preempt_count() == 0 && !irqs_disabled())
 
-#ifdef CONFIG_PREEMPTION
 #define preempt_enable() \
 do { \
 	barrier(); \
@@ -236,22 +237,6 @@ do { \
 		__preempt_schedule(); \
 } while (0)
 
-#else /* !CONFIG_PREEMPTION */
-#define preempt_enable() \
-do { \
-	barrier(); \
-	preempt_count_dec(); \
-} while (0)
-
-#define preempt_enable_notrace() \
-do { \
-	barrier(); \
-	__preempt_count_dec(); \
-} while (0)
-
-#define preempt_check_resched() do { } while (0)
-#endif /* CONFIG_PREEMPTION */
-
 #define preempt_disable_notrace() \
 do { \
 	__preempt_count_inc(); \
@@ -264,27 +249,6 @@ do { \
 	__preempt_count_dec(); \
 } while (0)
 
-#else /* !CONFIG_PREEMPT_COUNT */
-
-/*
- * Even if we don't have any preemption, we need preempt disable/enable
- * to be barriers, so that we don't have things like get_user/put_user
- * that can cause faults and scheduling migrate into our preempt-protected
- * region.
- */
-#define preempt_disable()			barrier()
-#define sched_preempt_enable_no_resched()	barrier()
-#define preempt_enable_no_resched()		barrier()
-#define preempt_enable()			barrier()
-#define preempt_check_resched()			do { } while (0)
-
-#define preempt_disable_notrace()		barrier()
-#define preempt_enable_no_resched_notrace()	barrier()
-#define preempt_enable_notrace()		barrier()
-#define preemptible()				0
-
-#endif /* CONFIG_PREEMPT_COUNT */
-
 #ifdef MODULE
 /*
  * Modules have no business playing preemption tricks.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6dd206b2ef50..4dabd9530f98 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2088,9 +2088,7 @@ static inline bool test_tsk_need_resched_any(struct task_struct *tsk)
  * value indicates whether a reschedule was done in fact.
  * cond_resched_lock() will drop the spinlock before scheduling,
  */
-#ifndef CONFIG_PREEMPTION
-extern int _cond_resched(void);
-#else
+#ifdef CONFIG_PREEMPTION
 static inline int _cond_resched(void) { return 0; }
 #endif
 
-- 
2.31.1

