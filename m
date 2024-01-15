Return-Path: <linux-kernel+bounces-26521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE3782E2A4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045F9283B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BFB1B5BA;
	Mon, 15 Jan 2024 22:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORG5796793.onmicrosoft.com header.i=@NETORG5796793.onmicrosoft.com header.b="tzasYck1"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15E31B7E1;
	Mon, 15 Jan 2024 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labundy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labundy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTWoNTjeudLY3BrYbuB26Jkqs0FJbbJXZEwxAB2MYbOuYSaU5a7n4g4gUPOE4jUkBY/cAyLJ/crGKBdXw2toaRWhZ0iOCj8/gqra5PSpb2R771S3+PoKzoCtDG/u1cwAVfanY1AQ8E2fxrG4CZF6Mq0IZtc0uuSYwb9rHa3OozbXQh5YAUX8U7eLTkremW0qbsFQJGA1BcUYjmT9wps42zNDJ5b9iMtxVagFnEDLsZVM2bkrV6q5iKcmc+FXe0KZcU4mzWlImRHxHS0xJHUx4/QXGjemTyGMtA1pV27TmisfJyFHyDLFLGhYiRCgtz8dCXyHGL/6pD+bIpnrDvCGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YX4ge0X79Ea3Mf9lDE+FahfR5jXSJp8kMcxhSVNbB2c=;
 b=e9yHgeXcprpAYXCdEgnHu/M6l8pfgnoH5LKLmOhJgfIcyga1oNciVw4fM/1SNUmnS4Dj0QPukZv7H8C90tQ9kBpdgGOVuvsZ+u63rzRm0P5dPvh75DFQZ+EP5r1q0wakQZSC/xXMmmgAcRuQN4z3osaN+1FnTJfDXb2kfgx08O2uQt+4clNnRaT8nWErU1eBF/u1FpXIPC2rXfhwol88EnXvco/hWg2+F7Nv2CBumM8+xL/KcWAHZa3VTpHMhs5Uerl9RVUpQYmtTjnp+5pefsZKWu2pOoeGlDXvHnNWF5XtklFOsX2PLRdU6xFK4LyFc+SlqL6038vtbPMjv9NRaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YX4ge0X79Ea3Mf9lDE+FahfR5jXSJp8kMcxhSVNbB2c=;
 b=tzasYck1osJEcr/P5crrd5a1H09Q0xAH5k77iIbHV/IK70E/PJDTNph9iraNIiuv8EUjRB06wNUTSnfY1wHDxIPJ2tQSTiGj4+7X1EQW1nhOT6wQma73jMZTPsLqFRMQ/tIYZAEpJb4p2gFgTE2BI4drWY+D1m5jWdU8LMNH+Zs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by MW5PR08MB8192.namprd08.prod.outlook.com
 (2603:10b6:303:1c1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Mon, 15 Jan
 2024 22:32:41 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::6438:cab:eaa0:104e]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::6438:cab:eaa0:104e%3]) with mapi id 15.20.7202.017; Mon, 15 Jan 2024
 22:32:40 +0000
Date: Mon, 15 Jan 2024 16:32:36 -0600
From: Jeff LaBundy <jeff@labundy.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: iqs62x: Do not override firmware-name
 $ref
