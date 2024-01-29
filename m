Return-Path: <linux-kernel+bounces-42992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BF28409CD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F7AB20AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC99A153BCB;
	Mon, 29 Jan 2024 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UFPNQmWK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ii6H8Aah"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF83153500
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541826; cv=fail; b=hH/gNLF/kLy87m7c4KtZu2eyS9tx7n3Ds9cXQNtehyPdSNvmwkxcKDq3XjMrQ1JlCgMVRXnrISc2eTeomlxKkzHvhmcetX063puw2XrG2seHj+qa/O2DnGAPi1L5rRtmyXC/e68TgXO3sq4zO1lzPv6Dm7yvl04IMlcI6+JuYiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541826; c=relaxed/simple;
	bh=oaZHsIsfyEPppuAX02h1tZTW1bWikQX5ovcQCVjIxqE=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RtVnnpI8oqMhlFtnpL533a5qvpxS1wrEv4NUCJ3XUBVGlxoXBODw+i+Ng+u7C11/7XG7W4mb1zBN+6x6QZT02uJ1jG0gT/MCBkXRFptzEYwKHeAnni/tkzveJlXcSJdNBINb1bR4tknBx5kQyYWCmBm5IKoHigOqWvw6wsYhb/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UFPNQmWK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ii6H8Aah; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40T9ifXI016121;
	Mon, 29 Jan 2024 15:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2023-11-20; bh=8xI3mAyWhu8ff58ooKups2x1ImUIAzGpwCB6xdsjUog=;
 b=UFPNQmWKUBKTAMFxrbZ6W+0JWf55VaorcLCi/FVJWsgxwtF9OOF8QPjeHlXZOg5c83zs
 iWu5cyaWTsScv55OD6rJg0K1RZ9xF07kklPCD61db3k7shRj0iQ+PL/LSnIoF5jo0aCJ
 1XsqbJOxEDYYWMzVEwQnYaotUDXO2RKr3f+gQc7hvjM7bt7GX+3WpYRleO64A5nwfCYb
 /HippSUT5BZYNjaoGKQL7Vf8NRCtysvpWznnG+AC6si5lDMXibG71Z6KcfWDeGzurxJ4
 sVR8tCdvLhhlwI/cN1EAOR9gzyXAdujHO27EXpll5G3Y7d3ThDIsYt33+VUgxVzDDLrA og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcuv42t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 15:23:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TFJij7014589;
	Mon, 29 Jan 2024 15:23:29 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9c1ggc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 15:23:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfJfONE+NSUBzYB3M80PzRUjtCH7lpUgkL+z7NOmFHREfwtId3XKwYXvjM3ZykaCRJ84HS5U7rwLvYRvBL0115YYMvk07icI2fjeEsa2N2XS/N3rg80BZXATJUC4D2T9HuKbWCboRgSEg6R9xM6JO4eh1ZlBk2jSKTbn2kX+cNTmA4Nsv1ThE31adDy8F4KIW+IOyHtwjvrMh15tcEpxoJuCepQZUQ6E7H3EOE1WD1PKOODdbWcW0d0Pa5KCNmtA3Gfi9qq142dyuUl6GEYwPJBJtiSjghc2HMvZTuPpQScbmLu4A42IB725km/gmTo4FjF1S7imORn3L0ElkIy9bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xI3mAyWhu8ff58ooKups2x1ImUIAzGpwCB6xdsjUog=;
 b=HqBNs55taJ3Jg3hRVZlR9BeoWxgBVtrRxPnNOq1YQFUqelveNOX14Z6yvEUyQ5+Dbrsoo048+2/jsQ8P3CKtFezCOYs0MTWuRRH2/kwhS7ukm02zfNhgPeDN4rwxl1qPeGiOLlheOYi2JyH6kSTJEkw0L9mGG0iC4N9xIuxzI3xjYg9gGU6TymPlYUid2ovTS0slFLaAdROwNwT04PBG9VUa6hKJ0fWpNuTQEDf3+VihQH79jXIWzaYXMMjOEbYvpLktWTGk+MRdU0nvk1jVzL+jwHXM+xSfPAn7Y8idY70p7tj5RHfC+TOzwWsX2lzMHA5/kaZt+fGNUAK5CFCqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xI3mAyWhu8ff58ooKups2x1ImUIAzGpwCB6xdsjUog=;
 b=ii6H8Aahmh7M6cY1MHNg7tZCndHOx5hdJ9ACw9WUBUKQ+1NUBDo7Ulxs7okfG/6oTN7tITiREkaNNjKqyypaQMuIESRH84chgfLFjb1+GmjJSB1DNBlJVBeQX/h8aNjP5KY7xpAcN0BC+StN67Om2d2FEt4V6RLb4EohNVUiY1I=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CY8PR10MB7338.namprd10.prod.outlook.com (2603:10b6:930:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 15:22:53 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 15:22:53 +0000
Date: Mon, 29 Jan 2024 10:22:51 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: syzbot <syzbot+39a72b995ba73633c1a7@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in validate_mm (3)
Message-ID: <20240129152251.mf52xjxf54umijwy@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	syzbot <syzbot+39a72b995ba73633c1a7@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f9f23d061013c383@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0445.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::27) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CY8PR10MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5ee8ed-18d7-4068-993c-08dc20de296b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	g9+roQ9w2aZUUJDzMSf1SlgDi5JXnAmiFkXFqRM5HNj/c8IKDiltrbJl/CWY8bCJHiqVLaHeK2A5gPRnXjfPPpIfl1LfpdhGjtRbqBgHl0YB/0qxN5kirxHDSO6dsu6aE4qBy/Qy/GhPbRV2XE2VXwLtVSAPOBVbQNda0yM2kCFWI99vcUL60QxnJIKqZqb4YrRAgzkqN6f1ZkvVufQwYhlo44tqkLQkm7S4Rphr6LDKGMPA8W4KveyTo0hQG3snf/tt4R0eJcOJLGRBOyvfLKZwdOCra8gaVr04jyWQHFLIFM6xoZlLB8YaT77McwNAk6gDGW1ue1C4KhNKK/OE1ebFdwAhasMRyjfPJtUbRf6JWGDPZw6QfT4Q/0OQw/9t9ITM2EjxYxaGb7OtL3xFuI+NsX2/nnnaUDnWfL08VCFAg8FDwvBvOV2szGWyOSQB5rl190G3XTHklxhd68bi6DEQE6e6UmKkegV1S4n66uvSdfzc/OgFmblZcqHOnWDRHykj7VZ536uvSV98puwrw1LBwNTIFddTTHlC2OsGlIWF66RDNBUH/PlYPPGGsvx8uR5fAJ0jrVpnI6ZmWTgnp74ZnLon07mj6LdQgxC+euE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(8936002)(8676002)(316002)(66946007)(66556008)(66476007)(15650500001)(6916009)(4326008)(1076003)(26005)(83380400001)(478600001)(38100700002)(86362001)(2906002)(5660300002)(6486002)(966005)(6512007)(9686003)(6506007)(33716001)(41300700001)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iCxgtunjFeFb/tyjrcuU/kbDTyEdN2QbhEb1vlufmC+ceMlgnPzcz7SCsj6V?=
 =?us-ascii?Q?BYTLfbfB+e86IMG0MZj8hGMJcgukXUzBGid4wfTTy3SK5N7CXpWSCK32HqQr?=
 =?us-ascii?Q?9r2E7jIKrMz1l8+Cahl7vG8iiIWqFWzCol0UWPrphJ4S7wPAiGZ7ejmQsHyi?=
 =?us-ascii?Q?FsDgy6OUREyIw+KGlor7ZSISUgK0FZG5LTqHAZ75fl52ZPdi5a+Vo/POADqa?=
 =?us-ascii?Q?LMS6RqRnDaOV990CcG2QvW/k+qKAkgqbBugI37G57M1wQzpq07jpvviq0rgz?=
 =?us-ascii?Q?IuJtQxeivgVWNBXUJJyr1Xmp+pPLNe4zbsVduZKWoMLE/CZ+1d94TZ2E0h0w?=
 =?us-ascii?Q?RGhoHPW1TlQPUsrfJ9xNjjEk+q4S/23yFp0rFXOS9lkzmFZwg1trrIfYSOiU?=
 =?us-ascii?Q?FMSytDSoMz7MLTMYDUH9tslPJR5vdvPIqYdvff5HvdjMF36RfJmWzFCLplEt?=
 =?us-ascii?Q?PqrQ+M7WD0mUF0M82etinz/ph+nfkMh5SHnVxguqhVCtlGKluzVMJHqEOGQQ?=
 =?us-ascii?Q?HbtcCzWR2szYFN0Zj1G/Vgi5I4fho5/oOgNZ/A2XLFpkKv32GY3rWznm5wnb?=
 =?us-ascii?Q?NPaxwTkqHSgQ2/vTTpDCLw1CWSi7dH9l66a02HLnWVfSt/NjUwOThb7S+pQs?=
 =?us-ascii?Q?N+nnGqS3nFdHdisOiSX7d/c1Cl5UnW74FC285O0vTIVcBgOIH+aQ1Ke/qZA7?=
 =?us-ascii?Q?zwdNa6+bX2pqVPIhKDPhhoVWj3x2wfV7crQN94mv/RdzZQjveirNMBC+e3RX?=
 =?us-ascii?Q?Qv6+eFUIca4FexA0wJfN0QCVGC4k/xcA05xzBjCWSzmjZn1p7tzH7fTmaMp3?=
 =?us-ascii?Q?2sCU9vF8sMPJmuZCCVjP6ZmJgj5g/4ldwI1tH04nzBcoLG9uKeSNgORKKk8l?=
 =?us-ascii?Q?L/vZd99kxAsxmUAu+OD6gML/+iM/7k7cGWxP+PdKbMej8c+ojvxBDWSZg9Fq?=
 =?us-ascii?Q?fg/nnCVloL4LL6BtSqFP64AAluH5f1fEBSARd5zxRhluqQXjDemA2ujle+Bk?=
 =?us-ascii?Q?Wjx88K73c8Voel85PCby+8JcvpZDPNowckWPb9RXKFfKgfMx3l2SQi4nIIYj?=
 =?us-ascii?Q?gBDC1B2Tx7+IROO8TMWyLParKQrVdq/Tzu1p60vGUCgnUn+ziPC9mMDrioFS?=
 =?us-ascii?Q?FQwbFvqBvVwp9fy5uZLkxYpNO012mn37dE7I1YcDrdYlODwF1MW9bPNNoIij?=
 =?us-ascii?Q?bjY7sd5JheZaTR4qU5KSWqfYRvf279Scjihj2UqSdzZ4yrgww73uNjsRhSMv?=
 =?us-ascii?Q?WCRMLKk4XMbSxYdxcKDrKJV6K7nJcX7fxtpzhvKmGnDDVMZ83jKW/9blIrdI?=
 =?us-ascii?Q?1wPT33kEQZ2yiwNbe2siqOCfwbNi4wv2w+pPISdzvJ29DDhvHr7vl5g+2MgQ?=
 =?us-ascii?Q?M7OIlMEampEU2gUrJU/Z2JMOhyzOuKfdwfSt3SiiwL7Qs1tvTd0PvpSZaHAw?=
 =?us-ascii?Q?lcqHvYznHm4I9XYVVWcmbWFpwgRFVourHD0cAISNAxuzEWtABqBde+63EUsm?=
 =?us-ascii?Q?+CYzMY6DuFkG79hfJKzW3u+F1Fsc6RDje87/yhghBne3VuaBKXoo7KYR+M/V?=
 =?us-ascii?Q?L/YiSeqaWfz12gAJEmgXrWXutuDBoJ7cK0ziRpun?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VmjR6PKluvPeJXXV0rUTxIf6iO+MmeMeCpuVlWKjDnzucphDxJ38Ol6PS6UHU52FycKWtQt2fuHi2P+p6wx9bkCCRdUczgOI+YGfIphueB+jhbTHhZDSpRa/LW+WHQtuR/W2AZdKY/bua5pOhQ1r49Vziysdm852BHb3xrVKeRpZ1nsyTzemUaEM10AAS+gn5QLdsa3umS9LUr0sXDkt+vWFS6Q9u999FTk4wzn3zc9+6Dnv7rdVJg0Of0w/t+I3/Hl9/+rsZTl3j50HI4/aP3uIDbBxddHm9ocRVhKmUMBdH7sZa2aQLXCTwOFnhlga5OUgnDbgtwBaI/S1cGpKPIbwrb6QxK/RF4pTnz0WmGO5ebBm3a6126nQGgo9/6qWMuOUUL4x4+3nwpWb4B25ZmUcDbGGSyWBi+NiHX4oKxOJfpumWdInpCmwCIb/lIvEKdzmk3nHylN9/YKCzwbxh4aGHIrFAsNEdUXTbH41cTfdDysXK4W0m7O0cPbZLmiherv/EKZ1KRdr2xGIVEURMIjPOZypr60UyjHGWPNC88KqFZ9yh2Vgp5cam3bOGEKFkD1W+/W+khX4Y7zoNAYirnvlpS033hahE0zTGq1fpuA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5ee8ed-18d7-4068-993c-08dc20de296b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 15:22:53.0701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgkzmggUmtaryla31+4RpNZezXdAFxvwqZZ+9aXV1+kkKDDCwOKdWGGmXgOwniuVGZVphg7w7EHLB2TsPxabFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_10,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=681 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401290113
