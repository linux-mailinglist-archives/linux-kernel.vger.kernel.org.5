Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D90F7F6194
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345830AbjKWOf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345772AbjKWOfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:35:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B154DA4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:35:28 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANETH9a019451;
        Thu, 23 Nov 2023 14:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=oZ2uygHrksDe1kQMToNCY5gUd2ctynOrjhFP93kaPWA=;
 b=hTvMimiY423JBn1DsekLLbb91pYQyhE9RI2ywW2wUfiJzDO9+vQdQfC63XBK51KcyQ4K
 hVKa4Ehf7oNIKMwkjGZQ/ZBh0Mj9aYehR+3XOiNfkX3JY+2mL8fFzCj2vxQpCl7iQ8i/
 MiczPHaR4gKQlHnSvgOfihqv70ie/wq49x9RuBmqfn8pDjrWtOT9otJMXX6S+3LnzOMq
 aqDCJm4KFPK8wIYi3G2/I5buTtFyCSNm+N89Wy783lv9DWBRDDdY4km2eHrsE7fqcERm
 TJeQCHoXu6OJ2vFDEtegzGz3T82B8XESNK2nXvnN0MxjPV3rKfqlbNRnUKOdSLtDjwPu /w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uekpestps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Nov 2023 14:34:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANDvSrK025514;
        Thu, 23 Nov 2023 14:34:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uekqapatw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Nov 2023 14:34:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5nMaKXXh2sfMc9/DCCWLkQ6Zzs69qCcHnie2emYuUAYnnRorjBEq3dl24RAfrFfSq8ExqhpPZ+w/7wuroadbr7jNzlGuqENCOaWw8L9ZGl9NIujZ4Ld2BhxUis1Tu0npW+yYPV3u5p7w3tb6gASNP4EPa4Kv2vEwnlXb4LIcagHpfY9X5xahPz6tNl5qsQRA++I7vNc5HTzLORXNbtyBi5ln2dbHp7pZ13Jl6H7+5HG8sYLJsnV4ebCSRVHVbHkEWHcPDjYvLTsDFlJr//QJD7B4Q3WmXx5fzK3re1USYL/M/+Jd/szJnsE/cbIZx8cRfCNb+qonP2rg1gSfYDsiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZ2uygHrksDe1kQMToNCY5gUd2ctynOrjhFP93kaPWA=;
 b=PCadNpMJSS35E3Ncu1lq4a4FaLQhyeXWDS3lL8IgNvX2F2E1u3+KHyjWrGjBSDZSBFHIuA4PzJx0yHBBxNO+Rm0qg7cPQfYrgTTwfAFDPIQijxXFZvfxpCEz09CBDDsro9/WBR00TODCqpdUeNLa47K2ancCq+bks1BJkDsHIPWWlowllvB3/PiZhDhLkt5hDTInkofAFLY6/g3JzRWdgtMYcXFp4bZ4Snn2uVnOtMg/u+xP4RjBNrLwqA5lO58AeVbgRJO78AX2elJabDT1yacaVQuFXLTfhEs6SAed6IWeGTCDDfCphH3ie3i4U6FdyRyQcUn/r4hrMPurTrXsmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ2uygHrksDe1kQMToNCY5gUd2ctynOrjhFP93kaPWA=;
 b=Sa5TJ6Cj3B10oEq6Nl5LyaxFlRXAN3XLAjhArxOHDLxcOBfMkg/RKsUnVBZHsjHSzfpQ/H3nXtUo7WRhMwVALNSg6rtJoe0cwsQMKbaJUaMBhDoz/kmhqcE/N7acN0e5wpBRI79sxHte/ESIGuZG9sV9ienQ987nb5PEpcM71lg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB7324.namprd10.prod.outlook.com (2603:10b6:8:ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 14:34:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc%6]) with mapi id 15.20.7002.026; Thu, 23 Nov 2023
 14:34:55 +0000
