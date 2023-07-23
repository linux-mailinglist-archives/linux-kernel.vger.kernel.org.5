Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F64B75E16E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 12:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjGWKhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 06:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWKhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 06:37:53 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5B3186;
        Sun, 23 Jul 2023 03:37:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajTZE3SaSWWx/eksW0o68VGP19s6WW8RXDlBnxrdlAaw+73PkZvJG7zQFHaL/aVfOJq9iWD8dYpuqV01UQyYMWFX0m3OxK2E9AiC8x9cfLeFAhEGhrYzwpkIBBctVgTQfedNqYdUY60GF/GZjikD8h9OStR0MJrCAnKxOK2lhkIYQmj3x4TYByIOzxeAbXQBBnjJBWJ9fZAMGkIw/i3uEkLkxbWIwEoFhKCz/i2LWvUqX+m+2asbgQ08aq+n5AwR3s4Cra/1vzy1vTSyhzRFrGPEigTzObKAI/OXnm4oz+DubzQTha3B+WPkg92aGNSdRDth3Yy2XKFWFB/3QmwMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrJKfva/GzQcjLjxr47XoBIzgzdHA7kgQzr5cOPrHkE=;
 b=IX4UVJdSOyMaAJSCzH2jdD9K46/gMKKH6WMnXm3jJ7CRYK7bFq6FaCePnXxHqwMejwtZ4+8vM1uZ8FdkERisuYej7cl+UQW0rorl1EHIUl4hY8GgsAGYEoY9P1A2npGm+HGnewafEU2oJgPWCiemIwyWDbQ59EeVcw4ZMhfNsCB16fklDhQFzG6nSfGDKF5gaDdX5mrV5U1eIJiKKXs/Mo5kmVZ1aXH79Lrd1YSitbzWxS00emeYY7BuOV1rZHlq5b74QS4ZEmBZ0VRBnTUCkq7YaMBZays0ZaeGGsW8p3ePTprzvYfvMgIuW9NlYlCpgZMF4V2X0R+t9F/yqFyrvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrJKfva/GzQcjLjxr47XoBIzgzdHA7kgQzr5cOPrHkE=;
 b=GgslHDAGK8YSkcJt2t0OxC3g3BnUwdPBNO0yj4hOs0l9MlecYQMNAB7QhOI0zAjUcytOov1RyHjvo4zvTQq05fsZfO9gCXi7eVt5HAh06MfbfAG/VjbAZmkVq2vgqY+9VxNGoMQTmBb1HxvE2IqO8r9bB0eRldD+6zuCnfZ1h8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB9427.eurprd04.prod.outlook.com (2603:10a6:10:369::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sun, 23 Jul
 2023 10:37:46 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b%4]) with mapi id 15.20.6609.031; Sun, 23 Jul 2023
 10:37:46 +0000
Message-ID: <1ab424ee-21a8-9ca4-e792-3222e68e1098@solid-run.com>
Date:   Sun, 23 Jul 2023 12:37:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 4/4] arm64: dts: freescale: Add support for LX2162 SoM
 & Clearfog Board
Content-Language: en-US
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>
References: <20230619090026.22713-1-josua@solid-run.com>
 <20230619090026.22713-5-josua@solid-run.com> <20230718024607.GY9559@dragon>
