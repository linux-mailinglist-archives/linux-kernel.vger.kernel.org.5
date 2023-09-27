Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E42D7B0A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjI0Qd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjI0Qd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:33:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9F5DD;
        Wed, 27 Sep 2023 09:33:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TodTi8vC8FmITG7x8GcfpPO9nXh6wc8EEaCDRclbymxtq12ngfjHsIXtAMgLhOS/SOqrLZhcsCpVAcP/N8kuB2G0uNh0MSM3zEokzMTi3HZsEl3mWV1UtzJ3EaL3lStXkJagchmR97yb/6SuV1Yl8HUuU/X0Io6qwicKnVxPvZp9txHS/kawlHFTUnPNVzwoeiha9lDmamZWlt/dizIdShmYREUraocRi7uJXt+yWWmPDnQBKFUgujsjr9GEqrlheIC7FT6hXUEI5l7tO+WQ2wkeKxIrORy3KOvHxSrc/UGrDssKPobX6oF3U9Og77sidQ/to2Sv76ntIv3ELl42CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZHHQ7z+gYAqzUaomMkt2aUcFnqsR1wYgwonnDaioow=;
 b=jn0Oa40vDUH1BmfdOMafSax5cinFd0xoDFgdYmXeBaLWjAJT4ca9Y8LqCVLPuJ1ImDRbuN1zbHH+XYd0N+LtWEFBH56Esd/whhfbd+7NdupcDG/DSnXxwRqEdiO8kJfzT/MPp8czir+4kJ1WpYfuRVOwv7cnQyKNhk0bZh4xWnTJeK3BwISepA2s/gYIMurttq/pF/1JYK2b2sB9GZF4QiheEwgbxXJ6L5GYPHeaktWB9ri3kDqaLYowNTGD5cPMWiqG9HgEebX5Z/W2O2cWrLEJ9LldCRsaMC0i8MAIdG49IsM7p5JEA8yp3556aHkdLJ2TcP7snDAPm57yhgWkRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZHHQ7z+gYAqzUaomMkt2aUcFnqsR1wYgwonnDaioow=;
 b=S8Er7HnjR21uemIgvxdgJ0mwB9EwiflQ+/XYiOlRNR6fKHoEcTbT006n4rRNuP8AUKEUu3QwTq1DC2BRPuBXpTptAiaBvThDuyfI/A8cXQLjNPg4MjguhpYe3fFA4En1jZwuuQ1x6ONWv2Q3lu+8xS0oeFwSLD50P/qLuu490Ds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by CO1PR11MB5041.namprd11.prod.outlook.com (2603:10b6:303:90::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 16:33:21 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 16:33:21 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v2 1/9] wifi: wfx: fix power_save setting when AP is stopped
