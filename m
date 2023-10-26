Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CE17D7BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjJZFFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjJZFFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:05:53 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1C3C0;
        Wed, 25 Oct 2023 22:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jF28Ye2/YnbrmPGZXee3EEDUm7a/94jc0XbXk1cGv2sjuNLUJmdl5TCrKz5aoW9GwNwfJtdOgyr3cx7MkUjZQEP7PQK5HeaOaic4ozUkcOAjp0918lIK2qdKSMNqE4exHYFcKGvREj8SyaU0RvKdlNFbPT4YB+xbnWgUzhu3SWcTkowyUqIWryqrsG9Zbpn0s0jtPLFgbjqQkVhU3vbUXzdZdzNqvaxiEGYXsBPtu6+IAUEovlIdhU+GmuCU6PLKfhwOtXZWrZkBDD6LZYFsV8ScEeavTx0cfX9P19vfb0sYNi7rPnqMhPMZge2bLvw0twoWDBoUHLPgt7ksRVEfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9UMvam7+B+LUAuhSE3s65x1hLkQzQzJ1ArzQxfcSUE=;
 b=aCk4lKW3moQu+r0KFiLNAfnuZQ9WFVg+zQfhmGr2ACZPl4aqLYe1ueYuw0IVl0iaSEOwP9LpygXvikilLY7ynnKbF/+o6Hqpe4BF5WOyV0/swMQO5HEBEb0/ttAwi2IxxDUNre/ck2XCY6Ql3fAHsTw/xKEg8X1/UDZNCkGUXnu7KXlH+IBmIVVVi7CJX63xQbTP+o4qdgyd2UmHcXVCDeMdzxODnNSMKGGZBqQdgcYsMly6horVscTP7QdEDTscK+gurkeKuOJ3boweCtiCEu7tvGAttN6z1hy6G9iRKZVlxDkoW9NVxXTUyVx1DIVKdos9sGk4vQETbT0sTaerew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9UMvam7+B+LUAuhSE3s65x1hLkQzQzJ1ArzQxfcSUE=;
 b=bTLcYM7RVdiUkj7jPGufaegf2Js1uGvcU4XE5ntRpEBzA4/jRkguD5X6uyFGACouCIq9rUwfm06IsckquDrrVMGk18q3Lit66X3YRDktR7AhfuHinjKQTHIThVDxu6pHCzBefqlLdZBOfqyYAcH9PJosu6zrzevcB5+5asFfFuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SJ2PR08MB9733.namprd08.prod.outlook.com
 (2603:10b6:a03:595::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 05:05:47 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 05:05:46 +0000
Date:   Thu, 26 Oct 2023 00:05:38 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/4] Input: add core support for Goodix Berlin
 Touchscreen IC
Message-ID: <ZTnzorJ4h1zva1AZ@nixie71>
References: <20231023-topic-goodix-berlin-upstream-initial-v10-0-88eec2e51c0b@linaro.org>
 <20231023-topic-goodix-berlin-upstream-initial-v10-2-88eec2e51c0b@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-topic-goodix-berlin-upstream-initial-v10-2-88eec2e51c0b@linaro.org>
