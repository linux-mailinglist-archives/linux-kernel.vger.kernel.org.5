Return-Path: <linux-kernel+bounces-97215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E80DA876718
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765B81F241A3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BA81F932;
	Fri,  8 Mar 2024 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="bYTa402/";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="bYTa402/"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F8F1EB3D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.82
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910730; cv=fail; b=ggMy6VxglYz+QQkpqMYj9ABbYpbmOyJxeJ/MMSel7vaBIywcLGB4sDFwh621+A1mufGQ6zeSKVMp2bILiYTLOaIJRKRi0aca8U2ddgA8G5qtk2Bd+Ug8jE0jYyGdgw0CETva+rN1/DBsZ9bIKSXWRU461YfsspRxVRefXwZATr8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910730; c=relaxed/simple;
	bh=LCzQWX+VmHnkjkSBJvnGfNNpSWxShvDCcLjMkolGLB4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nEUPXLMmeRNB0uxiX+1E0HO5yBm2GaEa/fWxqtvko4eu24fPvCJPGQKa+12QeQ1uba2wZK1ZVDMp5Aj2tc/xQIFFfl+7BpU9O1QXHZ5uwm+9CaCrMCzAyTWTN7WBx75JDJv8E49ZXzL/SFOrV+07AZdPG2DXWdpBwUm+4PzzKxA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=bYTa402/; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=bYTa402/; arc=fail smtp.client-ip=40.107.7.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=QDnpFJ7zjEIX3op1TaAsPBusozyAdP7Re5Zm8c8JM24hYYZ1HxeYTCby8A0cWqPcS1j5EQKB+X/fvOixrIy9AN2PiYtIy07KkMJ5O8F7ZeIjE3Skz8nppklOD5ENqAHvZyKWExVSIKoZhBE+5wklY4jAw9bMN60e5fiBDg8fkIfroN/g+1lvJHeHvxbQrE9r7zjLWakr4nhB24Q7XmO8apufZ7HzAlt/2h2+Yndxojbwlnv6zkhKmhXmmMqlc7x7GHG2r0QNLFfEXrA6DeAoicrVSVLDImatsbeWA+ZzpvD6zEpIvEk5ZCizPkApiDgnhTLc4oOSrY3eeedUxsqQHw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRTU7Hf9iiyCoNVyYsxQJ7HkD/ExztVOU3Uy6OB5I+k=;
 b=TcZsEsdTCCSi9wPDLmdc7MBzFWqqebzGeTroAZyebWWTN8bgzQj5u9POm/LQ/TjDJngOKcpNNzXgz8U66DXIUovCrPYYTuOLUN8/qEcBK9BGF1okCU7xllH/eYpsWNyPF+wZvy6/+1F4SbZyFIft4myGI1dfcrm9m7IeFYZsbJiB8nuFTPnBVu0FVcth5s7o2JBDAW1UoEaORTEyVcxp8oO5IyAmW19/pvF1++Rn/68x7ofxcuGk5KVLpa5ouExtSrFU8uiYo/uBQBpKkNuhlhRSvQBcT3Gz6kwUgVm3v8hIkpJQevm6JzVa8c42Gx2BqITSHt6xwjP1r3zhaIuL4g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRTU7Hf9iiyCoNVyYsxQJ7HkD/ExztVOU3Uy6OB5I+k=;
 b=bYTa402/97wjW5lMoJSqSgUGNZ43nuZm2aZ6Y9YnZ68UFj3j3N1OlXEh3jn0Ut4mzlHiBBOeWTI0Numt4bS62BVxTzMh9yDNmu8HJqUmWmxn6fZ0txZS5IlBuSuurqY+8Irx3eUVQdRuwBVhfWVsOAMpdgy2V9esAPp74jzK/cc=
