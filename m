Return-Path: <linux-kernel+bounces-68789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A2785806F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075011F23678
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EC812F599;
	Fri, 16 Feb 2024 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EBo9delA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="odqROqiq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73206768F2
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096590; cv=fail; b=IKx/sVlOMlmfyQmsHBrKg/Cr4q1sEsmb98rgauaZDdLCNmWUPTrd4T0Evuoh/ZBNvZnywOsl7V+UlYIWebzH+UexsQr5ciDWvzUWuCdlftfKKDf/jxd8cWfHD1gL65rVUmnpLXwV4Ye8qBFso+dGSWTPoQ0lPQdmQHNiWYQR1m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096590; c=relaxed/simple;
	bh=4hkDTlmwv+nYGRloh4SQTe2bOtxqy6gq/BW4BYKmd7E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kstY1BHRmQ6EsVxoTe5KhoHt30d1nUmzNNG39m8W+FiqYkAEAkuTtP2GqHLAF3M1sLEIR1LySo25swROTV+g73ECCkOT37USikgyda3m05K8KFx33BV7MYil999//Fcckcz4izyLLLjnnINA22mxpHRdUZbOSuCjPo4wt8PUSLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EBo9delA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=odqROqiq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GCidwN020785;
	Fri, 16 Feb 2024 15:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=c2cBIhFIX35Z5WPojgzlmrMqxOv5tzBqozoglGndGB0=;
 b=EBo9delAtxhOjSj91+NjGG2CgaE+ztv0uDknkLlFZz8GQzhDc9dfBzayli+1cYYdwb2M
 STHwdLHYItOptlrbQsBaAxv6eJj/viXneydz5SNIhPeawCLNteGS3s4kkNrSvzIWamtw
 tD4cm2Rc6Bsmpz7wJILZ1z/JULtSUAT5eUBSjt4qipMobdaPBNk/DmJnmI6uxsYvwb7o
 5rY/mVxbemi364IQYs3gBNtvXZitTJHle5TIgYbKxp8f86Rd4hUUWv9NlZqDjgHtHJ1n
 bBK3CzY4MOYNgyLqOFVb3xvitUMS1aOKR0ixymSYlrI+fgqmoCtB4QJ3/vbVwp0lUUoY qw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92s75ab6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 15:16:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41GF9Kfq024722;
	Fri, 16 Feb 2024 15:15:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykjjdg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 15:15:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJn0JXkROiZ/R/HXnqPWhUGs5bihNdNRern5ECMy+he7gqiq/S+rPEiWKVZKPi92u9n6nFDfPWlmhztNwHXb6RHBDVYa7OMH5omwgqJTS+kX5dr30wYXD/3hq+K9H/f1b0GTbXYzRizISDwkXNlh9iVeEynqtjiJFJ/LPMZApKa4Y+TcWyTt2eEW/u+y7FYxygL43ur87dZnP08QzJTDmqUgZ8u0JOGi+P3R7+kA2CRSNT5JXcTpCOEH8POk5dZGHmJju1kFQalJQ9L9o6Vh7LQzjxFRSjfH/ItwxSPJguCgfaB+aVT2ul1vhKe+TP7ZHGhNd5Ed91C2YTZpvAoFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2cBIhFIX35Z5WPojgzlmrMqxOv5tzBqozoglGndGB0=;
 b=FLbMXWeTZ4P0iBv2efWDQUi+ssTXtLRlk0dIbWlNYaQ5iqJb19Q6tolcDGr4MjgoZaHhdw64fL/pcs20L1zTB3L7PWe+d/Hp34qT8zCmyMgOGpoMotjULBNItQyYEdj30ACO96ucXqQ6sbJR3zIkY8oO1S1A0Zc9ypY292sPLfzlj7cXGnxJLwT7dOzQ6JY4eIqlzkh6uMoJ6GkTHi9TLzDuO/dziHSoQvzaBBwmTsH9Oh79CGgRiteqaYpvOE0UQKxIqapuL0iNmhOgE631WaxcIyVWcsAVzj28wXg7PRPO+4wsdjb9t6sQSVgzgh9J1jjvkp3EkftxJcpiszZDMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2cBIhFIX35Z5WPojgzlmrMqxOv5tzBqozoglGndGB0=;
 b=odqROqiqV7y7rhmjfXnxRUIzE4/X0C94959zrGoRIHi5P5gnkY5c6LJ1X/HAs0tEpmXFVl6E0jwRAfcifyWEUqChT8GsqeB+iMK9SPiX6NoGGKApmNVlH+nY/7Kk2LH4UQA+SctBy6NG73yoXFEnZ8Xc/a9bTJrM6ua9t7jhd2k=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ2PR10MB7618.namprd10.prod.outlook.com (2603:10b6:a03:548::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Fri, 16 Feb
 2024 15:15:51 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 15:15:51 +0000
Message-ID: <5ad9cc63-85db-4cb5-9013-828caf60020d@oracle.com>
Date: Fri, 16 Feb 2024 10:15:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] vdpa_sim: flush workers on suspend
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <1707758174-142161-1-git-send-email-steven.sistare@oracle.com>
 <1707758174-142161-4-git-send-email-steven.sistare@oracle.com>
 <CAJaqyWfYHqf2=8BMo5ReKEB137fxGZR4XEJ2d4imXOOXAX2wHQ@mail.gmail.com>
 <e1b80fee-30df-4733-9072-ce67e3edc72f@oracle.com>
 <CAJaqyWe1=eQ4eQyv+wOqbr3pfZst6gmss2SrDZSNkY_ZVXcf=Q@mail.gmail.com>
 <996cfabf-c612-43c8-9e56-03fb58a1ebec@oracle.com>
 <CAJaqyWdKC6rLBOykSeWc87QtJ757LNXd78R59JRizUyAQCu+ig@mail.gmail.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWdKC6rLBOykSeWc87QtJ757LNXd78R59JRizUyAQCu+ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0055.namprd11.prod.outlook.com
 (2603:10b6:a03:80::32) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ2PR10MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 9195c6d1-d98a-4589-97a1-08dc2f02295f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tnFxM/hb6rU+YN+boJUfTuL5Ix9ZG+O+nwyfDjrpagcp4QVc/IIAlewYSh8HiCCHhxrnfuTDc9BVfkjc+YWvKoMQnQdQBKD0UDnf7/bryBqHqszzl6uCtgjPIZ5h+sHTxsGoeCDv4jNvIxIYvm4EGtGQFAPljM2klWQt+VmUHI8a0KEOs7MilqPZipCMghtaMR10dT43wvtkNZtweSkyXxBQVCKeqFurxSU1a74+J/gQph6ByikNbicTh6/QYA6Wc6xlMrDDVGzi/Gr3y6ydgwK29gTZbkWp1IGtqgl2LOFkedCLliQ06pxotIgYjQLaqIRHUwlt9Hgb9D2cV3fVBI9gyEP5dd/OfuJHfVq+bbpwMt1ejebA9KR2J2SCL8HTplkTsyi2y93Y2i4D84vUee9uum8T4pYy3xu6v/KkOhJFxArxmb+cFREFuPRxpNKF/ZWlAI6jala3kH12cXOf5g26pCJ4PjfhxN2SXY8u5vySHh/aLMm9kN0p+tI1Ch/7JtR1vOXQu21sh8uPenwQR/9L9mT8A0lMLmHrvUEg0tc8q6iDJLLuoMkFRasfjEDo
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(5660300002)(38100700002)(15650500001)(44832011)(2906002)(4326008)(2616005)(26005)(66476007)(316002)(6916009)(66556008)(6666004)(66946007)(8676002)(54906003)(8936002)(478600001)(6512007)(36916002)(6506007)(83380400001)(86362001)(31696002)(41300700001)(53546011)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K2N1SUZ5cko4dEl5NjBqbjZlNW12MzNEckdBOWkvaWdxL1JWY3IyK3JoOVB1?=
 =?utf-8?B?NlF3cXI5SmQxWWRRNU5YeDVrUDhUWHgwdG1DWHBaQjRYKzR4TkloT2VMaTRh?=
 =?utf-8?B?b0RycGdRY08yMk93V3dPMVR1dWRYR05SczRaR2hNeWFtc2JwSXE1QktTSVRQ?=
 =?utf-8?B?ckg3bjhSaWk5cjJuWWVmdHc5WU1KbE5NZmFJenh0dGIvb1ZOMXFFcjd5dk9u?=
 =?utf-8?B?aU5PV05PbEFZM2xrWUxuRkVMb0RCRmlOcTFXY0c0dDVZY21TN0Nhb1c1TEx1?=
 =?utf-8?B?R2oyMWVzVjYvZWZTNnZhVC91WWlQa0pPRXg5V2t5UzdhZmRiakdiRjQ0djJs?=
 =?utf-8?B?SUNkYUlNYnlDa1ZLalNtTk9yTldVVzU2L3VLbEdXR3I0SFo4eHNTeVhCajJG?=
 =?utf-8?B?Z21DK3h2TTU5MXF1VEtlYW5XcHllTzEyQzQ0dGhMRGY1ZlRRWE5FUGp1YmNw?=
 =?utf-8?B?RnhRUVVYV3czc3phOFU4ZXVMK0JpdUVkWE9aOWUyTXFkRzZYUGo4alBicWNT?=
 =?utf-8?B?MVdxeWtBbnhMS3RKdW52S0h0RDYzVS8rNG1PZHhLa24zS2dYcVd6VyszYmZQ?=
 =?utf-8?B?WEdaVVNuTmNHR3BUQSt2YjE4ZHJqaWwyN3h5UUVSWmR1SDRHTzl1U25QdEFC?=
 =?utf-8?B?ZW12TDJ5cjFpNnlVMDkwaUFyWXY1ZmVjdkF1TytpTmpIN3c0bWFWcTN2SEI0?=
 =?utf-8?B?UVUxeGJyMEV5V3dCRmNEVjM3T05hZGlKM0xyQWRVTDVNZmdVemM5ZzJOZ0c3?=
 =?utf-8?B?SHJFK3ZZbW9qQmZLMDZkNWV0R3BENGpHNWUwdzVBSHVOVVpKMFJwODcrMXRp?=
 =?utf-8?B?cnVQNjJKak8yOFdDbWNIY3ROZ1loSU5UbUlZUDJoaHQ2aXVURUcyVlVZQ3I4?=
 =?utf-8?B?VnNpd2ZvY0dPUm8yRFdYcWt6ZjlPZWRFUHNyRHA5NUZRNGY5UEV0cjdMRlNO?=
 =?utf-8?B?WG53cythNEExYXB2N3ExTU5nU3VRWG4vWFF0VkxsbVBhdjlsM095YTZ2VHdX?=
 =?utf-8?B?dkgwMEdrZ0ovZ0xGWldoTzBURnBsbEViWlJ2SDJhNnpxdFJBclhhZy83U2ZK?=
 =?utf-8?B?VHIyNlZQT3FFMVBDSEdMYUpiOTdxYzNBU1hKVWNMNFBFeGZIZkZQY3poeWYy?=
 =?utf-8?B?bk9uYk1RYzh6UVYwVEMyY3AwY3hJa0xWaXkrdVdsd1BWRjlvK0liTHF2ZENi?=
 =?utf-8?B?eStucDJ0UU5xcGUyUlZxeFZVNkJHSWdGOWNINHBhVG0xb3FRRVR5SEJUZGdm?=
 =?utf-8?B?MnpwaFV6ZndSd0lmdk55VXREakhRM1NzeFVhenVXQnoxZitsaUkzdHV1VkRP?=
 =?utf-8?B?dmtoLzY2Y3NhdWNYYTU5ZjNqRFc5YzVmSWFnRjdkUURQV1VyeW4zRXFXUnN1?=
 =?utf-8?B?YUFXOEVNalo5bEdvMG0yeEVsaEc2Y2hvaDZxK0lXeGl4dURybmJhNE5FZW5N?=
 =?utf-8?B?SU1QWDZ4QThhU3hCNU5vSnA2eXYrMU9vSXI1YWtkQlVWK1JWOXhHQ3dMWUg2?=
 =?utf-8?B?enFOSEFTakRoS011dHNpK2FDZXI5VWE1WlZPOS84WEVOWDR5dlBycnlEM1Zj?=
 =?utf-8?B?U0JWTCttNXNFc3VMS3R1a0tWUXdXdlBkVHZja0ZXRFVLeUFNRVRNZ2JoUzlM?=
 =?utf-8?B?dGJsenZJemhiMEUyYmIvTHZqcWs0WkdFU1ZEZ2xkYTJzNFhXVHZrckZtanV2?=
 =?utf-8?B?V2FzaU5zazBGNlVUVXVCS25wWEVMeVo1c2d5WHBzZlpSaWJoL0pmTTF0bjV3?=
 =?utf-8?B?WHlsWUhSam9NY2xEazRXdmlOL0MvbXhWL2xYUjhUUGtKZW5iN09acEZuQTcv?=
 =?utf-8?B?UmlmKzFVbDJreEdITGVNWnE4VHR5eThTU2ovZkdWbFcrNWRVdUNnaEtWWE9U?=
 =?utf-8?B?TXlaZW9zTGhEcjZNblpzSDFKTjdIZGU4Q3FHM1N0L2Q4d2U0MnFVTVZRUEsz?=
 =?utf-8?B?cVdQcHVJcTFhNTNaWWF4Z0QvNm5ucVp6RmF2SlEvVDV4SHZmSFJVKzE5TDZC?=
 =?utf-8?B?bzVrZGhBY05zK1d6NDgwNWg5QmMyc1U0OTFZaGVmU3hlaG1BUk92NlNPMlJT?=
 =?utf-8?B?RGxEN2w0cFhCcDl3Wkx3M1BpVVJmMGd2LzlWMG5ZQXZ0VlRSRExVWEFJNTZv?=
 =?utf-8?B?UWNva2lGTk4zem93ZlZtcEtjL0k1ajlWUG9neXh6SUZFN0w5REVCSi84R0Vt?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VuRWzYDHCOi49Fo/yeZDJdB2MT8g3TBMo+19Qm0C8dSPLAQLSiq1kiToNWBNIU/lRMT3LnUR8Ec6pOHpSx9otwyoSeMs+sG0EkgZfvlc1/bu4O29VTy9i/JIQfdWU+n1HZebNg5MzP5ycbm/ezeL3ehF291fphXG0NtzUtp1k0Cpy+OQDMrq7579/6JCbjJOXGAjzWQDy9lw/Nv18IBG/8Q6EqNv1f1zL3leT/1umI6qQF5LJNMo1TXPtzKnjNInjqRtN3BXrbMoILUpH+P5mkBH4jEpaouSQHWcC2lith0Hqk+tZFC5Zx/q0nWHoyTopJxD2xwdTTdyb7u7TlEQJ+R+0qykH8BSzPY7O/HAyrCHO5Aqfx7zI7eq3J4vomHA2K9y/Xv1M+ubOJ1zvvP7dgqw65tH8K4Q5kmYuH3eibPPkotaynRKVuaMl5x7RdrXonoOwKniF09w48M2fSdrq2Rx1AjrN6mAlzDkoZShtn6nHG+98Zt7HKRvT31awSRRSpHCtuCqt2qyGjD93oI1L3r3hPa7SpKLL24cvTQ/MNC0LRwTLita0riw9pMaEF6gGjWxBtoyITH+0slKnxbjNoULYI6F3uyUWxxgJIz0pBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9195c6d1-d98a-4589-97a1-08dc2f02295f
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 15:15:51.1571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaQUMd4OwzoiyLw8+y0XtBMMAX0aTgnwR4sLDAfdWsN/Ss3hQBH7r2w2KTYUiYXGvHhmDVYRtMGswoGCY20arTTYOfuDU1UMtOl11XXecFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_15,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160122
X-Proofpoint-GUID: 0UBq3bb51ln--4taJSY0Vx4eCCoLILO3
X-Proofpoint-ORIG-GUID: 0UBq3bb51ln--4taJSY0Vx4eCCoLILO3

