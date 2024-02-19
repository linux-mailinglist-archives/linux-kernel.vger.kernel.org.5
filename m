Return-Path: <linux-kernel+bounces-71280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD42285A2DC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E4C1F22F79
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848112D611;
	Mon, 19 Feb 2024 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jqWAchxz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nremq0Hl"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4B72C6B2;
	Mon, 19 Feb 2024 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344524; cv=fail; b=QTQLY7EUBgvAX5URF76RQzWpiWx/MdEBEdXWkx8Ws22mywRfTT2dBGFrZ1idFCHLHTgW6JVq5C51Cee+Wc7ItAvRyeqOIrM7zGfdYR/8pLt01AKunC+shgkqlirDALYcBbQRQ0mfDY813W5Y65D5CxqAXG/fjSRYU/4DoOhlz3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344524; c=relaxed/simple;
	bh=+1MlZloFIcCWMfXSfacTbTRXdlvXZrRf2v+TK2xGpew=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iQm/a/HfEMInCFqL4Sglns3q4+Ws/y5kk3hCfKLGt9Dk24T85pcrzAMiu2BUmEPYwcQsaw9NsddzUeTPTfL6vPVuvAi7ibM6EQDxu7+rn7l9kFOERX8JxrcNE/N56/j6m6jTyi6F2MtHPmjamiWmEYQFH1L7aulV1a02cNqH6vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jqWAchxz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nremq0Hl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41J8OQRX024900;
	Mon, 19 Feb 2024 12:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=bdKOaxnY8lE0oMuXv8cbuyv5JMF1RdcjjKjJUx00y+A=;
 b=jqWAchxzpBcrGDVNAuTzOzIreQE8Ax70tNq1U/qx+EmyChAKbyn27LsFVog9wVeG5Ej1
 mSIEXg1SH5kXYIt1wPPXqTT0rEK14nLFpxG5mOkzqzg7EQ81UxJC8EuXe83ynvR89uAl
 qZIbJEytfxHFq4gbUebQsJQbZlEQT04FbG+jlHIMs0oI3bRnm872BXSXNX+ppw1ihx1D
 4xc0DCU+Shn7rDAfiY0gZ5yV2vHwh5B93pzGsWaKWxUtIctXAFgAXzqDAk/Q54DMNWPL
 c0PT8b7GyWlqPYWx3Qukc6avByQy672kPKxj0dKx/nPaOAvYIRlABrO73Ch1Sfd5F/sV hw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wampauwp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 12:08:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JC3oda014795;
	Mon, 19 Feb 2024 12:08:31 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak85tw29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 12:08:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZUZT0HlLuj3uya9vFibp2cf7zgyIyCSMusGWF5xN17dZjG001OcQq/xre0+5TcDrHkJxL7GI37eMrc8CKtrFc3ZO6rF2nvfCp5a6/Adj1middyvhespVaf3fGZ6Aoz6AOw60j6YBZW96+rgQjzhyPxzQf3xC1AYRpQxZE6py3zGUpaVMB32jp8nhVdTiJ9cj6gVS8AaAHZvhhhc5BgNvG57DD+iKgwp1T0i0M2VhQd5S25Lowi3SEHO8SRMfiAWREaJ3rTO2M9a34S1mthv4Be14lRdLAPek4o44bDpvL/Gr+fMqFgljkjATFSckaPIy91LphnGrw9v/mI2ly/2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdKOaxnY8lE0oMuXv8cbuyv5JMF1RdcjjKjJUx00y+A=;
 b=oNjY419dlLVL8ZIV+3LetawkYgSEncYqRwhvFvTUjHpOWJfIqjIxfdFUxEfTub/3GbDss97Js60B9DucqeC7KVrTrPlOOIKdjWanprMGofpE0hFN/jPJ2GKOkEuo5s94SelA3vYU1Ysuv1mexEKg1yjgnKX88ExiOf7VRGqAB0gKM4o14o7PB9szywjHNdNLejdZvy169PiXZoToSG6ejUQ2x8VoO2xUgQAan3ms7SLnB2lo5BbF0zbu7WiuyTWKb7Bx+smYlsUh58dNSifrIiE0XvVeuLG7BRDY4Uqgzc3bU1ZeF2lMDm5Sai2otemHtLlx2lwTO+YpFh+pjX2/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdKOaxnY8lE0oMuXv8cbuyv5JMF1RdcjjKjJUx00y+A=;
 b=nremq0HlYuu/DdnkFz8NJOgH6yoECBbUI/SqMHL5BxPwX1YQQ4gJ84YEE+dl6DcoTsej7UgpFXIhoMsTKE3itlKPzr1UTOYTjcB/ry97zTljKlhrDocEvD06kF7l4FAgTq5V/dD8cbetbhKkhMo1IaRLMLaLaf9ei7V009n9SSY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6883.namprd10.prod.outlook.com (2603:10b6:610:151::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Mon, 19 Feb
 2024 12:08:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 12:08:29 +0000
Message-ID: <96bb914c-79be-4867-b59d-62f80dbcdace@oracle.com>
Date: Mon, 19 Feb 2024 12:08:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] scsi: mpi3mr: reduce stack usage in
 mpi3mr_refresh_sas_ports()
