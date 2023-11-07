Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DAB7E4D8F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbjKGXpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjKGXpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:45:04 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A841101
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:45:02 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJjrE005490;
        Tue, 7 Nov 2023 23:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=wVQRuux3z3gJKIIlGh7oQ2vb6nJ+zJA+msnf2lZr7qc=;
 b=ajxyn59nQ4my4i3zUe/GRM3SX2kdNSVQNzA3fTzkHVZViuzl05ia/9n52S0isicz/dg2
 EWTDGdEjAzSE46fBWJQcb6QCmyNNHtDwdm/REeZlVw7YXg2qGgX6ucE+H1Q/E79KbFEU
 9S95Wbbu/qKl7DReS8N4058dJMawVDZSAS409GpNc7x7CDu1Vmvcdn0c+S2KKTisNHw0
 Jmwojqh+ihJ+g3ssXAMMOUVEpFFWtgmvXMouB+LuHKjjjaF43ovddtt6YVNQJVtWsP2U
 Nziv+ufIc/wC6EK88i9NhQebQiKPH2FZ46zOVzGLTPGnFtDXNZtR3GJwM/PmuDHZ3ve+ vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g7aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:43:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N3c9w003937;
        Tue, 7 Nov 2023 23:43:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vwd5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:43:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwzPyhfidBgkfiqiDC1jtR4GjpOEYthIAVfMvmFdIT0WN9YDSE8oWj0/w4o+WXcZpFn1xtJ2YiJ97m57ddMgd1rMXAFVV7yOvWNzfvJRor8U3AjRMdLVRhYb/uFbl1H7uWJBdjjLKcFPB/T56Ix/RkmZ6ymDnru5U29WDVsetgbPn2Sw3yRI5Wo23FUDNYNKFmzqHnyA5OdMewEKP6wVR5X6GkR2iMhE6S1nyxkoBffsw7XPoMxcXwW4pyVIPJdp5Mtj4fmSAZMxJD0bEwmuiA2UjvnDA+COxeqsjHgudBYOXkgHNv4ZAO9BitEdFNj7kIXa/mjiupyEwmVZNIj5/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVQRuux3z3gJKIIlGh7oQ2vb6nJ+zJA+msnf2lZr7qc=;
 b=PPbg/ReJwbiFt9AxrHbMjMspbpBL5z5po+G3EgywxtgxEMx7t4hGyGi9Syq18tjSHw237xofNqJauOsUw5YF8nc7G45NaXd1fQLIm2Unc0tE8Qf9gXz6kGcUxG4ho9J2NAJETKssNqHOqdnNicn7teuNZ4ODF1cfEvHrefU4+d3AITIA43RAMiu4n02nsCKuTha3Jej/lhQCZ3mHet7lGemgjjN9Tc1MvDgggMMMPIFb3jTxitiZxwSuM51tTX+jc/gJ1JqW7FuAHKeYMlJs+HBXe06RgpqNLbLF3ownxsyKQYibOO6jKS7rJvIHMYAcCKtyynMuBIFYCez+F3WbQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVQRuux3z3gJKIIlGh7oQ2vb6nJ+zJA+msnf2lZr7qc=;
 b=HHqqoIiCEQzS1urHMuK3wf2vHFXNXjv0iKiXyPUjYTlLNnTuIFR2MddzXm004rfdeVWluaIHMIYhhdpYPE3EujtYwJM6rV8WlTjEnokMomwjv4ONFIO5IJrzZHttyKC4T74BxO0IWyGegQ4qBabstLgYSn0uiZsxSw6oB+KUjTM=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 CO1PR10MB4419.namprd10.prod.outlook.com (2603:10b6:303:95::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.29; Tue, 7 Nov 2023 23:43:43 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:43:43 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107180153.4a02d2ba@gandalf.local.home>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
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
        krypton@ulrich-teichert.org, David.Laight@ACULAB.COM,
        richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
In-reply-to: <20231107180153.4a02d2ba@gandalf.local.home>
Date:   Tue, 07 Nov 2023 15:43:40 -0800
Message-ID: <877cmtxh77.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:303:dc::26) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|CO1PR10MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d155e1d-21f3-44e5-a935-08dbdfeb6059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLnYPoBQin2azzbr+32gSUY/fbRE0AEdgAvTubCDS/u6xgUYlKllQy4xB3tO48oDnR1lh9s5HvxiaKJZN4xefS7lS0Gk7TQcIdYbi1tP0fOSBQjGvNa4l7g3xaj9ACtHwcrtmfE0n4ve8MeIWI8/dQHUz6fAlMl/IVrWtjVtGTlGHqPZJj4znid13vpUFNcwA1xWCPwe2vjqUWaWJP3ODHRmEtH+ctozKVjW0vVcsciGoW8zHvJr1WsdegU2qTArh/VH0D2GVGePFRVGpo1jlLIFCVlEqhOo8rWBZF2L5G89nwo6oAsMddVJ1f2cXLXbjxhu6EnRUlDK0NhSg3HDm3VjvTMFUc+Hosl6NEMGwwsDyd2dsQV3yS2k3gK5SIWrd+qbBxhMZUiT44PCmIpSCTndU1yJXIjRuo48XVYE/vi/iK6tBlb7KG8omOYY/nhTz+oWE01fXLpMRTFGdWnkKo2+sw9ihoLlIP4YnbWbjf/QaZiIGNmMZtIFc/3/nBOfT5Ng55kIbTtRaKOiNGMp/fx7NIq47CQ5cXlvztIQktdAVLrv/VT+dev5pd6j4erj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(41300700001)(6512007)(66476007)(66556008)(316002)(66946007)(6916009)(6486002)(478600001)(4326008)(8676002)(8936002)(6506007)(5660300002)(2616005)(7406005)(7416002)(26005)(2906002)(83380400001)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dQCTTGd/dO6ZqA0uCxqfY/xHtLDGn6C4WE1pNipL5HHkqu+nhNolEP5Ly7ud?=
 =?us-ascii?Q?qNS4n5vLfvvzLjBosUlwe8LmZk9AzHqYJko2Lvd5TaWrpYt7Jkm8DDsQD1yb?=
 =?us-ascii?Q?DOKlpzPnBv6yIc587s8NrRW7+J+57/F/apM32H5D2uHHEfG5mXK8jk54m6vG?=
 =?us-ascii?Q?Q8W43SgsV1Y+b789PTtwjm0ngIou9jq97Ec9MbcZI+PK08Qx47BauNlkVch2?=
 =?us-ascii?Q?1GaAseABQGrG2x3l/pgMhus56gQrNsByfJM3yqcBb6+xYy/J3tOnp0fZkVQg?=
 =?us-ascii?Q?f7jwkaS0T4zqe9l4mqqOYiqxk64shPaNX2DTSovNs9n2tIT2A4cqIv9FQ7bE?=
 =?us-ascii?Q?aiIEopggvCLz22r/jIOdFJduQ6EAk/YgNkhXiBWmZ4nKDqihOYE0YnU8qOBu?=
 =?us-ascii?Q?uBPGTjRwwlbvhNw5fhUtMhGlz76+soI/pSUm3pDhLaw84QrVQHsOIFf1LUp9?=
 =?us-ascii?Q?j0xzoJ4iuHIC2X1cyCDcG5yhNhVUvfjDk2zD7qJljUuCl3Xp5y/mrlsdfpn9?=
 =?us-ascii?Q?cPb2uImiV7U3jj41o95RoyvfbYLYkB5l9Jro+5sP0x9CTFSo/GJx691uCGzD?=
 =?us-ascii?Q?gHwAVfle0xIy6NMQIQhpSl0+23OuA/nnrX6tG3AMXay2FgYUgZ4BsQjhNFNJ?=
 =?us-ascii?Q?9pCj8A1an/bp2zG2LuGmjf5wl672hlnh2VDJEeN/luHgXYQh59oC2/e+rZ8T?=
 =?us-ascii?Q?hCeJ0sUjcHBtU7OZ5E6Hmp29b3Ja+p83tu76Yzn1xh0YGZkgQRHHJ98Bwimd?=
 =?us-ascii?Q?hh3FuQL3f3GaNLfMtwlCQx+UuNIoBPy89AC2Qe11voXyJGOyZG39CZOSmXas?=
 =?us-ascii?Q?h7a0B66J1HcZxB0ErxGaNkr8Hv4P3U4RNFYU92P5wzMNFmlDIjvMjp+SX8A6?=
 =?us-ascii?Q?cat7e53cg2CYNxxAcBPXnsezoCEUaQwhiZ+ly67RdacoD8P1pU7Tx5CIsFfj?=
 =?us-ascii?Q?fAXJCp7PpEvqC8Te5RS7CGwpkki9lCGvJ0TPihuxevJpjUwexwLmtsevvQCy?=
 =?us-ascii?Q?xGQoV0/D2SVVMenQM5d1Y08m9H7/5akOY2Dp1Eae23/0T26C2OZY4zagV9bL?=
 =?us-ascii?Q?mWQSIP+r2BQMGguY33DIsiE66m0HwMwj5b4+1DAKNQoyzwFQcf2+9UnwH0YE?=
 =?us-ascii?Q?2jV5u8Vc5+k/tYAqYy5Btz+gHTlEdkN6FxWzEb078L9iqeic4ZBmB3hTjwkT?=
 =?us-ascii?Q?zfDld+8VwbFpu+StcKoQ02O64Jx2RupSFKAZA9IFnw5hWJxHIXh2MokQE0Yy?=
 =?us-ascii?Q?Po7JCcRidy5vydp5T2juqjvMoIlZy68FKeFzR2wZ7kxgGXRfWa+r3M51KBln?=
 =?us-ascii?Q?KiXlj2v8XOW227sLgdNG2c04x0cXtHZ0ec/DRyp4TMF//kUAPTDDNltgK92b?=
 =?us-ascii?Q?pnPFJMLmRHhEtyd0VpgT6zJ3dgGUfxTSl77ZqHcb8Gf26WleerDsDtKulpB0?=
 =?us-ascii?Q?Z8iC8zq3o+FYgFR8Pgb88g+JQaPQ2R5KruBN5B6MCuHBeZh5NQfXKLvhFR41?=
 =?us-ascii?Q?ml5QohqWIY3qDQQseTrkKZLQcONHJjP/FILE+ofa+veuDrNxREMMiMU0RVKh?=
 =?us-ascii?Q?EOPnXYqo64kwiQK2v+kkiyS7qQ6JhXc9QamkJnTDBJ3J178Clw+UD4cWeU7G?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?WpbZVinWHUYsevfeNt4hkWoiyhuP0hsCjdkQu3IwRd03X5IXtKZhpyleq+Ht?=
 =?us-ascii?Q?O1ezRJLJxfxf626EhA/Sj6GSQ8OSFOFYSCJIc3sm96YRVXUm3DOt8M3dil2q?=
 =?us-ascii?Q?11ewJFkLOsfRfknbRkrYbIpYgBCGTj112g7sk6h0Jgosf6ps4dtISFQH+dbJ?=
 =?us-ascii?Q?yD6GIO+BvsoHf6q5kS5DkvY6J6ZYBpXeufLSZNc3/TeYlnW7tDr3mHV3XwA0?=
 =?us-ascii?Q?FfOiuYYbkBiiXgXsvi1PeK3I/wCf3nm3vNdVivBB+shqL/HxZbHj9rK/2LtZ?=
 =?us-ascii?Q?f6z0NPgEXobAvv0rD388aZd1eIvjmL2JTRJGTQQy8wgq3yonBsyVGrJh68pb?=
 =?us-ascii?Q?2nBiirapRWMt5CWcv+vTtUtfqJ3bcihgidYhVpo1go8I7pxRBXP2w9yO0dwi?=
 =?us-ascii?Q?JQrY9P4OCB7xa6I3li2VgsrV4Jie4NdXO5BHI7irp1uHtp/xnjyACinh1XrN?=
 =?us-ascii?Q?RDOQxgkRCIkHtfDRCrDkc7lKkMtt1dRNigSdgELXwktfhT2K/Da87jeBH+da?=
 =?us-ascii?Q?Bxhk0A3wFMPQj2+GTthkvSnnMIdS9qibc4U7GoAQh3dIpsjoBrvewILW5byE?=
 =?us-ascii?Q?yjdC19RiismT5CqYS4gSo1f0d2T8EILPhmoa6l4EOkRsaQGCCYb9QCB3PCv3?=
 =?us-ascii?Q?J/djQdYKpEP2r+sILJ8o6JYahWUmJZ245PbDSVva4yNx12RGKppeSj8nkkvd?=
 =?us-ascii?Q?zn+FdQE5FPUUGKXF173E8oLosUIp5tH4455CIrsF1nqYJQnsMV26X/hDcu17?=
 =?us-ascii?Q?dkOvJAiWDa6VIg+uKarKMMiwzjXnTgPTlBDtfkZmx+UOWJWVA71Lx0TuDodk?=
 =?us-ascii?Q?NiW3Sxv2V88TZNL6Eg34oBtcA6ksRoJt1boCGuiBfDSuSs1DZQ0PGyzOEzxJ?=
 =?us-ascii?Q?66R+gacEUAsHUu4+Dk3Ae+BiPLF9SDkcWrmVM45op5fpWWgamMDOsc76Pc1d?=
 =?us-ascii?Q?r6MIuqhUtfqkl2FTi5xSECc6HXt+4g58aMo38LSzhRlAEJ4kKT7hvUTeSmjx?=
 =?us-ascii?Q?v2yqwDYOwmnjZfKJHBLhgiY94rokt0Ap20yDpD2IAYuuvCKvsullux386ps+?=
 =?us-ascii?Q?GVKPHynIc3d2+jC8Ycb3ijqV7ED7KLxD6QsL4aAwMggyYo4Ot+CyIuo1dPjE?=
 =?us-ascii?Q?UfEQW27FgEQc6N/BJLMNxKfPeBocNTgKctbkh/8QUcwg3utnhZQgVLmmEhAW?=
 =?us-ascii?Q?IOYTERXRGd1A9xGrhoMMHEcS8DV1c2gPdFwD+SwAktfqg8acKLIMBRA9Q5CW?=
 =?us-ascii?Q?IFbrg9KbSF3EIWb7CdKIFbSOvA823hSNnq5BeWB70uJFUDHgVbbNCck8KTpj?=
 =?us-ascii?Q?m1s1Er9dp9Mp8M/grxTEzk7fQmkeFlAfwmHTDKeu4zlzJNotzVYPjRc0n3RM?=
 =?us-ascii?Q?gt7y4gdVzttMN01Ghg6MoHxRPM34ZcOCaNoJ5EAfu0NtpRCgi2a6Fwe9I7UJ?=
 =?us-ascii?Q?mC5S2TuKesV//bihSssQCE+wO6Ggnskc76PQkNIx+xBNe6noteonsanSlri/?=
 =?us-ascii?Q?YsckHM90pbbtYM7uWN7ENrithq3LnPt3uxVRcHO7nACIbv9VnK6vKz6HZw?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d155e1d-21f3-44e5-a935-08dbdfeb6059
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:43:43.1912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvNYdGt7KziRJvhc47HSUbompWNVKQKV7h0qep4dZkDjGxKXuyxgiAzwKiCym6IHUAp9J9JrVYFZA7SNaXSIOLWTsRGkZtReR0+2Di84FuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4419
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_14,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070195
X-Proofpoint-GUID: 5TILQTI7tXOgJwTPMpxVTE_ERzQ5kL38
X-Proofpoint-ORIG-GUID: 5TILQTI7tXOgJwTPMpxVTE_ERzQ5kL38
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> writes:

