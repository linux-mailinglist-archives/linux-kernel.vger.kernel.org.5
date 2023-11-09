Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784BC7E6172
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjKIAgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKIAgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:36:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9841FDA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 16:36:46 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8NJSS3019201;
        Thu, 9 Nov 2023 00:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=lNuiJeIbDoMMFHLKs9SESYy1wqBokiG0HqLEiUPaZbY=;
 b=m3jSZpmA7J+XSuoYj+64K2mmK4gcvBAaREbkzPY/slWHRteq82zPR2+8lTNJ8l7VSL0t
 wv7Npz+UZIXWqNLnHFaf15qi+LozpyPEJm40YeRWlQftWCmL+xP5vsw7J/H7NKuU40rK
 bxZwx0iAdXT720yyIIqZBeundelQ/41tJHIfHWRQ3alCfT2u87HpiXNrahDKvgAF3Peu
 nE6IKxV8yoI4WaPLEevkGzvmvOLVu+meMiC5yIrGBUsDH2HT6itAnVIHh4xuzdFc/nTA
 EWDu0k1VgUieWtCKqilDx43wzDbig9Dzi2CinO/LFDSvKeSRjvkiAthujHSFCVcNgceY GQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w232vak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Nov 2023 00:34:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A90UkIn003884;
        Thu, 9 Nov 2023 00:34:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1xkv5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Nov 2023 00:34:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YF8mRZ1HS/ix8HqoylxcB32IW036KiYTlOSQsY78uvMeJRKH8Mig/N5yS82IvVugsZN3AB6o3I8lYVeXmSFKNjJmY0teEvrqemJZriytayteFf1eZYxMcvYleiNLmZvVJxn0AmHDkrm2M2MYw2ALSfwQY8+0PR4BFaa0QEZHOYhRwW3EgyROZwqiO8GU+RDklP+O6y8oHZB65iIwe27ouVvS9fyvy2GuDsLG5tfM6UB2om/iLiUlVuDygA86QhzBE91Cvuq+NAX1Uaw6NyaHxeqg5TwEiBr/TV/XAHd92FcmQ4kdtaPXD5/G3lXzaQSRaUi1mam8WUfwcDjYD5DLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNuiJeIbDoMMFHLKs9SESYy1wqBokiG0HqLEiUPaZbY=;
 b=EfIBdEeyzsIf/5arIWnB073+diyje+1EDJ2frlSAuw3ZuYkx4WzdBQkcaaD8udH6Ke17BsDBQYGrGQsuon6fdsnH09KqphrXlE0W5UONsj9jMtdgQRgpCCRUbN6xjT7Kne4W/z53YFtPmB4I6tZty6v6JZY5kQoXf+Jvvx4bN4WdxAerbzOmHrzQHrNiGKFhiY3XJBU6vqlov2wY3s1HdLN28iaQfVUmn3KgMbet7VGx6M63IyhbFsVvItMdLgdn6C7LR11YCj0KmbIMyvKbEOtustTAXf9pp1uJvMYLYiP13hgumdICYSxjGCRu32YknNUEdB8vn4NO+ooEyCaXjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNuiJeIbDoMMFHLKs9SESYy1wqBokiG0HqLEiUPaZbY=;
 b=ZL35TZJVmn+BUbKNgjFuXO1a7wmYvGkbGxMAda2vqpDWa6dFVVubveeP0Ygs3I6+s/PNpx3mn3+OP1VuTjdCvWT52MmgmxBDwj8vwrKTeHKPHq9f5XvzfHLYCpb+MdmS9ZXgeGrQK9IdHxKTJuDDfDRHrRT3rI5/n4d8rQ76uSk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA1PR10MB6517.namprd10.prod.outlook.com (2603:10b6:806:29c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 00:34:44 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 00:34:43 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <ZUu4Z8a8dPLfW7Ru@FVFF77S0Q05N>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
In-reply-to: <ZUu4Z8a8dPLfW7Ru@FVFF77S0Q05N>
Date:   Wed, 08 Nov 2023 16:34:41 -0800
Message-ID: <87o7g3epcu.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0325.namprd04.prod.outlook.com
 (2603:10b6:303:82::30) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA1PR10MB6517:EE_
X-MS-Office365-Filtering-Correlation-Id: 3422e8dc-6803-4928-f0c8-08dbe0bbab03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rb6iliZQBkMsB/6PEuyMKB+rV5W/bxEStsRuAxhtADxr5IClSv3mqhwCNWAm+Kpr0BKOd7jiRAs9hqweeSbMbeWmBGbdFcaGup0VyfZKcC1T/KXVwtGhbNVpKVnsrWA6Egg6q4iPZxAx4e/UihcmRXegXr9NfICTy22On/l0z9a+QskJvRNfonvCS4NLRT7P3llyCLYdExDJx1ae6NTBAu0BNJZZaXit32sM4+FbOIOhFbcRISCryAZUAEcHMIDJL5C/Uc49tQwJB8tF6QWRb2lXP87QfRQGM97vPMcAbO5HDLeuFo2Wpph8Z5S/EbxFvSQwPsYmbtMcZ5KR8Nrt1PZUTmg+h+/qzQQV6Cqk8gMPzoFtyPtxQDzokMO1uf14ZPJ2L2GWUxS6qgPiDx4agRY9dt8QKKl4gt2lmnUykjWcYBUrPV53QCGwy1RuD6k7m51jPEF3Om9rzx8dvGG6kRvF2ZZLV+nH7rVjrqf2AXTEXiCkGLimNBNshKU8Qi7oSAjnAd/UqI8QkcYcPl9rTNRd790UOugDGkSVQPtlX58=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2906002)(7416002)(7406005)(5660300002)(36756003)(6512007)(41300700001)(478600001)(8676002)(8936002)(6916009)(4326008)(86362001)(316002)(6486002)(38100700002)(66946007)(6506007)(966005)(2616005)(26005)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p7GqQ/SHZIuBoZPch4hSARuB68tx+xiICU3z0ViVjepG02TRAFv3LCk30QtN?=
 =?us-ascii?Q?uWHV2rEbZyv2oUtHb+KrtCWMNJcXbRXQOKxhLhUuQDDeEKbG+rZkpp9ZK9Vu?=
 =?us-ascii?Q?c6avf19PDbjSSE1Pp26UlngY4MZSZpfBoDDB2AX7FH73FvQUq/HxxyphV3mD?=
 =?us-ascii?Q?sVVUQjQVDfFlDT/Ysx9X87mEiKxYXLkOzF/+kkQNYK/2W7O7mWF+XK6JuPLd?=
 =?us-ascii?Q?cy2NXLrSAIpDQXsDAT4LPAemhGaraN1ej3J0yp2Pa3XB6XFUUL2N6C9tNIlh?=
 =?us-ascii?Q?PTW2hwjPUvgjxqq5tNaJ+p7zKWbBDHEoYBg0qK9y0iD3fdu5Kf/H3OfqZGjZ?=
 =?us-ascii?Q?l5WUoLYSoQXAGbbA5C0NEpLB+JD6ljV5uCdL6BkIw0zR/5pVBF+llDxlCinC?=
 =?us-ascii?Q?hwtiAJUMGsKvuusWiA7cvWpaZHpyQTZwjqrJWQVRxag7+3MgIGkIhbVgpQY9?=
 =?us-ascii?Q?Gg6NdWgl0gqP4JoSI5hiT5Rf/x+azuQr86PXQ8it0kmeMvWhh+sYg9hKtGlm?=
 =?us-ascii?Q?nMkmc6jJmnwxgG6PT/uu82BZkwytn9waHQuccTGgVEY6ambZAsL8zDQ4uBqs?=
 =?us-ascii?Q?giJvsC3+Bw1I613Wph0DBMnouiigYzOK1wC9o4VWjijO8Rk8PYwBvlhaYBTT?=
 =?us-ascii?Q?DE24tcAiymi8Nuu1PnEbXijuCOIyisceE2aAnTSH8UnzruhW4k8dU9qQ5CEi?=
 =?us-ascii?Q?ldxaJDsZhUOHGEVT27E6RcYua3w1ZEp/tzePulPM7aNbQrSmArrrAVwj50ko?=
 =?us-ascii?Q?UK6fufdXrMzH7bsXuWNdeSxzMR1AAZjaHjRju4DSjypMt9hK7iFVi21kmXra?=
 =?us-ascii?Q?vlzOntM0qC1TWn4izQFONTD4EFeoZ9qS1ZrrbYfMep+Oks7bE6pn0Vl1eTnQ?=
 =?us-ascii?Q?fiMqhmE5R/TBC/Hf9kPD7WvxSbIbAWO0PAvR1urTh4IrqC3T5kF05S9876LG?=
 =?us-ascii?Q?wIe3dyy/8wJcQlKjYk2omyU57FNK1GGDI8gA2mZkqumjOQHR7MP1rUnrwTKL?=
 =?us-ascii?Q?tZ8J5esr0xQseYBwyCW/Gsz6eLQ/eRANg1L0Uct935l7NSDhbkxzXLd510vK?=
 =?us-ascii?Q?Tcc9h+PlxHnoAkAc+67H+GZcIstwiRoQNjtDlXMm7xSztX0lUWH04bskmUe0?=
 =?us-ascii?Q?1vU7bvngN6ioQ3I5jF0g2XgqEeYta4czOPyNz/vQh+zEAXzSMj4GqqA6nIu9?=
 =?us-ascii?Q?bprCR4rnh5tyipTLbXxyYNXudcUwFqY5Z51rk1Am3JGlY7CebHqxVgImGO1C?=
 =?us-ascii?Q?utXCLWVCJF5dAISTcHWuuT1C3mK9k817u4mZGmV14B4YGriZEzITqrhyZDeR?=
 =?us-ascii?Q?cgtBbOaRw/yWpFYygTiPchXg7OudIfvuuqkSEzIBoAK2OAUsd4RtqEtxudmN?=
 =?us-ascii?Q?dBBgTmS9yMS3h69xgOC6GqHlFiOzQDXBIbrDyRenT5ML6ooIG95MFhqneHac?=
 =?us-ascii?Q?7pc1bATWToatTzeHcGcnscgWI5SoQgPKVxiq6BGQZawJJILK1UPRkFDeDCSd?=
 =?us-ascii?Q?Ksm2m3z3zZYVGoWinBWnqO89P1bt/XZuY7Ee1NGSSxMSyr8/waWUioBdJt0t?=
 =?us-ascii?Q?/aHeH5hl35W2Vhs6unv6LlmbOBRWOwpK9dCMggDZSYlmjvyMaLWssrcGBhoT?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?82RL2Qxv/l64ecc5Jm0ViAgezoUQ0xWt9XxM+/lZcVms9+ri2CSZdLuCq/a4?=
 =?us-ascii?Q?2nNXkJmpDXPOueeiz1yzjIdYKc9AAcSB9ay071JsqzEDKSBZTftoHPKO7kld?=
 =?us-ascii?Q?8UW+B+wMLR7TPcCjUY3AjwHQMjazzyQZY3aWOe9nmofTOCbeHylYlLQRXp7o?=
 =?us-ascii?Q?MgOn2j/fBYNoPHERGQ5sSjktYr2fSCQn5qZUukrB34BRKQ6rWfDekfsKCemN?=
 =?us-ascii?Q?/uc5rz5EEetzHM1GtdXsrOi/PCADbcuUtSJUF0b1FWIFEsKNlHRllnk2A7iV?=
 =?us-ascii?Q?vrg8jh4TnVxFl3OO/jodJZ7OcovenOlO1tfK4qrFaLW3YtHG70+IC0FT0fb4?=
 =?us-ascii?Q?+zb/kkkH4GXdNLv3KFDNJfHQNRoj7/fVwB9tG3vRibvcNBilQGj+9GoFkDrx?=
 =?us-ascii?Q?ItM8fSIIkSzqPewUTjcovOkjes7A0D0C+Dhjh04+0ay4lVXB22g43zES8eoG?=
 =?us-ascii?Q?x04GyNVYsZJZYLKJlk5k5jRGoLE5EYyckODrrzGoIzntl2XqbvOWjFQTa4SK?=
 =?us-ascii?Q?i+zYTfgU0R2Npw8WWxP19aYOpxTSrR4KOYD/YzIFvI/e2qPUJNhZTiDsw+IH?=
 =?us-ascii?Q?mGEFcQQpT6WFStApKJZMDFnRdkj0oSb+0jB3vlno/GsXnO6Wn7zWQFlfQ5cr?=
 =?us-ascii?Q?6EDN5cmzzq8PkK9fpe81NY0W8YmdW5f7FHE8SCJQ5aji/3ewYb3tG2lMIo0Z?=
 =?us-ascii?Q?x45CZqpRzf8JJTpLim3wKqS0WZsDkm/7uZfsUy5rHa1tK1k6nBN+LwLFmrbY?=
 =?us-ascii?Q?jyItYPYEJDdDX9xyMKN4mxb+/LUe5WIyRHSgW//hKEpeOmst/XmN2DvUYfNu?=
 =?us-ascii?Q?NnQTkRTIJ9IC+v547fwRo8muS8JzFkGyJy1dzAYcPQf1QQ8/3N63pfXkrxZn?=
 =?us-ascii?Q?EoUGAX+AlSFus82rNuO3o7wMVe5x+NmdlyBLcteBsdw1cTgsRVGtPu1qoktF?=
 =?us-ascii?Q?gA4WYLDLmBDCgfngA1dD7k0V37FcLpASxnVuVUKDFuu8nSIPx65qFN1A0Iq+?=
 =?us-ascii?Q?+sDD65tZMtlSOUlPqdlC8I9Z7SvDs6w0w5Ko0405c4uLyzh+kPFm8pcSyXQw?=
 =?us-ascii?Q?60UKml7a/MXvXA2D5ASjrI60vQrHilGvUuMM23ZGkFo8hubQagRfg43TQ+n/?=
 =?us-ascii?Q?EJi4qsn9g4/r15BSnmPOXRQmi3rwrR01XndzMDywjujeYK89EOyRkt+n+Vbv?=
 =?us-ascii?Q?/Vyn8m5DONiS0zeeGBeSiG+T47YtmHbUxcg7XG1ja8172EjHEllZECB79Qa9?=
 =?us-ascii?Q?Q9fnqH69zvhZsID1qPAZ4ix/eiXmqeZVAfEsBDGSNnWyZv4/6tWVUvdSMf+5?=
 =?us-ascii?Q?+MJxRVqSAZehdV0zQcfIyRE4mFyDa79yiEhURHUkVDN3Ue8WOKlNQC5Ht+Si?=
 =?us-ascii?Q?vdWKu9suBw3czcQ031CVwr8s8Ci2lOJh3os2MU2B37toO/j5/PGDAFklMvEv?=
 =?us-ascii?Q?vU2keqnAeof6Z74D4vI/uV1JJFzyWDwgRhndHZ3ufAmg86fqDw5ibxoOiSyj?=
 =?us-ascii?Q?Tv7Pro6nPHQHuqfkeHJGkDcQtE9KUyzK1rMC8Kvt1J7jFkRfhqwf6zEAswu/?=
 =?us-ascii?Q?YjcY28dsWNSNLzqGsTo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3422e8dc-6803-4928-f0c8-08dbe0bbab03
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 00:34:43.8628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVNdlhp30fFashUvNvSfQ5/vkeJQ3XYhfFYeF1E+hpw/6x1hNPVkdLvdUfY72AeblP/Pn37rEhqaHHjj/0FFiw5iWAckYzgSkR71TQbdjGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6517
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_12,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=434 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311090002
X-Proofpoint-GUID: dykLzYEMtp3w-82WHufAuFtjfhxCCsTE
X-Proofpoint-ORIG-GUID: dykLzYEMtp3w-82WHufAuFtjfhxCCsTE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Rutland <mark.rutland@arm.com> writes:

