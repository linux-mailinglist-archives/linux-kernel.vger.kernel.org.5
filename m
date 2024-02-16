Return-Path: <linux-kernel+bounces-69388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D880858853
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4532DB22D6A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3711474CB;
	Fri, 16 Feb 2024 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="adljTpxE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XRRr6Nh7"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7227213957E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 22:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708121062; cv=fail; b=HEzyteOQYlKChPUwv+tce49IhD4KXuYTmVZCXIefqx7J2TBSgzRoWhoM719sHATFH7P7Dy6ACHDtS6NVn8BaTBpIMUhiUSAsEje2uM/qxw7M3yCNvnJt1krTP0p1KskiHn2+yN4iqi4vQ1XKoiSTR73hBqstM7lAKzotLV5WRzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708121062; c=relaxed/simple;
	bh=vv3wBV2wjeQhArVH8Bz7PiQLHzgIRFyD6xaS3POyNPs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ibryJq3D0L9x5osgeAObTNTPoFLPHGE4fv/+hRgDatu4hh2FXHyt14im7t7YluwXqQ6hQbaAoy1b/sDhiRXWnkz7hMImD3/sE8k11u9pe1zJm9k8DAzLsh4ycPOKSe+kVIPAxNBY8J5+wckUIriVCDbWidKliRyvVnUiSwG811M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=adljTpxE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XRRr6Nh7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GKE2Lg009127;
	Fri, 16 Feb 2024 22:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=oTH16jxDvk+tkLCN5lWs8dpSI83kg/fSCY2vqjAIZa0=;
 b=adljTpxE6nte5OBqSHaNlH0u5i/RdT+OweCPH9NZ6DIKKoswUJn+4sMiTT1TvhT2BE56
 XW2hdp23A5TqsXe3D/y8RiM5RM/aO2qYD6sVymDK4UQSTeTQ13MjGijs35cJhKDNYOR+
 otpsh2lt9a4HxqHp/aXzkHkQOZk4pMGfc/R/PrJj35ZWwqOGYgvsjK/JSaCl5IR+JAoB
 dYY8AsyAIUP0nt9tt/GEeR8jao4IclWKL7VbToIsdQHVb2JqF1nmZ25tZrDtbLIU2ydY
 G7wyswpjMPEJfB7Eg5IXKkXd+Hz67yNSG3OHnsSRwVOiz8uORadAeRWGD4prGJlcUoFP Vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92j0p91k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 22:04:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41GLvhNw031501;
	Fri, 16 Feb 2024 22:04:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykcrtq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 22:04:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1Xg3uDUJTfG8czQs+jJUG6zEyN/VohIc/dgd+bW9uG6fVzDwq0uzoEpwR7gWAlz9hSMj8V/Fm8eyH0/5r+zgfBk1xysTy0iacq3McLzrD4z1GwXWb2FnW54q5rBVB9oZ6LSwdfugTyw0nY0lM02d5gMzDGLmVENrLsr+HhW33m70cNKJnFFA7ndoTzXhbn949XVbbYMZwGNsZbe4/9H41LoZH8yQhqP35L1wAAtxcaW3zPgbatXrI4ZR0yfwGU1qWL0Qvu1O4ewBOCHmdoogoQ0uSDab3+EQVaCvYZbcjOUKupTijt1D5o8Cmb+G/Y0kFa4fJ2WAKl4u4mokrSvww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTH16jxDvk+tkLCN5lWs8dpSI83kg/fSCY2vqjAIZa0=;
 b=eQIDhsPkh/yzkDF1ciURHNVRvuz1fQ+X4Gcon1gQkvHu/qGtzyHn05vM7j65e6xYA8DbtSWJCZryTIZjbRQpNs7KtYaB9SKR1TGczjLiajY+YBdWs65WBUsyzsuLRlYmqmpIYS8PGWu5fe6o55YpybMV7C1YDLKhDVb51g92JD+Dt93L9vP88a6rtZLLbKgwJH5lPvHuoc8YRRsOr1k9ZMy1SVC/05wMaz+4IrxyAPnW98XJqef52XIR1LrGE3XuT8JlGlbB1X2OafGplTgX4XirBnMjJqBNfpm20uTR3F/ZJ+7Rw7QBdPo/DCDIrj6A0nZhG73eTPHQTXThXhxSxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTH16jxDvk+tkLCN5lWs8dpSI83kg/fSCY2vqjAIZa0=;
 b=XRRr6Nh7o+hVezJgtwOaGnVVD4cTJ4FQVtNi0cDQfq2Wyjvz/z7vtDRoE4edveuMesnQGYpcYbnkXkmtsMZzjEyuAdP9T35hUFOFexH/QOyz1AFh0Sx0SMtySPErsW+SuONwb/8EDpiRoEs0IdBvlaPd6xn1ifznpqfzAIE/zAE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM3PR10MB7912.namprd10.prod.outlook.com (2603:10b6:0:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Fri, 16 Feb
 2024 22:03:51 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7eeb:3b3e:601:2e14]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7eeb:3b3e:601:2e14%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 22:03:50 +0000
