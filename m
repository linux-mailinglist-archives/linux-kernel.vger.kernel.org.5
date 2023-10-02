Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A817B4EC5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbjJBJOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbjJBJOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:14:05 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002F983
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMwmeUr13w7Vre09hGCEgq0VkrwriTGFUPvnpv6VHZondtANGR7iYaTkg/pnIiOGvYEyh1MrV818ckUQrpqNYQYZ8pj8LOztMb3WttcmsAprP7ErBCOLf05YJ6L5AJ0dwe4/2ltkm+Znpwjrz0mLm7BsI19XNfHbyMokWOE7MorCI79Rpm3UYHQ3dixD2yLvWUOpQDn1dyCOnGlILWfvMOivrB9MVQQH6yDF0u6doGMgVqF1xQ18En31dUInBviccg8zezmy1/seVnJaXoZIYFX4OlCF+xk75xJO2l/Ou2JpItymlV1WUwpBv1HP4eLp/9lMACVdGnF+I0Ent2BnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQpdqwSx/jDWJKUJer+t/3JJX3mUiH/x6IgedEhf+cM=;
 b=fclUG6G2sDRSV4jYM3iaVxYyOdcLij2Vv/eSvxiM996I9fcigTQ8qxxgvNHUyaHBpbBzOhi6yT8ADkMGtHz1XhKJA7VFLAUNfPIRjAKnRG7mo1bIMon6ozRLj8HfEKDUaVhpPGtgfA1l4ve6J/k/hRcbrYHspeE/X8BTN4ShGolC2ucuR1eMt0pkNAmg06/SDk4e+MUVhYZKF+C6SX2GwID6sQy5maYu86C2kLO/QbADv+ynJkPR9jXEzsI8QQiLk8fzJQdkL/A29cati3Fe85bUpZdiVzOgi9FwyW45uUeZWZ/eQdO22au+Gut7m1eqhCqU+EFk52ufriptdbwgEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQpdqwSx/jDWJKUJer+t/3JJX3mUiH/x6IgedEhf+cM=;
 b=MV0fdhcU+dZPdQivoFXhs5LmAO2GtbUi0BamVRxOKr4eElByY8Pwg2PJ48BfO1sbL8sH5139wXPdu5x2hIWb2AQFesisyHk0T27X4ctu0DP23/0PZnjerBUZjr22VITpp8bkbVRLTnIrDA5ogHClUQseehaCN3hiZxOHXZxNuvk=
Received: from BN0PR02CA0050.namprd02.prod.outlook.com (2603:10b6:408:e5::25)
 by IA1PR12MB6626.namprd12.prod.outlook.com (2603:10b6:208:3a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 09:13:58 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:408:e5:cafe::81) by BN0PR02CA0050.outlook.office365.com
 (2603:10b6:408:e5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Mon, 2 Oct 2023 09:13:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 09:13:57 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 04:13:54 -0500
Message-ID: <27af231c-4144-45b4-9105-fb9df20a7958@amd.com>
Date:   Mon, 2 Oct 2023 11:13:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 40/40] soc/xilinx: zynqmp_power: Convert to platform
 remove callback returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Rob Herring <robh@kernel.org>, Ruan Jinjie <ruanjinjie@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
 <20230925095532.1984344-41-u.kleine-koenig@pengutronix.de>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20230925095532.1984344-41-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|IA1PR12MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aae72b7-8ac5-482f-771c-08dbc327e881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QlfDE6g2hAWGePTC6rO5NV5uIiabT/acbL2fy+qRKugXtVR6VCCWw4aWh7ULsFepjojdZz8ALBhAOJgl3WJhr0S+tx8818WlSua356HGsDszxypZatWC6ZMaFbWoTMD/Rjt2BKS64/qilYTRdVZ2bz3OPCi9NmpX8dSLULma5/dPJds+Hd/JuC/BC4bbrqA5sadsDS+X87DzCeiNF90fxm7ZI3i+Vql78b2+aUw6JE5snLdehzrXN6UOSv04g7JNYBk+DL+ori3E7IDVw4SkRiPEXw6gYvIofzMCiZ7qFZ5pIa66R2MlDi+EW8bK9HiwWiTQlb4nP0tTYXbb9V1a+PZZjR5aFmVlezjp0NSz5Qh7Mh+xoAw2aw5lfri0hMa5QzBKFWMKA5IuPQBSQZHaebrv8k20k5A5TAmRAqQrxizZGOyAVWVfqTAAIG26wyR2he7JDudhut/4Tq9gSqvwuLkR+lwVYp11mOLZ1awsSQHbKFgff4++Mf3K/T1S2lLbG+yMUiXK1Reg+o+xAxmF4CYLsoGVAD0olY2KVGlUz2KPA6QYmMcRHEPRho8ObhaBS+tswFTrqSH6w5novzZqudY61M2a7c7QLECHCNLIVx9VAz+OqoCb9NBbIDC5Wy/TKhj546t6srVkFZretAM7ObAR1wHunJLTGpGsGgYEy55goSOXBKMpCi5dheJBCKvgVBtTAHU1Fo9JmG3iNVj4EHgZOcZMbe42LK9Z4uvbcVgMpZjI/jRvhbutlNcAssceY7wft0mcqqKt5MGWOHPc1GEKYxeEBafEqdTRXSEecmjaMoGBa7FAG7V/GF4y3MpY
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(82310400011)(64100799003)(186009)(40470700004)(36840700001)(46966006)(31686004)(40460700003)(2906002)(316002)(41300700001)(4326008)(8676002)(8936002)(44832011)(5660300002)(40480700001)(36756003)(54906003)(16576012)(70206006)(6916009)(70586007)(31696002)(478600001)(86362001)(53546011)(6666004)(2616005)(426003)(82740400003)(66574015)(336012)(26005)(81166007)(356005)(16526019)(83380400001)(47076005)(36860700001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 09:13:57.4215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aae72b7-8ac5-482f-771c-08dbc327e881
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6626
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/23 11:55, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/soc/xilinx/zynqmp_power.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
> index c2c819701eec..9d27f850f491 100644
> --- a/drivers/soc/xilinx/zynqmp_power.c
> +++ b/drivers/soc/xilinx/zynqmp_power.c
> @@ -275,7 +275,7 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> -static int zynqmp_pm_remove(struct platform_device *pdev)
> +static void zynqmp_pm_remove(struct platform_device *pdev)
>   {
>   	sysfs_remove_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
>   	if (event_registered)
> @@ -283,8 +283,6 @@ static int zynqmp_pm_remove(struct platform_device *pdev)
>   
>   	if (!rx_chan)
>   		mbox_free_channel(rx_chan);
> -
> -	return 0;
>   }
>   
>   static const struct of_device_id pm_of_match[] = {
> @@ -295,7 +293,7 @@ MODULE_DEVICE_TABLE(of, pm_of_match);
>   
>   static struct platform_driver zynqmp_pm_platform_driver = {
>   	.probe = zynqmp_pm_probe,
> -	.remove = zynqmp_pm_remove,
> +	.remove_new = zynqmp_pm_remove,
>   	.driver = {
>   		.name = "zynqmp_power",
>   		.of_match_table = pm_of_match,

Applied only this patch.
Thanks,
Michal
