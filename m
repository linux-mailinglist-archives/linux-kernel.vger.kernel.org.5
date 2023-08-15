Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE45E77D5CC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbjHOWKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238494AbjHOWKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:10:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1F91FEC;
        Tue, 15 Aug 2023 15:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692137404; x=1723673404;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yYtcy0I8hTeAzG8jrtDuYqyMjearmyqSj+228Q307Og=;
  b=Dyw6ky6g+mFFQYttXUtvq+Zkw5dXr4XV/7hWogWqO+h422PxBfluJNdY
   R9NZ2DeyYraTYMeKdXohFqy8UVQACdkQk/eNotVzOKkioLV1hHALDRNkf
   R8Ho4qof+4EHuxeMeOf37AG8hLmPS9rfodoBqJB/NiD+7jK4C7FuBXzzn
   svi8NK87Ka2hTowi41SrF2LeVrl7nz7kON5iFzKRnfnwSp923DUBd6oap
   EybImfx2cBQxB48JV9bnUrMqP912HiQqRqYS+lckh6INkz3A+7ACl2pTI
   cAgBqIoQGgMYwD3o8fdydH8WokEC7gcitvKeSTmJWH6TXJzr8j8gAkUnR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436287422"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="436287422"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 15:09:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="823997548"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="823997548"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Aug 2023 15:09:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 15:09:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 15:09:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 15:09:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 15:09:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofDIuVoLhW6gQrsmqpFbEWKzEQ2DksiN1Xw4w1WLADETJYyIq2AvVaXHNE1RTgc5Z10YPvnHmyck0T+WUKDK+E/d/D6iWuFmUx20/8BB00hEMX+Cq3i/LC0nNfowtObOKCpcE2szVSWQtRGnaej81qycQBIhs2Azq+CQb0WV0yf9KuxHWhwL0PJPhiGJ/RvQgWLhYWq8aAbkth75I9BITz+RSutPKuMyO8Yxk4EGzQtz9Gc+HQYwIKEbFPLqIPJjtzQP5OBV9Pu3tmURrkkT8l3tx5k62XlhfXknR9KTyNk3kFh3CYhpn9RMLAi0WxbwpUcwf1XilXqBWi0Z+3oBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYtcy0I8hTeAzG8jrtDuYqyMjearmyqSj+228Q307Og=;
 b=htIq5D5nRf48c4yO8BGceLZHkFcE9d/Rj5ZdATW7JIm1lboCEBUpwmxk3VHWQMzFDqUM5vSQ+7itVvpzZMVQ1ESn0s3hQf1tdt8Zm7dPtOm5Y+SjZ3TSCpGRF+bahCoz8LkcS3N927edbHvMSAZq3qgsyaAF96TXevl0mkbrqeVchd6s4gG/LqAm0z82ZWpTTI8jYx8DTkd2c2Tw0DQvoRMIjRkIuA2UmYp4Vx31XJuGTsRvt5n+yJbI/yat8t68RytDWs0jVTH612Ei6SqRbcDQmP+oF9wjT3f3jbiZ7MKjedpo/70TCMMZ4N8ecRdXdizrFe3vS9iVLbA1OXCx5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by IA1PR11MB7753.namprd11.prod.outlook.com (2603:10b6:208:421::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 22:09:15 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::da4:d67d:40ed:9786]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::da4:d67d:40ed:9786%4]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 22:09:15 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "bleung@chromium.org" <bleung@chromium.org>
CC:     "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>
Subject: RE: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
Thread-Topic: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
Thread-Index: AQHZuR/m4IKFgl1ovU6TI3vwoe4fN6/KvHFwgCFbT7A=
Date:   Tue, 15 Aug 2023 22:09:14 +0000
Message-ID: <MWHPR11MB0048351E2A2E742C4338153EA914A@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20230718024703.1013367-1-utkarsh.h.patel@intel.com>
 <20230718024703.1013367-2-utkarsh.h.patel@intel.com>
 <MWHPR11MB004898B3B175BAFC4A6327FEA905A@MWHPR11MB0048.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB004898B3B175BAFC4A6327FEA905A@MWHPR11MB0048.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0048:EE_|IA1PR11MB7753:EE_
