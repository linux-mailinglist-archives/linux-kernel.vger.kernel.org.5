Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0B677E985
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345757AbjHPTTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242200AbjHPTTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:19:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E25270C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 12:19:04 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GH4Amx007759;
        Wed, 16 Aug 2023 19:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=9Ggx17whv5zReNfNnoTumKOoI929NCcd53+Pe80SOJM=;
 b=I01P0iuNRT2cJlc3Jeas0oY4zMmefM4oJGt7LS2PXPr6KmMGda9KvHtg7BjEpjlK3Zql
 l1G8KQFxLwIBKOr01w4q+OL7tobq/KEucmD0TDMmBf2KX/rieprU3MYZ7xJeNRuj/h57
 g+1jlHFHOC5BfTA9cCyYb7vsRqf0Bew6rYOZQlGJ2wW7IqIlOe16MLy0OwilHuh9Jtns
 dy+zrc5gzPLKN7Qak9nUQWU6HdTML7D6AjxfAl1IlqMJuKTyryTNBDHV1LKbCYVNpAT5
 X6oL1urbhAkTr23+bvS7oKuO6hUQo5KriGyT3uHFug7FHBcvjGpNBC8GDjcZ69b8+/6W 2A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfqtpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 19:18:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37GIXtdj027320;
        Wed, 16 Aug 2023 19:18:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1tw6yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 19:18:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqHNWrBmXcpaD4xfBdGINKCRerUwrvR/oJlqLMf36UqMi/eD1Iinu5aVw4SlNv/pZIph7YYqBPbTDXc037uzTY3B9dKWzYHWt8mTYOeWq5PLeYqHmkNhPW15xuAWtduENvLU20ILs+koBw0glN1KLBx2f7rhbLooJpxuVh6tAPRyq3vGtFbfPl4E1Hn1pE4vFKIkLowV6eogmB3OEikgSEwGSzyVPaSlc4q1GkLWKvg95v/TBzLQvFr+Qp28jD4on1mTfKMTWPVM+s1aYobU+FInMBlFTy2n0FVTJ/xxvZs6EO3oFp9Va46i5ugcnS2GZ1MhqE/svOrIzd5wf73TVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ggx17whv5zReNfNnoTumKOoI929NCcd53+Pe80SOJM=;
 b=RUGUdLhMsYlk0jb6nOFlle0ZXgfUtt4cBc3J4f5dchgTtO6+eYUAxd8e6LyxUtVsE1my97Kzcn+VVcwHHOftCDd0k6Wk3tx8bjjn6/qYB2If2kF9+vV4fzpAF8ei9silM0EXpBn/RMp1Fnkv1OAAT7l/eyduPfW0NWE7Ad6SeJpz/u3esPePa9ZMFKyK0pavZWlvhu5z15UgL1UD2y22THYvb9vgjhC67lpnQSPOFcx7sFh5fVz3lqs61z39+4BuFRN3522iywz6EYL/P2P8pHG+zAhf9Ga9/9exfLtFa1/0KgKdJQyYlHgMHCO23iNbprmVRK8DOkKieTcjTQu89A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ggx17whv5zReNfNnoTumKOoI929NCcd53+Pe80SOJM=;
 b=K+CN3JlxXbupdpRXAOk/RD+de8VA7sbfUYnec+BxbuQZlEnFnJ20dcQhDIe1be0O8wZALmmcwgUTvMmC6o0J03Ooh/RsU+G8Kd8ekr3qMY0UXXAQMffT+IFbIs9SVu8nGaWXzR+jxiC+gQcwKHAJ4Z1JEI6Eh5dybemesTdAIfQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB7272.namprd10.prod.outlook.com (2603:10b6:8:f7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.23; Wed, 16 Aug 2023 19:18:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 19:18:53 +0000
Date:   Wed, 16 Aug 2023 15:18:51 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: maple tree change made it possible for VMA iteration to see same
 VMA twice due to late vma_merge() failure
Message-ID: <20230816191851.wo2xhthmfq7uzoc3@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com>
 <20230816161758.avedpxvqpwngzmut@revolver>
 <CAG48ez3mcH-ms0piv7iMcB_ap+WDgkE_ex6VHSZw_Aw30-Ox8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAG48ez3mcH-ms0piv7iMcB_ap+WDgkE_ex6VHSZw_Aw30-Ox8g@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: c2787a86-4d04-4eba-65f0-08db9e8da10c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttnkE1DN960TWr4DaP95ZsKuHWWA7Rx9x4kGrVfs2Yc5TQptOEXNFv3RTLk1ikMucmCyCSdS7qdhoIs/GjX7OvcVjlEC2SXI62RaqbVbM45fSMb2izAcmu7us75RDAtLSy7Nzh5cZtGZx50XOYRS2aRFAAEQWFy661QPgtxBfc6kQb50gYYWDyq68bnRA1pxjgCq7Kl0eeMVG87SWuXMpuIrmUumb1HFmCS/bhU1XWNTyaXl/9NqMnI0z2VpTqt4CmArHMNOirtxwOgokC6x7lXiU7c+2KiAI8M94FMQa/uTi2QCB3rPkmduVHVy19Vl1flEZ7+DbEHmHk0q6hIFY+wYzXagpDUgXqDtMGqRyZh2MUxSO2CXgiB/zizGZDqMaMeNkSQiYRtLCDjTvVmgVRTpopoT1O89VmlPq+zn/9DrkZoLi7Gbw9QC26RZQNUQoU7ZdcNDqZEnnvuxNFHbP8sTwyD1iFOr5ouHbCjy95KIbOfyXZHbmJXyPR21Y9vGQ6GsOWlW8Hzq6FPSmOC03n0Jlr1f5hrgfFM6ISYCYj33BQtp0VX0FHJwo7lJbEqY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199024)(1800799009)(186009)(316002)(54906003)(6916009)(66946007)(66556008)(66476007)(5660300002)(41300700001)(38100700002)(8676002)(4326008)(8936002)(33716001)(2906002)(83380400001)(26005)(478600001)(86362001)(9686003)(53546011)(6512007)(6506007)(1076003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTIwVlgvT1Z0NENEVTd2cXBCRHMyZzhKWmk1LzZXUVhMWW4vUy9zWVpKNU9z?=
 =?utf-8?B?R25BdGRLMjdsQnhLa1dVSWYyTTZqeU1YUGxnZ2NOS2J3K2xRMXZsZE1RMXF2?=
 =?utf-8?B?NGhaZWVianYyZzZKbzl2eVB4SC9iektjYWMwVmRObGV1OVh3TnNOTHM2cys4?=
 =?utf-8?B?OVFXYUxCMVJnRC9OMEZxZ2tZWlJOQ3RCVWtxWVQwRTNGcGtXMmQwWUVhVUw1?=
 =?utf-8?B?d2srQXdKcHJWSHlZcmRUdUNQb0lKVDh5QXVzZFRDaExIdUJXdkl5Wm9oSmN6?=
 =?utf-8?B?Qm83cDdQdE1oUklrSG43dnp3eXRETGN6MlpVV2ZkTE9Uaklpb29xaHJJVVJZ?=
 =?utf-8?B?SkUxUXMxeG5VSTlRcEs3R29VYW1oam1IbzZHYWkrZ1dCU3hqT3UvSWIxKzQ0?=
 =?utf-8?B?b0FaUUJKTVZ3UGRwUzY1VGRBMlQ4UFMrTEtZZ3hLZVdvUFhUaHMwNitCVmpG?=
 =?utf-8?B?UUxFVGxFeERrcWRRTXhqbVI1MUlKeFNNZ3YxRWswMFl1TmNOaDU2MmVrRG5h?=
 =?utf-8?B?UzNyVkdMQ0dnU2NhWlZtNTA2WnhGZlN5QW1xS2tUZjBXR3orZXBPUlBkWi9P?=
 =?utf-8?B?UkNpWXJhOERsK2tLR0JGTHR1V2I2dkNzSGsxM1BQNTBGSXFqTXQ2ZmRRQXUw?=
 =?utf-8?B?cWl6QTMzOGM4K3hzWGVoLzZRLzUxOWJYaGlGNEtvVmxveUR4MUQ0SkJmdjNQ?=
 =?utf-8?B?dE9TTG4rWFNCVzRJWjNacVN3WlMvQzVROW9BSUt5a1UvSmJKbVZMTGhPM3Bk?=
 =?utf-8?B?SnVOZ2JxVFZIT1ltbDJzdGFaTnVqN3NQWGdDRzJrdnhIeFNlNlFxLythWVVM?=
 =?utf-8?B?alpEb1lYN2x2R1J6eGhXZ0VldTZFMGszZFdwYzljMWRWNHpYWmpnc1FPb2VI?=
 =?utf-8?B?RHhGaEg2cy9pWHNqWHRDelVpaSt0akk3aythNGVBeGhNMW9lM0wyNjJaS21l?=
 =?utf-8?B?RUhpd1dEYUZNUW9ZUDAvdEp1VVdtZEhoV2NJTS9ZZjFmWis1V2xDWS84Ri91?=
 =?utf-8?B?dmVjdWNsbUl1M0lZWDFwUlMzaWpDZ3piU1RqcFg3TlEwUHBEK0MwaU9vbmNu?=
 =?utf-8?B?bTBwaFZ1STFUQ21LY2xoN05OQWdaUmxoS3JSWEVyQmtvTkhHYXc2cG1aREJC?=
 =?utf-8?B?Z041cS9zZytQVzdwU1lpRFd5anJSZGxZRTVGWk0xMWV0bGZ3MEU1N3lGM2Zr?=
 =?utf-8?B?UldCY1BjOEh5UmZGMlNBb3RGODc3NGQvejhFTW5MUUI3Sk1CZmcxZGVGRmQr?=
 =?utf-8?B?RzlJcTFEYlVpeDBpbEZhNVNvcFVCbHdUWXZKQmsycFYwckRhSXBqY1pYUHJX?=
 =?utf-8?B?Z2RBNGlySnFGNm1lMktPRmQybVptMVgyN2VmUHQwSU5mSXlhTURVNE5PeE13?=
 =?utf-8?B?NWwyN055aDJaMEhGbHRlMU5obGgxc1gwTlhKRy8vVitJc1doSTFlWXpjVmxF?=
 =?utf-8?B?d2hUSUFLT1dzdTVwcHNCWHR4MldrZm5oMFFWUnJONmFKZGg2ZlhtS0ZlMjRr?=
 =?utf-8?B?Tkc2RmM5MmtpUHpuNUZSZ05HREZXZGp0Q2l3RzhIbG13c1pLTy9UOUZuTE8w?=
 =?utf-8?B?azRZREVHMTNndjd2TGtTbHZvQmVkR3JvZkFYcTA5SFNBSC9NWWxveW5KdXdq?=
 =?utf-8?B?bkJhYUFGK1FNb0p2Q29pakJ6UmxHNDRWZVJEZlI4QlhvVkN5a3dTdHZkVlBL?=
 =?utf-8?B?WGRtdW4rQkpWVitnV2dtN1RXNHcyRnVBNGtEYzhwVjhkMzNpclVxeG1KM2NU?=
 =?utf-8?B?WTcrY0tSWUJkMUpZcXcrcXNFYlFSNERyeDlRZFdVL0tmQitsUGNRODBoWWZO?=
 =?utf-8?B?eUVNRGFIa0VoYUFPajI3bkdlc3ZtRjdqTDlsMlBtU2EvUjIwMHNhMi9CL2lh?=
 =?utf-8?B?dHdZQWQ0cVEwcmkzWVpDa256MHdaSTFVRlFnay94amtyZHlHM1JiY2E2QXpL?=
 =?utf-8?B?ZTRvMXZmVkc3VlhSV3VSVnBHQ1MwRGkzOXcwYTdmNGFVTzZiYWtaZWlkaU5s?=
 =?utf-8?B?a2xoR20vL05BbzRHNFp3a0Npd2MwNGlxTHhLbUVLVGxzUWNTbEtYbGhIR0lH?=
 =?utf-8?B?MFE1WGtUREorNldMZVg1dE90NzVhc0NoaWpTcmJOSmFrblJDTEM5dlR2L2RC?=
 =?utf-8?Q?Hd4Qj0M6QlM6OzcsQkPNkiV2K?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YC3sZaUYzGHLjKK86n+yNWnc87zVRtaj+y03tpI/VyR65M9ncEXE6PeZ136lnVtJwDg4oX/+lT8EoSStm4gLcmqcoKXd/LKCx6xPlmzcSncdSOllQ81csBgfV8788ZyJ679dk391xkIsHR5ytml6DMD6JdvYNFt7FrtAmt+jVzGy/vP6lDAR7MDSpgUh/VNhww+6ZkdnZE77cbEPLo6j3jEkJgiR0nxwVf92KHVmMc2/qr3B7fU0kqsJXtuGwJmKROer4tF4Ko2HFClR7c2scNhs3GBtHqyigTdqPX5IJzMORGSNNfv3X6m1DMylAeY9PuXAfKn7dDp/vdPKguRkBlpMeEgJ5dAuL0AlBp9xp86ORyo8xL0T5PIsXfaUw8OgHeAb42sP8O97SoSPoZclhhbGGb3IY0jzpIfLIurGY5q0MYY4g5gXVCM9YBFYbNkmdf4JJGxYKDttF6ToRucFNhi/XM8bAb4XcuuCJABEpyxHsUYZuJRzgE2ujsQ4oK7K8T9ABk6kvDBkQbAsRI/t7UtXdGpAr/p19UPq9w8qeibHqEpwbmpYlKUhFxxGu/Zv71M5cYFU74riQymzVq8wq3cbjPzIyWcjFSerTBEWki+RO0zxIujTOgHOyHQ04rrZ8IKk46nvtq4qvX++1n/Gucp6AoEypgC8BmVml8rwuz9re69UcDvgJfJlFXtsJVxVmCiWWQAhuU3sQfEjLcAeS0wLxw3RDf7ojE1lmA+VSunU3dgBQYrpnX1o5YZX9e5ViVpFJyVh/qBp9NLRVeO1q/3Sqnf+QRyDff3E+pmF9jVFjU2TtOl8yj6BW0sJI6cSJqEn+JZPJZGO8KmiKIYCTOHhCeHYBe+N18focxd4mBeKajaFKZ9hdyOr17CndO+5
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2787a86-4d04-4eba-65f0-08db9e8da10c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 19:18:53.6101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLrANv4dh6D5bhvVH+W1lljXc/0bG4owg6b06msLg4hbbEpCjhEy9aBMJnZDwXubnRRagNnkMVNUgFcgTH5aCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7272
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_18,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=893 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308160170
X-Proofpoint-ORIG-GUID: Ht732aIBN2gaPSNFXwPehJ9TCSdDp-SF
X-Proofpoint-GUID: Ht732aIBN2gaPSNFXwPehJ9TCSdDp-SF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jann Horn <jannh@google.com> [230816 13:13]:
> On Wed, Aug 16, 2023 at 6:18=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> > * Jann Horn <jannh@google.com> [230815 15:37]:
> > > commit 18b098af2890 ("vma_merge: set vma iterator to correct
> > > position.") added a vma_prev(vmi) call to vma_merge() at a point wher=
e
> > > it's still possible to bail out. My understanding is that this moves
> > > the VMA iterator back by one VMA.
> > >
> > > If you patch some extra logging into the kernel and inject a fake
> > > out-of-memory error at the vma_iter_prealloc() call in vma_split() (a
> > > real out-of-memory error there is very unlikely to happen in practice=
,
> > > I think - my understanding is that the kernel will basically kill
> > > every process on the system except for init before it starts failing
> > > GFP_KERNEL allocations that fit within a single slab, unless the
> > > allocation uses GFP_ACCOUNT or stuff like that, which the maple tree
> > > doesn't):
> [...]
> > > then you'll get this fun log output, showing that the same VMA
> > > (ffff88810c0b5e00) was visited by two iterations of the VMA iteration
> > > loop, and on the second iteration, prev=3D=3Dvma:
> > >
> > > [  326.765586] userfaultfd_register: begin vma iteration
> > > [  326.766985] userfaultfd_register: prev=3Dffff88810c0b5ef0,
> > > vma=3Dffff88810c0b5e00 (0000000000101000-0000000000102000)
> > > [  326.768786] userfaultfd_register: vma_merge returned 0000000000000=
000
> > > [  326.769898] userfaultfd_register: prev=3Dffff88810c0b5e00,
> > > vma=3Dffff88810c0b5e00 (0000000000101000-0000000000102000)
> > >
> > > I don't know if this can lead to anything bad but it seems pretty
> > > clearly unintended?
> >
> > Yes, unintended.
> >
> > So we are running out of memory, but since vma_merge() doesn't
> > differentiate between failure and 'nothing to merge', we end up in a
> > situation that we will revisit the same VMA.
> >
> > I've been thinking about a way to work this into the interface and I
> > don't see a clean way because we (could) do different things before the
> > call depending on the situation.
> >
> > I think we need to undo any vma iterator changes in the failure
> > scenarios if there is a chance of the iterator continuing to be used,
> > which is probably not limited to just this case.
>=20
> I don't fully understand the maple tree interface - in the specific
> case of vma_merge(), could you move the vma_prev() call down below the
> point of no return, after vma_iter_prealloc()? Or does
> vma_iter_prealloc() require that the iterator is already in the insert
> position?

Yes, but maybe it shouldn't.  I detect a write going beyond the end of a
node and take corrective action, but not to the front of a node.

If I change the internal code to figure out the preallocations without
being pointed at the insert location, I still cannot take corrective
action on failure since I don't know where I should have been within the
tree structure, that is, I have lost the original range.

I'm still looking at this, but I'm wondering if I should change my
interface for preallocations so I can handle this internally.  That
would be a bigger change.

>=20
> > I will audit these areas and CC you on the result.
>=20
> Thanks!
