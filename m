Return-Path: <linux-kernel+bounces-68936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6F7858216
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4EA1F22E67
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ACA12F5A9;
	Fri, 16 Feb 2024 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AMlZtNen";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zDSSdSx7"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883A728E23
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708099369; cv=fail; b=jXLKXrJPHQ6oNNGNnejO80YIR/ZzUepPofDj1jXe6KiPn72nE2ZwJI0M0kpq8/vx5J37pgVxPY5zSD30AE54Wjs99qhOpQNQZQV+MjfppLpMMVZjHAKFmqy6iAZ+qNONfZKSXoARWyGhAOcIaGbx6L+cKYDcqhz/ryCmV5k3dUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708099369; c=relaxed/simple;
	bh=l7LQZ8Y8DYKMEJElYu0oHNv1S2exJfO2inNATsqHbSE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O3CeE8raNrH8rVzHDH7OebNGsFpjlwo1FTUmF47nk4R96Gl7EA9oqaKxknCpRLXUTfHUFGru/WJCfYnXmlC0AUe+xsJ5dpY4JzvxCwzH2O3/xtvZH8MpQ4BNTNHTE82hhI9UguPFxoe1hPX37nZb9qKNbOjkw2XGUm10lxhXaFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AMlZtNen; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zDSSdSx7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GCrmAf001584;
	Fri, 16 Feb 2024 16:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=GsVL4yw8RHOltzAwuUw/Mw2TlQKdcBP8Wzec+w9L8nk=;
 b=AMlZtNenlRAa9wQUlQboTELPqneD1BnLqMblezLj7c8vh8BD7jfmwmNHx4iH/YotV2WK
 55mMKoVaDfWz3ubNftmEj5AULiOaoPGhRomXX/17hVRNYetSkv3wQZ7ZZWo+s/82oupE
 mZkOp0NkQerlsg4NVYB4Rc1Ey2v0mQpwjppLJu2V+cvcvwKvNx9NYW9rhVtFDGeIwBf0
 p2hp/lEruUxc+Jx4tGjhqPCPHn3JnrWvQHKOMyWbKs4ZrS/bZVrkdsmx7q+h1tmfsPzY
 dHIkCmg8rgg7rIKNNLdiW1dshDuRAL3bY+DpGq0/wz+Jsih6KKS4pX7hJxjsNRb+VWb3 0g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w93015f6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 16:02:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41GF4hEX000489;
	Fri, 16 Feb 2024 16:02:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykcbync-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 16:02:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqfaU1aS2YThIJ1k40G036TqabkAvdzzH/Ner8VxHju0burCX1D8dDnbMoKxtEoryd9o2Dllc3jC5uiCfqKYT5pd2DATLrForYxE1xp3FVbdiSjJpp8B/M/QVtxvxdErAG0ASZGJUz0+g297u7cE/tHq2pkSpYr8vQmNMkuYJeni4PaGcW3dqxRtO5JP6AlnL52ldhWRZiMyJ/ETHLi07EfZH52LK+FeOXZr4rYU+0Ocdq0YA5npVE6rsgKIpDEV6oMurI3LpWZwvjoCa8GROC85RrE0441Piydy9k1QTglviVYj6q/W13jZ7B8G1pMZpaECIDzU2abrzNbsPo1HyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsVL4yw8RHOltzAwuUw/Mw2TlQKdcBP8Wzec+w9L8nk=;
 b=GCHE8r9iRKeRTEuijLmrpClVLij+wRhMZWcwBdHDCf6ULAKyfeRW1ksqzS8JxX1XOokLRMYJWeXmZVKFnZ1eOMaA/lgqFN+j6BmmagqVTRtwp2mKALQjguHdsTlERe1s8hacFo5ibcydRxQ80ScMTD8yJnHIXP5P8HSjSkwpXHzibqzMvEeOvjPJPfP278VC6WuXB0BENfQCh0bLFhwGlgQY8+KAn0qaVSroCqJ//mMK6OojNB0Cbdnl0qFF3ReaKAYGUit0/x4XqRc1nVkeXuppG3eNeKd7nmIPK3s94Pp6GNUxFgpQ9yESD/T9LYza9NtXZ5gjFnZbYQUlaa91aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsVL4yw8RHOltzAwuUw/Mw2TlQKdcBP8Wzec+w9L8nk=;
 b=zDSSdSx7h+LkU40+03UAxNBZKocqaTNjEaUmgHg/wdG5+wHfuaEm0FoEj5FYn1rBRR/zNJl3fUUlKkUHdyr0hsYeJgVFSm+ISbuw2a82nTtBQ9gB6RsvNImPEZ34TSH+JxO3PSOUKlzKay0XXoluGo3E6LWn/UsP0cmrA1bYzTg=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by BLAPR10MB5025.namprd10.prod.outlook.com (2603:10b6:208:30d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 16:02:28 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::212c:c0ad:d364:3883]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::212c:c0ad:d364:3883%4]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 16:02:28 +0000
