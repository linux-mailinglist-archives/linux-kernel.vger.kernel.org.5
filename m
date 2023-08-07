Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428BF7732E1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 00:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjHGWSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 18:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjHGWSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:18:14 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2587B94;
        Mon,  7 Aug 2023 15:18:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8/pWLQsMtkeJcudSsM/wwuTILL0v6LEfcggmMpCVNNiauf4rW+V8ZdX82JHTImTpCnxlEU9pQwyfFwEq7ZIpnFzVdvD6TZ1XUPAbT+5VDtHjCnuTvatmCJaLvCW00Ek++0W5kUOOfkGEdxgAPotvKXaE25u1VB0UVG+h1/FbEf0ZtUF5Xkx/xFwT3X/sE9GmCPZTaXIAbBJQSFXpsxGZDtgbuKbOBior9V+xC13OZNXkpLxg1gNRNyn5raQA/H4mYg/Flc9aaAvvgg6H3CYsQOF1PtMUlmS+7WnKXodLulLLY0s0wsyEKYnrbWv5ACOAM35ZuMrpqoVAW57ryBjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awkLop5uMCOQv/wECiRNtgZ1GNaNSmrMAvLsd/zLsKM=;
 b=Tx9Ud8nDdJnbM+DKKaFE+HNeEt3xIamszkDz+e2CGE+AwKxgA+U3RgyB2RQqdbmAlngV4POafqpxo+Q6nFJgbozVy96vMzs4CqHezg/bBQgroKorstIPI+57uQBMkb687fQbBe1ceG9k/syJ98eqfCuD/u3gmPVmzHhEHgBVdipmBLAEgBF1Rs/8jepSg/ledCcw+nn6lW2Xhsx1c7T+NugvTM/cATM/N8Ueohbx6rBp/q74NBxE/sr1yW7XY9o6aiyrGswdB/kG59HePeCTG8qJxRxWIQAVPYvSY0tZzmEcQQ8sMm0qRavj/Jt7ZSUwcOVXfb7DTM7ap1xEQicY1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awkLop5uMCOQv/wECiRNtgZ1GNaNSmrMAvLsd/zLsKM=;
 b=tO/NTmzCozO/c489h60C13KW1q+d+bZelOTiLBl9GgoLwRag9514Yk8aq1IadxiavEIGgH0n5JxLrHEb+l4QI7WH6LCBIhS4SUa2NL1lmzWIXyZZAJ6MQyGcsx/DIanSOtC3OETOm/CKez5KfdqTjyvRUU7zno83dUJ093cIWOU=
