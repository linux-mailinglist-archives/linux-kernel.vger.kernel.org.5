Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97447B8688
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243591AbjJDR3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjJDR3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:29:04 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E515ADD;
        Wed,  4 Oct 2023 10:29:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eC8Mj/yusLcHCQSL6L4QF8AEV+HIVbuMnKOTK8G7RFKoqlJFBOWW5SOHsaYGGvm1PCSAzxs/MtlhLPl8lc5Yc2ZGv3ZLyFjYH6WBRa1wpfoJf0DKaE6vUD4o5KBKKTE+0Y5TQyqM4eCXgckyG5GNho6Dlt5b8quPa2n8IYV2I4WlFoE3Kp49CpxbhQBnjYCQVcNokYdlc7fzxCRbfAlpZuulqvORTalVL9huw1uQ6hK6Q+TmOTyYN/kkZEHcCzZWxNhsl0XbazatlJQLieOUedjHDv0TuSG8fzgFYDAvEGLLc0yc8shgNjMBJDsTg4VZ85RcN/rXa5lhfkT7sYbdkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZHHQ7z+gYAqzUaomMkt2aUcFnqsR1wYgwonnDaioow=;
 b=P6PieRKs61IcaoFbBjyhO3VkLAikYeJHplHJXp69ieFsmzJldk27g5w5QUxdOhsmlayJPP4/jKrG7JpPaJQPJ9S59gBR9YR/JLsgHNOs3xjPCotKmNv+gc0cpRn4SCaqg6MddS4PKDrLe/dCwxfA+jgZ91f5qwWFJreMpcSEcTCeXw+edUF2MCqftUCXKweWHr8OPbYjrey1yBM4+cScMfFUSOS0wL7zx2S4u95J1HucBFs8Sje5GReQyfoFItvl0ThnSJBYrsEzchGsEHKFMtpHwmTSK5Du25LK1O1EuB3AfuDrI+H0Y9RB0qSf1SDHa9RdiZ4FEtBkVC5EkWE36Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZHHQ7z+gYAqzUaomMkt2aUcFnqsR1wYgwonnDaioow=;
 b=NDxc9jFnFw6CtuMBpluxOmJNX8m9GByfEkqvUY9qf11WoHdjCu1hT9H45d9a1mkEb2MDMi3TDmcssSAa+Vi5ILFyRF68MNRNsQ8YGu5NRtebERXoH64W02K1AfXHesSUt7/GQoT6iPMhJlajDDdVMQRrLuBdClDzCiABxKsdPHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by PH7PR11MB5982.namprd11.prod.outlook.com (2603:10b6:510:1e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Wed, 4 Oct
 2023 17:28:56 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3%4]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 17:28:56 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v3 1/8] wifi: wfx: fix power_save setting when AP is stopped
