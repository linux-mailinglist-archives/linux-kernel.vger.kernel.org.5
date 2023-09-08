Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D30B798E73
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbjIHSxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjIHSxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:53:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFD71716
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 11:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694199195; x=1725735195;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aDhAQoEq9l1XWO/RbZT6QpFJdOCdlytBU+B0jsYhZx8=;
  b=EKGAF3Mfh4a8CT0PFMnaXTEqxT3pYZETeWLMrWxQWkQG4EoQMbVXfAQ0
   /l1nnyUHIMFcnTuqREWrnq1B3kVx3Yr/SmykY4AAN/wJZYyOLNx4yYCvO
   RmEfzVKk++k0Er3xl7FyJ3v0FbGAhr3X0O8K5bC4fAP0Tt/UKvdD5s/IL
   vyewVADH1FRRqcdZUNtvDoSD8uaTQD3rnVsyeNgeeN/1WScY/bXActPTi
   fHFv/GUHZlhgjXKqoMeGifMS6sGGDFphLQSBsJ1QfqVC46ERckAnuaE71
   fllth6PTUKVXeOJWQzunh/k9gn12QGbD7gYvp50aERI40GY6zPQJrgT6C
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="444153473"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="444153473"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 11:51:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="719247106"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="719247106"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 11:51:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 11:51:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 11:51:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 11:51:09 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 8 Sep 2023 11:51:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMaTcmhsay1TNpU0A00gpJGnFZsDB5yb5/bFxisSzrC8oMcNkM0PsYHv47QILiVOTGpCnE3eT7vbr0sOJo5UY95y5QiRPI4WAHNHCgcfWF17UIlJgTEpK7Gh935TrcLl5w/M1E2hoRAfVHiDdMCORs7IQfqtoPUEELafDHvoCtSfTBr8mM3j2/uiPFKH9ZQiPcnFi+iw1Z11oZmEBn3xvRSx+uKV0hHdAJSVCSQaUCABZX4nJUpTkfm7gq3xJPmDJkSYYdpPj4Kz3ZnY/oDxyTM4CCs+79W18OlVZAY6FHL8tGbQLhs3ljq1YlXTi0V5jfMM4xW88KhLrYfhVgSHMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDhAQoEq9l1XWO/RbZT6QpFJdOCdlytBU+B0jsYhZx8=;
 b=YJxKystqzucffaX9zXqjHUYLIrDEj78jSz77umr6P4b1NnIzAAdkh6YIiI7xp2my8JO0mei1zyBQjExgRc3uciY5EIkvc3rL7NjxEGoKkvDCU6QjjTg5lzNZQl+rnAfbk/FDOn+6qBOylg4cVC5N6d016PVEleYMSNbpdrjdT5QN9pxD4wn3VQlZRDahNQzYFpnvbdJjZV56remkgqiZ83r+yU24inYVQSln3Rdd4Lqx2jFi7D8mnyWYT1ZqkBIgZOK0eMLYIMmZuV0EUF7eY1lCyrmvJGvIY3aZ7hWEpgnRrRrB0DeefxsYNr5vLNJgaam+Hql8/lHeL/95HUJM6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB5278.namprd11.prod.outlook.com (2603:10b6:5:389::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 18:51:04 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4%6]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 18:51:04 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "babu.moger@amd.com" <babu.moger@amd.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>
CC:     Amit Singh Tomar <amitsinght@marvell.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "peternewman@google.com" <peternewman@google.com>,
        Drew Fustini <dfustini@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: resctrl2 - status