From:   Josua Mayer <josua@solid-run.com>
In-Reply-To: <20230718024607.GY9559@dragon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::6) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB9PR04MB9427:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4bdfeb-c850-4481-9cb8-08db8b68da91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muB022N9PYYTPiMyPSMsuIv5sBovq5z7C4bBNm3N+wrc2dFPS12e6L8emhhcyRkZSrXxPyE0VRFWOAJ9IGqYjaMcSBYZpSdmj1N2viatnJFAxBaSfYH2TOXOBh0S+DvxKVirZBv70hdxLYbKF18GyNmlbjDA+tTkfI3OoAj16oFAkvTi0OfN235CJRAYffkZ8FO7pvEmtNNj1Gonua5zHF6S+qLa63W+b/QQyiKofuuiPrft5HxT3XG6iYHj/2xGnjZWAr2vCbN3nWW6PzBIfUE65wCVuLTcdrD0qXI/DnS5Ln/dv8sFpLZltaA9RZSX0C9dJAh1GMSH/aCCUaanMjl+s7kYmYzqYVbx1tCCqwvWVOuQuxncwu78nFNgk820e2qUVy/K1iV7OVEfwWpGnscqaJ2/AsbA/adzOQxSXwSkFFv/2L05q319RzgCWfVNFAh9RwLuYHjV0wjdm2X0fE/0NHHdxiqiOh3E9imuZrAB037aALdFXi/bG0/ZwKP3BjsXXY7Nq+OtX7MHPq8H9H/EntZf9+OscclhSuOGnbZaW29xQoQ8EwlOWCkDMWe/Usudoyv/tC/frmtMOHls9oJw4inMO7B78Pdmzhz8x2zZN9a6XU36F25YW41sFxpz14W1khX3eC8gq+eAxfVvGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(396003)(346002)(376002)(136003)(366004)(451199021)(5660300002)(7416002)(316002)(8936002)(8676002)(41300700001)(31686004)(2906002)(66476007)(66556008)(66946007)(26005)(6506007)(38100700002)(83380400001)(31696002)(6512007)(54906003)(86362001)(6486002)(4326008)(6916009)(478600001)(6666004)(2616005)(36756003)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjdvZEE3VDc3TjZLcWhheTRWUUoxYXZJdXAxNG5mY0dhQTVMdDRKaW9NSWR0?=
 =?utf-8?B?WWxjRHVrTUJDN1pMVkMrbklOSHp5WkE5UHAxRzhhZ0NwUzluMWkvTWZab2RP?=
 =?utf-8?B?dU5rY3BZVzZkTmRSM0RPeXdIK2puZjYzWHMyVy9OeHVoUU51a1ZyZkhtcHhJ?=
 =?utf-8?B?NWVVUDRnMmxYTERucFR4OE8vRDdUc3BHT3NlTTR4WHZhZUptL1Y0N01jMVJV?=
 =?utf-8?B?QnhPNXcybXYwaTVFMWw0N2thbHNOSjZ5VnZGSlh0YmxkeE41MG9PNXFoTG95?=
 =?utf-8?B?VnZQL3dCUVMrTUZzeEdUV3djWEV1bzRTN2d4bmhXRks0YjZYNTdzZzJBVkEr?=
 =?utf-8?B?RlUxK3pJdituWWJaQlo5MXZpYk9ZVG1seSt0TXErOWplYS82YWZtdXF0eitz?=
 =?utf-8?B?dkxGWVZhWmh5di9UeEQ0bHlqbW5KVzVNdjVkdEtMaDNyelMzM2JUUlhVeXZ4?=
 =?utf-8?B?RzQrVDlhNmtvNmYyejJPTTY1T3dXbHFjQ2wyZVdsaU92TGZLeVM0SjJhVVcz?=
 =?utf-8?B?YktxRHFuZitpS0IzNzVjV3J5QStidE9QcU0ycjhsbGFtWUZHVjdGMVVpYlBh?=
 =?utf-8?B?K2Z6a080WUZSYy8zWTRqSnlSRDdoeWNQSjZxWDE4Z2ZSaWVqKzdmcmxKSGIz?=
 =?utf-8?B?aTdnZEQ3S2gxMVJxN1BUc2tzMTd4cUNaeVp3dHVmSWJOVzZtVEF0dHQwWHZP?=
 =?utf-8?B?dm11MVN1dGk0RjZ4Z2NDaGNrTFd4TVhwNGJtVm1WRGhMMXBpclZ5aGkwN1FU?=
 =?utf-8?B?VU9EajJFVjVBRSs1VjhneDRYSGNTKzZGUEJ2WXdJYlYwOGliV0pWcXJ4TFps?=
 =?utf-8?B?cUNjNmJCdkNmMUhialRoODVsbSsvajVEOCtnZ1ZBRStIc3A4blllN2JuN2hE?=
 =?utf-8?B?UkV1NDhqTHJUK3kyRWtpK21yakF3R2pXejFOWXNMcFNRbG1lS0VxVUd4c0tN?=
 =?utf-8?B?WmM1bHFWWHAzWWxFWTdpTTh1VUNxYVc1bFNwU0JDQkJlNktlNGtIYmRBY1pN?=
 =?utf-8?B?T0ZzNGRyVTh5TGxFdVFsM0NnMlNDcktxL1doMUlQSjg5MXY3Sno3YUtFZ3Aw?=
 =?utf-8?B?S0QrSHo3VHVjMHNHVnFTQlRnUXBZUkw4U1UvbFhaU05rSFNOUXZBbS9lK0ZP?=
 =?utf-8?B?b3ljUEpGay9XUlJ1cEk0RzJKdzVTTmx6bmtpUTgvb3BhK3B3aVJFdlN4YTZ6?=
 =?utf-8?B?bjFqWTd2WnZiRHRicTdmVzh3UzNyOTFOL044MTlZcWpDcEo2SEY5emlKYkpv?=
 =?utf-8?B?enE3bDRDd0dteVpZVmdYcEcrYTM3SzB5TW0rRUJJRFhFMmoybzIxVERWQkNj?=
 =?utf-8?B?LzRoZGNsMmpXZzROS0UyVEkyYWJkc3lJcE8yVnNuWWRyaG1VMUxQeHNPb3d4?=
 =?utf-8?B?bnNaQTNyNFhpYWdIYXZMdVErYkZCemxwK1kxNjFLUmF2OUp3cDAxbEFaM3hO?=
 =?utf-8?B?VzhIODZ6TFdFMXlXQ2phZ1NyRm92Q1ppQ2tCZmxTbFd6amF0MlkyT0ZUZXZt?=
 =?utf-8?B?V1BuMmI5KzRKTUQyWkxuc3l0eXdwczdvL0QvN1NKTFFtTUtadmFzUEJORXpN?=
 =?utf-8?B?Tm16bno5SlJPblNlTE8vamJKeVlHZU9XR2VGRnZQQlp1UWtKK0Rab3N6TWNP?=
 =?utf-8?B?dW5nWUF4U1BOMmNOVG9BRVgwT0pMb0F3TVBSUndPM2paaVN2b05lOWMwd094?=
 =?utf-8?B?Njk3V21XSmhHMW5wbnNlUVJIK01nZ2NqTWN3TGc4dXFHblhkN3craHVyQng0?=
 =?utf-8?B?TFFqVEJpem1XMGFvQ3hLU1hINXZmckJMTEEyUjhlaFk5enA3RHVRNUlEMTFw?=
 =?utf-8?B?YUo2ekVXK1RUTlg0VjN2UG95MUhtR2ZwRjJ2c1dUcnVVeGtUMGg4RGxiMTI3?=
 =?utf-8?B?MzJvZThEamQyUmlaOFM4WlVSdFlUeGZ5S05RVUo5ZjVkODkyOFM2YXlOL0xP?=
 =?utf-8?B?NjhyOGpKZEJoMzZXTzdVaG5BZkh5VmJjRDIwZGVwaHNSTG53UkJlLzl3YUNz?=
 =?utf-8?B?bVFzY3VlejBVOTVnQUpyeGQvQzcyWS9HN3o5azMrY2NFUXJvOHIraysyc0lR?=
 =?utf-8?B?QVpLU3p1ajhWVjNud0ZVK1hBTTRTUytheHk3MTRGbmZFS2hvcHJJNlJPaEhN?=
 =?utf-8?Q?GHAJPqmA8kRjh4x+QLSHjSr8S?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4bdfeb-c850-4481-9cb8-08db8b68da91
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 10:37:46.4638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: argtSrJmxmcmyCO5fnl8YAfNYy0HVrLN32NYvMu2r8yCciF3D4SFmiYHHWXB6bNPlY/JCGPRtwWshT4BPcTUaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9427
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

