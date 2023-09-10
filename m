Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189DA799D95
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 12:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242231AbjIJKBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 06:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjIJKBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 06:01:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB6BCCF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 03:01:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38A9tmdn026199;
        Sun, 10 Sep 2023 10:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=4JgimhLxZsvjmkrInuYCtveao39YFwuvWjoC5Vx9VMA=;
 b=4J+xalRaCnhNBI0jUyTdjHwPqbFDxPZPkbKHbXQulvR6MhjFCwIsJ/3WQdH/dMPTu4a7
 LHcGb5XqSftU2CkrgNA31M8BLXOPdLwfUw1+bTs/d1hqaltWkE27sAHofZ0OznniDbuf
 Wwu03QF2PAtMpwn4K6XRpgM6G2KFCFYPVR7yVoqDRMkJgdzRTc0cQ9bdovxggya4JreO
 wP/GhxUE39zTWZHmnc6uU4EgafnyDds8D/zEgH6+B9jqb0TppqFgKAeyvx0GRw1Fh2zT
 uT79W5MLMGx1XoqqGs5IlSWC6CI8vxtSIzVt2BxDAgSshX5Ik9bF87A/rovV9BqLTFLD Lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1bjyg03h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Sep 2023 10:01:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38A9DPE7002655;
        Sun, 10 Sep 2023 10:01:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f59d78d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Sep 2023 10:01:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N50aluMAG023hLGIDcsUVj2cYVUbDQqvlCzMlqSOXCT1pvHL2CP0NMq3wro4hpWjUDAk+G9VAudYPofguw+CqlpyDSFcTWkWvvkYbcnuSB5MrbR+CDdEXlIZKmdZe2gO/ttZ4NMp7YTrk2UqSzyojJoDaEF8bahJzsuOaYrarxywHzLeSHY6VZcWyT7J1OkveLZ+XkKI2RM9nfGe2LDM20QCi5RP2cH+8Ugrc7fUo/CNzVXNFNV0bDtOFBzlR6f7d8JEDt5uUU1Zg3yFfqi1H0y2aO0Ie1SG28rsKk5ZhVt6TtaHelC03y8xJMTWES2e8zeC/AUFmCwJMKB+I7isbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JgimhLxZsvjmkrInuYCtveao39YFwuvWjoC5Vx9VMA=;
 b=QemdFDCENZIg5/Y7GIJ3wThmPVnG1xcu9auh0coTUZSgRBxIhGnWIwW3hNUwI0sYE1Xga/HsqeshZc/IW5u1KcIdq37muJewsmZIVIezG10oQbo7B2hhjRwZFPxpAbcGU6eIve6Mtk/NyNQu/FhJZ08qJ8FnjO9A59AKivreEN1XS7KcgXFIGvnHd7tPqWeEv2i1P/r6AMJ94keXkUgBQrtIOzowjqxiYqggctz8jzMF/pEdCNP33bqTBNqHAPs3m3JQFuLtIDvk7va9lqyyGZGK8xO3Kiw48A7obEPyKk47xeGCZjCsY5ZVBmqHH8LOCkijNxfcqn7VuuWRTlEBFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JgimhLxZsvjmkrInuYCtveao39YFwuvWjoC5Vx9VMA=;
 b=P+Nny4wPR6HPbUcEFT/aPQotmO/rkVs4Dt7cb5JnPUAqSxGkpbky2L+JDh5+bswtjjJX0pO7ZQhnU/RW8Jhj049wUMaMAEzzRRDz/hCuhumvuy53CMCM9+lTPffFNJn/T5Ctr57xWpsYyVRP8hSQvulsLxuHtFMjSpoBDDqOn9c=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH0PR10MB5115.namprd10.prod.outlook.com (2603:10b6:610:c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Sun, 10 Sep
 2023 10:01:04 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03%5]) with mapi id 15.20.6768.029; Sun, 10 Sep 2023
 10:01:04 +0000
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-reply-to: <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
Date:   Sun, 10 Sep 2023 03:01:02 -0700
Message-ID: <87zg1u1h5t.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::33) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH0PR10MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3f006a-172c-4d61-8764-08dbb1e4d86a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfLSw/xiNteG2I7GAg8smlYAQtai9kqcU4kMeMD7ioo+Dyh7PtM/xQEKT0+xdJDoHPczYl9KDB5WDPegyPf16fQFbBziVbo6xqqyae/shNwZZnWyMhTk6gfLj2KkLk1GHiDI1arv4g8ygzTP9z/tYycg1RN+S2vMBcPMfjZvEMPRa6lFczxk1PIw6tnNSV0fXU3Nbsdyn46h578NAAxl/vOyKCm8ya69PslFIoNmU0OGjwiC+UBygw7OFbprvGSsgzaL+hzo6zNrktdgcl3ajVBkJWql/kf0QqJg2M4RAXJ2hxmg8KgVVU1w9VEhlmjyexEbHveQ9GVIUOZgYBMnV1YCqvl32s4HD4mdOVrsHrebNK7wwIGQWciUDioVoUYrj3uT91o6yNbM5ek9b9rEc56NKqFINnqYG3wfe9vxE+/85GNpaauYc7vcFDShdT0Q66iIt+WuDY73QTY8Pa+YRKBeXKt+2z9Y+hYFIiEgZ30s83igAFsdROuRXxqw7LEq0o7vR/lV2hCyxpukTEYeMCpGi0h43D8QwObwibglMMivYDJO8MSNj95S4OULqiQO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(186009)(451199024)(1800799009)(6506007)(6486002)(36756003)(86362001)(38100700002)(26005)(107886003)(2616005)(2906002)(6512007)(83380400001)(478600001)(41300700001)(5660300002)(316002)(4326008)(8676002)(8936002)(7416002)(54906003)(66556008)(66476007)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MI+ZcrKxEE/aAeIQBgncbWR9ZPlqBU46om97V/P9lV0S8GsLhjECEmrL+QFf?=
 =?us-ascii?Q?F3ugK4YqxD67B4UWAsxYn9iOyZ7pAWYJdSfYhsnZ5MwYVRxeNg2FslMa3vrb?=
 =?us-ascii?Q?Ab9SS6agGlZ1fcaTt1K6QwrmHfmd5biaCeqjklr7yg6Ds+nbK9NqmN9J3Z/c?=
 =?us-ascii?Q?nVL/NBM5q+TysyI+ILmCeVCJDORcRf7lT6vR95//dSVmBAgfqwpCpVLX8QMs?=
 =?us-ascii?Q?SWZvshPFHxBpPT/E5q8NcsRnhcHbxe3KbXeqsW5hPWZw3E66bY8pcSyLFs+V?=
 =?us-ascii?Q?7XVgGIY3/S3+UqtjozZS8PnFzXHOZpmE1HHlxAyOWOzzOA77ovqHS8ysIKhX?=
 =?us-ascii?Q?S2GMx9Q0VnRQrLIdLD+IEoheoyKsUpOzxcZtpc/X43gj5i5wGwpmGm/Tjr8m?=
 =?us-ascii?Q?J0QX4mLeT0XWvUDGkf/RpnICYfMga696VilkGm/pqH43QKp5YLJFJFVdRrpx?=
 =?us-ascii?Q?8UvDi6LYmCEEki5GEt07w9uR3qzAvDAgFY1UlYCatTwflhR+M4yBBxKERg1X?=
 =?us-ascii?Q?wvSQvtcSsDVDIK+j9xdVZWTA0YO6rqe2Xl48aQW8jGf5L2TGchY3fKrJEmNV?=
 =?us-ascii?Q?htzCXr2nWGV1CD7Psb45wkq5zXrP1j0bFDL5+/Zet+BD1nPA1Hr/C56sRZxY?=
 =?us-ascii?Q?c1moroIdhMGiQJnrh7aEDwCxUPNEYX5lLD36pbKHaAUGQ3GpFtepHVMAm2wl?=
 =?us-ascii?Q?TdShQQvETDvDZPn2h3zxX+fo24LvtrR0Np3oJc9pnOzmBVmumsa4Mr8O7ZGW?=
 =?us-ascii?Q?0gTanEDOFACqqLoiKgDGH9kMzXwJXxWkFJWNqzUs2yPsf6990wLfUHskzDls?=
 =?us-ascii?Q?2FFmEijZAexBM/70UsxynlddQv/xv5OeZVtMSyq/eMrvunyRK4f1jgWSFZJ6?=
 =?us-ascii?Q?YAWnk5Q6KRebJjR2TFMg6CcjlLdaRe78T8BwKeYc6hsLC5z8mb6whFQkemOD?=
 =?us-ascii?Q?dfsvEvcx6iPk8/Fomg8orcIqkTQQR3lLaS1VcUSOreI7rl3YWNGTm/4NAiSq?=
 =?us-ascii?Q?TtpyQc+HumSnTuNj8bF1tok/B3BMFD/2Peqsl1pFphmvzwHsrL8MxJxY35HF?=
 =?us-ascii?Q?LJS13XtaN9B4MvhfxhodsgnFjabPiabZBV3C0C7Ma+T93zrSytS7MoVJyw5z?=
 =?us-ascii?Q?B0dqYj41l8E32UfWDhONi7wCivfrxfUmHOKf48IWcfenvfZn50lQN5ptWyaG?=
 =?us-ascii?Q?KguSJDW4hedsSds3WHBPs5kj1R8Ykze+w5XVT4WGKTXB2W5IBzXW9P4y9YAM?=
 =?us-ascii?Q?mD+XL55KRRyKg+zNWFWun3Qqp2xOnK3uLoPzaZ11Z02QUzt+7b1bqs/9oB+c?=
 =?us-ascii?Q?6M7De+QCNxW4srHoa0xQmmDCr+rUNQ/i/19cgKdRIJ4ZjRjAyGknCR81lfwU?=
 =?us-ascii?Q?wJds+hXBeOMoIBfi5tWu7bYCzdkj8/eK+ZG3EFVIDZmMZfVjlMxNf5G1chSn?=
 =?us-ascii?Q?dZBHo4pLfvLJGk5IbQyp1cBjfggkl3la7NoP2031oTn+nYyNrOjdm3Eh9iNH?=
 =?us-ascii?Q?8ujPmyS1iOpHHUB+hE2gwUaZb0r5E2gfo1PXhh5eW41I4vYMLqpBVO18FIVJ?=
 =?us-ascii?Q?mDiUXk56mMgP/Wo+3OKI3Jm8n0Y59ege+IvH6zEf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QYBxZs2pvB8yQNDBbhEdtUm1e7PgOu3Y5qOy8IBQUhQGWITworuAL+7+LoJh?=
 =?us-ascii?Q?PLYty8/K/6X1EKrQeHnkgtEnh8mu0dG7O97cCL1qpaKa9WeFyaWy/EnemMtq?=
 =?us-ascii?Q?ZMnMEGUe0LbGQY9GZK5C4Nx8gntZCU9TJEFHAU/5WF7EmTI3m5DYuiqhGi0J?=
 =?us-ascii?Q?2bBl6s6NTPvSvGx9N/VcriCNAcBDVXWnIrfEYmAZDe8KoQX/tlUdqbEZM2pc?=
 =?us-ascii?Q?jRd81Vx3q3nw3KVdROrQwGEN9S0E89Gt8C8pnL2qeZhJsbOCR9CZJOOGhnqO?=
 =?us-ascii?Q?+Bwvis/eYUEYJ+EXq80zLgC2NZR3ixLKJqvIp1++HRhOtbhbTMDbf/+yx+GA?=
 =?us-ascii?Q?nAOBpDc/QWLUN1fZ/gtPsP1HMQkHUefejJtqmqFKIybQd2tBwzRKqERJvwlR?=
 =?us-ascii?Q?5yA36he4moy3fXJ7tXM2lZJjICzGFXXvFoxbwHe3ctaSgytV4kJ2ffAI5hl7?=
 =?us-ascii?Q?flbDwN07HcxfoX4PTifzIRhLMCyF7XaFRZQXjNx8BMiqBcwWL2+Ftd98Mysl?=
 =?us-ascii?Q?kzi8NcIMMhIrU1YlP/nAlepzRNSW6jmvoJq+qM/IhQF/fjj2mZxiQSEWa0iK?=
 =?us-ascii?Q?A5ziKTkqHWfbu8BMBB+cyMU8bAl9xB8q8Q95yvQSLZm/I0Rc0KF9HZcDowpu?=
 =?us-ascii?Q?vxewX2WcS91mAP38dG07BfekbJs77/sgwlQJlCvjKx+jvoWqTxhaiOEidHLi?=
 =?us-ascii?Q?rJiPriOm6D/fpoNE8pAOb0d1g/FEhW9Se1WUOVlu2qiQ+c+C65pQJUYwwFd7?=
 =?us-ascii?Q?svfX3qI6Br0fHBQy+J7tLOSffa3CenyJUiW/X+qIgxZe6q5V2LjexGzsOtsh?=
 =?us-ascii?Q?0ZexqEXpYKP8TBtruN9Aqhy/f9hvRjELAZJxijXnecENAELutRrdZlbln8Fu?=
 =?us-ascii?Q?awCWVdj/xlVtyzI7VRdmTpg18LK2eOMPbheRNdVErakEr8LHw3tI+Jic0DPK?=
 =?us-ascii?Q?6s/5Bv6iBADrAGySai2KHJohZiwtAkqr2YjS6LLVmpha2Kl+4wnGf4L0LWiQ?=
 =?us-ascii?Q?tVKC1DJPAQoaE3m7pRVXhvz+y+0DIRmbTBkeL59tAWk3qQVOdlUXEw+iP1fs?=
 =?us-ascii?Q?jD8Pr7GdK4nAA0gf/0MWrGhxnS7SZFupVCpw9lgvEtFpH7vr1lI8wuvERxvt?=
 =?us-ascii?Q?FtmvT6arxLF3y9wTghskr3OAWwxsrvLUBhhXhMiY8VtZtf3Yts9RKkU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3f006a-172c-4d61-8764-08dbb1e4d86a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2023 10:01:04.7501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FLKKqK4r02nwSr0wRkugiy9DRPocUI7088JbaEHqM2dDlVWpx1SJvHfB8K7PAQoqFF3lN5PkTKcrpNZ3dmOpSjY5TUzWwzTLBqCPlNhhys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-10_04,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309100087
