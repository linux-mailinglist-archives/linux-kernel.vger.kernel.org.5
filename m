Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EBD75BC50
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 04:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjGUCd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 22:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGUCdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 22:33:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B7BCC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 19:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689906834; x=1721442834;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=//YXrLGgNlv0XTnB1EAHtQ5ppDD41QiLVvV3doye1rE=;
  b=Kdzgztae1lgFZzoXh+c0houQVTzEiIw8AtzPztwv1PYaMCdEMBPCPVmt
   /V9ffnhoBwtPVteYkl5WBec2Aa7GGg1y4nt8wVWZbkrfhWPJrZ1tzlFTp
   pNbsMjID4DmNpQLfoXApKcIoJ5xavaM2ICxWdxSPJxPpD6IbJMtJA7N2S
   zZ+PS7lpT7vVHmUbQQVze/rtQd7Zx2aW/Oh37s02hUwxqeay3YOx3AN0j
   dSqOKNbwPYWu9IcjuyMi9d9UAseA9pICVLSCkO0pvOgpZhesrPejJWbZl
   SrEVfS0P2oeFMR4igMjJkp49bJH+a0i2M+fJT1N9kVCAVaB9FYOXjLJHp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="366956118"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="366956118"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 19:33:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="838374823"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="838374823"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jul 2023 19:33:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 19:33:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 19:33:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 19:33:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQhG9Hwyn3Tm17UpQgPymLaHQlFE6XGYjUXHtbrPlns4ZI5BYAKE2JP63GhLLaH2vq2vG0wpdynolmuENt3ipsijdg+7e+gTNORQtwASo10DoadJrN35tU2PCufcaCyKBuEWDgcbSzy5M8nB2haTDQrks34eKro1N7IGnJIcYzNl0ty/bkhfm5b7ta3pG0VQSxrid0Q3dvZH/t2cWTYyv3zuG4v3IWNvpesObMihm4t0SwM3N/HN9Dy71gbaikwL5T1cJrsLbwzZNbBRYzYnkvY49bQVEkqpCDnAWnW3qTcsw3VZZH6vhALLw0+4H3PywLSYzYBFhwbjY+/Kg62eJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcwjZFPCQBwWAB9ZB5U5BLRfUAgHlEDEUAR5pMCbSX0=;
 b=NXfjAixgFVMOZp6Qin8utAnJzZouplwWgdOZgXMffmE0G57dabyNZHzjzp+9c7lo1qALOKlZ0NURf6pwbWzLVH1ZN92efvNER7kQvYfNcC3XHGyx9p1kH7dwO38L9ECtMQNAAdsBzBhIYxI2rij42YKq+xgyqZ6pPMyoylXnru+QjAOVB3ok4mPQ2kioqSpHnpvvWLx1Eqd8HyO4QtMhK6jNVsOoGfayw0zLb4gZBQ7wrNcDJTFxs3LYt9Ej8t2sM6FfflQbyypZaNbQZbsWbh9fby1zMVHk2CdCF0em1rDPyrIEbesKu7nlyOE0sMZRgOBkDWlrC/Tx2atfk2qmCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5673.namprd11.prod.outlook.com (2603:10b6:510:d6::7)
 by CY8PR11MB7033.namprd11.prod.outlook.com (2603:10b6:930:53::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 02:33:44 +0000
Received: from PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::c3f:2546:872c:871b]) by PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::c3f:2546:872c:871b%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 02:33:44 +0000
From:   "Lee, Kah Jing" <kah.jing.lee@intel.com>
To:     "dinguyen@kernel.org" <dinguyen@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bacrau, Radu" <radu.bacrau@intel.com>,
        "Ang, Tien Sung" <tien.sung.ang@intel.com>,
        Teh Wen Ping <wen.ping.teh@intel.com>
Subject: RE: [PATCH v3 1/2] firmware: stratix10-svc: Generic Mailbox Command
Thread-Topic: [PATCH v3 1/2] firmware: stratix10-svc: Generic Mailbox Command
Thread-Index: AQHZuFExcUQgAtMuLkm1lR02IOmoKa/Dhr7g
Date:   Fri, 21 Jul 2023 02:33:44 +0000
Message-ID: <PH0PR11MB56734FD81C67F2A606146466CB3FA@PH0PR11MB5673.namprd11.prod.outlook.com>
References: <cover.1689524302.git.kah.jing.lee@intel.com>
 <ea74e0c56cd895e714738c0eddc1ca1f8537661a.1689524302.git.kah.jing.lee@intel.com>
