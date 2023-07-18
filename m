Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E922757832
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjGRJha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGRJh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:37:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20EECF;
        Tue, 18 Jul 2023 02:37:26 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I7E9sB030989;
        Tue, 18 Jul 2023 09:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=qUu5DtQZWOeHaHYVK9+an/j+qgPx+VKxymgiTGGeJrg=;
 b=OPr5HI8gyOGH22fxxukRW6R70LHevKkFkY27DTDiFB9+Q+nZrUkwy/q4pNCfj9bRaWKP
 cJ4ZpyTkCOavt4AcbjjRSuN34e83y7keeY84MX4aS6gB/9QnoMUnr/AsduKx82vcl8wz
 3wMMYMGMy7gO0S2R6zMFeuoADQKizIFTNWPF/vUDSra2ry7MzqKOxAz5J+ELqJKkwVQt
 22bwqK/qh0d0Rni4G8r+9V58jAZaXTq+9bYeSOGs/+cigUa5WsoU/vwjgKJA2OJZ+7id
 gE0x7dIVtuQnWKvWoHD///nj3Zx9tynyixfwDYHHoqm/kg6oyCvvypfXMxYcSzATymru wQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a4pm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 09:32:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36I9C4MI007807;
        Tue, 18 Jul 2023 09:32:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw4jx95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 09:32:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T91+8kvqDZ1zgNce1R2Ao3E5uWkjw7Wk2HvtupSvG8bJOdyOhMKW4kl0BzLgttLUlqQkzXUFL2F9V68GZXkbzfu7jlj9CgMD4X9Nd0ylgqlBs6gjULGKetb5MeMb+NtML9COgpirKCAnbSqRpsRVKnqZ02eNbCeBT91fg2rEIupx9TpedFRNho4dQ8JP9xBZgzJOx3MFwPV4mqzkhHpX8U/lX3+2qyyjzj6TtelEmNm8T2q20Mgigq2A9b0OftxlS3XZjxmuRSLG9QncmHsOCrHC8Ib/JZ7lC6E7nN57hciQ4btp+djtwhSSrL0Aug9RiOyZz8X9ifAAiDFuf3LnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUu5DtQZWOeHaHYVK9+an/j+qgPx+VKxymgiTGGeJrg=;
 b=ANXlEFHoGh0psADnsWpHuZDEJGsJoiZH4MEEJE/KM9ut4ZME7zPpcPqm1deb+QqoKIpYux69dfPatLOZP/ZNsti9oXrd1T5qfim4tPu9GS3JHVRGL9Vo9ODvUo0tT8+XxZT8DA8s7svf81PQvHVoBZMT1YUbUdHnvpGdCF8QdgFkN9ZDm6n5IQfp7aL02QnJdzkaUx9kxslmP6cR7fJiW+pk6sEVpAFJLfZ3cQn6hfEiQQgEDvQGJtBKZ1pFNvkdwY8iI2BK07T3r8BWqXlbfFZG4/s9UxFNIMe+FtRsirKalhmeqEnxLpRsc7wUNPxN4l6JbYxl2hquBK5QquQoig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUu5DtQZWOeHaHYVK9+an/j+qgPx+VKxymgiTGGeJrg=;
 b=b2oZOTeW9qA4j72K9/0Lsx7Cp5kisNsjQnswgiHf8+X/OPVHnYBchTc3MsLQPZSSod0fobi5hCefgFBYKQi9I+oaEVdyQvrTsmhwLU0sexaTL0u6mtUgNIwrQBEIIyimJ1kljean5Ejlj8u3OeJhqwNVTvmsiuPwvXP5Oo2ChRE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7176.namprd10.prod.outlook.com (2603:10b6:8:f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 09:32:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 09:32:20 +0000
Message-ID: <4f0355ec-8bc6-e51a-ab5b-61d555a68b6c@oracle.com>
Date:   Tue, 18 Jul 2023 10:32:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC 4/9] perf jevents: Add sys_events_find_events_table()
To:     Ian Rogers <irogers@google.com>
Cc:     namhyung@kernel.org, acme@kernel.org, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
 <20230628102949.2598096-5-john.g.garry@oracle.com>
 <CAP-5=fXa24_LEiyni0Ncyfa5hKwC1GE6y-zi2u8M98M9SwHX+g@mail.gmail.com>
 <CAP-5=fUs=u3PKYP3mVDdzNB8+=GAHaEXG3SGfWJpMELYYqO_hA@mail.gmail.com>
 <d59b6e7c-cead-24d4-a9cb-6552b3154d84@oracle.com>
 <CAP-5=fUu6xgVDQT4tq=vmRLDMe3ddMLywP11uOLvKSu8Lc6BjQ@mail.gmail.com>
 <897dcf1d-6a04-33d3-9c4f-ea9d1706cdad@oracle.com>
 <CAP-5=fX+rz928LtFs2MWYUH=6Mcvz0XQcLRkO-n9BnVnX4RYWw@mail.gmail.com>
 <297ddf04-9b35-7613-8efd-2857668b6835@oracle.com>
 <CAP-5=fXSQVyqCfrBJFjHkrRdANuQC=TKR-HHi37hLaQ91rPQiA@mail.gmail.com>
 <eb011f48-b953-3647-4699-734ebdf1876a@oracle.com>
 <CAP-5=fXJxVpYQ84hXiMxy4LUi7xs1puXdDhbp6d6N2ArnqKJuQ@mail.gmail.com>
 <0d6e41d1-2f27-9a90-1516-c4e50bad1c21@oracle.com>
 <CAP-5=fXKqZM=RMB-+ooKEKfGw=KdCVU0UbVQ9+XrDOAWpoYAdw@mail.gmail.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAP-5=fXKqZM=RMB-+ooKEKfGw=KdCVU0UbVQ9+XrDOAWpoYAdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0188.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e6e4db-7812-4a2d-0432-08db8771e21e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCTxu8GznwiEWNxaFQ18LghkTN+gbba141T6Gzho+XScGA3SH1mKAQWWNPrM2dixoKVsHOJB+srBIfGK7zgECXPna+ngWewwVhcAm5TDek1oon22loTwU/+0N4WIJ9FRPRcVurWGX4+SG1lKkMlRUkT4QTWkIam3jdxkJpbeTYLG83q1XGhd/wocGbo/KBm+0ersAKoBq7tdjBDwedUilw+wHbR13SO04hLJ9ra+3kDGLuwLkZUILkq0RBec+9wLBBiTb2zjRlqhSbZlLNjFJ7JVpaQSHwMZep3nuOjoA8vl5CX2nLefuxP/o/TTWxLbHh2lysTBb3JDkUhmvqktJxdtigWAVsbT7pCd9jirM9e05KbyRqMNgR3/rf73p+MMb240SswwL0E+vF8bAk8jmc3sxNzVVkrg9cpi/Dtrew0YjZBobSzko5q149h/2BP3jPcu3zzZPRKtpikBUsPU9ve5oJYdVL2mhLWqvqveHXl3QoDrkqXKqw12mie+ZTtOhp/Xl6EQz/v+ylSa2Y3yD1yABVEMPfzGSbLmHTq99lHLK/FX0JdJyriHcgxQaVpPQu4E5tp8ox03eJ06XvCvfyZxJXnDnYGOxGpimjH84qMC4vyHEvE6dgMePoDILyF5aBpZxBlnjkbBwL/tguxJfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199021)(316002)(41300700001)(53546011)(31686004)(6512007)(186003)(2616005)(26005)(6506007)(966005)(36916002)(6486002)(478600001)(6666004)(6916009)(4326008)(66946007)(66476007)(66556008)(38100700002)(7416002)(86362001)(31696002)(8676002)(8936002)(5660300002)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUVDaWpaZXZKdkMzRHhPdDQxRFhEaDZkbjR1WGlTVlhXaW1YbVlQQnk0Mml2?=
 =?utf-8?B?M0VFb3o1aXBGUmVyL3JpRktha05vSXB3V3R4a25ZR0VVa29UK0o2dFFFUG1t?=
 =?utf-8?B?bVI0dVZOWkY3K05TTVlUNzhqbHhsR1dIc0lmY2R5RGlvbGhNV1hrL0JaNDdn?=
 =?utf-8?B?LzBIekRqK2FLV29UOC9PQTVkN1lKcDhpY0lHTTRDdDhxQmZ6MTdyR0Nqb2pk?=
 =?utf-8?B?M3V0RDd5Y0VPbWNRVlEzV3JyTTc5WHNLQS9hKzdmWTVRL081RnpDeGlQN3FP?=
 =?utf-8?B?OE1BQmlvUUl2U2VKSGJHR2xMRXI0eVBpSDY2THZ3MkZBaGM2WDFvR09qMjFY?=
 =?utf-8?B?SUFCWjl3VTVvd0F1eHZzYjZ1K2Jwc0Z4a2VYZVZnYUd4WnRFVzRTdm9QdlN1?=
 =?utf-8?B?YlFobWUram1wdEZSQlZOVW4zQUprU2RsNkRTYm1OcVJqc3NzK1VIazJsZTNQ?=
 =?utf-8?B?dlA1RjVDWFFjRXdTWlJteUpwSnJqcUNweXhvMzNubk5pdWdCQmVPK1BQRE9l?=
 =?utf-8?B?U3gzdzdGZDRGUEI4dGZPYmM3YWowVW9HZDFWcC93cUxsOEx3VFg2dVAxNnZq?=
 =?utf-8?B?ZUFkYUFMVzRwN2FtdmVJM2FFeG9oMUlNc0ZtRERJL3loZE16UHBTeVVIVEt4?=
 =?utf-8?B?U0d2S3YwZVo1Wlo1c3gvRTBJUzV3eTJpRVVJenVoczZFV3BRRDlKSEV6eFFt?=
 =?utf-8?B?c3hFYkJvZEs2WHpWSnY4c2liVm9vZUlaNXdwMjlFNzdjcE5vY3pKRUU4aU5h?=
 =?utf-8?B?VWNES2svOE43SVh1STBxQkdPMytKdGZjMHRjbUdEMnFmZnJoU3phMmVFaHB1?=
 =?utf-8?B?TkRvdHJkTlBvREgxQm1XaTVLTDd0dW1iY1RTVWQ5dW4wcG9FVkpVOHpSZ1ZS?=
 =?utf-8?B?eFhIb1ZvWGUxRUJUSG1zaGpla2YyMnU3S3pldGJSUlVmMHhheis0WVpqRVAx?=
 =?utf-8?B?ZnJ5enQycXBnazRVdzJ6bUhYa294c1d1amgvRy9JMXh2WkpHNjdlRVJwMFRS?=
 =?utf-8?B?VXNnSmFFbzRjdXZ2QW9tR3IyaWc5bC9EUXpQZ05SRFNacDgzTUxhYlFsUit5?=
 =?utf-8?B?Q2hmV0g2OG5uTElMS1E3b3BPaTlISEtVTDdCV3hKcjcwRnFFZUkvZ1ZRS0kv?=
 =?utf-8?B?cWZqMFZtUlJRZE1rTHVJZ1FNWkFKcncwbkltdWozR2QxZGREK016c3UvTnlr?=
 =?utf-8?B?WU92YVcrNERJbXFYaWxOSXdud3ZLdCt2WUQvNnJ5RFdWQzdVZjl3dHZ1OE5M?=
 =?utf-8?B?K0JuN0NvNVdFdUZ2NDh5NHBKVDBUbUtMSzFIbExkT203c3prNjVVZnFSMHR5?=
 =?utf-8?B?TmN2eDBoSlZ0RG56LzU5N3hOWVVQdXIyRVJJdURudDhlSVNRdjVpWmNUSnB2?=
 =?utf-8?B?Q1IvWmR0RWd6S1NGU0JBV01HaWZKNVJPenJTQStyYWRWRkF5Ry9QQklLRmlZ?=
 =?utf-8?B?bWVkMzhrYnM1UFkzOUxsNkE5RjhOQmdzZ1lUNWxHUEpySXJiYWJDbStnUkJG?=
 =?utf-8?B?ZndlRGJ0REszVTM4ZzZmRHZhdStpQ3RKcW9EYk83OGY5d0VOMHM4TXBleHZG?=
 =?utf-8?B?eWo5UnRJeHZpMy9tL1NCUDhXaTcrN1RLa3J2RVIzTDBNZEYzVS8yT1lPRWI3?=
 =?utf-8?B?U2lrYWpPQ2ZMOTQ1d2duWnBUNFVBNzNTaG5NQU45aHVzS0NkdlZjcjJVcUR3?=
 =?utf-8?B?eFlNQkVGdDErQlN6QmorVEhNNjgvNDFEQkpzdFh2bEwyVG1QbzNwTVBGb0hk?=
 =?utf-8?B?THJXTnh2M0xhanRud0d5WTcvc0dXSEUrS3QxQU5JZEx5N1JWaEJMRzBIdFpt?=
 =?utf-8?B?V2x6Lyttdmx5d1dmUHdUNXMwZGtuQjh3UDRUWUtPODZ5Qk5BaW1OK1NqaUJ2?=
 =?utf-8?B?YjEvZSszWmNNS045YmN2ZUJiMmxDSTNSbXpKTmRJM0tYaXlKUkRVcjc0OXVK?=
 =?utf-8?B?Y3RYVkVmQ3UzN3pwNmUzc21GZmF2eWg5R1lxSDhFNWFRbDFERlAxTVR3VjdQ?=
 =?utf-8?B?dk1jYkJWQUEyTFpxUllJbkNSekZsNHlpT3loc0k3cUV1RWp1Rm1sbEtFcnVw?=
 =?utf-8?B?MlEwM0toaDNNWmt1Um9qc1QvL3pCQ2poMmdQczhPajFpODZLTjFkNzJ5WDNV?=
 =?utf-8?Q?rJcbumK5FsHsDAEi0aDBrc7eU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RjV2UHRpdU50RUhkdmZST1lZSE5KZ2pXS2pjK2oxYTAya2Q4c2xXNGJQNjNE?=
 =?utf-8?B?eTBnMUdGS0ZJTVgxakhQVjFIb0R3MjdoNGp0c2RrNTB1by9HcTlNSDFmeStJ?=
 =?utf-8?B?TGhXRUNWbzlGdFlWbXBzUm9pMzFDK3I2R1BIRVJlZC90NnF3RHNYMExkd3dG?=
 =?utf-8?B?aWU3b2NKSVhveDZtVU4yTmFNSUJzbUNVeFVNS09mTlZ3N21nRDdPbXRRWWg5?=
 =?utf-8?B?akFrQ280VGpYV01JUVQzKzBia1lGQkhzQXc2YUNoZzZoaTBqL0syRmNHN0F5?=
 =?utf-8?B?Wkx5azFBU0F5NzlCTHZGSngxM3Y1cWx1K0RuLzhIMW9iQVFHSWtsc1BPUlM1?=
 =?utf-8?B?M3NpdVoreE1jV1FJM0dzK1hKTFp6M082ZUJnd21PM3FmTFJPQ1ZxdHdKUnZO?=
 =?utf-8?B?WUhLaHczQmc2UGlsRm1KbXc4UEhQcC9jMXM4RnJralZkZThVUGRkZjBBTWFG?=
 =?utf-8?B?cUhJdzN1YXFwZmJwNnVhdFZjK09tNXdObGVFZExUWEhhVnFtMzNMK3ZOT2U1?=
 =?utf-8?B?UTRlaUhZZVNWS3RHTk1oOFk5ZU9RVkhZbmhrYVpMVDZMSlpFRG4wZVpJVmR1?=
 =?utf-8?B?OU8vRjdaaFRwZzJWZWU4RE16eFNaVzhBMFdTelE3dU1DUFJtZ1lYT0ZIY1hH?=
 =?utf-8?B?Mm5ITVRSS2JPV2lOaEJKekZ6RkVUOFVCK1ltUnhiMXkvK24yTDhzQ1RZcDNz?=
 =?utf-8?B?NzNEZjRxbno2OTFBd2NyOUNtUyt4US91dDMzQUZwZlNMTk0yRU15OU5KRkJo?=
 =?utf-8?B?UjNscHNjU1RtNU80WVN5MUhJemhtcXRzMUphQVlPWUltQUJZWWRBUU9oekxH?=
 =?utf-8?B?YVZCSGUrM2EyTmJHRzkyOGNOREZOTHFkeDVrOHNpMlFpYjZZQ3B2MGV6c092?=
 =?utf-8?B?RFBQQlNsdTNrQi8vT3JJdHFzdDMvb2F3WTJ5NlVUUjkwUVBxNFVsY1FEZDM0?=
 =?utf-8?B?ZkRaemU0L2srMnlCbXo4RW9pWlF4VlZzdWc1M1lVaU1WNVlNUHkyTnJ6REdL?=
 =?utf-8?B?b1g5SmlzWlplNkRCN1d1dWVnelZoZ2hsUGMyWXl2WVhRU3ZzaU8wWTU4c3BQ?=
 =?utf-8?B?OTA3bENtTHJlZmUyazZiK3VqcGFpdGF5em5lbmoreTY2MFVtTVdrZ0doa1Q5?=
 =?utf-8?B?NTF3SmFmQU1CU0FyVGZqSysyRmVPT1Y3S1lGZlFTTDNQOEU2bm00TTlnMzNn?=
 =?utf-8?B?RFNXdzZJSXRzNjVLeTRkbjFXUVpBcjdUTW5jVDh1TlRKQTRRbVg0bjNtVWM3?=
 =?utf-8?B?N1k2d1VvMk9JdnhtM1JmRXBUMmo0RzdWWU5TNURkQktKYXRWaUdrUmVTUzJm?=
 =?utf-8?B?NDBCcFJ4MjJwUFcwK1paQ2NVYzVVY1NGZjN2WlhiVkI2ajB1MzA1SjU3ak42?=
 =?utf-8?B?Yk5OYjNBbHpwS1E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e6e4db-7812-4a2d-0432-08db8771e21e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 09:32:20.0016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuYBHsTAaa82+wQrYsAC6fJrkX5YjF0phCj2vfk/TKvYxn+FbKaNf/N2tOtZ/gkznRRw+vMKJWNUUgCllGReig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7176
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180086
X-Proofpoint-GUID: bfZFgjtoSQ9zOjyVkmT5wI7dXMBv9iJ1
X-Proofpoint-ORIG-GUID: bfZFgjtoSQ9zOjyVkmT5wI7dXMBv9iJ1
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 22:39, Ian Rogers wrote:
> On Mon, Jul 17, 2023 at 12:41 AM John Garry<john.g.garry@oracle.com>  wrote:
>> On 14/07/2023 16:55, Ian Rogers wrote:
>>> In this
>>> series my main concern was in the changes of the event lookup and
>>> having implied PMUs. You mentioned doing these changes so I was
>>> waiting for a v2.
>> OK, fine, I can look to do this now.

I was thinking about this a little further. So you suggest that the 
metric expression contains PMU name per term, like 
"cpu_atom@instructions@ / cpu_atom@cycles@" - how would/could this work 
for PMUs with more complex naming, like the form hisi_siclXXX_cpa_YYY? 
Would we use the "Unit" expression for the metric name, like 
"@hisi_sicl,cpa@event_foo"?

>>
>> BTW, which git repo/branch do you guys use for dev? I thought that it
>> would be acme git, but Namhyung says "We moved to new repos from acme to
>> perf/perf-tools and perf/perf-tools-next" - where is repo "perf"?
> Current development is here now:
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=perf-tools-next__;!!ACWV5N9M2RV99hQ!OQDHOClSjd6nVZhmgzrK3RwzXuQpP54QhqyIKpITa_MFD4PLdS7yPYSnvInFja9nrFx9Sd-UnlsJ6XUqAh4$  

Can that be added to the MAINTAINERS file? I suppose it is ok under 
"PERFORMANCE EVENTS SUBSYTEM", since the two would-be git repos listed 
under that same entry would be pretty obvious in purpose.

Cheers,
John

