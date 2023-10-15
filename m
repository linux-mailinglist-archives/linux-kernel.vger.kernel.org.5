Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296E17C99FE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 18:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjJOQXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 12:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjJOQXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 12:23:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E428DAB
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 09:23:41 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39FBU2Wc030053;
        Sun, 15 Oct 2023 16:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=U5/RFU14y8E4JieQ8lnHLA4Vgcp03418FPDgLL1v1OQ=;
 b=vBnZSh2tERs2/dvDywUTcNUVKJvLDG1nTi/vDjz6wXv96SePLxDn2YaxL0Ux+FJBoxLY
 plgdwYeQ0pO0JgwQT99T9ig5XJQ0ehrkD9pTHd9uerl3EWU3lAocFOZwBGjIw5U69g/n
 lMrx4XczizCIqOD22TK0ZsO3pC5uec8f32sPqojOtyhJQx57aXpntZeSBN0aeQoJ1ZBn
 LO49cy/zPFh88puPVWhlGr8mSDliwtvSX0crxzZgGhY8WaJXUitE3XQ5bQDCuiAzzi48
 JLzjfhAKeOT2cMembUsHjkuat/OdPpf3Ynba7DUWWEeA+O3VFfqbTfxYcerucjPUZbzo cw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk28hbta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 Oct 2023 16:23:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39FCHXMf028688;
        Sun, 15 Oct 2023 16:23:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trfy14b7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 Oct 2023 16:23:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ce0ETRpASeZQGNSkndDS7d+03HC3vJZ+Nj4vZOb8FHsMuKe2QKrVf0/w2lAQKujPUaH9sp1TQOD2sNYfAGWL3XbmW3JOEkJY/5pYVrZWGdwEDiR9102thh4qsigVMwhzXbMRfjMPM8Qi/Eg6IwpLP5R/IRgmI/PmY00UfTOGPL+0gxOQiUG+f9apTfwVFchebRP9ceg0FKCCrNCsYgT1f7+knBnITp94K2pfc9ov71OluenhCaSRsJx+od4cLuaw0lBkj8gd9gpbxxLDgxY7XXAVjkS3oSwH+S4zu7F1KfQtOPyfS8dyN9Vl/qYLlATMkWYDk3ucAoCbw71YVA+7LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5/RFU14y8E4JieQ8lnHLA4Vgcp03418FPDgLL1v1OQ=;
 b=ZBDy3iHqL1yCZicX93mRQi5O4k4D9Xg8DtDUPM8XrI8aD0RrI66EW2ucvWgM/t77X9SIV9c8pkBH5tLW5PNNmPrAZC365kgIpslISyP8S7uzunmvwQi0eO+rJI+PrMcGdemNVbUlsp6oY2vDMLEJ0pnhKjftDRJ8838VBfa47DCTiOYo2/QRQokaykjkaedtbrLMHBKQO3/B749pkPATmiov0L5wi+o4IKuTe3geNJ6/V0rv9q5MCDoupUYAizjyGVHqN/MunihFKndgkOX+hwf1sR1hQ6hPImeWNG+uUqkSPKK9H/D6KUq8C4wqgz+RLC15mJYIpaGH/MLSS9foTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5/RFU14y8E4JieQ8lnHLA4Vgcp03418FPDgLL1v1OQ=;
 b=Fh0ZcND49ufdF8IfXPQ226eZdz6vMKhDBH5CvgHmSWhcVgKt7u/5LTcZnuX2Te73Qx6Wm1VSkHaL0pARagQB3PhN4r4tEdPPstBttMIkPtRWMB6IdFFq8J78+AIcfY8Z/BK8e2OMISZEY/AkshQDZeqWwfLpvDHR6RYe7v9lC+M=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by SN4PR10MB5605.namprd10.prod.outlook.com (2603:10b6:806:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Sun, 15 Oct
 2023 16:23:04 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::afa5:d894:d483:c5d2]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::afa5:d894:d483:c5d2%4]) with mapi id 15.20.6886.034; Sun, 15 Oct 2023
 16:23:04 +0000
Message-ID: <83cbf3c9-1a68-4ab2-bec1-658844d6566f@oracle.com>
Date:   Sun, 15 Oct 2023 12:22:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/2] x86/percpu, xen: Correct PER_CPU_VAR usage to
 include symbol and its addend
To:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20231015161036.39689-1-ubizjak@gmail.com>
 <20231015161036.39689-2-ubizjak@gmail.com>
Content-Language: en-US
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Autocrypt: addr=boris.ostrovsky@oracle.com; keydata=
 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
 Jg6OxFYd01z+a+oL
