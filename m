Return-Path: <linux-kernel+bounces-79020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B07C861C60
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4429286DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF611448DD;
	Fri, 23 Feb 2024 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f6RVFrB/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X4lL3j90"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F9F47F4A;
	Fri, 23 Feb 2024 19:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708715898; cv=fail; b=hG/9hgwv0FI52DcVZXi4LWyApeTgloKz3ApWs2maLWvYkXhfYXyTMZBykUfXNJnxse2OO8HEycrby/b9nkr/Q1jYPFBMaUeIN5BTW1v62l5/SKkmw7Ydb+ElScCHEfIlXhAk1mBi/mjJ9GqTuM46zdNwPyJRATmP2/6oYbbHFxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708715898; c=relaxed/simple;
	bh=mmK5Rbw3mlI0sE/8BmcBB1E6J6NXHp6oTZGLPSAl6CY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iCMLoB7Sxs71sc0sRjB4YK+SFG1v6vPksBJsrrzFeFUsOqOz8M9af0AIOwNEmsD2DFgYp4LSc5qFIfyOQtb0+F72wBOGxoBgQBw1YW+F9HbLYZnvnduHIhp1dDowhq9c6V9Uo/bJrVSWru7ldH4ezsdvj2WKrpEK3HH8DRv+1pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f6RVFrB/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X4lL3j90; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NG3xx0002147;
	Fri, 23 Feb 2024 19:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mmK5Rbw3mlI0sE/8BmcBB1E6J6NXHp6oTZGLPSAl6CY=;
 b=f6RVFrB/aL5tF/s8TGTZBJPwasvkeDW0OjJpxUgiF/MMgOVP4bmMUZMUtZaJzRAjtuh0
 YkAopTt7dZybPfzyp6Gj/TphsxR7KvaSzKzt2t7UnyvPa6euYzRWqNNVTZetekHVZqnu
 c4HNeh+yddjT71R5ucMB/qKvy+yAR1OFPb1DcWam2bCE+78qC4lj9PfKoCRIHoSc+WIz
 ZehD9H+jXCpc0/mzezn/zhGwr6ATsj74T33Mfe+mjpGSm4aweIca8hyT68zoV+KBA2km
 pzyxpkTadRlSrhHzFP+qCS35FL1TT2SU3zibncJg0kw8euAPUs/UVrkd3rd+H6a6MCfH 4w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdu8ceb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 19:18:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41NISgrs016842;
	Fri, 23 Feb 2024 19:18:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8d2jxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 19:18:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnKaRO+XvRg6MIm1DW62JmeRJUeYZcgcIqywupVaCVSuKCHVKhad8K1QM5CNKt1fA8dqox05bLy5j+on+cVQvhiLmRr1ibEnQTn2vC+AV1BBl+LszTsNWqWjI0nwh1EHYXaPkBjGHhun4otgWXKhuNHE4g8lYMh+2KIAVHVTJlE1FNxLwjiKbi2vikJIqciH2Id9g8DKMcFvq2gJqfsf8rIC+Q5Gc/YPHZAstL4dhXfvyFtPnUIoJ2UU96gjtzgzG6MkjccRCilWc3EWAOLX294Cr+xknIv9ud/pyghsXTPWMovpU0o1W2IZgxAuXX6ZiGVyxrT/Zf/fED8pgpadSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmK5Rbw3mlI0sE/8BmcBB1E6J6NXHp6oTZGLPSAl6CY=;
 b=nBorg5tMu/yAIssIdquLy6Mr4Mx39rPDt1q9FA3SihmluRwfzBxDw+a+fgzi7Jt601QENBa6trD04/5rfRAV2rKJ03svJTcAIbFRCZwgTjSTL/2DMJwxmmknZYMGcei/WWZdt9+9KzfKkwa1qPl0oL8BN1y96RLmGQjcwc8Mcsm7GhTeeynSz/7HPmxzdVvWMholjxKr0aGX2jqMTJu1b+2xgXEM9l+KoVH1v/hNrIQIX/ykuxqBeXOuKL1To6J34BiSQ61Y1ezZdAGkauQkWn26C23G5ACCP9nZqtaa/re3q3f4pCnWJyhw+Y0gJvLv19ezkMa5SzfcUS3GubVwzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmK5Rbw3mlI0sE/8BmcBB1E6J6NXHp6oTZGLPSAl6CY=;
 b=X4lL3j90UvkHGWTAzSNX9ca47wjMlKPZDkt1Z1BZ8E6J8hqHCrdr9D6r4RN4TbU/FZXM6zxPtw5p4XV8eXlgkkgIi8/ykqb/ctCncH57SYzP9CO4z6CCuigq97fhKX3XMrl1VP7zYCxjlAyvuGT5rhGHmQW2M+ZSGe1uZBSnxJY=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by SJ0PR10MB4608.namprd10.prod.outlook.com (2603:10b6:a03:2d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Fri, 23 Feb
 2024 19:18:04 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::1e9b:c7cf:d15b:c41c]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::1e9b:c7cf:d15b:c41c%5]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 19:18:04 +0000
