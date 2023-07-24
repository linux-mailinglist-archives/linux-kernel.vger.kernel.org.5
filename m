Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC1E75FA0F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjGXOmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGXOmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:42:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2125.outbound.protection.outlook.com [40.107.244.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA5B127;
        Mon, 24 Jul 2023 07:42:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqAvAYkb7/A10BJjfDEqo431P25uj/BoAoECNsvkuzN7zdkTAspPPH/1bNtPaPUUyX2xt2y/b6MpDjzT59W67nHrQ+IlUraCdSTphTDnTd9EyVpw3fYu7v8J0OiyrKPE/BqX1e7jLWS+6EDzG4AUTlMgXBMjRDcKKTu8kA2f6nrq6M2HzZ7b3Ut/Pur10wddiAVfwll0cwnp5g1aNnqxbZPitb3IYIyRh6M/nh3LZwiq40fd2KmqPtfz4MlbOzNaWHDmb2y0XjctNV6NeoJsSLU+fnOPy0Ljnvzdh1RgW3Qj6PwbAjcOuOtvwsDVGWmE3fF2eQe1VvDIzXPH6QxX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuftDA3ep9gS8FiU8YVKgI+yWILx47lTztSbUuNfj8s=;
 b=AJU9pWaWKoOBdJFzg45CmClUy7a4otWM6BdW25eTRNRmsxzON+YVUBGe86ReuCbgXuZTnm1kTYoTVWxeBLWXvTuXCj//kMD/NNKJ9cosuXawHfBWOpHctDJKrsZfatV5rSO1C/eCS54CgvisuYoVPbOMPdVrUrOSxxEIun08/mz53fvjRgs+DDINjeIg7cl/j2V5vVR7OFq0nteTeiGhYgUz+DEJseViSxFW1sqe0iWV6eQ6SfIjwRoivOubrnyp5DsDUtA0eLjEofYI0ktovB27F7lm9/AxmMuhtJUt35N4yY0KDi9puroZyagviIgMXk7i8NBrSrKN2zqI6Nk9WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuftDA3ep9gS8FiU8YVKgI+yWILx47lTztSbUuNfj8s=;
 b=Ho8jpUReVmn7FXnJxxXLM8vqSb3MQ+Bfe1nQo6fm6aIhN3OLHBo3K4XqOgUHtwYTmlqg+kmuAyJ9DXQYTX7oe50pVEnXWD18aJUEfeWNQTDb/DYaqzbfBCNas1kvYhVjScQpxZK0GVNRq3sESFqTbHgXRcsziHzOea50NCk6fQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH8PR13MB6184.namprd13.prod.outlook.com (2603:10b6:510:25b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 24 Jul
 2023 14:42:04 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 14:42:04 +0000
Date:   Mon, 24 Jul 2023 16:41:57 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/5] net: hpe: Add GXP UMAC MDIO
Message-ID: <ZL6Ntazi84za5YX+@corigine.com>
References: <20230721212044.59666-1-nick.hawkins@hpe.com>
 <20230721212044.59666-3-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721212044.59666-3-nick.hawkins@hpe.com>
X-ClientProxiedBy: AM0PR01CA0134.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::39) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH8PR13MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 866ba56a-6c07-47d0-e388-08db8c5425d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U64Qz9QntesZ+rAt0nvsZf7z5RByEYD5Ths6OZrn+eVG5FMZeQvMLXaaHM0mzmDSzNqnFIALGQrhhYB1TqtiouxOVuQx20UivVgeaaJr9d99CsgI13aJX2lBCm2JFMC4KJh2oeZl7OebY27+gwIQso1ivNTucCSrvjaLR6X6hrXXyNzn/HtLk6SZudxwSZ1bH+fxgyzhIW0IBMMY+NgNhEL7vBnpGn/5czsmOp3g7klPXfsrEHv7SaUiDEM8JEuFjM1WsfjJTb9ld4wy2cSLYWy3hyDnhdBX5Q1OAndO8FinSbGR6xNjyNcZRpOmasLmSPIuoXAi0HfmavhCjWa/aX3FUIeuZWbC4OY2utEJxt0IrxxZuNMwSnjWHKJALHMIGI7rofwn4BcvT5QjY10CTBrKw6SgMNjNlRfT9WLdSTBKYN9goM2V7rhPWLA0Nr1bRuueU1j564xWU7RmQvFE6snnG2V6/I5vIQKBimVyFAtHX3LgRC1iBvW+IW+/LrNi1Aeg//k0+M87wCZ8gwBOglAZiNcvCAhvehoK/UVYTWlP2IAtNKZQ5KCeCxQ1hQpwEdy9KotbNTTKvbvJiagTQPzp+Z7nm5m+2xjBmVQavA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39840400004)(136003)(396003)(376002)(451199021)(478600001)(6666004)(186003)(2616005)(6506007)(6512007)(4326008)(2906002)(86362001)(41300700001)(5660300002)(6486002)(66556008)(296002)(6916009)(36756003)(66946007)(7416002)(8936002)(66476007)(44832011)(316002)(38100700002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EntDJg4asg3y6SQLEtqaPVEPgUTS/L0AlJ5lnSjFMvjSshXQk9LfHg+i+6hT?=
 =?us-ascii?Q?TdwmdAkc0kALh+I8B4G53O4CvHN6G8zB+eCNo+aO3r1Jmpam5AmeoEa9cfTc?=
 =?us-ascii?Q?2cUR+6TPfApSix9l6NUlkMyKCDCfTx5JxDjPoAQcqm3v941XCj/BuOtnpbqw?=
 =?us-ascii?Q?ieB8kZHZiO1p7Q91+84OoNHidDt30Lc74CpqzPmZMW94Ld24Hc2HnKR/2y9c?=
 =?us-ascii?Q?o6dVsxNJQxLHsdXRX8uCaqwFjISxojsiN+luTAjkOHA/dX0I9ZvanlvUrVH3?=
 =?us-ascii?Q?FtvdreXsBszDYuSX5WN6F1komK5T8VHEP+JJ1ZZNfGVdKqvpETg9dAMsF8ZK?=
 =?us-ascii?Q?4yDCP6Ne4g4mpxlYa/cE1y6P2GlCQi9SfExnsYY4Qdx16bJ/IVXQH508jUFM?=
 =?us-ascii?Q?FrOk04N8ZZ2PCG3B+36nRLgzlBGG9jMG9Fk/to96odV4ts2l12WXKvyAh4KB?=
 =?us-ascii?Q?xX5Md16vF07Bzty5jz2If1iO4mJsgGJrg/Xuv2qv84K7r4OpjFC58DzdAnD2?=
 =?us-ascii?Q?sh/7Md9FOi8wbaVyPsTHQdCi2IjxLk1fwfuX3SGCxIAIoWKzjwtx9pov9V5E?=
 =?us-ascii?Q?BOIAkUdc71e8hzp2eQcVzsw3nhhmoCoEzspe2Gcz/Ho8zxN/8Wi5Wf9IMDd4?=
 =?us-ascii?Q?yj9bGuSqZ7F1R/vTiymsm4Ti+XZpU98OREIgxty+vSKBmkdX5S1rHmo4zhjk?=
 =?us-ascii?Q?rMtgYUqwOFV34W2khGXxlQYD/iZhBadVOemuejpPTX1LGMCT+kbOirwS6/w0?=
 =?us-ascii?Q?2QCivdOyMrx78Am3sxmAQ2juKU54MvjrhsQOSMo6zpBb/QDUIjPNSt953n8t?=
 =?us-ascii?Q?RPC+nMRbQSc7foJNQU5pDbZzXCBXdn9xdqHWwpj8r5FJUtdIYPmUw6l6/pUd?=
 =?us-ascii?Q?1aYtCtceW02Lntg7jF348tP4r4H6/zNIdZejGGesWfm1vri1ijvKPtv3Yc2P?=
 =?us-ascii?Q?JiGXd6qcQjXtPqoIgYth30jIeo1H17Zvl69OmQ2ALglRqBp0xtThT447m/5u?=
 =?us-ascii?Q?auFGkej3dntze72jghwj3RAsJ/hx4WgySxO/EqawYaVWN6X3JmHfq2UrLI28?=
 =?us-ascii?Q?fbSgR05kNm+PQkIOOwnd8d/ywt1HH8dg9Y2Hb8wKte4d4yEJ8hRaqz3aG+HM?=
 =?us-ascii?Q?YuI2mK1/fDtPSCRs7LjNbi4KfKFBxeFoH32OtLuPjbLDxb5YSavxFWOEOfO7?=
 =?us-ascii?Q?zdOrJLo148ceS7l9+wzLV6LOjQhsjgfxO35gS5O+hfJbUBjJDePUOs0JioKt?=
 =?us-ascii?Q?1wFWoVsLygfbDkAI2QY2Mho8KBwd7RW8QKpUXWBbtBXLWjr2TXj/mT0Arwgx?=
 =?us-ascii?Q?eV6wfPSijIhxSTJ1JsGVn/cCVT3e5XtJ/1LmOlCe7PtmdHwKKVX3i2emAaci?=
 =?us-ascii?Q?OkGioAfdWVBgPXEBeq9jkZ8BNW8i37e3ouz9W/uv4GsOBqMRT5Tj5e09StDH?=
 =?us-ascii?Q?hsLt9Wznm28VT+gES67YPJlE3CO5aGt1MGMrEasogPdtGrKmIKNgGHBOaMZQ?=
 =?us-ascii?Q?5aoGUo8PmN1W8jgK2a/0IfewUZZ3lhcq6OWAZgJRHmOUhXXuPzZWpP6/BA1U?=
 =?us-ascii?Q?CmJrzhABz7WaV/Z1zJYd7oXVrXuF8GKdJKhnIzVVBYAnemXkGG1hMgsZ2Hi6?=
 =?us-ascii?Q?7kJOwY0Nhwb38C1OUJHml42s7P0uTX79QZTtLJde22wobfXvCp6Sta4DZGBU?=
 =?us-ascii?Q?PU6RMQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866ba56a-6c07-47d0-e388-08db8c5425d1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 14:42:04.4106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxxeCqF/oMzfyccTjJRsJkwcHBGT327y9ZSw5x1JHLJbwIbHt96+T/E4JCsHoDvSNS9qkterTBb/88rmbE8lZQeVKX9RRfU0pY8iKqsMjSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR13MB6184
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 04:20:41PM -0500, nick.hawkins@hpe.com wrote:

