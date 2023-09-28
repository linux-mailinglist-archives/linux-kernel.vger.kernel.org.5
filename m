Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35087B201B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjI1OuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjI1Ot6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:49:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCBD1AC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 07:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695912596; x=1727448596;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xGtxJzajLcwAwST3MKGN+WWhcLWGui229XWmxiXqzOI=;
  b=dECLTH443qhZeaZx9cEwKXeT+2HbERPnsETY5oNegS7+2sZP/EAFhamR
   iFuwucYmk4na9rK0h5LUcGzCcgodzjJKxmSHvdb4phcCFqBqXjgkJ0hxR
   k1pjzEgogb2+HdMhvoyIvYX+StKCXCfd6Zu9FKF82SQTauVmn3aSnbeQV
   k8ghmzBLU7u18LTiPcWBYPzaFpxdveyYxSNCS35JeBnTtEeCKl80xvKxq
   Io6xJ4rNRGaiYHypcs7EMSBFuOCeEpaDsho+Lr6WH4Aj51ZKsVoSHtsUH
   vui/xAhqnanRqtr6tfoAsF/uAwLPVO0udkyiKHPyd1A5pj2/ZoUMC69Ai
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="446230659"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="446230659"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:47:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="873318178"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="873318178"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 07:47:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 07:47:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 07:47:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 07:47:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 07:47:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5NIXww4h6aswIlclqlpV77TZ0/IOx6ZeeXainhillpUxQozRVtvmeX+Iu5/jaJzB9jRcIr9i/wdlWBZnHNrnoDLlwlQ3I3Un8zKAIzTbAfarFT7V6K6VifFgDovSvsrwcW+gAXE8Qhzd+wVIdb+oItHHn0H8l4y7kEDz/MdnSvaWlnBPzb4fX8T+//4XJ0krc4tyxVrI+5y5e//ta+YzsXYERMqIHOt23W12ntJ3mGF2+UgzeUmXv5ZxPq7uaENv/jb+OjePMLsQypqkxQTQ8W4hLbd97rcL5BqT02zJOXY/1gT0At++Ck39TayNbSkAI6bhwLCg0RvnIo8cH9BXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGtxJzajLcwAwST3MKGN+WWhcLWGui229XWmxiXqzOI=;
 b=XP6AHEIr7tHdCFFRjMtNBXZQF6BaXpGb9LApltGDCFrqol17K162j018XuH4AVk8kZTsJuDoen5FkHF5IWoLuFjdR4NSrGTc0ad6AinXZxKYk/aO3qzZadLLA+te0f3C9rFmz24e1MWXimYIFRvHXJTgx7Bo8tMr4gqwsNeZP9jRXJ0ln66Zn5tBF8SLt+thy23VpqL3WUs7ogh/TFnHSdQOmTJHnLKgVQ5W+LhKwpsWXZTeyets5FwWyRdtHSt/tb10d++hPtAhsYXZtOQtnhak8rciqclIXFZmP/4HdpAEmuKzg3bBb3aw9oQfup+NERrNevOjc3+4RYSBRn50sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB6870.namprd11.prod.outlook.com (2603:10b6:806:2b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 14:47:32 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4%7]) with mapi id 15.20.6792.026; Thu, 28 Sep 2023
 14:47:32 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Newman <peternewman@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Drew Fustini <dfustini@baylibre.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Amit Singh Tomar <amitsinght@marvell.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "George Cherian" <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jon Masters <jonmasters@google.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: RE: resctrl2 - status
Thread-Topic: resctrl2 - status
Thread-Index: AdnWr6S/HyyETPT3Q2GfFYcuexQ3cgAzIiMAAACLZdAAAe7MAAAAiPEQAAJWSAAABd7ETACFeeDQAjAruw4AAQHi8AAGKjaAAVhq5XwAh8T7AAHy1EUAAAx3gmA=
Date:   Thu, 28 Sep 2023 14:47:13 +0000
Message-ID: <SJ1PR11MB6083C7959787B9816D951E0FFCC1A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <fb9499b9-c445-01e8-8427-6b05256abdb5@intel.com>
 <ZOkU+d4AsLGSAG+y@agluck-desk3>
 <b48fe955-c1b4-4aeb-1ab0-bf26e56e1f0e@intel.com>
 <ZOlRNTq3lE7VNHjU@agluck-desk3>
 <9742f177-a0ce-c5d3-5d92-90dda32f5d07@intel.com>
 <ZPjDHN0nvHz9kWFn@agluck-desk3>
 <18f3a209-8dbf-4837-6bcb-a71a1ee1abb3@amd.com>
 <SJ1PR11MB6083849D1AEF44806C4D669AFCEDA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <09e2894e-eb2b-12a0-c4a2-5000b27bbded@amd.com>
 <ZPuqsupe+BevodqO@agluck-desk3> <ZQSY5P8R5Q+OuvXB@x1>
 <20230918114420.000058c3@Huawei.com>
 <CALPaoCiDrbfAYW1sHgozVUew2wdvuGgkATbO62Dj0BEiQf5cZg@mail.gmail.com>
