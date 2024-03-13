Return-Path: <linux-kernel+bounces-102523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FD087B34C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161C5289353
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734EB52F62;
	Wed, 13 Mar 2024 21:12:29 +0000 (UTC)
Received: from mx30.also.com (mx30.also.com [46.231.192.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D29E5786B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=46.231.192.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710364348; cv=fail; b=fk+B0+udSaeZeBIHgl6LI8xm5iHRQ5KJO6OJkNCxQbL9y2zm9M27Aw4nigqlW1uyoeypn0M8ENt+RNG5IOt86yjM+ktYGJK5uzcK7TQqCo53hLDwh0+s3tn4guC/xHf1bUzSPzAZGiF/Yh6OVjQUJSm8Bv0pXuN1ZpFZIBQ0CTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710364348; c=relaxed/simple;
	bh=56lqnsFZ+z6kdhcwUNnG3yFzoGkdqAXhVMz947IFANI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZjIGDrmXBISa/PXNpT9cBSrrmQTnuxodrnXO+TA4yUzWUZrHKD8J0h9P6mUMkO9fB6+9nkUu094Fc9wplnFx/K+5MU0o7zPKB8zn+q2p8pVOSzXk9hETiJepDMUom3Fb58dRIDwXEpGggbb9Xy60ILbpMFZdMjdWvdnUiyb+kNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.ua; spf=pass smtp.mailfrom=hpe.ua; arc=fail smtp.client-ip=46.231.192.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.ua
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.ua
Received: from 172.28.22.3 by mx30.also.com (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Wed, 13 Mar 2024 21:07:24 GMT
From: Anton Gavriliuk <Anton.Gavriliuk@hpe.ua>
To: Li Feng <fengli@smartx.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, "open list:NVM EXPRESS DRIVER"
	<linux-nvme@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] nvme/tcp: Add wq_unbound modparam for nvme_tcp_wq
Thread-Topic: [PATCH v2 2/2] nvme/tcp: Add wq_unbound modparam for nvme_tcp_wq
Thread-Index: AQHadUN5+uWesked50+FTP+LFMilnbE2JQ4w
Date: Wed, 13 Mar 2024 21:07:19 +0000
Message-ID: <VI1PR05MB4431B6A2DF97E31C9103A364992A2@VI1PR05MB4431.eurprd05.prod.outlook.com>
References: <20240313123816.625115-1-fengli@smartx.com>
 <20240313123816.625115-2-fengli@smartx.com>
In-Reply-To: <20240313123816.625115-2-fengli@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_8dbef4c5-c818-41ba-ac89-c164c445b051_ActionId=31ef3d83-eb99-4499-9e48-c7f22e039790;MSIP_Label_8dbef4c5-c818-41ba-ac89-c164c445b051_ContentBits=0;MSIP_Label_8dbef4c5-c818-41ba-ac89-c164c445b051_Enabled=true;MSIP_Label_8dbef4c5-c818-41ba-ac89-c164c445b051_Method=Standard;MSIP_Label_8dbef4c5-c818-41ba-ac89-c164c445b051_Name=8dbef4c5-c818-41ba-ac89-c164c445b051;MSIP_Label_8dbef4c5-c818-41ba-ac89-c164c445b051_SetDate=2024-03-13T20:48:24Z;MSIP_Label_8dbef4c5-c818-41ba-ac89-c164c445b051_SiteId=95924808-3044-4177-9c1b-713746ffab95;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hpe.ua;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR05MB4431:EE_|AS5PR05MB11072:EE_
x-ms-office365-filtering-correlation-id: 0ce9c541-a874-4826-381c-08dc43a191c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jYAZS+8yuHb7Ew3B2BVcyUFlKeKyhRaoUPnB7kaQD9CxCVpOKPwQHXggtrdRERUFo8qHycVZb6+wS8IQvgU8rJDebcvRUuZrhwk/RplIcJbuUwP1Ps6dH8Xp25y18SKXqXC9bVO4SXcNOa9mf6JAXbcyFoViJ2zAdz4xH8c7umEZ2rjaQTNHUuBQsRZfV9B3xH1Pxf58JtArn/hECLU2XYka/lTiEOjWZkq1o2nWbDEKOixrTTXgW0Jj/tTkoU55a1h8cIZJSch7XLmpUwQfefcBV/beX2Xz1+v+TxXdZDRx26RcVucuQD/FvQNrlKKaKn6fq3Fqt3s9z8gTlyBJnDRFRMBXE3QMzAcL+30LOD83yU8DAnlEwU1JtAZCiARxPLOrA22FHQPPrFRrgy0MVqv2x25naeUxgTQvWdcEJmg4doDWp3BGj/xaTyYJAVFAp9dZRfkn7SRQAfubLSmYZfuqFDnToovJw0Ll+jEVQ6S30WPMFEwbc/fv9/6KHEY8fUq1WJ7sznTyArinRzIKJ3V+CSrMYcu+AlKXq2nwWKnvTsZSQ3+nstF/k+STUuRDn7ovf5COG85R6y5rxnrQhUMDv9NLj+csZGqw/kP+kwDbyTdp4fQ+9m9OziP/etQCL2nlgp12NRQ4cTdW3E37gUO10XR1IsPz+ncouy9qk5har10pb3QsYQXmMNfJhAtM0c4T3lpg0ZtaQ7fM7wkwsXM08iZa/+huKip3fxyCI40=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4431.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ITCy6CV3Fg46leUF8ZlM97QPyOz/xORL8erPFOqvUKgqNMHFXk0nXNpnjMOK?=
 =?us-ascii?Q?cCtir/dTo0GU6KBO0atAjxH0eLIl+cYRV4lFNykiKclfJTii/msTQEb8hSYN?=
 =?us-ascii?Q?hK/ykH1naJcRFJ7WO1DehKSOQXxF/6ccPXi3QQpWYtaOZqfq65Z+p9msxZff?=
 =?us-ascii?Q?1YY2kRduZoH8cYH2QE2r3XZmGz+vFBRjo9xZYuFR3nL1zF3GGHDwRdwhaTpV?=
 =?us-ascii?Q?sh+vEuGg+MLuJbAC7gYcnPpqPdP/O2lHB3/F+S8Gt9AwVImv2UAP53NQy+Ks?=
 =?us-ascii?Q?fm858vkSmWP+3igqAk7sCetQQkN5Ga03L1BQLmvNJZ+bOlGOQvZkoJwY+9rG?=
 =?us-ascii?Q?3dPs89Zw1SAQhTZeQB0L/j1eqM8Ym3QR9aWdH53Zt5zWHgYs1T9qH6KK7j3D?=
 =?us-ascii?Q?mRD6q4C2hI5X9RN+SdRQmel7lBZ7POrh5ZXWqlnZtQDEVYot5rDHy7mYLB9S?=
 =?us-ascii?Q?M25dT5yLrGPQn6kDhg0UlY6s5P9vLCaGl8llGcvAY6trUnvKCuxZCZfjBlCL?=
 =?us-ascii?Q?OADIAZTekNQUHkCPLwsRHvo/zNAMiZ0oyNf9etjflq50JwJTT9DlRuiiDpin?=
 =?us-ascii?Q?LWok5fykAr8kzVE2r89F3EQBiYcus+5MCLYFY8L9tuBaJDuIjKAOBXCvIsUR?=
 =?us-ascii?Q?FCzvmrCLmZvSB0SYlEwGwbpN53owc/eADBY7PiP2M703pQQ8xr+VLKzB4GVr?=
 =?us-ascii?Q?YlKZhB0HfAfGIu2R0fWXqb2BJuRTjqlQQgEvfEoXM4yKYMlWnuLhTsy+1HQf?=
 =?us-ascii?Q?R5T/iZ2xvXsS6Iimy1HixG4/I4nVSLJMzr3Vl3FOzuIDwzaR9TKeDDWN4hg8?=
 =?us-ascii?Q?2sIRSPG3oWxa0ark5WF+9vAk3gSU4vkHB6wS6UMhtzWMb6CBju70o98xKsDn?=
 =?us-ascii?Q?S/dIKcCJRrTgwhTh5VLFaIJWCAWVAF/JRjxj7TSE0H3Jwq5n3+X/p1DHEC8/?=
 =?us-ascii?Q?KBeLnWoSEWL2bxgdehKU2lfCjfOeD0E/spitMIEy7JPJ66jqrN4bXjoGmQx2?=
 =?us-ascii?Q?DsPv8tPU+YvxZfvCbnWAHKoK4R+8att0rFPgax4tGVIR258JOjRgBKOzt8Va?=
 =?us-ascii?Q?7GE0n8R/lFJEhnV/93nl2tzXHnrMwhzIX1xd1VEW1QZ90Tj4k/7DxALo4W8y?=
 =?us-ascii?Q?paLgiO4spHmr3NiZYn9dAZSw0fNkz4yP/1BTXgSYFGFc32UyklxaqEwDXyVX?=
 =?us-ascii?Q?GNa4GF3sVX5DJZM1mIGg5ywWcwRX/R3hgHX3MLIdmAh8BbcNv1VwWKf+Vl9G?=
 =?us-ascii?Q?VCpEtYuOaQXF/wx5cAUsFmUgvhzhq/PhlmxomyXk0PM/hHJIOHTLYHkFyzsO?=
 =?us-ascii?Q?WnnBvuSsW8aR4GuuZKX+fLhwvjwIiRSu/LUPHpW8KS2SiQnz4KorGWGPnx6X?=
 =?us-ascii?Q?RUXl6cowooWZ81+rfhqiH+XqJVF+aNaKg9HuPby9HSAOdzwX/D5nh32SB7Lx?=
 =?us-ascii?Q?2M518Y2biAcWO35yZ6Kx1wCaoDtlUga77szbzgQr0jLsRg/K0Z5Dr3fBK/du?=
 =?us-ascii?Q?hotwEO6Na7ymJlk324cHc3dhPq65StA/9xW1/RCu2bqTAi5fdC/vb0gH+ylV?=
 =?us-ascii?Q?qChXjQXsUDsrtpPc3UKrTSCKE37KNIEWc4qDm19K?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dh66lFGk1xWXY/pJbmzhDHR6zAPZ7JI4xHSMv4Lt2EXNn4Nf+D0yStSRZzQ33ycIrxHGdpOCTGZdUdMJnF+4gPyLJyTNYHIUcly0ZFQuNO9XgX6SaAMD7ydcMiJnVfcSPl52j6dIV9S/iU6/m4qCA/ro/1q1I69CX6684NLEQ+BQ+7ZmJBmRwsUBBs+/RSKaeVn0kAMF0bMYI8aRpvOU0fFCUbBukUt8VjD/OgjP6vaLt2AY+onn48Zr0WZMXZ8P9Uk3ctGXpgupk5JBgfkBJeji+1y1WcAE7FoU1T/7te4ClDOCzEyOT9kcUTQWSUfR3FA1LzrWLnIsQR4XPQRO3w==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VAKoTriiSjtEIH3vZVsUrlNIHtvlE7FCrM1MoSwOJY=;
 b=G10rdIeLx0rB18TSnBMA8HD4BG8qNG83IAuiqWPAR6/nOTJYFXQh4HEPGU1nKHhKkUeTd+ZiKayx+1yIDUCSuG42NACRNA4P+QEFOD6YJUgtN6qQiq9g/KPTHzqZJm2xqeL2gzgUxQLZ2SwURIhjPSQ1CYfnhfUQBSARjF5man4q4QB2oJBC7fg3a1uPt/kkpKkD+9y7e/vUHcQVxfrTyogzI+jKw7gU1Ppg/fcSEhiJByDCa8gzNzSTheujP+IwWtI/I6HZ+ttUejgq+EIY6pSOttPmfnEpRid+iTjjmJIeeFdhvZRZLCH+sQ/0ScTYOjDrtf3RepzUhsgGt1xE7Q==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.ua; dmarc=pass action=none header.from=hpe.ua; dkim=pass
 header.d=hpe.ua; arc=none
x-ms-exchange-antispam-externalhop-messagedata-chunkcount: 1
x-ms-exchange-antispam-externalhop-messagedata-0: cEUdVgrCzDKXLoNXgQFRTDbg0ZxVRWcG/tELxs6nJyBAZmTi2X2qAZwKugz5Rve7je98v5X5nYvbtatllt2FOZQLPXx2+BDm06OsJYgQeAI321AUBxsfUuKA4VWQfsawdpYVOlL5sIlnJx9lRwvKxtoNL/3ZOGeiLh8KpPrtzTfCBgCRHwwxHozky4CmDjCX6U+c+SWXUDlHdglDTmL7v18njuIzDOJBEECBNh3shDGttZ3E68b9MA6VttuvcmDbhs9o2/932JzdpDtSSnNncTIvVB6VeGV4O8ykKi5Zasqjib94nL9vzQ+wEGH2e+d+ihCA9ZCOVyODRb7AUXh/lF9iw6hePdFaMoee8D7qA7LYrJlBplUUQe6mss6YCwGFdtYieeEDefNGzc28R9nJQcs/fyk4aMlatKMgi082LtBOtRBkeT9JRyOGZTkeiTBPIO+5tlT/q72KM4bT/nVXwagVfsUbkWrTuSK5uC/OcFxbu86JS8Rf5/3TEj2dA+4fdYHb1J6xQWBaBhsGmai4U/BYYW5hNlCrCps+PaQIViKa/8oFhmSk29v0+xAibEmx2X5zt95jY/fffN7liLB4tJaWkir29ktqbD7kOP+RmI+UT1oBQ1hh8aj0Vq0O7qsXJpODuCJh8lHWI3ua4xgCrQ==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: VI1PR05MB4431.eurprd05.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 0ce9c541-a874-4826-381c-08dc43a191c3
x-ms-exchange-crosstenant-originalarrivaltime: 13 Mar 2024 21:07:19.3910 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 95924808-3044-4177-9c1b-713746ffab95
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: BCuFAK5PAGYwp28SwnuWuMIRGziJEG7yQBEjLmL4FTnSqp215a7haYn2jq/tCn2Fcsms7Y6AVrehmZNnwyUipixEWcH8z0kEq4YuOEK2ziQ=
x-ms-exchange-transport-crosstenantheadersstamped: AS5PR05MB11072
x-originatororg: hpe.ua
x-c2processedorg: 05d38579-af40-45c7-a100-db7b2fc24033
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks, it works.

Will it be added by default to the 6.9 mainline ?

Anton

-----Original Message-----
From: Li Feng <fengli@smartx.com>
Sent: Wednesday, March 13, 2024 2:38 PM
To: Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@kernel.dk>; Christop=
h Hellwig <hch@lst.de>; Sagi Grimberg <sagi@grimberg.me>; open list:NVM EXP=
RESS DRIVER <linux-nvme@lists.infradead.org>; open list <linux-kernel@vger.=
kernel.org>
Cc: Anton Gavriliuk <Anton.Gavriliuk@hpe.ua>; Li Feng <fengli@smartx.com>
Subject: [PATCH v2 2/2] nvme/tcp: Add wq_unbound modparam for nvme_tcp_wq

The default nvme_tcp_wq will use all CPUs to process tasks. Sometimes it is=
 necessary to set CPU affinity to improve performance.

A new module parameter wq_unbound is added here. If set to true, users can =
configure cpu affinity through /sys/devices/virtual/workqueue/nvme_tcp_wq/c=
pumask.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 drivers/nvme/host/tcp.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c index 2ec118=
6db0a3..34a882b2ec53 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -36,6 +36,14 @@ static int so_priority;  module_param(so_priority, int, =
0644);  MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");

+/*
+ * Use the unbound workqueue for nvme_tcp_wq, then we can set the cpu
+affinity
+ * from sysfs.
+ */
+static bool wq_unbound;
+module_param(wq_unbound, bool, 0644);
+MODULE_PARM_DESC(wq_unbound, "Use unbound workqueue for nvme-tcp IO
+context (default false)");
+
 /*
  * TLS handshake timeout
  */
@@ -1551,7 +1559,10 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tc=
p_queue *queue)
        else if (nvme_tcp_poll_queue(queue))
                n =3D qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
                                ctrl->io_queues[HCTX_TYPE_READ] - 1;
-       queue->io_cpu =3D cpumask_next_wrap(n - 1, cpu_online_mask, -1, fal=
se);
+       if (wq_unbound)
+               queue->io_cpu =3D WORK_CPU_UNBOUND;
+       else
+               queue->io_cpu =3D cpumask_next_wrap(n - 1, cpu_online_mask,=
 -1, false);
 }

 static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid) =
