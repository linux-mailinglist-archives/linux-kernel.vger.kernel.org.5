Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4652799CD1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 08:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346315AbjIJGZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 02:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346301AbjIJGZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 02:25:35 -0400
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20ED4CC0;
        Sat,  9 Sep 2023 23:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2478; q=dns/txt; s=iport;
  t=1694327127; x=1695536727;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pyFe+TWUlnkahQGduKGfEJI+eMGV985/XDgpPFZ3o0U=;
  b=CVPRRLSYGwjEiCUJLX15AQwiadzzARFqCTDCYwdbDJGu8urtmELbyN5b
   H01DMxuWCu6zrxNXI+yaBmyKDoEK64LQKcfB+nQ65tj5+UR9XW+Icmn3M
   FnuU2aNRGCQYz8IF8LRBURiZhaaaXUUcDH3qZxEZPXwCA1Ktw1HSgcdkx
   4=;
X-CSE-ConnectionGUID: 8mVe5ekHT22N5U+b7hlKKw==
X-CSE-MsgGUID: bDNUH3RuQ2mZ/oynLyLzMQ==
X-IPAS-Result: =?us-ascii?q?A0AcAABNYP1kmIUNJK1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEWBwEBCwGBZFJ2AlkqEkeIHQOETl+IZAOde4ElA1YPAQEBDQEBOQsEAQGFB?=
 =?us-ascii?q?gKGcQIlNAkOAQICAgEBAQEDAgMBAQEBAQEBAgEBBQEBAQIBBwQUAQEBAQEBA?=
 =?us-ascii?q?QEeGQUOECeFaA2GBAEBAQECARIoBgEBNwEEBwQCAQgRBAEBAR4FCzIdCAIEA?=
 =?us-ascii?q?Q0FCBqCXAGCKgMOIwMBEJwAAYFAAoooeIE0gQGCCQEBBgQFsBYEglIJgUgBi?=
 =?us-ascii?q?AgBiCGBZScbQIFNEoFGgmg+glcLAgOBX4QSgi6JTYIrglc/BQIygU9agn80K?=
 =?us-ascii?q?oEYiC8qgQgIXoFqPQINVQsLXYEUUTkegR4CAhE5E0dxGwMHA4ECECsHBC8bB?=
 =?us-ascii?q?wYJFi0lBlEELSQJExI+BIFngVEKgQY/EQ4RgkUiAgc2NhlLgmMJFQw1BEp2E?=
 =?us-ascii?q?CsEFBiBFARqBRoVHjcREhkNAwh2HQIyPAMFAwQ2ChUNCyEFFEMDSAZLCwMCH?=
 =?us-ascii?q?AUDAwSBNgUPHwIQGgYOLQMDGVcDRB1AAwttPTUGDhsFBGZZBaEFgliBIwgPW?=
 =?us-ascii?q?UBqAg+TEbIICieDZIwAlTsXhAGBVpIFkgMulwh3II1BiG+RTAIEAgQFAg4BA?=
 =?us-ascii?q?QaBYzqBW3AVgyIJSRkPjiAZH4NAhFk7imV2OwIHCwEBAwmLSAEB?=
IronPort-PHdr: A9a23:5KuJ6R8+KHoxyf9uWO3oyV9kXcBvk7zwOghQ7YIolPcTNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8ERHER98SSDOFNOUN37e0WUp3Sz6TAIHRCqOQd4PO3pGon6hMWs3Of08JrWME1EgTOnauZqJ
 Q6t5UXJ49ALiJFrLLowzBaBrnpTLuJRw24pbV7GlBfn7cD295lmmxk=