In-Reply-To: <CALPaoCiDrbfAYW1sHgozVUew2wdvuGgkATbO62Dj0BEiQf5cZg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB6870:EE_
x-ms-office365-filtering-correlation-id: a842436d-6a82-498a-58b7-08dbc031cd59
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V8utAtFrSbsSqJjGyY11dpiDmGZ1+XldU7hz6lbGBjICU/7z0x3o/4SSy8U0FQzDJnZMbX0wBkTFBPV/rqNy4P7vWs4QJ7PSfsIv4lDwg/j0YlFkAyh04Znum5dcM0HHQ+5RTTIk0zKC+MEXR+YR1lZospq5nbs+kC7BEUyDMX/sbWCoHXIlftDiVWc6pAaPI9ZUZVAwzrrEyMaejRIBbCikFNGE8T+K8Bnv+VRumfnlG7jQo9pDo3Bkc/XrzPridZw7Edno4LIe5qqPSsvR128Dh6jvFaeMqGaB2SSn6ZwE/4O+64ox0G2CuFRiL6i6BwhPeAItAxxA13vpq2H4sY4cP7eo1YjBAZD3ni9d/eDLrGz/T3ZtKCindJ0Ibj76wRLP6nYdYbV/eSZtc6LtGj++yTqrs0r5qOTWDpx0gl95TS5zm8QgwY22cMckLOazlbm+LWoQd4uiaC2myL54s5+LJhSEdZz5jNuFNLewHHUuY9j8y5lPGZlXWbeD0Ynrcm/dQJ8F515yC7Rn3X4rBarAyApeM1rr16FoQxBxhi/Momqd34cL/i6o1iQQmhb6vROIuQU2il3lZRqXZGucxt2auRG9GCwckiQUokiJ/JM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(4744005)(2906002)(7416002)(64756008)(110136005)(66446008)(66476007)(5660300002)(54906003)(6666004)(76116006)(52536014)(478600001)(966005)(71200400001)(66556008)(9686003)(66946007)(7696005)(6506007)(26005)(8936002)(316002)(8676002)(4326008)(83380400001)(41300700001)(38070700005)(86362001)(55016003)(82960400001)(38100700002)(122000001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjZKT2FzV0FHSUtnV0ZEa2dNaDNDNk9LdThkYmpLcXA2MjlFeXpIS2cybkZn?=
 =?utf-8?B?L2N2Ui96ZjB6cUpqRXFXMUptb1BKYXMzMHpacUdyR21oMmpmR1NFdFBLZjk0?=
 =?utf-8?B?OEhXVktvU2tKbE04SG5tMFR4cHJNY1dRVW5UaE9iRFdBUXYzNTJ3R1pXVElj?=
 =?utf-8?B?TzdUZU9MazZkcDE2ZDJMYlRnZzRHWXh2b05XN21tc25oWjRjcDgzVTNub1JT?=
 =?utf-8?B?OGFYeG9jL1hIbVpSUERUTFQxNExMN2R1c0s1ejNTMGpGTVFyZkZoekZWemNR?=
 =?utf-8?B?TkZ4aVcveVdMbDcyZXByN3VUb0s4dHUwQmtwWDkydWRYc0xaYWc1VU02dzI4?=
 =?utf-8?B?TjFJMGRFNm5sZTNMNS80L05jVmhDaEppSnhzREhYNmx5WXVPZEVYSDdFT3BH?=
 =?utf-8?B?VUppMnJRQ1ArZVJLV01VRjhWK2I0QWYvTkE0bytXRHJBZVBLamwvMEpnVS95?=
 =?utf-8?B?MHJKdzJpVXBlM0JWWWRhU1JkdHZXZWZZZEd6SlkxWTlyamw5dnJUVGFFWEo0?=
 =?utf-8?B?TTVZbU1uMWt0c01UUG40dHhGTjRjL08xMWh0a0tjNjlucUNUVVd4Y0RjV08w?=
 =?utf-8?B?RXk3eHhaZy9ZbTd6M2JtbUFkUk53ODZwczNYZytnWkRrcVl2RUJKS01LZ2hj?=
 =?utf-8?B?OXdneG1PZnRJMGl3QmlEeGlGbi9LaVU4Y0hnZEVLK2tQUDlyUTJmdk9NNXg0?=
 =?utf-8?B?RXRNNVlodXduVi9Ub29rVGtxQVpYSzkvaTF4T1JnUlhDVE9oQThvUkE3S2ts?=
 =?utf-8?B?S044MDZ4T1d6dDNRMm5QY1o2WS9Ebmk2MzRvYjZXeTdPSnJySzBqNXd0WGg1?=
 =?utf-8?B?NE90dmNKZi9XTFhvOXhxTjdaWmV1MWJydnNhaVdqdWVMVDVVaHk2VDd0V0d3?=
 =?utf-8?B?RmpZTzM3VEl1ckxBRWIrdXV3QkZ4VE9kVnlVckRFTUdiM1oxdTdPcWtncDF4?=
 =?utf-8?B?YkJsdHQ0MUViaG81QVZiUENiNUJyL1F2R29SQm5jM3NhZzdMeG16QU56cHhR?=
 =?utf-8?B?YjdIVFVOaCtXallqa25jQ0h5TjdCU3ZuWG5kUTZneVM3bkFlY0wxaDRFRnRz?=
 =?utf-8?B?YW1ockZwNWQ2RmM3N1pwY1pyUjVmTG9zbU1zclgzVlE1Mk5icnhnT2VyQjZi?=
 =?utf-8?B?VXhWZ1JlQTZDb0Q5S0ZHWTZtRVFTRFZubEpBc0VPUXFPcFdrTVBEaWllZGZl?=
 =?utf-8?B?d3kvQ2dGVmM1dVRxNkw2cEdsVCtBSGVvcVBlRFdRU0pOR0w5b21DcHpWRzVz?=
 =?utf-8?B?SlpzN0o5MFFFOWtpZzIxb2d0dC8xM3N0ZW1TdlJ3dXZnWStQRHZYV0ZPWXAv?=
 =?utf-8?B?akd5SWtTMGNpb0VxSHJSUzVqUWR0ejVYUTI5YmdCNFlmVVNiNWhETDZNSUVT?=
 =?utf-8?B?dFFYSmlhOStYUnk0M2lVbEMvU3hJbUkrblEydVl5M0U1b2c4eGoycGIxMVlz?=
 =?utf-8?B?blA2YnUvbE84YzlQejFvWlE1a3Mwdm9Zc0J2NkNhbk4vckxiQjVBSG9DVWF1?=
 =?utf-8?B?VTVHZG1wK2RUV3NTZ3d1QVdDem5hTjdYUDB1TzBieXE4MmtzUGIzSHVpelVt?=
 =?utf-8?B?MitMYlRkNFNrclhlblI5TlhSRGltQTg5b0RHejJyc1ROOEp6RUgrUjZkSzBl?=
 =?utf-8?B?S0FHdlBJQWtZb2VIZjg3RGdWbzh1Vlo2Z3NGdVlpRXpFZzZQY2tqZnRoU2dx?=
 =?utf-8?B?S1E1V1BHVExqVkovS0c3L25NY1hhRkltVjVZYzliRWJYVWhwYlc2RUxUQm95?=
 =?utf-8?B?Y1NveDN1YlRqV2ZqaWIwM2xySVlUUnJHbFBKNVhHd0VWK3J2bStYbDRvd296?=
 =?utf-8?B?czZ2RlQxRGFhb2hPZ3lleEYyOFRtVFdmYVdpWkN0ejhReGd0S0FiR0xBa0tX?=
 =?utf-8?B?WFpXc3hJdHJaQU1NUjkwYXlrS2lqMkpVcTllVklaZ0hwTmsrV3c5OGhvZEtB?=
 =?utf-8?B?MFNHcW9xM1RpOU9McEcwMjlnN0Y2THFLaDhnMXYrc0JZN0tyR004YWE3UWNw?=
 =?utf-8?B?eDFCN1J2eGc4RjVSNEx4M1ZkQUVvcmt3dkNGYWlXYWVETG1zM2lpU2FsZTZ5?=
 =?utf-8?B?aCszcnhlSUplcHF4aHBOOG0rUnJET09MaDR2MFB4WWlkWC9mSTBLWUdCNjdu?=
 =?utf-8?Q?3DIFvL6nUezChyJkeO0+b2fo8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a842436d-6a82-498a-58b7-08dbc031cd59
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 14:47:13.3750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yT323iwQbvqfl+8PkZBKRF31Gts5UTaXgV34bt3DzISfXpr84tOAQ5P3cj8A4HKdfzhbButr/B7Xd8ugyy4JsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6870
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJIGdvdCB1cyBhIEJvRiBzZXNzaW9uIHRvIHRhbGsgYWJvdXQgcmVzY3RybCBhbmQgcG9ydGlu
ZyBpdCB0byBuZXcNCj4gYXJjaGl0ZWN0dXJlczoNCg0KVGhhbmtzIGZvciBkb2luZyB0aGlzLg0K
DQo+IGh0dHBzOi8vbHBjLmV2ZW50cy9ldmVudC8xNy9jb250cmlidXRpb25zLzE1NjcvDQo+DQo+
IFRvIGFueW9uZSBwbGFubmluZyB0byBhdHRlbmQsIHdoaWxlIHRoZSBzY2hlZHVsZSBpcyBzdGls
bCBlYXN5IHRvDQo+IGFkanVzdCwgcGxlYXNlIGxldCBtZSBrbm93IGlmIHRoZSBwcm9wb3NlZCB0
aW1lIChOb3YgMTUsIDQ6MzAtNToxNXBtKQ0KPiBkb2Vzbid0IHdvcmsuDQoNCkRvIHlvdSBrbm93
IGlmIHRoZSBCb0Ygc2Vzc2lvbnMgYXJlIGdvaW5nIHRvIGJlIHJlbW90ZSBhY2Nlc3NpYmxlPw0K
UGVyc29uYWwgY29uZmxpY3RzIG1lYW4gSSBjYW4ndCBhdHRlbmQgaW4gcGVyc29uLg0KDQotVG9u
eQ0K
