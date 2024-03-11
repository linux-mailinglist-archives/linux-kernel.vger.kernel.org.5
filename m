Return-Path: <linux-kernel+bounces-98462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 539D5877A77
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77BDE1C21400
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68329F9CE;
	Mon, 11 Mar 2024 04:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LEVCIN2i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EcdvMj7+"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABD0F501
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 04:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710132700; cv=fail; b=u2Cb2PlKnOsnz8zmo89AXM0U4lHodpfs8BuxNVRWyPdE9cT70qTbUpDimB56SxuDRO0pbt5qxzUeOMN7AvPAgQUPBkcMf1qFv+ocoEssuNCwiC/j0FGljwwFBQnMHJMNwidu+n2Eg3DWp8VJMBBUjZQ16MQcIr/h829iylW/xjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710132700; c=relaxed/simple;
	bh=X2PIHiuFKBKI05lxsuXnS6NSky11/Ol1+qhEfte8+CI=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=XL8VoLhr2rjuqW7yHprYidPeB6S0ASJK6TtvESqS96uTwVMyHsDQtDAvlnuAZVkzIjiJw9z6Xjii13GAUAa34a0y+4MZI8T2lJghWrsXN8KMTMlRiBMoTqyXFxYIPILxEDR4NLZ4nCnCWij8tXFZy8xY7Wa/8ZoU4i06OkScD9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LEVCIN2i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EcdvMj7+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42B4NhpC006594;
	Mon, 11 Mar 2024 04:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=a88cHd67mI8leTPSMrJd9HS2LbGcUh0O1E+UEpZisvE=;
 b=LEVCIN2iHDRZCUzwWOdn4eMnikD9Q2Op5/ve7+qgRaUOYg/4WfMN5OZOh2g1EMWUkcB8
 Xov1dCyMs8XeOKlqodNXZGrAQtfcuL+nPTF7NxuHlnwD4M9nf7TFREBS5mES308ScYC7
 87d1mQP2mSTBHLjVFM6s3LU6B7Atv6sE3y/Ycm3wrGFbNJFRmpsh+WYspqoYVYyifoqv
 WoUe83CWAhIvM9P57glEzK6800YTWNr606X9c+659uf7m1fXn1P7Lq2/m0LCJ0vUbJHX
 N/uwiakc+LZKGEt3zSEqzYP5Yhq6Ye3+p50nk3RvgqDpRXxISE9a38teGYd/JYkh2mAm hg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfcuaa9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 04:50:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42B3Vmgg006069;
	Mon, 11 Mar 2024 04:50:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre758rqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 04:50:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqsgIptZBiSJ8OGdWQd+YghzZtED3kM5MIGA+vjgQvMz28QktyRDamJnp7FSq+u2PXFY9RPhWnFDJ7NFIMaLxjxEc4XezpnK2a8SP0eEkajIJRh4ySmZUE8tIozD8ClLflhRJSp6uScInfbW5kbWANGWbos3WTMtkA8RRdt0PvW439iSPkTuvUi+xIPP4Va9ar0oIHtp0vTIngKgGLeJvrSdJc+Tv82H3ko9HjgYVw5X0tFYsx0hsjBiHoQ+BnszzyBrN4LS8wD4PAfL4H5Ovyu1Xy2jkcR5JWZOdrbv4e8EVPz7/+uW2DO9i998vGnVJZ1Uc4nUugoyX88CxG3FJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a88cHd67mI8leTPSMrJd9HS2LbGcUh0O1E+UEpZisvE=;
 b=E3ZhSeN2uPZf/zv2vQ7lDtlNob9ZbayqVSf9bGd1ApVbU3XENBsZlidfHBZdGtlc/BMRiOmXpVXzain6wNe1f2EyP6KFZjBQcXl7DLAkpQiy0ZtwRPlse6tqaZskTRWuO0PLX4/aSU8nK2TjJ91eyyx44SlHV4efVcmqudInd3q4zV5kOCetdm5Fzz81VATuIXCEUQJeeScWyl3mkoJxLrUrwFH3BsiJwUMibHdbm2AQT8CWOvR7tahp4ZjNMR8GHxjlAxzFOpCrsQ83HEHUaRgBcZwAOp9rH+GYe6TIBYbkpbb2jo1kKvueBs5oeHqAXBv/1WWV6WrdHdk48je2qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a88cHd67mI8leTPSMrJd9HS2LbGcUh0O1E+UEpZisvE=;
 b=EcdvMj7+AYkw6AGChgnQfACPdQYAI8tcOqjcaMNyQuwWWvD98FkwgaLwsQiU1X72eZpmVemoUo1bP0X7z9lhtVVycUWvaJ04tDSe4U7tUJdbNLwXlBrTDk0KjP8MbYfwzo7lQzhib4UsFz6FKvJJ6XkOMKlBZJ+A98po5XUT07M=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB7054.namprd10.prod.outlook.com (2603:10b6:510:276::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 04:50:01 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 04:50:01 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-27-ankur.a.arora@oracle.com>
 <65e3cd87.050a0220.bc052.7a29@mx.google.com> <87frx514jz.fsf@oracle.com>
 <12a20651-5429-43df-88d7-9d01ff6212c6@joelfernandes.org>
 <63380f0a-329c-43df-8e6c-4818de5eb371@paulmck-laptop>
 <d956c2e9-492d-4559-b9f9-400f37f523bf@joelfernandes.org>
 <6054a8e0-eb95-45a3-9901-fe2a31b6fe4e@paulmck-laptop>
 <87plw5pd2x.fsf@oracle.com>
 <e36b84bc-09c4-4b2e-bad0-f72530a9b15e@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: paulmck@kernel.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
        Joel Fernandes
 <joel@joelfernandes.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
        andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
        glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
        mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 26/30] sched: handle preempt=voluntary under PREEMPT_AUTO