Received: from DUZPR01CA0325.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::22) by AM9PR08MB6082.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 15:12:03 +0000
Received: from DU6PEPF00009524.eurprd02.prod.outlook.com
 (2603:10a6:10:4ba:cafe::db) by DUZPR01CA0325.outlook.office365.com
 (2603:10a6:10:4ba::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27 via Frontend
 Transport; Fri, 8 Mar 2024 15:12:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF00009524.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 15:12:03 +0000
Received: ("Tessian outbound 456a16a4297b:v276"); Fri, 08 Mar 2024 15:12:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 55ca06f6e54ed1af
X-CR-MTA-TID: 64aa7808
Received: from c45630eca286.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 12B2F33B-342F-4A14-B8A1-25CA89CF68F1.1;
	Fri, 08 Mar 2024 15:11:52 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c45630eca286.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 08 Mar 2024 15:11:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGvqymfeJlwMcVTxIAXqIaPpUR9Z1TQRMeKKdG/9rjdu8kt18DxR4BhyI35bYoB3pwuHbRM+aKsWbhygJlQjWu+wroiZYvxeeeoqwxQvB6VjRT4DfYUAGF0+bjdAxYotwRuGnwe30tGfoMivbPZvEHoGwhqkRXxcwP7na42bzDbLCX+d5v2P44VtKXZVS4j2ToLugaZYTW7p268aViFlE+5s64Wwp0yAupElv5RAyq3Ohw7ZjzLzE8TG8YAMqiCSo6ooTObEuSWwLH3Tce64O34LZlvbFwFBe891/o3PxVW7BQSpJk2N51BKfnHdBSxzVEcncPiYqkhxJkmDRyt1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRTU7Hf9iiyCoNVyYsxQJ7HkD/ExztVOU3Uy6OB5I+k=;
 b=coe2wDce6WYhVANSssNR8SXta7k+jIb17scBNntN2MjgItbRLhwD6dcX719LlacqMWpg1Tnn/MAtLfWzPA8O2iB6s6sP5gAFCb/6eDMQ3OOknpw79uYR1Kwytm5Ecj0zRHwfiAgLMlwR8YUa4BrjIsCEqQZqb40RiKTPBflT0CqlrVauzBGdgA8/u6e0lEZlD6Z4zTGcGsCLqLZBABP9kgvSfe4oh05+8VvrV1IIKyHq0r16avWgT6OHpebz85EQxaDVNUhTHyrBSfbSxlmzvF/NiyEoxOv3Flk7+Ywuok1b63Yd+eYjO/KiVB0tkzYR+rpJcjbDNURT2md04bB+zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRTU7Hf9iiyCoNVyYsxQJ7HkD/ExztVOU3Uy6OB5I+k=;
 b=bYTa402/97wjW5lMoJSqSgUGNZ43nuZm2aZ6Y9YnZ68UFj3j3N1OlXEh3jn0Ut4mzlHiBBOeWTI0Numt4bS62BVxTzMh9yDNmu8HJqUmWmxn6fZ0txZS5IlBuSuurqY+8Irx3eUVQdRuwBVhfWVsOAMpdgy2V9esAPp74jzK/cc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by PAVPR08MB8968.eurprd08.prod.outlook.com (2603:10a6:102:32f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.28; Fri, 8 Mar
 2024 15:11:48 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::363f:3fc8:fc36:58ed]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::363f:3fc8:fc36:58ed%5]) with mapi id 15.20.7316.037; Fri, 8 Mar 2024
 15:11:48 +0000
