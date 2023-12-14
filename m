Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8CC813631
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjLNQ3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjLNQ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:29:13 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D66B11A;
        Thu, 14 Dec 2023 08:29:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO0F4TQC6v+YlYk1AvWLT+n+UxV91L2wQVsmp7qbG9KOZAOAma9qbikNDLXB6HGgebCW54DgN0Q26AUSZTM4nQtbNozuAJsXJcq3QKo4q2L4e7PcZ+D8/i901O+K20utbmc3qwhcQK3wt7RYgwFpcMKaQ/WtosAAV9E7z/zHnktOOgWhZjW6MLlCqfjYi0WCVuLCaMYOli+lC2aUdDyhpYZJweUdvvmeph7DUbt00qSDkC0nSnQqUyYL8rMsu7OvV9pMAzcxmpKdfAoWruWTtRiMrJnEyb50sacN3X5lsopo3xsqw9omdBcLZ2Us6rU7zeOve2vHPyli6Drx1w5N9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muHjV9f8sp9Mu6KBzS8Xy1OTxafFikYrBtEJqQnGvj0=;
 b=Lc0r8dSRfv8UiVA44KYByPVxbMxOZ3uB+GgDUv9epj+R5JHpstTfKQrSifjP8O+qACpNzhiCfHd534r9QXu69wXWBxocPol7D+EXjAFCWfo4g6mZdD0hu+o9AcnuYfaA12aG2i8o3XkO+zAQfcCV+4H0OnARVR3h1jycqHR6VkZa5TkeAAV3484fk2j2zei5AntJDSJ8O0n6N/FIA5lrRVGtw5CUhrtSNw4ZbduS2uHK8uh9cn8+e0AcD9HBkUO3jcM5L4XapvyxcGSYbHm6tdGnpOsfIADQTZE5hfjIwQ9Mh9NCY+6wT5F0xHb4T1E4a/Z7mrA1ZYMPFKeSmAPIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muHjV9f8sp9Mu6KBzS8Xy1OTxafFikYrBtEJqQnGvj0=;
 b=LfH7+GR/D4Q2U1QK+4R5FjJcXG55bhQXEGxwhRgGrsCo1zoPbIBJDhs2VTuy3eJY6hDZLTFDYM8oROR8LoDoC+WaK8W4OpQrAZuO1FP3CAMamX/H2z28PU88bbWPXkcC5WJc9N5+L7GFEjyh6W1YRYyh+aUFrRla62Ve+FJUaaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU0PR08MB8302.eurprd08.prod.outlook.com (2603:10a6:10:40e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 16:29:14 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 16:29:14 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH v2 0/4] usb: typec: tipd: add patch update support for
 tps6598x
