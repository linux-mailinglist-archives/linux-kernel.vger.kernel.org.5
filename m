Return-Path: <linux-kernel+bounces-58356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF6F84E51C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34ECB281DD1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98987EF11;
	Thu,  8 Feb 2024 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="caQ0kfQc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Sv2iDjVe"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821717EEFA;
	Thu,  8 Feb 2024 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410287; cv=fail; b=bFOFTNCCaxu+pIzAX/RiU66FmrP5Jmre7kRMdBmi/d6kEYHzpGqwyy81XwXT9cSlV72bD84ldHVa+FlyjQT1Xl4HgscM4I+CZA36TYBgASt4fur4JNS+6PIQ9IRxkiaQUthXUOCwIFrsmANaeDWVcm4DBsZ9Q5Ggo6meXQ7Ypew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410287; c=relaxed/simple;
	bh=0ohH1lmra54BzG0s7CEVvWyDN6FnKiiSkmwMY8Jy7ug=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Khuu73Ek4glMo7GvaSGlypwoH0krA0+r3hlSwYm0Zzr8I6g7G8D8CrTg6mm+Jgjam6KpTdfUWvxyEfqvZXnjhRZocRIj2M/2o8yxV82TwYHJGLXE6MTFlhlIlilyqA0ASrv+WFePiGOZI9zAoX9Rhs8XYOdt1eSnFtnNmkN1SUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=caQ0kfQc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Sv2iDjVe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418EUx27015736;
	Thu, 8 Feb 2024 16:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=IMq99lwn6pfqaZ491YgRdMn+26pBLoUGtn9mCeh5sFQ=;
 b=caQ0kfQcgsEj3fzN6JT4xKvz6ht5WCDK7IOzw/sN1CWk8yhmZpaEzghNPgBOoAMddPfW
 WnMbHI5cWPgR527cl2Je6iue8xb2moVT4xSg1Bh/nW8sWUlWCv3ZI5ZaMCjbOmeRVw/Q
 AJlKb3WYxE38E4eM5UhldiFrOknaaCxIEVrCcMWEl82yVi+TDOzzFaf5vulchchLBne0
 iqAsdRicBK8fuk7hctgTVx7Sx0eSXTgRIHMHS/fhZ4F/FBXo5R4i62jUlloANkuQeqZh
 Z0ypYohQyd9X1hOX0jZx7HcN9vmAxaO8O/D9iJNjk4oBcdesT0ECfXkyHudQDMtW5fxz VQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dcbn312-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 16:38:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418GJjLd038406;
	Thu, 8 Feb 2024 16:38:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxaw7qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 16:38:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLBwPBgWhiDDsRRHf3XeiEYEAyJ7K8Zx4Ll/D+j1cpXolIXe9Mo/UX0q+/WCuZF0LQtEGI2Il43MX461V1wGLzLMXjIoJOoD3aSoUYnaIZ80s9PahlVFIc/+KVU6Wf+FD59F6dZ7e/tYocoMxcGAAFChfcnB1VIWBrwz9tUQGm00Vs84WLQp1rxt3ruf4usA+JKOhAvkjJmPKvx1Fbe+WUIFjIVZzaqwUCWlsPkVkyKsZW1N1EtNxkk2R4Fle1GuoQEVvp1s/pu408vbwU9JrYzwdnWITQUkkkRQnJJizCZRlNtAI3JCedv6E/URMWEA4FxJ4xXCk13ncKlEpXQl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMq99lwn6pfqaZ491YgRdMn+26pBLoUGtn9mCeh5sFQ=;
 b=FNkbKj5ZJ1CxQ4AZRbENeCdalFDLrz1zGi9eICk2uKqZomC/6QrgUWBpKWmzX2jeaNDGKbfg4Tj5qeaOQGaYSSRbUyA1BgLFovavh9K4ae2J/ZgQJi6gU7L2DUfoG/6nSkZHUNl7uUk8ht4c1j3MhDCg0dHEc3Y9By2PVAkaDLzW9Y/1mDLObWFy80v/TaDt5aNxve8GtUWjUJKqil+ElzWP+7e6+ZrIiN16MRpzvDWWo+/YJtPXSVTUHx0KVUcBUcyErPIP7UvCrNwRk2JuKUruMGahL8FJm3oQ8UAiMg21Dw54AREFk9FT1ieF6/ZYIYhIJ3JeLubHm9GoL194Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMq99lwn6pfqaZ491YgRdMn+26pBLoUGtn9mCeh5sFQ=;
 b=Sv2iDjVeW2RktUkLgipWUi4GIZlphfNPyj4dGrfFI7kz8SGNMtN5p7zEGMElGQSyuf+wny09wCSfwrUtxMn5pvCj3TTjbfl8XGWWpR9LYs3aYjTxckyQ7jPE2Id0u2CADo/aR4+P3otGo6vJ82rn0ufpPuYWxgTyCcylInynqsc=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CH0PR10MB5276.namprd10.prod.outlook.com (2603:10b6:610:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 16:37:58 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::2e34:ae4e:d7db:ab33]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::2e34:ae4e:d7db:ab33%4]) with mapi id 15.20.7249.039; Thu, 8 Feb 2024
 16:37:58 +0000
