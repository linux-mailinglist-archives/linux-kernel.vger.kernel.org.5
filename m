Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8BD7A8949
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjITQKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbjITQKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:10:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A504BB9;
        Wed, 20 Sep 2023 09:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695226194; x=1726762194;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CGyFN2MspIZcsVuxBOrbKUofERRXGOJLwnAZFBBtuPI=;
  b=Sy/NcMM2iA/wg0pY++dEbG2QGbymuX4YpP+dkoxHw8ZtMqS5yI5NCfeP
   cYSdxRLxk3b6DRFc4IVSjO5fL1OkC97e0iHBmwPC5+bjhk/dAZ/Z3VG85
   SYZprOMZnjQ7KxUe6tCjINpjpd5xr764szIEaWWAlZ0PkXzE8FADjfss2
   dVcayV4l0XY/uE9LYYIHK6zGCXWgtOnBttK2ijMfUIgbg6GbVkw7SHfoB
   HJVENwEytAwcWIiDCYb82eumxmfgnY5JnezBJ/VMiWQRx6jA8X2+kk7ZR
   Bp+WsF2InBKG5wAvGh7DxZ+y3QQV8ZX6TLI7avcYDEFfD+dygjZFOmpas
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="380184311"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="380184311"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 09:09:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="696356689"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="696356689"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2023 09:09:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 09:09:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 09:09:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 09:09:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 09:09:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPKYJAHzoVT5PWtjkoDDNnIBIbMefDxoAcxm6cNfxzI4aLmPj2Kiu9fBCRoN7dNerdH3+NrvXqIQhcDuGJcNOAmRdv54Path3i3WWnyewThB+Qg9GO1dCb4rmyL9LBUwHSPDTzxq+ecjNrFIQ7i2aulfFc6QM6gqkkkt9hF6o7gQ88uaDxlCFVg4iZgzO/MYIl5ivn5gLOIdMIsvBS7W3A8gln0RJlg/HnrRFjUuKeqBEF1QKlhFDR9DFnyfpzt/MMc7oqjfNXUk9YSa8s45+ToVtGz9QbV0dCGaKK4YOiQi/0P55piEQ6iSD/kCAwa3t9ZiSr6HA9SySoLBi8OCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGyFN2MspIZcsVuxBOrbKUofERRXGOJLwnAZFBBtuPI=;
 b=WaClkhAOz3qdW63OdFaFayNMwWAy+OkK0taQLOntvd89lw2Sn3Vl8EUvlAI7TKgBjdV5nAaw8u/Tp5zXAbYSy6Bv4QFQpeIwKpy8iTu8BeNbTC3AT3nw+GxVyFzsctA5889avmVbPRVvzxmj7LMbVKyMcizjyM0pM/TGgoNljN9mAI7Y5MIOXxlK7BGdtcC5WH35SwOEUFpZjeTaS1fYBX7yD4aaQxQovfPtwj2TXkDf4lLiaP2usbbRaxCFxtS8XiuzUE4M/5MfQJx4uDrH1ZwtomnzezUgTXm8ppI6+dg1M96c4qNRyfls4MUhIIpxsTvlzcEL6m6lXJO70IFsDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 16:09:25 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 16:09:24 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@alien8.de>
CC:     "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v7 2/3] x86/mce: Add per-bank CMCI storm mitigation
Thread-Topic: [PATCH v7 2/3] x86/mce: Add per-bank CMCI storm mitigation
Thread-Index: AQHZubwYXa21JitQ9Eid+1nkCfmDVrAkQoeAgAAChYA=
Date:   Wed, 20 Sep 2023 16:09:24 +0000
Message-ID: <SJ1PR11MB6083FC3839693001C229E78FFCF9A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230616182744.17632-1-tony.luck@intel.com>
 <20230718210813.291190-1-tony.luck@intel.com>
 <20230718210813.291190-3-tony.luck@intel.com>
 <02e6de51-45e3-4370-95a2-df835b3bda46@amd.com>
