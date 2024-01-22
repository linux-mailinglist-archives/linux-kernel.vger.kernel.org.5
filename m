Return-Path: <linux-kernel+bounces-32404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436CF835B51
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68EF51C20FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D05CE56E;
	Mon, 22 Jan 2024 06:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dkPMbawA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lOJZPX6A"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA29FBE1;
	Mon, 22 Jan 2024 06:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705906609; cv=fail; b=biOT08EmmFRMabGuxhB6sFsWT2wjZBCZBoQTeTt5DGo0uao8vK1Xm5hIIl8iT/HT+r0dbE+vOqzOnlQ/pOEGxSMNZVsvzHUK2V8ofgKoYGcCALVFlrDw6SujuqpXflylaUZtG/MmaDwzfIyW+iFEDHXcHVJ/hSXcV2drUtEj0Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705906609; c=relaxed/simple;
	bh=esCWupmvJhOAY9yuI4hcaUqsCrCrvN3RLRPUa/wwpqQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sSxXDRyKDCHzbZVV0p/Gvw2yeVk0SVliWcBaCnBXEMlShDqBVFOf3FQrjmL90ZK/8iMZ4BwkSbGaUb7LLEeN1Bj+l/AWPfFKwD4IHFwKPJk7SPvPi63d/gvbIvQGl4eRQ2is4o29Jxf/7CVvFrmmYQU6w/uRIdWWVydribumjO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dkPMbawA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lOJZPX6A; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40LNupBS016475;
	Mon, 22 Jan 2024 06:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=y3nVk5hIFfBu/kGlj57Ww0utN10WudVqjEbNxujeXlY=;
 b=dkPMbawAUArTnT9ovuy03qPqBRUXzvWOW9Y7+h4jO4yp3QfzC/1QF6Px0D0F9iDo/bkU
 epb/XNnKXAM53rjkY3rxftIQivqwh/fo3c/7YmwLa5AjfmxcfkOu68YlAklCBER2CZ5l
 P3LUGotJXGlcGpJkE/deUmh3C/Inm3f17UUlxNYfibglOkTSEEDpTnYOTFmwYnkw2xtS
 P8bCldfZ+X/Wzuewkhwg0FrIKRiN8oQmjMxPgBW5iK5y7fa1HjbxeDU95g1LLX+yPzXO
 gUrCjEe5YXNmHT/mF370FVUy1NYbFUbJVXxCwA1H3scps68t2FPbEhqfVVbAoSvFQaFv lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cxtps1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 06:56:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40M6IigF013557;
	Mon, 22 Jan 2024 06:56:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs3207j1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 06:56:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4C5VpLj1+KzgXLvdXwWV/urp/BUi2TkQPuzp7kSJbSLyOTsZNLDSqnwjjklZcvqWUIe2iS0IO40sDZv8BEfojvFykbvEuqpq3LsfZ4k8yo2u4YAd8dlFxZlpCUayJ5+ZDEToAy7odkLhkAnkMckqOP/ViSRc/CtXvRCnLIU6PyLLeqcwnwWhPx675Tsq+a9IUmwCFvhQ0gPixjlRgdKeIGVLq4Rq9kfDExu/PkKlY18vkKGPPpMYaInM+w286F1u4nnuzpXhEkmcAwCV9OumAe75pYnuT8dNjcR7VsjpAi9QfQzWcoWPcozfGJJMf+ZgZURNdh3MhKaXrLLB4gNxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3nVk5hIFfBu/kGlj57Ww0utN10WudVqjEbNxujeXlY=;
 b=LrAK6CDSQURltDH12zW9Is1Kp1lcjSApf0F4AcPQQc3Xl/IcbbDFvTEGj59ltDy9FSJbhpJu1CJ5xIxR7+dRIIYadD+qSakxGh2lPsp+OPeSFwxt6hkZ4ZHLdciwciTZ8wF6V965pXUjYeBMhbjr8wcnwWHBFNCniYCmaGBVVcQhHCeCIUgHsaZ3DFZpWlU3dQDttLq2UhYijO2yhnzJf6PPyaNxUprHxmls3ic4nWH/35O/MBqDqHTrgwC4TzJ5MQVY1UkUY6wzkm29HosZAh7LmvaNi+JRBPPp7pTYPgeyODPnvcJB6MUu/9KUYcCVcg6otenbCbTdGgk3pEOV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3nVk5hIFfBu/kGlj57Ww0utN10WudVqjEbNxujeXlY=;
 b=lOJZPX6AywDAHkIAQgW+MXVcbuMPuoGF4AofpgMiOpCPEq4wK5hyl78yVQhWtO/GO9vj2Tcas+Qu4vOlwGFsIj0POFxt95zP8VmLBxj+nRF6yFxy7cCU+PBZo7G6puyVaKshMXCg/HyoDK3jEy6C/w5/+ULEI3NhzZcLYX9g9Wk=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DM4PR10MB6039.namprd10.prod.outlook.com (2603:10b6:8:b7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.31; Mon, 22 Jan 2024 06:56:16 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 06:56:16 +0000
Message-ID: <135bdba4-1be2-4a2a-aa6d-f257d3788099@oracle.com>
Date: Mon, 22 Jan 2024 12:26:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] EDAC/device_sysfs: Fix calling kobject_put() with
 ->state_initialized unset
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab
 <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, stable@vger.kernel.org
