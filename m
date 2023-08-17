Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E3377FE2A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354608AbjHQSum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354597AbjHQSuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:50:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4069419E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:50:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jM+TSOSjiNkvOWhcevscBMD14U5LqIpZe41+13QW7ld6YDf3IpsZ/OtW+AboRMJamQjyzBdyUo7A2YNtV/fyQmSGRt1q63+PzlxEnsw+YeffXXe4cQ8W9FENVADEXvB9R3uyIY9oF1pJ6ZwGznaHdGVRPPCLiLFxdZGstXgQVnfw3ffEA4T6Flq0q5pJxy6iayCDtXQjRjpZ3FWU1TEs+lJsVyhwI0jkTOhlG2m4NDHnAOS6q+N/szjFtFxz5BFRTv8Fx3Uk1f/pK75z4eLlEXB5wI8DigK1REk7F1+oD0pI7F6/TDKr8vyzcp/0ytNGu4OYh3ePKNuR+GvyDklbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deDcmCcNikMgzkMXFYU5ABh36E9f8F/7fvmImm8Uh54=;
 b=G8yx5fdyyJU8L4Mwqyp+LQlNvgjp9vEXqvI0hoRnaHqM9YoIyYO6rgXonpN9XiSYKoofTZWNXgM7Cl3pQe+0elF3Goh0NliQVihuujAznrI3f35kA+L/sLwvYlpJe9TlmZBWOc+q68M42Sjp2QgHuWecIQu6djFOLtu35L7TcNiHI/Fa+uAS7IadQkOh56UnLiPvnGc6uQo88NOtVhvqQv+MRrmsT7Hapl8xmE7gJO5RdzrCwohbGy5vPxvWW7RrPR4UtwnRuCTedaLlBMxXbFFexG2wgIycJJrQPnv/KKuqXSfddFGrZicBMoJDwiOqczgPqwmHELCagMOk18sZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deDcmCcNikMgzkMXFYU5ABh36E9f8F/7fvmImm8Uh54=;
 b=g0W5XVMMq0FV0sjq99ZdKnb2nDrfQp5PQthbWUXsFZT4UHmJTqXtnZNyuNPtiZoew3JGm3aXCvGJzuQxsWLAw5acVqDJjbokx3iD8JBoGWMLKJaTmUrlTkut+0sMIl7nTLSM2oMDzvHNB8sCC7Itu4fnqBFN4LlIEsSpJjiWGN/cJAWqjAqsBD9lpsR2RDd1ffbhJoId4IbtMl7b3loQbHfNUlvwGP9vpYWvWO7GhCAig/PrrY60xfjmdjmcAIsNCkW7w04EW2URFaBTra+/16YVvlACwXXOD+/rKk2w34kaCF7sy1PUhz+sMOtDrhjBwQ/GHWghwDr+KoVMoyvarg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 18:50:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 18:50:16 +0000
Date:   Thu, 17 Aug 2023 15:50:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org, nicolinc@nvidia.com,
        tina.zhang@intel.com, jean-philippe@linaro.org,
        robin.murphy@arm.com
Subject: Re: [RFC PATCH v1 6/8] iommu/arm-smmu-v3: Free VMID when
 uninstalling domain from SMMU
Message-ID: <ZN5r5q4j8hcuvYt/@nvidia.com>
References: <20230817182055.1770180-1-mshavit@google.com>
 <20230818021629.RFC.v1.6.I65dd382de382428dcb3cf61342b35405903ac768@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818021629.RFC.v1.6.I65dd382de382428dcb3cf61342b35405903ac768@changeid>
