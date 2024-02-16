Return-Path: <linux-kernel+bounces-68178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1F18576DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5DB1C217E5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C506E171AD;
	Fri, 16 Feb 2024 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FzZW3yNj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kxoTS8zB"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8866414280;
	Fri, 16 Feb 2024 07:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708068961; cv=fail; b=EsHjBySlVb/XuEGA2AeCO+qwg/4KDVmNp+SJdUplsHni3z14swGKH+fnqhG09tCj6rFnevEozL71onzM/SDkPtKv35SK2aq1oIhXmkKxj45aF7HQqhnjL/FE8Tzp8esAayc7TY2f5+cl8Vwh5/ZCm7rqxt8JHI+DbhU+QcUKagU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708068961; c=relaxed/simple;
	bh=V6+cBnW8p2bb9Ob8Z1Yir8zxn7EWxJsAlQ4ZHKM8klo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P89c4JDPQHBgyp0NPBZqJnnUfmrQi7fYTbt08iL0Neo/8gGEKX6OHps0KMYaSLFt+PzEReW/b6x6itOcwb6EGc6VG1z3tz6bSuFDMWJlB7V67N8MBkKOI9fMpy59zV0wXsQdt7LROhXdpm6NKlMjA15+MYjNecgD2s4AuvCoD+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FzZW3yNj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kxoTS8zB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41G50DVj021037;
	Fri, 16 Feb 2024 07:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=s+SYZowH0QfNN5ESswaxj3vGvque37rR19VBvozh+Ps=;
 b=FzZW3yNjgnnRyf0uTLKciBoQWX3kWqLO0F8cANFIHnMQ6RhydduDy+yt+3Mqo+0xvBL7
 sAJmahemzHesHsIF4dt4fEOBz87DRD1NnHUPVRhGsJQrdgvZI1UyldSHlCY3P0gX++rF
 RFdro4PcM10cn2UswLsEmaQ+i+k+aazmunexnlEmajUo2ZjRsTd43Usnp9ZQvvWH6uTI
 4L98Vv8C2GQZUzNFicAQBxkSop7IRTZfkAlvawqSSXR4WrAAj2a4a+P2GSOLDsGzdkkF
 gK6GR2sIE+CuS4pd9Nn21nVfCo1o4BkHz8lNfCNn7We8qxPCgn1Jw+BU/QuJh2VgmxM5 LQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91f04p1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 07:35:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41G6fZtG031332;
	Fri, 16 Feb 2024 07:35:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykbrk6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 07:35:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGBOI8YlQ/wST/sp/BfAGBNn3x5lFi4GwwENSrnBnVBf/RHrkbx6XrHiqsJGJ5cRGXgWo7y9VwiDyYwFhmeUYufirXPafbeMducbqR3FB5EAAtOzlMujm4fbMyMFsLT0r0xO718C8v2EqYov/8zfXQbFH0gPfyo/Grdm4NO86u/+RfI9jCzolFi49VVGUigAr3FK77nsQW8tmEr6w0AYR75O4ssX1AAORzW/gt6/WekAgXhhpSnjLREFq0Mf7apRULWljOhcKxoaBRnFBEQayhXbClpozdWm3VptfVBmUeauzhMjX9d8weuXskT8yd1X6A/p6eu4ECjvUToeodaLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+SYZowH0QfNN5ESswaxj3vGvque37rR19VBvozh+Ps=;
 b=Ssk6jfA6Wbah7NDqMM1XqtiBgLyhtOnCu+Rdso7sjZBcFpfvrDEmuy9kSl8RnmGVglcceuMNtUOeJ9Obi84wG/i3kfZuZDh0m814TwFl9KQpiSfM373FOAqEysV/XRSpF2wyCTLnUL9XAuXJfQ6PBneFPavhnuTL4HC1Bn12lZGUecqdF3hgWsjzk2gLOYJTXxq7qKLgBl/RnXwxn+myZDaOuih97P6hfa3Afak++Zax97Y/Y4bKoZd8+XU4O+0KFCc7W8AdZGQulNNfQh5YIE5ktJCygczz7/ZyAovDuqIt47YORqYWHIkr/RvjaYi+TK4dg71Bk6AQAPWC+g/CoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+SYZowH0QfNN5ESswaxj3vGvque37rR19VBvozh+Ps=;
 b=kxoTS8zBGeO6/QvWNQTpiwp2A4WtWXJxxtTssKfv1iumyzpTa9AmMiwILd3Q/Nsfaic9WX34Ym2RXJ/UZGWYNRuVhYUerzF26T1UvIsXbsscshG/VJkn6dKVejNm0x5PTrSOQttTyZ4U8OGItV9I4i7OExiA/vxNhIV3B0lYj6A=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BLAPR10MB5043.namprd10.prod.outlook.com (2603:10b6:208:332::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Fri, 16 Feb
 2024 07:35:44 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7292.027; Fri, 16 Feb 2024
 07:35:44 +0000
Message-ID: <3c2801be-acb6-4e6b-95e2-5bebe834c258@oracle.com>
Date: Fri, 16 Feb 2024 13:05:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] VMCI: Fix memcpy() run-time warning in
 dg_dispatch_as_host()
