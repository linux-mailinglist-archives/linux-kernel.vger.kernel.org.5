Return-Path: <linux-kernel+bounces-108123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E332B88064A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124261C20B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D743BBF4;
	Tue, 19 Mar 2024 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n3P1ia25";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Tf6s/Mcw"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F233BBED
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 20:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881500; cv=fail; b=a20t6vSFOGq6L3SX1m0biUnFiLqtHjMUj6a3jVMje9nwGj6nbtzm8njHT46Ke2OXGA39Wl3EVxWr85DjpYvi3x3THg63Cf2jcU5ifUvi2dY8ouksgpu3EuXkVi/uIOcrr6UyBtVGjl4yO7By0gyhCva6cczFcZcG+eEZVgsGxew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881500; c=relaxed/simple;
	bh=8DGelfM89CFZXn/1HomZ7RfcqafHA2yG/WCVZSY7le4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m794bsU3t2yw4CCa65gvxHEG8aqFY/hRE6TfPZvc57OFHKBvrYltZ9V7o/4yxz7KjL17VkJlLcnla8j2Si/7rXn8s/rOQmQyJnRAYCb3QphNPAb5nTZQgVckKvas70xtTRjj8w/xFrWAZronTQ9lZwFr8Io43R7d0TRK8HlTiJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n3P1ia25; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Tf6s/Mcw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JJEMCp019073;
	Tue, 19 Mar 2024 20:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=/tsYRu2VHH1DAjfI3W8gNXYGavwuC6Iiz8T0m+An1Rc=;
 b=n3P1ia25svVQ7Yc20hz/ZA+pv19x4pxExx3JX14w8+KSxGrHyr+wPC2qDemZIwI4dHDz
 oMd0jfPbSWmRgzux+O2CeU6Sjj0jSe7pzqlCgwpt4UNRg8F0ryrQ0WtQE4AEXk8sdSbr
 HFFSAMLdVgOpZRDz1MmE262dibWC+rxsL+QRwn9YgIF5YpWt3f/Yz+b+V5MD60nmAMfH
 BH5xV6i3lonCkD/z3/HGiP3O11+tCayMVmob0wHL+IZqWjzEwC5+g0TP8hZvNtOLXCZN
 td27V4zWwswoQdLVdl0Y10Jaus4sK7PQZRzd6gODMW57QjTfIs04ZJx3J+7mNqtXAE8y 9A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3yu6fh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 20:51:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JKgfKQ003788;
	Tue, 19 Mar 2024 20:51:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6uk51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 20:51:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQKdhdqSugO1DLfvtDnsuPXgZJmpJqhwUojeK1IufgquEs7VpgTFkG2q4FEUniNpDIJ+pHo+wLC6IYmdnxq3S+yT6dRFHuvxSXHgilA0WagfhlRTHohou6BuyaK1Kl/UUlwUSvpy5YBRWNiHI+EwrOZLt7HmywZutvC8fuAmlOfycXQWQRpQHK/q5RMTBwqCifngMRGhUsnpXgxIUMCRy3wwd/li7v8ENW3j33SYRIWcnCR7ut6ncMEQw6oU5SBBw7MdpenWr0VouP6pHTnn9ptvYAkhb3mhv5ckCQQorRbmEsYadJFwGywUA9Hp5ff0Ujz9IygNs/QaZVqcHufWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tsYRu2VHH1DAjfI3W8gNXYGavwuC6Iiz8T0m+An1Rc=;
 b=GQ3tuL9DdDwJSqqUsX6LJVEWnLL+8Yacp2QPERx6xKuiwTNwv9bJxKCubI1mXjfp53JV3v74Nj28yrJw9ihaMTrd9b6F6t55jXO4l1ozILHBhZQ1vDxRB8ZRmDbQers3GUVBW08iaebupRhV06tGt7Fh95SPy3xcI7T0M5siPlDj4kybUEowEYqQJ0pM1XNh5eXjUwCyDltQZNPGFZW6WIdHZxb/4pTHbM364cZybN63j0bUuT76BSTYPiHS4W/fQWHLfBieZ2ozPSpjEQtPtlLdMxV5yggwHsAX+VAR3LluF93LwnT0KUcqIs2uqfNWgiNppEusrHCfwE2mx8kMMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tsYRu2VHH1DAjfI3W8gNXYGavwuC6Iiz8T0m+An1Rc=;
 b=Tf6s/Mcw2JPJ9no7C5Xkni/Gj4XtI1D0NTEoOskVFsqHy+YJO4Wtg4xeUtvpyzs7lkrdSqmZe3wU9ycnqq3C6K0gwZWTgQrwDxiE/R8s+EdZcUJ2cuZsZA1Eyzy3QFKEeEoW6YnpmCnMi5z0lhY9Po/2m2XHIzy8/N7EgsTbMb4=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 20:51:20 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 20:51:20 +0000
