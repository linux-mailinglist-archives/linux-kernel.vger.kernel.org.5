Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281117D569B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343600AbjJXPgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbjJXPgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:36:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784EA9C;
        Tue, 24 Oct 2023 08:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698161767; x=1729697767;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m1ZmvptgUsoAcJISYKHS9lIT1nxC7ho8/UAuWzFddUs=;
  b=gxQIYKjE1HiAzQ+ENfu6G7nYPKWMA03jjV1Vc6LbTJTpOhkTC/8izfgt
   kqq5Yb3hipXKxdsccaOy/Nv0qFEVicKWawDJ6aFvoOtwOC6ApaicrSCos
   qpnpTt0RCRaaMHxi2Y8vV4P4V1CRscaPsmrvK90Q+PDRxYtTq0edIexg4
   xSY/ZgZxB7y+de3hh7MEXzqP3LsF3c9pH9dCqY/+3jVfFwuR39RTqN0mz
   0BGPI/mb4INNcW4awkhhc/ItoGhKBVgdIcDzWSBoVh6P3PXvkSQcSimTj
   hsEfAMITm762OKB1ZGBlkIz/IJZ8OcYsC9Ep9oc9tOWbNOWNmqv+M5HKh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="384290769"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="384290769"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:30:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="793528085"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="793528085"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 08:30:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 08:30:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 08:30:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 08:30:03 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 08:30:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IE9+JHCHPnU0gHE78Tl6Xbe4eDfSlT7f84M+h4bBgl9MUxQq+ihovurKc7tIsJLfAK8INw0qGrPU2kaan2UWhcQ0gPLCmdPUc6Khnvpewz+fwjAhtyWkwM0axCITYQlTI3wgsHBokWYKzOx7YohGgRyqGzAEVQLulBPga2HYde+JVvuGkj+XQcIMZX2dhwR8FUvEWBBLkwJ4XD58tsBVPMOTNZ5/xLu5zBbGTFMZhXHmbPIUzKCOprQMPvQ8shUiDd8don0hw7KKkuuaWgRrInUragUJFl28thZmfmZisnMmxm+QCKf52lPDZb6dpUVyKPGRUlbioIbEWf3Om01n8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njausf6g+RI+0u7SKxRcTcQ7Wwvr7DuuxA6vze+Qplg=;
 b=PjggYkdsEddNZwYOeAjBfG57ugeB13dHtv3z0SOvFYMc56nnWbeCO5YtFA2xicbhywFQjUsTFbdZ0F8GJ7nVu7+FsQ/uLmkW+CWSqxlW+R4JjuylnCPMEKEAlCGnuqd6OkeN+vsztDspnvREmXQX+yGqNlyzreDpferkDx5e6ErFjvMMTBGIgWKNlOt3cs/wsqrfEG0V3c59ePZeXPbOxkwSb47RTCmnUXpIdLxxumL0BL9iLUKLGRbrG3rmCMIjvoOxvpF5xtvi/nTwTmaXebDWqQoqbB7fxHPX3yRJEh9PC0/CgAZcwPgDAvRtUZM6y7K8VE906Q1GFyXQrqd2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by LV3PR11MB8604.namprd11.prod.outlook.com (2603:10b6:408:1ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Tue, 24 Oct
 2023 15:30:01 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3ffb:89e2:2724:4c5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3ffb:89e2:2724:4c5%2]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 15:29:59 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v9 0/8] Add support for Sub-NUMA cluster (SNC) systems
Thread-Topic: [PATCH v9 0/8] Add support for Sub-NUMA cluster (SNC) systems
Thread-Index: AQHaA5zI7d6eRkuVB02AcaLZ3Uxq0bBYclUAgACjiaA=
Date:   Tue, 24 Oct 2023 15:29:59 +0000
Message-ID: <SJ1PR11MB60834F077F9528CAD3C7E37CFCDFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231003213043.13565-1-tony.luck@intel.com>
 <20231020213100.123598-1-tony.luck@intel.com>
 <TYAPR01MB6330C183EEC67D29FB448E108BDFA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB6330C183EEC67D29FB448E108BDFA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=dde4638f-190a-4fc7-89a4-b6ab5015fe46;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED???;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-10-24T05:26:15Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|LV3PR11MB8604:EE_