X-Proofpoint-GUID: rQSiIQwos_746ji9PByo1DT2h81bJ3mR
X-Proofpoint-ORIG-GUID: rQSiIQwos_746ji9PByo1DT2h81bJ3mR
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 9 Sept 2023 at 20:49, Ankur Arora <ankur.a.arora@oracle.com> wrote:
>>
>> I think we can keep these checks, but with this fixed definition of
>> resched_allowed(). This might be better:
>>
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -2260,7 +2260,8 @@ static inline void disallow_resched(void)
>>
>>  static __always_inline bool resched_allowed(void)
>>  {
>> -       return unlikely(test_tsk_thread_flag(current, TIF_RESCHED_ALLOW));
>> +       return unlikely(!preempt_count() &&
>> +                        test_tsk_thread_flag(current, TIF_RESCHED_ALLOW));
>>  }
>
> I'm not convinced (at all) that the preempt count is the right thing.
>
> It works for interrupts, yes, because interrupts will increment the
> preempt count even on non-preempt kernels (since the preempt count is
> also the interrupt context level).
>
> But what about any synchronous trap handling?
>
> In other words, just something like a page fault? A page fault doesn't
> increment the preemption count (and in fact many page faults _will_
> obviously re-schedule as part of waiting for IO).
>
> A page fault can *itself* say "feel free to preempt me", and that's one thing.
>
> But a page fault can also *interupt* something that said "feel free to
> preempt me", and that's a completely *different* thing.
>
> So I feel like the "tsk_thread_flag" was sadly completely the wrong
> place to add this bit to, and the wrong place to test it in. What we
> really want is "current kernel entry context".

