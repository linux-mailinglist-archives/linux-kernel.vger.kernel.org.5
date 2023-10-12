Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C557C7603
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379706AbjJLSgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347426AbjJLSg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:36:29 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC32D10C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:36:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARKPBykfjwTM7jHMaGlbdB2Sw2trxyfxSTB7iEGoZU2gkLfvYrg+gLVnB0+MKpegrmXV41qBq+q6cs1i7/lU3dCvIjxOiWz0Pz6H/D7ELtAcKWjcMgXYaSeO2oORVgJLbN8lNs6QHaZI7Fd98DBNCbwBVCHl1SDOJ/X3vO0MLk1kEAm0njjTHl1PAr8QRF1m3YrpvdSmZ1ITyjsa09y2jv+0SZq4vuBkr/VQoxjAW+AfoAzrnsb0o1z6qEKzu3wvsNsQxB79Ep6HOkDVdMVhZip4pSgzOnvm7hNoVud05B1tXxjSYnlel1OPlE1H3zZQKtoEkXWWp3sb1cgutYftzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoU1dMvaNgGFhpq/nM3/kf0wteIN4HiQbHzbbAkDKpM=;
 b=WfbvdymgNd6NMv3Dt/TSxVj1tuZa5LbpS+vcFoDd3h7GkTf7rCfDQrgb+aznK7dbSJs9s0VKc+PZQFFsjjtnDE+JN/ztiLhcr4Q1iDIua1VOscp3Y5dQXzYpQQRkwVIxfLeNHWzEFNZzgglyEhHpDk4mVZBvy7Jz9cG8D0aJtsGsJz4BXcysdGluE9oHF7JInj9MXjqGcsQZXXxXpuG6bUbcAixcDbqMFJ0L2nHt6gx0N6xSRPuFsJg5xrSWrTkIy7pjkEOdpcdB7OYiayLOwlz79xCTVp4fEciTQLLM8gVCh0gSHyw+Bl6O/ACS8phcpIDPEHHPuC5rFBuXylsNmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoU1dMvaNgGFhpq/nM3/kf0wteIN4HiQbHzbbAkDKpM=;
 b=YWvz16o/afyL2Q3QpZgJMTSM90hM3RSvk5jtaOQeExyxEyqVMoUpOKyIQkdYxGPqIsQT6YDTodrBQ/ItTlSbgrc871ctE4zEgvfYh7fwzefl3tpOoqa6pcObwe3f/OTP0PfAh+3xkhDQ9J0NIIzdHyEqWhHPdHlik6wqRfKRzoVN19BIWQzZW46ldTbXnQsdht77b2rKd6HzBVhHAsnv0zvAErgDn9TqMqTEbID80cRRAAvTCMQMPf9nY7FeHIHYesVJvqYV5r/vzWgpxSEYqeIIWHElrFBbKA5RO00aJPoabWc0Cll7c7l3fZ7LFMH+MAJIbJwGRTDZ7ViehuzpZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8312.namprd12.prod.outlook.com (2603:10b6:208:3fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Thu, 12 Oct
 2023 18:36:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 18:36:25 +0000
Date:   Thu, 12 Oct 2023 15:36:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, ankita@nvidia.com,
        maz@kernel.org, oliver.upton@linux.dev, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <20231012183624.GN3952@nvidia.com>
References: <ZQHUifAfJ+lZikAn@lpieralisi>
 <ZQIFfqgR5zcidRR3@nvidia.com>
 <ZRKW6uDR/+eXYMzl@lpieralisi>
 <ZRLiDf204zCpO6Mv@arm.com>
 <ZR6IZwcFNw55asW0@lpieralisi>
 <20231012123541.GB11824@willie-the-truck>
 <ZSf6Ue09IO6QMBs1@arm.com>
 <20231012144807.GA12374@willie-the-truck>
 <20231012154439.GM3952@nvidia.com>
 <20231012163931.GA12592@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012163931.GA12592@willie-the-truck>
X-ClientProxiedBy: MN2PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:208:239::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: a9682feb-6b36-430e-e1d3-08dbcb5223b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5RKC7BO8MhHICT+tbqy5t9H0og9yv2tlAVqD6egTJwZ9etSn7KC4yc41SBa3d/+NQl5DqOGkHWB1fDrHt5SSocxPZAhQS5LMQN6k0udlZTaYL7kAPQ5/tjYiVLGQRCad0roivNK9JdQt7TJb6XNoodvb+ZvJ0rZH5BLT+R9N8G6zmJRt1qyx86lv4jGFmUXh/JIpGs/UtKlGJNGELFF74l5mwltM8Ocdih3dtuBxTNq3/e7St0O/fPuVzBY0ViYx3XCSTjSMlv3UvAwi2NsigLG2huTlF+lsb5WooUUwwCzorQ9rI7miNFBFobL8HDZMcEubA1MuSVHhVV1HJsi18OuOqcSbN1lEpjCnhUoxFsITxnOW5cyHggCKyfGregk/2VIosd+Co2Jn3CcMlqPkTQSC3+c/cIqk3ddebCqMc6ct0STLpwVL989G22/kad/hhQJ8wHxTS3D8a5m7Y7CX5upZ8w951pnNH/GBizWE+fZMt71d+i4QnG3kms4D3odgexQLkEReihoHYdGl79mmrc+HANCrwQ0eKKrKSsnTYA10MWxJkUuP1UiBqDwRdkXa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6512007)(6506007)(2616005)(1076003)(66556008)(2906002)(5660300002)(8676002)(66476007)(6486002)(8936002)(54906003)(6916009)(66946007)(4326008)(26005)(83380400001)(316002)(478600001)(38100700002)(36756003)(86362001)(33656002)(41300700001)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ze1IVRwj6SfQcVZlme8jA+4d7E50v0vtc+ebOq/1ASq0Nh2E+6gOHiCvo0xO?=
 =?us-ascii?Q?HzA1qDIZv/Np+3QM8XOYDlYaxhQpJI8yxkLYBN82asNJYKeFURMPY7eys0pC?=
 =?us-ascii?Q?p2kSGlWiVq9buhha/9QAbBobqTFGFPYdxWWp6RWoMjHPS/C9qZG3xul8TBEd?=
 =?us-ascii?Q?Nl49lWGUO4uypSeHJJDpt/OERhD+PV8SNyM/a+N579NwEuy6YCTOWeqtWUKN?=
 =?us-ascii?Q?IynLqtQgs8nh7mah6iwYGGjK7xZm/XA1JKiuRtY1x24OhekFyHTgjIa9+EUW?=
 =?us-ascii?Q?6VIHYe0zNxnTtkYVTGvj6BW67B5fFS9xuC+Ig8255FzCFqbXVC67Evkv26km?=
 =?us-ascii?Q?osm+9Znv7OAVWqs1o8f4LQ4VdPc9ykoZN6EPoqAFD6qmLec9dNgTmXg19Byj?=
 =?us-ascii?Q?OxdN606Yf0AfOUAbQrl0jh6DsFtiMIpmT76UDSBxQAfHsx+ghNpW0fHZMZCL?=
 =?us-ascii?Q?jI6RoRBr3rWjP16Odp0tBPbMJIfq40EsS4ORd0nHvKX4RWaZ/nlYViTEt9Ir?=
 =?us-ascii?Q?6JEKA9Q1cAurOwsXC1woXSs7vbF8731PZF8kiZ3FlsY5+6XJAsP6jtBjJZ8S?=
 =?us-ascii?Q?8F91snQBHrsREskU0cGCdOu0hIteEASi1aDrtjVGjDov2yvAiAXVCA/nWwY2?=
 =?us-ascii?Q?qjDIrxWwKeDXF03PRuxznsbe5y4azVFFZM8qsq2FvlB6Cvz2IAcDoJ9ZlKsX?=
 =?us-ascii?Q?MypatuZPfaL79aTwXppGSUcjkBqog/jnhViBBtBjG+REUpdiT+I+y7zVxNsV?=
 =?us-ascii?Q?R8szuCwE3j1beXlEop2JhFFjzCeKJR4HgO8RM0Of196V2IBkorxaNNc6mge2?=
 =?us-ascii?Q?8T0Um6Pyp/4SAWrG3zK90n47HYv/YscTNRvLrKBHLgUJ3PtC0V1z22zrhRZi?=
 =?us-ascii?Q?T98CxJ0UHn6zG0AqaSO2Lij0wSbiULJPdg7BP2ib4UAdJgODgpaiUBrxdw4y?=
 =?us-ascii?Q?BOf3fQd1kQdylJrI39rttj/blp/oi9dyNCt1SNtANBl0CElWcI/TaiPkOjv2?=
 =?us-ascii?Q?FEa3jtPBbfysPir2ZiJixwzlXm5a5EU3miRsoWR16T5IsgQ6QUKa4buwf0vz?=
 =?us-ascii?Q?5GhYH6b147+x7ixiegnCwkGL28Y6d9w4zcBsHXhjkfWiIpE2B98/78Ir0xWu?=
 =?us-ascii?Q?FZOLv7nYE4paEdJgEdgyW4gnLgMzdJ2dzJM4inaJXlsSD7UrUpTk1vfyXza4?=
 =?us-ascii?Q?j2SK0EpcpD1Z2ntEan/LWl3RYBPR4SEzfz9wDklElbImlyYYYh7ES7pX0M05?=
 =?us-ascii?Q?x3ZtLi4XzbAZqyYP/LJIWgVPycSn65uk1QISCaCwkqSwAntfHw7zSUjF/5eX?=
 =?us-ascii?Q?a0kjRZHF3Wta4LPAb6VI8Mr5DfjFJWr4BgRLJvdmwJHDRQQU/z5AeyK2bQSL?=
 =?us-ascii?Q?PX3MhKHnSZUp6kTH5X1Hg6oDDi0vigjQEx1sKBgjuXSUpLVOdc6okeX63MnN?=
 =?us-ascii?Q?7ojksidBqqyqgCkVbUcTz4TUwLb2xGrt1bGsPJyVW3cpZzJrUBjBBgaj4qNi?=
 =?us-ascii?Q?henju+5pRhpOe6bbguUwI6tzIQfoJQMG6NwJ8iwgtDV59I75XIV/GPne1H8C?=
 =?us-ascii?Q?UXh7+6dv/OZujyHCJQtvRU816i9Sxp2RkNO0OQLt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9682feb-6b36-430e-e1d3-08dbcb5223b3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 18:36:25.1503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEOEDZFR9wpvtRIMEs/CSH6zKdNrWu0LCnpcXHd99rbSRiBVPWbU41xVPzXI2AsK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8312
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 05:39:31PM +0100, Will Deacon wrote:

> All I'm asking for is justification as to why Normal-NC is the right
> memory type rather than any other normal memory type. If it's not possible
> to explain that architecturally, then I'm not sure this change belongs in
> architecture code.

Well, I think Catalin summarized it nicely, I second his ask at the end:

We are basically at your scenario below - can you justify why
DEVICE_GRE is correct today, architecturally? We could not. Earlier
someone said uncontained failure prevention, but a deep dive on that
found it is not so.

> Ultimately, we need to be able to maintain this stuff, so we can't just
> blindly implement changes based on a combination of off-list discussions
> and individual product needs. For example, if somebody else rocks up
> tomorrow and asks for this to be Normal-writethrough, what grounds do
> we have to say no if we've taken this change already?

Hmm. Something got lost here.

This patch is talking about the S2 MemAttr[3:0]. There are only 4
relevant values (when FEAT_S2FWB) (see D5.5.5 in ARM DDI 0487F.c)

 0b001 - Today: force VM to be Device nGnRE

 0b101 - Proposed: prevent the VM from selecting cachable, allow it to
         choose Device-* or NormalNC

 0b110 - Force write back. Would totally break MMIO, ruled out

 0b111 - Allow the VM to select anything, including cachable.
         This is nice, but summarizing Catalin's remarks:
           a) The kernel can't do cache maintenance (defeats FWB)
           b) Catalin's concerns about MTE and Atomics triggering
	      uncontained failures
           c) It is unclear about uncontained failures for cachable
              in general

So the only argument is 001 v 110 v 111

Catalin has explained why 111 is not good as a default. Most likely
with some future ACPI/BSA/etc work, and some cache syncing in the
kernel, someone could define a way to allow 111 as a choice. So, I
think we can rule out 111 as being the default choice without more the
kernel getting more detailed system level knowledge.

Further, patch 1 is about making 110 a driver-opt-in choice for VFIO
memory which reduces the need for 111.

For 001 v 110: 001 is less functional in the VM. 001 offers no
advantage.

!FEAT_S2FWB has similar choices and similar argument.

So, IMHO, if someone comes to ask for something it would be to ask for
111 and we do have a set of pretty clear reasons why it should not be
111. (indeed we wanted to ask for that instead of patch 1 but there
are too many things required to get there),

Jason