X-Proofpoint-ORIG-GUID: -YOjuRxh9mRUDKnmpm-670pQ8oBKOD5L
X-Proofpoint-GUID: -YOjuRxh9mRUDKnmpm-670pQ8oBKOD5L


Yajun,


* syzbot <syzbot+39a72b995ba73633c1a7@syzkaller.appspotmail.com> [240129 06:15]:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    596764183be8 Add linux-next specific files for 20240129
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=142042f3e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=584144ad19f381aa
> dashboard link: https://syzkaller.appspot.com/bug?extid=39a72b995ba73633c1a7
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11844ba7e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bd01efe80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b647c038857b/disk-59676418.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/729e26c3ac55/vmlinux-59676418.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/15aa5e287059/bzImage-59676418.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+39a72b995ba73633c1a7@syzkaller.appspotmail.com
> 
> arg_start 7fffd9277efb arg_end 7fffd9277f14 env_start 7fffd9277f14 env_end 7fffd9277fdf
> binfmt ffffffff8d9c5c00 flags 80007fd
> ioctx_table 0000000000000000
> owner ffff88802c0cda00 exe_file ffff88801ff60500
> notifier_subscriptions 0000000000000000
> numa_next_scan 0 numa_scan_offset 0 numa_scan_seq 0
> tlb_flush_pending 0
> def_flags: 0x0()
> ------------[ cut here ]------------
> kernel BUG at mm/mmap.c:328!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 1 PID: 5058 Comm: syz-executor310 Not tainted 6.8.0-rc1-next-20240129-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> RIP: 0010:validate_mm+0x3f3/0x4b0 mm/mmap.c:328
> Code: 0f 84 a4 fd ff ff e9 47 ff ff ff e8 77 91 b9 ff 44 89 f2 89 de 48 c7 c7 e0 af 19 8b e8 56 69 9b ff 4c 89 ff e8 ce c4 fa ff 90 <0f> 0b e8 56 91 b9 ff 0f b6 15 1f dd b1 0d 31 ff 89 d6 88 14 24 e8
> RSP: 0018:ffffc900035df958 EFLAGS: 00010282
> RAX: 000000000000032a RBX: 000000000000000d RCX: ffffffff816e2f59
> RDX: 0000000000000000 RSI: ffffffff816eb7e6 RDI: 0000000000000005
> RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000080000000 R11: 0000000000000001 R12: 00007fffd92ff000
> R13: 0000000000000000 R14: 000000000000000e R15: ffff88802c6b8000
> FS:  0000555557046380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f10ada208a0 CR3: 000000007b434000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  vma_merge+0x16a9/0x3d70 mm/mmap.c:1033
>  vma_merge_new_vma mm/mmap.c:2465 [inline]
>  mmap_region+0x206b/0x2760 mm/mmap.c:2841
>  do_mmap+0x8ae/0xf10 mm/mmap.c:1380
>  vm_mmap_pgoff+0x1ab/0x3c0 mm/util.c:573
>  ksys_mmap_pgoff+0x425/0x5b0 mm/mmap.c:1426
>  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:93 [inline]
>  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
>  __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:86
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75

I just tested the reproducer against linux-next with and without your
patch [1], and confirmed that is the cause of this validation failure.

The validation code is seeing an extra vma in the tree compared to the
vma count:

[   57.065418] mmap: map_count 24 vma iterator 25

There is a C reproducer from the bot.  Can you please have a look to
figure out what is missing?

It would really help if you had that complicated if statement expanded
with comments:

if (prev == curr ||      /* ??? */
    addr != curr->vm_start.......


Thanks,
Liam

[1]. https://lore.kernel.org/linux-mm/20240125034922.1004671-3-yajun.deng@linux.dev/

