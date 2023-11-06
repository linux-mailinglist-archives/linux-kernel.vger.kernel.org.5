Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99867E2D24
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjKFToo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjKFTom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:44:42 -0500
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FB5125;
        Mon,  6 Nov 2023 11:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1200; q=dns/txt; s=iport;
  t=1699299879; x=1700509479;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m9IDpKU0tHRxjhTRoRA6gjThs/p++lyj6sXgDrcHFB0=;
  b=GV4SPwp6lfdgVOUfcJ+EjnBy0QzESLjFPSAg6ELfnRPB6umPfsymUoMz
   yLV7dTdffFefQ33uKCOYVRG2YZNORcMp3zvB1SMa2j095ArIhsKSzGe6E
   29KfexHyFGRl98jXJRzFWPbwWxmkk90zQf1NiakaV3fgykl2RORjQwnuy
   U=;
X-CSE-ConnectionGUID: 8WckTd37QVyp0Y7fxExKfw==
X-CSE-MsgGUID: Kyf+1C0vSFWw8YEZLoFAnQ==
X-IPAS-Result: =?us-ascii?q?A0AbAAAGQUllmJhdJa1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEWBwEBCwGBZlJ4WzxIhFKDTAOETl+IYgOdfoElA1YPAQEBDQEBRAQBAYUGA?=
 =?us-ascii?q?haHEAImNAkOAQICAgEBAQEDAgMBAQEBAQEBAgEBBQEBAQIBBwQUAQEBAQEBA?=
 =?us-ascii?q?QEeGQUQDieFaA0IhkQBAQEBAxIRBA0MAQE3AQ8CAQgYAgImAgICMBUQAgQBD?=
 =?us-ascii?q?QUIGoJcgl8DAaBXAYFAAoooen8zgQGCCQEBBgQFsmwJgRouAYgJAYFQiDYnG?=
 =?us-ascii?q?4INgVeCaD6CYQKBYhWDRDmCL4kuBzKCIoMrKY0ICXdHcBsDBwOBABArBwQwG?=
 =?us-ascii?q?wcGCRQtIwZRBCgkCRMSPgSBY4FRCoECPw8OEYI/IgIHNjYZSIJYCRUMNUp2E?=
 =?us-ascii?q?CoEFBeBEQRqBRgVHjcREhcNAwh2HQIRIzwDBQMEMwoSDQshBRRDA0IGSQsDA?=
 =?us-ascii?q?hoFAwMEgTYFDR4CEBoGDScDAxNNAhAUAzsDAwYDCzEDMFVEDFADbB82CTwLB?=
 =?us-ascii?q?AwfAhseDScoAjVDAxEFEgIYAxYDRB1AAwttPTUUGwUEOylZBaEYgQ2BJwqBD?=
 =?us-ascii?q?ioLlhNJrQWBLgqEDKE/F6oAmD4gqAgCBAIEBQIOAQEGgWM6gVtwFYMiUhkPj?=
 =?us-ascii?q?iAZg1+PeXYCOQIHCwEBAwmLSgEB?=
IronPort-PHdr: A9a23:2RbdQBLS2WMfsMABU9mcuakyDhhOgF28FgcR7pxijKpBbeH6uZ/jJ
 0fYo/5qiQyBUYba7qdcgvHN++D7WGMG6Iqcqn1KbpFWVhEEhMlX1wwtCcKIEwv6edbhbjcxG
 4JJU1o2t2qjPx1tEd3lL0bXvmX06DcTHhvlMg8gJe3vBo/Whsef3OGp8JqVaAJN13KxZLpoJ
 0CupB7K/okO1JJ/I7w4zAfIpHYAd+VNkGVvI1/S1xqp7car95kl+CNV088=