IronPort-Data: A9a23:Cb2Tl6gq1pgscdwYU7ts32ARX161qRAKZh0ujC45NGQN5FlHY01je
 htvW2HUbq7fNGGnfd53b4u/o0tUvMTTz9ZkHQY9/yFnEHxjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+1H1dOCn9CEgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZWFULOZ82QsaDlMuvvb8EoHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 woU5Ojklo9x105F5uKNyt4XQGVTKlLhFVTmZk5tZkSXqkMqShrefUoMHKF0hU9/011llj3qo
 TlHncTYpQwBZsUglAmBOvVVO3kWAEFIxFPICSi6j8HOwk7mTyG25ahTT0tpPYk72fkiVAmi9
 dRAQNwMRhmHg+Tzy7WhR6w134IoLdLgO8UUvXQIITPxVKl9B8udBfyRo4YDh1/chegWdRraT
 8YUZCBmcBTHSxZOIVwQTpk5mY9Eg1GmLmwA8QnE9PtfD277xiBX7Zi2CsfsINm4AsJEmGKJg
 nDjxjGsav0dHIXPlWXamp62vcfLnCXmSMcRGae++/pCnlKe3CoQBQcQWF/9puO24malR9tVL
 0E85CUjt+4x+VatQ927WAe3yENopTYVX95WVuY98gzIk/OS6AeCDW9CRTlEADA7iCMobWwv6
 FLUktDJOWY1luCoCnjC9rO3jiznbED5MlQ+TSMDSAIE5fzqr4cykg/DQ75f/Eid04Kd9dbYn
 m7ikcQuu1kApZVQj/ThrTgrlxrp98aXElNpjunCdj/9hj6VcrJJcGBBBbLzxPJEIYDxorKp4
 yVcw5L2AAzj8fiweMGlSeEJGvSi4OyIdWSFx1VuBJImsT+q/hZPnLy8Ahkgei+F0e5dJlcFh
 XM/XysNvfe/21P2NcdKj3qZUZhC8EQZPY2NugroRtRPeINtUwSM4TtjY0Wdt0i0zhlwy/FjY
 8vAKp/9ZZr/NUiB5GTvLwv6+eFzrh3SOUuPLXwG5039iOHHNCL9pUktaQXWNojVE59oUC2Mo
 4oAaKNmOj1UUfb1ZWHM4JUPIFURRUXX9riow/G7gtWre1I8cEl4Uqe56ep4J+RNwf8P/s+Wp
 S7VZ6Ot4Ael7ZExAV/UOikLhXKGdcsXkE/XygR3ZQb3iyl5MdnwhErdHrNuFYQaGCVY5accZ
 9EOet6LBbJETTGvxtjXRcOVQFBKHPhzuT+zAg==
IronPort-HdrOrdr: A9a23:XCBKOq6gG6n7MG6TCgPXwY2CI+orL9Y04lQ7vn2ZFiYlEfBwxv
 rPoB1E737JYW4qKQAdcLC7VJVpQRvnhOdICPoqTMeftW7dySWVxeBZnMTfKljbak/DH4FmpN
 pdmsRFebrN5B1B/LjHCWqDYpcdKbu8gdyVbI7lph8HI3AOGsVdBkVCe3mm+yZNNXF77O8CZe
 ChD7181kGdkBosH6KGL0hAddLu4/fMk5XrawMHARkI1Cmi5AnD1JfKVzKj8lM7ST1g/ZcOmF
 Kpr+X+3MqemsD+7iWZ+37Y7pxQltek4MBEHtawhs8cLSipohq0Zax6Mofy/wwdkaWK0hIHgd
 PMqxAvM4BY8HXKZFy4phPrxk3JzCsu0Xn/0lWV6EGT4/ARBQhKTvapt7gpNScx2HBQ+u2UF5
 g7hl5xgqAnSS8oWh6Nv+QgGSsazXZc6kBS4tL7x0YvI7f2LoUh7bD2OChuYco99OWQ0vF8LM
 B+SM7b//pYalWccjTQuXRu2sWlWjApEg6BWVVqgL3e79F6pgEw86Ij/r1Vol4QsJYmD5VU7e
 XNNapl0LlIU88NdKp4QOMMW9G+BGDBSQ/FdDv6GyWqKIgXf3bW75Ln6rQ84++nPJQO0ZspgZ
 zEFFdVr3Q7dU7iAdCHmJdL7hfOSmOgWimF8LAS27Fp/rnnALb7OyyKT14j18OmvvUEG8XeH+
 2+PZpHasWTZFcG2bw5qTEWd6MiXkX2Cvdlz+rTc2j+1v72Fg==
