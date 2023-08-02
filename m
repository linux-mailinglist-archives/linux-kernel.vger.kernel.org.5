Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCADE76C351
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 05:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjHBDHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 23:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjHBDG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 23:06:57 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DC1EC;
        Tue,  1 Aug 2023 20:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690945616; x=1722481616;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VdbY9viEmmNEyA62feM2hp05AxOS4gLQsjFActrG/rg=;
  b=nM4b2iw6lMbMe5DdStOwefBpIpbIlOtnSwPY7TnWGQqTbogfwv1umBld
   ZsxuVEAMGVhYMCY0LIff4l2v3LZQ9TIshSo1TPKkighy6YQ7lD3qs7h0n
   M3a3vQLSXKM9i//vyjh2pXvAoevc+eIyUTlhUcCTuV/uCS/Cgmc3LH8AY
   dW0Fu8C4Nx3Y2idXR1FspyA3sO1fEo27+5X4oFHVA1G34DtRDOidMq3lW
   dASgIRy8/ApYg8rbTtMFzYQLlUo73Hzu5h2/3KZbKOC9eY3paa3XdrHlI
   wmWWl56UrkAUH7mrQyZRJhuQDRj7of6nYC5WzKZDnCME6Rn0cZImar8Sy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="372195256"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="372195256"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 20:06:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="722709073"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="722709073"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 01 Aug 2023 20:06:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 20:06:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 20:06:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 20:06:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUZUAg8UtP+nDv4gVepOSkp6cB3TEDF8MkrpIxYVNHrSpmXj9TiH7XM/5F0t/CXU1aVL1d5hxZnfwA1yBn4DXXTdDzPG/1rGXnA8SMfz2Z+Ir6W1RT3semXHPsAR32qL5nTtpt84CmZjHedAkIeydMdCS38YXmvF4pgCzees4buJUuy+cm/3oZOpUY1VjSGWxYMR9v/X8iv82DFN5CHbpdpChS5DUAG2dP6BHFlnjLPlYshh54/JkkPplr7+BKUPe0Urv6bCobjJf3zfnhxBYU1nD/N3RhY8RIx//OFjxgJSLI2gtqgyL+CJaTthDqijdSAZ+POdd9Q4CRif0+3bGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM51G3uZXIaRApqOdWj5fYo+GT9yS17Tjd2IXvsD6Dk=;
 b=DU+Nk8rR1Go3tdYDedCLGoSeEhgaIITEDmabNLBdH92X0oHBYGGBNlLXSFiaJDLiFfXon3XRIpZi7NNNYh9rl29ae9rkXi8XFJKX3dDS50OYe7dVB6hzlQGezOVCqMefH8HE4H28Qjorb9FBLHMrRwHxoxsTVr77Xnb54RVddFbN67tvvvJ7ITp7O2NhVuEyuSxwnI+ymIZYeVTja/ZEOkwESRDBx2hsqen/eUueOccP1Yy1EecuaAJ8t2+F6Wltelg5Se2SLWb9Uxec7UnUPEgbYBRIu30Q26hAQXlzaqzOxZV47PUqIrtFB8Mc2My5myX2hYdiVbf2IKAW8Y9A2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3291.namprd11.prod.outlook.com (2603:10b6:5:d::10) by
 SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.45; Wed, 2 Aug 2023 03:06:51 +0000
