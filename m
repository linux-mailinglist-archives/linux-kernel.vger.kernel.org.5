Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C9C7E4B8D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344298AbjKGWLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbjKGWLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:11:19 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C370E3ABD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:01:30 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJODJ032058;
        Tue, 7 Nov 2023 22:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=zDfCfQkBw91mMW+9GuR7IRCns/x7hsQuyMEDUgeK+cA=;
 b=4D8I1DjXpEzbQZh1jI+cEY5H+JZdhmkqaB+ACgPQbe5d+zCu/dLuCxWX+nV2v4UqZkNn
 5cLymAGpp/jl3e5pBUQl1lak+G2lycXlWASLGUAU1poKOiyllL9JwxkEP7pOrVTmQwBD
 FHQuo0GaqrqGPQPbMTOY8nVmGhU05ZV0mdGjz70PpqKGFyLqx80JPE3o76ik7w+55cne
 mDbQYU5gU8dv1+TZNYILRf1xwBv4qPtskDQPSqFYMACPYp6BK3EAHIQNtC5Ky+4vPeiM
 +nG6yjJSim/rwEspNnHpiUitcwHdMXSLOKgn15yp9h+FYdxJdfzxsKyTkJ1rDBDoeuCt hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g2e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIgdP011085;
        Tue, 7 Nov 2023 22:00:25 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1tskeh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V//QWaNdgNCMusgw/N6DBKGpNQx4N+Ln6N4YsJEOMN86bQMOMI/OsnwXoFWz64j3izIDLJ6892W5HxTNVJlAINYRyO4DVV/4k91FdSzSpmUklRccBOcEaCe7gWWQyX/nKBdzxIXiyYKjpLH8QhOx6xGsYRMxEBd518MUfD4LHlhauXaUDz7cKcAeKQ+0eoXJFA+X8AIfgeiO3CjVjQrGIAuXtLf8PxymmzsiQc0aasEjjeVSlsUTgdXjIhtTAeOOsDIY5htBz62KomknIFP+Bq/gckzfMlp61DvEcRpdpeMa5ISmYMsXHvxZtfLIQNjbPnDFt1bg1LadoXXPWSo7cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDfCfQkBw91mMW+9GuR7IRCns/x7hsQuyMEDUgeK+cA=;
 b=UHfsfFlBrdTq6jvn5L/SN3ogmAicyUHeJ8fzu9TC+XjfdlMrCnE32JFv/0pC6IE7tFo5jyV1VsYxX417gTNmOB81Gs1hDCYkqiGZwFqHTuShbHZ9kl6t24bTS5JMIQ9+VBDWrilUImeWjkZAXuoZ3+czyYKAszXmPJ4UB0+DqBJCXtJO5kU2fdYT0+tL0sLBnkWW2aLhnDJ0nhk+alxhSwfoNUmvAolwLTYlKJEqa6lgLr3mZweTNOZOhboAVcJ7iy0FPP3KJQ1tenzuyT+CxsRmXIMir17wK27vkNhb554NaVEeuISMRfBN6hH497wSVkljpvRR25TvgbdVrCDbdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDfCfQkBw91mMW+9GuR7IRCns/x7hsQuyMEDUgeK+cA=;
 b=IQDsXQXy6l3cyFd+yLaMBcOTrYlWB7MJbmdoTwPMjo61nLf53VfTC+UO591OQnLnRaEWRzxgieGFLG5Lgrjm3GRRSHegwtbSBhvdEwR6/9kSNkEkDB/25fJBnjiQRHddTrsuh9k+3OPIwWSE/g9pGNDLKu+IOS4roos0uEEHnMw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6275.namprd10.prod.outlook.com (2603:10b6:510:211::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 22:00:12 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 22:00:12 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org,
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
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 49/86] osnoise: handle quiescent states directly
Date:   Tue,  7 Nov 2023 13:57:35 -0800
Message-Id: <20231107215742.363031-50-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:907::35)
 To CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1c91d6-2397-45e6-5d39-08dbdfdcea83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ku2vLMvqT6icIo+TmTby658ia+Cb7UAJlP27rT68Tl/vp0lNKftuImsAPSiLB8kci9bIt+c4Sb00XQfZx+BhxrhvsDXkY0QuEiIdv1ziaTeY1VMMpa6lFtHeyl5wQmzJabvW8cFmFKHJxzamRSzHkA/ThnBWvl/gUYb5Pw2XFvBjbqw5uE/XQ4Z3xah73VgZt875fSe0d7XljhzBRzVI7kWqxsPxQOrIWqtmL/5QTXr0F1D2AkGiVGZsLiJmuUqbEbBRrB5YbE2cu7VvpuklFFS0eNTNfPK+14necc4uCGu9ABLnH/8ABmDh1jdzl/FI8mYihbB/sv42l3ioJGyd0l9iJKqMM6nTQB2AdYZUtw7BuBXYF2jwgN1CjX8C45eQycyQI+yY4zX2n4bvDq5AhWmAOplsVmbwGnLsWRNTAtZiD0uv2xRoTX8cMokyvb78ofuLKg0orL0V66r38kHKcB/tmgnt9gaiA5kIUGPXmy0h6gF8kv2P60CPDoSD2gHuYeR2vxdvGASq6M+qcMwUT4SCRPrTI8w2C/kIkrWMJthcwDsZn1GLucahhNDIuHyN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66476007)(6666004)(38100700002)(6916009)(6506007)(316002)(66556008)(36756003)(5660300002)(7416002)(7406005)(41300700001)(66946007)(6512007)(103116003)(1076003)(8936002)(8676002)(4326008)(26005)(6486002)(107886003)(2616005)(2906002)(83380400001)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4jUepuOGANNnWeRN3G68t8KHuNMBZkUZpcV3SCUskMWm7ClCJ2zlkBCGK5vp?=
 =?us-ascii?Q?fzXcz/MJmpQ8alunrhKLZk3rjOF4GKTT8RGrKH0QM0/eeFu1unaLdWP8x7p1?=
 =?us-ascii?Q?x8xhaEm/KMkrhCzluPgjjk85EBMPij+sQ4lDj/mn21KwbkQpAfWwg2aivQ+6?=
 =?us-ascii?Q?M9tSTDscYasDLrOv8L4Ro2vDA6oSYhEVSCn04rXj6yIP8/QsMFoXOotCpHYm?=
 =?us-ascii?Q?vY6d+I20M9QIwe7pqq5bG9BAk2RvrYJRbWXoOdAab1o36a+G4czq2YdZ6ubY?=
 =?us-ascii?Q?u2/6u/mr1f8rBiU674qyYHk7/Zj8d5xZKY4SZQWEtEoKIvtxlwg4iIs6WgZr?=
 =?us-ascii?Q?EVuKJOJID/rwR3q6Vps0bGEOm5PUIM4Ee9EFMEXqJiLlL6LHPDpJnUrMS0ng?=
 =?us-ascii?Q?3xgQ2llPqPw177uiIpyQ4PoxykgHnVGPcv59I2hxFHv4Q3wc7rGhTqo4TJMW?=
 =?us-ascii?Q?0C4ubOW3bHIthkqmnHLzHJuNU2wbtrPtbTAjCLCrHSIkzhL0Kcg8WYRVdHfz?=
 =?us-ascii?Q?NuQ0r3p/wOcTDEcquGUNXL2PdL2KQUhFGKZg1VeQihiVeZB5E3XNpUOJ1YOb?=
 =?us-ascii?Q?Ek71rQRXqydiypqT1OXHrW9/QTZBYaMk127OR+OIBQjAVzFjTVB9fsgU4sLz?=
 =?us-ascii?Q?8hcNx5cCkSj8AjV1RCjxtQIgW2K6L8JznTr1qW41dp8jxeofih25UK8CW9gL?=
 =?us-ascii?Q?ZPsnGPczdW7x0tNTf0bDN6UnefCdJVwvXzdx+ijzZVn1SGoQkpXCociXaDYR?=
 =?us-ascii?Q?WV/WLMTX0S47IjhFcedFeUJNi7k5aj1opy5N1GRPdC4+r4Z2h9jW4Mv/ywik?=
 =?us-ascii?Q?pDnggpdJSWSAx3/VX3xIIaoTGBqtB1SzyHUosmQRwO0pEezfLQUt5hOpyLbx?=
 =?us-ascii?Q?7nRINeU+xz7UtK8jUN9ycqQEoWJlzg1/OO3nXUid/Zm3DsLDWR0IX/S4nOxz?=
 =?us-ascii?Q?ORBPTlHU7BL4FQaNJkl04i6D2yBncfk/VdWnJQOL1uqfniOXOnjOIXAP6cGM?=
 =?us-ascii?Q?zXKGTp6w3ZqLsHwTATbZc7DsLTItphPJJSnU9Fbw6TiDxgsLqXk6vMpxnUq6?=
 =?us-ascii?Q?x/2X0Gcus8Vcmad35fKMh4/84ThxXPnfXHFz12KaU1QllUBNHClRucXb+fZM?=
 =?us-ascii?Q?zxfNUrooe6aPY2dSZ8VZZLDhhH26f+9IA/iyA0Jp1wSrt7umCMJGpzO2lxX+?=
 =?us-ascii?Q?5yBCKhd+Gy+wGfqCSxQAd3NZ1wKREBVQBBgpFh7QHZdXM3Bfz+6ECMBwNI10?=
 =?us-ascii?Q?bQV00BpVeNK58pm/1RLBbvbXcxzLSdOoOBTJTqxjvjHwg1pwarX/OKp88VJ9?=
 =?us-ascii?Q?57+QED0SB7tvP6hN+rdGFAPwp1UtGHZjXsruKVrOcyBGgk4Mom3hgg2zR0aA?=
 =?us-ascii?Q?YKxx8dH5LgRUYRD8DA/mlBYiconFiIMGXRW5xvgx0rS9DfKnPlG0OX3Ty2V3?=
 =?us-ascii?Q?AzkbWVV/PCItYW6g1oJHeAOXLv9zoxmXBevgqnCRAtFnj8KRu7nKMXY4HI8n?=
 =?us-ascii?Q?vpdXtY0mpQFvOd7tYJhLe09UdbLtcHjWnZEriCaPYGDGPXTh1bF10LCmgIq1?=
 =?us-ascii?Q?hIY1mfuFGePgVlNXGdezCnWRG87B5Amgqsg6mRKR6/PCos07sR6VtQbC0NcL?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CKwcbYFSVic6g0e4PMUhngczKcaOgzPZfbqaeZHtG6sML+B7EPVUO+EiHRbi?=
 =?us-ascii?Q?sgY3ykQ3b/ExEsn79slAZCgi6yKDC9j3kjpNJDmJVO2SnyZ5fNL3QBuMp8G/?=
 =?us-ascii?Q?R7lPAH7fqX5XgmXfdTDcn5jr5QBocdaMcQ8bPeuWVf/sikQ8910y9ZecvG8+?=
 =?us-ascii?Q?CYxFDKSwr2yjK/W6g6itz9+3+R/GNWN2EykK+/rJp+F+xdFKpC0+lXRJD5r4?=
 =?us-ascii?Q?ie7Gk7i1vdwwZ8Dy5b5Wei1PG7LRRmk64NIH7JtXSXC3SiNrZ8D32XOJVxgd?=
 =?us-ascii?Q?HRcSpQ335KiTNTVNHnfpE1syVcUt4558fMCLIdrEIjSkPrJd0bn/Jf+jQCrD?=
 =?us-ascii?Q?a6dMPk0yo9tFbn8Hg0nipPetxwwRsXArkQ+5BfKeu0DSY8LbPGpgDjl3pIkK?=
 =?us-ascii?Q?Zc4MRUYcijT6WEXxK9mykU67Kz5uVz0s6JcGVykxblJ2fdvjqJHsyj/z7tpL?=
 =?us-ascii?Q?qy16mrKsqWQDuXpchPljRFAxUtEO96sHxHpsuMeHAgEDEX5M1WqIpaXat0Dg?=
 =?us-ascii?Q?TIZ5NHGonCgm54dWt6vIeOUDMjBwppFNhVv8R3B7l94go732F1R87ctPgLag?=
 =?us-ascii?Q?Ps9jzHhy4pwYUrjkdzafkgmUV4W76OiLLNKsNmlLsOIxnSfm4p4RemfFg/7r?=
 =?us-ascii?Q?Ta6C6NHlVyEtqYjs33mU4vfj893icyqvQhAzZAjlHn/zSQrFa1nHyO3jOcee?=
 =?us-ascii?Q?jGWR3GRCli/OqLUPNULMPblnoYIbdEn/gmwTfI7hX9lkqibAkzwkHRdd0YLf?=
 =?us-ascii?Q?ovWPunSnOzGH45SRjeqDGoe0GVxJDMxhRCqSCqwpsKhn097mLavywRIShTly?=
 =?us-ascii?Q?u+Pqg8Kq4+a83snkS0s/dabqqBWu1xuSLbEV+15CCixMhC1FTdQvWYV9FtVt?=
 =?us-ascii?Q?N3sSNZlrrivY8Ui8zDDzNCtsddcxRyc1aRCqIvT8qJtlvWZXI7Wh0HsKquDe?=
 =?us-ascii?Q?NchGFn/cUhQExbwyYoWYdx5FJ370qs/GcH3IEvqLgGOdiLA/Bivk0zFqvOJb?=
 =?us-ascii?Q?xTAcNL3w+IixOS3uNgQkxJj7QOU7cwA3OTbimd+GMAqxDpyLv9FC6Yaeyjm2?=
 =?us-ascii?Q?pBhDK0UtLpeO9G6fdw8Opw/tNd5h5y76P6Dx6/yTWO/XuXAUS1VFcqXkM4bv?=
 =?us-ascii?Q?ukIT3esTjVo2N3zz2Veva4s/3tnDP5LOoVnmLXJW0gEeq48qs55mJPdkeHLZ?=
 =?us-ascii?Q?b6r9I1PpXBl0BzqLR8pLZXNtokG5oTJz0gtX9mXv0yVSW0oCKqif3UlSU6vt?=
 =?us-ascii?Q?zV6N/CRtau4cDBN26QJT/VnvIIxsw2tiO5JRGaIDoqsxTkPyX0H/kJ/Z/2B3?=
 =?us-ascii?Q?QYDGZG/+uc3ilPy0fjH5AWW/TPS2E6cUYDqZRId0Vh1/DI/Buxb/RwiA4btL?=
 =?us-ascii?Q?xtN13+2ujrcsrYpVF0uihX+aJi7OF59hI1LDqjUejZK/FX5j2y3yBRKLr31l?=
 =?us-ascii?Q?qGcrCj0cNrNTKgBg48g0AMTytTqwrrd63jqzOtJS6rFZNZ0V/Zz62jC8vUbU?=
 =?us-ascii?Q?GWEWHQ5IU0prJ8hHJv47/xePy8HF3V8fcV5Flw0GxHVkRfJRX5UdyIPc1A?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1c91d6-2397-45e6-5d39-08dbdfdcea83
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 22:00:12.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SD0lmxQN5N3TJJBD8IxgJ5H5vey+MMYHjlMBrGtc4F9Ij0bnbU0G2tWdku63U07pPxgLd+LX6/9XZKCBZPACAsXRy08LCDks3wn+qzrMI5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6275
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=802 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-ORIG-GUID: JWHRUvapECFaZw5SWt8zlEiJOnvpQH91
X-Proofpoint-GUID: JWHRUvapECFaZw5SWt8zlEiJOnvpQH91
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To reduce RCU noise for the stopped tick case we introduce explicit
quiescent states for PREEMPT_RCU=y, and depend on cond_resched()
(and thus rcu_all_qs()) to handle PREEMPT_RCU=n.

