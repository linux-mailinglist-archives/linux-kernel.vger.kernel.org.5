Return-Path: <linux-kernel+bounces-86189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA5B86C131
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49FF289890
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783374596B;
	Thu, 29 Feb 2024 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YBX/Iv/2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dpIJVuQ5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E0B4594E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709189088; cv=fail; b=MB6lKfv3dtEyttlBgoTcO54nnJ3hx2I1GhBqjHwfkz6OfeYQ16GhinxZAEmRuhGk1cdsOXI52F0xMjK9eXYuH/J1Hw4lzTLysVYHniBtFYv9TjYwpctonN3WeswMg8dUnKyHgCufWBg3DnPts53PDjGqcc7waPUIuzlpAFqq2gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709189088; c=relaxed/simple;
	bh=kLDXLLHf5mMe6fMjTWlo5IdkRVhQiaAk9XjAX+k2O0U=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=WSm5499iOjgV9ZnDAy1NhfPVvPzEkjwEAwhtuxHh5BmhOe36QHlBrqDxBLjScwWTFirnLiqTaePjvqyOcyCqOi1p4x4PedQBBTUY8L5LDK5gXf9SO+rASnEG08gB9oq3lSNgl9XqnqVYSRrJcshy//jptoyYID0GYBNPSjL4fNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YBX/Iv/2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dpIJVuQ5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41T1x0dK012264;
	Thu, 29 Feb 2024 06:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=vDqyXAlxy4iwwagzYvF3DdLNN7pqD5gvRjdJzsUMWhI=;
 b=YBX/Iv/239fo2/Gtw5QGEj8X5+HmMThgp72GOD6esVF/0d6BMeP8l8SwB0U/lyD1Mscl
 RJEz0kTe02TRjsOieHmT9puYosjTt0dsBLnVhnPMh+MWG4vRiFkpddkE4Fkwe5KGVlam
 gd/9bEEPBLXXYIEBfDkIKAxxaQrGa1/e064UuJi+nyBxFTMadzzqkqZ1Yk1eR9/oLW9s
 qgEo1mObPoofZtB7tQ1Fhs7r2o/4Ig+g78i5sOf31akHxjjZprmHXIi6hPTrNcfBInP4
 xLLOOq2Pe8NR0EHyT0qYV3O7peW6/hSVM+XUK2DsSjKOousNPXgg6y/3Gb0eULPVmMGO GQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf6ve4ha4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 06:43:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41T65vng001716;
	Thu, 29 Feb 2024 06:43:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wa2q29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 06:43:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcZiIzE7GxtFoRd8Zxscl81PkcM6giEvi19gQ4tU+ga0MiT38U7/XfwpYnoVn/NlouQd3iEiN6SultlOrCYa0hsjfbRYs+qvjcnq8F2YrVckK/iaHQCxLNhrLnxfrC4NcV5byD9PkfCLb4c6hivZ2BdQFmMPU3sMaIQqfPjK3KX19oC2rabisExoqQfg6Yuwuo8Ch9fWUO1Up9L+nF39/onIh4EgXhMl2b7s/VWgRrW2DCBoYBm1fMeQx5LYPmrKD+mzpyJ3ExBBHvC3rfHw/3MSQWgqPTcxkyMAkkPJAHt3OJxOWbjM8z62VBtx/JUpyjnK40xnKJenI97cf8PySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDqyXAlxy4iwwagzYvF3DdLNN7pqD5gvRjdJzsUMWhI=;
 b=dtbLruDsusI+4npDO1tljkI+k9spdePQ3i7pOKSk6U/Egm/Tp6G8XcLwZwP7LuOzF6UIGUIvvppJtuSEHzhEUqgw+9sRMbsZksL/VoYBtBS7R8IgVLgy4iEQ6iOLDfgqc/CoPVUkG7h0Bo6pU7UJ3/C6AfbSL9ItYvemdZF2jwdwIleKuKmH/bucN5eh+WkzdDkJJsUmyWEQ21EV5XiLEOe+6Qqoga75yAshffmJk8F2PnDhyMJgtbLwnZFqUdrHWZ0txYq9ta7CXfvu5RtMQ/RF+DePbNW3+AaCt38Cne5AfSb+kVSq9/0vtJtkeySbt4WcYZO0RPiYqHiXfHVrRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDqyXAlxy4iwwagzYvF3DdLNN7pqD5gvRjdJzsUMWhI=;
 b=dpIJVuQ5s644b40cnwqsyLERR4SWeucM2kQjJM+HbQgc18hjqcu07tJZwKDj4SqsG2fPi3PU/cboZ9d0o4tf4XH/fEtBx3jSDENr2xeXPZef5motqjaXNn65KennQdFaLjXLaZfk4PnWizjhN5v1U8DKB78HeVg/oXQpiEYU2+s=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN4PR10MB5542.namprd10.prod.outlook.com (2603:10b6:806:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 06:43:11 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::2bb1:744:f397:1d4f]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::2bb1:744:f397:1d4f%6]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 06:43:11 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-24-ankur.a.arora@oracle.com>
 <Zd85iRyY6-zlo2wl@localhost.localdomain>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
        andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
        glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
        mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 23/30] sched/fair: handle tick expiry under lazy preemption