In-reply-to: <e36b84bc-09c4-4b2e-bad0-f72530a9b15e@paulmck-laptop>
Date: Sun, 10 Mar 2024 21:50:33 -0700
Message-ID: <87wmq9mkx2.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0370.namprd04.prod.outlook.com
 (2603:10b6:303:81::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: d44fde0f-ef01-40ab-c015-08dc4186b616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AnXP5HcM/50o2MpdLlfRxZaCpKq4cryD5YUamVVqP4sk0DrLZENrQHMTPQFTHHcUdqpufNTek5VUB98fiRk3OzTfW2dkVuqctrQpsdUOVcqljz7x8mf6/f+20TG0aqChMztWsXpzb0Svyw8DO+vOfQbFJ99mBc8IhdgJt15R409pqI979aLhJQCy3wMj6RCQBiAncwrWMuK3AXHBIDWGHnxzVWGqtBb0xckP1SqGgqjklWN7r454pHmArR+Twnj3c9Hejp3lckKFyRGA+VeXy5pz5XjAmrYQUTXPw5Y4Uyn4Ni2+MGY1+N/spAr/mDY64/AXJZMCgu7jew77z8MegvElbVn7zAOK4f4wkjiDbk5S1pbiDRSRVTaoduwcZkPmcgZLpi/dSEjqEi+TTCLz4W53C25hjv1rxKsi3xP1xkotwWVUbJRLmjEruYnieiQA0I/mbyD1U+fc9Dwfy2dU0zBey3kuF6058R2x/rusAgnXmtxNtZOo/JdcR+OwT70f4RCeKR0LWX3iPrXp+QAnv2wvz975BFBesOlVP/8HyR/I03mjABhftENUgTQ6lenP9/w5S/6NeTMnXCat1mnj6aEFzdsTK01wJKj6ZV8mhLNq+0DgdIj1/gKKBJL7G1V4HPlcUApx0TTOLOR6PvWQHusVGsCeBG7VeO7I7Xx2w1c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?84R8ZIoYsrZlXfJv+7wfsG97HMPUnxJIF9Xarr+Yzbp1AgXgPgx55E13w1N4?=
 =?us-ascii?Q?Y6QsZtlvr2WDj2ddvis9BNR5YlHbi8JrQzpm0MTyRhvWEobi9o9t04VJYw8s?=
 =?us-ascii?Q?btenX+QxeSRpNQpGpqLptworDf39WUCJh1Cx/eYbL5jMXCtEWV9dwRdmKNnG?=
 =?us-ascii?Q?B62ObwnQ6SoicVY7eYs+AsYMv2VtxUebXj89ZJVaCzEsI//ZQdk3xRcwpMwZ?=
 =?us-ascii?Q?6JcJQ7/UYIvuAG9ycqp/1lkDtNw723fd+7PmHyBeoF8wGVgyxqXCcGTmnZG8?=
 =?us-ascii?Q?DxR0izcC+ju+e+76FJnBkOwPe284l0gNlQP1uXAqYBNB/nlvJTobCpYV1fhH?=
 =?us-ascii?Q?yNx7nsAVIhkeyOmPoEGSI4f0X8MiF2CfGunqa4RqFUHVETN6tL3W+bwnm3HZ?=
 =?us-ascii?Q?uEFKIvOHqGwqFGlYHW7PzotX2N8+RCSauXEDFiOMwUDFlwAD2vr/CHZgh5wH?=
 =?us-ascii?Q?zOrGpVSiUhF4kN9qNTlPxSQnsj1nx282LsXyqL2KHfj6AX5pn+w452qTjCZ0?=
 =?us-ascii?Q?7TJqku4lGBIxkp3/f5PQwKFjffsJ7f8u3L8TmWL24q5nfI3sQFe+Ctcm26a4?=
 =?us-ascii?Q?yQ4msMBNyUgZYEavX8qfN3z+e3NAALL/vMY6ptoruP1ORvpYz/RAyTDOqkTd?=
 =?us-ascii?Q?i92OtQ/fR/YAW1RRuhXsC+lc0kDanxgOP+Cvwaqrq+ITeRlXMCNE+OM2T8V5?=
 =?us-ascii?Q?OMuUxrt4Lvmymr+IeBCDshc6tw6hSVpwmhpmkDTQsjZc+UVSBdwMTm/mXiWy?=
 =?us-ascii?Q?oieuKXZ4tXS+B2kQBEyymzWYRG5Vpr1Uv5OecCsDdF5M6r57WNS5jp6K4JaM?=
 =?us-ascii?Q?RzUH5qv2FvivUzOEyZhSsXO6yzDXjXwO3K1J/WiW6rCLxXhM4LbQxe1XCuOz?=
 =?us-ascii?Q?oO0mTCCHIJA10jULLxiNYrYA0+16shnuoPatgKB15KrPwNs+N76Sh7+UDRcw?=
 =?us-ascii?Q?G4VFlxVZtUiJYfYCcayPpTrSClgP99q828X6Lo+WmNALD0NdHluEhF5LRegy?=
 =?us-ascii?Q?T3EBelYXk3ljc4/MC9gvCPQaRVkmcEV+3MMgTDoykrJ/NUXOhgb9UFXJC6yZ?=
 =?us-ascii?Q?UzrvL2ZkuTacs3gTjoTfqPJHCh0wEGu0IwJmISIrfUozYAdAMhDQyu+B82AL?=
 =?us-ascii?Q?CKlzB7zkhCmEv3Ru3tHT5uPYhOtxYhFXsY2uHdMSa8MYklSF1M055BjveRBg?=
 =?us-ascii?Q?Sk/H65aDL0wVQ9K9quWv7GBYbcd1EXZ6Y6h0o5ePTffzAwFMePirkys1km/k?=
 =?us-ascii?Q?1dHgeHZtj/SKqPIkO1C+QcfRa5TpQOnDBHaZVmxtJLlHD5ZxcU0mPDtD3OZO?=
 =?us-ascii?Q?cOinxRer5M40h3uH/WcxmWcEMXKiOT2OWR2FktYM/hsvVm+zKTnpTS2yzurO?=
 =?us-ascii?Q?9BffX7qdticRsRPD3TZFY7RQW4WeNWwY8P1WNKW+9XX2i5LnmD3hEnLyle3K?=
 =?us-ascii?Q?8sXk0HNiDwJ7AxxBRU6ajKorcEio3fQKdVkYEyYnzvCzMbksp6ZSdAwaaswn?=
 =?us-ascii?Q?KPSpOY/KQJqu0l+5VGZ3OQdy5j8mXKqXat8xeR9OR2pSXZizlGvNp0C05/BH?=
 =?us-ascii?Q?hmEZaIoaPCSIpeGgF7mjSkhug9mV5HvqxMFv2if3vpZg9KlXikBLTu3ot1+l?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oH2oantLkNn8unJx7VpaIdMPS8hszJsMYIGRNxlx/ePWZKYCoegbsffp/NbNqgiOwU/cKGStwao4J5seXmgc2t9VAvyH4Cawu5/bfcTOZWourYz7/Hf4qksgjdwDqgkQfqFaq1R7FzqVB9ghCQjjRa8Od8IfCzPp7tMvKo45hva3JtZBDBVzilqZnR4pa/agVOk2AnUNHdHZjUkrarNEwCj25WYtxJUEC5L3AWa2DePJsj9SXjHu2ZO23/Omzlw4w/KTVq9IuZF7QjLRdGQFdW1zwpZEDJAvvtFzQLPkYCWWO4EBJf3otlCRI01MjULMAR4YBKXMatGzWJ3P1x5YoMaPLXq9JKAlnSyft3c8m10yWZtPujZsjPi6bPv9eK12tYMpmc+13l2xj5fcK1/e46w846foqc1lmxYU/GrcMYy/26zjk+gypt+5vKe298q6I64Ftr2gca4FjCRdStODx/3GR5JDvc0iZxLC1M2XmRT6WtzA4Wdk8qwCqnuqzfOi0PagXm+eBpulZmCme/MdyTLoiettgUYhw2TXscy+0WRkj6HMns1+BTzn1rzX+oBrzTbVcuiF4StzYlsgN+Pmo7236a0ACAMgiwP+8Qr5H28=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44fde0f-ef01-40ab-c015-08dc4186b616
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 04:50:01.8485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLmVkJ9XL2Q1nL6XgEeW+SRcLR5DPtf4k1YuENspvH33lOEyarRmPNHA3wcgS6ex8t3+m0Rhvc0GLosseIH0/WIBJbImfKlkPOS4X3lOmyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7054
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_02,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403110035
X-Proofpoint-ORIG-GUID: 0hs0L2Vji0-bBSM357OhLJHVq8QkcGvZ
X-Proofpoint-GUID: 0hs0L2Vji0-bBSM357OhLJHVq8QkcGvZ


Paul E. McKenney <paulmck@kernel.org> writes:

> On Thu, Mar 07, 2024 at 08:22:30PM -0800, Ankur Arora wrote:
>>
>> Paul E. McKenney <paulmck@kernel.org> writes:
>>
>> > On Thu, Mar 07, 2024 at 07:15:35PM -0500, Joel Fernandes wrote:
>> >>
>> >>
>> >> On 3/7/2024 2:01 PM, Paul E. McKenney wrote:
>> >> > On Wed, Mar 06, 2024 at 03:42:10PM -0500, Joel Fernandes wrote:
>> >> >> Hi Ankur,
>> >> >>
>> >> >> On 3/5/2024 3:11 AM, Ankur Arora wrote:
>> >> >>>
>> >> >>> Joel Fernandes <joel@joelfernandes.org> writes:
>> >> >>>
>> >> >> [..]
>> >> >>>> IMO, just kill 'voluntary' if PREEMPT_AUTO is enabled. There is no
>> >> >>>> 'voluntary' business because
>> >> >>>> 1. The behavior vs =none is to allow higher scheduling class to preempt, it
>> >> >>>> is not about the old voluntary.
>> >> >>>
>> >> >>> What do you think about folding the higher scheduling class preemption logic
>> >> >>> into preempt=none? As Juri pointed out, prioritization of at least the leftmost
>> >> >>> deadline task needs to be done for correctness.
>> >> >>>
>> >> >>> (That'll get rid of the current preempt=voluntary model, at least until
>> >> >>> there's a separate use for it.)
>> >> >>
>> >> >> Yes I am all in support for that. Its less confusing for the user as well, and
>> >> >> scheduling higher priority class at the next tick for preempt=none sounds good
>> >> >> to me. That is still an improvement for folks using SCHED_DEADLINE for whatever
>> >> >> reason, with a vanilla CONFIG_PREEMPT_NONE=y kernel. :-P. If we want a new mode
>> >> >> that is more aggressive, it could be added in the future.
>> >> >
>> >> > This would be something that happens only after removing cond_resched()
>> >> > might_sleep() functionality from might_sleep(), correct?
>> >>
>> >> Firstly, Maybe I misunderstood Ankur completely. Re-reading his comments above,
>> >> he seems to be suggesting preempting instantly for higher scheduling CLASSES
>> >> even for preempt=none mode, without having to wait till the next
>> >> scheduling-clock interrupt. Not sure if that makes sense to me, I was asking not
>> >> to treat "higher class" any differently than "higher priority" for preempt=none.
>> >>
>> >> And if SCHED_DEADLINE has a problem with that, then it already happens so with
>> >> CONFIG_PREEMPT_NONE=y kernels, so no need special treatment for higher class any
>> >> more than the treatment given to higher priority within same class. Ankur/Juri?
>> >>
>> >> Re: cond_resched(), I did not follow you Paul, why does removing the proposed
>> >> preempt=voluntary mode (i.e. dropping this patch) have to happen only after
>> >> cond_resched()/might_sleep() modifications?
>> >
>> > Because right now, one large difference between CONFIG_PREEMPT_NONE
>> > an CONFIG_PREEMPT_VOLUNTARY is that for the latter might_sleep() is a
>> > preemption point, but not for the former.
>>
>> True. But, there is no difference between either of those with
>> PREEMPT_AUTO=y (at least right now).
>>
>> For (PREEMPT_AUTO=y, PREEMPT_VOLUNTARY=y, DEBUG_ATOMIC_SLEEP=y),
>> might_sleep() is:
>>
>> # define might_resched() do { } while (0)
>> # define might_sleep() \
>>         do { __might_sleep(__FILE__, __LINE__); might_resched(); } while (0)
>>
>> And, cond_resched() for (PREEMPT_AUTO=y, PREEMPT_VOLUNTARY=y,
>> DEBUG_ATOMIC_SLEEP=y):
>>
>> static inline int _cond_resched(void)
>> {
>>         klp_sched_try_switch();
>>         return 0;
>> }
>> #define cond_resched() ({                       \
>>         __might_resched(__FILE__, __LINE__, 0); \
>>         _cond_resched();                        \
>> })
>>
>> And, no change for (PREEMPT_AUTO=y, PREEMPT_NONE=y, DEBUG_ATOMIC_SLEEP=y).
>
> As long as it is easy to restore the prior cond_resched() functionality
> for testing in the meantime, I should be OK.  For example, it would
> be great to have the commit removing the old functionality from
> cond_resched() at the end of the series,

