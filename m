Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6962E7E2995
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjKFQSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjKFQSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:18:03 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EE7D42;
        Mon,  6 Nov 2023 08:17:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVEQF8uOwbsvit2HWqDgqfoMUU/lYdkM6zUyYSbh4Wgf5zYH5SWkexJRaYHIVHl/p+Zdv9WPLkddEWTdExmpJ9uUps4P3B+QB/ZvX9IafLV3HjJAfzU+Cx/D0qSL/TYnMlr98CHpE7PxiZA8yW7sHYtUr9aL8pgdgtQzh1KXm3BbCtwCJFNUSRwtjqdhPR38pOuki2EviBla3CpUsdHVXABGWdnSD8UNsJxN+YAQiGqRD0FIBoxbC/F8LbMfUYCr1ziMzH7rFqZZc0YOzix3dql0ebpotxHGCz9oxAOfet+uTMhS+cg0RAnx/XYHm7jHvDXcS4gkeLtWtsrGRt7rjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C164GxtIP68KIBm3BCbWqXUb//7dcipOUYttZuU7EJY=;
 b=gQPDX31syQPYsuZeD50CoIadsCgmQxTTo4naUwU5WqMKvZZByVc9gFOGkEDYZBDi9RcxIOOAWOjcda/9oSKtm3Psx6Vr/OMbNxbGaIRgri3ODGj+TdOCe/zOaJGF+LLieVuwZD2zrJBdmmJqcz/1NtalmpgrZMg/D2hCkerC6XxWZbDnXVlzya8m8ps2YKGiTJpXqYxmo7lvx5CaiWqdU+oT9R5Bd3gN36+Q0/027/ox3bBDzOnKRC3Yajf2O0XVEFdjaFnYh9Wc1oeQk8zhZYjmagKIgSR8I7nuB4P2yWr0APn/7lwWyzO4PKlFotG95LQCBAdIHO7cO6Y1og6N6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C164GxtIP68KIBm3BCbWqXUb//7dcipOUYttZuU7EJY=;
 b=eN2zhaFYz0FEM19Flxwh89DeeJHNN9nyTNKut2EZahVDntWJmjysbq5fhPCbEl1uI0wVBgJabbWGlXyEAC2xJyYqobI8LgDiZtiSJ6P2YRd9D44/S+KXhGEmEXvVqTAFSNkBfp6U4D+8Ykp7vEcNBqSqzoXCRMLp3RtTZVKP5jU=
