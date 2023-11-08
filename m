Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DE07E5307
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344166AbjKHKGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbjKHKGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:06:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A316A1723
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:06:29 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A88tRYH013734;
        Wed, 8 Nov 2023 10:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=MSasZ7io/fb5B5m8fbk7Xzwfgk9NOp5iREVQN+B2434=;
 b=cyus+Nv5vnC3oT5ug0K9Kc2e+Va8RUYBGH9DcMi0ly0y0d4qCq0Wku1SYh8SBaxqQdsS
 q3OS2pD+XIfhie3/+ZGPPeChNGJot4Dlx2DEWM6sviAOEKclzyVBGWCpBPCPHMTkAlLF
 TgDleqgSvv5urj2Yc3cPc0ApCjtzIzpZcOrbxC8biKswMwynwYcNUo8pifxPNKv1hrlV
 CvtIEYie8j0mGJX4TpHdkOW1veqVTdywJghTuml6kZS4weRQGrlN7u6CwJViI6eVswfJ
 XeMX3DoSI8jIuB+/W00Cy5iUxjAg5KZtrbOXP72GD6DxLW12oxwC9T+o7Id+12CTcCCk lQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w20147n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 10:04:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8A3H7p003829;
        Wed, 8 Nov 2023 10:04:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wgb2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 10:04:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsIZU5FLGrRou9mUo6os5QWDerIlFQZjW054vFQC4N17O9fMHSbVk21QKCqeFW9Ki2pAX1AhPyq5904AskCIgwlQTUmMCVoP1aPm383DctGWKo/XCayzdpfV6ch29sptSds7EhO4+kq+wsyAyFzSmi5ZejtjcK14IYAkMbeWuLCo5tIR4BWLl9K0y5ZVggLX3GFcJiAI3IZWVxFMbc+u6pqbXrqp/JvxJDt7bMsWlPCXUHdS9hX9UDVFPIa/JwNlRzC2hbGv5Hpa3oofTt1lP1tmIL2T+Ze+xUS3SmiKZPkNNKNFNQrWyz8Fh8WD3aj3QBPT3WKeJDTOTzX4U/mFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSasZ7io/fb5B5m8fbk7Xzwfgk9NOp5iREVQN+B2434=;
 b=O9MNF3qbvxSr5+OwGCsMe8qbu0LChYqIa6ZgNsbFmvYLbUQOcyXj8UalEsN8+2jPk/fEuaDI2OyHzjcCrJZALve6e6GP7uLqcBz6+ZNnHAbqtIjKW7KohKWajHm8Kt+7L/dE/9SsauKicp2oomDg+kzpb3GV9UpNa8Oe4+Wt9TzDgK73M1oZs2fAfHOHcCmrYMrdGhQ97L6476mkslF39j88rEh3k0J9gxv8+kBL4hphOkK1hMs6R/J4ZprrrpinR4RUV7+V+FfufkkrBRfNa8AA5/7GIttEW473yBvro/2OM3ikxkSTAm79Qvt15YFReRhOdBFADHbw1z12EXQ48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSasZ7io/fb5B5m8fbk7Xzwfgk9NOp5iREVQN+B2434=;
 b=xsaH/hYP04sAjtz3UxqGt1ORoXnVzIom40CW+mEbFljGNiQu0NgZkuolCn2ZMdz4GKSJASqkNjVq/40VUwfk1wENSbDIKUQ/glQijgwNgk/pDfcvKbswn+QuajKC6FiM+KEZqSp7PqW76vyyKLjfe9GqOUkDFK9iP3dLLJP9jnU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 10:04:04 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 10:04:04 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231108085156.GD8262@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