To: Arnd Bergmann <arnd@kernel.org>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ranjan Kumar <ranjan.kumar@broadcom.com>,
        Tomas Henzl <thenzl@redhat.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240123130754.2011469-1-arnd@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240123130754.2011469-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0128.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: 48700eed-184d-4bd6-827d-08dc31437be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WJlIyLHQJ0gEbOOE3LAdO6AVy9SbtDra/P7b8hqrliX1VMa27yseOHP0s5WqvFfVAmo3z297NrUyHRD9sCTzuBK3jdHBCjWx5Trj0hBL5N9NqGVJC+orB+Md4PzbT21MLEEMLKlA4cWq44QT6lIctg3QZfrYtKlht7zSbUuB29E1K5sy/LDMJcnTHp4nsgGHEsfwh/beO/r+GrIGSMsvnpiiP43YQ+rCfSoUB+Uk3u0wwwFOoM9OULnVbkLL4Y5KLId23kTr2F8CB6g+dkSJ3r5MDgi3NLhBv/vppnvx6rMWHnQdKBqQZSnxhTamTVX1waWAwwylkEcTgCGzQsEiRopXedHASAI2wVQIu8OByLBqA1mwefwXIeL6q5RjLz7goD1TRZjSrSqKUdjBUurOoyfsnB1Um8wpRK2HclEDwxadzr0i5LlLCoYxN9UXskYrJQbRsKWUYZcevJ3pjmh3l7X2YBGjKZyyF/p5yeXuKVdEuYuIw3KeGP695bLSRGdNNOza0+UYQ4lDheU97joWlQBz1gQhc1e6v3bDtKH724Y=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q2tIUGxQYjl0cFc1TDVKWDFtRVFMQVRFaDVaM1Z5WW5QV2xqYWV3dXJhNldD?=
 =?utf-8?B?bEgyZXNtMVlSVy9acGY1TGFpOXZDc1BBZ3lJMCtvVFNlMUhPVVBBMDBhUGdr?=
 =?utf-8?B?NmlIS2FYeTVDM1FzYUxBU1RLM2lUZ2h5ZFdKcmRCbk1CZ3g5MTJyOGx2YjJF?=
 =?utf-8?B?R3N3ZkxUdi9tY2VZV2pJdXJLc3RhSzEya2hoZng3cDNRQ1ZuODVheHl2a3A5?=
 =?utf-8?B?V25yWktseVZVMExmcXBsU2psbFMyTGdqZEh4RHZacjJsVGZKTDMyT1Y4cGxo?=
 =?utf-8?B?aDRtdVVtSTd2NEhOVVFOUlBMNHp4OEZ5VVdxV1BaNHF1bzA3QkttRGRpMTVB?=
 =?utf-8?B?amcxSzhEVENUT2Z6NGR6WVpKb1MxS3U5VGZjdUt5TjNrWWlEd1Zzb1NWRkU2?=
 =?utf-8?B?QkdrVnpNQmthZFFoYVpCRUdDZHpIZmU5a2lnSXpjM3FEclJHdktyaGlsbUN5?=
 =?utf-8?B?bWVvR1dtUjN0dTRIOFY1ZFFUaGNPbzVBamZ3b0hUdWtOWkM0TDVEa2ZlaWEr?=
 =?utf-8?B?ODVGeVV2cVl4Vld6dmd3ejZGaUU4UW8zYnlxTVVDZ2Z1cmc2U3VNd0lBbmkz?=
 =?utf-8?B?VzFSVVA0aytqdFpuQkxmZ1l5YWdTcVJpeTJDQ0R2NU1kOEIyRkFhb1JkZ1kz?=
 =?utf-8?B?elFkcTBERklLNFlDUFFzVFRnaUU5bklQZEJPa0J4bXNPb21YeE9BM3VEYTFV?=
 =?utf-8?B?Z2VPVVdqM0xNR1F2ODBTSDdwYytCTXBXaGZZeU9yM0ZXOFdDMlhqOHpwNGVn?=
 =?utf-8?B?V21vT0NpOC8yaUpQMU92Tk50cTZ2VXZHdGpQSFI3NzZJOEpjUWxqdTd3bnNm?=
 =?utf-8?B?MUNiQ3NTN0pKUU5XdmJCUTh5clhDa3E3VG5jOU8zWDFrZ0dITEVSMWgyMU9P?=
 =?utf-8?B?Z2xMMDhqOXlrcjBzemVpRWhDQVlqc2w3V1B0UDZlVHdKZDhFMUVTemlwdnV6?=
 =?utf-8?B?MGRzaGlQb09BTTBiQ2t4QlRPbVQrMEhWUFh3Y2J5aHNwZzNQQjhDQW15d3ZU?=
 =?utf-8?B?cmk1SEZzcGVBVktnSmkvd3JSMTdNVjF2UWJ2dWtxV3g4Sm5KU0RtdkppNlU5?=
 =?utf-8?B?ZHRnQlRTZmI5U013VnhvOWhyS1JWR2lGRzdIVEUxMERuVlRVaUl2U2dJR3la?=
 =?utf-8?B?RjJsWnQ5NW5WbXdLL0d5eFVVZlJIUWgxMFBadExtZkhibEh5VGNrb241OEdj?=
 =?utf-8?B?UFJLa2tRR2tJTUlZVkh4c08rb3VQYkZvZS8yTjc3bktmWWNibzVxNVFVV2hz?=
 =?utf-8?B?eDZWajYrLzhabFRiMlFJN2RMT1BiTmNEcEFBdTdpT1lNeXNkekRJUnpqbm5P?=
 =?utf-8?B?VHNOTFF6R1c3L1JqRHVBbGtjak9qYVJiYUsvMUpKT2ZiRkNKdVltWURsNmhl?=
 =?utf-8?B?TEVxRnFKN1M5aXlrQXdBMjl5SDBlbEFtd0x0V1BQb2c0Sm9yVjd1SGJTSVNE?=
 =?utf-8?B?c0NYU2U5Y2cxcUZrOTBhbWo0YWxFZUpYM05ETnB5MUxkNjJZVFBpZGlVckli?=
 =?utf-8?B?cFZoMHJyZGVwYVpVWWpmUnBBY2xyVDBscFlOMzRRZHBLQzhTcmpBa3ZYNGdz?=
 =?utf-8?B?ZmlqVWw1ejNsSHZVWDA4OVIxUEl5WnVYdVdVYitENll6MFoyNkE0dmdWbTVy?=
 =?utf-8?B?VnI5aUpNQzFZaXkrWTBvaytlaEppUzQyZVZQNk5naVpmUkpOVTVqWXVCZjZZ?=
 =?utf-8?B?V1pMbmEvZmxtTnhQRmM3Q0diZ1hoVG4vanVVN0NwdVMySWNxNnZvRDNSRkkw?=
 =?utf-8?B?VkJENndMRlN2SjdjSVV1OUpvbUF5RkVBSFpFamZLYXB1ejFKbWVjYytid2xG?=
 =?utf-8?B?SGFsRGxST1AzdEd6aElIQnpYRkhnNHRscitoQjBRV000QUJGc1pOWndjSzNm?=
 =?utf-8?B?eGIxaEdMM0l0aitDeWE0STAvbkRSQ0lVOGtXRmlSWkVPUFlsOXo2MlUyY1pO?=
 =?utf-8?B?UGlpWTBOYWd0dU9XcUFOeHN3KzJ0TGxmMUtmOG1nOGc2UFJ2bnZEOHBZQmdI?=
 =?utf-8?B?MmhFWk9ReElLVHh0RWN4aVRURzFWR1Bxd2pBSXpweHRwT0lkdlhKTDNxK2xH?=
 =?utf-8?B?VFNFK1RadGlLakwzRmJDRVRxVXBCaDdXZ2pYaGJIcmZITlFod2l3ZzRKV3Jm?=
 =?utf-8?B?YTFYNGtSakYrNUx0V21DV1BneHkwbFJESVd6eG93RVpMa05DTEc3aUFRNkgx?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Cm6bjyPwrq/JYMaQZSoBFMlYRGR06EvpDMGApU0UqPAGuA2fy3RJXFgrGiliJQaQuLaf30GXTVWCXehLrnktZT1ZXjtal0KLcvcLGJXx9K/YEbqEvYe0AeblN4ULhHzTVe+Ebt6VAwKGdmievzyti8pm+X8putHt34M51+VIZRTqNFc2SiqtpQullXjB3HjAXRIW4WoUtG0hn6kml9uVmEcXS3OlucaGenkxQatXthuHxkos8L6WNDYCu2BjyvIDIRdjiibGu0yJFT/v4acjcHEQTnnUaJR6hJvz3dgf8hnGuNgJGeqZxo0YX2HsQ2jaseeyFkIGy/XHR5dNiYGStMdV29lFTfNEzwHZkWpNu25uuwFrHofS2gmD3z46jFAqLQn2TmP9tkXHr096uGcd1W/3UVkySULWX1HTIAL9R8iCG/dgT84FaDsDBDX21dE6jtQTAY9zlaNOKW7D0XEhjNtgl/FMZPTy2r4KkqL1ok+9TaNk0iOPSLcY7GhmcnXULbA/mm4B7pdtgn8ELNJLhmDJAXnNgBcUg5oAfCasH3k++DLq/JdJ6HXF/iydlx8gB5lrJG78mmQTO1hcjn6rP6YCRvwBfx/o+dBZB+14fKg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48700eed-184d-4bd6-827d-08dc31437be0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 12:08:29.2776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kfe5cUOKAAIXQJ7U50w8+PyZFAqtH8Hge6Z9rMTlbu7Ui51qFiODlelIhwW8t10nJ+t+D7LW6Sv7HeS6jKH2eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6883
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_08,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190091
X-Proofpoint-GUID: ZdeYyIJYv24-mMBt5s8KyKWfSnxOfxDn
X-Proofpoint-ORIG-GUID: ZdeYyIJYv24-mMBt5s8KyKWfSnxOfxDn

On 23/01/2024 13:07, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Doubling the number of PHYs also doubled the stack usage of this function,
> exceeding the 32-bit limit of 1024 bytes:
> 
> drivers/scsi/mpi3mr/mpi3mr_transport.c: In function 'mpi3mr_refresh_sas_ports':
> drivers/scsi/mpi3mr/mpi3mr_transport.c:1818:1: error: the frame size of 1636 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> Since the sas_io_unit_pg0 structure is already allocated dynamically, use
> the same method here. The size of the allocation can be smaller based on the
> actual number of phys now, so use this as an upper bound.
> 
> Fixes: cb5b60894602 ("scsi: mpi3mr: Increase maximum number of PHYs to 64 from 32")
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Has this patch been missed?

I have this same build issue for i386 allmodconfig on v6.8-rc5 and earlier

Tested-by: John Garry <john.g.garry@oracle.com> #build only


