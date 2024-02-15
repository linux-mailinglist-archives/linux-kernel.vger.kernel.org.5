Return-Path: <linux-kernel+bounces-66884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7938B856314
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88F53B25638
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CDB12B156;
	Thu, 15 Feb 2024 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A+n4+JcB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PmoeVXNY"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5668A6A339;
	Thu, 15 Feb 2024 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999914; cv=fail; b=JM0XoPIHxwP1SQeGML6QS/PLm9oVrRGEV0XeGWyU6oJwEQuxInzBp63xdS6ZMup8uzDFe3rST3TioB8z5vxR8mICK2IC2xmAKKgxxE+0Ju/HHuEoEYxTieidlrIfiYQFc/oNRbUK5dzKa0Uv9Ja8VUy+Yv4MTYNw+IJ8yW5hTp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999914; c=relaxed/simple;
	bh=2djfSmpFv0v65dxy+IDw8UvmiqvoFmtkFq7l59P8uAY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uo3BCCo8N9+VU8R47gL4967Ve8SkAytT7YjiQdez6lEVJl6A1eF4jokDOUXQmNwRoQk8k/T7yUdQtvJgHN9M2HzVNUWgf2P8fNbySHbttzGdWu/nO/VPTVu1OUDnco+r14LmpnaXGYe69knbxWZ+CG8QiMaOHHyvJgP4c3pRQTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A+n4+JcB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PmoeVXNY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41F6i1wQ027890;
	Thu, 15 Feb 2024 12:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6p67dA+hWi9+VuUjfgrJMMtm4MgbKiTUKQFwPReWmJI=;
 b=A+n4+JcBW6PF+D9m9Jq+wVuoCZLTrWvxwcjY2QhUkoVcPX2oXV9IRpFYzwJ8nFd/sDey
 ZXf8Lbso4KUt5Y5SVUKnKKbsjbXBShb5gEHzOcvPWFlCWaKcG6LV4k4GUAvOvbow/iXS
 tCaH3FFwkJjltJNs1JptNRgAATyTwFpFIBQSaS3jrgf1SmNzEgWKjuvsrBdd0dCwMmPi
 mGv3SvGvO/hwSoQ3rOrBT0klj0tZeUjHDdG6UUHMIFfanxKKk6NFbkKdfRwEm8P/Ml8a
 GboLnG9HipJq0y6AVBkI0j1Sdhzii8dX8AH4SHZLSLM5+C//XBMzsplEg2oNgp+wRmIX Aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92j0j0j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 12:25:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FB3J54014987;
	Thu, 15 Feb 2024 12:25:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yka5cpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 12:25:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4GEZCggRxPirJCVKTOPCSQU755pqsjr+BnoT8C8xA9jt9nKeX4KmLLuuuKYTdlvqxLO9uijjGuK2js9UWpADKGMJKnPNZrgdILTPKHTbHMywdSp0lPCw3Kzua7J6E2G0KnNAqic3oiHRUk61XlgBDG4HWruSw5eb/Lo03ta9iAfX5oynUQ6zJaww9c+kHrn1wrp2i3iGbm4iuZqNRhTZvAKPi+r13Jqrb92NM7CgJXq2+5WMCkCHVlPxAJcM8judcQecCxIlTJ4aDvKpRsi77NZXky8W3wK4jP0GOy9t97TzhFYo/8i8WRQg5GV7tvfpxtD7pvsS2fEoFTeurBkhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6p67dA+hWi9+VuUjfgrJMMtm4MgbKiTUKQFwPReWmJI=;
 b=YdAYu84JzezW9HPGgpd1efY1vBEZ0zJX7dfq8nhTme3Vy4AOcRd+9QqyoQHNVm85zndhS8U0EmjwilVQftzX8/1WvmqINb7L0M1A3IAweKyRU9bFPEwgxqz/JSeSMdO8fz+6YEzYbOlloyhmEKtDtKlH4LBVvQ5sMTGSkfp2nQCetIX9nUGnLgjuwHbgWFWCKsoS3mQ+IYI+E5CwgDRV4xSMl77PlUZNqbVZs6uKaPkaWdGOCXacGOqUN6ayXjFUgfmUd+kLapiFYZljHcKmDiAEYKJG5bLSzQ4TxYxMTBYolVFo39W4sFI3CftbE6NbqA+h2F0k+UgsqB0C9WMooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6p67dA+hWi9+VuUjfgrJMMtm4MgbKiTUKQFwPReWmJI=;
 b=PmoeVXNYNgLeB78y7fOnmDx52N2GjKmr4eyIymDbDCkRrvfbV8TrIjUQHB1HDbVGY9MNh6b61loUI1myBG95NjXAD6O5m7E9Dz9YXF5tOSTUKw3mnHlIejRCD9fpZdAH/dFWF2CeQ2Inw+dJzGsHEqaDlSQ9bMyzQdddZU/KuE4=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SA3PR10MB6971.namprd10.prod.outlook.com (2603:10b6:806:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 12:25:02 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::6e32:a89a:f2b6:864b]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::6e32:a89a:f2b6:864b%2]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 12:25:02 +0000