> On Tue,  7 Nov 2023 13:56:46 -0800
> Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
>> Hi,
>
> Hi Ankur,
>
> Thanks for doing this!
>
>>
>> We have two models of preemption: voluntary and full (and RT which is
>> a fuller form of full preemption.) In this series -- which is based
>> on Thomas' PoC (see [1]), we try to unify the two by letting the
>> scheduler enforce policy for the voluntary preemption models as well.
>
> I would say there's "NONE" which is really just a "voluntary" but with
> fewer preemption points ;-) But still should be mentioned, otherwise people
> may get confused.
>
>>
>> (Note that this is about preemption when executing in the kernel.
>> Userspace is always preemptible.)
>>
>
>
>> Design
>> ==
>>
>> As Thomas outlines in [1], to unify the preemption models we
>> want to: always have the preempt_count enabled and allow the scheduler
>> to drive preemption policy based on the model in effect.
>>
>> Policies:
>>
>> - preemption=none: run to completion
>> - preemption=voluntary: run to completion, unless a task of higher
>>   sched-class awaits
>> - preemption=full: optimized for low-latency. Preempt whenever a higher
>>   priority task awaits.
>>
>> To do this add a new flag, TIF_NEED_RESCHED_LAZY which allows the
>> scheduler to mark that a reschedule is needed, but is deferred until
>> the task finishes executing in the kernel -- voluntary preemption
>> as it were.
>>
>> The TIF_NEED_RESCHED flag is evaluated at all three of the preemption
>> points. TIF_NEED_RESCHED_LAZY only needs to be evaluated at ret-to-user.
>>
>>          ret-to-user    ret-to-kernel    preempt_count()
>> none           Y              N                N
>> voluntary      Y              Y                Y
>> full           Y              Y                Y
>
> Wait. The above is for when RESCHED_LAZY is to preempt, right?
>
> Then, shouldn't voluntary be:
>
>  voluntary      Y              N                N
>
> For LAZY, but
>
>  voluntary      Y              Y                Y
>
> For NEED_RESCHED (without lazy)

