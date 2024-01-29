Return-Path: <linux-kernel+bounces-42930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841FA8408BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F2C1F21F01
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7408D66B27;
	Mon, 29 Jan 2024 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dc0Bgc0T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jkfr7rAG"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071A260DEF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539197; cv=fail; b=hBWPWEDo16YcSTwsjybNlOhVs8Ik+21ly+WBC2jHWDzR8AWXIuMYe6nvPIJlAX+ETHyAmOAOY/g3bK/29H2asJ8dZGsBQZ6pvHUmiqZG2I9E6KueXWRMnCFpwqKDkGn3+VOvYCV+nteZ/phrdqDsPZniE4+lU7qdKVmqAUetZ7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539197; c=relaxed/simple;
	bh=qeZ9jv8ZRIjSFrYewBxAs+v4bWPhL3VUVF9LY2NfsUc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YKY/KC0b3PCZgjla3RcNTNqyUWexxxP/0tKX8xeGW5r3FXGmpquCsoe7UMR4OeXOVipPmkR0mo2NoR3TPTBdHb9JALHBcvuZAbM6JnhKpz/CYotWgRIH3JuTUfRi1JIEmLynwfMvNybye12yZ0EfQElASlTbVc2gHFeo1VQZaF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dc0Bgc0T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jkfr7rAG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40T9iXRO015992;
	Mon, 29 Jan 2024 14:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=QiCv3AEfiYreVzeOo1zoks/t33cnGHaJI3BSk8e8zuU=;
 b=dc0Bgc0Tb0T1wyzMln8Xv696n4XlikLvVn9g60NlUU8Nl6mEId9yL2thHEL9J3jt7O/3
 To4fw04asMCH6+gT8+BHnkY0QkjjWmvGNYlGB5baMEjOphvih/SJWPtJvilGkveJmnJM
 G08OhG7wo7cKCYVvmN8zR6sXsc+8zn+gw9pn2a7BgnurIiOnRWRhWZifiER2Pw0m7JM+
 5Aw2UvohQ1EG8LcNKaFqrGvLlxOt577FGiWqL14NyMsoP5YsG5vZHZkbFvFOf5cFXWVO
 Jtym276nXW14O4WPK6JvkGDkgLRrcVwLvwGhHjfm3PxQpSR2Gg0NU+qd1EqYeS17fYNh XA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcuuyyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 14:39:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TDbdg0008435;
	Mon, 29 Jan 2024 14:39:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9c7amd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 14:39:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0IbqNUVxlyYbmbdzF8dAbxxnkt1s595/zBdgxsw2pwFTMh9EkYC5kSy39ms3gfDQrvZs7sMC9JAphJ0lrRRPQJi75Hxj60rDIJfkwyTYO4oL0CYDdU6p7FSCTIe9m7spQac4Xdk78doKbdQrNIIjKM/V5eJpf+EV4BmfdiNEbhgBCHaR+/uy03yQPhVChl/MEp7EWqgpRWPl5lanN2qRbdma2sPBIDKpLHVzdjMrrOjvykpuNrE/7V6dKALhp7vFzzc2oS7HA5cwflyu3egBQ7wN5QeYrko+viHNSGI+TPoTd/ZOSQqF0xBfyejpL4gLvz4wWHzKInHMFoT6IA9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiCv3AEfiYreVzeOo1zoks/t33cnGHaJI3BSk8e8zuU=;
 b=LkO6Za6NzSIMnqIWMTj+X/8ZDhC03NLFHZWcy8A+cjtuq6Eg5f3ssZGe/6aZwTfegQj31FEZn9thnRaVYaSv5xirwMd/4f2+pZf6ae+x5/MQ5B1+25+7aqzukZJvX58zsOoqEFq5Wktyd3uAb/DwNJe7l7WUSqjCJldraVLxpMbQDkw5vmhCEClWHwU6ixyosTUOXvgJJLtOQ9Rt//Xx76N+6YVzXRfZVhHBG2bTy3qpIKAKG9kjt0kSeQj7H5chPbzAgvyh8a9T9ST7O9gWDZKbReve1tRp9dreP7fX48BzENwisCLrXCzr5e3a4PpMF/DSNDXljL1obYRxVJehoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiCv3AEfiYreVzeOo1zoks/t33cnGHaJI3BSk8e8zuU=;
 b=jkfr7rAGplzxuRNhgmDPqDQ+uga9rkGyC+hcaoKrfX+GC12IBVJ4m8UDZYZrq6SrUWsUxPQkbS3Tjm5Efpn6tRZA43U3SA9RKQFg0Tv8AWqUe+pO5CxsW9BihdQESq2Zwke7BRyvKKKLYyWiHn8eTLAmB5p5UPeEOyBJka0Haq4=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CH0PR10MB5212.namprd10.prod.outlook.com (2603:10b6:610:c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 14:39:22 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::bd88:5306:d287:afb0]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::bd88:5306:d287:afb0%6]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 14:39:22 +0000
