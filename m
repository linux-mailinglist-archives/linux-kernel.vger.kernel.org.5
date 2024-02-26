Return-Path: <linux-kernel+bounces-82036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0337F867E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C80E1B2AB35
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80999130E5C;
	Mon, 26 Feb 2024 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U3DCCN/p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s8kz8f7j"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F68127B4D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967652; cv=fail; b=BqTBMnAdQof0U468G65s2mkZDn2W0g9CmPx/hxCyMFGdfxlZFaHHsxey06Y/3AHPxaw1Xl2nHCzJ9szaU9pZ1S9vRZOI+Log4Nx9jbSyG5tXPMBLeRifuF+onBOAmsZYqx6qIW5xKDRN7zvAU4r2bX+eFlbtdYK91WwcQai2yFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967652; c=relaxed/simple;
	bh=vtmqVh3gLNwL1dj3LFjVNqawiOLbMXTtbPfAxKdLaEk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t/E7XfaR+YyOs/990BTtmfgRaBMEaKWSSVo/L+kmNQNL4OyFkz1FWIcAOZDMWy5LN5X6SPHpoUFIVA6cksswIHC+nAUSumHPDZ8TxkSOyZBUhEogda08OWijhOOOXUgAXzI00BSOcwc8T2EDpuJ1Oe5jZqC1KjqgSPJtKA83zGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U3DCCN/p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s8kz8f7j; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QGmiqH001393;
	Mon, 26 Feb 2024 17:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=llJn2vk59Ga6kxGGyL9JPrGfjvZDI121Nn9UMTgvYt4=;
 b=U3DCCN/pYGtH5E8apU9PRfP9hI3DNu/BKpaQUxbwWFbpkjZlOATF1y494bN0FRFR98i1
 2+2hev0muBxwmx2Kbz1yUrIXh7p/OaNEL56O3SMr0y2crYKh5ZMbRSFvx+tCKrt7ueAX
 LtX3OgsgLQ/ER+eahyXmIOqK9K8+upPq7P66prraURUk4CRROPVvcKHz8Bhep+G/m/4Z
 ckMFQTRLXmoEDB/uVGL/9P1NWEfyXhbU6/W0CEtPKxjkKm1iWVUlENJuzkpTsUhklB7O
 +taYbdoq2IAure/aDZsTnxvfP/SH3AtHIqL4wUK+U5ehGOXa1D4w/L4xX0kbe11bHbMR dg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf784d8vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 17:14:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41QFtZIg025513;
	Mon, 26 Feb 2024 17:13:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wcc55t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 17:13:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3wDkBAoMQleKfLDadcOyER+iidGr1eNo+wwlAxLFD6DpgkZEDTtPLK3k6sAdE5BOOurG3z3vrV/5O11Bl+CE6W/CnDfI74GvL4atLNaliObNhFk+wPy2LOvvidgSXsKdCj3VBIyBDkD9292tQFngI+PIMniKcE6Xtrb1iILMJKPxLUFaJaJJ3Ic/SXo2gaYvrCb5ZRYcgEL2clMf/YmtObtFp3BpFbV30WL2EBvdrb3NZQz9Ez5fvwOqRlGuQ3HDpfa8jQ9Vv4OTWVVHtPDyBRMVLHlWizz4M7qG5d5ehMajNlS0nvSVn1u0Ovzah9BIoQMU6JK2kzZoeoLtaCyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llJn2vk59Ga6kxGGyL9JPrGfjvZDI121Nn9UMTgvYt4=;
 b=B8LYWcPngldr5/DMxt+xH1+tXyA2VaVnWXfpeWuGbvlOlErAfJa26eqkgioywm7eQMAaLCdwYbuQ6L9AHrHK+PgIFdd3ATDJWNOIVc6ANvBYLoSUN9YuptDAijFI2HHwScJz/QSOnCwmW6ureKUPC4LVBBz0ZxpmxJNB6HNXhL+jzOuApZdHmLNA7+7T1Mtic4nZQuO6aLrD8r+MsXmcm9pCNSOoL8O68Dy9AmDWhG1PWgyn7yMa1fu59gHiaIdbaxCwc0pciVEIK31K8hv3Fn/gZ3iRhvbiRDOu/6MFlN3WV54BonDspYUff6a7fa9EV31+mWrg1n+t7ud7lOd9ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llJn2vk59Ga6kxGGyL9JPrGfjvZDI121Nn9UMTgvYt4=;
 b=s8kz8f7ju86T/jhOaXFUNsPnrgDVnqkYfUegQV2W9fewACrMOjpmghXxfqkJX0uYvZpuEJnp8t3nRdGRU7jkWWx38GY3nSkfEzznhfUG6QEcij0b/RSOi/vBCd4MH3UfO7YKM8pngN5ppQAI2IQWriFpBSh2aTpJsa2lU3np0LU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB4818.namprd10.prod.outlook.com (2603:10b6:208:30e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 17:13:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%3]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 17:13:48 +0000
