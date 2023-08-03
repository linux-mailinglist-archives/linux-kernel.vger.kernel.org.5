Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FDF76F1C1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjHCSVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjHCSVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:21:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D602726;
        Thu,  3 Aug 2023 11:21:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373CgOtn006891;
        Thu, 3 Aug 2023 18:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1RHiMeTT4jM/MyspB3wIjGVuMd9vhRfq+Dl5lizXkQg=;
 b=SJjz7YhQIGlYZro+Ei7SklR5Cpuudb0kolaVuje/QOmvLBxF/AxELoqOJIihjqN9jJSV
 6ZdvJCPiyCu4NgemXb7H2DnMl59CKcil8uB2vHD+VuP+kg2ykw2RQDcY8xQKkk02G/5K
 2+PgBihuUnF+PRMjfaJaQcX6fpigG1IU3+UnK7/cwoEwUsNjRKWq3sSyf125Rpmrly+C
 jnQU2bHHjQE1iWWKxOraB3iOi3+igpt4kLQCaQIW/aWlIM8H/iMFkKN/z1k8Jou+9qCB
 gW6kYuvYQICmzZ8Fin1pGWKUYuwcucKPKE848fIJJWDtjzmbc6NQay2zEHK5VIh+68yo Ng== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uav284u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 18:20:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 373H2FsY015639;
        Thu, 3 Aug 2023 18:20:37 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7a21xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 18:20:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jO7fScyOxBg+SovGCr1TTSynU9gb1EgChc6/yzB3Zd+NrG1ZyLpYMzN5UDM24+GgEJoIu4GOtWlxECuFoQafA3uUIIk2aVvcJ0J3KzK6NvKHbbyT9gf4fOPTnOViDaM/6c9lb4SO3LamnHIhkxRGW7U/aEGULHLCX/NndXWTB0oKD19qdWyRm+ZHKJ13DjWAEeaDSf0E9HimIXc0TxeOQ5yj20RdpZJk783A36xImbRIh/8jQUneYUDpP7zJ/4/9Wjclf/qE7Aln6xD/AGgasFmjOt4sQZwwQd3Af9wUJJGF83mPmVb2c3hzZ3D25fzCRmtDvxkuju2El+lOpryCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RHiMeTT4jM/MyspB3wIjGVuMd9vhRfq+Dl5lizXkQg=;
 b=Gm+JyLSBFXgd0FOlXVZi1844sxbaZseGvAlJCFTAQOB2bcjD+moUQstoTSPvsFoDqGqxgeEJOjC5U0Bw+ImvC+bTzv43QKfRuv07sKfuZBm7asxE2ForLojT4CDDs+55GoXLPVxMUD3yFA4MxFlWssn2YthX1VoPWXVVJRngK0Tbv+2MA2yNgqeA3cSb7GfCNWhNR46GTiZtKMnIIIFDOteym9z68Z6lVxSnVD9dggSc4/xRuMA02G3m8h/jFHCIwoEfOsgx6tTDmfNYcPX+ZZLlksAhQgyiRUuayc5b+nasM6hLiO1sydbbECHEkXJ+42ZbMqVbGkvlLgKtxnjLLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RHiMeTT4jM/MyspB3wIjGVuMd9vhRfq+Dl5lizXkQg=;
 b=e871rb4zdo2n2pK9OJ+iQjBT86jfSzsqLGx+vw9lzy2D8Vf3SSedcMha/CrmZDUGoTYbfujqfUq/3PVFgEUsxBUdctxNTNQU/whsKuwL3ZxNqyhwSiPZbqDhUBo4pc+OE185iiAfC6PHo0MvnF6GQdEgM+QQ/5V4zD4pckhrJpo=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 18:20:34 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150%4]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 18:20:34 +0000
Message-ID: <a6dd6e27-e8a7-09ac-f33d-03318dd5695c@oracle.com>
Date:   Thu, 3 Aug 2023 13:20:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v25 01/10] drivers/base: refactor cpu.c to use
 .is_visible()
