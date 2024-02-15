Return-Path: <linux-kernel+bounces-67465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CD1856BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE781F21461
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596C11384AF;
	Thu, 15 Feb 2024 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XJQceDhU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O23wHTHk"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588D1135A40;
	Thu, 15 Feb 2024 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020202; cv=fail; b=kKp+Qu1Xx2xT04uVQHE7Qh4lY1IzzYvFmiAkbVyvzUxmuWMPwr7ZBiNKPhclcr6KqF2B9xYG9q8B7Df+Sqjrhs+F2m7ulOX6IOGZ7VF1OXlY/bM1pUT119kWmzdlJP2YHQD5fgJXY8joqdJUNfwVC9ieOB4YJ44gj5xo8TPHZCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020202; c=relaxed/simple;
	bh=1BTgm3tHP3MCFnMnp8Gsp5isSQ3Hc2uJxrM7Wf5QQVY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iit5S77RQhqE/pPsCGqtNB87CeC931e8dgoWsTTot6MxJCZD4zFAsecpUta2NNtPqRjvfVi96LING4ih4zqbDPjm8Oow9AcRTvGBsSwxpKnDt0yMRwoI1R73KXlN4gqWFyrWY/XvCaR+kod10ibJBMHdyju3hFYcO2lodDGrd/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XJQceDhU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O23wHTHk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFTABS006064;
	Thu, 15 Feb 2024 18:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=QvBPHZ4rmuqcRLtjbz2o5NY+9rTbEMPkaFZREIbezpk=;
 b=XJQceDhUf2ZirU9SiqcEjvSO2j1Yg3RMZ3RmmQUK3trb1hHtWb8kpEYgLeGBeOrGykbF
 XxZXU1JzPJaMrSqTzO3l2J4bISDe9nFAfYtRaMq4qNu1Uzx+BNfzntZUUlapu1dRkf1k
 R6LVmMqTsi4YEh7vejs11m9BAaLTL8CjzzOBsTa6R6MasqVc/kK8nft+pGO/uUa6hq59
 eDKHqpB5h+cKmJirpXk8wiepqMCpM6NXK9Fi143lVHQD3S3JihMEUghmzBDc790Q6TpV
 osNAS8WGK7ZTe+5bvt0LzeaA/Dam0l+LyPlXbumg+3B+9E7g86uiyyp2V6PiqOwEkiGl Cg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92ppjvue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 18:03:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FGufII013780;
	Thu, 15 Feb 2024 18:03:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6apdsmqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 18:03:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIHxYYeDQQl0087L3i3X/FeY2reYiZr6wH3m7xr/KizBC/PPBy1PXFHdzo5VNrCA7NIHXdIfsItK27uDDgI/c2MkF4Lp3D5Zmi2FRkgou0JQ/YpuWCBfLX7njE40T9t7IPugcxOVdVhfHWcnYuT3pd2WdoDymnmfh8WAsE4VRaub8nR7o9NawBpNvtJlM6SvsZJqdSG0AgY/vvgMsGY37vF3fS/91cgsltzCT6bTtasGR6dMC4yGnCbjXDynj4dzHCkARny+PBA81ujHacfPQ0uTOer0H9uuvn6peYPOE9D1BD+rt0u0pnnAp97NeeAkgMnn2AmahkxidTqUHZowtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvBPHZ4rmuqcRLtjbz2o5NY+9rTbEMPkaFZREIbezpk=;
 b=C6wQoGp926h3kXjayVGqc9YEQdK5Oq8sHgy9Y3SRHDl41BNXRThsYeTHvn7o11cxB0B1q2TQ6CMoCq1+FISBlk74DAOImYKHlUXocCms8NJ/h8Sn7OVpqbnF7V6abgmtTMvCMAj32ppYBkhwIlaJVvrAfrM27KUihZBwrH0S65rdbXvYwOfhPFe15YH0rTK7eSZwV//Lg2zgJqFvfVuyM+OBG6zX+7HkGJLf6einL/uMKx2GdFL3H8BejxXlCNC1qbY/06ULK+WMsL0FlupT4Tr7oqy1mH6z5ErZoCTRkQQ04ljs+XNzBoUEltIvp6h8iCCM+Wq/8uPimH808AzUdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvBPHZ4rmuqcRLtjbz2o5NY+9rTbEMPkaFZREIbezpk=;
 b=O23wHTHkCc8S20k6NZTxVXR3Ykr64EiP8rpW7v4lbuI9hFPR+4ysW/8DjOOBTpz44gGX4gHpZFc76gNMELkkCcl/wBVMUstzXmDSj2kc0/zRI2Bn2gHHAeuiyUs/BCwX0s5YOrDh4hChvlvSABzWcYwrVd/qeXlS39c4uUjlwfo=