@@ -2790,6 +2801,8 @@ static struct nvmf_transport_ops nvme_tcp_transport =
=3D {

 static int __init nvme_tcp_init_module(void)  {
+       unsigned int wq_flags =3D WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
+
        BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) !=3D 8);
        BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) !=3D 72);
        BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) !=3D 24); @@ -2799,8 =
+2812,10 @@ static int __init nvme_tcp_init_module(void)
        BUILD_BUG_ON(sizeof(struct nvme_tcp_icresp_pdu) !=3D 128);
        BUILD_BUG_ON(sizeof(struct nvme_tcp_term_pdu) !=3D 24);

-       nvme_tcp_wq =3D alloc_workqueue("nvme_tcp_wq",
-                       WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS, 0);
+       if (wq_unbound)
+               wq_flags |=3D WQ_UNBOUND;
+
+       nvme_tcp_wq =3D alloc_workqueue("nvme_tcp_wq", wq_flags, 0);
        if (!nvme_tcp_wq)
                return -ENOMEM;

--
2.44.0

Anton

-----Original Message-----
From: Li Feng <fengli@smartx.com>
Sent: Wednesday, March 13, 2024 2:38 PM
To: Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@kernel.dk>; Christop=
h Hellwig <hch@lst.de>; Sagi Grimberg <sagi@grimberg.me>; open list:NVM EXP=
RESS DRIVER <linux-nvme@lists.infradead.org>; open list <linux-kernel@vger.=
kernel.org>
Cc: Anton Gavriliuk <Anton.Gavriliuk@hpe.ua>; Li Feng <fengli@smartx.com>
Subject: [PATCH v2 2/2] nvme/tcp: Add wq_unbound modparam for nvme_tcp_wq

