Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936427D0F0C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377012AbjJTLr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377128AbjJTLr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:47:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA226D49
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXKp2WwEK7zfYOsHyXhuRHIJfK8Di/57jMP7D1+xZZOv3XuSWbaX6WzBQDMHpcicaw56y/0oDXyyeL6KXw80wISsw3b5JMRiSax8zO7NlIVkJB6FAMWH+xEaf2ANZh0oKtxqT4KFhqiTUTtPSXnaWL48UBq6jTvW4foW648Odb8647eyDBMA71TKpWlCA15zl11m4xp+KU6ycs4qj1Ovq02gpSdGMmZETvctVd+Uq6TLc8hawaxzbvml8lZF3ERZX97k0IKK2J+5YzTYjdWJrk0k+G+liZAC4DsUFmizN9u0wVifz7+eJ2ukLnD5WF4fWv+OWYPtALYzry+DkcwYlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ib9XBlR6hnORTwEmBz+x7QVjgqFFmiYMiRlPOLI8S/s=;
 b=lzzhgjWUb3JiFWq0QEWGHMLqsi8z2aLWG7GzQKfWHCxFQsu2wLDxn0ybyZRNAw/8UaIo5b5n6PvR2u9VsTBNVr3VaOhWuuYM8axS+dpit5z33fn8eXf3oiL/+4vvqnn9XbnVlU7hg8ZimxZ/ban4vmTMCc3VjnNuAO0NSLrPEZKLv9xN5ErvSN+8DI029pRmLJRVaJuNSFVe01JdlY7ruBtHfEXecoztIPedOdgdBQAVwY+SzGVRPXisybowGQgl+9l3fBDGDvhDi7FN4uJN8REt7qb6bkdWUGAZ4TQIezuUy9LpWqtv9VJLFnAlVmdKBJiJ25cL9fHQt9setfwzSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ib9XBlR6hnORTwEmBz+x7QVjgqFFmiYMiRlPOLI8S/s=;
 b=I18AdOvgzdmDehtDMmW5BPa9Y5Xz7LTzxyzOwE88yHY4XHMJsIVBabKVp2F4orj4S5ShMkYF+7KCywX+qWofvZkuwBR0W3jvDdjVdgqevPortvHK/gSzdueDUWTFa60Rto6N/+h264ZaQ+SIBhoPGbs4lWP0cjiM12MTpjnTWeXXFCoBbrb2pCxt/Uq+/5Mnp8nOIXolv4ZHk5kTuwVuFMOi7at4p0ZUnIR23jv4yXetjSJrhsUPO9mRWqJ5swfmih4jf8kJNoGojUDJ8INEuwvFxXldDScbVjr5/zKd4zUIMi5pXVi36VWBEyhEgNXve1/iZ5R/18hfVHWgxpDVdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB8956.namprd12.prod.outlook.com (2603:10b6:a03:53a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 11:47:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 11:47:21 +0000
Date:   Fri, 20 Oct 2023 08:47:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, ankita@nvidia.com,
        maz@kernel.org, oliver.upton@linux.dev, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <20231020114719.GE3952@nvidia.com>
References: <20231012123541.GB11824@willie-the-truck>
 <ZSf6Ue09IO6QMBs1@arm.com>
 <20231012144807.GA12374@willie-the-truck>
 <ZSgsKSCv-zWgtWkm@arm.com>
 <20231013092934.GA13524@willie-the-truck>
 <ZSlBOiebenPKXBY4@arm.com>
 <20231013134541.GP3952@nvidia.com>
 <ZTEN_oe97VRWbnHb@arm.com>
 <20231019115142.GQ3952@nvidia.com>
 <ZTJizmxV4Gtb4g3S@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTJizmxV4Gtb4g3S@arm.com>
X-ClientProxiedBy: BN0PR04CA0173.namprd04.prod.outlook.com
 (2603:10b6:408:eb::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB8956:EE_
X-MS-Office365-Filtering-Correlation-Id: 075b1314-11b0-48c7-e415-08dbd16251b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qoVsgqeLJx+fRQknyvicMg2wyiu3z8VT4QvhpzFxTx66jBUTk6xip4MOXwTYjE/tpkU3sBsuE6lrPlZAzCK3s8WKD2iIPioVJcQAAw60nlR4LDsPO0ghzK/KOomLZDGc1bxgoChKMSXGA4RpbpmX4DLWdcB8nC/uJfNt9GskQ0lTtKpBsFmc5duHjifJWZMIh3C6sC0oGPrDgPYMytboRfizFGRNcTkcR8jDtAZdpCBB4gMbWp0wc2seWY3nfswtAtMJgB6WUuj+BLB14I1vsGJI4/QRvv/pzw00XB2V6aJ7q5LVavndtYALAvP0lOA4Gm776iAMLvuG/tcS+S7rIDypMoA3NJCoLEZGhrzIyAoy9UOEKFsMUiYYtLR5o4ZQpGGOj4y0RPhqLfbjp5XnuGcfRmHyHwMAyOxrrbt+VlTajZN90oUshR5SHvGbb7ZFw1ZfgJSCHcdy1qZskJyzAt0IeBEjH6yTw97CZAI/WAlMAbtSdvi4SCoJH75TYcsmtBwbwzoJIhT8xxE86weZad9v/7xS3vSOHDTELVbgz2fIQzSmyYqGMpNIyhzNKh5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(41300700001)(8936002)(2906002)(5660300002)(4326008)(8676002)(66946007)(6512007)(2616005)(66556008)(6916009)(54906003)(316002)(66476007)(6506007)(1076003)(26005)(6486002)(478600001)(83380400001)(38100700002)(86362001)(33656002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?508zRRgYQPNjJm7IjaIJOmYXEpD9dbYPbTbffLg1kL9bl2a7d1/ENKi+MI3K?=
 =?us-ascii?Q?fdjJI4DqUhEzamNMkUpwch1m49S3DbDe7VhNZ1mRy2YC3KtBdCAuV1HrDzJ6?=
 =?us-ascii?Q?FzVbPuqmIJeZzvAkwibTOLOH6UeT72ecz34fMv4qBfJahbM+WZbCw8tBzcOT?=
 =?us-ascii?Q?U+R33Rz3f7ZMIXyHzveD5gCbvU5CNGMDLeVxpwX+wUje811tT6xliVqQrOVn?=
 =?us-ascii?Q?JAcrBSEiuccQy5IcCuW1ManPWevYvgYRYbLnXvmkBam6SP7FiwHJ8YOiTegE?=
 =?us-ascii?Q?Z1ZkRo5bPTht9IZkBfVDwMmFLtSfwlvLCB4lP3weaPU3cfuLO5AXQmv59HPm?=
 =?us-ascii?Q?rnTHKRrxGiobVlWISZ5JghQhUi1Bf7LdeJL/qempwGYP/nGUZkeESJWtYpoH?=
 =?us-ascii?Q?2Q+raGXNv4RQiY1cIhKoW0K+SAMWeFQBR5i4XvMeB/ey70vbpYiJnRj269XM?=
 =?us-ascii?Q?cOa5fWHLmH/a4mLG6rOdCulwpJYH3TGvI4MuNxvEtKTrEJCGEeKdLFegx3a+?=
 =?us-ascii?Q?0kWh+PQOARD4v9WvYY4rVBydhUjC/X2pxqvXVf346SUXyBYxpOz1Xatg2NG8?=
 =?us-ascii?Q?WfuSTorbxGZXvh9nHifTPOMscg4g+AgY3NLQDC5l8QYKhMdnyXewHww20PN7?=
 =?us-ascii?Q?Ffk/M4cHszzgq6rZRDQWAyrfYihRVfwVwnQB1QQzxO4GbfIiZoMEbp9s9hEj?=
 =?us-ascii?Q?cRW8D2/lChuUfSTKO3yoagbLO2fQNvPZVGtgUXn9nYTYejCNlRCIAwcVGupw?=
 =?us-ascii?Q?QeUEeLPxoZ2rDVw0DWzGzLLmbN2pL07o0X6FWpE3y5LjstkbKNNlSPJl3rQP?=
 =?us-ascii?Q?WAuBauPY+Wk2Z6vFuCvBibA1aO9cmJ8Fm1WQvriFOahItWeF2AlTwWOvS8Dc?=
 =?us-ascii?Q?ZnJzHglJK+orYsIfHn7I2tSFskfe2R3xbZWC8i9BmTQIjzDiywnn+aYsJ9ig?=
 =?us-ascii?Q?sxGDRR/S+lsSQNomd3X/WOsJjGuw3+uVxi34XvHbpbSqdrHwHvSdez/H3RWx?=
 =?us-ascii?Q?Tcy70NOHL9979mZZbQoG1i8tcI1wLXS87aXKtvLwZ0vyeRb5G4QdvNQEIcvL?=
 =?us-ascii?Q?kVKeRL3Vq4n+QRaX1Zs5jUg24IgplGXQHux3UCtBcXCxhqDQjjGTSw+wz58C?=
 =?us-ascii?Q?/Hb+nRwPvUyMkIEqOYspdnhQAGjb2ge81gDlZvnpKOMEuHXRCIk8tOHkL7Zh?=
 =?us-ascii?Q?qYlA8TRBFO4dKw807p0olXnnEtQNMxYUAbbajGhA3+swN4YDtOpkDYQu7e6k?=
 =?us-ascii?Q?FireH4U1mW8A9lgTGNprvpXzGL/C2iWnNX8Vk+sy9O48cHeDcp3GEYteDX/G?=
 =?us-ascii?Q?iVEdzAiElwIVGh9cBj8kxC1Ze3w7gDQ2dFyDT75ZQEbtdaULWbKd5vb0as7C?=
 =?us-ascii?Q?+ATEO1ei2IgzAvG1cJ9x3IJcAjLTkR4gsssrxCSGKaAKH7FgXeTrewurukW0?=
 =?us-ascii?Q?ecoNIAbqhO4E14Of/9/fRkbasXrmC3M66fUHkU0tlq76c3qVYNtDOKlxXaxJ?=
 =?us-ascii?Q?AcoSTYSxwIdm5Y3/XgZ7IzHBvzOCrFHK3tvMN7OCeJVZqvMzY97gzPYOL7cN?=
 =?us-ascii?Q?Sg+5OJVYvX+0BWXZDWYdQ2q7WF3Co49l/NRyf9xN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075b1314-11b0-48c7-e415-08dbd16251b2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 11:47:21.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ld1mK+N1B4Azr5J1SQtLnMaeOeFwIu2g/DkDBaHcvzvLnobmW00p2HgrNgDklFRn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8956
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 12:21:50PM +0100, Catalin Marinas wrote:
> On Thu, Oct 19, 2023 at 08:51:42AM -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 19, 2023 at 12:07:42PM +0100, Catalin Marinas wrote:
> > > Talking to Will earlier, I think we can deem the PCIe scenario
> > > (somewhat) safe but not as a generic mechanism for other non-PCIe
> > > devices (e.g. platform). With this concern, can we make this Stage 2
> > > relaxation in KVM only for vfio-pci mappings? I don't have an example of
> > > non-PCIe device assignment to figure out how this should work though.
> > 
> > It is not a KVM problem. As I implied above it is VFIO's
> > responsibility to reliably reset the device, not KVMs. If for some
> > reason VFIO cannot do that on some SOC then VFIO devices should not
> > exist.
> > 
> > It is not KVM's job to double guess VFIO's own security properties.
> 
> I'd argue that since KVM is the one relaxing the memory attributes
> beyond what the VFIO driver allows the VMM to use, it is KVM's job to
> consider the security implications. This is fine for vfio-pci and
> Normal_NC but I'm not sure we can generalise.

I can see that, but I belive we should take this responsibility into
VFIO as a requirement. As I said in the other email we do want to
extend VFIO to support NormalNC VMAs for DPDK, so we need to take this
anyhow.

> > Specifically about platform the generic VFIO platform driver is the
> > ACPI based one. If the FW provides an ACPI method for device reset
> > that is not properly serializing, that is a FW bug. We can quirk it in
> > VFIO and block using those devices if they actually exist.
> > 
> > I expect the non-generic VFIO platform drivers to take care of this
> > issue internally with, barriers, read from devices, whatver is
> > required to make their SOCs order properly. Just as I would expect a
> > normal Linux platform driver to directly manage whatever
> > implementation specific ordering quirks the SOC may have.
> 
> This would be a new requirement if an existing VFIO platform driver
> relied on all mappings being Device. But maybe that's just theoretical
> at the moment, are there any concrete examples outside vfio-pci? If not,
> we can document it as per Lorenzo's suggestion to summarise this
> discussion under Documentation/.

My point is if this becomes a real world concern we have a solid
answer on how to resolve it - fix the VFIO driver to have a stronger
barrier before reset.

I'm confident it is not a problem for PCI and IIRC the remaining ARM
platform drivers were made primarily for DPDK, not KVM.

So I agree with documenting and perhaps a comment someplace in VFIO is
also warranted.

Jason