In-Reply-To: <ea74e0c56cd895e714738c0eddc1ca1f8537661a.1689524302.git.kah.jing.lee@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5673:EE_|CY8PR11MB7033:EE_
x-ms-office365-filtering-correlation-id: 0df456ab-9e7a-4e7a-c27f-08db8992e76e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 50YafM7sW6AymmI+2p1IEDG858k12OvUK2gTmf1yarXBYGwT/Ly9cwLUOGlmjwPQ6yHMHMADqqE6kGjA0DJ/AiLgVwqU7bGQ/Xx8Cor8frbz9ITDjrQdSUNottFZkWwkkiULG4tm/AWho2JjzyHu7dD9vT2EqIZuHwkcLRg0kOEdcvAH4Q7pz64XrWkOpH9RM0E//L+ld0g+Xuy9X9NhJIADXmz+29dkOUwFlYxm/dLimEe9K05nb9Jr+/LVGcpyZibaN08FilLuyWsyPKyE9QCLk6R83cbZ+x1aPtz7MFbOZ2R3rp+MDY/NFI/kAYdDY3NgONHkfgzJtOKR6PhpMfjR4hGPvGOkU0l8bhw8NhcEGF08wq5xxLgP2gGQrD77zT3U/CTkf61BlRrhyKek/Dhl4OfeNoIl29o2cbp9v16hU//0tV6T6SB0Wph9V9uwkQLt8rbzPBJGT5kI1S5LMNt1G+kIY9eehMFXt+FKtpyqWH05932778by7l3kaeE+WB1KB0zwMQCRPCBMdZOWZ0QNRT6ibaDwCTCH9t4B9K8mvLcc7WWEc9wRjKCTE1llat+tTQQBKkVjZ8Ge+ma59OfuXRugEMaSPLQBC+yATwtwjzdIbxlDn+SrzZ2WfyxX6UmyoEsWgu2ahvSffyxddQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(33656002)(4326008)(86362001)(478600001)(9686003)(7696005)(76116006)(38070700005)(71200400001)(82960400001)(66476007)(6916009)(64756008)(66446008)(66556008)(66946007)(316002)(107886003)(38100700002)(41300700001)(6506007)(5660300002)(186003)(53546011)(26005)(8676002)(8936002)(54906003)(52536014)(15650500001)(122000001)(2906002)(83380400001)(55016003)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3wpVdcRoyJKxoHd5Vh5s4dEONTkJXJrcfOKUgzCAVmCAVNOnVOvVXb/wAZ2V?=
 =?us-ascii?Q?br9EXv7Mwa2CNxszInxRbasz9vycsitKkmQbpb7jw+3SSn8ubRNwz399gv5X?=
 =?us-ascii?Q?wzNplSI+Zm7OLMR9QZ9mh6I5Ol17gImUs/IOd0jWjNeXiW3PpHaiQ6IepMx1?=
 =?us-ascii?Q?TzmXw09gwYF4bmx+SvHqtt9/Xugu04Bb1XpUC49NEOcnCLa9xdtWj1aw3+63?=
 =?us-ascii?Q?XTwweW8K2vTHhawI2X05IwmhZjhLjv+jWTT9zss0TAO0POHfWobm69FgOntH?=
 =?us-ascii?Q?YFFqL1PReARi1QCsRyy4Myo8AJP8d+85hA6Vhdd2X26AFwyalqJw2zWZK+Z3?=
 =?us-ascii?Q?z03SEE95P4tOo1PxylOdssvoxNv/KYZKNQiUfzqeYEj4Uo00bz3joQO2iUOC?=
 =?us-ascii?Q?l0VEbX1kT1QPiBDg5oAttqYw1HKBZEiWf7IBbDOJ+kVoMHGKXUJpcNdxLPrl?=
 =?us-ascii?Q?f43CrnRUedYDTw/MZQ9TI2G1LZ2t282GyrbdYJGZmK9gRbdg9CKrGDFqghMX?=
 =?us-ascii?Q?G8RMyUrNfu602ufsKmGZrqq1i3mXaYu5x5BsnymiA11IQ9zsDRETUPmC1YvR?=
 =?us-ascii?Q?pFrPlahRoUh5rOzBlIA7oZ8RUHoedl8YHhfrO/poHK3Mt6Gtu+yOIzKaPg25?=
 =?us-ascii?Q?VOwwty9sFEw0nOqie+Hmf1tvu3BfP2IPFDJEUYHEPZUX3Zy6YSBM2en+KPv7?=
 =?us-ascii?Q?CD+v4/0Y6kcdWbmvKc5GxLLza9JKekWCONQRAxXXjVt/eSmTDIe2/VmflO6D?=
 =?us-ascii?Q?7vze1CBnhue5ux+YPB04LT9sj/stkC7HuJZ299DR+nFtfpbROuzAu4LnsOb9?=
 =?us-ascii?Q?d8k/dDeUae61C8+kFCQ7ZqAnr/zGb4OAZT0sm03r2B9wcolXQfTKb8blD8BX?=
 =?us-ascii?Q?ooNvKiHe8ejZLKCiCQl1XtS1LDAD6KV6g6gxz7q8EliwqWFSdaRFRjEP4BSu?=
 =?us-ascii?Q?7m9CyWDL1Sq+SZj5qyDLiUMI3uuqTzDAUZrircHwnJxZgj0L7x3aEDZoqpSZ?=
 =?us-ascii?Q?V0lzs4c6+dccY75j36AQDSpsYHDuNMt/HWSU6tRgHhTbeBu7dQZyVADj9qjp?=
 =?us-ascii?Q?6SdWRX9P++XOnXpNvhNqDlRry0tiEM9azYds2DafXFLHD3FMAcjAwMpkNKac?=
 =?us-ascii?Q?oJJRmre9nLq7BmUx4RkYGTnXJg8ZD9anmLda3H6GtFtYSvodi1zW/0gKhcH7?=
 =?us-ascii?Q?yaw6AGc5ltlJBe9+53NohabwE3KvWU6g4ueyTE/C71YcHZ8FEn2hnT+jxa7f?=
 =?us-ascii?Q?MKfx+95SQR7wnTbZzvO/AAo76nbfbbgiJvCc/KqA4DyvTcaZpF9Ne1qVLzfH?=
 =?us-ascii?Q?12YE54H6eXKcaiQ7vupvyaD57nBx3+ItbanBnsFSQ1reAo87xWkgI8fucnKX?=
 =?us-ascii?Q?lHOeVYHnu+EGk0tWfuD8Vpzr0WLKHVSmBzZrhObM0WwHOX3yBBQFRNzla42s?=
 =?us-ascii?Q?DSwupVZENcDmSqGHrfzKfRmtVFwcaHEFNZOjzApljp2M5WuOAa/wLHXof8ZG?=
 =?us-ascii?Q?kjzUZF+XgFj0NOgo/cyEdXhLWK6QfnIv9iJLJemkqdTavxfWfG8zybvHw4du?=
 =?us-ascii?Q?e+tFTEuMF4LcD4Zf43Dlgk5XLRrgDWVrOHEnMQqT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df456ab-9e7a-4e7a-c27f-08db8992e76e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 02:33:44.3808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NdkML+TdeBcEJkgVrJWpf6O6bbxzhkwNXhqzOCoBOymb1Q8vw2aT4iOwmpWemgjisktxgQQZ9XbT+z0pg7R10Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7033
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinh,=20