Message-ID: <a25c75af-c961-4ca6-9810-dbcfe64753d5@oracle.com>
Date: Mon, 29 Jan 2024 08:39:18 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: fix shift-out-of-bounds in dbJoin
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>,
        Manas Ghandat <ghandatmanas@gmail.com>
Cc: Linux-kernel-mentees@lists.linuxfoundation.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+411debe54d318eaed386@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>
References: <20231011143937.31996-1-ghandatmanas@gmail.com>
 <Zba9zRWq6rZhWn-p@casper.infradead.org>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <Zba9zRWq6rZhWn-p@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0047.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::28) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CH0PR10MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d82746-b366-44aa-a262-08dc20d81543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	s5iUN0A4cdCmU/byWgKu3OsGOCv7vMLnPl9suGOfMMk0cRh4FVVgnHFIACbMcERP6+nZCoNnbWZ2QfE11rLaWvABc2fXNm3a7q2iE9ZTJZ8Pal++TWCUrNZHW185SzPhZyX7bwIxmfVVMK4zDkWSp4Re7aJ1gcsrQEGCajUnOf7O49vhZBj8F3xCbd3KFbllnxrBvBjZznKeC3aAaqfLgqEjahI/X5jK/tVmPt3EerssW0HbvYbWOujXKdeao6xyrjpoj1WVXCqZNpIA/4uo0PAvxPJQLjDtJdNHtFQmy6hRYTFN3fATmBseuMyK++SFlW+xWaGYjn9dx+FDEP+HdtpercqmkQZBJnI49wuqR37s+SmxItEDXWG2jh/OwHqn2B9aJ8pa9+4hebF0HtIyHChfNf7CxnIkS8ZL6yDwhGU7JYvNp3rob5vdGX613Bv27wsASdZ4a7oum9rfwOYxA3XWpdE+u4F1nggdso6/F6Q+XWt3Kwu66V2Kjorrfsr/aWQJrVHD3rTYLj+gtk/2UPQY348QCF0GlYJjXEAHc2U6rZdD4v5DBITPZeL7qxI7qfqeoUoQrCleLAQK0DE1SxYa/WTfdc9IesKuVyD6hhCEElKnCvf3C25YgTa/5fvVOxcVqJDNy1nL1c04XqRAX0dpBMaLQltD61kCmX7LfSw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(2906002)(5660300002)(36756003)(110136005)(66946007)(66556008)(86362001)(66476007)(316002)(31696002)(83380400001)(478600001)(966005)(6486002)(6666004)(6512007)(45080400002)(26005)(2616005)(4326008)(44832011)(8936002)(8676002)(6506007)(38100700002)(31686004)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V1k3a3hQMmNnYnFhUWhMejBXWFFGamdIK1BZZ1F1Q1BpWjFsUDFmMTJXR0cz?=
 =?utf-8?B?Z0N2L3QwYnoxakh2WmhJTGRFMkcwVTBGQWQzbTBNRndEK0dyV3FXMjYyOVN3?=
 =?utf-8?B?dnFab0lMbEU2ejlHVFQ0Z2p6VnZmWjl5YmhNUUVhQW1PRmYzNlYxc3R2azVL?=
 =?utf-8?B?VENhdlh0OXoxOEZtNWNYYVppOXcrZnE4VEhURWFqbjBKYi9zT1QxRlFuSlcr?=
 =?utf-8?B?Z0RtemFlRjM4UFpZbWI3ZEpRVXdpU210eExQZjUrQldqNy9aOHZmQXF4Tysv?=
 =?utf-8?B?cmRLNFZvdWd2UVc5Qys0S2I3VTRZOTFaeWk2L2EzOWl4VlVzRFYzSXNKbWxW?=
 =?utf-8?B?NFRCNWt6N1VzN25hU1RITUlTV3U1U3JzT0R6U1B2MFl5RDVna3BqQkRCNmx1?=
 =?utf-8?B?VExyMEhrbys1aG9VU0h5dlFqTWhmYzFLcjNZZ0hlaU84U3NOMWVqVGFrQ3pU?=
 =?utf-8?B?S1lyTjlOUyt0RFBNcWFWMk5FSHgrTTlGUEJGYWk1dW52elpvS0J4OHVZZFh1?=
 =?utf-8?B?VDZxRW1GaGhRUHFRc0huRldMQU5leStoUmVkRnpCVUNza0hPalpYdkZJYlRh?=
 =?utf-8?B?Nll6c25iRlA2VzVJbGppMUQ2bWp1T3NucURtSmg3OXNPbDVxMzkrSG5yVHRq?=
 =?utf-8?B?c1p3aGdmSk9pQysvMHFOdEo1bjFJaVV4SmVqUGwzbnNXbEJCaktiU2lVLzFT?=
 =?utf-8?B?Q3l2QnJnZmJwb0w3VGJ1cWZXbHNZVzN5bkpNd0F4Myt6dHpQSVloRUFFSzZu?=
 =?utf-8?B?K0tNZWMwZlJCOVNwWG5iOE4vdm9vMHZyQjFQMEZGTXZuV2d3QnNtYmNRM1Vv?=
 =?utf-8?B?bmJaaHQ0Yk4rYlQ3WGRpcFcrVHJZby9tSDA1dVdENURaMGQ3RlZFWTY4eWo4?=
 =?utf-8?B?cC8vRnpjTlNwaFU0elNyd01qV1RQT0NFOHhxaXNTY1N1bmt6K25JbFRGeHBO?=
 =?utf-8?B?dG1ldmJjMkp5MTdsb0tiNDM1SE9Udlh5NTZSdW9icXhRQ1NIellCZ0k2S2cy?=
 =?utf-8?B?eGpUS2RhMHhpRnNhRHl6dUFOQlVtZ3VZVHBVYTdhOUprN1dtZ2hJd0NDMlY0?=
 =?utf-8?B?R2ZPVnZLUHNCS0RZZkRmSnJhR2dmYWxONXlWak1TMGd6bmtpMDZmR09FeExF?=
 =?utf-8?B?bG42Q2hRbU14dnY0WXYyanJtYk1GcUlBL3B1RWdEcEJtRnJUb083b2dsazlh?=
 =?utf-8?B?Um5pZFIwc1FDVHhkN3kycTdJcHlFZHJtVjF5N0JYMGdKaVY0bW9ONmZFV3RR?=
 =?utf-8?B?SjkrZzJwTy9TOGw4WCtBL1pmbmlhcGNPalJLd2tUbDkzWkJCTmFaR3lMY1pk?=
 =?utf-8?B?d1RWN05xaklzZ1NPVkNhWXppMUpwMmZXWncvSTNmL3VxZ1VYT3lUU0tUZW14?=
 =?utf-8?B?U1BWQS9xdGhIVm5GQytwTDJhTEkyS05IellqQUpPaWJnYnRwRVFGcGQ0TTNh?=
 =?utf-8?B?bUMvbm14TzJ3U3JWbzhrdDdyRHU4cUYrV3BvQXp5VTNrSElKYmJpQ3dzK0F3?=
 =?utf-8?B?THRUcWRoVmp1VG9tWmloMFBkM3l6YTRUcFpIT3ZaZEpmNzl4YzZKZEJlMHNB?=
 =?utf-8?B?VUVqcHdsWnhZdWtZVjRoVk1uWjlOMEo3MTdaR1Ayb28xemE3YTFEOGs3TDN5?=
 =?utf-8?B?TitBSEkyc1p0SG9ENDVkUThGK20vL2tTTUt1UnZEam01YzZVb0tqa2ZYS1pS?=
 =?utf-8?B?ZkVVMkViVEtWWlNVekZ4ZG4wMGZMN1dJd0dIakRGVUJ1Y2tXbU54ZUdoSVdH?=
 =?utf-8?B?TGZTZ1ExR2dhc1lFYTgyZHNJdnFsL29oUTJFRDlvZHliK0J5SXN2V0NsMHVi?=
 =?utf-8?B?WW12VzZvWVlaU2dtaytDdlEwaUZJeUhYWk43K3FVMklSUXdBSTV3akdSRjlH?=
 =?utf-8?B?Z0phdjRBZnkzWld6S0Z3Tm03OHB2alQ4QUNoZ3Exd1o2QXRBcURXUTZFek5E?=
 =?utf-8?B?QWhSYk9yNEM5NVVNOG95Yk5neUhvK0kyb1ZmcS96VXMxbXpKODF2cTU1Nm0w?=
 =?utf-8?B?YzkwbU9yV2k2eXVkbk5VRTFtSCtEOHkrTkdFV0NIcm1FclN2aXBwQnZIai9x?=
 =?utf-8?B?SGEzdlJKMlpJSHZSSVJlNjZxOVoraXlzeXRrRmtjSXlCbmtJckJaM0hFdmZC?=
 =?utf-8?B?d1BSWGRpOEluakpSU0k0UEkxZHdzcDJzZWl0ZmlyNGNLcFdLQ0JENUEza3B5?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/YfAfinF4EfhepsFa7GAN16qyem3C/MI/1dkIu/rFpzThqt/SunhPioUuxQ5YdV20DkI8qumMze+0T1diZPC+OPCtBrTdO5uVzcqBcGojAgyGbqICV73ETLfrYlaPAyDj1WX2+yQ5T9dPB9RuWyW80s3XQOc6iCU1vWoy4/TEt6yXL20AYWk+bLtI9YArfiq/UeIJHAEX9dDr8DEc9l4hgjQ0Fb8he1RF5ZNYs9XWvwXA68cgnBBMcxEYsUSmB6W4IieJ0EyIOr2gDdJl8Z3W63UtJHSN0MyyRkSxeCYtejj6vSmAIAMjIr2OWhwnGsbuvbjEPhFxMk1xE+eqchU0YQoDDElfWsYJ+Yz5xu9YbzXMgufNmtZZ4tSVi1Z2dWj+tQSurxqnW2960zNoA+e76oZkowFm3jl0HYNihlIQw/LCAb+ZGuY5p4XgJg1MCJfYwqigqdwsUFfADgYmWNGQYxASO+XgRPvE83qTX39TtAAaCkSR6VZrYHSnXqR4AvG7HQd2cITvRsJPLX4aInSeLB4ayT31TiUV/2OBcxqzcL83FRGuiCRudWXqQ6J4FCVRE1o0zmOGy8UAx4hl9ZuYy2zBK9d/VRJBvh15MPqSIg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d82746-b366-44aa-a262-08dc20d81543
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 14:39:22.2626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHfB2cRQvcYJh2lq3PEIifDq0LHLvZ+XU3hmHxzIdASncEUGzU3bloZLvlhrwqE4wi6IK6wBvRTwgNwNZqk8PWXx3v8LYWpQyfOANq8hHnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_07,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290107
X-Proofpoint-ORIG-GUID: 2WVAEssriYnsFvUxzMwcRUYoyjIZuDer
X-Proofpoint-GUID: 2WVAEssriYnsFvUxzMwcRUYoyjIZuDer