In-reply-to: <Zd85iRyY6-zlo2wl@localhost.localdomain>
Date: Wed, 28 Feb 2024 22:43:34 -0800
Message-ID: <871q8v7otl.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:510:23d::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN4PR10MB5542:EE_
X-MS-Office365-Filtering-Correlation-Id: ccea6f37-1319-40a4-0e47-08dc38f1b246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vz5/a0i/UDDhJ2mG0sCFMSAeq8AdOczskpsNkjUogpnPNR3cGjRkKAFPRCRm4js30n5BBf4SydfjX2fHzrJc177OpXq1g90Hu/hWhFJIIbCeaiptmIY941MpY1wixoOqi5SPoBk4iP6rnF7ufHnYDe0gFOxxdtAo1wQfDwSojSAqfGwf0Io7Mti0d1dhyUE2b0w4cAZeKZZOaKA/RAB4It7TyElFB8krcLvZ3NCqL98k3y+RtI2VhOruETmZfGt0xHz0DTDniZfztgEBSdT2dsKDCC3Q0xCanv5Rgvecc2VWnt1P0CrmmHgS22hKb1BBAPAvLryvV2X6uO6HDpOcRsrJBL9RbJsGp5UcqeA1Nzax70XPL5J2odhelYGw3UoqRgq24+wnpHey4nCkk4lPSEQI5e20/cV5AtSn8+L5jRmSxWRgvkxmE9X1og5r7fqyRDRgBf4WqNYhrwDziBvVG8m+5zUCmSS1HJ2NOoHLCd9n6K6wRuXga9QPgHAuTceUORPWjOMFbfh3uywOka0KVf1XXBmSQZXCjr0IKwwMf5vJkiWQ8W3EGmQQfvOOx9Fx81AJloNmeVanSTgOEQ44StUgu/Eoe2MYeTuZY/PCaME5yQwixsOhBhIRaTZ/LQfO
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?A6vQXNjLdR3ElM3KYAKjhl92HzHbHcnUou01FZ0tgzVG6mroe8ZHZzfcvW1v?=
 =?us-ascii?Q?qkS5roxYiGSE2JcJIHpBUKeK8UG4fRC1Yx1P9IUfJXj1nyVgOyRyhjql1vmk?=
 =?us-ascii?Q?kY+v1PTqU+SV6cwoUb/JbgXtTVx8z214lt7T8BwMf9vT5z7jOB6CyczubhAz?=
 =?us-ascii?Q?kk0t4db3xH6J/gD2cJl5hE5yxr2Hr2ffJGwALBbRfeiIYYRHaD169ShpYO/p?=
 =?us-ascii?Q?e9atMvPA/d96EjWCJj8j/WYTFP/mp5rBzRg4VzdK6qe/FKqiwxKydREA09wt?=
 =?us-ascii?Q?aQPjzp8LnEnucRms+jR7z6UKjxY9Z4cVHWfanU8gDidLNxpmmoKTIQkPzmJs?=
 =?us-ascii?Q?W1RHe+EBIAePfaow8rnvGx557bblhSIGOvSJbX0BQhEcoEzpCOsBd/Ra93zy?=
 =?us-ascii?Q?FOPt4pFNASLllaV0LShmb3m/1LBvZCFPNAhGkEG7d77nOKmW73aosgRAflaC?=
 =?us-ascii?Q?RqUJ7g4zEwt5oCN+PkMd90oe+VXDbFjhW7xwFz6GIaN3ce0JY2a5Jpi3m2zz?=
 =?us-ascii?Q?xX/RGquBRwP30wiBg+9JEt1cVUWiIFuadgFU2UL+7mDFEi045vaGd1P/Q04u?=
 =?us-ascii?Q?AQUjhgyQmcJukTOi1xWVl14NgiTY2H2DCKASB3K5Qa0gATmnBwqFBrGc5Ixl?=
 =?us-ascii?Q?AMshAPN7FuU8MIsADRL49DPKdZRrS3SU7Oi1I/dFisOV4O8oQBBuMAkWzY+y?=
 =?us-ascii?Q?PHtaMtEFiw0MmPMYfXrfcvW1vqc+XtPMr9KQxLQsQ8MQ6r1/ooAC/Uq1/9C/?=
 =?us-ascii?Q?353otDOCZ9WTifYvDa2pzo09mvZkghActueBxuEIcQIyri+78ap3naPCBU6b?=
 =?us-ascii?Q?LJKAJuIKr0XhzqqpGddJjNmVOK07l5KnE8/GXcFyDWnR6QY9Mp00mZFxPrpO?=
 =?us-ascii?Q?KUrJ23jsTVnuiXUqD6nb0pYxy4oUjKChHn1zzCbDG7iCfZWglNz+HedFLL10?=
 =?us-ascii?Q?e5tv9bt2ueoQH7FDQqoG0wi0raA22X7vxOoWwwidGvlI6MYgTn0ehPOjhjb2?=
 =?us-ascii?Q?0xiKt63OisA1UX07NnCrcVSrhjDFn7eZKhQ+1MUWOcWF07Hoak0XlBcDnGuP?=
 =?us-ascii?Q?hIEPufnXkqvqlTXgD8cXWXAIUa4kJ3UdUVK8YaApMo/Tdrusk9L67pnZY+gs?=
 =?us-ascii?Q?1c4XfZu6jlmGbuWS641k59+MJQoTF8zbrBxbogP4r7gaScgemcprfYAi4+6y?=
 =?us-ascii?Q?2t6Hs3MPc8006sXlABs1kCOmhjvK7ppK8j7AxK4vaSN1qDuF9TwFtlVg80Ih?=
 =?us-ascii?Q?wuU6n5/N6t/38/F9KwFAT8WrYwAmSmByLSYGAeqhLDoDMKrAoC+Fgm8EEM71?=
 =?us-ascii?Q?FbPWmgYPYFYofnNPmnrcLx4L7Q3ZiBy8VXjAb9Qa5xQz5bKkrcK+EJSakAe6?=
 =?us-ascii?Q?HQpjfNkTO2A72lnLFea5XSBo4u7OBr71zUtjR6MuEdXLmsXOPuJ5OyOY9ljd?=
 =?us-ascii?Q?wvLm6aVP5nN/t4qhSIeXiRQ2F9Euw1ldi3Q20JI5omB6kP+94ap1vZv2lEIo?=
 =?us-ascii?Q?UGFNAMcWOOuNyOkx5kHmso+9ZdHhkRDwxAgbz4qpTZyrWCfjfUbcT96pEwoJ?=
 =?us-ascii?Q?58yTaCutnugD4wmekibZDF1u9bliMX44KN7YbrzAkELMYuka5bnR6/F0oXzS?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dZ1sgqPWoWmGzvRkSm+ZjFaTqcBBeZjbOImUOKQP9dmzkkXDj8HQGl/gQQ9pNbxuHpTFtAXXbk071u0a7XTwGv/WfgshgEFDvPo1IzdlJ8vrn69mJ/9+ttwLwzNtQG227AE9yetvDH8Jf4Ss6z6UrEeg0jtJPDMGFdjFHRXDpE7Na+hoizYlpsdF+Izj558HSvPBLxWpA8lyCoHC5aBlJa9ZZdGDAsWggMekgOnOABqYRHW0h818AbXr2ZyOQHvGxNrxI3Ot3YhFVxVWfBuKREdUj9A40qGMCFEeRPgZ6anAQAu6IqDoLfQ790KwaEnjLKrYumU/0596LQD6ARPX1uUULmAtExOxlemmNgJqQ5G3+92nXYlGR13KbPlEyfADL8UDPB+y6rjeZb1ERepxMYV06VjEivC1V529w9uUM3qfZ9OqRYZyhO2bVJZ345oFG3DbVozOH+DccDsXeI4EEDV7AwTkYbn8+JNXnkBbglA7RJU6mWfa634JIoHB/s5tDPRJw/gyLBzyiV0ffPkRmJrte6e4vp+ELcG2behGs/UrfCTmPCJdu9QBjF7kElBLIyPDPikNZ870Z8U9ZpNyaPYMCJ0CVgyiykK8Z6CkIXk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccea6f37-1319-40a4-0e47-08dc38f1b246
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 06:43:11.2697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezCBStJ0pz3Ac2YnAUgB71Eah1e4MtNhMv41dhPdeKGouUSrQ5bdTIK7zC863+a+GW8CvrDQ76fv1VGwo322oVsUy8HKGrgSMjvkjZnvoR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=855 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290051
X-Proofpoint-ORIG-GUID: 9ZIp6Q5_p94He3dyngU9oUgCVLT89bqh
X-Proofpoint-GUID: 9ZIp6Q5_p94He3dyngU9oUgCVLT89bqh