Received: from AS4P190CA0021.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::6)
 by PAVPR02MB9112.eurprd02.prod.outlook.com (2603:10a6:102:324::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 16:17:56 +0000
Received: from AM4PEPF00027A62.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::79) by AS4P190CA0021.outlook.office365.com
 (2603:10a6:20b:5d0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27 via Frontend
 Transport; Mon, 6 Nov 2023 16:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A62.mail.protection.outlook.com (10.167.16.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Mon, 6 Nov 2023 16:17:55 +0000
Received: from pc52311-2249 (10.0.5.60) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Nov
 2023 17:17:55 +0100
References: <cover.1692699931.git.waqar.hameed@axis.com>
 <7b856b74c4c0f8c6c539d7c692051c9203b103c0.1692699931.git.waqar.hameed@axis.com>
 <20231103225331f0fee24a@mail.local>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Alessandro Zummo <a.zummo@towertech.it>, <kernel@axis.com>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] rtc: Add driver for Epson RX8111
Date:   Mon, 6 Nov 2023 15:36:55 +0100
In-Reply-To: <20231103225331f0fee24a@mail.local>
Message-ID: <pndo7g67t59.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A62:EE_|PAVPR02MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: a567821e-25ec-49d1-f2bc-08dbdee3ef60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bQmOBPzd0OlF742fYjcXC+4skuK3tNfHbeZRClaOgaACWd18hzlWoArAZ63c5vi38D5gBn/bQCd6sdqh+4AO1irmHT3g70pyEBmkg3ek7k5ZTYQWaf3HXtkktecYqRIRJom/oPxvpLtzat4hzyRCsm790UJolzWMRdCHJnt7e1KOEasHMOgz5cHWwG9lAZ7VgScakqBhiy+Ho2YBaJzSVedaPq0r26I7NxntxMSxLFKk0aeKfQlxQcEhErcGBscdGClAuF5htl5ilJtm+ZRMy/yjpXlldwz3M2qtiRKKdCar42d4IHZyowNLfvMZV8/50nTm57nXBLmEckWs29jCan206kbDuZ8tOf8SQ2yV2ZStFvN6Y7UfAfU12fbGkR+IF7x7cRIXlklv4LXeC2KQJ3RpGwN0izjgbnOrNRRczK0C/QvgIsZTMgQSJJ926pKhcE5Bv3Q9Z/m6fGVVIFk046b44AzvNd27aLxvHKZfW/yu0DTHulokzW35ceLb+bjXX6cqTu8Kf77XNeMQwoi5uojjaOpb8w9G/rYfxdHdXtAa7lnppvJV2vK28ZhMAqzDJBSIVhfgCNAMZCN3lvVfDBO7RlNNpYSf6pMDMy0YA68P1uEdZWvmf6+5/BSs6x4O8IC+ttlfJBhaBJxZschba7TRTYA/IUM3onKYsfo8V2u5WtqR1nYDYIoy+VS5jJ+UYFbydUEUz4XBteqlgbp5Shg+QFqkDCPf6t+j0VKRDbbvc7Ybu9Qp6+n6oQhxz7neg46WyfJveLnb9SVxNdEVeQ==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(16526019)(53546011)(426003)(336012)(26005)(2616005)(41300700001)(47076005)(36860700001)(83380400001)(4326008)(8676002)(8936002)(30864003)(2906002)(44832011)(5660300002)(478600001)(70206006)(316002)(70586007)(6916009)(36756003)(54906003)(81166007)(356005)(16799955002)(82740400003)(86362001)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 16:17:55.7795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a567821e-25ec-49d1-f2bc-08dbdee3ef60
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A62.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 23:53 +0100 Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Hello,
>
> I'm sorry for the very late review...

No worries! Thank you very much for reviewing!

>
> On 22/08/2023 12:25:31+0200, Waqar Hameed wrote:
>> +#include <linux/bcd.h>
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +
>> +#include <linux/rtc.h>
>> +
>> +#define RX8111_DRV_NAME "rtc-rx8111"
>
> This define is not necessary

Alright, will remove and enter it directly in `.name = ...`.

[...]

>> +#define RX8111_TIME_BUF_SZ (RX8111_REG_YEAR - RX8111_REG_SEC + 1)
>> +#define RX8111_TIME_BUF_IDX(reg)                                               \
>> +	({                                                                     \
>> +		BUILD_BUG_ON_MSG(reg < RX8111_REG_SEC || reg > RX8111_REG_YEAR,\
>> +				 "Invalid reg value");                         \
>> +		(reg - RX8111_REG_SEC);                                        \
>> +	})
>
> I don't feel like this is improving the legibility of the code. 

Sure, I just wanted to minimize `reg - RX8111_REG_SEC` expressions
everywhere. I think it's a matter of taste here. I'll remove the
macro `RX8111_TIME_BUF_IDX()` altogether.


> Also, the BUILD_BUG_ON_MSG is never going to happen and doesn't
> protect against a frequent issue.

Yeah, it's probably not that frequent. Just wanted to help the next
person here :)

