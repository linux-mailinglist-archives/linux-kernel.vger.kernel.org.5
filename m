Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1F17DCF1C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344076AbjJaOUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbjJaOUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:20:36 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EAFFC
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698762032; x=1730298032;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jj95Oyqmg1NB7h5qNIwZMi6ZUR83bb2jXBSrn+3JW8A=;
  b=pZF+4NAWGSJXisSFDeCc/4f8gNUKAF9eiPVB4IXbBUjQmKpDY//y9iU5
   Dz5HMsvbyeu1BqWyoqwCdeEgDJk4iQzTMIuCTsnXk4Vm6vVRlj9G/yN+H
   lXEvO/SvYoWLyKebiIZVIgcvdOekk+uAXkefrefhAoGRyfUfPHJc3TS1w
   5HsQMBCzTphiSd8en6H+pcPbpDsp9R807DzC5jl4jMugbjJqO/HBasi1Z
   zNTnyQWq2LE5Jhff39tMsiZ6lMm12W8vFQJ89WufjPkvYLgHGkxn5uoD0
   xL2jhxUe5wj9EmZPYyFWE6jnMGtEhxJrTERZYYWEvkolLUYucrD2tVPpr
   A==;
X-CSE-ConnectionGUID: R8t0Ze+9Qq6tndfClweYEA==
X-CSE-MsgGUID: MyiP74LiSJqP8MJu5qQEpw==
X-IronPort-AV: E=Sophos;i="6.03,265,1694707200"; 
   d="scan'208";a="1119297"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2023 22:20:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtggIYfRmJi3ZrPh1srECJG5njSdr0YM85wx0yKbHJ/cTHi3RXtYtPgP2X1wNQTIhFeclvPV2dEj/PeMzmUYOPIRC7EVDpHrJ208+Xqy8K9gFN5vhK92WStelZzdfxoHhIbiQt5UoTBfY84I+YBfHr+Tr/wjK/xvgRQaqul5a5TNtSDTgoF5rYokVbE6KSPF8BRoUqWNkAVvcESgMrCOvhRTrQEBop8lwfJkvtIQGZFQJIAb2tlG92LTAHZoplJn7J184GOPLnuB1CcYtN35lLBRF+5UCrggIS2KbksZokrXvQctS1K51Wc67h2fFH3eAbVaepk89b3RM5UK5BWwLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzDXwt8tQ/QDuCRP1kfK34IgEiqYdkKWYTFshruF44k=;
 b=mWn+XuNqCV3HQ8q4UkPagj/5Xkm4bb7cuJG1lTpChpOfyQvAEtje+F1ioC2VcKaSFURfE51sQlhJW2KuAWKgTL6a35p02KeIoo9obqystPPP27DjV5nN8Kys0sYCd+YHgdoCATQ5VuGy1F517OhZ2XBRbDDahvtrUJ7ONkJamthB9+bjer3GTztnax2NKlWgQgzIAUUFq8+nFk3ugIyThur3Ytmjq+LeDARmkl9Ss6TIOreKL7KeGCunakTjXGHgnZe2ght/XD5WqXawZmB+wHcm+JCFa01Q4u1d2ihoVuOuhdBysgOulBFchy3IKko8OTI5IB5y2uG188vASjy0YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzDXwt8tQ/QDuCRP1kfK34IgEiqYdkKWYTFshruF44k=;
 b=KVjxmeGkDuGqFu7UYUgmXRfx/aJAgwfcP8Q9XMzvz+vCEWlcoLNjcZVFJqewTpbSkgRb5eI8L+O+Cnr2mmozHE1A+dc8FjLkEna6+BAB/cP7eLLL6EYRcjXZygfIHwCJXDHUb0+HZhjQKAdtvHi+ydXllqbIlK9MHkm/4CVjr64=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB7121.namprd04.prod.outlook.com (2603:10b6:a03:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 14:20:29 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6%4]) with mapi id 15.20.6933.026; Tue, 31 Oct 2023
 14:20:29 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v3] nvme: update firmware version after commit