On 2/15/2024 10:44 AM, Eugenio Perez Martin wrote:
> On Wed, Feb 14, 2024 at 8:52 PM Steven Sistare
> <steven.sistare@oracle.com> wrote:
>>
>> On 2/14/2024 2:39 PM, Eugenio Perez Martin wrote:
>>> On Wed, Feb 14, 2024 at 6:50 PM Steven Sistare
>>> <steven.sistare@oracle.com> wrote:
>>>>
>>>> On 2/13/2024 11:10 AM, Eugenio Perez Martin wrote:
>>>>> On Mon, Feb 12, 2024 at 6:16 PM Steve Sistare <steven.sistare@oracle.com> wrote:
>>>>>>
>>>>>> Flush to guarantee no workers are running when suspend returns.
>>>>>>
>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>>> ---
>>>>>>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 +++++++++++++
>>>>>>  1 file changed, 13 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>>>>> index be2925d0d283..a662b90357c3 100644
>>>>>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>>>>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>>>>> @@ -74,6 +74,17 @@ static void vdpasim_worker_change_mm_sync(struct vdpasim *vdpasim,
>>>>>>         kthread_flush_work(work);
>>>>>>  }
>>>>>>
>>>>>> +static void flush_work_fn(struct kthread_work *work) {}
>>>>>> +
>>>>>> +static void vdpasim_flush_work(struct vdpasim *vdpasim)
>>>>>> +{
>>>>>> +       struct kthread_work work;
>>>>>> +
>>>>>> +       kthread_init_work(&work, flush_work_fn);
>>>>>
>>>>> If the work is already queued, doesn't it break the linked list
>>>>> because of the memset in kthread_init_work?
>>>>
>>>> work is a local variable.  It completes before vdpasim_flush_work returns,
>>>> thus is never already queued on entry to vdpasim_flush_work.
>>>> Am I missing your point?
>>>
>>> No, sorry, I was the one missing that. Thanks for explaining it :)!
>>>
>>> I'm not so used to the kthread queue, but why not calling
>>> kthread_flush_work on vdpasim->work directly?
>>
>> vdpasim->work is not the only work posted to vdpasim->worker; see
>> vdpasim_worker_change_mm_sync.  Posting a new no-op work guarantees
>> they are all flushed.
> 
> But it is ok to have concurrent mm updates, isn't it? Moreover, they
> can be enqueued immediately after the kthread_flush_work already, as
> there is no lock protecting it.

