Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20BD7A5125
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjIRRlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjIRRlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:41:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A6D101
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:41:03 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IA3VuC007475;
        Mon, 18 Sep 2023 17:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=ZWJilvjdithd7ZbWEnMb+BrQcvM30rFtP5+yoD6VD14=;
 b=q9S0BCvWg3wChb9nA/uY4m93xM+bcr7swn7FrKQLhT4QThqbROrN96z4KXBe56fMoTGt
 PZIFizdK6KbGV9zyuOjwxMvHD8ovMiuLUjVFdIZmtkfmK49ItTMt0RwsMJGmx0WC+IbC
 41/IQLIV/owckPKGnM2qkLhfrgikgf+FssDlvHBGpX/dY9CPiWo6lOHcqVt3tEvqD/LC
 Ik+DZVALWr+FKV0igqZZmalHAwbuHRAG4Q7jxMK+EPU/+dMwNeen264qUNwVahPl/omt
 6qblL2+BYWJ9kmm5nqEnb80aOJN0TN/BrCRIlIaPgZLmtVDVfZ+Dloqe2TrnH/WaAjiM Sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t52sdu5ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 17:40:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38IHUfIK030862;
        Mon, 18 Sep 2023 17:40:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t4ktkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 17:40:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/wD4WbhsM6QjTr2J/AslIjwKFRMKi+S3VVT+ex8MXSe7uIqOKmxZK5ALhWk7En1B7b+Yx5DZU/cJ8QGbhCvj+1OE4rqbZnY/pOfy2h0UFESdjDos2pzilTyqoTMATq7cmfvWmcmis7YoCMbO3BBPOvYlx37b1EMRoIPsdJb+kMiQAl7mBNhqTAhoPtjwmR2pWTg49ORDaG3I+9uYb1SFFT/zYwDqPmF5VEFUMJ6OwBccVGYosrFq/La9uJff/Aj4jGaHFIeIvvpPJeDST0K8GUWdvFOpjofk5/uXSAIfNJBKqLNuGSPVh8yWU9rUi+LN2W0+daw4ggILKvi0TUOKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWJilvjdithd7ZbWEnMb+BrQcvM30rFtP5+yoD6VD14=;
 b=i6YluWTWL58+02pRvVL2M6ycF4RvD5bditzWEL/gqxzyp5Ug7TrF2Aa7m/MNkGhyZCKU98z/BJ7UnkVG3JlE9qzR+qYNb/9Wg64b3cgi2/Dt9eG49iFgkaL+YYgspOQNGR2SgxMqpdckCQqi9H5BO9nd4HMwQ8/WParhD4uK8aArn4+hV2otZIKwzx4rTI3g7A5jckY6AOyfOx10vq8n+vskY3QU3m1JqGR0BGWqypkjfIMchuFwdZd+HpacRzNXG9UK9ZgyfU/Kp9oaq6QkkreMH6cKSixu5w2ANkcwNB6g8u2R/bSUKh8hZpyQra4N2BT9Zy+uTLtKyJ1U3dmwQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWJilvjdithd7ZbWEnMb+BrQcvM30rFtP5+yoD6VD14=;
 b=ILSxcY4cm58oEKxluRTM+76xy1WY9M1420TuZiU/yuWSBDqQStFTDRX8XR5/X2lKyEE+gzNWJIDlICXhIQPWkvMkK2bTejShGMu8VQ7Z8tRSbn9iceV+pVje4Ih0kmnp4cy+BTa87eb0lkAJEEx53NRB5yaCCXqbuwi6z8sqQX8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN0PR10MB5933.namprd10.prod.outlook.com (2603:10b6:208:3cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 17:40:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 17:40:40 +0000
Date:   Mon, 18 Sep 2023 10:40:37 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Message-ID: <20230918174037.GA112714@monkey>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230914235238.GB129171@monkey>
 <20230915141610.GA104956@cmpxchg.org>
 <20230916195739.GB618858@monkey>
 <a88b7339-beab-37c6-7d32-0292b325916d@suse.cz>
 <20230918145204.GB16104@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918145204.GB16104@cmpxchg.org>
X-ClientProxiedBy: MW4PR04CA0235.namprd04.prod.outlook.com
 (2603:10b6:303:87::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MN0PR10MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: df68d30a-279f-49a8-148b-08dbb86e603e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2gxYakD6A8+dWIr8GNsKFcn2Rx8Kpc87Qp6F6egzeqt3TRnUx0BlvlhIG+EE7TYTnJcmN5CO+2+Bmn+GYWVdax84Dg9fbi1G1lii9ZcL0IpzFGYrYJNZumGIPZ5UQ6wD3X3MZTRogZI3mL8sSjiCjZ3oJjB0fS+AB/JEiRI5neKLL/l7wbKLEnIDjduP86Cy/IS3RbXXT0iRc36fkzEw7noJ3UGS5TGKZ3fY0I522oS/IqfmpgY4wk1HM8kZxPZo+JwPNnjsIbR7d8uE/CGRtPgxHiZJ9DkLdQZse/yNAy9gIBkQgt0kEtQWgIcfP3TZ+oHiiEGEpN6nDVQP2DFbKF+YYE5PRP4A4SCxpFOddjixZDRzOl1YICis3w5TivAoMRg4EB7B7ziB7ogYq4jpAz6jnZ9seI5uLnpw9bvXiLkK7MFaqO1T0cn62u7WN38/labKdhAFyTBE03yvSd+EBzDWrGXn9/wM9cl3FaD62TweNmIZk1qn6VvEEnt/njKmHTzfnAttxSPbGXu4Qf+QP5xT2XsJRVbnZ8mRMp8textJn2+ShlpYtMaE3MaZIcJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199024)(186009)(1800799009)(6486002)(44832011)(5660300002)(6506007)(53546011)(86362001)(6512007)(54906003)(316002)(9686003)(66946007)(66556008)(41300700001)(38100700002)(66476007)(6666004)(478600001)(6916009)(8936002)(8676002)(26005)(33656002)(2906002)(33716001)(30864003)(4326008)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VqEel8EfKvNmTg60lfnGdOD9j5KT0jmAdcWiZEfU9K4n0O73h3x5CQMdEbjd?=
 =?us-ascii?Q?in3xLIgi/w+/54Rhz6JEYZyhQCA94zlEovGnlRcdlstFp0DaUzWnDmN//iPD?=
 =?us-ascii?Q?JCh4KsTKUUdTJDexbcHFn22kDwnxUpHSZgu1o921ZZJ9IpwBUOhoNZxGJpJj?=
 =?us-ascii?Q?uwDsjhI3jMSdZnyRBh+Sb3U4Ymlji6zTTaGKfluwBQ4rb3jYfWlAmG86KEVJ?=
 =?us-ascii?Q?zTT0Vw6yqDgu9+oCSzsa3AMw6ZM0wTx8rR9tx5fmklbf2oXr+ZgFpTPvSU5D?=
 =?us-ascii?Q?v8qiywE6w/oaLT3jebPa0RZlxOFTjohdSe8EPTjlgUkRPyBVogZboOk56hVG?=
 =?us-ascii?Q?3UFl7vGYSokNhj66/ZJLInRN+Mzjjo6p3qcrELaRZpRlQGjlWzLRQhzwCfe+?=
 =?us-ascii?Q?Fo+ze8Me6IGMlSMY3aIk2ru32H1UlzsGkcmrWhuqxwudSPNi1lAqz5LDdvr9?=
 =?us-ascii?Q?V6Px8t9+AOQ4KxFhcYNup+n32/16IPK2OSX1ohyq4rvkmYAifY0agHlI5K7O?=
 =?us-ascii?Q?JNfPkpt6XgqTHgseoehK86zLzJUffB8lIvTN2ytu5YA7/wt14wfiYhPPBmdJ?=
 =?us-ascii?Q?7pwWNtShZTpCIpxBpIRgYUQadyyolq6+D8P8gQCGASwj2eLzv1sKLMqqGt5C?=
 =?us-ascii?Q?QoANgav2CnjLVMiVgWMA7SkT4gOKWT9awfsiT92gU2oVDG7KtETl4Tc7vk/Y?=
 =?us-ascii?Q?izAcfIEAYxuPx1EXmZfxxw1RI3oQa9kWHtJ+zaaDEdSLh3Q7p5hKyTK34YGn?=
 =?us-ascii?Q?ZnGe7yGwPLI0gOzrSMGy59YhOIwhL8WnrD6HZvvp1MuqfkkvGGJ4vJnME2bn?=
 =?us-ascii?Q?DASWJv9J33oZHpTPpURcLNObc6l4xe5dTKufDHSD3ZLzhyc2s+poXU61lszE?=
 =?us-ascii?Q?PyP2xjFeJKSJIV4TvsfO1PuSJaLNxY8/vfVRHZaGkNZn3d9kWj6R/La2zFSS?=
 =?us-ascii?Q?htRYPSsN4CX/MVidostq/p5ib2W2zwgi1CiziEewGfajiEZYGf9ZZuRKRQes?=
 =?us-ascii?Q?l+cdo5064dUD8pEjtO7ODN/4/WHpvOKHPdD75rftu1X0Mpb6IJz7qy325J/u?=
 =?us-ascii?Q?g7PI7r2gyQw4MOvCGU9RgVJJHVJDVUhTKvpx5+Btuj12IW+L6Duhkaak50Sf?=
 =?us-ascii?Q?pEBDQLkwqJxc7VrFCLhZNmt4bFKx26H1/+KPY6kEEvuhE4wZGIAPY8qxY3Vf?=
 =?us-ascii?Q?zn/ZrOGQS31q6hbV8WgTeGQz07b0TTttJZ94ahuajc1Aig9IbgLOCSMKFVcU?=
 =?us-ascii?Q?n3cyvSwMtivsnUtReOVBwFvQGHPY54T/kGYsUVaKiyT8P32cNc2Wshe1/RvE?=
 =?us-ascii?Q?qu9T5S0Y64Uh8BWI3Dmnk95LBHG73tiSeetxGWTMtUuMQEVdKErlffW94RwK?=
 =?us-ascii?Q?yPGvliMw6+vFNGnVhnULqq8kEIupg5g16s7p5lwRRzVvTn5805NG9TvALXpp?=
 =?us-ascii?Q?bkbyKrIDPrWj8J83p0WUJiuFzptm47nvDCKCKfXzxx9PM7bp59ROo/LF9nv8?=
 =?us-ascii?Q?0Q7iLXAj6R4tgw5UPV5/OJ7KYz9xb+jP413glBbFnHF4RD9g5XigFbSFh+Jg?=
 =?us-ascii?Q?LMFmJovOATizBEQ2CSYah5hxo8hOZQKvXgWwwckv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?c0R4s8Ou6vR6lS6jyIRmZyVsVJZmVaMZSzjXliHXkgWopOMFn6H7ZL2wNmO/?=
 =?us-ascii?Q?/lk07beIg+5MDFq/EJnNoYrxOQBhu5a6+SgoEAXJp6ZdC1m+s/2AwoZLlBZ2?=
 =?us-ascii?Q?eu5H8WgUsqlZQpeKlSBijGZb0R/xbQT7wQ5bIA4w9zCHwC7J1qStCRf8/tGq?=
 =?us-ascii?Q?5nGJ+BugAfuspQu5prlR2admmnsioDodUSScVJM8eM0K4Z1OQ7cGBQve2+hv?=
 =?us-ascii?Q?kVoa1A3INV/7aGKHVDrrseJZ9UwulXIjs8F40PY3rBpnvfB8BtanmI4AwzOH?=
 =?us-ascii?Q?7gHYqlBeqKDA1MC0NZE/Wmckc2vq7EMiOTx37Pd5DWYq5RHH/NDUrRtx6XZo?=
 =?us-ascii?Q?dKbvOw5ia+/C/lJv/4MY1vIMaUfJKfsvD54DGvbEyMmGqQL8uG5rRo9BkfFP?=
 =?us-ascii?Q?aQCVl3hIpDvgA4IVN7SUlO2prfH2bqqe1AqpCRlpL820PdczxVHHC00sm3hF?=
 =?us-ascii?Q?0oRCBD4Mj08046mSHIUetcgDQx5/edN9IpQDYSLh1IScxMUnlknHzcfL7JaI?=
 =?us-ascii?Q?+v5riVIMArxwzIjtCwxG4amIJFL+aSjiCn/kqlQ/Y+arWeya/kkGlIHPTPW+?=
 =?us-ascii?Q?MvZIRd5SrX/fCnwrJjnjiRJ8Y8Sdwu1c+zjopyBjHWNxVfEOCp62c1C2WdUp?=
 =?us-ascii?Q?jffwE8ysTWGs4GCDdpjqtLdfYDGHU3sr6oIO7nD1QePubQP00n5ntYg/qmv9?=
 =?us-ascii?Q?D23RpygEmiNWTgdU4CoHkxjX9w3gkPygiCIdwu//PFAU+0NUNRvZgoynCSup?=
 =?us-ascii?Q?jM+Vf04elZW5b6U333TrsRKW8wC1NWf3pFv3gI9Az+d9Q3IAPgo9rjjU+wL2?=
 =?us-ascii?Q?wTXLBbLsKsKboiDz+es9e21nzyGyGNI8KZ3qfVRLFXRsuO5YI2B5qvTg6Izl?=
 =?us-ascii?Q?BFJtJKWGz7SXltP69Ci2oz2jXOYHxFpF5fKMWVjdyU6FnY6ErMQ8CFARzk58?=
 =?us-ascii?Q?qVTRzyeUO9j6Pr01+kANmUAkqTgPcwGa3bvAbStfg+7hLbeAej3Vf8OA/WV3?=
 =?us-ascii?Q?j/7R?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df68d30a-279f-49a8-148b-08dbb86e603e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 17:40:40.7818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6BlsxWr1EyiPja4Bdq/LpLOZ8DKypq7YqzGzYcY/kw+QDPC9x5QuY5ziSeojioyYSzafPyIsAMrnWjqFSJpLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5933
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_08,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309180156
X-Proofpoint-GUID: TZgJAvLeaBW3O5O9a_wEqFiWz-Iu3MWE
X-Proofpoint-ORIG-GUID: TZgJAvLeaBW3O5O9a_wEqFiWz-Iu3MWE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/23 10:52, Johannes Weiner wrote:
> On Mon, Sep 18, 2023 at 09:16:58AM +0200, Vlastimil Babka wrote:
> > On 9/16/23 21:57, Mike Kravetz wrote:
> > > On 09/15/23 10:16, Johannes Weiner wrote:
> > >> On Thu, Sep 14, 2023 at 04:52:38PM -0700, Mike Kravetz wrote:
> > > 
> > > With the patch below applied, a slightly different workload triggers the
> > > following warnings.  It seems related, and appears to go away when
> > > reverting the series.
> > > 
> > > [  331.595382] ------------[ cut here ]------------
> > > [  331.596665] page type is 5, passed migratetype is 1 (nr=512)
> > > [  331.598121] WARNING: CPU: 2 PID: 935 at mm/page_alloc.c:662 expand+0x1c9/0x200
> > 
> > Initially I thought this demonstrates the possible race I was suggesting in
> > reply to 6/6. But, assuming you have CONFIG_CMA, page type 5 is cma and we
> > are trying to get a MOVABLE page from a CMA page block, which is something
> > that's normally done and the pageblock stays CMA. So yeah if the warnings
> > are to stay, they need to handle this case. Maybe the same can happen with
> > HIGHATOMIC blocks?
> 
> Hm I don't think that's quite it.
> 
> CMA and HIGHATOMIC have their own freelists. When MOVABLE requests dip
> into CMA and HIGHATOMIC, we explicitly pass that migratetype to
> __rmqueue_smallest(). This takes a chunk of e.g. CMA, expands the
> remainder to the CMA freelist, then returns the page. While you get a
> different mt than requested, the freelist typing should be consistent.
> 
> In this splat, the migratetype passed to __rmqueue_smallest() is
> MOVABLE. There is no preceding warning from del_page_from_freelist()
> (Mike, correct me if I'm wrong), so we got a confirmed MOVABLE
> order-10 block from the MOVABLE list. So far so good. However, when we
> expand() the order-9 tail of this block to the MOVABLE list, it warns
> that its pageblock type is CMA.
> 
> This means we have an order-10 page where one half is MOVABLE and the
> other is CMA.
> 
> I don't see how the merging code in __free_one_page() could have done
> that. The CMA buddy would have failed the migrate_is_mergeable() test
> and we should have left it at order-9s.
> 
> I also don't see how the CMA setup could have done this because
> MIGRATE_CMA is set on the range before the pages are fed to the buddy.
> 
> Mike, could you describe the workload that is triggering this?

This 'slightly different workload' is actually a slightly different
environment.  Sorry for mis-speaking!  The slight difference is that this
environment does not use the 'alloc hugetlb gigantic pages from CMA'
(hugetlb_cma) feature that triggered the previous issue.

This is still on a 16G VM.  Kernel command line here is:
"BOOT_IMAGE=(hd0,msdos1)/vmlinuz-6.6.0-rc1-next-20230913+
root=UUID=49c13301-2555-44dc-847b-caabe1d62bdf ro console=tty0
console=ttyS0,115200 audit=0 selinux=0 transparent_hugepage=always
hugetlb_free_vmemmap=on"

The workload is just running this script:
while true; do
 echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
 echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/demote
 echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
done

> 
> Does this reproduce instantly and reliably?
> 

It is not 'instant' but will reproduce fairly reliably within a minute
or so.

Note that the 'echo 4 > .../hugepages-1048576kB/nr_hugepages' is going
to end up calling alloc_contig_pages -> alloc_contig_range.  Those pages
will eventually be freed via __free_pages(folio, 9).

> Is there high load on the system, or is it requesting the huge page
> with not much else going on?

Only the script was running.

> Do you see compact_* history in /proc/vmstat after this triggers?

As one might expect, compact_isolated continually increases during this
this run.

> Could you please also provide /proc/zoneinfo, /proc/pagetypeinfo and
> the hugetlb_cma= parameter you're using?

As mentioned above, hugetlb_cma is not used in this environment.  Strangely
enough, this does not reproduce (easily at least) if I use hugetlb_cma as
in the previous report.

The following are during a run after WARNING is triggered.

# cat /proc/zoneinfo
Node 0, zone      DMA
  per-node stats
      nr_inactive_anon 11800
      nr_active_anon 109
      nr_inactive_file 38161
      nr_active_file 10007
      nr_unevictable 12
      nr_slab_reclaimable 2766
      nr_slab_unreclaimable 6881
      nr_isolated_anon 0
      nr_isolated_file 0
      workingset_nodes 0
      workingset_refault_anon 0
      workingset_refault_file 0
      workingset_activate_anon 0
      workingset_activate_file 0
      workingset_restore_anon 0
      workingset_restore_file 0
      workingset_nodereclaim 0
      nr_anon_pages 11750
      nr_mapped    18402
      nr_file_pages 48339
      nr_dirty     0
      nr_writeback 0
      nr_writeback_temp 0
      nr_shmem     166
      nr_shmem_hugepages 0
      nr_shmem_pmdmapped 0
      nr_file_hugepages 0
      nr_file_pmdmapped 0
      nr_anon_transparent_hugepages 6
      nr_vmscan_write 0
      nr_vmscan_immediate_reclaim 0
      nr_dirtied   14766
      nr_written   7701
      nr_throttled_written 0
      nr_kernel_misc_reclaimable 0
      nr_foll_pin_acquired 96
      nr_foll_pin_released 96
      nr_kernel_stack 1816
      nr_page_table_pages 1100
      nr_sec_page_table_pages 0
      nr_swapcached 0
  pages free     3840
        boost    0
        min      21
        low      26
        high     31
        spanned  4095
        present  3998
        managed  3840
        cma      0
        protection: (0, 1908, 7923, 7923)
      nr_free_pages 3840
      nr_zone_inactive_anon 0
      nr_zone_active_anon 0
      nr_zone_inactive_file 0
      nr_zone_active_file 0
      nr_zone_unevictable 0
      nr_zone_write_pending 0
      nr_mlock     0
      nr_bounce    0
      nr_zspages   0
      nr_free_cma  0
      numa_hit     0
      numa_miss    0
      numa_foreign 0
      numa_interleave 0
      numa_local   0
      numa_other   0
  pagesets
    cpu: 0
              count: 0
              high:  13
              batch: 1
  vm stats threshold: 6
    cpu: 1
              count: 0
              high:  13
              batch: 1
  vm stats threshold: 6
    cpu: 2
              count: 0
              high:  13
              batch: 1
  vm stats threshold: 6
    cpu: 3
              count: 0
              high:  13
              batch: 1
  vm stats threshold: 6
  node_unreclaimable:  0
  start_pfn:           1
Node 0, zone    DMA32
  pages free     495317
        boost    0
        min      2687
        low      3358
        high     4029
        spanned  1044480
        present  520156
        managed  496486
        cma      0
        protection: (0, 0, 6015, 6015)
      nr_free_pages 495317
      nr_zone_inactive_anon 0
      nr_zone_active_anon 0
      nr_zone_inactive_file 0
      nr_zone_active_file 0
      nr_zone_unevictable 0
      nr_zone_write_pending 0
      nr_mlock     0
      nr_bounce    0
      nr_zspages   0
      nr_free_cma  0
      numa_hit     0
      numa_miss    0
      numa_foreign 0
      numa_interleave 0
      numa_local   0
      numa_other   0
  pagesets
    cpu: 0
              count: 913
              high:  1679
              batch: 63
  vm stats threshold: 30
    cpu: 1
              count: 0
              high:  1679
              batch: 63
  vm stats threshold: 30
    cpu: 2
              count: 0
              high:  1679
              batch: 63
  vm stats threshold: 30
    cpu: 3
              count: 256
              high:  1679
              batch: 63
  vm stats threshold: 30
  node_unreclaimable:  0
  start_pfn:           4096
Node 0, zone   Normal
  pages free     1360836
        boost    0
        min      8473
        low      10591
        high     12709
        spanned  1572864
        present  1572864
        managed  1552266
        cma      0
        protection: (0, 0, 0, 0)
      nr_free_pages 1360836
      nr_zone_inactive_anon 11800
      nr_zone_active_anon 109
      nr_zone_inactive_file 38161
      nr_zone_active_file 10007
      nr_zone_unevictable 12
      nr_zone_write_pending 0
      nr_mlock     12
      nr_bounce    0
      nr_zspages   3
      nr_free_cma  0
      numa_hit     10623572
      numa_miss    0
      numa_foreign 0
      numa_interleave 1357
      numa_local   6902986
      numa_other   3720586
  pagesets
    cpu: 0
              count: 156
              high:  5295
              batch: 63
  vm stats threshold: 42
    cpu: 1
              count: 210
              high:  5295
              batch: 63
  vm stats threshold: 42
    cpu: 2
              count: 4956
              high:  5295
              batch: 63
  vm stats threshold: 42
    cpu: 3
              count: 1
              high:  5295
              batch: 63
  vm stats threshold: 42
  node_unreclaimable:  0
  start_pfn:           1048576
Node 0, zone  Movable
  pages free     0
        boost    0
        min      32
        low      32
        high     32
        spanned  0
        present  0
        managed  0
        cma      0
        protection: (0, 0, 0, 0)
Node 1, zone      DMA
  pages free     0
        boost    0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
        cma      0
        protection: (0, 0, 0, 0)
Node 1, zone    DMA32
  pages free     0
        boost    0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
        cma      0
        protection: (0, 0, 0, 0)
Node 1, zone   Normal
  per-node stats
      nr_inactive_anon 15381
      nr_active_anon 81
      nr_inactive_file 66550
      nr_active_file 25965
      nr_unevictable 421
      nr_slab_reclaimable 4069
      nr_slab_unreclaimable 7836
      nr_isolated_anon 0
      nr_isolated_file 0
      workingset_nodes 0
      workingset_refault_anon 0
      workingset_refault_file 0
      workingset_activate_anon 0
      workingset_activate_file 0
      workingset_restore_anon 0
      workingset_restore_file 0
      workingset_nodereclaim 0
      nr_anon_pages 15420
      nr_mapped    24331
      nr_file_pages 92978
      nr_dirty     0
      nr_writeback 0
      nr_writeback_temp 0
      nr_shmem     100
      nr_shmem_hugepages 0
      nr_shmem_pmdmapped 0
      nr_file_hugepages 0
      nr_file_pmdmapped 0
      nr_anon_transparent_hugepages 11
      nr_vmscan_write 0
      nr_vmscan_immediate_reclaim 0
      nr_dirtied   6217
      nr_written   2902
      nr_throttled_written 0
      nr_kernel_misc_reclaimable 0
      nr_foll_pin_acquired 0
      nr_foll_pin_released 0
      nr_kernel_stack 1656
      nr_page_table_pages 756
      nr_sec_page_table_pages 0
      nr_swapcached 0
  pages free     1829073
        boost    0
        min      11345
        low      14181
        high     17017
        spanned  2097152
        present  2097152
        managed  2086594
        cma      0
        protection: (0, 0, 0, 0)
      nr_free_pages 1829073
      nr_zone_inactive_anon 15381
      nr_zone_active_anon 81
      nr_zone_inactive_file 66550
      nr_zone_active_file 25965
      nr_zone_unevictable 421
      nr_zone_write_pending 0
      nr_mlock     421
      nr_bounce    0
      nr_zspages   0
      nr_free_cma  0
      numa_hit     10522401
      numa_miss    0
      numa_foreign 0
      numa_interleave 961
      numa_local   4057399
      numa_other   6465002
  pagesets
    cpu: 0
              count: 0
              high:  7090
              batch: 63
  vm stats threshold: 42
    cpu: 1
              count: 17
              high:  7090
              batch: 63
  vm stats threshold: 42
    cpu: 2
              count: 6997
              high:  7090
              batch: 63
  vm stats threshold: 42
    cpu: 3
              count: 0
              high:  7090
              batch: 63
  vm stats threshold: 42
  node_unreclaimable:  0
  start_pfn:           2621440
Node 1, zone  Movable
  pages free     0
        boost    0
        min      32
        low      32
        high     32
        spanned  0
        present  0
        managed  0
        cma      0
        protection: (0, 0, 0, 0)

# cat /proc/pagetypeinfo
Page block order: 9
Pages per block:  512

Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10 
Node    0, zone      DMA, type    Unmovable      0      0      0      0      0      0      0      0      1      0      0 
Node    0, zone      DMA, type      Movable      0      0      0      0      0      0      0      0      0      1      3 
Node    0, zone      DMA, type  Reclaimable      0      0      0      0      0      0      0      0      0      0      0 
Node    0, zone      DMA, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0 
Node    0, zone      DMA, type          CMA      0      0      0      0      0      0      0      0      0      0      0 
Node    0, zone      DMA, type      Isolate      0      0      0      0      0      0      0      0      0      0      0 
Node    0, zone    DMA32, type    Unmovable      0      0      0      0      0      0      0      0      0      0      0 
Node    0, zone    DMA32, type      Movable      1      0      1      2      2      3      3      3      4      4    480 
Node    0, zone    DMA32, type  Reclaimable      0      0      0      0      0      0      0      0      0      0      0 
Node    0, zone    DMA32, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0 
Node    0, zone    DMA32, type          CMA      0      0      0      0      0      0      0      0      0      0      0 
Node    0, zone    DMA32, type      Isolate      0      0      0      0      0      0      0      0      0      0      0 
Node    0, zone   Normal, type    Unmovable    566     14     22      7      8      8      9      4      7      0      1 
Node    0, zone   Normal, type      Movable    214    299    120     53     15     10      6      6      1      4   1159 
Node    0, zone   Normal, type  Reclaimable      0      9     18     11      6      1      0      0      0      0      0 
Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0 
Node    0, zone   Normal, type          CMA      0      0      0      0      0      0      0      0      0      0      0 
Node    0, zone   Normal, type      Isolate      0      0      0      0      0      0      0      0      0      0      0 

Number of blocks type     Unmovable      Movable  Reclaimable   HighAtomic          CMA      Isolate 
Node 0, zone      DMA            1            7            0            0            0            0 
Node 0, zone    DMA32            0         1016            0            0            0            0 
Node 0, zone   Normal           71         2995            6            0            0            0 
Page block order: 9
Pages per block:  512

Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10 
Node    1, zone   Normal, type    Unmovable    459     12      5      6      6      5      5      5      6      2      1 
Node    1, zone   Normal, type      Movable   1287    502    171     85     34     14     13      8      2      5   1861 
Node    1, zone   Normal, type  Reclaimable      1      5     12      6      9      3      1      1      0      1      0 
Node    1, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0 
Node    1, zone   Normal, type          CMA      0      0      0      0      0      0      0      0      0      0      0 
Node    1, zone   Normal, type      Isolate      0      0      0      0      0      0      0      0      0      0      3 

Number of blocks type     Unmovable      Movable  Reclaimable   HighAtomic          CMA      Isolate 
Node 1, zone   Normal          101         3977           10            0            0            8 

-- 
Mike Kravetz
