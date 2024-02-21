Return-Path: <linux-kernel+bounces-75511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 957D685E9CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C65BB25560
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECF2126F0F;
	Wed, 21 Feb 2024 21:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iRLBmjQT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UJwc4NVb"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6810378B7C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550269; cv=fail; b=S9kTVxVMDAmtEfGMAg/qAe2SNSuD2eZU0wnpAZfBwFO1qXQ7g9jhHwyQZqeUAFS11IzYK0CNnnWJBjEzly8SYnV3EvwaJQxrdSdHAbuczzaqoYK8xh8hCU5RGiUzLEc7Fjp7WyCIwT3siT+LDgmNriakdWZ4nQwELpUXxkXBRMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550269; c=relaxed/simple;
	bh=+IQvimcf12TvILa0Y677GoTCQxhK2J41+57/C/Y55KE=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=DgajicFsTxbraldVM2KVu6DHMCSzU1W0dIyNrzuhNH0VEJEYwRol/JzCSsMRXM+E2O7/83ejIfd4p3BjGIRzCDNR+U8Oyev9f3saQrVVujcNmjKvisaEwehcTZPVOlEtEzZn/305whsEkgaZanrcI8fL6w5Bqy1NTX27bNFKpIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iRLBmjQT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UJwc4NVb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LJWWex012063;
	Wed, 21 Feb 2024 21:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=FYt6a1YWS06FqfQPnjYFVdNFMedrsdYLtARVALuwlJs=;
 b=iRLBmjQTrEEqZjoxXNhpBiwCmgPrcAFUIoXjRo1dRXVb0fYlISbDIqeoAymg3Gyw4VNu
 5IlCYdR5xQ4R5NudPuCXu0xbmA1DOZwsOtcc36d/7+DSGxpixlaI8Epmq2EkBvww65e3
 j1Lk+J24xbly1PPHI5OKSUbjoYaPiTG+ILBHHeC5vpfgwYeaKiae5wZ627Nlwqf4WMte
 +tlq95pXTcnzi4T2bkbpbiuUAXxSlVKzCSgRAL9EmBjvL/tcuYPevADveVcNGWUzzl+q
 iNVMMl1N3tmo/w0iPWtmKhpSILIXSvHe4l2ii25aEbR8P3MpOAZRreC2VRdGLm/eVUp3 7A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdu2w5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 21:16:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41LJZono032534;
	Wed, 21 Feb 2024 21:16:27 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak89n94v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 21:16:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oX62g+yyJuSY8bfzskh9hkX55bE5CyJQF1g7pae3a/8pAPn5dcPC4FJuHsa1GelGak4ZzOl2GLnUG4Yg64lVnAPAW5pGlHJY9wx/WkB/tA5x4Pg0IbgXJ8e5KbdaDKKz2uSWzHZ5m0B/Vmw5CeELODrDPmfByfHd8iTtDubaP0YKFh0gxn2vZ8Kh0C48pZNE8yE9obLYYLCl4xtERY8XxDgp+omOp7xM/qvmbwtwnsdozsHdqkLlUGSorp16Oe31ezUHeWxfCl50B5SrbLFWLthz/S5dal66G5yr/0WK6CMQgd/TQzUaWVf6oXmSzkWwdUG/i+6E0OuPsMOFNP3Zvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYt6a1YWS06FqfQPnjYFVdNFMedrsdYLtARVALuwlJs=;
 b=SK5/O2X2//GsW7OP8MlXabXbLFJxnuhhyT4vJ/FF7n3/3XzT5+WzkoN3ypIeyNxJJ+5eNCMiKgOEOqxTfv1YD+uq22Dx9Rogl5HUDAg6f6d8Ahdwy0tAx1F4Bh0rKijKk0dHD0Uu8U5RK2v3f934UmKCnXPjbjTAviw6bzwhhvMG27UxVP7QUf+euOopi7F4uQPS0LZhTo9QNd1GWyJnoWvN69LT3evosIi//T90ARXFUfHFt2IcHJ5EJVS+wmZUUDiWvIQcSdqpXh2NSi0mmoO/gAAMBCujxcGTXHRlBvli36TwwUKdbcUKI5uC7YoYliJNuxPoNkTXelQhljoiEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYt6a1YWS06FqfQPnjYFVdNFMedrsdYLtARVALuwlJs=;
 b=UJwc4NVb5yV/UALe5WLFbJkHyBgyqGGTMbdWYGTpC7/3rGM0T0xwS8T2lhDRJAR0j4Yopc4CHJwPJ3Ibh/R4dyCbFwVdFJ/MYLmWRVVY6LRHfcxfMgPXvPZM6d02sLtzVF/uHthB1y7vAmZNUbSt1a/XtVF4CgEKvfmbTbWxIls=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA1PR10MB7712.namprd10.prod.outlook.com (2603:10b6:806:3a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 21:16:25 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 21:16:25 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <15fcf98c-58c5-fa08-2e21-f3b0baf058e6@amd.com> <87zfvtg2mh.ffs@tglx>
 <f1a5fe09-f4bc-0dc5-edda-6b3e690bc0e3@amd.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Raghavendra K T <raghavendra.kt@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora
 <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
        mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
In-reply-to: <f1a5fe09-f4bc-0dc5-edda-6b3e690bc0e3@amd.com>
Message-ID: <87ttm1frgf.fsf@oracle.com>
Date: Wed, 21 Feb 2024 13:16:49 -0800
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0279.namprd04.prod.outlook.com
 (2603:10b6:303:89::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA1PR10MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0889d5-32db-4d88-6ecf-08dc33225c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fN8AVogSpwB2twZBUEUPpc6yEVuZUVT+KaOpis68Y9QCU0YeLvHvF4MiyhNJxdvGJhrcWBJ5gcb6y+XtzuptWSwLr29i6c9JW7a30Ue6sXNslC0XGD2euttWF07K6Dt2un2Ktl/zZ1BkJ8FVS9j9T8oe54zh8JZh5ujdkIrHPZH3b6A3wD+F15SDBXbGMIzm2CBcflDZziI3On+VoqzeDu9z08yjpnz7MZKzwdb385NN2SYRJR0hKKfQKowps4Vj3aTA7RdrCvBb4I2X/ee5JPOX/XYU1JpVMQfFtmi0wBoh+3x443dvgWFWKQjE1nK9QzDqRMdSPJJzn2S7KpMTsSUy9wqhLJVhQJgoHEuGAqY+LgRrCpmwD9grqWzZyPL2OEr2EXs5O/mO4nZ8pg5AklmnxmvPjsFe7Z6p3SrEpIbRqTGraaCYFwhLfKVT1c2CqipzUvP0Vgtbvubz3dPDZdLAJgGyo8Dsse0I+44LEvKlH2eloEEaENiX+1sn8yiV+WgakzyVn+LkvNNvUrx9BO/JG2yrljVpPd/V3SExoZ4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QFhyxCCNPPYDvvhOjv7xyjx3qyWaa/X52WehMarfoX5AJDEgbfr1r/wO3r8a?=
 =?us-ascii?Q?fHgkAnQGPMhw70wMNXFQHctMQzgUt3liFsU+dVP3c6msMXDqJGzKznOliCE7?=
 =?us-ascii?Q?4epx7oMa1aQ4y/hi/2pGl7clmQeS5ia7m4XHm4s1f6XUmTASXo56Walcq+zW?=
 =?us-ascii?Q?0nRM0ofPPug/oHF47Gg0Gj5w9V8pobLlomE/IQ0HwyxP5viDaSd0YSGkfyvh?=
 =?us-ascii?Q?iCGtrAQwxZrSCzW6yDTNKiVc8Q2OnMm5iMiJrQFtW0IeEEpu2q87+2Dj2QP+?=
 =?us-ascii?Q?abq0ri3YW3ffH+h0u3Zhbaup9WzakJ0KLtSNRzhMFiMo7R51l9q1L0QL9ASX?=
 =?us-ascii?Q?IEII1GmQa/HRPJptSLhzE2+q+ITmMTanXkrNSRaHpSIZxKrPrehe4BM8SBSq?=
 =?us-ascii?Q?VVNNC8zxn90cc2gZtaLvRKd2DVdIaBHMH3MlipTJA9ZoP5dF6RSjwEKUsXbx?=
 =?us-ascii?Q?Dhxh7NI3AdMC4qD4YgXnTSYcwTKVnEBZwl5aKyzUGv3FhnoK9UiZQAz53Z6D?=
 =?us-ascii?Q?m+ejEka/ZKbK/GDUcinoEUX8B898n4iqr+eqXss+RZhw4mbgyenqCl/YSAcZ?=
 =?us-ascii?Q?yfxsLzDMIMQXy0o2LxE27SfdOqG/i2HpzfrtudY6haMlXZzsdEkGsL46rFbs?=
 =?us-ascii?Q?CMSjNM3YvWZzGwtvp9NaTPkh2g92oO7Eb/2PPrLAv6z+mBncAUeSxhsShAgg?=
 =?us-ascii?Q?u/EhJq7HlevTqKosmEKpYowIJq/hMNDjbVIXJfb5xBFBnZhIhxkYSqRYVDpb?=
 =?us-ascii?Q?PDdjxo4/vEY/e0AWseXQH98GaVYVvA6Whud1/vX1BUuz9LkC0PsP6xPQGo5o?=
 =?us-ascii?Q?SARBq/MQwR/qjkfBLNSrL8NO8Zmrm4t7Wdpl2ZmgiXxKhbtDNSg7g7CgjUtq?=
 =?us-ascii?Q?TJ/bOGdyrHFx7vp9+Hc20uzBVzgWWUgcXFL4ZCE+ucGjq8zJdapU0wdXBHKm?=
 =?us-ascii?Q?jfOzz4pbNDdeQSq0wh3HKcgQ1UGByKPZk7UJY5jZoCZ+F5E58qs1DBlVMjS/?=
 =?us-ascii?Q?Eo8keqyVvZQrD51yigPNxq+/MlwTS/oGpww3RfcmESvqk51UI+I4LJ999uqG?=
 =?us-ascii?Q?e2v/wASkYMbxxpGnUVk+rwiGjpW6bNLnzcJSITIfWX7IHNX16QFcLHjPJHs0?=
 =?us-ascii?Q?704W8tllilhuv1eOpa0J6YMkEsRgGhy7he+iGOk2qJjXiZRZNyoTUB/571VR?=
 =?us-ascii?Q?ubGWk6vl6Ra+7jezPzz0m8LEm1UWbQELddjQeAsSQt4uMjSdwfyMK0GTrKjE?=
 =?us-ascii?Q?csjQgjqJmmlDfS3vMdGeBMcR3mSvuYgDewBB8mBFgsaphZjs418sSltJoIDN?=
 =?us-ascii?Q?gxQUEwkHvQD16TiddYbJsMg5J4aYxtjpdiDS1d3NPWQSNZzhsULGrsdLVF2O?=
 =?us-ascii?Q?xUfWmrVg7fMduqTB6TusxYvQWxRg5KlzhU9zlRenJGzwVMeGoHKQq8gwSPeG?=
 =?us-ascii?Q?eaI1D9I1axkD4F1KPca2KbbauV74IMswfV2iMxbH1Rxqb3Y37t6LApX4Jctc?=
 =?us-ascii?Q?FIzcsL6zQtnEB7PQ6CEQf4WlDMAoBXMIs5+8KP4VwMdIO/NMqHyALQUb3TnL?=
 =?us-ascii?Q?QilmYzEcGA0fGLfDZboMHbUPO5lUAr1XmH7yScoYHZbVP6+GmgwB1We6kdTM?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jOOFjOE5ZLjgLWy7XHaO/G3EU9DT/lApbyF1Ri93w5rN8WxbmCxoyMWAUnh0fwWHZ8dFQltuulA6QOXP3yJbzFysEw3J/6wzpHOxcCYyVnhL+1hk/KRUUn/Lv86p2zBKrWGofmAG/pMT0TGaHokc0c3t/ZAEnF0Rwhu2rr2eJa/ofJE1BzXQsJ1jsTEXttOaN5/j6UuDkPDf4eQf8pGEzcyCFDlHfDh9I9+7xgv8eha+q8sIhf2K58fb1B+STn6JiY68Ex2M8Xev0On+w9qH6ua3Kmj8giZSue4Vbd94cfPNprFayl8LUk1ShyEr+WuWknMbP1oL+NzuiKCBFAOISa2MqkKMrx8a/Tf6+7OpJHNCOME0ki7z3NUvB+dxwZP7rHL3NPIICzky7wF3L5P9jTcW4FwQTkLgjdCKYr5sORFR40l3BgK9Go9PjpM0BqsQSZpsilnw0J5Zk01gACGJCA2BVbz/f/IqLe9eywUAxxkRWPmR0pjMy1499LHGKKnucF1cAKf3WIQi1aUkqYhZUCsLD+ufOBs3CP5YmkMCTwyZxhqmGQDM+ZnAtSNMrXwEKoJmjKOSfE1j79LDuk5KeWCDI5lxXz3Hf3wdcg/ulOk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0889d5-32db-4d88-6ecf-08dc33225c9e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 21:16:25.7340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLa/Og/UW7Gm9Z8s/icn/2pr034PXVAPz6mxxJTG4JklvNj496HHwPcEp3DJ/wyeXY7BCF2+eTcqC/vId0QyNHdjtSRC9maSAVBbCPrNWKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7712
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=905
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402210166
X-Proofpoint-GUID: CiayByfjVbTol-c2SwWK8UnliygWVegb
X-Proofpoint-ORIG-GUID: CiayByfjVbTol-c2SwWK8UnliygWVegb


Raghavendra K T <raghavendra.kt@amd.com> writes:

> On 2/21/2024 10:45 PM, Thomas Gleixner wrote:
>> On Wed, Feb 21 2024 at 17:53, Raghavendra K T wrote:
>>> Configuration tested.
>>> a) Base kernel (6.7),
>> Which scheduling model is the baseline using?
>>
>
> baseline is also PREEMPT_DYNAMIC with voluntary preemption
>
>>> b) patched with PREEMPT_AUTO voluntary preemption.
>>> c) patched with PREEMPT_DYNAMIC voluntary preemption.
>>>
>>> Workloads I tested and their %gain,
>>>                      case b                   case c
>>> NAS                +2.7                    +1.9
>>> Hashjoin,          +0			     +0
>>> XSBench	     +1.7		     +0
>>> Graph500,  	     -6 		     +0
>> The Graph500 stands out. Needs some analysis.
>>
>
> Sure. Will do more detailed analysis and comeback on this.

Thanks Raghu. Please keep me posted.

Also, let me try to reproduce this locally. Could you post the
parameters that you used for the Graph500 run?

Thanks

--
ankur