Agreed on both, thanks.  I will simplify and only flush vdpasim->work.

- Steve

>>>>>> +       kthread_queue_work(vdpasim->worker, &work);
>>>>>> +       kthread_flush_work(&work);
>>>>>> +}
>>>>>> +
>>>>>>  static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
>>>>>>  {
>>>>>>         return container_of(vdpa, struct vdpasim, vdpa);
>>>>>> @@ -511,6 +522,8 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
>>>>>>         vdpasim->running = false;
>>>>>>         mutex_unlock(&vdpasim->mutex);
>>>>>>
>>>>>> +       vdpasim_flush_work(vdpasim);
>>>>>
>>>>> Do we need to protect the case where vdpasim_kick_vq and
>>>>> vdpasim_suspend are called "at the same time"? Correct userland should
>>>>> not be doing it but buggy or mailious could be. Just calling
>>>>> vdpasim_flush_work with the mutex acquired would solve the issue,
>>>>> doesn't it?
>>>>
>>>> Good catch.  I need to serialize access to vdpasim->running plus the worker queue
>>>> in these two functions.  vdpasim_kick_vq currently takes no locks. In case it is called
>>>> from non-task contexts, I should define a new spinlock to be acquired in both functions.
>>>>
>>>> - Steve
>>>>
>>>
>>
> 

