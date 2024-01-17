Return-Path: <linux-kernel+bounces-29418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5E7830DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F151C20D25
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB48250EF;
	Wed, 17 Jan 2024 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NBNihF7P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FdoxdPaI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C28250E6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705523478; cv=fail; b=HJMyjesVPG0xK5HTyb1NrSDrQsCT0kCn0aIlwnPYHQlO/s2n09TLdjukqwclStKuRj5R/kAOT5E9VcVYiKr955CGR/xD+Y9FWDFJp3IvKi1OGBjhiRT+SbQlbKr1Y9pN9p3i3vwpoEgNQ8IWwC2qxawh7CullxqkiglfiP/ahbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705523478; c=relaxed/simple;
	bh=5NV0PEX03omQCG6TARbFMbAecBQsq+1hrSSH8fnmTJI=;
	h=Received:DKIM-Signature:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID; b=LjJoZBxOHB8ChJsVjVKT0EVaxI0ajssDAY5Iwn1CXh/6LKXthsHxZSI0SYA2gtVj8aH8KgObd5UnScm9fVPoLPm9yb8c+tmqXmFddP5frlNUqOXbks4fbejCk58qa7VfkLEYpFUkYWU06GSV5cDGt+pAKAFzu+5UKVCJDkIWE7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NBNihF7P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FdoxdPaI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJdKpV023662;
	Wed, 17 Jan 2024 20:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=hPCOwRMADSbPYFe3a80MyB9lKKU9HdCira8YmLtIArI=;
 b=NBNihF7PFp+6SN91YbZZ9V+LdWFdZh9khhAZ6ZaICoSgacBEXsc7AxPWx2UceCrALqUF
 uMIo8GnOrHQzGAcuee6AUqC07JXx/wXmJdCxHrJvsXn3VRvNb5JCURwWnTBN1tabZaKl
 a9VrpkO7WIwDmklt6OBvsVnS9mdRY6uIDIRUnHpkW8h55FpuTBFjg5+C15WlrNZpAuyG
 0gSHE8GfYy6H/AtojWsPYmIv0g4ccBa5dyh/FI+CaTQ5gyom+Qrwz5IGHe4HK4+ocmSZ
 jmW4tp6ur53b8NhyHSe5TjBp8ZO8vKpKF1i3Bg1m/KVk4dN8sgZ25Hp0KenfE92MtxAk wg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkq3h0nyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 20:30:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJkf3u035811;
	Wed, 17 Jan 2024 20:30:58 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyb396v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 20:30:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqhvdTU9JAUy7A2eawk0RbpXe6yOmoThOmnjnROhmpHM97YZuiuEYYEJzMyG/e7v5mP64CsJ6QPqdgWw6bt7Q99O8L6pLbdD3XgtrnuFKsaPzJ67n/mqy74FadcAwjNTLj+6BuFpCvAgxs+V8dVzkIlUEGST4/LgVaCY4pAcWFja9o+X+Xtbut/r0DTks8w7gcX0nOhCcUJRLcpuVpP0DhZASbUn95CFj1JxfGgGStcIdtxG4QEqjvJZVf1XWL7sm9TbRBBrny2khop08YBhnbvR1mf7J6zD8AxJ3EbwiLodeNojE+sY9fg7yK0fXIt9nhdNNOX95z1xvy05FAz+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPCOwRMADSbPYFe3a80MyB9lKKU9HdCira8YmLtIArI=;
 b=NHs1xcEs2cjFweLVivM+7PMF0fECGiYSKe6Vo9ZvF9sN/wTC4vI6wBTYfinwl4tZEw0PfHHIbzBZyClyktDP+Y4XONvgxLkEpsIh4h9Kwr0f+wIjtxywS2kc5vncDSKGnVteYsR5PdaJOae3t6zdviYl02MqUwn0bH919HrdRfnPrEYcnSakNKMhHfTq5+qCCrQQ8ALGDzMoRs4yXyG5zvJc4zQrEGt8rbKD/D9+XNzpx1Fj/dfeBf+MBNOG3A2Ce9MFuyG95cJEZZCTbuTCK9F8R5PDPrZXOCiBdpSCPqZjaJUfbPd7aYOb33EEdAtuEspY/X6JVrjjx2Jkm9VxFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPCOwRMADSbPYFe3a80MyB9lKKU9HdCira8YmLtIArI=;
 b=FdoxdPaI3tqyYXMtKUwF7Ayf1Sr9/Jh2UOfESy+MWShz8DHmDgol8XZUZFWF1pMq9U9CnqjyeAl0eaJABgvm8NCvRoCP64JW2Ox1oo0EBVaaEANdkHi3utKpghBrgs8+uQdyiXFb67MNbOTLQ3EluaIolOBvd8xFVFunQICrDgY=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DM4PR10MB5942.namprd10.prod.outlook.com (2603:10b6:8:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Wed, 17 Jan
 2024 20:30:55 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7181.026; Wed, 17 Jan 2024
 20:30:55 +0000
Message-ID: <3017552c-cf49-4357-8bc9-d47593024e29@oracle.com>
Date: Wed, 17 Jan 2024 15:30:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 07/13] vhost-vdpa: flush workers on suspend
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>,
        Mike Christie <michael.christie@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea
 <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
 <1704919215-91319-8-git-send-email-steven.sistare@oracle.com>
 <CACGkMEv8TXXTrCW=hf1sJ+V2a0eD3w1b1Yub4FnGZ0=Du-RbtQ@mail.gmail.com>
 <11ebc73f-6469-4c97-9da0-0728edfb283a@oracle.com>
 <CACGkMEs1sf6NWT76fM+D715kqrwJ56SAXrcExKvWH_AYsjcGJg@mail.gmail.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEs1sf6NWT76fM+D715kqrwJ56SAXrcExKvWH_AYsjcGJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::34) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DM4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 56bd8815-92ea-4236-c62e-08dc179b34ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	d8YdgWBDU9PSwdSn0g08qtQZzHu9fPqVpyqqTlf1oA/2sQZsU+COe9T99TpspYCfop384+f1VN+e6ZkuNvCNE1lxLh9uzf2Fx9KSExgPkpPPMGHdGTnmlVt5SOWdixFnHuKLljjYMd/rFV8C5bvO8bQ8zyFIj+t4FHOqUiRp9pzo9tnn9T28roWFXN+ea7eCLSfuEsQhxqVY8c3is+OvSQvcNS0WWnGSKlZBjRVouzgHRB4Swlslp4PEYR/oRa1K6DC7XemEfCZQTn0lue14ZlhWH6tLXwH+fidG7CZyVoizpbfJLJhoFxJimmTpKGD1kc3nrbE2emKkOuHC+fPDZkFy/Nj2HEANAbzVLlGVsV6brwW33RdD+NqrXOq5SwYLzzu6rim2ptP678h6OBEAgeRyZHNKOXMtiQiW22E8CqVzXl0TYsz+u5tpEStpYRszChQ0UqnOYa4GxXU+XjWaRvEUFyjWivpcVV3YKurlzZoIo+kNS3WsqddsQalLZI/qbr/n32nUGwkd2arqBnKtcsncaZOvYmfQEKVU9uwBgYS2SFJ6iaTg46SIAG3pWbpQXZOqjJDHbQ56C+SCzOIIRbDep9JGbgzEKTCr162ejsZaB+k3jrbPfyW8C3hwXenxic6gnqBda0aB3jxkGTe2Dw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(44832011)(8936002)(110136005)(4326008)(31696002)(5660300002)(15650500001)(8676002)(316002)(86362001)(6486002)(66946007)(6636002)(66476007)(66556008)(36756003)(478600001)(26005)(6666004)(53546011)(6512007)(54906003)(2906002)(36916002)(2616005)(6506007)(83380400001)(38100700002)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OCtwZ1g4TUpXRzNteFBaNXpEUWd0Uyt3QkdIVXFISFdNdG1yODNRM25PZFpC?=
 =?utf-8?B?bWdTOEZEYXRqbHFmRlpUQi9UM21JV3RaYVMzVE5NOGc1VFlmalJ0R3QxMXdK?=
 =?utf-8?B?T2oxMndNYWliOC9ScUd6OVpXUGorVDJuRUFnbzhwbFVhaGE0REUzR2U0d2FQ?=
 =?utf-8?B?QVlRSlRUNyt5Nm52dGhWclB0a296RW1VTWpCbE9iOHFrNGVXd053cnUrVWVo?=
 =?utf-8?B?a0puMWpCVldqVGJEa3RNUmN1U1NxMjl1bE85NWJXRUdLNnRldThWeWJ1S09l?=
 =?utf-8?B?WVlBQ095TkdHUXVoWFhzR0J0Q0hxRkQ0TzBXclo1Z3paK0tKeU9oVGhKcjcv?=
 =?utf-8?B?YXBqbTZGNkhoN01jd0RMZmV0MWUwYWtWekNFZWYzcm5kZmtwQXd0N3J2d09m?=
 =?utf-8?B?NWViQWRQaFdPMlh0Z1o5RjZWN2Vzbjg1TjVVdklBYzZydW5PaS9DenBRV3VQ?=
 =?utf-8?B?am5yejVjZlhmK1ZnV0xUdUNtTGFFWkp2bzdkK002MFZmR29ZUUhJYzJOTUZo?=
 =?utf-8?B?V3NWemYwcWtSTStIbzdvdkQyZ1k3VFhXUUVFMjlXaTJuQmFzQVg2ZVU1cUp4?=
 =?utf-8?B?QjRqTzgza1pLVTBpa3hXTFYxYjRSbkJDZ2NMbmdacDg5WG9zVjZ1bm81UUVE?=
 =?utf-8?B?VkdNcmFVcWQ5VDQ4SE1rcGJkMi9uSnhCVi9keHFYRCtFWWl0VU9BS3E3a3Ni?=
 =?utf-8?B?cmowdG9PRkF4MU5zVjkzTE9zbnAxMU85VlJjelo3UFNNQUhabHlFQjNmdUNP?=
 =?utf-8?B?ZUp4K1NJUkZiS1RaZlV3YVgyVkJRYmJaaEFyakd4UmVYSnF0RnVvdjc5dnMx?=
 =?utf-8?B?bTEzSk5UUkpnN3d6aVoxc1VjSU5aNVZzTEJRZEFIbVErYXFVcEpqTGxWOVFV?=
 =?utf-8?B?ZjlPRk84SXlhU2EyODVBb09UTXloL2FKT09KWktKUi9waXhtdVRZVVhFVTRS?=
 =?utf-8?B?UmNHaTJWd041OTBqVkZYNkNpS094WXdLQUdLRytESFhIR1BPVEVObFErK0c5?=
 =?utf-8?B?NGhBQ0hrdmhVbjNnWXJpUmtqUUJHUkd3NFhuTVNXeUgvMUlEQ2hTYXRIUkZU?=
 =?utf-8?B?a0lsMXdTN2FYYWdpNGlPMDhEZ25wRHZPOGRwdDlnK1JzTlRuNVVlVmIrSWhD?=
 =?utf-8?B?WkVoY1NVU2tNSkxxR083ckxRRDlrUlg5UlBEejErSTJPZDVudWhZekh4MGJ6?=
 =?utf-8?B?QWNHRTFSKy82ZHB1cXlKTnlXNFVzTjNYTldOU2ZPOERRRWwvdW9RQkFjSnUz?=
 =?utf-8?B?Rkp0UVQ1Rk9wRXlLbHkxdk9ISVVqVW8ySEpwbnArRzNCaDBMT1dhZlYreXJR?=
 =?utf-8?B?VXVFeWtkOHNBdVNQYXNWUGdpWG4xSmxiTkVjMVVFTldldDFSNXpLWkEwMzRm?=
 =?utf-8?B?dlczclVZSGFPOCtjM0dWU28yaTVEL0F3ekxVOEFlckQyVXVoRngyMXIzc2wv?=
 =?utf-8?B?eUZuY3pKUFFBcUlLSWlCSDRTUGdkYlF4LzhNQzhmdE1oVUk3RWZMLzl2MVhU?=
 =?utf-8?B?YkNGWUlDTFkreWsxcWh1NTRUZERMNWFHWWdvZ0ZHZHZVSlczZU4rWlFKL3NB?=
 =?utf-8?B?NHlBY01MQ0VDMmpKbGczQlkzekVnSG5LNE9ndUo3ak8vc2d0TkFBQXFvZmpX?=
 =?utf-8?B?Y25NcHZJdEYyV0ZId2k3a2VrTG5vWXFrNlFGckF0cUY3WFFMdWZBNU5hRStM?=
 =?utf-8?B?NlJxY2RxUWl3RXYvM0ZYSDEvSWJWR3NTTzNYMlBUZE1vaHA1WGVlck85a0Rl?=
 =?utf-8?B?eGJVM3RyMWZKQVgwWGJMOURjc2xwYmxzS2Z1aTM2RGViRCtlOFZsTXg4aC9W?=
 =?utf-8?B?VWJzNXVxVTljWWJNS2xVM25GRDlSSHRBMzFhYWprcFltSkZiMCtLQ0JwN1Ny?=
 =?utf-8?B?VHdIdmUvQkxubFVDVzUwOHdIcWlkbWNOWWVWVk1sM1FxSG1hYjNZWjh5dU1w?=
 =?utf-8?B?S25YcVpOYUVlV2dFMWRURm5DUHNFRk1FYlcvT0x4anVYYU9xWVp5SHpFWmNl?=
 =?utf-8?B?UTUzZjE4YlN4QW45L2plZHdmTjg1ZEcvZ1dRTVp5TmwvVmY5RjZCSHNuVzNI?=
 =?utf-8?B?c2JkRWNYN1d2cXRGenVPakJpc2dyWS9lRGk2b3dGdGRzTHRiZ0FMaUhwOGlT?=
 =?utf-8?B?OHBuODJrR01tV3lSZ0NHdFl1ZURWVTk1WVVyT2s3enhGU0ZKVE96SDJEODFG?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HPQoj0SKlGdElHIJoWCF9enKEFKNjSwW5NC7suKwW2w+NVmOWxEn6V49Uq7RiYk2KuWXqFPGw6ZSfDUh1ziYLgdWPjGkVgFgJdPr5CM478w+OZAmZwgjfkVmiUiQ8EhwKJxQT8rvjtl4aigpf50taHZ4pRiucMCP3P/1dtShjvJ7EIb4XyCZqhVICyTeY8XuyrWKnhflQUktFbTKud2PbnzZwrgY6a9pXpXOBQUH3lDYuUHZrn3zW+9OUWAs+hzWg18J9yDlHKpKZVZGTan+FYus2vz6+hNKUsUcAxT+Xke7UPbUMISCJXvo2lxCURKtr2vRnrElIscXICz5ciY+eQZyFzcPa+/g3g0NXkUNb54uqanE6nvZeUj3VkXiSsoiJiyaNETglNSQxw/I/pEcnzWDLhyToOlxGc1IBvWpOQq3C10pOvVUEJtNKsHLfpXBB0p7ZHL1xN5YkoumnvGazqMDMRmQNKMg4xL0XOmgjxoP/RLHNE9RD/33l3D0qsPpXTXVVVieHabb2LhAAlrjZmn7Kzaq57CGxm38tvqMWH03go8+UicFvp1JCn8s3lmQuNSU5npYrMhjpDKZ7FudsFeqVo8BrnnMMK5QX3rDmlc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56bd8815-92ea-4236-c62e-08dc179b34ae
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 20:30:55.2172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELc4TPRiKyX23N4BGYhSRfmgDFjBSoOF5LFubPKFwelANUp09MA/dPdHXghq1ZXUFi5maUrTtqJBMSoOMdN/oVv+q/WXHI3ThAZIxHRrEVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170150
X-Proofpoint-GUID: P5i-xyvCOKBu2W_za45SPXDHPR0HESpV
X-Proofpoint-ORIG-GUID: P5i-xyvCOKBu2W_za45SPXDHPR0HESpV