Date:   Thu, 23 Nov 2023 09:34:52 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Chun Ng <chunn@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Ankita Garg <ankitag@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [REGRESSION]: mmap performance regression starting with k-6.1
Message-ID: <20231123143452.erzar3sqhg37hjxz@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Chun Ng <chunn@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Ankita Garg <ankitag@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <PH7PR12MB7937B0DF19E7E8539703D0E3D6BAA@PH7PR12MB7937.namprd12.prod.outlook.com>
 <ZV7eHE2Fxb75oRpG@archie.me>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZV7eHE2Fxb75oRpG@archie.me>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT2PR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b914e7-6e40-46a8-1088-08dbec315c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gU80fGFBFzryMRjMYKTf5oEYXQ721cS+HBz0iuSkabWT6u1SvxsI9wzzvYBsitWUz+kqTVWLeM7zwAKGLnIiZ4dbRKxoh+5VBESz42dWos3WUufV2FM2mlILLzaQxorJ3fZ8qpHhsery/5fY4ft3T8br+eGr51Fs8ih7n4RNgFT+xL0NlL3huZi9JgPTvZvIhDjhdoy9DSnBgjHBUqaaiIfwuTsm1uOM/Z6fi//d+eCxfq+FMSc5h+bp79MSs/P/6A37P1D7e2KWKNs96bcaLS/WU48K84H48iehuS7ZrZDAPX8BBOrJhCysO4NDUbRVRkUMsOCCIG46w6A58+BsJpW41H+bwRDrGpqH3VihfL40MEf17DBvWCQjSEEh/ym1HJNmzEpardjNQdS0nCVDoRX4BRi+UNJltKYKq3ab+SqlNz+IOr7fiwICau14xgUOQjEDebR0+bHiUWhrwtyqI/zhsJkPyUeHTpmMMhMa6PHB6nc3uezT0lKKXP2hxoQDI6qA7EfvE3UtZ1r8usyxnPrw0eiqfxs9KBxKx9323u5C6MH4ZjI6yNusAPXyRu1nwpJRqgY2FBxC2FZlwipcXK5S1wK8QAQVEUHc4LRXzTiB1WRQCzywitfKPC4pR4XHOP4rKt3YlPaAs9KSXdrnvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(5930299018)(26005)(1076003)(9686003)(6512007)(86362001)(38100700002)(83380400001)(5660300002)(6506007)(2906002)(6666004)(8676002)(4326008)(316002)(478600001)(6916009)(66946007)(6486002)(54906003)(33716001)(8936002)(66476007)(966005)(41300700001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?xgXYNqjeL/aanth1shx1xMrH5LY/8dk4YbkuFuoNlkmvDTaxrT9im2eI85?=
 =?iso-8859-1?Q?/knd3Ry5Wy82sM9NCFSnjpEnawuvh5FNr6pXdaT3vKd25p/8cuEfTIlV08?=
 =?iso-8859-1?Q?rQD9ufC1v6EqMQv9JsFXzhCD3OLlsKwCuG7zwQnYiY3r0SKlSAFW8UKF/Z?=
 =?iso-8859-1?Q?UZLOk3sQ+kK9SM0Kk3SKIVrHFOibzCg0B2BCityoWnanzpvtxuapmiHd2e?=
 =?iso-8859-1?Q?7O69cn6OYr3f0ktUCYXau4HG2GxD4ItPw4Ih87RsWjW6XiNoQXh2Rg/xhm?=
 =?iso-8859-1?Q?S27rT+7Ywj0zdDXIvV2C3me/mBzwJYsNljQGO5g5sQT9lbEWutAe0c3MSd?=
 =?iso-8859-1?Q?hZVC3fyjGUcm9KE7oCJ1rABy/EXDD9Oe05BXR/QLz9PP8ItHNNjPBMEkYg?=
 =?iso-8859-1?Q?ni3UvUESDXBbfM5Bmkl24WW8bAs0ArOAqebqSnvxK5Z7jnPCPAdLmVwrwm?=
 =?iso-8859-1?Q?wEeUw3Ll2uPSsQd5U5MYgDflNDL8MRsAF0JOen3fAqNAZSOKaZ6QTeR9Z2?=
 =?iso-8859-1?Q?Drm85OwV+7sCZeOw86XnWcC8V0k/mHLuqLKz6gUfSPBGLOsQ04MDdf+rD6?=
 =?iso-8859-1?Q?xRClt2J4nuWX2QK3kfOJUJ/X7E372vydXSM9zvtERHi4FwU4hqnKAjZcCM?=
 =?iso-8859-1?Q?ht5QhBgQA1/sA3lMgHmXCRl2zKueylWd1gvnqeGrXPbhycpzpmbbTkjA1o?=
 =?iso-8859-1?Q?hpfJXl91rGAg5x79HlsRW+B2jIBWWciSfdr++FqowdKpYHLcoBwXQY7fVx?=
 =?iso-8859-1?Q?+06YuDzINTjKTiYUbTVp47fQl5RscGVT3z/Apdkwzx31C/D7UFuvBbedyN?=
 =?iso-8859-1?Q?NQVFc7cHxp/8BRPjvu1KHVr+KcmPnkQX1cUhBQhMSbMckMuRAgy2tp4BK6?=
 =?iso-8859-1?Q?XCLWGgq6Q3blx6Gieg3LAncZM7ebjLK6UC/0UEaHyBn9VnCWOWrhUkMYhY?=
 =?iso-8859-1?Q?8rIeLCKztJK9yJRY/XWnAMw6ghVo0NZ5vLxZy76G/qDOFC2phJRQpOXNV1?=
 =?iso-8859-1?Q?PDQuSzLco90+tUkdxq6phyr+ceWQqO0dyt8a9FXLuw/ue9GolmSj1LeUKo?=
 =?iso-8859-1?Q?rSYp/fjTV86e6msSqD9vQN34+PQMxatpPyc1eFJ2qbWNFfI4HY9b8Px56J?=
 =?iso-8859-1?Q?Bc7oVBx/OBa2Ah6KRu4woG3OXIGFH79gvQNSRZgSX4p6t6pyrD3m5fr1xL?=
 =?iso-8859-1?Q?DxDpwk7sfnyUukhSVDfr1A37rSxcd1SL3yIg7AR/vU3zUdyGVR/rn5EdiS?=
 =?iso-8859-1?Q?mVu5R1tlQhKp0rQZOB7dkYA6vWgn0cfsZPzk5IBXbNx5ArCzCP9L6/hwn5?=
 =?iso-8859-1?Q?w3t4rXM+w1UDrtZpFLn9HAnMApU/5zEuvjdpdNFT0oa9RK0Iac0g9bBVx3?=
 =?iso-8859-1?Q?464meca6NDBID/W8wveMTYM4s9YctTDfhR3DjXZgIb2Xtqg8M9sy4xowPU?=
 =?iso-8859-1?Q?XfoU2JNVlAMRU5nUx0nKhhsA7whD5laSPr4n0t2IIdxggHV0oJHDpHdfHs?=
 =?iso-8859-1?Q?sr0cEwL0+pf7t+gujPeu1e8Cyrq46/a3s43pWWtmWPjsxTOmA8Qk3DbHEk?=
 =?iso-8859-1?Q?phSzWcDZnXtt1TBtpXyM1l7k0jzsEB1JZNvyAnRUkQWc9sV1pyMTGZv3+l?=
 =?iso-8859-1?Q?I3NGpNNLdbliXDAYb+1E/Rsg9ttdBf7SgE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?NB5xLdAi5EHxkHc6+M/ZgzLaXyZ6xSRv2pttGBwHy3qJYJdFIcX5duE6VF?=
 =?iso-8859-1?Q?YWNIMHCRz/34hI6XWz25DiR69CR+zbp/hxuXks22qr41rlk0emIV0HfQof?=
 =?iso-8859-1?Q?h+I37FYh7PxDAvn1EaxiD8l+AJuQSSlDJOqxfSlmdwG3gEQsSebPiR/f1n?=
 =?iso-8859-1?Q?o3Hu5buRKUDS0hutmG5/TyffQPdK9R+4FU+D8SK6cUauIh7vWjLR/uQ5jR?=
 =?iso-8859-1?Q?33jE4/q2C235NQKSZCPYyksqMDuiNMZKiUttOBwWHUX30Ja867rV/mGZvH?=
 =?iso-8859-1?Q?EKT2bvXQB2ruF4mFBI0wOgTExBzW3uy4gNUbhraUe1wjZDuiwX4pHrXoJU?=
 =?iso-8859-1?Q?7Ag4VZK8ZMt8fmUCH9/Ve3QPPyU+3dTXXZ8hSVkhKcLL5CKj8T/o0NzVxQ?=
 =?iso-8859-1?Q?p9EtcIDhiaWeVggv2BMbkhJZpnHTMtzyRUlxq4LpegEkvitrzJY1PvLIjf?=
 =?iso-8859-1?Q?HViBPbKe+11/R42Mw9x3GmcNqgoWp2JoBMOLoh1M0ps/x75StfoORKHn7L?=
 =?iso-8859-1?Q?eqgeAM+cqVuQaLaGWkQlEBivyTjl9UBW+loip6tVOXBfPcvBM3FrUGDFPU?=
 =?iso-8859-1?Q?q2IGSsfRQZzf17Ua1hvsHkRdwz5qZZ9KJ7KWkpuU+lt2ixQ+rQCF/7+oPj?=
 =?iso-8859-1?Q?qkH9ZYNVaAef3jiTBUOOLolh8G1DDjuPV8u9cQ9kySZPo3FtTr1TF5+qUp?=
 =?iso-8859-1?Q?seDInrqvw7PXGa4tRYp+mswiNW9UyzJjUHOUgYrlZj+mYkNbOjzL+Y8nmU?=
 =?iso-8859-1?Q?iEgFYbNbjqia/UndvFe4N9zw821MKyQB1FlHSYocHGkNFxNMMoQ/rFnvxD?=
 =?iso-8859-1?Q?N/9uVKE2DQtZZWzp/gVJHXNS7GMiz6tTMqxDiueuZTAoDnRcIljfH+7kNT?=
 =?iso-8859-1?Q?9TGmsh8f97rAbQFhvj3RcWkFukZSXnyPrvFvlgjZsgbjgN7uKJRZJPK5HZ?=
 =?iso-8859-1?Q?Qy69rTTSUZH/GS069aVMTotqYVopMNAq6JJLkqf0csjAFV3eAabXUpWdLi?=
 =?iso-8859-1?Q?ZkelXfA/ojc0sm2Uj+GjvtUZcn474hp6LmsTxO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b914e7-6e40-46a8-1088-08dbec315c9c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 14:34:55.7400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lUtdVVS9lNc4uJ4v13J6WrSTda9u6DDnZKmwEEZoy4ameuw6q4awrTZb+L6engA46T2ELvyr7VM55uV8m5YoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=513 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311230105