X-ClientProxiedBy: SA0PR11CA0055.namprd11.prod.outlook.com
 (2603:10b6:806:d0::30) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SJ2PR08MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: 679ab71d-1b89-4a7e-8c1a-08dbd5e13575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tavrz9WoShLkmsE5s3NGpRw3gjcVcpR7svPy1nRAHVJkG4FyPefDC9+oXd+2iav9Li2vf3dTpuLuFYnotUNPlX+Ambguq2zL8umt5Ebe3JrsiPEp8SA/iRtfMa2nDLoO+7z4NloB1f3KGn860jDaNU00g6YOb9q8QlG+JgtUhYztdZjV8sOk5+XzzhlIs6sMK9Hqsz35uwZwE2YLDJ6gsagKCg5KPuZcp7GDP+l6GQMwSKSWHXZENzpeCYUXkpsnrupT0uYyqDdEISg6ynSRpjXiXrf6n2PfJa8HK0A8ybjTkRfszr5HL2xyTUZJgwOt30Ujkv0YYr0bUASNmXYQVPhSxsK1e5KQEJfOtEwwYAqHgV5Nh3v97ocGvVjoTJ4YKyvtBBs6FH2W3KWzTexQmwsrXtSMwUWALdSaedieqWmEI/UqVtTFAVZ2AUD0styV7cSFm58fNLZfGm0FDqZ5vtHe8FqjNzHHIqTmaXX/CZHR4VDkwJH6S0u1M+jveOrbBLiIHknIgghWv1fL0TaD+NjgW8M7tT7/1gbhAC6Zp5YXsyoKmqLjHsICr5LA5Kac
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(376002)(136003)(39830400003)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(9686003)(2906002)(5660300002)(6486002)(6506007)(6512007)(26005)(66476007)(33716001)(86362001)(6666004)(6916009)(83380400001)(38100700002)(66556008)(54906003)(66946007)(7416002)(41300700001)(316002)(8676002)(8936002)(4326008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?174U4m24dsW3WTSh1wypAAnh8B3JPWwldXA+mXGA+uVOt2tZN4cbemStE+Mj?=
 =?us-ascii?Q?f3gJRCEvi1HirgYE7oBCQHUDEmC0F6/kPO3kToFDRFb4/uVC5m/IKyqABggM?=
 =?us-ascii?Q?vK5sov2cKfXGlljp9XmU5wKepEQwK0p+DMtvhhjhJAPIZVq1CmtRBT5dxTZ8?=
 =?us-ascii?Q?il3vqFCyqfQ/LvRNX3OJCQr4b/f1+EqZv9u5SnSugwRMHkALnKqNFiNEITap?=
 =?us-ascii?Q?yAva3A0Bmb4HRJQTuKb0/zeyTftK0Ywcntkheq65Izj4mQXSwUnlOfIcY9db?=
 =?us-ascii?Q?OuBIzrTDFba2+0GfouzSM+JFoGYV6HwLl7QCsg0/8QXTvYacpiHb179QMEvt?=
 =?us-ascii?Q?qEcsv1g5ppbVt4tj+U2caEAqxWEnMBCnn2I8j//AP9nd60/5naYl/dAi/8+u?=
 =?us-ascii?Q?vO3w++bZPYZAdks4+xj96IzvWtmAwz5CsrYrJwMP5UvQA00WxecFkqEF8J/5?=
 =?us-ascii?Q?l6MSIa86ow5I7xo8xrVsLn4EkSdoqfG4NScGkjJmH6GSU1rFeOfjwAMlojB5?=
 =?us-ascii?Q?4t0tIJMch4jTQlL0L7PkyE2MRAtmkk79x9RuWEd6bDp8RJ2C128hPLd8rvtx?=
 =?us-ascii?Q?cwBa3tlxUNms2/Hpg/cPFkvqK6WdM2s36HGrLEheE2UjEp3HkyfJ05ZHq9Ji?=
 =?us-ascii?Q?8ismlShJ2/+MRpffLl1YzzBkWwcS7izMEqbressjPANIlvxE3+3jG9eB3Nax?=
 =?us-ascii?Q?PoT8ZpiVhvogci8x86dlLsG0zp5IDehspb4zKlpdz0QBEZEIIQPun6G1UBb6?=
 =?us-ascii?Q?zSOMnq4WbMrhaAWctlzww+R9w+T7d+qRF/c8R4glxI5an+gmwxRXuWI4FR08?=
 =?us-ascii?Q?ilEY/6uCUX+VARXN+/SZWKauFUGWlqcOWYPuAiY4liCTUNmFcdNsK5gfgMdy?=
 =?us-ascii?Q?y6uW2ww/Mm4wIYUUsBGnbNzFHG4c7T8luZkEOg98YYEiIbCIk/P6/FYIAlSQ?=
 =?us-ascii?Q?V/AEZ2uIV8QlGb/WTXAULVytOG6NarSX2P1nO4GA/KFgaFBN9lLYgpz7bHmI?=
 =?us-ascii?Q?ziuP3NSaYSk6xXnwS5U1ydntPGvOI3iWfeT3IgfWRm+fh8ffUM2eHS97i+Fl?=
 =?us-ascii?Q?LRNj/ukmX0hdNrUE6OOTFdCWA0SGFzeBhuyrOIqokBbBPrbFH+6uSwn3DYaA?=
 =?us-ascii?Q?z/V7/6X+aw/RXbj3uC1r+eHo8jK6aGv8++XRuqvu1mbLA5bfhXa3NX1CpOAi?=
 =?us-ascii?Q?Gk+d6N8F0BzWgmADY92DegMPm7mS2BVvw9alPBeXMtzUkadrkSLvb8f/EGly?=
 =?us-ascii?Q?Q1I6FpN9rqTMrmvGx2I2ybtMWQ7qStTK0u8KdSgEI1Nzl+Htss9/5vZs6Ako?=
 =?us-ascii?Q?Q2WriS09oJVGZhLawHXDDGI1GfASFB1M4QqA2z8NihVrKFP6DkGkEyWXQdZa?=
 =?us-ascii?Q?f50LQRtDuMKRreHlIaIWNzp8cIm/+wrmB3SaoXd/8jQWFcY5bqlTqqXzaj/l?=
 =?us-ascii?Q?HkjS/pJpzTh2RoLAzs8p8HOGTzeZAN5wOEyGs/PTQSULyy02b7S9HoJXLjL/?=
 =?us-ascii?Q?fkFfIUw5u9fpqeb+5aHRN61WWnXqCFKaq7Z34huGoXwDWFI5jKoAGlxLFHBR?=
 =?us-ascii?Q?9qbw3rxMrl5MXAV/tKvKF43vaqvrNhI4MxdfotAm?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679ab71d-1b89-4a7e-8c1a-08dbd5e13575
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 05:05:44.5630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XTfKtEFoFrk7yOOuBvpDtlU7PdKYvHe1IEiXg+p54nBFdh5yG6tqPra4PzfoXgzknByCXAzIfOPFk2IQ2qsbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR08MB9733
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Oct 23, 2023 at 05:03:46PM +0200, Neil Armstrong wrote:

[...]

> +static int goodix_berlin_get_ic_info(struct goodix_berlin_core *cd)
> +{
> +	__le16 length_raw;
> +	u8 *afe_data;
> +	u16 length;
> +	int error;
> +
> +	afe_data = kzalloc(GOODIX_BERLIN_IC_INFO_MAX_LEN, GFP_KERNEL);
> +	if (!afe_data)
> +		return -ENOMEM;
> +
> +	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_IC_INFO_ADDR,
> +				&length_raw, sizeof(length_raw));
> +	if (error) {
> +		dev_info(cd->dev, "failed get ic info length, %d\n", error);

This should be dev_err().

> +		goto free_afe_data;
> +	}
> +
> +	length = le16_to_cpu(length_raw);
> +	if (length >= GOODIX_BERLIN_IC_INFO_MAX_LEN) {
> +		dev_info(cd->dev, "invalid ic info length %d\n", length);

And here.

> +		error = -EINVAL;
> +		goto free_afe_data;
> +	}
> +
> +	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_IC_INFO_ADDR,
> +				afe_data, length);
> +	if (error) {
> +		dev_info(cd->dev, "failed get ic info data, %d\n", error);
> +		return error;
> +		goto free_afe_data;
> +	}

