Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD547ADE19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjIYRzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjIYRzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:55:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60AF10D;
        Mon, 25 Sep 2023 10:55:17 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PHkmHx030133;
        Mon, 25 Sep 2023 17:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=D5IGKR/bKSIAvzIdF7KFR9A5rX7fePyfiN/nQTAooVQ=;
 b=Mlb8d1mWNieJED783mlUXzjR98agE5e6GsHRoEQsUSVJMBMNxsBR5H9nJg5mRjDVlNQ2
 v3YHuPmvknbetGEqxN2f4BNxyVuOVL9ORxl+PgXYJXrZ7ndnP7nRvLPB0+6ldwKaZFie
 5AyLou64paV7lzKyDeHUf9lIPZFGg6vRhdw11e5pfUCkDI3MmQw2iwWKVUYQePyB169h
 MjKjq5mhIMH48OCu3z5HOLJkpwgxWpAlCf8+W+SbQq6p07Sd3je/Fi/oaH9IwMkViNcP
 oTbELJQ2qXnAjXoKvSUCUCALA4UyhPSiIu6eb0jtoJL6E+y+gHAx+1gI/BFxZBYE7VWn gQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbcb0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 17:54:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PGpqHR039337;
        Mon, 25 Sep 2023 17:54:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfaxku7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 17:54:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpnoT2rGsngER881yb0zSPByHOTyk8xmIbqhoWvxVIj1GaX3DYenDQYQ4CXhdp1w2OzYFiKD/BEevroALC9KH9jMQcXllkHwV+uZntLErmA/USvaynXp8XnhgIe2cMCna3Fl/pF9Eb8qVC1myfQeqT/dUXiZWMlAPXJFfOJUK/fTuOCe7gZcikVXQYuXsHlRCh2tDpf6Y+G9Xkr3TdTs91UTgKGuv2kcskjFtgux3CSIBA1aOTr6G94lvjm/HiTJ1dMds/eDZRyLbdIjoxyu8ZlF3LJMicYX/sijc8MqWaMJIwNN0DAgg1z4TLQUxbPq11Km0lrIISzyi3HqZkLlwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5IGKR/bKSIAvzIdF7KFR9A5rX7fePyfiN/nQTAooVQ=;
 b=oJRUBUGHQ7L5Jkt7rrXmTz6XqJ8nF/nRj731tFL3mhydcdRJN4X+X0KTu3JcZc8oEQyIC1vT6aFC8OUUdUHTefpzDMa+kwg1WadEQMCZ1DOWA0sZ8odyYiI/X4UozGeTHFV+P3hSaQlHkCvQIMtqM34OhDvKip6MGwlF2Qd1vHvRgDS7i7ODLBAn90FzMDc2nsRqKZVv38nzXDdBBOwW4ODbPBlU5p1Vr0RmBUe3yYDhFJ1gAsrw9kA91iyW81mr4l5V4eaYcGBfVfcouSoKTYIFHZEDtMnMuMFCoelMn0lvHDI3DJu3vRetrJXFRGg5ypyAZeor0GYbAM0A6o5UHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5IGKR/bKSIAvzIdF7KFR9A5rX7fePyfiN/nQTAooVQ=;
 b=ScP1lU6T03kymM68v0sLqVph7STHm6BS3L2xCKI55tbPobsBQuj0/wG+pEqrsb/QDuwkuDvnvJXjfAVGrE3THEX2lX+t/cPOZSJK2webLoavtUfgFnRBeAd/FZWC/AR+OOMfHlF52cTmUAI7g9nKiDP7C6oEaMg+Vsj7D+XRdeY=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BY5PR10MB4259.namprd10.prod.outlook.com (2603:10b6:a03:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 17:54:51 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8%6]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 17:54:51 +0000
Message-ID: <a92f5e0c-1976-4fc6-ba48-7ff49546318a@oracle.com>
Date:   Mon, 25 Sep 2023 12:54:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/18] scsi: scsi_error: Introduce new error handle
 mechanism
To:     Wenchao Hao <haowenchao2@huawei.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        linux-kernel@vger.kernel.org, louhongxiang@huawei.com,
        lixiaokeng@huawei.com