Yes. You are, of course, right. I was talking about the TIF_NEED_RESCHED flags
and in the middle switched to talking about how the voluntary model will
get to what it wants.

> That is, the only difference between voluntary and none (as you describe
> above) is that when an RT task wakes up, on voluntary, it sets NEED_RESCHED,
> but on none, it still sets NEED_RESCHED_LAZY?

Yeah exactly. Just to restate without mucking it up:

The TIF_NEED_RESCHED flag is evaluated at all three of the preemption
points. TIF_NEED_RESCHED_LAZY only needs to be evaluated at ret-to-user.

                  ret-to-user    ret-to-kernel    preempt_count()
NEED_RESCHED_LAZY    Y              N                N
NEED_RESCHED         Y              Y                Y

Based on how various preemption models set the flag they would cause
preemption at:

                  ret-to-user    ret-to-kernel    preempt_count()
none                 Y              N                N
voluntary            Y              Y                Y
full                 Y              Y                Y

>>   The max-load numbers (not posted here) also behave similarly.
>
> It would be interesting to run any "latency sensitive" benchmarks.
>
> I wounder how cyclictest would work under each model with and without this
> patch?

Didn't post these numbers because I suspect that code isn't quite right,
but voluntary preemption for instance does what it promises:

# echo NO_FORCE_PREEMPT  > sched/features
# echo NO_PREEMPT_PRIORITY > sched/features    # preempt=none
# stress-ng --cyclic 1  --timeout 10
stress-ng: info:  [1214172] setting to a 10 second run per stressor
stress-ng: info:  [1214172] dispatching hogs: 1 cyclic
stress-ng: info:  [1214174] cyclic: sched SCHED_DEADLINE: 100000 ns delay, 10000 samples
stress-ng: info:  [1214174] cyclic:   mean: 9834.56 ns, mode: 3495 ns
stress-ng: info:  [1214174] cyclic:   min: 2413 ns, max: 3145065 ns, std.dev. 77096.98
stress-ng: info:  [1214174] cyclic: latency percentiles:
stress-ng: info:  [1214174] cyclic:   25.00%:       3366 ns
stress-ng: info:  [1214174] cyclic:   50.00%:       3505 ns
stress-ng: info:  [1214174] cyclic:   75.00%:       3776 ns
stress-ng: info:  [1214174] cyclic:   90.00%:       4316 ns
stress-ng: info:  [1214174] cyclic:   95.40%:      10989 ns
stress-ng: info:  [1214174] cyclic:   99.00%:      91181 ns
stress-ng: info:  [1214174] cyclic:   99.50%:     290477 ns
stress-ng: info:  [1214174] cyclic:   99.90%:    1360837 ns
stress-ng: info:  [1214174] cyclic:   99.99%:    3145065 ns
stress-ng: info:  [1214172] successful run completed in 10.00s

