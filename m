Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F1F7D7197
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjJYQVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYQVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:21:34 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2E591;
        Wed, 25 Oct 2023 09:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JI65gpTnk0+eRHKS63jym4vnQ7a3hhk0CyNaiENXVcZQPRktWZyQZwew5qWixNoZFQP6obJV62KkOPpJ0NadhGmK+j7FWGXwUTujw10r2Ibvmm2nNDd2BwuSVoUUOZBH556Gm1PBGhYzWCi0/9xLA7jMwzVghIsUmQGn3X+RybUMxU3y/7tD997PXKyxwuReQu+S7Z4fPLtJjSqQ6LaLk6KP4iPUKijLIGVpyoDP+4KAX/QpU3YL8+txh49glogVzJPie8unenICKXUEl07yPsriRlimd0mcQv4DSqBsR/K6mlDyGDCH1Y9mLCu9e57jmIEX9/qh+q61l5Ve71209w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdVu4hLita5BGAbnKwzCGjNl+z2XuqOisGCQ7HiOdps=;
 b=Ao5hEelf6PPSujr0FEoqKJHkoII5ey0+XBoyc5BKV0enlZTIB97HB7QCvA/lYNmUN9fjvhPrBpI6MdIBT3/06j2Gj8BvuhQjcaxHaNpxqhSf8zTSKdWubX7HQIGCctdilRfWeo0oDo/HscSTiBEWEBYVBrnzSKQJc1OfosSdH4gBlPPcKbnu0f2BDtRVAs2rd2OjUSm7M8eLuCPSBGcximxrCiyBaZLJTUMHonz+u1ex1iQhOaf41bhvc6/9RHfM1metSx+CmX1FJ9SiWe051xo2lVDYIL5pw4fNKkemIJXHf2AMIMmFwqC8/cd8jAGGBTyLL3FZHoQ8fmWlwk3tow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdVu4hLita5BGAbnKwzCGjNl+z2XuqOisGCQ7HiOdps=;
 b=ehHrBOMhxrxpB7LSqyjzordJvbPZxqiWuJzUNBf2FXQxuQ4xRV0z25hTKCXMMWl4+vcGsqAoZ6xVegmt08a4ru08ZAhhjBwPXkT4JebKunuKf32f/+PnSM01LaJ4KWRuTAVjPSSvkvtmTcdTnGzzyBCjQ9lNdFj6obhgxwqOtQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by PA4PR04MB7870.eurprd04.prod.outlook.com (2603:10a6:102:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.18; Wed, 25 Oct
 2023 16:21:28 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::b1fa:fd23:8cc2:f5ee]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::b1fa:fd23:8cc2:f5ee%6]) with mapi id 15.20.6933.011; Wed, 25 Oct 2023
 16:21:27 +0000
