Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867637AB2D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbjIVNj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjIVNj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:39:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AA2CE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:39:21 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MD08mp009333;
        Fri, 22 Sep 2023 13:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=u13VGdXcP6WCdOy6i1WsWxAvdw09MaCsHikSyJXHPI8=;
 b=PkkciLw/pP11S1OBHkhezWYzuOKeE4h6570RUA7J8NhfiuZb2/CJAChTCEYh/p4dflzB
 TVhgZ/bTgTx32JGi9go4+A2ifFtGZKEG1vxKDb4cUHWDjStDI0L7zzWBzrIWG8UDkUiM
 bf7ox033b7H23vR8/LkaThWxKG7LP6QrUdxJKnz8OJ7YiMzlo2OlPqXnre1SHl+LYnDt
 5bM0+wBRAku8l8dbCX7SfQq6IfPOnCQvumZRO8CzIAUvVhosxQXa3rGz/bM20JU4Q2If
 1FaHiY6fSMB80z1N//VRHgLxgfx9j3ilCqMcJiSg3istcAJVEVGG9vEDQZMOpLIPHY8O CQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsxstx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 13:39:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MDXxID021327;
        Fri, 22 Sep 2023 13:39:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t92vxcnb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 13:39:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZZs1MavlL1js11V3wxsOsiwKEuNasMm8Mnf6USx07ZlGy9N/7yzM5CZFVe16t9x39/XwoYtksORXwJc0zbtjRJnEvCc9xclkT1HcAx7bF+REgQSx7HIepuGVIRMkWfewbOmlSVHR0tv5JhryjGato0bmylfNCML8zMN0R3fZAFe8ZrBmWFjDJOrJLJ3rvVIbrLuphmRTDOoLWeXWqbXfYOP5L/BXJ08Zt+7ZAIrRW9JUAF6s12tPE/IxT0rkCZLdC5bBDhzmoQlQdFFZNhcnBH6vk+jIUBs2l17piyU/QuMqUVI+FRpyfCYaZbWToGdDL6YZIRDiG0L9RQMkVN2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u13VGdXcP6WCdOy6i1WsWxAvdw09MaCsHikSyJXHPI8=;
 b=D2ecHi/ZMKcu2vh++kmKt8SAzmVXMtmkdxSowfceXSdBFnLudKAHAokz8VB/CNRnDNwuj57zWBGQcdoJEl+cvVn2xKOt7xdumG1OisBciTndM5+WQJ8uU91f5lzz7rjw+i08rHIVWyLXLTI90JiZy+1mpYqk5fLLyykybDaITwWxg6HdW6uKbIPTat9fvZF3/aQnho7xizrIwDxSumhs97Rxa/M2JE9Qa4wWEdTPIqwp1a6mjLSO9kMQrzXZA1u9s7P04yiz5D4SSDXowE1NCUuVFHIwmNiLtNnic4G2Jhz4KFRl6RD4FD8cKasy8XqHUzX5wJjc4wLBzmtDj5hBsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u13VGdXcP6WCdOy6i1WsWxAvdw09MaCsHikSyJXHPI8=;
 b=v6nqYlHK+ELx5TfTTupbwpgLFcddunTprVBQiuVlzquNsw/0l26iOPAnllOS4TG9JKwVG+kbP4qyQgG4xKzDxCDJr9efe8RKqqluVhoyWVTVJ6reF2605cdnbQTMvVMZTk6t/PcQFdaJNZsTFRAxIaAd/AadBU8AwhNWOziCjCA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN0PR10MB5912.namprd10.prod.outlook.com (2603:10b6:208:3cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 22 Sep
 2023 13:39:07 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 13:39:07 +0000
Message-ID: <aca85963-fe1a-3386-82c7-6b64a3bfca87@oracle.com>
Date:   Fri, 22 Sep 2023 08:39:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] kexec: change locking mechanism to a mutex
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        vgoyal@redhat.com, ebiederm@xmission.com,
        kexec@lists.infradead.org, sourabhjain@linux.ibm.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        Valentin Schneider <vschneid@redhat.com>