This return statement is left over from v9; the print should also be dev_err().

> +
> +	/* check whether the data is valid (ex. bus default values) */
> +	if (goodix_berlin_is_dummy_data(cd, afe_data, length)) {
> +		dev_err(cd->dev, "fw info data invalid\n");
> +		error = -EINVAL;
> +		goto free_afe_data;
> +	}
> +
> +	if (!goodix_berlin_checksum_valid(afe_data, length)) {
> +		dev_info(cd->dev, "fw info checksum error\n");

And here.

> +		error = -EINVAL;
> +		goto free_afe_data;
> +	}
> +
> +	error = goodix_berlin_convert_ic_info(cd, afe_data, length);
> +	if (error)
> +		goto free_afe_data;
> +
> +	/* check some key info */
> +	if (!cd->touch_data_addr) {
> +		dev_err(cd->dev, "touch_data_addr is null\n");
> +		error = -EINVAL;
> +		goto free_afe_data;
> +	}
> +
> +	return 0;
> +
> +free_afe_data:
> +	kfree(afe_data);
> +
> +	return error;
> +}

[...]

> +static int goodix_berlin_request_handle_reset(struct goodix_berlin_core *cd)
> +{
> +	gpiod_set_value(cd->reset_gpio, 1);
> +	usleep_range(2000, 2100);
> +	gpiod_set_value(cd->reset_gpio, 0);

I see that now, this function is only called if the reset GPIO is defined,
but there used to be another msleep() here that has since been dropped. Is
that intentional?

> +
> +	return 0;
> +}

Kind regards,
Jeff LaBundy
