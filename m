Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23CA7585BB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjGRTrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGRTq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:46:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00BB198D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:46:56 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IIEXdO031979;
        Tue, 18 Jul 2023 19:46:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=xN61s78+cieCvir+WXzr17QtOB3mXoboTfQE5a3R1GA=;
 b=aASp9zQb7WUOIyJ15Q9cJksPkcQ1elopEI6RgTZGhNhTN5vi/NEZ2oOaTM8H+iyhMOOV
 ddawa+nuBl30tna9RbcoZfNhS5vve2sDF+HbwmBIj1TXMYskMMEewiQ8MG3k/IBp7Kex
 MBJkoFf2LigY20tRIU1SGOXssSUHpDlf99WLzEh2ZOotEVriGyQDMckvEYVOc7CQhtbZ
 W8T3Kxv92FlkOs3WDsrpA84cjXftQ6mhoxfvqyeGUyuVv9z5jjSGeyu+PqccSb9tUUOZ
 CWme8bpRZ4PBpn1dAlDhJTobzMU0KDoGElZApZrDAiYSmSI1zz2beUY6kJeagmO5mIDE gQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a61gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 19:46:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36IIc7A2007749;
        Tue, 18 Jul 2023 19:46:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw5cqcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 19:46:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBdv75hduwfrebDXpUaTKbklBVYwZI97UREwuGkzw3R4QDO3BM+xIUES2PuV6USu8rosQlnraM3k97kfSuD3s1nr0C/faVqtVZeNwvCDIirVrZ3sZQoaPKTpEXR8QIJb7stippboJYzxe/jyQpMOeNuo/E+XznD6RIpDvtBIK857CldBr+zxPb1dcki347x+5r31lY/TghNnZyy9eDmCkDL09AZFMUolFkmzbL5h4ufgGMppZfsWkjYAOL+1YEf3u4l+PKZnrnB2mviwR21VrLA7aJQX7HcAtvrlOlTewIqOUWiB5j0JgnZg3mqx+P/capkjp6HwKpVYPoVhtAzNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xN61s78+cieCvir+WXzr17QtOB3mXoboTfQE5a3R1GA=;
 b=CfsnJtne4imvALVw/osNCR/vrkxEz5617RpWSHnqciTkLVFfatpZURGcvp/G//LCZwLlhK7fflsnajWcVhccO1JRtCQGlWXtKZtxNMaigp4q7NJjZtNeFKhfOYHTRgm59jYI17x+fcEg3LdU5u1x4b7OLG3EydSvftNdV3xR61UgpixgXV1A7cwCkgg6FsHqG3+CR22E1BDqqpSH7CMNFzQcKiuF2+EiN90l9qku1+Di6T3NQXdzrkdPh1bIM4toUM3XJ+ZHp90Qtmw+JWelH2G67jFRxnNQiXpRbChW+5HnfTn3DrVYJ1zyBcKotvVPIrtury9lJfuRMlxV5KjItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN61s78+cieCvir+WXzr17QtOB3mXoboTfQE5a3R1GA=;
 b=dkhtQZaHUQj/x/IxuU3xbxwRKNxcJpE/PYw1pD51T7YpvXREIp5O4eMNkf4YX0uzuc5VLNrpkpfGfnual7JxXKmji3IjsyC01U7EBnX9DDkCPgBO50sCb6e28Zahv4vxLU+joaynszYixEVUV4A2CMajHFEp9tEcWVzJbpeI3lE=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CH3PR10MB7458.namprd10.prod.outlook.com (2603:10b6:610:15a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 19:46:43 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::1ad9:6eeb:6c8d:27d3]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::1ad9:6eeb:6c8d:27d3%6]) with mapi id 15.20.6565.028; Tue, 18 Jul 2023
 19:46:43 +0000
Message-ID: <6d8ac6ff-2cfb-5005-9e1a-4ce1ca8133e5@oracle.com>
Date:   Tue, 18 Jul 2023 14:46:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fs/jfs: prevent double-free in dbUnmount() after
 failed jfs_remount()
