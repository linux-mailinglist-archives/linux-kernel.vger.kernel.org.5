Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325007C4B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344249AbjJKHHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343944AbjJKHHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:07:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC26890
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697008028; x=1728544028;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DF/gSbAP9x4GDI/28TULmUOJfcGtHV4GawICgR7uA5g=;
  b=CToK+K5LnHORAaWyfL0k0qct/mylZVCPa1mbFOB+67Lg9XWLaQVChkIP
   KchAs6ivzMzEiQC+VnbljL9hocYeIlnP/JxmbukhpG522zFhKSpOl9Utr
   58MpAsnxcfMa+VRsCEVvImkUTYfiBIRRw4DyfZrZPY4SWpZRIuucZWaBR
   5bG/ygoLxjcKpade7mQb0SuGrA5W3hchPfe5IaIaDYAFbNAj+cR2orNIy
   AoN8KzhvbeoR8QDklBltYfKL1K+O9zWLTddTCn6m5nwyXqMx0e5Fnn4pn
   La9oxt0R7vi1R3ZIvHFLmTeVqkdnHBxpVqJTKFcixYKy6aehAFtj7ZrrI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="451089882"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="451089882"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 00:07:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="824056270"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="824056270"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 00:07:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 00:07:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 00:07:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 00:07:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCYleFJG+nkA5qysCwrib2QKtpPLx1TYljRX8xhdGuLFwiM0YJwqHhFx2G78fHVXRevdN8pEvST4ILaMYrpJj975u/aBJNR+kEOWZNsEmnL2SmC893bg+4Yky9a6jQHE18YFKLpBAklAbHpqt5LuZYt4+jJLM1LBDZHGEHl9lAukXir68ho50urZ/RjOVzEgju4r8l9zcO0KbGTHP6n9V51bbSeNQxg67djcupLlFdDcNwWU6D1bsQhc7qo61Ko5YClAO3mlpYLQ0oYEOxFfsczHQak6iu8kibbaHKvnz26mU+LXrB0d9R8eKzxZMEcT+DDryEVFAAtZl55+uKGflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DF/gSbAP9x4GDI/28TULmUOJfcGtHV4GawICgR7uA5g=;
 b=Vc12zXfBcxqzz8o46cfm52VaZGb28JSNRretYSrrMDZAHbdNAWOg+xUZIjHjFc30MmOl2dGJvQxU0UdPLSa99zVx86p13F1OYNCz3bcyV/Wp/o+3327AbvMiFQdTIzttVyIz1tPCu+hH6mjspcUkb2A9L7VFTEL6GPiftCA6uB0wvzJ++22JAJjeWWCJSzS4ogz7rAJFjWGd2zbg2p4yhnYP4lGgMH/LdLG29wqbjTAutcLdUGWFVItJBQ1Obttbl+KypJSi3z6mTuUaCBjXdSFA05eJiHVi5xTr4jNEcEGoWuunVSEeq5Yy084VBC/5edZVPLNFDT42ktyQObY6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by MW4PR11MB7080.namprd11.prod.outlook.com (2603:10b6:303:21a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 07:07:04 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::3346:a9d1:1c70:eec2]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::3346:a9d1:1c70:eec2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 07:07:04 +0000
From:   "Zhang, Tina" <tina.zhang@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 5/6] iommu: Support mm PASID 1:n with sva domains
Thread-Topic: [PATCH v5 5/6] iommu: Support mm PASID 1:n with sva domains
Thread-Index: AQHZ71lrQmeuFVBRWUer3v2RYxTBzrA8eaqAgAZ/cwCAAUdtoA==
Date:   Wed, 11 Oct 2023 07:07:04 +0000
Message-ID: <MW5PR11MB58811797F38979854B2C0F4589CCA@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20230925023813.575016-1-tina.zhang@intel.com>
 <20230925023813.575016-6-tina.zhang@intel.com>
 <ZR/ATxpIfCPRJO6r@Asurada-Nvidia>
 <7d8e895e-5f95-4ab3-b6dc-292b4197bc87@intel.com>
