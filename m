Return-Path: <linux-kernel+bounces-60117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA40850014
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00191F22CA6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D446037143;
	Fri,  9 Feb 2024 22:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IMstcmY7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yf79AFKP"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D102239AD4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707518058; cv=fail; b=E6o8rYeHzLgs8r8rlI9ZrEl+YtR9DtAI4Xg5luMgzJqUyfDl9I5gzEHpjspNC3sn4/fvMyuRMZ5TR7CGNkETo4uAOuLVKYPS2KzVhe+SKDV0dDB3l/eQHLsuJS2ZAAHuDZJRQJul3QUecvHq58ky9famh7MWb+tXEZuO9yjLmMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707518058; c=relaxed/simple;
	bh=ig+7d3FElg8ZebiigSJc/+WutL6ehcT262RTX7c7oAA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R7RcdI4+Jj/DJ0eP+zDGeQtX04oo1GTz5foZTaOK+/TYw8KzxhaPx1B2+Poj4SGe13VLOoJJZiUw/BXXveEJblJ/YjjFJ93q1zbYasCwA+dmhovDMIlO+6g1j11zYOupOMEsc3hV2qMgz52BlzWMp5n0FLQuMtJ9/SeITOj6T/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IMstcmY7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yf79AFKP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419MQgU5005187;
	Fri, 9 Feb 2024 22:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=SQxutcVTcVqLAZr01rlRr/xxA4oJMaJWpQbJrdR/pHw=;
 b=IMstcmY7lB0Wo37Yup+xOcB6be01kFuGF2LYAvLOVgmaY+ggBVQVutkCKCBhBJxjiHtj
 pVvrrSq/+uOvMsbyPiXvNnhxLIiW4nhZS262YwkT0Vs50bShZXpI9z4UR9dbQmzRiOpD
 hClaSdqkQ3eZjreaI6gxNvsQbwBVHbSm9nAPLd56XyM84NgVoj/YpeEsLxKIOukGhFXD
 lI1eoLa0g2BBerA4z1OG0zpH/QveOshWuwtd2S87KDjcRPnoKamsbMiXQL+ry0mb3SPD
 Rn81I0QX7MLvAoZXhm2OIzSBxHlLeqA5BdOmkdZjUXC2m5/tAclApxiiG3F0H7t29QOv pw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w5snr0eu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 22:34:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 419M2lBO038395;
	Fri, 9 Feb 2024 22:34:12 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxckhvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 22:34:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7xRlfOL79ESGVp5RuzF+Lb9aLrP3+h9kHKs2TvqR12GLK6+l5OakyShgbLTFuF4NtkPmkTCfpZgDnJ+ZdRWHIIUdi+JmzEbwwy/K69qxTwzz1ArHqeWnfB/suo3zUpLf0zo6+FJ31xGrg3Rr9i04UopkCorFPBthPDVnFnwFrLV0LwSnPlkAWRL/djOaNRI3LjKNxYz3f3Zuc+28cNZAH6UDMssmSfXpU27N8cjvxWvyo8UEecMgjy0SPysiS+VBuycBru6Vrh2nJFesm0vJvtdW9TG7+ooYo8XAO3LdL8XoU/Ad9WiwgPbMeCvue8GNsI2dV+dE6CgVUxoiU4U1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQxutcVTcVqLAZr01rlRr/xxA4oJMaJWpQbJrdR/pHw=;
 b=VBktXzpMyBPy4nQjePd5EK0iUhha4IrJlDfyUz67vj9KdzpUQmjCRSp85hMsJ/rpxgtd6wQr1Ni5eCZAKy2cU9MdZpZGPIrbDYt4LXXbuCFT/R6VOHtUnIJAzHs0gXhDdrltc9sUkKUyfXrzPAAOXOKqfVdQ3ynEuDB+syxhPKDmM2zXpxkBgACoYLrIEK1wZU0D1hI87CvwtUMAHvlKptTKLn2BerqyPUCa3xO6/qSa/ELihRG93VMQ9TGqaelNuyBvOjFFGt2i7cMUF8IQ0s6vuoz9l+H1FH8nN2lvfdGgctYb73h1xra/cINK/HQ2xaXhv3VqzY8mGUUThfESYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQxutcVTcVqLAZr01rlRr/xxA4oJMaJWpQbJrdR/pHw=;
 b=yf79AFKP66oVt17dK/tvyrcfP2fxyossQXQ0b4IgAiKUc1jYNi2YHmpWU54tofPrp+SVjqy4DcBAkbHLt2tv/pL5BUtmKlgApmlH2HPYTHkuV85KKZhrqubs+4regwiLktdv5rBX2fn+aRqb0p1WjWkVE+S3NIius71be/4eXhk=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by MW4PR10MB6584.namprd10.prod.outlook.com (2603:10b6:303:226::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Fri, 9 Feb
 2024 22:34:09 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 22:34:09 +0000
Message-ID: <e538b2cf-d1fd-4dc2-a09b-e5b4b90704c2@oracle.com>
Date: Fri, 9 Feb 2024 17:34:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] vdpa_sim: reset must not run
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>,
        Eugenio Perez Martin <eperezma@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