x-ms-office365-filtering-correlation-id: 23dfc81d-016f-4309-13fa-08dbd4a61557
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bDdU3x6EhOzF77GqDz84L2Nc+UlYYEjuPw/Fu6W4n0AYuzYd7oe20AtzAQP5ieg/ikvWGqehCAnassN32TPXs1GG3hUY8v90zLWNKGEAPX/qfyO7193jkxw+xPj4QONAGaDj2k6APToJsD9Mep+a45r+6UPnwKunEQZgX+4U21lvr1SPTwDWe8n1vg7iDX4Qrr/FtpXmoaZ9qNCvOUA1UUZWhWt14BINJG6U6Lw6FQ5EdrZe7JaTv5JgN93MJ4LkWtmQ0cW9x4DJRpLRZXlX+ru+Ex4Kl3tAMg8rRrllW3Hx10+fsoDizAj4Fr+6OHUl8IqWpUyXNtFeMaL/fvJuojt5/+WpfeutKn7x5PLyzsaAFH+paB1YHCV04Ig5AGXYhGvy9SlOgEpzy6ulInePq/bb62LffRnXklMFqbj6gLXlDg5b30OFfLpuJEfdUZQ0GFGA2nTVv4ioUmDxJM0nHtb+ASIpLykuMIP1jnfrYYD8V6RrPaDjir1ZTt8nWkVd+ueoX3g5hoJMl73CRivVO9aOUwPvfb2VhVVPOQ5Sg9RRxKrZfDf5n2caAwKNaZFMMy2ewtVk2xqIHD2HusxPHvliVY6K15srMf8KPLZ1WR/xkgl2Dsd1tzqKGgNXCl6q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38070700009)(64756008)(478600001)(71200400001)(55016003)(316002)(7416002)(54906003)(76116006)(66446008)(82960400001)(66476007)(66556008)(66946007)(110136005)(86362001)(8676002)(2906002)(8936002)(41300700001)(122000001)(4744005)(4326008)(52536014)(38100700002)(33656002)(5660300002)(9686003)(7696005)(26005)(83380400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KACBgjLjUIspFMi0BXAC/ct62Es7AZ9NqBl3Jf4ecqy8uq6BdWwjmKLnHAlw?=
 =?us-ascii?Q?u9o4vXL1SM8GSUIWnr/k8ZHfq09+MgCrRslni7YEE2FwV2ioHFsUGzCEnM/0?=
 =?us-ascii?Q?VTNINzB/C4yLgLd0eeNwGyfPT7yitLL1OeQFIGRluGlLfbl/LeBtmhHXubIG?=
 =?us-ascii?Q?RkfCQ7dWuwpbtv61iOUglHX6EyOILV0rioXrjLrync5+2fqZe4R4A4CMNTa4?=
 =?us-ascii?Q?nk2DZQtCHbq5HrVc3iH/LqDtCHy8e5cDd216tp3xNbNP89q+PJmlSfkkbumx?=
 =?us-ascii?Q?vl30AMwtkNeGUXDUmiMVXa1l8SPLX/EvFu7Kpvxj/wOoCGQkiPe0v0wW5ZHu?=
 =?us-ascii?Q?++Quhq8aFbw7F+Gy+IPfEIzgiNWebgjIQ/cn5tx7Gxn/i+6wx26WC/GvfJSK?=
 =?us-ascii?Q?1C6r6fAZslyXMuUZ4By9RPOrxm4dLCvJYEl7UQ1vLNJ94wwe2bwM642bCTEC?=
 =?us-ascii?Q?hriL43ceaJvsaquyMNP/NLLfuaJI2KP31FBBvjYI25LfqmV0nIhdgy0ms4wi?=
 =?us-ascii?Q?ostW1sLoPvoueuneV2kFGF1Fp2Ujqi7UmHFiPK8x07U+p4sHhm/5vaCGim2q?=
 =?us-ascii?Q?QNmWgVXvmY4ZdOoLucBmTfVJeXxX/T54G3FDad4H9P5M+5LdoqexdvM/nYay?=
 =?us-ascii?Q?BUKisrpEb6xNwI5Sc8IHbxVpSsDD9Mj52OVgtmTJjvjFwmFATPJG5j7qeUCO?=
 =?us-ascii?Q?waljbHWg+pPDdMS8oyO3Svvx/gRM/0l3SNcBKws/b2BY6g/Ct1ssbzo2IfbP?=
 =?us-ascii?Q?9TRabhGhF/OVyTGqagguBtb2CyJFRS/8LExiKIqXriS4RZMJ9Ph6IoCLPGL7?=
 =?us-ascii?Q?HZxXHLf9AO6MLpguTO7UHiuIVeZWRyWZnAk6krKBYouf3wTwl1QIRcFsCZt/?=
 =?us-ascii?Q?A/2wQGS70Vnq9JFySd/n8Jr7ZBKSaNAlmgg3+bRNsufAY9kF0Ibk9Ia5n50h?=
 =?us-ascii?Q?R5L6vIyX19mrrkSFT7kJvWtFFqovRnpvIniztZi69MvzaJI8f755+Cbc48Fl?=
 =?us-ascii?Q?hb8+5Ac+X0ugdN6wAdciAdXVwPlnlHiFPhyzZI4ogg2Uwc3SrG+/jjsFTAwl?=
 =?us-ascii?Q?TJkmL9YZ4nioG5G/p322KvHmXeSFCZB8xivDGnDKqh1+y1wCqjuCiuL9o4LY?=
 =?us-ascii?Q?3fkby8+jO4ePKtkSwCcw+2MJIkIRYlvWjHtpNk2UOXzIq7CKh7sRtZziKNMo?=
 =?us-ascii?Q?GLyknLWXTUCKXzx8Tz3/eDQHyidttn1DhQfu+VT+gwxQH7xh7CNFhITjPMZY?=
 =?us-ascii?Q?GY3CfPfaBZ3AvhkoA68Ur+0FGPwXrmQTctZFkp0PZD36Bli79UuGc7EsTSvH?=
 =?us-ascii?Q?88Dl/6AUsa9HNY21jqi70jJY/Fpkd364tRPQJXGiEioUpq5NP+WVYfdvGk66?=
 =?us-ascii?Q?nqMTH6n1tfEDuxOjDfv8ymdxO7T4byQ6sN3x5TY4cvcot7FpDBCkKygAYiOA?=
 =?us-ascii?Q?ZoD4CHyQz6pMVdMbzA+dWf7qM8aCFU7e/moFoHM+0Z0eyg7QRYjphxu4DPCd?=
 =?us-ascii?Q?Pa9Xuv/GzA7TI8gGHt7vOG0CDCGr/9sdMQHYFCq3UJR6liYNp9dmhCV7iKuc?=
 =?us-ascii?Q?kJBkPlAWpyycMfOzaAfNlkmlJmwEF1mEh0ZgTlGn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23dfc81d-016f-4309-13fa-08dbd4a61557
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 15:29:59.0333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lje5/qFwSLvxyznmw1K+vpji2rhGC8ESnWS8PHJJcYFayqnUwmxaiKxMBWUYrbccQsLKmEgL1UL4fUK1RdHekA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8604
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

> Could you tell me what kernel version this patch series is based on?

Shaopeng TAN,

Sorry. It's buried in all the other text in the change log in the cover let=
ter.
I should have put this more prominently at the start of the cover letter.

	Rebased to tip/master October 20th since that has several other
	resctrl changes staged resdy for next merge window. No
	significant collisions, just noise where "git am" would not
	automatically apply. New base is:

	3300447612b2 ("Merge branch into tip/master: 'x86/tdx'")

-Tony
