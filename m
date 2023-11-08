Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2537E5F68
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjKHUrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 15:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjKHUrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:47:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFA61FFA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 12:47:16 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8Jhlwj001586;
        Wed, 8 Nov 2023 20:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=oAaMwe5rZgx5atr+hrbp8PLIVE3U/3kA0sciEZWMQ3s=;
 b=GFxdb9TY8UIKJTcgY+vWLte6X8l7BG8cCgUdPbJ5r4k5sEKQ3JS35Zfwq28eNpqTrjwM
 p3njJOzaXNoAlqb4Onb/9LSkWv0i69W+yJH674tOe0ANZGsuRayQ5qxg5+Cg5KGeAKxr
 0ZiIgS4VcpyRCGMsuoTDSDc3wqhe7TYM0dy6G65CmwxxEV7J2iqNYuN/EilUtgEEV7+n
 afpiezw3ZHQywwJ61PugwPJFIipmFQN0UyUeEplxXg68pUWKQurZbbdg9JNZT5jk1AGu
 Yb8SFV6Iro2WdALf2vv/Nv8ew7V+pl5kYn40Ll5eojILC51BtWEuvz8KXM7w/FYATmAK 0w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w202gjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 20:46:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8KO28u023887;
        Wed, 8 Nov 2023 20:46:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w25m7wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 20:46:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2935wuvMOW7T4akK1BYGGbb6LP28ZJhW0KCAb+ncaON147S1inlKTDEeixqH4hYUBhg2lO6HWaH/hWQEWO//414aS3UisBNA9YP5sMAjpthF4uZJ9WNs0LUOTCDcGTJEExY7dOan6jt9fKl7bCbT2uwr82wniwV8ieVQTwLk26pCiQ3+ISR//XjMA+lwTNBE65XiAvl8B/RKPg3bL4lflY9UmpXb49d4v/9/gt1m6pWlCI9VtdczE0CBUkstRuS5Kq4KbNueXUAf9oH8ZW2r2rCWChNmZbYOQQ642W995ydWe24Vm/5i8WcoqzWdEkED1uALrK7Ru/0X6c5IC6jyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAaMwe5rZgx5atr+hrbp8PLIVE3U/3kA0sciEZWMQ3s=;
 b=IOn4AiHnlKXApXoX42nBfJBweJEgo2+eFMTwQQN6pNwR/eqkiAZtu0LhfzFcUWhDhO1xsVZK4x6Sx9x+uccJjm8BXtdufOgxfdUVDYw3zalKiExfJKrzL8ytUgPhEUNYREfHk0qGKdlsYGZg2MBdYgfF75WRbpEjimZ8Mg6cdusYcFf1VWIuDAcgRc6+ofq2EOKQgGlAmDGiwrxi0zDdf3Ui/QbJIIKpYLddy5ojt8gmiXslQk3Df8WvDp0SHc+zs7+PuOaC2Ni+Sjr9dn5lbOwPdxnrCxbrjd9Tcocvg1VdyqasQ2UZth6Mq06l7fVLc2F1d8weCguOffgMdX/GOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAaMwe5rZgx5atr+hrbp8PLIVE3U/3kA0sciEZWMQ3s=;
 b=rPmc8oJWsfUdtTSZr0OHuGnmnVAQcyatG+ZAcUxpNl0uPLtvSdNJo1Veo0PyHunz7hlWD37WmPDdqEKvmKNkG2GAwxyxsVAn1fW6unBnnmz8MBhEGyrnYVrHfgDENdezvIfx15DF8Se8JIGqnQUOlJAnqp/YPJBlv5uSUlRnTSs=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by LV3PR10MB7771.namprd10.prod.outlook.com (2603:10b6:408:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 20:46:01 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 20:46:01 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231108085156.GD8262@noisy.programming.kicks-ass.net>
 <87bkc4lfxp.fsf@oracle.com>
 <20231108101330.GK3818@noisy.programming.kicks-ass.net>
 <877cmsgsrg.ffs@tglx> <20231108112227.62f0c5a8@gandalf.local.home>
 <20231108164916.GR8262@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
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
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
In-reply-to: <20231108164916.GR8262@noisy.programming.kicks-ass.net>
Date:   Wed, 08 Nov 2023 12:46:00 -0800
Message-ID: <87v8acezxz.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:303:b4::34) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|LV3PR10MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ccc2ec-3be3-410c-4750-08dbe09bb7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DgoiDADtdER2JxzgxePuPUOOY8Xx02xwQ+jOUQcmm23gGP1ClJTSIhUFWbPvxF6lNAKXB8oSmYRGK9swOw3I0Hv4eFF4CMsjTtSzsnhMSiF1qW9yhKOt3Sq7Lu7pjYgo2vttUf2MnOHR0hGjYiIN9TcdXf3ghu+Ke5fPvpiqpOsNPcbT65XjpmK3In3t1GtTAxZh25gHDTzsVC2lFb+GlHB3gPW6U9ky+C8NpYcyRiuppbDIYPG2tdyHOl4ptNMTNtj6tU2KS+XGD/2DfC6s68EcqL2ZtJ0l99z++wh+RjujFqcuIzCWUzjsRvN6J87exa59pnUwHhrdYo2/CW5LgCDqRFEANkXneJ2vxfOyutMy3Sgvw/xQ1bp7NSABe0tHsrBOEoU9L0EeA23CiP7xPSWB3G/HT7i0qJS7lIGpSb6rsKZKNhBfV+USEmcns/zzp8WOrKbj+CldQt2DC46vdh6bXCu94c9hCC4bgxYmWXq3vSzlcJQims+JUAtcrsTU6Mkb/hdaiOJbLHAsWxxUBeYkpqDfd8G52SyHv7w234U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(2616005)(6512007)(6506007)(6486002)(478600001)(966005)(83380400001)(5660300002)(66556008)(66946007)(26005)(7416002)(4744005)(41300700001)(54906003)(6916009)(316002)(4326008)(8676002)(8936002)(66476007)(38100700002)(36756003)(86362001)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qFO0f0wDEWpa70PO1X0W9xTgZIYXB0bezsJKc1QAwvni4dLYLJ6LSwPkp7ZR?=
 =?us-ascii?Q?5r6jFGAQ9q2qdHcZNOhd8DXt8lEIp8yfFZXNjIj2yEnfOmCs+iL9cecJ55km?=
 =?us-ascii?Q?/dH3N7NTRdPSMzTZHlvmiUL2GRL5XMZUkOgArxz1lkJsuFROLm26er1henCc?=
 =?us-ascii?Q?ry99qYPf2b2KKR6qsDfJG2ZzYo0WRS3NnLjZsmKiWqKChlymDUyqcdqsrRSE?=
 =?us-ascii?Q?KbEsK5l2fEu4T8gh4Elw6zQ6n7cEgjYL8BWwmSXT0B5FwudV500ElSMElf2l?=
 =?us-ascii?Q?0lQdSJ1ee1Sh6uVMLXYKqNnNNkMPj+aMcFYgA9KqslNeTJmSP0+OEFf1FmDv?=
 =?us-ascii?Q?YWYYWMzoY8oGE6T2zuvefhNrpar8uJTela4L0YBRpLgWAO7F/6Q5cJRik0c+?=
 =?us-ascii?Q?ppyhFFlw3R631PMxnyECVV7+Rds+QQ3VvArJSSrKAJs1HiPYbpcISHYvgGDl?=
 =?us-ascii?Q?JciSqY0qlccwmAunTsH3VDJ0AN9N25jX0wRPuaROX29mBxIQs0scbKwzX8uw?=
 =?us-ascii?Q?ipfjWyxewcUpMIJGjgDpSP5df32T2kI6gJqEOl6d8CZm755nCmqD30Rykd2C?=
 =?us-ascii?Q?9UfyRsLE/aE4UpLi9pHOk2VfVilEhogBoixdtIoduDdqhZepD6/RepSeZUj0?=
 =?us-ascii?Q?jQsNwlHcmokFOELgXatzS4zQmRXIhxUsvBj2qqFWAaWKJJ3+q09XzNfb+L/O?=
 =?us-ascii?Q?h6TLe4Po9V4IQ/6j6fHehCqjH+d8DYM1XkSns98T/U11Ieb/JYOIkMp9SJMG?=
 =?us-ascii?Q?4Qp1wfmtteUfvJXdQizhMem5/HTVqdw6Rj+HuLGM4Y9121NvJcC6dMdO8G9h?=
 =?us-ascii?Q?QaIcQvnQIsjNWU+pS/iIhza1LofLjUER7EtffoHl4JeghrNoprU8rFlz2lGx?=
 =?us-ascii?Q?255Ell/wIf5v/XL5MHhEvkyL0m62TyBiRJ5BHteRn3nLuyHMFDjOoW2/w/1x?=
 =?us-ascii?Q?FOvpz4puvVC8EAv+n/0UL6wT+oeC/13XOAa4qFkDK70eT790IQeWoqbW9UMN?=
 =?us-ascii?Q?521/8VWPhrMtPMdFv31d48RI7S1A/UCXM27IHuDnvO4A8d1zYzar+lGNYrry?=
 =?us-ascii?Q?sIPGTU+K3SAqrTiGBx5s38q63Szlj0hu69eILY5oLuOe1DG9GUlHp1Jsin4M?=
 =?us-ascii?Q?vYFDGs5J5ni44jk3gaXjfNJ6JzA4h0UB82zlsrGZr7qQk3XvBjM0liAJVG87?=
 =?us-ascii?Q?gbU86uVxhJ4SDloXp/iurkWK2DNNa/W2g94gFgImOAAH/HRg/Gk4bTRtTZ9C?=
 =?us-ascii?Q?hEcC169Qa/teaXt5JEvyCoQqPXKkaYR2qmC75kG2p/yXQpusDTh6oyvxSJp8?=
 =?us-ascii?Q?3OGwVKQ026gkcLLZgtnif7s3Fn1c2SVTNLjZ2B5p4meUTvuVMPNwUmEYfohb?=
 =?us-ascii?Q?Hmk21gqwfvhLtwkXXCVRKkoCbVStJvmMk0XcnjiOXRwa9NfmTLi3AgbjNLTK?=
 =?us-ascii?Q?oyrSY1Xl0Zg7dkZeSohAQuyIxkIVlph1+wkboz9p/SjRHyzSOu4hpok4VeSP?=
 =?us-ascii?Q?ycHJoJf3HyCx3Ums2NJngKhHEZGvr5+M/dw95yOD2PT+OtqAUh2N4JdxszLR?=
 =?us-ascii?Q?t+mtDmmm+oUojsQoftHC0t5j1cCfdmNwVjmW7mn9H0jynAHZn+a5mwmtaFBy?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?eEPLDtIA23pX9byEGZeBwZrryAbgWXObz1o9s3kEf3KY1xsPKAF8q9ftUxrp?=
 =?us-ascii?Q?GVBxgU1O3aDz5Edm1XUYy6HMM4vmypj02guuZRjvTu5hrKVqosowFm5gNmS6?=
 =?us-ascii?Q?av8M9U8l64dJk6R7Dkr5iP4rEoz/AtBY9dfbuKI4Yegx6VIIQG/LHoQlSwqx?=
 =?us-ascii?Q?CVd5o0nc+hHKVQEb/amsXvKSOWoMTXEJ84grg8hqwxMQyqQCKE1V9ovDGOmV?=
 =?us-ascii?Q?do/BShXu9FIXkV8+c4Qzhwr98IvKuoa+afmgdvKyIG7RXv2nrhf9Kokr7Rk4?=
 =?us-ascii?Q?VPOshp6SMbkGXFJb2s3ptIiqWYeK3w0G1qKhX9WiGAKy/ugf1wg9qPWbiycJ?=
 =?us-ascii?Q?rWoXWr6ufCm960VE3BxbgrhSAQ88nLyhRjzurXYuhNn0Q/ucEJtiGW8ZnyJ1?=
 =?us-ascii?Q?ORNJeiyx1mPZMZ5+WyxTuvRkgSmCEojUsGgSkbJ7eJRwsf8lu4lNbJ0G8hlq?=
 =?us-ascii?Q?uevHpzfFGLBqb/CAHn2/k7vtXHUbXeQf8EdHRUiSlsmkCxJ0BHkyS7ziUg8N?=
 =?us-ascii?Q?2S2cpt9jzAZy4a1/+nvXThj1/iDJKZtvopWxLelmyWeGIut6rbfrNA5349RL?=
 =?us-ascii?Q?30fP6lcVzK1r48jOX/5l+1m+LHsRGlIJ3Q0jvdPhcZbMd6Gst5rXa3qyTUqM?=
 =?us-ascii?Q?7L6uPC7pHBMNMUWAfFGEp3Wxwz1/Oat2Zggb93XgnYYU/lgDAZuXARCeuUb3?=
 =?us-ascii?Q?XmaxijsWWEq3TXTaHu2Akmmpb3gzTrCSnWQn6qazPrYJv16Xki9cwTNZjkSZ?=
 =?us-ascii?Q?vtXF2qBYQTO4krX47s2f96nCg1+MHvXDtShQ3kzFhAbS8JaAx8Odxbs9dxCk?=
 =?us-ascii?Q?jAVuUFiC6JN+8a8m7QiCnfYfeNqrOFgONwjeuM/J/aVnlgUoiMDNYjLt7ly/?=
 =?us-ascii?Q?fQ9aA7o3hgjfQj6yoJgnC49YRxDhTo9kPCircP3vYT30mmp87bE44kT/LO/j?=
 =?us-ascii?Q?sKZdfat9GDZ5XqxgaYko7yGjWs599O+kjC5+3gir3PUasiR9/NHsnd28bljY?=
 =?us-ascii?Q?Rh0mv7EwZySP1HA8/rroBr6EMN+CvxKq4O8lPcYpvpPPIs+Io8HVjw0ujX0P?=
 =?us-ascii?Q?qFVs6X2W2l7NH4Wc2AbL36twHjMaqqyvX5PLnBLbCXhDCBOdqlOSFUarYjXJ?=
 =?us-ascii?Q?V8/eTYqxwNDhUt39xOhopB7ZNM9y/k0PZByrYdoHSiggpaZLi1oh8FRXvLm/?=
 =?us-ascii?Q?5DNSSP5sJQIbQxzNOAjTkqgGZ5rdbH6mf+PSCmi7dIt/DfQcg8BOqU4EMlAI?=
 =?us-ascii?Q?oNw55BbuGmAzsj5RyVyOC5p69tGsTa1nvszJYApXmff/gYNOCLKuZjuZlliv?=
 =?us-ascii?Q?kT/OKQzACftV3iY1b2r3iSAl8uWLIPtMe2xqhhvwIrr4VkVGogVt342eTojJ?=
 =?us-ascii?Q?V/PPIg1BGgyW0selmk+gXenA65Y1QQMptgYnsXXtZ3eVrlWiywsR19xwltgF?=
 =?us-ascii?Q?e37d//ski6xFA1k7ygvGyMtVgYWUf0slcaqcQxAPQIwDJA7+ltkkhbtGFuB0?=
 =?us-ascii?Q?E0VjyORgAY2YAhJiFYxsTsU9Q1Le30hQRA42nUV1997yqCH6jLi1kY7R2Q?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ccc2ec-3be3-410c-4750-08dbe09bb7f7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 20:46:01.5240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emM041U8yuhg7Pk/FXqhpX2jerOk4ssJyqnIK1YRPEEGiZEY8zU1HS0Fzw48PNdvWrseiXhdQGTcLyqk129VXwCACzEamPLji113pr/Ru7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7771
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_10,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=547 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080170
X-Proofpoint-ORIG-GUID: K02R-5XmdMZSpq9unjt-saToG5cTwIht
X-Proofpoint-GUID: K02R-5XmdMZSpq9unjt-saToG5cTwIht
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Nov 08, 2023 at 11:22:27AM -0500, Steven Rostedt wrote:
>
>> Peter, how can you say we can get rid of cond_resched() in NONE when you
>
> Because that would fix none to actually be none. Who cares.
>
>> > Look at my PoC: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
>>
>> And I've been saying that many times already ;-)
>
> Why should I look at random patches on the interweb to make sense of
> these patches here?
>
> That just underlines these here patches are not making sense.

Yeah, I'm changing too many things structural things all together.

Let me redo this. This time limiting the changes to the scheduler
adding a preemption model which adds the lazy-bit and which can
behave in ways that are similar to preempt=none/full differently
by toggling the treatment of lazy-bit.

This keeps the current models as it is.

And, once that makes sense to people, then we can decide how best to
remove cond_resched() etc.

--
ankur
