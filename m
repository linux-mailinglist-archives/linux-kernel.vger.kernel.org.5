Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8478C756501
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjGQN3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjGQN3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:29:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6A52D51
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:28:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HAndeP020316;
        Mon, 17 Jul 2023 13:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=FQfGxb2HSBl74TO5JYrzrprfNxO0lH91KSUOhVCc+Uo=;
 b=CV7EMC3IWM1LsImx4qmQk5HhXNrWT3Ihgi9ax0CVMoFbPElM/8A9diJbaWbfyIQrZl4J
 VurM/bkjktBzO8e5yo3b91IR0s0SWKaYyJjBbomuXFV6+vXIah8KFUBaG3Td+vEGBGbi
 g39qBKbYckIa8PPR4/WhHpXmC67Iz3s0lQLPzl91FfFex9XcWvBx7Sa4m0iBT2Mh2fj1
 A4lhrHw/oCT+7CzG7u5XCOPFgwlMNe26lz0kENsi7YGNdy1qDl11a1xFxcYEJUos2Iir
 RRHHjNwbu5aDgvnj1VdDSK5QvtHMFk8jHLP3Veikbgx5YJGKg6t6KOhqrKQs/wZayAqW 0g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a2pph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 13:27:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36HCr8Ax038212;
        Mon, 17 Jul 2023 13:27:45 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw3n11k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 13:27:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRHoMu3apdl0KUaR/KAmMYKkL0Hhlf8h2lUHzMZv3aSWuo7pzyCqyYvo6leXYFD+LBG55n3fkOVCV4zijAvjd5TDs1dsFj0IiOPzdz8hqltWN5zw1pH0eGb4B5PFaeIPHCBD8LrunU8XcL1FyAKoPONruxFH9Ci4TqSKdC1PNe1SMTrpXIx1r8vU5p97hTNYsMDGTOAcO59EWcfviv0QXgiu78AEgJ6xMiK724P7e5xT22xPMCYvfdQ8xs7E6Kpku178s514S5zApZtRpxC6eqr1I6Uarom0vT124WJ7xjq4oSP1EF0UUyeBgaVL9N5Em2NVhnTYm6o5Vbdpco7rPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQfGxb2HSBl74TO5JYrzrprfNxO0lH91KSUOhVCc+Uo=;
 b=O7JmptSi7qASM6qIYWDrXOlhS462EpDsQGadSIRSLKxfvrMI5MsEtnAhIgtECPL4HyFn0tB+ifCq0/RGU02rm+i5IUO049AEZDIWWVxHPjDl5Bdo7m9pUGBuNQ7Htx8hNc21x3vaoxOA+sZxj1N2kW0LXWeozhsVcspkiQThdbEetu7o69ITd9i6OXZLP2TOUmKMUSJCA/YQeDKT/nUmTSGjBLOi4k1av0Rjhds/kK/X+zGT8y0oWkjWbYybsAHrvdLzP9vj/8mf3OVC9fBf2p3efSlpRuXAY5nEIxwunkVRBdGmixNRcZeAa7FQ6PbjIHP+DEC7YzfQfSc7FMYDKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQfGxb2HSBl74TO5JYrzrprfNxO0lH91KSUOhVCc+Uo=;
 b=W5r9jNPAYDjA80EmqhwsmwHp5ZXWMnvJuY0nXCP1LR+ilH3sX5c7UKg1jZmxdb248FCnGp7lGkKjAMg1y7t2O9W5VMvWouKeYs1K4Vd86do7rvAMK6U8JUGGsrTsYk0T7Caq5+Co0Tuc/TmvyiUzsQqXylGsShjtwCeug4/2Evc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6861.namprd10.prod.outlook.com (2603:10b6:8:106::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 13:27:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6588.028; Mon, 17 Jul 2023
 13:27:43 +0000
Date:   Mon, 17 Jul 2023 09:27:40 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple_tree: mtree_insert: fix typo in kernel-doc
 description of GFP flags
Message-ID: <20230717132740.ng2wihlsw2zhi6ne@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230715084038.987955-1-rppt@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230715084038.987955-1-rppt@kernel.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::30) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e32208-3f47-49a6-3bdd-08db86c999e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AxvgvFgxcwto4G8Di0N3TkkrqyET3JdYzdkiVVCcMMsIbStjeyPmqZUHtQiBzjifXeGRA+B9uShbvbp/wfe31K3+c+Yob00LUT263QszbgjIi5Dop6/cL5ltHlZcMsv+2cDI6dDSFhL3qDNGPdYeoQW21e3Yp0J4TD/1+aALM6qd58dL3nzp39WqMVDntR7C9li+jO8Vs1DaxeD/fgAMnImIdQ/87tYIyvbSPXjYYza+iBA1svz2pudC0Dmyqykue3PuhDKLCZdtdUqxoxm3DVNOaWzeik0eB4NxVkHxrrsuFg9xmcZHSFpRU5lTxFLaNAydAhN5HIFnU3ohCl3smCFOcKjqfxRTBpSfXuXdM43YA/IO5LeioGnzREtuzON/yE5cR8RITF1EGl05Vado3KxE4iJ5eaHohfN4k4WkI/4DCIHAQDCGsuje7M3zom2gVRMivrC7Tvdh/4GIl5eVtQxnZdeSn+CKlZGXHHzqvdzVLy7Z5IeO9MaHw3Q3xd+4S3amtAtzu1tfWEn/4xskbiUDi+0deivI5cPPeZYqFZAdlSW19T+0iKpGgSFqAN5s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199021)(478600001)(6486002)(1076003)(6506007)(186003)(26005)(6512007)(316002)(9686003)(2906002)(4744005)(33716001)(41300700001)(4326008)(6916009)(66946007)(66476007)(5660300002)(8936002)(8676002)(66556008)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z+GUckUgBGXI9JOcE0Qv0GV3RIZAkYEUeanpLNR9/ec99FYX3HRU+7I2b8l0?=
 =?us-ascii?Q?G68J0r29c2D2HEqH/1cexYuW+t0V6MhNKUXm3rzvNYswUqTVa0dogNR3aebr?=
 =?us-ascii?Q?/i4xLg91RjUMC8MVKHGHXC9l6rZ8JZoNc/kwlxuZcrB/Vp0XTGK8rPXA8Zxv?=
 =?us-ascii?Q?9xM+A/fUtxL1WXoGnK4OGSzmTuG0P2fY6OtSGqkJod8WYVnIFbcd5xsdI62B?=
 =?us-ascii?Q?boSHvn4ljeC7mvWNdswi1asZxiQjiEe2751d41AEWbiTMEhxx1/uzhb/M092?=
 =?us-ascii?Q?2BqStUyRblF3Wkl4j5Wmth9DotOybwecZ+Sw0Wxz+Lu2lMWtiBcdNW93+tAl?=
 =?us-ascii?Q?oeRcrQ6hv6cTeqYLZ2RKTbYDk4NLCu9yQVuuxIFQFz0pI8dLRwsZ+N4lZ0nn?=
 =?us-ascii?Q?f/oLLmprOxnIxWofT/RLPjpc9vIeOnCgqwJyUlo/NyKCJzLi1q2xkSvk0zLW?=
 =?us-ascii?Q?NheQc2MOKH8XdJkL9b6iVd4nseQNfX1MaigYj6FLN6Q1zSN37PWV3bjlYBdC?=
 =?us-ascii?Q?e5sa0Zc58TeiTTZAs55uV8FRjstcyiiBZK67lP2sTif0+JcIyqBBA1M+FKB4?=
 =?us-ascii?Q?LD7P1aCtsOYuZ+fpafcJC+U3O/5X0VOKfqgCmhPoz7WQZuto+4T9M66Gj/7O?=
 =?us-ascii?Q?HP6cEOt+AtM6JvC9ofou4zgtsng9FdgICX0Io5ApMSo6s4C8greYfoN30P3d?=
 =?us-ascii?Q?G2/6gCHVU/cBqt5WAESOpdOMc0nB2Ki/0RcgJmFd0DaU1eLQDFv266tFlWk+?=
 =?us-ascii?Q?LkbpH3685GNCeFQcc0VYB7+rIO31Q0AUTHyxts+nrl3GPRQySxg84PySj/pD?=
 =?us-ascii?Q?qvY9ddT6metNQ9sweLPx2ON/7dwylXX7BKxiOL1MoB2X2YCxwACcia0zEOWU?=
 =?us-ascii?Q?X0CdZDybaIwZsYb4FndLbos11iY0w1OeCSCLJTPqeb1YOxFUc6/7b0KxwiP/?=
 =?us-ascii?Q?EOUf9smdt2sHSr0uSMU+KE1FNcylNL7oUq9H9EhldXFN+aUW7rnU6Lqz4f9B?=
 =?us-ascii?Q?PkNHqFFUU1u6jw/979RG4F085HKtyI3CjkFyncdhvjhvbToDyc0AjwBmo+T5?=
 =?us-ascii?Q?LLFe+I+ZjJaAexYvJiN10mmJ9WmR63nmkViSTrvVuBSPMIWtWVukC4p0CtVp?=
 =?us-ascii?Q?fFuElU60cIw+2wZTpfR+A56aNY+JEmlySX4KjtdJm+TDioniW31YZ7E1ywGq?=
 =?us-ascii?Q?UYmbTDmp9AgwYctxR1a/asc6ov9JRgyVNn6n/2voxUa6YuqgiFEk4m4FfOp7?=
 =?us-ascii?Q?R22Q20p+RWQqP+hQq5DQmRzP1EGCoJI2Xqasj4XkfY3MhQmIu4OZK5pa8Cah?=
 =?us-ascii?Q?Cz/SqSPW4iP5B+UUOoynjDvaZLJILRL2lCXJDef5yEZsijRmg0bohPB5Jy2W?=
 =?us-ascii?Q?a6ni/5yY8iM6tti6edmKPAcMU2cFz32NRhbRz0siaOjm7Rbh+E4yBdov/6lU?=
 =?us-ascii?Q?Zd1zSGt3VVs3XcgLS6aXmJVot5RXY9XeVkH54MlIM0np0Zq13wUKo38SsGmx?=
 =?us-ascii?Q?+V4ZSqGJYVoSbvrwSYko67iV3yb/6R4Of5MV5LfxA5AxoYVjF8YG+T9eo4Vo?=
 =?us-ascii?Q?CHJk08RF9oha/GFUiO+g+8Ti0I62bfngZ6hTKsxXBzECe8wl6RtLtz1vydG4?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OHIwKMDVvzS995a0EOZLdASVFW1xhnAU0oKSoKTJoLD+cQC6NvAO23Gi+YCpQXjj5PcuynRDAtKJXESwYkQJJxgOfuKkFrxCu3xTmz1UiAysI97qZQpvkyTxlI1QvPdgHzu5mWEPvELw6iO7oXYerGV5Y3jOGDhK5dkvGyRI2EgWnvJaCyEasgsF7CzRZvd8PsP7ql9xN8q1aMu1EI5LUq2HCMdMpVpF0hOncxfSPRayD6aJO++ZbTk1sa2097GoGtSjQ+K9n6oRPxPp3z7Y9gVR2Oue1UWtoy57QEQ43CKfQU+tKgxP7L0OR1egYAm7AeK2LbD9CrOt3clZi0J+0prcKq9AYZuIWvMx0VKB7Q/WNHaUaD9P+IWuDhzV/X/h7uGnmeMOuIRbIUv8Ratj0COT3Wwfm/Da4ER+lhefP2gOk5S6QbBsGoFG1aeQHlapUtlW3YLXatsBCu5opmg0B9z/WTDvWLYIb/iguAZWjPGlxVSouHIi2y+YEX9t2kjtR7ZKPo9oJpsNZhOpXFDVZUgDcnOUXSueEvoMcvww/9VWNJl6MN4toq/Tqbi56XRTMjteW1iw1LqY4Mm91CyDZSlc+DCPdodfuWPlQO2G2Lb1dpMcqnVMSAe4NExqw0p36QkmpxQTwvPlFz5jG7V6ykxOL9F4EEL5WAAOf2oqFaeZaa9tbRioIcEHwfibUjd4oz/NG+5Int+z/oahiAnowznII0DfSwH+Fo0rnMiUfLryqXjv6RSjladqypYi8CmJyxlw2Pp0sWJQHv2YZwhdhqJ9IJM2o00WZ7xkMXa9Tg+gY3KGk3ilf8nAgm2a1Wp6ykb+MLbqRBZUzL6iGrQvyrZtGVgvMrDENnBjHkaiziQdKhy4BzHu0KyZd4Sddv1j
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e32208-3f47-49a6-3bdd-08db86c999e8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 13:27:43.3185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4DFmpkEl+tg30Fg/f1j8TDU0l810CqfDX/sAbU2xX1MlSQQ2LCv7MURVnt4VEr4ZW6u+E9z7UVr2B1vCDM1gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_11,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307170122
X-Proofpoint-GUID: heyZBJ06hze6RtcSqJvTcJadsptvXYIM
X-Proofpoint-ORIG-GUID: heyZBJ06hze6RtcSqJvTcJadsptvXYIM
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mike Rapoport <rppt@kernel.org> [230715 04:40]:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Replace FGP_FLAGS with GFP_FLAGS
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 8ebc43d4cc8c..92da9c27fbd9 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -6339,7 +6339,7 @@ EXPORT_SYMBOL(mtree_insert_range);
>   * @mt: The maple tree
>   * @index : The index to store the value
>   * @entry: The entry to store
> - * @gfp: The FGP_FLAGS to use for allocations.
> + * @gfp: The GFP_FLAGS to use for allocations.
>   *
>   * Return: 0 on success, -EEXISTS if the range is occupied, -EINVAL on invalid
>   * request, -ENOMEM if memory could not be allocated.
> -- 
> 2.39.2
> 