>
>> +
>> +enum rx8111_regfield {
>> +	/* RX8111_REG_EXT. */
>> +	RX8111_REGF_TSEL0,
>> +	RX8111_REGF_TSEL1,
>> +	RX8111_REGF_ETS,
>> +	RX8111_REGF_WADA,
>> +	RX8111_REGF_TE,
>> +	RX8111_REGF_USEL,
>> +	RX8111_REGF_FSEL0,
>> +	RX8111_REGF_FSEL1,
>> +
>> +	/* RX8111_REG_FLAG. */
>> +	RX8111_REGF_XST,
>> +	RX8111_REGF_VLF,
>> +	RX8111_REGF_EVF,
>> +	RX8111_REGF_AF,
>> +	RX8111_REGF_TF,
>> +	RX8111_REGF_UF,
>> +	RX8111_REGF_POR,
>> +
>> +	/* RX8111_REG_CTRL. */
>> +	RX8111_REGF_STOP,
>> +	RX8111_REGF_EIE,
>> +	RX8111_REGF_AIE,
>> +	RX8111_REGF_TIE,
>> +	RX8111_REGF_UIE,
>> +
>> +	/* RX8111_REG_PWR_SWITCH_CTRL. */
>> +	RX8111_REGF_SMPT0,
>> +	RX8111_REGF_SMPT1,
>> +	RX8111_REGF_SWSEL0,
>> +	RX8111_REGF_SWSEL1,
>> +	RX8111_REGF_INIEN,
>> +	RX8111_REGF_CHGEN,
>> +
>> +	/* Sentinel value. */
>> +	RX8111_REGF_MAX
>> +};
>> +
>> +static const struct reg_field rx8111_regfields[] = {
>> +	[RX8111_REGF_TSEL0] = REG_FIELD(RX8111_REG_EXT, 0, 0),
>> +	[RX8111_REGF_TSEL1] = REG_FIELD(RX8111_REG_EXT, 1, 1),
>> +	[RX8111_REGF_ETS]   = REG_FIELD(RX8111_REG_EXT, 2, 2),
>> +	[RX8111_REGF_WADA]  = REG_FIELD(RX8111_REG_EXT, 3, 3),
>> +	[RX8111_REGF_TE]    = REG_FIELD(RX8111_REG_EXT, 4, 4),
>> +	[RX8111_REGF_USEL]  = REG_FIELD(RX8111_REG_EXT, 5, 5),
>> +	[RX8111_REGF_FSEL0] = REG_FIELD(RX8111_REG_EXT, 6, 6),
>> +	[RX8111_REGF_FSEL1] = REG_FIELD(RX8111_REG_EXT, 7, 7),
>> +
>> +	[RX8111_REGF_XST] = REG_FIELD(RX8111_REG_FLAG, 0, 0),
>> +	[RX8111_REGF_VLF] = REG_FIELD(RX8111_REG_FLAG, 1, 1),
>> +	[RX8111_REGF_EVF] = REG_FIELD(RX8111_REG_FLAG, 2, 2),
>> +	[RX8111_REGF_AF]  = REG_FIELD(RX8111_REG_FLAG, 3, 3),
>> +	[RX8111_REGF_TF]  = REG_FIELD(RX8111_REG_FLAG, 4, 4),
>> +	[RX8111_REGF_UF]  = REG_FIELD(RX8111_REG_FLAG, 5, 5),
>> +	[RX8111_REGF_POR] = REG_FIELD(RX8111_REG_FLAG, 7, 7),
>> +
>> +	[RX8111_REGF_STOP] = REG_FIELD(RX8111_REG_CTRL, 0, 0),
>> +	[RX8111_REGF_EIE]  = REG_FIELD(RX8111_REG_CTRL, 2, 2),
>> +	[RX8111_REGF_AIE]  = REG_FIELD(RX8111_REG_CTRL, 3, 3),
>> +	[RX8111_REGF_TIE]  = REG_FIELD(RX8111_REG_CTRL, 4, 4),
>> +	[RX8111_REGF_UIE]  = REG_FIELD(RX8111_REG_CTRL, 5, 5),
>> +
>> +	[RX8111_REGF_SMPT0]  = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 0, 0),
>> +	[RX8111_REGF_SMPT1]  = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 1, 1),
>> +	[RX8111_REGF_SWSEL0] = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 2, 2),
>> +	[RX8111_REGF_SWSEL1] = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 3, 3),
>> +	[RX8111_REGF_INIEN]  = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 6, 6),
>> +	[RX8111_REGF_CHGEN]  = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 7, 7),
>> +};
>
> I'm not quite sure using reg_field is actually an improvement. I don't
> have anything against it either, unless it adds bus reads/writes when
> reading or setting the time.

