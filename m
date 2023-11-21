Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FED7F29C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbjKUKGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbjKUKFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:05:55 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D950136;
        Tue, 21 Nov 2023 02:05:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnGb6WN+j7J8I2xeHoKUm69DmztFB1DQQzlj78ImUuQC0xQ9UBah354USW/QkVXJIxOsRp/26F443tFmKtFt/D31bW1pBm4oBWOza6mhe7yAOVUmufS5m6pynLisSJ5702qKxQtSlMtQ/13b4TAyw1gLuJsum++95YZk3sXZZwR4UGS8Rfa50DMwi9HMm+uY8v6yPtKSHrlsMAnFmXVYhIh5RAjiOwIeqp7QTaJWWVbJb9DkDX7Nco262zRowPp5UTqj/BQAsUgla94YqwnE3xYIc69pPV+fDTAObzfEJ526fTEvJMebhHuhjCqB9Sk/7/0Lu5t4FbA69qtjBJ48Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTYnnhnpP0p/42phfufQU+vI2ViwzxH7/n/2lKZ3X5Y=;
 b=gm23gTrR3l6RX0dRvYPswD4m31t/+FM/azHYyyVhVrJFPIIr2v6IJDTE9KgPlg7i06yhMXNTgmwVyAtxFUuiTCz19RxV3u2ZTBgSZxH+YQE4uQDD9oNC4JwSTXQTrYx8G1Q/IBvZGoC6KHOKms6+30JfZ57OJkfrlZ17PM1+g/vDkgZXN3co4bZ37w+VGqt9tbkuRUybaBqBL6NPSHi9huv3FOTlLUttE4SUfxt9Mzk11YJYWgA+Y5sO8R7rxlLHbPQ4s9yLdD3fsheZsEfoL5yfOZuk5KVcxt0XL2JLRmCGqf8iB1B7/Ipi7NqiytkHAHsZT17bmq3NK8YYnM41DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTYnnhnpP0p/42phfufQU+vI2ViwzxH7/n/2lKZ3X5Y=;
 b=YAR3enM0qvj0We8zg1qKM3xhlw0iZba11q+rpWXBeHUmrJb0meFej3qdKdfebwgRjZZyvFvUzOXXEadA5Dm0kkGZ0JG2Z/1V8T2dWGq0NqQ3GEOZ2RDEA/520WvSDkYjmKmpbyfTrPbFszLi4zSgoE29w57zrnyHyVnnMbrIyps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS8PR08MB6183.eurprd08.prod.outlook.com (2603:10a6:20b:29e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 10:05:46 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::79a1:5ad6:b221:ad]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::79a1:5ad6:b221:ad%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 10:05:46 +0000
Message-ID: <8853d53a-fc22-4983-bbc0-414ebb481745@wolfvision.net>
Date:   Tue, 21 Nov 2023 11:05:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] media: rockchip: Add a driver for Rockchip's
 camera interface