...

Hi Nick,

> +static int umac_mdio_read(struct mii_bus *bus, int phy_id, int reg)
> +{
> +	struct umac_mdio_priv *umac_mdio = bus->priv;
> +	unsigned int value;
> +	unsigned int status;

Please use reverse xmas tree - longest line to shortest - for
local variable declarations in new Networking code.

...

> +static int umac_mdio_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct mii_bus *bus;
> +	struct umac_mdio_priv *umac_mdio;

Ditto.

> +
> +	int ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "fail to get resource\n");
> +		return -ENODEV;
> +	}
> +
> +	bus = devm_mdiobus_alloc_size(&pdev->dev,
> +				      sizeof(struct umac_mdio_priv));
> +	if (!bus) {
> +		dev_err(&pdev->dev, "failed to alloc mii bus\n");
> +		return -ENOMEM;
> +	}
> +
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(&pdev->dev));
> +
> +	bus->name	= dev_name(&pdev->dev);
> +	bus->read	= umac_mdio_read,
> +	bus->write	= umac_mdio_write,

Should the comas (',') on the two lines above be semicolons (';') ?

> +	bus->parent	= &pdev->dev;
> +	umac_mdio = bus->priv;
> +	umac_mdio->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (!umac_mdio->base) {
> +		dev_err(&pdev->dev, "failed to do ioremap\n");
> +		return -ENODEV;
> +	}
> +
> +	platform_set_drvdata(pdev, umac_mdio);
> +
> +	ret = of_mdiobus_register(bus, pdev->dev.of_node);
> +
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Cannot register MDIO bus (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}

...