In-Reply-To: <02e6de51-45e3-4370-95a2-df835b3bda46@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB8383:EE_
x-ms-office365-filtering-correlation-id: 496fce0f-64b4-483e-ffb1-08dbb9f3f548
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MKFFPc4M6VAn+TZgJLdvvzrAnjwmhOpe5PgnkRfiBuc8rgCXRmcGKYQCP4vZA3LKJHnGINMbLxexHIgA5QAL7ku0IkngAKr1C4f01Q9WmPAdxcYUPhiE/XS2tYL8wtAJjibfisFX+zt58T7CvxBJ92QTGN5OG9I339VrB/ePlj0S+uEGwErS75pci6teX7s2LJ89wZSikhYfJQmzG0mGM6LX8Jhzl1VRNiowrYscsORL+dpi6pnKjHlenlfkWHoVJNJQjoyTRejbEBL9Dap0nWlc6CkvJszkL6g2U4AFZHRve9TfaexXlvozJFHa+bssiSMqIM4/5G+gR8gcGPeQTQIQqVDyfv7RImJn66SyNmFpo4dAj/NPTOOrH+yrQC6VPcL/CuB61LpOQmReJDwZs0hdGjud9sa+pk6F7JpF62nbpXifANBqsWCOq25yptZ0dnrE+4F7KftBm23UFP4W64T9wYCSc75iu3yIQ0OApeZgS+dvRV6jyaGJOx2o+pZ1AXECuKSYZKhNbajk90pHECNVG+vUPjhpTMsYUyXd/cbD1koaLSz8KdbY4uvajAHpyeeWledex0wLV07hE5dZCWqLhQHrQ/6qUPvHh/42l1TybZmEMcDmTo1MTvj/nEut
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(396003)(346002)(1800799009)(186009)(451199024)(9686003)(71200400001)(7696005)(6506007)(83380400001)(38070700005)(122000001)(38100700002)(86362001)(82960400001)(5660300002)(55016003)(26005)(33656002)(54906003)(2906002)(8676002)(41300700001)(8936002)(66556008)(66476007)(76116006)(4326008)(66446008)(110136005)(64756008)(66946007)(4744005)(316002)(52536014)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHV2Tm5UY0xwYWkxd1FRQmd0Tlp5N04wT1lTak9zUXBlb1ozTVZyU2xIN2dB?=
 =?utf-8?B?ZGJiN0VaRDZlRlRMTFU5SklBR1VwVXZ2bEJkVWNNd3EyNndmd1Btem5hdmZV?=
 =?utf-8?B?bytqV25UaTY4QTFFMUdjRy9UUHRidWFMcHhPaVZkZ1hjYXRzWWtIaFo1SDhy?=
 =?utf-8?B?eXpoWWI2RE1jQ2RGWVZhNWlyVUFRNjhRM3pRQ0V1THpBTGwrUlk2am81Vkli?=
 =?utf-8?B?WCsyb1NjTFRzeUFwZk9LaThhTWhrY0VwckxrY3FPL1ZqZ3NVQnJpQmRlWUlZ?=
 =?utf-8?B?d0REMllhVlB6OE5FOFh0UDdEazVYc3hFcnNiRkFoQ2hRNXFVRHF5RzVrcGhs?=
 =?utf-8?B?WGVxaGpWNUp0TTVvN1FqR1praEI2N1doMTVsempFSUw0TnEzVHdDeFJBYjcy?=
 =?utf-8?B?L0xKYUVNeUtiNHRQVlgxNkpSb2IzVkswdFI4bzBrT1J4dlpBcnNrN3FDYmh0?=
 =?utf-8?B?QkNEUjIrYnFSRkdoblhid3lWdEh4aFNxWC9ZaEI0WTlQbXh6dC80bXBFN0Rj?=
 =?utf-8?B?N0hhRFVSZG5EbEVIODFoTnc3aURZQVFVRGVheHhhY2NvU0NhM3MwNDE3bFp4?=
 =?utf-8?B?TzZyVXhBSnFodHNEajZWNUxidEx0RlNsb1ZKa1p4Y2RQUDIrZ2J2ZHZLcTJa?=
 =?utf-8?B?RlV6WmdNUHhORVArUmpuTVZxLzFocnlmOGxGOG9xclYwa1Zqd1RnMjJDb2dj?=
 =?utf-8?B?T0dBRUwvYzF5ZEMrMkpYaFFiTHlsUEFGS0t4UThkNjFNeDRHbFVxZkRtaWJG?=
 =?utf-8?B?L1pmMVdINk1ac0pMSENuN3JBM0YrOXdiYnNIY01rQkh4aFB1N3ozcGtOM0xu?=
 =?utf-8?B?dnVLN3dTa1k2N1hLaGZXUHlldE5UUlB4L2h1dWZXdlptMk1QMi9RUzhhR1FQ?=
 =?utf-8?B?MlVLRmFUZ3dlV1lGSDVWbWw5WE5NRlBwN2xwbm5qUUNVZEJldnJXRThvYURw?=
 =?utf-8?B?Ynh0UW9wZndidDlKNUV3RHFtYm9qMUZEa21LUnQvY0lXVUlaWGFjWHRpV0Q3?=
 =?utf-8?B?amNmUU9kTlprM3NVNUUrM1BOWHVaQ3FicG44ZGV2WjBoNDdkZGFXK3NpVnMy?=
 =?utf-8?B?amh1RVZvOXdVaEJ5Mi90OHExN0pxQnJyWTZuVURWS04xQWVMK2hKVU1JbE1N?=
 =?utf-8?B?WWJsb2dJSUYyck1VVVpVeFIrUEFoYWNVdzAzWHVOYUtOVGw2UThSM09OQStS?=
 =?utf-8?B?ZkdRTHd1TEFKZ1Bqc2s2c3lRbmYxbmNpeUhCYndBVWhRVkZXa2JVTnMyNXJQ?=
 =?utf-8?B?bjF0TnNRQW1IVENUVk8zNTNZdCtEUUk4QkR6Z2ZXSFpvNkViRUJXUXNUeW9q?=
 =?utf-8?B?ME5wYzlOVk5kTjBXN080elpOY2wvd3dRVXpIVWsydEJQZjdMbkZZbXBrKzlk?=
 =?utf-8?B?ZDh5bUFYQ2QzUEZRczdPRWNPZm9iYlVRVndYNkp1M1I3SVBHK0FRaFFlTDNp?=
 =?utf-8?B?MFJobEk0aCtLNWxhaGtwcElkQWhzSkdLNCtSL3FCVy80UG1PZnZUL2MzcDVW?=
 =?utf-8?B?WFRGQmVCMVpUaElocXczeFlFZFgrbUYyOWk2dkFIQnNCMUp4UjhPbmdWeEIw?=
 =?utf-8?B?QytHa3RNbFBaa0kvVlVmbmlvUTUrWVN5b01hSTRySDZzVkdNQldwNlloMEpK?=
 =?utf-8?B?dTdQb2ZCZm05ME9OYmJVNHlQajNzV0JJbWFpSXhXWUVuZUd1ZzBEMEVQT2Iy?=
 =?utf-8?B?bXFyQ01kZ0JMUkJySlU3cG9WRk00YkVhSUlVR3BTaXByQ3JRRjhERENvejh3?=
 =?utf-8?B?cjdqRmpEL3c5aU0xa0F1ci9IWGkzSFE2bTJKdm5mUCtiZXlMakpxTW9XMk9Z?=
 =?utf-8?B?enNFTXBUQkxkdXloZVFZVy9NSFpHZ2JKb0szeDJGQ1d5bHRPRDd6cFlwaHZr?=
 =?utf-8?B?ZGVMbDhuaTd0V1FQUlBtbHQrclVRc3REZTVZSjBPbW50Vm1PaDdYVVg5TUNm?=
 =?utf-8?B?ODUrUTQ5V3l5ZWVpT3lxR3lZb21LUHdIR0R0WC9zeEQraXBMRFNhSGg4cHll?=
 =?utf-8?B?bEN2S0dqOHdaYWVFKzFjV0pNVFRVLzNsdDdIK0l6M2F0L2pMbXRBT2NpRjdK?=
 =?utf-8?B?RWpIWGN0U3dkREUxWGJ0RXU3blltWEVFOWx3TWNVQjYvb1RQb2x2L2I5ZUw1?=
 =?utf-8?Q?Oi1JMfN0k80bps14kl96Jr3nN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496fce0f-64b4-483e-ffb1-08dbb9f3f548
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 16:09:24.6465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qzuImdFASx/kvmRXEEYiX6wJlQjpUaT6YCRhJroRHUs3f70jRKG0rd9IDd54EV/wByEEXhSrYLAwbj853cmhVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8383
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