X-Talos-CUID: =?us-ascii?q?9a23=3AY87JPmmk6i1Hsro4XWICrdVK543XOS3Y8nqNLky?=
 =?us-ascii?q?YNTwzbuCoClXP+KdHsNU7zg=3D=3D?=
X-Talos-MUID: 9a23:8tnS2QYCe1lr9eBTvRPKuRE5DtpRuaGcT0ccl7EXn9uhDHkl
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-11.cisco.com ([173.36.13.133])
  by alln-iport-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 06:25:26 +0000
Received: from alln-opgw-5.cisco.com (alln-opgw-5.cisco.com [173.37.147.253])
        by alln-core-11.cisco.com (8.15.2/8.15.2) with ESMTPS id 38A6PPFa007969
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Sep 2023 06:25:25 GMT
X-CSE-ConnectionGUID: +bl22pgaSBO/7hcfD6uMQw==
X-CSE-MsgGUID: 8+u9Sr6jQaWMPRizb9kdcw==
Authentication-Results: alln-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=deeratho@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.02,241,1688428800"; 
   d="scan'208";a="977858"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by alln-opgw-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 06:25:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hr/Sc93hAA9nBCImpGvw2hz8Q1xt4htgEAYjRdn4IVvEAqQ/dtGMlOc7l7aAOZ5V4l4qUddTUUh3RLey2bHT8iGUTqVC7eoWr7EER9T1ObYqmU8/B2eN68mMK4uIfJ/wSFA4pSy4y7HoCYUaYzolZriyJp87tDSLhmXMYx8IOShzv/dxdafmweS9mh0koh+2SVav42KxA5WadytKt72q3AqlshdyW3nTYYqltNyeGSSYF1xo28rImZfhJ9wjxIVeubpSCaf1PBVEVgh/uCN+BBbdcbhNSXxqj642YdkJZ8/iA35Yi1DcwmiRqb4NCDIApDChjQD4aryPiy/8q4iCnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyFe+TWUlnkahQGduKGfEJI+eMGV985/XDgpPFZ3o0U=;
 b=D094tfyTR6b4qD3eu0EUlhxQJbr8SyiRWAAgyVBPYLB/A/gQ0+NX0d3yrG6ONR6q8VmchyjmIIY+CsR4k8/r0u98nnKVQSqibLZkwI/KUQ2ecnUTAKl4Os0Lu8QSKFPm9Au+xnljH4gbz/xc43LanCLvv3YoQulLsXRmYNms5zo/xp9y/uruzbpc99tSwsoVtd3afKXOSJ7n7+j/6dCo4ELEWp7ZTX0EcZcA+efYIIWjLoN0bdp+JZXrNcYSUrqHKLqkNhFo03/l5o3aa/rldtXaaZHnxIL+VrsYOKVcWFyXoNi3gwodJ2HjSqhmjv/ud4Nd2fGaeSCzYSxfLnMKFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyFe+TWUlnkahQGduKGfEJI+eMGV985/XDgpPFZ3o0U=;
 b=kLz9lYgEm2ZlX2+K61yDZsT2atp/GpMnVobP6mvODhRwnVD8RgZ6i0O0VLq7DpzqhudvjkEanVDBEI+Flue3gbcFKnlay2M021szfBqaZxhKV9FMToM0Eqke8PC9DYvaIVVcNj2vflgqW4ptV1z/sgcwD6Y+3RNTij27aD9/7QI=
