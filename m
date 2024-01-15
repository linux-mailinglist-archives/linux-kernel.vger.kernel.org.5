Return-Path: <linux-kernel+bounces-25639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FC482D3EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4E51F2111F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FC023DE;
	Mon, 15 Jan 2024 05:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a7Vibnie";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iDxh0Rdf"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AFD23B7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 05:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705297580; x=1736833580;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=svdG8uqwFcm6PYwpjDnNyDU7wsP0F/TGx7egKiYQVTo=;
  b=a7VibniemXkcuUOjx8SBH8i6LrXN8wWEt4Rwq7Go5YlGpG4Kp0hA73Y7
   tyRq7YX6Oox6VelNKbxJxyssuiE+X25xPBnZUYyIivX5UUIRCpoKkKhv5
   O0H/cNv/f81lMHSgGXcfzo5hlnvqYxEB0CQ+83W9ShPXHSieDixd3/5ii
   Uza4Kza0QTKibJuZj4bGnO4lOSwFmvr4k2+4ztFUoGmYLfMa+AjEEFyIk
   694eQXCMhR05m+ThEM2Fp+4c9ItZUgJfTQzQvauNFht4wpSFI6sUSp/V0
   kHLDZzHaMLjUbMy3Wl7XeqREHFtQuiCXo4x/VX4H/kqDzC90G0i3p8Rb6
   w==;
X-CSE-ConnectionGUID: vzxz64uJSK2ch7VQh63UGw==
X-CSE-MsgGUID: MwUNgB4BTgGudI0jixSijQ==
X-IronPort-AV: E=Sophos;i="6.04,195,1695657600"; 
   d="scan'208";a="6968588"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2024 13:46:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxjiyvegF93poXS+3drjVi6RX6OrNWZfwI3idSKmsPtxK+o99U1LJ+PD8eXom4JsCsymVtjCI6QgF9y3ToUX9jPNEGrDdShpYz3AYXXagpg1SVoJsvuRHHDPAkJ+qLc5Dz0gbD8Xj2Aiov9zDDvDclEXdCfqJo5r/SMVujTRrAdKhDusnhhK3v46QaD35vjPhQXt3czcw4U23a10kezYhMbKZ/wq7Fi5rvX3XNmf79WZkZnbd83W8TUpXNkj2JWs8p2cLxhIWLJpxx+HrPa23XOK2vJJhli5zkkyy2C2vutxeeAjzFth5XMhMK0u8bvfS9qHEpLcU3qb8lqNLGC76g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AF6yXDWlqXeVYD8MYMSHvHWcQCGM6lclEleuEA2q90Y=;
 b=QvHQ8K89F74Y2aEcETjW63K6+FoQ+409a+hchYdYC3zIktUrg24Fdg6+5JrO8NSgYCSdZyTSQc7o04pThblM1K1QN/F5bZyUiUmPKZM29cPx94ULocILbwoPg+3SFAl6QXAEDYT+mcT3bBIDfFAIYmdC6fLVpQfBrIxc7XE6npG70qWcVAvaup3wIxLv9VkLUCiwIR95sjZWo0rRhZ48hwCDW5sTULvVM25YA99Bczmoa+rf0DNg5BdVp68klSbeFcppJy6hr0+qDduxwGjVQNEbDl4TUGEl/ClFJojPdTI/Y3jrMkAediL+1Jl27CpnSZM6gA8pmF0pH/RXso8OLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AF6yXDWlqXeVYD8MYMSHvHWcQCGM6lclEleuEA2q90Y=;
 b=iDxh0RdfLpxutLCsQjETd2baeFrwxDkkCc2jwlCMsuC30sdbm44M5FFo3i12fzdVZRs/xBcwOe8pysV4NUqn+K4RVj9z7NZkkA8Fj0Ee1x6sT12+4+NQo2t28szkeLZz2GmlJ9XFY7WKaTV6IDKZqITtK9q2iEbEBi3orkZ2nAM=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BN8PR04MB6451.namprd04.prod.outlook.com (2603:10b6:408:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 05:46:08 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::40c3:517e:80e1:e84e]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::40c3:517e:80e1:e84e%5]) with mapi id 15.20.7181.022; Mon, 15 Jan 2024
 05:46:08 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Tejun Heo <tj@kernel.org>
CC: "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: Re: [PATCHSET wq/for-6.8] workqueue: Implement system-wide
 max_active for unbound workqueues
Thread-Topic: Re: [PATCHSET wq/for-6.8] workqueue: Implement system-wide
 max_active for unbound workqueues
Thread-Index: AQHaMxW+fup8mSSkJ02yqXaFIZNHL7DKm++AgArgQYCABQnoAA==
Date: Mon, 15 Jan 2024 05:46:07 +0000
Message-ID: <znrr4upkwnaehoifwcfuhk25ddv4kriyhrymqawcvnxseampml@drwl73kklgmq>
References: <20231220072529.1036099-1-tj@kernel.org>
 <e3r47rru6go5fqxl5issvduzzmsxrtkefigrkfcnqiuouxm467@72hfzpblzr36>
 <ZaCMkV_pjPfhZmrn@mtj.duckdns.org>