Message-ID: <f6640cc8-2b66-44e7-b2f7-8ba17bde2281@oracle.com>
Date: Fri, 23 Feb 2024 11:18:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
Content-Language: en-US
To: Dan Moulding <dan@danm.net>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, regressions@lists.linux.dev,
        song@kernel.org, stable@vger.kernel.org
References: <f32cd478-a905-4e98-a46c-0612bc10c38e@oracle.com>
 <20240223174452.10209-1-dan@danm.net>
From: junxiao.bi@oracle.com
In-Reply-To: <20240223174452.10209-1-dan@danm.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:a03:505::29) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|SJ0PR10MB4608:EE_
X-MS-Office365-Filtering-Correlation-Id: 5199c850-4353-499f-150e-08dc34a428d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PMCtZot2Pp0Qdj8qZ6DZAOpdAqwMnibYCIdnKaOFI3aaSgeXBgixOg+qwiDqazmxaAYmYStib24siSwVskruA18e5+wDoBhX7yTRTkocBygqVSd5pNwy3M6608oMERbDqGyEoa3UNIJ7o/uVUAz9QYB81YtFu4ODKcUu/n8QY3VSmCKNhtGijInVs+32cAkHQ2BFJw/S4uU8gFIKvEOvzTVgQIt7OW+ON4mCyrpvQ57s+QvCLtk97qRgO2gRQQYfG/GdGVHr5efp5/ei/Rkkb10miNVHIdBcV7shVfKk1+150a8jamn4sMsjLltbvWZjQfrsbTjtoVXiBgTCGME+Q8K07gzJb3El8bOTuwvEedyYdRUDERdESGYDzt+nVpFLydFCUdNXQ+ck3XpDxoQ9IkL6Jroc2s71zf1OZqL3aveZlpsYla9hnTfGXNg0iHaCXPNHZdvvWAt+9Qgi1iCqy6UfhjS5FgalOtIfulXyohs5ss9gvpMuzyWttISFIAQgEn5nIwAnVRXx4ukDN0usQwtF5xscmG9r3Url4OS/YLY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aEpHM3hubCt0aC8zbFdRNjVuU3hsT2RiWVlYVTRoaWkwd3lMY3JNU3hoa1Nu?=
 =?utf-8?B?WHRjd2xuNG9tSnlMQ3lSU2p0cWdCalVxOVVVWGtRWlpYQlhHZzJUaXZoN3lM?=
 =?utf-8?B?b2dlSEhJQjhpYlJVMHJIc3NxUlRPMzIzRHdiYU9aTVZYWjYvZWV0ajN5Z0Rv?=
 =?utf-8?B?d1o1a2Q1aWxSRTdlc0MzM1YrU3hBdEVUdDhKeWh6V2U4YU95QS8vSmdnaWph?=
 =?utf-8?B?cnFrTWIyWWRTRFg0OVZSOEcxZXJZVEFuUTZrSFIzUEJCeTRJWk1LbmNuY0F5?=
 =?utf-8?B?Y0xVbXRZYmdRN1UrUkxzMmxTaTVhb3dlb2xuZGErT1VLOU9hWldTd0hpTm1C?=
 =?utf-8?B?bHVxT3hFM3dPeTRkVURwN2V0VFIxREhtYU9MSjhMYlk3cEZjMUJhZ2J4RTlH?=
 =?utf-8?B?cHFJMVZpM2NmQW5KWmpid0RuN0REM2JJaWljQkRreERQM3pRRDRGRVBhZkto?=
 =?utf-8?B?QldaTWo0SkNIMXhIMDkzcXdISi9wTlJwM094TldDSjdSQTdVOWtuSW96MXBr?=
 =?utf-8?B?TzBSNENlK3N2TytyNnRYemZTcmN4MCt3TDJnd25MM0Z0b3cxZ2xPYlY1cHFp?=
 =?utf-8?B?TGVSMmM4MFRlckRGemlKZndmTDhydEF6OXJUMWZPcTEvVytEUVRkbXhsT2NR?=
 =?utf-8?B?Rm9IcEVvZm15K1l3V1ZQbEtsaWxiL20vb2ExM3VVNFFpdU9xV2pSQ0ZNZ3Nw?=
 =?utf-8?B?U25mMHpNdEZhYWxyS0NNWURncXI2bHYyVkl4L0Y5Um9xbjB5UTI5d2dZb0VL?=
 =?utf-8?B?a1FUVmdxeWcwdEduTURBSTFQYWZTZlVZVlFDYzh3WW11Smh1TDhwK3lwMWlh?=
 =?utf-8?B?L3JyQ0J0WUVOajJNUkZnLzZoMWdHckFHOVBIeDZ6QjN1NzV4dU04b290VWdq?=
 =?utf-8?B?b2w0QTRrd1VKZk5VY0J5QmNHZHYzaWJSN0dhaXMxRElMM05DZlg2TnBuOUlY?=
 =?utf-8?B?c0pYcTZrN0ViM2hkeitXclpLcksrSktRRzNFNnNsUVp6NmppMWEySHN0ZjI4?=
 =?utf-8?B?RTQ5SDhtaFJFY0w5Zy9sLy9uc2JQRkxNY1VYcDFuOVdoeEg2a1ZDZlU3ZFdz?=
 =?utf-8?B?Ukt6WURBNUk5dmRGSWFhcTVjKzc5Z0h5cVdQY1ZqUlRHUXY4bmNwTWV5bjdF?=
 =?utf-8?B?UmRPYlE2bkgxbzhYMy9uQ2lZSVlscjBwSXZQT01aSWpiSXNDUjhSNVpvT3VQ?=
 =?utf-8?B?K3JlamxrS3NaV3lMdzlLMUxxNGMvWm1FOTNnb3VVZ05hZ3E5cmdkbTUvcTNB?=
 =?utf-8?B?TlVJREVwYXZycVVwNTRoN1p4UHhnMGpsZW9HMU1uOEJ5TzNGK3VGcGJnUE1L?=
 =?utf-8?B?TDI1cTVrYTNSc3JSbXgzOVNkNTN6aGg4L3hmVllKR0Fmc2dTc2tLWVBobmZX?=
 =?utf-8?B?MndpdDZ6UXhEYTVnM3ZqbUFTZS9FSmVhQjZsc0tZNUN3U1YvUytUelFrQmR1?=
 =?utf-8?B?c2ZrREcybmpJNkl2NENzSEpSbVlIaklVdHBjalh4RGxwVXlVSEVrYlRPcUVz?=
 =?utf-8?B?dmM5d1c2TElodml5MDlRdXc0TkRHbTVpUnFGNUh6V2VqZ3F1SXBKMUM5bCsw?=
 =?utf-8?B?V01rQjlickdpRXBTODFvTm4vYTQvVUdURVQ3Y0pCdkhuWmwzSlVhdWRJQ0hy?=
 =?utf-8?B?VDdoQ29xWW1Zc085M21oc1dVQXlXWTJSMzZhd2ZaU3c4QVg3QlJHWGlGYmd4?=
 =?utf-8?B?Ny95eW02d2RpdGt2QXpyb29CK2k4VVY2MlhCeU5uaXp3T2hFRXd2VldYci9X?=
 =?utf-8?B?YzIvSVVJNGxpaktDeFJldEh4WjhkejNjVnpycnVoT1BFTERVL0hwNTh6SUJF?=
 =?utf-8?B?OXNiQ1lvT3ZWbk9wYW5XbzEwV2NKejlnS3d1WmJCdFlxK0h6SHhJT0pobUpr?=
 =?utf-8?B?U2JsL2FidVFiUFNwM3FYOVI4akJ1QnV6YnAzSEtYVTlaSGZsbWFTV1VrVW9u?=
 =?utf-8?B?dC9GcHVOWm5NaDU5aEZwMFBkb2NyZms1eVZoSG01ZkNrM0kxVTZtbHdnTldF?=
 =?utf-8?B?NGNUNTMwWWRBdGxtUG1Ick5nWmpGVkpmTU94RGJHWUhVYTFRT1h3NGZZcDE2?=
 =?utf-8?B?YloyNEFhNXNjSjdHTzRQMEJZSWdCMXJwRllmQldXcm93TzR5TmI4VG9HRnl6?=
 =?utf-8?Q?tTokN7MBMxKLlXvQY0h8488+0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Crx271UmgGD3Vqtsb7vtV6bTeDv9N5ReKBzUdRd9LcOIY89kD98RztQ/pVqHp697Uy7Oa7EgdlV/iwD57/K0IH8Rym+bQpPyIZUyDIbBZxZfIXPyubBPfNn78euDbvLAqna50sVqwQ3+Ujs9tNraEzrDbQamz8FN0XGwk6OtQgx+tuSTHgGbklNWXfW3hKZ2cjX00Mmx6yAbRwGkj6G4HPUrIz4epUyKtHa6+LoMpVW1dWXj7ofFKz4zR8s7g/UxoqpT7hFZDAT7qzEfRBoValtOKHgK0lKrQh4hCYWHq+a47FwS+EmVL/lBSl5BBzIDyn3oiP8XMVentau1mEC/KDl1fzBK0BzqacbPdpANmu7xhwgVfDBQUMn+jb0hrkEpbRRyxP240uhYkPl20+Exq+GVxsaAtCnuc3FD/fdijeAT02BHOFSm6Sf2J0vNG9tTvDsiyGDTQfaC1FZ6nUadAOCzZCugovJaGUJczdO5QvOafupYcVtKtCgyUn3yx+uFhN5DMrqQ+7fzEYmaDtOPONAi4hNuhaz2AjK8rR85KwWn1lB1N+ynAfAQYaB3QnL60kVJYvfWJhvnRRsTISep+WXDjqmjo6vDX/2pK8ZQG7o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5199c850-4353-499f-150e-08dc34a428d2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 19:18:04.5474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9hFGeBEiM13b2LM8+7j1QeIEZDxIz8+c0IQ+wauFGDediSFZCCd/c8Rgmoo153+BAgJ2yEIaoDMUrdSweWhnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_04,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402230142
X-Proofpoint-GUID: WJKQmPj4JYy-7zCMnhK8r2EzMn8UFo5S
X-Proofpoint-ORIG-GUID: WJKQmPj4JYy-7zCMnhK8r2EzMn8UFo5S

Thanks Dan.

Before we know how to share vmcore, can you run below cmds from crash first:

1. ps -m | grep UN

2. foreach UN bt

3. ps -m | grep md

4. bt each md process

Thanks,

Junxiao.

On 2/23/24 9:44 AM, Dan Moulding wrote:
> Hi Junxiao,
>
> Thanks for your time so far on this problem. It took some time,
> because I've never had to generate a vmcore before, but I have one now
> and it looks usable from what I've seen using crash and gdb on
> it. It's a bit large, 1.1GB. How can I share it? Also, I'm assuming
> you'll also need the vmlinux image that it came from? It's also a bit
> big, 251MB.
>
> -- Dan

