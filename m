Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA05792B75
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbjIEQxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354223AbjIEKK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:10:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5109C18D;
        Tue,  5 Sep 2023 03:10:53 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3853OfeO029471;
        Tue, 5 Sep 2023 10:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=eJNwEdb2Cnqsx8di3tPwtelB+TJGZ5ZB/z8mBmNwIXw=;
 b=bzpwWwk/HJCOes332AbHBaUGFtBjLn69KWGvKVt7pNL9NRhTmy2K+3l6UIwTt5ZU83dU
 9mq0NaNvPM0fmCsv/C8I2ZLa3EwsWmaiFA+xMoY4Nk5YocIzyCMp/ng+/9SLb3B0ACJc
 yD3M09tSlJgL5/OUhoBV9AujCyk8rpLAJacPoWZXxD6BVv+P0W6GCWQWCGutCqa9OACD
 IeOQ5cmL/aohoG1LW3QOwE5ZxwIxsO/ORcOK9AarmfEYDMdrVbTMe/kOG1F3whDf+i7C
 jxqeSDWHfV49Mfu5CzS2eoKVj5gB+4VV1sQub7+4JZAgtcRPz+fpoeXVJYAqXryCYVVD mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3suvxamwc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 10:10:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3858omV6028151;
        Tue, 5 Sep 2023 10:10:43 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug4j6m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 10:10:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7NXQsb+5HZtOSYILwrNBAHzhz6CnOfRARnBz633Dj4TJpO71pL/z7bF64Wx/WsDJIHOXMUFOmUacXIPnam8hy/hCVNwR6kQKFnjV+83xhvZc7NHSuDl+pHfS6ttfq+0a5DtbokdX4di1bK+NL082QCv2HzznmH+rPhW9nOJhV8Mtp22sTL4qGvrjs6d6Y5dh9g8FV8aVuPHFntyVcIGa816qLwnhIbKa9D/4/MAKL2kDUOA90tX5+6nZl9sEP4ZX98VjNaRhyLE5sQOk2IUadupRFXA7FE98piG7nl8ksol/Aw2caeLH7CtMp1BRQUFj0dlvHULjCS6Cj3WvNBSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJNwEdb2Cnqsx8di3tPwtelB+TJGZ5ZB/z8mBmNwIXw=;
 b=DG87NDliKVunx3SboHvOm5elJ1FCXKuj3B8PFGr8L0OXwymLvMMDC9LKDLjoMMGKIqJEy01HHpjc0+PhIWTocDZX8Lzbn3v6XmWk4i6R8KB4F7hvF5OI2jYzIjk6+pPs/ZcqeLSSu1J5f0+SDt6NZsQ6+xxE5EACW4l2DciqVJvC9UUYDVsI1uuKhgUS6UVEEDPOYJbkwMbWOnU4kd/sILav/qZnriMPyRKb7SmGmcue1jse5Xq2/6pLE41jLt3ma5ja/YnTn40E5Tl8yeIPKcbCVs/ZAHage6b49WcsNQy55EmvHpHXd3N6Mtv6No2wZKNDACZK3drQbYUCMxIanA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJNwEdb2Cnqsx8di3tPwtelB+TJGZ5ZB/z8mBmNwIXw=;
 b=k+jRDYxJDtoY18WoCc0HjrVhoONeGOOlnTO2QsCGSUxFwB5GzkcyiNA/h8KGQTEjrNa3EJ8KTiqkVCkozR/r+7iar+9EOx81CO4qh6qfmlX4E6FbpQtCS8GbW0Gr3kv43NNYmI255ukB00+aLrdOPwQaCbyj+f/jcZhrPyn8UOY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB4926.namprd10.prod.outlook.com (2603:10b6:5:3ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 10:10:41 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 10:10:40 +0000
To:     Kiwoong Kim <kwmad.kim@samsung.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com, wkon.kim@samsung.com
Subject: Re: [RESEND PATCH v3 0/2] change UIC command handling
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1jzt5j5go.fsf@ca-mkp.ca.oracle.com>
References: <CGME20230904014146epcas2p37d6690a5eb3a5652571bb00e358231a3@epcas2p3.samsung.com>
        <cover.1693790060.git.kwmad.kim@samsung.com>
Date:   Tue, 05 Sep 2023 06:10:37 -0400
In-Reply-To: <cover.1693790060.git.kwmad.kim@samsung.com> (Kiwoong Kim's
        message of "Mon, 4 Sep 2023 10:30:43 +0900")
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0030.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::43) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS7PR10MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd8ae89-d58a-4e1a-a132-08dbadf85bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bRMzlrOhjI3MDS+/Uv6ePN0DqymQ5U8sgOfNaC8cVKj04brNCK4yLIAzdoI1O7STEdSeBUOQi/VWDW1uP4eV3eecdI5Za17k4DgoQmsiyPlkycthNBuXvpKhuaLVkBeBVssoUUUvMl2knpdumVgLDADQxUfby9TmnBXKowkZsmi1Z1SidRfeUjdpv7h09jFvlzMhCm+yTN3/jvc6AzJ7IMaqJB6ygQ1pcKf06MekwYLopVvrLM+p0uyM2yynS85D0O5zuWm8b7qqtq7q+QeKUeqA88SSl+7ifoCDuXIEO48amtL8o0yc6LWBqahhn/Cr7G1xVDl/vNAKvpd9rwHj5IWZLwLln3KKDrUUZmv9F0A829ga3sXrJGIFDkoE+04n/eq9nlXqvqtANwZYZAqTkmX+To6I0MI+6VJSn5FPmeDPrLARh4HjC9xuyO8ZwBn2GILLo0bcW7AneRKBUq+Qp5L37SkOuCFbx7RnDgMBUB0wNy5B0IetiEG4OqLv/46/bJpkEMN0XTj0Vap+i9+/NDX7YdDhv5PZt6jU8iYr9XBZYl/iAsRAYPI2RoZRRyhY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(186009)(451199024)(1800799009)(4744005)(2906002)(38100700002)(86362001)(41300700001)(6512007)(6486002)(6506007)(36916002)(6916009)(316002)(66476007)(66556008)(66946007)(4326008)(8676002)(8936002)(478600001)(6666004)(26005)(7416002)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H1MCMsqw/TsEAipokWD25ysFl6RU0Yc5rI/Rc6jnQYdoPn9noK7C6tl5ncnm?=
 =?us-ascii?Q?GB2gt9C7WAbPUyojpvf75BN4On69j95kJpoF+zyuFLiMW7tlDPlGDhKDFeOV?=
 =?us-ascii?Q?Dg6NLE0XqcqgcjXvLF7redbW3x/nBjoqyzCs6PGiO9eH9nWlf2p2wKni8r4E?=
 =?us-ascii?Q?hQLWPWezeCokRUCTS7bAQugTGdEOx82b1bWNaej9Ldt+MP754NdqR3+U+o4V?=
 =?us-ascii?Q?s0ixQch0PMJu9Vwl880Ns3HBSYuHlKo2hoj6D7DOiaslWTvauoA+yPAN4wEJ?=
 =?us-ascii?Q?411XNuHCZg3tUfvtzmAXkvhs+GRMnN5w4tixEneEmOe7Wsq2PASbB7Wz+Lai?=
 =?us-ascii?Q?Bst8+Wlj6onj9Z2SfovhwOeR6sHRqE6ium1AANgNeOlIK3IaUGxhed6HRVnb?=
 =?us-ascii?Q?6kaGOs3B1ri9lYNhwx4ZD7H2OJ1SpegYSCq5vT1KDZ5Ikk0aGA4rf/hndqXo?=
 =?us-ascii?Q?esP3PI9smIwTW4dBHylB53Nx6aIbFpCtpkPtyVaL0y+IQ95tc55byPMPBbq+?=
 =?us-ascii?Q?ssz8jdIpnhpQaLwQiO/83jdyElzKn3e+QaOjg1q1G2WKFm+GP61pkuTGUkMa?=
 =?us-ascii?Q?jODFoWzuKGFhF0iZHZYWFzUjw7qKpJpgs9TCtd+8b0VoxYQJxQjX/TY8ab69?=
 =?us-ascii?Q?8i/G9aQ1eGPNZtdDMD+TJFzW9W1OudDTeb0CQANZp34oZ5w7fBKXiX/rK01W?=
 =?us-ascii?Q?xVRWa2CsD6FE19qw6SW4ujlTri84EDxw8UD1LV/zAe0Eq4JqJLOqC+UAvXMH?=
 =?us-ascii?Q?Ahy2UMQdwMoZurmw5CHiGCgkdUyjYUGpXXsqTHAx7R+8nOt4OTIbAaKGmmvP?=
 =?us-ascii?Q?ItV/HfBdaVG2HyneQFF4T5Frw5OubmfGohDfOM6umNoUl81shVQ891L7u81G?=
 =?us-ascii?Q?CTnhcNqFSGahN+GTFEtsv+UJYasubIaEPfMoXetPdFMsuY5weJupRLUFzBxC?=
 =?us-ascii?Q?tNROFkStWMvpla0Lx+YnEgF24cK2TbEmC1Th4ZXTNLWV/ZwBLvLUkrf/l3ty?=
 =?us-ascii?Q?yh0jKo6bcaSkkcbzwIVv6AUNHbZFIpjSo9MbSR6QdXFPdPQt3An0Aba7hzuF?=
 =?us-ascii?Q?5oS3h9jKXFIPVBIoELcgxxNR2+UH/FKEUefLzlHfvEKFFHFi5AwsvTnPIbGd?=
 =?us-ascii?Q?CUTaZExwJ9sBXhMUCiFMWGoILx8RsG3wlOpGzFy+PYWxdiRPxtRJ4B92LAtV?=
 =?us-ascii?Q?nD51446Tkpw9k24IntzCp9vJEf8vl2xONDK2x42mY7pWP++0YK8xpTxL0/qR?=
 =?us-ascii?Q?QcDM0K7oSoQ5pksRBqeyEkV1GdS89FOy3J+SJDidkaiSuywA8uyOxtcEvuV6?=
 =?us-ascii?Q?j8VlTVfFUV7UsouHfZYcPtaT5CXUTh7DGAWpwtCHkuPUiRjp/tsycy4zT9Vq?=
 =?us-ascii?Q?EVN19H50ku1GiMCak/KC8QoAiiZVwjKosLmuqOdLEhS+Si8YkLuqlGNQQZUd?=
 =?us-ascii?Q?9jLcpbA8N7pDjr5nmVv8P+psdtZpc3KL3IZ/AJiUW3MXFPGlABtO2TExRZz4?=
 =?us-ascii?Q?2VZpQHxbydacQx5rRjEW1X7ciLVAiegG3LEY0C+ttNQqStbJrFH9/Mm595Yl?=
 =?us-ascii?Q?SH+xCDcO/SYDodGHgqIOuuclaNSBPAfoNHY0R8/6X0O6Ww48phQi3rSEApt2?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mVTfnpWhEpsgvFRCm5W86MyFXH712ioaoYtaCITxqVosUnP8mYtIHVEDrOVT?=
 =?us-ascii?Q?8YPGutoU2JpSCYLstDqWK4zM+hjm0cIrewKGTpSm2JuVqXC9PC1G8HkRz8oO?=
 =?us-ascii?Q?Y2md04caLNvVQZEMpaAJFWqw/CFTqWVs7iWIisQZzUmiPmxj7mbeGohjaFZV?=
 =?us-ascii?Q?YyE0idf64hlW7T3z1l4aXHxBbc5pqmr1uu8aXmFITHLkn+xPqeW1ej2nPRaf?=
 =?us-ascii?Q?bXnDAi/1ItXNUUzVpt3yX+txinCZ9Sshwfx63L4S7LKr6lr+Vgi4SYBUFZLN?=
 =?us-ascii?Q?rOpuN0byyluCU7Asd8YouCrknysh9YicNDdZRY5aTTAan8CSn5C5+LFx0I3Z?=
 =?us-ascii?Q?6oRcqT4q0M4bUm53denBtmLn8Rw+NqDGet/nkvPP9Pyem5IckHStTsETgpjV?=
 =?us-ascii?Q?vMtVc8AWcn1WIVI3oobXHHIK30093x+k+qrnAVTojNHTqkW5k5HeSBTZ6LmC?=
 =?us-ascii?Q?yMM9NjbgkGbnFOn6O/BFHsAPUXLA/wKstGWeQLxRz/iczRDe48+eQ0YdF+ir?=
 =?us-ascii?Q?DscM4rlomnamiJJFGm0AVWVPVadjS6yDuBDMijxBplPScL7wNcT5oXsXqPGx?=
 =?us-ascii?Q?XYJyvzJD5Vgbl2RVrTC9aXSDSG4bR//Z0OScy7CRRrnjOSik+otl7DAd+hjY?=
 =?us-ascii?Q?3KkniQYXpOV2POnoS3laOf+oC2wud5cCr6DEW05ofXuF5J0QT4Ltcob0ZNH6?=
 =?us-ascii?Q?gJEcs3aWgv0W6J1jKcFIOTfZ4w+CTuxQILT/oKlpu7dKSkyWjubmG3LJPxtw?=
 =?us-ascii?Q?hrEiJJnvj6qsupEP18c8np15rIWnzSWGEBrNFwUJMMjI9HxLQuIEyA1NriF7?=
 =?us-ascii?Q?VVLjZYgyItk0ASozp72dvE9hPKurEqX4EGXgwVVl1GWdSxJdYWFOUms4yW6W?=
 =?us-ascii?Q?7MYgEeyFQGCaTruwgMVBcTmlFYzTjqZuvSN5g+dsxXqXhPqv9YlirODk+jXd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd8ae89-d58a-4e1a-a132-08dbadf85bdd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 10:10:40.8883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkxR5i+RoBF8KeA7i5BNIXxsI5HuxnjpTosIkh5nhLWKrIn73aAjJqC91VELHUynyECjf35cgAiedIVWf710gIE9tAjtgKPpFDRRPzD2zgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4926
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050090
X-Proofpoint-GUID: BpQoSyY1_pU3TfQH0N35tanGL8NFOTgB
X-Proofpoint-ORIG-GUID: BpQoSyY1_pU3TfQH0N35tanGL8NFOTgB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kiwoong,

> v2 -> v3: rule out the change of polling w/ pmc from this thread.
> (I'll post the change later)
> v1 -> v2: remove an unused variable in __ufshcd_send_uic_cmd
>
> Kiwoong Kim (2):
>   ufs: make __ufshcd_send_uic_cmd not wrapped by host_lock
>   ufs: poll HCS.UCRDY before issuing a UIC command

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
