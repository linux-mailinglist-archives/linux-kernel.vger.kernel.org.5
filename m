Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8452875BC51
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 04:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjGUCeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 22:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjGUCeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 22:34:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319372736
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 19:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689906848; x=1721442848;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=trj0RCTrCFGCnDSHGgK62O0EJj+kiaiwhxiN36z0Z3Y=;
  b=gdidqJdY0NQsEYtj08MV1UEfpmefrYAJOvHtXU7WSrzMX0XpI4ogvF0p
   0AMursjqyqIFrqB00+bvN/kOVjf3ANO1kMDCHpqhajoslWaeP3rZHw8FR
   MwAGiptQHL6Kkh3QDwn56xzbnHdP1RUmPxvKJEZoVJ8Xuz310lmUcwV2I
   wW1qb8kr/RLFOsKTYqTNir0c7eXhCX4BqJuyxywtgYoZPHT3mC2lSkJQ3
   n6R2V1R7hdEd50HAeOkgwffeqt5bOH+JKnVv/nEQwSaeKoe3DS5XtRc89
   JuvSYfp+LoRtt+hTp5KTrhjFpDlEbfsejpoWt5fps2U/BSzjDFrwj1vFJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="430717498"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="430717498"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 19:34:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="724684691"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="724684691"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 20 Jul 2023 19:34:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 19:34:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 19:34:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 19:34:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KX3o5Emoc3el2BuqFJ1xsLZBl7+slTlDeFaYWQRg/rHNwcHg6k+aO/QwZ/TwZxpHhfr8MNhqc33B3a9AapxfDKZhqIvnzOjPgpn9SgIrMzL9a6eetQBbOUpPE9XunMlrP+sUPE3g0LmhMpTR3BWo61V4Hc1fRcSSS8fX++AvWc0KdETxDYJFyO4pNpI6XtKhajsizLz0DyN2f71q+VfNwC3/hObOmVh9TgLOmrnFLJN+6MKBoirRXnuDQIhzeCOvA4+f0jaFIvGrz6CfdZt+Rzp+nl3TV6jcMuQ6AWYEPzaZFFjYCu0uudR/x5svHl3g1tjLyD4m8V02Lt4E9nzShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6pR4aq5Tzkqfxjlh9fIN3hFN8hf3IDsb8bx2dJl3ik=;
 b=HhbSlpVWJQBiRaTlLn0nvTq0FX+UQkUzrKVOw6n9Sj4dddz0pvEvwXQXy0wJc3I8TJ3sZ/MpnS/UYLhDPv6NamJ+jE+pay9L9lVN1HqsHa4m2ueNPCXIL6/fKd4Mt7XLR2hvQFSxTdp8tE/0bC0rbBVubOHSzW/k7dMWBOP464mncdkSpLueM2iP7kWSDufgOpC8xSYRAFvDAwGZsKOSplBBymKhZvx4MTh1yQNOLI1dq5VgXRwQv26O5goQ0h9MPeV1j7O7LuB5/MSAQWFP2UZQY7zNVz+nbQYRGedC/pRZcK2UlHcldHMeUnjGCLWPXgdOHB/YThl0OYPN2FO0Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5673.namprd11.prod.outlook.com (2603:10b6:510:d6::7)
 by CY5PR11MB6115.namprd11.prod.outlook.com (2603:10b6:930:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 02:34:05 +0000
Received: from PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::c3f:2546:872c:871b]) by PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::c3f:2546:872c:871b%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 02:34:05 +0000
From:   "Lee, Kah Jing" <kah.jing.lee@intel.com>
To:     "dinguyen@kernel.org" <dinguyen@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bacrau, Radu" <radu.bacrau@intel.com>,
        "Ang, Tien Sung" <tien.sung.ang@intel.com>
Subject: RE: [PATCH v3 2/2] firmware: stratix10-rsu: query spt addresses
Thread-Topic: [PATCH v3 2/2] firmware: stratix10-rsu: query spt addresses
Thread-Index: AQHZuFE64Sg6wNtFyECl2C38OIxlC6/DhukQ
Date:   Fri, 21 Jul 2023 02:34:05 +0000
Message-ID: <PH0PR11MB56738D1373C7B2FEA7D947A9CB3FA@PH0PR11MB5673.namprd11.prod.outlook.com>
References: <cover.1689524302.git.kah.jing.lee@intel.com>
 <e640da0517b1d0de79013fdf4964ea34475f2238.1689524302.git.kah.jing.lee@intel.com>