# echo PREEMPT_PRIORITY > features    # preempt=voluntary
# stress-ng --cyclic 1  --timeout 10
stress-ng: info:  [916483] setting to a 10 second run per stressor
stress-ng: info:  [916483] dispatching hogs: 1 cyclic
stress-ng: info:  [916484] cyclic: sched SCHED_DEADLINE: 100000 ns delay, 10000 samples
stress-ng: info:  [916484] cyclic:   mean: 3682.77 ns, mode: 3185 ns
stress-ng: info:  [916484] cyclic:   min: 2523 ns, max: 150082 ns, std.dev. 2198.07
stress-ng: info:  [916484] cyclic: latency percentiles:
stress-ng: info:  [916484] cyclic:   25.00%:       3185 ns
stress-ng: info:  [916484] cyclic:   50.00%:       3306 ns
stress-ng: info:  [916484] cyclic:   75.00%:       3666 ns
stress-ng: info:  [916484] cyclic:   90.00%:       4778 ns
stress-ng: info:  [916484] cyclic:   95.40%:       5359 ns
stress-ng: info:  [916484] cyclic:   99.00%:       6141 ns
stress-ng: info:  [916484] cyclic:   99.50%:       7824 ns
stress-ng: info:  [916484] cyclic:   99.90%:      29825 ns
stress-ng: info:  [916484] cyclic:   99.99%:     150082 ns
stress-ng: info:  [916483] successful run completed in 10.01s

This is with a background kernbench half-load.

Let me see if I can dig out the numbers without this series.

--
ankur