With cond_resched() going away, introduce explicit quiescent states
for all configurations.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/trace/trace_osnoise.c | 37 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index bd0d01d00fb9..db38934c4242 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1531,34 +1531,21 @@ static int run_osnoise(void)
 
 		/*
 		 * In some cases, notably when running on a nohz_full CPU with
-		 * a stopped tick PREEMPT_RCU has no way to account for QSs.
-		 * This will eventually cause unwarranted noise as PREEMPT_RCU
-		 * will force preemption as the means of ending the current
-		 * grace period. We avoid this problem by calling
-		 * rcu_momentary_dyntick_idle(), which performs a zero duration
-		 * EQS allowing PREEMPT_RCU to end the current grace period.
-		 * This call shouldn't be wrapped inside an RCU critical
-		 * section.
-		 *
-		 * Note that in non PREEMPT_RCU kernels QSs are handled through
-		 * cond_resched()
+		 * a stopped tick RCU has no way to account for QSs. This will
+		 * eventually cause unwarranted noise as RCU forces preemption
+		 * as the means of ending the current grace period.
+		 * We avoid this problem by calling rcu_momentary_dyntick_idle(),
+		 * which performs a zero duration EQS allowing RCU to end the
+		 * current grace period. This call shouldn't be wrapped inside
+		 * an RCU critical section.
 		 */
-		if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
-			if (!disable_irq)
-				local_irq_disable();
+		if (!disable_irq)
+			local_irq_disable();
 
-			rcu_momentary_dyntick_idle();
+		rcu_momentary_dyntick_idle();
 
-			if (!disable_irq)
-				local_irq_enable();
-		}
-
-		/*
-		 * For the non-preemptive kernel config: let threads runs, if
-		 * they so wish, unless set not do to so.
-		 */
-		if (!disable_irq && !disable_preemption)
-			cond_resched();
+		if (!disable_irq)
+			local_irq_enable();
 
 		last_sample = sample;
 		last_int_count = int_count;
-- 
2.31.1

