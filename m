Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9C57A2A6C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbjIOWYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237871AbjIOWYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:24:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AD6272A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:23:05 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLvpmc026895;
        Fri, 15 Sep 2023 22:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=DegBftbsheCrESTzRwzzfr3kyOLf2UlOlljk8JHb6kk=;
 b=2JYtqPEl5rFe0IzD33zhuHJzR2stJbgHiIL4BcL1jgfchj/Jru/8VQrUUA3Rau41oIe5
 6YaqZ/ro3Pl3rhalqt/xmmluy43muneTvkkbCAlWXGR2eSPgRc5i4UI+V0P2xcP/10bH
 wzsyGv1Urv8aQI9ldxzXb0KWAKh9ck9JgX8D4NtOZQXqLi29K0rq9V2JohSa8hvfvwEX
 zv7G/UbWWbq10D8atYI8T/wO4y19aoPmEFQnkvnLykewMRoO6NzdWbtdqL/nz/Xxn5tA
 8U0u4TKNlsjIiUJnjsXwF82lloqGtcrzJDEP4r3rRAlXo+Eiw1gclSoZEurgvi1y7Ly5 YQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7krpsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:22:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLZhLO007489;
        Fri, 15 Sep 2023 22:22:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5bdakq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:22:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oC21nhp4UTS7sZNyTpa/RHImBlR1TTwsWF4cgSuv37xgDAfbziZj5GSTZ5+GL69CEpIJGFEENmu0yBATDFZUulR+VqWwMLimUPUB4JyXS6octrUlxHorW0jHlx5w/V993wv7FzdPfi7cfA5dLvZePtj4Sl1fmsu20L+2BnLSNRsuRP/Ai6B5iBviLbxN9cEZkHclA4FGD7c/v2uk71xJaKOPbBTf8rD8TVAtmQRwRbJ61HrhVmQHhpXMcwo49OYQ9Am8iAqYz/yfTHi/Ts0wYsUchkjwdGfIXyc1KowyD7WgtnT5okQxA5SsC63GHTDSVryGYKwjhWFBu5f7V9cqbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DegBftbsheCrESTzRwzzfr3kyOLf2UlOlljk8JHb6kk=;
 b=RYdr71952H5f+H7s5O+Qa6jeGUcgb3bsxQmR5I5vc8C7OaHnKiFCH/IUqWw5ZjpV93YMxRxOVxR25pGN3txVLWpq210gdLIDcU0RYvVf7wung2fnTqPtYqEHX/73soS0gAgzcT4EOFaKg14Y35dAk5bx1c/IvG7R/+Miz46GF8CkvrSaeVSCSPxwzS4y1nWueVmMa82Lj0FCxbCbVLGi+w196xbBd5s5e88HwZ9qxdC3aV5TPJZEa5YXzS6Z99s4XDA+OYyOYuIBqLTqIXIT2Sl+WsYdu03DWzhVYbDNcUwWFc6mq8gKzzVB8l+SzKchC2ntKXk052hDY9K9Ug0QHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DegBftbsheCrESTzRwzzfr3kyOLf2UlOlljk8JHb6kk=;
 b=GqQbawa2RSZI1dY4r01Je2BF24j6ygDwTuVG6TD7oah2Bn7LNwUpTQw1CgfOT0odvO/UpPABYbqZ1Rn08hhn1k+seNE8ObJcZoTMNgmMGV46nbl6ihe85hAWA783sLKYBiaqmU8tKb1sRd1X9ttrj6wqke3RntWP575o49FwrMA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5801.namprd10.prod.outlook.com (2603:10b6:a03:423::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 22:22:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 22:22:10 +0000
Date:   Fri, 15 Sep 2023 15:22:07 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Usama Arif <usama.arif@bytedance.com>
Subject: Re: [PATCH v3 00/12] Batch hugetlb vmemmap modification operations
Message-ID: <20230915222207.GB426926@monkey>
References: <20230915221548.552084-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915221548.552084-1-mike.kravetz@oracle.com>
X-ClientProxiedBy: MW4PR04CA0118.namprd04.prod.outlook.com
 (2603:10b6:303:83::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6ce474-9d5d-47d3-eef6-08dbb63a341d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EdHxEPNzvO/wY6dlB5uFHV7YDvPqq74P2oHPaeaEQp09tyqXjwFkgS/AUegaUfPBCLaTSq66DwZB0JPTGSQIoZ2RObYVvKklcfRh8dygAQ30QwJnVGQFc2hbM8j+dZhDkuY/4RkJww1XQqd8wdurIlQoxMc7p8Dcomws3aTbC3tkeG7eQThXnA3CP3WDApCdcNFnp9lCaraT5EW0o0riwkE42aY3kFk0lOZIZXajGgRZWhHGFzz6s5OEPF8HQILXhjXG/vmGdNILmbGhG7e4wieHz6r1dPi9knUrqvHQhALLjM+Pm8AYKFYoEyBTMTM1ChxIPKwPDH5Fi0Q3UBdvNCOmhVNGfnp4PQkuYhe1XkIjsKuK/6aD/t8Yu1k++sIrgK7ZEDTYkPghQnNK5nMrIVuQPiTSBzfgubS7ekQQkpC09/vRgqwhqyUWKHtvjk5aAUpCIfOPnHuwNIZ61d8ZfoZDxOt6gblGvKMY56JPzlRNk/O4FMadF4NFbY9Li365jNLTjz9mBbsYUHn8PhT74zfjIgAMhtEO5//nJhuRuH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199024)(1800799009)(186009)(316002)(66476007)(66946007)(54906003)(66556008)(41300700001)(478600001)(33656002)(966005)(38100700002)(7416002)(86362001)(2906002)(33716001)(44832011)(8676002)(8936002)(5660300002)(26005)(1076003)(4326008)(83380400001)(6506007)(53546011)(6512007)(6666004)(9686003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XFQgPp6nKItBrJTbJU4erXtWyv0DdWXFkNt6XoB4SFieQmPRiB7yV+CRJrpc?=
 =?us-ascii?Q?1oNDkqYUppcjdFXZNhQYF7sFRnME50ucV/m9lr5pUzBARRvu9dYp6vlWHkCJ?=
 =?us-ascii?Q?gj9sIfH3SjaSrzG3wrJl3xNJQ9Wodh2bG8H8iSEmpgi+3GX5pw5uVb34Zjft?=
 =?us-ascii?Q?LuXSi+mCnKCOM7zpDD4afsbYZn+Q5vzT9dzWnqTlesNOSEu8J+xRpWFUp7Ek?=
 =?us-ascii?Q?7bJOiJC+beAwpr63UwDODqT1MIofYaLSvi85+D51GMwlRJwND2S6kR3SlLr0?=
 =?us-ascii?Q?5d+l5hW4oq+Ohq6MCld8qSKJY3liNOip2siMfegqlpZ3QCYDs5uNa8RepKaI?=
 =?us-ascii?Q?atC/6ROfjF8r2PNBk46Gn6EbI4jBJg+Vht5nxJEpzHiEmAmMd21Ka98KIDXd?=
 =?us-ascii?Q?0bOhB+Rmq6aSZYGYLaTvM8Ci8tKRdyOo72Z/v94iJDUrsAdfONDXcAv0hI13?=
 =?us-ascii?Q?C/4x9Ne9lQlLKPoxdfGF1Sroq/qs4MkLBN5kg27zbjF/iC6NWGX7Jt0wlzdF?=
 =?us-ascii?Q?uAJXxi7Jhc+QV1OUhPypxDZFdoeqMTFK6nlsEG7HtCuFy/7ncFDD2Zhjgq4x?=
 =?us-ascii?Q?gsvogOg4vVIP4txxsw6hjSJpNXCysG8vr0bglvLhDLJI4gvOoOKTaG7Q2Bt3?=
 =?us-ascii?Q?ljlJ828PF8BY0pSiB+O96M9ZQTqpCC+txAKb+lwwQ34/CywEFbfSHjefdxnx?=
 =?us-ascii?Q?r9XfKpl5ZtvD/H6glF2jp7xqfmJdBZb6G17+GsXOxzkwNbAriSg5Sajkop4U?=
 =?us-ascii?Q?3Fmhwg8hwnylMUevG71kfXeZQMohf9caWrVcGRRnaZbMNNiBVHoSMMMQbUYA?=
 =?us-ascii?Q?c9kD00o/Fao0URJOU6rLO/ErspRTombVgEv+mB4ZOgPrNs3reqMOV/eZatrI?=
 =?us-ascii?Q?HiQ5oqLzB8vp7k93UYCSzf7To+V5ys11UzhuubbLzxBfVvDBQkhz2MYIqo0b?=
 =?us-ascii?Q?c1qarKYjCziOE5nFDsQgpuFaPjSfnYhIPf6K5cJ3fvUBiyvm1ZB6i6B5x1On?=
 =?us-ascii?Q?uBHf7L7aeAMMCuAwb6tex4naN0bReJLmRtVW2FcmW4T9l0UnXI0Z2UESxOce?=
 =?us-ascii?Q?FprQ2BeoxDKMaDqSrY+Ih/GuRnpjbEc+JG8rNg4jsn3PAZXbihQMoCoh8gZI?=
 =?us-ascii?Q?NOKbVD+fojZNXNZSEvIapCu+vhZNZTVMdswXx3BTk2vVNuTZrLcEO6PVTK0q?=
 =?us-ascii?Q?MeqtghLoGH8j0hXSPTrmxa7YZLvNdaS4sEokSvmcoqRPcxJwUP121TApssgS?=
 =?us-ascii?Q?gc+YLdOFcrAB8s5Q/ZlhxQBJ1SfLW7skFzMQwyinWjWvYfQVljpt45tX3WqV?=
 =?us-ascii?Q?FR3rf2WVcgbJSQqwMPCdn2q7wjrHBxDI6AQPdPgqG12fJqeyAvUdYJHnlhkk?=
 =?us-ascii?Q?uwHEIM4vqOaYalIK6AcxgOD8CPE4S1QNmIwgS3yq9pjdWZtMdMbg2CR106pp?=
 =?us-ascii?Q?+aOle0c94JGfV1oD6hd1ySS1ZKksLdLktSTUfzbxJ+prftvDeEIPcg/6s/W5?=
 =?us-ascii?Q?AsBckX6V+VzKudcBDPNGzGgLjSjYUTzQ+Y0Rq9nf3NsWtVsvAsPe9N8Qa8Gn?=
 =?us-ascii?Q?h8hZmgQMeIQ2Myfk0sX2DtRlKoIn1OgJglPovzNdOooc0YnKgANQqbFb/G2q?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9lN25z2vYriGpg9SIuUftm6Yg0GUrR51HIBU0sfP8G+1eqfTnV19MoDTNzpr?=
 =?us-ascii?Q?CoC6UF7LVykzWTG5oZLDGcVuaZGCrlQFpwVW7JMVRW0Orn9nJOJ0sbwQQ7Th?=
 =?us-ascii?Q?gUH7iPv6kwMTGmtZ0XjCO+ScFbriUra5kwm0S8r62y/wYiWvtobZSFqJZ2tZ?=
 =?us-ascii?Q?V/QxKmEDCoOscC8xkBCuLBwp3xJf2Sq4cUnS12hwRU/4+q1ZnqjKNHQLUrYO?=
 =?us-ascii?Q?f19NI7IoDowh+YtfUkAwyemSNsFtueQdbBMsP4EnFI4CZV+A6EuQjCJFPH4u?=
 =?us-ascii?Q?k7TIWmJUHkR2eIZjjFB1cxDvu44PMMss5UT6FM/tUnko6GmpRCiHyCKDrnCI?=
 =?us-ascii?Q?nK3yum70tOjVtRMJJcJSYOZw2goDJHNQf2ZhKTHDmE9cF3yK+lXeTVuylOfY?=
 =?us-ascii?Q?JHYxVqC6MdCUoej/tUTJFZ4Q3ijayHuVyZyJoxvzVu0Qb/1kMaWI/0vYUmmK?=
 =?us-ascii?Q?vCE8Uzf/7YcRunZK0AEH8XjsCfkKK0CKZvttzRZoYzspiFyXaJQHa+khOQ3e?=
 =?us-ascii?Q?0jd+zMk9U6xQDG+xouJX7MAuZLe8881psXlRlsQ2u0TnP73z8L6l4xRe/8wj?=
 =?us-ascii?Q?VKkVI0nbFsiojvPsqm1wUwb/VQ8eYv7pH+W2qmNcVtWed/Nx5sDzFXSUmvwy?=
 =?us-ascii?Q?jfYk8xgwCXzUX/yC4bgh3XlGqnzu6loGO0NP4dGLuVXUlnuQ2myBQ+p21Nov?=
 =?us-ascii?Q?eaJzeMPgIimTeuqsbnk3JNZcTvNEWqwpNpM1Q3DmfoczClA2Kfu8WvIRgqGh?=
 =?us-ascii?Q?CZ92Rq6xZmZ+d91x1S0w8S5p1VA6tpRHGako38JeBcqGCcYs/w/VtqkT4oWg?=
 =?us-ascii?Q?3/Te7lyiFyrw/63p994dZXXUINp5DVLQto2vjep1zmIVu+QHEOuvYZkyd978?=
 =?us-ascii?Q?66j9rfMLtiZhmT5sbEW95g694D5C6zuRWeew6DdlusFlrW8EM80cEDPNYhoR?=
 =?us-ascii?Q?78tZNYf/22/1A1BX8s5qVoHfZ5VqprNFNZpP/xhRw6OPjjAOFfIe9Fvmo/j7?=
 =?us-ascii?Q?SkcwzqTsdzxMnxROfpqu+8kw/QiUlbKUlFzCChA+96hg2xJoBxnusgYdR5QS?=
 =?us-ascii?Q?RmKp8WzpanFXFtsfnNNCPcW7fIqchpQPTLrWaCiVfFSyMN706iMiUZ5O/N81?=
 =?us-ascii?Q?HV7wgyqe+xkH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6ce474-9d5d-47d3-eef6-08dbb63a341d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:22:10.3381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqYfMkgHojreD9Q4XNAPlsC2UrMtaSxTr+hK0yw8vColf8Hd1iMj/Y4ROnFqlYwuJvQR6ojKrhYi2Poqd8UqAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=887 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150201
X-Proofpoint-GUID: RGZlVui4P77FHejROOx7SY4rFLWoi7Jh
X-Proofpoint-ORIG-GUID: RGZlVui4P77FHejROOx7SY4rFLWoi7Jh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/15/23 15:15, Mike Kravetz wrote:
> The following series attempts to reduce amount of time spent in TLB flushing.
> The idea is to batch the vmemmap modification operations for multiple hugetlb
> pages.  Instead of doing one or two TLB flushes for each page, we do two TLB
> flushes for each batch of pages.  One flush after splitting pages mapped at
> the PMD level, and another after remapping vmemmap associated with all
> hugetlb pages.  Results of such batching are as follows:
> 
> Joao Martins (2):
>   hugetlb: batch PMD split for bulk vmemmap dedup
>   hugetlb: batch TLB flushes when freeing vmemmap
> 
> Johannes Weiner (1):
>   mm: page_alloc: remove pcppage migratetype caching fix
> 
> Matthew Wilcox (Oracle) (3):
>   hugetlb: Use a folio in free_hpage_workfn()
>   hugetlb: Remove a few calls to page_folio()
>   hugetlb: Convert remove_pool_huge_page() to
>     remove_pool_hugetlb_folio()
> 
> Mike Kravetz (6):
>   hugetlb: optimize update_and_free_pages_bulk to avoid lock cycles
>   hugetlb: restructure pool allocations
>   hugetlb: perform vmemmap optimization on a list of pages
>   hugetlb: perform vmemmap restoration on a list of pages
>   hugetlb: batch freeing of vmemmap pages
>   hugetlb: batch TLB flushes when restoring vmemmap
> 
>  mm/hugetlb.c         | 288 ++++++++++++++++++++++++++++++++-----------
>  mm/hugetlb_vmemmap.c | 255 ++++++++++++++++++++++++++++++++------
>  mm/hugetlb_vmemmap.h |  16 +++
>  mm/page_alloc.c      |   3 -
>  4 files changed, 452 insertions(+), 110 deletions(-)

Just realized that I should have based this on top of/taken into account
this series as well:
https://lore.kernel.org/linux-mm/20230913105401.519709-5-usama.arif@bytedance.com/

Sorry!
Changes should be minimal, but modifying the same code.
-- 
Mike Kravetz