Thread-Topic: resctrl2 - status
Thread-Index: AdnWr6S/HyyETPT3Q2GfFYcuexQ3cgAzIiMAAACLZdAAAe7MAAAAiPEQAAJWSAAABd7ETACFeeDQAjAruw4AAQHi8A==
Date:   Fri, 8 Sep 2023 18:51:03 +0000
Message-ID: <SJ1PR11MB6083849D1AEF44806C4D669AFCEDA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <DS7PR11MB6077FE180B11A9138D8E7ED7FC1DA@DS7PR11MB6077.namprd11.prod.outlook.com>
 <35f05064-a412-ad29-5352-277fb147bbc4@intel.com>
 <SJ1PR11MB6083BC6B330FA7B7DFD3E76AFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <dc4cd365-2a02-32a3-da78-7ba745877e97@intel.com>
 <SJ1PR11MB6083C0ED50E9B644F4AF8E4BFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <fb9499b9-c445-01e8-8427-6b05256abdb5@intel.com>
 <ZOkU+d4AsLGSAG+y@agluck-desk3>
 <b48fe955-c1b4-4aeb-1ab0-bf26e56e1f0e@intel.com>
 <ZOlRNTq3lE7VNHjU@agluck-desk3>
 <9742f177-a0ce-c5d3-5d92-90dda32f5d07@intel.com>
 <ZPjDHN0nvHz9kWFn@agluck-desk3>
 <18f3a209-8dbf-4837-6bcb-a71a1ee1abb3@amd.com>