So, what we want allow_resched() to say is: feel free to reschedule
if in a reschedulable context.

The problem with doing that with an allow_resched tsk_thread_flag is
that the flag is really only valid while it is executing in the context
it was set.
And, trying to validate the flag by checking the preempt_count() makes
it pretty fragile, given that now we are tying it with the specifics of
whether the handling of arbitrary interrupts bumps up the
preempt_count() or not.

> So the right thing to do would basically be to put it in the stack
> frame at kernel entry - whether that kernel entry was a system call
> (which is doing some big copy that should be preemptible without us
> having to add "cond_resched()" in places), or is a page fault (which
> will also do things like big page clearings for hugepages)

Seems to me that associating an allow_resched flag with the stack also
has similar issue. Couldn't the context level change while we are on the
same stack?

I guess the problem is that allow_resched()/disallow_resched() really
need to demarcate a section of code having some property, but instead
set up state that has much wider scope.

Maybe code that allows resched can be in a new .section ".text.resched"
or whatever, and we could use something like this as a check:

  int resched_allowed(regs) {
        return !preempt_count() && in_resched_function(regs->rip);
  }

(allow_resched()/disallow_resched() shouldn't be needed except for
debug checks.)

We still need the !preempt_count() check, but now both the conditions
in the test express two orthogonal ideas:

  - !preempt_count(): preemption is safe in the current context
  - in_resched_function(regs->rip): okay to reschedule here

So in this example, it should allow scheduling inside both the
clear_pages_reschedulable() calls:

  -> page_fault()
     clear_page_reschedulable();
     -> page_fault()
        clear_page_reschedulable();

Here though, rescheduling could happen only in the first call to
clear_page_reschedulable():

  -> page_fault()
     clear_page_reschedulable();
     -> hardirq()
         -> page_fault()
            clear_page_reschedulable();

Does that make any sense, or I'm just talking through my hat?

--
ankur
