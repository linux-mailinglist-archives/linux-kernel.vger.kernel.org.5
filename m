Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D127B7DA3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjJDLBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjJDLBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:01:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1B0BF;
        Wed,  4 Oct 2023 04:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696417297; x=1727953297;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xdC8rxBs/gYl1epEexxiGMIUxzGsgYnCAKlyDM/2tZI=;
  b=R1ViZXdBaE71qfIfl149Gp9gfRTxT+Yxeg/PanOmrrwfiYwxOmzOGkpw
   uQ7tzAu+ldp9c4waxlEkdF6rrrOaKzuMZBkmsACDcEV+Yt8VDCWZVZeUg
   zgmXlowhaTyWLOTC4l3jMesqKCZbTvaAeP7+AZDb8CA1O2RmiCZdAocHr
   LiBAYbgJauLZMH8LvFV2rpdxnovx+VwY3d9uGVSKchtOltQor3KlRE0yV
   bKxn1XDirTUDIIWW27UtXOJaYT+GSQv+QS6dez35VN6NizNYb5N3uU04b
   6RpL+bG6Ez0sj+Lg2CBDglHQwdEgAdTe7cwlk2EltmqvIUfIkj3RHEeHx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="385955034"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="385955034"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 04:01:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="841790734"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="841790734"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 04:01:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 04:01:24 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 04:00:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 04:00:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 04:00:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ha8bz8VCEMYbYRWI4HNJqPTtyqcuc02DIfAfy1OCUNm/TJrb0V9Wwinlrl+E0ltg68mXnSTLUIMk0vyVLlvmJGdzwAIrOBjd+3AcafvnUd6VLHUp5e8AEN9uMPbHzaHEw+lTB/TDi5P5evX10hEo5IbVS+JKiiXFWe97v36V+6qr6EjCpqG4l45PLXGN6yk4fnBQrCUHWyUOZo2Nq8U1hNqNm7Wo+LugEem4zPNBrcxB8YQWF0R/ACXq01q0oACi3uqyPaegs2HzRneHP4JW8o65hwY0YK/FuMg7l1dlo0SyFGTnRV3Fn6311XQHAOS1/ETZZ7G6RNLJkhMftD0JIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdC8rxBs/gYl1epEexxiGMIUxzGsgYnCAKlyDM/2tZI=;
 b=iEQys6UrFO6olllv4/zwbKn666tNLLxVeiz6ZHdErStvTXA5lXwxsAjDYLVvDKQklbswAEp+TlMQv+wp1m/dd3DOVjiBqESojI+O9pyfzcJAsdSOm3X0ANunnly2+wA8anI6C0JrBg6jvQdLeN+XyQTpNuwDhpCgt6YqGObGfF7QEDUh2nUHG7fxC0PkMcU6BWvU85fA5g/A6EhLeud3rB+FUbQAcu15VxMg6y82tG19fNPOYaz8Jaa7/AzY7d/ZVfIr2MHZXXDobzk+bkuLnqGfa3T+R/E6vBJX+9fNKMQ+K7Srb3o077ZbNrMfnVpZU30XsJimsKU9+CQ75tbYDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6532.namprd11.prod.outlook.com (2603:10b6:208:38f::9)
 by SJ0PR11MB5006.namprd11.prod.outlook.com (2603:10b6:a03:2db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Wed, 4 Oct
 2023 11:00:18 +0000
Received: from BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::4451:d890:fc6e:aa9a]) by BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::4451:d890:fc6e:aa9a%4]) with mapi id 15.20.6813.017; Wed, 4 Oct 2023
 11:00:18 +0000
From:   "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: mtd: cadence: convert
 cadence-nand-controller.txt to yaml
Thread-Topic: [PATCH] dt-bindings: mtd: cadence: convert
 cadence-nand-controller.txt to yaml