The default nvme_tcp_wq will use all CPUs to process tasks. Sometimes it is=
 necessary to set CPU affinity to improve performance.

A new module parameter wq_unbound is added here. If set to true, users can =
configure cpu affinity through /sys/devices/virtual/workqueue/nvme_tcp_wq/c=
pumask.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 drivers/nvme/host/tcp.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c index 2ec118=
6db0a3..34a882b2ec53 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -36,6 +36,14 @@ static int so_priority;  module_param(so_priority, int, =
0644);  MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");

+/*
+ * Use the unbound workqueue for nvme_tcp_wq, then we can set the cpu
+affinity
+ * from sysfs.
+ */
+static bool wq_unbound;
+module_param(wq_unbound, bool, 0644);
+MODULE_PARM_DESC(wq_unbound, "Use unbound workqueue for nvme-tcp IO
+context (default false)");
+
 /*
  * TLS handshake timeout
  */
@@ -1551,7 +1559,10 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tc=
p_queue *queue)
        else if (nvme_tcp_poll_queue(queue))
                n =3D qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
                                ctrl->io_queues[HCTX_TYPE_READ] - 1;
-       queue->io_cpu =3D cpumask_next_wrap(n - 1, cpu_online_mask, -1, fal=
se);
+       if (wq_unbound)
+               queue->io_cpu =3D WORK_CPU_UNBOUND;
+       else
+               queue->io_cpu =3D cpumask_next_wrap(n - 1, cpu_online_mask,=
 -1, false);
 }

 static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid) =
@@ -2790,6 +2801,8 @@ static struct nvmf_transport_ops nvme_tcp_transport =
=3D {

 static int __init nvme_tcp_init_module(void)  {
+       unsigned int wq_flags =3D WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
+
        BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) !=3D 8);
        BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) !=3D 72);
        BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) !=3D 24); @@ -2799,8 =
+2812,10 @@ static int __init nvme_tcp_init_module(void)
        BUILD_BUG_ON(sizeof(struct nvme_tcp_icresp_pdu) !=3D 128);
        BUILD_BUG_ON(sizeof(struct nvme_tcp_term_pdu) !=3D 24);

-       nvme_tcp_wq =3D alloc_workqueue("nvme_tcp_wq",
-                       WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS, 0);
+       if (wq_unbound)
+               wq_flags |=3D WQ_UNBOUND;
+
+       nvme_tcp_wq =3D alloc_workqueue("nvme_tcp_wq", wq_flags, 0);
        if (!nvme_tcp_wq)
                return -ENOMEM;

--
2.44.0


