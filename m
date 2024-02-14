Return-Path: <linux-kernel+bounces-65794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C27B8551EE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C604B1F220EA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770E2127B43;
	Wed, 14 Feb 2024 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tgg7YELN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="saSMbJfG"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0D6126F3E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934699; cv=fail; b=TOyLWK2zHIZYjuLupPSXiMkAXa2/MIDj2JGPVCmtcWVQZaMWw2/zRwy0ZPEr65lJvuYPaGKn0No1aHfCODAmQOndmtZxeDKoah2/oXg93w7zTAUy85h+EGDY3i5LgX/Znn8FcN735xAQSdtrnESApLtOQVkBXxG6TUYvZovHw1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934699; c=relaxed/simple;
	bh=Gfa5QvoQuvQH49lbK/t8JbWat/jHz0RH8WXos+V5GIQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YWH/5AB8uu/84SER1AoOlxFMh2B9XrvAUR80JulJSjwvMXJUhaP82z32YxByvKv+BhbI+2nW4lJRVt85J2we54WKf/a5FuvJnuV3KKR/vUdNizShPcjM3rKkLvVChDOpPiWCl1alQXv3tdN9VDkYilyyWBu6pxEM35hV9IKEWj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tgg7YELN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=saSMbJfG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EGt3PV004809;
	Wed, 14 Feb 2024 17:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BITZ6+kD9FhVmUDhS3gTJ3Upm8M25cdtfDcsJCx/ZmY=;
 b=Tgg7YELNEIN1mGiSe+636/3yPlgixF4ZfcFfT7Mg1Sg0U67H0+OacQfhTHtHMK6OXBGv
 mXuAoAo/+duCE+43ppfxmQZHN5NwJehknYOL3tlJHaHp2S7JdG3qqvPmVH6Bx+cbUv61
 iuxbCt/kh7jtjRMrnFpSeaQXPQnABuZEwK76rwWZdF3/F8eio1kvl/Je/+g/rgkBoLt5
 fPvRutI6U44cH4ttr/8dPBDnkSxxTaYyTgEVUS+kDqgGl/QicMxcVzjbByRLhQkvtaAL
 sm8VDcyadGE1pqqKlsV6G7G7psEm1RRMBAGfYolkC6f6OYOUAEp52YyC/FEwvF4zTg2w XQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91f0054d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 17:48:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EGmw4T014926;
	Wed, 14 Feb 2024 17:48:18 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk91164-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 17:48:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wl8ZXVEdumGDcFs8Zeb/cIl7vMMKLUYSuapi8pDj6ZiVR4EMmMiRZQwH73YlbKUAF+fGlLIUJSQLjN0FbUq9AmCA5RWIlvayqXLCYwRrGEaThL7prvDyPGQwVCM2XhNVy7bI5v0VRm+h6x7GHAhxxdkEuXyUtSPmRzDPYGTuDMnYxI27rgWO8ATQbYXlrDQRt/8YvLQD9897BmzZDm2axA/U5Q7hia5JyqMuacIB0+F9yPLwMeZaJEAj21TUUsp7d6MAi0E5pnY9ss7STuNmicggzD+DX+ef+d4/80nyZmbgX+gTvUaraS6TV7eIyUoDLqdu6q3ktEDqG+ooYvjFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BITZ6+kD9FhVmUDhS3gTJ3Upm8M25cdtfDcsJCx/ZmY=;
 b=GjBufzagT1LKGEausz/3iTkC/LWTkTksN1xtzmls4FUORpIUaT79UI6LNYRkqpIvXWqeyfT7Cj7kM1RBkvosCtcwz6DQHTdf7x10KM8shJSFQY8owv8Hj9YlYsYGcPpuKtqtICUhpoWJhGhMQeibASPH4u8KnBJXToP+rA2HKG/YkDPEJbrwQby8jaqFpO8wdhZlCSyBSUS8qewHa8YGJ9bbKCJboztWaOkrLtd75xJeA7dpHhaOi+Afyy1gIMu3Mp2prM3kLq6wtFlPJMM7xiU5Tq9HyZ/06U8QKHu7nJWZk860oWzin1K2S0TXcO2otAKtrV+Q9mADFbnEhFlUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BITZ6+kD9FhVmUDhS3gTJ3Upm8M25cdtfDcsJCx/ZmY=;
 b=saSMbJfGbIKYS3CKqBQjgY06t2AxUUAxKnttPjmfPT46hhlaQQzErcsvDCBYYtowC12baEBIlOYZ1S6fB73tg5kJlqRX5pG4rVR9h1sVck3iA+PoMRUAeH9J7O5a/GUONr7IEkW1/PfLRwD/wTcfw3SbWpFzbvBksaTb+iyH/9w=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CH3PR10MB7356.namprd10.prod.outlook.com (2603:10b6:610:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Wed, 14 Feb
 2024 17:48:14 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.022; Wed, 14 Feb 2024
 17:48:14 +0000
Message-ID: <9250d604-61d9-4fad-a83c-719851980ba0@oracle.com>
Date: Wed, 14 Feb 2024 12:48:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] vhost-vdpa: flush workers on suspend
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <1707758174-142161-1-git-send-email-steven.sistare@oracle.com>
 <1707758174-142161-2-git-send-email-steven.sistare@oracle.com>
 <CAJaqyWdOYHA21A2JUwnTmWfSro7H0ZTTTkkH7Ot9F8hwK+TKXw@mail.gmail.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWdOYHA21A2JUwnTmWfSro7H0ZTTTkkH7Ot9F8hwK+TKXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::16) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CH3PR10MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a0590c-7a88-49a3-30ee-08dc2d851e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hJNqTaryHm63HT/gfYUrm1TEihjlYA7R/JkdAeiL2367Syj2QjMIYsxN+zjcDznVWUR/xAMQMr7jMZc4ihR3Vf0fB/vBXGwUrEYXpLkpG1irgHYsGcj7OA0+FPqxxogoHS+S2Mk1TjPPPr6Rld0/jyd2RB7Y5bsi1NO6KTI/L7S2kHij4SiH5OLeso78Tm1Wq8V2OTh3zAVmmQLSll4VO+xYip2Nh343z8beF1/lpxXl1WPgFmmMNH0WQy/2dRP72COZln7TLhk0T+sbOMsPqfizblax5WwCwCg7tM13tL80Tn2NhnovarTBq86CnAteHE5VDGc3hqL914U54ICDDIXX1wNJZ8vQVtBgnflhiY6TLazWj3qEySdmsVVXAT4rtDUBteRrCw4tbGRqj9H3dWWPTFWw4b1jV91Fp5GLSGiKYyL+3wieJcbmVKk4LQRpJkKKEmlSwSfZseRdex2l1NlUdT+MQliLOsIm/eamaqru/YA3Z/u0WlP0uaT4bWYfRFi1uBOdOl8LXXvnHOQnHWh7iwF0KLnOTbZj6SSkgHr1B4MODsWDD9bEdQ3LnMcH
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2906002)(15650500001)(41300700001)(8676002)(6666004)(36756003)(6486002)(36916002)(26005)(2616005)(53546011)(6512007)(83380400001)(4326008)(38100700002)(478600001)(66574015)(86362001)(6506007)(31696002)(44832011)(8936002)(5660300002)(54906003)(6916009)(66476007)(66556008)(316002)(66946007)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TW43YmZkR1JQeTVNYnVqQld2U0tGejc2NWI4YWxiSlVOQk1HTzY4WlNxY1Jj?=
 =?utf-8?B?a0JBc05uc3RYYmxrK1VmWG9pTktUWjBNRlgyZjVqNDE5WTNaZlgvSEpDM0dM?=
 =?utf-8?B?RHJkU3BpdTJUblVGR2hhU0RiZ1lsZkxTUkxDa1V1enEvSkpGMlM2dGJuZ3NN?=
 =?utf-8?B?UndITHNHdUtna1NNM0tIOTVrTU0vbktrM2RKRVpTeU1JcXdWaENWQVFjQTVn?=
 =?utf-8?B?cVVHMjRUNHVSUTRSdzY3Zmp2b1dKZlFiOHB2SThySjd6djJLTmpCbTFtU0lw?=
 =?utf-8?B?aUF1eU9zU042U1BHTEJhNmNkVEE4YU5ZVjlMcC9PUkJmWk0xRjdmSEhvSE1N?=
 =?utf-8?B?MDNtbEt2SXNyN1hhTDIyL0VCcTFya0xrQ1BUNHNWeEd3aWxKUzNLZVVkelZ5?=
 =?utf-8?B?SDBhelBZL3lBT3NGK3ZlNEUrUE1iZDdZeVFaTTZuaG5rVStCOTg0aThoLzlF?=
 =?utf-8?B?VEFMVDJRRGpTakE2VURnMHByVlg3V0QvOXNubHV6dXV3ZmJCUjl5aEl6VjZu?=
 =?utf-8?B?VG1ackVaTGFrTWlOeXRUbHg5b1B2RFBPWjFRdlVBaFVtZ0JRcGZlZE5sRTFK?=
 =?utf-8?B?b0dyV0JXSXBwWWlmWVlrVzZIUDJQN0d2MUxBSDZMSG9FNmdObkRGM2RmV1Mx?=
 =?utf-8?B?L0xhejVXeUZwV0tJNjloQkNmSlh5T3hNUlVlU0dDdzlQcXExdFhEWjc4aGdJ?=
 =?utf-8?B?OGwzWFcyekV5ZjlTZ2dwL1FFZEJwTFBEUXBsNHVVYXV2Rm1pQ3hQVkJURG5T?=
 =?utf-8?B?MW8wNUlEU0xUNkNSQVpxWkt5bEIrRWIra2h6YVhxdTN0SmRpcGFoMzR4L25C?=
 =?utf-8?B?alpQaVowR2JMQlI0eEtJUE8wMjZFS05zV09rdnBDSExhVGphQ3RtajV6SlpE?=
 =?utf-8?B?eHh0TEpaY1ZrUUtQUEVBeFl6alpCUmV0Qk4wRTRQWm5EN3Jwc1RicGJBa1k3?=
 =?utf-8?B?U2FKdjJ3cWhzdjhJbE81ZGpGeDNoYTlGanhrakFFb2VUL0RRVTh5Q3BuR1E1?=
 =?utf-8?B?QXlSeEdIckZOdnQ5WjRsNVcyL3ZuWW1Zc24wd3FJb1pJdHhOVjV4ekNrZjd2?=
 =?utf-8?B?VGtQeEZYQ08xZTVSd2dMMitXY1NZWXZmdTJuQ2pFbEsvdEcxeG9vbFMyR01w?=
 =?utf-8?B?WVBTKzRpNEM2OEVkYVo4Znk4YjVJeXlEODRDYTBCMUxtWkdxbUJaamY1VmxD?=
 =?utf-8?B?b1k3S0dQMm94czJxU1RkY3ZNZVRtMjk3OHhnWmFRUnNzc0ZoN1NiZjJJMTFl?=
 =?utf-8?B?QVR3ZWF4ZjZtSDZjVGREN3RBR2dwY01lUU5NUncvaTJWNENwaVh1NmExUUN1?=
 =?utf-8?B?QVpLUHFGTTVIL0xKbERGU2Z0NjZvRGJYVmgvb3NmZG51VEVyV0FkOUhGeW5h?=
 =?utf-8?B?UlRwNTFubUZkOEsybURxUzRuM0FQaGI5VE1PT0VMelMvaHlQVEpXeU1YQUhT?=
 =?utf-8?B?MGVMSmRITWJXVUZXcTV6ZU5rMkhQZ2gyWG9pOHFxZGpjTXpHb0gzR3IwaldY?=
 =?utf-8?B?T1RJdWVwSXdPODVZMEMwcXk3cDMzSVJabWdWTmlNem5ncU5IK1Y0UklvVnBv?=
 =?utf-8?B?UFJib3grOE5oS1U1UDhzQ2t5am5RLzk0QmZqcGVmMWFTQ0JKc1dtK01NR2ZT?=
 =?utf-8?B?UEphN0tLQlR0SXhzNFFwWFJMUWd3Q2hlRlBHMHNWVFRDMitkeTYzY3VsMjVN?=
 =?utf-8?B?TUV3QkJjaVpMOWlEaStYd1paZDliT2QyMzhUTnQ3akNHY05UbXpNNFM3WVN5?=
 =?utf-8?B?YVdidGxQYXRlb1YrTW1veTVHUFZkQ0RrdHFTZFVmOG9RMjk5MEs3cTNWN0xz?=
 =?utf-8?B?T0pxVUsvZElicm1rNWphallFM2tkRTF5YlFlSGtNWEpGRW5abC9LM1lIRXhQ?=
 =?utf-8?B?em9rL21rS0lxdFo1RUFGeWk1MzdOTy9tZjlUQXFsRS9oOVIzZDBQSHRwYytS?=
 =?utf-8?B?Y1d0alNFWElWOXRud2pPc05CeWJYQjd3K0t3cFByR1JqOFlRYytzT0tvWWhw?=
 =?utf-8?B?Rm1ZeFlrb2FXQ3pSRG4wa0lQa2hZZUNhemtQRjl5M3VQTWtTdjRrTUhPNHlX?=
 =?utf-8?B?eWRGOWdTbE1XSVMzWU03L2ZERWkrN25oL2NvR0FibEJOcmV2bmxKOFU1Nldm?=
 =?utf-8?B?aHNCVjVFbWU5dVlZQUIyaGlRbW5zb0V3b2wydGlPQXZaYlJzTCtJUTNPN2dO?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WNbwjBEfRbfLwGsPsHG6MEtrgijJlwbPWkgpL/xfxMruCcf095o2Et4tjwE/H9bHHrTsCXkleJqV9LK0XFi9cUC/8lDh9/tVA75eoRynLeyssMEbfVps9gW0qXU616fh0Us7RUJB1JiXeAFBWIk7q8hVGIdEJWkz849+d8geTzZ0eDw+3EpbYTiyQYfgPQBvpHGdnmA8yev5Wm2MrhdPaaifWJHG8WnmK8KQk/+ibQtNUXb4IAB5QrzD+gl4G2YBNn3Yt1v1ut915eqo439nn5O3QcvRnr03aG8VfFjPMfE7SuI0Y3TdlWcMNt1dTPG/wJIMr3lH4NGkGA89UDbNNZyk7W2d5m+oEE3AhIWQmmnXK4jP6fK0SjpJyl+eom9oID7UZ16u2ciTjeYcRjXBlbc/EI3gWvsiisWfuRICZkMskYwKd+1Y2dl4r0Obr/SKazR5p5Ofkgrc90sA6ya3B43NndHUEr0WAQsE8aGKEyrHf3u1PjeobaOzSH9a3dACa0u6G7HaCOpWnHFDK5/OxteOfBVs6Lk9k8g+mt3SBrZgzh1cO7/7I+LWXX/icTuTZtBSVNAS8329zNo0vn9lhN9GehvAApgZ1XU1IvdfEjI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a0590c-7a88-49a3-30ee-08dc2d851e45
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 17:48:14.3028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0yYel8wyYXuSvhMiGFJnXXiViUlftbeLj1BTod1LWCxTpU5yWH1E6Qc6ARNQPKuqTG6m8woHZjzRqLoSTUjqG4mXCgyldVKEyivF71o4Rc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_10,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140139
X-Proofpoint-ORIG-GUID: 7G9Q1f3AP0kDVYM-C0SrUvoexwgczZx0
X-Proofpoint-GUID: 7G9Q1f3AP0kDVYM-C0SrUvoexwgczZx0

On 2/13/2024 10:58 AM, Eugenio Perez Martin wrote:
> On Mon, Feb 12, 2024 at 6:16 PM Steve Sistare <steven.sistare@oracle.com> wrote:
>>
>> Flush to guarantee no workers are running when suspend returns.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> 
> Should this have a Fixes tag?

Sure, I will add:

Fixes: f345a0143b4d ("vhost-vdpa: uAPI to suspend the device")

- Steve

>> ---
>>  drivers/vhost/vdpa.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index bc4a51e4638b..a3b986c24805 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -594,10 +594,13 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
>>         struct vdpa_device *vdpa = v->vdpa;
>>         const struct vdpa_config_ops *ops = vdpa->config;
>>         int ret;
>> +       struct vhost_dev *vdev = &v->vdev;
>>
>>         if (!ops->suspend)
>>                 return -EOPNOTSUPP;
>>
>> +       vhost_dev_flush(vdev);
>> +
>>         ret = ops->suspend(vdpa);
>>         if (!ret)
>>                 v->suspended = true;
>> --
>> 2.39.3
>>
> 