I would, of course, be happy to make any changes that helps testing,
but I think I'm missing something that you are saying wrt
cond_resched()/might_sleep().

There's no commit explicitly removing the core cond_reshed()
functionality: PREEMPT_AUTO explicitly selects PREEMPT_BUILD and selects
out PREEMPTION_{NONE,VOLUNTARY}_BUILD.
(That's patch-1 "preempt: introduce CONFIG_PREEMPT_AUTO".)

For the rest it just piggybacks on the CONFIG_PREEMPT_DYNAMIC work
and just piggybacks on (!CONFIG_PREEMPT_DYNAMIC && CONFIG_PREEMPTION):

#if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
	/* ... */
#if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
	/* ... */
#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
	/* ... */
#else /* !CONFIG_PREEMPTION */
	/* ... */
#endif /* PREEMPT_DYNAMIC && CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */

#else /* CONFIG_PREEMPTION && !CONFIG_PREEMPT_DYNAMIC */
static inline int _cond_resched(void)
{
	klp_sched_try_switch();
	return 0;
}
#endif /* !CONFIG_PREEMPTION || CONFIG_PREEMPT_DYNAMIC */

Same for might_sleep() (which really amounts to might_resched()):

#ifdef CONFIG_PREEMPT_VOLUNTARY_BUILD
       /* ... */
#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
      /* ... */
#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
      /* ... */
#else
# define might_resched() do { } while (0)
#endif /* CONFIG_PREEMPT_* */

But, I doubt that I'm telling you anything new. So, what am I missing?

--
ankur