PiBJIHdhcyBqdXN0IHRoaW5raW5nLCBjb3VsZCB3ZSBwdXQgYWxsIHRoaXMgY29kZSBpbiB0aHJl
c2hvbGQuYz8gVGhhdCBpcw0KPiB0aGUgcGxhY2UgZm9yIGNvbW1vbiB0aHJlc2hvbGRpbmcgc3Vw
cG9ydC4gQW5kIHRoZSBDTUNJIHN0b3JtIGhhbmRsaW5nDQo+IHNlZW1zIGxpa2UgaXQnZCBiZSBw
YXJ0IG9mIHRoYXQuDQoNCllhemVuLA0KDQpJJ2xsIHRha2UgYSBsb29rIGF0IGRvaW5nIHRoYXQu
IEl0IG1pZ2h0IG5lZWQgdG8gZHJvcCBhIGhhbmRmdWwgb2YgInN0YXRpYyINCmRlY2xhcmF0aW9u
cyBvZiB0aGluZ3MgaW4gY29yZS5jIHRvIGFsbG93IGFjY2VzcyBmcm9tIGFub3RoZXIgZmlsZS4g
QnV0DQppdCBzaG91bGQganVzdCBiZSBhIGZldy4gVGhpcyBjb2RlIG9ubHkgaG9va3MgaW50byBh
IGZldyBzcG90cy4NCg0KLVRvbnkNCg0KUC5TLiBUaGFua3MgYWxzbyBmb3IgdGhlIGRldGFpbGVk
IHJldmlld3MgeW91IHBvc3RlZCB5ZXN0ZXJkYXkuIEknbQ0Kc3RpbGwgZGlnZXN0aW5nIHRob3Nl
Lg0K