Received: from DM4PR11MB6189.namprd11.prod.outlook.com (2603:10b6:8:ae::18) by
 PH7PR11MB7595.namprd11.prod.outlook.com (2603:10b6:510:27a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Sun, 10 Sep 2023 06:25:24 +0000
Received: from DM4PR11MB6189.namprd11.prod.outlook.com
 ([fe80::9b29:81ff:3783:1740]) by DM4PR11MB6189.namprd11.prod.outlook.com
 ([fe80::9b29:81ff:3783:1740%4]) with mapi id 15.20.6768.029; Sun, 10 Sep 2023
 06:25:23 +0000
From:   "Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco)" 
        <deeratho@cisco.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "salvatore.bonaccorso@gmail.com" <salvatore.bonaccorso@gmail.com>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in
 btsdio_remove due to race condition
Thread-Topic: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in
 btsdio_remove due to race condition
Thread-Index: AQHZ4LvcJrVsnoRBq0W95V9qrz7orbAPJ16AgAEtl9CAAB50cIAADDAAgAAAvOCAAATUgIABq+owgAA0MYCAATYskA==
Date:   Sun, 10 Sep 2023 06:25:22 +0000
Message-ID: <DM4PR11MB6189F15AB7DFD11AA02A16C2C4F3A@DM4PR11MB6189.namprd11.prod.outlook.com>
References: <20230906121525.3946250-1-deeratho@cisco.com>
 <2023090738-passive-snowless-3b9d@gregkh>
 <DM4PR11MB6189DEDD52F3E17C8C4E3D1BC4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
 <DM4PR11MB61890EE125816A786D153C22C4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
 <2023090820-wielder-angled-3def@gregkh>
 <DM4PR11MB618943BFA18521150923326BC4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
 <2023090826-fabulous-genetics-e912@gregkh>
 <DM4PR11MB61897793502F49240BCA903CC4ECA@DM4PR11MB6189.namprd11.prod.outlook.com>
 <2023090925-eloquence-derail-1e2b@gregkh>
In-Reply-To: <2023090925-eloquence-derail-1e2b@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6189:EE_|PH7PR11MB7595:EE_
x-ms-office365-filtering-correlation-id: 0e1a3452-bb60-45a7-2aeb-08dbb1c6b696
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2PWSZVbK6cwQuW9neZPuc8sfAJyMsaE332jA13tbyX4x2NU4tavtIEkGkXnkIJ2WQTQXWy6u7uFXzDXTmuK1WNlrEmcSVrfJi4u9V4PpiHbfxhgBToD/wYnEAxCY9AFEApmSRQHq9f/oiVVpHk4X93vhp0D9bzg9zN4b5eRgGhZErJBNV1XHrjGTWmRwYOW/tOOiVL8zhnxdxBgox6b30zn7gvDsrGSfWQtYdlI6s6ecZ57uu15stLDtbPyAtlFtNtW+PHJ56c6rTBUUO4hfVIUy7+2kWkjJjFVmxIhwoIRr9HmoW50RIjcIxbJGEoI9nDhPGFEcrrGBjYdY/MP3iTNtM6E+moTRj3JBJ62girghh4g7qyR0v8eTEHzvOnd+6OAiEn8BF6Hb7RHcoZOtdI2pEBZQ5l07JZ9ECao75xCaZYhqCNPobcJl3rMoLotnHqJz2qlTPCTXQxR1AaHktvuLFvjtHoVVHlIZmUsITIgeK+L7WNsEiWhNCtuvGYWNCFdLt2LwLUZASQckZ1jyMQiefVljtNlhx3LvvSkxP1OqVeQ9XGpBj4VSaHhlz03M2Tt/2PxcO5/qEeTe3VlENo/cH7jrPKlcG2RTMsewAb8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199024)(186009)(1800799009)(38100700002)(33656002)(55016003)(8676002)(52536014)(7696005)(6506007)(83380400001)(53546011)(4326008)(8936002)(5660300002)(71200400001)(478600001)(86362001)(41300700001)(9686003)(26005)(110136005)(66476007)(19625735003)(76116006)(966005)(122000001)(38070700005)(64756008)(66946007)(316002)(54906003)(66446008)(66556008)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CKmfhNWwBnKbDVmxb+SZIDkKRozyX/I/Ql29eilHdNEkSsbpN4ERwTVQr4I3?=
 =?us-ascii?Q?LvpmlbC9LzkTT6dYwbxbiL/AihLGinrJ+MehTTZEIjTSKNFGYpho7GboSgzB?=
 =?us-ascii?Q?B8fizWprtVi4qZStzQvex/aEXa4sTFNcX/Kda2MlDDuBiAd7tbhCmqonQDzZ?=
 =?us-ascii?Q?MNH2RQJVP71cuwq4PQ6l4wSQODOpt9pFkVA5wuxmV4NqXwS40kdgUW4GrK1K?=
 =?us-ascii?Q?gybGXsRvUI/LGcfbuqhdsQB6omu9uxZUbN4LLPwhWllxXHuGJn4uc0O9Ic3R?=
 =?us-ascii?Q?TFA0/18PixHkEq07gv5gSMWaeb5oUVQi7COXuqTMT1Wa0+J8ZNeps1hgz/5K?=
 =?us-ascii?Q?1XB0Es/Mm96tjHDkbZpbaTYsBMkdQtv7FE1zaYOq2MUfBdnaJDqPgo+XR7pr?=
 =?us-ascii?Q?up0g+Hir0qUMefKlh89ASNGBNSFNFb6L/WXKYwsZytJTMMk1JlJKL3oSZfXX?=
 =?us-ascii?Q?UhY8LqEe50LmPE2doMmlX0Iirv7qgPB/0ljFtpvHfMILjyiHOIlhI+rhDlVe?=
 =?us-ascii?Q?fnwYheyU6z67yA20q8bWdC6kzPo3xGBRaA+LF7mVTE/p7OC/oOkoQ9xsjEwQ?=
 =?us-ascii?Q?FB7lkKLqmeLsN5jVO7cDzHkG1lwBhyKDPRFfrEwMMLSeAQE80AhPXUphYabR?=
 =?us-ascii?Q?lIJyfiH2sGnyEG52ttlPnG6NDF0ob6fWiiPtYcCqt8kEVK7gFwTxkHqkiI+9?=
 =?us-ascii?Q?viXvvW+5HgiyhXu2RZ1y9toxkadBFviTa4v8m5Eq8+TrZThpB0BH/xbkYLlK?=
 =?us-ascii?Q?1wpqitmQ4Sl/luPgr0sHy5Yc0VtB9VML2DrxE0FiszyYbK9JcyylCtklJCQp?=
 =?us-ascii?Q?l2bWd7uljR/aO2n8bO4Nn6f/hIfMJk9ToKfO4LXzKAcMPA1cLNXIXOcBItUR?=
 =?us-ascii?Q?RtbPXnuanc4H9HGtuFy8sVagEAf4y2E8eQK6qCfOLSYmzQZ60gj1Wz/JQfOZ?=
 =?us-ascii?Q?4wMCNaySHoA6DF4jXFd+jDMVm28BWPS7qQcKuS3f/C6k/5NN/6RyWosWuT/y?=
 =?us-ascii?Q?tLDNpMlxq2A40zsFacTP9J7kC/mtl5gyujsrKTEZJ/QNXP+XOuvE6GYxxYfD?=
 =?us-ascii?Q?tW1rpLi2VWsTe9LMLYZ0JoJncRQwh5MWk+kutfED7m1pRwEY2NIWKnVHHwg0?=
 =?us-ascii?Q?V6Lq80CWaQazqzv9m6Fqwh3I4rhCJwo364gtLCTQshVCVQ//bLUllbht+FGG?=
 =?us-ascii?Q?HN2R+ymWPf+XjLreYx7vXtW9gaFC/u2w+9mREj1jfmXFwyGkCHoMsal6HToB?=
 =?us-ascii?Q?uxARUZl+prz6zDl9ow8GMVI6R4P88ntgxivjFPTMbJ+sfBqgsFeVlWVzb3T+?=
 =?us-ascii?Q?tqV8zzqusAs34MkxJl+XrSat0uUayhanSRDe6H52ejjEpnu3uR5DJA0IPKtB?=
 =?us-ascii?Q?IHLXxPFjj6rMMpCC8+6i6XaS8vqDTuFuJpp3vkTO/5gWowWbsu8r5et+M0Z+?=
 =?us-ascii?Q?CTaYH1SgdJ0pdRob6PfXCuv16EG1MZsTk0jA/933rCSz8HupWH7ReLSJJKwd?=
 =?us-ascii?Q?MEKpr4aqUfBeaehDzj9ofG4R5AHeFqhgpcYz8Dj23BcnTTef5Z81HQJhfFnh?=
 =?us-ascii?Q?JT3pGDV19iFX3m2NFAK352rX3UXLy86Hu85Gkud8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1a3452-bb60-45a7-2aeb-08dbb1c6b696
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2023 06:25:22.7472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iS2l14cSYixYG1QolvdBrhltdjpuvrDvUkBFR4b6m82hfYLGTISfOBqFVHwE574yFxkRK6wvV8u8wOU02bx5Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7595
X-Outbound-SMTP-Client: 173.37.147.253, alln-opgw-5.cisco.com
X-Outbound-Node: alln-core-11.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>=20
Sent: Saturday, September 9, 2023 5:17 PM
To: Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco) <deeratho@cisc=
o.com>
Cc: stable@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in =
btsdio_remove due to race condition

