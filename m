Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AE17A4D92
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjIRPxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjIRPxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:53:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A33A199B;
        Mon, 18 Sep 2023 08:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695052251; x=1726588251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jEFjrN+icB8dLQqR+ikRsJy0y6nMhUyim2mhjrNnM58=;
  b=KjovA0v9l5rv3dXQTyLVzUEoCQA9dzcb0LTLTSuPShScHtRxownXsYTH
   c4tafCXJLgfJa90P5v29lGnXoG+xfAAf0JjXneMWrUK3LCe64sbp3z+Qf
   2YevEe+nTL9yqWK6NTnHDjjDcG5GOghwCVgAw/w8nIzTxYfS2B08fQRzI
   djrSI8yqo3Dr/rI3i6fWUFyXy7SjGCrJmbPtC1bJt2qCFLXi6qSazAnro
   1y2izscOxNBBabKCZB3q2r1al80HVe7IdgZqWSS38PgExH9pQnFoSI6h6
   bPj1wdewK/AhN5UT+8/1QGzQQPIGtA5Q8qipI3gQyEtC4VDO2k4OiDuLP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359107285"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="359107285"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 08:25:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="992771876"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="992771876"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 08:25:08 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 08:25:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 08:25:07 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 08:25:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkZgkK0iSUKfFxSzRDKiMvhyPk2Wn6J0u7gIIzfLJHgPkyXV1lg/iBOqkdR7pMKGTT9u0ahKpSmvT+QE2f6w6s/JmZOYQG2sL4Vw/9es4V7+a8Zp2rHAOg7PSNljNMo2EutcbxoSvACnWiz0tqm3Y7Yr5FrvVsOekPEj6BJH9WIOKETObq7s0r89d0KZ+PRthLAIWLhcBtCSMwwhQkL0ZXWSQjzPZ38AALY2cXbX085IRnA2fDQ/QDtJeEqcFfeqxlt5/+z+GOtBv1BXucuDDNSYwZSy0sMKnYtJdADFBeIpSMWMkGHv76QjvMx7rKMC4Ewj5QDqIhA8A0gKkwb55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/H7a7F4/mmwe65iG16kcTfDwt0zt8pVZeUU6MVXfv6Y=;
 b=CwjbdBfNZ7eHcW+Cri7sD8hYlBN7KbavPx3pZXBJbJimmPs1crRWGhfKiT3Ad8QSzIlXLHa6n1HnHuWyET/OLVrj408CDa/+VBk22cdGDnJ1HVM3MUogJdbwtMjuv1jTPzEG6d3W8VHicubjN20t3s0GeDmuGIbnOby5GU83DaHAcleLjAm5ymJPdpsqete3tupeDia+azCfEQcnuksMYZiulP6aLf5yif3cJZ/GHNGn6PLSfI43YGzm3KAuDLvLU1yLm1VnLzoFWmLK0g9aLH3UbIAerCdgq+eoOaW9X3M9O0gkTlAf1Cd3DpD1xTuk2mYsllct2HW6kgf8KnfHGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB7383.namprd11.prod.outlook.com (2603:10b6:8:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Mon, 18 Sep
 2023 15:25:04 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4%7]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 15:25:04 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>
Subject: RE: [PATCH 03/10] platform/x86/intel/ifs: Image loading for new
 generations
Thread-Topic: [PATCH 03/10] platform/x86/intel/ifs: Image loading for new
 generations
Thread-Index: AQHZ5nFu/bHCYcc4VU+8hY4jAeuNNLAcG4EAgAAJkACABCgaAIAAbJrQ
Date:   Mon, 18 Sep 2023 15:25:03 +0000
Message-ID: <SJ1PR11MB6083A4237D928F180B6DB1E1FCFBA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com>
 <20230913183348.1349409-4-jithu.joseph@intel.com>
 <ba753b39-1819-35ff-1248-6ce2c2824ae9@linux.intel.com>
 <e084652a-91a0-0c16-7acb-d51a3d2f7ed5@intel.com>
 <10fe57c-c926-9de4-be84-21a0f8abab6d@linux.intel.com>
