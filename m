Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F12D7AF1EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbjIZRrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjIZRrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:47:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0462E5;
        Tue, 26 Sep 2023 10:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSPhj0e3u73jP5IiM+kiFJlddLxHeDbEZBONIsDYtDLW3zCAj0A7UUtZzbkUo4Ce4IYUKaWfgy3z7/KQRAND4FUH2YcCzDIl9t7zXzA6d8Dps2lwjY5lYEmtIcaizTR27OZMHZjE9lnwxuCsgV/OTLCytf06BCQac3krZXFCf0eVBa8BHIA3IYlSECianmQB5geDa6qo5adCb8FOXv6J5yw800EOPRTvAFvENTPgHSe+HjrDTxJq7hUeuK9UMn/iu6zod/j/Ns/IHI/NA/aCG6bIwVX510ikh/kENxF8AtH7Z8PW2N5o49W712lXWzVBqsQZhFaiflw7XC0NNC8JRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNQYCQMpDXgnQaY/pf5cyMhsLwPs80woJVKPGJ6crLo=;
 b=X0s6IuCVEb0TpaZWuLWyRUUJh4kcG5JNUa/j2Ac7GREoqqd41I+SxpLtmCRu9pHUXYMVL02s6XWu01ol9N562crlN3I0kdCVBTcqwTT6s24U35owwD5ds9V8jC0SHoHZs3t7HdWX+jMjhe77QdXVCOb5DFIjaFlQIVWbWkGtORnLAaHsrC7ORNfu+RxvCUhjMlZyiSjfzTwZLhXTH2aLWBoqORmDiDdfx28zXHBBa22zeqmgrYk8u6m2GFXWBMAqLMGITWXaZgHCpAn0fISBHjzynEfyP8e9ttH8XArpg80cMYcrwCYxo5CekcUbW9s9b4Jwd+X2wTBvhxik3j5TdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNQYCQMpDXgnQaY/pf5cyMhsLwPs80woJVKPGJ6crLo=;
 b=BHimnSqbT3a+xuqYFx0zQYZw+BCXVUfb1c0wImNoX97Hu0hLOaf29TO0nA56IJ4lmPJXCb4Pg4oCEoUHgCOtbSpTRPrgeDXbiNYVHNbOdesA84rB0S4ncCoFW/6+1nGw+L8Ev5Z/3XdRSZGc7BHILdu7gp0t/16pKUjZRqVzeqs=
