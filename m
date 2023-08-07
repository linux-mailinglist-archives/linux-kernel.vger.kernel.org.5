Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2131077289A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjHGPGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjHGPGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:06:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E692910FC;
        Mon,  7 Aug 2023 08:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxxqZjtiBPu5/sBdS7p+fEP6KiOZF0ietmGWKfe+LICEPGW17kXlQMjLK/8zc/sb6zMzURJJTSVlebs0B5kLtp8XjTDaczSbOksF5WEbU32Tca46AavF7Rhi7+zrHj8J0WWr21rRPaLzmUzzDGukaPyuPmMJsycJqYaOEKaRYpwSGI/x4mlN5gVQ4UbuwvsF39ohLUYs+z0Mi+GcmNQStl6WW2Nm7pV1tU92AWtJAQfP9YJLADx9SkChpCCMb0cFUNe1LraK/OgZYUVp+hHpeSoR5AcDefrKUytsga/P0OOq1otfzu6/Foj5YMVsV6rjbuvXexQeh2ELrGOf5B0RoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R02y5uDMP4DY2FFVtqTykV0XgTnZxfANfWvLa88n9rs=;
 b=lJMX1nC8l9+YJnuyzStcDGWXaZuLCP/1Kzji1A7IwfPEPX/66hav7DwCHKfLd5clbNOCD6J+VFGnIsGf5T9fY6AthAEqZSWKY9lqcGbOgdtz8Bl61fNMfFOH5MxLAppL0/6jeKAxvpoWS8PzZUfZ6UjSFABuniwgkiB15D3Q7fFlRf8/8F+MQ/HJWh19596rUsWNLMmm2s41Rc/zkJPzz2XhPBAGn6F5RmapBe2wOHnVvSRncWWpxIp3eXnCy7EZZVBrUbv3u6qS08DoruJppyy3vrmi31lMCBHb5HSlE9vy6uWkXCKAZXwISYLZRAK21kmKdVy8WWblou4Qp8YVRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R02y5uDMP4DY2FFVtqTykV0XgTnZxfANfWvLa88n9rs=;
 b=jHCddxcK+zjwrUMJYsivZR8mFEHUPP64SKM4ZK2rITsYoNrf1wzCnhAbpvrJSPM6ADaG5X47IioeS2WmGA7LXLCq/Y0GF2nhsnIaznufVi2d74XSP8j2fJeeZrWia7pTSR9sFOQ/3QzF1q/W5wlXtm/tEPF+5boxnKjlEiB6Q3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 15:06:04 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::14b1:be6e:19a3:2eca]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::14b1:be6e:19a3:2eca%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 15:06:04 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH 1/9] wifi: wfx: fix power_save setting when AP is stopped
