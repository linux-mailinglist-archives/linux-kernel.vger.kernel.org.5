Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44237E6CE8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbjKIPK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjKIPKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:10:20 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683EB35A7;
        Thu,  9 Nov 2023 07:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699542618; x=1731078618;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gLrl5nUuhqJd+djt/Y+vQRQnFtMUUsoN3nth80BqdGs=;
  b=BURhApWBxdzkBLEalnjHNFrIxLwK+rOe9hKyY3skslLQc33jMfyGkO07
   /O3ag+2eU1HlnzzWgcVZTGPSD2ZoU7NdGb5L5+zRC+Jky6iwbkfQ1y6d6
   /iNXzGW6DNYexteHSgSIOATttsxj0rHuWbzvFA6pCqwJ4GIbONPqotv7y
   /R8KoZ72H21j+ytcANjJ9OBDacyYi255LBF9g/S1RxIrUVA7cqGTu61jr
   7HftP6raYkPqmDi4laBf70OGq3DMLr7ssNwGNKxlsdKhASUrTKZUdjAcG
   7JbrW2wVvBnvIeTjHDLV+rXPbmi6Wiaf4daI7jKg4BiYGQeeL1n6xiF9a
   A==;
X-CSE-ConnectionGUID: odSlKg9VTgOLvV3kr3miBg==
X-CSE-MsgGUID: FORVNyvxSDCzJVpqok503g==
X-IronPort-AV: E=Sophos;i="6.03,289,1694707200"; 
   d="scan'208";a="1839705"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2023 23:10:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1/UsdZyTmFvkTL2JNFi/7v1fH3AQ9d0aoCcyn6ljXUbyNHn2M8VQhfCwemBkNydY69jP+Ajfbx27G3Tt+uy5FDz6PgizhLlm+2PEuPeSqwIh0qQ+JuD/S7GE4HQ+BbZv4zE2y8PD2vkicMSjH75vFXtMP8Rl01f9pkfm9ZqLrt2pBzcZ+XEaMQmAE8uLkHV5hTKOYr2xg/MW8D7YarZgk6E0T9VjOfqey0eVqriGKt+dJ94ErT4dq9UCgponj72ybWuJhkApCNfW3xrTWiAYb5qiGaPiXfD2E/1gnywhSdwFRQhbI7niwvo+ZKV699jh625/4luz5Xu+0LO2UwDhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTlIEiK2M52Izv4UVHfkQaTvFcnKSkAVhjLe+5+bo8A=;
 b=hqxQb6y+kz0y2a3i5mP/TOKPNIO/NSTcofv5dED96xPQS4PdZDvM8rP7ksjfIWedxTm6VtbPPbUCI6lmeKrkprf7auI0emSlIBSaf60tMLdkRG3Qdgei7BNxovh/joSkHJ3O8B30Gcubwuus7Ej5iaTGwsEVEOOUHr0dqZ5Wy8Bx54wHZHO1CDnThTrgbj/08IrYCggKapDUkajalu9TGkA7ArVzr2GH7HYcrCiNOa1+J3uR15F1sYORYQRzg8L0zZbDyk+xmuA8E7aRJBsUJI4d+Is4D8dGwobQCExJwb9b4/ytlMTetyLyo1Fg0s9KXngEdChSb4U0t2ik0Ljc+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTlIEiK2M52Izv4UVHfkQaTvFcnKSkAVhjLe+5+bo8A=;
 b=IuO6vjcPPZMZVsLC46+x08K4pGB94uy+7ZMHA1qFh67ozRcJmrIlN7PvwG32N5jfl5Z5yoda8CGRm1p9iJYR5fl+bAR96lPqO6081dnYnM/t78gFbI0Nh+WjUsAcpAfEQ0+Hukt9yiRWypHlPImM7Wvt0d8RHDH8h5PROviqBBs=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH2PR04MB6919.namprd04.prod.outlook.com (2603:10b6:610:9a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.18; Thu, 9 Nov 2023 15:10:11 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2975:deb1:a373:b88]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2975:deb1:a373:b88%3]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 15:10:11 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <beanhuo@iokpp.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mikebi@micron.com" <mikebi@micron.com>,
        "lporzio@micron.com" <lporzio@micron.com>