References: <20230901094127.2010873-1-haowenchao2@huawei.com>
 <ZRGfc73BSW0yyUtI@infradead.org>
 <47bed3cb-f307-ec55-5c28-051687dab1ea@huawei.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <47bed3cb-f307-ec55-5c28-051687dab1ea@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR13CA0064.namprd13.prod.outlook.com
 (2603:10b6:5:134::41) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|BY5PR10MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 6324c2f9-08ca-44bf-a6d7-08dbbdf08410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yw13odKGJpSDmHNjwCIJPKYr6SIxtz1t/cCxJOdKZBrHk5wuK3VSnWhkqd/PjKIjrazGrPhNMdRh3We/3beKvP+Fbbl1TMOpS212Q+oX+uTe2pfSTeoEAkJpLKebiYm65jxzxuOPDPYJAXrgaFUJ21PN3me4zmuIIQ5uXYmxcLVa5kFzb1PItkAQOeKwZUmELNYKiLxI2spnL7ARQBIcOt3ITsKznsxiwhzMsEe0XVOZzruTJzUpvVG/AeDWG7i9Z2see7zFNnrIN7nj0hPDpSomKmh98WsYYXBNGaBEQpkiRZOJfSaJLJgIu4/ua9B+ratdJ51od+/r1OAe9HOpp+c98ljY1rAUouGAUS7AJkMqcrNxhFvt4oSblRo/wh0spGkv6WDU1Bou5ddvD2/sAHfi4lXtb0x94F4t8Gjn5yK+UotWQRMAvGlGgbIYaYFUwSKyo2GYmQGuVNO53IoMC6uVWgU6+hiMKBq3tYYEKMdzW+0nu4eHMhnT7DvmAMl/7pltO0Y8rXf6sKejHYgyrvHozTWtrmHLUjq/om39QvqUxfK4583IhJpsLFf9/NCfWuabm1eUyQll3hMZWCfbk7T9eWTZ9D5NW3Ej3xS8vUv3iSFXCSZ6tnFFcJRcdMqbmGZLrJ/vmZAooCvEfmo3jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(1800799009)(451199024)(186009)(2616005)(6506007)(26005)(6486002)(6512007)(53546011)(38100700002)(31696002)(86362001)(36756003)(83380400001)(8936002)(316002)(8676002)(4326008)(41300700001)(66476007)(66946007)(66556008)(54906003)(5660300002)(110136005)(31686004)(2906002)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFRPbDJlRXFJc2VSZXVrZFFuTjZFUEpUMHBtVTdnZlp4RUZwT0NyMFZzYU9p?=
 =?utf-8?B?TFhwYXJsRTI3ZTkvanRJZjJQUllsR1lUVmd0NXVzL0FUb00xalp0QW1EeFpE?=
 =?utf-8?B?ZWN0bzJ6MTZJUjVGd3ZrdjR0UUE1T3I1TjVZQ2Uwa0N5T3QzVEJoSVVjNzNL?=
 =?utf-8?B?MTh0ZnNtWW5HU2xUdHQ5UmlGWHJxM2ZYOVByaUlLSVdPcm53bVNSK3JMNVFj?=
 =?utf-8?B?cTJZNmNFZ056MHNkSzNsK1VoK05WeFRXbm1FdzF5NGVlVmhZKy85aXBKYTI1?=
 =?utf-8?B?ZGl5SFc4b01KNUdwUkVQbXJEa1hKOGE3U3Y4endZZHBMT0k2Nit1RG1EZ1ZC?=
 =?utf-8?B?c0VGWWcxZXNvMDhLUW1oTTkxY2lNZVdGTU80aXJraUxFQXhTWFNxOFNHTmEz?=
 =?utf-8?B?UU5TcmZadkRLaTlidnBqbjBCRk9uR3ZXYW9rVElKM0FiVnQvNklvUjVDWDZM?=
 =?utf-8?B?MlJaVzB5cHFqRWtMQXArMW9aVXJmWjJZb2pWRGJqbUFwaEdnTS93b1NlY0lk?=
 =?utf-8?B?SmpUQ0ZVQStVcWhhcy9DSlQ5Q2NCY0hyUGZrUituVFBucEhQeHFJU29UaElS?=
 =?utf-8?B?TEhuOUkyclJXRTU3WFBxZjVjL0JoeHlGU0tIUmIxYVJzY1pnTktOdXFNczZ6?=
 =?utf-8?B?Y2ViVm1tRllaTkx5Zld6K1FHTEZxb0lWQWQ3VSs1b0ZGY2Qza3F1QjArZ1Ex?=
 =?utf-8?B?cVNLWWZZOXUwQUZVaWhScXRtaU0xdWs3NmdXNUlGRVh2cFBVWFdxMUZpd1ZC?=
 =?utf-8?B?aHZaK3B2R2xJc2g2OElZZ0NuTG5QK3grbzM3S00yeFlPVGVwaFFFaDdkZEVh?=
 =?utf-8?B?NG9yYW1VWGxqdXVkZmc4WWtKZHhuOFpRZDFaWUxaRlpKYlREcnNKNm8xY1NB?=
 =?utf-8?B?a1A3Z0hnZ1ltTjdmK2xzS1NibDJ3KzhQeWxSN3lHSnhzKzBMRVFTbVYvdFZF?=
 =?utf-8?B?R0Q5cm5KOTVsZHlpczFmSVNFY0J6QXVWMmp6TmkwVTBmMG52V1hValZ1NjdI?=
 =?utf-8?B?dEZHR2VtcXQxYlF5dVh6SEhJc0RCMGhUSEdGWEpEVGMzeFBJSWNMVFhsMHRk?=
 =?utf-8?B?b3o5SWJmMVhSWklnMGIyK04yZnBaNGVrQ2RPdGM5MzZoci8xTEFoV3B1dFFs?=
 =?utf-8?B?Vll1MUJkMUpiZEJyMENuUWthckJ1cVQzaHB3V1RwalJ1U2syeEg3VFQ3Vk1O?=
 =?utf-8?B?cjk1Y1BhcUxlZlVIZ3pDbEFGeG5vanlJK3FLa3libEN1TFBIMC9rZW1oZzJO?=
 =?utf-8?B?WkNXaGxGTGZXRWJMV1p3c0hPLy8rNzNhWGJxN3NlREc2ZWZ3ZUMwVDNyTSs1?=
 =?utf-8?B?NXpZazErKzhLZGVOOVhOQ3FtSVhOelFIMFFhMGs0OEk1WUVZTXBxZzBUTlJa?=
 =?utf-8?B?VnQxN2RobXpzNkVWc0lNbjBKMkZzaS9OWXBzZU9iMEo1cE1ZbDNLbTk5cWxv?=
 =?utf-8?B?cjZJKy84azdQUG9DQm02NlRLOFFLeDVsdzI2VmxCRFJaQW8rTjJ2TndnSWw5?=
 =?utf-8?B?U3R2RVhhUVEzMEpoaktKZkhlVnVRdm9YRGp4TDJFN3FXNXFneXo4MHByMXA5?=
 =?utf-8?B?TlV3d3dPajVZZW03R3pFTGdXYmk4bjJOQWxVUVNtdElJV3h1cmd1OXF4Vks1?=
 =?utf-8?B?Z2taTHltV092dStoSTZIeUt5RHpNRkxaUnhuOGdBOVhnbjdocnBPQnVKK2pU?=
 =?utf-8?B?d0k0SHBLVi84OFVIaGJKRzJNVEoxYXRQeHVvNlAvRzdTM1JpNExjMklIY0I1?=
 =?utf-8?B?ZWk1aDd0cVgyK3pUcXA5TUFKK1ltK3lMdlhPZ1dxbUxwOFY4cmRJSEU4Y04w?=
 =?utf-8?B?dldzSnhNRGFuakRUSEgwMisrTkJRaXBXZ29DT0pGTVM2UEdYcUtJMnl6UVhN?=
 =?utf-8?B?K3Q4Smo4dFNtemI5ZXM5Rlp5R3FOcDNjV3VWU2NRK044VDlLTlBwNEFYOExa?=
 =?utf-8?B?Nzh6N0xNMVZIY0hqczhkckRTOGc5T0luZDcrZTI3LzlBeEwwQ2dLaGxBVnAx?=
 =?utf-8?B?QldPR0FqQ2RYWmwrRG1jTlFYVGFUcllMNVJEMDB6YXNobjdnd0VaYlNvRlBo?=
 =?utf-8?B?UTV0N2QyL0w5dkFQcmJ0M0o3ZkVVbjBTTVZSRjd4UTY0ZWdKZWlkem5ZYi80?=
 =?utf-8?B?T2UySk1Wb1BreWtIWTJpWTUvclk1U0svOXRTMUNZc05VczQ2ZVJMdjhnNWlx?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7LRA9AFSmHyBPABOI1KMBC1+gTzAqiOaMzPRZk2/nzAX3Hxjlh9iS/ZSbDBPxsraXfTYY82HSIP7rVpfiuDbHHvJkv6mYjYIW15V8l8P479veGxD3Y53ehb4X7W6+GWdq4eSuVR8E4EBRpojKxva71MTxu2Jh5X74pO0qbBY9TQAl5nRnoSNmDXNqG7iux3NDcGWhDocoZjBcPvQ6s0XI4Ph1b/CgPHxN1rq/FIvqzKFf7NUuDhBWisiJmCuIFDtk7jxEc2WfDP2YBytMhGKbX37ZJu3gE8ECJhBsJAXQ4/2RW/wSbJGfhwAlIzwicF0UCtiqXrqgBhS/1K0d9iWwQ2KpHqLp4Mc2juhoiHYO7bkMcsv+Bwa61rsWv6gyFk7IpVEdzkoZGjbkNm5WQalo0Tn9ziPMGw9vPZV7iCP4U+wnYFjOIVKRhyEgDixTwRqhgL/4pzHrWDEs+mK1ZVMFMjEa4dbaCp1JhJFYaR/uGIR+rhRrKANTxZnMEye3AWueusgUUu912BlJd80+IjTtPNtw1gjDW1qpYz8igYP5SJn5q2icaHQFKDM3KPZNprW243hAASpnF9m1csnEFl4j78D5o9DX/V3wdVPmAzS0OpXb17Y636uqOLv2BoOS31GBj08v9yyQeFoqA/vBHdUpE/92odNhIkkHO5qm+I7wpvY+bgCT5Ced7IHgtjAyIfCVl6lg6YCHxMuzEZxS3ArUkBXgQh5XLEolP7L1qxOywmr8eutHwgtcBorMHS9Tyq2r1cmhziKWfcuk6IFXIK1T1hHWEdRvtvqfSyTXS8VANmpu12oCp2/EyVr3r7KTFOKpMY4kUCptBqevHGZ88BdK46+X2je/qEcUHd9RRoSRYarrMMlQQHNt6bjNinmGkFZ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6324c2f9-08ca-44bf-a6d7-08dbbdf08410
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 17:54:50.9562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Psujaw1nGD6rxOj218yzS5zBrvjjDym9hYGb8T0kdmWRFUcCe/Sd0VgJCZbNX7ML2gc/4WMbMU/nVp4qVsRgmfiCBas4BnF88xAtjwa1WhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_15,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250140
X-Proofpoint-GUID: YiTnzYEhWlS-piaJsFNazTkqDBsfuNzv
X-Proofpoint-ORIG-GUID: YiTnzYEhWlS-piaJsFNazTkqDBsfuNzv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/23 10:07 AM, Wenchao Hao wrote:
> On 2023/9/25 22:55, Christoph Hellwig wrote:
>> Before we add another new error handling mechanism we need to fix the
>> old one first.  Hannes' work on not passing the scsi_cmnd to the various
>> reset handlers hasn't made a lot of progress in the last five years and
>> we'll need to urgently fix that first before adding even more
>> complexity.
>>
> I observed Hannes's patches posted about one year ago, it has not been
> applied yet. I don't know if he is still working on it.
> 
> My patches do not depend much on that work, I think the conflict can be
> solved fast between two changes.

I think we want to figure out Hannes's patches first.

For a new EH design we will want to be able to do multiple TMFs in parallel
on the same host/target right? 

The problem is that we need to be able to make forward progress in the EH
path and not fail just because we can't allocate memory for a TMF related
struct. To accomplish this now, drivers will use mempools, preallocate TMF
related structs/mem/tags with their scsi_cmnd related structs, preallocate
per host/target/device related structs or ignore what I wrote above and just
fail.

Hannes's patches fix up the eh callouts so they don't pass in a scsi_cmnd
when it's not needed. That seems nice because after that, then for your new
EH we can begin to standardize on how to handle preallocation of drivers
resources needed to perform TMFs for your new EH. It could be a per
device/target/host callout to allow drivers to preallocate, then scsi-ml calls
into the drivers with that data. It doesn't have to be exactly like that or
anything close. It would be nice for drivers to not have to think about this
type of thing and scsi-ml just to handle the resource management for us when
there are multiple TMFs in progress.