In-reply-to: <20231108085156.GD8262@noisy.programming.kicks-ass.net>
Date:   Wed, 08 Nov 2023 02:04:02 -0800
Message-ID: <87bkc4lfxp.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0231.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CO1PR10MB4769:EE_
X-MS-Office365-Filtering-Correlation-Id: cd202386-861e-4e1f-574c-08dbe0420a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0k1VTDg0blcRCCGf4gmnCrTHXOxhZ+Bb5PgxzBNJCz535thHL03b5ef78H5ogLVg9YZ5oD9G9xNYWToSdYeDyCDxUkAdfkYzTlEVDqewn+BX1xOUVjCT4k6YacL1tJeWLDKpRbjEQAOfP0xWXO2L63+mbb134vTOnn9etzAzn+5i4hx13fug5ykRyOnj//NhNSOgeBsbsbRidlMK+uhSi4HlXkex+vAG/Ef4Egq+cyMOZ5QcH6CxVFR6XI6pHCmOdQEvGdCPYXqLMEtVZ20ipGrcrdqaUUtXMcDdbg9EXJicSEkYzji9fjgBseaV10HmqcC2noQc4lBQ/ZGyOZJg4/bFFzMZmA3Y4Llkt9ySxJUVJZ4jqEkGoNA98lCT529kinQ/nh1MTg3VjIM15ek0ELsPGyXUKpQG104lziCJy9GfluwIUCOB/nmaQQhZRGuy2IqNJ/PyA2aRN63cs6cduu3diBDXu2ZLfX9BlPF8uxPVikQ14dCwu256jpjKXzzqV1tIGtDz0D9JgS/PlDrrs+hdexOVcdnLNOLQMroK2h0/qFmNfOXbUqSwGlALz2wL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(366004)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2616005)(6512007)(86362001)(26005)(478600001)(6486002)(8936002)(5660300002)(66556008)(4326008)(8676002)(7416002)(7406005)(2906002)(41300700001)(6916009)(316002)(66946007)(36756003)(66476007)(6506007)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gv3WrXmuXX5HzGaYA2N6FVENZJ6Yk8LhrR/6X4QxeA3/UO8qV/5j/br9/QHD?=
 =?us-ascii?Q?1xdIACrvncC5Jolz7CBjDq6agZAZXkHjhcUf0oDgWBAP2223xlpY1nqtyRT0?=
 =?us-ascii?Q?p4kJLVEc9WCJsQm1zLyKflIvtZJ3tABQ3gj7j+MZpaPWcgJ7xl8lOYYVgrME?=
 =?us-ascii?Q?VOwwe7rTzgnTl0BqdfmSPrjNGBTZKjRHMpWEka4nEzqivQDL0eT19lq8fIyC?=
 =?us-ascii?Q?sOnWrXIaYMJBZyKa4IETuqweAVjBVeIhVV8YInGfAAZ+SdzopZk2dLVLAFdW?=
 =?us-ascii?Q?TAt8tCBISoE/FYR7IfcsRseYECibPnQcDuP73+C0LChfCxCNLnTCxWjodFkX?=
 =?us-ascii?Q?9+HPeDwqSr5xa/duc18PCJPz0/pp2qaMtye/EjItDHP/aX36zspqreEJGi3j?=
 =?us-ascii?Q?TIkXXg5CO32LxvToa0GUZZH7vOVztISJLpai4ZKUu2EEJtE8MSGU8WD+IzG+?=
 =?us-ascii?Q?uhKgHt9wxfcqfAeVzAGJLqUKSgTeFbb8aFMF74hZDksXURi9f0dtMNXbf/nd?=
 =?us-ascii?Q?aDKaY7Fi2jL+0/Nfq4LdCoaUvvJR5az8oejlDIoUcSryo1KKIy71NH67dsdp?=
 =?us-ascii?Q?4EO19Vbu5khJSK44C5xzuyknk19CyXzkL6Kb81/AZCMxT3HBvA0u4+EFCd0Y?=
 =?us-ascii?Q?YUsR+Bj0VFv7byM3EVGHo/VY+7RK+HGcKhAa364FOkM8EfPUZhsIMIfqWhQ+?=
 =?us-ascii?Q?dUFUx7eSngPVa2QWFYii+F8EGQicXoRl8iqf1LfRt8h7AuVJUlAhN70ZNVKa?=
 =?us-ascii?Q?yNulNeaSKmq3Jj2OhsgQwIdK+N6M6ptyNUiSyJF7xr7YFCddjb2FekW6Erom?=
 =?us-ascii?Q?WGg5uFZFuBTceQ93dZeUoYW9ebFfKqhATMZkbWGtqE0vvGf/vOqf71D4SEei?=
 =?us-ascii?Q?R+JLdlOXPGclhuZYzVpkpPEgOWbWBS/4NwlYCb/azd71JvM5OOzE2pb5fStx?=
 =?us-ascii?Q?q69SxEZ3kJbKdAoLqSiJEFvrdoza6iGNZS9r7wPQqHF4BhOILXZWtA6x/a4J?=
 =?us-ascii?Q?pCMh0GKRXAjUwOXKv8sO+CKTt/UMTxRcLXkqV7dxn0mzO+fmTSCZvptqQRVi?=
 =?us-ascii?Q?MJirhC13K/EaZm7HFo/3Baj8wVED0XLmst+Q2ibDcgN2u+m9jBJ1EaMM4jKU?=
 =?us-ascii?Q?g5BeepPqcL1s+9nS6pmyY3flWTtJWH4GXATYLTPh9kfQnT4Wd+TohruU78e5?=
 =?us-ascii?Q?+usmbkK0+Bn4DczjdcM7PCwesJ7tkhXYh5MphO2sRUmHx6cB0Fkuu04Os4Qa?=
 =?us-ascii?Q?5o4Ya3sgzftotgVDokViCTF9nhaGPlkNDq4PdWFiQ68FZ7y1y7PW9ViWR7H1?=
 =?us-ascii?Q?urplkq8NAh8P5rcSZ7Sl+/+3CoNm+yZALjkA+QqoutGdq//+k9QLw6YcIXgJ?=
 =?us-ascii?Q?Pnft4ZqIkCFhe6AEz5PjwhZbOS3kvVC9cTpqQCmNNVPORh9t+8SxlfJQTyUe?=
 =?us-ascii?Q?q6XKs216fRtPA2VjVKr1RwF2A9yiwN3naImlYt3ml1pJIKdYL6rWSgrNlYKW?=
 =?us-ascii?Q?S6mhCnfgaD7kpSMfFM1D1hu8tTdfVU2dVVtUfeuGSHg8Oyba6SIi1CexzaOs?=
 =?us-ascii?Q?3iY7X7zmFWfX4NO3SzeL5UOOpFLRCUCdK8UcmP+z7F5pVQcJww1ee7x50ySU?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/Ku7wP9HGdvn4azvleXim0UpgnQ59SW0gkkktXNflvgcu8O4FO+TEHcs+Kb5?=
 =?us-ascii?Q?wBiuNIBEVFZn1koeqbHRpm3ZnFaDOOTK8eqr2L3GcpF8N40RCJGzfrk3Hm13?=
 =?us-ascii?Q?XDjO5Fntr/JHwpjqC8HCoRFHL8DnRzoijEQL6+lo8saPANeJhEWIAd3MlCaX?=
 =?us-ascii?Q?ySKlKeFc4SjbyQOpuKYwUjT+eetr0TW96dWT57VvpMs3i8W7Ctm1fqG0pWoX?=
 =?us-ascii?Q?uWAFQhjfP/OvT+g6u5PmL14rPI5/gUveEbuUTmfX/bhZ+gUcxccwzxPh3tzM?=
 =?us-ascii?Q?3CoIozwjjfeZvtz20TdFjRT89VxfVJuDz498QrdxQGFYu6PoTEUnc8CkhunZ?=
 =?us-ascii?Q?9xhK1gR/e4y6dEjYA4DUBjUPxlPsmMaqAxAlB4Pvzj3DBjYRAW+9BanBpEXE?=
 =?us-ascii?Q?d3vQp6B6LcFSK3YYphRAkb4K60ZLyBoqbPn2u4olOmGo/1vUxDuL+fAx7YBx?=
 =?us-ascii?Q?mUUiUb3e7nneeb4U4D/fzpxzkc0PEZ1EqPx5u+Sid0gwjnVzanl+jO1QQV5I?=
 =?us-ascii?Q?0YZw/Zx1NlVIg1Fig/gk6KRGnB0YhLnLZcrPwKjhNz4Gjq39qhaghHmBJ0ID?=
 =?us-ascii?Q?PGV/rw1E+7mB8T8PuPfjfYtpKZPxeeJ6oSY5q57wa0HmCaalavaupmrA5Zfo?=
 =?us-ascii?Q?+Oz5Fs0a5CutT28291NAmr0E0RSBoOGvbyWBJGFIScvgQ1dhqdwDuHEVWehk?=
 =?us-ascii?Q?dJDMkZnXTh/1DXxcpbftwPEcv61uiPijUXJifC0g7N7BABQ3QNWgRbK5wKK4?=
 =?us-ascii?Q?Vp6QZWbt8BWWwfYYcS1cNo6F3KfX7+8v5KrtBv2Qm9X16VYflujRJ552srhu?=
 =?us-ascii?Q?DMwG2G0BPE7+X62DiQymveCXYNYnHPzi30Tlc7LOpGRTOEdvvv1TtEyU022A?=
 =?us-ascii?Q?wYEH3yF4JJkS7NbxJgzohCf0WVR7hJ22rFDIPQKYyZZrKKnkiLSemErZXY4e?=
 =?us-ascii?Q?OZx6RfJLQaL4LMN6pgUo0UvkWJ0hqDw6BQhnEGsDFjN2bFFYrHUwvRjxJ2MR?=
 =?us-ascii?Q?fv/vNnqPcW63W9VitscChj2VbOWD96p7xafOHcQDkNOVCpMZeoQGYbyQLXAg?=
 =?us-ascii?Q?IWRwPF2cUAxrwITE/gldea7UJoMB4WbWKa/O1FDybg77tqJ7c0TJ5vHAAByE?=
 =?us-ascii?Q?lKhw1ZTG+rQL2Do7o2+Ku/3mSg3CXWjECO0ISE4j8kbz4y1wuhQhEFMloMgC?=
 =?us-ascii?Q?Wr9Q5na+E1oAuG48aZ5UCd+tXswGV+TIPEUF+rN/yzZ0pe2nJjFsEIKA0BpN?=
 =?us-ascii?Q?G8mSkTBz76UN1vWK2qzry4jPeitckSfFcVZWYXeDKjgDllJzpOSLrXWomi88?=
 =?us-ascii?Q?bHIj7cukDZoLSUw7HbsHza6B8JOdG0AQaTVAQCcRUqH1k9n9KHIrbWQtTSXv?=
 =?us-ascii?Q?rBlUFQdEROnW3s6WXgErl5rxsmK6gz7dZflMLGNOkjHMJ2kQpKB/rteyVj0W?=
 =?us-ascii?Q?ha2d+8flDlpWl1JgFXVZ+7ZXps9t+QKRUoCSHari1TNSIiWaf230wSXuObK0?=
 =?us-ascii?Q?lxuvWl0uSN37GlTK+1eE9gy3EArTq2K4o+lYPARVRV/02B5U9MO8MjLstQ?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd202386-861e-4e1f-574c-08dbe0420a01
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 10:04:04.5296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPtzEofhU9i3dIOFhgo6TKsuTuYj4+UVJtLKuO7PBGNmNynoYgCB9KeB7NDs13OaMLWUMQBUFJu6bUTIkQDJDz1LVrgFGqE+AxvY19QmSJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=936 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311080083
X-Proofpoint-ORIG-GUID: eALSOMPcgk-joyNt0-92TXZPgQDHiK0R
X-Proofpoint-GUID: eALSOMPcgk-joyNt0-92TXZPgQDHiK0R
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Nov 07, 2023 at 01:56:46PM -0800, Ankur Arora wrote:
>> Hi,
>>
>> We have two models of preemption: voluntary and full
>
> 3, also none (RT is not actually a preemption model).