Message-ID: <cb0c185c-54f8-4b43-856f-685cc5ed3fc4@oracle.com>
Date: Mon, 26 Feb 2024 17:13:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware_loader: Use init_utsname()->release
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: russ.weight@linux.dev, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org
References: <20240222145819.96646-1-john.g.garry@oracle.com>
 <Zddt-U-6SdxkxqmD@bombadil.infradead.org>
 <51483aaf-d64a-4eee-b256-ab126483ad6c@oracle.com>
 <Zdy9gKO5Q6K4IE8J@bombadil.infradead.org>
 <ZdzGF9bxLn3Slbgi@bombadil.infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZdzGF9bxLn3Slbgi@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0088.eurprd02.prod.outlook.com
 (2603:10a6:208:154::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB4818:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8e2893-9927-44ef-f159-08dc36ee4baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KO8645MwWhrh+0NhpIJlIu4Kr0MVfvyUVP2Hk7GQQG6XvXmzPNs+QA0sCp9CmjI93XVGvep07DtHWJ16bLUrDUUa+OHHkyW/dTdR417hXj1bIQWM0WR9bW+SsIQXeL51HdAr0JJQ1PQt6aStLfmpZrvLzaGr6RRp50LgV3g5yptNM+dG8u2rTrW2fE2bie8atvF9Tea6XqBG5V9Ha7ZQWpWVQizu9VUOiwaB1hGnJ3SgqcwBRabTatef3PpIEZrxjm8BJ8Aq3gdjA/KBG0zFuoivD6MjNV+VeknL+sDGKgimEDkSA3y9iix4hhhsaP9yHwUiq3cr4MtBJNna3CWq20RS+Vddm7mYify+VE7sIsRbP2iZn3bZVm1EGTUKcxW1Wc38y/28i9UWcZifR9vw6PYzof/zXzAQwQxXU7bswganHfKRHtiTeLqlqTtTqYYXBWObuu2DyDNk4cPJDqIlY6yTNddqQh4rf+3znshSrR8Qr5j/B17aKWA6WJ1RkEaE4ZuNs47eJZH00qN8M6rcLTo3DlAG8KhoZnJwXqc+SZtnCVEmJRh5VoT5JpfvDXOf/YeoX68bz1MTWNMFoQ2wciAPBNXy/iXiKXQplzfonwWlSgEjmoTAP+w84dfSg3Rx
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z1dWajIxTHM1TE1WVnlhZXp5SVUzS0lMSExkN3VDcElHQ3J0VnFXMGVtWDlk?=
 =?utf-8?B?ZDg0QmtjLy80ay95ejBLZjVuQk9VWi9lLzdJNjF0M09QK2FFZzMyb09sTjQ0?=
 =?utf-8?B?SVJpMG0vcys0Ky9LYXpBS0wxcHlTUFVtb25tN3RRejB0Tkx0bXhFR3JjaGR2?=
 =?utf-8?B?Z3JqUlFSY0R0VUFoclE3MnRvTUh1TUZ3K1hUNEJTazlwTmdNaUFXWVBZckZR?=
 =?utf-8?B?OVMweXVCRjZxWHJFQXRBalJmVzdQR0J1K1BPUGRJZXl2cW1hVkVPNVNiRjM0?=
 =?utf-8?B?aFVQcGtXdUE5dVpIQUtwUlhoVDczYkxIWXJQTVN5WnozWkFTUWx5T0NTdURO?=
 =?utf-8?B?dGgzSFdHb0hONm9aQ3R3VUdtdDNSUUw2SlZsM2ZzRjRabTVIdjJ1cWM2WWh0?=
 =?utf-8?B?TGRPVEE4dHR6b1RPUnhkUWFTTElSczd3ZmYraWFKcVhwUUthMzFJT0ZSM0Vm?=
 =?utf-8?B?TnVYOUd5ZlhyRGxGVU5XcTRpVjJ6VkYrUXhmU3RMYzExTGtSM21tVmYwb3VZ?=
 =?utf-8?B?WnN5TzAwUW9Qc1FWa0hPclAxNlRxcDkxMVRIKzg3TXorMFNWcWxuNmZ4YVJ2?=
 =?utf-8?B?Q2JIeGN1Y1dnMm85NkNXZXZlalNNcFBOdkVJd3VLZUtobzV5bDlpL2xBWlZC?=
 =?utf-8?B?cEtxdTlSV0VnSkRydVJlczExVTBuYzE2OTllMGM0c1Z2VFUxZ3RvYzZBMDN4?=
 =?utf-8?B?TE5DNFluUjhsNzhtdUZraFc3aUc3S0tLZ0NqRUZKWDF1WlMxRW1kTkNETDVW?=
 =?utf-8?B?Y2wyS3hsakdKUmNzckdER0c0WS9YV0s0UHJqdmU4WmkyK0VBeDc3ZHpmUk9R?=
 =?utf-8?B?VVRaVWlxdHczU0dXQmNNbmdYU0RXM2tCUkpPSmNoSVdzSEo5T3RNYjB1VjlW?=
 =?utf-8?B?R2tzWWxpM3Fxdm05TS9tQlpWYWMrMzN6Zlp6bFIwYXRNMEgzcUlyTW5SVXJP?=
 =?utf-8?B?WFVqZVFxYUY2aVFraFYvOTNvbEtEd0lLV1g5WTRzaTVLMVo5aFA2OEVBYUlE?=
 =?utf-8?B?cFJQTytBR3F1a0owTG1RYS9xZDAzSlNtcUVTK2dhYjJoMGFjaDNYd0dpRTcx?=
 =?utf-8?B?KzFrTmFqWWozeVRIRG5ldWsyUXdtK3poNjlBRG9RWWRsczRKdlRZMTdWZVFT?=
 =?utf-8?B?aitOOXM3ZWQ1QUpDMVc5MTU0WDdsbklhYy95VnI4MERQdjdiMnFGMjBsVnNL?=
 =?utf-8?B?SGJLK3dXWWhoMndraHdUWVUzWFRaL0JndGg1c0xmRHJEWkQ1M1BLbU40V0tV?=
 =?utf-8?B?RE9jSFZFRU1XQVl0dll3WnFqWUo0MnpQeTdRbG53WHpLQ1ArUGZBSXdDNFMv?=
 =?utf-8?B?V2FNcm94eFlxRmFGWXF4S0krV1dJbmFkeVdPT2o4WlY4VGhXVlZxZ2lOMUFG?=
 =?utf-8?B?TWRmVHJxQXk4TnhsWnQvOHYxL3FGQmRzRTRCYjk3UVlhdUtnMk5VeTBTVGI5?=
 =?utf-8?B?S2xhMFhXRFlnZ3dLVE13OXZwWmJIMENkQVNkNDFKNldJNlZMZ3hncnI1M1pQ?=
 =?utf-8?B?cGhBdUdRWXNWL2Fqc0M1V0JKWE1aZlJ3YW92RW9TeTM5dm1UeFRFRFduZi9x?=
 =?utf-8?B?TlpPN2MxZWF4cTZseGVYODBZWXlqejFwM3VBZmpiUTF6bk1HY0UvOGNOU1Bu?=
 =?utf-8?B?RThaMTNoaFExQTBHWXNCRndjeW5iWGxFWWF0dGt3a2tkWER5YlVOZFFXMDAw?=
 =?utf-8?B?UUU4c1NIRU5KVjl3RzVub25maXpodHJJdHF2QW83bkVXd3hnU0E0aFg0dG1n?=
 =?utf-8?B?UjZZN2ZtOTRLZ0dQcDdpZ3MxMFhGbDd6cStZbzB0ZU00RElDTENSOXdWZ0dQ?=
 =?utf-8?B?OU0wc1hQNkI5eU93YXVQaVdYU1hXa3BITUdMYXlnN0ZKdlZXMEprYVo5MFNS?=
 =?utf-8?B?MUkwQmsyWk5xa0xZK0VQMnBjclRmdDdCc2d6YWlEK2g5VmZIY2VhaUROYXdS?=
 =?utf-8?B?Q21HMGtiS3lxditqSlF1Y1MvUGpCUDZUaHNVMk1tbEhYL284K0VuL2tQOHh6?=
 =?utf-8?B?cFVNZ3cvOFQ4cCtzVUQybEQ2Q0ZISmg0QWVGZVhVei9XYk96SGFNV2pxQ0hH?=
 =?utf-8?B?aWczQ2ZlYWhXdDByR012MmtOMTdvR21FR1M5dU9sUkJ0Wkg0OGhwcFhUMEFK?=
 =?utf-8?B?MU5yY0tRaUZmT0Z2cnVEb0FCaEI2VHh6ZC84U2xwcDdKOWVVQ0hCb0FmTkJm?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vRMobYM5yhLRoy7AkzxpKeJul5+rgUdWGCIUihuapmucJGdvx/q321Wnvr79ijhtIF98nvVIrDoCAH4ZBhxj84tJNMtb3fJ1URczJpbSgHDbZZKVO/GaNoeGBKxeiuuNdbRF36YGgbflMcC7LmZ1Q7UW4srkkP8td/tco3jVc3Ia1KpUVv7sUK207QIdwJVEg4wP2KPRTzLztrLbblunTl5Ld0yLGvtuc5WslouwnMBW+wZpNlpSwQYtnPTmzv+JDdrUrWqXPhE3DTl0d372yE4JKmLhQW1yIs5+L+VjzW2bzzWvulI2XXCN+TOkaKL7uUCH7VCk32k+Ug5OSIghO4zlhcIapk8gAcGvaewSLWm7R+VeKRKRc2Tv68PqUbkBPxZOiZ/b1gVqAUNfFQRCOClpsLNr9WV3HhNmIR6odjy5MBFaj/DLs1sbhO+cRUPND42mRd+hByzQj2xKGWLxz8wEc00DjvlTepGdUWDtFdpELhVRLmrTRZOBA53mn4MRSpNNQSYdL9aundexhurUZAAnlFNKYjzq0I5gr6bOtpJZep+7tEpgJceUlZMAJ7SLyJ4FMPPOp/Nl12gLPx5K2OK5/fphdBzOoC3DrjWtmk4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8e2893-9927-44ef-f159-08dc36ee4baf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 17:13:48.1652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJt1rWqoe7IPqI6cmkP7XlcXmqhpCkC/AQFmmgpSVjbieBtDnVi1k6zLoYlaoZikpUIRyDRi44VJal3SM39khw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4818
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402260131
X-Proofpoint-GUID: JA7KV-dm6XGiKaCpwkcv3aJWXaiKBu36
X-Proofpoint-ORIG-GUID: JA7KV-dm6XGiKaCpwkcv3aJWXaiKBu36

On 26/02/2024 17:10, Luis Chamberlain wrote:
>>> I am running this now, but it does not seem stable on a v6.8-rc5 baseline. I
>>> am seeing hangs. Are there any known issues?
>> I tested next-20240108 and so no issues.
>>
>> Lemme upgrade.
>>
>> Note you also need /lib/udev/rules.d/50-firmware.rules removed if
>> you have it.

I have this:
ubuntu@jgarry-ubuntu-bm5-instance-20230215-1843:~/mnt/linux2$ more 
/lib/udev/rules.d/50-firmware.rules
# stub for immediately telling the kernel that userspace firmware loading
# failed; necessary to avoid long timeouts with 
CONFIG_FW_LOADER_USER_HELPER=y
SUBSYSTEM=="firmware", ACTION=="add", ATTR{loading}="-1"

So I can remove it.

> I don't see any hung tasks on next-20240226. Perhaps its with your
> config that it is triggered.
OK, I'll check again when I get a chance, but I am not so keen on 
checking linux-next in general.

Cheers,
John

