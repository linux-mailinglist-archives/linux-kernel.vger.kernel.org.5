Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F9C80081C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378242AbjLAKWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378226AbjLAKWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:22:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A92A8;
        Fri,  1 Dec 2023 02:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701426163; x=1732962163;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vF62aC2e1v5NQ3hziibYxKne4BUCc+WRBsKbssIiXuU=;
  b=lHf4ngBFSXqbScccAvr8f4jdJaqFpbm2cFWahqxWt4zXCDEd5zIIaSQr
   SULpXelRV/7Tv5uV0AKTPS9P1jMT6ccN1M9B3lxFC74QmnAzKM7+byUOT
   80u/zXuzNS+LJYDaagaMAcuuKT79ztTrdHqFGCQb9Uol23lK3nIeZqd31
   Re9g1wiWaE1WGfix80SyBvUK1wyhXfRnk4G1TlpXrUtTUXaLXeNS9CMKO
   uBtV9gOOGk/CVkZf1n/ecI3xn3O+C61t5hMOtnYjj53IhnuIGywCCaCzC
   +Fx5YacBKyuLIywpqdqB8eaEyg5undT1UwC05Lm5G7obVLStr/bd2mXWX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="392342325"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="392342325"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 02:22:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="1017006960"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="1017006960"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Dec 2023 02:22:41 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 02:22:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 1 Dec 2023 02:22:40 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 1 Dec 2023 02:22:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGpll8nf0zZqet0DYi6bfGyxqK0TsRdIMOG7EBTu9j5yMod5rzMVibhGdz0Rz4brrsE2O/inRmyOtCVz5RDNcE5Rei3yJCLK55knCo1yXpyRYRjm312n49PI40RqYkhcbn+mlkqqnsFBlusoFmds6bikl2iQC4M3xNTt9PH9QwKnfiUE2kDzY4EHheae15Fh4EJSccDKFbAznXte3miiw1gyrPRcAI0px9GyQywuMfOBA/uERNHxW/pmH0frTzhTrwyInqRu2gk+LskLanrIFhci7ZlqDkib9NBfz26eC6qg6lziCk/IytP6QePfCIHoFSFSzs48Xht4tUtxkuI9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vF62aC2e1v5NQ3hziibYxKne4BUCc+WRBsKbssIiXuU=;
 b=XEORwXsNygI7QpVrNp1y/oFSQRWp98qZeTlx7bkgq2BtqjSyovSH0UqGUhwV1N/TSM6XciGDY+jCH2qVHLg0ADw2S/XoD76koGCJjHbluU8zdc3i8+tLw3MK/T0kGjS1bu6+l4r8t+6PdCQJCxaqun5AC5ZU/m2bhui8grV1Abhwwu8h0BAUzlsI8t1MMe9eIBWZC+3N3lXppciIgo3yKC3c2JC+yb0D95DDlxmqdn/k5U3Mr092yaH7gt6F0QxoQIRXTg7K6yAVY184R21harrALW2nxC2UEQwp5lUPzVDEhIHieTEw3jLJzJ/JuUHbNr7YxDw7Xii9IZRn5RxX7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by CH3PR11MB7761.namprd11.prod.outlook.com (2603:10b6:610:151::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 10:22:38 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::aa4a:f2aa:f6cf:367b]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::aa4a:f2aa:f6cf:367b%7]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 10:22:38 +0000
From:   "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
To:     Peter Hilber <peter.hilber@opensynergy.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "jstultz@google.com" <jstultz@google.com>,
        "giometti@enneenne.com" <giometti@enneenne.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Dong, Eddie" <eddie.dong@intel.com>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "N, Pandith" <pandith.n@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
Subject: RE: [PATCH v1 4/6] pps: generators: Add PPS Generator TIO Driver
Thread-Topic: [PATCH v1 4/6] pps: generators: Add PPS Generator TIO Driver
Thread-Index: AQHaALpZxHZAaaClkkqnOx5cHxnWO7BOLEYAgASqJoCAQadusA==
Date:   Fri, 1 Dec 2023 10:22:38 +0000
Message-ID: <CY8PR11MB736445F103863F240E472141C481A@CY8PR11MB7364.namprd11.prod.outlook.com>
References: <87lec15i4b.ffs@tglx>
 <c032b7f7-ccea-4e3d-a3fc-d772d034b195@opensynergy.com>