In-Reply-To: <ZaCMkV_pjPfhZmrn@mtj.duckdns.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BN8PR04MB6451:EE_
x-ms-office365-filtering-correlation-id: f96c1414-a53a-46f0-aece-08dc158d4575
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vat/DiTzUQaXJQEagGPB9G4VI6JaPi9wnMyakQ6HjqgNccNU0CARnvov81ypKz97K0U9L4J65ey1vznEuee58M9q5j4Jw4+i647UNr86JAkjEZVUTXx8jfe2p1cOJiGh3Ki4kp87YYveL/AXIha5CwEpO3YPqKb7ddqv7VenKwSYwavNscnF/CZPWtMpUGXId+eVjhFH7uyFHDHDGLMTXxXFboZS1MOLNeWtX046CROQI7bE3ASn8jS+Hea49xEdQBiOsSa2bHCiRIWoM+VKAhVGQCMvZ+LcxhqdAUpRF1vd37oCKgabcRVi8hmusCojJEpm/5QCm2qrZIAvJVWL0OebPMemFkww8bEJTMXejMb9QpDV+JQsQgkjh0jB2ZwHeqEB3G8p/y7SfYyMB1dRo8xIB4XS2ElcLyIoUvUTA4/BBFDi2+xzNZR6D2EAL3ia6xjzCEOccWl9OVQyWrghEr+QUl4xrcjV7hvNxb2fXpZIkr/+9pasknKWgI50uPeiTdi7EcuQP4qZZduiHJMheVctpcfKy5hJZelt2YetsR0lsUipzbGRw9qO23zoheTOoo/QjC4mcQoCkOxqtR2JuY8ShMuIkG7oAFq5fpP/25E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(39860400002)(376002)(346002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(6512007)(9686003)(26005)(122000001)(38100700002)(4326008)(8676002)(30864003)(5660300002)(2906002)(8936002)(966005)(6486002)(478600001)(33716001)(6506007)(71200400001)(54906003)(6916009)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(41300700001)(19627235002)(76116006)(91956017)(38070700009)(82960400001)(86362001)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eqa2Pi5kyHhO/G0cdH/lGL6NvyOCkAB4YNCSrVyjFQXc9UGnCe8/EUSRB8SJ?=
 =?us-ascii?Q?ea0UXnI6RlDGwrK++czRojYEnxLk3qh/VzY/lVpPefmm43xEx1DJESy/jKOM?=
 =?us-ascii?Q?wyjpQSdlt9SQZcIEu2DNeyzrxfaU6Xm7jZs1XXxu8/iilLOSZRua0279NGUm?=
 =?us-ascii?Q?xLKxAiF1LIvRfQsrx9JRYvSRTT4HT8b3NnvLMMMMonl29fbjZuv/p/6JmdD0?=
 =?us-ascii?Q?b0OKQevzQ/8bKLMQxkpdvrY+oHC3v/M2U60Vtdlfoq36Xsy34q1181RqTbpg?=
 =?us-ascii?Q?azox6y5TgFEpXr+Lxewwzs98mPYaha3/Dr1mMTxsN07OWFrdQEhzXoPARPXo?=
 =?us-ascii?Q?2nG6aAOFUKYuJylVT4UWzl+2GRDsTV7IuhytQw0bjlJPyUy0a+uldveDzbq3?=
 =?us-ascii?Q?1m0p7NtD39iBe6nmaT8bro3ECYv64OPCREGkFARXBnOyoypEgTTq3Dtusu+0?=
 =?us-ascii?Q?Vz0cJHGEef7tM2lpLFCG0XcNcNdFqhObtpf5cvEBc4ZsZAAO7sC/hJ++1goK?=
 =?us-ascii?Q?JW7arpYws2fDzu+E4CuasbUF0fHIlglPpHVpvh6zqzYdV0guLHsmWiWCijD4?=
 =?us-ascii?Q?Vslwodu2ZJ90NrHMHn7J/xUIKk1pI41US5UGwHY1VS3cqsri2y++rctpzFHF?=
 =?us-ascii?Q?+2xrmLhAZW9ABlvmG6YCFzWpUdApDZgpXpQjTGxcMrhl9Fuw35T3Wc136H09?=
 =?us-ascii?Q?gCNRH6aKB9AFeD+L8FD+PJIu7cOEktTEoOrgCrsaTIEW9ecBuUbrfwbzc5Z8?=
 =?us-ascii?Q?NeSwLy2x2DFO5nJbKHeCKoSJ3qRF2ZCxZKpqJysmi2eSbyTaBXjQ7uNA0jAc?=
 =?us-ascii?Q?SFcmfJm6TPe7QzEET3SSzxQ9DG8CYZNmGEATSPLtWNPaZ7z9t/0sniagMQCn?=
 =?us-ascii?Q?CPN8p0eXg4Pfi4J5pt3AFu3IzOabYhe21AV1ZQzjKZHsSiFTUCfMn4FhTk4c?=
 =?us-ascii?Q?X7XKISrLU15prRa9VxPamNkv01uKJKluk53hlrB58nfWMSoX9Ve69PYJ1hRH?=
 =?us-ascii?Q?y6poO2B+3yt4hfvPSqmeg9+iq25HanhktZ7SBnCmfhE2x8hbmjCjlFHkVa03?=
 =?us-ascii?Q?TCxMYRhgXsvT/kzXw2OZnHgQFYYIn9PuRxXMvM3m9As9qCMLQIA3ceZGxN4N?=
 =?us-ascii?Q?I1qxLfPiKos/9rwZnCIPt8B2TPdjTqrwIKDhUjhhFI5ty5zd1sGToNyV1EMQ?=
 =?us-ascii?Q?fqkyGdX78NgZLTeJSvrj6eFJBEOdLWrMVwJwjpxkejQPgFgJQYD+LnDi4UH7?=
 =?us-ascii?Q?Q3KrwtLvBme1FRzUzAxJiBaVs5EHe13eBmO8Jn7K9ibbEd5G9HaZUDtlAXU+?=
 =?us-ascii?Q?kEuGR7fX16CdXTcadKm7d/GjtFPQfEPH+4OoJkk3yOLedJCP4bjQgTJrngRR?=
 =?us-ascii?Q?VK9dW/iBovbbuaHWlIlda8ecYj7d4Z8YiPwLAuaArkUpScKa8W9qkYOt0VGq?=
 =?us-ascii?Q?ELGZqI+keVJOqpmbdf7HdgGFjSczxpNqGHsPaTmOm+IQnmV3YDRac9ZIW+1E?=
 =?us-ascii?Q?DdaF1peWQpUMqCzwnYd/wXftLzr1rM/BP1jgT8QXoewxRKOgbONcdw9V+Uc1?=
 =?us-ascii?Q?ZvXFc4jSJ/QGW9+Wa5ICBXCwml+p3DpoEMFL6xrvFExpJ+IPg5urH0gPg9xT?=
 =?us-ascii?Q?QA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F7D07C032F7F75499042C1C942C32192@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xvgjOOhW6UFoLvac1ViL03mUKTteAeOVFwqFuo4sqs56CX8DKI38MUKo4+rfuoJnOKNoplcKqMtRfAHVcAzXWEF+LbLCDZcjBTguB371b82oJXw3Onk06Xc8cdXcnexFesvjWjxIwbC3Gg50dXpcEkpXM1jq9/lNfvqJH0eevvOYFfNrDeH2Hxft89TZo+hSnQPxSkVsGbGC/PGgNZH2y3n1DjN2Y79YKEiW+rpqjJhSjsceHtL++zJLxInWHqt1keoCNcebZpf79i3m/VhPlYNnvLpsqDGZ1Do48G3ofkNaXzq8eGWJ5KgXOu3ObVxGDk7JbMgj2IKCQ1rzJwhm1QYXXXvGjE3wtQcBZ9bjQCigv4+X1U+kDFG6I7339zM+LOuV7hWAFMc47Msaa321d/EvxlSx5TbkhrZIc76FZmBF6PfKXkzm+6WD5D08i5tfBnHhlx+hkDVhMBgGygjfGPoKymNjF18CD/0YLsN0avT+7ODYauXNCMFgsUMPDEVh2XN8g1ShF2TWfUpgyUnpeGbhlH2JeiuxmIzSLY6tlb84JD17BpsCEc0WMSIdQlHE6Wsi8pguhZmVzpjxYaa6zRUsTnuieM5+N6aVGbTO1L6pQkxxlQ/x1lU9Shb8u6Qs
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96c1414-a53a-46f0-aece-08dc158d4575
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 05:46:07.9337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wcm/Lra0B512RQ0bh0J/ApAL7TP7MOeiKSNPPv5iVeemLtcEIsNTTT3nK1hNX9co/TEsg3y9MYdfF5gL+Qyb8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6451

On Thu, Jan 11, 2024 at 02:49:21PM -1000, Tejun Heo wrote:
> Hello,
>
> On Fri, Jan 05, 2024 at 02:44:08AM +0000, Naohiro Aota wrote:
> > Thank you for the series. I applied the patches on btrfs's development =
tree
> > below, and ran the benchmark.
> >
> > https://gitlab.com/kdave/btrfs-devel.git misc-next
> >
> > - misc-next, numa=3Doff (baseline)
> >   WRITE: bw=3D1117MiB/s (1171MB/s), 1117MiB/s-1117MiB/s (1171MB/s-1171M=
B/s), io=3D332GiB (356GB), run=3D304322-304322msec
> > - misc-next + wq patches, numa=3Doff
> >   WRITE: bw=3D1866MiB/s (1957MB/s), 1866MiB/s-1866MiB/s (1957MB/s-1957M=
B/s), io=3D684GiB (735GB), run=3D375472-375472msec
> >
> > So, the patches surely improved the performance. However, as show below=
, it
> > is still lower than reverting previous workqueue patches. The reverting=
 is
> > done by reverse applying output of "git diff 4cbfd3de737b
> > kernel/workqueue.c kernel/workqueue_internal.h include/linux/workqueue*
> > init/main.c"
> >
> > - misc-next + wq reverted, numa=3Doff
> >   WRITE: bw=3D2472MiB/s (2592MB/s), 2472MiB/s-2472MiB/s (2592MB/s-2592M=
B/s), io=3D732GiB (786GB), run=3D303257-303257msec
>
> Can you describe the test setup in detail? What kind of machine is it? Wh=
at
> do you mean by `numa=3Doff`? Can you report tools/workqueue/wq_dump.py ou=
tput?

The testing machines' hardware is as follows:

CPU: Intel(R) Xeon(R) Platinum 8260 CPU, 96 cores
NUMA nodes: 2
RAM: 1024 GB

However, for another benchmark experiment I'm doing, I booted the machine
with "numa=3Doff mem=3D16G" kernel command-line. I admit this is an unusual
setup...

On that machine, I create a fresh btrfs with "mkfs.btrfs -d raid0 -m raid0
<devices>" with 6 SSD devices. And, I run the following command on the FS.

fio --group_reporting --eta=3Dalways --eta-interval=3D30s --eta-newline=3D3=
0s \
    --rw=3Dwrite --fallocate=3Dnone \
    --direct=3D1 --ioengine=3Dlibaio --iodepth=3D32 \
    --filesize=3D100G \
    --blocksize=3D64k \
    --time_based --runtime=3D300s \
    --end_fsync=3D1 \
    --directory=3D${MNT} \
    --name=3Dwriter --numjobs=3D32

tools/workqueue/wq_dump.py output is pasted at the
bottom. "btrfs-endio-write" is the workqueue, which had many workers on the
unpatched kernel.

FYI, without the kernel command-line (i.e, numa=3Don and all RAM available =
as
usual), as shown below, your patch series (v1) improved the performance
significantly. It is even better than the reverted case.

- misc-next, numa=3Don
  WRITE: bw=3D1121MiB/s (1175MB/s), 1121MiB/s-1121MiB/s (1175MB/s-1175MB/s)=
, io=3D332GiB (356GB), run=3D303030-303030msec
- misc-next+wq patches, numa=3Don
  WRITE: bw=3D2185MiB/s (2291MB/s), 2185MiB/s-2185MiB/s (2291MB/s-2291MB/s)=
, io=3D667GiB (717GB), run=3D312806-312806msec
- misc-next+wq reverted, numa=3Don
  WRITE: bw=3D1557MiB/s (1633MB/s), 1557MiB/s-1557MiB/s (1633MB/s-1633MB/s)=
, io=3D659GiB (708GB), run=3D433426-433426msec

> Thanks.
>
> --
> tejun

Affinity Scopes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
wq_unbound_cpumask=3D0xffffffff 0xffffffff ffffffff

CPU
  nr_pods  96
  pod_cpus [0]=3D00000001 [1]=3D00000002 [2]=3D00000004 [3]=3D00000008 [4]=
=3D00000010 [5]=3D00000020 [6]=3D00000040 [7]=3D00000080 [8]=3D00000100 [9]=
=3D00000200 [10]=3D00000400 [11]=3D00000800 [12]=3D00001000 [13]=3D00002000=
 [14]=3D00004000 [15]=3D00008000 [16]=3D00010000 [17]=3D00020000 [18]=3D000=
40000 [19]=3D00080000 [20]=3D00100000 [21]=3D00200000 [22]=3D00400000 [23]=
=3D00800000 [24]=3D01000000 [25]=3D02000000 [26]=3D04000000 [27]=3D08000000=
 [28]=3D10000000 [29]=3D20000000 [30]=3D40000000 [31]=3D80000000 [32]=3D0x0=
 00000001 [33]=3D0x0 00000002 [34]=3D0x0 00000004 [35]=3D0x0 00000008 [36]=
=3D0x0 00000010 [37]=3D0x0 00000020 [38]=3D0x0 00000040 [39]=3D0x0 00000080=
 [40]=3D0x0 00000100 [41]=3D0x0 00000200 [42]=3D0x0 00000400 [43]=3D0x0 000=
00800 [44]=3D0x0 00001000 [45]=3D0x0 00002000 [46]=3D0x0 00004000 [47]=3D0x=
0 00008000 [48]=3D0x0 00010000 [49]=3D0x0 00020000 [50]=3D0x0 00040000 [51]=
=3D0x0 00080000 [52]=3D0x0 00100000 [53]=3D0x0 00200000 [54]=3D0x0 00400000=
 [55]=3D0x0 00800000 [56]=3D0x0 01000000 [57]=3D0x0 02000000 [58]=3D0x0 040=
00000 [59]=3D0x0 08000000 [60]=3D0x0 10000000 [61]=3D0x0 20000000 [62]=3D0x=
0 40000000 [63]=3D0x0 80000000 [64]=3D0x0 0x0 00000001 [65]=3D0x0 0x0 00000=
002 [66]=3D0x0 0x0 00000004 [67]=3D0x0 0x0 00000008 [68]=3D0x0 0x0 00000010=
 [69]=3D0x0 0x0 00000020 [70]=3D0x0 0x0 00000040 [71]=3D0x0 0x0 00000080 [7=
2]=3D0x0 0x0 00000100 [73]=3D0x0 0x0 00000200 [74]=3D0x0 0x0 00000400 [75]=
=3D0x0 0x0 00000800 [76]=3D0x0 0x0 00001000 [77]=3D0x0 0x0 00002000 [78]=3D=
0x0 0x0 00004000 [79]=3D0x0 0x0 00008000 [80]=3D0x0 0x0 00010000 [81]=3D0x0=
 0x0 00020000 [82]=3D0x0 0x0 00040000 [83]=3D0x0 0x0 00080000 [84]=3D0x0 0x=
0 00100000 [85]=3D0x0 0x0 00200000 [86]=3D0x0 0x0 00400000 [87]=3D0x0 0x0 0=
0800000 [88]=3D0x0 0x0 01000000 [89]=3D0x0 0x0 02000000 [90]=3D0x0 0x0 0400=
0000 [91]=3D0x0 0x0 08000000 [92]=3D0x0 0x0 10000000 [93]=3D0x0 0x0 2000000=
0 [94]=3D0x0 0x0 40000000 [95]=3D0x0 0x0 80000000
  pod_node [0]=3D0 [1]=3D0 [2]=3D0 [3]=3D0 [4]=3D0 [5]=3D0 [6]=3D0 [7]=3D0 =
[8]=3D0 [9]=3D0 [10]=3D0 [11]=3D0 [12]=3D0 [13]=3D0 [14]=3D0 [15]=3D0 [16]=
=3D0 [17]=3D0 [18]=3D0 [19]=3D0 [20]=3D0 [21]=3D0 [22]=3D0 [23]=3D0 [24]=3D=
0 [25]=3D0 [26]=3D0 [27]=3D0 [28]=3D0 [29]=3D0 [30]=3D0 [31]=3D0 [32]=3D0 [=
33]=3D0 [34]=3D0 [35]=3D0 [36]=3D0 [37]=3D0 [38]=3D0 [39]=3D0 [40]=3D0 [41]=
=3D0 [42]=3D0 [43]=3D0 [44]=3D0 [45]=3D0 [46]=3D0 [47]=3D0 [48]=3D0 [49]=3D=
0 [50]=3D0 [51]=3D0 [52]=3D0 [53]=3D0 [54]=3D0 [55]=3D0 [56]=3D0 [57]=3D0 [=
58]=3D0 [59]=3D0 [60]=3D0 [61]=3D0 [62]=3D0 [63]=3D0 [64]=3D0 [65]=3D0 [66]=
=3D0 [67]=3D0 [68]=3D0 [69]=3D0 [70]=3D0 [71]=3D0 [72]=3D0 [73]=3D0 [74]=3D=
0 [75]=3D0 [76]=3D0 [77]=3D0 [78]=3D0 [79]=3D0 [80]=3D0 [81]=3D0 [82]=3D0 [=
83]=3D0 [84]=3D0 [85]=3D0 [86]=3D0 [87]=3D0 [88]=3D0 [89]=3D0 [90]=3D0 [91]=
=3D0 [92]=3D0 [93]=3D0 [94]=3D0 [95]=3D0
  cpu_pod  [0]=3D0 [1]=3D1 [2]=3D2 [3]=3D3 [4]=3D4 [5]=3D5 [6]=3D6 [7]=3D7 =
[8]=3D8 [9]=3D9 [10]=3D10 [11]=3D11 [12]=3D12 [13]=3D13 [14]=3D14 [15]=3D15=
 [16]=3D16 [17]=3D17 [18]=3D18 [19]=3D19 [20]=3D20 [21]=3D21 [22]=3D22 [23]=
=3D23 [24]=3D24 [25]=3D25 [26]=3D26 [27]=3D27 [28]=3D28 [29]=3D29 [30]=3D30=
 [31]=3D31 [32]=3D32 [33]=3D33 [34]=3D34 [35]=3D35 [36]=3D36 [37]=3D37 [38]=
=3D38 [39]=3D39 [40]=3D40 [41]=3D41 [42]=3D42 [43]=3D43 [44]=3D44 [45]=3D45=
 [46]=3D46 [47]=3D47 [48]=3D48 [49]=3D49 [50]=3D50 [51]=3D51 [52]=3D52 [53]=
=3D53 [54]=3D54 [55]=3D55 [56]=3D56 [57]=3D57 [58]=3D58 [59]=3D59 [60]=3D60=
 [61]=3D61 [62]=3D62 [63]=3D63 [64]=3D64 [65]=3D65 [66]=3D66 [67]=3D67 [68]=
=3D68 [69]=3D69 [70]=3D70 [71]=3D71 [72]=3D72 [73]=3D73 [74]=3D74 [75]=3D75=
 [76]=3D76 [77]=3D77 [78]=3D78 [79]=3D79 [80]=3D80 [81]=3D81 [82]=3D82 [83]=
=3D83 [84]=3D84 [85]=3D85 [86]=3D86 [87]=3D87 [88]=3D88 [89]=3D89 [90]=3D90=
 [91]=3D91 [92]=3D92 [93]=3D93 [94]=3D94 [95]=3D95

SMT
  nr_pods  48
  pod_cpus [0]=3D0x1 00010000 [1]=3D0x2 00020000 [2]=3D0x4 00040000 [3]=3D0=
x8 00080000 [4]=3D0x10 00100000 [5]=3D0x20 00200000 [6]=3D0x40 00400000 [7]=
=3D0x80 00800000 [8]=3D0x100 01000000 [9]=3D0x200 02000000 [10]=3D0x400 040=
00000 [11]=3D0x800 08000000 [12]=3D0x1000 10000000 [13]=3D0x2000 20000000 [=
14]=3D0x4000 40000000 [15]=3D0x8000 80000000 [16]=3D0x10000 0x0 00000001 [1=
7]=3D0x20000 0x0 00000002 [18]=3D0x40000 0x0 00000004 [19]=3D0x80000 0x0 00=
000008 [20]=3D0x100000 0x0 00000010 [21]=3D0x200000 0x0 00000020 [22]=3D0x4=
00000 0x0 00000040 [23]=3D0x800000 0x0 00000080 [24]=3D0x1000000 0x0 000001=
00 [25]=3D0x2000000 0x0 00000200 [26]=3D0x4000000 0x0 00000400 [27]=3D0x800=
0000 0x0 00000800 [28]=3D0x10000000 0x0 00001000 [29]=3D0x20000000 0x0 0000=
2000 [30]=3D0x40000000 0x0 00004000 [31]=3D0x80000000 0x0 00008000 [32]=3D0=
x0 0x1 00010000 [33]=3D0x0 0x2 00020000 [34]=3D0x0 0x4 00040000 [35]=3D0x0 =
0x8 00080000 [36]=3D0x0 0x10 00100000 [37]=3D0x0 0x20 00200000 [38]=3D0x0 0=
x40 00400000 [39]=3D0x0 0x80 00800000 [40]=3D0x0 0x100 01000000 [41]=3D0x0 =
0x200 02000000 [42]=3D0x0 0x400 04000000 [43]=3D0x0 0x800 08000000 [44]=3D0=
x0 0x1000 10000000 [45]=3D0x0 0x2000 20000000 [46]=3D0x0 0x4000 40000000 [4=
7]=3D0x0 0x8000 80000000
  pod_node [0]=3D0 [1]=3D0 [2]=3D0 [3]=3D0 [4]=3D0 [5]=3D0 [6]=3D0 [7]=3D0 =
[8]=3D0 [9]=3D0 [10]=3D0 [11]=3D0 [12]=3D0 [13]=3D0 [14]=3D0 [15]=3D0 [16]=
=3D0 [17]=3D0 [18]=3D0 [19]=3D0 [20]=3D0 [21]=3D0 [22]=3D0 [23]=3D0 [24]=3D=
0 [25]=3D0 [26]=3D0 [27]=3D0 [28]=3D0 [29]=3D0 [30]=3D0 [31]=3D0 [32]=3D0 [=
33]=3D0 [34]=3D0 [35]=3D0 [36]=3D0 [37]=3D0 [38]=3D0 [39]=3D0 [40]=3D0 [41]=
=3D0 [42]=3D0 [43]=3D0 [44]=3D0 [45]=3D0 [46]=3D0 [47]=3D0
  cpu_pod  [0]=3D0 [1]=3D1 [2]=3D2 [3]=3D3 [4]=3D4 [5]=3D5 [6]=3D6 [7]=3D7 =
[8]=3D8 [9]=3D9 [10]=3D10 [11]=3D11 [12]=3D12 [13]=3D13 [14]=3D14 [15]=3D15=
 [16]=3D16 [17]=3D17 [18]=3D18 [19]=3D19 [20]=3D20 [21]=3D21 [22]=3D22 [23]=
=3D23 [24]=3D24 [25]=3D25 [26]=3D26 [27]=3D27 [28]=3D28 [29]=3D29 [30]=3D30=
 [31]=3D31 [32]=3D32 [33]=3D33 [34]=3D34 [35]=3D35 [36]=3D36 [37]=3D37 [38]=
=3D38 [39]=3D39 [40]=3D40 [41]=3D41 [42]=3D42 [43]=3D43 [44]=3D44 [45]=3D45=
 [46]=3D46 [47]=3D47 [48]=3D0 [49]=3D1 [50]=3D2 [51]=3D3 [52]=3D4 [53]=3D5 =
[54]=3D6 [55]=3D7 [56]=3D8 [57]=3D9 [58]=3D10 [59]=3D11 [60]=3D12 [61]=3D13=
 [62]=3D14 [63]=3D15 [64]=3D16 [65]=3D17 [66]=3D18 [67]=3D19 [68]=3D20 [69]=
=3D21 [70]=3D22 [71]=3D23 [72]=3D24 [73]=3D25 [74]=3D26 [75]=3D27 [76]=3D28=
 [77]=3D29 [78]=3D30 [79]=3D31 [80]=3D32 [81]=3D33 [82]=3D34 [83]=3D35 [84]=
=3D36 [85]=3D37 [86]=3D38 [87]=3D39 [88]=3D40 [89]=3D41 [90]=3D42 [91]=3D43=
 [92]=3D44 [93]=3D45 [94]=3D46 [95]=3D47

CACHE (default)
  nr_pods  2
  pod_cpus [0]=3D0xffffff 0xffff0000 000000ff [1]=3D0xff000000 0xffff fffff=
f00
  pod_node [0]=3D0 [1]=3D0
  cpu_pod  [0]=3D0 [1]=3D0 [2]=3D0 [3]=3D0 [4]=3D0 [5]=3D0 [6]=3D0 [7]=3D0 =
[8]=3D0 [9]=3D0 [10]=3D0 [11]=3D0 [12]=3D0 [13]=3D0 [14]=3D0 [15]=3D0 [16]=
=3D0 [17]=3D0 [18]=3D0 [19]=3D0 [20]=3D0 [21]=3D0 [22]=3D0 [23]=3D0 [24]=3D=
1 [25]=3D1 [26]=3D1 [27]=3D1 [28]=3D1 [29]=3D1 [30]=3D1 [31]=3D1 [32]=3D1 [=
33]=3D1 [34]=3D1 [35]=3D1 [36]=3D1 [37]=3D1 [38]=3D1 [39]=3D1 [40]=3D1 [41]=
=3D1 [42]=3D1 [43]=3D1 [44]=3D1 [45]=3D1 [46]=3D1 [47]=3D1 [48]=3D0 [49]=3D=
0 [50]=3D0 [51]=3D0 [52]=3D0 [53]=3D0 [54]=3D0 [55]=3D0 [56]=3D0 [57]=3D0 [=
58]=3D0 [59]=3D0 [60]=3D0 [61]=3D0 [62]=3D0 [63]=3D0 [64]=3D0 [65]=3D0 [66]=
=3D0 [67]=3D0 [68]=3D0 [69]=3D0 [70]=3D0 [71]=3D0 [72]=3D1 [73]=3D1 [74]=3D=
1 [75]=3D1 [76]=3D1 [77]=3D1 [78]=3D1 [79]=3D1 [80]=3D1 [81]=3D1 [82]=3D1 [=
83]=3D1 [84]=3D1 [85]=3D1 [86]=3D1 [87]=3D1 [88]=3D1 [89]=3D1 [90]=3D1 [91]=
=3D1 [92]=3D1 [93]=3D1 [94]=3D1 [95]=3D1

NUMA
  nr_pods  1
  pod_cpus [0]=3D0xffffffff 0xffffffff ffffffff
  pod_node [0]=3D0
  cpu_pod  [0]=3D0 [1]=3D0 [2]=3D0 [3]=3D0 [4]=3D0 [5]=3D0 [6]=3D0 [7]=3D0 =
[8]=3D0 [9]=3D0 [10]=3D0 [11]=3D0 [12]=3D0 [13]=3D0 [14]=3D0 [15]=3D0 [16]=
=3D0 [17]=3D0 [18]=3D0 [19]=3D0 [20]=3D0 [21]=3D0 [22]=3D0 [23]=3D0 [24]=3D=
0 [25]=3D0 [26]=3D0 [27]=3D0 [28]=3D0 [29]=3D0 [30]=3D0 [31]=3D0 [32]=3D0 [=
33]=3D0 [34]=3D0 [35]=3D0 [36]=3D0 [37]=3D0 [38]=3D0 [39]=3D0 [40]=3D0 [41]=
=3D0 [42]=3D0 [43]=3D0 [44]=3D0 [45]=3D0 [46]=3D0 [47]=3D0 [48]=3D0 [49]=3D=
0 [50]=3D0 [51]=3D0 [52]=3D0 [53]=3D0 [54]=3D0 [55]=3D0 [56]=3D0 [57]=3D0 [=
58]=3D0 [59]=3D0 [60]=3D0 [61]=3D0 [62]=3D0 [63]=3D0 [64]=3D0 [65]=3D0 [66]=
=3D0 [67]=3D0 [68]=3D0 [69]=3D0 [70]=3D0 [71]=3D0 [72]=3D0 [73]=3D0 [74]=3D=
0 [75]=3D0 [76]=3D0 [77]=3D0 [78]=3D0 [79]=3D0 [80]=3D0 [81]=3D0 [82]=3D0 [=
83]=3D0 [84]=3D0 [85]=3D0 [86]=3D0 [87]=3D0 [88]=3D0 [89]=3D0 [90]=3D0 [91]=
=3D0 [92]=3D0 [93]=3D0 [94]=3D0 [95]=3D0

SYSTEM
  nr_pods  1
  pod_cpus [0]=3D0xffffffff 0xffffffff ffffffff
  pod_node [0]=3D-1
  cpu_pod  [0]=3D0 [1]=3D0 [2]=3D0 [3]=3D0 [4]=3D0 [5]=3D0 [6]=3D0 [7]=3D0 =
[8]=3D0 [9]=3D0 [10]=3D0 [11]=3D0 [12]=3D0 [13]=3D0 [14]=3D0 [15]=3D0 [16]=
=3D0 [17]=3D0 [18]=3D0 [19]=3D0 [20]=3D0 [21]=3D0 [22]=3D0 [23]=3D0 [24]=3D=
0 [25]=3D0 [26]=3D0 [27]=3D0 [28]=3D0 [29]=3D0 [30]=3D0 [31]=3D0 [32]=3D0 [=
33]=3D0 [34]=3D0 [35]=3D0 [36]=3D0 [37]=3D0 [38]=3D0 [39]=3D0 [40]=3D0 [41]=
=3D0 [42]=3D0 [43]=3D0 [44]=3D0 [45]=3D0 [46]=3D0 [47]=3D0 [48]=3D0 [49]=3D=
0 [50]=3D0 [51]=3D0 [52]=3D0 [53]=3D0 [54]=3D0 [55]=3D0 [56]=3D0 [57]=3D0 [=
58]=3D0 [59]=3D0 [60]=3D0 [61]=3D0 [62]=3D0 [63]=3D0 [64]=3D0 [65]=3D0 [66]=
=3D0 [67]=3D0 [68]=3D0 [69]=3D0 [70]=3D0 [71]=3D0 [72]=3D0 [73]=3D0 [74]=3D=
0 [75]=3D0 [76]=3D0 [77]=3D0 [78]=3D0 [79]=3D0 [80]=3D0 [81]=3D0 [82]=3D0 [=
83]=3D0 [84]=3D0 [85]=3D0 [86]=3D0 [87]=3D0 [88]=3D0 [89]=3D0 [90]=3D0 [91]=
=3D0 [92]=3D0 [93]=3D0 [94]=3D0 [95]=3D0

Worker Pools
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
pool[000] ref=3D   1 nice=3D  0 idle/workers=3D  3/  3 cpu=3D  0
pool[001] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D  0
pool[002] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D  1
pool[003] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D  1
pool[004] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D  2
pool[005] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D  2
pool[006] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D  3
pool[007] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D  3
pool[008] ref=3D   1 nice=3D  0 idle/workers=3D  3/  3 cpu=3D  4
pool[009] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D  4
pool[010] ref=3D   1 nice=3D  0 idle/workers=3D  3/  3 cpu=3D  5
pool[011] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D  5
pool[012] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D  6
pool[013] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D  6
pool[014] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D  7
pool[015] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D  7
pool[016] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D  8
pool[017] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D  8
pool[018] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D  9
pool[019] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D  9
pool[020] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 10
pool[021] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 10
pool[022] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 11
pool[023] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 11
pool[024] ref=3D   1 nice=3D  0 idle/workers=3D  3/  3 cpu=3D 12
pool[025] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 12
pool[026] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 13
pool[027] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 13
pool[028] ref=3D   1 nice=3D  0 idle/workers=3D  3/  3 cpu=3D 14
pool[029] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 14
pool[030] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 15
pool[031] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 15
pool[032] ref=3D   1 nice=3D  0 idle/workers=3D  3/  3 cpu=3D 16
pool[033] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 16
pool[034] ref=3D   1 nice=3D  0 idle/workers=3D  3/  3 cpu=3D 17
pool[035] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 17
pool[036] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 18
pool[037] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 18
pool[038] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 19
pool[039] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 19
pool[040] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 20
pool[041] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 20
pool[042] ref=3D   1 nice=3D  0 idle/workers=3D  3/  3 cpu=3D 21
pool[043] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 21
pool[044] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 22
pool[045] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 22
pool[046] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 23
pool[047] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 23
pool[048] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 24
pool[049] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 24
pool[050] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 25
pool[051] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 25
pool[052] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 26
pool[053] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 26
pool[054] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 27
pool[055] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 27
pool[056] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 28
pool[057] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 28
pool[058] ref=3D   1 nice=3D  0 idle/workers=3D  3/  3 cpu=3D 29
pool[059] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 29
pool[060] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 30
pool[061] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 30
pool[062] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 31
pool[063] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 31
pool[064] ref=3D   1 nice=3D  0 idle/workers=3D  3/  3 cpu=3D 32
pool[065] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 32
pool[066] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 33
pool[067] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 33
pool[068] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 34
pool[069] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 34
pool[070] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 35
pool[071] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 35
pool[072] ref=3D   1 nice=3D  0 idle/workers=3D  3/  3 cpu=3D 36
pool[073] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 36
pool[074] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 37
pool[075] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 37
pool[076] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 38
pool[077] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 38
pool[078] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 39
pool[079] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 39
pool[080] ref=3D   1 nice=3D  0 idle/workers=3D  3/  3 cpu=3D 40
pool[081] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 40
pool[082] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 41
pool[083] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 41
pool[084] ref=3D   1 nice=3D  0 idle/workers=3D  3/  3 cpu=3D 42
pool[085] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 42
pool[086] ref=3D   1 nice=3D  0 idle/workers=3D  3/  3 cpu=3D 43
pool[087] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 43
pool[088] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 44
pool[089] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 44
pool[090] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 45
pool[091] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 45
pool[092] ref=3D   1 nice=3D  0 idle/workers=3D  3/  3 cpu=3D 46
pool[093] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 46
pool[094] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 47
pool[095] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 47
pool[096] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 48
pool[097] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 48
pool[098] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 49
pool[099] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 49
pool[100] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 50
pool[101] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 50
pool[102] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 51
pool[103] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 51
pool[104] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 52
pool[105] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 52
pool[106] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 53
pool[107] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 53
pool[108] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 54
pool[109] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 54
pool[110] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 55
pool[111] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 55
pool[112] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 56
pool[113] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 56
pool[114] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 57
pool[115] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 57
pool[116] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 58
pool[117] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 58
pool[118] ref=3D   1 nice=3D  0 idle/workers=3D  3/  3 cpu=3D 59
pool[119] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 59
pool[120] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 60
pool[121] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 60
pool[122] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 61
pool[123] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 61
pool[124] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 62
pool[125] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 62
pool[126] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 63
pool[127] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 63
pool[128] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 64
pool[129] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 64
pool[130] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 65
pool[131] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 65
pool[132] ref=3D   1 nice=3D  0 idle/workers=3D  3/  3 cpu=3D 66
pool[133] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 66
pool[134] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 67
pool[135] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 67
pool[136] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 68
pool[137] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 68
pool[138] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 69
pool[139] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 69
pool[140] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 70
pool[141] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 70
pool[142] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 71
pool[143] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 71
pool[144] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 72
pool[145] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 72
pool[146] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 73
pool[147] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 73
pool[148] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 74
pool[149] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 74
pool[150] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 75
pool[151] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 75
pool[152] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 76
pool[153] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 76
pool[154] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 77
pool[155] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 77
pool[156] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 78
pool[157] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 78
pool[158] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 79
pool[159] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 79
pool[160] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 80
pool[161] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 80
pool[162] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 81
pool[163] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 81
pool[164] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 82
pool[165] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 82
pool[166] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 83
pool[167] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 83
pool[168] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 84
pool[169] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 84
pool[170] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 85
pool[171] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 85
pool[172] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 86
pool[173] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 86
pool[174] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 87
pool[175] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 87
pool[176] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 88
pool[177] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 88
pool[178] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 89
pool[179] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 89
pool[180] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 90
pool[181] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 90
pool[182] ref=3D   1 nice=3D  0 idle/workers=3D  4/  4 cpu=3D 91
pool[183] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 91
pool[184] ref=3D   1 nice=3D  0 idle/workers=3D  4/  4 cpu=3D 92
pool[185] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 92
pool[186] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 93
pool[187] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 93
pool[188] ref=3D   1 nice=3D  0 idle/workers=3D  3/  3 cpu=3D 94
pool[189] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 94
pool[190] ref=3D   1 nice=3D  0 idle/workers=3D  2/  2 cpu=3D 95
pool[191] ref=3D   1 nice=3D-20 idle/workers=3D  2/  2 cpu=3D 95
pool[192] ref=3D  78 nice=3D  0 idle/workers=3D  2/  2 cpus=3D0xffffffff 0x=
ffffffff ffffffff pod_cpus=3D0xffffffff 0xffffffff ffffffff
pool[193] ref=3D3744 nice=3D  0 idle/workers=3D  8/ 10 cpus=3D0xffffffff 0x=
ffffffff ffffffff pod_cpus=3D0xffffff 0xffff0000 000000ff
pool[194] ref=3D3744 nice=3D  0 idle/workers=3D  5/  9 cpus=3D0xffffffff 0x=
ffffffff ffffffff pod_cpus=3D0xff000000 0xffff ffffff00
pool[195] ref=3D   7 nice=3D-20 idle/workers=3D  1/  1 cpus=3D0xffffffff 0x=
ffffffff ffffffff pod_cpus=3D0xffffffff 0xffffffff ffffffff
pool[196] ref=3D 336 nice=3D-20 idle/workers=3D  1/  1 cpus=3D0xffffffff 0x=
ffffffff ffffffff pod_cpus=3D0xffffff 0xffff0000 000000ff
pool[197] ref=3D 336 nice=3D-20 idle/workers=3D  2/  2 cpus=3D0xffffffff 0x=
ffffffff ffffffff pod_cpus=3D0xff000000 0xffff ffffff00

Workqueue CPU -> pool
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    workqueue     \     type   CPU   0   1   2   3   4   5   6   7   8   9=
  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  2=
8  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  =
47  48  49  50  51  52  53  54  55  56  57  58  59  60  61  62  63  64  65 =
 66  67  68  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84=
  85  86  87  88  89  90  91  92  93  94  95 dfl]
