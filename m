Return-Path: <linux-kernel+bounces-20622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C800828288
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137DA285ECF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1142EB1A;
	Tue,  9 Jan 2024 08:53:52 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2047.outbound.protection.outlook.com [40.107.117.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CFB2E842;
	Tue,  9 Jan 2024 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBfYeZmk00xg98Z5Smg/dcaZynMPHK6q/7ygTQfdzx64zzlL6uDYyk24TDdgnkQO7B3oA/96/40QwNo49E7Bmz1UNfZMdEEPfQk3OBQ2HVzBc7iQfyodZIJNom53K7XJRUBlUuuptFqHGyI6XPdZJBpBP/dWVZXxuS2Akiq9gGFJueVkosgz7+8OptxLHv/xo9KwYcz9a36BVat8HvnCIRFyLjQ853QWcWIQpBv3DUkzOAYXG4L9RxBMJS3PNV8+63O+cbG/DxP80bN6AubCzqgv6xcDMO7RteNUCkaxDKACeIKcClbcK7AXxgOgPwpSUDFa4hOs1CQVXOqViDzDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbSE8flAdRznmxyS3t+R0q1HUNjtRrGgOBwc5VEB2vo=;
 b=oZr0pcT7KQc9xODsrxueDhPz84T3lkyLfW7af335Reo0PWECKmFCI63d2X3U9/tTh9pbvJmFezDW9NbUjRsiSrVJcXlOGTnXP8lTDremI69ZV7Nkcdm5aq0Ilynu/dnO4aSLBzi9NStbYQ8Euj0SkGMgxZTmGnkfZClwXk48vAOkQUdf/OGbO7TYmiErn+a+WgOYJmugX4ESKSW6lSqraQumQJnO4OeWM25EwRtutKKbmroitzje1vc9rzFXGL2BuoYU6y7bMzm6WroBzB1MRunxo1uGT1/+WBYTVu5z2Rn0CBkAHaSQJhhCWu/6oIF757KMoeupopxbRBATpXKI3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from SEYPR06MB6278.apcprd06.prod.outlook.com (2603:1096:101:143::5)
 by SEZPR06MB5558.apcprd06.prod.outlook.com (2603:1096:101:cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 08:53:42 +0000
Received: from SEYPR06MB6278.apcprd06.prod.outlook.com
 ([fe80::c5a4:6868:b1f2:43a6]) by SEYPR06MB6278.apcprd06.prod.outlook.com
 ([fe80::c5a4:6868:b1f2:43a6%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 08:53:41 +0000
From: "Joakim  Zhang" <joakim.zhang@cixtech.com>
To: "andersson@kernel.org" <andersson@kernel.org>,
	"mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
	"arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>
CC: "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	cix-kernel-upstream <cix-kernel-upstream@cixtech.com>
Subject: RE: [PATCH V3] remoteproc: virtio: Fix wdg cannot recovery remote
 processor
Thread-Topic: [PATCH V3] remoteproc: virtio: Fix wdg cannot recovery remote
 processor
Thread-Index: AQHaMKsZ01O1wcUzFk6tbyQ7iXca0rDRTy1A
Date: Tue, 9 Jan 2024 08:53:41 +0000
Message-ID:
 <SEYPR06MB62789348742ED11883BA9F68826A2@SEYPR06MB6278.apcprd06.prod.outlook.com>
References: <20231217053659.3245745-1-joakim.zhang@cixtech.com>
In-Reply-To: <20231217053659.3245745-1-joakim.zhang@cixtech.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB6278:EE_|SEZPR06MB5558:EE_
x-ms-office365-filtering-correlation-id: 0895bf3b-b749-4669-25f2-08dc10f07ad0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Jgr1FYvTeMjfHXcyBMVD2I8b7QMjADjbCimhUZaD3JPG4gwnq4+fGy9RBnWH1/WnG9naO30Th7jKL+WfZrd9uXaQ77TOq7SUgsvtKUqWKvKVahn/od4M703bPZeLswa3erOIa6net4Ruv/SeJ3XAg+IBdsAlDNWOX6oJoA0qEH9oSdw0KVPtxBLkHVawS6yrPaYjqawHYGHT3H8tQfEix2a0ydcBKP5CZowAf6EzReYSfO5JTGGAlcY5DyHUIWE7ahd6vw0IjIGN9D3cB6059CnB0R278Mp/q7If/X5Xs1p8iTmfoUc7UimhnP1cu8OemEAtRV5kRJVlRYvT8Q6Dcx7lUXiDIzggzfZyVO/ilcoawso6/OoWpkcsVrLp2GWpcqpL3LqH4+TX6SoAoVy39R5s5HIPesz6ZgNMJbYIczKNEF6uqptZqaRG7Gq+ER1Rfmq6WbWDI6oO6F0Dw+NchyVc5n9QjDOc6LWqzQWyU/IhA5VRE5hTI23KS+GL81Y4owVG4khtdHEDTZT09d7JzhYyvhVynGJCOvQrxJ4AKeyZG1BGcuwOL7RpKlZHalIktHziXfMhKqeJ1ApydXqrATNmlBgnzynOMoiURbFzmM58xKC2UFHrmFAVizlg4GB2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6278.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39840400004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(41300700001)(7696005)(6506007)(53546011)(71200400001)(9686003)(55016003)(38070700009)(86362001)(33656002)(8676002)(8936002)(316002)(110136005)(54906003)(76116006)(66946007)(122000001)(107886003)(2906002)(478600001)(5660300002)(26005)(64756008)(38100700002)(66446008)(4326008)(66556008)(66476007)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IWIrZjMKL8SlfkHvMt2GfSHhVL5ffQ2cBn1++9EoSPB27hfL+WHsFch2Jb8d?=
 =?us-ascii?Q?c0aP5yCOr4M3Nrg1t0xdyQmxmLgrbd9OmPkUYseD2dqZVOQMhu2pVs7W+L/c?=
 =?us-ascii?Q?R1mGZ/nHiIrdQNJJpB9TyA2489dB2wY8iDvq0YQZ+V/uz5ZlC0G476fiT0fE?=
 =?us-ascii?Q?VrPTHcmfebJgbj33a242WZcVBi3cjCeT9Zej2RLM9dLmebLr43UeZuw2p/he?=
 =?us-ascii?Q?Zknio4C4VfTD5U1wML1G3kyxZgvEnOBdQ/VUlk5LCSoqlRRUjZEeiBvqdrgZ?=
 =?us-ascii?Q?x+SSRdQg9O3eCY1ym3QuW7sb4jQ2M2Gc1LyBZH2zqndulZNMvrgNIjQsxel+?=
 =?us-ascii?Q?dvF1Mer5Hqw/6abFSQ22p/dEtzNNrCY9xKaBUYW94p2UEIKVjb9TVmfdfvr/?=
 =?us-ascii?Q?8sew3KU9CToBr6n/8EAJEj4NNzfG/dj0kdWmxmdK7T/BbXoxsAXSbY62cN9j?=
 =?us-ascii?Q?bg51k733mEq5lFIgSzSr2BpVAPYiBRM8ENkxZjdR8Zlix8ZhmqlrS84Rfgph?=
 =?us-ascii?Q?pdn38gdiJZ41o3RurgadGHIUR+LFBE2JzYgBI12DUeBYFrFpjrJDnDphE5dA?=
 =?us-ascii?Q?CTutXENRmEDlWc0uPHrJvX9wlPDVCrdBhdCbE/KcHQmvqLsgMUnUBSUYcr6o?=
 =?us-ascii?Q?ICzecIma3dZxXBNW2THCuogaGPl/QmSlAMBvtVNM6T/PbWMWtUFllM6fkTPi?=
 =?us-ascii?Q?5e4+oWur9OvIGPIPrRspVi/b9vMUgruDXbo4zoCALuujMstAkY4U5JZH7Q/6?=
 =?us-ascii?Q?otVq//mRm3vOpFCUOt20BPzjqoRqmheGqPNEMFCcY2hxjV5Eu0ZdkhAfNZTD?=
 =?us-ascii?Q?j+Yr7MzAwSm8r13mICpPZIM4os2g1V3nYSkNH2zCK35uFGNEWH02+vSDa7+m?=
 =?us-ascii?Q?Ddf3tWY5FTaq3rgUj7gHT668uFtPKkT98j99oGpRpoAkYOsVH43Rij6WBz6q?=
 =?us-ascii?Q?uKvsQC4jyodPEjz9ctiLijVV9qMWWEw5dHmaNrLyR46n4/zyDG98a0z0vM/U?=
 =?us-ascii?Q?vVoFOPGOYD/EAIk9VKFwWqF2/4Rul1a+hWw9wKBYZVrLeq+eHuGhWO64SWXX?=
 =?us-ascii?Q?yqL5po1HQQM/cpCLFpTowHXII++x7Byhap2Hm1exkrvCRU3ureFj4+hiY0zG?=
 =?us-ascii?Q?88qpQw2dO6E2eVcVYzVV3Hy8b6vGWCkGe0FnRfXu9lI33TUf0DDwUNQbNA4l?=
 =?us-ascii?Q?zfr4ZxN/IBVFUzP/RedCFSOzWfmrdAfysw3rt+NbvGxjcFyCR7tczeB2YLx0?=
 =?us-ascii?Q?L6JtYeQk+DT1LSPA8q02ppwqKvGljIsSn6DQznywvLGn9U4cx+HHyftE5KJQ?=
 =?us-ascii?Q?s7lc3eRqDO6TJ8CCXn4HBRkcNFzk4VFACe23UUQTabPQMhKviyI8+skp1kLp?=
 =?us-ascii?Q?Cjfqj9epwqb3PcwWUzmYmHjbD+Qfg3KbAJG1XsREPWxnoN+WbE/s0+vCJVJP?=
 =?us-ascii?Q?27UHSISLWLp304eFGUbl9i3x1p+NP3kOvNGzuaPh4AwA1G6TlMHqcD81CVs7?=
 =?us-ascii?Q?NRu++SRA0QLq+yY8vq4T5tB3cDnN3mKdbK1KF9yh7cxqRTjsyIxRGbZR8s5A?=
 =?us-ascii?Q?2K239TV0hhQh43oVDxQb+Thx26l5w+FesgdSmAle?=
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
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6278.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0895bf3b-b749-4669-25f2-08dc10f07ad0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 08:53:41.8018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Ok34s5xBWSSJ5eg0v/KVUNAjruZiQcB9OkEFmSlg/0RB8PwqyfyfrJlm6ioTj5Kq9vXTp5J2VkUcMFFO4kd2lNq35qYO/iRiNbCrtPg0r0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5558


Kindly Ping...

On Sunday, December 17, 2023 1:37 PM, Joakim Zhang wrote:
> Recovery remote processor failed when wdg irq received:
> [    0.842574] remoteproc remoteproc0: crash detected in cix-dsp-rproc: t=
ype
> watchdog
> [    0.842750] remoteproc remoteproc0: handling crash #1 in cix-dsp-rproc
> [    0.842824] remoteproc remoteproc0: recovering cix-dsp-rproc
> [    0.843342] remoteproc remoteproc0: stopped remote processor cix-dsp-
> rproc
> [    0.847901] rproc-virtio rproc-virtio.0.auto: Failed to associate buff=
er
> [    0.847979] remoteproc remoteproc0: failed to probe subdevices for cix=
-
> dsp-rproc: -16
>=20
> The reason is that dma coherent mem would not be released when recovering
> the remote processor, due to rproc_virtio_remove() would not be called,
> where the mem released. It will fail when it try to allocate and associat=
e buffer
> again.
>=20
> Releasing reserved memory from rproc_virtio_dev_release(), instead of
> rproc_virtio_remove().
>=20
> Fixes: 1d7b61c06dc3 ("remoteproc: virtio: Create platform device for the
> remoteproc_virtio")
> Signed-off-by: Joakim Zhang <joakim.zhang@cixtech.com>
> ---
> ChangeLogs:
> V1->V2:
> 	* the same for of_reserved_mem_device_release()
> V2->V3:
> 	* release reserved memory in rproc_virtio_dev_release()
> ---
>  drivers/remoteproc/remoteproc_virtio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/remoteproc/remoteproc_virtio.c
> b/drivers/remoteproc/remoteproc_virtio.c
> index 83d76915a6ad..25b66b113b69 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -351,6 +351,9 @@ static void rproc_virtio_dev_release(struct device
> *dev)
>=20
>  	kfree(vdev);
>=20
> +	of_reserved_mem_device_release(&rvdev->pdev->dev);
> +	dma_release_coherent_memory(&rvdev->pdev->dev);
> +
>  	put_device(&rvdev->pdev->dev);
>  }
>=20
> @@ -584,9 +587,6 @@ static void rproc_virtio_remove(struct
> platform_device *pdev)
>  	rproc_remove_subdev(rproc, &rvdev->subdev);
>  	rproc_remove_rvdev(rvdev);
>=20
> -	of_reserved_mem_device_release(&pdev->dev);
> -	dma_release_coherent_memory(&pdev->dev);
> -
>  	put_device(&rproc->dev);
>  }
>=20
> --
> 2.25.1