Date:   Mon,  7 Aug 2023 17:05:34 +0200
Message-Id: <20230807150542.247801-2-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807150542.247801-1-jerome.pouiller@silabs.com>
References: <20230807150542.247801-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PR0P264CA0252.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::24)
 To IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|SN7PR11MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: dafce701-c166-440f-7069-08db9757d1f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hmBf4j51R+Tsv2XqmA+UZXsUgMrTSEY2L3+PCnSG/sfhsZsFjHZuP9DwJ2rmYzELiwXYtAmdGTk9zFXi6hscPffi2PYqGlWcrCydosDkYf7mV40b6bB7Pwc5Byfd6dPwOhrtzGn1ILvBovJqQs+zET1DFz691qx5/ZkJ/QkKfNOryUWeT4/yf04sHxD5zS9tnrkfLPMNQKM0ca271OBBzWjb2Q+nP7hdK5LL44dzNCv6U5ohQCJIfWvPN2pzbBkE9RO2bJy955rUkhnRJpnDmXY8VOlS0UrDDs9pWjf+3il7ZfWJJBaXytycm6h72iqgki008WU6NBIIgFSt9E/ohtP+La/vVASBgRZJOLBPNWvonoTzoGIizGx59B/VgIptJVKbrmktGT/vJ+pPqMdsv4tveL0IjZhsePTq7lzOUAyA9nu60vhCDnxmxrI0e0m+8I26yYXd+QC6jGftAGo0+WZBLbat7+kdO0cXYwrpSVU2/z/FhpzUWNNUUJmeUcB4fkff5v59W1q9VsDGJDFln2+glWd7JFtlh0q3TNUCggNweKUwQuqEMquwmuvzP4YrY3DGAg0ayK+wT6LFYbzbWTsJlFwrcijRwGk5nsyypkNOOzcNC+WPMEw7btTOqjb4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39850400004)(376002)(346002)(396003)(366004)(451199021)(1800799003)(186006)(2906002)(4326008)(6916009)(66556008)(66476007)(66946007)(6486002)(52116002)(6666004)(66574015)(83380400001)(5660300002)(41300700001)(8936002)(316002)(8676002)(38350700002)(38100700002)(2616005)(478600001)(36756003)(107886003)(26005)(6506007)(1076003)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1hoN3NBbUJRK3lJWXFWd1l4dWpiaXBna3dEbW5Ndm9wS2NQcThiSEMrZ0Zn?=
 =?utf-8?B?VlkyUXB0YXVXeDdZOUNJa01XaWIvb0lua1RmTGpGZW1JN0xlN1dGQXZVVWIv?=
 =?utf-8?B?aTIvV2RmNWowWFRxZWdMcDlvSmV4RFhMSFB3Vm5MTlhjTVh5N05heGZRbmV2?=
 =?utf-8?B?Ukd4STJKMHRGWEFrdFArc2svTElDY0JodTZoU0swS2tVNzdKdWxpWGdtaktL?=
 =?utf-8?B?L3RLVUpMRzlhNzNVRUFvMU8yajNjdkVpMEhQdStQUmc5ampLbWU2MzExS2Jh?=
 =?utf-8?B?NkhFSmpNN1FWM2lzK0tXZWZ3Rzl6a0VLdG4rWktnUUxWRkpUc1NmbnRva2VH?=
 =?utf-8?B?SGVWMTFkQUlQVjI0OHc5Y3M2dW10VzFXdjVYL1E3ZVdzb0JQSmM4Q3cvVklW?=
 =?utf-8?B?RDRzb295Y0FvZFhMM3dhK2pXK2k0UHlxUXRvd3Z5Y1Mrb1p5TExCTmVhUFRi?=
 =?utf-8?B?MEJueWdXazJxOUkxeGh3R2tPbHMvSjY5cFZRVGFZUExYTVBIOTlpYzAxWExt?=
 =?utf-8?B?ZFdPRjNmMVpMNU8yMHBjUDJONHlTMkZQWVJFVUVCdTFLeXhpbGdCZFZ2WU9z?=
 =?utf-8?B?VWNkYWNLNEVhY3FmOTAySkNKU2F2V2tpd09lanJKc2pqUWJlTTMza2ZtbjVK?=
 =?utf-8?B?NGJ3OFMrRUZQSGhkZ1NmaGh5Mk1idWd6c3lmNFBVT3F3OHozVmlsQWZCSHFS?=
 =?utf-8?B?d1B6dkFDd3dSK0FleERqL3FXTVBhdm9OblV3U3FEcUtVNVkzVnNPOURKRmMw?=
 =?utf-8?B?YkZNTll2RVFEQnZuUWJlM0tkazJKNWZXeHIydWovUEVjbDV6V3lyM2x4Sjd5?=
 =?utf-8?B?Q2hyTmlnNEszeUZKaFRYb0U2Y3FMMVdVS0dzdE1hN2luaGJRZmcwUFN4aGxx?=
 =?utf-8?B?Wi9WZExDdGp1bHZWeE5ZZlhia0pnbDFMbXlNdUNSYy81WVBJWnQzY3lra21J?=
 =?utf-8?B?aUxwR3A3SmFUTVkyb1FEaVY0QUhaWUN3RU5qTGQ0WFZjRXl5NDRtWnREaHhZ?=
 =?utf-8?B?cXQ2VXlWQmkrS0tsS1h5NWZpS0RVbEh5WGo5R3Y3bE1kcEVKd1IxVDhnUXNU?=
 =?utf-8?B?amx2cGlLVWxDRERKbzEzdjhzdUJQK01aTjh2UHV1NmdNWTdZanNWYnZKN2No?=
 =?utf-8?B?UTAyZURQU25Jd0t6RHpLd2pNM0ZHVDJHNzJueXEvdjVlMDlaQVFOMEt2cmFm?=
 =?utf-8?B?YUN3K1pEOCtadGwrWUN2djZBSEFyRzRldzIzcCtaM3RSR0pUNXZXNy9vQmNC?=
 =?utf-8?B?T0FPaWJQdlRiQndudDFwSmhjWDZSTVVmb3h5MjlYSEhNSE5WYW5vYm5iVVpa?=
 =?utf-8?B?T0JpczRiNVZ3amZYc1pVazVVQ2pLV3RRenhBVXpMa3lqeGlXUFlZaE9VUkgy?=
 =?utf-8?B?YUc3Q3hVUjhibndGV2hxNkZtb3JITHBONmY1SG1IalFYalpOQjVsUDRSSTZw?=
 =?utf-8?B?Vlo1T1ErZXZQMmJBeDJ4RCsrUTRyemlLS0NLemlYK3pjdUhTNUI1bWc0UkpN?=
 =?utf-8?B?NnZqbkJaenZBcTJxVTVUY09rVUdUVFVWZlFDWmJtQ0JNZ2pUSmk2MDN0MjZo?=
 =?utf-8?B?di9KQmE1NE9LQkRSMXdIWGZMRlpYQjFyUWJTd0FRWWZNSm43OHlHOWo3Y1My?=
 =?utf-8?B?QWgxZzhCdzlLSWJObElMZll2UVd1ajZlWmFKRUUyOTBub2hlUk52TGR6aEJI?=
 =?utf-8?B?c1VEbFZkck9OOG9ldDhOcE1oU0JpY0k3VytQcElOam9hcVl2OVlvbUd4V2pN?=
 =?utf-8?B?bm5WaHI1dUNEUlhMMGNkM00zRnJadzlMM2I2L0N5RVMzZHlFcEhMa2NaMHJV?=
 =?utf-8?B?bW0rNytYNWFFL200UUY3MmVVZXNPN2E1VnA0b0JUSXdrbDVNdFFCb1BiQVZT?=
 =?utf-8?B?VzF6VlliRDgxTkM4aGpwK2NnM2IzMlFMSzhwd0NUblMrSVZzY09CN1VyQ0Yy?=
 =?utf-8?B?K3IvQnlrTWxxaGtHcDVrQ2ZwbUR2OWFYT2dSTkF0cmZ1ckVlQlExT1hFVWIz?=
 =?utf-8?B?eFN1MWVKNE9TS2NaeTFvUkFUZ3pPUXFrNkgxRitRY1JrY1lteFMzQ2JwRk1o?=
 =?utf-8?B?RGp2TERaYVpvSWU0NkhXVk1PU0k2VnRKd3V6cnh1TEQ4bUtmM3V0cVJtNFIx?=
 =?utf-8?Q?iUoGyv/RioCU5Hu9jHNimDfOE?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dafce701-c166-440f-7069-08db9757d1f3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 15:06:04.4766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQewpjr55PXpADGYK0Lnhdv80ev2eOzcaafc1Ul1+ihm1EROImGtwlyc6tpXa4XNFcjhxEVOvsQaylxKF4f5cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7590
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIFdGMjAwIGFsbG93cyB0byBzdGFydCB0d28gbmV0d29yayBpbnRlcmZhY2VzIChvbmUgQVAs
IG9uZSBzdGF0aW9uKSBvbgp0d28gZGlmZmVyZW50IGNoYW5uZWxzLiBTaW5jZSBtYWdpYyBkb2Vz
IG5vdCBleGlzdCwgaXQgb25seSB3b3JrcyBpZiB0aGUKc3RhdGlvbiBpbnRlcmZhY2UgZW5hYmxl
cyBwb3dlciBzYXZlLgoKVGh1cywgdGhlIGRyaXZlciBkZXRlY3RzIHRoaXMgY2FzZSBhbmQgZW5m
b3JjZSBwb3dlciBzYXZlIGFzIG5lY2Vzc2FyeS4KClRoaXMgcGF0Y2ggZml4ZXMgdGhlIGNhc2Ug
d2hlcmUgdGhlIEFQIGludGVyZmFjZSBpcyBzdG9wcGVkIGFuZCBpdCBpcyBubwptb3JlIG5lY2Vz
c2FyeSB0byBlbmZvcmNlIHBvd2VyIHNhdmluZyBvbiB0aGUgc3RhdGlvbiBpbnRlcmZhY2UuCgpT
aWduZWQtb2ZmLWJ5OiBKw6lyw7RtZSBQb3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5j
b20+Ci0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYyB8IDUgKysrKysK
IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJz
L3dmeC9zdGEuYwppbmRleCA2MjZkZmI0YjdhNTVkLi45YzBhMTFjMjc3ZTk3IDEwMDY0NAotLS0g
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jCisrKyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMKQEAgLTQwMiw3ICs0MDIsMTIgQEAgdm9pZCB3Znhf
c3RvcF9hcChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYgKnZp
ZiwKIAkJIHN0cnVjdCBpZWVlODAyMTFfYnNzX2NvbmYgKmxpbmtfY29uZikKIHsKIAlzdHJ1Y3Qg
d2Z4X3ZpZiAqd3ZpZiA9IChzdHJ1Y3Qgd2Z4X3ZpZiAqKXZpZi0+ZHJ2X3ByaXY7CisJc3RydWN0
IHdmeF9kZXYgKndkZXYgPSB3dmlmLT53ZGV2OwogCisJd3ZpZiA9ICBOVUxMOworCXdoaWxlICgo
d3ZpZiA9IHd2aWZfaXRlcmF0ZSh3ZGV2LCB3dmlmKSkgIT0gTlVMTCkKKwkJd2Z4X3VwZGF0ZV9w
bSh3dmlmKTsKKwl3dmlmID0gKHN0cnVjdCB3ZnhfdmlmICopdmlmLT5kcnZfcHJpdjsKIAl3Znhf
cmVzZXQod3ZpZik7CiB9CiAKLS0gCjIuMzkuMgoK
