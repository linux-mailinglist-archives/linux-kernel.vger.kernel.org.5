Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5864B7ACEF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjIYEAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 00:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjIYD7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:59:41 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2050.outbound.protection.outlook.com [40.92.53.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D1210A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 20:59:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6xW+jkmakmf2VM/sXPhjhBEZ+rQti+gDTjzjrha8+2IUiJ/pBwBFMraD546z6IEHfabuen37v7DNwhH5BOhCwaOTXq4yOzT56TcD3614F/uvTlUnAOi5G28Lvq/SUGCFSF7kZVROKylzaGHrGIj1ICyW28gEOrkHWqFQ+yyT2GonVOkYfEHpi3eSm/Rj8f8mdJdo9fR/PhEpwTcPW2JydCYk+4XP2RRSkkrpDChO6nkQKjAjS6pI7SqAnEDVXgIByGKhWI6oHLNJg7nPxtZXjb7Z7kjNlNP6nKpqBASKDDuNcRxe4xo+HK4ZxzxG5G3aQuESGHdD2/Pi27iqDjtNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lm+anXVwSRREiQT5tWz8cBBHoJo+VmNh5WvxoqSawgM=;
 b=R7xmH9z2gLQVB5JhYNsiMkGL+uRtV1//cT75vfgVQ0XvSzoKFjaIrSUQsGj9I5ViYnVmSO8/OGjjN55qn4JOUc8l+ktaf7wl/Sl+WGpQB4qucmsAh9DXKo5Fhq/en/yZI7Pn9GTmihkYrsxun3NXKmUoYNZ4FB0yXsJoy5+zFthINYyhXP0cLkoiMMdS20YjdxSzNfNIpNQ5ZNQIqedly91CWQ/1qTcXrXqMwCgy1TJpd9cXgWEl+xNqVY0JT2uctCqldDoz/sPlgDK4KWrPkTlovkgi4DA27TQ+5rYV+tPlaXjvXLb6DvcAfXaJCvxrj22Wv2W6xbG+wjWfHF6/uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lm+anXVwSRREiQT5tWz8cBBHoJo+VmNh5WvxoqSawgM=;
 b=PBMTZclity5Dkd1xhJpOaE6nMHTsehNxcaqvHxYcndJYOF5cakkmHEAZIztdmlf5Hgfle83n1CmbWQHlsNUw0qNx1gaFn2YOWUcshQZY0MJQ2crM49UC7iZWtUpq55qLS2Cp5/W9gm05ghGiNalQJbx+ZKP4SEacAokQMseUtogjpxK4egFFm1kOXCxpd7enUm0MVUHJUPB6S/6fWf87N9y08FSj/ElxL9FSVqfsB34fLwH7v5Lx3n/MMBOjFG/7LD5gWp9a1ud3Z1iepfUAaN846sEUB2UeSjE77tY1BzoC+oW6HpY4JWPBOcThy79j3wRAcMg0dIg1E2c0MMPfyQ==
Received: from TY2PR0101MB3136.apcprd01.prod.exchangelabs.com
 (2603:1096:404:e5::14) by PSAPR01MB3893.apcprd01.prod.exchangelabs.com
 (2603:1096:301:21::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 03:59:03 +0000
Received: from TY2PR0101MB3136.apcprd01.prod.exchangelabs.com
 ([fe80::61:7bba:9541:ee98]) by TY2PR0101MB3136.apcprd01.prod.exchangelabs.com
 ([fe80::61:7bba:9541:ee98%6]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 03:59:03 +0000
From:   Kelly Devilliv <kelly.devilliv@outlook.com>
To:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: dma_map_resource() has a bad performance in pcie peer to peer
 transactions when iommu enabled in Linux
Thread-Topic: dma_map_resource() has a bad performance in pcie peer to peer
 transactions when iommu enabled in Linux
Thread-Index: AdnvZEYkV1103f9cR66I8K02bYRACg==
Date:   Mon, 25 Sep 2023 03:59:03 +0000
Message-ID: <TY2PR0101MB313681440D640B215C5DF5E784FCA@TY2PR0101MB3136.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [brlklJ18Ly5s5OTEATEulY8YaXH04SB8]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR0101MB3136:EE_|PSAPR01MB3893:EE_
x-ms-office365-filtering-correlation-id: 0ec75ca3-0980-486e-d454-08dbbd7bc1d6
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bJle5TuL0U3ucThLIYyFcsxrNDkHIM8hr41XweCZdXTkyTb2ZBBzD+HJMQq1/VCH1hb5v2N5Cln+hjWhKffcsanmNlQHyOcBDBFXtPOb5DYoh51flER/RpNOyF7oONKIJPkTCdBZ7bJLeJxUovL39JiUSf6+L2KjXyLPplnNn2+dG7BNyh/4QtVXqmZua4PVSCKzTKfBTFvxdX2cGg1u3TJ3kBhByFKpIpD32HsPHMIf9dN0FEkTc0TS/+c95RAMUw/WYp3cjXOZXUjbNpqCvNwwSzbKPyMeiOrtsngTbneN/T/hkoyhj2VnSJWRudeh9XeHixdcDP87qPBPhwT6z+fnWNdTJ6MGlbsyKC2JXIDBfBDZoejd5ybFQx3kAwGZLfuBuq+nwLjndGUEGX4ok1NknXTz+pvwzcbORreimlq0JvfdX8GBXbZHQjg/0/frcg1HsB9O17un+Zoe3NT1TKie0zjJxZksEbPFMhyDfOIZDL7BI4ZCgdkA7N7pJH+J1hq8Ko9Y9EfRXGX0btHs5EXjVe+ykhID8qF2zJY/ZqPxmkse8TdJxv5wXRtuR34g
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZdL2aaLxpaqbi/4qg9A9azfU8n9yqQtamXFwQSjOxZc9OgumNKJFtH7buxiG?=
 =?us-ascii?Q?SZHViX2lru3rNavnHh1uPdhPP5lREwBq43kViRLE3qJAQrN/5cb1Wms3iaYL?=
 =?us-ascii?Q?28QyYPZcXWq1junpabfeD0E0Am8kJ0tvki1BXU/yZIhbC/ll5kmMwjnMYw0V?=
 =?us-ascii?Q?w+Nr08tK0eCH2cASQ8AbbjwXTatMXs/EmHN3mtde/prYbNpsRGsVK2wnxC+3?=
 =?us-ascii?Q?5LeSYh+jOaQTmwTkxppB9VKNVDxuQmctYzrvHLJZuSkF9O2te8vUrxaJOl67?=
 =?us-ascii?Q?j+NUbOJwRniaHktjWwx3OFq2x2xGmm0CQclly374tHDVRZQ86Rq1utL9V5WX?=
 =?us-ascii?Q?CX+uI78vG4Y1w5yI5CB9YKXCsMXe8g5R+68uNWSIsAXr9+AosBCrjhl8LMNK?=
 =?us-ascii?Q?POn3q9z6IlR7qzHLmGzrlV+qcJp9Rrhent6tcICLNjc4LrJG41mwoBh5Kdz4?=
 =?us-ascii?Q?jBTkdXXmd2DnZddD0+PzZTCPbzEj5qZjSjkmWwqeql3BTDRAManLHAtjExQG?=
 =?us-ascii?Q?CI96soMDiN+dndm3pPG1khwvzSB7G1zWnMvStQbazJY34ebMaP3t3sCpBI4D?=
 =?us-ascii?Q?eKuiojfgozzl2NR2CZYOHaP5hWPADqz98tsYZZ/7eniPiBxAfWiC8onf0Bqg?=
 =?us-ascii?Q?iNaUwXpOyxV/hDzLbV4kJX1v8jaaZ3yaQpwdbewaLxZqN54ou+GM2/Y9I9Lq?=
 =?us-ascii?Q?kDxUaQT+batm8PUKQI1i7X24g1JtcZpEXUITjY5ADUSfgkXLijymvCPiUwcY?=
 =?us-ascii?Q?ZZowm102pzX6FeY+b3tTSkhRz9089N7UKilZmCrgLetnOpm2ZYMy0kLbMYUJ?=
 =?us-ascii?Q?T8j0SBRv63RwaROb949nDc2NvOxV37M7MkaLt0AP6ka0ITowX34Y/yAypGDX?=
 =?us-ascii?Q?lN/zPaL0lVy9Grk/BccJGnyMkkd/p+TwMjZkeJ5LptMal9n4yhxjRvDZfVb9?=
 =?us-ascii?Q?bxjA+Q95KvKKvvMXQ0UzoVDtDn7jzRmVIFBoh5hTcg7a3laTigRL62JNz/Jr?=
 =?us-ascii?Q?Rq4bd5AG7v0BUk4HtAYnSTbDZkDO4DTTszL1d8Mx9ibOSJC81B+Hndtrg/MA?=
 =?us-ascii?Q?9SL97rFJaoYDCYzuD/GS1mueK5YqUpbRWrB3L/I8K59WgVTjB8UKl4RePBmM?=
 =?us-ascii?Q?fQQvoxir6c5isRbqY3sUOdlN1dwsaWYQN7ho1tCmAeqqfjcJrh8gJgeyBa7x?=
 =?us-ascii?Q?OQmJK99sNvbgLN0jgTtFZky908v8w6wuLTBErw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR0101MB3136.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec75ca3-0980-486e-d454-08dbbd7bc1d6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 03:59:03.3502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR01MB3893
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I am working on an ARM-V8 server with two gpu cards on it. Recently, I need=
 to test pcie peer to peer communication between the two gpu cards, but the=
 throughput is only 4GB/s.

After I explored the gpu's kernel mode driver, I found it was using the dma=
_map_resource() API to map the peer device's MMIO space. The arm iommu driv=
er then will hardcode a 'IOMMU_MMIO' prot in the later dma map:

       static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_ad=
dr_t phys,
                                size_t size, enum dma_data_direction dir, u=
nsigned long attrs)
        {
                return __iommu_dma_map(dev, phys, size,
                                        dma_info_to_prot(dir, false, attrs)=
 | IOMMU_MMIO,
                                        dma_get_mask(dev));
        }

And that will finally set the 'ARM_LPAE_PTE_MEMATTR_DEV' attribute in PTE, =
which may have a negative impact on the performance of the pcie peer to pee=
r transactions.

        /*
         * Note that this logic is structured to accommodate Mali LPAE
         * having stage-1-like attributes but stage-2-like permissions.
         */
        if (data->iop.fmt =3D=3D ARM_64_LPAE_S2 ||
            data->iop.fmt =3D=3D ARM_32_LPAE_S2) {
                if (prot & IOMMU_MMIO)
                        pte |=3D ARM_LPAE_PTE_MEMATTR_DEV;
                else if (prot & IOMMU_CACHE)
                        pte |=3D ARM_LPAE_PTE_MEMATTR_OIWB;
                else
                        pte |=3D ARM_LPAE_PTE_MEMATTR_NC;
        } else {
                if (prot & IOMMU_MMIO)
                        pte |=3D (ARM_LPAE_MAIR_ATTR_IDX_DEV
                                << ARM_LPAE_PTE_ATTRINDX_SHIFT);
                else if (prot & IOMMU_CACHE)
                        pte |=3D (ARM_LPAE_MAIR_ATTR_IDX_CACHE
                                << ARM_LPAE_PTE_ATTRINDX_SHIFT);
        }

I tried to remove the 'IOMMU_MMIO' prot in the dma_map_resource() API and r=
e-compile the linux kernel, the throughput then can be up to 28GB/s.

Is there an elegant way to solve this issue without modifying the linux ker=
nel? e.g., a substitution of dma_map_resource() API?

Thank you!

Platform info:
Linux kernel version: 5.10
PCIE GEN4 x16

Sincerely,
Kelly