IronPort-Data: A9a23:rZ4Soq6Pf+KA4U+YN6IYgAxRtAXHchMFZxGqfqrLsTDasY5as4F+v
 jAXCD3TPK3bajamL94nPN7g8U0CvcPRyIdlHgVlqyg3Zn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyKa/lH1dOG58RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wq+KUzBHf/g2QvaztMtfrYwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoZWk
 M6akdlVVkuAl/scIovNfoTTKyXmcZaOVeS6sUe6boD56vR0SoPe5Y5gXBYUQR8/ZzxkBLmdw
 v0V3XC7YV9B0qEhBI3xXjEAexySM5Gq95eXHnO8jcDIkHT4YmO08qpgHGwmHoMHr7Mf7WFmr
 ZT0KRgXZRyFwumx2r/+E69nh98oK4/gO4Z3VnNIlG6CS615B8GYBfyXv7e03x9o7ixKNfXXf
 dYYbTNsRB/BeBZIfFwQDfrSmc/x3SCvI2YA9w39SawfwHndj1VaiKbWHuXKKu2nd+FSsG+en
 zeTl4j+KkhKaIPAodafyVqoh+nSjWb4VZgUGbmQ6PFnmhuQy3YVBRlQUkG0ydG9i0ijS5dEI
 FcV0jQhoLJ090GxSNT5GRqirxa5UgU0QdFcFagx7xuAj/OS6AeCDW9CRTlEADA7iCMobWwV3
 Vy1k4i2PAJ+qOWkFnyN26e3oyznbED5MlQ+TSMDSAIE5fzqr4cykg/DQ75f/Eid04Od9dbYn
 mDikcQuu1kApZVUiPjjrDgrlxrp98eZFFdkjunCdjv9tlsRWWKzW2C/BbHmARtoNo2VSByKu
 2IJ3pHY5+EVBpbLnyuIKAnsIF1Lz6jeWNE/qQcyd3XEy9hL0yL6FWy3yGouTHqFyu5eJVfUj
 Lb74Gu9HqN7MnqwdrNQaImsEcksxqWIPY27B6GOP4cSPsAhKVfvEMRSiai4gTiFfK8Ez/lXB
 HtnWZrE4YsyUP4+l2PmG4/xL5dxnnlgrY8seXwL5033jeXBDJJkYbwEK1CJJvso97+JpR69z
 jqsH5Xi9vmra8WnOnO/2ddKdTgidCFrbbio8JY/XrDYfWJb9JQJVqW5LUUJIdI1xsy4V47go
 xmAZ6Ov4AGk2iWeeVTVNSoLhXGGdc8XkE/X9BcEZD6A83Mieo2oqqwYcvMKkXMPrYSPEdYco
 yE5Rvi9