Content-Language: en-US
To:     Andrew Kanner <andrew.kanner@gmail.com>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org
References: <20221201124628.603505-1-liushixin2@huawei.com>
 <20230701140542.2252-1-andrew.kanner@gmail.com>
 <20230701140542.2252-2-andrew.kanner@gmail.com>
 <64b6b235.190a0220.28c3a.1ee8@mx.google.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <64b6b235.190a0220.28c3a.1ee8@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0003.namprd16.prod.outlook.com
 (2603:10b6:610:50::13) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CH3PR10MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f896efa-d01d-4f3d-389d-08db87c7b681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0iKjicUVKkn/SDFQESlcQOwobxfyeGP57fvBXJCBjF2XxiSgzneh1RjCLSg5xR+Gpb7h2iS1iuPqz3+PoQ2f5cj0TXwO60QX4XUERIIk5d9t8rFxKH+9nMWhvYcC9afANSxd/tPgixaLUEyqNzrLUlaeomBJ7L149NTKnlQs5MAQtf7BMmA8htur6F1zMbTaIfFCEUO29pgN+v6E+Hq4NYpFGXG8Uxb7NB76ZYL8Ww+Te/oNBrCI9cso24+MDKg7euD6YV0r8BC7nDdIU56uWAnaD0O2lvNow2HGrQgYyH7/PMnJi7EAwr6om1z6w+BEMoGKlW3RF9FAbmBbXsptFQyhf1Mr+yGi285LtTnGCvtFMSSAC9NqMaz0mEHtE2cM2GDIjGBR/vZ8YInyQwvxb5xfcF4qmXoT43VzBdS+hGytMctExSIMpIy5kWJ4gmpPDMFGvmuSqRq+i7c0Y9TThIXhB1f3gYvxWDgWQfei1zNEzf50MChEogUpQ1Lgku6+TGUP57aBz+P8tkFoL22SpVp64OeCnNPmT6tfOWqzl7cfYelKkj3DyMLpnS9OXyVcGqj/hBy34ng1nS/IwWlw5gJ1pCyGtj4w/eSMivfJhX3iDem/7bqIIAcRqFZ43DrgjntPE9jxnfjq5kL+8GeQEd0hs9A4JYR5Z66xwrUxoNs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(66556008)(478600001)(6486002)(966005)(6506007)(36756003)(186003)(2616005)(316002)(6512007)(2906002)(4326008)(44832011)(66476007)(66946007)(41300700001)(5660300002)(8936002)(8676002)(38100700002)(26005)(86362001)(31696002)(83380400001)(31686004)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmJzY1Rzc3VuSEg2dThjdmtTbHllMGZ1U2JjTDZZWHpNdExyY2wzTG1JRVVH?=
 =?utf-8?B?QWdSangxQ0RBSUtWVlMwTVFJM3g2bW5haStuK0VrRGFNZFRlR2lYSHZUcE1X?=
 =?utf-8?B?K2o2Qlp3L3MrNkVyREJ2QWNQeU5ORUhBUXpQYlV2SDFxNldkY0ZSSG1QMmEz?=
 =?utf-8?B?V1NrUUt1REU1dlVBVUxnWWNDZWZaOEkrZWVmRXF2WTlFdVlVYXVaR3g1OTFx?=
 =?utf-8?B?Z3hBQkpNSGdoeG5pajhURTZQTmx6MHBJb013L3NFeTRqcUhDQjhvR0F3UEFs?=
 =?utf-8?B?cXduRXdXbUlzNnNtbEhlRzZwS1VEN2U0dG1qUWdyaC9XTUw3VGkzbUVEM0Zu?=
 =?utf-8?B?MWFYY0MrZGJVY3MyYnU1NW1zV0JCMkFXTU5WUnVlb0lqZ1FuUVdGSm9ka3NU?=
 =?utf-8?B?bUhmS2VHbEJJWlhFR2J4M05oQWRpTTJsRmJEamRsaVFET0pVS0NVajhZVE5J?=
 =?utf-8?B?a002b29kcDNCeUJYbW1KYzlUMmxwMkFCeWR4eFJYQWs2dXRnRExFdGZYVW9P?=
 =?utf-8?B?dUx2Y2xKM1dsdURPZ1lVczlSaytXaGFuNytFKzFPVEpBOHFZUWR2OWttVElG?=
 =?utf-8?B?aUY2Y2piL0NuRndOaCtYNjRHVWRtZklCdXRQcEUzYmo2d1lMQ2pTYkphODFs?=
 =?utf-8?B?ZVlzdG5tZGY1N2lEL3MxUVhaVzlOd09Fa3YycmxTYlJaU2IxclZ0SnV6K08y?=
 =?utf-8?B?WnFMejhiY1FMVWFDSEpRVS9tM1RrWE12akRLbkZjc3QxbFA3Z1F6eGUvMUVO?=
 =?utf-8?B?NGFBVVZ5SjV2c1FEeDlFVEo3Z0MxTHlxbFBiNVZ4bmI5Z3JpR1oxa1FoWWlr?=
 =?utf-8?B?dThBNmhuam43Sk02QXV5MFBHRWxyS1ZzandKSUpxYlk1clBuM3haaitLWmZR?=
 =?utf-8?B?MzgxMkVvS1plbjNNTjI5UHNMM2ZkOExlckh0eWpwRDdBTkdRRkhGdzZkU3pC?=
 =?utf-8?B?L0RES1cxTVBMMFBNTWEzaHB2R09tbE1MK2xGem4xaFhmK3J2NFJZMElaNXhL?=
 =?utf-8?B?RUxvL2w1OEQ5VW9jWGtXMHlzdEdXdUVUNXBTcHJmNWpHaUhwaVZBRWd4blBN?=
 =?utf-8?B?eTQ1UFB6OHdoV0JjbTRtdjRldnVscGVZSnZWTS9CNWdDV0FVMnNianJ6Z0wv?=
 =?utf-8?B?RExUSVRYbGowWE93WEdlRytTRFJoaXdGZWdVZGtOUmJwaEhFYkp0azA1bGNC?=
 =?utf-8?B?dDhZRGdteW5IR2dTNEp6TXBCNWJBWW5oQlFmOTR0b1M1YXVrQkxsR01Rb081?=
 =?utf-8?B?bkVKREFHeXVzZHowOXQzWVRGQmo4TlRUaUFHQVpOeU1uRkg2b0lZWkFXWFRo?=
 =?utf-8?B?TWhhUndpVnJBcmdsWFB5WjdMdVhOK2hYZ2N3dFBUU3B6UDVDc2swN2dZZTc0?=
 =?utf-8?B?Z2RUMElhK01UR1YyaWNQS1hITGg5UUlCOXFnRE1MbmhyMkxFbzkzVHQrNGFC?=
 =?utf-8?B?OG56eFhDM0grYnNXaEV3UTM1YURhZTVFL0ZwbjRNK0d1UlZRU3lGVFBRaEdB?=
 =?utf-8?B?QmdIVU5mNkdqc1NsZ3NiVnNGNWNGQ2prb3BETFYrSFNLM3BlK2R5MFJIZVJw?=
 =?utf-8?B?VFJncTNCeVp0ekdvenNjU3RNMXVKRlo3WDluaFp5akhtcEZpK1VpdFMvenJk?=
 =?utf-8?B?dlRnc3JpVVJsSFdqWVI5ekZWOFhwbno0NnpzWG0rekFKWUlzdERqVWxSRWhm?=
 =?utf-8?B?Zk15bjVJNVRYOTlYcElFMjQ1a2tYSDlCcmRYR0gyNlpiVVFYcUx3NFBseEtO?=
 =?utf-8?B?THdRa3RsL0hBcEJhUXpWRnk1MmMwY3RQMGhrRVNqTDJleC9kb05FMnJibXBp?=
 =?utf-8?B?Vyszc0NZY1hmeDRLSkl0c004K1hjVUQ0NnRRcGpqbnhlbGUvMlljRE1xdUp3?=
 =?utf-8?B?cExKbWRBa1pCenFjclpFZTgrSGo5S2VXbVdwRHVhVVhCNlBBWGpQc1RNalp2?=
 =?utf-8?B?OXMzcXk0cm9Ib3luQ29mS0pRMnk0MlNFUmg5NmU4WVg3RzFyTXRNZkdDOHBs?=
 =?utf-8?B?d0dlUk5XRmZ3c2pFMUQxdUNVY1V2U29XTFhCLzJSMldXamJhdWNyc2d5UjJJ?=
 =?utf-8?B?RHkwSnF3bE9naUl4MVVwKzVQejRjZWxQdG9xcjlmWXVIZWQ1V2NyVlp5VmZq?=
 =?utf-8?B?Z1l4S1ZOTUoyUklheHFvV0RKRFpMNnhUUk1EUXdGR290TTgwS0ZaNHRnNmtT?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J0BLJ4BOi+niAgkvzKeKupjoiak/99CDsgLxb5XBg0WQgvclHWvUZlp0HfillQuMhJtmPMLeRDvTufQ7A8YDB4JdCvgn8nRYQgxklDbzCHCz/r1ViqHhndgVu9kiaKdvRvKMx99asIMHNMs2DrbmKR0HbinIg4xtw9t//QO2L8wqEMvaOm3KfNgTqr53bxByyUeNkIVaRdfcr5k3r6ueaq1TMP9UWvFQk2QSdqFZuExa0JpunCXFK8EI3Q1ZMGmeG51xmOUYGABbAPgXLaDQPifykEOHu/+Of3sRmQEd0KgDko68zLJnjGJWMyg+lDe4oNe0gZPeg5nqGSAdkPzAyxgYhJn6P/X9T6xvxQhJXfA9o4QO+oQQfP7hHVCTktGwrN+ZCkvG8BS1BadqJDUISVM8TQvKqiLIxLStf73RgeSD+5Ho7HbdQOO60lwydb5UohKNL/R+bMZpYARG+OAgN2yiYdvUvvDB1H4kLfuGVYZSJwAQH6k0s36iVWryQ6zej5ry31b4dZX9CEFIG/6ztUhuFmE/V1gtBoch8vKpGFy3da//x45bTbcgE8iJi6Cb0lpZGddyHb5ePCv2JyznIHBec+Q/X/6hLBolMI07iLPeNz9f+gfdD1e7/Hs5n8mvmzRgnt2nS8yA09nkYPlhy/x7VEeHD65/EKCQFhlqjEPHusAsgRVrCIucVE4zUzeeUEbZfZQOCBHlYmEf6YV6x2sqmf596f+fhhFrEnvUzO1vBd7e2RV9vIoQbn7KfaDFq0c1yliUGXn59c2q0CbhJntIpbJH0Vg7+QJtAbvuK2A3so+zFuPri+KHCeO0W1UcKA2hVOrwqC5jIE+RJO4UzoB0yyAcXV6xWE01wy5aWAJSXEhkHIqclfJMk3WAiLuUZPbYdTeeEbb7dUVPK9dI0SnDWNEoLi9bsifld+ZerD4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f896efa-d01d-4f3d-389d-08db87c7b681
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 19:46:43.6474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fehv7HIf+tmhp5iqTrb0E6K9htztIgBen8fybPrUdoTZFRQC7b7msrzFtBYCyj2XM2TugI44BEMeY52TYu9mTnNfK+zpclZP/DurckWeIlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7458
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_15,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=947
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180180
X-Proofpoint-GUID: t-L5JKkL7DO3nU13XVWIqBU8GRvWr9ms
X-Proofpoint-ORIG-GUID: t-L5JKkL7DO3nU13XVWIqBU8GRvWr9ms
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 10:39AM, Andrew Kanner wrote:
> On Sat, Jul 01, 2023 at 05:05:42PM +0300, Andrew Kanner wrote:
>> Syzkaller reported the following issue:
>> ==================================================================
>> BUG: KASAN: double-free in slab_free mm/slub.c:3787 [inline]
>> BUG: KASAN: double-free in __kmem_cache_free+0x71/0x110 mm/slub.c:3800
>> Free of addr ffff888086408000 by task syz-executor.4/12750
>> [...]
>> Call Trace:
>>   <TASK>
>> [...]
>>   kasan_report_invalid_free+0xac/0xd0 mm/kasan/report.c:482
>>   ____kasan_slab_free+0xfb/0x120
>>   kasan_slab_free include/linux/kasan.h:177 [inline]
>>   slab_free_hook mm/slub.c:1781 [inline]
>>   slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1807
>>   slab_free mm/slub.c:3787 [inline]
>>   __kmem_cache_free+0x71/0x110 mm/slub.c:3800
>>   dbUnmount+0xf4/0x110 fs/jfs/jfs_dmap.c:264
>>   jfs_umount+0x248/0x3b0 fs/jfs/jfs_umount.c:87
>>   jfs_put_super+0x86/0x190 fs/jfs/super.c:194
>>   generic_shutdown_super+0x130/0x310 fs/super.c:492
>>   kill_block_super+0x79/0xd0 fs/super.c:1386
>>   deactivate_locked_super+0xa7/0xf0 fs/super.c:332
>>   cleanup_mnt+0x494/0x520 fs/namespace.c:1291
>>   task_work_run+0x243/0x300 kernel/task_work.c:179
>>   resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>>   exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:171
>>   exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:203
>>   __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
>>   syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:296
>>   do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> [...]
>>   </TASK>
>>
>> Allocated by task 13352:
>>   kasan_save_stack mm/kasan/common.c:45 [inline]
>>   kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
>>   ____kasan_kmalloc mm/kasan/common.c:371 [inline]
>>   __kasan_kmalloc+0x97/0xb0 mm/kasan/common.c:380
>>   kmalloc include/linux/slab.h:580 [inline]
>>   dbMount+0x54/0x980 fs/jfs/jfs_dmap.c:164
>>   jfs_mount+0x1dd/0x830 fs/jfs/jfs_mount.c:121
>>   jfs_fill_super+0x590/0xc50 fs/jfs/super.c:556
>>   mount_bdev+0x26c/0x3a0 fs/super.c:1359
>>   legacy_get_tree+0xea/0x180 fs/fs_context.c:610
>>   vfs_get_tree+0x88/0x270 fs/super.c:1489
>>   do_new_mount+0x289/0xad0 fs/namespace.c:3145
>>   do_mount fs/namespace.c:3488 [inline]
>>   __do_sys_mount fs/namespace.c:3697 [inline]
>>   __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> Freed by task 13352:
>>   kasan_save_stack mm/kasan/common.c:45 [inline]
>>   kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
>>   kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:518
>>   ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
>>   kasan_slab_free include/linux/kasan.h:177 [inline]
>>   slab_free_hook mm/slub.c:1781 [inline]
>>   slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1807
>>   slab_free mm/slub.c:3787 [inline]
>>   __kmem_cache_free+0x71/0x110 mm/slub.c:3800
>>   dbUnmount+0xf4/0x110 fs/jfs/jfs_dmap.c:264
>>   jfs_mount_rw+0x545/0x740 fs/jfs/jfs_mount.c:247
>>   jfs_remount+0x3db/0x710 fs/jfs/super.c:454
>>   reconfigure_super+0x3bc/0x7b0 fs/super.c:935
>>   vfs_fsconfig_locked fs/fsopen.c:254 [inline]
>>   __do_sys_fsconfig fs/fsopen.c:439 [inline]
>>   __se_sys_fsconfig+0xad5/0x1060 fs/fsopen.c:314
>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> [...]
>>
>> JFS_SBI(ipbmap->i_sb)->bmap wasn't set to NULL after kfree() in
>> dbUnmount().
>>
>> Syzkaller uses faultinject to reproduce this KASAN double-free
>> warning. The issue is triggered if either diMount() or dbMount() fail
>> in jfs_remount(), since diUnmount() or dbUnmount() already happened in
>> such a case - they will do double-free on next execution: jfs_umount
>> or jfs_remount.
>>
>> Tested on both upstream and jfs-next by syzkaller.
>>
>> Reported-and-tested-by: syzbot+6a93efb725385bc4b2e9@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/000000000000471f2d05f1ce8bad@google.com/T/
>> Link: https://syzkaller.appspot.com/bug?extid=6a93efb725385bc4b2e9
>> Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
>> ---
>>   fs/jfs/jfs_dmap.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
>> index a14a0f18a4c4..88afd108c2dd 100644
>> --- a/fs/jfs/jfs_dmap.c
>> +++ b/fs/jfs/jfs_dmap.c
>> @@ -269,6 +269,7 @@ int dbUnmount(struct inode *ipbmap, int mounterror)
>>   
>>   	/* free the memory for the in-memory bmap. */
>>   	kfree(bmp);
>> +	JFS_SBI(ipbmap->i_sb)->bmap = NULL;
>>   
>>   	return (0);
>>   }
>> -- 
>> 2.39.3
>>
> 
> Hi, Dave.
> Are there any objections?
> Or maybe suggestions on how to test both my patch and the patch from
> Liu Shixin (some corner cases)?

Looks good. Applied.

Thanks,
Shaggy
