Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C414877C2B2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjHNVqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjHNVqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:46:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A742B10DD;
        Mon, 14 Aug 2023 14:46:05 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOsFm023657;
        Mon, 14 Aug 2023 21:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=EZLABlgzY4iKQ+X/IydT5kyN7j29B37kOOcS5x+m40Y=;
 b=deTHQ4DnAW8iXe0ghSP5Jvjvpmlh3mFX/Pofd4eKNKEQFW73LX3ALrXFdbEl2EUOaTip
 xg4GAT5vf+UX+qnEL4TEifwEkDruQjt8Xu0GErYRWejYT8etNQSdtqRScMm7oSOtK+ly
 QKpJdyUqwA+NU/wIoWAk855iACwSD67YajgbWlQft64eo3G1bEomY/UJGOEhytasDg2t
 apneUOZ8FZY5lcYJ+zolNd/nDZKGZjiN0dCxmwr6XO40uancnCJfFf9rjBFvj78EcJi8
 9iGu1yduRSS9KowjTp/l+29xG8uOyj7gKOhPFQhZs9iDX6iaOsSsiO7lRi2dd+AUHYL/ qQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w5umm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 21:45:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EKcvdd020093;
        Mon, 14 Aug 2023 21:45:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3up5qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 21:45:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLVjFrUszRMoVLnuENbiv2M37clW7d8yCovNEVBj79JQJXi9VVM4WHTGtAJ/Kie7QacFZ9LXcBQDyQ9cJZsOrBJ3/bVz/mvjYLU41PhDyHbAwhP0spadBxVS6MB9Y/e49zmByzqupwMz4lqCCBdy+xuk38FKL+R5NLgTYBDSCy9Enj1OJeJc6rC37rLhV1XOCncQoUP/RYDiZqeo98DFcWBABTRHI6epBxPpWQXWvrGhIhizxKO1I6LSGbY4HqoX4FWbSdwhC2ccRdytgozEN6QY5hQxjbk6rqvT8/1fH1gnms4sp9JA1kGbGXqa3aCk9Laviq4oZImiJ4J7ALAcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZLABlgzY4iKQ+X/IydT5kyN7j29B37kOOcS5x+m40Y=;
 b=TWPcrxoFHmb4U7oXExx+H3sqBdVWM2D7CfGeQ0BqoF1v1kYqxCO4UJ8BxqQ9gHgjII4y8ffvBkh/yhlbFDv9VNmuhC4vjB32nIBuJ9qI2WzTWSgRpPOHjTxXEzmVNAwDFAcS7I5dQNOBWsePmeO4hVPNQWpjxKh4BkW/TuJfjfqnrj5M1YaYJK2OQLx9oVz6S7yW6gWpxIuDY1qdm+f+mFh1g0apCxQWLBxoollCel/vBJs1/ipmmXUz+MiHAlylblOZs0FWDPliJz1uaDFT0PdUR/Mh1XZ3EcV0t8cZBNXKg9WG2W5/JqMGyB1QfpykNRrcrTQ41WGebQa1cR2K9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZLABlgzY4iKQ+X/IydT5kyN7j29B37kOOcS5x+m40Y=;
 b=cNXA/+e55txcP3pB6AuVtSqB5NE7jO/bQLdjuIpfO6A/39X9xHerygtbWgVyj/itJ4BN312Fh6MmZOcZeKiAC+ylIv/X8c+QVdLRQ3pi2LFwXO3jvcyuRviv1IGvwevwu9SDXM8IZ+2gw2niOZ1NcxJG54XbJY3oWb9Vet32xXE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH0PR10MB6957.namprd10.prod.outlook.com (2603:10b6:510:285::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 21:45:14 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 21:45:14 +0000
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
Subject: [PATCH v28 8/8] x86/crash: optimize CPU changes
Date:   Mon, 14 Aug 2023 17:44:46 -0400
Message-Id: <20230814214446.6659-9-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230814214446.6659-1-eric.devolder@oracle.com>
References: <20230814214446.6659-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0007.namprd05.prod.outlook.com
 (2603:10b6:803:40::20) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH0PR10MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c1696c-5fa7-4b89-c578-08db9d0fbe1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RSJUm7tWRfpyfJZpqtG7GdNDa2WiP+qqPuD+yL3M4pp/3HNx55YXdTCyKUi3RTeMV2I8AO/YhtCk+/uGJ8Al2AWwLMQW0npN8VdgsSyAzikN8ktVvIaErw0UcUSTtR19J+xDP3ytrpm04XMAlpqeQouDlrBsWwgvlQ/N+1BZpX0GM0S2nlT6fpryP0kmyKdW5EiT44naNSRTDDSJsULQxVDbgcljbbCOAcvP9IwG2uCByLuo9naWwkoAxzEgNfKBc9gVhhY7jI6dRGv24Ja9eKHA/ohW4u4sP1iVUeU6KzthCwgYCNbhQKZ3hx9PCzvrfgk8OltDymhhueAxAC6gcQOHipHaq8ojsgNE6NKNVwtQ5B+zEXM+KSpsY578DRym3XDkFUqr77cHQrdt8u0aJwRc9im7i8LzD6ra8uuZLe7780LAIsxVwQXpdWrfxea/debvH9tRAdLeUM8GXshhlU3tDxY/q7boX7gfglT+wMJrYgTKqJDGLLcdibcZChN7NluxUM3x7E9H7puwnGU//DQjkkQpRNSrni9QdSMl6r+QZ9gi0D8+9Qw3ZRNYhtfOGtLTsqm+FIMaCcRYkVxOvLBWKndmWbkHHD10TCzTWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(1800799006)(186006)(451199021)(6486002)(6666004)(6512007)(6506007)(478600001)(107886003)(2616005)(1076003)(2906002)(26005)(83380400001)(7416002)(7406005)(66556008)(41300700001)(316002)(66476007)(66946007)(5660300002)(8936002)(8676002)(4326008)(86362001)(921005)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mLYTLiG+kvsfFZdsiDtHssq6sA7W8WzMu57ffC1nY0GVYdQY1hG4zlzAk3iG?=
 =?us-ascii?Q?VOPdkxXMeYyVwy+JzCNy7GfPml3htfzIbWspORXoM/IiieV4E1L+vROGZkj5?=
 =?us-ascii?Q?vEkHbZtnIuqmf4UhS/Nh/dSlq6JlwtwZuc50ZmApXoZlal7j8X5bgmeeuuRb?=
 =?us-ascii?Q?CapzhOZe3QETCldk9209wgECt9EtwTncF9yevtCYtVELi7Dd0b6SKji/a7x1?=
 =?us-ascii?Q?T6HvgeVKXHmgF7iY5McBfcAB+KVfN8COm7qHzJP4r5752HcDYJ6khN18Rhb0?=
 =?us-ascii?Q?j2A11wJ0Vn/rOkrpn9jDsBh65nXJW6NfwY5786wH985WWK2z2wRIkKtTc5kE?=
 =?us-ascii?Q?3po8vPYwLQgJMEEyMUvETwFKjUmERdGx6v/+iihvMyBl5LQu9Zead/94ATil?=
 =?us-ascii?Q?JgENILzHNePwBrF5hkJBzO0Dm2f+E2f3LD61EzUOavkjrDIChGekH53Zfces?=
 =?us-ascii?Q?ATl6b6ih73UuuKtX2KS/JUc0Z9OBwW3DIEj1iY5SQqofKnCegHbvLqS3hwB2?=
 =?us-ascii?Q?aOQrBfCbg07MxCpd/Ih67oTkH1kyScVrhmjiZJzbx0jPh4VgU6jAAalISdtT?=
 =?us-ascii?Q?jMnglkXyE0WiI18aJt/KzaWlmZdPLi305fkHPlkhzDVmN2jT4UiEsfolnAkK?=
 =?us-ascii?Q?Rg/hvLsqQ3EaPowPdAz7+ueTcIS56BG4CAvhd1yboKYYhCNzcMMBR1aldUOu?=
 =?us-ascii?Q?O5ghkANmm2SP/z2Rg2UTctHiE7HcTwAITnR9HjsFFnkHynH3x60/hHCUlvQ6?=
 =?us-ascii?Q?gAMHCxAxReOKen5M9EEUjQSW1IM9cldet3LGG+M7ScwIrOB2eYVSpD2Vnc1m?=
 =?us-ascii?Q?IBrI7xM/TZ/OKlwpozHiZiMWJPMjhCAttmVofPbVsOewacBfWye73IVSGq3Z?=
 =?us-ascii?Q?g9U2pyJb7HPzIABFK6PftypbiVKY8HLBikhn8CveFsVCGrRvHOrTlYYhn0m1?=
 =?us-ascii?Q?IjsWcSyqzsyZW3i1MNuPd5439L1tEhrI3SMRFXYWHIMfId+qPJoWRlit17ZF?=
 =?us-ascii?Q?A0WY67i9Ao7ntHWWerjTe48QHMTaEeNeZLE7eq5UX/nkLTMZNzrLsvbG6ZDd?=
 =?us-ascii?Q?wkcTwzg/Gyc8pYkWKrEAIuzZRGq29KlSp6lIqwiZlyGwni1W2TI7C4mi5JWN?=
 =?us-ascii?Q?AUQH6Xf2udwfVMUKYrzJMvcqPOARcTrOORqr9gVBnw/dkakWo37+rxC7XKnT?=
 =?us-ascii?Q?Dr+vBwiOaWOgoutkbUlkuYwz4FvA1uL2rj1O+2XBBUnuJcVjgGR1KP8WgeGE?=
 =?us-ascii?Q?LYVJRYVrZPmdIbjvaoL++wEUnGwVkqoiRJ2A7pxHAjq2UDRYBhi5vmPViK5o?=
 =?us-ascii?Q?7UtpYc+bxGTE7q6dEz/xqpbssAOR5cNiJE0efr+V06ygaV1rGUT4+ddcgRtL?=
 =?us-ascii?Q?Ldq5kNdptJOk1BJOPVDVe+rKe0wzNIVk6tzbB7nFB129ZJIHmpSOoMNqjnWC?=
 =?us-ascii?Q?Dp019jNIECCZ9pE9Nvo41lsQGiOZ192nfH6qw6uDURfnXhLJKhg/uQmFvfM7?=
 =?us-ascii?Q?5Bo3NqTpDOemU/vSqtdiGIncpy1jxTG8804SgJck+3PDDPOxMlEF2COkshLI?=
 =?us-ascii?Q?9L2pY5Lf5nhsu5tqiENOoJAXKgzZ6ouUfBDNU6uLLsPt9jESUFb2CeSA7rpr?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Wf+KiiWxzuqmjw6+v+Zj5xO8JUkdJgdI2R6/F9/OTxGY0yMXFPK0Q4e8dcVl?=
 =?us-ascii?Q?hWqQCgbonoNkhSw5sfsFkPr7EKJG68CISxMMQhxSr/po/YNf2bgfw4zQKYw2?=
 =?us-ascii?Q?qT8bl5wosbGgxvlIo2IwSlBauhtG08vejctrf/5KQ68xSGqCZDvMZ4SrM+3D?=
 =?us-ascii?Q?YBbysXXkb3H4S66wVfngQTHXgzskcJ6YKtnmgrNyIrMqewmbjC+h5xXLqfqk?=
 =?us-ascii?Q?Z/TOzvshY1bHGNYZlGKu0YUXaJ+drnvdzH/0Zi/LntyhKjGVLxxTEarrWxFQ?=
 =?us-ascii?Q?B6TSEDGsJUVkKH3nVwW+QmWmg4O+KyUuKb4yBCQZqDNddzJlGlB0EndW1TYT?=
 =?us-ascii?Q?upvmgWzf9LFRRih24wWM2qTanyQDfE1P6Y0GZCBQOyudE1YMtL7YdvL6vPFN?=
 =?us-ascii?Q?jKnTwrDMLtX6BoMJpYEY0DZv8xKiAv47CSKHYrr2k5hmpSYm4DkL5VR3QXqf?=
 =?us-ascii?Q?O+l94vFUJJAK0OkPgwjol3CLC+os7PNksnrt+4D5t7yAvdSi7B3f2CstmP8U?=
 =?us-ascii?Q?hHvzgZlGm96iBL58H3VjvvP+n/i5+rRQbD5hzffSir7iHq8bOqHD/mU80YAT?=
 =?us-ascii?Q?N6GebP87HqeOwR2D6wkTOZmgav0d5zhTw/Ksnm78BCffY+yqMrBsn2Hg8pJl?=
 =?us-ascii?Q?TBD+EauGJPu65Mu7kIYS9KsQ78ZlNEFeWVNo7kwssTY13fLbGipp3wxyX2+Q?=
 =?us-ascii?Q?HAR9VHOT5gXl3pRBltVwKfpnPFlsNrdlKy2KCQBKVCz5wTBNDZvJititvKzb?=
 =?us-ascii?Q?Og9LXe1Y5ZbKE2CrTLKSCH2lgfR4Fx8bjDoBVLRc3Gzp7u8HhltwvfF7txtE?=
 =?us-ascii?Q?2zDZWN2NoH4vNnCEXWzx0L8N+sHSCA2TLlMd80Ll3tjdYFCuzQQirMjhpyI5?=
 =?us-ascii?Q?EeJrDFs6W4imXELkJGP/9XNMmzxh1iFvRAuUAkk1zGb0IURJ0G/6sooatjif?=
 =?us-ascii?Q?cdO2JXOVViExjlXkGtR7cS/aVFth85c/3QIGEcTUD/Z2LKEzV1bquzrfNgMz?=
 =?us-ascii?Q?pAULmD2hm6UtF4uA6rFctHYuo7rV8Jr98oirDL9EJwht5PTUeQDJAk/poofT?=
 =?us-ascii?Q?M9HL02xHALqE+G9Snqf3pDfqXxyq4rguc+02P6/5ingOSTVR0koEPu0XeDWh?=
 =?us-ascii?Q?asP7EUVW79R2W5IwM9f2YzbSwVwdbh9UUwYJrcdW+GRaUnQ9zd0vOxHrc9pJ?=
 =?us-ascii?Q?pCEYWeV+YehZmb+rbg0QtWw/BCU9c+AAwiqRbX/eW1mK649HmjmOWshfnXYa?=
 =?us-ascii?Q?0J+33pJRJvZ4XC89S7FAc0H79/xPuMKOSZhIg0doWAsI8vTC1geebayDyTPf?=
 =?us-ascii?Q?wZSGt8XuNvfCHVAfimm0+Hr/ff1di1BthZvTnkWGnB5ZKZFxNVGAbNIpz+lK?=
 =?us-ascii?Q?FEJQEE2cvSrHHWz5H10osaDKD7Ks7c67MWJ1OLqSFhgk+bfKwm/oVgrRQYHn?=
 =?us-ascii?Q?zne2XnCGFr4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c1696c-5fa7-4b89-c578-08db9d0fbe1d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 21:45:14.4784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liTCe1t09610c7VZM3zUSKDknP2kWIazWFA64WRNy3CeYuKpUTnIA5q93F47vXkaSl20wOKtLnNQ5owe+yYzTbGBo6iYczZ8PfKcmuU6fOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_18,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140200
X-Proofpoint-ORIG-GUID: dITMQgYODfZhQZkyeoEka6AhLU2uajD3
X-Proofpoint-GUID: dITMQgYODfZhQZkyeoEka6AhLU2uajD3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crash_prepare_elf64_headers() writes into the elfcorehdr an ELF
PT_NOTE for all possible CPUs. As such, subsequent changes to CPUs
(ie. hot un/plug, online/offline) do not need to rewrite the elfcorehdr.

The kimage->file_mode term covers kdump images loaded via the
kexec_file_load() syscall. Since crash_prepare_elf64_headers()
wrote the initial elfcorehdr, no update to the elfcorehdr is
needed for CPU changes.

The kimage->elfcorehdr_updated term covers kdump images loaded via
the kexec_load() syscall. At least one memory or CPU change must occur
to cause crash_prepare_elf64_headers() to rewrite the elfcorehdr.
Afterwards, no update to the elfcorehdr is needed for CPU changes.

This code is intentionally *NOT* hoisted into
crash_handle_hotplug_event() as it would prevent the arch-specific
handler from running for CPU changes. This would break PPC, for
example, which needs to update other information besides the
elfcorehdr, on CPU changes.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 1900efcdf1bc..86d2ca80b9b2 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -469,6 +469,16 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
 	unsigned long mem, memsz;
 	unsigned long elfsz = 0;
 
+	/*
+	 * As crash_prepare_elf64_headers() has already described all
+	 * possible CPUs, there is no need to update the elfcorehdr
+	 * for additional CPU changes.
+	 */
+	if ((image->file_mode || image->elfcorehdr_updated) &&
+		((image->hp_action == KEXEC_CRASH_HP_ADD_CPU) ||
+		(image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)))
+		return;
+
 	/*
 	 * Create the new elfcorehdr reflecting the changes to CPU and/or
 	 * memory resources.
-- 
2.31.1

