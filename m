Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DA57979FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243511AbjIGR12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbjIGR10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:27:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915831BF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:27:01 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387E70kp023862;
        Thu, 7 Sep 2023 14:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=9+VdPt6uHlCQZvB9xLI91s1foxPxF7Z0wA0vbT+QhnY=;
 b=d7tv+RYc/g8p15wQzjgrkq+m04HG5EkljLwmh55lv5xsJRgq4UzU3BNuopaQma53Ge4c
 4QogO0AFyLLDDaBb0VfGHNaX0bHDHHxPlDpmodG7H0Kx/t5eGwL6JYDIu43GBVRVTQ8g
 oD4LNB5Uu8TkbOrWL+I0ae3gziLpkVpGeY76xRD4LbxVW3eld9dnKRa/kHKzTiBNRjyb
 HV2ZvQ1aFDH0KSaphipCtozuqP9JL0e2fBqfnh87F2L+GojPaQMVtyMUkksjeQeiVZtA
 Lfnm3rwRITAs2Uad1fVXLSRRnEgoFV6RQ+BCow5F69sTbEAOC2/qhD5xSmnLgV/iNcou cQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3syfvx853x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 14:49:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 387E4Msx037685;
        Thu, 7 Sep 2023 14:49:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suuge2vkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 14:49:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcSqS0fmKVfntHva8bPa4bm07OgPceu2CHFrkVISA+DyVTYGChO6EEPGEu18Y1ozH5hfD81nCzkpurzz1lQ2lPJqpdSqPdAGRaP5R0agVdKacVUEFY5FweaW9K9wkn6WlQL+4cN/Zm8ROpbFkvOmVs7V3pGNooQm0RVh/paZG/OxVE49CDLC182XwMbmKj9DPNAU8yk0OC/8q3M4iDU6+lTJE9EVBB1WW2tVie/c7UcxadQB95LeB/wQ8wIyoWjKjlJzDvUUxlZqKrk9Xjj6o1iOTu63bcDyokQDurLbRkoUMG4HhGKw3CNO8QcV9kJDwz9sfxYdgTuxpi+SCDTS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+VdPt6uHlCQZvB9xLI91s1foxPxF7Z0wA0vbT+QhnY=;
 b=QZ0o3TAk0+vmVPY5nZw2ogVPIYj3cey7AHC/+F/MiniLM6Te0IG3svA1CYNrRISWX30idKdRyEv4DHgZv9m9f0wEWfYlmDmwRk81DTx6x+VV8kjRDt2bgkpk0BFUpIpdeFS42xC3LsYBmPiW522579gczxd1pCwBIfIQfBRJLt3hs35jH8OKCbQ15wQIYITxpqAmNCTlizGZscsCj4kva2EfkTpyYajohmMqVPy8rNZICeLZuwZqcE928WQyzyDmt+hmNATGI5rErt2yKxbUtzckpFd6KJMkdyhE4cEzNBPUnULsUUVHWDI+3Eb4+nzT/b7jWtJdaouCR31Z+3OPzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+VdPt6uHlCQZvB9xLI91s1foxPxF7Z0wA0vbT+QhnY=;
 b=s0vfCZM7gwlilGxYC7Ous1p8ntQN/Sf8AYr1uspEkPohaYVTGf83ba1GMQ+gfYmcYGApK+hofjMJNucQIYdgP+By5oYnlVSyCnr/tj6PPtkyRjQ3t0k1sxROQfmzs2Xcz/V4CzjaJiNMx5+7YxnLeBjsmupO6qMD6Oe0QPkHRvs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5554.namprd10.prod.outlook.com (2603:10b6:303:141::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 14:49:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.029; Thu, 7 Sep 2023
 14:49:27 +0000
Date:   Thu, 7 Sep 2023 10:49:24 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Jaeseon Sim <jason.sim@samsung.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [PATCH] maple_tree: use GFP_KERNEL on mas_node_count
Message-ID: <20230907144924.272e2f2sckprbvca@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Jaeseon Sim <jason.sim@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
References: <ZPlNPGpAPy+7oQay@casper.infradead.org>
 <20230907033914epcms1p61c5eed4d34d5c4212436c201f33292b3@epcms1p6>
 <ZPlIShWJWt+Kxt8x@casper.infradead.org>
 <06a8624e-00bb-a332-4271-860847faf4a3@bytedance.com>
 <CGME20230907033914epcms1p61c5eed4d34d5c4212436c201f33292b3@epcms1p3>
 <20230907044119epcms1p3ff1dd04b02119ff11b77fe40b4842afd@epcms1p3>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230907044119epcms1p3ff1dd04b02119ff11b77fe40b4842afd@epcms1p3>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::30) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO6PR10MB5554:EE_