Message-ID: <5d7021cd-71b1-4786-9beb-1a4fe084945c@oss.nxp.com>
Date:   Wed, 25 Oct 2023 19:21:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 0/7] Add MACsec support for TJA11XX C45 PHYs
To:     sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sebastian.tobuschat@oss.nxp.com
References: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
Content-Language: en-US
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0015.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::27) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|PA4PR04MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: eb696e10-2203-4c63-f466-08dbd5767028
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBfGz0PqUxda3tIfi+v8TH1ML6jio76Dx5LRwJ3pqFWXtxTiSqIwMrljiyHVmw566PhDypnkj39NqOTx9ue3Uj6Yos2YvZFG5V6/3z0vsw12I8n/eNk/fmArgTXFZoqi3SdtK7vestzUOEGygbaApfOIDIsRUoMG9WpdDOAb4Su5hipzL70Y6Y0Q9H8UTyakXO366Jfcw0J0ZdjaqyYglSFUVgYNkfENi/JKikE6YWa4e1UxWF041jEq0IhqL4CJLn9OCEeVXOihXvXxD8flpwk7doJkyKJCEM5W8Upo5j0Md2+lVcMZ5kVsEMKExjtTkwDeL96vaW9bhQZ3Mq6EztzGjPGjHg2r9iPItF9QGPlkO3nn2f6WLCLM+KXcHOs9N6KbMuhivD0RrO1HotWUHWL2JdIJEth+b2T4yqfz7pxj0cBn2/zygpm7QJBTtxIrzOJRLATKTYc7tyjOd0GFFKceVeCTKTN3GtJ0rvEtFB/Z+3yHancio7yPSxNE7On8wnra3myFFwKIJu8Mo17rCBLMb449fN5Dxj1Fqsx/pUpQk91tABL43ipbh6fO3ux0Mw9/3CwURi/0kEBQO0P9r4eyHBdNOkQLsyQnWTkjzaa3kuRIkNMD6uGPc3XwtV1hu8TyzcyFtXk6EFHnDGFiiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(53546011)(6506007)(5660300002)(6666004)(41300700001)(26005)(83380400001)(7416002)(2616005)(38100700002)(86362001)(31696002)(6512007)(2906002)(66946007)(478600001)(66556008)(316002)(66476007)(6486002)(31686004)(4326008)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDBidU0wNXpYZ2libnhHOWt1Unh3L21FNkJuWTlIYTVKWWEvRmxqOVRVL1F1?=
 =?utf-8?B?L0F1b1dDMldic2YrVVNsZXcreHR6YmQwRmVzVkc1SDJnTms0dW5FNlRncDJ2?=
 =?utf-8?B?VzRBdGx5L2xyM0xydVQweWlyWnkvNG52Nms5b1dERGdVNjlJdElZNllVTkVo?=
 =?utf-8?B?bVUwUUZBbGxEWDl0YnR1UmwwSUxZOFoxWWducUdTcGlsYUpiOTJhT3dPWWdO?=
 =?utf-8?B?amdUYldWQlVNUFNRSzFta2d4RCtXRHVjZ3E1VUlCTU9sT1lmTTY5ZjlTZzlZ?=
 =?utf-8?B?SS8xTi9BUzVvYjFmVXc2b2pGbUN2bXFGSTE0Zlp0UzNld3dsbFo5eDkvT2lt?=
 =?utf-8?B?ZDJDQVlIaXg5SnFpbDkwcEZHbEFkL2QreWRibkNLaEo5ek5XR1F3OTNJdHJi?=
 =?utf-8?B?anFwei81bVZsTVNEWENGRzVTSTdESFd5MmtTNm1Ec0cveDIzekc3d3R1cDg0?=
 =?utf-8?B?bzhhYVpENXhWOHVpT1VxL0txQ2VTUnpvZWRpM3FHQjFtS2RwRndXdk1xYWhR?=
 =?utf-8?B?OHFaOEtGUkt6K3MzSXZSZFJLYVBwUmUvNWRFZXQ5V1ZSampGZk9xV1F0SGps?=
 =?utf-8?B?TUt1LytQeTBSSEsxSlhHbm9wU0xHZWlBZmF2SDJCUjZRcTlKeHptVFliQ25n?=
 =?utf-8?B?Ujg5WHBNeXR2VGgzYmxjQnZ2aFBVazFVQkxWODdEYmRLRVpOdksvMjRDVEZ6?=
 =?utf-8?B?dVQwdms3N2J6MjdnVVhwYkQyNGVLUERHU1dzVWh6SWhDMnZySWw4YjJqaHhB?=
 =?utf-8?B?TlRLRmpRbGhYM29uUG53a1JkdmxKRWlKRTY5ZVVsQWwyZXBRYUZ5VUx3bWFH?=
 =?utf-8?B?anY4UmlYdE1DUDNEa2lDd3VzZGp4TTNmRkpTVnp3WDVidVJaNFFTS1F6YXpr?=
 =?utf-8?B?elVvSGZ6UFB0Zk96MlliRHNjTEhLbUl1MSsrRTlKdGFQYmRlelNFOVUwQk9M?=
 =?utf-8?B?WFpSWjVzT1MxaWR4S003QjRmb1lSY1dBSld4UEc4S0lJWlJUSEp4dDYycEI4?=
 =?utf-8?B?Uk1XQVJra1RBUWhmRHVkb21FYWdMbkFKSWxZZWNkUzMxeEl1S1FDc2x0WlNP?=
 =?utf-8?B?QVB2Q201cG82UVkyNWVVS2FQSlRCdmZRRmJzYXZMd25vdkl5VjdqZmJ6bkZG?=
 =?utf-8?B?ZFEzTmZVcVhLNno4MGdYN3BZNEtkNk92bUU0K3EvbS9VWUFCeUVvUElVSTAx?=
 =?utf-8?B?U1FETkgrSndOQ2kyUS84UWF6MXFxaGMvVGZ3d2IrdDZhaHI3aDJrOWpmM2RS?=
 =?utf-8?B?SnpBVmZIU05RUHlsMmFDRGxTdkNKNFNzZ09HbU5LZFBSOWJCVlA5MWwrS0sy?=
 =?utf-8?B?K1dPU053ZzZtN1pyQlVhTnJCY0dzQ1RNVWFlVnRBRXU4Y0s0c2RFb2lVZlUr?=
 =?utf-8?B?SFUvTWtEUDNJL3pqTitvek5OZHQrNFJtY1NGYVZUZmVVcms0eldQVTdFemha?=
 =?utf-8?B?TXRHdXpnL1FNU0ZJVmtLVWg1NjJrUDZsRHpGVHVpU09GbUpXWlNvNGVpOW55?=
 =?utf-8?B?dlZidmE4SzV6cUFlL2JXMkhiUG5Xbmk0M3pEbkxDWm9OUXRqdEJVMXQxZkZv?=
 =?utf-8?B?L0RyWnRKUDRoODMvaVlzYjJPd3JQWXpUU2RSVnl4a01TZzhCWkRFUFQ0V3p5?=
 =?utf-8?B?NUdXa3BONGpLYXppMkZ2ZEJpZVRBMU9GOGdvS1lKZXNYVForbVZJYzVHZnF5?=
 =?utf-8?B?V0Q1bmRMbGJEZmtlTkswYWpKTWg1SmE5OW9vQXpKeVlqUHJhRmpzQlhmMDVh?=
 =?utf-8?B?MlJWNEMzM2wxYnQ1MHlUQWkwSnJFQjBQNExxMmI2UTAvMUhsSWpVL1VnY0k2?=
 =?utf-8?B?NnRwcTNLMWJPZG4yTWVORDlPVEFKSGg3VWJSaHVSVldPRkh4YWJtLzh6dHpw?=
 =?utf-8?B?WTcyaURFNWxaeXFJSXVSdHZYelZXOVVNMUdYdHVaTk9HVFB0NkNwUStwVk1Q?=
 =?utf-8?B?cmVwUld0VVBlbGh4WnRRZmhLQjZQU1BwbmJUNEhIaEF2K25VeFFDaFFMMG0v?=
 =?utf-8?B?V2xNQk42UVVOQmlwWW4vYWtOK1hUaU5RcXh0emJyWTJhZEpIakVyUXdyeGdO?=
 =?utf-8?B?TjhHWkNVOUpNdmsxSzRJbWhEOHFBb2NDTmp4c0tVcW5McVExenhXQ2o4SkFW?=
 =?utf-8?B?RGg4LzJEQnNEM1E0eWoycFgvems4YmFDekFMdlA2emxBRDdoaGtUWWVmUHJa?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb696e10-2203-4c63-f466-08dbd5767028
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 16:21:27.8033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7O/vMcFF6GOGVBIvlgZVY6RxaOFHIQExErtk3xW48+lFgpJl2tdNMfalF3PVAAyc6+fiYl/zcvNUxqQ5ZX+jG5QjR8yoRX+vL3CH9LpCmYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7870
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The state of this patch series was set to "Changes Requested", but no 
change was requested in V8 and I addressed the changes requested in V7. 
Am I missing something or is it a mistake?