Subject: RE: [PATCH v1 0/2] Add UFS RTC support
Thread-Topic: [PATCH v1 0/2] Add UFS RTC support
Thread-Index: AQHaEwuioW4oGnRpy0S0zhZK6qWN8bByF3cg
Date:   Thu, 9 Nov 2023 15:10:11 +0000
Message-ID: <DM6PR04MB6575C315A2A8C80B93E7139AFCAFA@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231109125217.185462-1-beanhuo@iokpp.de>
In-Reply-To: <20231109125217.185462-1-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH2PR04MB6919:EE_
x-ms-office365-filtering-correlation-id: 33775f62-c4f9-48bc-0c0f-08dbe135f802
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lmUdsFPMgWa7HnrjJBgR23FWK0mVNNjvkOxCVjZudMTRrT/l9ZnZDOgnBY5IvSArTTmrOK8267UMu+5l8trIlV9XxuBHNfYO34LsB5WrVb8SiDkKfoq/cPvcZLIyU3co7VCvK3O6yp71U+DLZz+WAZehmH9KmpjqeogGcgm+gkSRnDxEIpyCrgxRwiMRl/+kz5BEaQmmNnoHGaYV/OzkcgJi0J8G6vRIaMpHueGfGm9BJn5W45UeDIxBYOHEkY4M3rmAPW01gzcEhXgNbdTT0fhhBtRqBH65P0RQiqxWcKuhqEd7rAFBoyBgqzekVgZTX2EJegHp9sC8jqOaH7tTJovQuKjE2W06yCzwqiN84wXmClzLFP4EMHDdYt2cMfEzOS3rdn7A+1vfXHhbQ4hSpYjznAm7bPhTgYGRz4AWKxHulO/3RcwvNMHOYlCw/6Vwfx1KMF1tRfWE5xEqy4VCz688xw/2DKK5V0pjgf3TmHUlSnp767zog1FbpJNebjlY+DfGdFeNWr0AqPs3EgXDjpyJ5A+LOX9TwUhO63NprxDQoMkSX4Q/LDn1dygtGwGZmCNyjtEAv52ewRJt4Iwd4uTr8MsXTjNQJs9UU8i1ZBnMD6f76C8v70GBfrWbhMpXLwlbjFhMWU8KUp9ZUTBMUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2906002)(4744005)(316002)(66446008)(9686003)(110136005)(26005)(66476007)(66946007)(76116006)(66556008)(64756008)(54906003)(4326008)(55016003)(478600001)(5660300002)(52536014)(6506007)(83380400001)(8936002)(7416002)(8676002)(122000001)(41300700001)(86362001)(38100700002)(82960400001)(7696005)(71200400001)(33656002)(921008)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u3gLsvisQdHFsvHR9xGOTnIfHdegEOIv4q9NPzG3twpsKe/vZlqNGX3erXqi?=
 =?us-ascii?Q?K3HQNy+qnEGxZFd2oWMI26t6zdnwuld5XSCAAKskwHZEzEBh7TP2M14iIYEZ?=
 =?us-ascii?Q?QCMf4M7vCeOB+XLRDN+niUtZfEct+7ucLHB3aKjNWsAV0EnC0RXJAopCvlGv?=
 =?us-ascii?Q?8Bu2jwHuu+99lDqPc1VaAukFQUoY6mG2N/5TpQgP8hJud7+xX8fh7GSvMzbO?=
 =?us-ascii?Q?PnNZ+soHgVL/IOSc0PYvA1g8sMR9yFH7137yTWDni/GXBR73YbBoV33EG1/4?=
 =?us-ascii?Q?L+26AKQRbChW2nb2rnZS8q8/gvMUaCnRC9cEN+ECTsIo6usEw9KQMGRdmYyj?=
 =?us-ascii?Q?fWiWFBwZqYjGRBPexIddH8Te6c3SGwb/Bbwh8k+kNbKGeTy53A13n1QvUt0v?=
 =?us-ascii?Q?2Q5YJCumpsRLnQ8Ji+mLuZcYuP4G3PvN2+6nj7bEOLdrc3Osa0KXbQR/99CF?=
 =?us-ascii?Q?wFxxrZdbsMQmbbSRVLMAqU0BP4inOJp5WB3flTBlv0Sia1VKIZZb5DwCF7uo?=
 =?us-ascii?Q?7x1QyLFsS1Ur2QvlcGojys0DYhdYeYhDV+LVMRSnHwhEU9Oyd0wafdJde9A5?=
 =?us-ascii?Q?iKSpjEbX/iL0Gte6GzPvOj5lxDQl+uC7Wl5zePNaWhiXp07U6jnzlrce3fgx?=
 =?us-ascii?Q?9r7r78e4D6YV0tOUuHxsIF0wdOCBG3b2lT3FgFPThx10QYgJ6IWIAZmuFyy0?=
 =?us-ascii?Q?w0xDOK8W/qgECNrRgo7SgahXSWy92dPzIemMKyazJtfXmJBgN6ZGnhkQrM9u?=
 =?us-ascii?Q?MWQZVcO63Zl9Ty3Bpupce7PSbptBVNg9d1OeaykVoJurxwa6WMl00cc4OEkF?=
 =?us-ascii?Q?An4wkG+d/2PolVvei44DlXKacZXWjqu3YNNtN2K33G5QImG0ZoD6Y/cj2yN6?=
 =?us-ascii?Q?gdSh2jDgoVOibaU5IdBhLBebRPVuH5rRARDHbrtq/hqhAciLBMMsEKakfkQZ?=
 =?us-ascii?Q?HaKKKoHxExEpPvnfsQ0ee4X1poIMPkAwk9DCl3T+C0M/4CFMq6iioJ8Pa+OE?=
 =?us-ascii?Q?RycO7WVR2U0wB8jKvcxfJnTO25rWbfsk76kzimpRSPSz/MqAeWhDbNWJyPTv?=
 =?us-ascii?Q?4puLuH/LIcQogBxQFjSkJDl9Cf3mZ87s3KPRpdckS0OmwQnpQdNUCHdgdKGS?=
 =?us-ascii?Q?ZU+gAC/zPpTqDMduFaMkmSMj7zrrPw95xggLqYPz13HXEZqCk4eXLAedH7vt?=
 =?us-ascii?Q?60D9UPLIwA5tHB+DlNUMepAW6Fk1BsXmdT/FKa8d/PBBQ8kZ56yuKNKOCc8g?=
 =?us-ascii?Q?fokUi+savZfSA1+iLVNBACQ5ixIxjTEIf+6pjEwA2t5j3x3NtkuWRf7PKpF0?=
 =?us-ascii?Q?inE7Q0YrpfkSzAZYG9UU+b/IY8ZCURFBLl739dZBPWuMGvYPz6kaBbMnDY8i?=
 =?us-ascii?Q?j7iQbU9jZJm3dgUO4GEzXlrqJhC5Pb30xQPLzkA/XTumHNaoWcE4zXppT/oD?=
 =?us-ascii?Q?/sRJ2PtlX5BwrizhiAy9f7W3U8tvse6yj71MHq+VHZd9S/ILmxjO8JJ5FTjk?=
 =?us-ascii?Q?GM2Z6TwsVATR3aQGKU0Z0dyyI0Af6wBC63L/ZqABiEFTXmy7odCwIp4q/St9?=
 =?us-ascii?Q?FjZTqF5FtBBBf/dcsn1V+wNyGcGpLCSDb7kjTwx+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ERGaTTvIqDxopPYKmv2zTlHsHMQDlS9qT3C/p4W3ztn8DQAo1f7mrjcseMF4?=
 =?us-ascii?Q?XO68Hib0qykoFixwur+ll/cJ5YOUunipZbjPuKqlMtnyPeI6grYiprjKyC9u?=
 =?us-ascii?Q?6VdMoblUIJjDLIO3JmagK0dblnOJ8VI/zh+472uIfob301f1OzR/B3iRTkM8?=
 =?us-ascii?Q?zxth+zKovLXXKrO6jbIhfSROFDvP75Qr4e8vE54tFYaC2s1eeIMsgkZHh4wA?=
 =?us-ascii?Q?3AWBzaKyrRK9UHwWa4qnaMmKUt6Zp1CUyVf0s790iJt8d9GcvYAAn7GMr7qv?=
 =?us-ascii?Q?UD65S/Ddeltl1HurW0yKDWUigUkrYbogjFPYaX7rJP7InJQxfqPnrlnkbMBh?=
 =?us-ascii?Q?89MFhbUtYEHEUoxEGXEG+uzARVga+ovnsF/7FAJ2D+IpWWMX7djQ8oFLXMiX?=
 =?us-ascii?Q?dZQunVfaWoZvxRbqdQh42uySytnm7SrhKLmde1tGd2MrggTtsiLcd6vKWvVK?=
 =?us-ascii?Q?RiP7iKBkZEl2o58w2ERAp3jsa8eFFH0dyAQpDau4RnbEXYSAvI5OIvE0d3QM?=
 =?us-ascii?Q?cJjxsALgSEJ2VzMhWVcqAEUAaBVqTqoR7OMiaVV/2mQJjFTZRWBaMJQ0jiSt?=
 =?us-ascii?Q?fXB8nzcGIklr2B+Z6rULhRAMPmBLsBvBur+y6GE78GNTe2S4F9neaRydOKd6?=
 =?us-ascii?Q?wwPOPSQmAtq3QAUcApyaeY3vexnyjAhle1oaNFmzSItUsCBjS2PqbmM1EPyT?=
 =?us-ascii?Q?4F0LuDM/J2do8vkj23IYe44v27YlaZ0kCvxZppMucIrjgqXyPlVHzTnolfA1?=
 =?us-ascii?Q?OlOZWGzAAz72Qdi25SDE8TZyC4cIkoFFw26obxHGAA/hC8/oFi1qGLzo25zR?=
 =?us-ascii?Q?7ixGLCI4NXVjRHPzFo7JifwoP2REOrRnthl1qH4Q81dYmRP9Im8pcT1JzO1j?=
 =?us-ascii?Q?H0R4sKJkoQNhiNvShzGBPlCicg5MPkpmcGrEkJj63edu2Y+85ZE39KPZPaub?=
 =?us-ascii?Q?0/APM0oIyp7AEKDlLluJCrHxKttus/ZMS2YnuKXn779RJrTsb310N9JL5+7e?=
 =?us-ascii?Q?jqXqf8Er0DPI3JgDv6NtWU6u7mznyd7rcyuExjcPuZFdKFs=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33775f62-c4f9-48bc-0c0f-08dbe135f802
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 15:10:11.2928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iKoz42HOv9bqV7WNVoc7UU3V9IuElQBc8LlKPEHC/CJFVgORaYSZMFEEpqEc1IkdgZ4FRe95Rc5/kF+85Z+3cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6919
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> *** BLURB HERE ***
Typo?

>=20
> Bean Huo (2):
>   scsi: ufs: core: Add UFS RTC support
>   scsi: ufs: core: Add sysfs node for UFS RTC update
>=20
>  drivers/ufs/core/ufs-sysfs.c | 31 ++++++++++++
>  drivers/ufs/core/ufshcd.c    | 92
> ++++++++++++++++++++++++++++++++++++
>  include/ufs/ufs.h            | 20 ++++++++
>  include/ufs/ufshcd.h         |  2 +
>  4 files changed, 145 insertions(+)
>=20
> --
> 2.34.1

