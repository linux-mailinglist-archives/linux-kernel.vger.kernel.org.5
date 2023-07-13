Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59745751EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbjGMKde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbjGMKdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:33:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2106.outbound.protection.outlook.com [40.107.244.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B594C1BDA;
        Thu, 13 Jul 2023 03:33:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0uhJv8OAljvAwTJZc0RcgJw6PL04oNzA0YZmtK15smcBqPWfkgB+314P+vwBTVxX3yYLzTj0Kk99maZXunLjSpXCvUb9uwVNHw6uG324SwDvacad05UrrjVTpuAhCL6uEYaBrIIi2PtUqr9tG8DinLrONycBNMj42AO35hp+VL6n67GYFzJwEe8I+CdvVKdPqMFW1f5cTP5OkJceQ7Tp/SGhTRK04c7vGoIGKlFELSLr0bcYgRGePEihhs2+CbXcvkp2xzpfQM9WAN8YVB+sX32VBDy7heqKI6iYeYgsbhMLwLPTH1wBru2aTGVOy+MK4z5cElEkLirEgocyDDO3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eooczQFQM5SI3H2WOHlmRovkSDsK4qnU+i7ckej9qGs=;
 b=K/D8bz6Hob/teKKARK5vr1GBkxbtdGycVdpazTOKnAjs+wA0gCQxbIcj4v9lBAsgpHMDdq8URITwhwLIkBbaxy9T/cV5eEfJZ2zr1y6TaWEkBn+tLolrb8MjQ+vNkJbvpMVMueLhQd1riDBHK+gzkwzu4g8WygdJzUDfMNh2RnUm7kOos7uB0Hb0voemKoMEMMO5VBxzw1oCdPEQZBs9HknTc3bkUPMiOsH+enDhqFmVbT4GXaf8Vyo4AQxrPGmFl9o8Ea2nIGVem8zm8bwikWoKmRp97qoYn02G14NcutVWKYrHF9Q0gu7famCKfJ8RPsZlxUqti8vTTPsYslIhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eooczQFQM5SI3H2WOHlmRovkSDsK4qnU+i7ckej9qGs=;
 b=naEy/JJkufLva31mALNQVtpVuGY3GmH8RvqI1uTIG0Hwb7NO+KWNK3WP2KBHYJ2/jfqj2n35L2q6FDJkxIlh+hph7zvMtCp3Lmpxk3egqZ3WSOPBcHYeI/DyNDJcA1z16Ph/96Hj0Itq7K0qS3wYNGcYjg5lwvBXbRkQOV1+lig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB5451.namprd13.prod.outlook.com (2603:10b6:a03:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Thu, 13 Jul
 2023 10:33:27 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 10:33:27 +0000
Date:   Thu, 13 Jul 2023 11:33:20 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: ar9331: Use explict flags for regmap single
 read/write
Message-ID: <ZK/S8DqTw1pQLd4g@corigine.com>
References: <20230712-net-at9331-regmap-v1-1-ebe66e81ed83@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712-net-at9331-regmap-v1-1-ebe66e81ed83@kernel.org>
X-ClientProxiedBy: LO4P265CA0152.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::15) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB5451:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6465fb-5f31-4174-0b35-08db838c97b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OzaLtHcSI7SjaZ1HzHMAdwoIhQa4WONcuiKBFXCmiEyayLOF8SkMod4FLdsy5fBxroTfSK/UscSBnLHXn25dWp4vQx+Vsj9LJkmCI/bragui375vk0iQcQi3st/3Rpe5mOqtV9mlmBpIz56BglQmvbANFiaGAo/4i9SByryWFykeJW9WsxWyMD8OLQepxQYuYoFRlCwTfiNOiDoF8klTsw2lLqg0I93Fb94kBKzBoVfCiL0l6GBfJ3lr4tvYvpMcmfp9h3RE2KByGHT4UK9oNR91f/Hbn0qcbH4MMdCOj8MYGxO0RoCBs/dAh+R9WTpyHTN+8CULQ5cgAb8ty76z1hXC7wwOWh3SdYmM8aOCV4jWTZ06wyz68Wew9t6gaHcCefSYQMT4gxLZxQPtJWx2hvsh/rzg4F2pNtdS1po4jjOSo2xwu1c37sxBZoSDTPFdUGmokhI6udTrPCqHBU3TRnY5InbWjPRri0aTvW1lJTUWvBLa1UoTr/y0x7VRvmxXnWCUrBVmModcCOwBZ2aSHKSudgPZmalDOmJxHC56oyv/OeNKfx5aKagQua92QXz9UBWNdfb7PscgfYbLB5JuNyPHTDZ7owAhmo5Q7AYlE/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39840400004)(396003)(376002)(451199021)(6666004)(6486002)(478600001)(54906003)(83380400001)(36756003)(86362001)(26005)(4744005)(2906002)(5660300002)(316002)(6512007)(6506007)(2616005)(186003)(38100700002)(44832011)(66476007)(66946007)(8676002)(6916009)(4326008)(41300700001)(8936002)(7416002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w2loZDDOJOadDwHvNeHZT9rPCRPXFbSFNZk1mOo0qhD6QVq8xKEQ1fABrnd+?=
 =?us-ascii?Q?lp7QWXmEBj/oiROipxWZhTDK52wm86e4jO4lnpHDqRKnw2c4eDnxoQOAptDR?=
 =?us-ascii?Q?WBtcg/tnvuaPWlnZeuAQy1SKCGjM0oH9nODlOjT3ZH9IhYhxL3dPV45NLtdX?=
 =?us-ascii?Q?XsxXLtfj3R3VfWvNs/tYF1JjZ2dZpDzexKiwTkKNpYMTNPXgb/ZbPMveIdEB?=
 =?us-ascii?Q?NlfWaScwRKNOoo2q42wL6npNArNfU0+vv0+g+Y5ZdqLfF00ypit2hieNLHAU?=
 =?us-ascii?Q?puPzbgrn2+dIyt78xlE7xaebPluzI+ncHupYsOxITUOU7uo11o9PijyCI3Zr?=
 =?us-ascii?Q?A0UWfQpvuP4KwTVIBdCzbHuunwG0Dz/C2z+PyEyI9tKd8HrMVPags0bHj01D?=
 =?us-ascii?Q?ZLJ3KiZmo7LR3VDv+tCTphyvkXA7Uq+XQK7K/hPYpXBSmDIrcfZbw4ADnRZ2?=
 =?us-ascii?Q?G8Dawv0vKw9O91ruWuUXlSn9/lMt32dBO4IYaoOCdqa0vAesH/KMjfKQyCb2?=
 =?us-ascii?Q?ypC7AQDc5siee2xskzUIewA5KRCUc0HMe7k8CdGB0F9766bgxG+ppK64T0bG?=
 =?us-ascii?Q?CkpKT8vr6Pv+hC0dGWUSFjSLjfo/kqE/QQ5lPikONd5NW217BAUdmQVN0OZ+?=
 =?us-ascii?Q?XXtT2fa3fhix6hu9RV7UKgzzS9ItwWOkjRtiQ2+2NKi4RrXknor8O/uoTBuo?=
 =?us-ascii?Q?/wUs78meHoEaGcvWQboLV6LrVErQES6BS8YeIBrDtJGxzAaOR8GJN9n5jaBV?=
 =?us-ascii?Q?myodLuMnBq7tAO4NV1jS50Rm/Eii2L0bwq75wWTS6YSjLCmVa4Zm5oRUBlnQ?=
 =?us-ascii?Q?VJMpQJiLcQ4bCiZlD1oB7dxkqDCXfxvY6v86KLvGLp4jidNgc/7GJGceqru6?=
 =?us-ascii?Q?O+y71CTlBK4LGOp3g1+W1wrzO7xLgUe6CdMTyJ1fPdPJYQ/HX1vIbxpO3Ovh?=
 =?us-ascii?Q?HAVv4ZF6gJTnacAAQqP8DQPQIHZJrYxqWjz+cLoNhtzqeQLSKLED9REoZr/T?=
 =?us-ascii?Q?B6GG1B9GUe1VzvxebwqgTlKL+xeD00ozWsZ4+HbGJHfEv3fs8Gvng4WM1NGI?=
 =?us-ascii?Q?enULUhD4q4V9hipFAsWDmVFU6yVAVJtXPynz2+SkkBHAMi2041hwZXQLmdBV?=
 =?us-ascii?Q?mtuCsTBxHk3mpaAK8Y8IDFV5gUwTxfAMx2brUbk4I7bIfJCmIYZ9uCin9hX5?=
 =?us-ascii?Q?PPWb6+K15XIg8mmdGfsM08f1u7qQOXceejfeW4taoYSJyXi6NAdiPV4KC51a?=
 =?us-ascii?Q?RqP4gWh36Y5Mtqu82ZTaQJWB5OEtOZPk0lp77BiS9OJhoM04jHTBDEyqT2Yb?=
 =?us-ascii?Q?FtXPwqOVJ746vxgSf700SM8ZWyS7Uaek1ZdVREL9o/kYwJQb64EkIFPMIKNn?=
 =?us-ascii?Q?C8M1tIKZtdXRNTur34/Bg26JhsPwtinSXWwYs/OoAqA68UYTwVL2hObF7sPl?=
 =?us-ascii?Q?ehWATmz0I+aeyBBHTsZtH5c2g2mAri48ONbQosicl8Av/yS2+u4FX39Iz65Q?=
 =?us-ascii?Q?CJPfcL0gJleb1t6RWyXPuE9OhYlOnNAwDTFWwmNuPBELDK9gCEyr0lSpshg6?=
 =?us-ascii?Q?Swp4YjpveFS734oYOYPjo9eLJXCSh9+B79a0k26oaqB4OOGKANUHBFmNyTo/?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6465fb-5f31-4174-0b35-08db838c97b9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:33:26.9410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vt759e55FAj2gAUdq/uanWd+FTzESRTz1jOoHhAQJEb3Zt5ISe1FLejSfMwlMARYEOLBzzDuuTtu/xiJECKQyzImrYx7xpjAFzPajj3HRNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5451
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 12:16:16PM +0100, Mark Brown wrote:
> The at9331 is only able to read or write a single register at once.  The
> driver has a custom regmap bus and chooses to tell the regmap core about
> this by reporting the maximum transfer sizes rather than the explicit
> flags that exist at the regmap level.  Since there are a number of
> problems with the raw transfer limits and the regmap level flags are
> better integrated anyway convert the driver to use the flags.
> 
> No functional change.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

nit: there is a typo in the subject
     explict -> explicit
