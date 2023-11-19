Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CF27F05F9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 12:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjKSLdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 06:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjKSLdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 06:33:19 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6304E19B7;
        Sun, 19 Nov 2023 03:31:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZZO99TYhUAuwAU/VRsfU4Y7Mvt+DWVKX5PpufP9z9sFE+tZQ0Y4xRwAKeYlI1gEMc6vCz17EGw5alIxdhMdQBTThErUvqLVBCKlA9xNXhODq/0y5n6uIciZQvSvcH3GG6xelhSnRUfIdHjCh9mvxK2k6YA4qok86r0X1Yg4WB1ZzMqaWBT79YjLvRX6cKs73zmiLky3M0LmVFCSyojhXpRStJBKrejuJhFJJTDZu5AA9KmXOUYHFPI/Sjl9y6dqF/xeW8WyhmCuwXv0PBVToBLPlru1tOHwFwmCtIFaeKgmHj0ksx/nwveF6RotZofZPDrTicTa5JH3mdZAT17ZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+1MxCDAL+VXAwZ1w1tZbusxF2hjn3qObDdr33XIjkI=;
 b=moTK5RxQmomR3mOjqSF3yMEcFjtptadirU20qzvYVqi74AKfIhKU2nnAbm4WkzjDnceSojs51QGC8hFSZo4M5dKegHePPrfvzctfAxJNf1KdkpPzJ5/1iamSK0WR8RAOFaP37etfRrvZcrK2mCZSS9izok9WerH+QHG/Mew3Oi0BjqQxe4HzvMy3vQ8ra4g1hONXLR2EAOWpx7ZL7comV3mis/Wmq4AFzHb8R4L2fOIo1stz/jj8HwQ+OjKZydeKEGNF4P8/bP5613LIT/cZm4Amq9XNjjCYb2kxQ769TBNe/UmUmcfqRqJFEb2nDiKNrm7M8zDeSSY1nSN53OKJhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+1MxCDAL+VXAwZ1w1tZbusxF2hjn3qObDdr33XIjkI=;
 b=D34l9eQNS9HV75e/oog0ZDLfiw90Q+PNZN2RTojKky7+EwvjLR0v7k2U6wuIa7+OsRffbMZrGCjcdYdvCJYT5yO8GWTJKjU5F9frqjo0iLHXqwPZ4C1jPPNEaf3Sg2MAPFzgSgG2tKXtLIs7C5+HzDB2QSLc4tQP6ifA/lDxBTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM8P193MB1060.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sun, 19 Nov
 2023 11:30:01 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7002.025; Sun, 19 Nov 2023
 11:30:01 +0000
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        stable@vger.kernel.org
Subject: [RESEND PATCH v4 5/7] serial: core, imx: do not set RS485 enabled if it is not supported
Date:   Sun, 19 Nov 2023 12:28:53 +0100
Message-ID: <20231119112856.11587-6-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119112856.11587-1-l.sanfilippo@kunbus.com>
References: <20231119112856.11587-1-l.sanfilippo@kunbus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR5P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::17) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AM8P193MB1060:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c9931d-4f02-4340-29b7-08dbe8f2de83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q0LGHB0c7TTeM05ow5gD+ElnnQL/FhDSeVFQhodrWPZS0SwP7AzQNQP5bYlw+4HKxeGCN6FXOl7gKrShGUbOXRdt1EZy/q/Sx2BVnpUfMBQEZklWLZvWX1OGnb+gVwjc0fNzdR3+NSOfCycUrq33XJe7NIiY1wUYXwI+Ivi/Bq+3sU7hk3VX6x9jkCmOHqGs82qJN1fVG8yeaQfE8b9Ji1wiUtgPyOCUndDHQNTtCuv1F1bnkVM+Jtks81qGg12LAKY2avguv2ve9G50tW/vFy5JEgmylJxKO7DVJdNUKq0GlUZ7hBf/mzZsMY46u/3YekOlQwlKcSYnGzVZwdFCcXbuEDpWEZSf1tdAn+YTNnMiM5jqGC+h8Jnkk6ldlH9Q5+thPTDsz/ifi+D+b/iMGbrpXAYcoFCSI7vuaSmqkK+F9ZmNLPgkFi6wVotrKp4JBRtNsIUHZejQY87Ru6PJEZApAEfljwIYA7xGDrOyATDLV+36PGp0Kn81Rmy1DolcPSeGNjCGwlaAhXfBcJ2S/B1QIhF7rl5ic0BHKx0zJ2E9ToWbeSS1xHONi9XnNBNp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39830400003)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6506007)(6512007)(52116002)(66946007)(66556008)(316002)(4326008)(8676002)(8936002)(66476007)(6486002)(478600001)(83380400001)(1076003)(2616005)(38100700002)(6666004)(5660300002)(7416002)(2906002)(86362001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTA4cHlsa2xpSktCTGhSbGtKK3F2Ujk1YWpxTndKbm5ES0gzQ0d4R1ZBVVB6?=
 =?utf-8?B?UlgvUTBGanh6elJOY1U1NUFrZmVxeWg0aWxGbDlUZEpMU2c4MHRtWW9zUGMr?=
 =?utf-8?B?bk1qNytrVHEyZWN4RmMza1l5SWd2RlFHaTErSnFBaWNJeG96UkdTRVg4QmY1?=
 =?utf-8?B?d29sZkcyRWpvRzhuZGxQL3VUWllXWDdzZkRwK29raTBmUE81ZGpwcStMKzND?=
 =?utf-8?B?cDZxaGJDK25GUkw5Z1ZRYnNjcmN0VmpZNU9teG9LdGJWdXBNQ0hjWXg4aUdk?=
 =?utf-8?B?bHA1bkE1VUhHckM5Y2sxaE9JN280a1psTVpyR3UwM2thMjJLK0p6eGMxUUpp?=
 =?utf-8?B?RUVyam1Fam9RaFZzMEx1LzN5MGd0R1JOT1dDUWxmZSt0NWozVnBUVldqSk90?=
 =?utf-8?B?MmNmVVRDaUpIV3dKRVJBdS9xUW1DMld5RnNkeHFhMkU3cGFiWHRYZG05eTQv?=
 =?utf-8?B?aVkxMjFXMUtjd3R4RTdpdkordkszRHRudGxEdXhuZDJaSkRnVExodzFnd3Ji?=
 =?utf-8?B?NEhXT0NGTnp2T0dVMnNVR1NseFFpR0hpYXp5eHNLMWVTTFhQMDl2cllIMFBu?=
 =?utf-8?B?TGlJNnh3UmlOL05IZ2lHbWZ3ZmovZlVsRUVhanpWdW5vY2wwSmhOS1V1bzFX?=
 =?utf-8?B?ckhYTDQyK1pZVzk0ZkdNR1hVU3VZK0tiUXBBVTVKbkZacUY5cFVsaWdlL1FR?=
 =?utf-8?B?M0NISnRBN2VMTTdGMUVJdk1BSXV6dEtBanpiTHhZV2FYY2NDQXRCUWFDSm1B?=
 =?utf-8?B?c0l4V2VQc0NuWEVXU0lUZ0RteGJuRUxXbk9PVklhWVZlVjAxb3N1UGcyTHNz?=
 =?utf-8?B?eDVxenRHTEhoMUxLMTJWb1IzTUVNVTBGcFNEY2NKRUVMNk1lcnFYSWoyTFh0?=
 =?utf-8?B?M01id0xPeVI3RkV5MDVMTHROVlZVVjFoenhsWkRNdGdueUp1S2FCVnJoRDFO?=
 =?utf-8?B?Q2xzc3V0VzVvVUhRVFM3SnhnaHhsU3QwTDcrNHR1ME9wMEFpQWdoR0p3MzhB?=
 =?utf-8?B?OTJ1V0JtWGV6QWhYU3VIczRVcE5oaWJBTVpzQXRDWWExVzBDTUFRdGxUYzFH?=
 =?utf-8?B?MnJzVjg1UThlUHV2MFhldTREb3NvZnFFZ05EQnJWOVFkY0twaGZzNlpzN25E?=
 =?utf-8?B?eDA3VTR4bkZ0UlJZVldjdHBMbUJCYktvNEhkUGlCM0VBb3pNVmxhYS9PejFB?=
 =?utf-8?B?dkNTdkhCMWlYa2hNeEFRdFRaMDhVODdLYTdjd1Jrc2RzUmI1d0FWTVNyYWkr?=
 =?utf-8?B?TWNTNVRjbGNJOHlqRjc4Ulg4VzRiY1p0STZwNUFkRitscU1tY1dkdjk0Y0Zl?=
 =?utf-8?B?dWhVUGYyVmkyZ0UzMDQvWEpjaGl1WnAxN1d5SGxGY2QvQVk3ZUh0T0V1ck9m?=
 =?utf-8?B?V1J5QTJGcG5nQjUySkhNL0hnSHlEbFNEQnR4cWZUTWF3SnNFVjJDNXhHRUtM?=
 =?utf-8?B?ZnBiWk9NK3RzQk9FVjhrYTN5ay9KZFBzeENtN0w2ZVVNRnFnditGOHA0K3Jk?=
 =?utf-8?B?bWszTUpaN2duSGVCb0NqV1BQczhSQ29Hcmp2cWRvcEhJSW9USUp1Z083UmU1?=
 =?utf-8?B?NjVDU3R0NVNvQ1BlN1hZdHlpNXo3TGZ4UDlkUDRrTnhzczZmQVlsSWJOZnBa?=
 =?utf-8?B?NXBXVkRtTmtRWnZZaUdWblFocGlaQ3NrNnBZbDZOMHVUVnNRakVFOWlydEd3?=
 =?utf-8?B?R21XaVVYczA5UCtTZGpWTWlQd3JGMnJKeGp3dzNneW56aCtXc09wekM2Slk5?=
 =?utf-8?B?SlNORHhUZ1pOZVdQNkxRYXZXTHJYd1ZnTFhGcUI1b2dWYUhpc3ZrenJ6ZjNV?=
 =?utf-8?B?MDFYN3BOUEdRZ2hnSnJ2VGdZS0ZvV1UzaWVnM3ppZWJwK0RaM3cxdC9wdUZ5?=
 =?utf-8?B?UTdOOU5wWThMdXM3Q3MvTGY2bnNuc3Q3K3ZFZjR4Q1lBZUVyajM0eFdkb0hx?=
 =?utf-8?B?TmJxU2kvaWtvU0lMdDlYaUhLSlRTbGpVY1k3d2ZTVTNseE92QXRZS0h5Uk9C?=
 =?utf-8?B?YkZhMEw0c3ZVbzVyNWxSRlZxTHY5eHZ5anlvcHd2N1ErNXFQWS85dzFvODBw?=
 =?utf-8?B?SlNxR2piY2Z1QjA4bWg0cFd5VnVBczFxQVJNK0pVRWhDb25oVVhlWnRsc1BC?=
 =?utf-8?B?c1ZLVHhqVkQvalA0ZXViaGprWEFVb1FZYTRFa1NmMEkxVDBialQ1dmRYTEk1?=
 =?utf-8?Q?sfw4mHCx/TdkeXmMGmIOVWH/l7hr5LUjG46BEvMsNSw1?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c9931d-4f02-4340-29b7-08dbe8f2de83
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2023 11:30:01.7062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPdr3yjCygk46Gx015I+queD7HnsBbnEMDZHMDEjI5HrMAfVD+qJWxtZ1wSA24RKSqFKTaJMUPthXVNzXrjkpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWYgdGhlIGlteCBkcml2ZXIgY2Fubm90IHN1cHBvcnQgUlM0ODUgaXQgc2V0cyB0aGUgcG9ydHMg
cnM0ODVfc3VwcG9ydGVkCnN0cnVjdHVyZSB0byBOVUxMLiBCdXQgaXQgc3RpbGwgY2FsbHMgdWFy
dF9nZXRfcnM0ODVfbW9kZSgpIHdoaWNoIG1heSBzZXQKdGhlIFJTNDg1X0VOQUJMRUQgZmxhZyBu
ZXZlcnRoZWxlc3MuCgpUaGlzIG1heSBsZWFkIHRvIGFuIGF0dGVtcHQgdG8gY29uZmlndXJlIFJT
NDg1IGV2ZW4gaWYgaXQgaXMgbm90IHN1cHBvcnRlZAp3aGVuIHRoZSBmbGFnIGlzIGV2YWx1YXRl
ZCBpbiB1YXJ0X2NvbmZpZ3VyZV9wb3J0KCkgYXQgcG9ydCBzdGFydHVwLgoKQXZvaWQgdGhpcyBi
eSBiYWlsaW5nIG91dCBvZiB1YXJ0X2dldF9yczQ4NV9tb2RlKCkgaWYgdGhlIFJTNDg1X0VOQUJM
RUQKZmxhZyBpcyBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBjYWxsZXIuCgpXaXRoIHRoaXMgZml4IGEg
Y2hlY2sgZm9yIFJUUyBhdmFpbGFiaWxpdHkgaXMgbm93IG9ic29sZXRlIGluIHRoZSBpbXgKZHJp
dmVyLCBzaW5jZSBpdCBjYW4gbm90IGV2YWx1YXRlIHRvIHRydWUgYW55IG1vcmUuIFJlbW92ZSB0
aGlzIGNoZWNrLCB0b28uCgpGaXhlczogMDBkN2EwMGUyYTZmICgic2VyaWFsOiBpbXg6IEZpbGwg
aW4gcnM0ODVfc3VwcG9ydGVkIikKQ2M6IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4K
Q2M6IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4KQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcKU3VnZ2VzdGVkLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29l
bmlnQHBlbmd1dHJvbml4LmRlPgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2Fu
ZmlsaXBwb0BrdW5idXMuY29tPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyAgICAgICAg
IHwgNCAtLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyB8IDMgKysrCiAyIGZp
bGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKaW5k
ZXggOWNmZmViMjMxMTJiLi45OGI3OGQzNjBhNzQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3Nl
cmlhbC9pbXguYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKQEAgLTIzMjgsMTAgKzIz
MjgsNiBAQCBzdGF0aWMgaW50IGlteF91YXJ0X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpCiAJCXJldHVybiByZXQ7CiAJfQogCi0JaWYgKHNwb3J0LT5wb3J0LnJzNDg1LmZsYWdz
ICYgU0VSX1JTNDg1X0VOQUJMRUQgJiYKLQkgICAgKCFzcG9ydC0+aGF2ZV9ydHNjdHMgJiYgIXNw
b3J0LT5oYXZlX3J0c2dwaW8pKQotCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJubyBSVFMgY29udHJv
bCwgZGlzYWJsaW5nIHJzNDg1XG4iKTsKLQogCS8qCiAJICogSWYgdXNpbmcgdGhlIGkuTVggVUFS
VCBSVFMvQ1RTIGNvbnRyb2wgdGhlbiB0aGUgUlRTIChDVFNfQikKIAkgKiBzaWduYWwgY2Fubm90
IGJlIHNldCBsb3cgZHVyaW5nIHRyYW5zbWlzc2lvbiBpbiBjYXNlIHRoZQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc2Vy
aWFsX2NvcmUuYwppbmRleCBiNjM2ZTJjZTZlOGIuLjUxOGUxOTAzNjk4MyAxMDA2NDQKLS0tIGEv
ZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFs
L3NlcmlhbF9jb3JlLmMKQEAgLTM1ODgsNiArMzU4OCw5IEBAIGludCB1YXJ0X2dldF9yczQ4NV9t
b2RlKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCiAJdTMyIHJzNDg1X2RlbGF5WzJdOwogCWludCBy
ZXQ7CiAKKwlpZiAoIShwb3J0LT5yczQ4NV9zdXBwb3J0ZWQuZmxhZ3MgJiBTRVJfUlM0ODVfRU5B
QkxFRCkpCisJCXJldHVybiAwOworCiAJcmV0ID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTMyX2Fy
cmF5KGRldiwgInJzNDg1LXJ0cy1kZWxheSIsCiAJCQkJCSAgICAgcnM0ODVfZGVsYXksIDIpOwog
CWlmICghcmV0KSB7Ci0tIAoyLjQyLjAKCg==