Received: from DM6PR11MB3291.namprd11.prod.outlook.com
 ([fe80::cf83:5843:b3c9:10af]) by DM6PR11MB3291.namprd11.prod.outlook.com
 ([fe80::cf83:5843:b3c9:10af%6]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 03:06:51 +0000
From:   "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
To:     Conor Dooley <conor@kernel.org>
CC:     "Ng, Adrian Ho Yin" <adrian.ho.yin.ng@intel.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Turquette, Mike" <mturquette@baylibre.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "wen.ping.teh@intel.com" <wen.ping.teh@intel.com>
Subject: RE: [PATCH v2 3/5] dt-bindings: clock: add Intel Agilex5 clock
 manager
Thread-Topic: [PATCH v2 3/5] dt-bindings: clock: add Intel Agilex5 clock
 manager
Thread-Index: AQHZxBQYoDLOJHXuDEWKBojhTKBqcq/V7XmAgABmtRA=
Date:   Wed, 2 Aug 2023 03:06:51 +0000
Message-ID: <DM6PR11MB3291BD9E538528059D199EBCA20BA@DM6PR11MB3291.namprd11.prod.outlook.com>
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-4-niravkumar.l.rabara@intel.com>
 <20230801-handball-glorifier-e55d44a2b638@spud>
In-Reply-To: <20230801-handball-glorifier-e55d44a2b638@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3291:EE_|SA0PR11MB7160:EE_
x-ms-office365-filtering-correlation-id: 307e428c-a045-4d0b-3add-08db930584ed
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WqqITs+CWbfwxWtsy5wywdgJx5caXgn5tIwLwp2UJubej0NUaFbaBjLFqawapS/Dg5tWM3NThSKPtqHtba8+iad9OR+4hD6Ac2iPZWhUZpdNf82hl0wHc/cH4NwViA0pwISvOXpT0uuY6NYC9NobdhJUipOhkWqF9CqZnG24ZXj+k6GWvhHZbEZ6EcoexyJI2fB+3DEHrAlfG+sc+t4QaiJ/O/6GiG09hvo2pYIPvkWmqO+pP3IStg2RFN+WgF49fDX86nTykWzE0oBbHZUkAOcb1e5j8hmiBwDxyI8eihS2N06GeORs5X0JpYOVZA218pBdLt4adGhAqu+s3P7I4PW7d1qawYA6Gd5fl1qDcjO/GqGMeBiYiZeNI/JcPfSGgU0PU/Q3KAZACrT6YnslT+HhRHsboqPoWKOHIQPYQoVHhD3X/wH2EBjVhyPGEfVdCIllixYL7FalicKxKeg71amnNiY4QkFWsHa6R1WjEpaTKQKHQR7V/RaUSqQ8LANVA0wI3jjg/MzdI+2bGNi9ucyV7lOod5YJicDUNEob3ZRK14az2N+NejfsYxWiNCyPMw/y9ETFvrIdJzN6BeqJfczEujLQAwfDmgnWdybb3yizRB/d6d/tYbBp+wl2tvJO0goVbfjTWaVHjbUFkeUUQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3291.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(55016003)(186003)(9686003)(966005)(316002)(86362001)(122000001)(478600001)(54906003)(38100700002)(66946007)(76116006)(66446008)(66556008)(66476007)(33656002)(71200400001)(64756008)(7696005)(4326008)(6916009)(53546011)(26005)(82960400001)(6506007)(41300700001)(107886003)(8936002)(8676002)(38070700005)(7416002)(83380400001)(52536014)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6z8718pX6M0a3obiSYEoDAvNzz/Nh5jXEA/A4pB+vneXc+Q77uABuprxfHDi?=
 =?us-ascii?Q?N1h9pAC/6/tpvHgMQWVlk4iYJoXuE9RxTLHg7273tlawKqKbfwHfGtyEeQeI?=
 =?us-ascii?Q?RlQZrdF8uMI2j1iz3JohAL1Pnc0oQFL5bmb32r5gzOnmcifh/nRaNNTnrq7j?=
 =?us-ascii?Q?0IJNVsBOU0CYszg44C5EXMB7TlpH8UHjIFcFtTcZ7NdwF7FkDJmOPWbbobRE?=
 =?us-ascii?Q?Y25shWPz/l0P2VM6yK3EsINdCBRzFOvcDogVf9zf5lxIpmGPPjmKa/YiybL1?=
 =?us-ascii?Q?lyzqMa7wNoJJUyUcyrmjV//9gZutG5+qdW4J916arYoGwzSC7jdHFR7002nK?=
 =?us-ascii?Q?kQO3l/JrsyFe34v6qakMqwnONzH/ktHNC/kgls/fH8Ff5vduB97wKegxnaao?=
 =?us-ascii?Q?t22Q+Zl583BMfn67ftSZGl6yJ1mW+xEvrDkX34jPEqhCmp92vIDq4WpZskFn?=
 =?us-ascii?Q?Ku8GO7llC9HhPL2PEWl78b3dYju1rEfTO/c2WoYDTGismuy8IJX69sW1oqcz?=
 =?us-ascii?Q?ZmGVLINbn866bBHf4494AIOTg4ermd9FsH0Kd29+DuMI9+2CvPPJOO++jcTw?=
 =?us-ascii?Q?oBpLjqvWpy7bZPIy268liO/v0YT8n13PFGGbeFNFS61neylLWgrZ5nJt6dRM?=
 =?us-ascii?Q?5fLQsEVlsd1M0P6vxKp8HhfRBHt6+tjr1WftZ8QGUO+BR2eq5s4cT0F8yrAF?=
 =?us-ascii?Q?80C2UjVm28d5na6WQhC0esVggzHx29XrOurbyZcxUvpiWzWAsY84wUzerifj?=
 =?us-ascii?Q?C28Sue5JK9tTmoL7mCBF/0xAcSv1FaF6/SbE63LFC20/l8X89s3DcjSS/JTM?=
 =?us-ascii?Q?2XFYrzDcxZaz+RRjIvc22i6dRBHPqgktpCb7tltzySXNblnlotnplqzRGzZc?=
 =?us-ascii?Q?ShHHVZeprFN0qw10YlbWUsqHpbB4mQkeIBvMh6M0A45xlxxswKWqdaj1B+W/?=
 =?us-ascii?Q?4/Wf+9PmZbw/JmsMlSec/3PVJaWpXEr9VEXSbc9QumPuAyBt5moNpOVooFCk?=
 =?us-ascii?Q?lvfGvV3BCF7uKyb7Z85iguMBxzBE5bwSRYxiNX/Ms84rFO1/j2v6jYYg9Iac?=
 =?us-ascii?Q?hJzumrn55nEN+zRgCHm7IA/qyYFJQ9JG93tF7V2WCtYEMQ73uUo0VfiZ2q1P?=
 =?us-ascii?Q?2nA2qTkIy+YdzD/+lh6WUTOzaZ4YloV0J7Jtra2mqF5gfGGQyy1IZvuLa9MY?=
 =?us-ascii?Q?fW/IUv8iKRKQPLbsAyA6RDYaA0D5KHQk8sNwyFYJxcz6EYcd2U18aVIdYtm/?=
 =?us-ascii?Q?N0NKFk8BhtK3q+y1O/etvoQMw5CpRqXkz6Pmz9tO/4R698G0lo4OTJ0mvsF9?=
 =?us-ascii?Q?qbdTP99rl+RZ1xibbNdqEToKuTMqM8TqSVmTQYQEjsHujMVUI9lUfpVleJVc?=
 =?us-ascii?Q?/xFon03YsBEt2kFHj+Fwk2ZEKu8oZGDQh/WtsTzRqzvvaLatF/LEICNLXz0I?=
 =?us-ascii?Q?s7JSMNGZvrwc4JPaEsBAw96DVChxgeBcjjg2zebXeNVJ56zClIvcJ8Px9hwL?=
 =?us-ascii?Q?sbNnwiyMKHfGww8ypTTbk2wWIDqfMSwgiPVtJ/bGCr9e94NzWqIEyi6pWKvg?=
 =?us-ascii?Q?KFht5kvMTaHMb9MVOLehrIqZ4nuASmgBjLG4U/GLNJO9OXekce+1IRJzTI4A?=
 =?us-ascii?Q?sQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3291.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307e428c-a045-4d0b-3add-08db930584ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 03:06:51.6944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vGglsKfIe+82bCnar0+CfpjlJD4hro3qMYcG+etw7X4sMe05hEidv0Tx10ZIYaSLYLwsjEN1AauwMzYNSwUf+S5f+it/eZq43s2VF4Oh1jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7160
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Wednesday, 2 August, 2023 4:58 AM
> To: Rabara, Niravkumar L <niravkumar.l.rabara@intel.com>
> Cc: Ng, Adrian Ho Yin <adrian.ho.yin.ng@intel.com>; andrew@lunn.ch;
> conor+dt@kernel.org; devicetree@vger.kernel.org; dinguyen@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; linux-clk@vger.kernel.org; linux-
> kernel@vger.kernel.org; Turquette, Mike <mturquette@baylibre.com>;
> netdev@vger.kernel.org; p.zabel@pengutronix.de; richardcochran@gmail.com;
> robh+dt@kernel.org; sboyd@kernel.org; wen.ping.teh@intel.com
> Subject: Re: [PATCH v2 3/5] dt-bindings: clock: add Intel Agilex5 clock m=
anager
>=20
> On Tue, Aug 01, 2023 at 09:02:32AM +0800, niravkumar.l.rabara@intel.com
> wrote:
> > From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> >
> > Add clock ID definitions for Intel Agilex5 SoCFPGA.
> > The registers in Agilex5 handling the clock is named as clock manager.
> >
> > Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> > Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> > Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> > ---
> >  .../bindings/clock/intel,agilex5-clkmgr.yaml  |  41 +++++++
> > .../dt-bindings/clock/intel,agilex5-clkmgr.h  | 100 ++++++++++++++++++
> >  2 files changed, 141 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/clock/intel,agilex5-clkmgr.yaml
> >  create mode 100644 include/dt-bindings/clock/intel,agilex5-clkmgr.h
> >
> > diff --git
> > a/Documentation/devicetree/bindings/clock/intel,agilex5-clkmgr.yaml
> > b/Documentation/devicetree/bindings/clock/intel,agilex5-clkmgr.yaml
> > new file mode 100644
> > index 000000000000..60e57a9fb939
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/intel,agilex5-clkmgr.yam
> > +++ l
> > @@ -0,0 +1,41 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/intel,agilex5-clkmgr.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Intel SoCFPGA Agilex5 clock manager
> > +
> > +maintainers:
> > +  - Dinh Nguyen <dinguyen@kernel.org>
> > +
> > +description:
> > +  The Intel Agilex5 Clock Manager is an integrated clock controller,
> > +which
> > +  generates and supplies clock to all the modules.
> > +
> > +properties:
> > +  compatible:
> > +    const: intel,agilex5-clkmgr
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#clock-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
>=20
> > +  # Clock controller node:
>=20
> This comment seems utterly pointless.
> Otherwise this looks okay to me.
>=20
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Thanks,
> Conor.
>=20

Removed in [PATCH v3 3/5].=20

Thanks,
Nirav

> > +  - |
> > +    clkmgr: clock-controller@10d10000 {
> > +      compatible =3D "intel,agilex5-clkmgr";
> > +      reg =3D <0x10d10000 0x1000>;
> > +      #clock-cells =3D <1>;
> > +    };
> > +...