On 1/11/2024 9:28 PM, Jason Wang wrote:
> On Fri, Jan 12, 2024 at 12:18 AM Mike Christie
> <michael.christie@oracle.com> wrote:
>>
>> On 1/10/24 9:09 PM, Jason Wang wrote:
>>> On Thu, Jan 11, 2024 at 4:40 AM Steve Sistare <steven.sistare@oracle.com> wrote:
>>>>
>>>> To pass ownership of a live vdpa device to a new process, the user
>>>> suspends the device, calls VHOST_NEW_OWNER to change the mm, and calls
>>>> VHOST_IOTLB_REMAP to change the user virtual addresses to match the new
>>>> mm.  Flush workers in suspend to guarantee that no worker sees the new
>>>> mm and old VA in between.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>  drivers/vhost/vdpa.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>>> index 8fe1562d24af..9673e8e20d11 100644
>>>> --- a/drivers/vhost/vdpa.c
>>>> +++ b/drivers/vhost/vdpa.c
>>>> @@ -591,10 +591,14 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
>>>>  {
>>>>         struct vdpa_device *vdpa = v->vdpa;
>>>>         const struct vdpa_config_ops *ops = vdpa->config;
>>>> +       struct vhost_dev *vdev = &v->vdev;
>>>>
>>>>         if (!ops->suspend)
>>>>                 return -EOPNOTSUPP;
>>>>
>>>> +       if (vdev->use_worker)
>>>> +               vhost_dev_flush(vdev);
>>>
>>> It looks to me like it's better to check use_woker in vhost_dev_flush.
>>
>> You can now just call vhost_dev_flush and it will do the right thing.
>> The xa_for_each loop will only flush workers if they have been setup,
>> so for vdpa it will not find/flush anything.

Very good, I will drop this patch.

- Steve