Thread-Index: AQHZ9oob7BXM2gqo7E2GJlUHTgEagbA5QECAgAAux0A=
Date:   Wed, 4 Oct 2023 11:00:17 +0000
Message-ID: <BL3PR11MB6532AC02EA46C2D861438A29A2CBA@BL3PR11MB6532.namprd11.prod.outlook.com>
References: <20231004061214.17176-1-niravkumar.l.rabara@intel.com>
 <20231004094455.1a6a19e1@xps-13>
In-Reply-To: <20231004094455.1a6a19e1@xps-13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6532:EE_|SJ0PR11MB5006:EE_
x-ms-office365-filtering-correlation-id: 1e2cf256-d0e7-4ca4-b135-08dbc4c9182c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6gY3WG9C1YH33sVD4iF4cPLHH0d3vgOAa14ZzDIO4IMXNSNdVQD4pN5q9yfD/IEhb5qX/1+pvEWkui18WpLgXakIE+sB4NIwij4Wm2ickwCxvrFcIbVDo2WCNpcAY8bM2cFDwgi+JhC2+sXwxJigldrYGZpDPMjBod2DiSVljRApW3HB7A5siq5/oofktaVBD5J2QKFklFhvx5/tmMQe43VMfSrLdUxFpp5uZOma1dGKNrj40LfGdrggE6qszeAZwHLRDzlvDpVXnO/vw9iohrRpGaHmu6EyI9rdRAq1bnS+UPTLs6aKZ63Hb6GQH3NAb+c0fECMB+IXus/59jh2zNPVIJI5ELhjDKr68r9UrZPjko3WhjAVwIRMcz1b7KTAKpRKv8CT+n+7FUlBdy3LEpqW32XI0tAZ6UH0oovTvI67wxmx4HpiRTLCRR5IuBqHVGfM8NAaNUgzhCaAUiBKuHtY81dZzJmc2+1At3JFXfWiLIXUOm91uKVvcHnEJ3BCs3f7zOBg2gpfMXLM+AxCF/QysHm8kvR9BfSOTBSxAoJdV9i9bYLBW4XmEqKL+w47mIXizwWFcmMgjfei0vQaBck7CeOqaNpv+jjy08zKKu11Zyn4KWQR1spSOyvPCnkdlUMPxjxkwqZjSHJ9C04Y+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(66476007)(6916009)(66446008)(66556008)(64756008)(54906003)(316002)(66946007)(26005)(76116006)(71200400001)(66574015)(53546011)(7696005)(122000001)(83380400001)(86362001)(38100700002)(82960400001)(33656002)(38070700005)(478600001)(966005)(6506007)(9686003)(55016003)(2906002)(4326008)(8936002)(8676002)(41300700001)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZllBSXNiVncrZFpJVmV5emZ5dlArbUM0VWdLdTVnUzhJNE5IVHhEN2NWbWdu?=
 =?utf-8?B?YUdNNnVnYUpKei9kWDdGc3RRS3N4QTZwOWp0NWF5WDlRYXhQUlR4VG83RExj?=
 =?utf-8?B?SzRtbHhoT25ZbWM0SFpGdC9WRHlQRWhJMm1MWkNlb1JFTFpSRjc2OVJWZ2pm?=
 =?utf-8?B?akwvWG5Ienk1MWxkNUoySjVJU3FFZXJnMHQ5cjdKM0diUzgrV2ZvSjdVeS9x?=
 =?utf-8?B?d0t5QXhtSDNtRzNEOEl2YTBmR2txOXZmN1JLZ2VPQTd6c3Ezb1N3WFdqUi9i?=
 =?utf-8?B?Ni8yYWFhQ1RrcjJkMzNaVUtiN3NrbVpGSEJTckdvOUVjQnVkNnZ2cXoyaHF5?=
 =?utf-8?B?aVZEbTc1T0VkVkZPdjh2cWtjc2tadFBkOG55NktNeWFydytzbHpvUEtPUzda?=
 =?utf-8?B?eGhwSWZhYkVOY3EycWFUL21wTUdzQ3h5SnBkVGFiU3FYK01DamVKK1FVVkFR?=
 =?utf-8?B?cWgvK0p0em9Ma0djNk1KUWFHaWhqMVl1a29xajdQbFZmcGo1TS8ydzUyMHB0?=
 =?utf-8?B?VmpjZG1QSVdCc0pGZkRzMkVpbWNodWEzY20yYk1YcDdiWFArTnRITGZxSkYv?=
 =?utf-8?B?MDhGS1lJRzJVL0NYRnIxK0F6UGxQbXJMOFFUd2FtaTFkUHdjSENjN0g0Y3BL?=
 =?utf-8?B?WExVSmZlZS9tc01LV3BVa3ZmdEJIVlFpTVhLWkRDYzJETDVodXl3Q2ZiVzE2?=
 =?utf-8?B?dFlkeXBpeHlXZ0lHOUg5aWFLZEtDQmNmMFA0K1kvVGsxU2xpdDJIYnRVUG1U?=
 =?utf-8?B?djdGcjNNbkpJaWp3VGJNZ2FFTE9kQjVBUXBDS25pVXptSUtFZStYWW50ejVu?=
 =?utf-8?B?UWhFZGs0NTJJUERkL29GclVoUjN6Yk1vdFR0ZWxqbkZYN3pwaW10RjhYZTBp?=
 =?utf-8?B?V2QwbWhsSDVOV3c1Zmp4VTlYamFvazF6aWFGVmc5clAwNXVxR1FETjJzcjJG?=
 =?utf-8?B?N0pWQSswL3dRSU5Rb1puQjd5dURxVUE4MnFpOXZ4VUoxa1hNUGdsRkR1eFVD?=
 =?utf-8?B?a2lRa3BOMHh0SHVFRmFOaTZiZUs2dkFsdHRqYS9OQnJzR2M4M3Z4Z3FEa0pw?=
 =?utf-8?B?UDMxSmxLTWtlejVScFJjNy9xbml6U0lmSjhRVnk0cmtmSDNydmpnUitONkVR?=
 =?utf-8?B?QlZWWWZTaVdocG5VQnVvWVVMN0dhZFZmeXJaekNMdzA1YnVRVDB0TU9Uei92?=
 =?utf-8?B?RkVPTWZQb0k3dm5nWVZpcHlGSEFVaFdQbnZnTHJiY0I4cU1GbEo1UEJXbkQ4?=
 =?utf-8?B?eE1WN3VmR3U0SjhnV29XM2IyVUNGZlk2ZmFxeHFiRXpNTExxNkFUTjh4Z29L?=
 =?utf-8?B?YjVCSWhZakovUzgyV1k2QnlxSko3YWFFY3dRTUxJT1k5RUExbzFISVRTVTBB?=
 =?utf-8?B?R3Z5WEZLUS9vb0QxbHhpQ2NpYnVHd1V0S2hwRml5WUdNMmJqck5IRDJkSUxu?=
 =?utf-8?B?ZG1jd05jeDBGUUhHbXh6akdhVUN4MnU5SWRsN3pmWlFJcTNPRVdTVEdnSDUw?=
 =?utf-8?B?MUJmRW50SFg2anBJNmJPUW02OTJaUGxhSGZoK25YRSt1Y0lGNGVsakkySmY3?=
 =?utf-8?B?TWNyVGxIanRidTJjZTNEbE11ZGducER5WWxYdks0Q2d6TWNvTmpZYkV2VS84?=
 =?utf-8?B?SVo0d3FJZnhodUlWVk16Mlg1cDBxRW44dFVySW84Ujl2ZnR4R3hqM2JOVkV6?=
 =?utf-8?B?bVBuVmt5VEtFejJzVklBZmlxTlQvcit0UHErQUJKSm9WUzNFV2xobkRPckln?=
 =?utf-8?B?a2JpSTRhM3lsQytpbXhtWWtNSStKY2xYSmZlNU5CVkdzM1F4cmZJN01OTW8z?=
 =?utf-8?B?VytsVzIwSERHS2Vpc0RDT0MwSWRycWpoZFN1OVR2bmhIUm9INEdNTkdnWmRX?=
 =?utf-8?B?M0tDaC93NUh0djBaYjRsTkRWRXNXeTNvMnplSDZtWml3Y1B3WWFGTzM5emVm?=
 =?utf-8?B?Sk92SElsZDN2djNKUU41Ymo5c2FWL3VycWc4MzNlNTZyaGFUUTV4SXBRMmQ2?=
 =?utf-8?B?cG1TM3N2VDBUNnBXRERuOENpNXhEd3dUb2IxM3ZNbnM5eHVkSHROL1RaY28v?=
 =?utf-8?B?QVI4KzVVRkt0WnNkUUY1blhXM3Yvd1g5WnZ6eG1SbVZMUFIxZDFpY09uUUVL?=
 =?utf-8?B?MHpJMjhreUtHMWp5bklTR0hzZVZZNkdtVnQ1V3V3NzlqZWFuMVFlZnhBWm5y?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2cf256-d0e7-4ca4-b135-08dbc4c9182c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 11:00:17.5975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2sM6qFxaFfSn0hcdzdeM3OM0ccSpZs2wCrxilQ8PkUBFb2aIVoI7awEwkrRCD0tVMrwmaH3jheK9P14ot5eL18gPCP/zdFBi5PGWgdxoQik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5006
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlxdWVsIFJheW5hbCA8
bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDQs
IDIwMjMgMzo0NSBQTQ0KPiBUbzogUmFiYXJhLCBOaXJhdmt1bWFyIEwgPG5pcmF2a3VtYXIubC5y
YWJhcmFAaW50ZWwuY29tPg0KPiBDYzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5h
dD47IFZpZ25lc2ggUmFnaGF2ZW5kcmENCj4gPHZpZ25lc2hyQHRpLmNvbT47IFJvYiBIZXJyaW5n
IDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnp5c3p0b2Yu
a296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5v
cmc+Ow0KPiBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0hdIGR0LWJpbmRpbmdzOiBtdGQ6IGNhZGVuY2U6IGNvbnZlcnQgY2FkZW5jZS1uYW5k
LQ0KPiBjb250cm9sbGVyLnR4dCB0byB5YW1sDQo+IA0KPiBIZWxsbywNCj4gDQo+IG5pcmF2a3Vt
YXIubC5yYWJhcmFAaW50ZWwuY29tIHdyb3RlIG9uIFdlZCwgIDQgT2N0IDIwMjMgMTQ6MTI6MTQg
KzA4MDA6DQo+IA0KPiA+IEZyb206IE5pcmF2a3VtYXIgTCBSYWJhcmEgPG5pcmF2a3VtYXIubC5y
YWJhcmFAaW50ZWwuY29tPg0KPiA+DQo+ID4gQ29udmVydCBjYWRlbmNlLW5hbmQtY29udHJvbGxl
ci50eHQgdG8geWFtbCBmb3JtYXQuDQo+IA0KPiBMb29rcyBnb29kIHRvIG1lLCBvbmUgcXVlc3Rp
b24gYmVsb3cuDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE5pcmF2a3VtYXIgTCBSYWJhcmEgPG5p
cmF2a3VtYXIubC5yYWJhcmFAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tdGQvY2FkZW5jZSxuYW5kLnlhbWwgfCA3Mw0KPiA+ICsrKysrKysrKysrKysr
KysrKysgIC4uLi9iaW5kaW5ncy9tdGQvY2FkZW5jZS1uYW5kLWNvbnRyb2xsZXIudHh0ICB8DQo+
ID4gNTMgLS0tLS0tLS0tLS0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA3MyBpbnNlcnRpb25z
KCspLCA1MyBkZWxldGlvbnMoLSkgIGNyZWF0ZSBtb2RlDQo+ID4gMTAwNjQ0IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvY2FkZW5jZSxuYW5kLnlhbWwNCj4gPiAgZGVsZXRl
IG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9j
YWRlbmNlLW5hbmQtY29udHJvbGxlci50eHQNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL2NhZGVuY2UsbmFuZC55YW1sDQo+ID4gYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL2NhZGVuY2UsbmFuZC55YW1sDQo+
ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjc4MTgxMmFj
NzAyZg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbXRkL2NhZGVuY2UsbmFuZC55YW1sDQo+ID4gQEAgLTAsMCArMSw3MyBAQA0K
PiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xh
dXNlICVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcv
c2NoZW1hcy9tdGQvY2FkZW5jZSxuYW5kLnlhbWwjDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZp
Y2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IENh
ZGVuY2UgTkFORCBjb250cm9sbGVyDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAt
IE5pcmF2a3VtYXIgTCBSYWJhcmEgPG5pcmF2a3VtYXIubC5yYWJhcmFAaW50ZWwuY29tPg0KPiA+
ICsNCj4gPiArYWxsT2Y6DQo+ID4gKyAgLSAkcmVmOiBuYW5kLWNvbnRyb2xsZXIueWFtbA0KPiA+
ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgaXRlbXM6
DQo+ID4gKyAgICAgIC0gY29uc3Q6IGNkbnMsaHAtbmZjDQo+ID4gKw0KPiA+ICsgIHJlZzoNCj4g
PiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBBZGRyZXNzIGFuZCBsZW5n
dGggb2YgdGhlIGNvbnRyb2xsZXIgcmVnaXN0ZXIgc2V0DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRp
b246IEFkZHJlc3MgYW5kIGxlbmd0aCBvZiB0aGUgU2xhdmUgRE1BIGRhdGEgcG9ydA0KPiA+ICsN
Cj4gPiArICByZWctbmFtZXM6DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBjb25zdDog
cmVnDQo+ID4gKyAgICAgIC0gY29uc3Q6IHNkbWENCj4gPiArDQo+ID4gKyAgaW50ZXJydXB0czoN
Cj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGNsb2NrczoNCj4gPiArICAgIG1h
eEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGRtYXM6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+
ICsNCj4gPiArICBjZG5zLGJvYXJkLWRlbGF5LXBzOg0KPiA+ICsgICAgZGVzY3JpcHRpb246IHwN
Cj4gPiArICAgICAgRXN0aW1hdGVkIEJvYXJkIGRlbGF5LiBUaGUgdmFsdWUgaW5jbHVkZXMgdGhl
IHRvdGFsIHJvdW5kIHRyaXANCj4gPiArICAgICAgZGVsYXkgZm9yIHRoZSBzaWduYWxzIGFuZCBp
cyB1c2VkIGZvciBkZWNpZGluZyBvbiB2YWx1ZXMgYXNzb2NpYXRlZA0KPiA+ICsgICAgICB3aXRo
IGRhdGEgcmVhZCBjYXB0dXJlLiBUaGUgZXhhbXBsZSBmb3JtdWxhIGZvciBTRFIgbW9kZSBpcyB0
aGUNCj4gPiArICAgICAgZm9sbG93aW5nLg0KPiA+ICsgICAgICBib2FyZCBkZWxheSA9IFJFI1BB
RCBkZWxheSArIFBDQiB0cmFjZSB0byBkZXZpY2UgKyBQQ0IgdHJhY2UgZnJvbSBkZXZpY2UNCj4g
PiArICAgICAgKyBEUSBQQUQgZGVsYXkNCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0g
Y29tcGF0aWJsZQ0KPiA+ICsgIC0gcmVnDQo+ID4gKyAgLSByZWctbmFtZXMNCj4gPiArICAtIGlu
dGVycnVwdHMNCj4gPiArICAtIGNsb2Nrcw0KPiA+ICsNCj4gPiArdW5ldmFsdWF0ZWRQcm9wZXJ0
aWVzOiBmYWxzZQ0KPiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICAg
IG5hbmQtY29udHJvbGxlckAxMGI4MDAwMCB7DQo+ID4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJj
ZG5zLGhwLW5mYyI7DQo+ID4gKyAgICAgICAgcmVnID0gPDB4MTBiODAwMDAgMHgxMDAwMD4sDQo+
ID4gKyAgICAgICAgICAgIDwweDEwODQwMDAwIDB4MTAwMDA+Ow0KPiA+ICsgICAgICAgIHJlZy1u
YW1lcyA9ICJyZWciLCAic2RtYSI7DQo+ID4gKyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47
DQo+ID4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gKyAgICAgICAgaW50ZXJydXB0
cyA9IDwwIDk3IDQ+Ow0KPiA+ICsgICAgICAgIGNsb2NrcyA9IDwmbmZfY2xrPjsNCj4gPiArICAg
ICAgICBjZG5zLGJvYXJkLWRlbGF5LXBzID0gPDQ4MzA+Ow0KPiA+ICsNCj4gPiArICAgICAgICBu
YW5kQDAgew0KPiA+ICsgICAgICAgICAgICByZWcgPSA8MD47DQo+ID4gKyAgICAgICAgfTsNCj4g
PiArICAgICAgfTsNCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbXRkL2NhZGVuY2UtbmFuZC1jb250cm9sbGVyLnR4dA0KPiA+IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9jYWRlbmNlLW5hbmQtY29udHJvbGxlci50
eHQNCj4gPiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCBkMmVhZGE1MDQ0YjIu
LjAwMDAwMDAwMDAwMA0KPiA+IC0tLQ0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL210ZC9jYWRlbmNlLW5hbmQtY29udHJvbGxlci50eHQNCj4gPiArKysgL2Rldi9udWxs
DQo+ID4gQEAgLTEsNTMgKzAsMCBAQA0KPiA+IC0qIENhZGVuY2UgTkFORCBjb250cm9sbGVyDQo+
ID4gLQ0KPiA+IC1SZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+IC0gIC0gY29tcGF0aWJsZSA6ICJj
ZG5zLGhwLW5mYyINCj4gPiAtICAtIHJlZyA6IENvbnRhaW5zIHR3byBlbnRyaWVzLCBlYWNoIG9m
IHdoaWNoIGlzIGEgdHVwbGUgY29uc2lzdGluZyBvZiBhDQo+ID4gLQkgIHBoeXNpY2FsIGFkZHJl
c3MgYW5kIGxlbmd0aC4gVGhlIGZpcnN0IGVudHJ5IGlzIHRoZSBhZGRyZXNzIGFuZA0KPiA+IC0J
ICBsZW5ndGggb2YgdGhlIGNvbnRyb2xsZXIgcmVnaXN0ZXIgc2V0LiBUaGUgc2Vjb25kIGVudHJ5
IGlzIHRoZQ0KPiA+IC0JICBhZGRyZXNzIGFuZCBsZW5ndGggb2YgdGhlIFNsYXZlIERNQSBkYXRh
IHBvcnQuDQo+ID4gLSAgLSByZWctbmFtZXM6IHNob3VsZCBjb250YWluICJyZWciIGFuZCAic2Rt
YSINCj4gPiAtICAtICNhZGRyZXNzLWNlbGxzOiBzaG91bGQgYmUgMS4gVGhlIGNlbGwgZW5jb2Rl
cyB0aGUgY2hpcCBzZWxlY3QgY29ubmVjdGlvbi4NCj4gPiAtICAtICNzaXplLWNlbGxzIDogc2hv
dWxkIGJlIDAuDQo+ID4gLSAgLSBpbnRlcnJ1cHRzIDogVGhlIGludGVycnVwdCBudW1iZXIuDQo+
ID4gLSAgLSBjbG9ja3M6IHBoYW5kbGUgb2YgdGhlIGNvbnRyb2xsZXIgY29yZSBjbG9jayAobmZf
Y2xrKS4NCj4gPiAtDQo+ID4gLU9wdGlvbmFsIHByb3BlcnRpZXM6DQo+ID4gLSAgLSBkbWFzOiBz
aGFsbCByZWZlcmVuY2UgRE1BIGNoYW5uZWwgYXNzb2NpYXRlZCB0byB0aGUgTkFORA0KPiA+IGNv
bnRyb2xsZXINCj4gPiAtICAtIGNkbnMsYm9hcmQtZGVsYXktcHMgOiBFc3RpbWF0ZWQgQm9hcmQg
ZGVsYXkuIFRoZSB2YWx1ZSBpbmNsdWRlcyB0aGUgdG90YWwNCj4gPiAtICAgIHJvdW5kIHRyaXAg
ZGVsYXkgZm9yIHRoZSBzaWduYWxzIGFuZCBpcyB1c2VkIGZvciBkZWNpZGluZyBvbiB2YWx1ZXMN
Cj4gPiAtICAgIGFzc29jaWF0ZWQgd2l0aCBkYXRhIHJlYWQgY2FwdHVyZS4gVGhlIGV4YW1wbGUg
Zm9ybXVsYSBmb3IgU0RSIG1vZGUgaXMNCj4gPiAtICAgIHRoZSBmb2xsb3dpbmc6DQo+ID4gLSAg
ICBib2FyZCBkZWxheSA9IFJFI1BBRCBkZWxheSArIFBDQiB0cmFjZSB0byBkZXZpY2UgKyBQQ0Ig
dHJhY2UgZnJvbSBkZXZpY2UNCj4gPiAtICAgICsgRFEgUEFEIGRlbGF5DQo+ID4gLQ0KPiA+IC1D
aGlsZCBub2RlcyByZXByZXNlbnQgdGhlIGF2YWlsYWJsZSBOQU5EIGNoaXBzLg0KPiANCj4gVGhp
cyBpcyBub3QgZnVsbHkgcGljdHVyZWQgaW4gdGhlIGN1cnJlbnQgc2NoZW1hLCBieSByZWZlcmVu
Y2luZyBuYW5kLQ0KPiBjb250cm9sbGVyLnlhbWwgSSBiZWxpZXZlIHlvdSBhbGxvdyBhbGwga2lu
ZCBvZiBkaXJlY3QgcGFydGl0aW9uaW5nICh3aGljaCBpcyBsZWdhY3ksDQo+IGFuZCBub3Qgc3Vw
cG9zZWQgdG8gYmUgc3VwcG9ydGVkIGhlcmUpLg0KPiBDYW4geW91IHRyeSB0byBkZWZpbmUgYSBw
YXJ0aXRpb24gZGlyZWN0bHkgd2l0aGluIHRoZSBjb250cm9sbGVyIG5vZGUgaW4gdGhlIGV4YW1w
bGUNCj4gYW5kIHNlZSB3aGV0aGVyIGl0IHN0aWxsIHBhc3NlcyB0aGUgY2hlY2tzPw0KPiANCj4g
VGhhbmtzLA0KPiBNaXF1w6hsDQoNCkhpIE1pcXVlbCwNCg0KSSB0cmllZCBiZWxvdyBpbiB0aGUg
Y29udHJvbGxlciBub2RlIGluIGV4YW1wbGUsDQoNCiAgICAgICAuLi4NCiAgICAgICAgY2xvY2tz
ID0gPCZuZl9jbGs+Ow0KICAgICAgICBjZG5zLGJvYXJkLWRlbGF5LXBzID0gPDQ4MzA+Ow0KDQog
ICAgICAgIHBhcnRpdGlvbkAwIHsNCiAgICAgICAgICBsYWJlbCA9ICJib290IjsNCiAgICAgICAg
ICByZWcgPSA8MCAweDAwMjAwMDAwPjsNCiAgICAgICAgIH07DQoNCiAgICAgICAgbmFuZEAwIHsN
CiAgICAgICAgICAgIHJlZyA9IDwwPjsNCiAgICAgICAgfTsNCg0KSXQgc2hvd3MgICdwYXJ0aXRp
b25AMCcgd2FzIHVuZXhwZWN0ZWQuDQoNCkRUQ19DSEsgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL210ZC9jYWRlbmNlLG5hbmQuZXhhbXBsZS5kdGINCkRvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9tdGQvY2FkZW5jZSxuYW5kLmV4YW1wbGUuZHRzOjM1LjIzLTM4LjE0
OiBXYXJuaW5nICh1bmlxdWVfdW5pdF9hZGRyZXNzX2lmX2VuYWJsZWQpOiAvZXhhbXBsZS0wL25h
bmQtY29udHJvbGxlckAxMGI4MDAwMC9wYXJ0aXRpb25AMDogZHVwbGljYXRlIHVuaXQtYWRkcmVz
cyAoYWxzbyB1c2VkIGluIG5vZGUgL2V4YW1wbGUtMC9uYW5kLWNvbnRyb2xsZXJAMTBiODAwMDAv
bmFuZEAwKQ0KL21udC9uZXd2b2x1bWUvdXNlcnMvbnJhYmFyYS9rZXJuZWwub3JnLzNvY3QyMy9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL2NhZGVuY2UsbmFuZC5leGFtcGxl
LmR0YjogbmFuZC1jb250cm9sbGVyQDEwYjgwMDAwOiBVbmV2YWx1YXRlZCBwcm9wZXJ0aWVzIGFy
ZSBub3QgYWxsb3dlZCAoJ3BhcnRpdGlvbkAwJyB3YXMgdW5leHBlY3RlZCkNCiAgICAgICAgRnJv
bSBzY2hlbWE6IC9tbnQvbmV3dm9sdW1lL3VzZXJzL25yYWJhcmEva2VybmVsLm9yZy8zb2N0MjMv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9jYWRlbmNlLG5hbmQueWFtbA0K
DQpIb3dldmVyIHVzaW5nIHBhcnRpdGlvbiBpbiBuYW5kIG5vZGUgaXMgT0suDQogICAgICAgIG5h
bmRAMCB7DQogICAgICAgICAgICByZWcgPSA8MD47DQogICAgICAgICAgICANCiAgICAgICAgICAg
ICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MT47DQoN
CiAgICAgICAgICAgIHBhcnRpdGlvbkAwIHsNCiAgICAgICAgICAgICAgbGFiZWwgPSAiYm9vdCI7
DQogICAgICAgICAgICAgIHJlZyA9IDwwIDB4MDAyMDAwMDA+Ow0KICAgICAgICAgICAgfTsNCg0K
ICAgICAgICAgICAgcGFydGl0aW9uQDIwMDAwMCB7DQogICAgICAgICAgICAgIGxhYmVsID0gImVu
diI7DQogICAgICAgICAgICAgIHJlZyA9IDwweDAwMjAwMDAwIDB4MDA0MDAwMDA+Ow0KICAgICAg
ICAgICAgfTsNCiAgICAgICAgfTsNCg0KIm1ha2UgZHRfYmluZGluZ19jaGVjayBEVF9TQ0hFTUFf
RklMRVM9bXRkL2NhZGVuY2UsbmFuZC55YW1sIiAgaXMgT0sgd2l0aG91dCBhbnkgd2FybmluZ3Mu
IA0KDQpEVEVYICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvY2FkZW5j
ZSxuYW5kLmV4YW1wbGUuZHRzDQpEVENfQ0hLIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tdGQvY2FkZW5jZSxuYW5kLmV4YW1wbGUuZHRiDQoNCkFueSBhZGRpdGlvbmFsIGNoYW5n
ZXMgcmVxdWlyZWQgZm9yIHRoaXMgcGF0Y2g/DQoNClRoYW5rcywNCk5pcmF2DQoNCg==