In-Reply-To: <10fe57c-c926-9de4-be84-21a0f8abab6d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB7383:EE_
x-ms-office365-filtering-correlation-id: e4bb5220-a9dc-4b0c-f46b-08dbb85b6e98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cAyf8oo16ay8X/Q6lTYYXjcDOWAxDxJBE3IHYGRYQHAznazzGvwtWR2G4ejjGNxRb/cJeI0e423ICW+6z6aqf7SIu3tW8hQIX0KRw7ZpFU7Gp2Ad0mF1H16WQV569MO8xRA6zYk/YDwurUp3R89sfnBIlmwGlIafLLQOLrC6X2b/UPulMnVBSQefUb5yvKYnCyocmJjodT3mD8xLcs9XDtcH1zpzxfFx0XZ1srzfpG2yDipCqXiAso7H2wNzKAV/PPUkoVxZFdfjU0XA5hWT0BU0pVzujj0Buo8bw4urbUx82rCc6YNxpQ3ov1IZSRuaAhNT01ckHoXgl+6MPmMFbuGxeVTpX/el92clPpe25EkazP1mhLGa/Sz5/u8/6y63q1vZtBrmCQ3w+8MY57tD1USA6WDe8QyGBxFE/qUps9ecp1Wumc3BGSDQ0Rk0xv8dlqWVJLLoYCqLA2qySfvjTjyssw4raerGfxa+SEz/Ru1hfFYF6l1Uw9VKSmFpEswJmn+7AuFaymeCHU85JJYJaOdPHUHnaTj1wljxNwe4GT0T7fEu8kuUytoJOTZvXpGeOdyjK1XzvQxhcTmfD9en+HpG3Pda25KeLRPdeboQo5GIb/Kgj3QBmdgRjhOhdFOB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(186009)(1800799009)(451199024)(9686003)(2906002)(26005)(478600001)(71200400001)(6506007)(7696005)(33656002)(38070700005)(82960400001)(38100700002)(122000001)(55016003)(5660300002)(7416002)(86362001)(8936002)(110136005)(316002)(41300700001)(52536014)(4326008)(76116006)(8676002)(66946007)(6636002)(66556008)(66446008)(64756008)(54906003)(4744005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+kD8TPE6zktKgvGoX6/AUrYt9wf7rXUqdd6n1YQN3mEu17V74flzkg05Nr?=
 =?iso-8859-1?Q?/UGUnu/W77sk8+eJLj8c2OmdXc4k5UiphbzYBHQWDnFSNfZ6orZFI5gNwi?=
 =?iso-8859-1?Q?swbquHLXnVkZHa9oYQLJ3Fu21cPSA+YleynLu7QHgQ5eOQHaHDCfw0uYv5?=
 =?iso-8859-1?Q?mLxm+q3rqVERCyo3MqBAcl1BNFuiSiDOm2Xns7ykmGAZOtKxuZD9l/jkK+?=
 =?iso-8859-1?Q?mH6mF0g2sSgkS4BF58OUBXttMqnI2+kHsKRlSplQ6E/G0KTV4AamW5LhRA?=
 =?iso-8859-1?Q?/ohnh1sCiWPKiP2HRLGJLZYp9CpMFru4NWsngEiHlWzE8BVlZkyKq2aujV?=
 =?iso-8859-1?Q?zRLMsO5tNOp/tFqCTNP8OzGYgCnVUBS919m34sRGZSFvmFXYDRYMolUNMX?=
 =?iso-8859-1?Q?JG6DX+sbJXhtIuuM+JuA1ELCnTB/bPSygDDNgndyuUyNzrdS8Tknv2BWxn?=
 =?iso-8859-1?Q?LE2Yr7F8Z2dNnzmScAZDvDOB04WwcwnzbfzbfGtgO+cwfwtNDAv7nY0BDx?=
 =?iso-8859-1?Q?YV1qcTRjzl6JICMTqUiZx97Mpj/pcduKWZe8j1zmTl5IiXlr9xlAkax8V2?=
 =?iso-8859-1?Q?ZEYB25rpEIyvlSTAAKJ1ZfPv/8F3wDfaSls4lRRbhmu/hFb5EPA/zIH40N?=
 =?iso-8859-1?Q?4WAuRcTrfWFR4ZrenwoYbQdCvdDfStyrgbklZsbP4Y9dadlb7jTkB+tdxK?=
 =?iso-8859-1?Q?Q5VTonTgHtodVJ0eQQuuk0HupjKZquNgW0TQAfwWcgbgC/AVrlHFXo6Hhl?=
 =?iso-8859-1?Q?lVhJC/oWAJB04TBgY5/Jgu+6xD9Bs9boIxYEXv6AptBzGaCvshJqmz7fTe?=
 =?iso-8859-1?Q?VNToXuBkYX11iX7DXlH2RQPTNl3/NlodkKlv/mx3SeC32q/RdekI2dGKJL?=
 =?iso-8859-1?Q?kA++kAQ32DBKZRe4agIqMhJAOgRd7/PPbVhZdvklEyc9a271O2UrsETxcN?=
 =?iso-8859-1?Q?kwtToBRhimYJGhfQlEOn1Y9nmdOtsZv93r3R6vivoRbx9lmr96Jr3l0/g/?=
 =?iso-8859-1?Q?udSLi+/6Zxv9N4LCHi8kFVfJ230aMGO80BhGP2fjrBtZWHm0NsCwo+XULy?=
 =?iso-8859-1?Q?85ExpUaRlqkrid1g10BpVHjNlH+wnnqlYYXtZgN0Az51UOkUCyCarPPxcg?=
 =?iso-8859-1?Q?7uORO0V6cZb+JFpogGrJYvxk/VIJ/eXt2DhU3Cr9eodOvMA5w2gTuorgJB?=
 =?iso-8859-1?Q?isrx/meJ+34cSxbCcp3+C+iF+eEyjqPmy4SyM2oVlz1W1n5AprEGJZM//2?=
 =?iso-8859-1?Q?wZg7pBtnRJEnSGghxOxaxz6ggfjDPc7OqxZQUXws5Sk2jzt/Rl0TXMQ26x?=
 =?iso-8859-1?Q?O06Y5eG9WLu0m31ZAQXy6QY3Qc95nbocmIBklN+/sTms+wF1r4DnYa+wIJ?=
 =?iso-8859-1?Q?28Ez0npq9waWyNtQMS/hrzD7TWDdHcOZ2nMNefrhxhQs3R8fXr18PYtxZz?=
 =?iso-8859-1?Q?3l+u9FKhuxR8SEkpdL/6WLPRA6vErvuuqKKEGmaY/CHpAHH3gvjWQ8dBoe?=
 =?iso-8859-1?Q?GrIsofzZqTxWchS78DNtQx8YH21bssoRaMmGxcCcg97N3C6MipDr9X1xIg?=
 =?iso-8859-1?Q?LtI6fGfBjdPIx2bbGIEVBOot7KZFXWZ9LxHXoZ0O9mNqBXK+tvrpbH+84P?=
 =?iso-8859-1?Q?lO6A5lBFJP3Hiqx/Dtjd/ENfWu+H/fJGnQ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bb5220-a9dc-4b0c-f46b-08dbb85b6e98
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 15:25:03.9791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aGJWZKRmpQ3lFvgGRmWCr96ExRcily3N1FeM1XktSpirgUpqTkEpPux/xwG+wMOuqUPFEALi+TeZTc9gvJH14A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7383
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I think Tony's "proof" is pretty invalid. He doesn't differentiate
> HW interface related bitfields from those which are not HW interface=20
> related (to the extent that in fact most of those bitfields likely are no=
t=20
> HW interface related).

When I made that comment it was about a patch series that used
bitfields to decode the subfields in Intel model specific MSRs.  I
think that's true of use in this series too.

I think most of these are for MSR decode. The one mentioned in
this thread: "union ifs_scan_hashes_status_gen2 {" definitely is.

Are there any that are not for MSRs? I'd also claim "Intel
specific" if there are some decoding parts of the Intel scan
file format.

-Tony