Content-Language: en-US
To: kovalev@altlinux.org, keescook@chromium.org
Cc: arnd@arndb.de, bryantan@vmware.com, darren.kenny@oracle.com,
        error27@gmail.com, gregkh@linuxfoundation.org, gustavoars@kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        pv-drivers@vmware.com, syzkaller@googlegroups.com, vdasa@vmware.com,
        vegard.nossum@oracle.com, nickel@altlinux.org, oficerovas@altlinux.org,
        dutyrok@altlinux.org
References: <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
 <20240111125330.53853-1-kovalev@altlinux.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240111125330.53853-1-kovalev@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0095.apcprd02.prod.outlook.com
 (2603:1096:4:90::35) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BLAPR10MB5043:EE_
X-MS-Office365-Filtering-Correlation-Id: c67e649c-51f4-4b2b-faf3-08dc2ec1e248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	A5slfL0FI+cbszOmRPHNb+s2kFbvMSJpH37g7SEXqOyKmLBrtCims56+HHu7uD62eRhvw3p/q1Q6F7Q2wZSJzVoyxAC8estNrlsJsLHXWnF/veMEHqAcgJQTxuzN1qyW0prhErh25Zc193bA8lQlAaXFtJONHK5BPKYC9czlY8knNjeYgGDhv7G4W7WY4dr5fpcG3AfzoH5ZXpjSx8hrAJkBnAGsaAkaUj06BuSIpbbaVeR1EnRK9cyd1+nMM+/ehKQxYwzpsaatqbJdYtUgwwuVbFeN2BoQPuOoRVlrjL4m++X2mL201M6QoqYPdRoNS2IZ4v+lpgKR8fPnsDBWgCgJtWn2voLPVCcL0xQQrScFNVoEFyQ1dAovmik5aKur1Zcv2E1a4Y4+BZR3S/RTzeAKrE3EAYsRgi3C6xCawc7f0LEsyf0kTfdd408+4MrKz6iMKzEUe7qoZnULnCfs+rdHegOm05aFVgMQE+mQw2EDEBRotxYY0bDqo0shjjPqGDtbiZojGkNQj49mwMPwoV0nyLbtBvKV7b0GWeRSGYBcQKb0g++sgLvFzbJ3L/fl
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(230273577357003)(186009)(451199024)(64100799003)(1800799012)(86362001)(31696002)(36756003)(38100700002)(53546011)(966005)(6486002)(6506007)(478600001)(6666004)(316002)(6512007)(26005)(83380400001)(41300700001)(2616005)(4326008)(66946007)(8676002)(66556008)(66476007)(8936002)(7416002)(31686004)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TzZXMHlrZmp4S0lWNzN2dGpEKzhjd05iUTBZMjhsc0hKcjZGdWwrZ29RQVNj?=
 =?utf-8?B?b0FUbHJQSHR0QWwvVEhwOXpaalNjODh1OVAxeDI3M0dKbGgramNhREp0aTQ5?=
 =?utf-8?B?d2VTUUx0dzJKMG1ETFlyU0JGN2c5aUdmMFRNMDV6V1F3cENSMmFZcFZSVnFU?=
 =?utf-8?B?SDVmYWE4cUNvOUllSHdKRXlYUFRLTzFmN2RyOWlPRyt1VTZTcXdBNWhmSTdP?=
 =?utf-8?B?eWFJOERMN2pHYi9xcmlrRW1HTzVlYnh5MGYzandVL0lvd01hZXY1YjdQeisr?=
 =?utf-8?B?UzZORDJXaTJpeS81RDFpUGJYWDYxV0U1NkNQeXRFOG5PcXBBN0szNFUxSkVH?=
 =?utf-8?B?ZmdjZjFtT0RGUTBTOGhuS0xsMlgwRVJqU1lDdXZETEV1VGtHUkd2N05jcEZH?=
 =?utf-8?B?ZGFURkFmOUlLWWVNM0RxdkhSNnBmYmkzc0JKaURPVFFnR1g2aVhNcU0xS1Mw?=
 =?utf-8?B?anZQV213SzE1WW5RbTJMelZsNWlLcUJISFZ2SVhoQzduY3piN2VIK2Z0TnJQ?=
 =?utf-8?B?NUtMZVh6RmNYbEtvWW5XZSswUXVKRUpRVGlWckVOUzNHRm5zMEtlcCtRbjdT?=
 =?utf-8?B?TmF1SVBQMjhkUFpnQ094aWxvQ3NrSVRpNURVMWh5WEFEM2FKbkoxYjJnNGl1?=
 =?utf-8?B?VFBsYlhEWENtNFgvSE9LV0g5L1NpcnhjOHZ2QUlxMmdZU2FrNkdmV2ZMVDRl?=
 =?utf-8?B?Uk1YcW1qTWRrMitmd1drRlgyMktpMllzemZ3b0lqdUpjQUlhQzFiK3dsMlBv?=
 =?utf-8?B?bUJvby9zdWJobWtnOS9zUm5TK3BBejVJeUVSQURNZzZ5eXFmeGxRdERraFdq?=
 =?utf-8?B?NXZFZkhteHdPTjBCOFV6Z3YwN2JJbEEyQ1BISDNkSWVCL041R1RIcGNmbjY0?=
 =?utf-8?B?SDViZ1lkK3F6VWdzTzRuTmxwSXUyamZPTlZpNlBBUVhINk5WeDNQaXNqeHl3?=
 =?utf-8?B?eVp0SWFzVDBYQ1NaL2tCanlsTFpzYTdna3lZdkNYQUNRckhZdnh1WWI5dU1E?=
 =?utf-8?B?Tk01aXVvdVBmMUVENWJEdVovaXVVaWszRktTTXZTVFZKU29SWDRHMFFKOWQ3?=
 =?utf-8?B?dUtsSktNVTRhbDZHdzMvSTA4OE1mMnRlaXpuTVZoenVuMWs1dWU3SVpFNnVz?=
 =?utf-8?B?NW4yWTViMjNtRDg4ZXpDSUZUZCtpallMdldoNzFQaGJWcGdIZ3Axd0E0dkNB?=
 =?utf-8?B?V2hxQ3JiTTlPRVg3N2R2ajNiNnhnang3a3lIUVJDVXVLdmdyb2hpdS93UDk4?=
 =?utf-8?B?WGhtNEdQbDJMU1Y0NkhISFd1QUphUlVORy90d0NYNDBlSXIrQU5SdTBRMS9s?=
 =?utf-8?B?OXZXL0p2cW1WOWhvcHpvNStKUzNGeUJNZlphcWNFUGhRTDVEdmVaMEZMVkZz?=
 =?utf-8?B?L3N6bzUxQm81dXAvYXF6YjhPdjBkdFhaQkZGd2FsRnVQejVBWUsyYVNkS2xq?=
 =?utf-8?B?UEhtNUE3T2lPWTJtUXY0ZE1Ic1FSWDZ6bEc3QUgxY05GUXJNT01RMkdEU1Q2?=
 =?utf-8?B?SzFYQ2RkUTNlSmk4NzkvVGx5eFp6WjU1Tk4wY3BnRDNXU2hwdnBaeVgwUk5M?=
 =?utf-8?B?Q01RT2JZeFVBenlOOHZoNVVYRktOUmN4Qy9tajF2QkI2TjJEdjVZUlFyWmlp?=
 =?utf-8?B?V3k0bU1QUVF3Y3YwdndoMWVlQjZKaVp4Qkl3MFNmc3JlSHZnRzdPck1LMFRM?=
 =?utf-8?B?V0V6eXdJLytxQnRhNktrak8zL0xRU2YvcHovVG9oQk1zMktXdW1rNFltaEs5?=
 =?utf-8?B?T21TTmw2N3dHMVlwUCtKSUFMMzJCUzZRaDNQaEhDOHN4dzVOeUFwS0czVm5H?=
 =?utf-8?B?cG55cHJETWJxMEd4Q0g2RTlZUEpBQnNWa0o2WGtSWHVBRE5rRm9xQkJFL3Av?=
 =?utf-8?B?a3puallLOTRSR1ducTlMNjlTaHBuWUorbUd1bjlHM3ZRQmJGbUI1VnFCQzFD?=
 =?utf-8?B?aVNpSldiRm5aODd0SzdFUnpnNXVpM3NnY29MUnR6eFR5NGEyaTU1MytXcldj?=
 =?utf-8?B?U1FuMzBrTXkrbUtEekxTRnNVTjdqbGFIWXVWVmwrTWRxdkZ0YWFDcWtoV2NB?=
 =?utf-8?B?dHBWN3E5WEpvbW4wSU5TVzRJSmx4NnVaMm9pNWk0VXA3ZTc3b2JjOWVpMVZ0?=
 =?utf-8?B?TXpmbDZHYVkvZ0srbC8zWGxHZEtVVmh2TFhCaGFrWFRNUEM0MFBkY2JPT1po?=
 =?utf-8?Q?dyVLYulSZsh1vZoLZhAMdxo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	A4CPR3jKmKKByBZGlmsp0gj+nh0VAdJkzy/fKy7lpox6YJeOdcUSGQTpjw0zpXzPAOYoq7NUIcHevoCg9PD16VDf/LTMO4+PyBbk2q37lFjyUSDtmPooG15/Xa6ulBSzjYh5sOpBIBtT8HNnefDGygazegWDjMuQKlssiH7BZeZz353sbH6vuuhK/FtJjKGrkvm7zNh3IEjawSPM6KnFg8QY/zVdKXaJF+Fb7DNOLBCYCuh0w2aBW+Zhq51SDF+KHgoMNaZAei4GKrV2GIlRVQkIDk7MWXo8ttuTta584ucM0hcTJTZGWR0qYTuIYcOr+LxfXAHfqBo9+ps6PHti8aWksRsziiAz+zVk2mzZQAW83bHlUUJUKPcp2P/mgwS25bedCOdqJ19z8g3HNDNvBi/Njdy1cxsz4xinp1148CPNI8S3eepQHTymK4qKx43gNDtXeI1u6s5Ucs02+qmK63Ci6CWZcgPPmwTjt0C1GdwwVoMKYFNBFAdHfmAyuYVPKezrGllfYIZIu3RmKjo24zqdyLbRaLDdoWqpmcb2TKf6N/wwReYOsSUXZIHJAsdbkmhuEqYdZIFBfTgOqk849DMrBOnYzLC/fGycarg+7VA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67e649c-51f4-4b2b-faf3-08dc2ec1e248
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 07:35:44.3528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6kHaRmDk99th4LW+lja7TRPNbW8HQwpD9l1OZN3dYX2mKcWnKYbQxB/HaE7cMv6dHMEAMfhrb32e8+iJLdlr0C/9ffuQI0u/mpnBVvdc2jIl46tttKUzyMujLuGJP4i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5043
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_06,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402160060
X-Proofpoint-ORIG-GUID: 2Ayf1Y0DbW_yNO7KYGgAtocN_mskjr8G
X-Proofpoint-GUID: 2Ayf1Y0DbW_yNO7KYGgAtocN_mskjr8G