On 23.10.2023 12:43, Radu Pirea (NXP OSS) wrote:
> This is the MACsec support for TJA11XX PHYs. The MACsec block encrypts
> the ethernet frames on the fly and has no buffering. This operation will
> grow the frames by 32 bytes. If the frames are sent back to back, the
> MACsec block will not have enough room to insert the SecTAG and the ICV
> and the frames will be dropped.
> 
> To mitigate this, the PHY can parse a specific ethertype with some
> padding bytes and replace them with the SecTAG and ICV. These padding
> bytes might be dummy or might contain information about TX SC that must
> be used to encrypt the frame.
> 
> Radu P.
> 
> Radu Pirea (NXP OSS) (7):
>    net: macsec: move sci_to_cpu to macsec header
>    net: macsec: documentation for macsec_context and macsec_ops
>    net: macsec: revert the MAC address if mdo_upd_secy fails
>    net: macsec: introduce mdo_insert_tx_tag
>    net: phy: nxp-c45-tja11xx: add MACsec support
>    net: phy: nxp-c45-tja11xx: add MACsec statistics
>    net: phy: nxp-c45-tja11xx: implement mdo_insert_tx_tag
> 
>   MAINTAINERS                              |    2 +-
>   drivers/net/macsec.c                     |  130 +-
>   drivers/net/netdevsim/macsec.c           |    5 -
>   drivers/net/phy/Kconfig                  |    2 +-
>   drivers/net/phy/Makefile                 |    6 +-
>   drivers/net/phy/nxp-c45-tja11xx-macsec.c | 1724 ++++++++++++++++++++++
>   drivers/net/phy/nxp-c45-tja11xx.c        |   77 +-
>   drivers/net/phy/nxp-c45-tja11xx.h        |   62 +
>   include/net/macsec.h                     |   54 +
>   9 files changed, 2011 insertions(+), 51 deletions(-)
>   create mode 100644 drivers/net/phy/nxp-c45-tja11xx-macsec.c
>   create mode 100644 drivers/net/phy/nxp-c45-tja11xx.h
> 

-- 
Radu P.