Any feedback on this patch ?=20

Thanks.=20

Regards,=20
Lee, Kah Jing
> -----Original Message-----
> From: Lee, Kah Jing <kah.jing.lee@intel.com>
> Sent: Monday, 17 July, 2023 9:50 AM
> To: dinguyen@kernel.org
> Cc: linux-kernel@vger.kernel.org; Bacrau, Radu <radu.bacrau@intel.com>;
> Ang, Tien Sung <tien.sung.ang@intel.com>; Teh Wen Ping
> <wen.ping.teh@intel.com>; Lee, Kah Jing <kah.jing.lee@intel.com>
> Subject: [PATCH v3 1/2] firmware: stratix10-svc: Generic Mailbox Command
>=20
> From: Teh Wen Ping <wen.ping.teh@intel.com>
>=20
> Add generic mailbox command that can support SDM command. User can
> use this command to send SDM mailbox command. User have to specified an
> input file which contain the command data and an output file for SDM
> response to be copied over.
>=20
> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
> ---
>  drivers/firmware/stratix10-svc.c              | 18 +++++++++++++
>  include/linux/firmware/intel/stratix10-smc.h  | 25 +++++++++++++++++++
>  .../firmware/intel/stratix10-svc-client.h     |  5 ++++
>  3 files changed, 48 insertions(+)
>=20
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix1=
0-
> svc.c
> index 2d674126160f..260695a8a9e6 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -37,6 +37,7 @@
>  #define SVC_NUM_CHANNEL				3
>  #define FPGA_CONFIG_DATA_CLAIM_TIMEOUT_MS	200
>  #define FPGA_CONFIG_STATUS_TIMEOUT_SEC		30
> +#define BYTE_TO_WORD_SIZE              4
>=20
>  /* stratix10 service layer clients */
>  #define STRATIX10_RSU				"stratix10-rsu"
> @@ -361,6 +362,13 @@ static void svc_thread_recv_status_ok(struct
> stratix10_svc_data *p_data,
>  		cb_data->kaddr2 =3D svc_pa_to_va(res.a2);
>  		cb_data->kaddr3 =3D &res.a3;
>  		break;
> +	case COMMAND_MBOX_SEND_CMD:
> +		cb_data->status =3D BIT(SVC_STATUS_OK);
> +		cb_data->kaddr1 =3D &res.a1;
> +		/* SDM return size in u8. Convert size to u32 word */
> +		res.a2 =3D res.a2 * BYTE_TO_WORD_SIZE;
> +		cb_data->kaddr2 =3D &res.a2;
> +		break;
>  	default:
>  		pr_warn("it shouldn't happen\n");
>  		break;
> @@ -534,6 +542,15 @@ static int svc_normal_to_secure_thread(void *data)
>  			a1 =3D 0;
>  			a2 =3D 0;
>  			break;
> +		case COMMAND_MBOX_SEND_CMD:
> +			a0 =3D INTEL_SIP_SMC_MBOX_SEND_CMD;
> +			a1 =3D pdata->arg[0];
> +			a2 =3D (unsigned long)pdata->paddr;
> +			a3 =3D (unsigned long)pdata->size /
> BYTE_TO_WORD_SIZE;
> +			a4 =3D pdata->arg[1];
> +			a5 =3D (unsigned long)pdata->paddr_output;
> +			a6 =3D (unsigned long)pdata->size_output /
> BYTE_TO_WORD_SIZE;
> +			break;
>  		default:
>  			pr_warn("it shouldn't happen\n");
>  			break;
> @@ -597,6 +614,7 @@ static int svc_normal_to_secure_thread(void *data)
>  			case COMMAND_FCS_DATA_ENCRYPTION:
>  			case COMMAND_FCS_DATA_DECRYPTION:
>  			case COMMAND_FCS_RANDOM_NUMBER_GEN:
> +			case COMMAND_MBOX_SEND_CMD:
>  				cbdata->status =3D
> BIT(SVC_STATUS_INVALID_PARAM);
>  				cbdata->kaddr1 =3D NULL;
>  				cbdata->kaddr2 =3D NULL;
> diff --git a/include/linux/firmware/intel/stratix10-smc.h
> b/include/linux/firmware/intel/stratix10-smc.h
> index a718f853d457..ee80ca4bb0d0 100644
> --- a/include/linux/firmware/intel/stratix10-smc.h
> +++ b/include/linux/firmware/intel/stratix10-smc.h
> @@ -466,6 +466,31 @@
> INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_
> COMPLETED_WRITE)
>  #define INTEL_SIP_SMC_FIRMWARE_VERSION \
>=20
> INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FIRMWARE_VE
> RSION)
>=20
> +/**
> + * SMC call protocol for Mailbox, starting FUNCID from 60
> + *
> + * Call register usage:
> + * a0 INTEL_SIP_SMC_MBOX_SEND_CMD
> + * a1 mailbox command code
> + * a2 physical address that contain mailbox command data (not include
> +header)
> + * a3 mailbox command data size in word
> + * a4 set to 0 for CASUAL, set to 1 for URGENT
> + * a5 physical address for secure firmware to put response data
> + *    (not include header)
> + * a6 maximum size in word of physical address to store response data
> + * a7 not used
> + *
> + * Return status
> + * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_REJECTED or
> + *    INTEL_SIP_SMC_STATUS_ERROR
> + * a1 mailbox error code
> + * a2 response data length in word
> + * a3 not used
> + */
> +#define INTEL_SIP_SMC_FUNCID_MBOX_SEND_CMD 60
> +	#define INTEL_SIP_SMC_MBOX_SEND_CMD \
> +
> 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_MBOX_
> SEND_CMD)
> +
>  /**
>   * Request INTEL_SIP_SMC_SVC_VERSION
>   *
> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h
> b/include/linux/firmware/intel/stratix10-svc-client.h
> index 0c16037fd08d..60ed82112680 100644
> --- a/include/linux/firmware/intel/stratix10-svc-client.h
> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
> @@ -118,6 +118,9 @@ struct stratix10_svc_chan;
>   * @COMMAND_SMC_SVC_VERSION: Non-mailbox SMC SVC API Version,
>   * return status is SVC_STATUS_OK
>   *
> + * @COMMAND_MBOX_SEND_CMD: send generic mailbox command,
> return status
> + is
> + * SVC_STATUS_OK or SVC_STATUS_ERROR
> + *
>   * @COMMAND_RSU_DCMF_STATUS: query firmware for the DCMF status
>   * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
>   *
> @@ -164,6 +167,8 @@ enum stratix10_svc_command_code {
>  	COMMAND_FCS_RANDOM_NUMBER_GEN,
>  	/* for general status poll */
>  	COMMAND_POLL_SERVICE_STATUS =3D 40,
> +	/* for generic mailbox send command */
> +	COMMAND_MBOX_SEND_CMD =3D 100,
>  	/* Non-mailbox SMC Call */
>  	COMMAND_SMC_SVC_VERSION =3D 200,
>  };
> --
> 2.25.1

