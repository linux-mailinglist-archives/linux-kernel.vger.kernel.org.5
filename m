Return-Path: <linux-kernel+bounces-8201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C710C81B392
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD1B1F24DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3244264711;
	Thu, 21 Dec 2023 10:31:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2047.outbound.protection.outlook.com [40.107.255.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7C064146;
	Thu, 21 Dec 2023 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLYW98FDav+nWPveQp1pvHE80oATtFDvYrvmGW9/iDQQk8bC2kTTri2gzseYgnxtoMkqD5xDx955ebR4pk7O90RZoIgBSbVe9yAk5Ti/egicBU6Ds9Q5qrzdXfOJPWuaJfS+zlnmcOwQKvuU+ItSRcy7C4CZnyxTPWA9Or2o/nLcIhf4w1YEx0MSqXOZ0EHn3u2YO4h0Kf35R7UybMRPaYqktc9Vf5smX+3EDE7LVoMV/M8PxGob+i5xR2z2GC45F/HuBIc/3R3ZTWRrzj/8mSP6OdVJQIX+PMkRv7hEORTQKOYTpdidM1J9gkNG7gB/sS/DZSCgXOzZIvDdz3wV3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5hSi6kW0BKxiA12DlSe40Arfjwiw9b/a4KsS2i+z64=;
 b=fsIXjAeS0aSZlC42eydypjeNvx8rsimB9ezOvJKS48YJR7CdNI+p5YIKs4g7l3iONKZFcOskODCjcBru3YaZmIddvZ5v0Lyf2+zFCqbvRTLJp9Cq6diQ9O4WVgSdLNoD9PCkQvoaVsNYXGptnBv53+uvsVBrJlaSm7E3XMDbbbKdb5UZSaBzZeAK8u2g8xGf5nAl+C8/rt25e1vACYEErRJVbZ1KbeKhJagTNC4OtL19NJS/LrBd7Xzi48FgZVcm+Bb9eDsstxxDl+BXqL97Pxjd8Vnon3IN8I/BfxL3l/TmQCkA8HH8JUoF3BBI+YyMEiqVp7x0Kezskz4LE8azZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from PUZPR06MB5498.apcprd06.prod.outlook.com (2603:1096:301:101::14)
 by JH0PR06MB6415.apcprd06.prod.outlook.com (2603:1096:990:14::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 10:31:30 +0000
Received: from PUZPR06MB5498.apcprd06.prod.outlook.com
 ([fe80::f3a3:b8e8:6e3f:70b1]) by PUZPR06MB5498.apcprd06.prod.outlook.com
 ([fe80::f3a3:b8e8:6e3f:70b1%3]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 10:31:29 +0000
From: Xinglong Yang <xinglong.yang@cixtech.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
CC: "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] firmware: arm_scmi: Check Mailbox/SMT channel for
 consistency
Thread-Topic: [PATCH] firmware: arm_scmi: Check Mailbox/SMT channel for
 consistency
Thread-Index: AQHaM2j73q0S6m9b4UmorQvngEo3CLCzio0g
Date: Thu, 21 Dec 2023 10:31:29 +0000
Message-ID:
 <PUZPR06MB54988A8170D462FC8EE43A05F095A@PUZPR06MB5498.apcprd06.prod.outlook.com>
References: <20231220172112.763539-1-cristian.marussi@arm.com>
In-Reply-To: <20231220172112.763539-1-cristian.marussi@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5498:EE_|JH0PR06MB6415:EE_
x-ms-office365-filtering-correlation-id: 80d67579-9247-48d4-40c4-08dc020ffe8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RdatFF+7BDTGR/Dt/tv8YnnIXxCOUSS420G/ixGYG2b+o1wK5OsjfxSULgYMd6+AzmZnXx5OOjdqjsb2srjmbdKTVryxWQ0YfA9IpMByI7kEejjTJcO1UM0XZjni0kgm6Xu8iE50BEtfHSSWd/bhYX9FWC3gEonqou2dlGs+Gr7+y/s9+oA3gySeuDkFSG4e2AJ96mk6u1E+a9oCJAX2jVDg45/bDQREXfFwPxWUs5j3mVW6i22McAUbS2msvHS+ZKQGodEAUO2hWQd078JSOFtUaDZCvPa9+yOA/jpvqk0ksXVVynMTn8X/H+GH0dFJvvbTEjGhkVgshOZB1YiS3IlkJotSL5G4iByAsG3C8Ju1p6imWRLUmvVcpccrSGDWdXnlzz91DgjI76bBCddrY6mOwbBze16s3D/vo53paWMDV4/HZ1xzm1K8FOPVXtL3tO/gzekdOUVyn6TgSWPtsDjJrEbvkPt+xc0GeSywIGs1KsEM43hHVOtV0UX39IiT/KeC36aTVeUwYpDr6TsO5adY9xsnl4ri5RMXIqs6Uw+rvZ0gAJ9S8XE0CbJqd3okorUrYPpD1EQouCqWe0/9szJo9ujeqBOCeect6Vre5D8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5498.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(376002)(346002)(396003)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2906002)(5660300002)(15650500001)(6506007)(9686003)(41300700001)(26005)(83380400001)(122000001)(71200400001)(45080400002)(478600001)(966005)(38100700002)(7696005)(38070700009)(66556008)(66476007)(64756008)(66446008)(66946007)(44832011)(76116006)(8676002)(8936002)(33656002)(54906003)(110136005)(316002)(86362001)(4326008)(52536014)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XP/6du1ofuNes8V5tKfJhh4NrahJ0HPhhGsGaeZIuC4JtKFyZhdiuSeZ6ehb?=
 =?us-ascii?Q?uwSpMl1rWA3CjT33irk/GlxAGLrfW+3/TS21CBuwfl0b1HWMuzv8jdP1zTXd?=
 =?us-ascii?Q?YHgDwad4mhRLRc4h2J+q7AL0WfkVlHOVqSprItqd7bzjSbjKyVUGWgDKH2Vt?=
 =?us-ascii?Q?CuDVpc6nih7MHrVVazW5LWc2DemypNCbK4xDlUzKfm5BkVbNADll1J1QePuB?=
 =?us-ascii?Q?ZFBxXf9YpaVWJ7HNTFpsrxrklpRKf8RVVvOCc5e4ThSr9wMXyifHYNSnyhnm?=
 =?us-ascii?Q?hfnhrn5uDyrHaWAZ4uSRyNgdMJWWACfKgEqsAOhMvBirSwKtb7ND+uDnQE4e?=
 =?us-ascii?Q?vXOVXcaIwSLclNqJA3h9kxq10JIS2j3eAvBlMlJwi1LOX/1SFfnUkzWolHU0?=
 =?us-ascii?Q?c2rhYI+KQOK/JAjKYtqvXO78mXT5Q+OpzwL9fLR4CxJ+Mqzw9Rlpzb6UN4wA?=
 =?us-ascii?Q?aXMET6H3rkaOSI9CGw/rN/WtV8W6N2Bhv2rdR3tb2zWkeNgwxC6GHAvyOh6O?=
 =?us-ascii?Q?kjD8hQ0fliGDqF3e5QaStWr+jJcmdP7BJ9AJLzpAR3lnARA1gyKAaRwadeai?=
 =?us-ascii?Q?5xZNDVG9SGaku4hkSjmtBRQ3UT3oa+tRuLcyYMg65qPa8YOYiFg87g1KcqxC?=
 =?us-ascii?Q?+rcjIZcF5H+W2yaM3tf0iHIVgXzW8/ISyiVhmZIfmyUqeWkPAADSADFzwgRM?=
 =?us-ascii?Q?JnI/3Svm1GBA6gAnKDQhLbMSNjTsmv60XPrb5nbgM2b8fBzhvQQ84HBEam+N?=
 =?us-ascii?Q?SLMRPcSkQ4auO061xnWiTmtfB8j8PVFu8eqagnw2zeNbJpmHnYgm7Yws82Ef?=
 =?us-ascii?Q?3BeVIEMrP9f4BGQlltWJJnxHlB5PxrBVm5pLihRwKmOArC5msjuHoYcO01ki?=
 =?us-ascii?Q?ORD3mouavsIU/42Hgk1E9JEEEdQmjmMGdHolxfzGUZkjflxnU5RDbD5vSvin?=
 =?us-ascii?Q?NzsYrZD06vN/USRBE4SYXgkbg4yZae+m7KlgePteqGsf5BcPY7ty/4YC0xLC?=
 =?us-ascii?Q?ETJJKnpzPIMsrW2wqMjcmLC6KpVM7tYFYJ98lbXwfCs2AqeH+1frtETs6RGQ?=
 =?us-ascii?Q?QaVIK8mZ1hWOh8uiX9c8lFLyqAkYVGp3mVVpleyvw8KrdhVB1Ps8A2hFUjs0?=
 =?us-ascii?Q?vaXC3dZdw+vxDCLacAYlGcDK1Nar3/U2Jg0s5KSDGshzeCugcqfz3F1Dha5c?=
 =?us-ascii?Q?bEOxQUipzpEGLJZoX0XBx44EPzaj+Xfd7p39mOCpovt4D5mfhARX/z0Va6q+?=
 =?us-ascii?Q?5wBiGMSa29/Zghx3KoqU/2wnhScBHjVnhYv4wVCvKZZ7MSOY7je52O6XksKg?=
 =?us-ascii?Q?FPp5myPrVnC23Jy/8Mwg2aXhIahaK9ILb1/788fw2PQxy5YQxEJJ2sV7ANnk?=
 =?us-ascii?Q?mZ8drpxu6erxreeGzxDBhIdChZMQVqSWtJUSxRNhOTXx0hzEFj6MWxRqy1u3?=
 =?us-ascii?Q?tFbF96NdrUL04Rxv5N8U6RY0Aa0tXo9wv4x0AHB/TWW0ilj1wlOGtaXRfzAZ?=
 =?us-ascii?Q?cU17tjOjBl0m6arBRRGPXQiD4GAbIFO5vo/vjn4clTMxp/h8tOhTVSBcmH2w?=
 =?us-ascii?Q?lzm/XUCXdbtn+WDhrEl5INmuX3Jf9DBVF3M32CbW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5498.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d67579-9247-48d4-40c4-08dc020ffe8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 10:31:29.7499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8l1Fg+SGVagXG0VrFb7JLfzY3GD8O8NLylqETcgX7/wLIjpdyxXUEyJEW0olnGUjNjr5sJLHhJcBpnydAKoJUs3diJs056hS1MmfqIY4MA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6415

Hi, Cristian

This patch successfully solves the bug.

From: Cristian Marussi <cristian.marussi@arm.com> Sent: Thursday, December =
21, 2023 1:21 AM
> On reception of a completion interrupt the SMT memory area is accessed to
> retrieve the message header at first and then, if the message sequence
> number identifies a transaction which is still pending, the related
> payload is fetched too.
>
> When an SCMI command times out the channel ownership remains with the
> platform until eventually a late reply is received and, as a consequence,
> any further transmission attempt remains pending, waiting for the channel
> to be relinquished by the platform.
>
> Once that late reply is received the channel ownership is given back
> to the agent and any pending request is then allowed to proceed and
> overwrite the SMT area of the just delivered late reply; then the wait fo=
r
> the reply to the new request starts.
>
> It has been observed that the spurious IRQ related to the late reply can
> be wrongly associated with the freshly enqueued request: when that
> happens
> the SCMI stack in-flight lookup procedure is fooled by the fact that the
> message header now present in the SMT area is related to the new pending
> transaction, even though the real reply has still to arrive.
>
> This race-condition on the A2P channel can be detected by looking at the
> channel status bits: a genuine reply from the platform will have set the
> channel free bit before triggering the completion IRQ.
>
> Add a consistency check to validate such condition in the A2P ISR.
>
> Reported-by: Xinglong Yang <xinglong.yang@cixtech.com>
> Closes:
> https://lore.k/
> ernel.org%2Fall%2FPUZPR06MB54981E6FA00D82BFDBB864FBF08DA%40PUZP
> R06MB5498.apcprd06.prod.outlook.com%2F&data=3D05%7C02%7Cxinglong.ya
> ng%40cixtech.com%7C669e9ff5e6764a77791208dc01801b8e%7C0409f77ae53
> d4d23943eccade7cb4811%7C1%7C0%7C638386896955072826%7CUnknown%
> 7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> wiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DT1DOD7KfY%2FJNJHacHtX
> d5wcfde%2Fd5UDqGvyW4vuYwYU%3D&reserved=3D0
> Fixes: 5c8a47a5a91d ("firmware: arm_scmi: Make scmi core independent of
> the transport type")
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/common.h  |  1 +
>  drivers/firmware/arm_scmi/mailbox.c | 14 ++++++++++++++
>  drivers/firmware/arm_scmi/shmem.c   |  6 ++++++
>  3 files changed, 21 insertions(+)
>
> diff --git a/drivers/firmware/arm_scmi/common.h
> b/drivers/firmware/arm_scmi/common.h
> index 3b7c68a11fd0..0956c2443840 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -329,6 +329,7 @@ void shmem_fetch_notification(struct
> scmi_shared_mem __iomem *shmem,
>  void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem);
>  bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
>                      struct scmi_xfer *xfer);
> +bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem);
>
>  /* declarations for message passing transports */
>  struct scmi_msg_payld;
> diff --git a/drivers/firmware/arm_scmi/mailbox.c
> b/drivers/firmware/arm_scmi/mailbox.c
> index 19246ed1f01f..b8d470417e8f 100644
> --- a/drivers/firmware/arm_scmi/mailbox.c
> +++ b/drivers/firmware/arm_scmi/mailbox.c
> @@ -45,6 +45,20 @@ static void rx_callback(struct mbox_client *cl, void *=
m)
>  {
>         struct scmi_mailbox *smbox =3D client_to_scmi_mailbox(cl);
>
> +       /*
> +        * An A2P IRQ is NOT valid when received while the platform still=
 has
> +        * the ownership of the channel, because the platform at first re=
leases
> +        * the SMT channel and then sends the completion interrupt.
> +        *
> +        * This addresses a possible race condition in which a spurious I=
RQ from
> +        * a previous timed-out reply which arrived late could be wrongly
> +        * associated with the next pending transaction.
> +        */
> +       if (cl->knows_txdone && !shmem_channel_free(smbox->shmem)) {
> +               dev_warn(smbox->cinfo->dev, "Ignoring spurious A2P IRQ !\=
n");
> +               return;
> +       }
> +
>         scmi_rx_callback(smbox->cinfo, shmem_read_header(smbox->shmem),
> NULL);
>  }
>
> diff --git a/drivers/firmware/arm_scmi/shmem.c
> b/drivers/firmware/arm_scmi/shmem.c
> index 87b4f4d35f06..517d52fb3bcb 100644
> --- a/drivers/firmware/arm_scmi/shmem.c
> +++ b/drivers/firmware/arm_scmi/shmem.c
> @@ -122,3 +122,9 @@ bool shmem_poll_done(struct scmi_shared_mem
> __iomem *shmem,
>                 (SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR |
>                  SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE);
>  }
> +
> +bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem)
> +{
> +       return (ioread32(&shmem->channel_status) &
> +                       SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE);
> +}
> --
> 2.34.1

Thanks,
Xinglong