Message-ID: <ZaWyhLcS86Xlw0Vt@nixie71>
References: <20240115182042.1610134-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115182042.1610134-1-krzysztof.kozlowski@linaro.org>
X-ClientProxiedBy: SN6PR2101CA0004.namprd21.prod.outlook.com
 (2603:10b6:805:106::14) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|MW5PR08MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: fac17534-c64c-4ee2-e8b5-08dc1619e1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WcF6ktaCBqBWMmGGSiiPkPZp0zTJJ46LMRMhzl0ezNQAaQ6S9CQWc3hLjCG6R927yI7fdqDVCB7SAZQu3UvaQsZ9cAj3uUkTqV1oumARZc+0b/rF5CUdUNH2NnkvPlJ3qgNvOiGQ3PfoNNX6yjXwAXv1rx2b9QI72A546NxONY2qf45JDpX7P6M434te2PQhJOGNICV0Nia0qLNr0CWZyoW6ZafIZzj0VSfo3XN2O0YJDhcOJUg5tztAKD6lQ2PZJDs7yyh24XCY+NB3QJbyitsgMkNdHdpTuvboAqbmEa38IHyTQ/Bn0TVy2GVAVxLXpavgJzKFUPHTOnYm8svrHt4XYcQIHF/vsyW4UtvnePUrtRQ9sMLYENpQ61JJEaj7/aSmfaMFojadFBmV8D+Fej2IKrJzIezh/Np420A0PL2Whw4Yuu9PFdYBUoU8iWy3tLocPa79Qoqm6VHlVObdDzyKmi+nKunkgDNp/2YORepq6/+P2h1bYQeSEm7uNxu0f8p1iPzfr8PTJ/WOuKoZp8Biu4hB7SYpXAoK9A+0P55tpGqlH7wJe1nm/tF/lAGR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(396003)(366004)(376002)(39830400003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(86362001)(83380400001)(6666004)(9686003)(6512007)(6506007)(6486002)(8676002)(8936002)(4326008)(478600001)(66476007)(54906003)(66556008)(6916009)(26005)(316002)(66946007)(41300700001)(33716001)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jw8eRONuZBzzcMAz4W0IwFb5ZOdJaoQjvi7cCDJv8bvdlOPB0dHEiKLCuh1W?=
 =?us-ascii?Q?T4znowcQURUFNq8ym/T3WlApvX+C80X08m7jNzIan4eQ2EobtYSJ0zkF/4jt?=
 =?us-ascii?Q?3jnztPf1V5bzFl3mis+CQT7SSAIqM8J8pmzuKprremzs2uUh2iKbFuL56+gO?=
 =?us-ascii?Q?42qkiYt6rSKbyVoxE6w4pZHhx6lrdenerZPjXYyMHlxh8qG9HKLTnokMlGX+?=
 =?us-ascii?Q?TFHx240XyhWch7YmQYuB030HsFlpCj8ScsrO8NuleMTgNgSJV2iD/I0RlDIz?=
 =?us-ascii?Q?JwxQotbY/7RG4ZYJ2jLu266QEN8L65kDPisAuiDI9ok2aC396O25dCZsnrHf?=
 =?us-ascii?Q?1zKx4DO/NUzrk0gu717PN7VnqR4cxh/IitW3EvI+R9Wektojd8SHjc0VEefG?=
 =?us-ascii?Q?2qJef7maavQhhWC+lRfzFpVeEEUzSn5MND1IYOzuEWrYX33kB+7HvhyPx7FV?=
 =?us-ascii?Q?6MnZwi3zoGvwpPin8hHTSD99wmwPO17bhPTAk4sZL3S7LqFJg2ThkUpe5u3U?=
 =?us-ascii?Q?nRkVrXFRdpf9YeRq0xbVCVuyA8mwyRidlEqjwqbsbUcMFIo17k8ff9Tgdiio?=
 =?us-ascii?Q?EwbpasguTf9FNdGgrA3NFUdHvkTOpgXbcJ2WT+RjgMM70q+IRp+5SGWNQR0c?=
 =?us-ascii?Q?SNr6ezBCQpSBS0jZJEGB4X4prf+qHBFVl28msCVpHhJVfvHSC5Wv6BI7mBOz?=
 =?us-ascii?Q?qCBPwZIFY5zxH4Vvchx8NK+F0iVHSs1LOZR4C+x89FyBYNRqsv4e375hy+jb?=
 =?us-ascii?Q?Hn8Iyg/oz6UVe2JgaQTZq5mG2Mr/j4iEiE40goVI5EZviWt1iaFZkn0nLvHm?=
 =?us-ascii?Q?N+FTGoa73QbqZgbLZ2KO5Yhs7zaGGe7eDhm2fgXvVTFUsX2N9TxtBiktOeyB?=
 =?us-ascii?Q?GIEGRO+SOkEm2R6WoJPhqQYpvw+0WMQMBvLIoMbmzlaG0ZviYCjM0P7lz9QV?=
 =?us-ascii?Q?a4Hrcg5wIwX23FDsDFYP/TE0Yz73Ssr78FB0u+Ajg4qksCw7I20U7oHsqEyL?=
 =?us-ascii?Q?/GFvx35t+S8cV/FTwG87Y4maP0Oj7VGh/n5psyLAVfmx6vfA5he0juCEQuX0?=
 =?us-ascii?Q?UOuEXToIy6Q4UGgSN0bsE/VWlFCrk631rlym/AxNJCtWINV/+cZACpbm8bSu?=
 =?us-ascii?Q?J4eqaWryrfr0TAn2uBvzN30Z9HJqr3jOyBQltfLSnMQTgEq0Fe/5xfxL7ykc?=
 =?us-ascii?Q?MpCtyrYn+1srPIV754YhM48BVTT3QQx0hTEv1sATIv6Yt3Gm2gY6CpeUi2XX?=
 =?us-ascii?Q?WL/c2Eb5zHJTddGNQCapVRtsaSfYucLSJPlJ/rEU8JTdq6F88BxwA2pdHAwg?=
 =?us-ascii?Q?CJVVNAWmiK6xmudGE+7Rmtzyv6vIS51HBFCAQykraDV7DCgfw8WlxYcNypWa?=
 =?us-ascii?Q?ieYtjS25+BIwm6qI76NaNC23gQ+raxeYm2tDSGnL16unCofzBlJVaHLJVjRK?=
 =?us-ascii?Q?C4poPqRF3FOXf+GirTMpKdonCXPebwolZy/yc+xgxh+TfHOhDSoC9IjBZrZp?=
 =?us-ascii?Q?L3auuqUa2PLQhuqKAycyYz8rLLBfTxfZ1c5Zf7eBlTscMTbGr2u+m5U5sO6k?=
 =?us-ascii?Q?iMljqdcVhnmWllsA4nweb5zckeYJ3sTvxlATl1wt?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac17534-c64c-4ee2-e8b5-08dc1619e1ab
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 22:32:40.4703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yb6mkjOUJ5I6FH14l1xj+ufL0RrY+0vKHKdKe4BnXGWAPMqdDW0PpploFUT2yqiOShHp/WznCpWp+zBN5uyaxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR08MB8192

On Mon, Jan 15, 2024 at 07:20:42PM +0100, Krzysztof Kozlowski wrote:
> dtschema package defines firmware-name as string-array, so individual
> bindings should not make it a string but instead just narrow the number
> of expected firmware file names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Jeff LaBundy <jeff@labundy.com>

> ---
>  Documentation/devicetree/bindings/mfd/iqs62x.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/iqs62x.yaml b/Documentation/devicetree/bindings/mfd/iqs62x.yaml
> index 044cd7542c2b..f438c2374966 100644
> --- a/Documentation/devicetree/bindings/mfd/iqs62x.yaml
> +++ b/Documentation/devicetree/bindings/mfd/iqs62x.yaml
> @@ -31,7 +31,7 @@ properties:
>      maxItems: 1
>  
>    firmware-name:
> -    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
>      description:
>        Specifies the name of the calibration and configuration file selected by
>        the driver. If this property is omitted, the name is chosen based on the
> -- 
> 2.34.1
> 