On 1/28/24 2:49PM, Matthew Wilcox wrote:
> On Wed, Oct 11, 2023 at 08:09:37PM +0530, Manas Ghandat wrote:
>> Currently while joining the leaf in a buddy system there is shift out
>> of bound error in calculation of BUDSIZE. Added the required check
>> to the BUDSIZE and fixed the documentation as well.
> 
> This patch causes xfstests to fail frequently.  The one this trace is
> from was generic/074.

Thanks for catching this. The sanity test is not right, so we need to 
revert that one.

Shaggy

> 
> Sasha, I see this one was AUTOSEL.  Please stop it from going into
> -stable.
> 
> 00274 [failed, exit status 1]------------[ cut here ]------------
> 00274 kernel BUG at fs/jfs/inode.c:169!
> 00274 invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> 00274 CPU: 7 PID: 52174 Comm: umount Kdump: loaded Tainted: G                 N 6.7.0-rc2-00020-gcca974daeb6c #442
> 00274 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> 00274 RIP: 0010:jfs_evict_inode+0xfb/0x110
> 00274 Code: 28 fc ff ff a8 04 75 24 4d 85 e4 74 10 49 83 7c 24 80 00 74 08 48 89 df e8 e2 a5 00 00 48 89 df e8 3a 95 ee ff e9 2f ff ff ff <0f> 0b 48 89 df e8 0b 28 00 00 eb d2 66 0f 1f 84 00 00 00 00 00 90
> 00274 RSP: 0018:ffff8880080bbd48 EFLAGS: 00010287
> 00274 RAX: ffff88804b209a80 RBX: ffff88804b209df8 RCX: 0000000000000000
> 00274 RDX: ffff88800b813ce0 RSI: ffffffff8217a259 RDI: ffff88804b209df8
> 00274 RBP: ffff8880080bbd58 R08: 0000000000000001 R09: 0000000000000001
> 00274 R10: ffff8880551e4540 R11: 0000000000000001 R12: ffff88804b209fa8
> 00274 R13: ffffffff81e35fa0 R14: ffff88800eaae7d0 R15: ffff88800eaae7d0
> 00274 FS:  00007f4f5784a840(0000) GS:ffff88807d9c0000(0000) knlGS:0000000000000000
> 00274 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 00274 CR2: 00007f4f57ae2c00 CR3: 000000000a5c4005 CR4: 0000000000770eb0
> 00274 PKRU: 55555554
> 00274 Call Trace:
> 00274  <TASK>
> 00274  ? show_regs+0x60/0x70
> 00274  ? die+0x32/0x90
> 00274  ? do_trap+0xbf/0xe0
> 00274  ? do_error_trap+0x75/0x110
> 00274  ? jfs_evict_inode+0xfb/0x110
> 00274  ? exc_invalid_op+0x52/0x70
> 00274  ? jfs_evict_inode+0xfb/0x110
> 00274  ? asm_exc_invalid_op+0x1b/0x20
> 00274  ? jfs_evict_inode+0xfb/0x110
> 00274  ? jfs_evict_inode+0x3a/0x110
> 00274  evict+0xcc/0x1d0
> 00274  dispose_list+0x48/0x80
> 00274  evict_inodes+0x14c/0x190
> 00274  generic_shutdown_super+0x34/0x160
> 00274  kill_block_super+0x16/0x40
> 00274  deactivate_locked_super+0x2d/0xa0
> 00274  deactivate_super+0x3b/0x50
> 00274  cleanup_mnt+0xbe/0x160
> 00274  __cleanup_mnt+0xd/0x20
> 00274  task_work_run+0x59/0xa0
> 00274  exit_to_user_mode_prepare+0x175/0x180
> 00274  syscall_exit_to_user_mode+0x1d/0x50
> 00274  do_syscall_64+0x4e/0xf0
> 00274  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 00274 RIP: 0033:0x7f4f57a76857
> 00274 Code: af 95 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 79 95 0c 00 f7 d8 64 89 02 b8
> 00274 RSP: 002b:00007fff75aa4be8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> 00274 RAX: 0000000000000000 RBX: 00005586b9c30ad8 RCX: 00007f4f57a76857
> 00274 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005586b9c343e0
> 00274 RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000073
> 00274 R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4f57bb1264
> 00274 R13: 00005586b9c343e0 R14: 00005586b9c30bf0 R15: 00005586b9c309c0
> 00274  </TASK>
> 00274 Modules linked in:
> 
> I haven't attempted to dig into why yet.
> 
>> Reported-by: syzbot+411debe54d318eaed386@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=411debe54d318eaed386
>> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
>> ---
>>   fs/jfs/jfs_dmap.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
>> index 6b838d3ae7c2..baa97bda1c7a 100644
>> --- a/fs/jfs/jfs_dmap.c
>> +++ b/fs/jfs/jfs_dmap.c
>> @@ -2730,7 +2730,9 @@ static int dbBackSplit(dmtree_t * tp, int leafno)
>>    *	leafno	- the number of the leaf to be updated.
>>    *	newval	- the new value for the leaf.
>>    *
>> - * RETURN VALUES: none
>> + * RETURN VALUES:
>> + *  0		- success
>> + *	-EIO	- i/o error
>>    */
>>   static int dbJoin(dmtree_t * tp, int leafno, int newval)
>>   {
>> @@ -2757,6 +2759,10 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
>>   		 * get the buddy size (number of words covered) of
>>   		 * the new value.
>>   		 */
>> +
>> +		if ((newval - tp->dmt_budmin) > BUDMIN)
>> +			return -EIO;
>> +
>>   		budsz = BUDSIZE(newval, tp->dmt_budmin);
>>   
>>   		/* try to join.
>> -- 
>> 2.37.2
>>