events                   percpu       0   2   4   6   8  10  12  14  16  18=
  20  22  24  26  28  30  32  34  36  38  40  42  44  46  48  50  52  54  5=
6  58  60  62  64  66  68  70  72  74  76  78  80  82  84  86  88  90  92  =
94  96  98 100 102 104 106 108 110 112 114 116 118 120 122 124 126 128 130 =
132 134 136 138 140 142 144 146 148 150 152 154 156 158 160 162 164 166 168=
 170 172 174 176 178 180 182 184 186 188 190
events_highpri           percpu       1   3   5   7   9  11  13  15  17  19=
  21  23  25  27  29  31  33  35  37  39  41  43  45  47  49  51  53  55  5=
7  59  61  63  65  67  69  71  73  75  77  79  81  83  85  87  89  91  93  =
95  97  99 101 103 105 107 109 111 113 115 117 119 121 123 125 127 129 131 =
133 135 137 139 141 143 145 147 149 151 153 155 157 159 161 163 165 167 169=
 171 173 175 177 179 181 183 185 187 189 191
events_long              percpu       0   2   4   6   8  10  12  14  16  18=
  20  22  24  26  28  30  32  34  36  38  40  42  44  46  48  50  52  54  5=
6  58  60  62  64  66  68  70  72  74  76  78  80  82  84  86  88  90  92  =
94  96  98 100 102 104 106 108 110 112 114 116 118 120 122 124 126 128 130 =
132 134 136 138 140 142 144 146 148 150 152 154 156 158 160 162 164 166 168=
 170 172 174 176 178 180 182 184 186 188 190