Received: from MN2PR17CA0023.namprd17.prod.outlook.com (2603:10b6:208:15e::36)
 by BL1PR12MB5948.namprd12.prod.outlook.com (2603:10b6:208:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 17:47:26 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:15e:cafe::25) by MN2PR17CA0023.outlook.office365.com
 (2603:10b6:208:15e::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 17:47:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 17:47:26 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 26 Sep 2023 12:47:22 -0500
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
Subject: Re: [PATCH v16 6/6] soc: amd: Add support for AMD Pensando SoC Controller
Date:   Tue, 26 Sep 2023 10:47:16 -0700
Message-ID: <20230926174716.41705-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <68ca306c-5ea2-437e-b7f1-68bad88557a0@app.fastmail.com>
References: <68ca306c-5ea2-437e-b7f1-68bad88557a0@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|BL1PR12MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: bee88fa1-9a54-4a86-53e2-08dbbeb8a583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdgIF3ouo8ejpupXUudOaux7+uAMRlyF6NXx0Qdz3d1tOP3XygVmFlx/pU8fhJm6lIvr+Kz6bMXBS6f6WQfiji8lMQdpeSsP5NMZ9PsY7XlBwNzZjYR2UF/M5K5ZixstMlUvMet9WdkLSQMn5mOwf9zmuZa2Fs3mmHAheGx2U5YTpbz+/w1+sBkSmnwzFG4Hasoanoa0cTdPKaJQ5UbUDttYAFaJJJyK/jNOpT0YPg5My6wN9fzOPbO9ZLkaf0STqe4hLIKXtIBTSp6nj/JS1qbh1wVc2lLzgzpBB2s41+NTB6bkJ+28XxN7wL2Dme2mhtQMdtsBTBgsPNY8+Y20VzYnKLdXfW9KEaSWPlF/VnDt0AlJZuKYHxnuCu50/GFmzDdNIX/f4KHAhbT1KCHHeyGOUWtsvZpPlsNBvJ5l0p3QowXDDfAvKijuTCU2yjRNPzShWFWJSwejolBNsOdZ9V7STbTEP2L6PqpZsE8vU8wTTVPRr63dfO8qJ4IEnZxxxXB2msfBMZyE8l7j9s0X4PtPZvArel3Ax9x29GSZUf827HaZcEGrhyDUjoGHORahrlBZDegPjnTS1B4cvI0BxoCtb+J0QZU6035UsuOs7JlDrJ6pEoNXkpXERE4aIXUS6YE1o4QkveW6o0j3m27uNTMHf93j4yRueEs6Nc1hini06tblQcIY5LKy+Jd+XDGB6iSdVUsoAdy766f4UcUQroJ6x7/VCm6soQW8Ih0Sqzoc51iBYN03W75ZA6OmK0soEweFLQJDlwf29nH7BB63Zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(46966006)(36840700001)(8676002)(8936002)(4326008)(5660300002)(7416002)(40460700003)(7406005)(36860700001)(16526019)(70586007)(1076003)(70206006)(40480700001)(54906003)(6916009)(26005)(316002)(83380400001)(336012)(82740400003)(6666004)(356005)(41300700001)(81166007)(2616005)(426003)(47076005)(2906002)(478600001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 17:47:26.2695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bee88fa1-9a54-4a86-53e2-08dbbeb8a583
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5948
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

Thanks for the reply and guidance!

On Fri, Sep 22, 2023, at 06:24:00 -0400, Arnd Bergmann wrote:
> On Wed, Sep 13, 2023, at 17:49, Brad Larson wrote:
>> The Pensando SoC controller is a SPI connected companion device
>> that is present in all Pensando SoC board designs.  The essential
>> board management registers are accessed on chip select 0 with
>> board mgmt IO support accessed using additional chip selects.
>>
>> Signed-off-by: Brad Larson <blarson@amd.com>
>> ---
>>
>> v15 changes:
>> - Drop custom ioctl and use existing miscdevice interface.
>> - Delete unused definitions in amd-pensando-ctrl.h 
>> - Makefile change to compile for ARCH_PENSANDO
>
> Hi Brad,
> 
> I'm sorry I've been out of the loop for so long, and I hope
> we can find a way to manage your SoC support soon. My impression
> is that the normal support patches (1, 3, 4, and 5) are largely
> uncontroversial, while the SoC controller support seems like
> we are still not converging onto something that is ready to
> merge, so I would suggest you split the two parts and send
> the basic support for inclusion in linux-6.7 while we continue
> to discuss the soc controller driver.

I've sent a patchset with only patches 1, 3, 4, and 5.  Correctness
is the priority for upstream inclusion.

> Please remove any references to the soc controller from the
> dts files and send that first series to:soc@kernel.org
> cc:linux-arm-kernel (and the other interested parties) so
> I can pick those up.

Yes, I've removed the node for which the compatible driver is the problem.

> 
> Regarding the soc controller driver, let me try to give
> you my impression of where we are:
> 
> - you have gone through 16 revisions already, which is way
>   too much for a public review, we should have been able
>   to find a solution earlier than that, and this is partly
>   our fault on the reviewer side, and I'm sorry about that.
> 
> - Andy's latest comments and a lot of the earlier reviews
>   were focused on implementation details. While those comments
>   are helpful suggestions for improving the code, they miss
>   the larger point about the system design that I'm worried
>   about and probably don't help you actually get it merged.
> 
> - The main problem I still see is that this driver completely
>   bypasses our normal kernel abstractions and instead creates
>   a low-level passthrough interface for handling kernel
>   functionality in userspace. This creates a liability both
>   for the user ABI and the kernel implementation and prevents
>   any 
> 
> - There is a chance that your design is in fact the
>   best way to handle this particular hardware, but it is
>   your job to write a convincing explanation of why this
>   platform is different from all the others in the patch
>   description. Your current one-paragraph text does not
>   explain this at all.
>  
> I would suggest you prioritize getting the other patches
> included for the moment, but we can keep discussion the
> API design for this driver either in this thread or on the
> #armlinux IRC channel (irc.libera.chat) in parallel if you
> like. In order to help you here, I would need either
> the documentation of the SPI software interface, or the
> source code for the userspace tool.
> 
>      Arnd 

I'll redirect and reframe what the SoC driver is doing to
#armlinux IRC to find an appropriate solution.

Regards,
Brad