References: <1705519403-255169-1-git-send-email-steven.sistare@oracle.com>
 <mhnsrwlvqjeftu5aa77iaowdk2wrq366yofjchbn5fwchgcbna@kcjtoj46fawi>
 <CAJaqyWcLj7Y0rm3_jdfP8KgS4gkE9ns286XJywBGE0iijMireQ@mail.gmail.com>
 <ouq2ntygn4i7gtld5utumipzggcakbqhu2hc5lbznoddhvezkk@jstz4h3vovej>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ouq2ntygn4i7gtld5utumipzggcakbqhu2hc5lbznoddhvezkk@jstz4h3vovej>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::7) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|MW4PR10MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: 57fb2194-1c1a-400a-2839-08dc29bf3ba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LJEySLECOEzU/S9MbQkVwEUZRO3DfYNQdEnG5y80E0s/TANpRxca7G/V/oBA9g+UyF6o857AFWFu3V1LfBBe/6zfZ+P9TJBx6W8GW53ygfLnne2Ulkxbz/vFnsSpftWfjuLbJyTG+029jp7Qr0PYo0fx0aOPQm/UvCCByNOm/Zl8494d46P7YK4ZkldQ5WO4oB6Ygpue0686dwYlqm/q1Af+5NoHPJzggdGwBauENh4ekbBY2+dypjs1oF8ftNKsy4G8BsKX2W0oZcOeWYW+BHg0gHZzBAilc+ZNN85L+tXf21cGNYk0KAZk1VntddTXufsErBBB4gAkHspimlEM88gFkmjibTIYFCK8h3NKNXrS/3cDQ8s1bXHd2FPJ6djJCkaLG12I2lntY9xi3f/rTgCKUz+GS/NA9hnaDsf/azoGidNobOTylj6O8Y3wF3hfS94ElcX76RfSdMPEb44lTVbeloPmZeKuRleh8oIAV/Rx43JQWCxXXlVwcXhsahcka+GjHZn9HpncgOz7yWoNn/V+F5/fFh74ojoKAi+yEIysmWtuC8SKM6YLMpFkOx5/
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(41300700001)(83380400001)(2906002)(4326008)(8936002)(44832011)(26005)(5660300002)(36916002)(6512007)(6666004)(6506007)(8676002)(53546011)(478600001)(36756003)(6486002)(2616005)(107886003)(316002)(66946007)(110136005)(66556008)(66476007)(54906003)(31696002)(86362001)(66574015)(31686004)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TWk2NGhQVm1vMXd6cFRKb2lrRUhZdmdzVW5oODdkQ2prMzdvZGtReDZaQTlR?=
 =?utf-8?B?WStSWXozUnVsYTR2am9TejIwdnNEL2w5RE84TWlCbVVObk05Q0ZXY2MxK0Np?=
 =?utf-8?B?bzVtRWNHZlVEWHN3MlpEWUFIYTFqR3RMYklPd25JSWZvRjNyays4V1VOTzBo?=
 =?utf-8?B?dENscVFTZERQQUNiblZ5akNYaHpDUVdUOFZwY1IvUVk0NTVKWjZacUJZVnN2?=
 =?utf-8?B?UUlrelM1WWQ5NmFoMzBnUm9oVjV6VU0xc1VZT3RpTUw3Mkp6OVF4aUdONmxU?=
 =?utf-8?B?YThEWG5Vakc2dlNyOEVtY25ZMFJjRkpRMWlpWVdwdzBjNm5Tc1hzb1p4N0RP?=
 =?utf-8?B?NlhwTy9iTEVCZW1ZeE1aOENIZElHZXRoZ2RZTVhNb0xHMUU0TytGQytvM3lJ?=
 =?utf-8?B?VUUxa3BhU0dsMGkzL1NXR1ZCMFNFdit2T2FmT2UrSnNETFozaTQ1WGwrdkRj?=
 =?utf-8?B?T1V4clc3VGt5b3UrSzNLUDBTVTliUzZ5NnhhUjIyT0hvanllOWd0UTB6Mmt3?=
 =?utf-8?B?OU1HSWliN0RYaEMrR0dFQitqZk1reklldjRxYUdWQlBCVElvRUlXTWVjVkoz?=
 =?utf-8?B?bFJXVGJhcW1zL2JYUHRJNGpRNDhtV2pQWUVFUEJ5UW1aVk84UTJzWExkaHBD?=
 =?utf-8?B?RzlId1piTHdqOEZZUlpyRjBzV2Q1VjhCY09IYmF0bEQvRVp3SkQ3VkI0NHJ4?=
 =?utf-8?B?TGt0OEsrS0hENFJ5bnczQk9uazZQRDM4QW5pNHVjMXJZUFF5cklSNEkySVhR?=
 =?utf-8?B?WmdXMlIzYlZnQmZWOWVVWGZ0aDVHZ1o0VUkzODAvQU5NWWNMeEhGb0U4UnE5?=
 =?utf-8?B?dzJHdmx3alpNeXRqVFVGaEFKRHBSc3YrU1ppVWtCaGJ0WXdMOTdURzIzblNB?=
 =?utf-8?B?UHNZcnFXWlpNY0F0S0Q5b3dvbWhIVnhCSThvNXV6a0tPbDRiOTVjNW16dFI4?=
 =?utf-8?B?SkVPK2NpUnovd0FzL3dURWVLZzZYcTZuelFDSm1YVlU0Qk9ZWmdRamNkbXh6?=
 =?utf-8?B?OXI0RWluZHNhYUl1RWZTeEp0ZUg2bktGeUpTYkNkSEpEOGlnbWNkeVpJMnVY?=
 =?utf-8?B?Smo1ejBDVkVpckxDK1dYbTZqZStsSWVEMi9HK3k5NGN1RE83MDdrT29XZ1dU?=
 =?utf-8?B?MWpET3NrS2ZtK1NXUk1kbzdrbG5HT3JVeURod3FEck5HaEk4VlF3TkhqbDR6?=
 =?utf-8?B?TUE0YlJEYkcvSG8zR0NHZE9SWXMzSXhBRGF4Zy9UU1QvYTJvZFNOTDZTcUpC?=
 =?utf-8?B?SzFXOGdJc255cnBPbys3UFdiN2pSNnlNUW1PeE1QN1lXclpxRWVSd3hmdWY1?=
 =?utf-8?B?dnNGc0hnWnRybGtCVi8va1RKaUpveVlLMHpRYk9CQXEzc1AyUWp4NFROUTVI?=
 =?utf-8?B?R3ExeEtEdkxKb0F2SU53dW01RTRQN3dlcm9mMUxYS2R3QjNlcnJmQWdsdUZ4?=
 =?utf-8?B?TW9NOW9NeGN2K0dIUVdSUmZZTnBqclBlTXk4NkFmUFhuU1pPVDUrR0cvb2lu?=
 =?utf-8?B?VkZHT1RkSDhBWmIraE9nUm00TzFMZldqbUxWNzlrcHBHWThZeW90SUVlVDBY?=
 =?utf-8?B?WDNVbmQwQ0VjQTJuMnpVNDFuelRjcy9tN3BUSzYrWmR5MkcyMlJIUDNhTFE1?=
 =?utf-8?B?eHJQYno0TFBnWUNZZUVrbFkzemkzdm0vUk5TS0FmRGFkRGlNMWNKT2E5ZlRN?=
 =?utf-8?B?SlcrMlY1d2dleUdwMVJRNjFIMHZDWHpUdk5lQ1lRZmlEL0FFekpUUlRuYlpK?=
 =?utf-8?B?TWo0cmZmZ2dDWnVJYjhxK2RkR2pZWUlBVGVnMDBBbDYwM1BoYUJLdU1valdu?=
 =?utf-8?B?Y1JURUVveVpsYkJTT0ZIenIvREVsRHJtQVV2UFRnRDh2T0l0U2JXb2NCc2xl?=
 =?utf-8?B?SUtlck5hL2g2Nnh0UWZRRlo4ZUdjMmVrM1QwOFkzRXNPREg0OE00aGVKVmxD?=
 =?utf-8?B?NWpOU2REcXB2ek1NTWxHekk1TW9EZ0FWRWxiZWszOTYzRTAyLzJsNDZmVU9L?=
 =?utf-8?B?dVlCT0RrRExDNFJ4enJHZVk1ZDN1T1FKSUJucUJ6b0k4OHFBZUs2WDVlbDB0?=
 =?utf-8?B?UURHcGxDTmFRTm5DLzVpVVVTd1ZZT3orSEhyVU9DWktTeldVY3hYV3dIOExi?=
 =?utf-8?B?MVMzWUpUbi9pQ3ZjanJWQXB1UEZmUWYrdlBVVmp1Zmg1S3NhUm81YVZTVXJI?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HhUPlM5pfDEti31qMhWWjs+2MG3ZJxx5ei2nc5FE5hSP+XYe6tI5fkIVCECu2I0TnKprUcNmhWH6oat4sop314+ApluocGSeicmv8lyNukjmDSOYkiPEHzqFi7E4HLdfnSyXbJXjE7bdGiWe3eADRFUHHwXrmmb5nvmL2tVpnB1zJ/gtqCPNYscG8Mdrg6Kt+p0d+FiG1Zw3HjJVrn7ZyKIaqtj7lXCy76hCh1HaQdziB5eb5EwyKYw766+Rwgh9cjQ4NXuGSJCk5jq/vLt0PImcqqEMyXLSqAce4LHJlXWMa/1tIFvrzlt7IPDibJaWw4bHo3C1t9hdBKybNh3tkgUFUQUFpq2n8GlLg0nAZhr843hYDNwTSs0dBj/fxhKVURDKR/q3TwpN2n6ce6KWTZI66etKvVlogxA7TeJpH0BGfXwu/o5KW2rn3MQnHjoqsk6Ao3JHqdAdPBemNoT5WZBF9CRNSGFHcCjIGxKEBZB1B+OI8dM7V46kvqHZo7yZTT+wXwetEOXygPDcK91EitAhnDRk85GZU6rfUhkghPaw4j4Ob5g3wY4PFuIO8uLUEorxbOhKtXIBhJqTmySLosa9b9XC0WZQvxbcJNjS3B8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fb2194-1c1a-400a-2839-08dc29bf3ba7
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 22:34:09.7508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CyPaW2EgWs0EYXw2fBJgSNgN2bSUEMpf2lGiaW7T5eJNSNg3ovjjWwHGsnaSmumeIslLAZWggJA+Kbu0pbWdLFX1dN4nCWfHz6sEu2w8NXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_18,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402090165
X-Proofpoint-ORIG-GUID: K36OVJO6aaPNwH-HJEvesQhkah7APHhL
X-Proofpoint-GUID: K36OVJO6aaPNwH-HJEvesQhkah7APHhL