Thank you for reviewing.

Note I have added a general question inline below.

Am 18.07.23 um 04:46 schrieb Shawn Guo:
> On Mon, Jun 19, 2023 at 12:00:26PM +0300, Josua Mayer wrote:
>> Add support for the SolidRun LX2162A System on Module (SoM), and the
>> Clearfog evaluation board.

>> +&dpmac11 {
>> +	status = "okay";
> We generally end property list with 'status'.
Okay, I will change the order for v4.
>
> Shawn
>
>> +	phys = <&serdes_2 0>;
>> +	phy-handle = <&ethernet_phy2>;
>> +	phy-connection-type = "sgmii";
>> +};
>> +
>> +&emdio1 {
>> +	/*
>> +	 * SoM has a phy at address 1 connected to SoC Ethernet Controller 1.
>> +	 * It competes for WRIOP MAC17, and no connector has been wired.
>> +	 */
>> +	/delete-node/ ethernet-phy@1;
Perhaps somebody can help here on what is best practice:
As outlined in the comment the SoM includes an ethernet phy at address 
1, which is not used at all by the Clearfog carrier.

What is the best practice for unused but available components?

The phy can still communicate on mdio - just it will never receive rgmii 
signals from ether cpu or carrier.
I am leaning towards just keeping it with status okay, if only for the 
prospect that a smart driver might put it in a power-saving mode.

>> +
>> +	ethernet_phy0: ethernet-phy@8 {
>> +		compatible = "ethernet-phy-ieee802.3-c45";
>> +		reg = <8>;
>> +		max-speed = <1000>;
>> +	};
>> +


- Josua Mayer

