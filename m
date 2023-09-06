Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAD07935BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbjIFGyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjIFGys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:54:48 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A8510E4;
        Tue,  5 Sep 2023 23:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693983251; x=1725519251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=a0Dh3J/pnGxXARD3y7Y9SUtA5/jnj2TbqYuX63xwdzs=;
  b=ihJkd95b55hirtbKW/7wEdAoR4VXZ6efNsfG0nmdKVswPkj40SBue6Na
   TMYCNk0LSa/1urjTKbAwrUsks5EbFqiXbXXdWkKlOIU7oTDFHc2l7RxnN
   LB1JOs6si7YIDywXMc9EInNTk+wG1oBZqsAjyC0YOK/ROJmfB8IGJjmSa
   0XZc9Hz8F1GGvRwPCB9VRuVOVdDqglEIBxV7JYcUHHEB3hNaIUmCE5YN9
   4Jb3ho3WRr2hNkGkjMXBvOL9I8ph5LuUbKdeZg2sA4NfDwmif9cW6FpOb
   cA9q57FOd9J12cDBBMGKczgwgFXnCjiwZTeJyrIMGGONqG1xjlLXU7V2m
   w==;
X-IronPort-AV: E=Sophos;i="6.02,231,1688400000"; 
   d="scan'208";a="241329864"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2023 14:53:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjhRp+iybmuty0iown2SAKrFJsj5R+3cYUufm6d8Kc5/fNusm4oX+CDszDQrHxds/X/Vse945N0FxuwMhYRRrpUwErdxwST16KWFiWrNoHiCRwNTPx/TAn7sdi2Nt0GZqAR+1yJspqlUFKFVNRp2iF4+h5CJO9u66V0kM/jQYXE3g0mUxv5KTj3Phen10KqYjneS6RFaodePuOylAmLiq8oHxXTtgh4hKIc/7AqRh5IQe/HW+UgTcx7F1yABxvbC431LFX4OW7W2BCAUvMo7Zy8OTzlCyGe+aMkdS62MYmJuHGyw1HqWzGa+1iiRgBhw3yr/0Il0ND0twaOU0i3O5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHZoWGqataw2TRf/C4+TogfNf8dzRSKjNNSeHGW05wc=;
 b=Qmk/9vDGl1Y8EQGFdioxKEbNrpq/NudOGWZi+Oc/4iqg+FiO/HnbqvNGfgIB2ovGvqJ5/aaoHdZXQJTS5OCMsEtqRtDI9mY9DKLsDdwrNihatVjrbbbUk2gdWF+C2xGzg2ngIEr1pd+6abZJSJseBl6CYG7pEK2fIlBokG9K5JlGYP5LSkzuI/7pPsTHt+ppG/Xm+iNxbbR3acG9bpHMB9vbPojG1UPvK7SkafDk3ExUtzzvTgGM6iTTLobA7HIOvtXuOK4wMKTlUdOLr1eIr/j7HoTD1sYXoP9JGp7nv8p38812B0IwXMrhvTT3UOg7nurkXd80U1zEj5U3ci2SZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHZoWGqataw2TRf/C4+TogfNf8dzRSKjNNSeHGW05wc=;
 b=KFaUddTjj4+i1LnG6bLzr0Im36/iqr6M2h+U0jLvUpzrLNC/DJyTY5SJt57Ux5D60EqTMt9zIc4e6d7u9GjeEhc271PA8Z/ePjYA50J7O2CdB0Ql/EGQCNYNjgHVwxAieK2p+DpBkOIQQUyV2Zp84E8d764L+ur+vphi9G2qTg8=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by MN2PR04MB7133.namprd04.prod.outlook.com (2603:10b6:208:1f0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.25; Wed, 6 Sep
 2023 06:53:02 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6768.024; Wed, 6 Sep 2023
 06:53:01 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     "linan666@huaweicloud.com" <linan666@huaweicloud.com>
CC:     "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linan122@huawei.com" <linan122@huawei.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: Re: [PATCH v3] ata: libata-eh: Honor all EH scheduling requests
Thread-Topic: [PATCH v3] ata: libata-eh: Honor all EH scheduling requests
Thread-Index: AQHZ4I7HWkKVVgD6mU+zyAtt5GUSuA==
Date:   Wed, 6 Sep 2023 06:53:01 +0000
Message-ID: <ZPghzE2IbbF5mJnB@x1-carbon>
References: <20230906063321.905103-1-linan666@huaweicloud.com>
In-Reply-To: <20230906063321.905103-1-linan666@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|MN2PR04MB7133:EE_
x-ms-office365-filtering-correlation-id: e4cb3a9e-1a71-4d7d-3be3-08dbaea5e9bb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5kcTJryUSn8U/gOE76Iq3rPe4Oa+hnrYptJbJ7BdRCAsH9bQT9SNwoy+IejUgTDtzqU7vx4WnRSnT3lz3FSlJpEWn8qgfKRiqLMy5+3TPzWC+Pmbj1rS+1vh/Krcogxw4ABFpYnPCuyrQBK1kYjCbdmd/IC7YUvXeKhIbbG/Orr57h7A75ingfSdiKCOwdFhi94tbEf6+bb9SL7NaEmkyBnxNCLdrtNFZZ15PLBUuZzh84r3gDYX60MTK30VyrQXqA8ey3bqbMgolQIcmr+TR3NjdJgHN8Fp22UZdPk0tgz2QleZ4hd+oQOykYm3TyUx3sSMrRQ/ra9gqMqAW6SKRjh4Dzr4Ljrm0o9l9VTpD4VZpYarI+o7JFEG66ntC08w6FiiKuIfFJUJREkOQaIbNyiom/UVoabVKzuPKeJ/qfLTyhzjwdV/Ir2Iajk6WXHqVw0QJmu+0IxgI35/h/qTrtfW5hICBT434aJwLdf2mlWNOkUJPejE3fazwjAn1zRBZGpe6nIWn1XhGto/fh9Tmtz0tHkn9vciWaMiDMA8zQ0f369Fkby7RXbsndIH2UUfKY1Gmt5Q64Uy6jNYPl51WmQXExIpdAwgQ/O1Q+u6SgaGFx88TSVnWaKbKuTuSgb7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(376002)(396003)(39860400002)(366004)(1800799009)(451199024)(186009)(41300700001)(71200400001)(82960400001)(478600001)(122000001)(33716001)(86362001)(38100700002)(83380400001)(38070700005)(26005)(6512007)(9686003)(6506007)(6486002)(76116006)(66446008)(2906002)(66476007)(64756008)(91956017)(316002)(6916009)(54906003)(66556008)(66946007)(8936002)(5660300002)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/HMRPoCMQKILfb/RdM9nsG9qrA3fS/jG1fXihSAcbzq74acZGBPVr/EUEbQJ?=
 =?us-ascii?Q?bwnwV+FVQevBOt1Pok7uJSzg6M0KjX+Xwj4mgEO+WhrdrpoKZdR4az9uM2fz?=
 =?us-ascii?Q?HRZhNDgfmj86ptI9T2OkDLUWjsWRxa/gV+ZjI5Kfm601MuDw+LAj6Hp2dcU3?=
 =?us-ascii?Q?EgM1KhOWyIlghxMa/18n5ZwNjNbMmrkY/c2K+STc56seCc88EC0zOxwynl6h?=
 =?us-ascii?Q?wEON7fsWJX33rHu1hqoXShO4dZ4h6jY4Orfub/LKyjnXieq0Yy20G36IfP+s?=
 =?us-ascii?Q?LePjEcaDquF7US9fPlGOeCwn/sJiv4FBe5aHwLKsARmWxIyA3RNKsN83zIKQ?=
 =?us-ascii?Q?K2OfGJaMoThQI7ryela5UO9iiukrCPY+5nIlGh+J1pGEziGmjnCJz6lr/SHi?=
 =?us-ascii?Q?yKrC5gjEgRvWsnOQtwUzYeemg7OeOng299VM/B12Ij/26FQS+klRP9IsPnBr?=
 =?us-ascii?Q?rTSpFMsOafk/yZAI51tpbfmKkqkfqXGAF7PQ/HMIjOg2j0qqNJ2Mi9qIAw0c?=
 =?us-ascii?Q?ZtFEayInxeAenVigf+Ev9V1YdJvYANW1mYG6N7REkRX/uQliyT1f0yjCMVst?=
 =?us-ascii?Q?OZHAK74Sk1W43QIYPebnOqVCXwJFfn1Pw/C+/BGSUvWeAXopQrJ5Nl2M0YTn?=
 =?us-ascii?Q?XAnhnypMwWtU7aVlK990Vk+2BfHk7fMVXHQRK6zaJcpl7XSmUYjqpeKOPDPZ?=
 =?us-ascii?Q?nWYHPSbAaIL8nSjfbnT2iLEyrkAHh1ucMiDsaM4nrw78QTn/VZkqYQS0nMyV?=
 =?us-ascii?Q?N5bI/dFFRH/UdJlBEc8YQZdD0fNFBN4JuxyhEkaCOJoqfNRPS1hKABwJWSyq?=
 =?us-ascii?Q?oieD3BzudNUNKKC2XoVAicT4H3lQhpxCyuUCTlgg0rYGYTaMaZ3R3fOJU0Qc?=
 =?us-ascii?Q?07VE8+QeQ95+aFJjNGS2+Ima5kJ/gEoIbxUGi+Nqyx+LGMrqvLPiRSS9KB8e?=
 =?us-ascii?Q?3q3fNdUcCFYwIJdlu8u4Vgcg8pgnaHbMrgCGzNw24ORa1MH6cgTbjzqyDgSU?=
 =?us-ascii?Q?iS1e9ZgzsOa1JAHY9AIEZgnDoi6H2fhWYG/G0QJwN1T/nlsSLpEdU8NZ9hpJ?=
 =?us-ascii?Q?Ki72JGpe+X1jg2H4x5XfRV1jn81z29H62WoDeIaPodjIEHbfol8wXmTi50kJ?=
 =?us-ascii?Q?iT0LtisGttf64zU+bGcwZlZWb8CkWDOHGlXuhNvllathqkGVZpVPb2vzFCLg?=
 =?us-ascii?Q?oVQvGn063RbfCRNN0Qd5GCwrBFJFTscu8xGrSkgijN1Ny2kVQmdzO2lODJpe?=
 =?us-ascii?Q?vtPw1RgbmHjHUvTSa8klUTSypZ4gES/CfqsrmjvyFDHX3KBzVSgjm+djm+p0?=
 =?us-ascii?Q?DCgPKPXLzimHAd+D9Xa0Psm0Zl6k918wdYvs1firmS4eSIBbtygwuQHa+5/7?=
 =?us-ascii?Q?VHpsqlZIRd5dw41OqUZFxoLl3f4lvwl1w025tRhkm+ZyoyzC3cvDZK+aPCrM?=
 =?us-ascii?Q?azVJRutCUatLQLAZ0wPM6xdajUjZypX8Cs0F4Stk22NVZnQ6v2vn9vIkRz7D?=
 =?us-ascii?Q?Gw41F/IgratCn9UBHo3lKHOBm/EWViSAcnwL7t5AcMbUuob29A1PHdey2Gve?=
 =?us-ascii?Q?5zExQuSlRCp0JEhCk/Am40IFOgycB+oeuFmxV8xhnb9rhvFN5T0fNdULzLq6?=
 =?us-ascii?Q?Ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CA8DEDB69F10D9488C81C17E8F16A4F3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DeDjG/y7NUBI8Baf3qOe7q3YGBI7al1EaPddAbuxFIXRq7RNLMOGJINNr19WdcxquyEvbo3GmxBJzBwCzzrZea40HWEKz09zuLh4SogKLcNqwwPuDRkeDQEGGxtnqOF4SBHrn3KfLj/7ySKdilZOwuS6msWtrGAa8Mo3vhGHdnZIl8Ph0X3bmN4itc5LHGN9x56hZNUUbGYbq5WzAhgi8b8r05GLqjkAnNwMR0VXbM0QwvrVYTHrM8D2/t4QtP5Hh2B9AmuOJqBaOJGXS1ImTTWxYyKe3QB+OShDhn1CYcJdtx3RW+pFwmtcaONt9LirYAcpT71hSL7/rP+GRAT7kPpvVxe/IgxbG4nLaaal8BbmvsNqWKxH+nwdllINWhg8x3CE63Jlz4miD/tDHQmIO3hXhTcfFVc4G/vHR1iz6HrL5TRVSC2SFBpJyE44Ea3qJQ0xTybMVamFB4vSKsOhmOKSdZFB5a+xM9PjQSkgrJaA8oNI0uE2huE0vi74rMWzhUfyXYOhHqPfy+FPeQItUtRJOZs4ILsVb0sFeOgMFmIS0H2xyxjhIA7cd62OP5B3bgnM8NFN4nxwP/FTN2xUbvM1pU4Vn2YiYsxuYsVPd6UrJAd+wGJpEX3NOTpky3hszGMh/PYCCTASfVHJcn56YWjWY6Wj6UaXRWGrw8asoSmpywZLxcsc0D9DehFZivSCTuA3nOoXjXCej1I50VvEd0GNhx/l/1Mgwnn6+SOgI4NNrYGbHAVo0qSunHnIY0icQOYmGKcZh83v8hFub++rXk/zKI4VSmwzkBfiv66TdRH3ETRYgwJaZ4q/e5ZkjLAWkyEHA7O3qY5rUe4FTe2kEPS16I4Kj+4DXkSX37ss5LDJ0sC4Y5csen3FSTMGZqSV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cb3a9e-1a71-4d7d-3be3-08dbaea5e9bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 06:53:01.6675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6LPu+y/ziJoIX1B+aLgjjTwwxnc8zZlu6Tbjj+qREjFqHT9v/3P/qN5OOlMCi93aI51bijlzuIrBnuK90BHUMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7133
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 02:33:21PM +0800, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
>=20
> If a disk is removed and quickly inserted when an I/O error is processing=
,
> the disk may not be able to be re-added. The function call timeline is as
> follows:
>=20
>   interrupt                            scsi_eh
>=20
>   ahci_error_intr
>    ata_port_freeze
>     __ata_port_freeze
>      =3D>ahci_freeze (turn IRQ off)
>     ata_port_abort
>      ata_do_link_abort
>       ata_port_schedule_eh
>        =3D>ata_std_sched_eh
>         ata_eh_set_pending
> 	 set EH_PENDING
>         scsi_schedule_eh
>          shost->host_eh_scheduled++ (=3D1)
>                                        scsi_error_handler
>                                         =3D>ata_scsi_error
>                                          ata_scsi_port_error_handler
> 					  clear EH_PENDING
>                                           =3D>ahci_error_handler
>                                           . sata_pmp_error_handler
>                                           .  ata_eh_reset
>                                           .   ata_eh_thaw_port
>                                           .   . =3D>ahci_thaw (turn IRQ o=
n)
>   ahci_error_intr			  .   .
>    ata_port_freeze			  .   .
>     __ata_port_freeze			  .   .
>      =3D>ahci_freeze (turn IRQ off)	  .   .
>     ...					  .   .
>         ata_eh_set_pending		  .   .
> 	 set EH_PENDING			  .   .
>         scsi_schedule_eh		  .   .
>          shost->host_eh_scheduled++ (=3D2)  .   .
> 					  .   clear EH_PENDING
> 					  check EH_PENDING
>                                           =3D>ata_std_end_eh
>                                            host->host_eh_scheduled =3D 0;
>=20
> 'host_eh_scheduled' is 0 and scsi eh thread will not be scheduled again.
> The ata port remains frozen and will never be enabled.
>=20
> To fix this issue, decrease 'host_eh_scheduled' instead of setting it to =
0
> so that EH is scheduled again to re-enable the port. Also move the update
> of 'nr_active_links' to 0 when 'host_eh_scheduled' is 0 to
> ata_scsi_port_error_handler().
>=20
> Reported-by: luojian <luojian5@huawei.com>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
> Changes in v3:
>  - change patch title, previously it was: "scsi: ata: Fix a race conditio=
n
>    between scsi error handler and ahci interrupt".
>  - drop the variable 'host' in ata_std_end_eh().
>  - improve commit message.
>=20
>  drivers/ata/libata-eh.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 159ba6ba19eb..2d5ecd68b7e0 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -735,6 +735,12 @@ void ata_scsi_port_error_handler(struct Scsi_Host *h=
ost, struct ata_port *ap)
>  	 */
>  	ap->ops->end_eh(ap);
> =20
> +	if (!ap->scsi_host->host_eh_scheduled) {
> +		/* make sure nr_active_links is zero after EH */
> +		WARN_ON(ap->nr_active_links);
> +		ap->nr_active_links =3D 0;
> +	}
> +
>  	spin_unlock_irqrestore(ap->lock, flags);
>  	ata_eh_release(ap);
> =20
> @@ -946,9 +952,7 @@ EXPORT_SYMBOL_GPL(ata_std_sched_eh);
>   */
>  void ata_std_end_eh(struct ata_port *ap)
>  {
> -	struct Scsi_Host *host =3D ap->scsi_host;
> -
> -	host->host_eh_scheduled =3D 0;
> +	ap->scsi_host->host_eh_scheduled--;
>  }
>  EXPORT_SYMBOL(ata_std_end_eh);
> =20
> @@ -3922,10 +3926,6 @@ void ata_eh_finish(struct ata_port *ap)
>  			}
>  		}
>  	}
> -
> -	/* make sure nr_active_links is zero after EH */
> -	WARN_ON(ap->nr_active_links);
> -	ap->nr_active_links =3D 0;
>  }
> =20
>  /**
> --=20
> 2.39.2
>=20

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