In-Reply-To: <7d8e895e-5f95-4ab3-b6dc-292b4197bc87@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|MW4PR11MB7080:EE_
x-ms-office365-filtering-correlation-id: bf7c6362-b7e6-46cc-4d18-08dbca28ac97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3bfqipBpqSyTQveHumORiDlHHZvQjq9chLRW3U+bQXBmGxX3YcpMZDjedygPECoHzYeyWllGl2zvyuVQFShw6jyMNXIcKZH1Tf3mWSIgBP9eo8dx6BG1wW1KFPD1t30/uqERz41FggGFxIJW+hSiGChcz5W2qtVOwkscVN2FrzJoUl7JTzi8GxbiCBVGSxdohFut8h38TsPvm7G2jOdt0qMtDVwsrjMKMGh8BG7yeL2pLaowr6OXbi8pCcSpmBJM1uaahNxIsHPGgec3b5XA8ii9pzuF9bc5jZ5z3bsrIWMsjC2dK1uVCNq2Zi+5NWDPe+pVnuur3o4g+7tNp4AjSvgHLkYBF0yJD3qOIHBj75Jznp+rRurltQ8VXVEXbgR6r1fk2ichz821Fcs/YLl0akbOb8LH/bhgU7cApw/2UtCl9f3XP2Vc0xDlkSk/nFumTbgfajKxypP96h+ihjAGcPKwYOZ7x4467v8xU/eyejvPlCXsi8d3XatSzLU+scc880zzlwdLeiL1i/HLG5oQNw/WycWUtiEqcTxpCfSYXEchf/3uSOCEjXmvANAedGxmLpJtJXbgAwOdM0uvIvMTjeoh+LnNfPBOtoTAC3bODcI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(55016003)(9686003)(478600001)(33656002)(966005)(86362001)(53546011)(6506007)(7696005)(71200400001)(8676002)(8936002)(4326008)(122000001)(38070700005)(38100700002)(52536014)(5660300002)(82960400001)(316002)(6916009)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(2906002)(41300700001)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dU83eDZmUUM5aUg4TmdYY3hGU2pQQy80d3hTWHlyRnNXVmw1eXdWVG4rOGNF?=
 =?utf-8?B?ZWM1dXpsY3h4UHNodmRFSXNoWFhJUDBtT1ZNQTV2allqTjFtVmh4Uko5R0Rz?=
 =?utf-8?B?RDhHL3FQb1lGUEgrSjRqc2k4QVBlbHlPZmFpMFYxclBmZ2NrNTJNTTdHUXV2?=
 =?utf-8?B?WWwwYzNsUy9xV2NqdnRVcGl2MXBObm8vWk9FZ01uRElMUERIS2UwSjNrR01F?=
 =?utf-8?B?eWkzNlR3RVdBU1NnMjhHU2QyUldadTVLYjZSL3ZPSmJ2TlJVczB0cm1tMEhK?=
 =?utf-8?B?YmJXN2FzaFJsb1JVY3FGZ1BEQmVIZzVNeGpic2ZzUm5zWDV1N1FFL250Qlgv?=
 =?utf-8?B?M0FneVhTRlAvNFhvZnNYUFlHOWJpMFNkM3c4aHlrOHVXR1Q4cGNYODI2RG9F?=
 =?utf-8?B?Y3MrZmtRZnZHM1BoTm1EYXhBeXF1R24zUVczL2h2M3c4a3p0bUJwUmg4emRs?=
 =?utf-8?B?S0dIakMvbWV4MitMOTBZSDU4ZFhMZVFWcXFEMEpiMmZXdWxXT25Rci95Wndo?=
 =?utf-8?B?TjNHOGhxbmNmYmcwZzdFYVBYTDZaUUtVdmgwcmM5L0xrMWVQdG00alZFOGI5?=
 =?utf-8?B?NEl2ZE1kU1VWTEdNNk9mYlkrQkFtdW41UGxaRnI2cTRQSExDR2owRE1tcDhE?=
 =?utf-8?B?SmRwc0k0TEZFcGxjMWo4YWJyUnBwR05BKzVBY2dXbVhhbWJJcXcwME5QKzhh?=
 =?utf-8?B?WldySDcvcVJLNWNvbE5EZml1SmNCZVVML3JabTJONk5vTEJJSHY5MG80d21G?=
 =?utf-8?B?NXp4Z3QyUmE1MXhvYkxZaEJJeXBTc1h6OU9QNWlIYzlqUllyN2FCZmU3NVQ1?=
 =?utf-8?B?bTV0VCtvc25BeDM4TGZTSHJ2ditWWmZtTnlxS2M4V3JTM2NwZmZHMzVaaXdF?=
 =?utf-8?B?Sjgzd0tyM2JMZ01HOUlMcVdQd04rTUR6Z01YRjhDZ05xY2JXbERCeGdjcXJq?=
 =?utf-8?B?Z05aUWllKytzUG9OL0JIWnYzcE5xQ1RSYkttNXpNc2hJYm9PVnBYK0h5QmhK?=
 =?utf-8?B?a0pGOS9yYjhkd2V5TEl6Sk03QUV6by83WGNhUWRTVDhpL3RKUDYwOEJrcklO?=
 =?utf-8?B?aCsxM3UwL1c5bW1BTjNLaENOQTVDWDVmY2JWaFZ2TXEvdHQ5bjd5SmpUNjlH?=
 =?utf-8?B?YmVRQmQ4WFR2K096VkkyaHd4RmpZVERnd0M4a2NJRTd4ZVBjajJDOXowQUVv?=
 =?utf-8?B?MVFDWnRKSkorakVLYWc0TDNUdGE4TkgxTGxYTGtON3cveERTWmxSSVE5cVZw?=
 =?utf-8?B?azV1TXVrWHlMengwdktGY2ZTSkJKbUxxMmtWaCtUSjFINGs3OFlJRWJkVURv?=
 =?utf-8?B?NVFDY1JyVmZVUjJGTHd1ZHhVc1cwVUVGTGZKdldjSU9WTnM4ZWVnUmhSbDNz?=
 =?utf-8?B?bGFjVHlpVnM0dXJ0VzR0OW9qMytlWnh0S2JjRUZlQjhNaWl6RVp3RVY5UzVz?=
 =?utf-8?B?OTRFQVNLY3ZRS0R5eEovNkkvRE9rdmE1V0dWK2crL1lLV1J6MDE0bkJaQ2Vw?=
 =?utf-8?B?ZUwvc1FJZHFyY3RHd25WbVZ0RnZvZTdTYzRoTWxtM29BeEFmcTRzVi9sSjIw?=
 =?utf-8?B?YVRXZEFXODhZYXZidENOWXpNTURVcW9GZElpNXNRajg1MmQwNTJobVdxcUlR?=
 =?utf-8?B?dSsvMjRnRERieWdQK3NTUEhLU0cxaHAzNVdqVGhXNnBLZ2FrYUc0bkh2cFcx?=
 =?utf-8?B?QjhOMU9LbjJRTnpURjJCQ0FWbWMxVkFaQm84QkhXWTBlandLbWpaZE5hdFVK?=
 =?utf-8?B?cnhrUTcrbkNsa1gxZXVVUVNjTUpxNE4vUHo2VUlRR2dHWldzM2hCNFBGUjhr?=
 =?utf-8?B?bjQ4TWxZbVRudVpqWldVSjBmajJxZklhbEN2WWF2RUZmVmdOY1pxbHZhLzVv?=
 =?utf-8?B?SnFGbjhEcktHMi83c2t2ejhxUU9qVCtTV01GZ3VKYU1LdlBYblZEc1VuNDFz?=
 =?utf-8?B?VHh1RDFYZ1Z1Y0Z6QXJSTi82Ym1GQmtkMlIvOVNPNDRSTW9WZ1RwMXZqMHQy?=
 =?utf-8?B?KzVDeWdmSElDRWhBVXlvbnFrVTE4QmJLQVV4Ry9rcCt4YjBUM2xZSm9YOGQw?=
 =?utf-8?B?MTA0T1FsTGxTcGNPT01uMXpXTXBYbG03RlJEOVJyMnJXVlBEWldsOVJFNE96?=
 =?utf-8?Q?fq6Soy+eX5zYV+H/7ZbFdozOX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7c6362-b7e6-46cc-4d18-08dbca28ac97
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 07:07:04.5669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/kHl9acqLjYDHUqcYNOiB5Xx32SS3GIuH36vfEyZRXWSjFikempSsozmencmi6/64HMhAZK9ONBr4OMMiAsNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7080
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmljb2xpbiwNCg0KVGhlIHY2IHZlcnNpb24gaGFzIHN1Ym1pdHRlZDogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMjAyMzEwMTEwNjUxMzIuMTAyNjc2LTEtdGluYS56aGFu
Z0BpbnRlbC5jb20vDQoNCkluIHY2IHZlcnNpb24sIHdlIG1ha2UgdGhlIGlvbW11X3N2YV9sb2Nr
IGhvbGRpbmcgYXMgYSBwcmVjb25kaXRpb24gZm9yIGlvbW11X2FsbG9jX21tX2RhdGEoKS4gQWx0
aG91Z2ggSSB0aGluayB0aGUgaXNzdWUgeW91IG1ldCBwcm9iYWJseSB3YXNuJ3QgY2F1c2VkIGJ5
IHRoZSBpb21tdV9zdmFfbG9jayBob2xkaW5nIGxvZ2ljIGluIGlvbW11X3N2YV9iaW5kX2Rldmlj
ZSgpIG9mIHY1IHBhdGNoLXNldC4gSSBndWVzcyBpdCdzIHdvcnRoIGEgdHJ5Lg0KDQpSZWdhcmRz
LA0KLVRpbmENCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBaaGFuZywg
VGluYQ0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDEwLCAyMDIzIDc6MjIgUE0NCj4gVG86IE5p
Y29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gQ2M6IEphc29uIEd1bnRob3JwZSA8
amdnQHppZXBlLmNhPjsgVGlhbiwgS2V2aW4gPGtldmluLnRpYW5AaW50ZWwuY29tPjsgTHUNCj4g
QmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT47IE1pY2hhZWwgU2hhdml0IDxtc2hhdml0
QGdvb2dsZS5jb20+Ow0KPiBWYXNhbnQgSGVnZGUgPHZhc2FudC5oZWdkZUBhbWQuY29tPjsgaW9t
bXVAbGlzdHMubGludXguZGV2OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHY1IDUvNl0gaW9tbXU6IFN1cHBvcnQgbW0gUEFTSUQgMTpuIHdp
dGggc3ZhIGRvbWFpbnMNCj4gDQo+IEhpIE5pY29saW4sDQo+IA0KPiBPbiAxMC82LzIzIDE2OjA3
LCBOaWNvbGluIENoZW4gd3JvdGU6DQo+ID4gSGkgVGluYSwNCj4gPg0KPiA+IE9uIFN1biwgU2Vw
IDI0LCAyMDIzIGF0IDA3OjM4OjEyUE0gLTA3MDAsIFRpbmEgWmhhbmcgd3JvdGU6DQo+ID4NCj4g
Pj4gRWFjaCBtbSBib3VuZCB0byBkZXZpY2VzIGdldHMgYSBQQVNJRCBhbmQgY29ycmVzcG9uZGlu
ZyBzdmEgZG9tYWlucw0KPiA+PiBhbGxvY2F0ZWQgaW4gaW9tbXVfc3ZhX2JpbmRfZGV2aWNlKCks
IHdoaWNoIGFyZSByZWZlcmVuY2VkIGJ5DQo+ID4+IGlvbW11X21tIGZpZWxkIG9mIHRoZSBtbS4g
VGhlIFBBU0lEIGlzIHJlbGVhc2VkIGluIF9fbW1kcm9wKCksIHdoaWxlDQo+ID4+IGEgc3ZhIGRv
bWFpbiBpcyByZWxlYXNlZCB3aGVuIG5vIG9uZSBpcyB1c2luZyBpdCAodGhlIHJlZmVyZW5jZSBj
b3VudA0KPiA+PiBpcyBkZWNyZW1lbnRlZCBpbiBpb21tdV9zdmFfdW5iaW5kX2RldmljZSgpKS4g
SG93ZXZlciwgYWx0aG91Z2ggc3ZhDQo+ID4+IGRvbWFpbnMgYW5kIHRoZWlyIFBBU0lEIGFyZSBz
ZXBhcmF0ZSBvYmplY3RzIHN1Y2ggdGhhdCB0aGVpciBvd24gbGlmZQ0KPiA+PiBjeWNsZXMgY291
bGQgYmUgaGFuZGxlZCBpbmRlcGVuZGVudGx5LCBhbiBlbnFjbWQgdXNlIGNhc2UgbWF5IHJlcXVp
cmUNCj4gPj4gcmVsZWFzaW5nIHRoZSBQQVNJRCBpbiByZWxlYXNpbmcgdGhlIG1tIChpLmUuLCBv
bmNlIGEgUEFTSUQgaXMNCj4gPj4gYWxsb2NhdGVkIGZvciBhIG1tLCBpdCB3aWxsIGJlIHBlcm1h
bmVudGx5IHVzZWQgYnkgdGhlIG1tIGFuZCB3b24ndA0KPiA+PiBiZSByZWxlYXNlZCB1bnRpbCB0
aGUgZW5kIG9mIG1tKSBhbmQgb25seSBhbGxvd3MgdG8gZHJvcCB0aGUgUEFTSUQNCj4gPj4gYWZ0
ZXIgdGhlIHN2YSBkb21haW5zIGFyZSByZWxlYXNlZC4gVG8gdGhpcyBlbmQsIG1tZ3JhYigpIGlz
IGNhbGxlZA0KPiA+PiBpbiBpb21tdV9zdmFfZG9tYWluX2FsbG9jKCkgdG8gaW5jcmVtZW50IHRo
ZSBtbSByZWZlcmVuY2UgY291bnQgYW5kDQo+ID4+IG1tZHJvcCgpIGlzIGludm9rZWQgaW4NCj4g
Pj4gaW9tbXVfZG9tYWluX2ZyZWUoKSB0byBkZWNyZW1lbnQgdGhlIG1tIHJlZmVyZW5jZSBjb3Vu
dC4NCj4gPj4NCj4gPj4gU2luY2UgdGhlIHJlcXVpcmVkIGluZm8gb2YgUEFTSUQgYW5kIHN2YSBk
b21haW5zIGlzIGtlcHQgaW4gc3RydWN0DQo+ID4+IGlvbW11X21tX2RhdGEgb2YgYSBtbSwgdXNl
IG1tLT5pb21tdV9tbSBmaWVsZCBpbnN0ZWFkIG9mIHRoZSBvbGQNCj4gPj4gcGFzaWQgZmllbGQg
aW4gbW0gc3RydWN0LiBUaGUgc3ZhIGRvbWFpbiBsaXN0IGlzIHByb3RlY3RlZCBieQ0KPiBpb21t
dV9zdmFfbG9jay4NCj4gPj4NCj4gPj4gQmVzaWRlcywgdGhpcyBwYXRjaCByZW1vdmVzIG1tX3Bh
c2lkX2luaXQoKSwgYXMgd2l0aCB0aGUgaW50cm9kdWNlZA0KPiA+PiBpb21tdV9tbSBzdHJ1Y3R1
cmUsIGluaXRpYWxpemluZyBtbSBwYXNpZCBpbiBtbV9pbml0KCkgaXMgdW5uZWNlc3NhcnkuDQo+
ID4+DQo+ID4+IFJldmlld2VkLWJ5OiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29t
Pg0KPiA+PiBSZXZpZXdlZC1ieTogVmFzYW50IEhlZ2RlIDx2YXNhbnQuaGVnZGVAYW1kLmNvbT4N
Cj4gPj4gU2lnbmVkLW9mZi1ieTogVGluYSBaaGFuZyA8dGluYS56aGFuZ0BpbnRlbC5jb20+DQo+
ID4NCj4gPj4gQEAgLTEyOCw4ICsxNDIsOSBAQCB2b2lkIGlvbW11X3N2YV91bmJpbmRfZGV2aWNl
KHN0cnVjdCBpb21tdV9zdmENCj4gKmhhbmRsZSkNCj4gPj4gICAgICAgICAgc3RydWN0IGRldmlj
ZSAqZGV2ID0gaGFuZGxlLT5kZXY7DQo+ID4+DQo+ID4+ICAgICAgICAgIG11dGV4X2xvY2soJmlv
bW11X3N2YV9sb2NrKTsNCj4gPj4gKyAgICAgICBpb21tdV9kZXRhY2hfZGV2aWNlX3Bhc2lkKGRv
bWFpbiwgZGV2LCBwYXNpZCk7DQo+ID4+ICAgICAgICAgIGlmICgtLWRvbWFpbi0+dXNlcnMgPT0g
MCkgew0KPiA+PiAtICAgICAgICAgICAgICAgaW9tbXVfZGV0YWNoX2RldmljZV9wYXNpZChkb21h
aW4sIGRldiwgcGFzaWQpOw0KPiA+PiArICAgICAgICAgICAgICAgbGlzdF9kZWwoJmRvbWFpbi0+
bmV4dCk7DQo+ID4+ICAgICAgICAgICAgICAgICAgaW9tbXVfZG9tYWluX2ZyZWUoZG9tYWluKTsN
Cj4gPj4gICAgICAgICAgfQ0KPiA+PiAgICAgICAgICBtdXRleF91bmxvY2soJmlvbW11X3N2YV9s
b2NrKTsgQEAgLTIwOSw0ICsyMjQsNSBAQCB2b2lkDQo+ID4+IG1tX3Bhc2lkX2Ryb3Aoc3RydWN0
IG1tX3N0cnVjdCAqbW0pDQo+ID4+ICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+Pg0KPiA+
PiAgICAgICAgICBpb21tdV9mcmVlX2dsb2JhbF9wYXNpZChtbV9nZXRfcGFzaWQobW0pKTsNCj4g
Pj4gKyAgICAgICBrZnJlZShtbS0+aW9tbXVfbW0pOw0KPiA+DQo+ID4gSSByYW4gc29tZSBTVkEg
dGVzdHMgYnkgYXBwbHlpbmcgdGhpcyBzZXJpZXMgb24gdG9wIG9mIG15IGxvY2FsDQo+ID4gU01N
VXYzIHRyZWUsIHRob3VnaCBpdCBpcyBub3QgZXhhY3RseSBhIHZhbmlsbGEgbWFpbmxpbmUgdHJl
ZS4NCj4gPiBBbmQgSSBzZWUgYSBXQVJOX09OIGludHJvZHVjZWQgYnkgdGhpcyBwYXRjaCAoZGlk
IGdpdC1iaXNlY3QpOg0KPiA+DQo+ID4gWyAgMzY0LjIzNzMxOV0gLS0tLS0tLS0tLS0tWyBjdXQg
aGVyZSBdLS0tLS0tLS0tLS0tIFsgIDM2NC4yMzczMjhdDQo+ID4gaWRhX2ZyZWUgY2FsbGVkIGZv
ciBpZD0xMiB3aGljaCBpcyBub3QgYWxsb2NhdGVkLg0KPiA+IFsgIDM2NC4yMzczNDZdIFdBUk5J
Tkc6IENQVTogMiBQSUQ6IDExMDAzIGF0IGxpYi9pZHIuYzo1MjUNCj4gPiBpZGFfZnJlZSsweDEw
Yy8weDFkMCAuLi4uDQo+ID4gWyAgMzY0LjIzNzQxNV0gcGMgOiBpZGFfZnJlZSsweDEwYy8weDFk
MCBbICAzNjQuMjM3NDE2XSBsciA6DQo+ID4gaWRhX2ZyZWUrMHgxMGMvMHgxZDAgLi4uLg0KPiA+
IFsgIDM2NC4yMzc0MzldIENhbGwgdHJhY2U6DQo+ID4gWyAgMzY0LjIzNzQ0MF0gIGlkYV9mcmVl
KzB4MTBjLzB4MWQwDQo+ID4gWyAgMzY0LjIzNzQ0Ml0gIGlvbW11X2ZyZWVfZ2xvYmFsX3Bhc2lk
KzB4MzAvMHg1MCBbICAzNjQuMjM3NDQ5XQ0KPiA+IG1tX3Bhc2lkX2Ryb3ArMHg0NC8weDcwIFsg
IDM2NC4yMzc0NTJdICBfX21tZHJvcCsweGY0LzB4MjEwIFsNCj4gPiAzNjQuMjM3NDU3XSAgZmlu
aXNoX3Rhc2tfc3dpdGNoLmlzcmEuMCsweDIzOC8weDJlOA0KPiA+IFsgIDM2NC4yMzc0NjBdICBz
Y2hlZHVsZV90YWlsKzB4MWMvMHgxYjggWyAgMzY0LjIzNzQ2Ml0NCj4gPiByZXRfZnJvbV9mb3Jr
KzB4NC8weDIwIFsgIDM2NC4yMzc0NjZdIGlycSBldmVudCBzdGFtcDogMCBbDQo+ID4gMzY0LjIz
NzQ2N10gaGFyZGlycXMgbGFzdCAgZW5hYmxlZCBhdCAoMCk6IFs8MDAwMDAwMDAwMDAwMDAwMD5d
IDB4MCBbDQo+ID4gMzY0LjIzNzQ3MF0gaGFyZGlycXMgbGFzdCBkaXNhYmxlZCBhdCAoMCk6IFs8
ZmZmZmMwYzE2MDIyZTU1OD5dDQo+ID4gY29weV9wcm9jZXNzKzB4NzcwLzB4MWM3OCBbICAzNjQu
MjM3NDczXSBzb2Z0aXJxcyBsYXN0ICBlbmFibGVkIGF0DQo+ID4gKDApOiBbPGZmZmZjMGMxNjAy
MmU1NTg+XSBjb3B5X3Byb2Nlc3MrMHg3NzAvMHgxYzc4IFsgIDM2NC4yMzc0NzVdDQo+ID4gc29m
dGlycXMgbGFzdCBkaXNhYmxlZCBhdCAoMCk6IFs8MDAwMDAwMDAwMDAwMDAwMD5dIDB4MCBbICAz
NjQuMjM3NDc2XQ0KPiA+IC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiA+
DQo+ID4gSSBoYXZlbid0IHRyYWNlZCBpdCBjbG9zZWx5IHRvIHNlZSB3aGF0J3Mgd3JvbmcsIGR1
ZSB0byBzb21lIG90aGVyDQo+ID4gdGFza3MuIFlldCwgaWYgeW91IGhhdmUgc29tZSBpZGVhIGFi
b3V0IHRoaXMgb3Igc29tZXRoaW5nIHRoYXQgeW91DQo+ID4gd2FudCBtZSB0byB0cnksIGxldCBt
ZSBrbm93Lg0KPiBUaGFua3MgZm9yIHJlcG9ydGluZyB0aGlzIGlzc3VlLiBJIGRpZCBzb21lIHN2
YSB0ZXN0cywgYnV0IGRpZG4ndCBydW4gaW50byB0aGlzDQo+IGlzc3VlLiBJJ20gZ29pbmcgdG8g
dHJ5IG1vcmUgY2FzZXMgYW5kIGxldCB5b3Uga25vdyBpZiBJIGNhbiBmaW5kIGFueXRoaW5nDQo+
IGludGVyZXN0aW5nLg0KPiANCj4gDQo+IFJlZ2FyZHMsDQo+IC1UaW5hDQo+IA0KPiA+DQo+ID4g
VGhhbmtzDQo+ID4gTmljb2xpbg0K