Received: from SA1PR10MB6445.namprd10.prod.outlook.com (2603:10b6:806:29d::6)
 by SN7PR10MB6500.namprd10.prod.outlook.com (2603:10b6:806:2a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 18:03:05 +0000
Received: from SA1PR10MB6445.namprd10.prod.outlook.com
 ([fe80::f51a:7f6d:973d:c219]) by SA1PR10MB6445.namprd10.prod.outlook.com
 ([fe80::f51a:7f6d:973d:c219%4]) with mapi id 15.20.7292.028; Thu, 15 Feb 2024
 18:03:05 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
CC: "andy@greyhouse.net" <andy@greyhouse.net>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajesh
 Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
        Rama
 Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>
Subject: RE: [PATCH RFC] bonding: rate-limit bonding driver inspect messages
Thread-Topic: [PATCH RFC] bonding: rate-limit bonding driver inspect messages
Thread-Index: AQHaXwBJpRniMP9JNU66kt9+kpIT0bEKKuqAgAGI0CA=
Date: Thu, 15 Feb 2024 18:03:04 +0000
Message-ID: 
 <SA1PR10MB64450CA1D56F8873331615BC8C4D2@SA1PR10MB6445.namprd10.prod.outlook.com>
References: <20240214044245.33170-1-praveen.kannoju@oracle.com>
 <7713.1707935675@famine>
In-Reply-To: <7713.1707935675@famine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB6445:EE_|SN7PR10MB6500:EE_
x-ms-office365-filtering-correlation-id: a1db4926-c8d8-4871-de35-08dc2e505bac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 YarJOegVNWaSJdiL0rbSEqagY9zcLIZzjFxqgE/MGXK0/Fo26ToGCjY0ScCHhrH75ULYmqj+AjvMSGnEisfnqavagtDo7Id7bRXwKpl9PaioOD2Y6/3YGW7EnYE4G8vHw6LCpl+Ei5qvc1nFR24r+Z7NvCWdnw6Fg+J2eHO21wMyTMtbX1tzDgIgF641Lo4heHI6Sl5yekT45oI/bwIi3XapaVlEJIzjhtNdn0D/mPzNjAILfkuKGjQOT+7vbWz78OtnvME3XbLjo0MXBQnhL8WCmvkNGRiXueyhC0vUANvxKoVbxQ7HOvCp54MXYgR/4ovZpz97zJA/VjPEbjU/t//InPTtfWzsNlnP1NqlgUZwb9LF/nr3gaQobuOUmT77VYfkZExUEb1tcOpne87pjgC9MoPZuA9QE5mgthv9xNNuLsaN9MxhkVoDrrQbd7zbqtAgxkSGF6kxiDKkcJVPqZStHYB3RBOKZ7tOX2rTBrw+vMX9RW9Uxt5jaIlCu7/eF4I5crCOeGIMa33CLcrcRS6oYsTyrFsQhPx5UpAbFEHFgUp3HB8uBopkNaRBtQJcd6vio18vwdW7Y4RYuz1A7mJalwxHxj+puiL5/eOi3jIgMRVlIEdgr5Aphuc8EOqy
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6445.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(55016003)(316002)(71200400001)(54906003)(15650500001)(44832011)(2906002)(5660300002)(66446008)(7696005)(66476007)(64756008)(86362001)(66946007)(66556008)(8676002)(76116006)(4326008)(6916009)(8936002)(6506007)(478600001)(45080400002)(26005)(38070700009)(83380400001)(41300700001)(52536014)(107886003)(122000001)(53546011)(33656002)(9686003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?eNB2lj3eJPoGmLbSn6+HtQVT0caEGVD0ZD+4Cu25PF6RcjqBRgtWYlusbEi2?=
 =?us-ascii?Q?cKSlNBGYltG5JJJMNSBSQ60fIDB66gLhIgwS6D6Qv0g0MmtJANXFot+se00+?=
 =?us-ascii?Q?n3VQJShTUilP/myA0hwUG4eSRnOHC2nL65kUmL0WOs6pP+yzHORgJDF1WKVH?=
 =?us-ascii?Q?QMHCyUsztKk2QeMzgEVtrJk9L9WX3AdhRs6EYQ86fJmbCIaL2X03sDarwDtx?=
 =?us-ascii?Q?4k3t8608SKPzcjO2m3XAlsHc4pODxfxVQSkLS7V9cnmcuDN2DqaC+2GE9c+h?=
 =?us-ascii?Q?izISV/F7M+ZqcljRG7QZ2zueZTUtWRwgRKMzxv1L0P+4S64SK8viKQykME8b?=
 =?us-ascii?Q?vJv9GZDCWAAvioJ2HIkpa8SAOwCv+xbWe71dEOG3TxCOmmoUCRF7ZEAk/ZGa?=
 =?us-ascii?Q?AglcDIudQ3bsc+su0uRrdlsKS5hr+yVA1gSfUfhWkMbBv2qMR3/AZ7nyKP/+?=
 =?us-ascii?Q?+jFhjgmwpH8gPfHT2kfS4y+GGAXFKkgY8UzZ3258785tTdmySEdnmXpxZxJb?=
 =?us-ascii?Q?F3VTeZJhe3jNOijYV32k3Qeo72zwLH3Fp2KK+Dzz70aIC2M+LhZ7kGD+iyjs?=
 =?us-ascii?Q?s76K6Dd8/BlPf1BgNJQyab76FLfQ+cThOb0OULYjiWCabqzVLDcQ42lpsxfH?=
 =?us-ascii?Q?BGuuvkU4PYJjhjw4jYas33vzy7ZkdVQlPw9UOE/O3+Q8F2I5mWj8Qs6Fcc4g?=
 =?us-ascii?Q?4t3QzhmTNhsP7hwDDbSrbyS9FK/8Zvf1SgVvJ4MNThE94J2X8nDqbfiCxzCD?=
 =?us-ascii?Q?en1CB5qBNDg5Xlwu2E9I0ymC/5lmHKCc3oTT/wNUQe/LLHhwGrBkisrHOyzA?=
 =?us-ascii?Q?l9gil27ncG1RkuweivInfqBYLG7XOOMCSe7ZSGvzMnOY/5Fj8/c5l88w+fsm?=
 =?us-ascii?Q?0LI0FVSqTnKssoo7QreEaq3UgUqRsJ9SFQyteKnhqFTjOuojJ20ENRPou1l1?=
 =?us-ascii?Q?W8O0vDQ59bmElnFhMklhYoFLuRsLre8h0Nw+CedJI2hTw/r7T4GZycL3t6Ae?=
 =?us-ascii?Q?3Ia8uhrKq/JFhMfpW6y30+4qg8vR4q9ap6dOzV2uc5VIMMCw+34PoqOUstM3?=
 =?us-ascii?Q?k3UmDi7kVxbhDnCenX7rOcRrok21ZSyzl+zIOmyPoheGH4kEKL9attb+R+Xy?=
 =?us-ascii?Q?oGgFaowP2E9LGVQNK5UmkPMToUbBQJdVcw1+oQ6c+H6OZd3Rj8J8vqNoBtwh?=
 =?us-ascii?Q?g6dMmsPPRuTDFxvQ6ZmJYKPKNHGvRX7eF+gHFl3UpAQPEbRKSgv+pOIoiTQW?=
 =?us-ascii?Q?CpT/ws/I/Upa+oExH1us6iQHhn1F3c+WyeBg5+p8MJIP6iH+XEKAoUlL0iEJ?=
 =?us-ascii?Q?eh1fOUn8GBqGhp2z6vtq4zAafRRhiZzFP0DTz4dKv1V3H1l/RhPwYnNvfwsO?=
 =?us-ascii?Q?dTPlLiOJfPNJlSshOBR0yOmnNlxxbEvwViVjnRdBbT8otAWnVdRFRwSV9Ubm?=
 =?us-ascii?Q?oBkKrnBRtAnLttRr2OR43CQJyQTJBtgS+g0s4qMWl2OSRs03PkjE5lPUQrOE?=
 =?us-ascii?Q?MR4kDs7Ix0YcLQoTyrf2D9688zGzcyiYB0ZNvFW6memcpgS4KOYJJH3IKk7X?=
 =?us-ascii?Q?+92sYAwEhlGTsnKseIiDW234dKIBFKUhLyqhIyPx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GigghutEUAAfUhEOCE98jK0HzLlPLDCdMkj3sTtruXplcbNjelrAnvz1pWnuHmfJux6XWlanVIiDgXrrci/LxhWqtYnOKogHvrYGpxSuuEyYtBn8NR/Xb+V2XiQ3vIi8OrnbIOkBN9cAATiXkovOnITtNdlWDCaeeT3j11AYloAaQr5mKhhwHMryd6+HjwxGekodWzVUoSONBSZqXZshNFW3CpP5JoMqz9xWbYqSAiNo77yzGvdieHN61DUxuEie4JGESGYy8Z0axLDxzLdRj3O1poH9j5o+Ovz1PXmstYJ3q+izMHSbtz4pP6h80t/NiOMnDGB5DxLnMvrSETThRIiE8IG7XcbR8G8SYEGwhM+P4FsnHk6xXFMnfl3VhV4lMJc27VbrXGYGtdBjhxe0fErI6xvtSqlrGSdkFl4bsTQ8lj5UsFDTA/kuOwiQ6nXIxwQi5dntDZgDbYW9lTGdJwlRq6oBQSvKGwdUs+x5P6L9r2jmrDiIQlJe3RZ3sHb1nwYFpSTaKL4m7e+1Du9gsTTOEIZj5gitg14qBhDwh2rQEs9buwja7VSiscpcNrn3XJHF1b0xWqFBQ7tnvUvUQhK7g9w+5k3/iwTgI8uz2u4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6445.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1db4926-c8d8-4871-de35-08dc2e505bac
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 18:03:04.6689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWy4tGJzVk/xf9T9KS2FouvGk4iViPTtUd29SVCuuy8bFLRvJ0nV/6nG15TLfABmC4hqAigFHPIbfLaFCpFiZaDaANLDTjYi0QSf+2Cz6A0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6500
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_16,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150145
X-Proofpoint-ORIG-GUID: MxZrfzNWF3_4eveI0a2jmUvYIhyb1Ahx
X-Proofpoint-GUID: MxZrfzNWF3_4eveI0a2jmUvYIhyb1Ahx


> -----Original Message-----
> From: Jay Vosburgh <jay.vosburgh@canonical.com>
> Sent: 15 February 2024 12:05 AM
> To: Praveen Kannoju <praveen.kannoju@oracle.com>
> Cc: andy@greyhouse.net; davem@davemloft.net; edumazet@google.com; kuba@ke=
rnel.org; pabeni@redhat.com;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Rajesh Sivaramasubr=
amaniom <rajesh.sivaramasubramaniom@oracle.com>;
> Rama Nichanamatlu <rama.nichanamatlu@oracle.com>; Manjunath Patil <manjun=
ath.b.patil@oracle.com>
> Subject: Re: [PATCH RFC] bonding: rate-limit bonding driver inspect messa=
ges
>=20
> Praveen Kumar Kannoju <praveen.kannoju@oracle.com> wrote:
>=20
> >Rate limit bond driver log messages, to prevent a log flood in a
> >run-away situation, e.g couldn't get rtnl lock. Message flood leads to
> >instability of system and loss of other crucial messages.
> >
> >Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
> >---
> > drivers/net/bonding/bond_main.c | 34 +++++++++++++++++++---------------
> > include/net/bonding.h           | 11 +++++++++++
> > 2 files changed, 30 insertions(+), 15 deletions(-)
> >
> >diff --git a/drivers/net/bonding/bond_main.c
> >b/drivers/net/bonding/bond_main.c index 4e0600c..32098dd 100644
> >--- a/drivers/net/bonding/bond_main.c
> >+++ b/drivers/net/bonding/bond_main.c
> >@@ -2610,12 +2610,13 @@ static int bond_miimon_inspect(struct bonding *b=
ond)
> > 			commit++;
> > 			slave->delay =3D bond->params.downdelay;
> > 			if (slave->delay) {
> >-				slave_info(bond->dev, slave->dev, "link status down for %sinterface=
, disabling it in %d ms\n",
> >-					   (BOND_MODE(bond) =3D=3D
> >-					    BOND_MODE_ACTIVEBACKUP) ?
> >-					    (bond_is_active_slave(slave) ?
> >+				bond_info_rl(bond->dev, slave->dev,
> >+					     "link status down for %sinterface, disabling it in %d ms\n",
> >+					     (BOND_MODE(bond) =3D=3D
> >+					     BOND_MODE_ACTIVEBACKUP) ?
> >+					     (bond_is_active_slave(slave) ?
> > 					     "active " : "backup ") : "",
> >-					   bond->params.downdelay * bond->params.miimon);
> >+					     bond->params.downdelay * bond->params.miimon);
>=20
> 	Why not use net_info_ratelimited() or net_ratelimit()?  The rest of the =
bonding messages that are rate limited are almost all
> gated by the net rate limiter.
>=20
> 	-J

Thank you for the reply, Jay. Yes, I agree. Used net_ratelimit() and resent=
 the v2 patch. Please review and provide your comments.

>=20
> > 			}
> > 			fallthrough;
> > 		case BOND_LINK_FAIL:
> >@@ -2623,9 +2624,10 @@ static int bond_miimon_inspect(struct bonding *bo=
nd)
> > 				/* recovered before downdelay expired */
> > 				bond_propose_link_state(slave, BOND_LINK_UP);
> > 				slave->last_link_up =3D jiffies;
> >-				slave_info(bond->dev, slave->dev, "link status up again after %d ms=
\n",
> >-					   (bond->params.downdelay - slave->delay) *
> >-					   bond->params.miimon);
> >+				bond_info_rl(bond->dev, slave->dev,
> >+					     "link status up again after %d ms\n",
> >+					     (bond->params.downdelay - slave->delay) *
> >+					     bond->params.miimon);
> > 				commit++;
> > 				continue;
> > 			}
> >@@ -2648,18 +2650,20 @@ static int bond_miimon_inspect(struct bonding *b=
ond)
> > 			slave->delay =3D bond->params.updelay;
> >
> > 			if (slave->delay) {
> >-				slave_info(bond->dev, slave->dev, "link status up, enabling it in %=
d ms\n",
> >-					   ignore_updelay ? 0 :
> >-					   bond->params.updelay *
> >-					   bond->params.miimon);
> >+				bond_info_rl(bond->dev, slave->dev,
> >+					     "link status up, enabling it in %d ms\n",
> >+					     ignore_updelay ? 0 :
> >+					     bond->params.updelay *
> >+					     bond->params.miimon);
> > 			}
> > 			fallthrough;
> > 		case BOND_LINK_BACK:
> > 			if (!link_state) {
> > 				bond_propose_link_state(slave, BOND_LINK_DOWN);
> >-				slave_info(bond->dev, slave->dev, "link status down again after %d =
ms\n",
> >-					   (bond->params.updelay - slave->delay) *
> >-					   bond->params.miimon);
> >+				bond_info_rl(bond->dev, slave->dev,
> >+					     "link status down again after %d ms\n",
> >+					     (bond->params.updelay - slave->delay) *
> >+					     bond->params.miimon);
> > 				commit++;
> > 				continue;
> > 			}
> >diff --git a/include/net/bonding.h b/include/net/bonding.h index
> >5b8b1b6..ebdfaf0 100644
> >--- a/include/net/bonding.h
> >+++ b/include/net/bonding.h
> >@@ -39,8 +39,19 @@
> > #define __long_aligned __attribute__((aligned((sizeof(long)))))
> > #endif
> >
> >+DEFINE_RATELIMIT_STATE(bond_rs, DEFAULT_RATELIMIT_INTERVAL,
> >+		       DEFAULT_RATELIMIT_BURST);
> >+
> >+#define bond_ratelimited_function(function, ...)	\
> >+do {							\
> >+	if (__ratelimit(&bond_rs))		\
> >+		function(__VA_ARGS__);			\
> >+} while (0)
> >+
> > #define slave_info(bond_dev, slave_dev, fmt, ...) \
> > 	netdev_info(bond_dev, "(slave %s): " fmt, (slave_dev)->name,
> > ##__VA_ARGS__)
> >+#define bond_info_rl(bond_dev, slave_dev, fmt, ...) \
> >+	bond_ratelimited_function(slave_info, fmt, ##__VA_ARGS__)
> > #define slave_warn(bond_dev, slave_dev, fmt, ...) \
> > 	netdev_warn(bond_dev, "(slave %s): " fmt, (slave_dev)->name,
> >##__VA_ARGS__)  #define slave_dbg(bond_dev, slave_dev, fmt, ...) \
> >--
> >1.8.3.1
> >
> >
>=20
> ---
> 	-Jay Vosburgh, jay.vosburgh@canonical.com

