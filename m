Return-Path: <linux-kernel+bounces-34641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3295F83858C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6AC7286EF5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85B550244;
	Tue, 23 Jan 2024 02:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VvBOuzsO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WUufoVJj"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61884F886;
	Tue, 23 Jan 2024 02:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705976993; cv=fail; b=aJkDQciix3wQOT3fjWRkEvh5eVcPeJfwwf8tISZdsjTb3XsgF7bqaDYWWC0ea8RFJtvFx02VrSdZP4AWqZUrmlLCyUND1LnWTTXzspjTXsyXjI2dBPJ4iFu3966VvEq0bBjZMlm9ZdKB/jcz/2t5kHf5UcUzlMSCQLevV6WEwcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705976993; c=relaxed/simple;
	bh=goqGNY48Qe2NVYHamgVuZW4lkrxT2RAomRAHpb4dw74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qxAXx1t/MpKa4NsbwG94xjMdJ35lmaRrpfXOquZo72l5Ym9CKP6syi01hgj7Q3fZoYgFl3CSWHJw950kBNIDEbPDk81G1t+uzhGWA5/yQClXzIhXptKcIiyWLUvShWjRhNIMzzOdhyFG7t5ZNVHrDy9XxmNC1sNpCyv09FujEEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VvBOuzsO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WUufoVJj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40N2TD8q023096;
	Tue, 23 Jan 2024 02:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=rHuphJv+tcmEa8VGe1rk+6hnxTP28V9xY/R41o5DUII=;
 b=VvBOuzsOt8r4+ETFqz7TBC3zjv8cI1vtT30Bhnn+02AbPi31l8+SDQ/nsGPIiK2auhcZ
 A1WHP1aq+4uqYrNus21sWzgPy2GzMZ7XENN9es3kh2o3zxvEtQMEpnyrk6cQIzWlpDrR
 t8RGp/hXIgu3CUgsf/gfYyo/vHacct9K/VjkbSX/s5uhI1044u0MZqX3dknYY4/i7a3Q
 GDBZNoiErt1WHP5Cdyq5ZDWXllTuCKhcNgkaSG+Cd/JJAksk86VCPEbzjm4V6KGHB68w
 gwHJXPK05aEA+SNpRYpe6Mp29yAmCCZ9EJNNhFzrp1mxo835lMzmFM/Yi0/huPOaSlTx Pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79nd7r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 02:29:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40N1N3tw013275;
	Tue, 23 Jan 2024 02:29:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs3703vs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 02:29:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZkiVHKhJNQJT5BvT1doDJEwHqMq6bv349f79LzLMCkkUR9uW9GAU/YoRRqJ0Y6Q30rmCvSMvCpt1fgZ/fnG3YKiG6nvDOFa0wQh+JV1C2x5Ip7qmXm3HEjChYAM4+J6RFGK+L4LK9mU9cpZJCm1POHPC8Pikp/rO1VidhUsIQF+MCjg2rhYAn1R1yi+mLpFxAPWoHmM1VfhS3Jm+43TqXTbFOgntXMkUC7E8y34/tjfE0MLc+yH2woYYImW9GBLUBc6fc55B2o3JJGJ8Cq63yr9O4ToaSgQYjZhIoPik8M8y3cGqtmqeIxh2fuT6wY/E9Dv1FN/mA0bmMoeWn/Eqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHuphJv+tcmEa8VGe1rk+6hnxTP28V9xY/R41o5DUII=;
 b=SjZAkDL3uNfmSfjVVATcYcHZHNGZY4dpycgeo7Mb5hqTRCuWWeHlJqav+ZioG1VZHGdC+1MwFDrLfJqh24WR8v5eFqSaJ0BiCaNgrudNs2Q4t1aYyAxeDYPjTxIFnyXNYKljFzyD4gZYZUW+2BqFdNW2TmBpVGJSIi2+ENcQNzuP8YbcsUEM10J9lDvUTLTwGAkCeHPe51eO2OZ2RM+nnC0wMoQyze7GhbgvJnTAaqQCyTDxS6hAqZn3zhjYcYms4bRJMsC1CnZPokYYjixKPLI/y6RNHll9U1Xaev+LePveFx3eT/I9V1aXO9LVunGN5wATug0QuEk0cjppP9K4Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHuphJv+tcmEa8VGe1rk+6hnxTP28V9xY/R41o5DUII=;
 b=WUufoVJjAYHnEyn3kCU4cCe9AeNkNzyjuUE6603RidbDNVVv+OHh4HVNCtNclgduTAoSEq//++OP9LqVXeH0zflXrYRydYb+151iIerbwYuK3Ifi6prIw21vuMb4pjclyAGl1iPay7VohKFFa2mbdHpD15/TYM/MuvgEVNNUIQg=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4724.namprd10.prod.outlook.com (2603:10b6:303:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 02:29:23 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 02:29:23 +0000