Date:   Wed, 27 Sep 2023 18:32:49 +0200
Message-Id: <20230927163257.568496-2-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927163257.568496-1-jerome.pouiller@silabs.com>
References: <20230927163257.568496-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: DS7PR06CA0052.namprd06.prod.outlook.com
 (2603:10b6:8:54::30) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|CO1PR11MB5041:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f486f14-5dc9-407b-912e-08dbbf777484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KFNxBwVHILwZVF66zAQbUUyE5OgjZCU1iRHw6u+p2renmUvKY3+mNHR9rIzy4YvJnPLFmkv+auYkJbjqi4xVHbFAfGZEoSQ6zXtk6qtagQCUSfremixz4g59b50WuDnZEQ0IyV9SVIDZyXB3mZH5GWySpw9nJlcMhyXs7Z/aw+8bHce3KijUUpeM34SKZIovhz5wkVv4rfmYe8EG5aJbISvoiCvnfxiIAf63UFLMcL7ylV6eC+I8V1lzb+qg6vAfBEeGWXA9EPAlVncl8NAdIzNbrISPxFfiY803/2C8vBKL9u7dTPJ0XyrDX+DYPEktLU2lCkte2K+14basANCX7aRbC365zq71/qQfmVKwe6XJzq4ql4H84coyoKdmY2rf2g6gBrsi0798PJRsULrG8qfXKxCvRFQTI1kmcXqItke2nGRC2fcbr3OHt9HFgLaE4RLYp0ZHq2iIfyWQif7FZ2v6mZAHWKQDwBB4eveomY0+cafYuZX4qKNqhoV1+yFM18ZbM9Zfe6yzRy8JryVvK934VxEj1dJPgYlesLMvZIsPLGVluSu8cjzcbvTfNSWS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39850400004)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(6506007)(107886003)(66574015)(66556008)(66476007)(6666004)(1076003)(86362001)(6486002)(52116002)(6512007)(478600001)(38100700002)(2906002)(83380400001)(5660300002)(316002)(6916009)(36756003)(8936002)(8676002)(2616005)(66946007)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3pSR0NudHhNeTYzaVRiaERuMnpXazJNc1pNeEMzcDQ0a0x1WmJHaGRzUER1?=
 =?utf-8?B?KzJhbXh1VGYzNkw2UWxyWmlhaExlbzZoaDhXZmdCTEZ0dit1UmxBM2tqb0t6?=
 =?utf-8?B?VExjUkNEelBBRWZlWmpqeVVnLzRyQVVxL0U2WlJhdXErV3BleWx3ZkRHdzMx?=
 =?utf-8?B?ODN0TC9yaDFEYm5TdnlDZDRLR3JxR1hpK0hsTVowYkFXeVAvazZGZkpqdk5Y?=
 =?utf-8?B?VVA5aFFwSWNLbkF2TmlxUnJVd21CL2FZeU5Qa2RURm1heVNjTzA4MlN2aUI4?=
 =?utf-8?B?TWNMNnAzSEc5bGE4OHhSbktvNnhpc0h5cEVKeEdzM0U4aGdCdDU4MmMvUWpP?=
 =?utf-8?B?a1NoL0laV1VkUHlhWVlERUNyUG1ycG5qblpuNXd3NmdZakhxWU02Nkwwa1NN?=
 =?utf-8?B?WnZBaEF4Q0hsc09LSGNwT0dtNitmRURERkVDMmFiRlByNjNGaUZSMlpvdmpR?=
 =?utf-8?B?SFFVN3BPYXVzMC9aaktyRGFXWVBjZEx5YzhZbG5Xc3ZvN0NZa3ZmTkV3dEFW?=
 =?utf-8?B?azB1b2pIMUJUZ2tUTXBpeEluTU5LS25JeWxqL29oZmVCYkFnOTlLKzhpQ3o4?=
 =?utf-8?B?U21EU3dLSEtOU0FRL3JyWW9oRHpMbEwyL1dJOThPZXFlSHA3QzBCYS9TeHdG?=
 =?utf-8?B?NWZIT1FzNUk2YUFneXRaUHBsMWpZMURrYTgvQXRLSnpwb1hFb3dybk8vNExx?=
 =?utf-8?B?REdZMDhuVElRek5Mc2w1bzlHdkYrWWk2MDIzRDBiQngvU3o1OTh6UWp5QVF3?=
 =?utf-8?B?SFZwbWlxeGk3ZnczdkdlZERXRS9UL3lQZUNTUVpGbHFpVkc4MS9LTTVMRVJv?=
 =?utf-8?B?dzlHVTkra2xhb1hLamF5aURya2gydzgwVE00Rkt1ZHQ4bVpEMDZ0NmNYS0h2?=
 =?utf-8?B?dVRFRzFiSy80aEVPaGd4YTcxRHI5cy9TWFNtMW5xZmZNcWtKYy9LVWZKN2Zu?=
 =?utf-8?B?ckRCVW56TEs3VDJDUmcvdXFUa3FtZHFiejZKbFhuMXN2bmxxWFlIdkk1TFls?=
 =?utf-8?B?VVV0ZHFCL3ZYL3E5RnZxMDgwY2xtbi9FdEkvQlcyWWhPdnNiK2tOY1NNUW9D?=
 =?utf-8?B?eHVvWmpNaTFkM3RJREFzaGlpQ2FCMkFCV3I3V1BHellzclJwZC9TVHBJOXNj?=
 =?utf-8?B?M0xjUHVjMW5YMTdXQkFYRSs3Z1N4bjhHMEZjaDRhczlWbEo5WnYzMGdhK3RO?=
 =?utf-8?B?d0FhdWdFVG9mOUp4Vlgvek9vWk9JMUJaaU1uWEI4eVNuZVFWNDVDT1N5YURD?=
 =?utf-8?B?UWtjM25FdGVpSHlIMmUreUtIT29vSGx4ZlcvdlRrTldySVl1Tk5TNnkyalN5?=
 =?utf-8?B?SDNkUncwS0tNQTM3dG9tV0hhbVpXNGpoUS9xenFrbml0cXRQNnBJWERoY29k?=
 =?utf-8?B?dUtmOFgwQzJWbDNLa203OHEvNEhGbzU0T055UW5vTit1TzFHMEZENU45Mktj?=
 =?utf-8?B?aUROYmxjOUl0TThwT3RqRnYycDBGeTZMOVdVclhodTNsOUdpNG9zUnRRc1ht?=
 =?utf-8?B?OUtZdXNnS3pnVSt5ZzM4WGZYSldUY2NQOTdhOStkYXljaFpUL1JVSER3REJC?=
 =?utf-8?B?MFh3OUl4aElyUGVqUG9mVDFIWlNNSUZ4MWpHa0JQYUpVbGlMUVhUVHhCalIz?=
 =?utf-8?B?Q0N6MkVWTnA2YUdyTERGbVN3cWNLOUpVVkNHV21mQUtSaXoxZldLSDNUM3Ew?=
 =?utf-8?B?S2NDYzkzUVo4ckVtOURKY0dOZEJzV2VEZTdPNFJDZUhTL3Rwbm5wRlhpbmZ0?=
 =?utf-8?B?bGdwMldmbkoxQVplcFBLZ0pHWUlMRGJDUmZvblowM1ZTTkIzb1Rqb3M5K3Fh?=
 =?utf-8?B?d0ROQXpQRUpsanNmcnpEYUtucVArS0VieEtCR0hxYmJvL0pZaThtdU5jNXhy?=
 =?utf-8?B?T1pDSFp5ZTZqU0kzSXZSTk9vM3BjYVFheVFlU25FaHpMMU1iRDU1R2Y4b2Fo?=
 =?utf-8?B?VmQ3OEF3bElHY0JpcFB4MzJmYnNOaWw1NkZ1ZDNTRy9RYXphNXo5QVV2SFA1?=
 =?utf-8?B?WUdPZnRRa1pEaHdML3FaZnI3MENTbjFGa21JTUhvKzZ3WlFWRis1NitITDI1?=
 =?utf-8?B?Z21mN0ZaYSs3THE1STZwcE5vcTk0b2E0NmtxOXVSLytabTJtcm8wTW9ZcXg3?=
 =?utf-8?B?aitjUkw3cjVYYThNTGc2UlRIWE9IY1phM3NnMWpLU2hhUHpCaStkZVlRN3RV?=
 =?utf-8?Q?ak/BLrhVT4ta3JMCUXR3ruZQZHQGIuLtYr+MAsydM+tw?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f486f14-5dc9-407b-912e-08dbbf777484
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 16:33:18.2400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RH5MRTGMwR+/rFeFlvTtEexIqpxrAjG1lxg/8PyKk0Qodfg0G8Be8CRgOo/T1KYKEdmNKADaqdHvNSWsy+ohWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5041
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIFdGMjAwIGFsbG93IHRvIHN0YXJ0IHR3byBuZXR3b3JrIGludGVyZmFjZXMgKG9uZSBBUCwg
b25lIHN0YXRpb24pIG9uCnR3byBkaWZmZXJlbnQgY2hhbm5lbHMuIFNpbmNlIG1hZ2ljIGRvZXMg
bm90IGV4aXN0LCBpdCBvbmx5IHdvcmtzIGlmIHRoZQpzdGF0aW9uIGludGVyZmFjZSBlbmFibGVz
IHBvd2VyIHNhdmUuCgpUaHVzLCB0aGUgZHJpdmVyIGRldGVjdHMgdGhpcyBjYXNlIGFuZCBlbmZv
cmNlIHBvd2VyIHNhdmUgYXMgbmVjZXNzYXJ5LgoKVGhpcyBwYXRjaCBmaXhlcyB0aGUgY2FzZSB3
aGVyZSB0aGUgQVAgaW50ZXJmYWNlIGlzIHN0b3BwZWQgYW5kIGl0IGlzIG5vCm1vcmUgbmVjZXNz
YXJ5IHRvIGVuZm9yY2UgcG93ZXIgc2F2aW5nIG9uIHRoZSBzdGF0aW9uIGludGVyZmFjZS4KClNp
Z25lZC1vZmYtYnk6IErDqXLDtG1lIFBvdWlsbGVyIDxqZXJvbWUucG91aWxsZXJAc2lsYWJzLmNv
bT4KLS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jIHwgNSArKysrKwog
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMv
d2Z4L3N0YS5jCmluZGV4IDYyNmRmYjRiN2E1NWQuLjljMGExMWMyNzdlOTcgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMKKysrIGIvZHJpdmVycy9uZXQv
d2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYwpAQCAtNDAyLDcgKzQwMiwxMiBAQCB2b2lkIHdmeF9z
dG9wX2FwKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlm
LAogCQkgc3RydWN0IGllZWU4MDIxMV9ic3NfY29uZiAqbGlua19jb25mKQogewogCXN0cnVjdCB3
ZnhfdmlmICp3dmlmID0gKHN0cnVjdCB3ZnhfdmlmICopdmlmLT5kcnZfcHJpdjsKKwlzdHJ1Y3Qg
d2Z4X2RldiAqd2RldiA9IHd2aWYtPndkZXY7CiAKKwl3dmlmID0gIE5VTEw7CisJd2hpbGUgKCh3
dmlmID0gd3ZpZl9pdGVyYXRlKHdkZXYsIHd2aWYpKSAhPSBOVUxMKQorCQl3ZnhfdXBkYXRlX3Bt
KHd2aWYpOworCXd2aWYgPSAoc3RydWN0IHdmeF92aWYgKil2aWYtPmRydl9wcml2OwogCXdmeF9y
ZXNldCh3dmlmKTsKIH0KIAotLSAKMi4zOS4yCgo=
