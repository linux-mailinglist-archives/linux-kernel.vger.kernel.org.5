Return-Path: <linux-kernel+bounces-61850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9D385176B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873B5281631
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41FF3BB47;
	Mon, 12 Feb 2024 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eE9lfEtH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AgjiC3+T"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BB93BB34
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707749805; cv=fail; b=N07lZl0Z/9w1Xeo3wo/cP8ezT0fpJyX52mEuV5mNCLov4D9BEnfOiupSkDOltGonD5HPidqTsDnJtvNUW/unNdfUTVCAz2v8XJ+KnVkAC5U8vXi8lOybBfefAsEvrtIjGplbIVZWcr+6RMOtA2lmBw8LOq1D+7o/sIQTECCqp4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707749805; c=relaxed/simple;
	bh=FQBad7r1fk2vkPQT1u4QGErT/GMh6ifwjEhfAGIq+2Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VfssEpYjcSl3OB0DLOKjHNNxwYTd7e5VRXjSkupEtajmgHV+WdG+CnIAlL+vYrZ+95N6EnYLU8G4jyuV3v9q340Pn+GILAPEJoRNlTvINfdgyDvzhzLKg8PrixQtMbNc/Rwg0GWyo/5IDLJxYugKxFK+4f0Gb88MD6VY3zs/yaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eE9lfEtH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AgjiC3+T; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CDxN6s013941;
	Mon, 12 Feb 2024 14:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8dPqU0OCU8EDM7Yj/Z8Mg9eVyIpkwE2BUyttyXdaL9k=;
 b=eE9lfEtHbvZShPukf88TfhHHu9Ma/wPFXSqCFEK9/JX2a5GXVzzGcPqD7Q9QwqVyDxMM
 aV9mGBvt3ZNwIgxuSUpOB/ute0ev8yyjsVEJU1LSDlkQIe6w0IXw4rqcUZAzMpdbN6UT
 QWY4VlmfkkfurIoTPfr5DEB8aXXYyMM4zcQjnn9z6MYKkRvU4HHiq3HdlI5eKcsE51cW
 Fh+5KOCsBp834GPzL1M2jbOWFSlxLVTQS+ngM/o8l19FvftX2jtvwIW11rG9+ubknr4I
 Amxo9nlm2ibt5ZXtnwRqVtwxFK2de5pXdLh9+EXSdRaEaBt24p3UMFzwXpUL+yuJey0a Og== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7mpqg48d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 14:56:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41CEacMh015051;
	Mon, 12 Feb 2024 14:56:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk5vc2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 14:56:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E77HzVVo5g3IZ1MczyXZk0nG01R9cuBpVdAnIoKtmfVi9DkpuODnQcQ1K/2Wh/eMLxJ4C8sSm4AK9/Djuf9ftpwg0eIbRMx2MDLevwLv31RqF2OwZMptw+PUxfeTc2ZhU0X++vmHqbex1ww3AwqheOMBnpKOgXLxJKdBZt6cNoaBn+VLfiPIlzDMKHgR5cicK4Ah8zhRSd3PaDYdyVLGs3JoEJ3poWGVLrcHK+BrZhkreXsmU2BrH+MnEYChil2uy6hRVBeh4IVxB+8ooXIsKSBny8AAB6syEtjFK2UrmIj5isHLi3ZpCbEO7/tFm5oAOzbWKIVwG6IWBoAUltJO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dPqU0OCU8EDM7Yj/Z8Mg9eVyIpkwE2BUyttyXdaL9k=;
 b=gA/PnC2mUvSa+ID38Cx6pnXnDG6MXN9hwCSJ/UFCJrnbTXHbrRiyA0B/O8+ovW+1cSJrEdUYXGXIKt2EBrRPFblQIoofG6KmBtO9/oWfYRjMNBeTWcyiL6c1llOOPUadx5axBEGdLP34p1InNgLyOLwOZmNLjM16P/LD87G6gsCKPcVqHm1xl70eRKuWy3hQYNF0exTIm4zv76wF7y+SmQJ8SMUik+bKUQRv6+WHErlXj8ZfTsop/qZPpAft+QlYxM5aBIbfGQLBnrPCl0udfXECgvb4ygjuuhQ4VPb1kFjMeedgauv/sm3Y5GYBi/GWDTeJekmvQWq6SGztrPGq0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dPqU0OCU8EDM7Yj/Z8Mg9eVyIpkwE2BUyttyXdaL9k=;
 b=AgjiC3+T2XqdZ9MeEvBW2x4GJZ+G32j16KKrleGrU3qYgFWpmgxWPiQ3m2m+yDap2GoffNSuazamTABE5bDrfolgB7WrTEeq/yp325X2Qxaq+E5W8kdyKmCedgOkgqLmxvopaXxV6T5cdU0XyvKcjDWikZIJ5lec0pofHBw6lbw=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB6352.namprd10.prod.outlook.com (2603:10b6:a03:47a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 14:56:36 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7270.036; Mon, 12 Feb 2024
 14:56:36 +0000
Message-ID: <a4d2626d-7d74-4243-93a9-01d7adc8cda4@oracle.com>
Date: Mon, 12 Feb 2024 09:56:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] vdpa: suspend and resume require DRIVER_OK
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <1707517799-137286-1-git-send-email-steven.sistare@oracle.com>
 <20240212031722-mutt-send-email-mst@kernel.org>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240212031722-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14)
 To SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: 6614a214-2194-4139-f42d-08dc2bdacf31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aRmA//3rcHFsvcaq+cOfUQYz99I7g1aMwW6rNTVnCh6KHRb4ia6w+AQEEa+lonlGCKevsYrRym8ZRzu/cU/wSHW3l5xwUJjDVEfPcs8jojn3yjGIeOpInDz8yPg8GTS6Jkh2jpc8VkjGq8PEINQz7UiPTHIh/CogpivR43n1At39zvV8VdsHW4spNTY3ZBoH5FboT+OowR32Yvd8v9fX6rUo7hmKiWF7LNecRVkj99A67/uQVZMhPtMVPpR+NwHMCptjwNX1bS2zLsjgdcukCsDpv2ZYTY0OKojazwI4q/MdyWCQV+KnQCpmgTkp0NO7kZxE5ffTcTqLr0N15bMEku8GXWjKCPJH2KHGoTwLa4w5cPkAsRBiFQtI4NqliNBGstqTumjfABbpSV5jBeQoEFz+3iiQZz3dc7aAwde7g23fHKK94PF2OmyW6dW5XstpOFCHcH9kB3PGkywNibkCc/ngY6Z8BFH9GfhjQRvL9qlKD4KK9hUEuYbSjN4JUtbsTOxtUN8/tKp3LcM2wzsa1U48slTBO/hzJvcFIgqGS6sWxF61ZJaFT8eu/FHJ/uZ0
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(86362001)(31696002)(38100700002)(478600001)(6486002)(54906003)(66556008)(66946007)(66476007)(6916009)(6666004)(316002)(36916002)(53546011)(2616005)(6506007)(26005)(6512007)(36756003)(5660300002)(41300700001)(31686004)(2906002)(15650500001)(44832011)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b1FnWEhJdmVGNlh6MElCUVo3VUdPY2FGcXVNOFo1bFNTRmZ6VlBqUEIvOHBs?=
 =?utf-8?B?TS9TUDRmcmdkalZXZ3RSVHU4aVl1YmQreldpTkVLOEVqM2d2ZDY1Z21Ib2s0?=
 =?utf-8?B?K29wNVpNd3lFdlU5N1o2VXZwV2VTRUdSVjRkamJpSVNJZlpYVXc2OXVLWnU3?=
 =?utf-8?B?bml0dmZISC9QRS81NmRWcFlPM2JyTFpqak5sejhXWHNNYXVLZ2hlTElCU1ND?=
 =?utf-8?B?MWhiSmJ5RVNBbTNCTWhDOE1jKzM5eU5vK3R2Wnh6RWxwOXpnc2p1M0R2Ym9H?=
 =?utf-8?B?ODErZlhSR3VLSnp5ZDJOaUY3ZFhaWWViTkxrZUJIcnJ5ZTRleW9JZVIyWUdM?=
 =?utf-8?B?TzVUMHJ1SkQrUlhuc1gyUndIcVRnR3FxcUhXTnkyenBrVVpLcGlLWXFjY3ZO?=
 =?utf-8?B?VHdRVlBSSm9wSWxjcnFTQVNuN0VwTFd2NnRHQy8yb3ZMdElTOFRJRUN1em1W?=
 =?utf-8?B?TVVJdVVlZzExQ3YzU1M2b3dhNWpPSGtIbzE1djZZY3dYWnRWTUtGbUREL1hK?=
 =?utf-8?B?L2tMZ1FJVk5QUTR6VGlOWERXV2xsQ0lMQUZ1cTBVOUdOdmpqdlJHb1pmYm92?=
 =?utf-8?B?SHYrbHQycEhJVDN5VlV3WmhkMWpNaTFPSzdXdk5NamlMR0pqc2JDSitUT2N1?=
 =?utf-8?B?VzZHakhvTkRvbmU2UUZET0piUTArRWpmeEZ0VWZrMjBPdFR2N2ZRcEhycUJi?=
 =?utf-8?B?ZGhMdlRKOHY4bUgycW1tZHZHRkVrK1NKYTFTUi95eGhwNmN0V3B1dTkwZVpV?=
 =?utf-8?B?a3hiYnVqQ2dUN2M1Qk9YaGlQblNrK0trcWpDZFY3UmhHVktRK0xnMzNZUkNn?=
 =?utf-8?B?dnd1NVg4d1Z1VzhHcWg4OFloUWhVWFl0bGg5dG1oRGdiWUY2dXh6R0dWWEJB?=
 =?utf-8?B?bE9BWWxYL1h6WEpzeVAra200U0ZSL3h1Q0tQdzJsNzBBeDlMcExGR2RqOVZW?=
 =?utf-8?B?ZVhyLzJXdHZrRjBBRTdtQlVsLzllQ29FbGMzdDNWZEhaTmFUaFc1SW1ZYytw?=
 =?utf-8?B?dEI3ZzNLdUFxbHNCNW9xR0NlcHpnWmRUTW5lLzZXdUpRc1BONWVYS2ZGY2lo?=
 =?utf-8?B?Y3hzeG4vUDJTbmgwMUhUcXV1UG51U1VJWDlXbmRGazVlcGlOQ3BpME12bXNs?=
 =?utf-8?B?MW1pRkl2M0ZlNVJodXRla0c4dnpZTGlaUWFFUnZvalFoQUhxbnN4dkhHajht?=
 =?utf-8?B?dHQ0S1E5R0tQRkVCcGhEbjRDRDNJU04ycTFqTEJVdTFya3NpWEM2dnp4b2E2?=
 =?utf-8?B?anBRSmRwM2F0TnF4Smp3UUJQdFp0REZmL3ZDZzc2bHg0WWNPRXp6eTJtM29h?=
 =?utf-8?B?S2lZdytqUlZ5WEo2OTdmMGVDeHZjVTRGd1NPUFFGMFpkNXlEU1VoMXpZejU0?=
 =?utf-8?B?WWgzRUlZVGhxOCtUSnFwT05DcW8vS1hPMHRlNHVCQldlcWVVemNYc0VGTXh0?=
 =?utf-8?B?bUtHcFpFVlZ0WG01U1F1cHBJUjBsUGdvSElTUHNQOG40aG94OVVsblZ0aVpW?=
 =?utf-8?B?d1lKZWsxWXpKTG9acXFnS3RSaGR4SmhpMlpvLzZ6dTVWemYyZWNZWGFwWklz?=
 =?utf-8?B?TjdZSWc5VnNDSTBJUkp4aVFTYXlaZFA1OGtWMGI2R09CeVlyWndQMjZFUTlh?=
 =?utf-8?B?N1NicjZ6azRsV1NkNitNU0VHdVBBdTZodFFkdWV0aUlRNEdwamxySWV6blFO?=
 =?utf-8?B?Yjh6NUdNb0xveVhRUmM5SmQ3dWMySlZHQTA5akhWU1ZOYWd5OUdzZU9rdWto?=
 =?utf-8?B?a0Y2WkJYV0xuWWRTa2Q1R1hIdXJDdVZVbk92eVMrVWN1bWVpOUlRTExkZ2pi?=
 =?utf-8?B?bWhadC9WOUZ2V3VIZ0hicUVuVlcyZExOR2Z0WUx5eC84Z0dVTkdyNmhoWnRN?=
 =?utf-8?B?VVJhbzU4aUhBK1BkYzBDTXd5a1ltVEgvQU9STnNvbFJWZG55SjZxdzZWam1z?=
 =?utf-8?B?cHp3aUdxQjBaaTdzWGFITU1NQkxVamlJY1ZvQWNObWh6UGZFbEJsVm40N0Q0?=
 =?utf-8?B?d2VFeHQ1NGJva3l0OThHSGQwMEg2MHN4STV5NUhZQ0cxRU1qRzMrbHp5ZmZ2?=
 =?utf-8?B?WmJ3amJ2V3pMTThHT0dkYm42dnhhQ2x2NkJXTWlZNWIxbngwazN1OTBOdWpS?=
 =?utf-8?B?QWE5bm45YUdrZUtqSEwyWHRRVjk3L2J3RVpOdHJvN1k0ZzhJdXFWMjZxenI0?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1/D68Vg6EAFaj8XIjOPboAOjZlnYs1wsDLO6W4LhoByqO/l3WpC2jg1OnWahESvFWYmSva9oZakhocbxt9qzCRfz3OZ8Q1O+xxXx6TcMIwCHrmTE0RBAaseMH2IodVwCSnpzQzCLlsIPE1cTRvMFh75xRjr4/FLoSy2EBso6i+wcnYZla8ukyMmXFoOAD9ZL/HDmOWooPLrI4mZZi+4UYI0f3kUx6oNLmCXfV1t3re15vcSVQwcludZV4SMT+FPiMFtQOHPXynyveXGgcKnTRc0Wv4Wo0fsWXst5jqfRIPtfFEaa+UMWkrzayTWLbgIL0NHB82VjWZmIGU9xOY3Q2fqQbrA7p515jjkGENnXYBejx07NoOQ0Zl2jllvT9J47Vv9yoDSj9XJNszY+GoM96dCdpFngYf2TywnlHG18feQyd8oG7QfJ8XLg6oKj5+jVwL4XVW2QD6p9vdYGozcgyMUqON9A5MX1cbyT6dSI2C+nhtLR3l/IGEbFvi51WBhT5le2vKsea6mPs9erX3f/FefV61nrMj+Hp+1QQKtbgVy91f+v3eQrUa98/PrnPghM/V8N10sTyV/aij9zhA6ZR78Jvyjn0G0d3Tg+YQY4ij4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6614a214-2194-4139-f42d-08dc2bdacf31
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 14:56:36.0249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkYcka4AKHr3gZZQUZtzqbII0u6nZa8/ZqdmSeczwCqcfuG4Woc1CmvisoiYFcabBSZ/MLD+xPw70SgmP76yjj0YqA6Lrx6V4jfeevutpX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6352
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_12,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120113
X-Proofpoint-GUID: 3K56VeA2O8Wh2SvJ4fvy7a7BkZw8qdA5
X-Proofpoint-ORIG-GUID: 3K56VeA2O8Wh2SvJ4fvy7a7BkZw8qdA5

