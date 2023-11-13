Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539DF7E9654
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 05:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjKMEqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 23:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKMEqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 23:46:14 -0500
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712D41716;
        Sun, 12 Nov 2023 20:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1699850771; x=1731386771;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=94je/IGiPH2ZEiK14b56f9eDno4EGMG3LQyiDty94CI=;
  b=ZlMJTO/dhaLUmk8iKZNj/iIhDGAVyvIECwt0OGa+CkFlswmwVNBFg4u8
   7syH+u84h6rvPT952zyY6mwcC9zFgm0BH2HG3MZnHNWnArsRHPkHiL49v
   jTHPcCNjAgsyByKMV8EPMuR6qidrgF8ZR7P799LmJyrHybJyig1tLf9lw
   9AYpojQWKvxFb1bnwlLNofg4jh7LQ2Vb2fctXAhr+Pct2T2rMk7t0RPYb
   2SN86QzvkDs52+hLjecEhrxlkHx5aGyxBYAMoBLBjr0Hla5KZzG7OWDv4
   53XLwa2RUzGSAkUzwkbZAa3Dy7zHPsLPEEU6ReOy91kqDPLG+ZIc1eSgh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="102355026"
X-IronPort-AV: E=Sophos;i="6.03,298,1694703600"; 
   d="scan'208";a="102355026"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 13:46:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9T++BXw7evG6cFw0m+EUKaUQug7mK9k8/B6SkY0bcznUdw6h9Rgj1020StTx2WAWr4iDndFWhjE+XCQoLXFGYKehPb175TFgOllvE2FlwCnTMjkisYO3E8UIL1UMy7LjKwE3WLkyx+10PaCeEZkn/Rg4CXLf4LUx+eqbYU9xuJ84OX3blZcFfgkTnwHLW6UU3CwGAtLYEVJslhMG6RwHI/NcA/hKpH9xmI83B4uzKW3I3nr/m/9DfZ9XPuKDtg+ZOymApWlVzLkOrsAH5FfufJg2YA4ElFYbqyaxaztrO23YUfZMhFP5KPoW8hgaMR9gRbjF9qn9nvOqQtr1uO4kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94je/IGiPH2ZEiK14b56f9eDno4EGMG3LQyiDty94CI=;
 b=EkALw7zeu2pIhEasdHlDe/q8QUUJ6hV1Tjlmvz1Qgve4IOt/BMe7ajlfoa1dcMrqucSWd+ewRIPF67KDV5fNwLrFXeJ/ZA/Igu9IYpr6sg9etyK5NBAn3i6HPCZDb0k8M+FJWpyICMkhLrnqquRBm3RQvnegZbVhjKk1aprascyaHTOkuZ3PEFNjzAbAbioct2ARomEh97S03/2gVCwbq+v2J36CUsqFYO+eTssiYUYwOAOifRUJoRqEDRZg5o9LPYLGu0LQathCq57qO/TcfwarajJYNfu7U2uxGYcqS1CMgUy5ski6URNRb/XXAVQrIwxFwFkZWoVoi1JQoB+ENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYCPR01MB11544.jpnprd01.prod.outlook.com (2603:1096:400:388::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 04:46:00 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::50b4:e09e:4f2c:a5e3]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::50b4:e09e:4f2c:a5e3%5]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 04:46:00 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'Tony Luck' <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
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
Subject: RE: [PATCH v11 0/8] Add support for Sub-NUMA cluster (SNC) systems
Thread-Topic: [PATCH v11 0/8] Add support for Sub-NUMA cluster (SNC) systems
Thread-Index: AQHaE2HU2S5N0wc6j0OwKX6c25Pe5rB3hcGQ
Date:   Mon, 13 Nov 2023 04:46:00 +0000
Message-ID: <TYAPR01MB6330461AE38D0991FBF62A0D8BB3A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20231031211708.37390-1-tony.luck@intel.com>
 <20231109230915.73600-1-tony.luck@intel.com>