X-Proofpoint-GUID: 0CbcD6ZLXzdD70dVNFhM3Focs99bEnWk
X-Proofpoint-ORIG-GUID: 0CbcD6ZLXzdD70dVNFhM3Focs99bEnWk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Bagas Sanjaya <bagasdotme@gmail.com> [231123 00:07]:
> On Wed, Nov 22, 2023 at 08:03:19PM +0000, Chun Ng wrote:
> > Hi,
> >=20
> > Recently I observed there is performance regression on system call mmap=
(..). I tried both vanilla kernels and Raspberry Pi kernels on a Raspberry =
Pi 4 box and the results are pretty consistent among them.
> >=20
> > Bisection showed that the regression starts from k-6.1, and the latest =
vanilla k-6.7 is still showing the same regression.

This is almost certainly the maple tree.  The tree is slower on writes
than the rbtree and so if the benchmark mmaps/munmaps in a tight loop
you will see this slow down.  What you are doing is measuring the speed
of inserting and removing a VMA with this benchmark, so it's not really
something that happens - we usually use the mapping between adding and
removing it.

What this gains us is the ability to remove contention on the mmap lock
during page faults.  If you were to test contention around that lock,
you will see a slowdown until you reach v6.4, where per-vma locking
started to show up.  More benchmarking will show different types of
fault handling outside of the mmap lock until (I believe) 6.6, where
most (or all?) types are supported.