In-Reply-To: <18f3a209-8dbf-4837-6bcb-a71a1ee1abb3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB5278:EE_
x-ms-office365-filtering-correlation-id: 2463baed-78f5-4abb-52d1-08dbb09c8d9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VeYIJEJzIZSsATdojGc4WLM/V+pUFwq/P2Ef2WhasSgIcGn2FqtX278ZvFJwcXutBgxTePJO8rvLR/vW/05C7Et+i7wsDgXqrbwZo2rtgty1UDE4yalsT2qo2vbAc1QMiP/m+3hsTBOlwFotaJhix4SwGwqBk769tezACJDH10EpTUwYQrXWcIFAJ7OVHwXOLazNpt/mjd9mb4BYPFjF9wH82KAwEXa+BhX3TvL9i6Cf0Hz6+im61LeBCp1nqfHi9V6csKZ2QXTFBhOgaQQp7ro+NzwbHwB9/iM+MNtdPmBDZoLhn20cE1izIPIjLGq4+j8YfPvXgsMkSQE4XMPN2DiLY3xM6zDE0x0Y5CZVUVCliw4qktO4mcOYh6hsnI/2ZNYNqmyG43bysXHaVCSHKljauLxDNpDYEybIgAZH/IBeoGv+weMWnqs4cSyUGwdX/rKXVExn50yNY3hnl9tT1i/IRbZrBRrPoL3RA/ws+41M6en/Sfn/IxnAVuBaL0ZIlioFc6iyV1IZ7c+5EmXcJiGZ0qUK5vN8IAaqWUQZ3zndjCjCW03tQ2atUnoV1bFLNILT6CgtUG79l1TYgeaZlOZafhkXe7p0pKZdAFtNMgIqU2x9yYqSEE5CrdqumCmH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(1800799009)(186009)(451199024)(2906002)(33656002)(38100700002)(38070700005)(82960400001)(86362001)(122000001)(55016003)(9686003)(316002)(41300700001)(66556008)(6506007)(66476007)(54906003)(64756008)(66446008)(8676002)(76116006)(110136005)(4326008)(8936002)(7696005)(478600001)(71200400001)(66946007)(83380400001)(5660300002)(52536014)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2pRR0U4S1ByeGVzR1VPNk9zRWZGcEc1aitVaUJqSDFWQVNPRjNwNFZwRVpp?=
 =?utf-8?B?Zk9YS1FNWkMzWWpleC9hdWd5K3NYM3dZelVEY0NoRjY1U2RXRVlWVGExdkFD?=
 =?utf-8?B?V2ovNUVWOXpSOHJ3c3NtdjA1blJJOFIzYVBxb0RLdVFvMTFadXpxZzRrMFkw?=
 =?utf-8?B?Y2RLTlNTUys4aitBanNUOHNsN0JLSm9XMFJsRENhdzludERxSjRuQVlOd09z?=
 =?utf-8?B?U1RaVExnVmdvbG0yMHZ0K1FMSnhaV0FSVGZzN0VsMFBIRXlhOU1BUVhIWlB5?=
 =?utf-8?B?Ymwzd0FNdFJmYlRrUHRpN1JHZlIwYTlEZWZKeXJJN1AvWGVFVDR4dnlZY2tI?=
 =?utf-8?B?SEFrdFBvaWxYc0lDODNPT1Y2UzVZUHN1Qjd4MzZ2N2N6bCt4cDJYbjQ1N2V6?=
 =?utf-8?B?MVVLZFR0b3hMMlpMd0ljS0dPcUpZRTZURU93NTdsVEoyN1hlUSt5aXBCSml1?=
 =?utf-8?B?M0NNQU9rcEFEbEU4UWVXdzF2OWpnRXF4QnJOYWIvVjQ1YjVmVTRhc2xoNFBI?=
 =?utf-8?B?WXYxWXdXeDBJb0kvZmdUcml0anRUOEFHVzRlN3ZzQm53aEN3UVRiMit1SXZ5?=
 =?utf-8?B?S2hzZ0VURjdZVWYycEJkR1I4YTR0bXBDME95dUhtc0dzNnYySGtrTkFDa2ts?=
 =?utf-8?B?amxkRm1sNkZDbE1haEZSU3dKV1Ntems2SnFra2tMOFhkU0V4d29Cak9xdFU1?=
 =?utf-8?B?cGNreU1XVmxrRTRkOFZhRVMvY1g1aitwdGFTTnRhMEorZVIxenRZMzE4dlc4?=
 =?utf-8?B?M3ZHZXFia2tnL0U4ZWxleFY2QWh4R0hqWUlSMlRjU1c5R3NqV2p5bGdXMEpq?=
 =?utf-8?B?WUZVRWU1ZXk0UXZSRkN4REdjcXB3c1ZFaGF0dzhuWi9lVkV6YitjYSs2d0tQ?=
 =?utf-8?B?VXMwRzR0ajFRdE9RVWVtY0J3Z0FuNUNMNWJSWU1XOUdmV0UxbFlQQ01QekRJ?=
 =?utf-8?B?eml0MGJEeXYwTjg2SmZNQldlOEZEUUt5T1FNRUxNcFZ3UEV3U0Rib3VVNE13?=
 =?utf-8?B?YVlhc0R1a2tNelFPSmR4UGRnOFZQSzRjS2FnZUZpWHVtd1ZtVGI3TitSbExX?=
 =?utf-8?B?ejVjUEF2OVdJNVpUODBUUWhkSUUvVC9NaFZOaFlmam9MNUJxYWdrdDlLcUx1?=
 =?utf-8?B?NVpxdUtJb1Y2OFNKcjVkOHo2ditzU1VXZmlxUm5BcEZZWEZOYkc4TFRuYXRu?=
 =?utf-8?B?bUtSQVlhOUl6Y3NpMTRjTGczVC9BMDFucTNHTFc5WUNPRGQ5dzZOQTFzZkpV?=
 =?utf-8?B?c1dTOTdEUWZLT3BvRWNsZ2RjMzZJZ29TK0grNGxITWxOODF0TXJhUXpCYW96?=
 =?utf-8?B?b0tMLzNvMElrTDh2UUhBNngrZGtOVGkvYk5BdlI4UzI3elhlZDZPK3NqT0k3?=
 =?utf-8?B?bmNoYXkyZlh3Z0daMlA4Sk10YU9hdldvclM1ZkZuNzhjM0lsT2xXNUVrV0w3?=
 =?utf-8?B?Vm9LNHVGbFhjMnVXbDhYL3h3bStreU42VDQ3K3JTMzhBWEZSN0NieU01WThD?=
 =?utf-8?B?UFRPZXZLNDhpT2t6VG90dXNLQ2VCQnhSZ0kwQVQzZmxIWkJxU3dnSTd0MXlF?=
 =?utf-8?B?NkUzb2IwVVNmZjhhaXNnSXJ0OTNqc2l2d05Gb0RoSVVuMFhqU2NxeEt6ZUdM?=
 =?utf-8?B?cG9rNGh0c2lIMVdKbHF4eTFDLzgxdnlKZE5kekRWdERqTXZ5ZXp4WEYyWnlv?=
 =?utf-8?B?VDB0eFRaWUhBVEVPQzAyU01ucW4yVGtiR1p4K3VBa0VMU0tLZDZKVVQ2V0pi?=
 =?utf-8?B?NHZWazZoY0RiVTRibnpZU05hdHlEcVhQeTZIbWhLcDAwZmMxN3Bmd1c5aFNZ?=
 =?utf-8?B?bjJUUjIrV3FORzUrb2RvTTRGd0RiK292U2crOExaR1QybDE0clRRSjlLVWpn?=
 =?utf-8?B?anNnbUV2QlJPb3JXanNJNm90SXNpYWw5MW4vQ3F6dktWY2NpTy9zY2lUdFZ5?=
 =?utf-8?B?bGJaUkE1S2xGYW1SS0YvTkg4QkVOYjV3Qy8vdjlvQlBibEZUVWFEcUhtL3lF?=
 =?utf-8?B?UjVDeVdWQXNVMzdrRmpQb01UR2ttdGxIRllXSzgwM1Y0dHZoRUtEeFZzR0N2?=
 =?utf-8?B?MGlqWk11QkhXOW1zRm8wN3I1cWwybFZ1UXl5UWszNmJBV3ZyRCtYRytmdCtn?=
 =?utf-8?Q?VPhk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2463baed-78f5-4abb-52d1-08dbb09c8d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 18:51:03.9735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kKlC2PEVXlFFhrLUWeGS7Kjp0kvZZuF8fDrDemYlaS6GW3PTeob04S1wac+8kT1qS25ZldocWQf+ywTGGSAboA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5278
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IENhbiB5b3UgdHJ5IHRoaXMgb3V0IG9uIGFuIEFNRCBzeXN0ZW0uIEkgdGhpbmsgSSBjb3Zl
cmVkIG1vc3Qgb2YgdGhlDQo+ID4gZXhpc3RpbmcgQU1EIHJlc2N0cmwgZmVhdHVyZXMsIGJ1dCBJ
IGhhdmUgbm8gbWFjaGluZSB0byB0ZXN0IHRoZSBjb2RlDQo+ID4gb24sIHNvIHZlcnkgbGlrZWx5
IHRoZXJlIGFyZSBidWdzIGluIHRoZXNlIGNvZGUgcGF0aHMuDQo+ID4NCj4gPiBJJ2QgbGlrZSB0
byBtYWtlIGFueSBuZWVkZWQgY2hhbmdlcyBub3csIGJlZm9yZSBJIHN0YXJ0IGJyZWFraW5nIHRo
aXMNCj4gPiBpbnRvIHJldmlld2FibGUgYml0ZS1zaXplZCBwYXRjaGVzIHRvIGF2b2lkIHRvbyBt
dWNoIGNodXJuLg0KPg0KPiBJIHRyaWVkIHlvdXIgbGF0ZXN0IGNvZGUgYnJpZWZseSBvbiBteSBz
eXN0ZW0uICBVbmZvcnR1bmF0ZWx5LCBJIGNvdWxkDQo+IG5vdCBnZXQgaXQgdG8gd29yayBvbiBt
eSBBTUQgc3lzdGVtLg0KPg0KPiAjIGdpdCBicmFuY2ggLWENCj4gICAgbmV4dA0KPiAqIHJlc2N0
cmwyX3Y2NQ0KPiAjIF0jIHVuYW1lIC1yDQo+IDYuNS4wKw0KPiAjbHNtb2QgfGdyZXAgcmR0DQo+
IHJkdF9zaG93X2lkcyAgICAgICAgICAgMTIyODggIDANCj4gcmR0X21ibV9sb2NhbF9ieXRlcyAg
ICAxMjI4OCAgMA0KPiByZHRfbWJtX3RvdGFsX2J5dGVzICAgIDEyMjg4ICAwDQo+IHJkdF9sbGNf
b2NjdXBhbmN5ICAgICAgMTIyODggIDANCj4gcmR0X2wzX2NhdCAgICAgICAgICAgICAxNjM4NCAg
MA0KPg0KPiAjIGxzbW9kIHxncmVwIG1iZQ0KPiBhbWRfbWJlYyAgICAgICAgICAgICAgIDE2Mzg0
ICAwDQo+DQo+IEkgY291bGQgbm90IGdldCAgcmR0X2wzX21iYQ0KPg0KPiAjIG1vZHByb2JlIHJk
dF9sM19tYmENCj4gbW9kcHJvYmU6IEVSUk9SOiBjb3VsZCBub3QgaW5zZXJ0ICdyZHRfbDNfbWJh
JzogTm8gc3VjaCBkZXZpY2UNCj4NCj4gSSBkb24ndCBzZWUgYW55IGRhdGEgZm9yIHRoZSBkZWZh
dWx0IGdyb3VwIGVpdGhlci4NCj4NCj4gbW91bnQgIC10IHJlc2N0cmwgcmVzY3RybCAvc3lzL2Zz
L3Jlc2N0cmwvDQo+DQo+IGNkIC9zeXMvZnMvcmVzY3RybC9tb25fZGF0YS9tb25fTDNfMDANCj4N
Cj4gY2F0IG1ibV9zdW1tYXJ5DQo+ICAgICAgIG4vYSAgICAgIG4vYSAvDQoNCkJhYnUsDQoNClRo
YW5rIGEgYnVuY2ggZm9yIHRha2luZyB0aGlzIGZvciBhIHF1aWNrIHNwaW4uIFRoZXJlJ3Mgc2V2
ZXJhbCBiaXRzIG9mDQpnb29kIG5ld3MgdGhlcmUuIFNldmVyYWwgbW9kdWxlcyBhdXRvbWF0aWNh
bGx5IGxvYWRlZCBhcyBleHBlY3RlZC4NCk5vdGhpbmcgd2VudCAiT09QUyIgYW5kIGNyYXNoZWQg
dGhlIHN5c3RlbS4NCg0KSGVyZeKAmXMgdGhlIGNvZGUgdGhhdCB0aGUgcmR0X2wzX21iYSBtb2R1
bGUgcnVucyB0aGF0IGNhbiBjYXVzZSBmYWlsdXJlDQp0byBsb2FkIHdpdGggIk5vIHN1Y2ggZGV2
aWNlIg0KDQogICAgICAgIGlmICghYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX1JEVF9BKSkgew0K
ICAgICAgICAgICAgICAgIHByX2RlYnVnKCJObyBSRFQgYWxsb2NhdGlvbiBzdXBwb3J0XG4iKTsN
CiAgICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCiAgICAgICAgfQ0KDQogICAgICAgIG1i
YV9mZWF0dXJlcyA9IGNwdWlkX2VieCgweDEwKTsNCg0KICAgICAgICBpZiAoIShtYmFfZmVhdHVy
ZXMgJiBCSVQoMykpKSB7DQogICAgICAgICAgICAgICAgcHJfZGVidWcoIk5vIFJEVCBNQkEgYWxs
b2NhdGlvblxuIik7DQogICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQogICAgICAgIH0N
Cg0KSSBhc3N1bWUgdGhlIGZpcnN0IHRlc3QgbXVzdCBoYXZlIHN1Y2NlZWRlZCAoc2FtZSBjb2Rl
IGluIHJkdF9sM19jYXQsIGFuZA0KdGhhdCBsb2FkZWQgT0spLiBTbyBtdXN0IGJlIHRoZSBzZWNv
bmQuIEhvdyBkb2VzIEFNRCBlbnVtZXJhdGUgTUJBDQpzdXBwb3J0Pw0KDQpMZXNzIG9idmlvdXMg
d2hhdCBpcyB0aGUgcm9vdCBjYXVzZSBvZiB0aGUgbWJtX3N1bW1hcnkgZmlsZSB0byBmYWlsIHRv
DQpzaG93IGFueSBkYXRhLiByZHRfbWJtX2xvY2FsX2J5dGVzICBhbmQgcmR0X21ibV90b3RhbF9i
eXRlcyAgbW9kdWxlcw0KbG9hZGVkIE9LLiBTbyBJJ20gbG9va2luZyBmb3IgdGhlIHJpZ2h0IENQ
VUlEIGJpdHMgdG8gZGV0ZWN0IG1lbW9yeSBiYW5kd2lkdGgNCm1vbml0b3JpbmcuDQoNCi1Ub255
DQoNCg0K