In-Reply-To: <20231015161036.39689-2-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::24) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|SN4PR10MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: abb54d55-5aea-4047-781c-08dbcd9b0227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cw9+48Dc20mzyv8ERMifqZB9rbC85bPlaqqh/1p4iq/tQ7TgN7gapU08/JJaJ0cRJ6SHo8HWD80663pv7GIyYbkycoR4STxh8JACvhO6hbEgInClwmmtaZMWi2FmlbK/yuNpavFkQ9AhluaTyjymAukJMu8329a6J5PbkAaswzdUHc2Ffo17tLOBUFrd4xP/7gRpoGCCbPNNRWnPGi3hgw6sh2nocj1G3wnJcOBnGK+3jS6aFxpgnQ970iC7dilyZcyb5wyfGeYDwfYP4zIqHTQEi05RCENnEtRFngFywJrTTaY+ASfkTqLMRjYhgzKBmBr5JdYaM28uB/GF8o3cPuytiI1KgrAkLLFgxg57pKVN/whwFf4k+aGTeUfCp2dwjCcg2uWp7il2Ce7w41XkjxgRPP78J8b/iLechgQP2DYOaiJqPwOOcL0QCNhdza06qQvvFPPHFa2lcdXFXAU/MhdYUQCRaz7ce6aUcPf6J+W9Er+VMdwnW49Pqi3AL4BGyRR4fizJApxZofaagIbsNwqk4/eBxSmvuLTUgMyf/Wq1XLWD96w+rjWyIXEdDHsIaWTypghGM1yx2LO8cz1V3n8jXKnEyi/j9S8d0mvJo+xNquBa5I7RJJSF1L18LokXlhP/RD4ZwF5rFeT2+YVZFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(6486002)(6666004)(66946007)(66556008)(66476007)(316002)(54906003)(26005)(2616005)(53546011)(6506007)(6512007)(4326008)(8676002)(8936002)(7416002)(2906002)(4744005)(44832011)(5660300002)(41300700001)(36756003)(31696002)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGMvMkRoQW9GTDZjUjJxOEtiSXpLbmtFMk1rTGVSYVRoQ2IrTXlGeGR0bjR2?=
 =?utf-8?B?Wkk0dWY5N3VyK3BGS2JNN3BBOEs5aHlpbHA2QTF2N3RsNHNoamljakxCbzA5?=
 =?utf-8?B?dWtnb2Fqcm80RFVFN3BQQi9SOTVlODV6NkxUNFc0aXlBQk9YNDJseGp0bHRi?=
 =?utf-8?B?dXJaWXpBMzl5TXdSUjgrdW8wM0xNNzJDUVpOTUpwZDBVMndGeFpBcUJhbWYy?=
 =?utf-8?B?OFJ6SXhZWWlKRzZNZnAwZHpjQUoxQ0tHay9JN0ljK1hGbzRCQjVBQlk3TjMx?=
 =?utf-8?B?S3NoZXY3OW1hM1pDcnNscjdHTWpmcWxEQmtRQW11OTRGZTJKMTNnczV5N1lC?=
 =?utf-8?B?TzQ5STBOMElkdGpBME5ZRStnaVg5RytGekRmVkRqMndCRDJrdXBzK3FGWE1V?=
 =?utf-8?B?STRMdEI1WEpFSUZqZnRGMVZYdUc3L1ZtQXpPQ1ZLdEFGVzJmbHNPc0lEdlRY?=
 =?utf-8?B?TXNKb2dLWlA0YWtyTk02OHkzWjdIUkIxU3V5WmRKS2tKVXladlV5UDBzbHh6?=
 =?utf-8?B?cVcrQnRIWFZZWFZXcmFZRVBPMmYzOWhEWTQ2VW81ejJWb0YvSVZyTDJ5SVdF?=
 =?utf-8?B?UnJ6MndZa0phU1NKSnE1T1htTXM5M24yWSt2cTlCRUhPejVsaDV4NUlCWnpZ?=
 =?utf-8?B?VUlLTm5qcEhzbE5pOFA3TzBtYU9IZCs3bUZmdGFHRGJsWUhHRG9ZdWFnRG9I?=
 =?utf-8?B?RUdPK2Q1aitJQmt1dW4zcUU5SUw4QXBMNHVjVTNLSTA3dVhST0Z5NFhMSURE?=
 =?utf-8?B?M0hVRDA5N0k2TllORUJ5aGZpdkxodmxaQlZDWDlueGw4cmUwM0pnMk9aeXZr?=
 =?utf-8?B?VDhRMjRlRk14WXNlU2dHNGZSYk10dnFMUGdxNkR4U21RajRSQXoxVUZmSVoz?=
 =?utf-8?B?SmJBK1FEVm9zU3FqVTVReXJuS3ZISDFtcnc2RTdZOTNHcjc5TW5kRW9xUlNv?=
 =?utf-8?B?RjN4czVlQmpPN2ZUSXlTMzVGYUtXMWV2WVlmdjAyY29kaTBROUZLTWNMU0ZO?=
 =?utf-8?B?K29jbDZIZzNhSDZaYWJFY24xREljY0F3TEk0dW14eld0bWs4R2ZxajZyaXph?=
 =?utf-8?B?ei9lbll2TEdrRzFNTzZlUVQrazFjRTh6VUhTayt1SzRKeVg0OXd6NGRVK1I3?=
 =?utf-8?B?Z0YwMDU1TmhsaU9XanJDaktBdkZWallNV2VaMHZLbFlQOTRtcUlkZTFEcjRO?=
 =?utf-8?B?MERSVE50RTNpK3daYVQvZ0FhOTc1cXRPRXRzbFJ2eFpDOXZqU3Nob29DUk1I?=
 =?utf-8?B?VEdLQWdvOHZ5dndKbHVrbFRHUlhrOXUyWTN2MncrY0liaXlmcHY1eDFiQm9I?=
 =?utf-8?B?U1pPeGlQSU9wMEVFMzY5bExYUVVsdTZUZi9IYWtWZnJ2YW1EdXFLeWtUbmVq?=
 =?utf-8?B?MmdCTXVxL3NLYmlEb2VVaWx5L0o1K1YyaHRNOTNlNXFEOHNXbTZHQ2Z1cCtV?=
 =?utf-8?B?VE50d0FDNmFEVjJuY29kNTBEdjQ2SnpvdDNvbDZjSDVIekg0U2hWMGc4Zklu?=
 =?utf-8?B?WFRoRDdKazh0TnJjUHAraDAxVlJhVXFUVERVd25KSXpKNzY0WkIrczJ6SnE4?=
 =?utf-8?B?ZGRzUGlLZFFpdmpNMFNpcVNPNWpNUzdtZUJKR01nZHlmQk1EVGkzbzNKVzJE?=
 =?utf-8?B?c3J6RkgraGZ3UW9uOHdtMDcvUnlWVk1MckxtdWIzSjBIczNzTTcydysxbnow?=
 =?utf-8?B?VytpVHg1aEVPbVhOZHNBdWlGOVl4YWZ6d2RZUW4rMUFmZzlwYzNGUjkrVmln?=
 =?utf-8?B?NzdEQk5HK0dUM21XSHBQc0VqT0M1N3U3VGF5SDBaSm5WV201eEMxVnVVclFu?=
 =?utf-8?B?RVhINVFBbEFuZng4K3lJMDBtZVNTUE1hcDB2QmtIVzBQeEJOLzZ0ZDkrZko0?=
 =?utf-8?B?bnF0d0NLVE5DNmZPU2N4bFMxNTlEMmhqZWs4U3hTalN1K3luUHNmWTdzZ2lq?=
 =?utf-8?B?dlVabXBQcDd5QVRDZ0VUZnJhTnJETXJVcmFneDNiV1VPcWZQeEJtei9zdEJz?=
 =?utf-8?B?ZElHS0pERDZCaWdxckU0S21manBlMEQ4cExmR0NENWNWRWwwbFE4SVp2WTNj?=
 =?utf-8?B?aWt4ZDV0akIydjNHcFV5SFZYYXdxMnF6OFNBY0IweFp4Rm9BU1JKT3p6MlBB?=
 =?utf-8?B?ZTVGbmFKTFZsNDJVTStLZ0pTcm9qbXN6S1o4eHFGOUcybHowYUVTc243YWZB?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cDVaejN6SFI5MWZtM1FMRU5IUFFYcXhmdWpjSmFIRzZFSTVqaDBBbEJFNlNt?=
 =?utf-8?B?ZGxMWVQ1Vzg0bWtxMmU3SHY3Wkd4dWJlN0plSWFqWFhRdGpaYnA1Ly9DRGln?=
 =?utf-8?B?NVBpUW1OOWcvenhaYVoyYWZESXVqWCsyZmJya1NOZ2xRU3BuYVVucm9oOVVE?=
 =?utf-8?B?Tko1Z1pzRG1BcW5RZ3VuQ1F5MmFLc3RGSFRCUlRqSVl1QmsxdE56NVlDZVgv?=
 =?utf-8?B?K0I2K2VjTjl2RytWWU9sU1pnNGh0a0d1Ukhkbjl0YnJXbWM4bnZIYW5jUC82?=
 =?utf-8?B?SzZ5ODRFZ1JtdEU2ejhaSkd1WlNDUCtDNDVhYmdYNmdBV21pU0RGSDlsMkJ2?=
 =?utf-8?B?Z2lqb2Y1bGY0azFGcFU3N3FUMnBqRDZRcTJ4U1ZmRlVwZFo5UXRLcTF4SVEv?=
 =?utf-8?B?Um9VWUlGNHFvWDhXL0FYRkZuQmxmbnhkU2tuZ20wRjZFU2NGcDN3VENxYm1m?=
 =?utf-8?B?ZDhGWWdxdXJha3BVZFVQT1VaU3VEZ1VyUUpReE9IQkxZRzdSVkI4eEVCai8y?=
 =?utf-8?B?d3pzSGJGUUxIUjdFd1FMemtLUzdNeHZMZ01ZcWFOMXJOT3BOVTE4MmoyU3l3?=
 =?utf-8?B?NUR6b0phaGFEdDA2Ym9wL3NOUWVaSFYyY2s0cWhVV1lzMEMvYThsdWk1MEJS?=
 =?utf-8?B?WjMxSXNIS0J3Q2VmQWNIV3A4QnpPNVZ1cDRSWGdnQWxtdFd3WURPQ0k3VEVI?=
 =?utf-8?B?dkRPRnNaUHVOOXlxUDdKR3pYYjlQVUs4a0d0US80ekZ3NmNDQjk1WHN2SzdH?=
 =?utf-8?B?YmZXTWpKQm93S1FVOHZSNmVkb2lqcTNqZFJwQjFQMHRYK3Y5N3dzVlVUUCts?=
 =?utf-8?B?QmwvQUQ4dG1aVUlNYkdPQkxLTVZDT0lKMGxPd2RvTUhsY0M1YUJQV1lHdDJy?=
 =?utf-8?B?ZEJ3cWtIdkJ3b3VZQ3BaK1BPSkdmR2padEc3K1IrMzZUbDBIbkg5S3NqWTU4?=
 =?utf-8?B?Um5GODdFK3NkVURZSFRoWUNWY0VOMy9qT0RhZm05YWZGSU5sZ1lVaFkrTVRl?=
 =?utf-8?B?cHQ1TUxCZE45U3hmNmIvL243d1EwVXRtOGpUcUtFLzNVZ25uQnQ3bi9rZFQz?=
 =?utf-8?B?L0wrVjFCZVlQcEdXQWxVNFNuMDkydkx0cUtadUJLTEUyald3MzJqcUQ3aStk?=
 =?utf-8?B?Sy9yM2MvMTVHL1JyQk9MRUNIVDZmZEFqcE8xZThCbFhLWThWTTFxZFVqTVU4?=
 =?utf-8?B?NmRBUXJLZC9GcUk3WUwzTC9HSzZjRTJtY2MxSEo5eUc1aDhOcU5POXpSaUlF?=
 =?utf-8?B?RU16ak8xMWhrc1BQVEFLQlhnVGhWTjhPSmVQNXE3WC9VUFBKRGEzY3Z1Q0ph?=
 =?utf-8?B?T2kvR2ZTMDhWVkt0VWJBRGsvREtqMGR5dkl2dEVwdHh4TVVYTGxlVjEzbjc2?=
 =?utf-8?B?am9sbWhmUXhqTXBtT1Z2dDRTbGhzQVVDYmpsUXZpUkttYUZTSDdURS8vWVlm?=
 =?utf-8?Q?RlDQEZCL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb54d55-5aea-4047-781c-08dbcd9b0227
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2023 16:23:04.4469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfLiuwvWylAvgMxBmiRUczL0JPjRf23gDhGfsGSbchCnJl4EjRhE4wAwxIt6CcXK51pioWjzULcOLYHT9Hxx9LCY+ULrzWT1srUrcggko7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5605
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-15_02,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310150148
X-Proofpoint-ORIG-GUID: hqat7VCFzDJtfuLry0JkTBDHSgyqe_0k
X-Proofpoint-GUID: hqat7VCFzDJtfuLry0JkTBDHSgyqe_0k
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/23 12:08 PM, Uros Bizjak wrote:
> PER_CPU_VAR macro should be applied to a symbol and its addend.
> Inconsisten usage is currently harmless, but needs to be corrected
> before %rip-relative addressing is introduced to PER_CPU_VAR macro.
> 
> No functional changes intended.
> 
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
