Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624A7764477
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjG0Dgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 23:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjG0DgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:36:25 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021015.outbound.protection.outlook.com [52.101.62.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6B4270D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 20:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgOqP1rUofioR4jKV7H6bXrqvEz/wKputfl08coepAfu5dyJSF2qNgL8+/R6KVRUbidKLIuVvIyEBuryUk3rTzgq28Y15YvwZEMQu2E1z/DySJfxl0vE/UkSQaUTxUOATy1GD3gku2Czb7qWrIUPd0DNXQ1RDoFT2YYKOz5UzAHebi0v/35iV1niy+HH11Cr75S2iY5k4dWrzYD8ZG5L5LA7CNPhzGJT+I9oSZlwm/c0NkUgrWl5JsIYJd1AC6w0cFpS0pcDtE8VheK8IGtRWTuZqmy80g8NeqKOOLB/ekP/66FLc7ljYY2HlfA2caDTyOD0gz7X2l85yKZUciyTPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UNjRWanA3UsFnV/e3/+d4hyMYzWxkMUJM/3Tkjwwhg=;
 b=jYFmrE1o+mkuvAHwpa/0DKlip4Km2fUzu756WRYveI+E+tcTQKV8uKRNX5zWav9OB5T1rYF/f9xuTDwZSM+UUWY1uQkQPqom+O6qfm1JSQfPQjwCQ31r3Mpfh8eLoGHeiFy03F8RUJAqCvF4Lzpe0COdrOj3osXs2A5V2+YYj6szqVFDjwxC4Je90YNUg5PoqvuFpDAJRDfBfoGxTk+CGYO8CGZEyAdoG0DZlHsORnS81kBlroC38LklcIQsiXdfqZiyAcbgzggmiE/nao/TmEj3Lw6m3no6nX560gJroJnIsMz7AqPphDQ+Pp0Lt61lJrnEMlNbinFaAPNCJeteBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UNjRWanA3UsFnV/e3/+d4hyMYzWxkMUJM/3Tkjwwhg=;
 b=G93AM/pKy8VMDG5LKrMpvx2Pysf9KytEdgTCiwFoTdf711I09d3uAAUNLxvsOJGKMijvlir41IvLut6QEMaqitGI2z+B0lULazr8oAT8XiabFYEzoKRNiD7ab6+IB2vv9/Z4NwvX1EC17BKboJH36vtSt2hmTDdht1h90GiVEaw=
Received: from DM4PR21MB3441.namprd21.prod.outlook.com (2603:10b6:8:ac::18) by
 CO1PPF347D5BDCF.namprd21.prod.outlook.com (2603:10b6:30f:fff1:0:4:0:a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.12; Thu, 27 Jul
 2023 03:36:11 +0000
Received: from DM4PR21MB3441.namprd21.prod.outlook.com
 ([fe80::f3ba:9bd2:7908:4ea9]) by DM4PR21MB3441.namprd21.prod.outlook.com
 ([fe80::f3ba:9bd2:7908:4ea9%5]) with mapi id 15.20.6652.004; Thu, 27 Jul 2023
 03:36:11 +0000
From:   Steven French <Steven.French@microsoft.com>
To:     kernel test robot <lkp@intel.com>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] fs/smb/client/sess.c:160:5: warning: stack frame size
 (1152) exceeds limit (1024) in 'cifs_try_adding_channels'
Thread-Topic: [EXTERNAL] fs/smb/client/sess.c:160:5: warning: stack frame size
 (1152) exceeds limit (1024) in 'cifs_try_adding_channels'
Thread-Index: AQHZwBLWbILdzQpn2UWwGHu8Gccq46/M9bnQ
Date:   Thu, 27 Jul 2023 03:36:11 +0000
Message-ID: <DM4PR21MB34413441C9DF320C24F5A84FE401A@DM4PR21MB3441.namprd21.prod.outlook.com>
References: <202307270640.5ODmPwDl-lkp@intel.com>
In-Reply-To: <202307270640.5ODmPwDl-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2ee06bb5-e93b-4192-990a-dc10ea389b10;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-27T03:32:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3441:EE_|CO1PPF347D5BDCF:EE_
x-ms-office365-filtering-correlation-id: 2ac106dd-7fea-4c2e-dc83-08db8e529f29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q2x2eWHyDvkwjyvdw5CtgAVrlRCs+H49PPU25YmZrqdIbd9l7s32IWGG/WAZ21WVPpKLbbBBJmwBn9bKuAwGwPkoh6gFWx648kl9v4QkWuo2sHlDXT0N5546cZ8HqT48hv80IXmWitdlSq/rdinFGivhhcTeZUSQFC5IB9Dxj15fydNzfa7ueya7avVkaRlfEUYrYF5kPun8nQpNeFsHDomRL9Kyg3zcV5fYdWq9hxq1G9WtJMiDVbpTjJk8zVT+n0srofgrQE0TWFbU1+6zzQ8HVCs562xe1A3poz/4pE3b0y6nYQnlhawumYdY6G/2ceL1Z2HkLBGKbrgXvhCcbGO4rND9DY0bGEe8sjJCiX4YiI73tXJ6AhCLuJGTQRpFEPRNI4X3RjgfIXxNvIJq9YG4oLfkdyvI50Oh8pHDngoPfRgydoNXM4BbEfO8A0SDaypwPgMhkEibSNZejFFavl+MQCKSimY/dXbubrwLWX90BUZO3QRH6BjGWSZff0DL7TydXIE0maqftlOeKcXuP4SyjnIvKkJF1UgTNX0nAcw8h6U6Ce2jXz9Jcf2QqcEBqMYRguyAxHvUZ/si565//uNvNYaOU2SrGYD+aGh2rObde4YmNnx/Vh3tplU9SetBmk+6RBWtz2Ufi08JFm6EOQEYTRFi+673XQOc5ay9bfeVklOmo7CzWEJgFIQrJ3HU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3441.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199021)(122000001)(82960400001)(38100700002)(966005)(38070700005)(33656002)(55016003)(82950400001)(86362001)(7696005)(71200400001)(2906002)(4001150100001)(186003)(478600001)(5660300002)(6506007)(8676002)(30864003)(53546011)(316002)(8936002)(41300700001)(54906003)(52536014)(6916009)(66476007)(66946007)(4326008)(66446008)(76116006)(66556008)(64756008)(9686003)(8990500004)(10290500003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+hfo0b2sLxchuAzlou1x6z6GsqI2DLqMeO6fjTc9F072dHtzUkiDS3NOxb/b?=
 =?us-ascii?Q?WAxhAohtYWMaGHyngD37jFqbQvfHTq025hlRVxdFgUe+0gwZIusnGflnay20?=
 =?us-ascii?Q?hMtEvlIAi/wNIGVXDZDjSws05SV+xTZQawHB0yTqbKhzLiev9DYBsNpBI2CY?=
 =?us-ascii?Q?IXYVXX/147YkkRoqBNA4yX+oJY7R0B4yO2b6pKBeBG9ewZgV51h3M3aWIpKf?=
 =?us-ascii?Q?SaC/U6XPlFr/uonS8jaCgOwHD/J+pPfWMdwOo4c8BaU4xT6oECgm2oJ/Z9zW?=
 =?us-ascii?Q?YRzmw1LGHkfXVpEu27ZySke3z8E0wEwCbjWO8YCnaRM3Z4F4Ie0Fk0DFKEps?=
 =?us-ascii?Q?Ql5mjax4S5NziLpk+EqVY9/twTWFzigE18sIykh/tROwtp/XTl70scnBYOqv?=
 =?us-ascii?Q?ujUtPhWB0/D8Blaxr2pnWi5ka1mHd5lKkhk8XwMEsyB1hkJw+T4JPjyE8dyW?=
 =?us-ascii?Q?aqQM0x/wkfQD17yT01+vbBy1gFXPeCD4galJKnNhzTY6+q4Ne48C7DEfiYnA?=
 =?us-ascii?Q?IW4dN1Dm2qX2KggYuL+4A6g9ncMLZ2YYHlZB4miclB6yLK/rmnDgri05UQX8?=
 =?us-ascii?Q?S3/LEiGxpOo5mq1SoCcgOalYEfKVpkEtjbCRhab/phRAnOEWBDFqgSEsQ0YB?=
 =?us-ascii?Q?/CcPBumxt653kdGHrH38Gffip1drZOamkq6qrOcPWwPMRRVy4Grc2vbp0ZzT?=
 =?us-ascii?Q?fxtsuBS/VmbPEb9Pb2uqDRLBVEoRQWDzPBne1V1XcU6LljNm4LExXUzy5JYJ?=
 =?us-ascii?Q?/kDNEaT2cXEws3oaPNwoZSTHuZEJNNh0D8g0P9XP3zzE+qhZThHy615TOk9F?=
 =?us-ascii?Q?9iTK+Svm9Fe5glSqSAWj95UPW11SC5jpu0FR2yh8H+MWloieFTxz7yhDqrcG?=
 =?us-ascii?Q?C4X+/BRNrW+sBj0XAqtUDrTNuv8N0kL3r5jhXWfgJlJw7Uf7yQ/xqz9F/BuC?=
 =?us-ascii?Q?EOcTStJ5TNqrX0SGc42FOaPaUki6I+iOu7Xa9zhPR0VLi/iY2bje7M6+Od5+?=
 =?us-ascii?Q?EUogWpnNoZoCDfx1rlBSr2D9jkNdar2yYpBLPle2V/iOlgd75K5YNfJmLBdR?=
 =?us-ascii?Q?ke2PNDwYYl72YJYduxnV6Bjtk4pOqXduf24Mpwv3bmCAJN6WJ7gK+l2SiHsh?=
 =?us-ascii?Q?KTveoCL2531fJSWYO//BvR7tLtqNeTBzIRb5KtOaoRem7xr2Ama2Vk2gXTLF?=
 =?us-ascii?Q?0CKV8spx9g/BueiJc5gaxrkGzOyEDJDRqgnvbXspOR4Tpk//j/go+Mp5fGRR?=
 =?us-ascii?Q?Jh7xGntLeVPU/DZs07ej1JliVqeje7FKgBOmBL1no+UYl/dt696hqc9y0+Yh?=
 =?us-ascii?Q?865ntcRB0dcJyL9GPbnkQOSqdhykb2P+CivBaeDHFTH80ciZOzLh3cU1I10f?=
 =?us-ascii?Q?yD/OR5K9qn0BOWRFJZLsn9uyz6LjbClZrxgOdSkE+8K+zHYYCoDUObe7ws2g?=
 =?us-ascii?Q?tZq45e/2MuHkjm+pH7Bzt51f/6CzqyRHkW7w+R+YnuN/sArkQHcFp3rWp0M0?=
 =?us-ascii?Q?ktp5GhzcaZlt9cABz+EdXWqBNhEMzK7KfQXDUuxoK7+haTZ3Bc7j+nRXaZqt?=
 =?us-ascii?Q?+enyGpqKt8XfXUg1wNzRT3Zm7SWoAEYh1xNc1k7CD4lRuBmAW/Xsu3yyKWy+?=
 =?us-ascii?Q?N1AR8tDjNwvDzk5a6gtVmdn9yiQfh9rhq3U8g2EuxJho?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3441.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac106dd-7fea-4c2e-dc83-08db8e529f29
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 03:36:11.1590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UU5Vi3RpeouPBTpTsB4e3tE2DxyLtWCqA7vpTdlD4Mth2pVRBBdKPjJxYOh8E0b9Rs6VE3wQXAHSY3tnoYCVAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PPF347D5BDCF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone recognize the problem here - the stack size it is complaining a=
bout has a small stack usage not a large one
     cifs_try_adding_channels   has five pointers and five ints on the stac=
k.  That seems small - not large.  It is called by cifs_mount which doesn't=
 seem too bad in its stack usage either.

Any ideas why the stack size complaint is made?

-----Original Message-----
From: kernel test robot <lkp@intel.com>
Sent: Wednesday, July 26, 2023 5:44 PM
To: Steven French <Steven.French@microsoft.com>
Cc: llvm@lists.linux.dev; oe-kbuild-all@lists.linux.dev; linux-kernel@vger.=
kernel.org
Subject: [EXTERNAL] fs/smb/client/sess.c:160:5: warning: stack frame size (=
1152) exceeds limit (1024) in 'cifs_try_adding_channels'

Hi Steve,

First bad commit (maybe !=3D root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master
head:   0a8db05b571ad5b8d5c8774a004c0424260a90bd
commit: 38c8a9a52082579090e34c033d439ed2cd1a462d smb: move client and serve=
r files to common directory fs/smb
date:   9 weeks ago
config: mips-loongson2k_defconfig (https://download.01.org/0day-ci/archive/=
20230727/202307270640.5ODmPwDl-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a=
5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230727/202307270640.5=
ODmPwDl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes:
| https://lore/
| .kernel.org%2Foe-kbuild-all%2F202307270640.5ODmPwDl-lkp%40intel.com%2F
| &data=3D05%7C01%7CSteven.French%40microsoft.com%7C2cc584fd937a4cd5b9d008
| db8e29f75b%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63826008313023
| 4737%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT
| iI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DAauGIxZRPM5DK1J5j6lyEp
| jOkArxfVtIUAnmPcxcCQs%3D&reserved=3D0

All warnings (new ones prefixed by >>):

>> fs/smb/client/sess.c:160:5: warning: stack frame size (1152) exceeds
>> limit (1024) in 'cifs_try_adding_channels' [-Wframe-larger-than]
     160 | int cifs_try_adding_channels(struct cifs_sb_info *cifs_sb, struc=
t cifs_ses *ses)
         |     ^
   1 warning generated.


vim +/cifs_try_adding_channels +160 fs/smb/client/sess.c

b54034a73baf9f fs/cifs/sess.c Shyam Prasad N  2022-01-03  158
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  159  /* returns n=
umber of channels added */ 387ec58f339b0c fs/cifs/sess.c Ronnie Sahlberg 20=
20-12-14 @160  int cifs_try_adding_channels(struct cifs_sb_info *cifs_sb, s=
truct cifs_ses *ses)
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  161  {
90c49fce1c43e1 fs/cifs/sess.c Paulo Alcantara 2023-04-21  162   struct TCP_=
Server_Info *server =3D ses->server;
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  163   int old_cha=
n_count, new_chan_count;
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  164   int left;
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  165   int rc =3D =
0;
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  166   int tries =
=3D 0;
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  167   struct cifs=
_server_iface *iface =3D NULL, *niface =3D NULL;
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  168
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  169   spin_lock(&=
ses->chan_lock);
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  170
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  171   new_chan_co=
unt =3D old_chan_count =3D ses->chan_count;
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  172   left =3D se=
s->chan_max - ses->chan_count;
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  173
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  174   if (left <=
=3D 0) {
88b024f556fcd5 fs/cifs/sess.c Shyam Prasad N  2021-11-19  175           spi=
n_unlock(&ses->chan_lock);
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  176           cif=
s_dbg(FYI,
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  177              =
      "ses already at max_channels (%zu), nothing to open\n",
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  178              =
      ses->chan_max);
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  179           ret=
urn 0;
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  180   }
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  181
90c49fce1c43e1 fs/cifs/sess.c Paulo Alcantara 2023-04-21  182   if (server-=
>dialect < SMB30_PROT_ID) {
53923e0fe2098f fs/cifs/sess.c Steve French    2022-02-16  183           spi=
n_unlock(&ses->chan_lock);
53923e0fe2098f fs/cifs/sess.c Steve French    2022-02-16  184           cif=
s_dbg(VFS, "multichannel is not supported on this protocol version, use 3.0=
 or above\n");
53923e0fe2098f fs/cifs/sess.c Steve French    2022-02-16  185           ret=
urn 0;
53923e0fe2098f fs/cifs/sess.c Steve French    2022-02-16  186   }
53923e0fe2098f fs/cifs/sess.c Steve French    2022-02-16  187
90c49fce1c43e1 fs/cifs/sess.c Paulo Alcantara 2023-04-21  188   if (!(serve=
r->capabilities & SMB2_GLOBAL_CAP_MULTI_CHANNEL)) {
9c2dc11df50d1c fs/cifs/sess.c Steve French    2021-05-07  189           ses=
->chan_max =3D 1;
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  190           spi=
n_unlock(&ses->chan_lock);
90c49fce1c43e1 fs/cifs/sess.c Paulo Alcantara 2023-04-21  191           cif=
s_server_dbg(VFS, "no multichannel support\n");
9c2dc11df50d1c fs/cifs/sess.c Steve French    2021-05-07  192           ret=
urn 0;
9c2dc11df50d1c fs/cifs/sess.c Steve French    2021-05-07  193   }
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  194   spin_unlock=
(&ses->chan_lock);
9c2dc11df50d1c fs/cifs/sess.c Steve French    2021-05-07  195
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  196   /*
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  197    * Keep con=
necting to same, fastest, iface for all channels as
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  198    * long as =
its RSS. Try next fastest one if not RSS or channel
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  199    * creation=
 fails.
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  200    */
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  201   spin_lock(&=
ses->iface_lock);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  202   iface =3D l=
ist_first_entry(&ses->iface_list, struct cifs_server_iface,
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  203              =
              iface_head);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  204   spin_unlock=
(&ses->iface_lock);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  205
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  206   while (left=
 > 0) {
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  207
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  208           tri=
es++;
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  209           if =
(tries > 3*ses->chan_max) {
bbbf9eafbfdaa2 fs/cifs/sess.c Steve French    2020-05-30  210              =
     cifs_dbg(FYI, "too many channel open attempts (%d channels left to ope=
n)\n",
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  211              =
              left);
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  212              =
     break;
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  213           }
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  214
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  215           spi=
n_lock(&ses->iface_lock);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  216           if =
(!ses->iface_count) {
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  217              =
     spin_unlock(&ses->iface_lock);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  218              =
     break;
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  219           }
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  220
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  221           lis=
t_for_each_entry_safe_from(iface, niface, &ses->iface_list,
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  222              =
                 iface_head) {
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  223              =
     /* skip ifaces that are unusable */
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  224              =
     if (!iface->is_active ||
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  225              =
         (is_ses_using_iface(ses, iface) &&
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  226              =
          !iface->rss_capable)) {
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  227              =
             continue;
65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  228              =
     }
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  229
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  230              =
     /* take ref before unlock */
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  231              =
     kref_get(&iface->refcount);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  232
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  233              =
     spin_unlock(&ses->iface_lock);
387ec58f339b0c fs/cifs/sess.c Ronnie Sahlberg 2020-12-14  234              =
     rc =3D cifs_ses_add_channel(cifs_sb, ses, iface);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  235              =
     spin_lock(&ses->iface_lock);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  236
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  237              =
     if (rc) {
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  238              =
             cifs_dbg(VFS, "failed to open extra channel on iface:%pIS rc=
=3D%d\n",
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  239              =
                      &iface->sockaddr,
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  240              =
                      rc);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  241              =
             kref_put(&iface->refcount, release_iface);
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  242              =
             continue;
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  243              =
     }
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  244
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  245              =
     cifs_dbg(FYI, "successfully opened new channel on iface:%pIS\n",
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  246              =
              &iface->sockaddr);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  247              =
     break;
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  248           }
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  249           spi=
n_unlock(&ses->iface_lock);
aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  250
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  251           lef=
t--;
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  252           new=
_chan_count++;
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  253   }
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  254
724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  255   return new_=
chan_count - old_chan_count;
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  256  }
d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  257

:::::: The code at line 160 was first introduced by commit
:::::: 387ec58f339b0c45e3767395f11fa8dd3772131e cifs: simplify handling of =
cifs_sb/ctx->local_nls

:::::: TO: Ronnie Sahlberg <lsahlber@redhat.com>
:::::: CC: Steve French <stfrench@microsoft.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