Date:   Wed,  4 Oct 2023 19:28:36 +0200
Message-Id: <20231004172843.195332-2-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004172843.195332-1-jerome.pouiller@silabs.com>
References: <20231004172843.195332-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: DS7PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:8:2b::25) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|PH7PR11MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: a36ddfe4-d6a1-4e5a-d0ae-08dbc4ff6320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZMGXU/vrOHpFcWkJ7CVAgTVxDPIw3837BRbWbkbQ1N/rvPSYdD0Z8bwFfjSxYDgJAvBX6pn2deN92De3Y7SJSYkGeCNWYSNLZ9SXwzXZK0DGl8IZ8IQKOAgXpJaZO8jGMHNivxpmm4LmKzZM1957qCxRJ/thZYfDuCpfxMlJjZ4MjiOWL81mUgJ7Ya3qI3cR0soLDYhjPcpoccv3Ijlm/AUCqFY6ZtbOTqTXVcGxngAqu1yBQPiVLI4QleCZQPk+7eza4GQPTxADniUFuibUVngKg33u10K8ZqFe2MP9HIqmFz49ncgx6OptF4wbleb6S3kvb5zbZ9ZHnS9BzdF14zvzQ4H8cpb4FocOZXL6eLoP1fjp82Le414BzFnvucNMWu8D1XZeeKkHJd9d19P09XnQsgJ/4pkORI6r4+CEo0WbDg8gouJWpZeqTvN+9V7gGRzgV+PzscFL7T8pGNK6nYZgcwbuBqRefHdiFSm1PAHoyFHPITXt8rRieevmkBUaR477GdzGtaSBsQF2Bw9ifVBeQ3mBuEM5JMdY6E3vZTNHmViwk5tQP7rPsrjG3MN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39850400004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6486002)(36756003)(6512007)(38100700002)(6666004)(52116002)(86362001)(478600001)(6506007)(66556008)(66946007)(66476007)(316002)(6916009)(41300700001)(2616005)(107886003)(1076003)(8936002)(4326008)(8676002)(66574015)(5660300002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUtLeHhtSWpWS1pna2haOHdrQUlvSEQ5V08xNEk4Mmg2cDFwWXFQWTJRUFp6?=
 =?utf-8?B?aXFRYzdlWjFGV1pra2JaanFEWGdWcFJCR2l6Y1JLQVRnVThMWDlBMVpsd2pl?=
 =?utf-8?B?empPU3RpSENvdnFlWk1LbWhBZEFFV0tSTVJzYzVXZWxCVnkwSkEwV0VVMklw?=
 =?utf-8?B?YjhTWUZGU25VbUg4dHpYYVp5dU9DMHJDT0pOVndLNWd5aDFYbktmWWk1Z0ph?=
 =?utf-8?B?MzBiR1c3WTBka1dMSnhiQ3hFR2pqdSs5UzBLcWNaZ040SkhObjVmMTM1alc2?=
 =?utf-8?B?ajU0WVdHbkNkNWRuZ0NhOWI1TEtBak9FcXQ5TFVQUUliUGRKWmVIOWxpYnMz?=
 =?utf-8?B?QXNoeWk2UkNTWXFRUW9NVEkvdHpSZmtHam9HdmNnTGFwRGhSeVFUQ0JBOHpL?=
 =?utf-8?B?cEcyVU5aUWM3NUxqd081RmlGZlFVOVNWbCtDRURvNnppMTlpbVkvbW5XUXBp?=
 =?utf-8?B?WTY5ZUNzYlRoS3hrOVRsT1hGcXBhdGVqZDM1VlJJRFBWRW8rVmlBRlZlR0FZ?=
 =?utf-8?B?amNEVGxQYnBLdWtpOG16cEZpdEFZMVNReVhrdis4RmpBN0QvZEFGdVZDNkZW?=
 =?utf-8?B?Ny9ibjRtdWUyajBMMTJ2QitXTEtRY096aFhIWmgzdzkvcENpSHEvMW5JaC9s?=
 =?utf-8?B?TTc2Q3cvVVd5dEg5a0FITVJPTVdyMlJVRmcrUzFOQXF3MXBnR1hUd2QyeFFK?=
 =?utf-8?B?ZzU2dmwrQ3dqaWVBNnFFMVlReUtxUm1iZmZ1Z2N0Yjl6bk5Pd1VqeW04Z25G?=
 =?utf-8?B?OVpmbSttaENlS09LVG14NEVVS1E4QTBnMXdheHdqeFQyS3dzYUlJd29oU0da?=
 =?utf-8?B?SGhrTWJ0ZlpyTDJmT2FXaGQ1U056RmkvcGNPaElrMytzRTNZR3ZOL3dlQVNl?=
 =?utf-8?B?NXV1U0JXSCtNSzFPMjYzN1prYTkzcHYxOXl2V29zWDhqREx5QVlqbWtxTTcw?=
 =?utf-8?B?LzZrMjlrR280ZjErK0ZZWHRwZE9pdUlna1FiVFhyeklqUjRvQ0JNcVEwSGxU?=
 =?utf-8?B?OXJqVHZqUzJjMDRheTdnSm1lS1lHWWpiOGpTdEVMVjRLcGE0OXlFblpiNGNR?=
 =?utf-8?B?bEpPTmphL08rRncvTmJMUC93NVcyZy9rUTVMR1hTWjlBVVVoZTNXWW1NZEMw?=
 =?utf-8?B?ZjVQZ2ZzeHkwSjFTdU9sbG84SGhOU0NFMGIwdzJBWEhRSzIzcWprWWZ6VElq?=
 =?utf-8?B?N01KQTVDSy9ML3NKS2FhSEl2OE5aYTF4c2ZMRnA2WnhsWG5lcldaMFVDOEJh?=
 =?utf-8?B?Wjh1MUhrZ0lGN1UrMXpWWXhEZkVPdFQxamxrNlRLdWVxck5QdGM5azViZUxp?=
 =?utf-8?B?YUdSVnM5RVMxc1czM1FUQUZUbFlIQkFlMVMxZHlBV3lTMTBrNDR2L0xXTXds?=
 =?utf-8?B?RjVVRzZ5M2pKbXd1a2tWK25nQmRaaDhzWEp2NHB4Mml0WUF4dWhGMnNLZUgw?=
 =?utf-8?B?T21Vdjk1S080UDdMcW4zVnNBWTIvcm5JV0FmTDgyWEdjaDJUNFp4RlpUQTk5?=
 =?utf-8?B?VE1QV2Q5VlExZEM5NFRTbU5ldXlsaUhJZjVDN1U4b2IvQU04djZqN0JueTBk?=
 =?utf-8?B?Vk1UWkFrZlNRSk9RTjBaRktLeEhlUG5uZ1U5V3RYMGUwSUlrZkZQb1BqVE9E?=
 =?utf-8?B?YzlneUJHZ3o3a2pGZkNNVWlLczBGMlNyVEVEL3pCanNnMk9YODJjVklER0hX?=
 =?utf-8?B?a0Z6clBGeFFqNlp3V0dYanJBb0k2UWRESVFBYzl0RExXMU9pWTAxYzF5dERO?=
 =?utf-8?B?SWErT0ZFa1Z2eFZsbFp0cUJadHBFcVhQTG9RRlVVb2tKaCtGVDJ0bE5YTFM0?=
 =?utf-8?B?WU5Gd0wvM3ZIbmlxd3pHVm1QczZFWU9zbytRbEl2SmxITElpRWRoN2kxZVF0?=
 =?utf-8?B?T2N2NFowYTEzbUZibUc2MjhCTTZXd2hORVBEMmFham4vd1JSeDljZDUrTDBQ?=
 =?utf-8?B?SXNiek1zSkVOUlEyVWo2aGZ3NUkwY1hHaWM1Qi81S1BkeTFrZnp6Tjh6TEp0?=
 =?utf-8?B?MVB4d1BaS0h6MjhEZW5tL2xoRzk3RWVsUmZWWm9udGVHbXlKVDJ2RnA0cnBh?=
 =?utf-8?B?SCtQYkRtMzNtVk5rRmdtSXAzZ0tsMnpGbHhKVEtKTFVBU1RXZDJUQkt4dGxw?=
 =?utf-8?B?Tk12aUtDcy9BNmtBcmlpcmp4M0lndXE3WFFRYjl4UVJPQ2d1VUQxMjFBSDNZ?=
 =?utf-8?Q?SI2uzwCiUP8AA0jaBs20NaCs0WjZLOLMNnZcWT0qfbKv?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36ddfe4-d6a1-4e5a-d0ae-08dbc4ff6320
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 17:28:56.4059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQ3vP+cMnFKxBa3U9T9m5MtkAHgk2RNYMh2qSRQdh9FPlMdVnvbsrmkTEHaVVx2exAHEZP4/82+nd0Ntde9q9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5982
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