Message-ID: <7a767645-af51-456d-bf7e-e0038ba38871@oracle.com>
Date: Tue, 19 Mar 2024 15:51:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [virtualization?] upstream boot error: WARNING: refcount
 bug in __free_pages_ok
To: Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin"
 <mst@redhat.com>
Cc: syzbot <syzbot+70f57d8a3ae84934c003@syzkaller.appspotmail.com>,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
        xuanzhuo@linux.alibaba.com, Paolo Bonzini <pbonzini@redhat.com>
References: <000000000000cfd4800613fe79b1@google.com>
 <20240319033941-mutt-send-email-mst@kernel.org>
 <20240319171923.GA1123315@fedora>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20240319171923.GA1123315@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0093.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::34) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|DS7PR10MB4944:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f36d69-84cb-4ad6-04c8-08dc48565462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	doIFDmaoCM03PYRq/iR3sh1M+YmW3laU+P/BrjotexpQDK52t/oCcOCc+xWOKO5SaWKbzjMc4ZTXtAF/kXyM2Ko37oI56AWKmoIq8Ek8VZqKWX8NOEfdKXUIXsJkZiYZ+lgy7GixUY7VBkmdEVWR3+wPTwgApWlRky6rvz2852U/f75sQ2hSPwqpjTpNRue3XqnpoUai6YV/VUye5/dAVQNgkSrm+o+1Y0sUV1o3O0chcqhFOL78gCOhxGbXVN1dH5ndVEA8KtdtpEd2Om57SMZV92Jdw4q/Mbi6RIDSOx0CND2WZ05ITgfWq+a7FhL/UkzBF5Eaxn6mlLPj5Ffcp9wgvqcWKpsjIEiA892UyMgqiECADz2KJDDNZ/i4nNKyamTaggW9P1T6k+4UoPBwGgM4EZzpnKArhNIiT4vZWI7SJek1YGOKcZvdb0/My1N7d28KiJgcG4IR5pxg44t69JF7F4y+2jSla5dx1OrVWyE07eQFqGCSo9sUdhd5WwEatldzFAKdAZwE77u6s34Te80cKkOmBZQUvpEm6cjMuaV0YXU9tr+6Y6BTaTYyNZoqbTOm3Yiqyj5Z9QGkMlS+YcmijtDBENaBSHbIeQONw96flt4DvjgTk+OWWxjylukY
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Zm1pQ0ErcXdBaDR4RG1XOG9uQ2pjK0Z6OGdQZGVYOGNpYWxFc3NDemV5em15?=
 =?utf-8?B?a0RWRythcys5Tld6aS9GMTNYQTR0b1F1ZmMrY29wR1dIQjNiVmR6SlJBZ2VE?=
 =?utf-8?B?Z2t5YXZoYW1ISklTQi9xVWpRY2JFcGEyWVFaUEExZ0hRUWFGNFJKdjNzWlhG?=
 =?utf-8?B?ZU1tbzBGTHhtbFA4K3Y4bjJVWHN1SlhFZDFMQjdjVkRsYk9MSW02ay9WN3JM?=
 =?utf-8?B?TjRITEh6RVYxemxranZFWTV3VzdUVFhSSzZNUGhxRVhaVmowUUxpNk8rRGlW?=
 =?utf-8?B?RDJjTkI3MUxSYVljNmdyNlpKb1g3ZGVDYVFXZlQ5bENtUEpjT1ZXcnJBdkM5?=
 =?utf-8?B?V0dzN0xPdFhPL2pqTENWM21nTHQ5U2ZIaDFMVm5iWFFzM2x0NWJxOCtOZHhR?=
 =?utf-8?B?MjVjNEU2Y29NZzFwKzY4M0gvczhOZUdsUitnUGxLa1QrcTU1dGZYSzNKS0hS?=
 =?utf-8?B?bFh2YzJ4bHd5YTJiNW1CYUtkLzJ1WkpDaDUzYW9xUUo0cjMwVkdtMFlBM2wz?=
 =?utf-8?B?NzRLOUFISU1EM1laM3pjQjJlOTFhU3pHZnEzZ3o5Zk1CM2F3L3NHd0EremNm?=
 =?utf-8?B?R3VnSjNaSlJPbktMb1FKZjFZS055MXVYcE1nMi9SMXNpdzl1ZmdrWml4dTZS?=
 =?utf-8?B?c0VKWGxRT0VPc2pJWHFaZi95NkQxOWM5WWhZOEo3c2hFbmFWeDZHVUtDKzNr?=
 =?utf-8?B?b3BzK1BrQ2JHaWFXZXZqLzQzcGdCUHAvT0hrbDVCTkVwT1lxbmJ5Sktmdmds?=
 =?utf-8?B?R3hlMFZQa1kxcXZNVGxHNCtkNVpCU0ZJWkgyTWZ5SGZ4eHVCZ21GLzV5eDYy?=
 =?utf-8?B?RnRaaTFBZThXWDU3cEF0YXlnQ2lDUUdKYzhzVjBjVXk5MDNPQVJaV0w3OVR0?=
 =?utf-8?B?MS85NnA1ZHY2dCtEUitINjFHVWcreHEyY3B5SUZCRVd2SnNGamNtWXhyRlVT?=
 =?utf-8?B?UGlSeFdFaVhHcmM2aHlZOWJXcUxoRng4ejNudHRQRGpEYW1KRXpHODEwVkk0?=
 =?utf-8?B?aWJ0dnFGMC9QQXl2aEhBamZwM0VRUmlDT1piMVdnS2RzdlZjKzI5R2dBV3cz?=
 =?utf-8?B?YmlQTWFMN0VwSkRxQzZkRFgza0RUeTBsRW9QdDhRUWJMNzY0NDArTFRIRllL?=
 =?utf-8?B?MEcva1FLK0ZTSUkrMm91UWI1OTFkQURnbERlYW5hWDR3YmtYREJ6Y2QvanRk?=
 =?utf-8?B?dWNtMHRPV0c1WXVzaEFyd29qKy9talNvbllLbWZSSVhacVFEUDM1YnFPRVgw?=
 =?utf-8?B?NkltSTMwaUd6dXNBV09Gdk5IcG9hcWF6blBUSEhURlR2THU1eFJRYm9Benl4?=
 =?utf-8?B?UVZ2WitEaFNFVVE0SmZaZlZERWVyR1Q1UFlIeTF1L3dkTlU4OHJoNlZUNTBj?=
 =?utf-8?B?T2VFMWpGTmZNdTFJRlA0N0xtNnZtWEkyK2dNRyttWGs0T3dHSDhvVU9WWE1j?=
 =?utf-8?B?WkJRTDJZV3NmTkUyWXR1bjhCOUVDdXdBRDZJQXc3Si9WT0k1SHQ1ZERRb1J4?=
 =?utf-8?B?eU44MXhVbHhHSlFRKzRONDBGZE5vYTBIRGJGTkdSQkRhOWJyTUM2eXVESUND?=
 =?utf-8?B?STlKK096Z3M2VEFiWFZQeWc2TmZoVnhsYlBrQ1ZqM0JGVEFRT25KajUvV1pj?=
 =?utf-8?B?M1IreDJOeTYwWlR4M05hNVIzc3AyZDNCQ1BlNlhWR3VXRXppSzJnUE8rVUFw?=
 =?utf-8?B?cG1vcWh1Qy9nWkwzVHhhdzk2Q3hQdlpQcS80LzZRbDFsNkZwR3JZMkV6NklJ?=
 =?utf-8?B?QU52aHQxMkt5RU9ycmljQ0lpZ2U1R3NSb2VXMk40NkVtbmQ5dGtpZDgvZE5x?=
 =?utf-8?B?VVBmVTJNMW1hVThoS1YxNTdJTVJTZlFZZWhQaEZ6TEc4RW1UL0E0ell1WUVt?=
 =?utf-8?B?cG41aHZuWTNNUk9IYTdVdXRMZkNXZlBjR2RaQ00zUkJUbHZPUlExSUtjc3J0?=
 =?utf-8?B?ckpzM1JKTjFaeGNJWnk0RVF4b3lNalFQVnV6SmpVUHlpY1pGNXE3VTY3RTd4?=
 =?utf-8?B?aDQ2Nk5vOTJEYStkaHVlZmthUDFJbk16UU1UN2lmVFZWMW9JcUQvZDN1Wkpq?=
 =?utf-8?B?blFLazNjNisxY0h5WS90dHV3TmMwcWRlSm0zMlA0VnlOWE16VkQyQ05PRUFS?=
 =?utf-8?B?ZGtQblZKRGtJNGdLU2VqUVlac0ZYL2FlVG5qazA1a0IvckNuVUMxbWJtT09G?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	djxsg1WLI4LmbsoFw4hurkhFsV1phya/3lHtwxTzyiyc5wexG+I13W9DcB++vSAJ/rRsHtuuoSI4L/RiMvIG3YCq7nPC7E5JmT8YPrLg/eZ0xY2dRJAVQa+7HcUu4efkN1QkaQ/rNF1RnCZqVO4hk6224A8GzFGEgkI22hzvC8okKuVBUxWbldZlQnEuP78ISmZ/gf1Ykcy/T5RCuZHdbw7k/Glom1PcPMKlXpAFM2KXFCDiyYTGPciwuqaTDw7xNppF7OmKQ5TsU/yLhRWPTQkRYliCTk/KTcmCt9bnCi4fPL6mpigeG2PqChT49sL1bvP646hkLX4dI4cMCQagkhYNNDlkzYu9T22dy1Y9HRs6HUqKoxu4sMQCQAi+PL6w5S4f8+hZpmgYbgPtd0ogplDban4hYynq+q2QEzrltnfMJXlEI5mmhslIEss6NxPa6B+WLV+T93c9Aq6j/4Vp+OGNgDYkXgXBTca4glrTBfEouzuLmG9go6RyOFwgK3WvuoFbZkVprJ12PzFP2qtSS7y3olvqHoAVllCHSZLKjnNVTEi5X5B1NOlUkFTac/86+pbutmxYFoW5szQS3kxf/XF/JTlpZJqXIV6YpiaU85g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f36d69-84cb-4ad6-04c8-08dc48565462
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 20:51:20.1706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rB2ZJqlK35FQjZcrkzlHz7Qx4ikqn02d8SLgtSgUw/Z+rj5ZRk4MRDNj3pqIERFBTleYZgXMpHHwp1BJVB33lx+ON2kxwF9slZvHXjm+pz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4944
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403190161
X-Proofpoint-GUID: OPp5W_kBtfObVxoCDlOF77AkSrrTPfsd
X-Proofpoint-ORIG-GUID: OPp5W_kBtfObVxoCDlOF77AkSrrTPfsd