Date:   Thu, 14 Dec 2023 17:29:08 +0100
Message-Id: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFQte2UC/3WOwQqDMBAFf0X23JRkg7b25H8UKYlZa0CiJNFaJ
 P/e1J57nIHHvB0CeUsBbsUOnlYb7OQy4KmAblDuScyazIAcpUB+YXEOVVlft8cyGxWJVRJJ6ao
 2SAbySqtATHvluiHv3DKOWc6eersdmXubebAhTv59VFfxtf8Dq2CcmQ6FLiUXphbNaxr739Ozo
 whtSukDtL/vYsgAAAA=
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702571354; l=1676;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=dg1DUYN3nvxSvXMMUXgIDxESHY7y9Xr8sWz8SlSFvmg=;
 b=Y/DLiGZWbq/r+yNr2a3bjZ6TDnPIVmU+6DE5R7bjdDXCgR5SSF5RLVw0roOHHZ0BChYRsnR91
 ftydvJwJv8OCx0UE0oIlE17tn1+IGl4O2S2Z54BKiJRwjjKsjkXrL94
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::19) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU0PR08MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: e201e5cf-2634-4683-4639-08dbfcc1cf93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: asEpybDj39TJRbYpP0n9WIwRpDM9K3LbNa18kFpCd7YWDpqAEb5SJMz0a1UBE7d5EK9tixrs5zXY6xxr31Cfua1i44xzatkihgA19rgPLfZ2KedKbavPy1IiVSsUhCj6jxdvxTHXgN+90Z+muid6lJ5jwLNxip0WNTdAMXsRsvn9+XI+GS2ElqyMPLuFNB3CpFq5pAughgS199iewKjiLxX1EeRu/9B4ysg/sb9AXGEGzxlBOUvPsaTqn8YI5lraStWR7k14f8fInlTUcxx4wn9a+nITbcERjtKLAqWBpA6mVoFw2Gbk+GHukkLSmkWO4Y7iyXAb7J0rh+SWuUHpa3cj4u9YGhDAnEX900819qlCCrJhkBAzexSp0WX9Cjxef/xTe6nTSa3n7qjdv0nlGEjwP/ghPC9C8bXlcXNbktN3v/AxsXN4piE16O4h7bbu6ISdT5Q6Tqb9RxPiRRV/SAWVDt5Uj94mAp6Rw3846YtE+8LJlWtidnDQChEgzZEo5h1V6ew6MA/hUMDPbwv48cHLLfkz4A2LeHMIGMLmVY/Dp7fqyJgl4XLkNyEXE/pMlnON8s+iFX6tcgL+DKeh7SsswLkKc9KFRDiX0zMjYBs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39850400004)(376002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(52116002)(107886003)(2616005)(26005)(6666004)(6512007)(6506007)(66556008)(83380400001)(15650500001)(44832011)(2906002)(5660300002)(41300700001)(6486002)(478600001)(966005)(66946007)(8936002)(4326008)(66476007)(316002)(110136005)(8676002)(38350700005)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzQrSUxydXI4bDg4VXBNMlhtNGVNbGF0dVdmMFdSSzFtZE1wVlFUZDZLSU1I?=
 =?utf-8?B?anpSTTAwQkVwSml6RkVkOEcvK01sMFN1Zm16VThVVXVVKzFmWitnR1IxRmhp?=
 =?utf-8?B?UCtOMm9aNk5EUXhqbWlYbmtBMHN0VTlkZzJsaUhad3pUbXFFd0Q2eUVWSm14?=
 =?utf-8?B?N2tUcXpPRUMxMFJFNmw5S29tS0V3TkNoekNSck0vTERPVmsvMnRITUlCQitt?=
 =?utf-8?B?T09IRE4zcmtSQ3oxem56SEk4THFBTEpteEpOVnJRc2VEUFJOeEVTNTlTTDdp?=
 =?utf-8?B?eWFVNzFmMzdzR1czOWtlb002K0EyeHQ5UGJyMWRlaW9HTno2ZHh1Qlh2ZDNW?=
 =?utf-8?B?K0pOR2M5S3RBQVYydEpWWXdRNGtJVlE0eko3bkZKdTVLSDVRcUszY2p5ZDNn?=
 =?utf-8?B?RENldXh1VEkvMmNlUEVBdWNqVDV3VUlUeENoZU9aNkhxVjFoeVdXaHN0VmJu?=
 =?utf-8?B?NmlZYm5STVNIVzVydmpYL0lSNnQ3OFdLMzl6T2h2VnBpOTVIb0VCdERFcVpQ?=
 =?utf-8?B?dDZXNzZ0ZEJjQ3A5dHBCVldrZ3N3aFJYQmhNaW4wanFoQ0pYazZyV3dtYmE0?=
 =?utf-8?B?L2lZcG9rbTcyNE01UTM4MHVVd0lhSEZiY04yTkozZWZRemNPbEZSbmRQVVZZ?=
 =?utf-8?B?UUZXanM0Y0VqUUNqNmhUaEJoWWRtQlVNS1d3TG96cWRMTmtMLzNaU2VkWC9M?=
 =?utf-8?B?a3VLQ3hyR1FnQUxrQkwxaElsTm52UW54STRSWEJTakFNQlZxZVVhU3ZQa04w?=
 =?utf-8?B?TGdDbEhNODZZRCszbzhFSGFlOU9QbjljMUh0ZTFrUStWSHYwVGhXQXplMU96?=
 =?utf-8?B?eDllK3ZFNEpvcitQUXUwZk9ITjBoVUpPVTlNSDNxVTFuQ1hMSnAzWTJJUTN2?=
 =?utf-8?B?amQrb0J2dDBZV3NiSERUeFlMTE16UUpvSDhoVFdTUi85Mi9Cenk2aEFIK0Vs?=
 =?utf-8?B?NzZmQm11a0Nmb25sYWFKSFJ5QU9ydks5dE1icWVkR2pFSHM4V0txRjNiNHdi?=
 =?utf-8?B?SlVDWTZ5ZHFpNFFNZHBWdThhbkcyOHovbmZ5Wm0wRDMwNTV4dmQ3UzQxN2JP?=
 =?utf-8?B?czBOL3BJZHh0b2Y5eG5QOHh6SnZHaUxWcDRHQ0RQQlROR09JaTEwTDZTakx5?=
 =?utf-8?B?RDhlNnpGRzg4VDMvUUJaSG5VcFV4WnZQVWNWd1lrL1ZsNzRTZy91N2JkMm5j?=
 =?utf-8?B?R0R3d0U2V1BmUHMzL0NjcVdnSXhwUmwwVmFPQUZzVENGWmRXVXo3N2o1SVIr?=
 =?utf-8?B?bXIyOW1naTVBVWVoc3Y4M3FCTXYrM040Z3FrcHFTMk1jQVVjVi9kbmNWaEs4?=
 =?utf-8?B?a0lMMDFtYThpdURwQk5qeVlXTWZ4WWIvM0lNVlE1VGZadHZqbmpTZklCczI2?=
 =?utf-8?B?OEZPMHNYS25ESVJkR1ErWkV2UUprczhZK0N2MkF1ZnlVdjRCOW9kWjl5UWlM?=
 =?utf-8?B?Y1FYUXdRY0R5akhEcE1yVjRrbStpNklPNVRQeFozQ0ttSHI3K2Vzdmp3bUE4?=
 =?utf-8?B?b0txVERhd0dhR1RyRzdHR2ZJQXpxQ0NVbFJOM2ltcktZbHlVWlJOSzYvSmdS?=
 =?utf-8?B?c3hlVE1IOUxXSlNxNjZmYW1qVXhSdzRKT1R1Sy85d3pxdFRLcm5NMWRBM0c4?=
 =?utf-8?B?Z1NXbVNJQW8vUXlnSXk4WTA5SjhjSHYrQjN2V2JUU2UrcTArRC82M2hoc2J0?=
 =?utf-8?B?Wm9ZbDNmTUNLcnkxU1pQcWN5ZmFVTVB6YXhUL0xHKytFU3BUK0xHY21HVkhl?=
 =?utf-8?B?Wnd6anY0b3FPN1lxUk1ZRTFpNVZiTWVwb05xYmorempYSFUwSWlyaHdGbGNX?=
 =?utf-8?B?TjlUTG5WakdaajV2TkRvaXpQc3pxcmMxaFZFS3JkRXovT2l3amxVWlF6Mjdx?=
 =?utf-8?B?ZnhGZHptUDZSWUVkZUtJRjBaRGJhVFR1TnFySFo4bFNCSThrZlFlTFl0Z2V1?=
 =?utf-8?B?UE1CZmJ3V0UrQ0x3cDY2YUVPbndUUmVsSm0zS2N6NmNXL3B3ZnVEY0Z6bi9F?=
 =?utf-8?B?MEZRN1N1UXFxZStIUjUvZ2tpcnVyRnRXeHFUL0NnTlVkQ3JCbnBQdDA3ZHU1?=
 =?utf-8?B?aFhxdDJGYW9uRUJXY3BYOWoyNWhRNDNsTWZsNldQVm1BZUlya3NjR1NTQ2tO?=
 =?utf-8?B?SDE2MXRoMml5NlVzMUd6b1hsVmxraHJvTzgxcm1mOUxVazBWVUdCcjdjbUlD?=
 =?utf-8?Q?hMZRO7QqS5s3ra/1hqVug1g=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e201e5cf-2634-4683-4639-08dbfcc1cf93
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 16:29:14.5521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9K1Gx2yYhFofcAV+619ZIkvDAekhPO8OZJLiyRJl4L4i5OcQTNj4IFoj3fwH8Num0YkNFxH9v/P3i/b7qIDzmdpaZ21FT0uVyZ0V5HBQYJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8302
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extends the patch update mechanism to support the tps6598x.

Currently there is only support for the tps25750 part and some
conditional clauses are used to make a special case out of it. Now that
different parts support patch updates, a more general approach is
proposed.

The update mechanism differs from the one required by tps25750 and it is
explained in the commit message as a summary of the application note in
that respect.

Note that the series makes use of the TPS_SETUP_MS introduced in
commit 6a4d4a27f986 ("usb: typec: tps6598x: add reset gpio support"),
which is currently available in usb-next / usb-testing.

A TPS65987D has been used to test this functionality with positive
results.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Changes in v2:
- Remove probe defeferring mechanism and expect the firmware to be
  available (Heikki Krogerus).
- Link to v1: https://lore.kernel.org/r/20231207-tps6598x_update-v1-0-dc21b5301d91@wolfvision.net

---
Javier Carrasco (4):
      usb: typec: tipd: add init and reset functions to tipd_data
      usb: typec: tipd: add function to request firmware
      usb: typec: tipd: declare in_data in as const in exec_cmd functions
      usb: typec: tipd: add patch update support for tps6598x

 drivers/usb/typec/tipd/core.c     | 150 ++++++++++++++++++++++++++++++++------
 drivers/usb/typec/tipd/tps6598x.h |  18 +++++
 2 files changed, 147 insertions(+), 21 deletions(-)
---
base-commit: 51920207674e9e3475a91d2091583889792df99a
change-id: 20231207-tps6598x_update-632eab69d2ed

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>