events_unbound           unbound    193 193 193 193 193 193 193 193 193 193=
 193 193 193 193 193 193 193 193 193 193 193 193 193 193 194 194 194 194 19=
4 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 1=
94 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 =
193 193 193 193 193 193 194 194 194 194 194 194 194 194 194 194 194 194 194=
 194 194 194 194 194 194 194 194 194 194 194 192
events_freezable         percpu       0   2   4   6   8  10  12  14  16  18=
  20  22  24  26  28  30  32  34  36  38  40  42  44  46  48  50  52  54  5=
6  58  60  62  64  66  68  70  72  74  76  78  80  82  84  86  88  90  92  =
94  96  98 100 102 104 106 108 110 112 114 116 118 120 122 124 126 128 130 =
132 134 136 138 140 142 144 146 148 150 152 154 156 158 160 162 164 166 168=
 170 172 174 176 178 180 182 184 186 188 190
events_power_efficient   percpu       0   2   4   6   8  10  12  14  16  18=
  20  22  24  26  28  30  32  34  36  38  40  42  44  46  48  50  52  54  5=
6  58  60  62  64  66  68  70  72  74  76  78  80  82  84  86  88  90  92  =
94  96  98 100 102 104 106 108 110 112 114 116 118 120 122 124 126 128 130 =
132 134 136 138 140 142 144 146 148 150 152 154 156 158 160 162 164 166 168=
 170 172 174 176 178 180 182 184 186 188 190
