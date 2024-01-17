Return-Path: <linux-kernel+bounces-29425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D734830E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18E31F27CFF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335A7250F0;
	Wed, 17 Jan 2024 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aQYy7951";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TYVszq57"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2B02420C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705523706; cv=fail; b=H6iynvolPH64BRMALS3yujilIe/Rf9D7j87dffTEUpo3rJ95d3sUKpm9chSQMzbKu9+tGSpIfI/XGTeE8gFhSAv96AKkSLkBfhKDPA9bJ6PAxgRxLoyaswaE0vAuJZE2J4whhng8W1HdIu21yE7lQozDv0uqLrcfL0/dzkebwAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705523706; c=relaxed/simple;
	bh=QdjFUpOUFYeROeV0EflJqbN/U0ul1Q3y3lY6Z2wGMVQ=;
	h=Received:DKIM-Signature:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID; b=JgD9NSyblYBmkASsaXIFuvmzJTCmzUNh9K0k9+Xu6D53fJGN9HYcJ9mnN0Az3uzOmsWGvEXvgS7uXwA1CfQrz5ggwBMOmMoxFQDX2kpJ0VALwcpLo659FvAsVOAluieB9JjyuM0SOA5fMRKlcq9WDaKgiBU9Hpwvg2ODmz49WUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aQYy7951; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TYVszq57; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJco1j031346;
	Wed, 17 Jan 2024 20:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=UxmA2vKAE26tqXfUmAMi0Xy7X3bjF/MZON4bjEtgpnE=;
 b=aQYy7951mJjpHR0g3GFQjfKBin+8W9FoxAIXv/VRPYMMVv4y3BgsCQtW5Jqzd61n7XDr
 Thephn9yxZ89CDk8eKLepen5j7CXPqN1dnXl3X1znUps7x3kTy5y/5Vvfhinybw5yCEA
 3/9dARFt4VKbZkv76pWQBgkE/bRDzNJYE7YrGPuRjgHtxkC+Gx8PzT9/QwcWCi3ZK+U2
 yf5bMx4yyvk28ELEDl6x0K4xN4ONKODitavXggm668O/PNSnUvtDV3dBSD9JiTj27hJf
 B/lAROK0pO3ZZhAXn8pmW88i/3nKaTKviuttDJBvIZFk4z32tvlt/PA2xqBx+HvLjRGa TQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkjba10hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 20:34:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40HKT49w035855;
	Wed, 17 Jan 2024 20:34:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyb3gpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 20:34:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heXwVFHp51nmW93aD5OdzNUfXmYsGANNfn2fWZ7Aq+u0iT8gmgl+J6yfOkZdnf9BguEqF6UcIxAYEOEkUTG8snjSoflBQ5ue0IXLUYfDW+Uw0Mr79719VHoCeN9Btz4KT3PjYKc2vmuYCwXGbD8HMazgdJMcsIb2qQkTPQd69Q+LXmOTg1GwbtxYNx3ZpluEC1UgXLIVKh3QEt7HccCZyryJ2YsLWkj6YlyMGQGt+2V21qV8040KuP7fMOQ8hT4hbq1wS861XsTqe6PXAol9ifobbLEYjOpTko8dl9+QGMy72HH/9AvMCKfAg6B4qFI/O4cE8Y5Y2pLUJtdawaYQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxmA2vKAE26tqXfUmAMi0Xy7X3bjF/MZON4bjEtgpnE=;
 b=nVJWMXe0ppIirxAcvX92tkjyjSGlDOFTXLSeYACPZtIsZoF/zMdbz46tB0yC0ZA3F6tjcKceHxXPOoSjChPy5NXJKWIHQ0Dy2AubZ//EkBN1u/X4Ld421e2ZY+7k82TDJ4kMCSDnIuU9BKZECbij6wrbdla6z/PR9d0NYBiN5v4CoIJJxnOX5CGuqbOUDLvySn8Is5EgNs87yUAHISqgksa/H6ZicmmWiGbOtmFk7/ax1HlsVjO+XzVg4oqyjA1KdsHmCcMH++85vhMaKsSxfuiXkou55H96EGeBlQi8BO+Mn/ppTYT0cEREo8g7oLgBJXwe/ruN2Jpvv1Cspw5giA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxmA2vKAE26tqXfUmAMi0Xy7X3bjF/MZON4bjEtgpnE=;
 b=TYVszq57/qDfQ9dCSz+fyEAkny5ZDR2nUW3lL67WxblvVwQDTXZFcqUfwIhwGiTdT9ph8W+8DVlcqHqRRr1deTwjrbvIw01HQIMlKxhR6i05xQIC37adJWq28CPlnZY0f36aeU+T44YvOIMZ0QaRgli7IEyP2xgTxgV6VFGOLJE=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CO1PR10MB4451.namprd10.prod.outlook.com (2603:10b6:303:96::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 20:34:46 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7181.026; Wed, 17 Jan 2024
 20:34:46 +0000
Message-ID: <3324a580-8436-424b-bff1-5d7df046b938@oracle.com>
Date: Wed, 17 Jan 2024 15:34:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 01/13] vhost-vdpa: count pinned memory
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea
 <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
 <1704919215-91319-2-git-send-email-steven.sistare@oracle.com>
 <20240110172306-mutt-send-email-mst@kernel.org>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240110172306-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:208:23d::15) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CO1PR10MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd43cfb-6a4c-470e-cadc-08dc179bbe49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dnq854PXt6JoVRX31phKiLKGH6xGZDTwB4Uup1+OrBs1h/lhjaYHjtov4g+48fImi+tVrOej8XQE19bqnW5J2gxTdGOUXz/2yYCFJD7TczJVjFcNeSjDGSxjRcv1UO7WQLBIyAAIFZn+FexLaoE/pVhrEsT0MrSyMAnceuDdNrnfpjVzQsXg4EJstUYkieD24hf5mVEWv105TTSIbZTo/OupC2mqFPWCYaRkK2R1r1sVzdQIM2BhudFo1PlMtr6FTXQOSF9ApkETeQ/232QBO4X8zPAJ6qmqgAZXOu0vQDMzOIXTAUbD4UQffXTHP29fY9NHWrsN586CW8XFXoQMSr9N6NeQXLRPwP9lOPkYD18Rad7FK+ZQyR1Bdj3dfgWTAoZ2+XuJGQK/Ypq26NtT1kYVBtM9A4H/TXO4b71A5Y4pmcxKgb3GAFjPoPub4Gt2pY9b3aAmKu82Axh4Mb/EFhUhqB0R002JqhXW7WaEspCTwsie+FlVyswyz3U82BMHwnkMSQLu93+hUznDMfnuPZmOZTS6s8zDZ4mxoewuhKtUXx4f/wx6ETw2N8GmKq7H94Dy+P3YvT60SJesx3goy4zfBO2ztoFSFiu/MP1K8Wrw0iLlggF7cHBR27oloDeP5cYxVjaVp4kRdWJ0FRCVkQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(31686004)(36916002)(66556008)(6506007)(83380400001)(44832011)(54906003)(6512007)(66476007)(6486002)(316002)(6916009)(478600001)(6666004)(2616005)(66946007)(26005)(53546011)(4326008)(8936002)(8676002)(5660300002)(2906002)(36756003)(86362001)(31696002)(38100700002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UFhWUUxCYk9hNVVnR1JEdFc4RG9mWXV2ODJVQW5MNmtxd3dwY2tpckhCUlpm?=
 =?utf-8?B?NnBWRWhMTTM5UjJTanU4OTVEZUlQaVh4S0RkQzhEM1FLeVNucEIrTHByTDdB?=
 =?utf-8?B?bGwyMGcrazF4NmRrcklrMkhxcW5HVjFLZGhDcHUzT095dUZBNmo5d0JXeXRB?=
 =?utf-8?B?TlhtMmNhUnB2dVNLd0JIUjJ0YnBiK1drbTNXU0hzc3NlZFZqaG1XRWJmN0Nn?=
 =?utf-8?B?aFM4TUE0b1BYSWE0OWtSTnZXeUxVaTAyWlJmaXFJbGZMbTRtUW44NnVlOERJ?=
 =?utf-8?B?QnlpVStxeXRwNDZjOTVMd3pQUkI4bis4SkJkR2xHQXA2Z2IwUGJjYTF0V3gr?=
 =?utf-8?B?NUhwMXN0OHV1d29sa3NLbUhZRTB4T3NnWXRCWlFwaUdKNFZDQm1UOVlVMXpp?=
 =?utf-8?B?QWgxZEhaODdPOUUvOFBjaEFGaHFKMjN4TU4zaHFQelRwek9ueTVTaC9CK2dT?=
 =?utf-8?B?SlJ4SnkwTHZWREZwampja2ZSR3kwQ1FVZVJCVFZJa1FWNFhDTGJnRVQ5elBB?=
 =?utf-8?B?OURSeDdqblBDMnNYd1Y5SklCQWZRSWxUWHo0aDhteTZtYXFiWitodHdTVFVy?=
 =?utf-8?B?UWNHajdUN2dVNEgxMmxlak9DTGZHa2xwdHQ0dzV2Mm5FS2tJcTU0bko4ZU5B?=
 =?utf-8?B?Z0drdVN4bmlpQnZOVDhpTStPL2RCeGJJYTkveEMvN3ZrNWNrL3VZYjczV0sz?=
 =?utf-8?B?ZkJyZTdjSjFuYnAxWHVReVFnMVFoRUNKTWtrNnFvcFNZQlRvc20zVE9iWFNU?=
 =?utf-8?B?SDRualFSYTFFZ3B2MnE4Y1d6U1VhWHdoVk9NbSswSERpK0ZCazllK1VlZlVr?=
 =?utf-8?B?QllQQnAyZUhML0lldFNWWjZGTG9md1YwK2I3V1I5Nzd3ZmY2TG15eEFFRnBu?=
 =?utf-8?B?K0gyQy96Q0NWek1acVNOQzk0SFZDelhGRG5XNEtUdjc1ZHVHaFdJMGVuc1Ax?=
 =?utf-8?B?MWt3RGVwczAyNzZ4b2JLVDFmOEZXY1IwcTFuRW1HeVFWdWtnd1h5WGFVN3pl?=
 =?utf-8?B?bE9mbi8zU0dwQjdPVFk0NzBLQnZQK2N1bWxjRmV4VEtPdmpTenp6Q3pmR2hD?=
 =?utf-8?B?c2hwZkRGWkhkMFN4ekUwRXBxWkFSSjBhbWQwWFJsQnR4eEJ3U1ZUdEk0a1Nq?=
 =?utf-8?B?TFNmQVhwQ2xmTGNUUnJqcUkvK3BLdzA0VldDaTU5RldMb29iTmw5a21JWC9J?=
 =?utf-8?B?WWNDVlFRUDRVZWVmaHExN1IwNVU2aWkrNUd0QUMxYVduTCs0TDE0VkxTcUx6?=
 =?utf-8?B?UEg3Q1lZTTJTVkdFVUszVXNtYktNY1JvdmRQRnRFRHFjMmVoNjFIT3NqaVVp?=
 =?utf-8?B?dEhhWUxIMTEwUU1SSHh0dmREYlJTT2p6eSs0aW5lSzBVN1hNVkZ2VFhyOU9J?=
 =?utf-8?B?VVpaemdUQzJkdmY3Vnc5b29KMDFRaUg0ZGUvRENjWXZiT1NFYStibndWbVJi?=
 =?utf-8?B?Y2tCK1BmNm5iZSswYU8yL254b3d2Z2QrSWZSWmw0K2JJdVgxV0UwY3U4U0pP?=
 =?utf-8?B?cHdpSnVJa1BuRkpRci9JKzAyK0tFVVIwZkN4cncwRnNOUFlVclpOZWN0NnpV?=
 =?utf-8?B?QUpNbkhHMGlwc1d4R3MxY0t5VVJLZ2NRSXFZMTlLMm1ackEwYnVYalMzV1ZL?=
 =?utf-8?B?aE9nc3QvTURJVnR2R2FhWTM0Rm44dE15TmN5Z216eERZU09ZVUF0aWJZSWZG?=
 =?utf-8?B?UHF5Y3NuMkFaV0VaaGdKL1d2SUVGWFJWZm1IVGRMVEVoTFRiUERBMVhySGVO?=
 =?utf-8?B?R0lLVGJoYkViREtwWkNKeDNmQVE1d2xFVFBVNTZZSmhwOTNIemMvY0daU1U0?=
 =?utf-8?B?eVhzWWtOb2tUaE9PQk5ZOXpJRE5sWWRvU1VPdlhYVTRlYy9HZ0pTN2lhZGxw?=
 =?utf-8?B?VmZtVTlINm9qNGhoRGloQkZHOWVpeDYwdlA5djlab1lkTlpmQU82NkpFbnBj?=
 =?utf-8?B?RzlXYktMZVlLVElvaHE4ZUVWSWV1d05YcmVjdjFDZTNEZEF3YTcvUTdSN2JN?=
 =?utf-8?B?MGZycFNiTEcrRldXdzd0R3NMT1NEaUFqZTA0ZnVXQ25OZ01ybk4rMGNGTmF6?=
 =?utf-8?B?KzVqQmNxZEpEUzlndGJjK3dwTGt3Q0pub3lSWlk2UzExOWcrT3Z1aWJ2NVR1?=
 =?utf-8?B?UGJnUlNaZmpWa0l3Z0dIaE9VV3R3SURoTDRSOHJtcWJNeXlhQVdXM3pJZGRJ?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CtPIadeqvIxXmheylrjPxwUuQ3G8FSt0x8OMdg2qQVi+T3knwugS3MkLcevZBw5z44hv+J7D0HlpQHZeuxB3fwYzFxWfJKXIpd9Se9CfDw6o4K2g/JmpuCmgcNQiOU8s91w1+5WA1Jinn9vqr7+vRGRsxA90klsOb2rv1j5merTUoirbQL1WoE1vN/XMItX5kXrn9Xzcs/NwocuBVoj5Zxtx6SARMDV8Z3Fi2QgAfIRI1LbkcYYD0sXyTdhgG4HW+ALphcAPNn4FZ9Hop+fgiT8WoJdy+XUdwjHR34KcKIw81d6WyueUOHiAkFp9hRfzpgip4tzH8qQ7JhV0G9LQG9J7JfQBKR4DjmzW6GtnTEGo6td86YwEKRRaV3pkdeo45NXNP51/bFg7UsWNYnUrTZ8wGXuwoSUkCtSnDTJ8i5s+mD1mrc87cnxIHOMiftuJoQa8jzGI5bBDhGVaf0authu6Pa19qlxWnABhGPkQPbwZWAQSy8JnrMWe64STJ9AUjr3c12EI2Pzh80xgkHkDAFiOUDVjG1X83lb/sQ7qCOal8rkj1y3ty7Qz9ayeSm9TVTj/pNFJLzddisKkQGp2CJKZFXUMKJtX4Fr8PXRCUWY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd43cfb-6a4c-470e-cadc-08dc179bbe49
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 20:34:46.0902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyUOEI7Ls8DJou2vcVI7J6EognB+AAFkeNG1xRL6BkVSjSnwEiBxFZyc22l+jJ7LOqyf+38HXSAIwb4cGnXvAathZKNDU3c1xfnZVdIMWVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4451
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=958 suspectscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170150
X-Proofpoint-GUID: _lNCiHDzVYJaL26jm_RFg9uQJWLYb0Dw
X-Proofpoint-ORIG-GUID: _lNCiHDzVYJaL26jm_RFg9uQJWLYb0Dw

On 1/10/2024 5:24 PM, Michael S. Tsirkin wrote:
> On Wed, Jan 10, 2024 at 12:40:03PM -0800, Steve Sistare wrote:
>> Remember the count of pinned memory for the device.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Can we have iommufd support in vdpa so we do not keep extending these hacks?

I assume this is rhetorical and not aimed specifically at me, but live update
interfaces for iommufd are on my todo list.

- Steve

>> ---
>>  drivers/vhost/vdpa.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index da7ec77cdaff..10fb95bcca1a 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -59,6 +59,7 @@ struct vhost_vdpa {
>>  	int in_batch;
>>  	struct vdpa_iova_range range;
>>  	u32 batch_asid;
>> +	long pinned_vm;
>>  };
>>  
>>  static DEFINE_IDA(vhost_vdpa_ida);
>> @@ -893,6 +894,7 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
>>  			unpin_user_page(page);
>>  		}
>>  		atomic64_sub(PFN_DOWN(map->size), &dev->mm->pinned_vm);
>> +		v->pinned_vm -= PFN_DOWN(map->size);
>>  		vhost_vdpa_general_unmap(v, map, asid);
>>  		vhost_iotlb_map_free(iotlb, map);
>>  	}
>> @@ -975,9 +977,10 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
>>  		return r;
>>  	}
>>  
>> -	if (!vdpa->use_va)
>> +	if (!vdpa->use_va) {
>>  		atomic64_add(PFN_DOWN(size), &dev->mm->pinned_vm);
>> -
>> +		v->pinned_vm += PFN_DOWN(size);
>> +	}
>>  	return 0;
>>  }
>>  
>> -- 
>> 2.39.3
> 