References: <20231128183037.3395755-1-harshit.m.mogalapalli@oracle.com>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231128183037.3395755-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DM4PR10MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: 28033b7e-c459-45c1-e5df-08dc1b173a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HwREhRzlamoIJPIl/7tqOolJcf+HE+XlftsYBXCdBj9bb9Z7vgjZpk/UAMWD+i498ce8456leJZr9bDe4hyhz2GPK4rBQpkd+3fLMpy8OYBY7WrpmfSAXt311C8FQEiWN5qg6R/3nJb3hnHnezkIiJYNCeaxy71NKsR3eVslY5Rf2DglKAGFyXdY3Ru9iqWdxKGjEHvMVVG08fU3yJmWni0Z97zEuWW3uwxI13qonnRbaMES+643ziwJMrIy2JPfa0CyYvvWjg0Fqkw9Ed1AVqDhRlrsRPE4HlOx+xtnVujCJ8uIgc0iZ71n6pw0dc68LSvEnajbimiRl7SdEEg4B3lzOuRJkofjuUMrDYFetCiMXkR2BhTYVFPdPneYANv28Cp09OBXFQsGaa/bm0RNlPVUBnAg40nLTuXtd5t+AQWZBVObL6dRxNKYEzWMBSxALlQJ5fRhPiJmuXbowonn6WLi0LQU67v/8rN7Z2oGaaCqLyz8bafOLQKFRlWpYaV3INECr2VNwnNluPxItMckXpYZ7xMtM0eD4A26oauV46UwcwaID1XkpWV9YAw+LRRD1fNBA1s1LqcwMLmgrLFuxoKyyz7oIeRn3jomdi7MjTbGXLt5jn2O60bxD07uEd1Vhw868T3yrtiA4sLj3B2uWTjsRCQXa4+w/4hAmHeGTcoSxAUnqbLIhKulpQWwN9WA
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799012)(64100799003)(451199024)(38100700002)(4326008)(8676002)(26005)(2906002)(966005)(66946007)(8936002)(316002)(7416002)(5660300002)(31686004)(6486002)(478600001)(2616005)(83380400001)(66476007)(66556008)(110136005)(6666004)(31696002)(86362001)(6512007)(41300700001)(36756003)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c2NZNW1ORE91TzNKTVY0cENma1pPaWgycDY0aUN0M0Zza3B4T0FFVm1SWGxy?=
 =?utf-8?B?MFZWNXB3ODdHN2ZmN29ORU9Ic0E5WWJ1d0hEYm5DSThWUjl6SjJPTEFpWlk4?=
 =?utf-8?B?NWZ0S3Q0Uk1YR05hODhDRVVEUGZxb1NETGtqTG1OeEVpNmJmaG1CWGptVFdk?=
 =?utf-8?B?NXlpS3FOd04zeG5OeHo4VFVTekJpMDRDYVFQR3JOMWNReW1WL0pZU2gwVXJj?=
 =?utf-8?B?OVpoSm5IL1FnMmJzV0s1NzgyT2svNVRLei9WOW9ycnRacVpjUGtMOHdtNGxQ?=
 =?utf-8?B?Y2JWZTJlNCtEMXRyRUI5ajRiU1lwdkJqUE15QTFQRVo3Q2lrMWU0clBsMnRz?=
 =?utf-8?B?UTdiSDNMcjFoR0VLZHM1M2pnT2ZjTTBkcWVPcVJ1U3phZVhWbW81UWZtTml4?=
 =?utf-8?B?dE5BaXhrRUZneDIwOVRMYUV0b0NLUkg3Y2pyc3JFRzRFWkN6b2lDN1dTTXYw?=
 =?utf-8?B?Sjl2NzZMUlBMNFhUQ0p1dDlEY3d1MmhGTXhLcEZ5SXBkeGV2UmJnZmxDSEVR?=
 =?utf-8?B?eWFPUjlmYUhFeVJuSGRwbVBma2VQY1UyQ2o2Y3grL0JrSFJ0T3NLcDdsTk5r?=
 =?utf-8?B?MDkzUVZKSkNlcXViTnFTMTlrVVIxcDZjT3BmYVd2WWRKdWlVa2FBeFV3VnJu?=
 =?utf-8?B?K2pLeTRvNFRiSlZvWXc2cFdGK252azEweVpDMXZ0dEUvSFhuakRxMUtyQ1ly?=
 =?utf-8?B?MUZYSTVML3kwM0lhdnBPbVFGMzI2UEJ3Y1FoRWZFcjRQbGVsZGN2ZFZHaVNj?=
 =?utf-8?B?cHd2UHRMNFdYVkJpMHRuTDRtbG5XUjFHL2VVaFduTFlPRC9nRDBjbVhtU0dF?=
 =?utf-8?B?NWdOakRBVjlZY015NW4zMGF5djN0cW5wRWgzYkZCa1hscVFNU2ZsTy8wdXgy?=
 =?utf-8?B?WGZ2MlpWejVROGNpTDFMTlBjU3I0b0lyYTVzZmhqQStneWdoelFOTmlBR041?=
 =?utf-8?B?ZC9OR1lyUm1ScFdwWURaaDlYT25lRGtGUzNPM1F2TVBpZG5ld3g0VHhNaXV6?=
 =?utf-8?B?V3hheG9HK3gzeUwrZ1NaTWxxcXoxcGtpbmh5Z2RPczhLMHM5L2xYY0t0UDNY?=
 =?utf-8?B?NFhKNjhxZ21wZmhMcGk4ZXJVZ2h3OFJXRXdQbnI2WG9qOHA1Q09yVnNycU53?=
 =?utf-8?B?dVZSWnFFN2xOTDJFWnpJYzdOV09iV05GL0s5cjNmTUMvU2Y5Q0ZjY3JDcGQr?=
 =?utf-8?B?NUp1blcrOVM0Z0pkRllkZ3ZxNHJtWFNmUHFxNVlwaEFITjY1RHBxN1pOMlA1?=
 =?utf-8?B?R2xpVHVOTXVXN0k1Mm4vLzdBUSs4TTlrRUszZzJyblUySzRwQkRlNTVRb0Vq?=
 =?utf-8?B?eU9wMG9nZFBTVUdaaGQxVS9ET1ZkcUw3Yi9FNnBWOW1iZzNHN2w0OTJ0cWYr?=
 =?utf-8?B?Uk5OZkdwNkR2blBBbFU1bkhDVXF6T0gvMlM5L2ExeTJQY2V1VjhTQVRxZzdH?=
 =?utf-8?B?STAvci8wUDhDNFBIZGRDNFdLYTFzSU9sM2FkTHp5UU5zYm4vOHk4SE9xaGho?=
 =?utf-8?B?K1VOdEpZdU5ZL2hTNWZyblZJWGxqNXVPNzlrWWE0WFVXZm02eDNheEhmWlk2?=
 =?utf-8?B?ZFlZeDg3ZnFnaHpRdEMwbk5IVi91enlXS0pVa1dzVnVWZFJSaXZ3eFh2cUNx?=
 =?utf-8?B?amFOdmZpblk2cHpmR29NSExpZ2xuUFErREZ2REtwSEdJc1RXWnU5b2laQXZv?=
 =?utf-8?B?UFBHYTQ1eUExTjZWWEpGWC80bndRbVM1NWE5a3haTHd6a1RUblQzWGE3akFY?=
 =?utf-8?B?UTlrcFhqQVZWai9veXhJbjBiRTdlZk9LVGpSbSs5OFZaWW5vYzRUMzRhdDdW?=
 =?utf-8?B?WWpVb2VYM01YOVdmRXl0cUFnc3BPSlhiTVk3SEgvL1pTTHZicWRlaE56aXNC?=
 =?utf-8?B?SlNKcnlFSk9HUC9TSXgwekp3dGNvdTBUN3FKRW05dlMvT2VheGNBOTF1NHFF?=
 =?utf-8?B?c0VWcnJHV0VoV1dMY2VoaHRDNWN5ZC85ZzR5UDFoN3FIWjI1M2w0eTFCY2pr?=
 =?utf-8?B?c29Pd0hGNDhwUTVlcEx1K2pabk5Hd2lROHVlbStpbzBDdUQxMGlRN0Vrd3N6?=
 =?utf-8?B?RndDZWJGYWNweW9BS24rNDhvQU40QUFHL0gwYUdleHhoMkt3ME9PbG85dG8x?=
 =?utf-8?B?V280UGVJaFRKLzREQjlEa2lmd2ZrNTZTVTR1aWtOampPcDc5RE1CTHdzaVZy?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	P3RKiwvonzCr8FzWQMrqQIG4oCXBFhC9Ln/32EzSXqpBGUuHPgwdA0WJ8RRHTERSAWlCaJKycFulfG/y5SRgg2CqSEyaKFci7hszUk1oP96lOL6+E//Nnhy9LyigOg6PNrTMgLEKA4LnbikUwMyrYKSKsqeOub/Vv23lWVoKy4M3NoRJaK1M4x/a+7YwkuM/ioWJa3w65o+GJiFKjHeDSTZCn4CIZSukgz6rTKEulFgmmCO/OfXwzVPjr0xaQuJP6wmsNEIxBPQdrVOIV4HwaViGnH7AaBJ+kw1Qw1/wcJu5mxZOSrr7AVgQ4KujepSCW0ys2M/om5yxecCyAc5T0VVReA0qsXUBaYTdA4f1kLpYvn5PhjYdho//HjMseNAGXAjGIAn4KFGGZO8ZsI1J6KSKWqyg3pwr8PI6kd24G+Y5SsMuHBJ9kHmtj2X4whnet4xBTSnwBT3tCy0nLV/0wCd6sUHz6Vepr8oeehhlzq7pajgkf87MKbA7niMHIycqbEin1l6pzNvgkhl1AdbuAqzp5G30zJhsu7L3gwrP5X17l7sQzLUX3U5Y0yFvp9q0PNMe8umOlZtj/VtLK8VRZ/kIwyJar1Fo1pnZLoijfYQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28033b7e-c459-45c1-e5df-08dc1b173a90
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 06:56:16.3664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBqSIU4hz7fIEi8vfb4onIV9fSyi0NEwg6lQOWa6NreR3DItGL0kZAnYNKBlIIqwUYuJ/r4FqSmSc4TiKpCgZKVpkAqyzbvHtMb5hlKFSbSWMkBPuJo9Srsu8bPt7HG4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220048
X-Proofpoint-ORIG-GUID: FIN1wcwUZDNEhlY7rJW91VtZ0uAGk-Gi
X-Proofpoint-GUID: FIN1wcwUZDNEhlY7rJW91VtZ0uAGk-Gi

