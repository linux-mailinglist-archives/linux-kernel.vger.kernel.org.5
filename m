Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEC5755D27
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjGQHly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjGQHlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:41:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56BA10C0;
        Mon, 17 Jul 2023 00:41:49 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H6xS32003429;
        Mon, 17 Jul 2023 07:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=OHI76J3AxrxMnAo7zOlft5dMZ4SL5FaK+AuzekF7aq8=;
 b=3qooZBes+dMmOKROqwWEIhrtJu8tFCr7D+0WyAHuoOPF9V/gim7egJKYaU08q+NlYO4z
 QA+ozJ5E+Xi6hPeCiV2dNWMmqxVup+tMudifdA8E70wQH+d75CU6Y6wGAlXfnsmJvnNi
 uptOSAWT06SSufni6fmITptqq9cuu0zrgGX9CyXP4ueRIOqbz00awa3BdP4wf88w4AAd
 zDfdlXNkiMHZS339HxaueD19bfgb5ktIQFIPrCXIKZuPstEbHArkgxeczRow9YnQ+tZv
 +Yq1XfcBAKAF71Krg2J3jMK2Y/KR2uDzxkFDK+/V+t1LZMJm4f5q3nNi1tGJFac8EaRL bQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run77t394-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 07:41:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36H6K9rQ017349;
        Mon, 17 Jul 2023 07:41:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw38vj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 07:41:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zy4c41i6TBCuCHY1AmZX16b3hfDBRulKGjvXVjXJowyJnc6bRbPUG8DrLUjhPHLw8jz3pw+G2vaizYeQU6q4aMVVHh6XJ45XAiJ8EBjTxVUJqD31JBacg316rlTx9PvUpQP7Femgg34xgVg7/T2+0gWIB5iNf4rVPmVVJEUyF5MEupS/6mOxsIOcaimsnk57JBa7+0L0uiaBRtstCFopd03Tqtne0CLq8+W/oognmof64iSHhluzq5S7OARNvyqe0pbmFfuikBqRr0d7Mx6SQ0G2A7TNiiiOaFlHDlWi1wYJaD89/RM48VBuuBaIrsXEFfzy6vCaIA4aPgMmICXx0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHI76J3AxrxMnAo7zOlft5dMZ4SL5FaK+AuzekF7aq8=;
 b=D2V+ZYCBo/Cd5mqo05myu9l5N7IevytyozeJK/69Ns+Vx0NUT7Ioi3Ih0AwrcJZv+l5mjTLF+UZRlBdeeOGJQiVw0eYw/Chv2qhb4TJ+OTeNX3j9v+h29yQoND101Qdh2qGkJy8q9sbD0uUdpdczEd+JOdD2uoPiPeQ57uDFmCF+SxmsSa9xkRpMK6nEJhr5w5BMEekNzmIW29P0HwWoRHyc4H6s1prezMj201CCCCWJxFbX/F6WNUgbOlYj6Uav8IKus0IQKPEFUirN2AwLOIApSA0o77O+tOxce1AAMFcPisGR0QLtnpD7j8XiDHeRB32G0OGyGG47c2uDUyi1Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHI76J3AxrxMnAo7zOlft5dMZ4SL5FaK+AuzekF7aq8=;
 b=CNm+MMFk70LOoIBw5dNvZ8UXapxXuN379Y17OfwpHeGLXtD6XmZpLrxW+jH6xB0oD3rtWRchlGCvCkux2p1MlxtRjWFXFWDRlL+zBuA5D1WDxN7HCiRj4mQfREU1229lDxM/mrr2WJmDunj+KKL4w+7Agfyv5HRAFQ6/fnsZPmk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB5940.namprd10.prod.outlook.com (2603:10b6:930:2b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Mon, 17 Jul
 2023 07:41:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 07:41:22 +0000
Message-ID: <0d6e41d1-2f27-9a90-1516-c4e50bad1c21@oracle.com>
Date:   Mon, 17 Jul 2023 08:41:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC 4/9] perf jevents: Add sys_events_find_events_table()
To:     Ian Rogers <irogers@google.com>, namhyung@kernel.org
Cc:     acme@kernel.org, jolsa@kernel.org,
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
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAP-5=fXJxVpYQ84hXiMxy4LUi7xs1puXdDhbp6d6N2ArnqKJuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0589.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: c03816d7-a3b1-4999-7b0d-08db86993789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kkaJucNiGXHIzFetfL6Zjxbaa/fUxJ4Y0G3vyfE3sUS0TUwhBucv6bPOEa19gVC1GMtuJPc8tcCP/jWHctrMwIxCtg4iQ9O6eqOFZT7h9HSuPcLd8EPQla/HS3cEyRBtmnwV0cdf0yPWuIBhXcDDiBTquTrnoCQ3nm1HbHlX5GD/C9y3E9rL9QWhO2JrAV9FfcF6/cX8LHvEUDEkhJnerry633KNmgkGQAiSwBWmDAPcCyX9BW4H3+LJ5FNcFGBVi9MkFGl5t1EIczqLqE+QPg0Gx/e35XTsx3YKaz+tw7VuKCT27PJ7Td7MTe22+7fpvpSLhu80UIHv1MIyMfp40uIRiyZsO6cp0HjzUD3gMk4S2f7oLDAN3F+P05JTteGh79b28t8Vx71bcGOA8WPCjGOMw7dGp13oSswcahSULGs674S25J3X/sTZIV19mDQsR0d4oIpAEf3eY9Qt3+aAJxcaWLTbkoI+gpElXVlPZCHEdru2xg+6uj8iTc8qlqM8QWN3+2aoc1rAEVkjO2pnlLmPzqiJdMI54LOuPprMnRQPR/w50l6iibTVNdFXka7pckZxVWHlGEn37ufqVzN0Pn5faqxMTo/Jen0I+mMTX5lNBZosig9kshxrlhXIjw/rZRGc+ndNfKH/L4pAalMyTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(4744005)(31696002)(86362001)(66946007)(66556008)(66476007)(2906002)(53546011)(6506007)(186003)(26005)(31686004)(2616005)(5660300002)(6486002)(38100700002)(41300700001)(8676002)(7416002)(8936002)(36916002)(6512007)(4326008)(316002)(478600001)(6666004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M25jdkFOcnFUUjJWaDVvQzlGR1VPbkRZbU82YkFPMzMzbWFtSExZazFuRmRr?=
 =?utf-8?B?VDlqM1V4UVVCTWhGc3J4QVNtcXd2Mm9OdFlhTHlPWktpSHFTNk4xeHhxWG5p?=
 =?utf-8?B?Mlk5NzgxWVBVekh6TXEvVTBSTUFUdUk5bGFDT0piUTFUVVhTUXFBWHBRd2Fu?=
 =?utf-8?B?Q3JxUExLNURORGV2eGlBREFsUW9RZW1UcUU5Tm1rcXZ4K0ljSzJEUmJFZEE0?=
 =?utf-8?B?SG9mZjJ3b1dhUjF6WEJ1Qk5MT2F3QmxvTzdjZ2kxK0t0Qm0vNHNRZE42Znl6?=
 =?utf-8?B?WGRRaWhKZmtjcFNGM0I4NG5BYXJ0Q1ZqK29iSDF2V3JOMlZZL2FISjVZYU5y?=
 =?utf-8?B?c2wzYWZ4R3U0OUFOTStDNi9mdjVnNGhxWWdvbmhUVU1HakFzNnhzRW9nNmY1?=
 =?utf-8?B?a0dSYlZYZTBSOWl1NVhhWFRFc0VBY0lIMERFV2UrbUtZL0U5VEtsbGF4dG5J?=
 =?utf-8?B?bElwMTVjazNWd2dEc3RsOGZTc1o0NFdZWnZrWjhEMUdyS096eHpiUkZ6MHA4?=
 =?utf-8?B?dk8zMGZxcTNxeUJLZXdObFQ2UjNDcWhFTE5IRXpGSE9KY1RQaW4wSC9OdEtE?=
 =?utf-8?B?TzBjRXJsb1VTdmFLSFp6Y3NkOS9mL1JIZUwybHg4aUtQckt5VVgxbnlvTytt?=
 =?utf-8?B?OEY3QkhOR2lHMGhlNy9VVUphMTR5ZnNuYkJJNjFoUC9icGhib0MwcTNMSGFS?=
 =?utf-8?B?cVBWcDQ5YUpRZEJwcy9vSzgyNk13YlJZN3RZNXd1ZUd6N3M3WWQvUE1OUjhz?=
 =?utf-8?B?VkZzVFdJR0NET3VRU0NBZVpKMGNuYVpFUDFZQ3BGbmJ0d3BtVTZWbkU5WmR3?=
 =?utf-8?B?WkdvTGpRRTdHejZvaDhKdXh6QlZneE5tbWNXUHl5SWo3REJ0aUh6dDRQeTRh?=
 =?utf-8?B?azJqYXlRRThBWml0UElaN2liTnEzaGIvYy8xeGZCN25VNHVjZzFPVDdxL3I5?=
 =?utf-8?B?UGVTb0p5UnRFR3BSaFdzUUY2K3BVS2Y4NVpta3ZFVWZoYytERWpwbHFaaW9y?=
 =?utf-8?B?MHM1VXNGRUJjMmpad3JkUjJHd3RvZStHaU5YMTJuRWtNdExXWWdIMGQrQjdj?=
 =?utf-8?B?cWV0c2dCT3FnU0ZWY1B6S2lLQ2ZmbUE0eW5QY3RXWHZmUVlENXo1TEJVZWM0?=
 =?utf-8?B?cHl0MzUzYW1vZzRQU2xrSnVFVjl4dStTcUJublZsSlVBS3lXU245NEFjWCti?=
 =?utf-8?B?QkE1Q3NSQm9SR2kxT1VtR1RqK3VOdndJdUJBMGVoNkNyQW93MWFEbDAzT0h5?=
 =?utf-8?B?SmVLdFIwS01TcGpVTzkya1Q2cVFYTTZKekNqcWxNT0s4VzdPcGRKUkFGVVVq?=
 =?utf-8?B?ZXVLVDJMSUtaQ1NlUmpiWlJSM1J3UGE4YnBYbnJ0UG5aR0xGSHlLelh0ZkNl?=
 =?utf-8?B?eG9zUS9TVklQV0VmdWVyT25VUmdlb1RDR3E3R2pNd2NQMk9kWFZ6WFV2Qytp?=
 =?utf-8?B?UGZqZEJFUXVnc1JVVkgrb0pqdU1VZmJ6Z2pvamtqQ3p3OWZJZm0zWC8xa0tV?=
 =?utf-8?B?cjRqa05TWmxjNi9zKzdVRytnTDNEVFczTmJwN0xUbUxCaGJSeEk2TTJlRktQ?=
 =?utf-8?B?ekFKamsvbmtWbEY2NHloTWFiUW9jcEs2UFdMd1lNNjlFMlkxWEFJL1BPYjhs?=
 =?utf-8?B?cUV6eklSZzN2MlAwZ1dJTWN6SEsvUVI3bkZQVWFCZGlINEk5MXY5MUg4N0FW?=
 =?utf-8?B?MGEwZFhveFptd3JtYkZGdXNBRUxlVloxNU1XU1NsRjd5M3psWGxZL1M5eFNS?=
 =?utf-8?B?WFA4azY0SSs1OU5hWEZaNUx3TE5iVDdjMkhUV2p2RnVnY3UvekVVa0dtNC94?=
 =?utf-8?B?UllDRE44NkZWODhsMjJ6MkxJRGJvME9vTEw5UEE3WUNVWFJhalk2WERUMUw1?=
 =?utf-8?B?SzVQQzhOOFAzaEZ3czFDSURTQjBZZjNxZDY3RUI0Ri9BUFRlMjJQVU9ERlMz?=
 =?utf-8?B?NTRYR2FydEJHUTZpcUpGbmZabnpZcjgyUkVyUnlZNldPQ2pYbG1DNWF3L281?=
 =?utf-8?B?cFNtWVVNSS8xS2hYWUgyZnd5RFNHRGNqZ2pUZFJnTW1QelVMUjJseEhXdVNl?=
 =?utf-8?B?alRFaTFsbEVLbkljWFV1OUloVE14dUIzWExUN1FweXdvVTVJdFBjaElkVjlw?=
 =?utf-8?Q?eObS+qwgiuOlWjZ8TZYHnUhd9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?S2IybTlCT2IydWlGSHdjQnFyZTAwa3UzK1dGVS92bi9aOWZKZjA4akFMVStl?=
 =?utf-8?B?RDRlOE1sWWJMWXF2ZjZaVFN2OXZFTmNlTThrMHQ5WWNpK21RRUpuM2Q1Z0tW?=
 =?utf-8?B?cStCRmU2UUpsbmcrbnMxTlJjM2VRc1czaFdVNEoyeFBnRFdpUU9wYXhsZVdS?=
 =?utf-8?B?cVBvT29QamNOM3VVR1hHM0ttNDh4ZHNzdUQ4RHVPYTBxUHBrNWt5Q0VwYkdT?=
 =?utf-8?B?blY0TUw2QVp6U28waUxDSWEwUURqaUMyaW40WHpPa244Rmtnbk5jMDFiTDZq?=
 =?utf-8?B?eTJnUFRkbTZsNWxzWDhKRmlZdUJkbnJoQzBBL1I5TzRFcTg5dlB1eTBPRkE5?=
 =?utf-8?B?eUIwOFluY1B3RFR0Z1hFVVJOVmgybFdVYmFLRzdEalhjTEtDQnpHOTZ3UXVX?=
 =?utf-8?B?Wm1RWG1UMjR0S1FhRGhxcGZsNE84allnWGZxM0tiVVc5OXdWamxndm0xdW90?=
 =?utf-8?B?NklHU2FDZ01IamdOQVV3M0hBUWhwOFBtVlVyS1A0RVN4QThoZjlKQlUvM3lk?=
 =?utf-8?B?bm5QT1R4QTYyd2pRSk55M1EyWXk1M1ZaSldVUWtkUzEvTDRjNGxqTmczZW1s?=
 =?utf-8?B?dGdNbWwzSjk2VW9lb0x0YXlOekc3SzdEL1JzYjBVZ2ttaFF6TE5IS0tkRzgy?=
 =?utf-8?B?b2Z4VzJERGEyblFIRXpXbUFTM3lNbzM0VERjSDFUbUFlVTlIblVLbFpndERh?=
 =?utf-8?B?d2RTT0h3UVcwaEIvTEhaQVJkeHFsSm04eWpnRzdqaHZialpJWnRXY2d0NjZP?=
 =?utf-8?B?ZjB2NUl2MlpWSEc2RnpMWE5iUXZNK3Z1RnRDdC9VTmlXR3E2UjZseVZhYmJ5?=
 =?utf-8?B?blRHczJ4d1pkeHVRSGEva1laT2h4T1pqRU1uMi9JY0QvZHEyZkFaZk1HQUN5?=
 =?utf-8?B?elVyVG5kc1JIeGFGM09Ta0ZIU2gzcktYMkdqVWRoRkp4aDdHWjlWZWIwbEUv?=
 =?utf-8?B?YkloZ1lQN09JNXl3RVFZTUNtR1lLOTBMcnFVd2NCVDB4bDdDelRDWEZDc2FT?=
 =?utf-8?B?cTEwRjBESXFWS3hYampxU2YxSnNLKytJL0J2bFliaGtZK0o2T1Y5QkM5SGJh?=
 =?utf-8?B?S3B3N2NhNkl1aTJHTk95ZGRJVVd0ZitNWWVVS3g3VWZHK3BuV1RibmZxVGRB?=
 =?utf-8?B?eU9nSjlQelE2K2liVHFIbzFUUVRUellFa3BMbkdVVFI1bEwweFIva2VYRUNK?=
 =?utf-8?B?K040c2RvUzVDMG1QOTRrdERBK3lPdXdpZFJyRDYwTXlybHRkTnZlSHJwSWl3?=
 =?utf-8?B?SHZJM1RPd3Rnamw2SzFVemJxamdndGZKaVFwOGhTb0NLbUZ4MXV3ejdKNkIz?=
 =?utf-8?B?dWdUeDJIZElmWEhpaDY5TGpFTjRSY0hNbXBHM2F6czE0cDZ4b2FJNEtqby9H?=
 =?utf-8?B?ZzFTYklKckxmekE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03816d7-a3b1-4999-7b0d-08db86993789
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 07:41:22.5615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjgjkVpM0r2kd6HG5p16sm2WdZ1p1Um91mINZWIy/gTJWHoq/sdrq1opjLx6WK0hQzAzjS1tJXOEquQ1xj8YeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5940
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307170068
X-Proofpoint-GUID: A8yy-umFH9BE6gIwV6z5GrdUfguQE5rQ
X-Proofpoint-ORIG-GUID: A8yy-umFH9BE6gIwV6z5GrdUfguQE5rQ
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 16:55, Ian Rogers wrote:
> In this
> series my main concern was in the changes of the event lookup and
> having implied PMUs. You mentioned doing these changes so I was
> waiting for a v2.

OK, fine, I can look to do this now.

BTW, which git repo/branch do you guys use for dev? I thought that it 
would be acme git, but Namhyung says "We moved to new repos from acme to 
perf/perf-tools and perf/perf-tools-next" - where is repo "perf"?

Thanks,
John