On 3/19/24 12:19 PM, Stefan Hajnoczi wrote:
> On Tue, Mar 19, 2024 at 03:40:53AM -0400, Michael S. Tsirkin wrote:
>> On Tue, Mar 19, 2024 at 12:32:26AM -0700, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    b3603fcb79b1 Merge tag 'dlm-6.9' of git://git.kernel.org/p..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=10f04c81180000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=fcb5bfbee0a42b54
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=70f57d8a3ae84934c003
>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/43969dffd4a6/disk-b3603fcb.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/ef48ab3b378b/vmlinux-b3603fcb.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/728f5ff2b6fe/bzImage-b3603fcb.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+70f57d8a3ae84934c003@syzkaller.appspotmail.com
>>>
>>> Key type pkcs7_test registered
>>> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 239)
>>> io scheduler mq-deadline registered
>>> io scheduler kyber registered
>>> io scheduler bfq registered
>>> input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
>>> ACPI: button: Power Button [PWRF]
>>> input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
>>> ACPI: button: Sleep Button [SLPF]
>>> ioatdma: Intel(R) QuickData Technology Driver 5.00
>>> ACPI: \_SB_.LNKC: Enabled at IRQ 11
>>> virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
>>> ACPI: \_SB_.LNKD: Enabled at IRQ 10
>>> virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
>>> ACPI: \_SB_.LNKB: Enabled at IRQ 10
>>> virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
>>> virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
>>> N_HDLC line discipline registered with maxframe=4096
>>> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>>> 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
>>> 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
>>> 00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
>>> 00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
>>> Non-volatile memory driver v1.3
>>> Linux agpgart interface v0.103
>>> ACPI: bus type drm_connector registered
>>> [drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
>>> [drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
>>> Console: switching to colour frame buffer device 128x48
>>> platform vkms: [drm] fb0: vkmsdrmfb frame buffer device
>>> usbcore: registered new interface driver udl
>>> brd: module loaded
>>> loop: module loaded
>>> zram: Added device: zram0
>>> null_blk: disk nullb0 created
>>> null_blk: module loaded
>>> Guest personality initialized and is inactive
>>> VMCI host device registered (name=vmci, major=10, minor=118)
>>> Initialized host personality
>>> usbcore: registered new interface driver rtsx_usb
>>> usbcore: registered new interface driver viperboard
>>> usbcore: registered new interface driver dln2
>>> usbcore: registered new interface driver pn533_usb
>>> nfcsim 0.2 initialized
>>> usbcore: registered new interface driver port100
>>> usbcore: registered new interface driver nfcmrvl
>>> Loading iSCSI transport class v2.0-870.
>>> virtio_scsi virtio0: 1/0/0 default/read/poll queues
>>> ------------[ cut here ]------------
>>> refcount_t: decrement hit 0; leaking memory.
>>> WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:31
>>> Modules linked in:
>>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzkaller-11567-gb3603fcb79b1 #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
>>> RIP: 0010:refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:31
>>> Code: b2 00 00 00 e8 57 d4 f2 fc 5b 5d c3 cc cc cc cc e8 4b d4 f2 fc c6 05 0c f9 ef 0a 01 90 48 c7 c7 a0 5d 1e 8c e8 b7 75 b5 fc 90 <0f> 0b 90 90 eb d9 e8 2b d4 f2 fc c6 05 e9 f8 ef 0a 01 90 48 c7 c7
>>> RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
>>> RAX: 76f86e452fcad900 RBX: ffff8880210d2aec RCX: ffff888016ac8000
>>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>>> RBP: 0000000000000004 R08: ffffffff8157ffe2 R09: fffffbfff1c396e0
>>> R10: dffffc0000000000 R11: fffffbfff1c396e0 R12: ffffea000502cdc0
>>> R13: ffffea000502cdc8 R14: 1ffffd4000a059b9 R15: 0000000000000000
>>> FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: ffff88823ffff000 CR3: 000000000e132000 CR4: 00000000003506f0
>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> Call Trace:
>>>  <TASK>
>>>  reset_page_owner include/linux/page_owner.h:25 [inline]
>>>  free_pages_prepare mm/page_alloc.c:1141 [inline]
>>>  __free_pages_ok+0xc54/0xd80 mm/page_alloc.c:1270
>>>  make_alloc_exact+0xa3/0xf0 mm/page_alloc.c:4829
>>>  vring_alloc_queue drivers/virtio/virtio_ring.c:319 [inline]
>>>  vring_alloc_queue_split+0x20a/0x600 drivers/virtio/virtio_ring.c:1108
>>>  vring_create_virtqueue_split+0xc6/0x310 drivers/virtio/virtio_ring.c:1158
>>>  vring_create_virtqueue+0xca/0x110 drivers/virtio/virtio_ring.c:2683
>>>  setup_vq+0xe9/0x2d0 drivers/virtio/virtio_pci_legacy.c:131
>>>  vp_setup_vq+0xbf/0x330 drivers/virtio/virtio_pci_common.c:189
>>>  vp_find_vqs_msix+0x8b2/0xc80 drivers/virtio/virtio_pci_common.c:331
>>>  vp_find_vqs+0x4c/0x4e0 drivers/virtio/virtio_pci_common.c:408
>>>  virtio_find_vqs include/linux/virtio_config.h:233 [inline]
>>>  virtscsi_init+0x8db/0xd00 drivers/scsi/virtio_scsi.c:887
>>>  virtscsi_probe+0x3ea/0xf60 drivers/scsi/virtio_scsi.c:945
>>>  virtio_dev_probe+0x991/0xaf0 drivers/virtio/virtio.c:311
>>>  really_probe+0x29e/0xc50 drivers/base/dd.c:658
>>>  __driver_probe_device+0x1a2/0x3e0 drivers/base/dd.c:800
>>>  driver_probe_device+0x50/0x430 drivers/base/dd.c:830
>>>  __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
>>>  bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:368
>>>  bus_add_driver+0x347/0x620 drivers/base/bus.c:673
>>>  driver_register+0x23a/0x320 drivers/base/driver.c:246
>>>  virtio_scsi_init+0x65/0xe0 drivers/scsi/virtio_scsi.c:1083
>>>  do_one_initcall+0x248/0x880 init/main.c:1238
>>>  do_initcall_level+0x157/0x210 init/main.c:1300
>>>  do_initcalls+0x3f/0x80 init/main.c:1316
>>>  kernel_init_freeable+0x435/0x5d0 init/main.c:1548
>>>  kernel_init+0x1d/0x2b0 init/main.c:1437
>>>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>>>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>>>  </TASK>
>>>
>>
>> I think I saw this already and also with virtio scsi. virtio
>> core does not seem to be doing anything special here,
>> Cc virtio scsi maintainers.
> 
> The oldest commit that syzkaller found is a memory management pull
> request:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?id=e5eb28f6d1afebed4bb7d740a797d0390bd3a357
> 
> I can't reproduce the issue locally with QEMU 8.2.0 so I don't have a
> way to bisect.
> 
> I reviewed the virtio_scsi.c git log and there have been few changes
> over the last several months. I couldn't spot an issue in this patch,
> but the most likely virtio-scsi commit is:
> 
>   commit 95e7249691f082a5178d4d6f60fcdee91da458ab
>   Author: Mike Christie <michael.christie@oracle.com>
>   Date:   Wed Dec 13 23:26:49 2023 -0600
> 
>       scsi: virtio_scsi: Add mq_poll support
> 
> Stefan

I also tested the current kernel and didn't hit it.

In this mail:

https://lore.kernel.org/all/ZfKPf_pGxv-xtSPN@localhost.localdomain/

from this thread:

https://lore.kernel.org/all/37cb2e7c-97f1-4179-a715-84cc02096083@I-love.SAKURA.ne.jp/T/

it looks like Oscar is saying he has a fix right?