Received: from BYAPR01CA0072.prod.exchangelabs.com (2603:10b6:a03:94::49) by
 LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Mon, 7 Aug
 2023 22:18:06 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::3e) by BYAPR01CA0072.outlook.office365.com
 (2603:10b6:a03:94::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Mon, 7 Aug 2023 22:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 22:18:09 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 17:18:04 -0500
From:   Brad Larson <blarson@amd.com>
To:     <arnd@arndb.de>
CC:     <adrian.hunter@intel.com>, <alcooperx@gmail.com>,
        <andy.shevchenko@gmail.com>, <blarson@amd.com>,
        <brendan.higgins@linux.dev>, <briannorris@chromium.org>,
        <broonie@kernel.org>, <catalin.marinas@arm.com>,
        <conor+dt@kernel.org>, <davidgow@google.com>,
        <devicetree@vger.kernel.org>, <fancer.lancer@gmail.com>,
        <gerg@linux-m68k.org>, <gsomlo@gmail.com>,
        <hal.feng@starfivetech.com>, <hasegawa-hitomi@fujitsu.com>,
        <j.neuschaefer@gmx.net>, <joel@jms.id.au>, <kernel@esmil.dk>,
        <krzk@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <lee.jones@linaro.org>, <lee@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <walker.chen@starfivetech.com>,
        <will@kernel.org>, <zhuyinbo@loongson.cn>
Subject: Re: [PATCH v14 8/8] soc: amd: Add support for AMD Pensando SoC Controller
Date:   Mon, 7 Aug 2023 15:17:54 -0700
Message-ID: <20230807221754.51667-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <787582a3-51a1-494e-bfd0-b51d1117432e@app.fastmail.com>
References: <787582a3-51a1-494e-bfd0-b51d1117432e@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: d29386b3-7d78-42a3-39ae-08db97942ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LkiTNTqYOhgV9P0Y7uWayt6f/doYZVbg7Xow9SN42Zh+d0ERHiGsNS3t/78zhlflOgBp6dgUujQcRy7Jwi71/lZfhk7D5D/W5mbqSZWQvkN8nhNuRgtpMw76JuSlMZVBvuyPIhnjwUfqz3jtli91mt6mkLQ08Ld1APqeKwP4+VBG0pZz2uBtJI0tw6Tu9cFPVxmZfD/2YCWDGLkCm5mEQcqp0Vpd4b9VM2Ry0nfl8xocDSTT11P55tob01Xnb4GrWpq5CJU6n+S2WYWihrKo5XH1CbZ3d/QW4KB5ipvjDIToNUZdJUyt5C9u9iojsjMISmCRTTulKi95nHlqYn7kKCQbWftcPlBB2z5NW/oEOhLUMmi7iad7K+z4axfunlGhxR04McuSu2q5LQX3rckT4AYyVKjykrDEhSjMzeFX90G1V7nARg0IiI7WuKcVptHvL3KiR9kVL7wY49UZjWIT9AlNhQoevVXx/tw86MaNEfhFHcIiVl+3B7nypor/0DAtqbz/eAxmRK4X07j1EC8Xu66rnD8KqCdBAkscV5ewOH9sjtXTQHVWt6d9P1kClH4mSFPD1af2Cyw/+6fzFLHUVXuxb3XGuxL+jLgKlKAQ8tRUA3qKr9QiJvgwXBscYo0osTqbHng6IKGEmgwRBNq3NbfETYOy6f1UMfKjvx2JUC+tMj2KiCHL7nAGd6EBa8ksrHPaNslEGvKkbiDOp8ZLhJuwojHchkb+JdSYXdBqtAG9AqQRSFfNxdpOsj+t7FczDLBuGZFbI8d/08JFt8/8ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(186006)(1800799003)(82310400008)(46966006)(40470700004)(36840700001)(40460700003)(41300700001)(8936002)(8676002)(47076005)(36860700001)(83380400001)(16526019)(26005)(336012)(1076003)(2616005)(426003)(81166007)(356005)(82740400003)(6666004)(6916009)(316002)(36756003)(54906003)(40480700001)(478600001)(4326008)(70586007)(2906002)(5660300002)(70206006)(7406005)(66899021)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 22:18:09.7675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d29386b3-7d78-42a3-39ae-08db97942ecb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

> On Wed, May 24, 2023, at 00:11, Brad Larson wrote:
>>> On Mon, May 15, 2023, at 20:16, Brad Larson wrote:
...
>>> Also, can you explain why this needs a low-lever user interface
>>> in the first place, rather than something that can be expressed
>>> using high-level abstractions as you already do with the reset
>>> control?
>>>
>>> All of the above should be part of the changelog text to get a
>>> driver like this merged. I don't think we can get a quick
>>> solution here though, so maybe you can start by removing the
>>> ioctl side and having the rest of the driver in drivers/reset?

Might be best to pull the whole thing for now until an acceptable 
solution is reached.  The reset function is a recovery mechanisim rarely
used where the byte access to the different IP at the 4 chip-selects
is needed for a system to boot.

>> In the original patchset I added a pensando compatible to spidev and that
>> was nacked in review and reusing some random compatible that made it into 
>> spidev was just wrong.  Further it was recommended this should be a system 
>> specific driver and don't rely on a debug driver like spidev.  I changed 
>> over to a platform specific driver and at that time I also needed to include 
>> a reset controller (emmc reset only).  I put these in drivers/mfd and 
>> drivers/reset.  Review of the device tree for this approach went back and 
>> forth to _not_ have four child nodes on the spi device each with the same 
>> compatible. Decision was to squash the child nodes into the parent and put 
>> the reset-controller there also.  One driver and since its pensando
>> specific its currently in drivers/soc/amd.
>>
>> There are five different user processes and some utilities that access the 
>> functionality in the cpld/fpga.  You're correct, its passing messages that 
>> are specific to the IP accessed via chip-select.  No Elba system will boot 
>> without this driver providing ioctl access.

> Thank you for the detailed summary. Moving away from spidev and
> from mfd seems all reasonable here. I'm still a bit confused by
> why you have multiple chipselects here that are for different
> subdevices but ended with a single user interface for all of them,
> but that's not a big deal.

The goal is to isolate the the kernel from device and platform specific
changes.  All the IO to the spi connected CPLD/FPGA (design/cost dependent)
is a byte at a time or up to 16 bytes for internal flash mgmt.  Performance
is not an issue and spidev was sufficient.

Maybe this paints the right picture to zero in on a correct approach.
Internal and external IP can be present at CS1/CS2 depending on the design
where the CS0 board controller registers get additions over time in a
backward compatible manner.

Design 1: FPGA 
CS0: Board controller registers
CS1: Designware SPI to I2C to board peripherals
CS2: Lattice dual I2C master
CS3: Internal storage

Design 2: CPLD
CS0: Board controller registers
CS1: Not used or some other board specific registers
CS2: Lattice dual I2C master
CS3: Internal storage

> The main bit that sticks out about this high-level design is how
> it relies on user space utilities at all to understand the message
> format. From what I understand about the actual functionality of
> this device, it most closely resembles an embedded controller that
> you might find in a laptop or server machine, and those usually
> have kernel drivers in drivers/platform/ to interact with the
> device.

The dozens of registers at CS0 for board management are defined in
userspace programs or script.  Only the regsiter offset/bit for
emmc reset is needed for the reset function in the patches.

> Has anyone tried to do it like that? Maybe it would help
> to see what the full protocol and the user space side looks
> like, in order to move some or all of it into the kernel.

Looking at drivers/platform its pretty sparse.  What do you 
recommend based on the design 1/2 variations?

Regards,
Brad
