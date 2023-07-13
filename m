Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EF57519B6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjGMHWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbjGMHWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:22:48 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2085.outbound.protection.outlook.com [40.107.8.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7281B10E2;
        Thu, 13 Jul 2023 00:22:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E68Rudp7W383GCZrRRhZ6Ef8MuZ7zXUo5/C7GHZLiCUADI61DzuXLpMmPkjgolc1HWzK7GL/5tBQztn5CXmrXp5O0XdZyxIPt3+gr7Dwrfl/AtSL3eDQL7h0KvY5M2gzlQwq1sefc273iScpQdIIqvgjSBqZ7LIdAEv6Yi1rzCyqDw1fOMGTLjT+100unno8g/nzrxoSgtdI7aa0dP458F/f/ZhRq6Kj9Rnv9XOPnxjkeN/N8n8ZRxfySO/qBEfQKkEZfBYZEy6FUtONUBWqo6B2yXTagw2s7k/mde+RoURcyEIqP2z6yKYVaeqov9FkOGWNnivEIcuxTixhkNQhlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0l4iqRAY39r6CTM1yzHURiFA0976ufCNkUzDY9ZZ/1s=;
 b=iU1p16xxYWcWq7A0pFXuLWdhhTR/nR2je957Fz73rU2GFgXo+iE+s/FYrwt44pTS+CMzvWfsCLXcUt1/hrXCiieQ08YaTXNmQGs8hHqGrfDNFYn1q/HZnOH3ZvDM33+O5UAMTpKrXTZd79XtowWDaLGoI20/O4k2l3d5vo2npBHFJZNLBVzMx7eq7+v4vgn6N6NIrqZjRGFvyYiWHtR8Ufg0Dkar0eQx5YKAUixV+naVnnfRLqnjv7PH9Fhvz0uwlpaweZEF1nzkzWrH0VeB9VuWRqbY1cN5LKCFGEf06UeUY7QUDrrDCES32N8wxgXfR/c0Ii2OAYjrPidE46pcog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l4iqRAY39r6CTM1yzHURiFA0976ufCNkUzDY9ZZ/1s=;
 b=aUI86Kj/f5M8mDLc8GrVF38wRunzHblJ+Q3dMWjyxVIHc34t2kc8XWXH5ND3SPl6y7HqVhpVW6yMSsohYEUlX+AMprELX4ygAKX5YmLZWbdRKUOtxH10SHg0+MhNBMUAUVbM+EN8dXnwBNZbQ1w2FUmBIyilGWrhZskmK1vAvKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8292.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 07:22:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0%3]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 07:22:44 +0000
