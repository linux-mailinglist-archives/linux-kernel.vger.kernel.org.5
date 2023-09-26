Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06BF7AF4C3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbjIZUGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbjIZUGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:06:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8D5D6;
        Tue, 26 Sep 2023 13:05:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCFLepEKzGuxn6PTYv4iKe1vgQzmPwQYrru1ad0fV8Vh+v6/oYQou3yfzadJ+NsLmg9xo6/T2bUot+OVKcuDlVbpLytouDFXdwr4/U85DfWqn94m5A83kdhGmPU5khfIyMyrc3OG1zrDUdVaOAS/04gMpxs95BLUyKiZpKR7RIhbOQ5yYHmsApy/j1WE01/fhogUa0nyACkH8TzLsiyOaczLKdUmt+q9KUWOZ5BuhBV8COHLzOazwbv5qH8V/ThH6BUn38GrBQklUxFNYL8a1tCi+8HT15fy4CNN+w+dqs+JMcHYa0j47JgGyELS9KHfLChTNcVgO5ns7qsAppqLlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uObNh1yKGnx9276qFxdZOOUZx9wJsTpJpILuuNVoRbQ=;
 b=M60Bhx2raTONCJL5tet4Y/ZPUPsSLFge6q9amWqs9uLF9JUu5KE+O9Vyn1/SaUpPr6kj49scoIaokvH/aCqTbBJlZiSabbwC5Y+/Bsoi7AOrJpmlAUaQS9272tH26Dj2SYsuXcFy8RWN6viMwiXpqOHdgrpvSmPbCwnwZcq5dsw4Wdr1tn5OWAUC5iS1r4T9GLXizr8+uAXMV62kgtjK3EDgtMLc9eVWMOF4MhAMutuYVm08XNuYR9SRSYaDqKbdTKlgvCutR4HEi5UY8ge/14lIXMYmxQA8ughfPY1XVxOGJShSzm6mbvWVOkL7zVKGnN6tcnLBZkcgy3WYtU54zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uObNh1yKGnx9276qFxdZOOUZx9wJsTpJpILuuNVoRbQ=;
 b=p5XLkCQ0lRQ9qO1ZW/HDYa1VQAQSP3jNHs6dxiZSqJRqaMli9GxzxrIOvyEiiKTtLABUmE5ZmhdoE5S2l2qAq1j7Ti4Gj5ziTPfCcUV8yvdJD0l1c7vnkcbeGhfsq4/jHDIUv6fqoeL4OJTH8XojHgFTC/wOyS0DfWImtb4DWFs=
