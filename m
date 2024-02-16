Return-Path: <linux-kernel+bounces-67904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 563D68572BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31691F22F05
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502969441;
	Fri, 16 Feb 2024 00:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="URlzeOdU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gzWZByiZ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596DD8BF7
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044405; cv=fail; b=K+lrmXSc2RxkX0jTX88Gvj9mwAnSUyxYbXcX13lBiQfdBXqV7QY/b+19alR/nyLWzmuL7fEkmrRc03hqxG3L93RBpfDEzUqmPMo5XgF5+5/zUXmuKuTFwVtX/1Ngt/3xse6QzG0HVgBblak1q2z0ovOfhIh5HvGGsksAnFEa2gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044405; c=relaxed/simple;
	bh=prDrrLZqK12VJb0uJ5SVwlPxmjiFlnluhR4SnWkHmik=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=JSGIhkyoPaf0UdhdV+uxD5Z/FC1e1bX6fSPc1F7g+wiT9u9Yv80UPDaCd1qQo2PL4OcgR5c2jQLzSFAQFsdEluopmv5MDpe5H85ekVv8IaWOZYUwvrVL5iSqQL3Ue8FKXa/gBEiO1NMIexCJ1+Iks2e7ISXDj9IVWPC9NatP84A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=URlzeOdU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gzWZByiZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLSPLY029368;
	Fri, 16 Feb 2024 00:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=6y0gyKwUYRPATCRfrClht4Rz7mBGfqpCRjNQgo9Lgx4=;
 b=URlzeOdUmkRJZ1SJ+kvVEn+F16i30aL6zx9GNEeOJGAxg0N8PPGoSyvA17foMzYI8Yqp
 kmuqdmqvnSEGGabjDm+njDXYa1bwrb4tUndJAu5XA6csy6hpbu1UOiB/VUC1nUBPePaQ
 3rt2we+mtIF3iUdGnZpQWqQ+iSFzkjojpVcP98/zaX2o4yi8PidgEpQG5+U9KQasNGV+
 KZlpId0QY01qRYUWl/UQp5FGUnPngC5B+oL39BkjnKlId8y92DSf+3LHHxR+4Z8J7AUW
 Y0ErJKd4gz0VL+5mjYv3YJNTxFi2fbwDEzdE0IwNTomjZhHTLq/iTPQbxuuAIH/fPZ5U mQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92db3qce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 00:45:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FNE3bK013875;
	Fri, 16 Feb 2024 00:45:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6ape948m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 00:45:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0nZ5od3BbXlj3stNhkt9YO5B4To05tZ+KBT01JKiZ0EOqC0PefTf16HeCV40sjB/pz42ULf8QdQ70GsImn6NoBYxBAbjN4UxOsSwhU5KxFDc7qz1tOSOiSPNpnhsZv5MQeB+g0a3y5qqUDPDg09E6DMs3EimuNLJ4Y5D00YN/JRMPQPsKtqum1dMXkSVZaSpqH+8qKXclhwG4EwyJ/a3mt9aYxqs7Zm1QdpZ3bbP2SMeX8pIQAH+JUqJD5YpE87UZGvTiWZs/qMYpUH8PYxgEB8SOnW+MU6hGELs0Xt3Rv/KkJ87gt96NLWKgsv6nNAkpU/FYyV/QCjV3bEjETMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6y0gyKwUYRPATCRfrClht4Rz7mBGfqpCRjNQgo9Lgx4=;
 b=PcJP6ptLRdVUkqCx+jmiLI+XCqjFcqcRXQORqW67QlIJpLPBp2amWlF7ec1/TmZIs+TMq/uTvn2zEKLCijj3i3dz6DS7dov1hfLxfMAL3BThOecQYqIuLy1VYQi9t1mY3obuaPscgdUUjkZXWtn4vtTWgb1pok2wlRqBv8glM0EKbhScziD02Dlb/uXBe7Zje5mHVo+fPZ6xoUU/eJYAaGJcqE1rT+uX7ZtZvkRd1GN0B3TFrR4xANaZB8cs8r2DM7m0oGqQM46sCufKbAuY+L50op2XMXOfBtmxoAc94+EFqVq+xG+Dx61h1jtS71kNCMAqC43eHehZq9esuqRETA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6y0gyKwUYRPATCRfrClht4Rz7mBGfqpCRjNQgo9Lgx4=;
 b=gzWZByiZXT+bnD+32n4yXj4HcN8IYdn8zg4AcG6/GVM15++ST4b8XMXhzv6GwEBBp/IS6exJhfMHg4bBCq1pTvXsAhqwwOuDpVKUrp0cANqCXVufyP+Cy7S/cWiSyFreqnA53WNCU9tu1OWwlr5upGbkmc8baSDVBdV7L4vKU68=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB7210.namprd10.prod.outlook.com (2603:10b6:610:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Fri, 16 Feb
 2024 00:45:31 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 00:45:31 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <a7e785f8-d4c3-4b1b-9abe-36ac0b971e44@paulmck-laptop>
 <87le7mpjpr.fsf@oracle.com>
 <4e070ae0-29dc-41ee-aee6-0d3670304825@paulmck-laptop>
 <0d4a4eec-ce91-48da-91b6-1708a97edaeb@paulmck-laptop>
 <871q9dmndg.fsf@oracle.com>
 <9916c73f-510c-47a6-a9b4-ea6b438e82c0@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: paulmck@kernel.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
        andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
In-reply-to: <9916c73f-510c-47a6-a9b4-ea6b438e82c0@paulmck-laptop>
Message-ID: <87jzn5kzia.fsf@oracle.com>
Date: Thu, 15 Feb 2024 16:45:50 -0800
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: be603a67-606d-4f65-f0c9-08dc2e8893be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vwuo6xEbWeweHdM01yxlqPwzEhJ3QvTYlUw7zQASoxgPq+a1cdjyOdJuQAVTdJSUgHykB1VpleSt01ROB5eHE1s6Nu1QDZsrQSRnnqFhDWOW8GU6pt7kSIAvdaofb3+fuukxKGLvBynU4k5OCHkS9qyXbj71oF9Q0oRrr0R6+t08FGafmq2QgikoVWc9kPzk1XRpRMJUeq0UdKxSBjN6guZ+WrMme01XWaD+IrVhxjoUeMmHBV+APy4LM3Jaec7QWoQvL9NW6kDPaZ0yL1DhiK6qmnJYrO6CjDzzK9S1QWD3cqPYuj8XcY+B02whwpYTYlkkLwogUoLRs97y9n5tdXKuWrJNAnMeszkb0l0/rKosdFhlTmN9SYZFLjS0C9sjkC/8qJlHmkZDup/qqFVEmrNYjJb2zaY7qqvgs9XI6MeSgy2EBuUSQmMiHYAv+M616oTNDUeb3jWlsK7je91BlVLR2n6zeR5hZhcnJl8LSGCyiehyOJeqkDJhp4v5XiS8dQ9lWO736Dtk6GYlYS34TaNrtNJEMXjrz5p6xlJHJqGHSOhnuTS2dTCJfa31MZsm
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(8936002)(4326008)(8676002)(2906002)(7406005)(5660300002)(7416002)(2616005)(83380400001)(38100700002)(36756003)(86362001)(26005)(66556008)(6506007)(66476007)(66946007)(316002)(6916009)(107886003)(6666004)(6512007)(478600001)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vRDRL6esiwfGbK9HDyIHI8Qpd9IhnfUS68guZzW2rIppruAXeWCP5yHNKS0Y?=
 =?us-ascii?Q?8tEUhcJn2xZhmC9cZnKv8xFtIO1mBPqncagCispZjjT/Rj3cwp2opldNht7S?=
 =?us-ascii?Q?cK+vw9qIXhIHqbCvItt5BifFM3mN9wuODipjwcLMyyrlyICqJHFNaCBoUyEI?=
 =?us-ascii?Q?I3+2Y9bCmV7FLQ27jzyDCqnyOGUb7oLjwzG/BHVFZB8ze0kCfVXeIUijBFnq?=
 =?us-ascii?Q?JqOSzWEdv37WGcvuF40sxJUydrEz55rTFINqpcS3y4Cs0jkKg8ASqMJHhK8b?=
 =?us-ascii?Q?HWKfPa/V/D/wMMRgc+jm1fXX9zrRTskAkTDQLPXK/ODkS9pzzUclJknbes1G?=
 =?us-ascii?Q?cqpgzco8JT7Z1kj/o+P7zycuFmnBoTFM1F+4AY3739HD4SGHBPLUhEoS14Ce?=
 =?us-ascii?Q?zCoTj4ZOZavZ8A3eDOuGDq3jNCSypKR47PMizxhJJcyeILLqt1WcxWy4H4J8?=
 =?us-ascii?Q?kzcLhU73aGdDR11qmZV8ebnQpc6CUnphEFruC+81IiZrg5uokeZOMU/Evf64?=
 =?us-ascii?Q?4gH4acf3WYYSwuHLHJ+jmJQ8iPy6PIs91p+K070zARG3plNZUuRQo1FN4pZc?=
 =?us-ascii?Q?3LOesScMNOf1u+bRwVCJ2pJPGVrIMxE9MqmnDD8BItBj5Sv6cAYZ6ULUuR7j?=
 =?us-ascii?Q?3Iwt0yONHrvilS2Xv3VfGqXTTYtTuqDv8EAQcIUPSau7wo1jIp398PMVvY3V?=
 =?us-ascii?Q?F8V9qoMDZC246HPQaiyz8C6JVh0hkhCCSfLmBHa14JlI2geSx4MRJXb8luV/?=
 =?us-ascii?Q?COFVGum4Dc5cQidQ/1YF8Lw8gDdoteVtfevO9qNDQhMJVf8ByczxcSgFg05o?=
 =?us-ascii?Q?K87i7IxhJu2j9+RB/EuwizcQiI39IugKITsckq4Myo69p3l+qqc9fpy5tKj8?=
 =?us-ascii?Q?d2j7wYV2rywY0L1ohg6SlJ/JNhL46/MClenQZI5vj7AgNz9rLIOMOnJlZ5fK?=
 =?us-ascii?Q?CJf0QXS5/txoIp7V2oJOhvONtnYLNmDqDMsP2JogOom+jPLcu+Dj8Q1uBHiy?=
 =?us-ascii?Q?PQJQBP8H5yMZlqSp4iKCLlxTRnY1htLKsAXXigmmLTXz5Wa8Q5Bohx8P/BsA?=
 =?us-ascii?Q?MmauFnq0Is4FWiQRKivomPNAp3ZSNvnbHw6LtH6L3jtkv7WK34csqsUJZspN?=
 =?us-ascii?Q?MMcW5knHGpkQLTb3UQROH9kEEkqgqamUTIbzQkg9Nt6nDNqVxwkxrw4Bvn2Q?=
 =?us-ascii?Q?Caidq1YWerCD/CKaJSUe1kBGfz4J1/Iozks1PZVW5NiR4h3kiEYn/+kB99gV?=
 =?us-ascii?Q?tYAg9TQ7CxfmEDzHONZK7eldPVC78dN3XdAsfMpk4ExCwuqFOAWCCediOBfS?=
 =?us-ascii?Q?GP+qlr92JpdcJcp/q3mvsuILOjWtIbIFpPN84X45ZOAfJPe4z8/Z1cajZGbj?=
 =?us-ascii?Q?moga1B6DLp3PvAxWj4gcc5eCeWhZlTCADZSgOUUqOgv/svPaEh45UuZogC+C?=
 =?us-ascii?Q?ES/msJ7aCT2jptgX0KngYyJediaAwgHkNtOCoT2KW2mPr71vnGRDfrn9uihS?=
 =?us-ascii?Q?03NAuMBgnUXRlbFtome1Dc/+gKdpl3HwhPavWXASVc+5Ozxb8Fv/OATlid6i?=
 =?us-ascii?Q?sctpCzLl4ctOwXFPZr8NLxT8zDzg+Jl21fQBCUoSF+opLHcDLyyaKh0hrJna?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	94gjbtoA6Z+0fG6aiXjawe21iE92NZ1HcsI5nUVOwlxUbyXt3NWwMEC1riqxJtKLiKwwIOhpMXRY5lGkyYIxHGOLrv4DGUIZwk2kHqAx0xoW+eXS89jBkFIZBWTOUV9/yKW0mWN0op+C3MxldFXunc3lgZ1baEilmrF8V978kzJZQFbU3rww/Z5S8vCdHY249VTHP9fe3xFFC9KHFGz77cYkjK8A90eo2yj2q+tmhzP3h2/CKS28H5Mvwed/NAQyO3m5CrFi/hmBXGHWnCm6BsYn1jKIxXYqvbnjVOfgtAtKzbj1sgXrGVknVVi72QsUHeZMNHSCg6L5aTcMCRw77YH3OJTroU8dZ2Vf4uA0cqNlMmZIQX2PmB63KAJx3eLTbhsML9hB46vQvmWVmHnVV/WdeqAfHG8ykZo64srmt2GaptFu6T6luTDdPDbasHr3oEVbMeNwdggqQi6QxUVRnICqvaVDsVu6tMTX7DNesP7KcLKgumJrOQk77XB8WH2a0pFx8eGzdBCI3V00HRgyGsY2CvkG0rdiEu1y9H6R8+EYM+LelTzSTQwXgwP8pupXOn6f1WXbAVceP2T4RC2+RAsBv3iaWt2dfas7aOvo0Z4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be603a67-606d-4f65-f0c9-08dc2e8893be
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 00:45:31.0087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5H23sIBBZkRgHN8mJU/8ppz9oH8AWom7oBR8AnRb2KBEi8pNuA4+X18KoLz4Zpr6BOMcvYP5+HHsY9Dr22CQltKHbI0uHHfXeWkA0BSqls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7210
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_23,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=755 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160004
X-Proofpoint-GUID: 4JlZRHY0c_eB5KPJX-wR0SNcgmdSDqyq
X-Proofpoint-ORIG-GUID: 4JlZRHY0c_eB5KPJX-wR0SNcgmdSDqyq


Paul E. McKenney <paulmck@kernel.org> writes:

> On Thu, Feb 15, 2024 at 01:24:59PM -0800, Ankur Arora wrote:
>>
>> Paul E. McKenney <paulmck@kernel.org> writes:
>>
>> > On Wed, Feb 14, 2024 at 07:45:18PM -0800, Paul E. McKenney wrote:
>> >> On Wed, Feb 14, 2024 at 06:03:28PM -0800, Ankur Arora wrote:
>> >> >
>> >> > Paul E. McKenney <paulmck@kernel.org> writes:
>> >> >
>> >> > > On Mon, Feb 12, 2024 at 09:55:24PM -0800, Ankur Arora wrote:
>> >> > >> Hi,
>> >> > >>
>> >> > >> This series adds a new scheduling model PREEMPT_AUTO, which like
>> >> > >> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
>> >> > >> preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
>> >> > >> on explicit preemption points for the voluntary models.
>> >> > >>
>> >> > >> The series is based on Thomas' original proposal which he outlined
>> >> > >> in [1], [2] and in his PoC [3].
>> >> > >>
>> >> > >> An earlier RFC version is at [4].
>> >> > >
>> >> > > This uncovered a couple of latent bugs in RCU due to its having been
>> >> > > a good long time since anyone built a !SMP preemptible kernel with
>> >> > > non-preemptible RCU.  I have a couple of fixes queued on -rcu [1], most
>> >> > > likely for the merge window after next, but let me know if you need
>> >> > > them sooner.
>> >> >
>> >> > Thanks. As you can probably tell, I skipped out on !SMP in my testing.
>> >> > But, the attached diff should tide me over until the fixes are in.
>> >>
>> >> That was indeed my guess.  ;-)
>> >>
>> >> > > I am also seeing OOM conditions during rcutorture testing of callback
>> >> > > flooding, but I am still looking into this.
>> >> >
>> >> > That's on the PREEMPT_AUTO && PREEMPT_VOLUNTARY configuration?
>> >>
>> >> On two of the PREEMPT_AUTO && PREEMPT_NONE configurations, but only on
>> >> two of them thus far.  I am running a longer test to see if this might
>> >> be just luck.  If not, I look to see what rcutorture scenarios TREE10
>> >> and TRACE01 have in common.
>> >
>> > And still TRACE01 and TREE10 are hitting OOMs, still not seeing what
>> > sets them apart.  I also hit a grace-period hang in TREE04, which does
>> > CONFIG_PREEMPT_VOLUNTARY=y along with CONFIG_PREEMPT_AUTO=y.  Something
>> > to dig into more.
>>
>> So, the only PREEMPT_VOLUNTARY=y configuration is TREE04. I wonder
>> if you would continue to hit the TREE04 hang with CONFIG_PREEMTP_NONE=y
>> as well?
>> (Just in the interest of minimizing configurations.)
>
> I would be happy to, but in the spirit of full disclosure...
>
> First, I have seen that failure only once, which is not enough to
> conclude that it has much to do with TREE04.  It might simply be low
> probability, so that TREE04 simply was unlucky enough to hit it first.
> In contrast, I have sufficient data to be reasonably confident that the
> callback-flooding OOMs really do have something to do with the TRACE01 and
> TREE10 scenarios, even though I am not yet seeing what these two scenarios
> have in common that they don't also have in common with other scenarios.
> But what is life without a bit of mystery?  ;-)

:).

> Second, please see the attached tarball, which contains .csv files showing
> Kconfig options and kernel boot parameters for the various torture tests.
> The portions of the filenames preceding the "config.csv" correspond to
> the directories in tools/testing/selftests/rcutorture/configs.

So, at least some of the HZ_FULL=y tests don't run into problems.

> Third, there are additional scenarios hand-crafted by the script at
> tools/testing/selftests/rcutorture/bin/torture.sh.  Thus far, none of
> them have triggered, other than via the newly increased difficulty
> of configurating a tracing-free kernel with which to test, but they
> can still be useful in ruling out particular Kconfig options or kernel
> boot parameters being related to a given issue.
>
> But please do take a look at the .csv files and let me know what
> adjustments would be appropriate given the failure information.

Nothing stands out just yet. Let me start a run here and see if
that gives me some ideas.

I'm guessing the splats don't give any useful information or
you would have attached them ;).

Thanks for testing, btw.

--
ankur