In-Reply-To: <20231109230915.73600-1-tony.luck@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=5d64cce7-ed31-4539-b02d-4fa91c491db1;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2023-11-13T04:43:41Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 27890044d4a5460d88fc182d82749a1c
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYCPR01MB11544:EE_
x-ms-office365-filtering-correlation-id: 29367b49-a226-4284-c16c-08dbe4036f15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DvLbFN5O/1y7DY8ACXTG09wSRHYo8KE5elzuvT0RDoLdw12YgBvr+OV3epeJgy96M1ocvO6Inv7hOXNIbrLXwoiWv1RIZkRpbzcdRvfqXFBc+LPCe6flEKz5/yISadH1N1ruCOaYBi5Etkm8+orqEpvI6ritZNuqnz346HQdzd6b5KIeNjSps/q/pS5JqOBHN+C94GiXe0ZyVbwfDRLkCOir73LObnsm+Ny4175gay56kzx5+TZ3S4Oxgdb4EubOzivQEVpqW67uRU/eRBJ9g0mOL8ZaRjHFQYoaVwn6prs0f2KIr2+Sn4y4LdtAzXDIQSrpalWq0vnlV++JmilfnqGIkpo97eEInPdoB5st0+lK6BLxg/9pd4zrH+q27b6pamMEjWQWEplN+bPH8tpiLv9T0cBieMQwoEBxYGsoZmf61StyvwgHSB7eql4GpxhyUNXj/y1+cDSgv0S/1ZjZvEkR6Tqbp3lsqwBiXF99a8cy8EuJ+6n2I9UnSaXdMPah/3KtGtCTXtAOcbYN0UD1UgmvNJAozL7g6/2fe4A6zu5nvf+Ob0se41F4DscLVSknN1cBhD++UGvn1Mgm4GxZmAoVepbiVsYB66H6fR7/JRnLvg5LRJpvdq6CNIQNavVP9eAayu1DCX8DdxhQmIaxog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(186009)(1590799021)(64100799003)(1800799009)(1580799018)(26005)(6506007)(7696005)(71200400001)(9686003)(5660300002)(4326008)(8936002)(8676002)(52536014)(2906002)(41300700001)(7416002)(478600001)(316002)(110136005)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(82960400001)(122000001)(85182001)(33656002)(86362001)(558084003)(38100700002)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?dHU3cmVQajRtZFY3MjRtZXl2anZ0Y2xNZXMzc3czQTlQcVowMzRpRmQv?=
 =?iso-2022-jp?B?dXFYaExLeDVTb0ZZa2M0QXcybVI4QzRIZlRFUGNOY2J0ckxXVG9OeEFG?=
 =?iso-2022-jp?B?aXNsZDV4TjlZeUlLdVljblZoRjczTUl2cWFvaXFGazg1dU1NRy9YL0tR?=
 =?iso-2022-jp?B?MjJHcTU3Q3NKRnR3d1pQd0ZOQ0dzeGVzMHNadWlnMHJOemd6NU9NV1dI?=
 =?iso-2022-jp?B?MDJVeXVVNlNjdFdxd0hYbGNJWmNPbjc4cEVJY0w3cHBZVCtBbnZPR1h2?=
 =?iso-2022-jp?B?TlBUSmpVMjgvdkNTNUNnS2Vtc01idy94VDBGODIxWndCRGtTajZkRnNC?=
 =?iso-2022-jp?B?VHJzeThiaEJWQnNCMzcySWs1Vjlyb0p4QjhPdXV4VEEvRzdaSS9ZYUlV?=
 =?iso-2022-jp?B?UllqQkE4ai9Jd2RjYlh6bFJhVHdxSVRaUVZXN0ZQWkJHaHRuODdXYW12?=
 =?iso-2022-jp?B?Q0E1MlhpK0o0RFhIUC9VWlR2a1dvZFRYQnZNeDRWT3EvcS9yR01yUytM?=
 =?iso-2022-jp?B?Q3A4aDZhU1lBbFR4aEx0czdDeWJXd0t3MEJFczlVYWhYOUxEVytGWGlv?=
 =?iso-2022-jp?B?YlZIWVF0REExZzRUZnlaY3oxa3pOKzAzdHFxWFpPR00rcHorSnlLTnc2?=
 =?iso-2022-jp?B?R3BSb1hSYXJuWjdFMVV6QkJQZHRhN0lGVldvaGJJL0R1dk1hUGhxYjFJ?=
 =?iso-2022-jp?B?WWNFcUU0NnFFT0ZwK2treEwvbnlKZnpyZlBUWTVsWEROTVVkQlV1dDRO?=
 =?iso-2022-jp?B?SXJicVpGdUpLdmNYSHpzRFFxZnpBSTFRZmgxSE5qekM0SzRkVUZHNlVO?=
 =?iso-2022-jp?B?SHIvQmNldm9wdTZVa28rMVJFQ09FVzBiWlJJeXcvOGlGQyt6aFo4SS9L?=
 =?iso-2022-jp?B?Y3gyNUpEbGxFRzN6aHdCbDdJN2kyblpVT3VLZUhTaWxhSDUzSnZYK3pv?=
 =?iso-2022-jp?B?SzdTOXkyN1JWNEtYVFpKWVhhSXF5TTgzeFI1VzIxN2pQN0RRcHUxejly?=
 =?iso-2022-jp?B?dG9GS3ZXbkI2d3FTajFzNzV0RlBWY0RXTGE3b0dBQTNmY21HajhCUkw4?=
 =?iso-2022-jp?B?ankwQmFGeUE1K0NzUDR1Rk93NWVpSlorK3MrekZRSHdwaGd4YWliekpY?=
 =?iso-2022-jp?B?cXU5U2Q5dFMzWll2WXFqcFZ3aUxnVHVreEFGb0RBNW5YamFHMTR0TXJx?=
 =?iso-2022-jp?B?QkwwK2QyK0lOaW9QMlIwYWM0MXJOSHdsU0tXKzBZcTFqdXRrdXBTbHlP?=
 =?iso-2022-jp?B?VmJzK0pKRDUwTGJHWXFnYlNvYVF0OXBkc2pKK2JOcWliNzdxcnVnVFE1?=
 =?iso-2022-jp?B?dWppOEJmcyszakZab3BhQlJJQldaNHY0bHRRMktQRUpva2k1Q3RyTW4y?=
 =?iso-2022-jp?B?akFXTDZhTnM1MmFjMHR4YjF6WDQwSVZoYXB0Yi9CenJEVWJDNUZCZGhN?=
 =?iso-2022-jp?B?c1hlL3g1RURqS0wvQWlvQmU3bUhDUFMzdVJwOTlIQndsaFQzWUU2ZHlv?=
 =?iso-2022-jp?B?Qy9FK0QvVytSODA3VVVJZTVmMGNJczZveGR2a2NZeVZHeFNWczN5R1VY?=
 =?iso-2022-jp?B?RVFyZnUrTkMwUmhqVjRUSHRlL1gzVjkxMzZpZFUrdkd5VkpGaXJFZlV1?=
 =?iso-2022-jp?B?Tm9BcXp4c1hlUS9JTE5udlVUdnhFN0kyMTZOKzFyYmtPOElpYlgzYWlR?=
 =?iso-2022-jp?B?eUtQVVFzZDBCc3dMd0ZuUzZ4QzNwK0tmemFWUmwxUUNxSENhU25PTGFv?=
 =?iso-2022-jp?B?L1VIc0hXR2xrNjNhMXhYaCtyTkExYS93em5UNWVpWGIzT1JhYzYvekwv?=
 =?iso-2022-jp?B?V1BoQUVUWWFCVWVqWDJyS2l2WlBDUlpqc202WGI5cHU3OEJpL21WQUpW?=
 =?iso-2022-jp?B?VTlpT2dFbE1MRUV1eGdVU1FFUXdnbzlUUTljaTdEZU5Ic1hzaElEelhk?=
 =?iso-2022-jp?B?K0JPUjhCNzFMQUdHOVF2cGx5SjI1NzQxSktjZGw4VmFFYnRUMUtmMU1n?=
 =?iso-2022-jp?B?czNudkNld3Z3Qks4QnZmZWRHR0xSVXVVZ1Y2bzIwY2lXQWl2NGlMSlZM?=
 =?iso-2022-jp?B?QXl2TzY3WjRDeENmWjNUYTVlbjR2cnVVd2FTYTBvMHh5WnA4OVc2Qkdp?=
 =?iso-2022-jp?B?dFdVTWFuU3hISStwdXloVkZtb0tSZDE5WHM3WndjaDBmNm5GbTRzaXdm?=
 =?iso-2022-jp?B?amlIbUxNU0hPT0ppRXgwemxObjUyYi9sSnRza0ZyWHhFMGYxVkJNcExU?=
 =?iso-2022-jp?B?ck5nTWdQVUJpWWlxZjV1QXFZOHVQenNPVnhKMzV3bFkvT2Q2bEZ5YWNh?=
 =?iso-2022-jp?B?U3NiM21UUkV4Q2JtVkMxcTRpL1VBR1J1U1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?MDV1SnZCb3BUZWo5NjNNL2dmQ1hlTmFJa1VTVHNXT2oxTEI1WDAxOVZP?=
 =?iso-2022-jp?B?eWs4anNSVUduQXkzRzQzRmMzMTlpZ3U4bDRHcVhnVWVNQ0ZIRWx2cHlF?=
 =?iso-2022-jp?B?eTVEeTRMdW1EeUw4RmkrMllpNnN5NStQRC9KbEJIMmV6dkVuQ1NTcWRD?=
 =?iso-2022-jp?B?NDNpMlFBSTRSdzl0UVRtbTV5RHhqM3BLdy9Pc1RZV1dMUExsbk9Nakxo?=
 =?iso-2022-jp?B?akZjREp4QWordkRITWtJdU01aDQwVmdrejNyekd3bzZaU0NkcUVuU3M2?=
 =?iso-2022-jp?B?ZW5vOWw3dGRFRmFZKy9qK05pMnc3SXRjdURRQ011Y0FVK1VORDhMUUJJ?=
 =?iso-2022-jp?B?ODNMQVY1SFp5UldBd1k4WG5RRGVWbkdFZTdPWTN5eENkZ2ZQMTJEWVFB?=
 =?iso-2022-jp?B?NDVBZ01qbEx3TGRldEMwcG90bitEd1gvYTlWNVVDT0gzemdzTHZaTnlo?=
 =?iso-2022-jp?B?N04yQmMzQ3I4TmFrcmtXTW9oZFJCbGQzVXAwWWNjSllOOFVIcSswRU1X?=
 =?iso-2022-jp?B?Z2x2b3loQ1BtbWxhNGkxVThtVzN2dmhVanBwN1RLSlBiTDBCbzN0YTlz?=
 =?iso-2022-jp?B?ZDBNa0hDUTVPd0xjVFFRaERUUHZmcTRGazVMMFA0akVHd0tGaDhUTUs5?=
 =?iso-2022-jp?B?UVk1akR3MXl0a0s3L29SaG1DNm1GN29tdkF1SkpBYXBROXA3cTBsemtO?=
 =?iso-2022-jp?B?dEIxVGl2YjdBdEFtSFhJcVo4WDlESElOK1V5UTJuYk55U01KVkFpRXhi?=
 =?iso-2022-jp?B?UmRkQUJ6NVlyWFgvbVBTME1NRHc4b1FyK1JHODdOcU5KUGFTbjdycTZw?=
 =?iso-2022-jp?B?cVJ2RXN6NFhURkJSRkx3SHFsMmVtQXBwS1hMc3JmSllTc3ZPazNkQnYy?=
 =?iso-2022-jp?B?SGRLNk9Kb3I5ZjFUMnp0eUVDclN5M1JEdFRsQVc2VzNVWmtkNkRCSFNk?=
 =?iso-2022-jp?B?NkJMam9BSkJqV2lBWWt5OGpFazdqbGE0TXNja0xZcnlxTzluUUMzeG1P?=
 =?iso-2022-jp?B?VUNXb3U1VnR0U200WWVxYWdHYnJZdUR6bFZhTTFUUTNDd2NXdnNiU3BW?=
 =?iso-2022-jp?B?emhjb01mckJiUkZyLzhOaGpWSlFwVkE4akZLNWhSRnViRnIvUlZzeXhm?=
 =?iso-2022-jp?B?aVIrU28rekFjSGk1UGFjWjFsSEozNUxNTUc5bnNMcVEyM2YwL3YydGl0?=
 =?iso-2022-jp?B?dTgwK2NOMHFoUURCYVNLYmdOblg3OVYxMFVxQmIvOFhpc0Y5QlZUb0hk?=
 =?iso-2022-jp?B?ZnpYT3VxYTRCYVBkeUtwaUlZTTFUR01BRkh4c2pwVkozNGJpTk10RUNR?=
 =?iso-2022-jp?B?ZzZNWGFkY29QUElPWWtKUUlCS2NFL2V1Tm45dXBkVWFnUVZwQ21RdFd1?=
 =?iso-2022-jp?B?MnIzVXhXUTZBblQ0TW9HYmZPeFg4ODhlUEw0cDc0aHdNdmVxZmU2RTdr?=
 =?iso-2022-jp?B?dVlMdlM5TThpRmhyMUg0QUYrMzF0dDdpSDZnQUJwRjY3Y3E0YjhyUVNu?=
 =?iso-2022-jp?B?cXNibEZqUko3N0QrV0Z6UFJOOThHWU5lWXk1cFc2TXAyamdOV3ZJWGRV?=
 =?iso-2022-jp?B?em81T0VweVZ6ZWcwZUZ4V1lBPT0=?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29367b49-a226-4284-c16c-08dbe4036f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 04:46:00.2603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y0vSt1RLjG1Y6PCT7U25A1/iv7a+4pXk1QJL9XAyrHTHtc+aPjDAZThmSYJTDhhxaq4SLbMBccDnrRaT20xGqlVJHKdRZ/+nJveVszp5RLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11544
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tony,

I ran resctrl selftest on Intel(R) Xeon(R) Gold 6254 CPU.
Everything looks good.

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

Best regards,
Shaopeng TAN