events_freezable_power_  percpu       0   2   4   6   8  10  12  14  16  18=
  20  22  24  26  28  30  32  34  36  38  40  42  44  46  48  50  52  54  5=
6  58  60  62  64  66  68  70  72  74  76  78  80  82  84  86  88  90  92  =
94  96  98 100 102 104 106 108 110 112 114 116 118 120 122 124 126 128 130 =
132 134 136 138 140 142 144 146 148 150 152 154 156 158 160 162 164 166 168=
 170 172 174 176 178 180 182 184 186 188 190
(snip)
btrfs-worker             unbound    193 193 193 193 193 193 193 193 193 193=
 193 193 193 193 193 193 193 193 193 193 193 193 193 193 194 194 194 194 19=
4 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 1=
94 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 =
193 193 193 193 193 193 194 194 194 194 194 194 194 194 194 194 194 194 194=
 194 194 194 194 194 194 194 194 194 194 194 192
btrfs-delalloc           unbound    193 193 193 193 193 193 193 193 193 193=
 193 193 193 193 193 193 193 193 193 193 193 193 193 193 194 194 194 194 19=
4 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 1=
94 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 =
193 193 193 193 193 193 194 194 194 194 194 194 194 194 194 194 194 194 194=
 194 194 194 194 194 194 194 194 194 194 194 192