X-ClientProxiedBy: MN2PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:208:160::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9542ca-e01a-4e89-116d-08db9f52cbc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGeb6AyYOt9rXEnMvdPCMywRscoA+4OpiUrPDgBi+3sPnpom42A6q6XC6/gSn0eoRBT3KSnYwfOfyXa8vJcNBucSwne67dDBBm8JDZD2h+FtGPG/nu+bQDMQSavLHecumn9a9ruFXnSZs54R1cBIhGG0j+hduGZxMf54RwJ5H2iUv9hXOJBBoIn0aLXLzp6D/MZaEwQwg3Zo/mvwDxPSbUOZgbKnbVkpe8QfQ0fYwFEFapll5lWewItYhkquJx/Vai62b9YghqRdWWV1iG7ToUskj76L81o2msujITjXN/4O/nuYE3QIMqk5qNQiJevwSvoEkbkqB5O+2pDh6T/9HC5ybMSKKgjh721AT7fDdeSEtCfWqzAmJ85DBhQC3hCTNTOwrt7iPWkky9Zz6vhFLXsR0EE35jaEvumCALL9Gdj0sQmNW9c7c2MV5P9c/oZ+bD1LPw6gKEhn6bPjmoObdrnkazsx2ikwUpZIiaySWm4q8lQcDAl+o5iiJ7PY64YSnVkSjrm4UrtI+Im0fNN/O0FeBX/yvgbITZ/BIJhACcKhlWH3ONThleZjmlvhuECI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199024)(1800799009)(186009)(36756003)(86362001)(38100700002)(478600001)(2616005)(5660300002)(66556008)(66476007)(316002)(6506007)(6486002)(6916009)(66946007)(6512007)(26005)(41300700001)(4326008)(8936002)(8676002)(4744005)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qbuDWDwNqGpaCNEofESipnnkyixvmy3igvP3fItBcd1qtmrW3AMSbyWzgHZT?=
 =?us-ascii?Q?bGRCBTn/6j5XRExwJiE3MlnivfXiBLMiaUVnYGrFQnlt1puO7ONBX+BIU1lf?=
 =?us-ascii?Q?UhtmvI3q8mE8qORpZLGgT86zJYQ2HdEWY3WMfo6H2TEp6/7VSCx4hcQ//pNd?=
 =?us-ascii?Q?ISV1TsEy6+72aExK4traxxGeszWEtwwtNEk38Coo481boXHdKGbpLUBWVt0A?=
 =?us-ascii?Q?KlGLXvwZTjm8ozy2l90Cg4m3sjNWD6UHLhv0tcI8qSZ2+/EN9QK9+Bbb24SS?=
 =?us-ascii?Q?1dpdgS3FZw8Lco4bqQjA64bdlvl0n6pyhcre7XHFzOOSZoc3F9Crn6WzuRdt?=
 =?us-ascii?Q?WQe0zaZo6e8hvhQi6E+nY+5WawEccHyHQ4Ui7Wh4tfoWJttnpcghPvKECRWs?=
 =?us-ascii?Q?kgp5YebD8OGx+CYN6P1wuM6t+maNEbl/HPX8SGAVC5gTGMvtZwdyu5JXvWga?=
 =?us-ascii?Q?Bj8cHcgbqK0dyk1r2heoAnGXAbz7tYKmHx0bK0Ilqbye/ofXO02sXHxmFUeD?=
 =?us-ascii?Q?f/gziy7X6t68qqYQVqdgD/c54rYuPwGNvdS3d5E+O4zKf1MJiZPXcNm5cs8g?=
 =?us-ascii?Q?OEaoCLPsVX8WUgz+45aUZl4rmRQAoILNb1QESLZyzw97yBFZuQ7zOVp15zqo?=
 =?us-ascii?Q?wnvyGTRAhiqiAGPSjzGkMYlTQDsyti1cp5svw0riq99V68vQg8cOoZuxUYkl?=
 =?us-ascii?Q?yNcGHEWeZgWfb36vlzONIZ5Ae5ASVjKp4yR4PJDisFBeF2WqfK0YI27JJ4YG?=
 =?us-ascii?Q?/vdSXrf8zR2FSlEDxpjFg8Fyll98vkxPHHhOSZZPyu+3kmYeCf+h3SSC2Iir?=
 =?us-ascii?Q?0ol8TMH2a1XUJMKn1yhkiM8d1D/EltpNh7ntkuUbc8a6llZ6WQTjtXYqHKeg?=
 =?us-ascii?Q?njwNmArBkXgUocqQE1rMQpe23z4wKlK6XwOvGYevILs9YXBi54iVwXZZwSx+?=
 =?us-ascii?Q?1hHlCHq1ikNVLdxB0gQxUavyFlSH7jn6w3NVvOefKgm2x4eH8JIP1Gle29MA?=
 =?us-ascii?Q?CojsNFA6/nCfWiHQft0INw0izOEQKUa+lHI0RNwh2XFAVJdklhhke7fc6pPL?=
 =?us-ascii?Q?1YWYmrthh85XwHl46oMFNuw3/9J9LozLu5gQmidNlgnhbczY2eXAdB8Zj/5y?=
 =?us-ascii?Q?Pdx83XQmgCpmje/o7mfGGp2L3gN9mJsHIFaic4S93T4//OLEa7aQvWEZWJGm?=
 =?us-ascii?Q?FR93fbTKvCVCFmebhJ3YXK3fkaHhCK2PzEMeQzePFj/vzuPa6teN5SuEdDIo?=
 =?us-ascii?Q?hdwZl9X/iyk7gpOvvDxdwIF1myxq8Fs4j1YYklR3jzbn66QhO/ELsdsw+hgX?=
 =?us-ascii?Q?MWu4+J/uSb5UO+CtnvC+SKiRXjmewNkMxyr6ehuPemRLbozhdce2WslO/RH6?=
 =?us-ascii?Q?M8+kIhOeSZYfHK1WGurjIUIoWSW7ATlodmWUjACN7RAz5553Vga1XXq0V9N1?=
 =?us-ascii?Q?pEJDZEMxrsT5zkpUJr9hcRvDyS17Hw3jled4aDNyqO1rnlkv2ba6RJN7mGQe?=
 =?us-ascii?Q?3FALwdgO14ulXtEoKeMk+b3RRKhuS3Zv07NwV8FZcyJWNhP0Q1V4tRziwbp0?=
 =?us-ascii?Q?JCGb872DP7BBkLkbEOVJL126T4AakOpVGQAF+CEg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9542ca-e01a-4e89-116d-08db9f52cbc9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:50:15.9816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8tzS8f8v9u85SXT6hav2LoGUIdnitspInbLinggqHYJkSekN5uzF+46p1icEunr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 02:16:28AM +0800, Michael Shavit wrote:
> This will allow installing a domain onto multiple smmu devices.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

The VMID is basically a different ASID, eg ASID is the cahage tag for
a S1 and VMID is the cache tag for S2.

It is strange that it has a different lifecycle. It seems like the
issue is that the VMID IDA is per smmu while the ASID xarray is
global?

So, I'd suggest consistency. Either the domain ASID/VMID is global and
assigned at allocation time.

Or it is local to the instance, assigned at bind time, and stored in
the domain's attached device list. Some logic is needed to optimize
this - probably keep the instance list sorted by instance.

Having per-instance cache-tags avoids the limit problem a prior patch
was struggling with, at the cost of some more complexity in other
places.

Jason