Message-ID: <10f2de59-5ef3-9bc0-b359-e0e8474ab92b@oracle.com>
Date: Fri, 16 Feb 2024 14:03:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/6] mm/migrate: introduce migrate_pfn_to_folio()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, apopple@nvidia.com
References: <20240216211320.222431-1-sidhartha.kumar@oracle.com>
 <Zc_YiSDsmdv-2Rcm@casper.infradead.org>
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <Zc_YiSDsmdv-2Rcm@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::26) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM3PR10MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 850ea375-ac78-4d1e-7a17-08dc2f3b286c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GNZtVuCf66fkmfTWSFmdjYCeYPds2mzBMarVJQ0z7qygX+IuycRoPwn09N28/bg2QCfcg0s6XiRZr3fIuMzoG+fiU1uiIpspoWrhNRetotkqEt+qFe8G57n3SiuuN+JxiIwu4so5l6g5Ts9HFfNnEb2DBFVlaqL6b0oZ3f4FKxCg8X34oKAa17adjG7r+eLYRXnSNNDfPzM7WiqqMITRr9/ovbLAtnHtp256XXQWWj/aVOH0ezFc2v1GpmS1KDAXr9CrKzM/QfuRscHH/CxfM89ieM/6wPst5UnHsw4auV1fliLfwR2FXbt97ohf9mKD4Jic4QHERzeplp194t7EybqG1zwTqxFJF56npsOBQo6WLw3iZ7HKqFoZF0CNzIcP8TPVYOPG70/XMhYu+i5JDxdpMFYqmRu6PcXQfgPG/UpA8tqdqvvkgfeCQvFgW125xvtRKSvLp/8wtDhNbqjINR/dqW3hI5YLHQ2FwWaOLa2bqzAtqriLibcgMa1wXF02Jtt/s4O3bKlEwfqvRhWvXadm0r0Bf+xK9Vz94lLTUZuK5CggmOduZ4HouRs6ZtoO
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(2616005)(38100700002)(41300700001)(6916009)(4744005)(8676002)(6486002)(4326008)(5660300002)(66946007)(44832011)(2906002)(6506007)(6512007)(66556008)(478600001)(316002)(53546011)(66476007)(36756003)(86362001)(31696002)(8936002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VTdHVkZYR3l2Rkd1ZnVmaGRESXRFcEtnNWxQbDlFbjFTYWVaTkp0WVFHUjlJ?=
 =?utf-8?B?QytNY2Qya1FBT0ZlbDdtZXc2aU1aejM3dUxVUU1CTmNaSzB2Y2dpRTdKb2Y5?=
 =?utf-8?B?eFozQnh4OS9SYVkzWmNIMFM0UzcwRGZKWExJekVoZEx5V0Q4bEFDdTFwSXh0?=
 =?utf-8?B?b1pYampwYVNrSlZVbU1lN09BR3BlZnFoWGJIWXJnZTNiT1FhbzJHQTh4OE5I?=
 =?utf-8?B?eE9pZDQ2QTN0VE5WN3N0RnlVc3YzVm1QRFlvbUpaVVA4SVR6NTc3RWN1a080?=
 =?utf-8?B?RmVuKzNCdkxhckVYcWtsWDdxelJ3SGFSNnVxM0U2VUN4bjZBUFNQb3Q3czVn?=
 =?utf-8?B?YllQME9ud291S3ZiNDRUMDNpNXJaNWx4R2RNaHVrSzVrV2pFUVljaldRMkpq?=
 =?utf-8?B?b04vZUlZSTQ4VDhFbndoYi9EV0xxc3NJTHpnMjF0MnBIZnRoTWdPU1k4Yisy?=
 =?utf-8?B?QVFLT0xuWTlxNU5LenZnd2ZCT0FsZnB6Z3ZxYWsrWXBDT2l4bk1hOU00YXh3?=
 =?utf-8?B?ZWxRQ25kRDlaa1Jja0p4WkZrNC9VQ2hzQ01uNG9Sdy8rR2JORW1kNCtGQk00?=
 =?utf-8?B?a2M3UWVHR2VTanY3bHl5WDVtN1hWdWJKVlpmWXN0RlhHNjNNeFJ5MFlIK1pj?=
 =?utf-8?B?VnZlL1lKdXM0SWMwRk94em0zMEc4VFlEM3lKb2pqYXYySjBaZjdTK2hBVTJt?=
 =?utf-8?B?TjRxYnFwYTg0NnAzRXd2RzJ4QWRJcG5xeUFBazk2L1QxMnBnelU4cmhNVjRm?=
 =?utf-8?B?T2s4OTltY1lvMU1mYzJvbFJIZUo0Rnk3OW84eHUwc3RLUkFVUUk1RlZhKzNY?=
 =?utf-8?B?WGNYOHlVdldtdVRmdVcvRVNEUExSM0pEL1lYdWI1a2VGc3BuOTVPYnFKeEdo?=
 =?utf-8?B?cmd3cUkzMkpwOUtNVnZQR095bTRLc0E5dHBvM1Ntc25NSnA2VGw5bWNORDZI?=
 =?utf-8?B?MnV3M0EyUUdCRUZxMzF0Vkx5Z2w1RmFDbnRQa0kyV0d2dWlBMUs0NUhsVERF?=
 =?utf-8?B?bVRmZ0U4d1Rod0x5NGJETXdUMEtHWU55Q0MyWXBMWkJiZ05aaG1pV2FVeHNp?=
 =?utf-8?B?RUVlVUVObTZDMkQ1R29MN3R2UUU1bWxYVEh5TnJyTmloMWZHWmI4YzJFaTAx?=
 =?utf-8?B?dW90MExVcG9kL1ZYNWhzdlNMUGF1cjhGcHZQK084TmlLZVNjOERrbisrQVg1?=
 =?utf-8?B?UE5IdzVxVTdWUmM1VFVPdmU0VVpDTUJDYUFRM1VVaXN3Yk5mK3pqOHpGWDV6?=
 =?utf-8?B?WjBhbkpTQS9tUDdiTGl3TE9hS0pLRVNDQ1paUkU4aVZHU014c1FpbjhsR1J1?=
 =?utf-8?B?VFBjQ1ZmZWRxdWoyL25JcWZoVjNjaTQrU0FvTWNwR2M1dnhMaEc4UnVqcWNW?=
 =?utf-8?B?bTE2Q0tTVkgvU2I2S1YzNzNJV29hMzhZc2NvNFhpNytOdmRHeHN1REdoWkpv?=
 =?utf-8?B?ZjZGYys1M2tHenhiYXBYZ3FCUE41MUlGb25JWnExMWo4WjRac0QrT0xFR2d2?=
 =?utf-8?B?UHdHdUlXeHhvTjFwS3JiSGdFMmE2ZzZ5QTd2MHl4cUpweUNKeVpKdmNUM2Ir?=
 =?utf-8?B?WnI1Wit2SEZiUjc4cjZiM05OK1dYR1pXOUQzT0R3YVpteExnUnNDUytBK0V0?=
 =?utf-8?B?NVl6N292R2haVlVjaTJmWFh1NGZLbkwrNVhRVWoyRHAxeWNkOEFCQjh1cklO?=
 =?utf-8?B?WWdsWUpLWXJlM2RMeXhaeUZqNUk1VkpJZWJpZ1I3Rlp2TFZlWDNHeEFqU2Jk?=
 =?utf-8?B?UkJkV1VSbjFQWDVuMWp1QnplRHFUWHd1N2NEeTVVODk2UTY4aE5ncFhqK3Nh?=
 =?utf-8?B?NnFDVUc5ZmxPYTc0R1VwWFZFMHg1Z3pucGdOdkh3MnBLUmtXODlVbElab0FF?=
 =?utf-8?B?REpmL00zQ0FQN0Y0bXYzRjlObFBvNk81S0t2eVJmRVlJOGtneFlpNW9FYTRK?=
 =?utf-8?B?WkcwcFpEN2J4ZUVYa3ZiQWVqcTVNSW14SzV2VmlMRk9lWHhsZHBFY293dFBy?=
 =?utf-8?B?NzFSQ3p4N3c1eTBMOW5sV0U1VkdFdGx4UFNxL0xwcjJNVjdISkNya3JQaDBQ?=
 =?utf-8?B?ODIzVk8zcjhTSlFSRnBNZS85RHlzL29Va2pzRjFoeFlpdWcvclNVaVJQc3JU?=
 =?utf-8?B?MlZtTkEwTHB2blhQT2ZZNWtXTGM0L0Z3UXkzcVRjRkVnL0x2aVlwUUthbURq?=
 =?utf-8?Q?zOO4d5KAVx8atOUOGGGV5qE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JBsIYdl9Ie8zN2V1Orjb4uTj41zxWs7685m5Cg1ovuA+ooXJPBfX3RJbhsi/ysHsSNDrAbp+b6skhUoKAbjEtBmVp2SD/tUROnCnfS0mAfdiEkXR9BYIRCqAI+ehNNWAoBMa4Ccd7uPwsuLgCx86ExePWeIsiT7xDL17eVEDYBnyVF26EvK+w+4wgx6twpz1JN7I6MjUgU5AD7oN+O7663Ab2akYPi7/vvUxbTNDxVnUo53O5YSOOQv9qTEWzMeO1OgmTmwgr0A6lmrqTtBeDGnkJ6UMFwuc7xPOCdk4HH408GGpoyuivEifwqVy75U6CpgCZdFKmkRxnrBkl3c/TV9RCVOHNuLlNwQ07AynPA6tbhPNpmOEBR3qA4K+vSe+LcsTGx7mhDT3rgTYY/Miz2MCNNFDY3RBcDqprKryaEo3KvDuXKO3ameQLEW1vuaCfUKYEBybM/sZAvY1UFAtQhR/g1mylrWYmTlkiHHDyiR8YEZ8coRf4qj7EXDkDjcwYbboVT3Yv8EGaKKPu9J9H0xogqrNY0KnuKDjrAvY7iXGpsG+gjuC5rRQV4tf3KgzgMwHuv1ZQmN583B3oIcGgf4OiLV6OtkCaTneaq4tBCU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850ea375-ac78-4d1e-7a17-08dc2f3b286c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:03:50.9423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvffFicuco3FiFxOdXwdLqnc0v9VWPX7p87ulpbvy7w1XOHuFKmekSsC2J+1mGjgn6mSUKC+UusWCbLcqwlTZd4Wkmvfjdkpowssgg8XQjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_21,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=849 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402160174
X-Proofpoint-GUID: 0V4gIdcaznVKA7IoXvYODWwTl3N8sJYU
X-Proofpoint-ORIG-GUID: 0V4gIdcaznVKA7IoXvYODWwTl3N8sJYU

On 2/16/24 1:50 PM, Matthew Wilcox wrote:
> On Fri, Feb 16, 2024 at 01:13:15PM -0800, Sidhartha Kumar wrote:
>> +static inline struct folio *migrate_pfn_to_folio(unsigned long mpfn)
>> +{
>> +	return page_folio(migrate_pfn_to_page(mpfn));
> 
> umm, no.
> 
> 	struct page *page = migrate_pfn_to_page(mpfn);
> 	if (page)
> 		return page_folio(page);
> 	return NULL;

Thanks, I overlooked checking for NULL before converting the page to a folio. 
I'll make this change for v3.