Message-ID: <ae1c5559-4469-448c-87d3-ab458c3c8b24@oracle.com>
Date: Fri, 16 Feb 2024 08:02:20 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] printk: save loglevel before console_verbose()
Content-Language: en-US
To: John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20240216005128.1045812-1-stephen.s.brennan@oracle.com>
 <87eddcsqzd.fsf@jogness.linutronix.de>
From: Stephen Brennan <stephen.s.brennan@oracle.com>
In-Reply-To: <87eddcsqzd.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: RO2P215CA0027.LAMP215.PROD.OUTLOOK.COM (2603:10d6:10:e::14)
 To PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|BLAPR10MB5025:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ce76c7-2329-44d4-53ef-08dc2f08ac98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gfjlufwCkNwnCK2yD6e4cM2Xwj+qG9+BUqpLqmuVvN2MUnp5/HBuBBRlWmrQI0ibNpLb9MwC8pWTk0kJiOw4cyXfkYdwcat9ws3jG5I402OuN6A0YapMYQ4FkkeYq4+nLTDMboowtzDDrv35zKunYzJBe84NlKoFS5QCMxnAp8EK4PLtRj94RWr5qBZjw4kM+XXUQDotWOV5H+N1L8kzeMp6puAN08wR39aADEAjZ53Q38cew9BoX+1LLtAMh0JmK+rvhRgb6NhgWrLkAxdHayrA7AKOKCxbA/1Bu4308i6m+br8Xy2Vd6YP2PJ3YU2beyQDC0qOWDdU8e/76r9AntR0mT8ZRfov8rEjPPxPNH/jqflyGOxNAf0+MmGmrY4fUJLMr1ikXMJancT+2wxeGsW/mS5VESY0IxzZNpKZiVmbgwupLqv2tSCGqaazqQhTPaG4f96MJbp3lww5tbwredqnYVdR7Cj+SLJ8ld3g6ApLO3Q1llAGlx379sx/t9c+8XLDD3/n8iDDreiXbAmf84c+np1Kzv402bqS6lsYKwQHDLQ1HmC+8jxhQIH7z/vg
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(8936002)(2906002)(66476007)(5660300002)(4326008)(66946007)(8676002)(66556008)(31696002)(86362001)(36756003)(53546011)(26005)(54906003)(2616005)(41300700001)(38100700002)(6512007)(6506007)(478600001)(6486002)(316002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L0VYWUhYMStxYTVOanFkUWhGdU9GSVVQYms2bURLazBNTk1pVjR0THM1VmQr?=
 =?utf-8?B?SkZhQnpBdm1ZZ0NqeVVCam9iV1BjcjkzS0VRamhEcjBMSVJJWWZieGhNQ2tP?=
 =?utf-8?B?YlkwVkw1aHBkeVo5SFM1Uzc3RHEyM3VzQ0hWT3VMU0hJaWIzb2NWOEc4amkr?=
 =?utf-8?B?Rnp2ZlQ1ZnVUMDYxbUNIemxGZ1VhWFQ2am9mZytEN09ZYVBpZmgzLzdJNjVu?=
 =?utf-8?B?a1Y3RzBuSzAzYm1qVDFXZE5yUVl1QzYrWEtjelVBR2Y5b0VPbkxRSVNJcUZ2?=
 =?utf-8?B?ZnB5NVh4NWJock1mOFhHS1k5OGNPeDh4L2xOT2VWM0RRYUtYbmcvNEpBZVl1?=
 =?utf-8?B?RmprWmZCK2xsUk93RWo2NVBnelZSVHRxY0k4bzlTNFlLZXZ0Yk1qL3A4RzU1?=
 =?utf-8?B?TytnVURFUGRTbmIwS2FaWC8wRGtuOThyUnB1bERzTHJoOVhRaW44NzVqSkMz?=
 =?utf-8?B?L052NzE3NUMrallkYlVjd1p5eURpN2Z2bW52dFRRV3RqcldNaVBMNW1hVTl1?=
 =?utf-8?B?THA5S09BNjJMMENaRUxsTWdWZkNvcVZudEs5bFkzdUF2UjZQWTlJeURCVUQr?=
 =?utf-8?B?cm1VcE5JTHZTeFVPcDM3WlpXb3Q5N0dOTDRMYnF5eGphQ0RDSW5BZE1HVHhJ?=
 =?utf-8?B?LzNrY2t6d0dhN1pmRHgvOFV4NkJHUmFKR0dQUDBiTlJBa0hubmFqMWs0a3pw?=
 =?utf-8?B?OUErK1M4anBYK3dLTXJkNmV1Qm0rZ0pRSGNLZE9sMU5DOWRlMW1GTG5IR2Fl?=
 =?utf-8?B?WTllOVVHWUM5ZyswNFF1d2ZWcFhvREFuREthZDE2dHhqYy9RTHZpQUY1Ly9x?=
 =?utf-8?B?R3Z2dTVVRG95NTRJZGRxOHVpeG5Od0ladXJ2SVNMVXRZeDB6dWtUSnNTWUhT?=
 =?utf-8?B?R0NHY2RyYVRQQWR6VVgzaHF6Uld6QWx4Q2Y3eGtHWDhTc0ZHWDJLQkpLci9L?=
 =?utf-8?B?U0xKd3VnSWtCNlNwdS9lMzlRWVJWU0RnaHIxdThtSGp0WVh3LzdWQUZ1WTBn?=
 =?utf-8?B?RFpDOE5uenN6UEl2UVV0QlpTSUJyRWNzYWNkOVVSaDBHd2YzMXRnaS9iWmYy?=
 =?utf-8?B?M0lCQWhhVW9DRWEybURkTHk1bUVsUzQ4Q0l5c2VheTlxKzdmUEU4L0RDRGlz?=
 =?utf-8?B?dXZlTkdkSXVmbldMdFJHbEtZTGg0SkZBdzZpN1UwUjAxWVJLL1RPSm45YXZB?=
 =?utf-8?B?ckhNcDhVckFrOXNIQVJvbzhKbFdtaHdJMDBaNG9qeDZaNDQ4RXNwQWhSdWRz?=
 =?utf-8?B?NTBKY05TL3F0YVN4cm81NjVMWHpYTlJpN1NScFhtMFhVQUJ2Q1RSdm5jWU5m?=
 =?utf-8?B?VkhleHlTMXc1T3Z5MVlud1NUeUdVaUFESkROUllFYithYjFRM3dmbFNHaXNt?=
 =?utf-8?B?aThjaVZMNFpkRU9YVmpJSm1OTWxWcGRDUTJ0Y2cwTGdpUW1oZGkxQ3VodjRI?=
 =?utf-8?B?elVhYStTcHhxVGJOSGVta2FvVUZBd1gxM2NTZnk2L2xtR2cydHEvNUY5MnBW?=
 =?utf-8?B?MTQ0UEl3MjFPaUpPVlhmZTRRaVV1d3hZWXNQQnorME5sbHdwdldLVytQMHhF?=
 =?utf-8?B?SjVQeEdlUUI3SW9wV2FFSnNZSTlMamljYjZwRjB2QmU4TzYvMmpvdVpBbjJi?=
 =?utf-8?B?WGlWcFIweGl5NlpHTjlpNkUxZk1kSmhCUDVyay9xd0tVY1RLSS81dEJaMERt?=
 =?utf-8?B?SFZUQUh5Ri85WlMwU1Z0SnFWaG5WenlsaTJtOWJKUDJ6YStiSUxQS29BWk10?=
 =?utf-8?B?VUtlOFR4TEs2eCtldy9tZDI5enZ0Y0Q2Nnh6WURGR2ovZVpyNDhwcndqSjNh?=
 =?utf-8?B?c3ErYWpUYUhFMDJPZmwwaE9hejh4MnRaU0h6N2NyVDdPWmgwN3hUZG1XanBP?=
 =?utf-8?B?eTV0NElrczI3Y3FYSno5dDRWUEZXck0wWG9qME5YbTVIMXM5S3pNTnptWjds?=
 =?utf-8?B?S09wOCtSSHFCNHRNTmI0NytyWlZyTWtLdFJSeFdkdG11SXViT3RvcVJMZzdO?=
 =?utf-8?B?dWNoRTVGNzlpZ3B3cllOVVJabkhzYU1UUE5iS2MwL2toYWpWY0NLam13aWpr?=
 =?utf-8?B?eXJ6WktoSG1HNDN4RGtET1QwQzJ4L3Z5cDI3RFhka1YyUXZmQ0JYcms1Z0hp?=
 =?utf-8?B?TUNoQjQ4RWcxL1M1N00zUlhKZVhRSHo0aGg0Q3dNVzNab3hqM1phVUVsR0FH?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FbyL5EA+3Y50nJBBRDHMvj9lFL5Ilgp6gWJCVIBcfowq6phS9nwzwMCe6kOxIhHbJ1moxhI4BobYLDPgOBeEA/mkd560NlbQXZDYfWiZIRWIH43p4ubCLaY3T/jXCQkejfZaWogIr3rIPTQXfbXvcF4M7kXJpgw1RCox4lgz6KKZf3gxUf8yehd82Z0F6/HT9gzOFTJHVRc6RESG+dFGHmKzux6M6xQ7cv4aUZgBVRnxhSCUgHBKRV68ZT85B7ejNq22VsUNeXkgPY8ph1l/T11Gy6IqqjIeh8yCW3xGwEVkUEcc6l4+N8Cq9cXoH8pitqd2RZClwEFznITOsl3Jo0S0dwBfIJzpQYv2QCp9DjlJsnnZKJHh/iY5vK8P5ZRJ2aLiLZBTtd/3ht4tSJLkrmCgMC+SpsK+V9/iXNrWrrqCCnV0rUjsvaPwny8pjrLxfjBook7w2tF8XH5VkKYWiK1sGetiXlH6qvyORxeiyE0IzvVBYzBd4kFwTDaSjPq2dNSfn2cj/kcORLVnF6PH5T9oKFFEt9Lm6hfcziVhtR8guUkbmPklYLkLdyiYwGuGQhuWYV/89RioVzJ3pOlt9BZI+gzxnppAoIZB2wI22go=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ce76c7-2329-44d4-53ef-08dc2f08ac98
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 16:02:28.4640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOns/K9E/V04PaDf+M4kGUkBzz64psY2UyRveqjeXvvj95rqjdunGzoMScM8iSg50m2JubNccqshxozp7ZjK6imyZDmLZqOWwNpFRkrBgyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5025
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_15,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402160128
X-Proofpoint-GUID: TwC1LaqjTbMUVXEJVIyiI56JSpZV0VtO
X-Proofpoint-ORIG-GUID: TwC1LaqjTbMUVXEJVIyiI56JSpZV0VtO

On 2/16/24 01:22, John Ogness wrote:
> On 2024-02-15, Stephen Brennan <stephen.s.brennan@oracle.com> wrote:
>> In panic() cases, console_verbose() is called, clobbering the
>> console_loglevel value. If the bug which led to the panic related to
>> printk, it can be useful to know the log level prior to the
>> console_verbose() call.
> 
> I've done a *lot* of printk debugging over the past 6 years and have
> never had a case where this would be useful (or even interesting).

Hi John,

That's fair! The point of sending it upstream is seeing if anybody else
uses this information or if I'm the only one :)

> I assume there is some rare and particular scenario you are trying to
> debug. And once you've debugged it, it is no longer useful for you
> either.
>> IMHO this does not warrant adding an extra global variable for all Linux
> users.

I've been seeing bugs (to be fair, on older kernels without the latest
printk/nbcon work, which resolves much of this) caused by excessive
printk logging & slow serial consoles. In some of these cases, the
loglevel was set low at boot but modified by an application, so it has
been nice to know what the _actual_ loglevel was at the time of the
crash, which I can use with the console baud rates and the log buffer to
get an idea for how backlogged the console was at a point in time.

But of course, the console sequence numbers can tell us how backlogged a
console is at the time of crash, and you can infer the log level to some
extent from that. So I can see this not being as valuable generally as
it is for my use case.

Thanks,
Stephen

> When Petr gets back from vacation, maybe he will have a different
> opinion.
> 
> John Ogness