X-MS-Office365-Filtering-Correlation-Id: 6426d9ff-4c11-43ad-48b4-08dbafb1a28c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Om6IM7gecd+FT9PjW9HVnVIksavUvQ11hfuDdqcb5i6J1By9Jko0vDdljQ2YLuxMJYsTKT+UVTpldBviTQYfvibWXtqGMjTTDFuufC9r76qavblmWXEAvtXMylKk8I64uxUSejh7TDOekhfYlQD1r/g5LiN7dCafWx3Ve2d5tC8+kpkNBY+hT29xv5wLadxoqLM+X9KhbiACD6CjB2/d6I7jDYc9FZWbQJEQd07C8oAxBAAvjCoppxySrOtVV1R+3kcRAbXy/9yEYzxGCzBrmvSpSGgxREcML5R/SQeMsH180HcdSWCRrXzKZ4PPKdFyijFEBXoaTQyvI5xsUgEnC/pIQ84fjqrQCiIiDD5JUDoilqaj4EB9f6A78p3fkFVxaP0NmUfGpKbfa3pnHvrv+oKk7Ok1Ioq++cVvfobZM+OfSU74D+mSao82KQ3oeNb1XDGjD4BTqv+Dze6cireourv9wmwqonxVS0Ea0b6Y3leBoPXSyNL1DtpuqOB/4HffgL3ernWUwW6Fe3Gn9FBDVIO20ywHzd25ce2hKukCByLn29XW1mlFsTeP0ECEj4AU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(396003)(366004)(39860400002)(376002)(186009)(1800799009)(451199024)(8936002)(4326008)(8676002)(1076003)(26005)(41300700001)(5660300002)(83380400001)(2906002)(6666004)(478600001)(316002)(6916009)(9686003)(6512007)(6506007)(6486002)(54906003)(66946007)(66899024)(66556008)(86362001)(33716001)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjBNQW96OE0zRGw2eUJuS2lnbTlpUUNVVkNodEFDV01JRnlicU9mZldZK3hH?=
 =?utf-8?B?bFFZeklOWWFwRHlibUU3QWI3QXdEQnpLMm43Skc5ZmRLTFJzSnZEeStFdUk3?=
 =?utf-8?B?VVhyb0t1a3BmeTJwQnFJNHpzcklZVnVRalE0bmNLTlp0dVgzZzBjQWRmdTRH?=
 =?utf-8?B?UG9SOWFNSGRkeHVpK3gwRWFZMW9nL090d2syTkd4Z1BFcjAxZ3BkS2RYTnRv?=
 =?utf-8?B?ZzJzMThGVXE0Zi9yQWJHUmlDM3pnWUhweXhHUlVqMTE1TDU2N3p0NDJ1Qnl0?=
 =?utf-8?B?ZEcxeWxzb1hyNVJObVlFbkYyWDJCbDFpeEYveXdqY29ZcVBVTmo0Z0ZpTXRJ?=
 =?utf-8?B?eDF5N3Y2RTJyQ3JpblppL2dvUTVBdXZZUWtkbkRXTUUrbWJvSGw0b3J3UWlQ?=
 =?utf-8?B?V2E5eVJXek5mbzlxWWc4Y2pkSXVzKzhjQlFYTWZZOVp6MlpFc1MxZVBWTDR1?=
 =?utf-8?B?TXRMN2syaytvTXNJSndqeng4bDd1ZUtscFh4cm83bjFNc2RWYVBXM3VPSXdU?=
 =?utf-8?B?eXZwbGdiQ0dLMGtFdGRNWXo1THNjaHpHU1VBSndwdGZRTzJCOGVnWVUwZm9F?=
 =?utf-8?B?S3ZBTGcxRERjS3MwSHl0UDVCeWEzdUlvTTErTDU1WXNjeDFheTNQSkZtTmt3?=
 =?utf-8?B?dzgwTWVNMkZqcmJra0p3VU5ZZE1YSEQyWlZqbENUNmVrWG04MzB3aUxDdDBj?=
 =?utf-8?B?ekJuK1FoL0dtbDNkS1BnTjFVQ3Z5RDU2Z0wyYTdtQkR4KytHQnJqOWY0OFdw?=
 =?utf-8?B?ekR6VUxLZ1VUWUE3aVFOY3pGdWIvazdOV3doUWZ2Zml5NjZPSUFleXZWMUpH?=
 =?utf-8?B?QnV2M2JsS0lqcmE3WjlaS1ovVEhLcEh6Sm1XZEpZOGIweVQyblhRUWFpTERH?=
 =?utf-8?B?azltdk9hWHU5M3pKejNmWEkrZ241TWVha0ppakJDckM1WjJnWHZjTk1mZ2J4?=
 =?utf-8?B?NEpDWHVmVVFEQm5FYkFuOFlOeTFlUE0vQ3FVKzV0RmZ6NmhJTmNoWlhKYzYw?=
 =?utf-8?B?aWw4blRhdWN1bm1mbWxHTzFWd0VBZS9vczdRZzRERVhiN3pyRzNtVlhGaXRV?=
 =?utf-8?B?R3VDWkpTUnRHRmk4bkw1UlZMM1AvRGIyK2hQT3dzQWliNll5WXpYR2VDRXFL?=
 =?utf-8?B?RkNSN2lpbjFZMEhNb0xpbWJ0NzBhTXlROVplN1c4S0RzUGtEbm1ITXNvWkMy?=
 =?utf-8?B?UDlsdDQwUUVseGpQQ3RiQzMwQW1OUGh3WXpVU09TSzhrKzlTY3ZERDFaeFVr?=
 =?utf-8?B?SUl4NTB4amR0bnUrNHhxZlppSXZtTkdMTDNGTUlsQ3FFUlhJbG1VODRKUXpV?=
 =?utf-8?B?cjJSM0tBdmpLTzNBRDVMZlFVUW1wUGt6YndWK25aT0ZQOGVURklMTjNwNnFl?=
 =?utf-8?B?c1lVMmRobFQyMzdhQWRKR1F6c2RMZVpXOVJaY0FYOTFlWFVWTEpnNzdSQWxJ?=
 =?utf-8?B?SkR0S0xQOUNKQUN4RllrZU16TWpMbzY0N21kN0xBVlZpTS9zeVE4S01JT2RI?=
 =?utf-8?B?RDRtRVlMckcwQk9IOU5pRXBieGhwdkt5V3U5V05ZWGpobEpoWEhvNm0wVGJ0?=
 =?utf-8?B?dnNYTmNEeThkZDREdjVVRk8rRFl4UlpCR2ZydmN5ZlRvOG1Xd3g0QUhqV2s0?=
 =?utf-8?B?bloxcCswVkdCRFVod0d1K3FjK2pNSWNiZzIwRVJyZ1o1Lzh5bVdkd0c1NFVQ?=
 =?utf-8?B?US9yVkRPYUZ3b0FjOFVHYlp0UzljTDNGUHNzWkJmSFFhdksxUWJQV0F1RjM0?=
 =?utf-8?B?ZUpIUWRld0xCQTZVU0V1T3JwNkpEU3k1dFpiazhQNkVpbGF2TWlRd0xEdjlS?=
 =?utf-8?B?VGE0dG9CeVlWOUNaSTRSalZvdURva3QxU0VDcFVnZGVpeHFhVHk1TjVkNlRG?=
 =?utf-8?B?anFyMFBiSTVUenc3eFFMRC9CckEzbWlObkpVUEZGMHdDTlRhQkY0U1pUckZq?=
 =?utf-8?B?Q0orUHY4RjI1NUNDUHpEYmRoSks3ZlI4cWp0REdGbzFyNEpvRDc1T2Z5VGVz?=
 =?utf-8?B?TkR5Sm5XdWg3dEJMcy9saHFYeDBXVWVIeUl6aWxtOWMxdTc0eGtwdnB5Z3o0?=
 =?utf-8?B?Zm9JbEtBS1ZZUUpvbEJocTRnRUp6S1dwWitHZXd5dzJLc2E5SWEyTlBpNEFH?=
 =?utf-8?B?bDBrMVdLeEpERTlyNkt3UmNMK0gwZlVjSWp2c09GSDhsSmZMZ3VaL2ZKczFl?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QldyVmFaUTkxR1B1aGNmVzFRRzliWWUyR0F3dDZIUTdDelhNaExXdjc3eXo0?=
 =?utf-8?B?ZFB5cGcxMnZmVGhhaCtYb05WdlpRQkFtRldjcU92MlhqUldtNFk1RFU4VFVk?=
 =?utf-8?B?OGpDZTZwdVh5ckdKdkM5RjRsTDB2U3ovRi83djdhRlZQbi80SjFzNWJDN0xt?=
 =?utf-8?B?cFB0SFJrUlhUeENiL0FGRFVWTzhxdWlyQ0dhbFpiZ2lvU1hWUWVrdE5MWEZj?=
 =?utf-8?B?cUZOUm9xd01kSjFCL3NzVUU2MlR3RklLOTh3NElZQ3hnTlE1bW9MczRSdUU0?=
 =?utf-8?B?WjFzSTRVQWdYTW9HdlNRaFZvOEVlQXNYMjdXMlZRVCt3RDduV1FiNzAra3V4?=
 =?utf-8?B?V0JkdmR0L1JobE94eVZtU1BDODYvY3BFVWs0L3dEejF2WHNWKzg4aUsyR2U3?=
 =?utf-8?B?Z3Y3OFFEaFRjK2JpSUVNaExSbiswQS9sZEttc3BJdFp3dzVMQytaYXRFelBK?=
 =?utf-8?B?WlBJdXU4OHJwbG9uVWlmVmgxTjFibFRTTjVreFlxWi9EUWsrckQ0OERHcUxz?=
 =?utf-8?B?WDAyT1U3WHFSRit0OUFEQXVGUnRsWkhpUnpJbE04cmJDNysreG5IVjVidFJJ?=
 =?utf-8?B?cUdmVjVyaVV0U25sWmh1VXVRWURPYWNYbC81anBGOWNEemxuS2hCN1E2ZG5J?=
 =?utf-8?B?Z2hZY3JMdkhFV0dEdDQvajRTK2UvT0Q1SWFIeHAvTjRQRXpvUy9NOFBQbWhu?=
 =?utf-8?B?Si9SR1BXMzNlamNHb0x5Rm82TDVTMGhuTFhPRGN2Q1pBOVp6d3JKWlY2UGYx?=
 =?utf-8?B?djNyRU9JeVo2dzdlQXo4NjE2TjlvRE9UYVlpeVJ6T05QRkhyNm5qd1QybGpw?=
 =?utf-8?B?VzQ5VkJkRmJKVDNabThVOVV3QzRzLzJSSHdNa1B6YmJqQVF1MWxCVEd4TWpD?=
 =?utf-8?B?cEVkQjAvWllGZFBzcTNtMlJoRnZud0h1Q0JiSzlMSzMxMXVFRGsxWngyMmV1?=
 =?utf-8?B?NDZTNGQ1M1Y4dFV4T2F4Rm1QaXdNdGozWUhOSXhZajI1V1hqWEtkS0pBUFE0?=
 =?utf-8?B?cnFjRjl5NWJBZVFuU1ZtNXJTendDai9sa3ZsQTU5UGlUd1EvV0FXN1FHM1ps?=
 =?utf-8?B?cFhPeTdXT0NoVlNrNDIrRWlWMjNqY0JsZHhWc1hHczNwNG02K2s5SllISVFo?=
 =?utf-8?B?c3BzZkU2RU5PSHpmTHFLeTNNdEN4em1jcHJFMFRwU2diTHVwUStQd2Y1WGc4?=
 =?utf-8?B?T1J3L0xaUlh4Qnl5THJZeUgwQjFuUllmbmpyVEtMUCsxY25FM2IySURkWFZ1?=
 =?utf-8?B?R1R0aERROExTZ2F1dUZLN2p6emYwV3NnS0ZvcTB1Q2tZdjVnR2VvVnU0QVZF?=
 =?utf-8?Q?3LBhocZCXl8b1Q6jaBC2DcYnHUnc+dCuhW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6426d9ff-4c11-43ad-48b4-08dbafb1a28c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 14:49:27.5484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBp7uviWMIBKYp487oCiUoH4/XiGm7kToC5xLnTTMdh/thPszDaIi36RvKuEL9/vJFL3gUjnM9V+HV/aGCPMHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=902 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070132