> On Tue, Nov 07, 2023 at 01:56:46PM -0800, Ankur Arora wrote:
>> What's broken:
>>  - ARCH_NO_PREEMPT (See patch-45 "preempt: ARCH_NO_PREEMPT only preempts
>>    lazily")
>>  - Non-x86 architectures. It's trivial to support other archs (only need
>>    to add TIF_NEED_RESCHED_LAZY) but wanted to hold off until I got some
>>    comments on the series.
>>    (From some testing on arm64, didn't find any surprises.)
>
> When you say "testing on arm64, didn't find any surprises", I assume you mean
> with an additional patch adding TIF_NEED_RESCHED_LAZY?

Yeah. And, handling that in the user exit path.

> Note that since arm64 doesn't use the generic entry code, that also requires
> changes to arm64_preempt_schedule_irq() in arch/arm64/kernel/entry-common.c, to
> handle TIF_NEED_RESCHED_LAZY.

So, the intent (which got muddied due to this overly large series)
was to delay handling TIF_NEED_RESCHED_LAZY until we are about to
return to user.

I think arm64_preempt_schedule_irq() should only handle TIF_NEED_RESCHED
and the _TIF_NEED_RESCHED_LAZY should be handled via _TIF_WORK_MASK
and do_notify_resume().

(The design is much clearer in Thomas' PoC:
https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/)

>>  - ftrace support for need-resched-lazy is incomplete
>
> What exactly do we need for ftrace here?

Only support for TIF_NEED_RESCHED_LAZY which should be complete.
That comment was based on a misreading of the code.


Thanks

--
ankur
