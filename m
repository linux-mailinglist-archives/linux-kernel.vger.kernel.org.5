Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4E07A232C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbjIOQCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbjIOQBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:01:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97C51FDF;
        Fri, 15 Sep 2023 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694793709; x=1726329709;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sre5ihO72So3qO2blFqLXYsF3AzrPRhXI1O0YPj+u1g=;
  b=CxdT+k+rMsjlBX2xniKhF9MWGQYNKNpcqhqWwViot7kvJdVxAXYziND9
   I2SgE/3fLRQPXPyasBJdQlbevXiBxPCUagPtT3YUfW6Zl/wolZaF5Z9n4
   yMYePQ4dkdhyq+c3JP8KVp4v6xFbVXKiZHfAuw+SK++N8E3mRI0tbIQnm
   hsl7+EdeAgeAzKGsTYpc29CDBtk7IbeSZ+/5So/vzI7CwKU1uRdt5EtPe
   TdQn2m5o2zRBQKjSvw7Qf3oj7SfJiwBIrVyOyMmdIe+qU5dQCeSsuBTI5
   cwxQ61+gWsZ3v1vbXCVp9h7kWinzZTDdsts62shNWLHSf3YhtJx9FTCLM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="443342364"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="443342364"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 09:01:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="918697590"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="918697590"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 09:01:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 09:01:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 09:01:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 09:01:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 09:01:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaNGYyJyy8zB2tRHc7ErdtEhvQZZ0ydyE2+PsRPS58o9ypxCpzQj2onQEEui1qyjgtZzm3xdMbkFqSHTnJNaSYCPLi1Kjs9ha9PX5mWGirZ/j/v7ZPhTDlhEbz3FSvOxW7xWUqatV5SSPVMw/u7y47j7M9wb11D/PTnKNp5mf6mUDu5Bogz+Np7xsaOKjhVfQ0bEAwgo/dvLnbB8ZyIQ5rOXuFwXTczkNXux4L5/V0P2EEg2wYFMAYx2GhDlOeX0lI5OssiPfTXBmct6WBazsImpjZcJlGeA3zi/PfBIVvRlLI2uSc7qbADWiEn4pdc7EU6uUpTljp2kwHNJ692yIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sre5ihO72So3qO2blFqLXYsF3AzrPRhXI1O0YPj+u1g=;
 b=Q0o9tXM6NRvJY9qnupn8JkeL/aT3izKtmiPuMDVejZCoSKLNwkXC+IToqUwGng4ReVKFZ+RhTPpq6XHUPauVMZMuCNcyoOQ+ugi9MjrnO85dJ5f6o1F/7CX9FMQaepUISVD94PWBgjWttkGUEkpzT/qHWokRQnQJ1mgxXaDAMlhMayb4wmCadtlB6mcmGBAR2ydpbdjJerYMISS8CVsERuq2m9WhqIIY4om2W8ivM5ZKwiz1FvmToUQDJvkY2ZNvzswaKa4UkwS4tyTxFqna7k0Wjl6rtFgQAtmGVdpoNkzRbTZ5shYTf1v8G2P2yOSV3lcilGdXo49y/9c9zhH5fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by SJ0PR11MB5938.namprd11.prod.outlook.com (2603:10b6:a03:42d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 16:01:44 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::dccd:a041:a764:21f4]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::dccd:a041:a764:21f4%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 16:01:44 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Prashant Malani <pmalani@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH v3 3/4] platform/chrome: cros_ec_typec: Add Displayport
 Alternatemode 2.1 Support
Thread-Topic: [PATCH v3 3/4] platform/chrome: cros_ec_typec: Add Displayport
 Alternatemode 2.1 Support
Thread-Index: AQHZ5RQ8pkufV0PHy0qNPGaCC0iZ37AWY6qAgAWtvqA=
Date:   Fri, 15 Sep 2023 16:01:44 +0000
Message-ID: <MWHPR11MB0048848CD12DC750417E7264A9F6A@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20230912005752.1532888-1-utkarsh.h.patel@intel.com>
 <20230912005752.1532888-4-utkarsh.h.patel@intel.com>
 <CACeCKacmH19niA7gWTZCj89ZmFth0LWvkMYasYwUvVHrmFKCZw@mail.gmail.com>