IronPort-HdrOrdr: A9a23:FaCwha7bBKYixd6FDgPXwY2CI+orL9Y04lQ7vn2ZFiYlEfBwxv
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
X-Talos-CUID: =?us-ascii?q?9a23=3AgbRX8Gt8Z9iV3AdSYV/sEhGs6It1TXbe8HuLfHa?=
 =?us-ascii?q?GGH4xeeKbWXKA2617xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AIApiNg3SkjqtgbGUWvpoVCV4EjUjwLWgSxkmyYs?=
 =?us-ascii?q?9lfabZR1dCROaoh2xe9py?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 19:44:38 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
        by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTPS id 3A6JicAH009285
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 19:44:38 GMT
X-CSE-ConnectionGUID: 21iIi36ZRj23TZLetc6mlA==
X-CSE-MsgGUID: TcvMOIjXQ6mK9UsKieiXUg==
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,282,1694736000"; 
   d="scan'208";a="7145179"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by alln-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 19:44:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efTIhSjg1Y6dAjN4aAyTalGIK3OzwPYJxaqO+KfJKm4vvFRopFfY5RPjWJiy7nwWRyGOAU4EvPldc31pLEwuCnEDtHNWv3Xvi/ivWIn3yeVmlx1wfHHJHPhfxwiEr3pVljtbVBssMHrCwBjtlB8pbbtqwhww/K/C+nMj4Y0+ZDZmGHUNUaUz0TkYBRQvF5CPeCd8GQw5Xw5LeoBxxz5AdV3dyGcHZAJe8Gh3nOPkVTRg6pYBTpp2wwlkaw61Z/Q05ODYP4raxhL7dsnJCLC/RHA2SHOrSRlOgyTJJitfjmGxj0QnSEO24okZ4rDPROH347JirYdBARpCNC35VR2Qrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9IDpKU0tHRxjhTRoRA6gjThs/p++lyj6sXgDrcHFB0=;
 b=TrEEzvQ3SK7jMcrKPzJvk/k0ok6nY/yg/ltOS7t6TcK2ivDwpFL49azxD/+RtTWE1st32tCa87c/sUvNCmhJYxQrJNXZIyuWGCZHABCq9UO0bQIvhgD3RDfuWoQI1PkSfMCwiKHCBS5+ZvoJdH9e0sKJiZ+LzChjG1lqwGfnTvAnSdl3yKZvy/2237TQjcPEv9O0O7qdJ9U0UMcSghzrB4s97YOlTdBJcss7LFP4kTXmTkZORd/K1eA8NhgdHWq4MtERNgIgw0SeRLD1Dc1FRwLQ4UI6SbzLrP8SfkNdgEeYMzDRzfeK5AIxeHtWZm20upV8CrF/isHCqNbPNy2m2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9IDpKU0tHRxjhTRoRA6gjThs/p++lyj6sXgDrcHFB0=;
 b=bzUv+k5AcMmBk9vLezYNvxizmPXzVkKVWej3B9bjMvYoMvLChCT3UqvuePR2QefmWC9u6kWMV23n6yIMh+Ja2eKs++E0FX3oaNdvn5eOhLdIb5jSAD8fPmJF+Ecm9ouCBLD8ItQpH41Lg538sukxN6gvqOUyVHH37/k+jPPC1ro=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by DS0PR11MB6518.namprd11.prod.outlook.com (2603:10b6:8:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Mon, 6 Nov
 2023 19:44:35 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 19:44:35 +0000
From:   "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To:     John Garry <john.g.garry@oracle.com>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>
CC:     "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "Dhanraj Jhawar (djhawar)" <djhawar@cisco.com>,
        "Gian Carlo Boffa (gcboffa)" <gcboffa@cisco.com>,
        "Masa Kai (mkai2)" <mkai2@cisco.com>,
        "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 00/13] Introduce support for multiqueue (MQ) in fnic
Thread-Topic: [PATCH v2 00/13] Introduce support for multiqueue (MQ) in fnic
Thread-Index: AQHaCP/s6s/FHnLBUUCNY/zPGRER67BmxAoAgAb8zcA=
Date:   Mon, 6 Nov 2023 19:44:35 +0000
Message-ID: <SJ0PR11MB5896BC6839CEDCAD97ACDA7BC3AAA@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231027180302.418676-1-kartilak@cisco.com>
 <4bfe8125-660f-4ac2-0aa6-aa7a5b6df2e9@oracle.com>
In-Reply-To: <4bfe8125-660f-4ac2-0aa6-aa7a5b6df2e9@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|DS0PR11MB6518:EE_
x-ms-office365-filtering-correlation-id: b3559f2f-d7ec-4521-92c1-08dbdf00ce14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uJ/6gFfSqIsStBYvKWFGEbZhILxymavoaNkfzYa3cMsOHXiARW/Cw/Lb3KSxMWwSJxxrrvbWRuBKpSZdhtbi52PnekK4TSiaEtxEzOEBbkHYXHCz5rT9KA5826mfoGVG2vqEeIEMZ9+GTJ27TWewGR3Jhxqh3+wfTihTnbDQnM6LXmhnWRSQB7rWqeJjtwT8OvIs0qYnfCdkDU5vsI4LWZCpjxKspTeT/Fz8Ahk0mRp989gp3umuoee4e40BryfbnzU0AV0whnF7mV/2kjEBG9tXFUHGpgsnCGqW2cIoZIzXyfppkgwhTdMiigH0l5EJ0LLR16CRYYyeLGZOxPPnJxs+S9rYU9Fd8s/xm++7oI47pUvGbxquQi8jW7do+tPZoZVu7mhocDKdD3Oi2hTpWbKo6FtTrThj0MVmAklnWhm1XL4ZdTzR56/bF7gdCop4W9s4Eemgfs+dDKsAPupzLXND0o7THtefq9QckgotW7tuNP3CRv7xkllI7A93thToNZoyR8EjWCMs5O9N1DN/g9nPv1Tzywk1x7U/rG8jbizj5LETBQgE10A7xy5qm/12PFbh2OcVF424QBzRum6bGaKZEW0hq2L1paw+u2mGSVEtCU0tW1lEJQOMteoTKVER
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(55016003)(9686003)(86362001)(33656002)(38070700009)(122000001)(38100700002)(52536014)(4744005)(8936002)(5660300002)(2906002)(53546011)(6506007)(7696005)(71200400001)(478600001)(8676002)(4326008)(66446008)(316002)(66476007)(66556008)(54906003)(66946007)(64756008)(6636002)(41300700001)(76116006)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3Z5V3NsUlFuelVLZXJqRnZvOEhXTERuR2NSYmpXRExmaCtGV2hSUDZ0UWk3?=
 =?utf-8?B?Wlg3MGlpZWorN09CSFFVclZGYkVueHBseEJqWDlIc2tXY21QTUgxYTJqSGZz?=
 =?utf-8?B?V1NyQXhJYmxLd1lqdTBwSzc5SzhTYkkwMXAxMHJub3JvZHYvRzlzWitjZERn?=
 =?utf-8?B?RFR4c3hPendmMDFJcUxvTTJlTUdvZ1B4ZW1sSXgxaGE0ZDlnUkYzY3UyVG9C?=
 =?utf-8?B?MWRmRjBVY1cxdkE3MkFoeUhKb0hlbDNHU2xhREUzMEVaZHVERkdwZ3lnMUR6?=
 =?utf-8?B?RndWQWdGOHIzZ2cvcXU0M1BtbjM2MjJuK1piNFZUTGFJb2QzcitrZ0Yxbmx2?=
 =?utf-8?B?TzZFcDB5dmxZT3FyNEVpOTJFdWlpWVhxY3RZcXZRdXpFR0VBZVJKZGc2ZWpK?=
 =?utf-8?B?MnRQN3lOVDRrNHo5aFlOeUgvc01HWnhpWUpYWVRxa05wV0FpN2ZJUlM1Ymp3?=
 =?utf-8?B?UTVsNTNETHdoQWwyVExMbEpubzZScUJBNVcvYSs0S29EVUhiak9XaERjaVNy?=
 =?utf-8?B?SEhYRVZZWmJSeUlyU0FTb2xUVzJhd3BSRm5DVzhEQVBYNU9LVE9Qd2xuYXRK?=
 =?utf-8?B?RXhHQnlCb0QySnlTT3hkaU5ibThsNkVzWXNUZHhRMElNa2tLa3RwLzBMWllC?=
 =?utf-8?B?eXhlZVJkV3NBSkFEQUFZUHJ1V3RUc3psbDBweFJzV05FOHUyZTlaZXAvbzU5?=
 =?utf-8?B?K1VsWjdqZmxZeC9qTFpoZzFhaFlJbUE4MUQybnZhSU5zVE9YMXRaS3JXZk0v?=
 =?utf-8?B?VG1SNEJCbEVUYm5YVWczR0F6QnE4c0JUM0RYRGN4TGt1SWNFZkxCQnpZaXpX?=
 =?utf-8?B?aTVkcHQzalZDRE1WZmVISkRoOVU4N21jUk8yc1EweGJGSTJwRmdMaUZJdEIx?=
 =?utf-8?B?ODU0azE3ZFRtQXprclJ6bmJFTThybXJJYUUycFRRNE8wWFZGSzcvNlBvcFpH?=
 =?utf-8?B?MTZmdDRZZk1tMGFobDRJWHpISkNQeHZic0hadUpZNzNyOHk2MUE0bk1FVDZE?=
 =?utf-8?B?UXNmMUF4eVBBRUNNOWZQK0pHNWhYTjRVSTNsQXF1QnlleEs0bXBqa1FWQ1l5?=
 =?utf-8?B?c1QrZXZQQlE4WXlaTnpvY0NXMDlhSW5kZXJtaVVycWQ0VHAwczcyRTkydkVi?=
 =?utf-8?B?UkdkOTZtek0wUXM0N25QeEVuMGNGdHdPTDViZ2h1Vm1OT2dPbHljenhvWHJO?=
 =?utf-8?B?OGxmQ1NCbzE4UkJxRUR0eDJ6TlFnVW14eG1aNFV6a0JBQ1ViRmhUNDRXMndC?=
 =?utf-8?B?MWhzSHlEOXFsVzdHQ0RFZXgzV29kemR5U3ROYXhQbVBwaGoyck1VT2g1RGNO?=
 =?utf-8?B?bEhJNjFQU1NaTDhqT1A1a3d1MFZ2MkQ1TnNXOTQxNEE3Sjg5SlprSmpuczlG?=
 =?utf-8?B?RjJ0Zmtwc1c4K08vWTR1eWNTM252TWp0cGp6MzE0bmZ5d200dUhtajNvbm9l?=
 =?utf-8?B?UmNpcStzNmJuYVJlNjhaRXlpUXNwL3ovVkNVQXFwWEUzWi9FMGNnTUN4SFdD?=
 =?utf-8?B?RUllSEx6OVdjQmpEamt3dnpxUGJHY2ZEOTVPOUx5YnZuNzFHYlNMRStGYitE?=
 =?utf-8?B?bG45TWtHalRYWTJHT01Hd0l0TCtRYkRDa0FTQTBxWW1oMmJWTTBFaDAyQTZi?=
 =?utf-8?B?am4vVUpDd0hodE5tK3pHb3d5YmRlemovNlBRQzV4RGZ0WGx5T0E1VlRNb2px?=
 =?utf-8?B?M3NLdFdrZkZSK0txbWUwclNyUnY4RXFyWndpeDdJam9HSEF3QVFlWGg0V1VZ?=
 =?utf-8?B?OUh6QThHOG9HL0gwQjBqaXhKR3BUN0VhaXkzbEQ3WXp6UkRSMGczSmNXYk5t?=
 =?utf-8?B?Q1JPVlRzSkQxT2c3a1J0SW5LRTBXcjdMMGthczJYSHB2anozY0dseXlOVFZI?=
 =?utf-8?B?bVdObmV5V1Z1SGxuTWx4TGZLSDRaS1FnYlJIckl1RmFLQ2RPTmpGTVJXd2I2?=
 =?utf-8?B?aUliQ1U4TlBtK0wycllEdnpxRys2OHU1ZHFOc3RFcTNzRm1rN2dyNzd0c0tr?=
 =?utf-8?B?VHBwL29xNDE3a21Lc2ZqcHhEak9PRElSQ25ibmJJOVdIRkhJTFgrd0NER3Uz?=
 =?utf-8?B?RHFjSWQzRWRpcHl2L1RKNE9McFZkWktmVFJyUUJta2JkNDkrY0FIdUdVUjhV?=
 =?utf-8?B?R1hVSzJ5SmwrNlVGbm1VYzRNOU9QWFdObXNoM1dsRzdLR2QxWGtaeDJ2Nmhx?=
 =?utf-8?Q?4TdedUBFvQXsHEMOwOF1v6s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3559f2f-d7ec-4521-92c1-08dbdf00ce14
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 19:44:35.3271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gilbjHNw61p8TCy//kR583rePqCdL4EMc1oBXYdqeJg6v4meOBhpeevsO0IneS5UgkLgiPhziaQrZxcki7t75A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6518
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: rcdn-core-1.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1cnNkYXksIE5vdmVtYmVyIDIsIDIwMjMgMjowMCBBTSwgSm9obiBHYXJyeSA8am9obi5n
LmdhcnJ5QG9yYWNsZS5jb20+IHdyb3RlOg0KPg0KPiBPbiAyNy8xMC8yMDIzIDE5OjAyLCBLYXJh
biBUaWxhayBLdW1hciB3cm90ZToNCj4gPiBUaGUgbnVtYmVyIG9mIElPIHF1ZXVlcyB0byBiZSB1
c2VkIGlzIHN0b3JlZCBpbiBhIGNvbmZpZ3VyYXRpb24gZmlsZQ0KPiA+IGJ5IHRoZSBWSUMgZmly
bXdhcmUuIFRoZSBmTklDIGRyaXZlciByZWFkcyB0aGUgY29uZmlndXJhdGlvbiBmaWxlIGFuZCBz
ZXRzDQo+ID4gdGhlIG51bWJlciBvZiBxdWV1ZXMgdG8gYmUgdXNlZC4gUHJldmlvdXNseSwgdGhl
IGRyaXZlciB3YXMgaGFyZC1jb2RlZA0KPiA+IHRvIHVzZSBvbmx5IG9uZSBxdWV1ZS4NCj4NCj4g
SW4gbG9va2luZyBhdCBjb21taXQgYWVjOTVlM2E4ZGVkICgic2NzaTogZm5pYzogUmVmYWN0b3Ig
Y29kZSBpbiBmbmljDQo+IHByb2JlIHRvIGluaXRpYWxpemUgU0NTSSBsYXllciIpLCBzdXBwb3J0
IHRvIHNldCBzaG9zdC0+bnJfaHdfcXVldWVzID4gMQ0KPiB0byBlbmFibGUgTVEgc2VlbXMgdG8g
aGF2ZSBzbmVha2VkIGluIGFscmVhZHkgLSB3aGF0J3MgZ29pbmcgb24gdGhlcmU/DQo+DQo+IEpv
aG4NCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldyBjb21tZW50cywgSm9obi4NClRoaXMgd2FzIGEg
ZGVmZW5zaXZlIGNoZWNrIGFuZCBjb2RlIHRvIHNob3cgdGhhdCBmbmljIGRvZXMgbm90IGhhdmUg
c3VwcG9ydCBmb3IgTVEgDQp3aGVuIHRoZSB1c2VyIHRyaWVzIHRvIGNvbmZpZ3VyZSBtdWx0aXBs
ZSBJTyBxdWV1ZXMuDQpUaGUgc3VwcG9ydCBmb3IgTVEgaXMgYmVpbmcgYWRkZWQgb25seSBub3cu
DQoNClJlZ2FyZHMsDQpLYXJhbg0K