Juri Lelli <juri.lelli@redhat.com> writes:

> Hi Ankur,
>
> On 12/02/24 21:55, Ankur Arora wrote:
>> The default policy for lazy scheduling is to schedule in exit-to-user,
>> assuming that would happen within the remaining time quanta of the
>> task.
>>
>> However, that runs into the 'hog' problem -- the target task might
>> be running in the kernel and might not relinquish CPU on its own.
>>
>> Handle that by upgrading the ignored tif_resched(NR_lazy) bit to
>> tif_resched(NR_now) at the next tick.
>>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Originally-by: Thomas Gleixner <tglx@linutronix.de>
>> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>
>> ---
>> Note:
>>   Instead of special casing the tick, it might be simpler to always
>>   do the upgrade on the second resched_curr().
>>
>>   The theoretical problem with doing that is that the current
>>   approach deterministically provides a well-defined extra unit of
>>   time. Going with a second resched_curr() might mean that the
>>   amount of extra time the task gets depends on the vagaries of
>>   the incoming resched_curr() (which is fine if it's mostly from
>>   the tick; not fine if we could get it due to other reasons.)
>>
>>   Practically, both performed equally well in my tests.
>>
>>   Thoughts?
>
> I'm still digesting the series, so I could simply be confused, but I
> have the impression that the extra unit of time might be a problem for
> deadline (and maybe rt as well?).
>
> For deadline we call resched_curr_tick() from the throttle part of
> update_curr_dl_se() if the dl_se happens to not be the leftmost anymore,
> so in this case I believe we really want to reschedule straight away and
> not wait for the second time around (otherwise we might be breaking the
> new leftmost tasks guarantees)?

Yes, agreed, this looks like it breaks the deadline invariant for both
preempt=none and preempt=voluntary.

For RT, update_curr_rt() seems to have a similar problem if the task
doesn't have RUNTIME_INF.

Relatedly, do you think there's a similar problem when switching to
a task with a higher scheduling class?
(Related to code is in patch 25, 26.)

For preempt=voluntary, wakeup_preempt() will do the right thing, but
for preempt=none, we only reschedule lazily so the target might
continue to run until the end of the tick.

Thanks for the review, btw.

--
ankur