In-Reply-To: <CACeCKacmH19niA7gWTZCj89ZmFth0LWvkMYasYwUvVHrmFKCZw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0048:EE_|SJ0PR11MB5938:EE_
x-ms-office365-filtering-correlation-id: 294b13e1-447c-4fe0-c707-08dbb6050f06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: at5GCHTrit6QJnxNjQgM/dl9pijUhcDenXsc4SiM8XD9QNQ8iSE9BJU2rHeRh9jn6PHhzSjFEsIdkChnx+eP/D/DBi1lsqn3iecZif8y8yORToXQvFSxbflZ78MibmFduA0cMKF+9Zw759Jnud74QuKz1toeldYjqNct262CvPzg1aNVAGD/WDwdOuiVO178jBeDlPyvw0zoTXlOXw3i39xuI+hfeaaIYrIV4bpH3z8APisiE6nxZZT30+pblsvyk9XmDAnKz4zTEw8lS91RHvX/yZ8QRcOTZ7Bwdb8ytxsq2syI6yKaVAxnouNvgWK7WYmBe0vNjlsEPqvf6+rPeRZ1enoKpDZUxnHY+a8DQkdW6m4qPVOtb2I0aX7vwMTPmU+awefyJT1gRSajJDkyKtOeK5cVg/uGOdp+a4JmtDsyGiucbBC6Jw/kPJ63vHl8XkcR4T0zDHBpgTJ8AKgm7MNidEymNTOZh3PbWgA13Jgi6f6PaxCoS5xc1j3U0G7RPEyl5rFKOod/WQrVJXiqragonw7iqllUv3bbnZs0GRjKo9UDoZin+tDRgvHuJMv0PqIQKU/3uYyw9YRoyi4akGM67pLrYJxUVH0cBeU4FbVD4PlUQ2bngxnqtIirA03y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(346002)(396003)(1800799009)(451199024)(186009)(83380400001)(82960400001)(53546011)(9686003)(2906002)(52536014)(8676002)(6916009)(4326008)(66946007)(33656002)(316002)(66556008)(5660300002)(64756008)(66446008)(66476007)(41300700001)(8936002)(54906003)(55016003)(122000001)(76116006)(478600001)(38100700002)(38070700005)(86362001)(7696005)(71200400001)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWg0SkxUY1ZTUVVnTUkzdG80bE4wSUFmZVg0MDJScUZobVozM3FXMnYrMnM1?=
 =?utf-8?B?OGhUOVgreUFuZXZlTDlrK0k5c0hWY3REVmVkWTJySjJVbkpxQTBpWWdqbFcr?=
 =?utf-8?B?M2RLV0lycHgrVmpvWENRMExEY0tnRm9qNzAvUHZmSk91cjhhd0xtVGZBUmxh?=
 =?utf-8?B?MDNTWGlQRUFTVlgxanBXN1RIaUU1SlU4SlgzQU1KQ1ZDdmR1Q3pYNlY2eDNG?=
 =?utf-8?B?ZlltTFU5R0pTYzJqUVZWVDJNTVhxbTA4YktKWlduc3FxOTRHZ3kxQkF5MEo3?=
 =?utf-8?B?WGZkNEVoUG4wNjlzQXl1R2d1R05OSWNvblVBWEhzckI1Vi9CdFB4WVlOQUJU?=
 =?utf-8?B?YnltQk5hVXo5d00xajFEa3FIWlQ4bDZnUVY1R3BIS0JIeHJ3ZjIvT1ZmMHRV?=
 =?utf-8?B?Mm9DNllQZUU3UXhOdzZ1TjRVR0VoTUtNUmFtdVNMYmVRRVV4UlNlaEZqd2RU?=
 =?utf-8?B?MGczS0VlN2ZIay9DZnVYakdHaWRmaDBPMFhoSTlNVDFCN2NxRzYwa0p4RlB3?=
 =?utf-8?B?WGdXMGJKT3JxL2hqTnVYT3FaRnE3Q0QrWVZJc0RqampOR1R2QlR5b2RFeXVL?=
 =?utf-8?B?SHNJT0pYSFY2Und2MFBNUi8yQ1NKc0Vha3JCeVBBS1RpNnFnTGZ4NUYrOHNK?=
 =?utf-8?B?Qmd2VDFUQzVGdXNldCtibnhFazMrbUhoZnlXeFQydEVSSXBmV1JqMlBJN08v?=
 =?utf-8?B?LzRZUnY3VG5veHlxS0t4SEoyamNoWHltdFhOTGVZZE9laU1oRmg5RUVtQnFC?=
 =?utf-8?B?dWliVFNoTW5LamV5bTU1WDVSZC83ZHMwVVZPSXZIRXNLTnJ1LzFuN3pIYVlm?=
 =?utf-8?B?SmhKSnlYZ3lLWDlmOTFQVVVuVnBhdit2cTl2QnRYZWtlRDdZVys2YW1yMElt?=
 =?utf-8?B?cDd1bUNPYmFGVWZZMjIrRldVaXV0T3h5WWxLTG5IMStUaWdaNzAveUZ6aU9t?=
 =?utf-8?B?QTJITldJZzN6cENYTThCcnluOTB6L29xVW5MckI1M1dOSWNJS1ppSUwzVGlS?=
 =?utf-8?B?VnRXUXlyZGdZM0VwcGJKQ3d6Y2V4RXhYalY3aSs3SFJaUm1rUVVEUWNocE5a?=
 =?utf-8?B?dFB6VlcrZHBRZXZnWnhBaEo4a2ljUjFjYUF1bXlyYUdzZnRKNE8xUWpZcktk?=
 =?utf-8?B?bTQrVk5XaUsyWjkyYXV2eEQycUZCSTZablVuN0FiUkYvb0t4VTMvb3Awc0pC?=
 =?utf-8?B?Z1BveGNtVVRhbmJqWXZIcHczVU9kdy9kdlhqT01KOUEzNGE3SnNvSnV0SnRM?=
 =?utf-8?B?KzRtMkxqcnlhS0g0RHh0RUprVnFJeXY0QVRvYkY1eEVXSlJaZ0NVczJIVkFU?=
 =?utf-8?B?ci9kYW84bjFxcVBxeGRlWGV5YWFjRmhsWmRMTDJxU2M1aGhZVHh6bTN3WHZS?=
 =?utf-8?B?UmFmR09RaGJyV1RFZnBxaXUyKzdPVlRvUFFmRnJ1VXpteGlrQjF0OFh2Q3lD?=
 =?utf-8?B?dnJPVGhHcWkzMm9TcW03eGsvSEVCNnNQZEoxWSt2bU0xR3ltVGtRR0lTM1dk?=
 =?utf-8?B?U0NhT2hOWDZSaFJaVWdrMDlOUm8wbS9peWo2aVM1d0hXK2YwaEtWTkpMNnhw?=
 =?utf-8?B?bmpMN1YwaDlyWlZBWkIvc0VPNWdiRVRXdGZuT3RMb2dka2pJVWxrWDE4L0Q2?=
 =?utf-8?B?RURERWFVVTRWcUJPK3ZVd0VoR2ZMdEw5eUJCOVJCL2w3ampoLzk0eUxrSHVY?=
 =?utf-8?B?VWFJeHpFaWV1NHd4N3JxYTdDR0d0cTZtTDBBMmlZMUxsRHh3ZHJiTGxNVUY2?=
 =?utf-8?B?b2s4UWRmQ0xDVGI4SWlSM21xaXRBZVNCYVc2djlTMWYyUDVZakdJRXlWY1FH?=
 =?utf-8?B?MkNTYzRveWVFeklpT2xoNXRsV3hBZFQ5ZXAvL1lKak91ZWhqNGFDV2pJdTN1?=
 =?utf-8?B?eE5qVkREVUFhWUN4SHNYNDVQeFczWmZWczF3KzlySE1rdlVnWFlaUVh5OENK?=
 =?utf-8?B?WEpQYXNJYlVNZk1kRmVwb3dXbE41eG1wVElLejEyY0FrVTdzTGFCditlQUlP?=
 =?utf-8?B?bFpWNzBlalNNVkhlWVN4VDFIRElnM1RHeGVPODZTaVpZSGxmYnAxb1RuZ3p4?=
 =?utf-8?B?Q3RXRlQ2c2JNZlRpMlEzQVQwUDZPcGJWRm8vdlAwa3JKUFk2S2ovVTJKNnh5?=
 =?utf-8?Q?xZgO9d7prcy7cIuf6N2H/c+Mq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 294b13e1-447c-4fe0-c707-08dbb6050f06
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 16:01:44.5733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FhuLAcGxj0bvkNxkUzR+Ta+a2zc84IONzYvDe6d8f8M22hCYpDXFKUS+oyguWAqAdr29s9yEgGwojQul2iWlTOJk4fl4Lh6K5BxUIyVVfkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5938
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUHJhc2hhbnQsDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQcmFzaGFudCBNYWxhbmkgPHBtYWxhbmlAY2hyb21p
dW0ub3JnPg0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAxMSwgMjAyMyA2OjE4IFBNDQo+IFRv
OiBQYXRlbCwgVXRrYXJzaCBIIDx1dGthcnNoLmgucGF0ZWxAaW50ZWwuY29tPg0KPiBDYzogbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsNCj4g
aGVpa2tpLmtyb2dlcnVzQGxpbnV4LmludGVsLmNvbTsgY2hyb21lLXBsYXRmb3JtQGxpc3RzLmxp
bnV4LmRldjsNCj4gYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tOyBibGV1bmdAY2hy
b21pdW0ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMy80XSBwbGF0Zm9ybS9jaHJvbWU6
IGNyb3NfZWNfdHlwZWM6IEFkZCBEaXNwbGF5cG9ydA0KPiBBbHRlcm5hdGVtb2RlIDIuMSBTdXBw
b3J0DQo+IA0KPiBIaSBVdGthcnNoLA0KPiANCj4gT24gTW9uLCBTZXAgMTEsIDIwMjMgYXQgNTo1
OOKAr1BNIFV0a2Fyc2ggUGF0ZWwgPHV0a2Fyc2guaC5wYXRlbEBpbnRlbC5jb20+DQo+IHdyb3Rl
Og0KPiA+DQo+ID4gRGlzcGxheXBvcnQgQWx0ZXJuYXRlbW9kZSAyLjEgcmVxdWlyZXMgY2FibGUg
Y2FwYWJpbGl0aWVzIHN1Y2ggYXMNCj4gPiBjYWJsZSBzaWduYWxsaW5nLCBjYWJsZSB0eXBlLCBE
UEFNIHZlcnNpb24gd2hpY2ggdGhlbiB3aWxsIGJlIHVzZWQgYnkNCj4gPiBtdXggZHJpdmVyIGZv
ciBkaXNwbGF5cG9ydCBjb25maWd1cmF0aW9uLiBUaGVzZSBjYXBhYmlsaXRpZXMgY2FuIGJlDQo+
ID4gZGVyaXZlZCBmcm9tIHRoZSBDYWJsZSBWRE8uDQo+ID4gQWRkZWQgYSBoZWxwZXIgbWFjcm8g
dG8gZ2V0IHRoZSBUeXBlIEMgY2FibGUgc3BlZWQgd2hlbiBwcm92aWRlZCB0aGUNCj4gPiBjYWJs
ZSBWRE8uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBVdGthcnNoIFBhdGVsIDx1dGthcnNoLmgu
cGF0ZWxAaW50ZWwuY29tPg0KPiANCj4gVGhhbmsgeW91IGZvciBhZGRyZXNzaW5nIHRoZSBjb21t
ZW50cy4gVGhpcyBMR1RNOyBJIGhhdmUgb25lIG1pbm9yDQo+IHN1Z2dlc3Rpb24sIGJ1dCBJJ2xs
IGxlYXZlIGl0IHRvIFVTQiBtYWludGFpbmVycyBmb3IgdGhlIGZpbmFsIGNhbGwgb24gdGhhdA0K
PiBjb21tZW50LCBzbzoNCj4gDQo+IEFja2VkLWJ5OiBQcmFzaGFudCBNYWxhbmkgPHBtYWxhbmlA
Y2hyb21pdW0ub3JnPg0KPiANCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGluIHYzOg0KPiA+IC0gUmVt
b3ZlZCB1c2Ugb2YgdmFyaWFibGUgY2FibGVfc2VlcGQuDQo+ID4gLSBBZGRlZCBoZWxwZXIgbWFj
cm8gb2YgcGRfdmRvLmggaW4gdGhpcyBwYXRjaCBhcyBjcm9zX2VjX3R5cGVjIGlzIHRoZSB1c2Vy
Lg0KPiA+DQo+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiAtIFJlbXZvZWQgZmVhdHVyZSBmbGFnIHNw
ZWNpZmljZSB0byBEUDIuMS4NCj4gPiAtIFJlbXZvZWQgc2VwZXJhdGUgZnVuY3Rpb24gZm9yIERQ
Mi4xLg0KPiA+IC0gUmVtb3ZlZCB1c2Ugb2YgRUMgaG9zdCBjb2FtbW5kIHRvIGdldCBjYWJsZSBk
ZXRhaWxzLg0KPiA+IC0gVEJUIGNhYmxlIFZETyBpcyB1c2VkIHRvIGdldCBjYWJsZSBkZXRhaWxz
Lg0KPiA+IC0gVXNpbmcgVkRPX0NBQkxFX1NQRUVEIG1hY3JvIHRvIGdldCBwYXNzaXZlIGNhYmxl
IHNwZWVkLg0KPiA+DQo+ID4gIGRyaXZlcnMvcGxhdGZvcm0vY2hyb21lL2Nyb3NfZWNfdHlwZWMu
YyB8IDI4DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgaW5jbHVkZS9saW51eC91
c2IvcGRfdmRvLmggICAgICAgICAgICAgIHwgIDEgKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDI5
IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL2No
cm9tZS9jcm9zX2VjX3R5cGVjLmMNCj4gPiBiL2RyaXZlcnMvcGxhdGZvcm0vY2hyb21lL2Nyb3Nf
ZWNfdHlwZWMuYw0KPiA+IGluZGV4IGQwYjRkM2ZjNDBlZC4uY2NhOTEzNDAwYjM5IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvcGxhdGZvcm0vY2hyb21lL2Nyb3NfZWNfdHlwZWMuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvcGxhdGZvcm0vY2hyb21lL2Nyb3NfZWNfdHlwZWMuYw0KPiA+IEBAIC00OTIs
NiArNDkyLDggQEAgc3RhdGljIGludCBjcm9zX3R5cGVjX2VuYWJsZV9kcChzdHJ1Y3QNCj4gPiBj
cm9zX3R5cGVjX2RhdGEgKnR5cGVjLCAgew0KPiA+ICAgICAgICAgc3RydWN0IGNyb3NfdHlwZWNf
cG9ydCAqcG9ydCA9IHR5cGVjLT5wb3J0c1twb3J0X251bV07DQo+ID4gICAgICAgICBzdHJ1Y3Qg
dHlwZWNfZGlzcGxheXBvcnRfZGF0YSBkcF9kYXRhOw0KPiA+ICsgICAgICAgdTMyIGNhYmxlX3Ri
dF92ZG87DQo+ID4gKyAgICAgICB1MzIgY2FibGVfZHBfdmRvOw0KPiA+ICAgICAgICAgaW50IHJl
dDsNCj4gPg0KPiA+ICAgICAgICAgaWYgKHR5cGVjLT5wZF9jdHJsX3ZlciA8IDIpIHsNCj4gPiBA
QCAtNTI0LDYgKzUyNiwzMiBAQCBzdGF0aWMgaW50IGNyb3NfdHlwZWNfZW5hYmxlX2RwKHN0cnVj
dA0KPiBjcm9zX3R5cGVjX2RhdGEgKnR5cGVjLA0KPiA+ICAgICAgICAgcG9ydC0+c3RhdGUuZGF0
YSA9ICZkcF9kYXRhOw0KPiA+ICAgICAgICAgcG9ydC0+c3RhdGUubW9kZSA9IFRZUEVDX01PREFM
X1NUQVRFKGZmcyhwZF9jdHJsLT5kcF9tb2RlKSk7DQo+ID4NCj4gPiArICAgICAgIC8qIEdldCBj
YWJsZSBWRE8gZm9yIGNhYmxlcyB3aXRoIERQU0lEIHRvIGNoZWNrIERQQU0yLjEgaXMgc3VwcG9y
dGVkDQo+ICovDQo+ID4gKyAgICAgICBjYWJsZV9kcF92ZG8gPSBjcm9zX3R5cGVjX2dldF9jYWJs
ZV92ZG8ocG9ydCwNCj4gPiArIFVTQl9UWVBFQ19EUF9TSUQpOw0KPiA+ICsNCj4gPiArICAgICAg
IC8qKg0KPiA+ICsgICAgICAgICogR2V0IGNhYmxlIFZETyBmb3IgdGh1bmRlcmJvbHQgY2FibGVz
IGFuZCBjYWJsZXMgd2l0aCBEUFNJRCBidXQgZG9lcw0KPiBub3QNCj4gPiArICAgICAgICAqIHN1
cHBvcnQgRFBBTTIuMS4NCj4gPiArICAgICAgICAqLw0KPiA+ICsgICAgICAgY2FibGVfdGJ0X3Zk
byA9IGNyb3NfdHlwZWNfZ2V0X2NhYmxlX3Zkbyhwb3J0LA0KPiA+ICsgVVNCX1RZUEVDX1RCVF9T
SUQpOw0KPiA+ICsNCj4gPiArICAgICAgIGlmIChjYWJsZV9kcF92ZG8gJiBEUF9DQVBfRFBBTV9W
RVJTSU9OKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGRwX2RhdGEuY29uZiB8PSBjYWJsZV9kcF92
ZG87DQo+ID4gKyAgICAgICB9IGVsc2UgaWYgKGNhYmxlX3RidF92ZG8pIHsNCj4gPiArICAgICAg
ICAgICAgICAgZHBfZGF0YS5jb25mIHw9ICBUQlRfQ0FCTEVfU1BFRUQoY2FibGVfdGJ0X3Zkbykg
PDwNCj4gPiArIERQX0NPTkZfU0lHTkFMTElOR19TSElGVDsNCj4gPiArDQo+ID4gKyAgICAgICAg
ICAgICAgIC8qIENhYmxlIFR5cGUgKi8NCj4gPiArICAgICAgICAgICAgICAgaWYgKGNhYmxlX3Ri
dF92ZG8gJiBUQlRfQ0FCTEVfT1BUSUNBTCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBk
cF9kYXRhLmNvbmYgfD0gRFBfQ09ORl9DQUJMRV9UWVBFX09QVElDQUwgPDwNCj4gRFBfQ09ORl9D
QUJMRV9UWVBFX1NISUZUOw0KPiA+ICsgICAgICAgICAgICAgICBlbHNlIGlmIChjYWJsZV90YnRf
dmRvICYgVEJUX0NBQkxFX1JFVElNRVIpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZHBf
ZGF0YS5jb25mIHw9IERQX0NPTkZfQ0FCTEVfVFlQRV9SRV9USU1FUiA8PA0KPiBEUF9DT05GX0NB
QkxFX1RZUEVfU0hJRlQ7DQo+ID4gKyAgICAgICAgICAgICAgIGVsc2UgaWYgKGNhYmxlX3RidF92
ZG8gJiBUQlRfQ0FCTEVfQUNUSVZFX1BBU1NJVkUpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgZHBfZGF0YS5jb25mIHw9IERQX0NPTkZfQ0FCTEVfVFlQRV9SRV9EUklWRVIgPDwNCj4gRFBf
Q09ORl9DQUJMRV9UWVBFX1NISUZUOw0KPiA+ICsgICAgICAgfSBlbHNlIGlmIChQRF9JREhfUFRZ
UEUocG9ydC0+Y19pZGVudGl0eS5pZF9oZWFkZXIpID09DQo+IElESF9QVFlQRV9QQ0FCTEUpIHsN
Cj4gPiArICAgICAgICAgICAgICAgZHBfZGF0YS5jb25mIHw9IFZET19UWVBFQ19DQUJMRV9TUEVF
RChwb3J0LQ0KPiA+Y19pZGVudGl0eS52ZG9bMF0pIDw8DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBEUF9DT05GX1NJR05BTExJTkdfU0hJRlQ7DQo+ID4gKyAgICAgICB9DQo+
ID4gKw0KPiA+ICAgICAgICAgcmV0ID0gY3Jvc190eXBlY19yZXRpbWVyX3NldChwb3J0LT5yZXRp
bWVyLCBwb3J0LT5zdGF0ZSk7DQo+ID4gICAgICAgICBpZiAoIXJldCkNCj4gPiAgICAgICAgICAg
ICAgICAgcmV0ID0gdHlwZWNfbXV4X3NldChwb3J0LT5tdXgsICZwb3J0LT5zdGF0ZSk7IGRpZmYN
Cj4gPiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdXNiL3BkX3Zkby5oIGIvaW5jbHVkZS9saW51eC91
c2IvcGRfdmRvLmggaW5kZXgNCj4gPiBiMDU3MjUwNzA0ZTguLjNhNzQ3OTM4Y2RhYiAxMDA2NDQN
Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3VzYi9wZF92ZG8uaA0KPiA+ICsrKyBiL2luY2x1ZGUv
bGludXgvdXNiL3BkX3Zkby5oDQo+ID4gQEAgLTM3Niw2ICszNzYsNyBAQA0KPiA+ICAgICAgICAg
IHwgKCh2Ym0pICYgMHgzKSA8PCA5IHwgKHNidSkgPDwgOCB8IChzYnV0KSA8PCA3IHwgKChjdXIp
ICYgMHgzKSA8PCA1ICAgXA0KPiA+ICAgICAgICAgIHwgKHZidCkgPDwgNCB8IChzb3BwKSA8PCAz
IHwgKChzcGQpICYgMHg3KSkNCj4gPg0KPiA+ICsjZGVmaW5lIFZET19UWVBFQ19DQUJMRV9TUEVF
RCh2ZG8pICAgICAoKHZkbykgJiAweDcpDQo+IA0KPiBJIHdvdWxkIHN1Z2dlc3QgcHV0dGluZyB0
aGlzIGhlYWRlciBtb2RpZmljYXRpb24gaW4gYSBzZXBhcmF0ZSBwYXRjaDsgaWYgZm9yDQo+IHNv
bWUgcmVhc29uIHdlIGhhdmUgdG8gcmV2ZXJ0IHRoZSBDaHJvbWUgcGFydCBvZiB0aGUgY2hhbmdl
LCB0aGVuIHdlIHdvbid0DQo+IHJpcCB0aGlzIHBhcnQgb3V0IHRvbyAoc29tZSBvdGhlciBkcml2
ZXIgZG93biB0aGUgcm9hZCBtYXkgdXNlIHRoZSBtYWNybyBhbmQNCj4gd291bGQgYnJlYWsgaWYg
aXQgd2VyZSB0byBiZSByZW1vdmVkKS4gQnV0IEknbGwgbGVhdmUgaXQgdG8gSGVpa2tpIHRvIGRl
dGVybWluZQ0KPiB3aGV0aGVyIHRoYXQgaXMgcHJlZmVycmVkLg0KPiANCkhlaWtraSwgIFdoYXQn
cyB5b3VyIHByZWZlcmVuY2UgaGVyZT8NCg0KU2luY2VyZWx5LA0KVXRrYXJzaCBQYXRlbC4NCg==