References: <20230921215938.2192-1-eric.devolder@oracle.com>
 <CALu+AoRv_Y3e2SmyftTLcCPzPbfjshc4dwO+fFK9gwtsgWfyvQ@mail.gmail.com>
 <ZQ1K88Il1F2I8JGR@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <ZQ1K88Il1F2I8JGR@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::30) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MN0PR10MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a2776e2-66bb-4a33-3bec-08dbbb714b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fwW9jJWBusxumUtnDbPhvoGFTfkuuySwwIz1KmDO3la4j0j7RlMgxuACUE+jYdlF/fqN4V8yQkwKmNl4YdNTrIsMGfIu1ynddwEuM2/xjxaGyE74npFWMxoGVaybDGgJi9wvgV6FUESzolrSbWHNNyhfGQxCsB7Xxug68gaj9ENoItEHf2w6OWLp7wwc9ui33dx87cpkaFmr7u6mWUgC0HpKVoLnWfLSLbrmievZqrfihykJGkVt99Vo39BbQAh8DsOU58r3F4z2GkhiEk1woOVI364Q9hdIsuhg03BuU2OFAYlkeWn/DKVAkNmIMXt/U1JyxhbQznRU7gcnKzgGZ+VrxXy7+KjarVI+gLGV/hrpDV7mtRM3GcH5NOunTweXxwcqvFytY+Ga0uyd5YLsT6CyM4BQss577FC14conibVn05q8skApMvDUtx3J6O1CSn6GXetbXdaBWqMoDYaKZVb+qMqb+zBJQu3tfeJlEoe2Gdrd23XUe03kWeo51+o/p2nrm2QquosBrFgV9+I7YPQ0wafT26wBXK+/QHVmZuakCqOio7POqU2PbDjJrU6GPqGBlD0h+7ZKzCfmJUjVN1iyxfTC14F7phBgq2iELmMmql03+zNJBXG7dC5cud3eBS/Lpoo4TvcL1UGpExuS4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(186009)(1800799009)(451199024)(478600001)(38100700002)(31696002)(83380400001)(6512007)(6506007)(36756003)(2616005)(2906002)(6666004)(53546011)(6486002)(26005)(86362001)(4326008)(66556008)(66946007)(66476007)(6916009)(54906003)(316002)(8676002)(31686004)(8936002)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWN2cW9UdzRZQkpRbnFibGpZQ3pTeWtOOE5rV3lQWG8zejAyVnN4VnZIM2My?=
 =?utf-8?B?VDBVV3ZYVTVDQVpxYmxXMDNEMjVtazhhUDRiRHZlYWxncUR3WnduMzJESVl3?=
 =?utf-8?B?VXRTQ2FTR3BtT290MnphWUN5WUlwVkwyNlIxdnRldTR3Q2RWUDJwUWwwdEo1?=
 =?utf-8?B?Ti92YVdpd0pDeWplZFB4MThEejRjMDJUczh0d0JhMTlIcDN6Njg1NGI0RzZS?=
 =?utf-8?B?WFo1NlFxN3NSQzZZamxsVjY5MkZVMEVXODZHRzJPV1YyTmNDZFhPL3BlN3kv?=
 =?utf-8?B?cTNadUZaMExjaFRLYU1uQXBsNWdDNm4vdVJhaEJQZGluZWRXRXMxTHBHV0kr?=
 =?utf-8?B?dnBKTURGektYaDRvQTlqWFAvTnRKenQrSithQkdIS0pRT1F2SmVHY1ZrZmh1?=
 =?utf-8?B?ZWsyMDk1M21uR3VPcW44SGVmVjlySmNvSDgzWW56Wkx1S3FVcVpXR2FucVlz?=
 =?utf-8?B?eVpJT0FDN0hrNWJlUHFGdUZGSTlTZGtadHQyTktJdHVmbTJaQnhJMHAxeHlS?=
 =?utf-8?B?bkJ2cDN1bDVyOUZkbTl4YlVoTlAzYWMxYTJlbytjOWdCTjh6UGlUVDFzSFRE?=
 =?utf-8?B?QUIvNExDdDh3bHVVY2MxOUNYakc5VUc4NTkyQ1VqclVYcUpCeFBkQXc2VWNY?=
 =?utf-8?B?cTBSL1JHZkNYSURTR1pPcituOWVuVUpUaE8wRmlvQjNHb05Sb01SVXdhZVRX?=
 =?utf-8?B?WTltaFJoMytFS0tnakVva1lna3hMM0JBd0VYWWNJQVZmU3RjT0FaWkVFSkda?=
 =?utf-8?B?RklvS1JGN3pWTlpVUEJ3RkxMcndNVTFhMnZEK0lrWUY5QTVKK2EycUdGYnlt?=
 =?utf-8?B?aE8rOFppWTFTVGhXc21kTlZEOVQwcmh5NWFMYTBhMnlTMks1TDdoMmZqR1lu?=
 =?utf-8?B?ZnJVUHJCQTIvU3dXY0lnMmRuQnNKUkxCbmQ1VlhBRUJCdkUzUWZGQ3IxS0RP?=
 =?utf-8?B?N0MwcmN6N29ObEVhRlFCRlhoUGs4YzZzWGNoZUE4elYzY3hEQW1DWGhPbTls?=
 =?utf-8?B?OXNrVkVFN213dkY4WjdWNVd1Y0U3YW00Ym1TNk5JK3pKL25CR0RqWUordjZv?=
 =?utf-8?B?alV2M0VzYzAyL1BJZCtJd3pHQ2Q3UXhFQ2U4aTFTM1pOMXNnUGZJb3VwaHFS?=
 =?utf-8?B?NnlCUkxTempaalo2YVV5c1lZQml2bnA2L09id0llbFVhTU5IWlJSang3OHND?=
 =?utf-8?B?dGFVM2ZwVXM0TzgzTy9GNDBQVjNwSFM1NmNwR1hFTUkrME1POVJHSFpyL1FB?=
 =?utf-8?B?bmtRdTBibUh0MlE1TGNYRHBIU0lvOWhDcEJ3ckFadDVDaDJVd2JuakYxOHcx?=
 =?utf-8?B?YTYrUXJVWXhvUzFGcnBGdjdBQ0FINlBpM3JCL1lKRzJFRkRlOS9XK2Vsdno5?=
 =?utf-8?B?S1phTHd3WDZnSCtOUlF1eFhFNzJUL3drSHFMNXh2d1cycXRCYmUwdi82TFFj?=
 =?utf-8?B?dUNFcmRjUkdEMnJGdEM3LzVNdzgwNVVMM0FxQjRTdTFzR3lsVHBjb3VUM0Yz?=
 =?utf-8?B?b2ZIK2p0Sk9Ha1paZ2U1S0NxVTJtZkk3U0FibzkxQnJTbmVQWWtiSkJnZlBs?=
 =?utf-8?B?cGh2RGJHZGVLSDZQQ28yaWlocEcyZjlHTlQ4VlNYVTdJN01iS1lmVytkWlp6?=
 =?utf-8?B?NmtJOXF3c09GOWkzTkRDcHMyU2g1cExZcnNuSHkwcE5LUHg2R2NhZDBIc0gw?=
 =?utf-8?B?YmRJb3NOckI2Q2ZWbm9EekhHcjFQUHBlUHFwU2NaZ2dHYmh4ditYL3o5NzNZ?=
 =?utf-8?B?eUlac2g2MjliTUtiRFk4V0FFd2U5aVV1QjdGNnAycTJjeGt5QUg0T1NMbldV?=
 =?utf-8?B?UTc1RWQ2eDNwOG9ENlFrazdGVGFySTlaWldReUsxWG53ajNRS3BCRHZ1Tnho?=
 =?utf-8?B?VGtrbW5QdWdnalhtRVZCcEc0ZGZ5TFdFZ3lad20rYjB6dUw2TU5pVFF5dThF?=
 =?utf-8?B?bXhuNnN2MC8wZmtrZDlQL2NsQlIwRjUvWkEzQmkzZ1hNZmxuMXZ4TEF5UGtC?=
 =?utf-8?B?dVZiUGlGdzRSR2swRk55Z2xlTnlFZ1JZSVFDa2hJaWs1WWE3bWNvdnUvczVB?=
 =?utf-8?B?NlRiNmVnaTVDMUtscjFtcFFwMTcyK0NMMUtBemtKVHIxZHpGZHRNRkphek5p?=
 =?utf-8?B?eFdvc2ZMQk0xa0V1aTcvdEhaOUJ5UGNMazVRSzA1cWNYVVZHc0RwK2o2cGlH?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 362v6cZeP8pPgeHoZHMFR3n+Gf1DPa1P5zbilOAuaoVO4Q+omg7H3GDMOPIA40WGQk1rEbHzzRepq0VGqDV5JhoCM5StcE9OUGbXklRR34CRX6dCgZ6GkjoUpYH9bvvE2PMJN2EYYiLpZMjs2uQ64Fc4KhWD3tKPsQTwGq0YeWHKnpPgOef+KAXt165uYz/ZXUoBdgW5a/tDO4bfHEWbU5BR8/bWV85GFZGhHA2KB3fwsiqthpWIY98kOolr08ndJ5hbghX8aquJrFRbAXtBAXR50WD/96dEbrlZxb9I89oW9sc7O4YMV/U6EfGsjra4cFYuo6cPNTfjY8mR83ctjjzmX+xdyWzyH7agFDwqyCK6Er1kIukIQj59WdMP4DAMmJ5yS30w7MsMt/MFEp/fcvcuKjWoqBf1Rf1Rd+Yx4po8AqPTTFfwyjdirp5auokKXK7ii0PTR2iVpqr9a/WklhAvP+F7p4X9mgwhT+NBsZ5JxYRnij7zIS13X1eJRodKHxMrMIH//c0sgWqqnQk+ZgFQKtnBZs7OIRsSz4jLsFqUcmsqEscCqDyl9Q4RSTTebDKfoiIsUWMu1yzlex3LRnc2u+M/p2ckDdRloslBWSMgcMdzbgZBvTDTOhsVsUmgcg3qdbH8XiL6/wXnQZz8fXjTkQpT86HhUGV/5y9RyrNfKMMF45aphtG8fo+6tbQtK4LPFjeoK/xLuKaxMARiPuRit807OeGB/AoMBtEgmlnoSVX9JtK7yTyJ3OyEZZJGfDpP8mjCcfI67V5ZsuHgEpqKyOSBk7ZxaS/H3UgSwOBDQBMYDxeo2EzcHG7YaT7xsmjzIzy4n9XK/A/8kk05C/coGV6x+aOimQwITNHAFFJa0qo1JPOvcOZPD88utVGasDvXU4y6CFjF/8WtsINZ+lacV4vsLj9esNjg1n3M39k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2776e2-66bb-4a33-3bec-08dbbb714b73
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 13:39:07.6654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOMpg+33MgF7Z+94NpM1dIBtz/9tSFzPZ9U/17qqO5hsAcfzSWmqUrg6UjPqUJtnABhPgv66ppu7+jKkq5gIbyPSjwCBdmXgjGjZD3Qz4Lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_11,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220117
X-Proofpoint-ORIG-GUID: jYElliTmN_CCQ_TDqBzH8UlC6WodW-o1
X-Proofpoint-GUID: jYElliTmN_CCQ_TDqBzH8UlC6WodW-o1
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 03:06, Baoquan He wrote:
> On 09/22/23 at 11:36am, Dave Young wrote:
>> [Cced Valentin Schneider as he added the trylocks]
>>
>> On Fri, 22 Sept 2023 at 06:04, Eric DeVolder <eric.devolder@oracle.com> wrote:
>>>
>>> Scaled up testing has revealed that the kexec_trylock()
>>> implementation leads to failures within the crash hotplug
>>> infrastructure due to the inability to acquire the lock,
>>> specifically the message:
>>>
>>>   crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
>>>
>>> When hotplug events occur, the crash hotplug infrastructure first
>>> attempts to obtain the lock via the kexec_trylock(). However, the
>>> implementation either acquires the lock, or fails and returns; there
>>> is no waiting on the lock. Here is the comment/explanation from
>>> kernel/kexec_internal.h:kexec_trylock():
>>>
>>>   * Whatever is used to serialize accesses to the kexec_crash_image needs to be
>>>   * NMI safe, as __crash_kexec() can happen during nmi_panic(), so here we use a
>>>   * "simple" atomic variable that is acquired with a cmpxchg().
>>>
>>> While this in theory can happen for either CPU or memory hoptlug,
>>> this problem is most prone to occur for memory hotplug.
>>>
>>> When memory is hot plugged, the memory is converted into smaller
>>> 128MiB memblocks (typically). As each memblock is processed, a
>>> kernel thread and a udev event thread are created. The udev thread
>>> tries for the lock via the reading of the sysfs node
>>> /sys/devices/system/memory/crash_hotplug node, and the kernel
>>> worker thread tries for the lock upon entering the crash hotplug
>>> infrastructure.
>>>
>>> These threads then compete for the kexec lock.
>>>
>>> For example, a 1GiB DIMM is converted into 8 memblocks, each
>>> spawning two threads for a total of 16 threads that create a small
>>> "swarm" all trying to acquire the lock. The larger the DIMM, the
>>> more the memblocks and the larger the swarm.
>>>
>>> At the root of the problem is the atomic lock behind kexec_trylock();
>>> it works well for low lock traffic; ie loading/unloading a capture
>>> kernel, things that happen basically once. But with the introduction
>>> of crash hotplug, the traffic through the lock increases significantly,
>>> and more importantly in bursts occurring at roughly the same time. Thus
>>> there is a need to wait on the lock.
> 
> Yeah, the atomic __kexec_lock is used to lock the door of operation on
> kimage. Among kexec/kdump kernel load/unload/shrink/jumping, once any one
> is in progress, the later attempt doesn't make sense. And these events are
> rare.
> 
> Crash hotplug event is different, there will be many during one period.
> The main problem you are encountering is the cocurrent handling of hotplug
> event, right? Wondering if we can define another mutex lock to serialize
> the handling of hotplug event like below. Just a sterotype to state my
> thought.

