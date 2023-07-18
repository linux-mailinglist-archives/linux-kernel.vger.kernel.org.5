Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC1975821B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjGRQaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjGRQaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:30:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FF910E4;
        Tue, 18 Jul 2023 09:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689697808; x=1721233808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1Eg+lmyxRr3kE5ceJPuZhEzpw4vvsLS/UBGwUk8Oygk=;
  b=dMosPTw0zHnZ4qsrCbGhFpEcWUEc4uPeJUiyw3eHZx7Qe/jWLQ85Lkhb
   9Pq1oMyTxfnR1Xne7/VdJf4DU34EqSdfVQe/hvV16f3a7wip7M18N6bPL
   uyKyysy/5Osf1YEHsi5KfUxrbPCO68U3NUeWRe6cH1kInYDowrjWKX2ep
   UU5ZUEtkL5i2w2rCDMhVjNIj0GrvFF+uIRgzazvtb/JCSD/zyBzg/i4Uq
   qp0/dxfTPtypoaJ9nH7xvTMUVWFxj0Zm+fF6SCnPe5ghG1qtw7Iffi9w6
   8wSZMR7KBiMp0clLt61jkiRCumScrJhOXW5mkfO50NBc/wgv403INkyKL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="430015019"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="430015019"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 09:30:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="758851932"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="758851932"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 18 Jul 2023 09:30:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 09:30:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 09:30:06 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 09:30:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L841z4RwKc5S8rG38CmsopcmvC4ZM+I9X5GjJG7ZV/mNCSO3x4SXaU0Sl/cZGHPGxymZXcoRMtTHGzdCMZQ8ol6FwIdaVQQRJa+2viSyrs1xNiVMMWv2x4sUhwekCh4BPTLpQD38eyxkIpq8H3wZXr+mbWH7f+6VKZpXZTkkoTXAlW8+oDOGo2NfwfQTKJQOGNkkxDgzm/ctBpaE8sGQmke1ZU+MOl2JXj6AlAIoW01V2TfCWP42VNrA4j08W911OYbWTaCsBUYhX3BnQDsALxCpkpKKQK6Hni9ugEoC0srgwJT7Ule/UsGks//AnEhgQQ4QhhRjqi7mrD6m8xaFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSShV50rk+yATltKl7lDhSTWOmbyo5soe3CnNsJ2LTg=;
 b=i3W/fHaxnbVa4KTncekiW7oUOV/CfGkiq83qxx9y4e26U5hJVJLSLorlP7YhvoeGrkymouhtH5kiPka5Ho8akkfPxT9/K1GGzX3bCwF7vtKRKWO/DklYZtGFkxnGEbsZBNm5mYwQo5srt5DVtWoT11k8rzQ4trbzb6CfZTNcTe2XEigq9V4lTtqGB4edTG5hZC5bR/CN7X/gzdfodIMlqeLR+hwoeYoo0q0/+ivMooVSjl2HI6JjjWn7nSF6CPmDzPH5T/XQ2M0nEjy1E6IqNRukAD5dDp0VafrDYgu/3r9H8ufaiNaIdWQS/BJYB4lPOaGXGGeTyKM3NCqhNEsVag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 MW3PR11MB4649.namprd11.prod.outlook.com (2603:10b6:303:5b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.32; Tue, 18 Jul 2023 16:30:03 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 16:30:03 +0000
From:   "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: RE: [PATCH net-next 1/2 v2] tools: ynl-gen: fix enum index in
 _decode_enum(..)
Thread-Topic: [PATCH net-next 1/2 v2] tools: ynl-gen: fix enum index in
 _decode_enum(..)
Thread-Index: AQHZtWmJfuKrBYUvlkKIn1akadqWPq+33AwAgAfiO4A=
Date:   Tue, 18 Jul 2023 16:30:02 +0000
Message-ID: <DM6PR11MB4657721B8CB36AEB67F1A8809B38A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230713090550.132858-1-arkadiusz.kubalewski@intel.com>
        <20230713090550.132858-2-arkadiusz.kubalewski@intel.com>
 <20230713090234.28b04145@kernel.org>
In-Reply-To: <20230713090234.28b04145@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|MW3PR11MB4649:EE_
x-ms-office365-filtering-correlation-id: 8bfd8968-ff4f-4c5e-f870-08db87ac3cf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5q5Kn2lcJBvgJuZ6gBLyqGec6HItDtQSSSfL9FW/V7fOSIx6KoNGHWjifHPkRAZd2hsvQPn6aFbnZFRjxZIWuDh39cb6OGfoFQTRnu/sPtH4uUTtK0cad9LLUNkAUk4oCKdjfUifg2wm448D4Qf1EGUcckm2J3JsLkXY24hya0EMzreFtXNoG9/2qdmdpvlVoxTRnJWRMDHafQucqYmz8hFoAYO0XpOmjQ4+hANw2HwypqpHdorKDjie1cy8Kuba1vSw+1EOlDT3LSmcu4JMYAAbvZEJTIL3VO8dIuR2Aqf88kQVGZlLl53FSx9Aqxy95Qhlh3pC4A7N9iPjPJjXbEFmk5Zg9NwxBiHghMExfpR9+eiYHtJTfyTrJ8tj14Ml91CufihI140cSFUN08fI6X7ADzD+QRxPzebWYHOE1Woa8Xj+Dsl/eD4GjLTLmh76l4ItXktLXJk3uQJ16meUdFt7Wz6T9L70RPHHyzU88lGA/ur0rpSR4xBzz5bTCFRt2knL299dlzyAlJR4NX3L2UVGT09TYVFgXjiIjkOaKo/FiQFA7aEUMYPtcBWVf+MDBoctSNPRABT8nGDt1BwyfiyMOg9IL4nVSOevtGEPk2UVniYduvEA6c/ZocY305Oy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(86362001)(4744005)(2906002)(33656002)(38070700005)(55016003)(186003)(9686003)(6506007)(26005)(38100700002)(82960400001)(7696005)(122000001)(66446008)(54906003)(71200400001)(64756008)(478600001)(316002)(66556008)(66946007)(66476007)(5660300002)(76116006)(4326008)(6916009)(41300700001)(8936002)(52536014)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tFGgzJlwBP7xisxqjalhbBnq4ErWOayagHRdVReRstNMcZp634a0TnL1yEeb?=
 =?us-ascii?Q?jaoAJ+weXsPefjgDI3INCo9fNytFFiNEHdJrxGZgzY42xajGrHxudtcZYIgY?=
 =?us-ascii?Q?z9biidmt0pNOQGz4329vJbW77Gap5+ulrMt+fe48h5u2G8ZDRlc7IgXKVXV8?=
 =?us-ascii?Q?gQPFHpQ9LNsIc8aqo+Y9zjUBfMSqN6/Yy2CXoyGZi2S+OP0xMY5LKyo25ahC?=
 =?us-ascii?Q?jJSxqWYTJ1X01ubQfMGoicmY13+sBzzRDKQWEmDp0y+A2pXF6jZWviCtT5OA?=
 =?us-ascii?Q?sIAFXWXAypKLQZv52xBBCuDd6Qs3ppyQyDD5dEBn9uhTB9gdXnir4ckk34Y8?=
 =?us-ascii?Q?CoJiGjQxG0lI8uzllCW4v2ifSpgtXri6Ay+p6lC0d7d7MzpiLbzHSqNu2iK3?=
 =?us-ascii?Q?q4ENAbjbhye0oSnZ6Z17l6k/l/oBz6mR11oHKA2BorUTk41vH/jU0W0OgNJi?=
 =?us-ascii?Q?vO5TOwIDr8pdc55tfQq/xDu9HbbLCSRJBZQGqYYlS9TautbLyiH+j+zrYoKY?=
 =?us-ascii?Q?t+ECteRl1gjgVOm9OatM7qSTqhjWM+wQKgd3lw0fH2X9hPIlnNqAT8s99JEa?=
 =?us-ascii?Q?skapbaHUT/J9Vte7xahdVYQTWPnF/kPVlN4uDKiGS015GY013q9POdXnVNmY?=
 =?us-ascii?Q?iSn54Gc4PVTStkxe2VMvPjITxrFB2V6aVnfwJXjJWcUDBQYCGLl+wOGFBrQ/?=
 =?us-ascii?Q?ma0pbIXdebaoSW1TeECCGBR+SiI9/yzEXKOmjYhltr/qocZg7QCO/wQ7pF15?=
 =?us-ascii?Q?25aJ8OPrliCFFsQoGAWvNViXwKeCoS/LZpAQO9lAkViG9GB66kZz8O/UI+94?=
 =?us-ascii?Q?5ybcJ/qL6/wQh7r0zRpJV2ZlQARDCt4TyEBHN6Mkhlm+hA8bpib4h0eQfSRA?=
 =?us-ascii?Q?fENwKUDL7KNVFo9kCJwO1G3CV7fTNdKf90xZYxw4PhM9UarpEbvl/cY08M2+?=
 =?us-ascii?Q?lHN2clU6Zm0jFfSylNyA+OXg1AGINmRTJqBPBiwqq8xUaFAOEDPZ2TDtIqqO?=
 =?us-ascii?Q?zK1bx8w5oKIhjXvoB+B/wNqIt3hKtsE3Ca6O8WtZqPJfmZw+/nieR6uzp+lp?=
 =?us-ascii?Q?kOfVKoK1mq8yfqrHu81mcrvBIm6QsAX1RT0hPk3AlZf7MjWhttKC6DVS4BwL?=
 =?us-ascii?Q?oaEfJoaO0xOAVvYMJKCFOzTRAfRGHEgthJSZ67xk2fYsE4KadWtpAjx2Fb36?=
 =?us-ascii?Q?6sI3fOfzjEA82Gpn6kX+uJYnztyKpIYj1upVTRCHIu3IhtrUjwGTPkusM4MF?=
 =?us-ascii?Q?h60SDzEt1XCJEy/DYkx7dH7kZzDnIUPP4IVC+cvqponZtQ9mD/VPAB696g7n?=
 =?us-ascii?Q?32Tc2aIekZ9jWW6rZRdTxqs6fkCe5FEgsZm2oD+jrQd8WzxWrPRbpjJyB91X?=
 =?us-ascii?Q?cHsu6hImx9EMf+7L19bW+cOGnqmMuE4WFNZGWlptVqwlBeo+zlOXGw7wxQCw?=
 =?us-ascii?Q?X3mO9ufQoNYsNpDcd+4VVoTP6yvE4LhMt8wx5FIyJ3LAg4AZ+cpk6M8aEEft?=
 =?us-ascii?Q?6o9o4evStPRm5PtAyTZ+5e8DRG47UHt5kWvgAK1XzzUoS1p64smWVMN1lDHZ?=
 =?us-ascii?Q?G+hwxcrMp7Z/7RG2s+Ml41kqqpn2NefZ/zpyYq/wZzKlF27xWyCzsHiSpOva?=
 =?us-ascii?Q?RQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfd8968-ff4f-4c5e-f870-08db87ac3cf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 16:30:02.9875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +L0JT3/5Nar4VTbR8Hn7LQY8/WBr2PBXcdRgjYvn/PN67JHLo/wAiGMAGe1zol5En881DYNktHY1atE7l8Nbi1nUQtALJLXa+u7hZlZZKO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4649
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Thursday, July 13, 2023 6:03 PM
>
>On Thu, 13 Jul 2023 11:05:49 +0200 Arkadiusz Kubalewski wrote:
>> -        i =3D attr_spec.get('value-start', 0)
>>          if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:
>>              value =3D set()
>>              while raw:
>>                  if raw & 1:
>> -                    value.add(enum.entries_by_val[i].name)
>> +                    value.add(enum.entries_by_val[raw & 1].name)
>>                  raw >>=3D 1
>> -                i +=3D 1
>
>This doesn't make sense, as I suggested you need to keep i for this
>loop. Move it to the inside of the if 'enum-as-fla... and init to 0.
>
>i is tracking which bit number we are at as we consume / shift out
>bits from raw.
>

Yeah, you are right, I don't think I had clear mind when created those..

>Have you ever used ChatGPT? No shame, just curious.

I have used it, but I am not using it to prepare code, this was my fault,
chat would probably do better..

Anyway just sent v3 with this part fixed.

Thank you!
Arkadiusz
=20
>--
>pw-bot: cr
