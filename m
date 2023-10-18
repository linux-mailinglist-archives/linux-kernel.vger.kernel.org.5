Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34B37CEB73
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjJRWpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJRWpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:45:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AC7115
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:45:13 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIn01g011269;
        Wed, 18 Oct 2023 22:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=crSuBl8qRGbavHySHhGZY83lAFTcVhIN17Mxig0+nzE=;
 b=yDY0jE1mRhWlMJpwZgbNFVSFZ3MDndLuHwgdPKPEUX5ncUtBy5vp1SQV0pIRO/O8e3t6
 bcI24d0pDc0e+WYYj+EW8E+SFoizvEOFKS2XxBAk7YV4h3qXl/Xs+dVXoPJtd698l1VE
 67NepVjXslUPFFlP1TNvVuI/2ArSzHMTXcj5BH2qkS7yDsvBz6fbhtBkctcuMB64rLey
 izMdIXTVACSXf1HwqyUXpYSM+1ePsKBRs/1Ia5nke9UFpYxVlVtDX6dX3YdvKHCRNLfm
 ovgajnijAgYtUZzaIGQYW40WvWgFkxeodlWyhV1d7xp947OJHrNRDwYHKUw6lMFjiFrH 0g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1cgv6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 22:44:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39IKHNjg009572;
        Wed, 18 Oct 2023 22:44:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg0pw6tj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 22:44:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPVN6cvy6XDaoSn8ILCAuhghmizmc+DJNG9JVxpiXleUiFixV8ENatWXSEf6vPROc+ITMlUayNl/Yxe/dkiCZmStoVuBoT+1FywlDNfCiMWmweIkHaDgHtvOM24Ij8lv6i2P0nq7YBrR7RsQ1afKNwXcpDns/DtEHLJzZs2yB9ka0mOaU/IVCxhTcOc9INpIMvQLE+k/89wus6QMrKBY3RjY1NJCPPAajBs6TY/Vyi460ueqtzhcw3EYV8cO8BmxnJqytZj1eLLD/1/0/eLJxRyR8UIJ5jzBj8xsXX+E4W6LJcf/URXfLuekIfHluTTcm/px9loCP4kmiTuMEF8jsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crSuBl8qRGbavHySHhGZY83lAFTcVhIN17Mxig0+nzE=;
 b=ALKpTgD9uFALVzDaTJpfdO7/KHRaAtFa7ZnMwUk0K1SiBrSTj6YNFftvWOIq3qGkbVXGZj13MX8sxvMhgmB4hQ4/gWUOiZCeeoNiUZbIiJQ92NLxVF1+JDHbpTVS05/00cRpyGTF3BnbSeqBoYn+vWvCp4hYxxuLHwOTokWTBP0hXPhAbjxcy92KZY5M6IsdNrp8g5DFtG/1dhpfIu2bXUqC9I7yzHmsZ42ihuLsxjvR53ULoo6BTbU70+2GyNLSRnYymbXjvWq15wVFfhrLxWSbYTSR2Ythe5MV5aGJHfCZRKLDloy3uf994yVu6f2mJ1YlRIotiX8zBGhahN1T2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crSuBl8qRGbavHySHhGZY83lAFTcVhIN17Mxig0+nzE=;
 b=cCK64VUmSSpdAgTCDDKJ0uVs5txQayWUU1gS2HMuz4t23COpuXG5H6/WfKm0detJ+plz6DWbmuVHRboMgLcsmly4e6fBIuB502Qmr0r6K1epQysTD21eU4P9Y29az9ltpQf/ZSu6IcWNPhFLkjey9xzHi2eMJVtwLUM3bLzqo4A=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN7PR10MB6382.namprd10.prod.outlook.com (2603:10b6:806:26e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Wed, 18 Oct
 2023 22:44:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Wed, 18 Oct 2023
 22:44:25 +0000
Date:   Wed, 18 Oct 2023 15:44:22 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Bisected: [PATCH v7 2/8] hugetlb: restructure pool allocations
Message-ID: <20231018224422.GC5181@monkey>
References: <20231006032012.296473-1-mike.kravetz@oracle.com>
 <20231006032012.296473-3-mike.kravetz@oracle.com>
 <20231011064756.GB2866435@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011064756.GB2866435@google.com>
X-ClientProxiedBy: MW4PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:303:16d::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN7PR10MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d6ddba-d4cc-4861-b7c9-08dbd02bc764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/uT3CgUihjr2PoZ1w6E9p4qJVNSPZIhR0SlZbSbG3eoCsELhViLVERqjSCKIf3+K+Z5pusU0QMcYsTvgfT+apP+B18fZVemLrX8GF2XFjAGijgjcavAIRVsKPJ9+0d7Kaj5UnPPX2q5ZEITo6HeR7RfnLm54KdIva3kohyL0yw4ooj7+KWWIAaFPyplLiq5QQhc1oeSaDq7QiTCWJfSeoOwAhpH8A38GoO9XN3rCoty0vByRg9IPRCMNZDgK1UGAl2yFqmBjMqtlhTpMi3sKETesIb6211NCQpRafi/2ym3MwKGb6//oNVNjMuHOhvxOXf5xJMARAcZBK+3chN0C1IK9KtAYPou7j0pwxrPvwKMaHO3Rv0EZ+R+h0CABGzvvhQ05/0xra+vRwJABvKV5s5mfpQNJTZM8/E4B+WlNq5STBNyAVQil5+MjgPdRIsRw8sbF5+ZXX1g0rHprnxA1OqGvXNaGocdqKU9mwNzHoLWTPOYA5LRYXid3SBYlv+TIv8PoHw52XGZPZi/RybYCWesfc58LOkHiPK1x+XzEdo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6506007)(6666004)(53546011)(83380400001)(26005)(6512007)(33656002)(9686003)(38100700002)(7416002)(66556008)(2906002)(44832011)(6486002)(8936002)(4326008)(8676002)(33716001)(54906003)(5660300002)(6916009)(316002)(66946007)(41300700001)(66476007)(1076003)(478600001)(86362001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dLEVHqed5n2iNN8qMgdmDiX1pYey4zB61Y67lWeJGcarM9iwyb80t3Sbv2MB?=
 =?us-ascii?Q?URoMgWhgYcREk0nv2vffLIHx17nVVKnobgN5q+dzMyNN81Cqolm1brjpvl3M?=
 =?us-ascii?Q?jCXjCRkVRC7mIOIwCoC0Ym18egKmpvXhIFBhpsO4ECstRY2jSBIDYwmzYvHA?=
 =?us-ascii?Q?l6ZIJ066TkQxBArFoJ0rx95aVa04wZg0TuD5CP0NbZdBpCrz/2MN1+28OeWV?=
 =?us-ascii?Q?rsryCOTzLIZdjAGUEn23uEpPSVpTQMqGi8KPct9XYCvaqKdpLKIxuAQHMXlo?=
 =?us-ascii?Q?82KXh9WTTvHYww8D9Rbsm8xhkQ7PSIJVJZFMintwBnAR0eBh2LT8EkPwK1AE?=
 =?us-ascii?Q?ZzqUy4+QSwhE2/ouhYaumtkXCHrswLApt3FGUPMUpmzS1oNxwznQi8Wo7d0c?=
 =?us-ascii?Q?meiqb4giHPWnOvERRbk33j74ojmUPAy2tvC0SDWE4TeXmaeQFa67YaZtUYXK?=
 =?us-ascii?Q?0+dNblVM+MHqB1/vcCr02zv3vTiVvV7k+T7KvPb4UfauY5k3SFIMgwE3eGiF?=
 =?us-ascii?Q?ROlkSRjcPp+WWilpBmbnRhVAjCnu0eNxlf7Yx2gB7YoyFksgczk/T9YFkBr+?=
 =?us-ascii?Q?IWbCBsW0C08D95PyF/9CxE358mMcQWD6LGFx7slomyRW1ZkfMfaxn88Xsx1T?=
 =?us-ascii?Q?FL4wISKUuOZ03C3bdSNl94kTeCBwdZWDJ4jm5hFd5CSm5aTtb4+rRfkRfQu7?=
 =?us-ascii?Q?Jmf5S82PDuCy4WrdNj+IhEz6q9BiWcNaBOd8SFvR6YDpHnbcAs/ZXGFqmvgw?=
 =?us-ascii?Q?tMpC/8ypuoR9Auq8LtsrNfXwzfX8NOTanrAe5YHHFrEq2ihZa8VUNCfoFdsp?=
 =?us-ascii?Q?Dy2gfKJUP5yA6JiKTTBgbguAMeOto5XB8brZbvemz97ERyzgLRq+w3xWDmhK?=
 =?us-ascii?Q?S06y0umi8dhyUEG0RlhifEXeMhRXU5N2+J5esqlomXBrn8kggGkx4KdNlNz5?=
 =?us-ascii?Q?kbrc92yaP6BV/3PogruJt10XPUemeFkReZN55zfhyirhSXk1zA0mueisM6ba?=
 =?us-ascii?Q?ovD4u+wmEdjbMqkzy3Qm0a09Xv4C6CwoZE3WdBcit+m8T3AUazrOWRgrWdqu?=
 =?us-ascii?Q?PKC4j0PTpT76hdcemO+n+25VPftw8LJ2o3KOlcTYip/dG44qKbUOIgP25kpU?=
 =?us-ascii?Q?QKzM7FKISWgB/416Ah/dpM03uDXofb4dZGkCofIa6QPBbFeo7ufYCScMAg3I?=
 =?us-ascii?Q?lVkKu4Xj24qaAsRvWJC+5+EZww0D7QqGvvsXNTCKwFmEpQDouFxLJRyVrneC?=
 =?us-ascii?Q?sjbKdD7Kr8qzfk5EwLWJBqI2Fy531cTlI1tkyJ5maJvW6lLYcxSs3lIfBTHG?=
 =?us-ascii?Q?cFOwuf4nAsk80WoqUHDFtIKkZCOFRiWuhvvYYsGueMvDgRsATKf9+LczpBJr?=
 =?us-ascii?Q?mO6BUbvd0SKHy5MECTc6DuTjjFsVaNBXzMNAcNzQmmiqISNPKx+9Of47HzUR?=
 =?us-ascii?Q?C64acPr7I/4x2FR0Vmb3j+dGxr7RVEEglnDwNgAK8E7mBYbX5rlyW2CPABzP?=
 =?us-ascii?Q?ZtFhNxSUiknc5mOJQ5o632FTrzlRa574rydJUA+XRcWUX0DeOifRbHdG1AVC?=
 =?us-ascii?Q?HTS/kJzqVlhXG7tK+EmCW9Az/bgCG7fc2RA6GsiBYd7R1URkqzOjpniSK6EV?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?igX6ltmuFE3zvuTO3i6fG5x68VdsE9tWvTZTpxsZzt4nOarVHdWLpVrVaJWB?=
 =?us-ascii?Q?1KKGVB+WhteLTHrORvgL+sHG4yn6jT77kprJGJZCE0zUiZmBRY0TXa9FYaA5?=
 =?us-ascii?Q?IqtLcADJGLZ8jUQqinFU3iFiSIunOou8I85FdH9WZZFWCGyXMXYmgpOQaHI4?=
 =?us-ascii?Q?oEGhjpHLQOqu14Bvqz5+tLfZzc+Wz/zDB7TkZVp7xdkdbrfbElR//SpwJSLP?=
 =?us-ascii?Q?T8SkBpRa+vy+oMu1XM5n6elNWGW3Pu67wVyCPzcfV2HcFKyEs/21SyXuQWTC?=
 =?us-ascii?Q?G5J5KwryODpTMSsqt2PNIRqZYddJ3t5IievO/TWiGaw70HQSfxb8ZkqrtoDZ?=
 =?us-ascii?Q?GeZDxNU8tKZNVhFTQ2ZuUG0ujKZEt4w6mVGY2w2eX3S11LeSpMh87qwrdre4?=
 =?us-ascii?Q?gOnlscRVt7W8Qkvb5eh/22bQoTX0kdjRadHORATNII3JpIk20gW0FWNf/GNf?=
 =?us-ascii?Q?snx59ckQ9xm/c1aCCKHANMlVFkAB9/OtX8cbrabAviuViBcIBYZK8MqOLxSA?=
 =?us-ascii?Q?Hw6GCmBvArc7lcw9ZZxLtHi8tDP/zR/hye074qyzHtwdiIGyNLQ5j2Wslwej?=
 =?us-ascii?Q?zRCwfGnPHkxbDq1ucrSimuKqDp/aPP2tqh8jfrnDwrJGclp0EZeMFCpbU1XD?=
 =?us-ascii?Q?AkFfwnxAa/8ZahMySYJ8rVtca3nerZM/TTHsjV5WgEtidUwSsANtL4TI6O46?=
 =?us-ascii?Q?ONNwtG5+P4j8usICKC/9M2VlJxkrGQcVkvRZyz0QnsknPDbHepAJvNSMomv6?=
 =?us-ascii?Q?yQ2oYga0X3xqUJ15L4oP2pJOAlZz4fJ3ijlC7RapQVb/H6YarPmy4pAePLW7?=
 =?us-ascii?Q?W/GNNepeOcsu/y5oGbPtaZKRaFa0U4abpp+yzZ2X/6IIr2f7GB8yS8NAU/yO?=
 =?us-ascii?Q?+tbtOVoT7DDgtj7LmqrNnprdmstZ6q1Tn87dAxZdSG0+ZEkX0ltFuKHtAOcu?=
 =?us-ascii?Q?NoV4mwikIV2aqe3cpM7kiby+7eGURqwt3kW18zH/3fU16P9udnouyA4ACJb2?=
 =?us-ascii?Q?FYLxfpCWsdGwAtMWxu1nf30Dp9rQMTUVYtazc8V6xnMgLqaDWOOBE/aqZmiG?=
 =?us-ascii?Q?LaxSapZ/GIFsciQtYSpYTGRKF5GWRNZveIeyqb5Yh4AUCYvvxB0frBiPWo61?=
 =?us-ascii?Q?mhZu9xrNWNOuDkDzIL/0RW/IUTJ3MKoCL8/JSd9MSjnxeImuUhSZx3P2nA9t?=
 =?us-ascii?Q?uw6XW8kltUf6DJUO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d6ddba-d4cc-4861-b7c9-08dbd02bc764
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 22:44:25.1730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/4NmGg1Vlc+g0yqXc6N7IOvrRPpjdiHwINnYEtcbMJTWRNAdUDI3tYPqne20nAp74n+ysFIqjKOy50d9oIknQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6382
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180188
X-Proofpoint-ORIG-GUID: 3oNKaNgX3zmtJrwE7gyPbSI35lVVgqhL
X-Proofpoint-GUID: 3oNKaNgX3zmtJrwE7gyPbSI35lVVgqhL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 15:47, Sergey Senozhatsky wrote:
> On (23/10/05 20:20), Mike Kravetz wrote:
> > Allocation of a hugetlb page for the hugetlb pool is done by the routine
> > alloc_pool_huge_page.  This routine will allocate contiguous pages from
> > a low level allocator, prep the pages for usage as a hugetlb page and
> > then add the resulting hugetlb page to the pool.
> > 
> > In the 'prep' stage, optional vmemmap optimization is done.  For
> > performance reasons we want to perform vmemmap optimization on multiple
> > hugetlb pages at once.  To do this, restructure the hugetlb pool
> > allocation code such that vmemmap optimization can be isolated and later
> > batched.
> > 
> > The code to allocate hugetlb pages from bootmem was also modified to
> > allow batching.
> > 
> > No functional changes, only code restructure.
> 
> I'm afraid there are some functional changes.
> 

Hi Sergey,

Sorry for the delay.  Not ignoring your report but chasing this in
another thread.
https://lore.kernel.org/linux-mm/20231018222003.GA21776@monkey/

Quick question.
Are you using LLVM/clang in your builds?

My guess is that you are hitting the same issue.  That BUG at mm/hugetlb.c:3180
should not be checked/executed unless you allocate gigantic hugetlb pages on
the kernel command line.  Suspect you are not doing this, and loop code is
being run when it should not.
-- 
Mike Kravetz

> [...]
> # good: [9e6c86c616f7d4b166c12f1ea9b69831f85c4a86] hugetlb: optimize update_and_free_pages_bulk to avoid lock cycles
> git bisect good 9e6c86c616f7d4b166c12f1ea9b69831f85c4a86
> # bad: [1d50db09471e2a67272cee6e004ffed380ac571b] Merge branch 'master' of git://linuxtv.org/mchehab/media-next.git
> git bisect bad 1d50db09471e2a67272cee6e004ffed380ac571b
> # good: [80b14e865ea20ddc20aae61e2c106ebb03257cd3] bcachefs: Lower BCH_NAME_MAX to 512
> git bisect good 80b14e865ea20ddc20aae61e2c106ebb03257cd3
> # bad: [31d068de8a0de2c44168bbd8a62da21a7bc76051] Merge branch 'for-linux-next' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
> git bisect bad 31d068de8a0de2c44168bbd8a62da21a7bc76051
> # bad: [0bb194b29fa6296a74b989e0f7f2db4fc11d8012] Merge branch 'perf-tools-next' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
> git bisect bad 0bb194b29fa6296a74b989e0f7f2db4fc11d8012
> # good: [62001c9bf6aad59dc800c16613e5440b9226c252] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan.git
> git bisect good 62001c9bf6aad59dc800c16613e5440b9226c252
> # good: [21d856352ab78daffb9d05296b87b570f3afac33] Merge branch 'mm-stable' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect good 21d856352ab78daffb9d05296b87b570f3afac33
> # good: [7fded33c6971b6c8e87cbbf48e74536aacca2991] perf test: Add pmu-event test for "Compat" and new event_field.
> git bisect good 7fded33c6971b6c8e87cbbf48e74536aacca2991
> # good: [4c37b665186a5e2907bf0308474ac3f15eb847da] compiler.h: move __is_constexpr() to compiler.h
> git bisect good 4c37b665186a5e2907bf0308474ac3f15eb847da
> # bad: [3424f8f382bd4d30e01eaf316823321ef7bd1560] mm: delete checks for xor_unlock_is_negative_byte()
> git bisect bad 3424f8f382bd4d30e01eaf316823321ef7bd1560
> # bad: [b5c6a60fe5b0339ba9c54f9f871db5c4a0e47906] iomap: protect read_bytes_pending with the state_lock
> git bisect bad b5c6a60fe5b0339ba9c54f9f871db5c4a0e47906
> # bad: [bfae92330ddc44968c628c0085082d25061495a4] hugetlb: batch PMD split for bulk vmemmap dedup
> git bisect bad bfae92330ddc44968c628c0085082d25061495a4
> # bad: [fb59f2cb8956f3888d2e0b438cc503565aa3c405] hugetlb: perform vmemmap optimization on a list of pages
> git bisect bad fb59f2cb8956f3888d2e0b438cc503565aa3c405
> # bad: [bfb41d6b2fe148c939366957ea9cb9aa72d59c4c] hugetlb: restructure pool allocations
> git bisect bad bfb41d6b2fe148c939366957ea9cb9aa72d59c4c
> # first bad commit: [bfb41d6b2fe148c939366957ea9cb9aa72d59c4c] hugetlb: restructure pool allocations
> 
> bfb41d6b2fe148c939366957ea9cb9aa72d59c4c is the first bad commit
> 
> commit bfb41d6b2fe148c939366957ea9cb9aa72d59c4c
> Author: Mike Kravetz
> Date:   Thu Oct 5 20:20:04 2023 -0700
> 
>     hugetlb: restructure pool allocations
> 
> 
> Bugs-on linux-next:
> 
> [    0.827640] ------------[ cut here ]------------
> [    0.828608] kernel BUG at mm/hugetlb.c:3180!