Message-ID: <64750f16-12d0-66fa-97c7-eb2aac03d017@oss.nxp.com>
Date:   Thu, 13 Jul 2023 15:22:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/3] arm64: dts: imx8qm: add thermal zone and cooling map
To:     Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Li Yang <leoyang.li@nxp.com>, Zhou Peng <eagle.zhou@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     imx@lists.linux.dev
References: <20230712211755.1538847-1-Frank.Li@nxp.com>
 <20230712211755.1538847-2-Frank.Li@nxp.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230712211755.1538847-2-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb16bfd-8ef6-4afa-bac5-08db8371f35f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kzaZnnzXu3fFpmk++axJ0fWq1y3TU0Qo4YCkFbS3YUZiYgiRUYvcosZOpbQ3Uerz949tc731mnVeQUWNEqJOn7Bs0YqweeslFCP5iaYqpqLyMCp+1dExRQ4VN/Q73B5e8/DnDOVp7LK0o+tXCrM1p7XwSfVljHPlmksCsFXJP0LFFNcuxt/XH6l0+d5MreC3df5mepy3qz4G6ZVCASzVJZ5lIZrJhM1Pduj+h8TDYF6vnT58Ugr9JG9GJ/ztinVFYcKgySxzDJgaY3hxIrwYXYrBMcm8tzoLrX8AOoD3G2rcTn9XatM7E9AOZj0Kr+pIMoLrWDEg/oBMxOKWBp2K7joFOfaACJT5s2ioxPSyDPIUihT7Syrd1kC4t7WmqV2BlwmOpCxP6mddg9vOrbEdsSwaHRgQvMaepcGuEnrVq/I1CahRxf0ES9aRlwoO2nb6/6FuCtz2A60YY0rEoBmajIouQ/3lrOq8pAxql1GPuKGEtmpgZyFfFRAP1VUrT/RB+ZWVBdnci9/w+zuGcoBmMlz49MkVLLS93SfRYsgPjn+UQbn63Us2pqTC06LoCVMN5i+albBg9X8eu+rATbiVLtsKirbkbtJqOY0X4ErExfHe/w/aDyKK+1UuJIOHZdP1Qzusfk4G+Tok52rqijSHn+7dA7Ow+c/tfjP2Gt9sDdCJxT2YOMRWLYgJXCJchmd0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(110136005)(316002)(6666004)(186003)(66946007)(4326008)(31686004)(6486002)(66556008)(66476007)(478600001)(41300700001)(6512007)(8676002)(8936002)(53546011)(7416002)(6506007)(86362001)(31696002)(26005)(5660300002)(44832011)(558084003)(921005)(2616005)(2906002)(38100700002)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE55Si8xb2ltVUtDME1jSkxPdmVRMHprSmlINHV2ZDRaeDZ4eFRFOVhmUzl6?=
 =?utf-8?B?UGhLei9zUHBkUDRiUnUzWDA4ZlJhdmlyZW9zd2YrUFVYSVFJNEVOdE9wSkJY?=
 =?utf-8?B?ZVRwOHhWbEdZdk5TQ2JWY3h6WUtoYkJsSENMT0NUQk41Nm1RWGRkRk5aV2Zr?=
 =?utf-8?B?RjFpbCs2Q3ZDSnM2cnpnYnFWRERxMFpQSXBYdWdnenN6SERGeG9pZyt2S0t0?=
 =?utf-8?B?NExxRVJKQVV2QTU5TVZMbUJRZU42VEd5a1RnVjRYVWkxTVNKZlFJd2UyNUs1?=
 =?utf-8?B?L3BINE43d3QyMktlRnBCbjg4c2N2SCtMNFR4Q3ZJbTdiY1MzMlFTODU5Tk1B?=
 =?utf-8?B?WnVZd2I2aTFYVXJwTGRsTVRCMmFtNDlRU3I4T1N5bFpXS1lhNXN2K01FNHNt?=
 =?utf-8?B?MFBFWFFlNjJxcUQyUzd2MTM4RUxOQUR1OUhRSFBQcUp0NmdWNS8rMmxaTHNr?=
 =?utf-8?B?NDl3My80N0lHSzB2cVRhTWJuWTViU2QwbWNCYmVPU04xczh0YnJ5YmJaZHM1?=
 =?utf-8?B?L1RjdmVEdTVQVzJSeXpiN2ZMVEJxSlcrYjg4eER3bHRzQ2FUQW1FcEFqN0pM?=
 =?utf-8?B?ZHEzSlA2Y3lnank4TTZsQlY3Q2w2N2RGR2N6VkxaN0NNbmhyTlRmZmd1blF4?=
 =?utf-8?B?cXVLQlR3eFVrWXYvMWttREVVbi8wZ2Z1bzhWRnVLcmFJOHdqR3Y1am1Pem5I?=
 =?utf-8?B?aXNyMTAvcUljZ0c2b3U1eE5vYWpnTXc3T29mNjNuZUNhTjVCK3YzU2tlTEc5?=
 =?utf-8?B?NU01M3JXWVNsOTVWLzB4Q3IyVWIxWmNYTTdsRXlwSEwxRUNjQmJDZG5oL05y?=
 =?utf-8?B?MEo5NDh3SWpBelZCV29zOXgyMkJ1a2NoSnZOWkU1cW9yWU5QSlEzYTVsdHRJ?=
 =?utf-8?B?aVFxU2doNFR6ZlJOQWRhNHpNdk1JSmV3ZXhlaVlaVWVIUGxHeHQwZURBb1Y2?=
 =?utf-8?B?RmZpeDBBZjRWeHpkZzRGNWxFSnhBMEZucGpvMUUrYTdBUTlpK1ZBWENSckla?=
 =?utf-8?B?Rk5ROUlhKytadnVZMnNZcTlOSWZqZnJZdms0L0xWU3pQWFF0VXBQdzNTbmx0?=
 =?utf-8?B?M3dLaVAwM2twMVFhY2srYUVsYXZWU1NVbTlHWkZQS3dJK1BJQjFaUW00UVVp?=
 =?utf-8?B?RU4zRzFVcU5rQ2FwK2ZGNUdQcWVvTnhZaFRTUjJQVk42MHo1OCtnL09sLzdD?=
 =?utf-8?B?ejMwN3JpVDY3UnY2ZkYzK3dzZ1pBRzlmU1dLZ1cveGJXL0FXWVhDRFdwQnhU?=
 =?utf-8?B?VFloL1pkdmhrZks1NEh0N2c0N0dlL2RleWdBdFhzd200SzlUZUdMTUZzLzMy?=
 =?utf-8?B?bWN3SzA3akFzQlh3OWNVSk5HR2VUWnEzandONFl5TWlqb3JqbFliWElqZVNi?=
 =?utf-8?B?WE42WVBGbWlDWG5lQlNSWUJVeUJZRk8wUXk2NWdiZEIzTnd2VGFXcE84Zy9r?=
 =?utf-8?B?M0J1Y2ZHVzJIWkZnQ2ZwVC8ydlFlUkxFZURGOEFDeUxsUnV1bStaV0F5bkJE?=
 =?utf-8?B?M1JwYlZSNm8yZmEvRzFWbGQ4cnNIQVdQZE43bStZRkMySUtkSG1vK1RIVGF0?=
 =?utf-8?B?Vit2WjNRT0w3cmI1OGFNM1lYZTltRlREVmRUYUVWc2FRMkZDeGR2QVVYMW85?=
 =?utf-8?B?NVdNSU1Ua25zREN4VXIxTXNWOUkwN1I0RG5wazJmK21ueTJ5YkxjZ21BREVl?=
 =?utf-8?B?MS9SNTI5ZUkwTXU1RXlRVlFYVkZHRDFSYnd0eEtWL0FDcWU2L1hvSzlRZTlp?=
 =?utf-8?B?eXZzNytlaVVtU0pLeFNYWWI5NjYxS0hYdGszZi91Mkhsb1V0OXM0bndXbFBO?=
 =?utf-8?B?ZEZCd1hOWU51b0RiRldaS2Z1bHhwcDAwdFVETFVTbFFqVzJ5aStTRVZFSjBa?=
 =?utf-8?B?OEx0NHJqRHkwRTBQNWFib2pMMWZzdkh3QlM2bFREWmpFKzFUdVZhdVJzUWtn?=
 =?utf-8?B?QVd2YVNnZlZodWRGa2szc05ZRFc2RmJRK3JFV0ZpajZ3TkpZSWp4dmNreDZP?=
 =?utf-8?B?NUZCMlNUSUNiOFRkVlV3empzbzErMTJTTitKdGdadUM5cXFoZU43QW9HUGFy?=
 =?utf-8?B?N240WXlmZjZlNURIcmpNVzdhQlN3US80NWlzWEVCUERURXhmMEVpd3VabjQ0?=
 =?utf-8?Q?a16Nw0QapYUKdSr4teYc5YgRx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb16bfd-8ef6-4afa-bac5-08db8371f35f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 07:22:44.3390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPG/wFjh0PZLeCs75owAuDqToSOcaM4tYLjuhNoJvKW/Z8iWmFK64JYPvItqbKUCKNeQ0kO4d42Ii2ZN6iqDLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8292
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/2023 5:17 AM, Frank Li wrote:
> Add thermal zone and cooling map for cpufreq.
> 
> Signed-off-by: Frank Li<Frank.Li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