x-ms-office365-filtering-correlation-id: 932a2828-fc8b-43cd-bd65-08db9ddc4347
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YHC39P6e/Hhj4YJhdJN/b7KkjVAH9Erc2QfvMxYjy9TFPRwPtQZIq1TeNAzqqDCbiTrIfR7vVpqV05mI6tkKr76TfE8pXRYegw9lYrkjI0oNu2hj4zjgfolcO1Vkss0PbkslmO3RlLqGUK9e2ivMH/FimWNYigO+OCuokWxc92X9sF/rLmyYDxzsplEF+p6SIb0tS47kCogZ9hoo0/elrCTQUwZnCVOvnnGd+sJ4DdVufCKqIvNsvkzTg9uG9H+Mr1LvOZaILq53ozCfxYJCkIMA9fjPcc0pWHXnvFxChScCHOBSahkdf7EvEMlETeLuKoS8rQkSZzMRcX7KWWDkpDQLVplKM4eTfPvyYjboR8+LxioYIiIUMDzRTOc46LTKJ0Yk/2RQgM27pP4iYVXOoBbS+qydMho63cJ2MdpCKkVKbUM9RBV/tWEpw+9ZRKD2Q1Aos0vc1ui/oe7Z59Zd3dak7oF67U4Og91DgrXBW2STNg1+gonce6rdiwnrObP7AhMtCslC/otXrquOdDA0Cha9/0iZws7dfjfqD7BZfw/4GA0znrbrWzgvEyyDZPsI7/BFm7CBYs5akGXr3Y/LbOGwH7pGBY+24EyAYwHEWnhYDXl+jrksdxywnj9dcfmN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39860400002)(1800799009)(186009)(451199024)(110136005)(4744005)(76116006)(66446008)(66476007)(66946007)(7696005)(41300700001)(64756008)(4326008)(86362001)(53546011)(66556008)(8676002)(52536014)(8936002)(26005)(6506007)(5660300002)(71200400001)(2906002)(9686003)(38070700005)(316002)(478600001)(38100700002)(33656002)(83380400001)(122000001)(82960400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bz25+O6Vx3p4VFyXZ+XC+Yc/8abOZMXUFXx7zBD8FqG2QfZLJM7gpTV/870j?=
 =?us-ascii?Q?9UfUlnx3lcHtVGjDHXepLS12iKvYJDR744YskLd13B35Das4eZxtnJB31Elj?=
 =?us-ascii?Q?Tlidw9Rg4X1U8EMez6rvSf3GFQalrT4QKgy3EVuQZuEDCBduGi8TaB9g8imR?=
 =?us-ascii?Q?MEmxZPetLLZzKdbS+iJmnjGEIiQPLnjaNtAe6rhBstrV2JP46XUggkQnyOMV?=
 =?us-ascii?Q?Ud4lXrmQGkwezi63jB+Qte+6/R7qJUlaZfGWlom8ugRMUvlMflyspvsCjEAD?=
 =?us-ascii?Q?HMIvcinDxPEmOSmYVwYqcHSFPnKLDGZmm8D9tZruOIj2n4SgaOkkYORFVKKB?=
 =?us-ascii?Q?vXoD9o06p2RvR0RLahzO6dA+vrO9dy45goIAtm8xPCqBgO8LBFQohqq08bfS?=
 =?us-ascii?Q?/phUyYpGvIBvjAiVdjnnCkAsdt4LttOlLYHHrXdob27TMJaRFgjbdTfsBm6G?=
 =?us-ascii?Q?AlexEXKDbX5KUJuKfVGgkXDNltk3OXTjwKjEGT6k5aTPw2CjktW7SQLUMMBy?=
 =?us-ascii?Q?HxDiDUjRJPNsBRHbtsY7ptxF/Mtifv9ThDWR3qN+5EjTN4iwIUtUEZF4sPu4?=
 =?us-ascii?Q?PDNVofRJvzqr1nENFZyo9/cgWJcrQTqBDtfb/26rHdlccUSn/LCNG1MMZi66?=
 =?us-ascii?Q?tjnhagVv/YqYeqUbZm9qvMKNuP6VkJeFoqQwhBn1DVI0vGJtWCDpmusikmvf?=
 =?us-ascii?Q?v9Ejh/qXfuxpL7PY3j3jdYvZUQoKdGGcFBxnz9KVAG/IQTZn73EMRoZysLK1?=
 =?us-ascii?Q?Gna6KUZQV53xKkDapQAIZ6RbA+OzbkKelBuzbRXB2NAkakXtaVp8zKDBpt7T?=
 =?us-ascii?Q?109M8JTRk7FeQPev/QESF0nShhINzv9CwvxV/8x8fLinN+rMrge4rWKmSkPr?=
 =?us-ascii?Q?wjwdlGXxBB5On+mcIKKAsEkEFLK+9jvcz9bdoVEbyklduM3XueTDPqzRgNHW?=
 =?us-ascii?Q?fE4Xqgx9XP3y343zF9Y0fv9CckKGm8OQT7OZGnJ2DgMWHWs2Ek81h9dmi6wh?=
 =?us-ascii?Q?ySfp+wz/zUj80xlc5yUZ761Wm3AFsvc8CKHPwewGoL4v0+2Iys8QpsHLzqWH?=
 =?us-ascii?Q?/mSlZZqWTNw6nlrzjfGDBRcdqRGVlikJjX1UDiCP9KLgfYD1iSzI2QrdkvG6?=
 =?us-ascii?Q?/oMFx/Mq95Q4VVdkhVwXedM5eVUduD1tbHPZ4VwsiZIF6E/o7WSKsq9s8bHX?=
 =?us-ascii?Q?/c7H3okZwOA3Zm7YYWpqLRPcDvs9p2UevtskdjeiRmWbpqIc4aiSXOFcQ5Bp?=
 =?us-ascii?Q?BMnj3M0IoRGZC2Njq9bbAkB2Vjxh+GGEbPIPUSADCvrdOYlZkP7NUZ+Z0ShC?=
 =?us-ascii?Q?zAWKS8M/b2+lGHqYFuwNvSc62ydDJbVxS82L1jKIGrWMENsiouWLEpRj1sfO?=
 =?us-ascii?Q?Qvpl5JjyblfU5Sf4/b31Pk2o+kAh3jHD6cJNEULzeOModFZxs7+OaC5S1n2v?=
 =?us-ascii?Q?ta+CCxXJlHRJkmtYxkX8+CVUpHMku6BORZGSOOoF6079OksurdXFOu/gn2Ja?=
 =?us-ascii?Q?caR2B3Xh4l92hqtprT3klutlfnYDjXViPA/6aTxsJ4TBQE8P/I7doZlM8N/p?=
 =?us-ascii?Q?GrPVwS2seTwBeedJZFmc9EVAy19zxOxwJJ8vcl8+L3T3Y/jdeAC8b6HZOEi+?=
 =?us-ascii?Q?zQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932a2828-fc8b-43cd-bd65-08db9ddc4347
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 22:09:14.9671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBOzH4LGTb5l2X3xZn1DpUhGLGphwysXOQisoX1uDYVPZ5rMGSQrRAeaFtny9mRiRtKjhW6C2dHYIHOVYeu1Kb5XuriUvEbWFJOc5NPZYq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7753
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant and Benson,

Could you please help review?

> > -----Original Message-----
> > From: Patel, Utkarsh H <utkarsh.h.patel@intel.com>
> > Sent: Monday, July 17, 2023 7:47 PM
> > To: linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> > heikki.krogerus@linux.intel.com; pmalani@chromium.org;
> > bleung@chromium.org
> > Cc: Patel, Utkarsh H <utkarsh.h.patel@intel.com>
> > Subject: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Configure
> > Retimer cable type
> >
> > Connector class driver only configure cable type active or passive.
> > Configure if the cable type is retimer or redriver with this change.
> > This detail will be provided as a part of cable discover mode VDO.
> >
> > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> > ---
> > Changes in v4:
> > - Removed local variables and used inline assignemtns.
> > - Added details about return values in cros_typec_get_cable_vdo.

Sincerely,
Utkarsh Patel.