Hi Kovalev,

On 11/01/24 6:23 pm, kovalev@altlinux.org wrote:
> Hello, I was also working on solving this problem
> https://lore.kernel.org/lkml/20240110104042.31865-1-kovalev@altlinux.org/T/#t.
> 
> Please note that there are 2 such places in the code, and by analogy with your
> version of the changes, including changes in the approach to calculating the
> size of the allocated memory, additional changes on top of your changes will
> be as follows:
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_datagram.c b/drivers/misc/vmw_vmci/vmci_datagram.c
> index ba379cd6d054bd..1a50fcea681bf8 100644
> --- a/drivers/misc/vmw_vmci/vmci_datagram.c
> +++ b/drivers/misc/vmw_vmci/vmci_datagram.c
> @@ -369,8 +369,9 @@ int vmci_datagram_invoke_guest_handler(struct vmci_datagram *dg)
>          if (dst_entry->run_delayed) {
>                  struct delayed_datagram_info *dg_info;
>   
> -               dg_info = kmalloc(sizeof(*dg_info) + (size_t)dg->payload_size,
> +               dg_info = kmalloc(struct_size(dg_info, msg_payload, dg->payload_size),
>                                    GFP_ATOMIC);
> +
>                  if (!dg_info) {
>                          vmci_resource_put(resource);
>                          return VMCI_ERROR_NO_MEM;
> @@ -378,7 +379,9 @@ int vmci_datagram_invoke_guest_handler(struct vmci_datagram *dg)
>   
>                  dg_info->in_dg_host_queue = false;
>                  dg_info->entry = dst_entry;
> -               memcpy(&dg_info->msg, dg, VMCI_DG_SIZE(dg));
> +               dg_info->msg = *dg;
> +               memcpy(&dg_info->msg_payload, dg + 1, dg->payload_size);
> +
>   
>                  INIT_WORK(&dg_info->work, dg_delayed_dispatch);
>                  schedule_work(&dg_info->work);
I think you need to send a separate patch/patches for this.

[linux-next]$ git describe
next-20240216
[linux-next]$ git log --oneline drivers/misc/vmw_vmci/vmci_datagram.c
19b070fefd0d VMCI: Fix memcpy() run-time warning in dg_dispatch_as_host()
e03d4910e6e4 VMCI: Use struct_size() in kmalloc()

I see that the two patches I sent are applied by Kees and are in linux-next.

I am thinking if we can reproduce the above WARNING in 
vmci_datagram_invoke_guest_handler() by modifying the C reproducer 
generated by Syzkaller for dg_dispatch_as_host()

Thanks,
Harshit