X-Proofpoint-GUID: NNDNtqY0q10RKaXRsJpg_4pTd8nyD0K5
X-Proofpoint-ORIG-GUID: NNDNtqY0q10RKaXRsJpg_4pTd8nyD0K5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jaeseon Sim <jason.sim@samsung.com> [230907 00:41]:
> > On Thu, Sep 07, 2023 at 12:02:02PM +0800, Peng Zhang wrote:
> > >=20
> > >=20
> > > =E5=9C=A8 2023/9/7 11:49, Matthew Wilcox =E5=86=99=E9=81=93:
> > > > On Thu, Sep 07, 2023 at 12:39:14PM +0900, =EC=8B=AC=EC=9E=AC=EC=84=
=A0 wrote:
> > > > > Use GFP_KERNEL on mas_node_count instead of GFP_NOWAIT | __GFP_NO=
WARN
> > > > > in order to allow memory reclaim.
> > > There are many paths that call maple tree's mas_node_count(). Some pa=
ths
> > > cannot reclaim memory.
> >=20
> > Right ... but we should be handling the ENOMEM inside the maple tree an=
d
> > allocating some nodes with GFP_KERNEL instead of failing fork().
> >=20
> > > > What testing did you do of this patch?  In particular, did you try =
it
> > > > with lockdep enabled?
> I did power on/off test with this patch.
> I did not try it with lockdep enabled.

To accomplish the same result, but with a much smaller scope that will
work with lockdep, I would suggest changing mas_expected_entries() to
use mas_node_count_gfp() (which already exists) and pass in GFP_KERNEL.

Since fork is the only current user of mas_expected_entries(), this
won't break other users and we can deal with changing it for others if
it is needed.

If we do go this route, please add a note in the documentation about
using GFP_KERNEL.

Willy, does that work for you?

Thanks,
Liam