btrfs-flush_delalloc     ordered    193 193 193 193 193 193 193 193 193 193=
 193 193 193 193 193 193 193 193 193 193 193 193 193 193 194 194 194 194 19=
4 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 1=
94 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 =
193 193 193 193 193 193 194 194 194 194 194 194 194 194 194 194 194 194 194=
 194 194 194 194 194 194 194 194 194 194 194 192
btrfs-cache              ordered    193 193 193 193 193 193 193 193 193 193=
 193 193 193 193 193 193 193 193 193 193 193 193 193 193 194 194 194 194 19=
4 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 1=
94 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 =
193 193 193 193 193 193 194 194 194 194 194 194 194 194 194 194 194 194 194=
 194 194 194 194 194 194 194 194 194 194 194 192
btrfs-fixup              ordered    193 193 193 193 193 193 193 193 193 193=
 193 193 193 193 193 193 193 193 193 193 193 193 193 193 194 194 194 194 19=
4 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 1=
94 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 =
193 193 193 193 193 193 194 194 194 194 194 194 194 194 194 194 194 194 194=
 194 194 194 194 194 194 194 194 194 194 194 192
btrfs-endio              unbound    193 193 193 193 193 193 193 193 193 193=
 193 193 193 193 193 193 193 193 193 193 193 193 193 193 194 194 194 194 19=