On Sat, Sep 09, 2023 at 08:49:52AM +0000, Deepak Rathore -X (deeratho - E-I=
NFO CHIPS INC at Cisco) wrote:
> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, September 8, 2023 12:39 PM
> To: Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco)=20
> <deeratho@cisco.com>
> Cc: stable@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free=20
> bug in btsdio_remove due to race condition
>=20
> > A: http://en.wikipedia.org/wiki/Top_post
> > Q: Were do I find info about this thing called top-posting?
> > A: Because it messes up the order in which people normally read text.
> > Q: Why is top-posting such a bad thing?
> > A: Top-posting.
> > Q: What is the most annoying thing in e-mail?
>=20
> > A: No.
> > Q: Should I include quotations after my reply?
>=20
>=20
> > http://daringfireball.net/2007/07/on_top
>=20
> On Fri, Sep 08, 2023 at 06:54:06AM +0000, Deepak Rathore -X (deeratho - E=
-INFO CHIPS INC at Cisco) wrote:
> > Hi Greg,
> >=20
> > This change is required to fix kernel CVE: CVE-2023-1989 which is=20
> > reported in v6.1 kernel version.
>=20
> > Which change?
>=20
> [Deepak]: I am referring below change. This below change is required to f=
ix kernel CVE: CVE-2023-1989 which is reported in v6.1 kernel.
>=20
> Subject: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in=20
> btsdio_remove due to race condition
>=20
> From: Zheng Wang <zyytlz.wz@163.com>
>=20
> [ Upstream commit 73f7b171b7c09139eb3c6a5677c200dc1be5f318 ]

> This commit is already in the 6.1.52 kernel release, why do you want it i=
ncluded again?

> confused,

> greg k-h

Hi Greg, Salvatore,

When I have submitted this patch for review, at that time, 6.1.52 was not r=
eleased.

It will be good if you can share me guideline or details like how I can sha=
re CVE fix patch to upstream for review like what details I need to include=
 in patch for review so from next time, we can save time in query discussio=
n.

Regards,
Deepak
