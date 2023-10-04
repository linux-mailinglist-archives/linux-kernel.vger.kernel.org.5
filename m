Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC197B7E2C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242251AbjJDLas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjJDLaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:30:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568C190
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 04:30:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ho2qPpTtWJwbn6b/crA+NfW9FzRZ33fnTf7EH2O7lb/zJbgPKJ8cidxS2idpUf18F6QfpzDUL9fxL5DvcTAj21K8z+7Y4VgPpNCFxJg5xMtclww1PBqglbkb1L9+QFpiunQG+KBp8daReeHnBuLUDrguuVAldT4u1zsXEhmaSk7SK9njAlscXvNn4LUlnQvxYSfiEs1uMEJFCQaN5wdeO3+2MnruqqMuplPySGcrOZCIG3CghNlEr+NbkjFySQ2CtIlloAWLshk7MLOUIk0FwpduR7Odgy+6557SjQPaZvEGIFxA9gY93/3KUsPYZ5jlqmgbfjzp0nhdDYE3Sml0lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBu0r05ASFe/tOkVkAf0gj+R6oCJI/fmSQ3VXcMqi8A=;
 b=WfOct4uKzDos9GficT+DmQAAnb0ixei7LabdF+f1uCV69uYqN6wGYgCHuhfryhjzg1sQiUYbmD1kIXGugX8dobM1N4TkfqDAhPG8vPzmnewJIn8J+Hei8FS+qwqWRWHrdITp/kA85aLv0Rd7I/3HelZI6r54LOd0z1gXNhqA6TCI/FFEVLoy89DEKamE6XT3VFDE/cTGmqsDG07h/4X22WMiTImx6Kg87qERY/QkEWGzQmsoPVw0qVvxSoT+szXXVBquFNQ9kYwCcqjSCgY5pHxPhWrJQXpm/ec/RzEzup4KhaeRI1Ujtb5b/ZGWaX4IrwXlLtRxAjfXthqVdvhRMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBu0r05ASFe/tOkVkAf0gj+R6oCJI/fmSQ3VXcMqi8A=;
 b=Tw8+C1E9TWqaFcX95EBAe2666oIuZ5zgrpjMZuOQjrdShyVgzK+0xwLTgQIpuladj14efjVXKG3zN5y8Y2TRAOHukHSwdU7hjWVWznknmA0dAdE+H3sr6El6V4rcIywCfGrhYwUfCOQbpMcpD8AISOuY9Q1a7Cyr51gedDNvbJ4=
Received: from MW4P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::13)
 by MN0PR12MB5884.namprd12.prod.outlook.com (2603:10b6:208:37c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 4 Oct
 2023 11:30:37 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::a9) by MW4P223CA0008.outlook.office365.com
 (2603:10b6:303:80::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 11:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.17 via Frontend Transport; Wed, 4 Oct 2023 11:30:36 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 06:30:33 -0500
Message-ID: <7c86cbb1-f21f-4136-ae56-8c0d5771a335@amd.com>
Date:   Wed, 4 Oct 2023 13:30:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] firmware: xilinx: Expand feature check to support
 all PLM modules
Content-Language: en-US
To:     Jay Buddhabhatti <jay.buddhabhatti@amd.com>, <tanmay.shah@amd.com>,
        <gregkh@linuxfoundation.org>, <nava.kishore.manne@amd.com>,
        <ben.levinsky@amd.com>, <robh@kernel.org>, <dhaval.r.shah@amd.com>,
        <marex@denx.de>, <izhar.ameer.shaikh@amd.com>, <arnd@arndb.de>,
        <ruanjinjie@huawei.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Saeed Nowshadi <saeed.nowshadi@amd.com>
