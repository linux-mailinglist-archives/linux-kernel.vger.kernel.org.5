Return-Path: <linux-kernel+bounces-63785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6EC85345C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A209628D27C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AD45F563;
	Tue, 13 Feb 2024 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dqdREUFi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UHmOfyGE"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FC45EE82
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707837053; cv=fail; b=Iwp+VVQ+TIxJPwXrU0LgF/+yheIr/2OnXfzrbcLpjKH5qVuoo27xJuh3dp6bu+hVVQQk3+a5frEVU4VWyWw7wbgnsxEfG+a8bLOxa4QRzDbVpuiBlS41NoatI9QOUa8TFL/DRquXupKxpYcrEqbGZrpS+MlRY1YYHVz4VlKpaMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707837053; c=relaxed/simple;
	bh=SvUQv9tg9zjzeE7JZdqH67o5E6JkclOLE9HbgLauD/U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OzSb7T3KG127StVsqZvKWtsVXZ/X7V8vJD0KYPmDVm5XmM8F2IQI/nY791BOqNW9oE93nTok9qlYtXF/1r1opRpcoxu0Mwek7hVaDOHbLYtt2htJI8U+/7Kv0AcqIP1IxDPmpumWgManmJcarHkAG1d4I0/M3gX2MM+8YQR1BCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dqdREUFi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UHmOfyGE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DDmmDS014098;
	Tue, 13 Feb 2024 15:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=06mRMxzLyvgwJnqM1kDLloFJ/SknHtHkxif2yZ/8uHw=;
 b=dqdREUFiq8WpXnP8wajJqsOJo/HhGSQb+wKQs012kXPwNAo9aJPzXRZc3XSG/vgEEjr2
 6opWHQwn1UherOC7jIGQnmgNuRuqEJS4TGriT7coWfFefBIf23sEsg67Uto54ru7jiwA
 ms2s/XAUYLTpwscFQBo05psfqlhPX3ChXLToSythUqLpRIAWgiRnd7h6Eq7/uh1R0fvT
 pKxS/Ihn1ZdcB4C2thBGdLjwKd+t8FSoTQsJzq9U1DHnWRaI/XN2lv36F80vs6QCuKGr
 TmlItjTflpvrnZnglSnqosacpnlRDt4ifrqaBPRtJL1D386j4E88yaFdb9XMwB74A3sV Hg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w89brg9ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 15:10:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DEXKQ6015208;
	Tue, 13 Feb 2024 15:10:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk7fnem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 15:10:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHWVfPNL57R4KuqOV3iQMFhtPKhoMLj7pss6AKZyShK2Mv9DQ31eNuInM2xiSZG9C70fEQBo1HBeYnBsQ+MRGJCfiabynhcznnls1CcoaQAtSQmw736EYkqZo7x8xvtOuujVT/4/5Kl+CP5JHVz3/dvuqm/Orn4utK0NdCfZedcqDN1pXinD4aSlwEvd7Y2N/NFawiNUJX1XrUdBsuWBhCxdd5pEi+ZiIOQFNappLFnY+rSKfcstAC80p/9QSl0qCfGdwhfbpvwrU96rey+4c/iwrRs0cRdVhIMLaDy68R6tvLrNSw2mq0h4++XKcARcolE8Q5KosTxJ6EX5ZHas1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06mRMxzLyvgwJnqM1kDLloFJ/SknHtHkxif2yZ/8uHw=;
 b=iKlvGlHqZ9lwmX/mhFIGXruTFLEV+Eprc1WKAl7Q3XhkpF/BuUaFAMDavFRxGG5Eo1mQy4YgQ9VmArYaj8Ww4GMDawR2TA34kjvSjHpcyD1YL8mFbWWVGI76aR9y/Iia32U0BIk/p8rguLzhCGtTwZpCvp2ZvT7Z8nwj++SVeAfHVT0BZJQdMD9latBLDB2/se1XMTRRqMo47ZHveIEsF+RN5QTzwLdkIu+D5agEyuwoOjy5o09AOGg3fCk0KLk8046429HqJDmBoVrKqfQYhjXflsfwQkCewBU6gyIW0ur0qnQYH2eG/WbAhjIWom73cep3TNMYphmmfz6OIhr0vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06mRMxzLyvgwJnqM1kDLloFJ/SknHtHkxif2yZ/8uHw=;
 b=UHmOfyGEZQBKennI5dgJRkSIUjDZrI9FoPJpj9qPVUOTaUwv175vNSFz3vPxQejFpiAVnqXA5ZSozMTHWoctZpepd7roGiw0sFXAZFWI5uOyv6od6wCxrpNzE9xxb3s9lUA5yMAxgIgeO1IhHUYVUOMGl5Y6nm3s7k+NW7xgz1U=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by MW6PR10MB7614.namprd10.prod.outlook.com (2603:10b6:303:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Tue, 13 Feb
 2024 15:10:37 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.022; Tue, 13 Feb 2024
 15:10:37 +0000
Message-ID: <83e12387-e9b6-4a06-a38e-0f9888cd4e88@oracle.com>
Date: Tue, 13 Feb 2024 10:10:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/3] flush workers on suspend
Content-Language: en-US
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <1707758174-142161-1-git-send-email-steven.sistare@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1707758174-142161-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0485.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::10) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|MW6PR10MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: e1545ffe-08b2-4108-e032-08dc2ca5eeef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vyem/DqrSn4NThvkofov2MBCfNi8WZlCd/vVzcVKtI4ghVonctefT/0ty7GI4xa4L96+pWUn+CDnfkobRRxfqXlKnE8xB/he4ghAWYBgjw+tpnFR+ol9WHV7+tGLo5oMsZfvpGXlrPyG4AG5VY5IAL3Yno69ewclJLnasxhqJcDdpfZxRfqR2MLiSnY8E4FFRVhyvqPHy3rFzjV5sTJxkjunIMoK6OcfDLwoP5b+A+CWGGsyaaWR4MJ2E6dkMyvxNReQtYpPNu04/STLo12GHJWTgmfvdy+MAeMVSRHmvGpXcM1KYrNlXY+yWPcjIuOa2A0emRL78AGhEWFIbab/gxJzvVk0eLMJGCzalIA7BQoKQ1bNMaFVMRBtkayGMYElYU/8nr+RCXxQ3xScj/2EDIigSZ6wRvfmvwvxaR7ppZ30Q25r+jsf7rYnnvJk04EyHN2VBE4/+ro+l9NidYD8uRzVLqFFtfRnd4WHTqlKFeavgW31oWiZiWQpZbSZ+AhKzirZAA/+jjKyLiJDyRZMz4P7g21zD0Q/8ZjJ1ofBL4tLJKOjlMVyVYlW/celSzMe
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6506007)(53546011)(6486002)(6666004)(6512007)(31686004)(36916002)(15650500001)(2906002)(54906003)(4744005)(316002)(5660300002)(44832011)(41300700001)(66946007)(8676002)(66556008)(478600001)(8936002)(66476007)(4326008)(31696002)(83380400001)(2616005)(86362001)(36756003)(26005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N0RBNnBoOG5tU1QyZXY2UCtTV05rOTJxaDRPV1EvSXNZOFBLbEt0ZnRiK01H?=
 =?utf-8?B?dlFKVzRaaDFDUEpFNDFGYzhOWXk5TG5TbzJNVXJtNmpBVkI5UGh4eFZPVS9O?=
 =?utf-8?B?T0taZG1CaHNrb210cWFPa0RGSGQyb2xONTczZ1R1YlZRT09GblZMS0h0RjZ5?=
 =?utf-8?B?NFFZZ3BxeVFYUEJDc0lneTMyN0l1cHk2NUxCS0ZOQ2F3L2tCclFFZ3VuNXY1?=
 =?utf-8?B?ek9DVGt4dXVMUjNWQlFiMWwyRjBzMFJDeS9FYnhOc2lxTUdFaHduMldvbDA4?=
 =?utf-8?B?WGhZRVVWN0J4aHRIUHBSaU1Wd2Y2bVVVcitJclJaUVRXZXdsVU1WVEt1bmY4?=
 =?utf-8?B?ZC9zR2REQTJrSjcxTWJEbXgrT2pJNU5pWGh3djVHQTR0ZHRVL3h3OXlWYVRn?=
 =?utf-8?B?aXZJN3RPczJBYmEzYmRHcUV3djlON214SzNqQ3ZPbjBLV0dwS2VzNThOOHVp?=
 =?utf-8?B?NHVMRkw2NFVwbzRxWTVLaGlXRjdWTUYrMlo1ay9uSjYyVDZIaHQ1dUFwQzlw?=
 =?utf-8?B?SHhCT2JkdkcvKzl2Z2lSVFJOcUhYYUtmaEJ4UmV4T01RanJqRStmQUFrWW40?=
 =?utf-8?B?ZmtyckRCaHpGTE9IMC95dTY3Y0ppdVNwdVQ0ek02cHNYRHRWZG0wQ3ZRdm4w?=
 =?utf-8?B?ekYwdTN3ZEJnNUx0VWJjSFNMZmlJNHNkcEUwalVlRldRazAyVUU1Rk5Kd3lI?=
 =?utf-8?B?WUZJWnFrTm5RVkhBY29wb0pOS1dyTlBaaldqNi9GU3hjV25HUHp4ek9mS0tu?=
 =?utf-8?B?eVl5a1dhZWFSOGdQakc0dWpIVFVOWHVBcTRhZG1SQzNCeVppVit4NEZ3SGZo?=
 =?utf-8?B?RFNZTlBtd2hHY2RmTlVINEY1UlNxQlk2TFliS1R4K2VjbFJQZVorVHVTUW8y?=
 =?utf-8?B?TklMaXZQTk5Pb3BRTjBRU1hrYWx6UEpLWmg3K1FyWDlZMmtKYWFMWTJxejZ5?=
 =?utf-8?B?eDJSREkvREhPNDhlNlE2OG9wUDI3L0I1SlZMZEl1RnU3UFd3ZDNLL0NQbFl2?=
 =?utf-8?B?ZVhVR2Q4R3JrcnJJNEY0bFNDQitCUzI2cGRoZ1hnWlBtTTBQNmVwK2RiQXU3?=
 =?utf-8?B?MTZrV3ErMXZjR2t4L0xYUDJQNUNIckJQTkxqc29xWWZwQ2pLcHVNU2U5a3Yy?=
 =?utf-8?B?dzBVRW45ZGVld1NTMEltcm5KZ2ZrT1lRc3l0SDVWKzJtQk5Vd2U3VTJZUlo2?=
 =?utf-8?B?YlFHSkxtR1d4Y1RPeFF6M3NRaGV0T0sxbEIxTmpiNEEvS1NHeTVLcGhWU25X?=
 =?utf-8?B?cWkzV01rMm4yS1IxY1VsNXl4ZGpKbktXVldJclhlZEtRLzlzeVFENC84RUpW?=
 =?utf-8?B?TTM4LzBZU3F3Z2kvMlIwVmUvV09vcW5FQ2xoZGpZdk04NTNSMElhS0FpM2xy?=
 =?utf-8?B?R0lYRnNBekhZL3pPY3hFU2U5S2ZWeUYzVkRuQUlmc3dqMFlPTHprMytPYlF4?=
 =?utf-8?B?UHlzVU9RQmpNYkVEOTh5K0JZVGVGcE9rSk40bTNGcGRuODZpanJNaWxSOW16?=
 =?utf-8?B?WXA2a05SKzBYMSs4dS9laEcxYWpYVzhnZjIyamxESjVlSHRXL05WRWdtR0RM?=
 =?utf-8?B?cFR2OFlKem9Oa2tqWCtXajFxNkNZUnBHTUdrak03NGVkdU94ZDM3ZkxEeGZJ?=
 =?utf-8?B?MHF4RlJuNzFpNjQyNzFZQ0g2K0dpckpwZDQwWTRNWUZ1YUJxU1QyZDlpbmg4?=
 =?utf-8?B?U3k1K2pjMm9Qamo2S3o1YUFYcktsYmt1VVNaL2RsMEhMZ2VMYWV4d3orZ3I1?=
 =?utf-8?B?THRRWXRuZGxaVnNCckNnWUxhWFJvYUdmYVlFS21NV0xGRFpaOHN4bHE5MTlD?=
 =?utf-8?B?Nkd5RGNSTXRYRGdrT25nMEd4YzFLUzRrdldPRml4Z1puNk9qdzlUWVpsTkM3?=
 =?utf-8?B?V2tYS01IRkI4OG9RWlpaTU54Y2N4R2l2U2RTdGxnTGtIc2RlRUw2a2kwS0FO?=
 =?utf-8?B?WkZhdmNiK2FuekdhZ3FRV2VjOHRSSEJ2TUhVbG1TZW9lTS9DVzNmSlRJdGFv?=
 =?utf-8?B?bDNFVy9wc21XRFJZVi9NdEpPejU4bFlScGhJanUvVjM4K1hQbWRlR3pOYUZv?=
 =?utf-8?B?RXhRa1JYZGJVSTRUNlZYUlFYNlMzWngvclU3TTZTbTZxRzlQYUU2MWFUQVp3?=
 =?utf-8?B?R0lGTTlVWkV1UlFMd2sxaTF4TmZSaUZrMkdtdGh3UEpxOEduVmFhamJtWTJs?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zqjpVnrkVH81ppNLEanPWmKiviqaFWW5hjzZSjBX2xRPugQyLEDY1TeR3+pvWx/71GDAntGeuQ2vXn8kQwRp0ogDoal6c7Hh7GtHCuQ7svrjvH3tpxqG8uiW0rMFvVBqPViYPqVi+aefnP9zgp7AkLV8XtcbB98Pw3QviId8QO2e+k3dnwvyIdL6RGFGWCXHqQHrnrPULUqRjlOcDHmsC6Hfh6kWA8VjZOYIxo06VgJ77Kv6EvcC0xGzw4/LxOC2AfAOWaGlKC2p0yI9VlGbZj3Q43//i3g+JY0vJquLrawqgbfsOi/Dop1c0OVgdC0/t3E4UAvUa03R8wUW4o6RkIX5NAGXvx+JA+mBtDXbZkW2deP1FAcUwxvjJcFSrDDU3wW9taCavvvYH0MWJZ8lZI7kEEDLCWwGaPZBXoco8Pb8lD8WP+24EbpEUcsSAFps9TkS/AMK+ipWheQQJnSgVWothf1WRO6cRWvVyKn0PQbzWItT4MWF9UEKBJirLLumg2McEO3MKdGEQ0W46lkytDWCy4fhqY0l3oc2yoDamzw8zLgJTZLInYJTpGav4qVM7gHnAQGnY1FRTnUbpkB3wwyS+myzgKLdUbbG6I/tv6I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1545ffe-08b2-4108-e032-08dc2ca5eeef
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 15:10:37.1819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yb44RCGo91qm7Eruf0Wh0z92ccrjuDOAK2qctteusbWKinoDNe1viNN0l6BJk04BR2EF1WCrVOdRqtFdFTbXdXKEddW73zqWgXsh/HLUWck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_08,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=556 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130119
X-Proofpoint-ORIG-GUID: -FHOKLaX_FbR_b3DK7GV1RA5jSPyz2c7
X-Proofpoint-GUID: -FHOKLaX_FbR_b3DK7GV1RA5jSPyz2c7

On 2/12/2024 12:16 PM, Steve Sistare wrote:
> Flush to guarantee no workers are running when suspend returns,
> for vdpa, vpa_sim, and vduse.  (mlx5 already does so, via the path
> mlx5_vdpa_suspend -> unregister_link_notifier -> flush_workqueue.)

Changes in V2:
  - renamed "vduse: suspend" (was vduse: flush workers on suspend)
  - call vhost_dev_flush unconditionally in "vhost-vdpa: flush workers on suspend"

- Steve

> Steve Sistare (3):
>   vhost-vdpa: flush workers on suspend
>   vduse: suspend
>   vdpa_sim: flush workers on suspend
> 
>  drivers/vdpa/vdpa_sim/vdpa_sim.c   | 13 +++++++++++++
>  drivers/vdpa/vdpa_user/vduse_dev.c | 24 ++++++++++++++++++++++++
>  drivers/vhost/vdpa.c               |  3 +++
>  3 files changed, 40 insertions(+)
> 