Although this is expected, I am still looking to reduce any real
workloads that may suffer.  I've been reducing the allocations, for
example.

> >=20
> > The test program calls mmap/munmap for a 4K page with MAP_ANON and MAP_=
PRIVATE flags, and ftrace is used to measure the time spent on the do_mmap(=
..) call.=A0 Measured time of a sample run with different vanilla kernel ve=
rsions are:
> > k-5.10 and k-6.0: ~157us
> > k-6.1: ~194us
> > k-6.7: ~214us

I would have expected v6.7 to remain closer to v6.1, but that may depend
on the minor versions you have been testing and what fixes have landed
there.


> > Results are pretty consistent across multiple runs with a small percent=
age variance.=A0 Ftrace shows that latency of mmap_region(...) has increase=
d since k-6.1.=A0=A0An application that makes frequent mmap(..) calls the a=
ccumulated extra latency is very noticeable.=20
> >=20
> > Please find the ftrace results and kernel config files in this folder:
> > https://drive.google.com/drive/folders/1qy8YTBqxu8Gdbs7IigYbSd4FXldId5s=
d?usp=3Ddrive_link
> >=20
> > The test program can be found in here:
> > https://drive.google.com/file/d/1tG6_BbQMCHwfKebvAIAg_xqbM_lpPcuM/view?=
usp=3Dsharing
> >=20
> > Info on the testing environment:
> > cpufreq_governor: performance
> > Test machine: Raspberry Pi 4, 8GB DDR
> > SCHED_FIFO with priority 99 for running the test program
> >=20
> > Vanilla kernels are not tainted. However on k-6.0 and k-6.7, I have to =
patch the drivers/clk/bcm/clk-raspberrypi.c file with the version in Raspbe=
rry Pi kernel tree for the CPU frequency governor to work.
> >=20
>=20
> The next step is to find the commit that introduces your regression with
> `git bisect`. If you haven't done so, see
> Documentation/admin-guide/bug-bisect.rst for instructions.
>=20
> Anyway, I'm adding this regression to regzbot:
>=20
> #regzbot ^introduced: v6.0..v6.1
>=20
> Thanks.
>=20
> --=20
> An old man doll... just what I always wanted! - Clara


