Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAE37AE032
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 22:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjIYUHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 16:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYUHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 16:07:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F3710C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 13:07:36 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PIJj1Z022044;
        Mon, 25 Sep 2023 20:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=IR+DzdDGO25+pwmclLTQyPo/I241ntgfcqlYlkgKxE8=;
 b=L+qVnIiUDzV6Wk6V2E3OjPeCkiyYO+7/NmIewTw8I0QUm8jc05GteP4X7zVRieoYuqij
 0H8ImZEqeiA+kiYhaEgBCRt1B8LHqpet2sIR52EU326aXRjx6OgwXMz7GDT9VTaLquw0
 F1oJPcSFzeEuQreKGQAt2muR6Gn91DYRS48oWI0LGRjyYg+K79xcnPHTJi2DtmshiLZg
 HHa33yfs1eppBVpB0BoYUC1QpplAV5z/t830NDjKeyuOtOuvskQz3lFNqyPf1No+JnSC
 102OUYqdz3XJ3/0z9EBCHomyFsnNrtLikq0bXAv8B4Z1RUI/JGmbKiUd0BTsZM0zyNYw mA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbcr8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 20:07:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PJoEVw017958;
        Mon, 25 Sep 2023 20:07:06 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfb2rfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 20:07:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPwTBejPK+Ds4H9PD6equmLqXMpw37TAUdJxAZ16jdDH/Se0POj4BcSZH3BQAlLFfRpsslfOzhV+uL4cG25XPnzLIMq6T41CIh7W/WpuugvqRdEwqw/LqZid3QUjiOPLhIHznfguHX+I4Uqek76QXVx3jJV3pjaRcCTcM4mbjj+zTsJ7Ar/K1cYGeUbCzaGODyo2yEZmUAX5k8ovCLaONN+EIk+IwjX84nHz6G1HSkZOg1TpXdNpBD8eT0MzF3x2gRK7bPuivp+miwWgBWqazjZZKKIVNOLNS87J36ihQDTNbNO8TB9Srd7RD4X9nuE88uYvCOj85Vkspcv/ojGjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IR+DzdDGO25+pwmclLTQyPo/I241ntgfcqlYlkgKxE8=;
 b=BhL9dY5h91PRFDgk9DaAgIGEdPKCHOUpDGUoh9zX/1EGb5uN2wXAeDo8muTSRGlEHdAvDZOQF6HVP/ywrPkD5ifLdgdwszaRg0aV+yzhp2WGdTwhaIIzszCxAcxka75wdbKBy6l2rcMYtQbO2pChzf+mT68gZqfx1OVh1wqo8a5PahlEJOCQ8TWgLNLdB0DgIRc8B4mZ4lDSM+RacNKJFVge2nk5GaWr4ThkV3J4MnkbwXJWfJ9/ZvzfBYto9nHUwLoy6sBXxOUHD7/rebgncU+jlfl6REoB285Jlh9XYXoAZCP5XFv6g0dpjl20cLBrtA5nTdcQ7pIeXq0pCuX8QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IR+DzdDGO25+pwmclLTQyPo/I241ntgfcqlYlkgKxE8=;
 b=M4fbSDmAlK0ceFGEmAA5w/jn350rBuvAZNaa+PyxXl+/70SBRHaPPd1gm6Ebz/Ow6jl1CCE0A9wH6nO9rfZ2Uu8ilrKAElbAx6556xkZMxIh6dEzmoyDgJ6lsJjVvgsJLXTcqS6j408ly4YZ0GfFX7cjbw4NN5fPbj9ukDuTfC4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB5270.namprd10.prod.outlook.com (2603:10b6:408:120::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 20:07:03 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 20:07:02 +0000
Date:   Mon, 25 Sep 2023 13:06:59 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com, willy@infradead.org
Subject: Re: [PATCH 3/3] hugetlbfs: replace hugetlb_vma_lock with
 invalidate_lock
Message-ID: <20230925200659.GB11309@monkey>
References: <20230922190552.3963067-4-riel@surriel.com>
 <202309250923.NEPT0ip2-lkp@intel.com>
 <692fafae9842a9b15b7b4a033bb7dc800784d4aa.camel@surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <692fafae9842a9b15b7b4a033bb7dc800784d4aa.camel@surriel.com>
X-ClientProxiedBy: MW4PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:303:b4::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BN0PR10MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: f124a85c-9caa-4262-4df1-08dbbe02fb93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oxBakYcCmGysXT7iODiiCJPLdeik4iRfDJXb+zAUmTzpmcn0Bn9PAX8ZbE9AEZmdHA9q70z/B8pV3+00qbEXXNjp9p+Pwj4o+53bB2m47yqQawovepLwrg/cOuB7AovSnFJnijGXbeNiQyhWpEkFWanQIpPhHgSh8AzjLN70c6pwc/c0dMdFPbqfcm7zBm+1q8lNeB+FphZa5HxuETKvUynGUC9cRfXddH047db8qDonigvkqL0cbOlnJRj1fkGgZ9p/b8+jDADsRC3lrE/pVZb7CbzSTiAT1KaUe88y9rX0syb0W4owlwUHJjQHH2WvZWm1twQhzRIuk4zhnrkMtWyUPP9Fc3yeXHEi8AHrKQ4Bpkcc45m/22AZrdsHUnyuUCVB276YReF+fP58P2u5HjtTUFQuHob7KLDYwrxTWUSBIw6MYu8eu9GrWGzDMx5b+doP0C3E5xRGNcdAXJZdXklWhq2Dyr+dPX29F/8xvdDMOwaL4ibqk8uFN66NL4rjpVAaNneBf1pHhGSdvyL6JbxEBMsMsGHkWLxfWthzOF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(346002)(136003)(396003)(366004)(230922051799003)(186009)(1800799009)(451199024)(1076003)(6666004)(478600001)(26005)(966005)(6486002)(83380400001)(86362001)(33716001)(38100700002)(33656002)(5660300002)(53546011)(6506007)(6512007)(9686003)(2906002)(66556008)(66476007)(66946007)(6916009)(316002)(7416002)(41300700001)(8676002)(8936002)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CsnfXNoM895IsMbvfrNpUfXPnV8yCH0KS6/GlT2bpPdCWlNLOpTPr7BxIQFC?=
 =?us-ascii?Q?/vpI1MAA+Oc4Ivlb03EUMeWSg4G/p7D1vg27zYbWlo6E5VBgxCIhzQAJ73hE?=
 =?us-ascii?Q?sbNYM8kvDRQyPENk6xQqrIex02HGapZF6PmGcyGG3Oj9vmaQgd/8W+4cWXNo?=
 =?us-ascii?Q?CeOqSXjmaEFEWQX4Ltyn5cHsmqSFGUR4wyh6D+bPOcW1Are6I/pyuxzF/BXv?=
 =?us-ascii?Q?2Pm/FFC+N5hpCA6lTcgfZxm+toXpcdNV+ThlWQl2lWiFNqacLigAvX0YINFd?=
 =?us-ascii?Q?zNLMt4HIsXAiKsmETgWSe2cX8RlqkhhNi2fTK8Jsz6aw65siH76umz2C+mdv?=
 =?us-ascii?Q?7UzC/nZ9mKmitPnR9NAzRUQKdt4vnVzf/2xoqXMwEqdLdU5eN3PlVjPSlMDD?=
 =?us-ascii?Q?+jiroKxCO1QWNHcIuEiKEnQNHegwfnolf8gNMBMU9k8w/tab6xZsTSXTjUKY?=
 =?us-ascii?Q?jutD105xcW8ixv+OwUpKB5UB21eooFhpa5AV5Yq3EaUbefBJZP4x7tbItCqD?=
 =?us-ascii?Q?nMS8GPXYk5MGyn8Di8lgvQkobzwe6Frv0q6P4RKLGdAhu4FOeqeWQk06jdlE?=
 =?us-ascii?Q?k/gycBb7yQUgj56lfTaojVLYLB1xWEuvRVDS09RqAf286m/3O29OCDNyvFwg?=
 =?us-ascii?Q?Fh8qbBfH8mTa9LvkSjNx790oaJP3G2Biqk9+SfGJpnyeqJYXuHjjwZW8MXgh?=
 =?us-ascii?Q?1hSre6wrlCcAZGduNRHP3g9LIewBM/pbJ8sqE1lLfjjrrVw2k1ZamurJwNsn?=
 =?us-ascii?Q?ALbz+5Xxy2uJ8e76hvjr1+osFNMT2y+iyv+t1+qLeq8AZnLedOGnETQL+ZhV?=
 =?us-ascii?Q?2Tgk0s71jRQOlfiiXonSw+fZojaIUgmEU9lQkV8apoFWuxwCUgji/2gOhhBU?=
 =?us-ascii?Q?NYTHuZKDCT9KJVj/VW5/p7r4dewX3V9/Di/xVbq25//IIepd8C3kh/Dd7h4p?=
 =?us-ascii?Q?UJysRx3/CbvddfKX1PCoJDHlnpKJtnmyz5ByOIWLuYQEZuCDyFqGaPX/vqDY?=
 =?us-ascii?Q?SOKpWWt+PNbkwznzpImpIiewRYJYxZj5gDUk5mGOcpSxorqHW3R2n2Xo7hbu?=
 =?us-ascii?Q?LMGKPkMItRAQEpQ52vblVYxDRiRuUUm4rxcSaEyfCWxKOZY2Bri61hyDGHEH?=
 =?us-ascii?Q?OU2kaYn2lENS1F2SLR62BJP+/mTdgf+1dEnzX3zlh3J7/kE0ugn/EkABaD7n?=
 =?us-ascii?Q?IBNdYdG0DQWhcVSIKCkcCw+RnJfN/TJbDd9Uc8y1sgYlyu1iijzRYgjPo1Ds?=
 =?us-ascii?Q?705I/iqnX20TsIIfATfGzRseHD6HtIdpA1XZhBaPI4b01xl9B71py9WlqpYr?=
 =?us-ascii?Q?Wy/1XbJTwUvSIiP8XLhOl/kouyj9D0BBxLon31cdOQynwZ5+w1svpGlXUj4+?=
 =?us-ascii?Q?yPlqMFEE0KVxIwP4LxqSLVP/VEEB4ygOPHSbLC30zwpA3MF5q8RuVgef7eba?=
 =?us-ascii?Q?6qTM0P/43LnIymPQK3NhfICI9kYme77AybAPgZH49azsrlyrjNLW9GAzYHb1?=
 =?us-ascii?Q?uf6DYQXyi6y09oGZunXoDw2mhb+BP6+K2N+d/OY+jDqLwE3jzHj+Bn/tbjlr?=
 =?us-ascii?Q?LATC4SjW2GcqNnABRYr6S2I63Bx6COwPOj/kyA8C9drocY8K8vRP4+ZFJq46?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?NHjY9XHvu860dlwmnOYlRoaB+lMuhFndZcRIOZWM0j1Fme+RA9RXKc7eUWdw?=
 =?us-ascii?Q?747yA/Yln56OTf5db9yzlNkQIL63zlvovTz/Asi7vyzNKBETJEgc20PVFQOs?=
 =?us-ascii?Q?ZkDo5DbGOTpdFNc/lR6LAPXpeSd1APXB2kkSHbZcAdCDlPM9AYI+n6EdcGpv?=
 =?us-ascii?Q?JIlseJ2rCkp77C9mTErMX3ZOxF1K9zQ0Sk1ebbTRN8KZVroKNiR/kyI2Cljv?=
 =?us-ascii?Q?EU+EKMcV0mSFwkreL7OH3BlMGwHmUTbuP0c7ylzwrZJ6cr3MwOgpZKLL+eSW?=
 =?us-ascii?Q?BTbYuPsKVTFjiJ5LaZAkEx9STkehlBBdn7w8MerMflG6Spf04pbKTGiQpzoO?=
 =?us-ascii?Q?WKBV8XSZo00zY0Wsr+HUIugPP0BM2YqIrkjeTFmEWRlitl23hY5ambmC/bQI?=
 =?us-ascii?Q?nRClfE8Df2VvP92UQVW51tthKZsDzyZoavt/jsI7K54vZOrJcLDuNeVV3+jC?=
 =?us-ascii?Q?xR2eNPmpelva+1La5WTEHAnvr9GJGYGw4tqGm7QtIvCiu91lAqqdfUzjZdMD?=
 =?us-ascii?Q?nhEGA/nMnQlA1jlqaIZMjAeSPxCEB98u2WCuUKcRYjs11ruHyaf+0H6odTZS?=
 =?us-ascii?Q?FQH5kOcuLOVJRGTnyVMhK2cpIZy3hAhlWt9WnlCZdc2p6GMw6mtKenhEBwW4?=
 =?us-ascii?Q?/aBzn/6BOwtfa+XsJCe0QOApVI1e5cC/QHNhFHDOpwnJbRe+78yoa+sz3/t8?=
 =?us-ascii?Q?M4Q+Q0TfZb0xSK74tzX6LFsYvIGcIJzW3so1yp1DiaZr7UKLU2hMfLvn90Ao?=
 =?us-ascii?Q?kw8jzs8nMX/c1pPnpOkVlZSw5n59H7tn97hJZQ1AYyFI+sxEJQTWTcXHzdd8?=
 =?us-ascii?Q?gXwd01NFcAZEd4qP5oZfBILJC+m7UIVvfhlzh2FN29KtHF1USRPdhPW8k8Fw?=
 =?us-ascii?Q?Jh0dEM36a8dlRSc+SETyxWJRfCuBja9cL1oaikiuMu83gpwVgp15miolEsr9?=
 =?us-ascii?Q?DCPvgM2lzVHjHr+BCGZp20/SGnvl5S766rdtzXlNdfIMO+wsRduVQr4k2KNH?=
 =?us-ascii?Q?9mAuteJzfdOe5QVrz68TQH34zg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f124a85c-9caa-4262-4df1-08dbbe02fb93
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 20:07:02.4863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrD3yZA97LnrBGNG3aBGM69d3yRoaB1D0Fr1xvGRiQbTZ6yGaG9GKOlxUILbsFGHASSlNCzrE8qB2jy9LflBRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5270
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_17,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=668 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250154
X-Proofpoint-GUID: YgLd57S5L2mTbRiWpVsSd3ydELhUbQTy
X-Proofpoint-ORIG-GUID: YgLd57S5L2mTbRiWpVsSd3ydELhUbQTy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/23 15:22, Rik van Riel wrote:
> On Mon, 2023-09-25 at 10:04 +0800, kernel test robot wrote:
> > Hi,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on akpm-mm/mm-everything]
> > [also build test ERROR on linus/master v6.6-rc3 next-20230921]
> > [If your patch is applied to the wrong git tree, kindly drop us a
> > note.
> > And when submitting patch, we suggest to use '--base' as documented
> > in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> OK, so I have a fix for patch 3/3 that gets rid of the
> compile error, but the libhugetlbfs test cases show that
> patch 3/3 opens up a condition where resv_hugepages 
> underflows.
> 
> I have not figured out the cause of that yet, but
> patches 1 & 2 seem to survive all tests fine.

In addition, I suspect patch 3 is going to cause a performance regression.
It is taking me a little while to resurrect the test environment used when
the hugetlb vma lock was introduced.  My plan is to exercise the series in
that environment.

I should be able to review patches 1 & 2 later (my) today.
-- 
Mike Kravetz