Content-Language: en-US
To:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com
References: <cover.1700132457.git.mehdi.djait@bootlin.com>
 <db605935ad21c4780b73db87605b52d30bc936a4.1700132457.git.mehdi.djait@bootlin.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <db605935ad21c4780b73db87605b52d30bc936a4.1700132457.git.mehdi.djait@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0038.eurprd09.prod.outlook.com
 (2603:10a6:802:1::27) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS8PR08MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 4312ec1d-82a8-46ef-7516-08dbea796e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adsdB4QOWeaatPid7ZRKZvRcNZJTOsFpYQG8kZQnk8TfSQv+4KtYI1OLGjfL9s8YjI8iPds96maBdk3/tSt01aKaYkY9jcZQpvJ++mr60ut/moeis3pfeC6QICj1gBg7UMUN85cj50JZeSq2MzWJIRcSSXy5uCTPtFybAwIY3MJkDXnw8o6z4kIxUPqpPDZcZyk9VfTLO0raDV3yy9hlzJibYlbGV5wHf6ntdQkNorVwdizb46oaAhMYJF4MRLPR0TAtSuN/TPkSkkaA7N9Ib1kyWft2lai/vjPyGjQ1xl1K2LGLCbFPgzaaEYu4re3QN29mRuAT7Pl9tjZQzPlBKLNEDU+pJ7rnWpyX+TwcvC8TQ9qygbzZWdXn41Z1cr8towR4e31/q336+WcWRcUicH4g5zRYdXrPisbdOoVqB+tJNFTRugVIJLfe0IrsZkTK2OInKvIndHdS7/R9YKD0jgJzVLJaXcgEF/5GkxV9Pjmpy/TQbjJilmn9+bP1jr60qA3R+PLGfyWM2sD1XDzQQF4xiNKn+qxWylDT3pB83d/VTgHbtj/i6SWLDhgUGOI6Z8pRAR/wrDriNkUviy8dhI3a4YEhFdiXhmVzsbGZoe/wm3VmuvHLrkMg4JGQ+bzSkY1fyf3cTzPIbaHEXDBssQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39850400004)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6666004)(2616005)(6512007)(36916002)(66946007)(31686004)(66476007)(66556008)(4326008)(316002)(8676002)(8936002)(478600001)(26005)(6506007)(53546011)(83380400001)(6486002)(38100700002)(44832011)(31696002)(5660300002)(7416002)(2906002)(4744005)(41300700001)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnUvMzNhOGdGYVpBeGhsU1VUcE54Y0RjZFBwTHNYcHFTSVVEMWxQWFIyUWs1?=
 =?utf-8?B?UVd3eENlbDhWWHlKbHFjeVFFRVhibmM4bVVjaFg0S3ZhVDJzbEhBSW5Da28x?=
 =?utf-8?B?ZlJTOTNadU5teUs0WGZQMy9kY1RBeTFOeDJwNDFSelkzenljRzlHTENSa3JI?=
 =?utf-8?B?eU5pc2hPWVJaRGZVZ3gyWkY0eWh0TE5vK0JxcmJJQ1JGcC9GYUNQaVRtZnJM?=
 =?utf-8?B?VE5Cd2JtdWJicFo4amFOb3FnclZ1N3ZrS3NrcHBKWXlmTndqRGlvc1ZnVXRj?=
 =?utf-8?B?TUlCQUJCSjZSTnlMVlNFemRrSWZtNzJQTlNCa1BQNXh1bnNPNEVtTkEzcU96?=
 =?utf-8?B?c3pYdi94VHBpa0srL3k1ZEV4eDR3eEtCeWZzNnVLalk5MnhVaWN2UjBBN0hM?=
 =?utf-8?B?aXVEclhSUWV0Rm5KL1A1aE42ZCtuSzUxNC9DSmxUckw5aXlOUDJxemZ0ZmlG?=
 =?utf-8?B?S254T2hKV0JKaTA2NUJqZDRXMldxNXpSVmIxQXdQVW96NEJwRHZUMmpQY21u?=
 =?utf-8?B?QzYxZ0RlUnovanNUSWw0YUlCdS9uUkpraCtJMEQreUg5REhzZ3RUVDJQL0VI?=
 =?utf-8?B?cjdJR3VNbDl5UkF2dXUxQ25udVIycjc3N3FXajlvWjIxb0lVT3BVb05sdzdj?=
 =?utf-8?B?YjJuWDh4d2p3SEJqUExnb29SVE82dFJKc2VuWms1akFnTmt4YnlrM0gxMlA1?=
 =?utf-8?B?NlQ0UFZ3UlZUQW9ad1FPajUzcUtKb1l3emdzM3JSdVlUQmdUeGRKM1FmaStY?=
 =?utf-8?B?THZ0djFobGZ3TklYc3J4M0o0YmFVNG43Ni81OWQwSjc3TTE4NkNQK21GYXBn?=
 =?utf-8?B?Wkd5blZVcURNTHErcVE3dGhFUVhTOEFlUjdqckVhZk9SQVUzVzZIK0RjTkVV?=
 =?utf-8?B?MExEN1ZWbzE4eTVvUVljenNockFKVlkyR0VUUEdIU2tDcVl2YmlJbDFEWXd0?=
 =?utf-8?B?NUNLUHAzVzhqaGJpbFl1Vi9oL1BER2ZQb1ZJWnNvaDVUZmFQUTBaTXUySXZN?=
 =?utf-8?B?MWJSdW1UNy9KR0RBVlUwbzl3T2NWd2oyajNOWkY2QmR5ckY4dWRXYnVmMi9P?=
 =?utf-8?B?MVRTUnVvbmp0NlRHbk5NZ1VDSVk2MlJDSHRBeGdkVzdiYi82cHBHd3dJV0VP?=
 =?utf-8?B?dS9qQm5uSjBFZzd1T2k0aFhBNU9EbzVFWWw2SVZrcXBKZWRUSWUxVEZONFpG?=
 =?utf-8?B?Z1V1UFNsS1B6L3ZkNDJ1M1ArblU2cXBBY01oZW52MWFhTHQvSnA3Z0tvVFI0?=
 =?utf-8?B?RW5PVTZ5VWVBYWZuUXhGSmNGeFdSbUhxakFsREFoR2lBRytwUGlQOUZ5aDBI?=
 =?utf-8?B?dk4vNnFqNVBSa0NEMGFmMG1FekdwRG56NU5xQXNDOHIwa3lRVGszOE8zandn?=
 =?utf-8?B?eWM1WkMwRzdXSXllTVdxUWJWbXQyNjZyTlRiVDc4b1p0eE5RSjlTYjVJWEtG?=
 =?utf-8?B?SlJSdWdHYUUwOXdxTVk1TGcvbjhOWjgwbEd0amJua1l5UzB5N1N6OUE5b25S?=
 =?utf-8?B?UmI0WEZKYUduSW53K0dUaTZDcGRLTE9tdzllYnZ6ZEFoWmRZaEh3S2N0Z1Q2?=
 =?utf-8?B?OFU3alVoU01qWVJFdXpKdCsvcWJvRzROUWxGRUxTdkVnbkVrOGY1Smg2TjY4?=
 =?utf-8?B?S0xHUUhiVUhxVjFqd0d5WVFRTU1RUTZtR25HeHdWYy9GNFJ0MFFDa3BXOHg5?=
 =?utf-8?B?S1F6Z09xUG03YitONTJ2QjdKenFyMzlMTXM1M1hhQ2R3Z2luZTc4OWdvQU9K?=
 =?utf-8?B?ZnJtOWcvbDhWVlRzZGRZL20zQnpiSlp5cjZMM2Vyb2t2U0hOKzRBdWZQUnNM?=
 =?utf-8?B?R0xqQ3pzNExLcDlXa1N1cytMN0pseXQwcS9XNVkxN1EyQkJsSVp1UlR3QkpT?=
 =?utf-8?B?c3FwelBPTUdtMmhWRVJWNGFSNlZHay9pNG95S1Zzb1VNY2VtUUUrS1VJaEVw?=
 =?utf-8?B?NDFoeVlUMWlmQjVzamVqNktKM0FCcXVNOWNmdGJScEpFMEdUeEE2Wmtnd3hi?=
 =?utf-8?B?Z0tQdkFESFVBM2phRmc4eFEvUnBneTdzbzJZSXB5YlpvZnJ4b2RaWllXRS91?=
 =?utf-8?B?RXZYQ1RlLzFyemlER0p4K3NxTXRlSmRyTkpQYUVmT1BNSnNZTk1lTkpuY1Bz?=
 =?utf-8?B?ZFA3WTI5bWdOeW1POUg3emsyTHFKM2x4YzBqOXBTS3paOUZrZEg1QzYrY3NB?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4312ec1d-82a8-46ef-7516-08dbea796e3a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 10:05:46.5815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbgnDEQIN9/csr0K1fI79HoAbKx6R11DMz2Guuj1Tg8QIwCf3N4G5MJYJnJjWJ4pmlqKc2J2Jp5Ekcp6+LiqUPxAH2afe2Ypvf+R+n2tH9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi,

During testing I found another issue:

On 11/16/23 12:04, Mehdi Djait wrote:
> [...]
> +static int cif_stream_start(struct cif_stream *stream)
> +{
> +	u32 val, mbus_flags, href_pol, vsync_pol, fmt_type,
> +	    xfer_mode = 0;
> +	struct cif_device *cif_dev = stream->cifdev;
> +	struct cif_remote *remote_info = &cif_dev->remote;
> +	int ret;
> +	u32 input_mode;
> +
> +	stream->frame_idx = 0;
> +
> +	fmt_type = stream->cif_fmt_in->fmt_type;
> +	input_mode = (remote_info->std == V4L2_STD_NTSC) ?
> +		      CIF_FORMAT_INPUT_MODE_NTSC :
> +		      CIF_FORMAT_INPUT_MODE_PAL;
> +	mbus_flags = remote_info->mbus.bus.parallel.flags;

remote_info->mbus is accessed here, but where/how is it actually set? It
seems that the struct is actually zero'd.

Best regards,
Michael

> [...]