Message-ID: <4c297f67-72e1-44d7-acb0-462ac261640d@oracle.com>
Date: Thu, 8 Feb 2024 17:37:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: scripts: sphinx-pre-install: Fix building docs
 with pyyaml package
Content-Language: en-US
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org
References: <c6555e01-1945-410e-9950-53c40052626a@oracle.com>
 <20240208131305.52577-1-thorsten.blum@toblux.com>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <20240208131305.52577-1-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0538.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3db::10) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|CH0PR10MB5276:EE_
X-MS-Office365-Filtering-Correlation-Id: f277dbd3-776a-465e-c3cb-08dc28c44ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jACDmd8pXhx6JWbf17DTwuE43iFuYDYmWhOYBgsatTKSB5NdPtfNA7MOquPMnkyPt4X8VZ9JL+/lW4Wl+TvxlWxEODKhon5XJnTmMy/AHlL8zwwMKxpLjvwgFkjeAEF/A/FPVvuaoXCkqu4C6D8nQBZuZfuVEWKC9ji0W9EeZONghhjZpgT5qXJqW0wLGrkQTBflgHGKuDUz+qcTeJVA6gfMUs33Fhz4ewe8FQPold4//zPc/d3iF18n8IX8KSCdzUYRf+Hwf5sVKd9DWbwit/y//ps5vF1gPaorzDFwNg6IrI82ehViS2AuB4sKMdjY1xl/0qgG3P/QYhNoGw2q29gA7bk8kgXfKhKk571IgMoxctY5a7LxSZG+vQjvgj7jM0NvhfCIfV8l2mJj5ERg3d93gHgEBmyEh9+Dnj16ZyzdzhSKLfIWMj+4/NMAjUd1N6BgCE/2uZAzzmNiG9KHrJ1QpOQV2R6RKQuAH9As0gYvpsIlHeKFCiGpYR7J/GyzFshXng+TC6dxjfR9VhFh94lbWdhXfZJuQdRDl8RphQXFy/Il1MB+tR9eDoojOGZL
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(44832011)(5660300002)(6486002)(6506007)(6512007)(53546011)(478600001)(31696002)(86362001)(26005)(2616005)(41300700001)(36756003)(38100700002)(8676002)(8936002)(66946007)(66556008)(66476007)(6916009)(4326008)(6666004)(316002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dWxOS01QTFlLQzhSTmR1T1hNZ2N1dFlCS21TTmxlc0plL2hwaG1FNTA5dm4x?=
 =?utf-8?B?dnZpb2NNQ0RsU0hvTTI0ai9Pbjd2R3ljc0R4SlR6bVp4dWMyZ3dLSWhrdjhH?=
 =?utf-8?B?cnRERTBnQWxaVXZQYnhRTnhTVTNyNzZOUjBkVG1lbnZNY0E5Tm9GdzF6TDlE?=
 =?utf-8?B?ZGJwSnFMZ2RwaWUwR2RJV3kyR3U1SGdqRXR0NGpCWDRWNHlNeUpXcDlhMW4w?=
 =?utf-8?B?ZUZyd0lCWjdUdkdkWXpRaHgxcGxXR0ZxTitNQlZnZ0ZLL0tYNFFnTTB2c1B4?=
 =?utf-8?B?bTZjYk00dElKUjlEdWVrSEVEVDEzQUxiWEVFTXJicm5vUE8rK3FJVDlBVkhL?=
 =?utf-8?B?K043dURHcXQ0NXJybWp5aGVSNHM5NWlFTDlhRFdnUjNVeGRDN1M1a2VyODB6?=
 =?utf-8?B?UjFteUpxRXU0UFJ3OHhDMjBwbjJnWFg2UHh6TnZWc0dycFBmM2pXR3NYdHND?=
 =?utf-8?B?YVJuL0x2cEFPMEF5SDYxZ0RVQzk0eERMVkNJWnR4cFQrdEplNCtjTC9rZEIr?=
 =?utf-8?B?TjNhK21OMExSdThNOHlESGp3eE5FSGZNTXBsMFhhbks3T2MvWUNXZEFxekI5?=
 =?utf-8?B?OUR1dHJZRzZnL3pZd2NQcU9iZXZCaG95U0ZNakQzV1MrU1pYbnYrUlZkbVo1?=
 =?utf-8?B?TlYrczdqOWhPbUE0eUREeFhjMnhWaUpWakl2RDRmakY5WFh5clBjQzQxcTZp?=
 =?utf-8?B?a25FNjRPNGVCSGxod0VXYUZvZUp4VUVmcDA5VFNYb0xuUGlhSU1ESGhVR1FP?=
 =?utf-8?B?V2E4bTdyZWxwZ3hCc28rbjNtRnJWbG8vQjJlNXZaK1NtbWJmWE1kcnMveXA4?=
 =?utf-8?B?MUxNcEd1VWZDcnNTU1AxcFRQUTY5bldWQXJaRlR5RmVXNFpMR2h0dEJSNWtO?=
 =?utf-8?B?SWZRMjJVM2svNk05SFFvUGpubDgwcnRaYUVBelJGUkZQb0ZCQU5hV0p4MGNP?=
 =?utf-8?B?TGxjcGdyWjVqN01ablFhZlNEWDcwaUZNSXNENU5USkZVUTFoWG1vMUZJdTV2?=
 =?utf-8?B?RzF2V3pFbHhrWWFIakRUS0w0YlU3WXpkMzlmMGZKcG1aZzlWblJmMjBlY0ZD?=
 =?utf-8?B?Y05OWmp1V0hWREdTb1RVeEJteFlJd01sczZxaDdzWWZjZ0t0eENaRExTZHB2?=
 =?utf-8?B?eWFtQldlRkdSZEVkb01qSUNjTTJvd0lKajBGSzhqRExraWRRSFhldHgzUnFi?=
 =?utf-8?B?VkwrRlpZZ0d4Z202eDFGdTRZb0ZXbXg1U0dUY2pSWE9ESjJCQzNTUTQ1Ny80?=
 =?utf-8?B?TnRXV0Y5MnMvUTAra2xLYVJ2NmRNeU5mby9RWVVRY3NHSVA3Zmx1bk1DVUt5?=
 =?utf-8?B?SWJON3JZL0ozY3VJNlVVeHhLWVhhTkozYi9PZUtSZ1VsSkM3OFU1OUNzOEYw?=
 =?utf-8?B?YTZFeERnamdsRHRxdy93S0Q1b0tjU0J3K09ON0JqYmNKMm1YZWhuNDZTcG1G?=
 =?utf-8?B?My8vTEtaUGhqRndSTnZsdWVRRkprV3k3WDY3M3pjUndNS0MzY3FUWDdkL3A5?=
 =?utf-8?B?ZGRQNzdiSWZOWDZlWXFRTVZqQ2F1Tm9LM045QTVzSHRxV0V2UHhCazFPdFUx?=
 =?utf-8?B?RzBoY0RwK3F4eDNmaVBaaFhUaDROWDRYMnFpWEM5M1p1TFZlWTRHSnVrT0d3?=
 =?utf-8?B?UDB5ZnR4Q1hyNEFVYk9CVVNNcTBxekdBTDQxaDRqTjdWaFZheXJvZitlMTd3?=
 =?utf-8?B?N09icHdJaUV1L1RHb20xL3diRlRIdVR4VDA5NmV2ak0wamQxSDl6Y0FaODFh?=
 =?utf-8?B?VlkvemR4U1NDRFJYTHZqK3oxeUFnbXpCY21ad1l3WkVDdWVTRFkzdkR5RlJY?=
 =?utf-8?B?bjB0OFh2SUhLVEx2VlVkbDRMUzBJdzhJWGNZak15MUp3U0NLd0N0bHhMMHQ5?=
 =?utf-8?B?aUo5MUtpQ245a1RxbW1mZzV0YmhEMWh0Q0wyeXVWcmJCdjJNdENGZHVKdGll?=
 =?utf-8?B?UWN0VVZXd1BlUk1FVis2RjVIOC80dXh4SVFWbSs2VVdYTHljT055MWJBSVFL?=
 =?utf-8?B?MjhoUTVaRyt1ZXlwY3U0YXpBR3JnTy9MZmx0Z3lZbS8rU3BDWW1RYks0T3Aw?=
 =?utf-8?B?bG1Eb3dzOG1QdEpUVXUxQUZKa0N4TGFoTVAyN3hpTElsMThxZTkwdTVlUzJJ?=
 =?utf-8?B?QTAwR1J2ODhZdEtkM0ZuK0VQWnJ4dEtjYTN0dFhLb21SaUt6MjNlNjdDemFv?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EMPLAbBs56jIe/G1QG/Uwvum2uKEtOedlyBzmHaSoA8u+Fo3RJDD+xvgU1R8NvezWkQz6+Qwm/WFTm4J1AAunSYLbtW5dzKBETm+zZgCHHAm0ElUcR4V8PRtS9WKbQllZA/V5RdFqEBUjq+/2h66bXY09SJ6O3Fex07nVs/36FqH7Vo/pFuoTl4QDTGm4nDe4rcEUKASaS2XCgzHGj60PgRNs0lJK5YZfcoqHnu3MPI1OLzvxH1RcQgz8m+QnTFm/8JeE6O1WUbMp06oAZdWcoJWrN1m0JCTiTAiNGEcNeXQSdIKCdxLn7wYZ/TO6SxA9dS5wl4ZHevt+tLbexcHhMvCtFyWaCfOP6W4/DcowKxxcZ/Wlq6pdSQlW8fSFcfmif1AZEwi9sRK+Fgx7oGQtOzJnZfr0ccT2/LmtNoMchLSJQ3Nzs01PZB+G/5L9qxYYWyHME/lDQggR8Gr/yh3NXx9BR3AMmyLUSbaY3qOnXlMk/4NQ52nMwJAIxpD63hkWTpVqJlNDmYOEQRsVL85ZcTDnaKPp++wuKli8CrInZOMnYExA2mdgWli9FC+zPbEbsHvXEAjTxZz19dHZFW/HLHGxjhCPYSGBtdhR2lhIiY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f277dbd3-776a-465e-c3cb-08dc28c44ed9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 16:37:58.4029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQaIWbDKYeE4BVj4AOfN8RPTI2naswMa39nIVIF/yxI89dmMlncmg6Cqf0DWSEIqY+0eNTPeALo9T9kJ3K2JCwCnIGAGtpv2VC6WK+W90o0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5276
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_07,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080087
X-Proofpoint-GUID: 2NqtoiwdWEgmwYCxmjIFNAwY5RPFFb55
X-Proofpoint-ORIG-GUID: 2NqtoiwdWEgmwYCxmjIFNAwY5RPFFb55


On 08/02/2024 14:13, Thorsten Blum wrote:
> The Python module pyyaml is required to build the docs, but it is only
> listed in Documentation/sphinx/requirements.txt and is therefore missing
> when Sphinx is installed as a package and not via pip/pypi.
> 
> Add pyyaml as an optional package for Debian- and Red Hat-based distros to
s/optional/required/ ? Given...

> fix building the docs if you prefer to install Sphinx as a package.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
> Changes in v2:
> - s/pyyaml/yaml/ as suggested by Vegard Nossum <vegard.nossum@oracle.com>
> - Make the check require the Python module; was optional

..this ^

> ---
>   scripts/sphinx-pre-install | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> index 25aefbb35377..7e49a020c25e 100755
> --- a/scripts/sphinx-pre-install
> +++ b/scripts/sphinx-pre-install
> @@ -361,6 +361,7 @@ sub give_debian_hints()
>   {
>   	my %map = (
>   		"python-sphinx"		=> "python3-sphinx",
> +		"yaml"			=> "python3-yaml",
>   		"ensurepip"		=> "python3-venv",
>   		"virtualenv"		=> "virtualenv",
>   		"dot"			=> "graphviz",
> @@ -395,6 +396,7 @@ sub give_redhat_hints()
>   {
>   	my %map = (
>   		"python-sphinx"		=> "python3-sphinx",
> +		"yaml"			=> "python3-pyyaml",
>   		"virtualenv"		=> "python3-virtualenv",
>   		"dot"			=> "graphviz",
>   		"convert"		=> "ImageMagick",
> @@ -951,6 +953,7 @@ sub check_needs()
>   
>   	# Check for needed programs/tools
>   	check_perl_module("Pod::Usage", 0);
> +	check_python_module("yaml", 0);
>   	check_program("make", 0);
>   	check_program("gcc", 0);
>   	check_program("dot", 1);

This seems to work.

Reviewed-by: Vegard Nossum <vegard.nossum@oracle.com>
Tested-by: Vegard Nossum <vegard.nossum@oracle.com>

Can/should we add it to give_opensuse_hints() as well, given that it
also apparently allows you to install Sphinx via the distro package
manager? (Not sure about mageia/arch/gentoo.)


Vegard