Received: from BLAPR03CA0114.namprd03.prod.outlook.com (2603:10b6:208:32a::29)
 by BN9PR12MB5033.namprd12.prod.outlook.com (2603:10b6:408:132::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 20:05:52 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::f3) by BLAPR03CA0114.outlook.office365.com
 (2603:10b6:208:32a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 20:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 20:05:51 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 26 Sep 2023 15:05:48 -0500
From:   Brad Larson <blarson@amd.com>
To:     <andy.shevchenko@gmail.com>
CC:     <adrian.hunter@intel.com>, <alcooperx@gmail.com>, <arnd@arndb.de>,
        <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <broonie@kernel.org>,
        <catalin.marinas@arm.com>, <conor+dt@kernel.org>,
        <davidgow@google.com>, <devicetree@vger.kernel.org>,
        <fancer.lancer@gmail.com>, <gerg@linux-m68k.org>,
        <gsomlo@gmail.com>, <hal.feng@starfivetech.com>,
        <hasegawa-hitomi@fujitsu.com>, <j.neuschaefer@gmx.net>,
        <joel@jms.id.au>, <kernel@esmil.dk>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee.jones@linaro.org>,
        <lee@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <walker.chen@starfivetech.com>,
        <will@kernel.org>, <zhuyinbo@loongson.cn>
Subject: Re: [PATCH v16 6/6] soc: amd: Add support for AMD Pensando SoC Controller
Date:   Tue, 26 Sep 2023 13:05:41 -0700
Message-ID: <20230926200541.35787-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAHp75VfRLv1=3M+a9pr=ZJgNwtBOrT9xi0UjDJMuY8uM9+ffSw@mail.gmail.com>
References: <CAHp75VfRLv1=3M+a9pr=ZJgNwtBOrT9xi0UjDJMuY8uM9+ffSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|BN9PR12MB5033:EE_
X-MS-Office365-Filtering-Correlation-Id: b969c263-7d64-46f5-a98f-08dbbecbfc0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQfodNG/N7OkrYS3Cy5LSiTOK3owTPIjuJ9dtt8P7QK7MG04gMCksZUAX8Zo+C6gOqGsjFqAePndpIr7xQKcB+MO++y9n5GMcFG7I0elQlOSuHyjgPZHnVivYgZ4rxo+DR8iMSQKr7eJ8rKvoOsTReKeW3s6LEsl52xB1f1T0SIVnt9D7G6kAQbTwQJc2lMGo7pz9W1kn53kHoeVx32mHSLP3cGwCDm77d8w2j+TxKje4F9Eq1FQoNgiPqt0Lm3ka90lHpHha/iMI7B1whSjSIhrgtIoeEiiawP5Zl9CHTl51BahYDVTkKNdh9s1r6tbQIeVbd3UW0h3iug6Prw02woYpj4CrMn4hOMKC8OjeTZaI+v2ouY+vxJ5oamFL5RZt1r2/dmVljaYmdKoZSpl5O/g4lkigwO6jgQ6KqZbhGwEcuWbx81b7O1micH5uCka0TTegMgyBOoiprnaPBqbaOrJgUTMrcbgdbQXj+1HV3xlDyHJCPhUE9nroy4wKcVxb6gyaKkFlh13ZmM3FwWg2H9NwIZMfmGRr3BrzfUeNMxzKI9b+V7ayQEdTi00K0hx9moHKKNP5Kie6kopZlv5KJCFLNr5VI3hhQ1lHFZHP+18FwsEWvg42FjgvdY1yRjfzR+IAbBV0XZXwlN9rcFU81SRLhKo9AU9IndAkhP7Sl1jBEz6Qu8p3855n62sOmo/XyhbJGx4Az1Y448H91wadDoLDGYE6pxbqjwo3vRs2nQtzeGcJdcR8v3mIeEYHcnaEINXWJ1z2QnK/4QJhBribw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(46966006)(40470700004)(478600001)(8936002)(70206006)(70586007)(336012)(6916009)(83380400001)(40460700003)(2616005)(1076003)(26005)(16526019)(4326008)(41300700001)(47076005)(426003)(36860700001)(54906003)(7416002)(316002)(7406005)(6666004)(2906002)(8676002)(53546011)(40480700001)(36756003)(81166007)(356005)(82740400003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 20:05:51.8733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b969c263-7d64-46f5-a98f-08dbbecbfc0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5033
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, Sep 21, 2023 at 18:19:57 +0300 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Thu, Sep 14, 2023 at 12:52 AM Brad Larson <blarson@amd.com> wrote:
>>
>> The Pensando SoC controller is a SPI connected companion device
>> that is present in all Pensando SoC board designs.  The essential
>> board management registers are accessed on chip select 0 with
>> board mgmt IO support accessed using additional chip selects.

...

>> +#include <linux/cdev.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/fs.h>
>> +#include <linux/init.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/reset-controller.h>
>> +#include <linux/spi/spi.h>
>
> types.h ?

I'll add types.h

>> +#include <linux/uaccess.h>

...

>> +       struct penctrl_device *penctrl;
>
>> +       u8 tx_buf[PENCTRL_MAX_MSG_LEN];
>> +       u8 rx_buf[PENCTRL_MAX_MSG_LEN];
>
> These are not DMA-safe, is this a problem?

It's not a problem, the peripheral is PIO FIFO driven only.

>> +       struct spi_transfer t[2] = {};
>> +       struct penctrl_spi_xfer *msg;
>> +       struct spi_device *spi;
>> +       unsigned int num_msgs;
>> +       struct spi_message m;
>> +       u32 size;
>> +       int ret;

...

>> +       /* Verify and prepare SPI message */
>> +       size = _IOC_SIZE(cmd);
>> +       num_msgs = size / sizeof(struct penctrl_spi_xfer);
>
> sizeof (*msg) ?

Yes, more compact for here and below.

>
>> +       if (num_msgs > 2 || size == 0 || size % sizeof(struct penctrl_spi_xfer)) {
>
> Dito.
>
>> +               ret = -EINVAL;
>> +               goto out_unlock;
>> +       }

...

>> +       msg = memdup_user((struct penctrl_spi_xfer *)arg, size);
>> +       if (IS_ERR(msg)) {
>> +               ret = PTR_ERR(msg);
>> +               goto out_unlock;
>> +       }
>
> Wondering if you can start using cleanup.h.

Perhaps if recommended, I don't see DEFINE_(FREE,UNLOCK,...) being used.

...

>> +       /* Perform the transfer */
>> +       mutex_lock(&spi_lock);
>> +       ret = spi_sync(spi, &m);
>> +       mutex_unlock(&spi_lock);

>> +       if (ret || (num_msgs == 1))
>> +               goto out_unlock;
>
> Second conditional will return 0. Is it by design?
> Since it's not so obvious I would split these conditionals.

I'll split this to be clear, yes return 0 for success.

...

>> +       spi->chip_select = current_cs;
>
> spi_set_chipselect()

Yes, I'll change to inline function spi_set_chipselect(spi, 0, current_cs).  The
second arg must be legacy as its unused.

...

>> +static int penctrl_regs_read(struct penctrl_device *penctrl, u32 reg, u32 *val)
>> +{
>> +       struct spi_device *spi = penctrl->spi;
>> +       struct spi_transfer t[2] = {};
>> +       struct spi_message m;
>
>> +       u8 txbuf[3];
>> +       u8 rxbuf[1];
>
> Not DMA-safe. Is it a problem?
>

Not a problem, the peripheral is PIO only using FIFOs.

>> +       int ret;
>
>> +       txbuf[0] = PENCTRL_SPI_CMD_REGRD;
>> +       txbuf[1] = reg;
>> +       txbuf[2] = 0;
>
> Can be assigned in the definition block
>
>       u8 txbuf[] = { ... };
>

I'll change that here and below.

>> +       t[0].tx_buf = txbuf;
>> +       t[0].len = sizeof(txbuf);
>
>> +       rxbuf[0] = 0;
>
> Ditto.
>
>    u8 rxbuf[] = { 0 };
>
>> +       t[1].rx_buf = rxbuf;
>> +       t[1].len = sizeof(rxbuf);
>> +
>> +       spi_message_init_with_transfers(&m, t, ARRAY_SIZE(t));
>> +       ret = spi_sync(spi, &m);
>> +       if (ret)
>> +               return ret;
>> +
>> +       *val = rxbuf[0];
>> +       return 0;
>> +}

...

>> +static int penctrl_regs_write(struct penctrl_device *penctrl, u32 reg, u32 val)
>> +{
>> +       struct spi_device *spi = penctrl->spi;
>> +       struct spi_transfer t = {};
>> +       struct spi_message m;
>> +       u8 txbuf[4];

>> +       txbuf[0] = PENCTRL_SPI_CMD_REGWR;
>> +       txbuf[1] = reg;
>> +       txbuf[2] = val;
>> +       txbuf[3] = 0;

> Can be assigned in the definition block.

>> +       t.tx_buf = txbuf;
>> +       t.len = sizeof(txbuf);
>> +       spi_message_init_with_transfers(&m, &t, 1);
>> +       return spi_sync(spi, &m);
>> +}

...

>> +       struct penctrl_device *penctrl =
>> +               container_of(rcdev, struct penctrl_device, rcdev);
>
> One line?

I'll check/change.

>
>...
>
>> +       spi->chip_select = 0;
>
> spi_set_chipselect()

Yes, spi_set_chipselect(spi, 0, 0);

...

>> +       struct penctrl_device *penctrl =
>> +               container_of(rcdev, struct penctrl_device, rcdev);
>
> One line?

I'll check/change.

...

>> +       spi->chip_select = 0;
>
> spi_set_chipselect()

Yes, spi_set_chipselect(spi, 0, 0);

...

>> +static int penctrl_spi_probe(struct spi_device *spi)
>> +{
>> +       int i, ret;
>> +
>> +       /* Allocate driver data */
>> +       penctrl = kzalloc(sizeof(*penctrl), GFP_KERNEL);
>
> devm_kzalloc() ?

Yes will change to devm_kzalloc().

>> +       if (!penctrl)
>> +               return -ENOMEM;
>> +
>> +       penctrl->spi = spi;
>> +       mutex_init(&spi_lock);
>> +
>> +       for (i = 0; i < ARRAY_SIZE(penctrl_devices); i++) {
>> +               ret = misc_register(&penctrl_devices[i]);
>> +               if (ret) {
>> +                       dev_err(&spi->dev, "Failed to register device %s\n",
>> +                               penctrl_devices[i].name);
>> +                       goto cleanup;
>> +               }
>> +       }
>> +
>> +       /* Register reset controller */
>> +       penctrl->rcdev.dev = &spi->dev;
>> +       penctrl->rcdev.ops = &penctrl_reset_ops;
>> +       penctrl->rcdev.owner = THIS_MODULE;
>> +       penctrl->rcdev.of_node = spi->dev.of_node;
>> +       penctrl->rcdev.nr_resets = 1;
>> +       device_set_node(penctrl->rcdev.dev, dev_fwnode(&spi->dev));
>> +
>> +       ret = reset_controller_register(&penctrl->rcdev);
>> +       if (ret)
>> +               return dev_err_probe(&spi->dev, ret,
>> +                                    "failed to register reset controller\n");
>> +       return 0;
>
>> +cleanup:
>
> err_cleanup: ?

Will use err_cleanup:

>> +       for (i = 0; i < ARRAY_SIZE(penctrl_devices); i++) {
>
>  while (i--) {
>

Yes, can change to while(), order doesn't matter.

>> +               if (penctrl_devices[i].this_device)
>> +                       misc_deregister(&penctrl_devices[i]);
>> +       }
>> +       return ret;
>> +}

Regards,
Brad