Message-ID: <26b25204-9829-44a8-9836-1ce1c8725586@oracle.com>
Date: Thu, 15 Feb 2024 13:24:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, security@kernel.org,
        Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
        Lee Jones <lee@kernel.org>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <00057b93-b5fc-4536-b13d-cd3b6cead5b1@oracle.com>
 <2024021530-plank-cornmeal-90eb@gregkh>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <2024021530-plank-cornmeal-90eb@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0340.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39a::7) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|SA3PR10MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: dab7f79d-1fc3-4aa5-0ae8-08dc2e21225b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jmSiPTffWBPVLc7nJm1N9/1Oq63dgyON4zYd8QrDaiz/5Lg4SyS7f+NLR9Z61JUGhCf7c337kAyshkhYu0xRVeQ0gmXKKOVczU5EYb9J7f+QMfUMkXTdJ0laItu0+3heFxatxOcV6yrQ2bDuhzjyHJ6vZZzmi7cbXr3/QFCvO+oQNkh4PRr9qihjeh5qxwgO/3mJmrsnL+mN7OBHmirc27vZSYVhxYX9Pqn42qp4Qo/IPGQBofjPwQ7AvUaKo6gaB7t0CE1o7ddl2neZ2Z1l8vjF34nbXAYCaRuhr1kbY+7jp1/3QJl8tiKhVXpLGdIVdvegWGheWUbUHeM7PNoZIbFBITsq/vcLUPUAkmMPCqTjxfUxPRREQ3DrIlZR02ugZ37cSQDTxmtC+9qLAnvNxOSPEmrCyungAd/Qv2MYM5J7eEnfAMnVg5aU0HEtiTzIqlSwLDrARTh1mtDu9zTuQq8zg28ryZPwEDam8GnmDNxc/qcbrmjvFlF/ErU9dZ8mJE9IJcgl0m99abVoOwRWQPOjQYIEFCQVNrJfbJpsBls=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(31696002)(31686004)(66476007)(8936002)(478600001)(4326008)(6506007)(53546011)(6512007)(44832011)(2906002)(26005)(83380400001)(41300700001)(2616005)(6486002)(966005)(38100700002)(5660300002)(8676002)(66556008)(66946007)(6916009)(316002)(54906003)(36756003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z3VFSXY3R2VZbDA4bkZMQW1GeVZQTGJnVUdNVFRGVk1YL0ZMdWdhS0laVEQv?=
 =?utf-8?B?c2RIODVnZ2l0c3dLVWdMMXp0UmxpSjdWWE1mcGEveUdZQ0hXa2NDUTRHdjN6?=
 =?utf-8?B?ZlBRNE5wZkxjMUxVNzZrdm9WWDkzY2Y3bDd1SUgvNTYyQUQ1UXEwVG9iQXo1?=
 =?utf-8?B?eFpWek1tb1NmT1o3QkYyajZwNi8wSEtuM1V1UG9ZNzJhUG9oL2tIcWRIQm1N?=
 =?utf-8?B?SmVNVHc0WVhtMTRuQ3hFeFVzVXZWbUw5U2h0bTA2Y0RGbzJrRWFxTzg0NHZG?=
 =?utf-8?B?bHpJUlEvMSt3RzViaFhOTUxwLzVFeW5GTTh6ZmFFSzI5N1VjelAzVnlTU014?=
 =?utf-8?B?ODRuRFZ6ejVFbGVFNjJYTnN3cnRLQzZPcGZTQkwwMGRhVlZlSXNGZDZPVFA1?=
 =?utf-8?B?b3JsL2dPcEFXbi9zVHZnalF6R3ZDNHZRclZaK1ZjRWNwTm8vdTR0ZWwrRURs?=
 =?utf-8?B?eVQ0RnNsTU8wZTdXZ25rNm8wSjhNQlI4NWR0Mzd0NWd1cW5nbzU4M1ZlTk1S?=
 =?utf-8?B?WTVuQnVQVnB0aXZoeEp5TlZCMStFN1VoRk5BcHhUMnNla1BsNU5OMG9ISkgv?=
 =?utf-8?B?SXdoV0poQnZtb2dCMW1QUy9TbnpLVHRITE1tWkdQbkV0ODlRM01VSTlRck9o?=
 =?utf-8?B?U29MVzBBNW0wN1A4Z05YSTQvS1lKT3NEUXZ2aitZeFpJYlJPdnRJN3BCODBP?=
 =?utf-8?B?b04yV1BaanFOTDg0ZVJWWmdWc3RqbjZXQnF3aXdKZDIyOU8vTmtGSHgwZis1?=
 =?utf-8?B?UEtYTGpWaEJsb1V1L0tkM3ovM1VDSGZkMzhydEpYUnpFQXFiaXZQSDNaa3RQ?=
 =?utf-8?B?Y1MzNkQrdjYydXFOR1l6L0FNbnEwY3oyVytJdE1ETUNHcVd6V3lBcnYxYmpr?=
 =?utf-8?B?QXNxa3c5dG1UUnZQUVpIc1FSQWNuMmZSbTFZZmFLc2hFdFNVZWZOUnF2TXJp?=
 =?utf-8?B?aWN1UkxyMzhyNlo5blhnQktkV0Fzd2Ziem94bDlxRW5UbVN3Wk9WL2x2dG1x?=
 =?utf-8?B?OFlNUytQZ2J4RUpLdk1EdFFJcUxDYWZRUVI4ZG5zWE10cEhUMWd6NXljRUZY?=
 =?utf-8?B?ZnlhNmNtM1JWRm9PWkNLazZJN2VyQ216eE1OdWVGcFh0ZlVHdjFlcUlKQ1JZ?=
 =?utf-8?B?RmdmY3lUbEhLZ0pvcGR5SHpncmVLUWNGK2tXTUZaOW12VmFIbUtlTXNXdFF1?=
 =?utf-8?B?NnFjeWo1VHl4aFdVbjk5cGlQaEVoMllsd2VWalZPd1htSThXeGsyZDJpSXA3?=
 =?utf-8?B?NDByQVZZZ3pUcmJRcDMreEJSZnFDU0docHdvVERXME93TjBFNU9oczhQZDdZ?=
 =?utf-8?B?QjczeDJoczM4R0FUaytNWm0wd2VBNnBvLzZwRkJsVXhobjZqeTRMOTdPNW9O?=
 =?utf-8?B?Yyt3NXc4cUNNcHRiTHFvajhkYTVNNEFCRW15ZXhFd09uTis3V3V0UUdraTdt?=
 =?utf-8?B?dVEvVnhVMC8wbk1jU1BFOGpYMVptTkJyRkJ5Q25GWThTQU0xWXpjRFA1cEho?=
 =?utf-8?B?ajFjQllnYWl1UnRpNTFRMTFmNFEvaC9WNGJWclI1WWpDdCsrV3pSdCtPdm9S?=
 =?utf-8?B?c0tKT2s2ZHdXY1g1ZHFxN3FKWVFiaE9YajlDRHNJL1dLZmVRdHJYanYxanNi?=
 =?utf-8?B?UWpMRVlLRWFMbE5OeE5lQjZEU00ySy9tcVdlVTFzY2JuaDdySGl1bkpHTXFI?=
 =?utf-8?B?Qk1VWGk1bnc4dTAwbTIrUkVqZVlKTzl1MVNYbHgvYkRNQ3l4bGttRm1acVlz?=
 =?utf-8?B?WVBwTTRlTUwvaE1wRk1rRGF1UWJpTFdxUHFiNzRZcll6SDlxVEx5OERwV2xG?=
 =?utf-8?B?RjJSRHJ6RUVKcy9UaVQ0cWlWcjE4TDVyQno5YXJmbVZ6c0FEVHVGVTZCWVBO?=
 =?utf-8?B?MVplcHlSKzdjV2libzZRRWxPSENoTU5uSzMvNjE4dzViM0JXWmtITW9UMDhQ?=
 =?utf-8?B?VWRXSWdlazUvamNRWXBUSjRUY2ZjbHhKOE9rR0F1MFl4elFpZmJNamFXanh4?=
 =?utf-8?B?QzRFUVc5SjFMZUxZcTFsTS9wTDRlRG1nQ3RDUnpFZVRGREhWOWFXU1ZXeUxK?=
 =?utf-8?B?UjJNUjRJYWxBaGErdVZZZ3BuWFZsM3QrdU5OK1BJZTBHNDM5VjVkVzZkeFBw?=
 =?utf-8?B?d3NzMk8rNXplMnFQRWV5VTlzNERMdGdhM09PVG9BTlRORHI1L25ER3FQKzU2?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/uTy9q3n9+G0UJFaStc2Br72GGfzig1eiUHMsCCMrtAg3Ja8UdT/2Jr8OCzGIIiqJF/1ksB1RIAHc/d/ZcWzOepshVSPqdI0OsVzUIDaSYPXUIYX/2KLsJmHp9QVbl29WoFDhOYFOl9+uRsIhkAgvv9ipgNWBwN/n0CrqSYiysqcxix9QZC7cuVLKXJbjjHj2BwCyWqAaVqbuouomrLyBClumyRu2Oouscd2Dfr4HPDYSm9bJM/DmY2rk9d1fbv5Bx8S93f5yS7TRbvHKk0YjVJ1wtvGg1iv4/e5aruq9hfduwTL+dP1/16DlFwANEr49WeI0SWs4YxJumxHoWcrfe9O9jWhelUKTElwZzS8Qi9T1zXsdS0LWLWU+JeQDYjPmh6zk6mC/r4PwBdghli/PwEAxZMhxiGj3GMjhI0IarrFi9Uzj04VufidSjSin4XATGOYzGTo1cMWmTlJVdwrPfDNh+J07drdJWU9R++tpe7hKbhaw5VyBBD/dljyP2Jdgp9jlY3X5RDYtpmEfYLSSX0X43oeNJ9OC6aIlxELgscgiYdkBZN3+I6/F7kwVqe9Pf7BEWhLqfYbl1Rx7TRvIH99w2LeLcEqtUPEh3w22N4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab7f79d-1fc3-4aa5-0ae8-08dc2e21225b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 12:25:02.7200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iT7Nu91+2V21rRZYJ99+DuWk8AiidDCiZMXrhxFWnbVcA6Bz61znXWvMqBhz3ZqHmN12A5SNuvzOzxa0r2jhbG0QuW0kD1zHb0O3Rt3eS+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6971
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_11,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150099
X-Proofpoint-GUID: 18U7O57-QIV9J5UljsByoKxMnwT6vDzA
X-Proofpoint-ORIG-GUID: 18U7O57-QIV9J5UljsByoKxMnwT6vDzA


On 15/02/2024 12:50, Greg Kroah-Hartman wrote:
> On Wed, Feb 14, 2024 at 09:37:31AM +0100, Vegard Nossum wrote:
>>
>> On 14/02/2024 09:00, Greg Kroah-Hartman wrote:
>>> diff --git a/Documentation/process/cve.rst b/Documentation/process/cve.rst
>>> new file mode 100644
>>> index 000000000000..6465e6a79c18
>>> --- /dev/null
>>> +++ b/Documentation/process/cve.rst
>>> @@ -0,0 +1,120 @@
>>> +CVEs
>>> +====
>>
>> Document titles should have ==== above them as well, and then you would
>> need to shift all the other headings in this document (i.e. all the ---
>> should become ===).
>>
>> Info here: https://docs.kernel.org/doc-guide/sphinx.html#specific-guidelines-for-the-kernel-documentation
> 
> Really?  I copied this directly from
> Documentation/process/security-bugs.rst which is in the format that I
> used here.  Which one is incorrect, I'm confused.

Documentation/ currently has a mix of both formats and they both work,
but the guidelines linked above is the gold standard and what we should
aim for in new documents.

The "correct" format would thus be:

====
CVEs
====

..

Process
=======

..

At least this is my understanding; I'm happy to be corrected (and in
this case, we should also update the documentation).

Thanks for your other clarifications.


Vegard