4 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 1=
94 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 =
193 193 193 193 193 193 194 194 194 194 194 194 194 194 194 194 194 194 194=
 194 194 194 194 194 194 194 194 194 194 194 192
btrfs-endio-meta         unbound    193 193 193 193 193 193 193 193 193 193=
 193 193 193 193 193 193 193 193 193 193 193 193 193 193 194 194 194 194 19=
4 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 1=
94 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 =
193 193 193 193 193 193 194 194 194 194 194 194 194 194 194 194 194 194 194=
 194 194 194 194 194 194 194 194 194 194 194 192
btrfs-rmw                unbound    193 193 193 193 193 193 193 193 193 193=
 193 193 193 193 193 193 193 193 193 193 193 193 193 193 194 194 194 194 19=
4 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 1=
94 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 =
193 193 193 193 193 193 194 194 194 194 194 194 194 194 194 194 194 194 194=
 194 194 194 194 194 194 194 194 194 194 194 192
btrfs-endio-write        unbound    193 193 193 193 193 193 193 193 193 193=
 193 193 193 193 193 193 193 193 193 193 193 193 193 193 194 194 194 194 19=
4 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 1=
94 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 =
193 193 193 193 193 193 194 194 194 194 194 194 194 194 194 194 194 194 194=
 194 194 194 194 194 194 194 194 194 194 194 192