I think we are just using preemption models differently.

I was trying to distinguish between how preemption happens: thus
voluntary (based on voluntary preemption points), and full
(based on preemption state.)

>> (and RT which is
>> a fuller form of full preemption.)
>
> It is not in fact a different preemption model, it is the same full
> preemption, the difference with RT is that it makes a lot more stuff
> preemptible, but the fundamental preemption model is the same -- full.
>
>> In this series -- which is based
>> on Thomas' PoC (see [1]), we try to unify the two by letting the
>> scheduler enforce policy for the voluntary preemption models as well.
>
> Well, you've also taken out preempt_dynamic for some obscure reason :/

Sorry about that :). I didn't mention it because I was using preemption
model in the sense I describe above. And to my mind preempt_dynamic is
a clever mechanism that switches between other preemption models.

>> Please review.
>
>> Ankur Arora (86):
>>   Revert "riscv: support PREEMPT_DYNAMIC with static keys"
>>   Revert "sched/core: Make sched_dynamic_mutex static"
>>   Revert "ftrace: Use preemption model accessors for trace header
>>     printout"
>>   Revert "preempt/dynamic: Introduce preemption model accessors"
>>   Revert "kcsan: Use preemption model accessors"
>>   Revert "entry: Fix compile error in
>>     dynamic_irqentry_exit_cond_resched()"
>>   Revert "livepatch,sched: Add livepatch task switching to
>>     cond_resched()"
>>   Revert "arm64: Support PREEMPT_DYNAMIC"
>>   Revert "sched/preempt: Add PREEMPT_DYNAMIC using static keys"
>>   Revert "sched/preempt: Decouple HAVE_PREEMPT_DYNAMIC from
>>     GENERIC_ENTRY"
>>   Revert "sched/preempt: Simplify irqentry_exit_cond_resched() callers"
>>   Revert "sched/preempt: Refactor sched_dynamic_update()"
>>   Revert "sched/preempt: Move PREEMPT_DYNAMIC logic later"
>>   Revert "preempt/dynamic: Fix setup_preempt_mode() return value"
>>   Revert "preempt: Restore preemption model selection configs"
>>   Revert "sched: Provide Kconfig support for default dynamic preempt
>>     mode"
>>   sched/preempt: remove PREEMPT_DYNAMIC from the build version
>>   Revert "preempt/dynamic: Fix typo in macro conditional statement"
>>   Revert "sched,preempt: Move preempt_dynamic to debug.c"
>>   Revert "static_call: Relax static_call_update() function argument
>>     type"
>>   Revert "sched/core: Use -EINVAL in sched_dynamic_mode()"
>>   Revert "sched/core: Stop using magic values in sched_dynamic_mode()"
>>   Revert "sched,x86: Allow !PREEMPT_DYNAMIC"
>>   Revert "sched: Harden PREEMPT_DYNAMIC"
>>   Revert "sched: Add /debug/sched_preempt"
>>   Revert "preempt/dynamic: Support dynamic preempt with preempt= boot
>>     option"
>>   Revert "preempt/dynamic: Provide irqentry_exit_cond_resched() static
>>     call"
>>   Revert "preempt/dynamic: Provide preempt_schedule[_notrace]() static
>>     calls"
>>   Revert "preempt/dynamic: Provide cond_resched() and might_resched()
>>     static calls"
>>   Revert "preempt: Introduce CONFIG_PREEMPT_DYNAMIC"
>
> NAK
>
> Even if you were to remove PREEMPT_NONE, which should be a separate
> series, but that isn't on the table at all afaict, removing
> preempt_dynamic doesn't make sense.