Date: Mon, 22 Jan 2024 21:29:21 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, linux-m68k@lists.linux-m68k.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 27/82] m68k: Refactor intentional wrap-around calculation
Message-ID: <20240123022921.77eddqhiltrpphdv@revolver>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-27-keescook@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-27-keescook@chromium.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::8) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4724:EE_
X-MS-Office365-Filtering-Correlation-Id: a380067e-48ea-405a-188b-08dc1bbb1ce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sMQrSdKjmIVLuQXURzZnLOCVeKv274+txjFjangEPUiiS6lb7dB1BCMr4w1+4+Neo/EPh/9Ml2AlkjsNBeKcFAR2rP+I+AADMADbgcI/3uW8gkJFgdj37g4exfxWQcWd11QUU4o/RrRGHSNvzq/w3RVAGNSf7dIwzLhP44GtWqmS0MMKYXgJslISVZBMVCWjJl3dKwPiV566NzCv8li1mGf2Udblix81wLKKgzc53deMH0VVm5PNlh1zFow4Nk0E4/WATlLQ20bfmOsdYVgzSD1KF6VJhN0g0Gs2agu7Otuwb/MMXH1QUVn0sbRCM5X6FCJ/n3sK1L/DcET61TOEb0qfONPcR5PhNAjYr7Afmp8K923uL42GJTB/9/NHdegXxCf7axE/XSALdFMsrttxEj4z2tI8BjUCRYZDyMKDsqH/ra0+/qlgNQJPjtaESZJEUZGVm4VaZq5pJxHHR6uzxnjtvGVFnIFX/y8rG4ybxTfXZ7eSiFHNkmo08cr9TsNBj7LUCiaG2ieSXPEz410JCQe+xaFo+MZ11/83qxVQefqKQJRrrvqeQNd4j8dLKXoTzgCWzHeKlYSyNdtL1Jy9aA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(1076003)(26005)(6506007)(6512007)(9686003)(83380400001)(5660300002)(478600001)(7416002)(2906002)(41300700001)(33716001)(66556008)(6486002)(54906003)(966005)(4326008)(66946007)(6916009)(316002)(8676002)(66476007)(8936002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rfrRRV6FfGhp3+DH6GfIl0nlMQdhO8poHj4yfbcXoVP7Gf4beX7LNP4IB1qw?=
 =?us-ascii?Q?YvLJB94he4trGkfgqbW27SAdlX6NxFv2/Y0KnS99WVWGOcUqV2+F5biXJDok?=
 =?us-ascii?Q?6euQEhcLaBi+Todw3rrF83OAaq9O27X2KADmQIhmowCgCFk0RAC2HgTEsPhH?=
 =?us-ascii?Q?+CIzL1zbiwNY4u+hLZ4Hb89PboZS8CFHzW9WMbkwRbPrnTWJpYI+i5twwEIe?=
 =?us-ascii?Q?ROl321lvNq8zoxH+k7Zo85NodiRRwgArAuJ23q6qcVCwR58LxYlme/WH0naB?=
 =?us-ascii?Q?cNz8v55nyDT865RuWd7oOu9tjUsIGslM9JaqGecKsjbo+qxt8t42rLhfabrO?=
 =?us-ascii?Q?MWii/DUMAyJ67HxfKmpQBPiW78NFsj4UscZQ83uqoJZTJQ0sAgIo5fdDCDeI?=
 =?us-ascii?Q?bMmQkIikC4kqY6sgb2zBhHgMteAHH/Y1IGe6wa0NbjcgJGhRFNlDl7OlNZkR?=
 =?us-ascii?Q?jYCga12jTpipB9zRZAhBwMkdLNGbM0hQEO0ocLXOqMVLG4/QDF/j2q2/gWF2?=
 =?us-ascii?Q?StErr3eZhNVJb5Kr8wyFj4CbhDQsmvEjCEhxend4mJkiLkV74TnPPfHHNXTC?=
 =?us-ascii?Q?TsjW4M8hccUBy+C/eGJuWQuyYMedU/GsLxyP5zYEDU+YtGpE/iEXEUJc1Ncr?=
 =?us-ascii?Q?DsyIKXMBpAp/L2A1vPR7axksWcY2Ce+qRwZUDFZCAQiKvc70wpAG7CkdEwRn?=
 =?us-ascii?Q?oVjyPqEPtnPIuSRhwrtd8hm3gW+6FhGJT+FoPR+vjapRUWrnLF7KwDPovbDg?=
 =?us-ascii?Q?wo2wbLe5GWTrFxdbVeYPOQP1lgSSpZneRgh00yZSMbAFca3RGtekYcH8/wI4?=
 =?us-ascii?Q?jq9K8jn8lPxqZo5DtDMJxHamOYlRRIgOOM+NGWkt4VkJbgbg/lteIms9AyjD?=
 =?us-ascii?Q?n6jNG32WRUYQ6pFAAsJiMlnlkUyGbauGYTlKxtKB1F6wgqkLhEUbwmnw+F6R?=
 =?us-ascii?Q?yr/bxJvuy2FO8jCRZfs3rxKpvNBthteW5cIFPa4clEfKLPpOGp/Hno9X4BEj?=
 =?us-ascii?Q?iZjMtQ55mT+NR9bG33+50bgxVCFD6aL0ojqmFpQBB9Xf2oixG+0ZKShBcNl9?=
 =?us-ascii?Q?TguFrzwUkfZu5pWQQq8V07sQqfeXbCtfCh6KihE9dVI9eQ7/UmAe0BCwupDj?=
 =?us-ascii?Q?9qXvafCUiqUwds6bFVsSDdKGBB0sJlQ7OkD2Cj9LNNuD+g/aubkHcqb0B5+A?=
 =?us-ascii?Q?jvfe9pcETii69l206UP+ISSVf6GOlbyaRVObsua/9sX+FGtZVcUEeVbXkqMf?=
 =?us-ascii?Q?22ZjgZj4vG5wFm8OUxPaU2CpRx70jWX+Am/DNPg87AWUsP0fhgHhhI2+tINf?=
 =?us-ascii?Q?SCQFXUlhaB8wJ1O1Lp7z8qivhFpTljGPWjHiGEBkiEQJTOP+27HaIuusL5kv?=
 =?us-ascii?Q?ZPFwTDE8ISxF42CzlBn6wgJGsHC0uGCFxAr7o7AAYfzcH9eUL7qC30KPVNnB?=
 =?us-ascii?Q?V0SbNJueRTu+P0Bd+zv427amNokj4/rXESgXIsVQSeyYbba8cUX2xKa6tFpq?=
 =?us-ascii?Q?YEnGVodJa0ILxt/NzhzuMf+YyTs1rcI6qFOGje5lHlrs9dVGg2p0I0TrEKBM?=
 =?us-ascii?Q?hQ54akU5wlQem1is9T+u142eirMRZggAFrmkfyWO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LU0p7E+7TAC0tDpXpI9cyv+0F4VPxdBzNyK6HzT2BamjobSp8NoWVffTME/S7/C3nTVmPa/YWW2KOrRaxUHVer+fBw8bD38hINsWFi3j3MoQS0SZlG08Ren8O8dDz6YdcMpIZ+cuizxR1YllhYLRK3qlHM952XEB+J6MhzGV2iePBlvE8cgASaehxgJgXEveauXykM5ey3FNtR9aoioWFDbxt1+H1nLeioYwTN0Bf+IWqSsvJuStrFsVLRI6fiuawwShXtv7yBuBS1SUklw3lYV2/2fxCFZXwLvRODI0WffJqOifAFBl61Y3NA3CSTKqN9db0fKoAwSLVU2ELAl8YvT6wgsSDbR9DDJqc91yt/8YtC5AwDVy+shKIQ3hkrIg9HGZph2BzH0Eop2/f/FSVMTfQTFY+K8pSVW5aM3BidJtBh2LB0QeG/5KRirVpD0VqCgpKK9UXdPbKQk7ADfuNpIgu4SjaIpjJSFb8NGxQXar6bqdtaDFHhatIg9/I9j0MG/X945GqvjI1ZS1mvknyQLasrEVtgeS8T8ol9wq3QH0TK1qBiV6nSOD1v430DAEpmlnVncdaKX9Y1T5g+Mr+vVH6fdstt7keoKs8VG5nGo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a380067e-48ea-405a-188b-08dc1bbb1ce2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 02:29:23.8404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4AKez4scciYZ7ghOVcX2VPNz3qkpWtJGSF44xpJMY42KnsAr/Oi7cnmiEV9NEXxBYFDlrfT8TwWgfS65ayv6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230016
X-Proofpoint-GUID: hpPZy6-0mUj1mKyhjCQuSKItHibNI_Wp
X-Proofpoint-ORIG-GUID: hpPZy6-0mUj1mKyhjCQuSKItHibNI_Wp

* Kees Cook <keescook@chromium.org> [240122 19:36]:
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
> 
> 	VAR + value < VAR
> 
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
> 
> Refactor open-coded unsigned wrap-around addition test to use
> check_add_overflow(), retaining the result for later usage (which removes
> the redundant open-coded addition). This paves the way to enabling the
> unsigned wrap-around sanitizer[2] in the future.
> 
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: linux-m68k@lists.linux-m68k.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/m68k/kernel/sys_m68k.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/m68k/kernel/sys_m68k.c b/arch/m68k/kernel/sys_m68k.c
> index 1af5e6082467..b2b9248f2566 100644
> --- a/arch/m68k/kernel/sys_m68k.c
> +++ b/arch/m68k/kernel/sys_m68k.c
> @@ -391,10 +391,11 @@ sys_cacheflush (unsigned long addr, int scope, int cache, unsigned long len)
>  
>  		mmap_read_lock(current->mm);
>  	} else {
> +		unsigned long sum;
>  		struct vm_area_struct *vma;
>  
>  		/* Check for overflow.  */

With your nice self-documenting code, you can probably drop that
comment.

With or without the change,

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> -		if (addr + len < addr)
> +		if (check_add_overflow(addr, len, &sum))
>  			goto out;
>  
>  		/*
> @@ -403,7 +404,7 @@ sys_cacheflush (unsigned long addr, int scope, int cache, unsigned long len)
>  		 */
>  		mmap_read_lock(current->mm);
>  		vma = vma_lookup(current->mm, addr);
> -		if (!vma || addr + len > vma->vm_end)
> +		if (!vma || sum > vma->vm_end)
>  			goto out_unlock;
>  	}
>  
> -- 
> 2.34.1
> 