On 2/12/2024 3:19 AM, Michael S. Tsirkin wrote:
> On Fri, Feb 09, 2024 at 02:29:59PM -0800, Steve Sistare wrote:
>> Calling suspend or resume requires VIRTIO_CONFIG_S_DRIVER_OK, for all
>> vdpa devices.
>>
>> Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>"
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> I don't think failing suspend or resume makes sense though -
> e.g. practically failing suspend will just prevent sleeping I think -
> why should guest not having driver loaded prevent system suspend?

Got it, my fix is too heavy handed.

> there's also state such as features set which does need to be
> preserved.
> 
> I think the thing to do is to skip invoking suspend/resume callback

OK.

>  and in
> fact checking suspend/resume altogether.

Currently ops->suspend, vhost_vdpa_can_suspend(), and VHOST_BACKEND_F_SUSPEND
are equivalent.  Hence if !ops->suspend, then then the driver does not support
it, and indeed may break if suspend is used, so system suspend must be blocked,
AFAICT.  Yielding:

    vhost_vdpa_suspend()
        if (!ops->suspend)
            return -EOPNOTSUPP;

        if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
            return 0;

- Steve

>> ---
>>  drivers/vhost/vdpa.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index bc4a51e4638b..ce1882acfc3b 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -598,6 +598,9 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
>>  	if (!ops->suspend)
>>  		return -EOPNOTSUPP;
>>  
>> +	if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
>> +		return -EINVAL;
>> +
>>  	ret = ops->suspend(vdpa);
>>  	if (!ret)
>>  		v->suspended = true;
>> @@ -618,6 +621,9 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
>>  	if (!ops->resume)
>>  		return -EOPNOTSUPP;
>>  
>> +	if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
>> +		return -EINVAL;
>> +
>>  	ret = ops->resume(vdpa);
>>  	if (!ret)
>>  		v->suspended = false;
>> -- 
>> 2.39.3
> 