Agreed. I don't intend to remove PREEMPT_NONE. And, obviously you
do want preempt_dynamic like toggling abilities.

> You still want the preempt= boot time argument and the
> /debug/sched/preempt things to dynamically switch between the models.

Also, yes.

> Please, focus on the voluntary thing, gut that and then replace it with
> the lazy thing, but leave everything else in place.
>
> Re dynamic preempt, gutting the current voluntary preemption model means
> getting rid of the cond_resched and might_resched toggles but you'll
> gain a switch to kill the lazy stuff.

Yes. I think I mostly agree with you.

And, I should have thought this whole revert thing through.
Reverting it wasn't really the plan. The plan was to revert these
patches temporarily, put in the changes you see in this series, and
then pull in the relevant bits of the preempt_dynamic.

Only I decided to push that to later. Sigh.

On your NAK, what about these patches for instance:

>>   Revert "riscv: support PREEMPT_DYNAMIC with static keys"
>>   Revert "livepatch,sched: Add livepatch task switching to
>>     cond_resched()"
>>   Revert "arm64: Support PREEMPT_DYNAMIC"
>>   Revert "sched/preempt: Add PREEMPT_DYNAMIC using static keys"

What's the best way to handle these? With the lazy bit, cond_resched()
and might_resched() are gone. So we don't need all of the static
key inftrastructure for toggling etc.

The part of preempt_dynamic that makes sense to me is the one that
switches dynamically between none/voluntary/full. Here it would need
to be wired onto controls of the lazy bit.
(Right now the preemption policy is controlled by sched_feat in
patches 43, and 44 but sched/preempt is a much better interface.)

--
ankur