References: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
 <20231004094116.27128-3-jay.buddhabhatti@amd.com>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJkK9VOBQkWf4AXAAoJEDd8
 fyH+PR+ROzEP/1IFM7J4Y58SKuvdWDddIvc7JXcal5DpUtMdpuV+ZiHSOgBQRqvwH4CVBK7p
 ktDCWQAoWCg0KhdGyBjfyVVpm+Gw4DkZovcvMGUlvY5p5w8XxTE5Xx+cj/iDnj83+gy+0Oyz
 VFU9pew9rnT5YjSRFNOmL2dsorxoT1DWuasDUyitGy9iBegj7vtyAsvEObbGiFcKYSjvurkm
 MaJ/AwuJehZouKVfWPY/i4UNsDVbQP6iwO8jgPy3pwjt4ztZrl3qs1gV1F4Zrak1k6qoDP5h
 19Q5XBVtq4VSS4uLKjofVxrw0J+sHHeTNa3Qgk9nXJEvH2s2JpX82an7U6ccJSdNLYbogQAS
 BW60bxq6hWEY/afbT+tepEsXepa0y04NjFccFsbECQ4DA3cdA34sFGupUy5h5la/eEf3/8Kd
 BYcDd+aoxWliMVmL3DudM0Fuj9Hqt7JJAaA0Kt3pwJYwzecl/noK7kFhWiKcJULXEbi3Yf/Y
 pwCf691kBfrbbP9uDmgm4ZbWIT5WUptt3ziYOWx9SSvaZP5MExlXF4z+/KfZAeJBpZ95Gwm+
 FD8WKYjJChMtTfd1VjC4oyFLDUMTvYq77ABkPeKB/WmiAoqMbGx+xQWxW113wZikDy+6WoCS
 MPXfgMPWpkIUnvTIpF+m1Nyerqf71fiA1W8l0oFmtCF5oTMkzsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmQr1YsFCRZ/gFoACgkQN3x/If49H5H6BQ//TqDpfCh7Fa5v227mDISwU1VgOPFK
 eo/+4fF/KNtAtU/VYmBrwT/N6clBxjJYY1i60ekFfAEsCb+vAr1W9geYYpuA+lgR3/BOkHlJ
 eHf4Ez3D71GnqROIXsObFSFfZWGEgBtHBZ694hKwFmIVCg+lqeMV9nPQKlvfx2n+/lDkspGi
 epDwFUdfJLHOYxFZMQsFtKJX4fBiY85/U4X2xSp02DxQZj/N2lc9OFrKmFJHXJi9vQCkJdIj
 S6nuJlvWj/MZKud5QhlfZQsixT9wCeOa6Vgcd4vCzZuptx8gY9FDgb27RQxh/b1ZHalO1h3z
 kXyouA6Kf54Tv6ab7M/fhNqznnmSvWvQ4EWeh8gddpzHKk8ixw9INBWkGXzqSPOztlJbFiQ3
 YPi6o9Pw/IxdQJ9UZ8eCjvIMpXb4q9cZpRLT/BkD4ttpNxma1CUVljkF4DuGydxbQNvJFBK8
 ywyA0qgv+Mu+4r/Z2iQzoOgE1SymrNSDyC7u0RzmSnyqaQnZ3uj7OzRkq0fMmMbbrIvQYDS/
 y7RkYPOpmElF2pwWI/SXKOgMUgigedGCl1QRUio7iifBmXHkRrTgNT0PWQmeGsWTmfRit2+i
 l2dpB2lxha72cQ6MTEmL65HaoeANhtfO1se2R9dej57g+urO9V2v/UglZG1wsyaP/vOrgs+3
 3i3l5DA=
In-Reply-To: <20231004094116.27128-3-jay.buddhabhatti@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|MN0PR12MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: cfeb55bd-ead7-4564-be6b-08dbc4cd54a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBU6M5RhiE50hCIhBph2J7XLGM4DhOaPtm6IjqTQBwSEqlOtwoes1lBwPgkKjbOvlaXP5sJCSR6N0NBwXL37QuhjDY9WF3cLiuuSe+/aH+Huo4KC0nNt91horEW54eieBQivzKJLes3ZYcEW6VfRCzjCPgvXKYbYLOsUtHifB4lmkyCW5bYoLjiYrJV6rF4/6GIrD1MwBMjr0NeBm3GnfwVN2vFriP7D7HC5JUyR1k2EeE/QC7RtyumDxKOjDttMe7mm/xhY8WXvSvITnIwHCDEEYxzjfx/cG6+NbyGVt0evE+CTQ2CEV+docYk+giNMvxKJmnu4Byvg8h4F8OkASkKsVBGAjOEPm3kiu1Bw1s/hIAUahciMMWNi7vFlWEgib3kV3LxSTdJAqVRKEZa0Ang76DrOXbc3q4k+fSak1v2aq888uu8CIc4oVnVVzsINHqWAvvf0bNie4mAIrORBmJI+l0s8anAc6UPZeWxJnhtv7cyQZVCcRYmeklvmzXmX5ewLsp5zLRKev2eiSPNozjNbQ/aZO+LA6cHFFBuIXj3fVNfKNafPISbPwMPezdI7mDBJ0entHxU8/b1JgIQyv3JKoM+dZfPyiuS6wuGL6J7lo84xcFFCJYH4uS2GkXHiq81Wqov20QjfK5jip9IWsAZsOQdA/mKv2VupiR2kAk6hpfeTj2ty+ZlaizT9dBBKLPlo8hHDap6WtJ12i9IB6+ifFnydQKoGz7s5HNNpk1RNletDGN4a4AGE5zpdKUVy6F0iIsGLdwerVGA1Kf+GrlirVdY2D2184RRz93/yz9izy6Qi2WQWw+gBjsE59J8B3qEmCfUPb5Kzkgf/OxUPag==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(36840700001)(46966006)(40470700004)(47076005)(2616005)(426003)(336012)(26005)(53546011)(478600001)(16576012)(41300700001)(70206006)(36860700001)(70586007)(54906003)(110136005)(31686004)(316002)(16526019)(81166007)(5660300002)(82740400003)(356005)(40460700003)(921005)(4326008)(4744005)(8936002)(8676002)(2906002)(40480700001)(44832011)(86362001)(31696002)(36756003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 11:30:36.8982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfeb55bd-ead7-4564-be6b-08dbc4cd54a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5884
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/23 11:41, Jay Buddhabhatti wrote:
> To support feature check for all modules, append the module id of the API
> that is being checked to the feature check API so it could be routed to
> the target module for processing.
> 
> There is no need to check compatible string becuase the board information

nit: typo because.

M