In-Reply-To: <e640da0517b1d0de79013fdf4964ea34475f2238.1689524302.git.kah.jing.lee@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5673:EE_|CY5PR11MB6115:EE_
x-ms-office365-filtering-correlation-id: 1703c1fd-df2d-45da-b29f-08db8992f3bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1oDW8WdfVAFl14WO+XR8/OdYhhBH6jThBzJmupyZqOuaYzQfXe/Wtg9J7PmGcTiLAsM5qppwpl88vXDmn65e1/oLdlGMuB5Qli3uMd8xWdYK5X2wtOGAIRSrCkXUNtltXhzoo34g/DkpAzDV5HmJ/J4omvIHpjsbUc6xv18aFGCT+qcY7gIyyr9IrOfFEknUVnmH8rfImw/3uPrUAsU7GEWaPTZkv4WpnJsz5eAK8YXYUKaY/Z6Lo8IV0LvLXVxflmsn/9j44dP36e04+gpt5XwZ16d40RMtLNKQuQkyfYwZYAw79qyQ5F3sjGuWWKhebOf/9bWJdMFxrQExvnOiC+te2DcK40hzFlWvDVw5707mVNT1p5hcWvZZDmYIzfNLMeMF8ZnZOsfabUUmU/b3m54dGC15fHJkwW6No3n2LvVuZc2yhWPXgQkC4ATJ+JBPyl5v1m5H4a5M3AqZB7xYWmJoAgC7ltLYcmYz6pxeZaKfVGmA10AKLxOwuSEaI+4h6soN2vLT/E75V6gHg9iGQy//1xB5NMddB4ynVpUmd/xo97T222N31pLUqOkY7AuV2ap1n+oXBKVuP+rY3a78HssVoyKGsfZuQA51hUTZ3LkHf+obDaDFiNGI6zu8iXmT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199021)(2906002)(41300700001)(316002)(5660300002)(52536014)(38070700005)(8936002)(8676002)(33656002)(55016003)(86362001)(478600001)(71200400001)(54906003)(122000001)(186003)(53546011)(6506007)(26005)(82960400001)(107886003)(7696005)(9686003)(38100700002)(66476007)(64756008)(66446008)(76116006)(66946007)(4326008)(66556008)(6916009)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kawlr0rDRf6pTkksnBOjJtVfgHHJ7y/BIrQ7v9/JcnM0xlCNx2WoJNNJuKCt?=
 =?us-ascii?Q?8lYrZ7XnKWMzYOvzdjwQPuSZuCmi048uh3axLGzQpmvjK+rAlJS1K/MZS89Z?=
 =?us-ascii?Q?RFQEpoJE63YzMElTrWgTca92W1aT6lkXWcYtiGQMMjnYAQNTHrdceuPhUWlA?=
 =?us-ascii?Q?oTPuY3xk2j8/CAvR7jQgbiaDQtCNVeWSVtjCkkIv26XaTiQRD16u8ge80IYA?=
 =?us-ascii?Q?kSFBOm47w8zX1BDF/BCkajg7yDIvcdP6EGR2gKkfos2f6jcRgV7uq0Y58daN?=
 =?us-ascii?Q?LYwpCpTAh0pj95dT7SGnd7V7amSrwJ4iMlId0qiPjEMMQxaSbQYslT0i8+Ys?=
 =?us-ascii?Q?yZsyEX95zE1usCftHMtJUHQjJQT66dfG8jfRlxytC550dWEL+xyFy5UHreWo?=
 =?us-ascii?Q?3y7GFocaxQSKrx6NLvMw2ykbvdXp6W6vSv0BOovYS4sylZMWw3O6eZ4e5zou?=
 =?us-ascii?Q?lOC6EB8JO8wrCtakxKj+JVftNQOSN9PLAEX8PdPvguKziQdHWeA80cC9Q+jF?=
 =?us-ascii?Q?XwkCZ0kz/WS1NEvW8CCyBFDB+ra93/cDWHw8Bp2EjUjbzW+zNhthXizyjCEU?=
 =?us-ascii?Q?EzbB87pwAWKyI48jSJqffECzMRb+A4Y8dW+zrAtVmPCm7WNS1DJknoEP8HWx?=
 =?us-ascii?Q?UxGL0PUqw6R/8g8+ZoM5x2f+Fa3+jjM8FSf9hc0DFKQ2M5/qUzNSQrw/VJcK?=
 =?us-ascii?Q?hCdG2Xo09U0KcRdx9bQ4GDw7W58Os7S9s2OKYbgHllpwSGZPntT0yrIVm+wv?=
 =?us-ascii?Q?fcag9G+wDYu3Q7ir7UbY3rBeU8z62cDeE2SShleyaaPoMvlR+J9qz67nGlOp?=
 =?us-ascii?Q?DEWXS+r9+7Ihuq3xMIFylGAS5c+b3fJ6af/yo5+bWdvOsCnWPLKkDfZxr886?=
 =?us-ascii?Q?tyRKeiffgKVKJ74+eV9GCJVqnHXSjZHItmvLz8S1bXCzY4kZjt1hhegOBx/A?=
 =?us-ascii?Q?bxmtUayT9N9qsTxoZED15Xsq/qIgTuTMrVLzI8UuebVdOBfIV7JcE7U7G4KX?=
 =?us-ascii?Q?zWIo/EBo5Nvmp/Z6HFQ4m2akZjs5vcixl+SRMlKQdDqcMSwSLE7MQo61lF8O?=
 =?us-ascii?Q?htn0qK5mhkvgvlfW5ytUFu+yM0Y5nJoLY7qR5Cw3e1qdEod+lzVTpsRFTZ/w?=
 =?us-ascii?Q?5cVxmsVtebzp6nte4YWVfdnRwot+OaO7LE0q9bwhmNAAq8AdE4IQ+WRPNmhs?=
 =?us-ascii?Q?bM59tLXPNOyWI0PLtpA6/ifANW3pdEe+vqz0CzJ7O1w60eIw6LiYz2uA9FRi?=
 =?us-ascii?Q?laZiiC3sX36D4ARjCyvYMgJF6r0ocFV0eI+/1/v9fYnMTmNF1ayLD6C2okkb?=
 =?us-ascii?Q?zBAd2V//8vmJkFz2AWLj+eNM5rpjOx0TlzNKWzvQtNwRNr/Ppl1Pp0AgfOxV?=
 =?us-ascii?Q?9VJgT1Usm4M8sun/SNVV8fa3yzZP3a1XA87EFGJHjO1+SQ9lr5AUWoSJvChQ?=
 =?us-ascii?Q?S7rvd0SDZlejfEiTh+HISCPbSYpmDnLtczPu6YUozZyvcIXP5GDQTxmIa6Pb?=
 =?us-ascii?Q?tyZ0E/uyPtFgy/9ybqZIx7Y1dGaw141PI5piEjLRV8kFtkQ9AqAxZPkcLp3c?=
 =?us-ascii?Q?LuJ9smxweruF/ccPrhQxqQIvlhLblEoDPV7O75wE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1703c1fd-df2d-45da-b29f-08db8992f3bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 02:34:05.0414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6MWMSUd29g4I3ZebIsMAueG7aB4rdJGbgMqrkYrJKJ61/VN3MFSAZ8FrQipebas2dZLiE9wD2JbjwlC5cvMY4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6115
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
> Ang, Tien Sung <tien.sung.ang@intel.com>; Lee, Kah Jing
> <kah.jing.lee@intel.com>
> Subject: [PATCH v3 2/2] firmware: stratix10-rsu: query spt addresses
>=20
> From: Radu Bacrau <radu.bacrau@intel.com>
>=20
> Extend Intel Remote System Update (RSU) driver to get SPT (Sub-Partition
> Table) addresses. The query SPT address can be used to determine if the
> RSU QSPI layout is 32kB or 64kB aligned.
> The alignment can be determined by minus the upper with the lower of the
> SPT addresses.
>=20
> This patch depends on patch:
> firmware: stratix10-svc: Generic Mailbox Command
>=20
> Signed-off-by: Radu Bacrau <radu.bacrau@intel.com>
> Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
> ---
>  drivers/firmware/stratix10-rsu.c | 100
> ++++++++++++++++++++++++++++++-
>  1 file changed, 99 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix1=
0-
> rsu.c
> index e51c95f8d445..af71f921be5f 100644
> --- a/drivers/firmware/stratix10-rsu.c
> +++ b/drivers/firmware/stratix10-rsu.c
> @@ -34,6 +34,10 @@
>  #define INVALID_RETRY_COUNTER		0xFF
>  #define INVALID_DCMF_VERSION		0xFF
>  #define INVALID_DCMF_STATUS		0xFFFFFFFF
> +#define INVALID_SPT_ADDRESS		0x0
> +
> +#define RSU_GET_SPT_CMD			0x5A
> +#define RSU_GET_SPT_RESP_LEN		(4 * sizeof(unsigned int))
>=20
>  typedef void (*rsu_callback)(struct stratix10_svc_client *client,
>  			     struct stratix10_svc_cb_data *data); @@ -59,6
> +63,9 @@ typedef void (*rsu_callback)(struct stratix10_svc_client *client=
,
>   * @dcmf_status.dcmf3: dcmf3 status
>   * @retry_counter: the current image's retry counter
>   * @max_retry: the preset max retry value
> + * @spt0_address: address of spt0
> + * @spt1_address: address of spt1
> + * @get_spt_response_buf: response from sdm for get_spt command
>   */
>  struct stratix10_rsu_priv {
>  	struct stratix10_svc_chan *chan;
> @@ -90,6 +97,11 @@ struct stratix10_rsu_priv {
>=20
>  	unsigned int retry_counter;
>  	unsigned int max_retry;
> +
> +	unsigned long spt0_address;
> +	unsigned long spt1_address;
> +
> +	unsigned int *get_spt_response_buf;
>  };
>=20
>  /**
> @@ -259,6 +271,36 @@ static void rsu_dcmf_status_callback(struct
> stratix10_svc_client *client,
>  	complete(&priv->completion);
>  }
>=20
> +static void rsu_get_spt_callback(struct stratix10_svc_client *client,
> +				     struct stratix10_svc_cb_data *data) {
> +	struct stratix10_rsu_priv *priv =3D client->priv;
> +	unsigned long *mbox_err =3D (unsigned long *)data->kaddr1;
> +	unsigned long *resp_len =3D (unsigned long *)data->kaddr2;
> +
> +	if ((data->status !=3D BIT(SVC_STATUS_OK)) || (*mbox_err) ||
> +	    (*resp_len !=3D RSU_GET_SPT_RESP_LEN))
> +		goto error;
> +
> +	priv->spt0_address =3D priv->get_spt_response_buf[0];
> +	priv->spt0_address <<=3D 32;
> +	priv->spt0_address |=3D priv->get_spt_response_buf[1];
> +
> +	priv->spt1_address =3D priv->get_spt_response_buf[2];
> +	priv->spt1_address <<=3D 32;
> +	priv->spt1_address |=3D priv->get_spt_response_buf[3];
> +
> +	goto complete;
> +
> +error:
> +	dev_err(client->dev, "failed to get SPTs\n");
> +
> +complete:
> +	stratix10_svc_free_memory(priv->chan, priv-
> >get_spt_response_buf);
> +	priv->get_spt_response_buf =3D NULL;
> +	complete(&priv->completion);
> +}
> +
>  /**
>   * rsu_send_msg() - send a message to Intel service layer
>   * @priv: pointer to rsu private data
> @@ -288,6 +330,14 @@ static int rsu_send_msg(struct stratix10_rsu_priv
> *priv,
>  	if (arg)
>  		msg.arg[0] =3D arg;
>=20
> +	if (command =3D=3D COMMAND_MBOX_SEND_CMD) {
> +		msg.arg[1] =3D 0;
> +		msg.payload =3D NULL;
> +		msg.payload_length =3D 0;
> +		msg.payload_output =3D priv->get_spt_response_buf;
> +		msg.payload_length_output =3D RSU_GET_SPT_RESP_LEN;
> +	}
> +
>  	ret =3D stratix10_svc_send(priv->chan, &msg);
>  	if (ret < 0)
>  		goto status_done;
> @@ -572,6 +622,34 @@ static ssize_t notify_store(struct device *dev,
>  	return count;
>  }
>=20
> +static ssize_t spt0_address_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf) {
> +	struct stratix10_rsu_priv *priv =3D dev_get_drvdata(dev);
> +
> +	if (!priv)
> +		return -ENODEV;
> +
> +	if (priv->spt0_address =3D=3D INVALID_SPT_ADDRESS)
> +		return -EIO;
> +
> +	return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt0_address); }
> +
> +static ssize_t spt1_address_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf) {
> +	struct stratix10_rsu_priv *priv =3D dev_get_drvdata(dev);
> +
> +	if (!priv)
> +		return -ENODEV;
> +
> +	if (priv->spt1_address =3D=3D INVALID_SPT_ADDRESS)
> +		return -EIO;
> +
> +	return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt1_address); }
> +
>  static DEVICE_ATTR_RO(current_image);
>  static DEVICE_ATTR_RO(fail_image);
>  static DEVICE_ATTR_RO(state);
> @@ -590,6 +668,8 @@ static DEVICE_ATTR_RO(dcmf2_status);  static
> DEVICE_ATTR_RO(dcmf3_status);  static DEVICE_ATTR_WO(reboot_image);
> static DEVICE_ATTR_WO(notify);
> +static DEVICE_ATTR_RO(spt0_address);
> +static DEVICE_ATTR_RO(spt1_address);
>=20
>  static struct attribute *rsu_attrs[] =3D {
>  	&dev_attr_current_image.attr,
> @@ -610,6 +690,8 @@ static struct attribute *rsu_attrs[] =3D {
>  	&dev_attr_dcmf3_status.attr,
>  	&dev_attr_reboot_image.attr,
>  	&dev_attr_notify.attr,
> +	&dev_attr_spt0_address.attr,
> +	&dev_attr_spt1_address.attr,
>  	NULL
>  };
>=20
> @@ -639,11 +721,13 @@ static int stratix10_rsu_probe(struct
> platform_device *pdev)
>  	priv->dcmf_version.dcmf1 =3D INVALID_DCMF_VERSION;
>  	priv->dcmf_version.dcmf2 =3D INVALID_DCMF_VERSION;
>  	priv->dcmf_version.dcmf3 =3D INVALID_DCMF_VERSION;
> -	priv->max_retry =3D INVALID_RETRY_COUNTER;
>  	priv->dcmf_status.dcmf0 =3D INVALID_DCMF_STATUS;
>  	priv->dcmf_status.dcmf1 =3D INVALID_DCMF_STATUS;
>  	priv->dcmf_status.dcmf2 =3D INVALID_DCMF_STATUS;
>  	priv->dcmf_status.dcmf3 =3D INVALID_DCMF_STATUS;
> +	priv->max_retry =3D INVALID_RETRY_COUNTER;
> +	priv->spt0_address =3D INVALID_SPT_ADDRESS;
> +	priv->spt1_address =3D INVALID_SPT_ADDRESS;
>=20
>  	mutex_init(&priv->lock);
>  	priv->chan =3D stratix10_svc_request_channel_byname(&priv->client,
> @@ -693,6 +777,20 @@ static int stratix10_rsu_probe(struct platform_devic=
e
> *pdev)
>  		stratix10_svc_free_channel(priv->chan);
>  	}
>=20
> +	priv->get_spt_response_buf =3D
> +		stratix10_svc_allocate_memory(priv->chan,
> RSU_GET_SPT_RESP_LEN);
> +
> +	if (IS_ERR(priv->get_spt_response_buf)) {
> +		dev_err(dev, "failed to allocate get spt buffer\n");
> +	} else {
> +		ret =3D rsu_send_msg(priv, COMMAND_MBOX_SEND_CMD,
> +				RSU_GET_SPT_CMD, rsu_get_spt_callback);
> +		if (ret) {
> +			dev_err(dev, "Error, getting SPT table %i\n", ret);
> +			stratix10_svc_free_channel(priv->chan);
> +		}
> +	}
> +
>  	return ret;
>  }
>=20
> --
> 2.25.1