We shouldn't of course use `reg_field` to do extra unnecessary bus
calls. Also see the comment below when "`reg_field` is worse".

>
>> +
>> +static const struct regmap_config rx8111_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +	.max_register = RX8111_REG_TS_CTRL3,
>> +};

[...]

>> +static int rx8111_setup(struct rx8111_data *data)
>> +{
>> +	int ret;
>> +
>> +	/* Disable extended functionality (timer, events, timestamps etc.). */
>> +	ret = regmap_write(data->regmap, RX8111_REG_EXT, 0);
>
> This will lead to issues later on, you should leave the default values.

Alright, I understand. Will remove.

>
>> +	if (ret) {
>> +		dev_err(data->dev,
>> +			"Could not disable extended functionality (%d)\n", ret);
>
> You should cut down on the number of message, this would be a bus error
> and the user has no actual action after seeing the message.

True, will convert it to `dev_dbg()` then.

>
>> +		return ret;
>> +	}
>> +
>> +	/* Disable all interrupts. */
>> +	ret = regmap_write(data->regmap, RX8111_REG_CTRL, 0);
>
> This will also lead to issues later on when adding alarm support.

I see, will remove.

>
>> +	if (ret) {
>> +		dev_err(data->dev, "Could not disable interrupts (%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int rx8111_read_vl_flag(struct rx8111_data *data, unsigned int *vlval)
>> +{
>> +	int ret;
>> +
>> +	ret = regmap_field_read(data->regfields[RX8111_REGF_VLF], vlval);
>> +	if (ret)
>> +		dev_err(data->dev, "Could not read VL flag (%d)", ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int rx8111_clear_vl_flag(struct rx8111_data *data)
>> +{
>> +	int ret;
>> +
>> +	ret = regmap_field_write(data->regfields[RX8111_REGF_VLF], 0);
>> +	if (ret)
>> +		dev_err(data->dev, "Could not write VL flag (%d)", ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int rx8111_read_time(struct device *dev, struct rtc_time *tm)
>> +{
>> +	struct rx8111_data *data = dev_get_drvdata(dev);
>> +	u8 buf[RX8111_TIME_BUF_SZ];
>> +	unsigned int regval;
>> +	int ret;
>> +
>> +	/* Check status. */
>> +	ret = rx8111_read_vl_flag(data, &regval);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (regval) {
>> +		dev_warn(data->dev,
>> +			 "Low voltage detected, time is not reliable\n");
>> +		return -EINVAL;
>> +	}
>> +
>
> Should you check XST too? 

According to the datasheet
(https://support.epson.biz/td/api/doc_check.php?dl=app_RX8111CE&lang=en),
when the VLF bit is set, "Either power on reset _or_ X'tal oscillation
stop is detected". It should therefore be sufficient to only check the
VLF bit?

However, I do understand that it's maybe more "robust" to also check XST
(and to be able to distinguish and report it). We could add that.

> And with this, using reg_field is worse.

Reading two fields in the same register with `reg_field` sure is worse.
If we now also want to check XST, a better (usual) way is to do a
`regmap_read()` and then `FIELD_GET()`. What do you think?

>
>> +	ret = regmap_field_read(data->regfields[RX8111_REGF_STOP], &regval);
>> +	if (ret) {
>> +		dev_err(data->dev, "Could not read clock status (%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	if (regval) {
>> +		dev_warn(data->dev, "Clock stopped, time is not reliable\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Read time. */
>> +	ret = regmap_bulk_read(data->regmap, RX8111_REG_SEC, buf,
>> +			       ARRAY_SIZE(buf));
>> +	if (ret) {
>> +		dev_err(data->dev, "Could not bulk read time (%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	tm->tm_sec = bcd2bin(buf[RX8111_TIME_BUF_IDX(RX8111_REG_SEC)]);
>> +	tm->tm_min = bcd2bin(buf[RX8111_TIME_BUF_IDX(RX8111_REG_MIN)]);
>> +	tm->tm_hour = bcd2bin(buf[RX8111_TIME_BUF_IDX(RX8111_REG_HOUR)]);
>> +	tm->tm_mday = bcd2bin(buf[RX8111_TIME_BUF_IDX(RX8111_REG_DAY)]);
>> +
>> +	/* Our month range is [1, 12] and tm_mon has [0, 11]. */
>> +	tm->tm_mon = bcd2bin(buf[RX8111_TIME_BUF_IDX(RX8111_REG_MONTH)]) - 1;
>> +
>> +	/*
>> +	 * We begin at year 2000 (c.f. rtc->range_min) and tm_year starts at
>> +	 * year 1900.
>> +	 */
>
> Theses comments are not super useful because most of the RTC drivers are
> behaving this way and it is quite obvious why this is the case.

Sure, I'll remove them.

>
>> +	tm->tm_year = bcd2bin(buf[RX8111_TIME_BUF_IDX(RX8111_REG_YEAR)]) + 100;
>> +
>> +	/* A single bit specifies the week day [0, 6]. Note that ffs(1) = 1. */
>> +	tm->tm_wday = ffs(buf[RX8111_TIME_BUF_IDX(RX8111_REG_WEEK)]) - 1;
>> +
>> +	return 0;
>> +}
>> +
>> +static int rx8111_set_time(struct device *dev, struct rtc_time *tm)
>> +{
>> +	struct rx8111_data *data = dev_get_drvdata(dev);
>> +	u8 buf[RX8111_TIME_BUF_SZ];
>> +	int ret;
>> +
>> +	buf[RX8111_TIME_BUF_IDX(RX8111_REG_SEC)] = bin2bcd(tm->tm_sec);
>> +	buf[RX8111_TIME_BUF_IDX(RX8111_REG_MIN)] = bin2bcd(tm->tm_min);
>> +	buf[RX8111_TIME_BUF_IDX(RX8111_REG_HOUR)] = bin2bcd(tm->tm_hour);
>> +	buf[RX8111_TIME_BUF_IDX(RX8111_REG_DAY)] = bin2bcd(tm->tm_mday);
>> +
>> +	/* Our month range is [1, 12] and tm_mon has [0, 11]. */
>> +	buf[RX8111_TIME_BUF_IDX(RX8111_REG_MONTH)] = bin2bcd(tm->tm_mon + 1);
>> +
>> +	/*
>> +	 * We begin at year 2000 (c.f. rtc->range_min) and tm_year starts at
>> +	 * year 1900.
>> +	 */
>> +	buf[RX8111_TIME_BUF_IDX(RX8111_REG_YEAR)] = bin2bcd(tm->tm_year - 100);
>> +
>> +	/* A single bit specifies the week day [0, 6].*/
>> +	buf[RX8111_TIME_BUF_IDX(RX8111_REG_WEEK)] = BIT(tm->tm_wday);
>> +
>> +	ret = rx8111_clear_vl_flag(data);
>> +	if (ret)
>> +		return ret;A

(What happened here? Hopefully not present in original patch.)

>> +
>> +	/* Stop the clock. */
>> +	ret = regmap_field_write(data->regfields[RX8111_REGF_STOP], 1);
>> +	if (ret) {
>> +		dev_err(data->dev, "Could not stop the clock (%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Set the time. */
>> +	ret = regmap_bulk_write(data->regmap, RX8111_REG_SEC, buf,
>> +				ARRAY_SIZE(buf));
>> +	if (ret) {
>> +		dev_err(data->dev, "Could not bulk write time (%d)\n", ret);
>> +
>> +		/*
>> +		 * We don't bother with trying to start the clock again. We
>> +		 * check for this in rx8111_read_time() (and thus force user to
>> +		 * call rx8111_set_time() to try again).
>> +		 */
>> +		return ret;
>> +	}
>> +
>> +	/* Start the clock. */
>> +	ret = regmap_field_write(data->regfields[RX8111_REGF_STOP], 0);
>> +	if (ret) {
>> +		dev_err(data->dev, "Could not start the clock (%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>
> You definitively need to handle XST here too.

Do you mean to also clear XST the same way we clear VLF (before stopping
the clock)?

>
>> +	return 0;
>> +}
>> +
>> +static int rx8111_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
>> +{
>> +	struct rx8111_data *data = dev_get_drvdata(dev);
>> +	unsigned int regval;
>> +	unsigned long vlval;

Just caught this; it should actually be an `unsigned int`...

>> +	int ret;
>> +
>> +	switch (cmd) {
>> +	case RTC_VL_READ:
>> +		ret = rx8111_read_vl_flag(data, &regval);
>> +		if (ret)
>> +			return ret;
>> +
>> +		vlval = regval ? RTC_VL_DATA_INVALID : 0;
>> +
>> +		return put_user(vlval, (unsigned long __user *)arg);

... and then change this accordingly.

>> +	case RTC_VL_CLR:
>> +		return rx8111_clear_vl_flag(data);
>
> Do not allow userspace to clear VLF without setting the time.

Hm, makes sense. Let's remove it here (since we already clear it in
`rx8111_set_time()`).

(I think I got "fooled" when doing a quick search and seeing some
drivers allowing this. They sure are in the minority though...)

>
>> +	default:
>> +		return -ENOIOCTLCMD;
>> +	}
>> +}
>> +
>> +static const struct rtc_class_ops rx8111_rtc_ops = {
>> +	.read_time = rx8111_read_time,
>> +	.set_time = rx8111_set_time,
>> +	.ioctl = rx8111_ioctl,
>> +};
>> +
>> +static int rx8111_probe(struct i2c_client *client)
>> +{
>> +	struct rx8111_data *data;
>> +	struct rtc_device *rtc;
>> +	size_t i;
>> +	int ret;
>> +
>> +	data = devm_kmalloc(&client->dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return dev_err_probe(&client->dev, -ENOMEM,
>> +				     "Could not allocate device data\n");
>
> Please, less strings in probe or at least, use dev_dbg.

Alright, I'll convert them to `dev_dbg()`.

>
>> +
>> +	data->dev = &client->dev;
>> +	dev_set_drvdata(data->dev, data);
>> +
>> +	data->regmap = devm_regmap_init_i2c(client, &rx8111_regmap_config);
>> +	if (IS_ERR(data->regmap))
>> +		return dev_err_probe(data->dev, PTR_ERR(data->regmap),
>> +				     "Could not initialize regmap\n");
>> +
>> +	for (i = 0; i < RX8111_REGF_MAX; ++i) {
>> +		data->regfields[i] = devm_regmap_field_alloc(
>> +			data->dev, data->regmap, rx8111_regfields[i]);
>> +		if (IS_ERR(data->regfields[i]))
>> +			return dev_err_probe(
>> +				data->dev, PTR_ERR(data->regfields[i]),
>> +				"Could not allocate register field %zu\n", i);
>> +	}
>> +
>> +	ret = rx8111_setup(data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	rtc = devm_rtc_allocate_device(data->dev);
>> +	if (IS_ERR(rtc))
>> +		return dev_err_probe(data->dev, PTR_ERR(rtc),
>> +				     "Could not allocate rtc device\n");
>> +
>> +	rtc->ops = &rx8111_rtc_ops;
>> +	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
>> +	rtc->range_max = RTC_TIMESTAMP_END_2099;
>> +
>> +	clear_bit(RTC_FEATURE_ALARM, rtc->features);
>> +
>> +	ret = devm_rtc_register_device(rtc);
>> +	if (ret)
>> +		return dev_err_probe(data->dev, ret,
>> +				     "Could not register rtc device (%d)\n",
>> +				     ret);
>
> devm_rtc_register_device already has messages in all the error path,
> simply return here.

Ah, that's nice! Will do then!

[...]