Hi,

On 29/11/23 12:00 am, Harshit Mogalapalli wrote:
> In edac_device_register_sysfs_main_kobj(), when dev_root is NULL,
> kobject_init_and_add() is not called.
> 
> 	if (err) { // err = -ENODEV
> 		edac_dbg(1, "Failed to register '.../edac/%s'\n",
> 	                 edac_dev->name);
> 		goto err_kobj_reg; // This calls kobj_put()
> 	}
> 
> This will cause a runtime warning in kobject_put() if the above happens.
> Warning:
> "kobject: '%s' (%p): is not initialized, yet kobject_put() is being called."
> 
> Fix the error handling to avoid the above possible situation.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: cb4a0bec0bb9 ("EDAC/sysfs: move to use bus_get_dev_root()")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Ping on this two patch series:

Lore url: 
https://lore.kernel.org/all/20231128183037.3395755-1-harshit.m.mogalapalli@oracle.com/

Thanks,
Harshit
> ---
> This is based on static analysis and only compile tested.
> v1->v2: Resend as a patchset as they are two similar bugs.
> ---
>   drivers/edac/edac_device_sysfs.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
> index 010c26be5846..4cac14cbdb60 100644
> --- a/drivers/edac/edac_device_sysfs.c
> +++ b/drivers/edac/edac_device_sysfs.c
> @@ -253,11 +253,13 @@ int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
>   
>   	/* register */
>   	dev_root = bus_get_dev_root(edac_subsys);
> -	if (dev_root) {
> -		err = kobject_init_and_add(&edac_dev->kobj, &ktype_device_ctrl,
> -					   &dev_root->kobj, "%s", edac_dev->name);
> -		put_device(dev_root);
> -	}
> +	if (!dev_root)
> +		goto module_put;
> +
> +	err = kobject_init_and_add(&edac_dev->kobj, &ktype_device_ctrl,
> +				   &dev_root->kobj, "%s", edac_dev->name);
> +	put_device(dev_root);
> +
>   	if (err) {
>   		edac_dbg(1, "Failed to register '.../edac/%s'\n",
>   			 edac_dev->name);
> @@ -276,8 +278,8 @@ int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
>   	/* Error exit stack */
>   err_kobj_reg:
>   	kobject_put(&edac_dev->kobj);
> +module_put:
>   	module_put(edac_dev->owner);
> -
>   err_out:
>   	return err;
>   }