Message-ID: <5a32e8e1-67cf-4296-a655-f0fc35dc880a@arm.com>
Date: Fri, 8 Mar 2024 15:11:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] sched/eevdf: sched feature to dismiss lag on wakeup
Content-Language: en-US
To: Tobias Huschle <huschle@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, sshegde@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, nd <nd@arm.com>
References: <20240228161018.14253-1-huschle@linux.ibm.com>
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20240228161018.14253-1-huschle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0115.namprd11.prod.outlook.com
 (2603:10b6:806:d1::30) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3919:EE_|PAVPR08MB8968:EE_|DU6PEPF00009524:EE_|AM9PR08MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: e172a55c-fa3d-42a8-935a-08dc3f821c50
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 /0HRHlroZ3WUl/gY3PFxlNR9tCwV7V1GUSCv9hwg7D807vGN8dcGnnLixNHFQv2GCS02bZVSB6WjoNYU6KsBwDnPk5RlHiPkL9HzFfMNr5+a9sfAhf2YE59xcURy2V4W2RjqdielNfCTRGSG3Z4XyB2tBg/v74YuqGGMXvGxFUdnJJEAOS0Ni9Oua30yz5LsymXcRvj9uLM76QWcRFZQAhUVWFem8TlSWxfc8opd5QFf3/m4lbC4uOcFf2dxHxSZmGl3TAIEbXbW0rR2n8RgXr3kUw3YKdqIqeeJ3m2lcdFJxTxDJqLHzZndIu22NTUD2ZYT+7g9KJPTQzzCPv88quBftckF8FRxLbTXiszWvcM07Vr85t9fpZL8Nh0BWUvaJO0Pft7As9Kt33PFcTZ7FQtpdqPEXhcBQmuy/WhUcIT9tbH6zB7VG/wJhlhjBvegRh9DuKbilwJHP045BPjUlIvmwck83sH7esT5ojhv5yzi0ssmLApHI+c3xTzv0ISaMmNxkbMUG9UG4PDWy0c9L4sVIl+sN1bRz9MR7AtMYqGUZgK+hVAM6PMwr4DPjfa7wPJQAbduA1VOiRL7IQXjJYu/UH2FCNGglMfNaOdfbic=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8968
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5c576016-3956-419b-bce6-08dc3f821339
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LVTYQPgeJFohz/dRHCkOgHnXj+uciZ9j9HYZ5wW8FWKzAeNJQ0W1NzNgAPd3GzRmsHtMsrxqPJnUZ7O85uAspw/vLxZ8ez3ZsN2S1hH+CjP5PDkjZhnFbhUjkuriQ23+hq4W+A2djvLgnbXCQP3FuQmQLrcQ6WtV/fCuPrDc0HjWlZpHBTT32ZF3vVYg3JIrqL0/HV0crf/i2QppubfuLfOleBHz/HRPxkTgMzolPoljIMFMMwZIoP3n3lQgOUHpbEzE4jtfbpLm0MPiaTcnnwF8voIWT88bKHtl+Eg6Vhux46lVQjKgf9YCRfVGdAhevbZesufSz/GlJmv7ELfNZ0H7caPFMbzI5SZMMcBjF/okU2TsJskX5GoTShp2RNdt8Q8BKVGm9JVg9OkAN4VI5VDLF9IuL0OiWyrPvcqTkbeZKrribsQ2OpZ389BbAjnpKqLKVP3vAy7GgIpvwAuDwPlxO3QFMw02whE40xJepGlfkZDLbo71i9nKu441ksWYLwLSwTV7JP2E1O7Z/5GUQ94Lb5NADBBesnlJj3Ooji48ElPemcjXh8E/v6DThoxqtbyvUyt1QLb7Y/mdXSktotrM/IxLSPiflX3BG43+Jx+r6sZ4gqynCrXZ9phT+pQfM1zB154Ut685KzbcMWiT66CTvclp30axXGwxffz4DCKclL7BE4MWChYLqMP9BKvJvscIMCDUZ/mvfZhMkux8KQ==
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 15:12:03.3108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e172a55c-fa3d-42a8-935a-08dc3f821c50
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6082

Hi Tobias,

On 2/28/24 16:10, Tobias Huschle wrote:
> The previously used CFS scheduler gave tasks that were woken up an
> enhanced chance to see runtime immediately by deducting a certain value
> from its vruntime on runqueue placement during wakeup.
> 
> This property was used by some, at least vhost, to ensure, that certain
> kworkers are scheduled immediately after being woken up. The EEVDF
> scheduler, does not support this so far. Instead, if such a woken up
> entitiy carries a negative lag from its previous execution, it will have
> to wait for the current time slice to finish, which affects the
> performance of the process expecting the immediate execution negatively.
> 
> To address this issue, implement EEVDF strategy #2 for rejoining
> entities, which dismisses the lag from previous execution and allows
> the woken up task to run immediately (if no other entities are deemed
> to be preferred for scheduling by EEVDF).
> 
> The vruntime is decremented by an additional value of 1 to make sure,
> that the woken up tasks gets to actually run. This is of course not
> following strategy #2 in an exact manner but guarantees the expected
> behavior for the scenario described above. Without the additional
> decrement, the performance goes south even more. So there are some
> side effects I could not get my head around yet.
> 
> Questions:
> 1. The kworker getting its negative lag occurs in the following scenario
>    - kworker and a cgroup are supposed to execute on the same CPU
>    - one task within the cgroup is executing and wakes up the kworker
>    - kworker with 0 lag, gets picked immediately and finishes its
>      execution within ~5000ns
>    - on dequeue, kworker gets assigned a negative lag
>    Is this expected behavior? With this short execution time, I would
>    expect the kworker to be fine.

That strikes me as a bit odd as well. Have you been able to determine how a negative lag
is assigned to the kworker after such a short runtime?

I was looking at a different thread (https://lore.kernel.org/lkml/20240226082349.302363-1-yu.c.chen@intel.com/) that
uncovers a potential overflow in the eligibility calculation. Though I don't think that is the case for this particular
vhost problem.