I've tried this patch (with slight change) against my regression setup and it works as well.
Eric

> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 03a7932cde0a..39b9a57a4177 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -783,6 +783,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>   {
>   	struct kimage *image;
>   
> +	crash_hotplug_lock();
>   	/* Obtain lock while changing crash information */
>   	if (!kexec_trylock()) {
>   		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> @@ -852,6 +853,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>   out:
>   	/* Release lock now that update complete */
>   	kexec_unlock();
> +	crash_hotplug_unlock();
>   }
>   
>   static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 9dc728982d79..b95a73f35d9a 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -48,6 +48,7 @@
>   #include "kexec_internal.h"
>   
>   atomic_t __kexec_lock = ATOMIC_INIT(0);
> +DEFINE_MUTEX(__crash_hotplug_lock);
>   
>   /* Flag to indicate we are going to kexec a new kernel */
>   bool kexec_in_progress = false;
> diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> index 74da1409cd14..32cb890bb059 100644
> --- a/kernel/kexec_internal.h
> +++ b/kernel/kexec_internal.h
> @@ -28,6 +28,10 @@ static inline void kexec_unlock(void)
>   	atomic_set_release(&__kexec_lock, 0);
>   }
>   
> +extern struct mutex __crash_hotplug_lock;
> +#define crash_hotplug_lock() mutex_lock(&__crash_hotplug_lock)
> +#define crash_hotplug_unlock() mutex_unlock(&__crash_hotplug_lock)
> +
>   #ifdef CONFIG_KEXEC_FILE
>   #include <linux/purgatory.h>
>   void kimage_file_post_load_cleanup(struct kimage *image);
> 