In-Reply-To: <c032b7f7-ccea-4e3d-a3fc-d772d034b195@opensynergy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7364:EE_|CH3PR11MB7761:EE_
x-ms-office365-filtering-correlation-id: d23f1562-f52e-4d81-9f15-08dbf257715f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p+mjKRG5nUwl4WjHpcXTNDdCmZRo355bkQRRKGK2s6JtAU0Bhs+YQSSM4AgiGgrRigDMmzmKUtS7bsfhTN/cJFgi2ZSKGGTS7+12emrdNpRlErB6njHxjf1VWKfPTFCuR2O4fBYuT0QpJGMlr8RRe2IRzsE3buztYi4ESrVi4ZbMWfcZoOdkAXsOTUnhBQqqbi/Wx6hrjPF5+fqB3t35zuIOw0sgTjUI+DjeRBFR3srRBjPB/nHIDsGHC/ERuGopRHwihRQkcvbHepoQhx1UkJhxXelR/x8stMpo6xmdEoBG4+S5nXi6iI1GB8jLCWtnuZQNubOfc/JtvdSEtfEjCcnO1TblKFVGmA2ChGpqPvO0arZlOlch6/0O7pREo9QHOsqO6Q98T982UaH4NPRM0uMA9TIRKj/vvO3zXrY1bVDBkgaj3VcHtJukaTB3+Lr6AAUTVjzoOHjBNLShnE/XOQ2gWIskTgIbOLXobXrmHcs5tVwC8qkKVRUoO12lMoHuhZuq4KgIzdxFlUnV43cpRFJzaI1kc18eYopDsfAH2Cc3x+d53BYSR7+ENVlEB4c3ECkfcO9ggzzF2ehWfAFZ67YFGPYWcNPmj9QAYEjjR47uRZDsF4Xn/GNklunhSocQAP5Ro9iQb3zTpuuajuB+6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(55016003)(38070700009)(86362001)(76116006)(66446008)(64756008)(71200400001)(66476007)(66946007)(82960400001)(33656002)(38100700002)(122000001)(83380400001)(54906003)(9686003)(26005)(6506007)(7696005)(53546011)(966005)(110136005)(2906002)(316002)(66556008)(4326008)(8676002)(5660300002)(52536014)(8936002)(478600001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VG1oNVlKdkN2ZDZISFpIUjgvWUV2VkNpYXhjL01sNFNSaVlVci9WNDNvS3Bm?=
 =?utf-8?B?dVdFTHFzVUNNdU95S00xeE5QdkpYZXlQSWRsMEkyNGo3M3RJSnUzcmJrQjJo?=
 =?utf-8?B?ME9pUDRtT3dqQjY0RUEySGgvazVqSmlJMGZPOXhXdThmQTJjNTNqS1c0a1ZJ?=
 =?utf-8?B?bDVwR3ZqbE5kb2JuR0p2YUNWd1B4TmNwWXRaTWg0RXpyMjhvR3o1Y2ZTV3ZS?=
 =?utf-8?B?YjgvUUJYaWpnS0ovNytvRUhQM3VYcnR3b2VON09TQkRhWU9tdHh4UTlpNW56?=
 =?utf-8?B?ZDlmNUM0Ri9RcDRIQ0syMFNHanZseWt3VUZ5dURUb1VEcE5PbFlKZzV1Q1ZO?=
 =?utf-8?B?VUJDeW5SWW9jRHVzdXhPeUU5STNsN3puMkJHMG9HditnalVSY3ViZnFjN2M4?=
 =?utf-8?B?ejhtSWk0d0hLUkhqL2RaT2x5Zk1mdEt1Tk5DME9JdDRxbGlsT2UxYnhudGFE?=
 =?utf-8?B?SHB2S1hjNXQ5eHo2OFdDelNxM1JqNVk0UUFsWnhHb0kxT3pwcHllQ2ppdk5t?=
 =?utf-8?B?VE9sWnNoRmhKNzBsN3dTeFdGWDZneWNYRHhWVDdiNzVqYWpjRk4valV2OG1S?=
 =?utf-8?B?VkM0bGZtN0hQa1Q4UlBDN0cxYXZSMlVOeitQSDFvWDh4WUt2OHJTZGwxTWpO?=
 =?utf-8?B?aU5DdU90bEZacGtzRHc0ZU94MnM5MFBRNS9QaitmZjVNQWhZTHMrWXNPSXY5?=
 =?utf-8?B?Sk1vZ1J6bkMzNTF3bG10aXFhN05EZHNOOXBuR1hQRzc3eXBpMGpEWnZkOUl0?=
 =?utf-8?B?RTNLTUIwYXRDd292cmttL2UzVzl2QzhJR1FrU3NXdk41YWR4RkhoMHZaalU1?=
 =?utf-8?B?cGgrTll6TkliVE5EZ1pYN2xibVYrQnozSXBhQWk1K1lvd0lLYzBJcmp3Ulpy?=
 =?utf-8?B?NHNhOVljSjJzV0F6QzFUQ0doa2NWdk1RVUVPdGs5c3NMcTJoMk5OcG0yM21B?=
 =?utf-8?B?bTJoSUtoUTNiOFBsa1RUU01ZRkx6QzZ0SndNVHEzRktOT0VMbys5bW1DRTg2?=
 =?utf-8?B?UzV0MzFNN1J5ZFR3UWFHcjRDLy9QRit1K3FKK3JtbkpYRStxQm10Unh2cFRN?=
 =?utf-8?B?ejkxV1VBaHFpZ2h6a1lqemEyWHpPTC91UmEvVGkrY2NjbDBORjdQWlBlRGFT?=
 =?utf-8?B?ZW9lZ3RocEdpaGszY29zYVhLcEtVS09WeG5Sa3RyZ0tlQ3VBekxPRzMvVDg4?=
 =?utf-8?B?R0ZyU3ZLQWgvNzVOTTVia3JkMU9LTlZaajFNRFFDdC9WeG4rRTMxcEo0Vzht?=
 =?utf-8?B?a0JuNlJKZWFaMktkeFVLY2VXMHJGNE5qeCtsV3J1OTE5cHgvUmllNG5wS00z?=
 =?utf-8?B?d0ZzKzgwaUExanlmeHc4cFZsYlI5QkU4NmZRbnNmOENpZ01TZ3dCdURJZmM1?=
 =?utf-8?B?WmFGNDhrZkd6VkdmQjB1aVRRSGlYNDdzMlNmbXI2WFlyVm9xdW0weVh2TzN1?=
 =?utf-8?B?Rmh6ajlpTENIWEthNytmR3Y2ZVZXODE4U1MvRlVnNUdjNVZZb3dxZHo1ckNp?=
 =?utf-8?B?c1Aya01OaXhZWG5hSG8xSTM2ajJjSVVobmpSc2dLT0xBMFdkNXpMaFEydjJI?=
 =?utf-8?B?WUhMa2gzdGZSMDVrRTJtTnJUUkRsamtQRGpydjVCbzg2UGpVaElVSmszUnhB?=
 =?utf-8?B?Z1JLNzlwRVZCQ0VFenFjT0xHSCtPOXhtZU5zZTBDWWhMNkxCTXNrRXB1eFRY?=
 =?utf-8?B?NzFKMkJoRTBISTdwd3pCTzJGMERoMDNkWFYwRms5R1Q0L2NkY0x4VXI2ZUxv?=
 =?utf-8?B?aFN2a3ZWdU8wLzBTRVp5K1NYSlZmUzBhckx2YnhUd2M4QmxVWmxHUTRXc3BC?=
 =?utf-8?B?ZlI0QTd1bVhNTmNOSGpiRSt6VUlyWGRPekxyT01HUG1BYzgweUplUzdjMyti?=
 =?utf-8?B?a0lPSHlsRkdPMFgvV1k5enFQQ3NTUExHUkhOVW5mSHRxbHdybGZZeVpZOXVH?=
 =?utf-8?B?Q2RrOWhOR2hyTGxyemk4bUhuZTdEb1c4WlA5Rm1pZ1lqa29vVjhtR2JUTmE0?=
 =?utf-8?B?N1NQYWRWNXhGY1BacmtpdVJlTGlDQURrUTVjTlVTaFBuQXB0Nm8zSWJ6czRq?=
 =?utf-8?B?WjNJb0J2NWx2ZWQ5OVBzaVJtVk9zQU5FNlA3VDVQOFFvUHhNUkRNMDJlRS90?=
 =?utf-8?B?Wno3d1JxWXZNTjR1RHNHVmk4bFRtcnFJRWYzMXNmQjh3Rnc2a2IrUkNRZDdL?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23f1562-f52e-4d81-9f15-08dbf257715f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 10:22:38.1135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rVObD7mQxfuAsCJzYvLvX5KEDgUoa9o/0Crof31hU1iL6a2HbmvdVnviT7T5UKC8l7OMP0w3h5669xL3OXwPmbXvJhYI3uGdymLMUaje+as=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7761
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgSGlsYmVyIDxw
ZXRlci5oaWxiZXJAb3BlbnN5bmVyZ3kuY29tPg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMjAs
IDIwMjMgOToxMiBQTQ0KPiBUbzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+
OyBELCBMYWtzaG1pIFNvd2phbnlhDQo+IDxsYWtzaG1pLnNvd2phbnlhLmRAaW50ZWwuY29tPjsg
anN0dWx0ekBnb29nbGUuY29tOw0KPiBnaW9tZXR0aUBlbm5lZW5uZS5jb207IGNvcmJldEBsd24u
bmV0OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiB4ODZAa2VybmVsLm9yZzsg
bGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsNCj4gYW5kcml5LnNoZXZjaGVua29AbGludXguaW50
ZWwuY29tOyBEb25nLCBFZGRpZSA8ZWRkaWUuZG9uZ0BpbnRlbC5jb20+OyBIYWxsLA0KPiBDaHJp
c3RvcGhlciBTIDxjaHJpc3RvcGhlci5zLmhhbGxAaW50ZWwuY29tPjsgTiwgUGFuZGl0aA0KPiA8
cGFuZGl0aC5uQGludGVsLmNvbT47IFNhbmdhbm5hdmFyLCBNYWxsaWthcmp1bmFwcGENCj4gPG1h
bGxpa2FyanVuYXBwYS5zYW5nYW5uYXZhckBpbnRlbC5jb20+OyBUIFIsIFRoZWplc2ggUmVkZHkN
Cj4gPHRoZWplc2gucmVkZHkudC5yQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MSA0LzZdIHBwczogZ2VuZXJhdG9yczogQWRkIFBQUyBHZW5lcmF0b3IgVElPIERyaXZlcg0KPiAN
Cj4gT24gMTcuMTAuMjMgMTg6MjcsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gPiBPbiBUdWUs
IE9jdCAxNyAyMDIzIGF0IDEwOjU0LCBsYWtzaG1pLnNvd2phbnlhLmRAaW50ZWwuY29tIHdyb3Rl
Og0KPiA+PiArCWd1YXJkKHNwaW5sb2NrX2lycXNhdmUpKCZ0aW8tPmxvY2spOw0KPiA+PiArCWlm
IChlbmFibGUgJiYgIXRpby0+ZW5hYmxlZCkgew0KPiA+PiArCQlpZiAoIWlzX2N1cnJlbnRfY2xv
Y2tzb3VyY2VfYXJ0X3JlbGF0ZWQoKSkgew0KPiA+PiArCQkJZGV2X2Vycih0aW8tPmRldiwgIlBQ
UyBjYW5ub3QgYmUgc3RhcnRlZCBhcyBjbG9jayBpcyBub3QNCj4gcmVsYXRlZCB0byBBUlQiKTsN
Cj4gPj4gKwkJCXJldHVybiAtRVBFUk07DQo+ID4+ICsJCX0NCj4gPg0KPiA+IEFoLiBIZXJlIGlz
IHRoZSB1c2VjYXNlIGZvciB0aGlzIG1hZ2ljIHBhdGNoIDMvNiBoYWNrZXJ5LiBBZ2FpbiwgaXQn
cw0KPiA+IHRoZSB3cm9uZyBhYnN0cmFjdGlvbi4gWW91IHdhbnQgc29tZXRoaW5nIGxpa2U6DQo+
ID4NCj4gPiAgICAgdGltZWtlZXBpbmdfY2xvY2tzb3VyY2VfaGFzX2Jhc2UoQ1NJRF9YODZfQVJU
KTsNCj4gPg0KPiA+IG9yIHNvbWV0aGluZyBsaWtlIHRoaXMsIHdoaWNoIGNhbiBiZSBoYW5kbGVk
IGNvbXBsZXRlbHkgaW4gdGhlIGNvcmUNCj4gPiBjb2RlLg0KPiA+DQo+ID4gQWxsIG9mIHRoaXMg
bmVlZHMgc29tZSBzZXJpb3VzIHJld29yay4gU2VlIHRoZSBiZWxvdyBkaXNmdW5jdGlvbmFsDQo+
ID4gbW9ja3VwIHBhdGNoIGZvciBpbGx1c3RyYXRpb24uDQo+ID4NCj4gPiBUaGVyZSBpcyBhbHNv
IGEgcGF0Y2ggc2VyaWVzLCB3aGljaCB0cmllZCB0byByZXBsYWNlIHRoZSBjbG9ja3NvdXJjZQ0K
PiA+IHBvaW50ZXIgaW4gc3lzdGVtX2NvdW50ZXJ2YWxfdCB3aXRoIGEgY2xvY2tzb3VyY2UgSUQ6
DQo+ID4NCj4gPg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDgxODAxMTI1
Ni4yMTEwNzgtMS1wZXRlci5oaWxiZXJAb3BlbnMNCj4gPiB5bmVyZ3kuY29tDQo+ID4NCj4gPiBU
aGF0IHdlbnQgbm93aGVyZSwgYnV0IGhhcyBzb21lIHZhbGlkIHBvaW50cy4gSSB0b29rIHNvbWUg
b2YgUGV0ZXIncw0KPiA+IChjYydlZCkgaWRlYXMgaW50byB0aGUgbW9ja3VwLCBidXQgZGlkIGl0
IHNsaWdodGx5IGRpZmZlcmVudCB0byBtYWtlDQo+ID4gYWxsIG9mIHRoaXMgaW5kaXJlY3Rpb24g
bWVzcyBnbyBhd2F5Lg0KPiA+DQo+ID4gVGhlcmUgYXJlIGNlcnRhaW5seSBidWdzIGFuZCB0aGlu
a29zIGluIHRoYXQgbW9ja3VwLiBJZiB5b3UgZmluZCB0aGVtLA0KPiA+IHlvdSBjYW4ga2VlcCBh
bmQgZml4IHRoZW0gOikNCj4gPg0KPiANCj4gSGkgU293amFueWEsDQo+IA0KPiBJIGFtIHdvcmtp
bmcgb24gYW5vdGhlciBpdGVyYXRpb24gb2YgdGhlIHBhdGNoIHNlcmllcyBjaXRlZCBieSBUaG9t
YXMsIHdoaWNoDQo+IHdvdWxkIGltcGxlbWVudCBwYXJ0IG9mIHRoZSBtb2NrdXAuIEJ1dCB0aGUg
c2NvcGUgb2YgdGhlIG9yaWdpbmFsIHBhdGNoIHNlcmllcw0KPiB3b3VsZCByZW1haW4sIHNvIG5v
IGNoYW5nZXMgdG8gQVJUIGNvbnZlcnNpb24gY29kZSwgbm8gaW50cm9kdWN0aW9uIG9mIHRoZQ0K
PiBjbG9ja3NvdXJjZV9iYXNlIGNvbmNlcHQuLi4gVGhlIHBhdGNoIHNlcmllcyBzaG91bGQgc3Rp
bGwgYmUgY29tcGF0aWJsZSB3aXRoDQo+IFRob21hcycgcHJvcG9zYWwsIHRob3VnaC4NCj4gDQo+
IEkgd2FzIHdvbmRlcmluZyBpZiBpdCB3b3VsZCBtYWtlIHNlbnNlIHRvIGNvb3JkaW5hdGUgdGhl
IHBvc3Rpbmcgb2YgbXkgcGF0Y2gNCj4gc2VyaWVzLiBJIHBsYW5uZWQgdG8gcG9zdCB0aGUgc2Vy
aWVzIHNvbWV0aW1lIGluIE5vdmVtYmVyIGFsb25nIHdpdGggb3RoZXINCj4gc3R1ZmYsIGJ1dCBJ
IGNvdWxkIHBvdGVudGlhbGx5IHBvc3QgaXQgZWFybGllciBpZiB0aGlzIGNvdWxkIGhlbHAgdG8g
YWxpZ24uDQo+IA0KPiBJbiBjYXNlIG9mIGludGVyZXN0IGluIGFsaWduaW5nLCBJIHVwbG9hZGVk
IGFuIHVudmVyaWZpZWQgcHJldmlldyBmb3IgdGhlIHVwY29taW5nDQo+IHNlcmllcyB0byBbMV0u
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IA0KPiBQZXRlcg0KPiANCj4gWzFdIGh0dHBzOi8vZ2l0
aHViLmNvbS9PcGVuU3luZXJneS9saW51eC5naXQgY2xvY2tzb3VyY2UtaWQtZm9yLQ0KPiBnZXRf
ZGV2aWNlX3N5c3RlbV9jcm9zc3RzdGFtcC12Mi1wcmV2aWV3DQoNCkhpIFBldGVyLA0KDQpUaGFu
a3MgZm9yIHRoZSBwYXRjaGVzLg0KIA0KQWxvbmcgd2l0aCB0aGUgcGF0Y2ggeW91IHNoYXJlZCwg
d2UgaGF2ZSB2ZXJpZmllZCB0aGUgbW9ja3VwIGNvZGUgc2hhcmVkIGJ5IFRob21hcy4NCg0KUGxl
YXNlIGxldCB1cyBrbm93IHdoZW4geW91IGFyZSBwbGFubmluZyB0byBwb3N0IHRoZSBwYXRjaGVz
LCB3ZSBjYW4gY28tb3JkaW5hdGUgYW5kIHBvc3QuIA0KDQpSZWdhcmRzDQpMYWtzaG1pIFNvd2ph
bnlhIEQNCg0KDQoNCg0KDQo=
