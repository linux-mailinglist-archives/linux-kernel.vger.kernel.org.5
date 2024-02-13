Return-Path: <linux-kernel+bounces-64371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E0F853D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBF91F2815F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C1661699;
	Tue, 13 Feb 2024 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KwL22+01";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G80y/0wH"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420F2629
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860833; cv=fail; b=dP/YVLsYnO9G/7RmModQYbZqpbG1NhWz4cJ804WHmkrczoPwOLlJhyT6M8LkYkQIYfVM+EjwapYtKSNk+wB0yja3rJFm7BoqkgMa6jaQsLXgmflLrCkpFCrC5nBXkX+y41BkjEdwHrIyC3y4DX59OrEcBhTz9DeSJNSJp8wVoXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860833; c=relaxed/simple;
	bh=oHsU0zEgvKs9CHWE9vsC7xu3SZh4E11OIZsYVR3ktvA=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=NRo5fEtOqqksjIsHSp24jtH6QRWx29vYrfbKg9UHJI61PN8Y+4HxY66GMl7iIsG43KIscA+jyG4IY+lIHC4aAk7JWvSbHdqxVsJZAspLfmsMGIQro4VFuOO+h4SCV/nsW14ujMAxb9cO7bHryeIlFBKBpfDkB4lrrFH7OZtpq1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KwL22+01; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G80y/0wH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DL3xnd003620;
	Tue, 13 Feb 2024 21:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=oHsU0zEgvKs9CHWE9vsC7xu3SZh4E11OIZsYVR3ktvA=;
 b=KwL22+01Y0IWhzk4i+WF6D/FOww/7nXBSjGxO4gUCfb62BTLmIG+Jx/n77rjCDtzMgIO
 3aUg0B5OtGQHPfYFkoKFrsfY/tdGPox1nX7V2n0O9aMwPwuHAaapw3DY4FrG+Qei6N34
 susKIIjJnrOIku3so+Sq5SmizF8u3smqydsS9aB8yIuuu4S7FfIYZiIjr7FWVTJO/dWu
 tkaJKWkCpW/nw1OjK0XQe4zjX8VEDMDAc6RaS7V3Ya60V3yAS8X2gciMC6rx7lyRerV+
 QvsHUisOmbe7imvCtFrdl+0yaphkLjCkEPDMxYA0rpCaw7SCZhFXvewiuWCR5iWHa29q NQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8efvrc5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 21:46:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DL3HOO015090;
	Tue, 13 Feb 2024 21:46:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk80dqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 21:46:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imY1nwlBHemsZqULtkOTNgPJL45j75AmRrxN4ef2l5qwRt2AlXtTz6iKQsERGramKwxAIENq+dBtLWqvqq7uSiR+dVXrR438fuKm3YYRjjwoKutv5SH66w+Ha0zeBnqk/z10ZW/Qb2X2UxxYRY/zx+GRKnX8Rf1RYp+bVxxRoZW5uB96i0w2GCp1VtQIcUIiEJUQYBxtPAa8qU99jRLkoEO/yNdxKUeThYxF1Ku/aqnV3tGtQ+9HzrNhlJPhwNe9bTPJAmJDDWWwSs09aXwo2a+asL/EFDn7/ZPjdQs++iVfYzw6dpcA1YXztEuSQZVhpwpjPMtePVk6tiofdgbR+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHsU0zEgvKs9CHWE9vsC7xu3SZh4E11OIZsYVR3ktvA=;
 b=GvJgcXkBmozuOR0IOcf1UVZzSl2VCin63or7Q8oVzkdbquu+A2illkLlg/qBribJNdenuKmSmkx6EwsxIeempXJtRYGihFHPup7Y9qfQac3RenILEqf5LdHGRKG9GcJKSvd7rTPLKRvYAw3yatvZ8XNViSo26pFh+7dEs+X+1cTOZjkd/xoOtncVESnQ+nszroHoVjRWIFSBZWRcK2b25XxJYFlvxv77iKOl/CW9f+DJ8edXnMf40xm87imYfpTyWVmDJo97QmsrDtPxJgFyca2919UEmzxSPnbQpEnk4z4naHWOanhXx0K4tBAAU23sfj6XneXrJmABLiZ/U4pyxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHsU0zEgvKs9CHWE9vsC7xu3SZh4E11OIZsYVR3ktvA=;
 b=G80y/0wHru7lDrrBqlqJQMC0AfwZpVY5lsRqYeOWp9Q7gP6h9USp899nrxNWQQ8RhqLjojwcE6C4QXUPUs5oQ14RPhhAiLprWfunWOty9Zah7QFwQu4a/Ar/5WmY5ZmsIj91yiEAxa94cvGhKMy/lcqQHj8uL5dTEsVy5PUk5CY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5689.namprd10.prod.outlook.com (2603:10b6:303:19a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.37; Tue, 13 Feb
 2024 21:46:01 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 21:46:01 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <CAMuHMdV-JXjXmd5yan0-on52oH1dbRg1=N9OL2C7FAhLaOsTgQ@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
        mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com,
        jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
In-reply-to: <CAMuHMdV-JXjXmd5yan0-on52oH1dbRg1=N9OL2C7FAhLaOsTgQ@mail.gmail.com>
Message-ID: <87r0hgrqab.fsf@oracle.com>
Date: Tue, 13 Feb 2024 13:46:20 -0800
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR04CA0294.namprd04.prod.outlook.com
 (2603:10b6:303:89::29) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW5PR10MB5689:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb21c3a-83b2-4a55-d892-08dc2cdd2b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wl0GMplWCXxNzCW5igL3LNyLtwdpUW+J/M8T2Yge7qu2qasthuCHPcZcuni8esvqd4E9ykVdXUEZ7rKJis8uKqCFSJ7GHKWaxxDG0Af+fiFQ0u8wj5iWXBYnvgS/OmWQ2TbRvyZqLZQY7PjbEwzJC1pk5jYBz6o2WRaW/cqOH4LB5gye1UHoipCrh58A6psiWQAnxd5CmK3MvUbeaaNsn5agh1qOXhOQWy0oGuN/0R6A7YK4mkjHnT82WXWbWQN2GxWeOZzcSP9I9qUDmDqFaB4omZzoWbA3vnHI0s5Rie9TaLZfN2WgqGaFhu9BrF5+KwX2u4gnTTfFmbCYduVaz66ernrWXJazUKRMH5gV8Fc9GcaTZTjMZ5kQjf6iiekVP5EWjZg247Ef3h6Co2hu8vQBg3MzGFADSMVVwk1JjE0cMfoaIMHfHoPxO+O2tbzrdkmZPXTQfYEKA7pDxJ7MmIJPe7Y7cEJc9yJctpakiCt27JkrBxpVM1yu74HXi3RHy0FcmAWQ07KLFckptn8juy9MojYIZq0VnL13Y6cQcMdroctLiG/TlYJBwAgIfNrR
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(366004)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(8936002)(4326008)(8676002)(5660300002)(7416002)(2906002)(7406005)(4744005)(2616005)(26005)(83380400001)(6506007)(107886003)(38100700002)(36756003)(86362001)(316002)(66476007)(66946007)(6916009)(66556008)(6666004)(53546011)(6486002)(478600001)(6512007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RFhyYWgwWmR2MlRlL2VtNGtVMjZydkpHOG1hREpBTzdDM2xIckR1REFveURt?=
 =?utf-8?B?UG9Dc1M2RW11N0YwWi9vZVAySjdkd011YW12Q0p0QS80cVozb0pkdlk3OWZr?=
 =?utf-8?B?ZTdIZ1p5RFU5QmVxRGcyM09DYkZGQ1RzTTJnNTMxWHJWOWRWRlZ2c2pYRTRI?=
 =?utf-8?B?VkZWTm9wTSs1ZklWNHUwYnIxTUZDNmpZS0YxaWRmaXg5OGNQNjZSbUhJcmpz?=
 =?utf-8?B?eHlWMzNtYVlVbFNPQk1rQnpiZk9wS2kxVWpNM2FoSTBYbW1kYk11UE5zSHZz?=
 =?utf-8?B?TEdUT2luQzVHTC83MzJ5TW1aYy9CR0d1VUV5Zy9NYzVyamFMeGhGdHRBdVhO?=
 =?utf-8?B?K1RmMlBna2tLM0tvSU5oWEl0NzZDcE8wV2laOVcxakxzT2p1Z2JESHdZcXhC?=
 =?utf-8?B?MHFnd1dJckRERndRWlAxWlorald1MDQxZmZYTHpGTm81cHU1K0tqR0xFeGtl?=
 =?utf-8?B?YWZKQ0U4ckZLQjFVWG9nZUJaU1I3QjhpVktjeUtMU1BHamZMZENYU3RYMVNQ?=
 =?utf-8?B?Sys4S0Yza1FobDdFdWNrWGxobm9WbWdTbDNkdjNrRXJhVE5XMWFHSklESHNk?=
 =?utf-8?B?NmlhTzBvUXpBTjQ5WDlKYnA5aTlZdDYvRnQxZUJVRnpab0FCK3d2VzE3dEkv?=
 =?utf-8?B?aFJoUjZlOXhPQTBPMGRJRktQVmt1bjBhNFR3eEZkOHpRU1I3cVlNZzFoUUdK?=
 =?utf-8?B?bWhURHNkS0VTRlkwM3hSNHRBbHI4QnVZUU5yYkVmMWNyMGFMek5xb0dFd3VU?=
 =?utf-8?B?enZnanNDZGtPbG1SYzAzbTUvWDRVUlhMNU1ZQlZoc2tTOWMvZDkrUWUvSllM?=
 =?utf-8?B?bkhXRGxod0szSlI4cmhWZ2M3aGJlV0NEWVdRcmtxTzFHYXowbTFtV1FUZ25R?=
 =?utf-8?B?Q1c5djE1NjU5YXJiMEtBZ2NPc2xyQ0NNNWhuclY1YktXZU1qdFZ3b1hFUE1u?=
 =?utf-8?B?eEZiS3FwakVLYXMvcTR6UXZaUEMzVG9JTS9NcjRZTmlYYjBqRDhXU2w1Wmpt?=
 =?utf-8?B?dDU4ZzNqQTBPTC96MEJpdFZUSFk4SmRLWng2bWFNYnZtR0NweW9xN1FWRkZo?=
 =?utf-8?B?UXh1dnExejBweWJTOUN2SUlIK1NrRytmQmFoVG1sNEN0SW5JNmlaOWxWSzRJ?=
 =?utf-8?B?NjVJRzNBRkJJSHFJUm9vVHUxQXhXS3VvK2N3aVhnbzZCaytjOGsrZlAvbkEy?=
 =?utf-8?B?TEdNTmNCN005REdQdzhwQWRJdmZnbE8xS3RheWhBYTVoZ09OOXRhalpMVXlV?=
 =?utf-8?B?b1hRbjhzUkxGdTNkcTduNlZSalZIalk1V3JwYU8ra29hSUFhRXJSQTk0VUxV?=
 =?utf-8?B?VnZxRjlLeE5TZE5zTkpqU0UvcmY4blBqUE9hdGVUUEl2aDFpV1FXaThWOEl2?=
 =?utf-8?B?RmJGYjUrNllWSys4UE5NZkVJRktvbFVpNnhCSnhmbUJMeHRwOEFqOXJYdXJ1?=
 =?utf-8?B?Z3dmMmN4WVNFRkJmWGRCbzJZV0VwUEpnZklWZnArUzA3dEY4YzZxOGxoVFR5?=
 =?utf-8?B?NEdWYThBZGVjaGFVWDNNeXI1RHUveWtMNmh5b29GSndVK01WTmlWVWhSMk1P?=
 =?utf-8?B?WlVmeWhGWDZYTEpyYkdISWpUUjEzaThlK29rOVZaWEhBangwUEpIS09sc1FE?=
 =?utf-8?B?VDl4OGFxand4QmVJQjVHQndzQ0k1SlhIVFV4dStWMFZycTJKQnh3ZnN4SjZF?=
 =?utf-8?B?L0d4RFUyWkVhMWdlWEhUODE2OS93bE01UkRLZUY2SzZ1Wkl5azNmd2htRjVh?=
 =?utf-8?B?R0FrbWRaYmVRWVFJOEppR21mcmRkN3Z6Z0NITVJoeXEweVNhczMvb05mS3Nm?=
 =?utf-8?B?Q1U1ZlZYQ0JkQzlmNW14RHlLOEExOUtjNVV6MVpNcGpjQmI5UG5HVlNYWXRJ?=
 =?utf-8?B?bUZCRk43K0N0ME1XdC9TR1Nsd2hSNlJ4RG1wa2E2TDFFcU5PNExtSjNmaTlX?=
 =?utf-8?B?RWhocVpZSnoxUXZVdCtMS1NPTW9mS0xzSU5nOC9RMUw2OW4wVUtzbk1rSURz?=
 =?utf-8?B?dUpyeEg5OWoxaCtWRkhlYVQwdTgxdlVsRDNrVCs3QmtoNWM2eDBhQ0VxTHp5?=
 =?utf-8?B?UUFkZXBXTEtWcjZ0TDUzektsdUVRRUg3aGM4RDRuLzFjbURtT0E4NUdUaTRj?=
 =?utf-8?B?bUEyOUNlSEd1ckF0ZXhaR1hiL3ZuOC9BRXhRUG9HQ0tDbHpVOHB0ZUV6eDNO?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bLzYZKNRSJc+cB2EPlwtKflWUEw+h7lERCRpbxhLxzG8pBF4cXYMdLO2gyyEs66i+QSHjwUQr4BaWJftJxj7+nAlLsh7jkbuxM/BknKbMKzL9RToSHz0cNOggBtaWwkk3h8o18R7ffXDSsZwYcicxJZdD4i5Csm2jqoRWovh55i1yiy4YtI5/kWXVL+k05VFc2JnLHeheRmNXOhkABkI+6EelHBTto8EsoHGylyixLmIK4MIPB9emgeh8tBAY1rC3EOMWW4WMKO3zMchzp5mJxq9As6lKLX+yQw79CskD1YIpTHYMlZuDZhmDJni7txYKWhTNGqOmf9tnrsKpLjqZ67UDY93QIMu2YbQag0RKtOC/gIDjVNdiC1ZSq70wi219wuW5p7SfTioBgLJd3+zGGmjwq6Qp4zCYIG55yN/rHbLb/s0e9hxbv6bzOhvFgB0pJDOQtpbhnzROO+EgRVQijj13nX9P8XYyhYtRZkMZReqNBtOIf+37jKwL05pq7ek/qTFjS/F+ViEc1npMDjRQwgG5Z5hohI7G8ikrPbOGIiV5GPnbr0zfdJBNkYzB1ZLhWFnbpoyqA0Bs1OkgXDzCODvq3fKba8PjvUdnwYuAoQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb21c3a-83b2-4a55-d892-08dc2cdd2b78
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 21:46:01.0320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKjTYnPepufjTxp6dslpNvyd7q35TYu7YsWA3GY2vqwYNASCEF5G8vVPgN1wVcqxPcVXbwxgj7NTcPNQrHkPHZH+ks/+GeJguqTbYo4Mwdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_14,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=781 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130171
X-Proofpoint-ORIG-GUID: wWWKPlu6bmLHZ5gMriy6e2-FezFVD0kg
X-Proofpoint-GUID: wWWKPlu6bmLHZ5gMriy6e2-FezFVD0kg


Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Ankur,
>
> On Tue, Feb 13, 2024 at 6:56=E2=80=AFAM Ankur Arora <ankur.a.arora@oracle=
com> wrote:
>> This series adds a new scheduling model PREEMPT_AUTO, which like
>> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
>> preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
>> on explicit preemption points for the voluntary models.
>
> Thanks for your series!
>
> Can you please reduce the CC list for future submissions?

Will do.

> It is always a good idea to have a closer look at the output of
> scripts/get_maintainer.pl, and edit it manually. There is usually no
> need to include everyone who ever contributed a tiny change to one of
> the affected files.

 I was in two minds about whether to prune the CC list or not. So this
 is very helpful.


Thanks

--
ankur