On 1/22/2024 5:59 AM, Stefano Garzarella wrote:
> On Mon, Jan 22, 2024 at 11:47:22AM +0100, Eugenio Perez Martin wrote:
>> On Mon, Jan 22, 2024 at 11:22 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>>
>>> On Wed, Jan 17, 2024 at 11:23:23AM -0800, Steve Sistare wrote:
>>> >vdpasim_do_reset sets running to true, which is wrong, as it allows
>>> >vdpasim_kick_vq to post work requests before the device has been
>>> >configured.  To fix, do not set running until VIRTIO_CONFIG_S_FEATURES_OK
>>> >is set.
>>> >
>>> >Fixes: 0c89e2a3a9d0 ("vdpa_sim: Implement suspend vdpa op")
>>> >Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> >Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
>>> >---
>>> > drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
>>> > 1 file changed, 2 insertions(+), 1 deletion(-)
>>> >
>>> >diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> >index be2925d0d283..6304cb0b4770 100644
>>> >--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> >+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> >@@ -160,7 +160,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim, u32 flags)
>>> >               }
>>> >       }
>>> >
>>> >-      vdpasim->running = true;
>>> >+      vdpasim->running = false;
>>> >       spin_unlock(&vdpasim->iommu_lock);
>>> >
>>> >       vdpasim->features = 0;
>>> >@@ -483,6 +483,7 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
>>> >
>>> >       mutex_lock(&vdpasim->mutex);
>>> >       vdpasim->status = status;
>>> >+      vdpasim->running = (status & VIRTIO_CONFIG_S_FEATURES_OK) != 0;
>>> >       mutex_unlock(&vdpasim->mutex);
>>>
>>> Should we do something similar also in vdpasim_resume() ?
>>>
>>> I mean something like this:
>>>
>>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> index be2925d0d283..55e4633d5442 100644
>>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> @@ -520,7 +520,7 @@ static int vdpasim_resume(struct vdpa_device *vdpa)
>>>          int i;
>>>
>>>          mutex_lock(&vdpasim->mutex);
>>> -       vdpasim->running = true;
>>> +       vdpasim->running = (vdpasim->status & VIRTIO_CONFIG_S_FEATURES_OK) != 0;
>>>
>>>          if (vdpasim->pending_kick) {
>>>                  /* Process pending descriptors */
>>>
>>> Thanks,
>>> Stefano
>>>
>>
>> The suspend and resume operation should not be called before
>> DRIVER_OK, so maybe we should add that protection at
>> drivers/vhost/vdpa.c actually?
> 
> Yeah, I think so!
> 
> Anyway, IMHO we should at least return an error in vdpa_sim if vdpasim_suspend/resume are called before DRIVER_OK (in another patch of course).

I submitted "vdpa: suspend and resume require DRIVER_OK" to check this in vdpa.c so there
is no need to check it in the leaf drivers.

I also submitted V2 of this patch, "vdpa_sim: reset must not run".
It checks for DRIVER_OK, instead of FEATURES_OK.

- Steve