btrfs-compressed-write   unbound    193 193 193 193 193 193 193 193 193 193=
 193 193 193 193 193 193 193 193 193 193 193 193 193 193 194 194 194 194 19=
4 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 1=
94 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 =
193 193 193 193 193 193 194 194 194 194 194 194 194 194 194 194 194 194 194=
 194 194 194 194 194 194 194 194 194 194 194 192
btrfs-freespace-write    ordered    193 193 193 193 193 193 193 193 193 193=
 193 193 193 193 193 193 193 193 193 193 193 193 193 193 194 194 194 194 19=
4 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 1=
94 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 =
193 193 193 193 193 193 194 194 194 194 194 194 194 194 194 194 194 194 194=
 194 194 194 194 194 194 194 194 194 194 194 192
btrfs-delayed-meta       ordered    193 193 193 193 193 193 193 193 193 193=
 193 193 193 193 193 193 193 193 193 193 193 193 193 193 194 194 194 194 19=
4 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 1=
94 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 =
193 193 193 193 193 193 194 194 194 194 194 194 194 194 194 194 194 194 194=
 194 194 194 194 194 194 194 194 194 194 194 192
btrfs-qgroup-rescan      ordered    193 193 193 193 193 193 193 193 193 193=
 193 193 193 193 193 193 193 193 193 193 193 193 193 193 194 194 194 194 19=
4 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 1=
94 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 =
193 193 193 193 193 193 194 194 194 194 194 194 194 194 194 194 194 194 194=
 194 194 194 194 194 194 194 194 194 194 194 192
btrfs_discard            ordered    193 193 193 193 193 193 193 193 193 193=
 193 193 193 193 193 193 193 193 193 193 193 193 193 193 194 194 194 194 19=
4 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 194 1=
94 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 193 =
193 193 193 193 193 193 194 194 194 194 194 194 194 194 194 194 194 194 194=
 194 194 194 194 194 194 194 194 194 194 194 192
dio/sdbj                 percpu       0   2   4   6   8  10  12  14  16  18=
  20  22  24  26  28  30  32  34  36  38  40  42  44  46  48  50  52  54  5=
6  58  60  62  64  66  68  70  72  74  76  78  80  82  84  86  88  90  92  =
94  96  98 100 102 104 106 108 110 112 114 116 118 120 122 124 126 128 130 =
132 134 136 138 140 142 144 146 148 150 152 154 156 158 160 162 164 166 168=
 170 172 174 176 178 180 182 184 186 188 190=

