Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E82774F59
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 01:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjHHXc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 19:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjHHXcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 19:32:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCBA1BFF;
        Tue,  8 Aug 2023 16:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691537535; x=1723073535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0WKfgunlB3FfAYAaL3ULE6OaaCZdN5ct1p+zL9YzyYs=;
  b=SOv3OEDVe818J4l4lUjAj9o4h9VGrkCkXvaHn+4kVHlPweNqwDunvwj4
   F6JUnAzEZiYz2ako6pVTA+3uQWPcdNwrxG6DZzExQcvYHEBOlMVN4wnKi
   CxYYsgdELag3iNNgHx7g0G47NYsu7vXzRbLmC73kL+vhePW9obEQllzxS
   6cIb4Il/DEsNY0E03wOnJ9tWmds5wJGkKFNE+WsAN7aTZI6SSeTVSRN+U
   efvZs6rrWLBGcVUlZGITU2m65qgDH/HkJgjQ//mtMdOldiucy9NC5x5Ts
   /ML8Fm5lEgCzMgyf4OpGMUAQ2seYGBOt+dwh+XO/ttGdpeteytZ1df6Uq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="368439579"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="368439579"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 16:32:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="681445590"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="681445590"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 08 Aug 2023 16:32:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 16:32:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 16:32:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 16:32:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 16:32:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lw8kyFZyvYK4K1LXqAWe0tCVym2pd8HtuIj0M6PbNvxLDAeIRsLfM6QenZ+pds3KJLiKYdo9WGCI4sFl+SNn6mUOaC7M0oWXaCo4NExx7hZ55g7dMf1T0p+6EPXI2kDQ9/c9No5SpKAx7MvMN0K513zur0Xd4qgWyACxP53lrHnHzpFErV5rIZFcyPbYghXVUcXPPZ3oyZdSE0lc0pCcfNvZEsqhTTv57NMFh/+Z/AkJaku1MEMzETbX5BgCnnZDUUH9aFVVslh34cBRoVCn8Ngl/ea2jG1HsUGlhc8WZWc3LDkFAaGdFlQp/e0G2lLH50caNrG1aLX55W+Xy8zosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WKfgunlB3FfAYAaL3ULE6OaaCZdN5ct1p+zL9YzyYs=;
 b=cWT3XGNsR3wO2nfuXzCLsaW+oEwXE0k+8iOKhWRx0EsK1LmTAus3a+dWWiZOngbiUF/ThY1QEy4nhPR4AE162F8F6dnLStnUA/WRRpXo+2ALl0i9/yK3sSp27wrPntwWwJynlHsdVWmKjoiPQcegxnf8wlyG5E6MP+PdFr/qOgeKxziv+EmlYbyyeCAwPtmvGXAby1bv4W0hY6IkEvLbvA2PNlgnC24kgn9wSs3YoBVXU1/2Fr5uoQ/14j8Ec+pDmLFII64gxb8D1wM6jphnwnad1Dfyo8QBkgha2XRAabQf1BPB0YkcW8hvHxLCb4yQji77nJu4LTe14BsX6vgggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW4PR11MB5871.namprd11.prod.outlook.com (2603:10b6:303:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 23:32:10 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 23:32:10 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>
CC:     "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
Thread-Topic: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
Thread-Index: AQHZwYoTw9Njl1TosE69WJRoUv/G3a/RDr0AgACyhACAAIcTgIAIwDAAgAC2XoCAA80+gIAA93MAgAAJwACAAA9BAIAABTcAgAAcafmAAAfrgIAAV+OA
Date:   Tue, 8 Aug 2023 23:32:10 +0000
Message-ID: <8d7acdd5d4824999ac6f28def43f9bdb8bd45d44.camel@intel.com>
References: <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
         <64cdb5f25c56_2138e294f1@dwillia2-xfh.jf.intel.com.notmuch>
         <1180481830431165d49c5e64b92b81c396ebc9b1.camel@HansenPartnership.com>
         <64d17f5728fbc_5ea6e2943f@dwillia2-xfh.jf.intel.com.notmuch>
         <c7d6e953a4b36014ea0c7406531b24bb29d6127e.camel@HansenPartnership.com>
         <2425e00b-defb-c12b-03e5-c3d23b30be01@linux.intel.com>
         <64d263e44e401_2138e29486@dwillia2-xfh.jf.intel.com.notmuch>
         <CAAH4kHamob7g_+BRd0JW76cM7_vS=jzXzRjrgCPDxZ29VnzdCQ@mail.gmail.com>
         <64d270a2a68ce_5ea6e294f0@dwillia2-xfh.jf.intel.com.notmuch>
         <CAAH4kHYht5s4CkS5Y9+VotPH4WqDrzng0vYy89oq0_U16H_dDA@mail.gmail.com>
         <64d286bda1d8b_5ea6e294eb@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <64d286bda1d8b_5ea6e294eb@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MW4PR11MB5871:EE_
x-ms-office365-filtering-correlation-id: 00467c1f-4581-49ed-8bc7-08db9867afeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B8MqCDWzeuUXxxMIYeCwHg7uiHyfFnfmObLs4qhpGglmu4cc0S4rnvHYCHUqvM21ubSyUKMSPHiPNYn2Dv164EYX/BKtG29hNFKEQ6djeqU6jtM9WwJCBt+3C0Z/y+LWyMaM1jp9zWfIe4fzWOM7CrZGX1fau7eo5lvk3ruza6azG8mgsd6df5zrPlaIQwfVN/TbZovBQIziVZ9Q9fMRWvMVk9xGziGBeEe8W4FqjuLK4Fp9J+iCc8Wpy8o/qyUFSD2lLOFbM8yDyi5yEVzY1A4ItQrO+S5GAnC6lJGWcW5DkDLjZ2Vl482+ABP5CPOxaSYZL+hV2idv2TiiZJcGY9ufoFbS9NuUtAWYRrVUe8YzY48vtlsW+3WzYx5Yu3NydXOz6UXjquJUeKScoGaVsRoVtKbW8YkSXx3hX10z3HRAIEH813O78OUY3nLoFf1x20POAxaDJ1qPWCn5L43bxk7RalZckL0crjjHDAtASzrW/KbeDDRhoM9TE6rTuFRhIF35wtSsJts7DnH7XHaBOjhd6tzuJXZN7U4b8IRjaC+E/17yfEkeefF/vraJYuhgNq923szdxuPqiJCIJ03/jPxpF8yM/pWbQNBLdTCmUG8A+wTFG9VM10wtWvlkDMkL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(186006)(1800799006)(122000001)(110136005)(54906003)(82960400001)(41300700001)(38070700005)(316002)(6486002)(6512007)(36756003)(86362001)(91956017)(66946007)(76116006)(4326008)(66476007)(64756008)(66556008)(66446008)(38100700002)(71200400001)(83380400001)(478600001)(8676002)(7416002)(5660300002)(2906002)(2616005)(26005)(8936002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFVzTEdYUVBDS0hGZW5EOEdaTXZGbzd5S2gxck5LOUlVcmpuRklsVG94THBJ?=
 =?utf-8?B?STFacEJjT2pSVkh3NEdONzRwRE4xSjUvb0ZGaWRJZllXMjVISmh1S1ZwTVd2?=
 =?utf-8?B?UXhoY0ttNlp2SXFhUGpNODF3azVEYURZUFB3N1ZkZmllQUY4am91STNmR1ZG?=
 =?utf-8?B?ZDhiOThtK3JYVFhoYm4zTnB0MnBUb0lsaDhlVnROeXM5eDljL3NSWDVsdXhp?=
 =?utf-8?B?b2tONmU3VG1EOG1odjl3cFQybW9UQU5HWDVNUkM3NVVuRmU2RjY2UkUxYlY3?=
 =?utf-8?B?VTRBVVoyV21EV0hkbFYremYvdG8wbzFaMXI4YklHQlZwNEczb2d0Zkc2OE1Z?=
 =?utf-8?B?Ymd4aCtyUmFya285V1VWTTRqSmtqa1c1TUk4TmpKd1hJdUpHazFrWFpkT2kx?=
 =?utf-8?B?SSswQkppSmJTck9TV1FuUVlNK1kzSjlzYWZmOTFzdVlORnhVWHFKUnNKbDYw?=
 =?utf-8?B?SUhBUmJMYndQanQrSTl3UDUzb1lNU1Y4Z3lkZHU2bTQ1Yk9wdnVUc0JwcllH?=
 =?utf-8?B?bWtRTExFQWt0eXVVYkZPUkxkdG1MRnR4OStkTVE1QjJ0amtXaHRTK1B3UUFi?=
 =?utf-8?B?dVVucDVJblpVY1AxcmJRMkR0enI5QnJqUUJ3RjAvbG1zbkRwaXZPeGp5U2kv?=
 =?utf-8?B?TDI0ZFdLTXlPUXhVSENiRDMrQm9MalF1ZFFReGdkeFJMTHlja0duaGdsMHVm?=
 =?utf-8?B?dW1BT0I3WWNhNFU2NjNVZWhMNTNNZnhDOHJ4SHZUOU1XMHlEb1lPWmpLT2Jh?=
 =?utf-8?B?STRmOHNiaE1hZE83di8vUlFKUURpUUdLandGM1lBSXVkaW1YQ2VBSklFUkRy?=
 =?utf-8?B?Qk43YysvRkxpazdLeUFuK3lCYnhyQ3ZkRzhUZE5YS1RWZ3l4UGhVMGNoWVU2?=
 =?utf-8?B?TWVlcURyUEdGZ1gxZ1dDRXpIa2F4NVVYYWRRTSttZlpEOUI4U1dYWGkrdWtn?=
 =?utf-8?B?L1FtZDViZXhUMFZ0N1dqelcwRkYycGs4V3hZeFd2bTlmaUpXK1J3dTV4cmpk?=
 =?utf-8?B?RGhyWEVyNFN3a0F5NXhYNTF0bm0ySE9HYWI1OVkwSmpkdUxBaCtUdmMvaExy?=
 =?utf-8?B?MzVCbkNPT0REZ3o0aFBpVHNGeDdWbHNDMktCTTV2ajVHUHFaK2NqUWpmWFpz?=
 =?utf-8?B?cFoxYW1LNEpBVXZXcStrb2xEbjJlMW50ZVlzbXJFczhSbkkrMW5EZWNLeS9E?=
 =?utf-8?B?U1VDdTQ0VDJ5WTM2cUFuZjFQOVFyQkFIUHJlQnVQb0Z6eXF5V2REUFkzNkxG?=
 =?utf-8?B?UVY4Y3hQdGdKc0F6QnVmd1pJN2pLY2pGa0pQYk5DK1hXOVB1ZWREb2RudEY1?=
 =?utf-8?B?RnkvYUQ5MlgxTUdnc25NeHY3eVRwbUgyWjJmSXk1TkZ0VTFCYjFJVHFwNUI1?=
 =?utf-8?B?UUc1aTgyakZGd1huWHNMeXp0S1FGRzRQUnN6Y3RydnppVVg1NGNibDl3N3hZ?=
 =?utf-8?B?blp2QlNzVVdBUWdDajFDZ2xlQnorZWM5V2UxanRadUtkMjl1LzBmemRhYkdW?=
 =?utf-8?B?QU1EbWVOT0dOcnI2YmJveTFHeGwxS0NxUEZxTTRXK2ZRb3Z2Wk1POG51Ukxh?=
 =?utf-8?B?Uld6dUNNeVZ2eSs5VTVJcTlXSmF6R1BEMEpVL1dtdm9HRDM2NUhuWktadlM2?=
 =?utf-8?B?YzdwRDJkdW1DRHkzQ1dJQ2Z5c213SlJsUUtiRitoVHVHWWlxMFgwa1Y2WGZs?=
 =?utf-8?B?aWcvbW1BblAyTnFDUUt4OUVxRVVka25CVE5XUXVRVndudi9Lb2ptMTU0RFdp?=
 =?utf-8?B?T0RoL2RrN3RmMkdSUmV1L2N3YUNhU0RaeGZicGQzTFJYYkNQWmdEdkRDakpG?=
 =?utf-8?B?UzVlZktBVGgvbEV5dTJNWXFIUXhoWURSL1NKMTBRdGVmVkNCYXlkdElOM3U2?=
 =?utf-8?B?WlRQWDVVMW9SRnNrY1NKQlM1L1VkQkRrTE5VSDE2cWRBOXo0VmJSdTJKcEFN?=
 =?utf-8?B?c1lrRzNmbEV3Y1lxeTl1aGM4b0xaZWN4M05oWGIwQjJTcVpkSDFJVG9VQk12?=
 =?utf-8?B?TkNORi92RkMrb1l1VVhiTEtFN0VzTE85SXRJUldGdlRidXlZNjl4bTBhQklU?=
 =?utf-8?B?cjhzbTFxMnFFb0grcHRVMHQxRFNFbHNoNU41bTBnVnJ2VU5jdjJPR1hGblpu?=
 =?utf-8?Q?lUt6PvugaIbxWTLqmzGNDopDu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72CF49FC8EDC01478D0E1E3AFD723707@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00467c1f-4581-49ed-8bc7-08db9867afeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 23:32:10.3139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OpdOwlBqqxIZzfM99WqVnMFIpa/PHyHrkfrZnr/QbXShAgT8xjMtZkI8VFXIX1xH/172TbpIl9heKN/5W45+iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5871
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

T24gVHVlLCAyMDIzLTA4LTA4IGF0IDExOjE3IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IERpb25uYSBBbWFsaWUgR2xhemUgd3JvdGU6DQo+ID4gPiANCj4gPiA+IEkgZG8gbm90IHNlZSBz
eXNmcyBwcmVjbHVkaW5nIGEgdXNlIGNhc2UgbGlrZSB0aGF0LiBJZiB0aGUga2VybmVsIGNhbg0K
PiA+ID4gY2FsbCBvdXQgdG8gdXNlcnNwYWNlIGZvciBUTFMgY29ubmVjdGlvbiBzZXR1cCBbMV0s
IHRoZW4gYWR2YW5jZWQgdXNlcg0KPiA+ID4gY2FuIGNhbGwgb3V0IHRvIGEgZGFlbW9uIGZvciB3
b3JrbG9hZCBwcm92ZW5hbmNlIHNldHVwLiBSZWNhbGwgdGhhdCBURFgNCj4gPiA+IHdpbGwgcm91
bmQgdHJpcCB0aHJvdWdoIHRoZSBxdW90aW5nIGVuY2xhdmUgZm9yIHRoZXNlIHJlcG9ydHMgYW5k
LA0KPiA+ID4gd2l0aG91dCBtZWFzdXJpbmcsIHRoYXQgc2VlbXMgdG8gaGF2ZSB0aGUgcG90ZW50
aWFsIHRvIGRvbWluYXRlIHRoZQ0KPiA+ID4gc2V0dXAgdGltZSB2cyB0aGUgY29tbXVuaWNhdGlv
biB0byBhc2sgYSBkYWVtb24gdG8gY29udmV5IGEgcmVwb3J0Lg0KPiA+ID4gDQo+ID4gDQo+ID4g
SXQncyByYXRoZXIgaGFyZCB0byBnZXQgbmV3IGRhZW1vbnMgYXBwcm92ZWQgZm9yIGNvbnRhaW5l
cg0KPiA+IGRpc3RyaWJ1dGlvbnMgc2luY2UgdGhleSBlbmQgdXAgYXMgcmVzb3VyY2UgaG9ncy4N
Cj4gPiBJIHJlYWxseSBkb24ndCB0aGluayBpdCdzIGFwcHJvcHJpYXRlIHRvIGRlbGVnYXRlIHRv
IGEgZGFlbW9uIHRvDQo+ID4gc2luZ2xlLXRocmVhZCB1c2Ugb2YgYSBrZXJuZWwgaW50ZXJmYWNl
IHdoZW4gdGhlIGludGVyZmFjZSBjb3VsZA0KPiA+IHByb3ZpZGUgZnVuY3Rpb25hbCBzZW1hbnRp
Y3MgdG8gYmVnaW4gd2l0aC4NCj4gDQo+IFRoYXQncyBmYWlyLCBpdCdzIGFsc28gbm90IHdpdGhv
dXQgcHJlY2VkZW5jZSBmb3IgdGhlIGtlcm5lbCB0byBhd2FpdCBhDQo+IHN0cm9uZyBtb3RpdmF0
aW9uIG9mIGEgdXNlIGNhc2UgYmVmb3JlIHRha2luZyBvbiBhIGhpZ2hlciBtYWludGVuYW5jZQ0K
PiBidXJkZW4uIFVuaWZ5aW5nIGtlcm5lbCBpbnRlcmZhY2VzIGlzIGltcG9ydGFudCBmb3IgbWFp
bnRhaW5hYmlsaXR5IGFuZA0KPiBkaWZmaWN1bHQgLyBuZWVkcyBjYXJlLiBzeXNmcyBzaW1wbGlm
aWVzIG1haW50YWluYWJpbGl0eSAoYnV0IGV4cG9ydHMNCj4gY29tcGxleGl0eSB0byB1c2Vyc3Bh
Y2UpLCBrZXlyaW5nIHNpbXBsaWZpZXMgdGhhdCAoYnV0IHRoZXJlIGlzIGEgdmFsaWQNCj4gYXJn
dW1lbnQgdGhhdCB0aGlzIGlzIG5vdCBhIGtleSksIGlvY3RsIGNvbXBsaWNhdGVzIHRoYXQgKGl0
IGlzIG5vdCBhcw0KPiBhbWVuYWJsZSB0byB0cmFuc3BvcnQgdW5pZmljYXRpb24gYXMgdGhlIGFi
b3ZlIG9wdGlvbnMpLg0KPiANCg0KSSBkb24ndCBxdWl0ZSBmb2xsb3cgd2h5IGlvY3RsKCkgaXMg
bm90IGFtZW5hYmxlIHRvIHRyYW5zcG9ydCB1bmlmaWNhdGlvbiBhcyB0aGUNCi9zeXNmcz8gIElJ
VUMgYm90aCBhcmUgbmV3IEFCSShzKSB0byB0aGUgdXNlcnNwYWNlIHRodXMgdXNlcnNwYWNlIG5l
ZWRzIHRvIGFkb3B0DQphbnl3YXkuIMKgDQoNCk9uIHRoZSBvdGhlciBoYW5kLCBpb2N0bCgpIHNl
ZW1zIHRvIGJlIGFibGUgdG8gaGFuZGxlIGNvbmN1cnJlbnQgcmVxdWVzdHMgYmV0dGVyDQp0aGFu
IC9zeXNmcywgaWYgd2Ugd2FudCB0byBzdXBwb3J0IHRoZSBjYXNlIHRoYXQgaW50ZWdyYXRpbmcg
YXR0ZXN0YXRpb24gdG8gdGhlDQpoYW5kc2hha2UgcHJvdG9jb2xzLg0KDQo=