Content-Language: en-US
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org, hpa@zytor.com,
        rafael@kernel.org, vgoyal@redhat.com, dyoung@redhat.com,
        lf32.dev@gmail.com, akpm@linux-foundation.org,
        naveen.n.rao@linux.vnet.ibm.com, zohar@linux.ibm.com,
        bhelgaas@google.com, vbabka@suse.cz, tiwai@suse.de,
        seanjc@google.com, linux@weissschuh.net, vschneid@redhat.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230629192119.6613-1-eric.devolder@oracle.com>
 <20230629192119.6613-2-eric.devolder@oracle.com>
 <2023070342-human-spill-a62c@gregkh>
 <31c1393d-4285-0032-7675-737737d21f71@oracle.com>
 <6d2811f5-a5ee-a49d-012d-b519b2c6ee26@oracle.com>
In-Reply-To: <6d2811f5-a5ee-a49d-012d-b519b2c6ee26@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0179.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH0PR10MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: d5af5a0c-053a-4d05-a88d-08db944e53ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OiilTQr44cADhSezjnfDuw9ImjhpIiiFX/v/wzMSibVHKqeCAbzOGfksZfAD9HZGyHDvdl4y/heZIsWCGeWLk0Yw7SlwPDafU6u2YT4IhPLtD2XhsbmF/LTzNiBiIP4qtrDi3a3qLWCj09MWCWqPoULjgtlCWZrBb/efzhSwU7SFa3tnmmRKCpmz8qCvwWgp9vISQvykx2EwyzJbzVqoi6j26Kje2e/l88TNfec15pfFGRiPQjxLjTKqiUxkppcJQMM0Mgkf7MAYtB0MLpJ06cJ1vSjv1bKwVUE7HH+XQyb8Q/jsMMB+cJv5Oesabluj8GascLMNCThwLgayUxuskeMDo0e2DbAYBhIvgkVHz7qKArWA5LvJFhNZAKtLOezRW1eeeud4it52On28vLV7cZ1myDoXxsxdBWsA4vTxIkGMiZLmILNXTPbomt1ITILeH9M8KRByWs13l4HXNQ7iCPY0Q6/h3Aa7FL2p/NVyC0o328kGpfXDytN3bA42BHT4PylFHMul2OtL4HJxiNV3XOwn4+mIJsTOvs82s3g1kteU3mn7DClo3HwHzZuvlUP5mdNg3+s6CClw+NiNScJ22s+/s2DbfU7OjxU3CZS9FKt2HjOIc9VgNpW+Asf65KdiyNE5WSxd2ziaPz/OqboBgEKq8MCDouCtVjrwyQOayFh2mSwUV3Cnbn3ntUSr4Hjd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(2616005)(107886003)(53546011)(6506007)(83380400001)(186003)(26005)(8676002)(316002)(66556008)(2906002)(4326008)(66946007)(5660300002)(6916009)(66476007)(41300700001)(7406005)(7416002)(8936002)(6486002)(6666004)(6512007)(478600001)(38100700002)(31696002)(86362001)(36756003)(31686004)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkJjRW1PZytvQVNkWFNqRDBGSkY1dmN3eEd4SHl3TENBU1VIWWRmK2laRDl6?=
 =?utf-8?B?NlM5WEdIWFpyZGRUUjZyYng3Z09DY004eDA3Z1Y2Ry9jSnM2WGUweWxvRnRD?=
 =?utf-8?B?RzJCbE5NbHcyVldDODFaaWg2WjVYSzgxZjloNW5OVzRhczZjM3NLZFdpQm56?=
 =?utf-8?B?WnFsTUg3Zlg1QUk2VURwOGJ0bUFBV2R3ZW1aTDBDTVRvekxYaWIzaG5wblkz?=
 =?utf-8?B?V3JVdDFUVDAzQ2cwZjgxNktsUk90eWRVSkRRaVJJdWhOUnFtbjV5ZnpDNG1v?=
 =?utf-8?B?Y3dJOFVxUVB4RWIxUjY4MHRvaTdrQ1BDRUhYSGZHeXZZaUtjSDFRSjR6RFEy?=
 =?utf-8?B?cnB4SWhmWkFqU1krRWRkR3ZDK21vSG9Xb005OElVejQ3OUJsME9jc0JVQ01B?=
 =?utf-8?B?UTFDTmJabVVTdm8xK0VOY2hhby9uMDFLRTZGMUltWmVtM29uNHlBRVdhKy9X?=
 =?utf-8?B?MmZOU242WjdPUFJQN2J6VDZTbFFRV2hiUndybklNcm4xb2pkUHpHSXc0b0U0?=
 =?utf-8?B?Y2NnMDZ1aWdnWjM0bURVb1AyWkFEYlNISFdlNk1hZ2RTNmJLS043NEtJZHEr?=
 =?utf-8?B?aFRYd3FQaTRTWUE1ai9zbDkrNWp6OGQ1eXRIYnhVNXJ2NXVFRUJUTjlEYVpo?=
 =?utf-8?B?WXdRSEZ4YXRMVUI5YUZEaVhhQWZXK1pQWEFnVXQvN21kYWorMk1JYkY4Y3FC?=
 =?utf-8?B?WFRmTE1oRElkWStCWFVXVXFBdklFaGxTMlltYVRpYTlqaE9CWGk3MG51WmNy?=
 =?utf-8?B?STVOa0Y3TjVoaHBzeVQ2dTQ3U2pscGc0Z2tmL25ramEySWVnbTFGUUFKSmI4?=
 =?utf-8?B?RThDV1R0clp5NGM5RUNuUHNGZCtBeVBabGloaWFRY3FiT0FRaXVwQWM4aDRp?=
 =?utf-8?B?RGQ4SU1SRDJETHVUNGRQd2hSUkRHbzVxT1ZMa3pJZ2c3ZjZuYmY4SGxobDR4?=
 =?utf-8?B?U1ZqS09NakFVN09OcFJQTGpncHk4K2ppc2tsUnpFU2k4anRScTdhWHExdmll?=
 =?utf-8?B?YlB2SGhTakpCUUx4SHF6dVIwcVV2d3V1bm5JZkhIc09idWw3SWtzS1gwamxo?=
 =?utf-8?B?THhTcEJlMzhEUHpjVHdoazFWclpLWWFGL3JIVUFWenJxVWh0T1pPeElPZUFj?=
 =?utf-8?B?MXBucnpOZnU3UzRlVStqWnJUOEFRbFJ3ektRYlBDR1YvaGtHb1RHU3hVRmI1?=
 =?utf-8?B?THFWRkYvamNMQTN1ZFNFaHlFZDNlYm9iTm5MZEMyc2hNZXNmcTUvaFI4RmhQ?=
 =?utf-8?B?M2taNDdObzRYTXRTY0VBT0JxWjlZU052L2hmMUU2L0d3RTgrUkRHVGR1T0xI?=
 =?utf-8?B?S2VYUlpzNzQwcFNIRzFkNWZnWkxwK3B2Wm9IclB6TXRtNXF5Nkp1bXBUNkZI?=
 =?utf-8?B?em5uS3NnT2plYVg3TE5GUTJmWDJ4d1owWTQzR1lPRHA2NnJ0dFRrbFZjdFdF?=
 =?utf-8?B?WGlRSGVES0NPbG5PUUpiUHZyb0hvaGxML1NGTllHV0xPNWY1bUtjVGFmTFNp?=
 =?utf-8?B?YnpPbW82QXoxSVVvYXcySHp3VmhTQy95dk4vUDBuYnlPNnFUL1ByY01RV3Fn?=
 =?utf-8?B?bk9mbUdEU2NZYVRROEc4YWFKVHRmakdEenNhVGZha2dtWiszaXZSUUtDZ1M4?=
 =?utf-8?B?eEErZndzZ0FvTmo4VnNTc3B0eVIydWkvMFErQzRXVmFYeXFRTllhZWV2NTVY?=
 =?utf-8?B?b2xUTlIrNXBlY3FXWE1KMzdGQXh6QmV5MEJhNTZUd3puVFpheGlaaUovTXpu?=
 =?utf-8?B?Z09sNk9FcDJQOFY5TUhJUWFiZ0phb2ZnVHE0ZEV6czE4WEpHcENqQlgvbGFz?=
 =?utf-8?B?WXkvdlpYR0pFemZoa2pPRG9udHA5MUFCamN6RkErcVNZL1VpWUZKdUp2SklI?=
 =?utf-8?B?Vm1kTFdGaFlYUXRudGVpZjM2dnR6SHpGNjdQOVVHQU01TFU3Zis5VTR1K3M4?=
 =?utf-8?B?S2czRE01S2o0QlhFMzNJaUcwd1RxWXM4VnVKZGRRSHNlRjJZSGFQR0Y0UGE2?=
 =?utf-8?B?RkhDQm1CZVg2SXZ6VXl3cEZDNGNQemQ2RXRhR291UFdOdCtIVURlMUdPdWp5?=
 =?utf-8?B?cTIzWFNXTlVGSGJJa2VxRXdQNVlBZWUwUUMzUzE1bSttcnhGMHJmRVZ5cW95?=
 =?utf-8?B?VHhzRkFIOVFqRjZWeWFLQWthNi84dHVoNG9tMWk4bUVpeEhCOHJWWUJpUjhF?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d1Z2c2VYSHVvZlFEQVNJQmo4bmkvQVRqMks5ek8rdEtIakQ2c29scGlRNWox?=
 =?utf-8?B?U3dSSzZrZ3FtdUJ6c25VUkwwT29wN0F4TGRabkxMb2owZFJoOFppb25FYzI1?=
 =?utf-8?B?bjJZMXZaSzlwdml4KzlmUmhhVlBKODg5NlA3d0lzUGxBbm1McVRPc2w1VHEv?=
 =?utf-8?B?c0NhZDZXbWNraFpjUmRpNmlpODEyQkpFdUhHRTArSGF1YUN3anVtd0N2dmFG?=
 =?utf-8?B?cFA1NWpwcmtYZUJGcFN2clRNVGlVSkFiZi93aVEwTXBObzBMRjc2ZWlNZWtG?=
 =?utf-8?B?YTNwQjR4dUtpR3RzNDNlbU1aQ3lWV3R1QXJESzg1S1UzKzNnZ1ZGREpmSzMy?=
 =?utf-8?B?dzI4WmIvWHBBTDVMWHoxZjRyUUxSVlVJbERycnZubm51UHU3VldLSXRDZU91?=
 =?utf-8?B?L0o5KzQ5a3BWcmduam1yVG1KbW9NUzA3US9FQ3NQOG0wd1czT2RPdzJsLzY1?=
 =?utf-8?B?R242MEJaZ2dWTnVsaU9obE1KMm14N09vc3JBR1RPOVpYNDcrbjI4bXFhbEtD?=
 =?utf-8?B?WFBmSW00a1ZwRVBHTm5xSXpUekpLRTl4Zm9zUW1OVCs5N09McFdaYUk0TFdj?=
 =?utf-8?B?bVhWV25lemRyN2VKUWd3dFV4QmdaaWdZM2E3UWc3UmdKOVFmRXl5Q1Ywam9S?=
 =?utf-8?B?cHUzcDdPM1ZSV3c0VjlNOEJkOUlnejBDUCtVenBuUkpuRHN2TFozS09iQm5s?=
 =?utf-8?B?SnhQY0NBTXV6a2dvVHVraG83WFFvYnhNRE4zVENqbXJmRkJEanVWcGZqckkw?=
 =?utf-8?B?RmRxcVNjbjRRcFJuRUJMU3BGeGsrRDgyM05wd21TWUVlb2JqYU5kaXEvL2I5?=
 =?utf-8?B?MHpGQkgwdTBubmprR3lYTVBkV0pUKzVwUWp2TGtPQk1BRW4veSt0SlVMYk1Y?=
 =?utf-8?B?WExDZk1Sc1V6SzlCb3pDUG84aFVVSHBoVWUvSFpOYnJXemFDQ1RkS3hZbFlL?=
 =?utf-8?B?WlJ0L1VydkVkZG9RZXJRUzZIUFBZcEdETnNlMzlTOGZKM2FKNzY2Z01WZStr?=
 =?utf-8?B?QTBHaFp3RDN3OTlvVWRwOWRUUE91Y1FVME1UNVR5czY4WWM5TFpnSGIxSEtX?=
 =?utf-8?B?MXFuZFFqL3VIUWZzWlJCbm5VaE42QUcwZi9sYVVCKzhjYStpUXRrdFd3YlU2?=
 =?utf-8?B?dDd2cWtBNnpIYVkzakViSXlRbGFyNG1wY05zaWxpQUUyc05YQ29YSFQzdmJM?=
 =?utf-8?B?Ni9NY2hsQUk0MEw1dGwzSU1jN1FGcm9VSjNCSDlVOWpmTk5QcUpPMGY1cXZL?=
 =?utf-8?B?VXNEQ1lPSDE0N3lpTDZzclYxRlBhMDY2NUhXc3VvRVBoZUhIUG9OaW5LcFJN?=
 =?utf-8?B?NTBFNHJiNVZNanBSWm5HbFJtcUV1L2N5Vk9abWYveEQ0N1hZalR4VU1oVENH?=
 =?utf-8?B?aGxER3hwdWZhUHFwQzhjV0lyam9kL1c1aE1sNHhONEZVZDJ0U2taQ252ZlE4?=
 =?utf-8?B?TXZEYWpWT003cmRQMW1WMjlMNzNpQzlHVU9NRS9vWTFvT2ZmYWZSNW9RQ3Jk?=
 =?utf-8?B?T0pGMW1vS0N0eGNicFd6SURNdmI4SWlqUWpuSHArREdqK3d4SktXanVRTnIv?=
 =?utf-8?B?SFV3T1Exd2VZYkphK0VjVEhLYUxTZHZlc01ybG9GaGJrOWMzQ1BVZzAyaWFl?=
 =?utf-8?B?T1M0bWl1V1FUb3hKbWRYc3NUbUpLaU90RzFUN3R3SUNrK1RKWmRGRFFVSE5k?=
 =?utf-8?B?NUg4THdYVkFyQVFmRXRVamMrYnEvTndJSXgrSlhEVzRiMzRqdzM2ZGducHB2?=
 =?utf-8?B?TnFDQXI3cU02NWVNcXlHNTZpQ3ozS1NzOUZjbDEwNVoyWUNuMmFEVE9relYz?=
 =?utf-8?B?TjNJWFMwVkQvWjFXZkpWOXhtenB5ZXMwSjAwMm1FVTk0WjBhUmtrcE1ZYUxK?=
 =?utf-8?B?bjNrL2VFTkg1ZVN3dTlTaTBMcjdBRERDeHlnZVpzUkpYNDV4djBUcnBJM1JL?=
 =?utf-8?Q?0SF9lgcPUb4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5af5a0c-053a-4d05-a88d-08db944e53ff
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 18:20:34.3917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6MWNO6R0OIVfELjsCoIkiqkUc6PiXa3maCK55GFYpfVEEIiNfwwEaWCRqfZj5GPgtbPMwWUKkMwODkmVC5jkX4Qs8eUmE0F3148jTYXIHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_19,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030165
X-Proofpoint-ORIG-GUID: NkniB4urIwSKTU92992GLlaklmST8eSy
X-Proofpoint-GUID: NkniB4urIwSKTU92992GLlaklmST8eSy
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/23 11:32, Eric DeVolder wrote:
> 
> 
> On 7/3/23 11:53, Eric DeVolder wrote:
>>
>>
>> On 7/3/23 08:05, Greg KH wrote:
>>> On Thu, Jun 29, 2023 at 03:21:10PM -0400, Eric DeVolder wrote:
>>>>   - the function body of the callback functions are now wrapped with
>>>>     IS_ENABLED(); as the callback function must exist now that the
>>>>     attribute is always compiled-in (though not necessarily visible).
>>>
>>> Why do you need to do this last thing?  Is it a code savings goal?  Or
>>> something else?  The file will not be present in the system if the
>>> option is not enabled, so it should be safe to not do this unless you
>>> feel it's necessary for some reason?
>>
>> To accommodate the request, all DEVICE_ATTR() must be unconditionally present in this file. The 
>> DEVICE_ATTR() requires the .show() callback. As the callback is referenced from a data structure, 
>> the callback has to be present for link. All the callbacks for these attributes are in this file.
>>
>> I have two basic choices for gutting the function body if the config feature is not enabled. I can 
>> either use #ifdef or IS_ENABLED(). Thomas has made it clear I need to use IS_ENABLED(). I can 
>> certainly use #ifdef (which is what I did in v24).
>>
>>>
>>> Not doing this would make the diff easier to read :)
>>
>> I agree this is messy. I'm not really sure what this request/effort achieves as these attributes 
>> are not strongly related (unlike cacheinfo) and the way the file was before results in less code.
>>
>> At any rate, please indicate if you'd rather I use #ifdef.
>> Thanks for your time!
>> eric
>>
>>>
>>> thanks,
>>>
>>> greg k-h
> 
> Hi Greg,
> I was wondering if you might weigh-in so that I can proceed.
> 
> I think there are three options on the table:
> - use #ifdef to comment out these function bodies, which keeps the diff much more readable
> - use IS_ENABLED() as Thomas has requested I do, but makes the diff more difficult to read
> - remove this refactor altogether, perhaps post-poning until after this crash hotplug series merges, 
> as this refactor is largely unrelated to crash hotplug.
> 
> Thank you for your time on this topic!
> eric

Hi Greg,
If you have an opinion on how to proceed, please provide.
Thanks,
eric
