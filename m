Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B637F2582
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 06:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbjKUFsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 00:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjKUFst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 00:48:49 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7DAA0;
        Mon, 20 Nov 2023 21:48:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kp5XGYF+8dnUnevuiGxQNaPC4IAfWov5oIa0fG8TGHtV7iBC7sPIzLQgfymo2z5/zJhIu+h73ITMnZhU2qVwhvFgtbCs8ukrMUIO9Hraf12cXW0P9QPU3LvqDg0GYG8k/wgJPMuPOk6mI4lIE4hSO5RhNJfTZWcoo0qlhhHTsdWILeQsFw8s+Hugf/DzGMp0g0+XkxitrxSHTh/DQvQHoqT2Sp253FF64DGjcoDN42BM5rMUF+RKUAegn3UTbrMihIDNbNwG/I1fl5osT0XOK0iDgJ81bj0Vpz/IX3T3XXAfQ35SaU0PP+IOCQd2rsBUMcsBBQHl4phS8Dp/VbBNAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mknMSsMOfYtkqgEVeeZDb3t47igeR1HLYf8CRmHwC4c=;
 b=XSvWZMRI6lEl+3x2zdCKwV3oGPcI2jBVcrQJiiLY6dlVK3pPCeE24ECO4mF4aK+q6yLjpxZDXcTxMDzZB2cS0H+h7FETsfpb1vc28Ds8Q/nY7TI0faTWmyHqcVJTBY1jQq3kVfNAlb5P68zbe0GymJZI6JvIQ1+Z7xgYu1c1ObcT1NSboYXjpB/lqTzxA2N7id7dgWyoAHK7vmBoTy6VUw9vWLrAT3reUnfOZws77uAIa+RrXxY4wB6qxEWrBde+cfcy7Z7fXxsg9oAASWyMqlUZg07nxZIDma5O9jxAnkjAhFxR9PdhgH3V905VfWnbUPR6OElrVAPu7roP+ookfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mknMSsMOfYtkqgEVeeZDb3t47igeR1HLYf8CRmHwC4c=;
 b=o225mk0D3IOSwVuE7Uu9NvHqqJ5fUQzXk9gjVR+ukXG+gIaDlVS5QI1HELqScRWJOEj/zUr5ljFe8PVeHLgm8hBdk4wCiwOc5vJ2nVGRq1/kdnNIsWeUJcUSkfhYGEtukiK32b6O180DkxIEaT1c0LC4GqlNY+73527Uwoznrvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AM8PR08MB5795.eurprd08.prod.outlook.com (2603:10a6:20b:1df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 05:48:41 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 05:48:41 +0000
Message-ID: <9879beec-05fc-4fc6-af62-d771e238954e@wolfvision.net>
Date:   Tue, 21 Nov 2023 06:48:39 +0100
User-Agent: Mozilla Thunderbird
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH v2] iio: tmag5273: fix temperature offset
To:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::35) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AM8PR08MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: f10d922e-e85e-4793-f97b-08dbea558408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RWXEEwCKoijGHOyemNBJnTOeO0P9mJj1LSSvorXNEz0/mVy8m8vkfRX2fYZ+aZCle5P8bT242BRYADhCUproOts7RMrQlGByi9kdtHB/e+DYr+SEVi0FqtxCF8bS6POZdsPOulLxJyAJGFz8yb08MvxBFIWJ0X37un7VFgwZaBuKYk/yu1LQN/gpsA3SSXt3jRZCEdfxEKnuEqAjpm45xZIg15dkY3buDGXlSDBhZ7lBkXN20v+q60H1EVp/hmODtxC5VIAcn2VK/23jsPZ/gXDOIZrGeltp0bkrTbLqwmaV3K7pTS8094c0c1QGFY5gw2E1yAwBsOBBcT/EhgkUOcT9IuMdP1DmiEuuY93OWCU19e7lze6frWWl4Gj3Z/ndrJswn7TqvyOES+fBnisHNiJ+KnQSE8WBG7NEBAH52HhQKsNmBqUG3Apum9ihoaBElWJt+ikKS9PgKLtuo5/z11Du0N0s7tdgR1jjp+4m8zC/ExdQn9uRT9+wiAVphzp+rwBwF1wCNdw4Ebf7TRQE0xTUbAedPTqXakHAuuwdPv/X2o2KpCLOaZP4fuRgOYMBvfA2veWPLhAk9DC03E7DRr9tQ+u1kA56WBE90+E8xXRtIDcZAYqUk02KJQMM823uW5pLLgoVq2ZgMgHMa2mzpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(39850400004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(6512007)(26005)(107886003)(41300700001)(4326008)(8676002)(38100700002)(8936002)(2906002)(44832011)(5660300002)(478600001)(966005)(6486002)(6506007)(110136005)(66476007)(66556008)(66946007)(316002)(36756003)(86362001)(31696002)(31686004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjU5TVFwVHF3bjVBSXNPbmhzMGUrYUJKU1RKWFljMEpob1VNaFVsaWNFcFE5?=
 =?utf-8?B?UXZWWjRyOTU3WDRpakxmMGdRS1NQTWtvSnBWQ3NMSlM1eHNQNDJpYThDYVhw?=
 =?utf-8?B?N2Z2SXJQRjVVRk53cHNrOFo0QmYyMGZvYVR1UmZGK1h2V0xjSS9KajB3OWY5?=
 =?utf-8?B?R1l6d1JyMkltdS9CRVgxOVRyZGhmY2NPTW5BbTBRbjZ3N0pNQnlWSEgwODJC?=
 =?utf-8?B?N1VBaUhCRkFyUnlQQk52dUw1SzJ2RnZhTi9udjBlRklVZndWTys4UUlCa3dX?=
 =?utf-8?B?OGFCVkx2TnBFRU42SEJ4cTc5L2tXSm5xVEhUdFNmQW1SV3J0TFhVZDZuTGZm?=
 =?utf-8?B?eWdCNFJPVkpSMnpHWWhYYVl1QXA4ckJQaEo0OC9CS3d5bEJwZWk3NHltT0JJ?=
 =?utf-8?B?djM2RXhkalNtdzV3ZTcrK3RwRGRmMU5oVW9VNEw3QUFhRndyNVRPT2Yyb1Jv?=
 =?utf-8?B?U0hFZ1ViTUdPRlZSczlqM2VvQ0xyaUduR09WWjVFS29HOWhFeWoxZFhWbnN4?=
 =?utf-8?B?STlLK012RFYybjN5a29RU2l5bWtHNzFzK3FuRDV1QmpzWkIyYmNVVlEweGZj?=
 =?utf-8?B?OWpVckxFL01ObkpiUk5abTJEYWVNekVrRVZsODhOcTUrSUR2S2haWWZnSG9v?=
 =?utf-8?B?MGNjTm0yMHdIbkg5UTZJdGIxOFhXYk1jL2phdWd3YzJtRi9tejduRFJTeTdJ?=
 =?utf-8?B?NFV3NU1ZNklXSi92WEliMWV6YmJ6YnlTdWpWTGZ6UmZ5UXRKWEpCMWI1YVJ4?=
 =?utf-8?B?T3R1TkF5TlR6OGF5MWpldjZzRUxoQXhHNGdBWGVOVjA3bERudVczM1FhK3ZX?=
 =?utf-8?B?R1dHV08xT3JSL3BPYWtoZ2VTck8wNXBaSUFUR2txRW9PdzRUUFMzd0xWd1NC?=
 =?utf-8?B?UEFsVTV3VDNwSHNkcFRqcmVXelFnVStrdGtmRVF3ejV4bDV5UmRLZVJ6cWNQ?=
 =?utf-8?B?RkNHalppeWZHN2FJUXZyem5PclZnT0M4WHc1aG5lU2h6SCtlRUdYYzBwbit3?=
 =?utf-8?B?ZkExTmVvQ3k3OWdMUFRoZjZTaU5XdlBSMW1FQ016a3kyRmFZZllvMnFidVdO?=
 =?utf-8?B?eUY3aUxva1pkZVNaY1NUY2gra09oRm1paVRwMGVHaGlpTUVqYUlYcVBUNWRm?=
 =?utf-8?B?YWFDc0tZaGswWC8vZ3E3OVNuTTMwTEVvcjZNcE0xbFlHWnBKcjM4WkdCQldR?=
 =?utf-8?B?a0tmdmpKd2M3TjV3amJzM21IMWkxQ3kxMm5KSnNHRjd1SEJyT1BjNEZHcWhw?=
 =?utf-8?B?MzVGSjU1SWpzaUlyYVhwRnZJV1BjT2dtd2tRcGRWT09UNzF3K3NsZ25Qd1V1?=
 =?utf-8?B?WDRCY3RzRTZiZC9TUyt4RmYybXRJWHh2R2xQZlRPZWFKbHhrSnozdmp5dW1X?=
 =?utf-8?B?RnhSMFpVRjVwUi9MQnI2cjhxeFJVdFdtRkVNMEc4c0FyWkhtZHhwM0N4ZHBD?=
 =?utf-8?B?YlRybndkcFgwWHdkMFF4c3J0eVBLNVhmVFE5SStDRTZUcllJRDRGRmFEQmda?=
 =?utf-8?B?UjNXUGFpMmo2anphZjFSNU53dU1rKzZXYTVLT2x2S2x4ZFM5Y0k5SUkrZ2gr?=
 =?utf-8?B?K1dYWHFUaThzNVZLZWg5WDBSaEFudUhhR1RKMy9Kek9acjNHYlBaOUZUaG9I?=
 =?utf-8?B?eWNaQy9uU09NRklDM2ZHWFlNcnZxOUcvQ3d5bDJxN3pvTllJQnBHSTRUczgr?=
 =?utf-8?B?QkJxQUxjN3VLMEhHVTJJcDJEYnVKMzZsQ0N4RUx5cEdDZGdGUWEySy92M0tm?=
 =?utf-8?B?b0tORS9HSWc5OEd5Y2o2bnZQUDlpTGFEWmpMd1doVmEvNkIvZnFwVGt4akZh?=
 =?utf-8?B?UWF2RUtLekpDdUZhbGRoUFk1N3FnSldyKzdxdFVXNWZJRk1NMC9LNCsvclhs?=
 =?utf-8?B?UGRNR29RQXU4MzArR1V1WVNpMWJPUU1PcklGNmRWOE92aFA5dDgxUVVaaVVU?=
 =?utf-8?B?VnBnRkhGeVZ0R0p4TStOTmtiaVJFWjd3dU5VWEQycTBQZThXdThrc2p0WmZC?=
 =?utf-8?B?RWJJMEh4OVI1QkM2Y0QwQkRIU29aTTgyQmR3MHJ2Q2pHOWphOHNrcTAxM0NQ?=
 =?utf-8?B?RFJOc2M4QUlHOUZUTEUvM2dHYVRuOUJ0UmhpUFp3NERCT0NCQ3I5L0NySXJ2?=
 =?utf-8?B?dFByN2h5ZExPMHJJdVNmM1VBK0FaL3kwM2ZtVTRUR2NNZnVaT1BJaCtJczRH?=
 =?utf-8?Q?9rA2xZoTOgupRI1QSntc7TU=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f10d922e-e85e-4793-f97b-08dbea558408
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 05:48:41.3050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ja+1PqiI8V1K5quIJrHQGH35PmfmJSelSsB8ZlaAiRoBCNzgMpROdfRtKDzKiWk8WCX9MVzNlHPT+l1gFOz9UNOUkjGg5OncTZYeJOPUcKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5795
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current offset has the scale already applied to it. The ABI
documentation defines the offset parameter as "offset to be added
to <type>[Y]_raw prior to scaling by <type>[Y]_scale in order to
obtain value in the <type> units as specified in <type>[Y]_raw
documentation"

The right value is obtained at 0 degrees Celsius by the formula provided
in the datasheet:

T = Tsens_t0 + (Tadc_t - Tadc_t0) / Tadc_res

where:
T = 0 degrees Celsius
Tsens_t0 (reference temperature) = 25 degrees Celsius
Tadc_t0 (16-bit format for Tsens_t0) = 17508
Tadc_res = 60.1 LSB/degree Celsius

The resulting offset is 16005.5, which has been truncated to 16005 to
provide an integer value with a precision loss smaller than the 1-LSB
measurement precision.

Fix the offset to apply its value prior to scaling.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Changes in v2:
- Fixed typo in the offset value (16005 instead of 16605) (Jonathan Cameron)

- Link to v1:
https://lore.kernel.org/r/20231023-topic-tmag5273x1_temp_offset-v1-1-983dca43292c@wolfvision.net
---
 drivers/iio/magnetometer/tmag5273.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/tmag5273.c
b/drivers/iio/magnetometer/tmag5273.c
index c5e5c4ad681e..e8c4ca142d21 100644
--- a/drivers/iio/magnetometer/tmag5273.c
+++ b/drivers/iio/magnetometer/tmag5273.c
@@ -356,7 +356,7 @@ static int tmag5273_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OFFSET:
 		switch (chan->type) {
 		case IIO_TEMP:
-			*val = -266314;
+			*val = -16005;
 			return IIO_VAL_INT;
 		default:
 			return -EINVAL;

---
base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
change-id: 20231023-topic-tmag5273x1_temp_offset-17774cbce961

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>