Thread-Topic: [PATCH v3] nvme: update firmware version after commit
Thread-Index: AQHaC0oJhsp4cOjFPkarvnC0xN8QtLBj9DcA
Date:   Tue, 31 Oct 2023 14:20:29 +0000
Message-ID: <ZUENLHhI3wTr6c6G@x1-carbon>
References: <20231030160044.20355-1-dwagner@suse.de>
In-Reply-To: <20231030160044.20355-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB7121:EE_
x-ms-office365-filtering-correlation-id: 256efccc-3512-4216-d333-08dbda1c88c6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dQp+QIDijFaoi25K4M3pAy2ES9zUGNqyrvAg2tf3HTe50tdGSYpX8vwGEeqa3g91+J4ljrQXTI80UyAal+1XKZ1crzSn5g65nV3ygv9/1zvfmgQA3ZS8KVMVHwQKIAnpy9uTQf04rZSnEBxuLuGAKeNzpGFjLx2vK76Vbk/waxIwzaxu+oEB9By+BCIB0RJsYxDhZoxHsdejXDmpTDY5mbyDIf2XuQ4xop4uFrUjOmvlg4nNTklw/2A1mRrje0RZz9EbvvMARgUrLb+0VW60R1MkaawE+Qss3xWfNFcmnvHaCwxtljNEnhRWNhPnO+1b73cO54HqOLSnBEVXAVdV282HNTw8RmYp+chTWhN6bzPjmCo+atMzua9x+oyjmoFbY7tSpkXagDoAmwdiZKghP1kRvWHhteaE2mBnQBWR0q/dMMvayZnYdW6xKzMEmUU8/VLO0u8cXCvDufv5XUW7shW6tQtjXpfZ4e0GQVMIedXUi7lxMIYagFscTxKTT2ozsl2QA5RJYC2fpa4odXyszkPgDod+VzMRGMTsu8T2VS7rYmIGn3YyfQlMNR/NrYt8USn1tvV0P/rFduOQN87WHKk3weBH3eg/RGZyTmOyv62MV4aC9WMGQD/jxU5Pw0KErtCvgWcXOuu6q7WENt5JdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(39860400002)(136003)(396003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(82960400001)(83380400001)(33716001)(38100700002)(38070700009)(966005)(6486002)(122000001)(9686003)(6512007)(6506007)(71200400001)(478600001)(6916009)(64756008)(316002)(54906003)(91956017)(66446008)(66476007)(76116006)(66946007)(66556008)(8936002)(8676002)(4326008)(41300700001)(5660300002)(15650500001)(86362001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2XM2cMzEIbR3THjEHt0OIp1/R3Y9mwMMswvgQuUY7arD8+LjmYTTbP/9Csg3?=
 =?us-ascii?Q?h35GGO7onxAoNrckmByxzTT4a7B3E4d3UQvBD/lvZY4zoPrFesYkhYNnE+7k?=
 =?us-ascii?Q?eYOF2dFmvGhntJEuQzbudzjQEeNYh8PfL8GQMaHXrUPm2EJCJE0NrPbkSjkg?=
 =?us-ascii?Q?IPn8vSP2Y3i5DQdEWL4RWf7IyCjYpT8zJ9lxOIR64gKd/3bGS8iNnHWpdh7e?=
 =?us-ascii?Q?7+enXPg9RddEVLliqSB3HpVQLWQYu8A9fodhUKMXYsTK7Vq3XyKlgUZygUXm?=
 =?us-ascii?Q?LbHDWOLPJP99bdp+T2G2sgT3i/kU4DYRdz8xnPw+Hjj4McjHJU0KF1NmhPgt?=
 =?us-ascii?Q?UVHG2zCP6Pfv45MRSqn1jbfyYTYoDr0EvhKtQBnF3u99mCNonoYoj3zzKsZ7?=
 =?us-ascii?Q?C2cMSGMYDiLI8EwwTytGEV+tD5euTFPy/CsoF/GBwqp+vIk6+PsQmHcQcfcb?=
 =?us-ascii?Q?A9p+tr8HPPvz9LqKRXQ1Kl4AFA4bNkzkO4vd+/2DlmfdUOthXeSFvE2S9Gsf?=
 =?us-ascii?Q?PH3hx/NQ2ZBxPV9UE9uwZupNJtiex/rhk+k2WZIwk5POz8ha9xgh4JmVuLiG?=
 =?us-ascii?Q?1yfzRg+wFXM4BNDp7a/BJ5/aB1SO9n10kLW+5xymZBaWOvQB5XEpdly2k2IE?=
 =?us-ascii?Q?NXotDfllTJ9hBmJPSLpjQqI+Htot+zQWs36Yz3eEyjswO2qJo1MiUjA0a4EX?=
 =?us-ascii?Q?46OsL83j3LQyp+YlbKjo0u4U7SRYJsMk0SL6hApUv06cz/e1X+k1+xuS+sZW?=
 =?us-ascii?Q?kHA8MiFNbuzdVaQuRgWK4SCjGRlIPM2wewvp73Li644911eWGBwUjNGZhyfo?=
 =?us-ascii?Q?qHAuQce14xDWbpKH33kb+40vEshEXLt9t12yLmFA8OXGN8kjABj5iLdl2aoF?=
 =?us-ascii?Q?KsVwZ+O4f0TWImqHF2K/7n/fwuTRGgxoARuRWagL1QwfhgeqI3if5FSJ+T/w?=
 =?us-ascii?Q?9aOVWNpECWI/wI9Kx5VoR7RhBe92W1VLZyj67O1faYrEFqu9TxQN3EKrR3Sc?=
 =?us-ascii?Q?yRdEOw9VkYaisZRvKI5TVnuRbQdHUPNWaISMPg9jid5WnPHtc9jgdrAncGBC?=
 =?us-ascii?Q?WBSd1hmMCvQNwhMxiQNRjLYI481z5zw2ina3RDRS+y5oo/MFgX18y2rXUbVJ?=
 =?us-ascii?Q?d3VprwzPGU/Pb0cCD5qaX1kmHnhZRyUSpHRpZecpPgRf/MI8NKL6EUxV9UHD?=
 =?us-ascii?Q?gsCp1B8Egoa1fupuZkyzw6gzUEjV8oR8Dy80F2cWj/Sym8ZAlE6pgi2MkZsB?=
 =?us-ascii?Q?sEgGkNtsJo9a9CgraiLq9TkiQE30RQ3gp/kJ7Nb+IT8YfQdoHusjuhGzBUjI?=
 =?us-ascii?Q?084xl6pq3quzISLz9dUaDQEh7MZTrMjkSz9RPQitPD+tae4hY/1duCSkuCp8?=
 =?us-ascii?Q?Mgw/CPRHjlFWiZUkpkhONx2KV79x52h5FhAe58Em39xtuT4kRIgbDxxLxGXi?=
 =?us-ascii?Q?fVvMUWmNVazPtcCcXJthF+s+C7N8vX7wUOZd3+hFcpJ5Hmt1JrMRDjg0SQjw?=
 =?us-ascii?Q?wtpQKn9mI9cK7wpFqWhw8/xSQJ69DALmsBcrPd/mp4biGXPQL3fhQhgtxaiq?=
 =?us-ascii?Q?p3dFo22HahrcM6nW8eZ7KnWQWsd6qegf1Vg1kofrtuUP2dR0nMLq3z/TMkIV?=
 =?us-ascii?Q?7A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <49D3C1C83F75D44488C75244D9C65B35@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QeIAW+9/aWbjUr5vz8bwfgR9+kQ2cSMhVoQTIl/0EAT7JdYifSLZtZ2tJhLE?=
 =?us-ascii?Q?RSHQAbvh3ZC8qO32wZBwd3/u96qJMVGD8dUvoQaaXwMROf41ADwEzolABoEL?=
 =?us-ascii?Q?QrPqcVWxOYiRpWbokwMUOkt60vg5n1gcr8oOVBrs755avWRa1RzySqD+W9z4?=
 =?us-ascii?Q?VD7asfpsjMGxV4AVgsDD7Fj+US28yCdiZfso9RHZruZqtswh8y/CJj715j1V?=
 =?us-ascii?Q?nzGxCkfMQtrjAXYCo1MN1C0aKSIuPWxCAImXi/FGzD8hKYwRKdMr1SaF9+53?=
 =?us-ascii?Q?zZcE23mzgx3T4/dr3bfWywx9rnT/3Em7JdumjhTGb62/fiHombZPjq9u9dy+?=
 =?us-ascii?Q?7ZaEFftYbhvgNVQ2jDEAc32UCPp43J5gzLnGC27G3ywVrLJzWqPTAORBsdvV?=
 =?us-ascii?Q?076pi+AyEMivOhNVTqFq7r+XrHKyX8zz6/qKQa2EZyKjqx8sGUPYyyzP+zsk?=
 =?us-ascii?Q?Ch/TUf1xWR3B+xTdvPSXxu+HOlcFkqgbuoSUS+ixshBb179eDDQAY0RIkdtD?=
 =?us-ascii?Q?1monWtcxoFSqfGmbVttPWG5MjrikfkQmi4xNbNZZGgHCUsPaqj4Ik1tX+XsV?=
 =?us-ascii?Q?9ekqfFxV6ikYA8t7VGCnOHCUewiPDSjahedtBfm9CXx4AQuADpT6s6efQQIo?=
 =?us-ascii?Q?kBQsuSc1xOhS7+oFIFiSH6T06v2V8xqFABjs/JdEKu+21qQYzEutusq1nPKG?=
 =?us-ascii?Q?qIaOeUxXjYKB4iH96ViWdAtzXjPCCWR96sZkSlRxi4uaRvxEcFPG5OieToLo?=
 =?us-ascii?Q?qG5T6cv5OvcJpg9YlY3lYPDzDxB5F4gXPI5heJqvGp1/IbbjpMgCVjABTUIR?=
 =?us-ascii?Q?V43r4CahX+HQaAOkmVMBOhDO93SysDpeJPZsU8jXVitjhWFgM+TNNffPwOmZ?=
 =?us-ascii?Q?F8AUysNb/sdc9GXXhYK010qiOhrFyE9Atzio3RgbhXUMnRLavGj+D64pPE3H?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256efccc-3512-4216-d333-08dbda1c88c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 14:20:29.1207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TtfXYQLwwQaJj2uklDT7qr/DPpCQTZe8ialgZm+4eiayhNs4xd53I4cVKTzJjWESICyfwvRk4XU+6DkUOVcEPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 05:00:44PM +0100, Daniel Wagner wrote:
> The firmware version sysfs entry needs to be updated after a successfully
> firmware activation.
>=20
> nvme-cli stopped issuing an Identify Controller command to list the
> current firmware information and relies on sysfs showing the current
> firmware version.
>=20
> Reported-by: Kenji Tomonaga <tkenbo@gmail.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>=20
> Only compile tested. Asked for testing.
>=20
> changes:
>=20
> v3:
>   - use afi variable directly, no _to_cpu helper
>   - fix bit mask size
>=20
> v2:
>   - use fw slot info instead issuing another identify controller command
>   - https://lore.kernel.org/linux-nvme/20231013163420.3097-1-dwagner@suse=
.de
>=20
> v1:
>   - initial version
>   - https://lore.kernel.org/linux-nvme/20231013062623.6745-1-dwagner@suse=
.de/
>=20
>=20
>  drivers/nvme/host/core.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 37b6fa746662..e8511bff78d2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4053,8 +4053,21 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl=
 *ctrl)
>  		return;
> =20
>  	if (nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_FW_SLOT, 0, NVME_CSI_NVM=
,
> -			log, sizeof(*log), 0))
> +			 log, sizeof(*log), 0)) {
>  		dev_warn(ctrl->device, "Get FW SLOT INFO log error\n");
> +		goto out_free_log;
> +	}
> +
> +	if (log->afi & 0x70) {
> +		dev_info(ctrl->device,
> +			 "Firmware is activated after next Controller Level Reset\n");
> +		goto out_free_log;
> +	}
> +
> +	memcpy(ctrl->subsys->firmware_rev, &log->frs[log->afi & 0x7],
> +		sizeof(ctrl->subsys->firmware_rev));
> +
> +out_free_log:
>  	kfree(log);
>  }
> =20
> --=20
> 2.42.0
>=20

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
