Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390247E006F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347618AbjKCKKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347559AbjKCKKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:10:41 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E578ABD;
        Fri,  3 Nov 2023 03:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699006235; x=1730542235;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D9eNdempfOFcbuRk0jnQ0sm3xH5M5kK1np2d/i/4QdU=;
  b=h5WYesI+ExwvPrByDZwTWcDrd809wC0Z+icgYJsPWHXK9ZekRaj+Mc57
   k4YR7DqAmuwisqb0UQujd56L+8YnYZE5zoZ5BH578at4+bIAeYmYV6R8R
   puG2h9vozvMclquH95MepjM6YCNQDpgiGXdK/wAMWVjlm3rs8+OBd9O1D
   O3OdnhzpzA8/R6kPD9Ah+seKGX6hPonL+O4iwZP33houU7eVIRbWZFSQI
   Wgdax0c17nTTlwvossqAbOY4aQxFZPiUad36zjXI+TMu5bprByvxzz8FB
   JbNmkc39jzQ3rEJBTi9UaiZsI/TodDFIyjWKo5A0i1N6NDWSCH73tqgPw
   w==;
X-CSE-ConnectionGUID: PtJKTg7zSEyrDPZ6Vvy35A==
X-CSE-MsgGUID: AbdaLNuGQImwwSBBF6BFog==
X-IronPort-AV: E=Sophos;i="6.03,273,1694707200"; 
   d="scan'208";a="1462731"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2023 18:10:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xl46Wy7hBXtE81i92WTn3xrw15/VO0aGSlwOQSHuUeMzkv4L6e9pAbyRBkR+JJdyuFLpfP305RFekR+NZRnxvqge4+w3L56RTrYLrz+Xs0HJ5bUY621zsACfX/Cl1Pj4VBtIMvryUwvvyQwjXcwpGoJukF7WNsgGAAB8Y8WKXZvQJEJTcVJp4N8EBgI7u6m7M4iYV+tqQcLQzpmt/Dz1DMwPueX6L1sJH4okwqNfB/WGDjtbu/hxqEW4Tospc3Iz5y8stbeVJuFvTN+AFx0GRg3G8V0YPeL05pPUnppTdvSurj50ELoia+sElv434t2gA6gS6brwXsNoDmb7ThpiEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9eNdempfOFcbuRk0jnQ0sm3xH5M5kK1np2d/i/4QdU=;
 b=F5PTn4uENN7roNWdfcZAJuRSafhoxyic4iP1skazokriCcorE3DSdQfCWkdQqOvLT0l3rSVn9m5HRETpOSQ38j9kQHnlEU42aL8srsxDcXDzHyAvJnG3U6AIeWgJ+8DM7HpbEWGRyQn3cczyFWn918TYAkU2XQsKiWJsQ9G+RWq8t4mBJ4GOvd6G8u6LAV++u9IdthK04P7hv66uyU2/6SNwUXQ2ukyXifz+eLJih1K/bL5a9S3a/Bd5QGTf9smyW8y7gxZBqyk0zmTE5XTfgBOZbGifBcH4CJeYmbqglxNf4Y0eRF00aDkfMSLNI/9Vtn/eLZECU+xy6pngbu/72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9eNdempfOFcbuRk0jnQ0sm3xH5M5kK1np2d/i/4QdU=;
 b=X7xGTkVvWonsMixecOv2ut+aNR2JIjPGmefwbTEGQ3eRZnIHahXw0bJ8Q4aGot4mC5+zKg0wiPzz6JKi0UfUyloLxb4gbmoKO+RhymAXEnXHHEoOUWqfQRm8U2KwnjTAT/KUvAbFz447QL5FpzXPnY+ycFWR6qXmXrqWgUes3U8=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH3PR04MB8875.namprd04.prod.outlook.com (2603:10b6:610:169::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 10:10:32 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd%5]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 10:10:31 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?utf-8?B?S29ybmVsIER1bMSZYmE=?= <korneld@chromium.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Bhavya Kapoor <b-kapoor@ti.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Thierry Reding <thierry.reding@gmail.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 0/6] mmc: block: Fixes for CQE error recovery recovery
Thread-Topic: [PATCH V2 0/6] mmc: block: Fixes for CQE error recovery recovery
Thread-Index: AQHaDjKH+gjyau7I4UWMpmvuqg6ipbBoX00w
Date:   Fri, 3 Nov 2023 10:10:31 +0000
Message-ID: <DM6PR04MB65758B72F1260C13951C83FCFCA5A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231103084720.6886-1-adrian.hunter@intel.com>
In-Reply-To: <20231103084720.6886-1-adrian.hunter@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH3PR04MB8875:EE_
x-ms-office365-filtering-correlation-id: 3f60d9db-f701-4874-92eb-08dbdc551cdd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8F03cYqZ6qfRJs6LG4fy3mCRhNiv/mHG4Jam+fN0z5U8+/mCkmVWnXszHyf49DrpHrJB8tvjHVUb4z0xgmPthwd+I7l4mMNsXuQ9k1ycMcG4vfzR9bsWgA+UlgMmWZQaTlr8EIqjy6eE4x9uFJfm1uBmoz8sa3GgjIRiEgZoo7on+8yc7RKqo9v2aDnXOxYbA1ogVtiqH1vHLx24aco976fZxSEv8nXiQheh9H23KUITEaynDtL8up75onDuVk5RTJ4Yoe5T0OHC9lDUAh7WKOQH1/yCzfW+PE5bDroeEOiSSPft8mkuTL8q+oOzPMunRjoKL9vgnxngvyG3fqOkUs7XOcHbBPxctVihEy8sC1UJlVIB4BhDy13KnrCRs4j4fDt4b4eG0AWKl1cgK1h+UUxSilQzBYCCw/y4OakEu5W/g/zK3Y5j8tiw6gcvSGbOwb+3Woy/Fty18xwh1ZLNfpCWaKOKRzjDqzcyPMmllkLP5rd8X3VF8w87z+P4s8kAMLsGMQe7AJ/w5WP7r3YWMFvnfFMJjkAKSRs9bUfySzr21gckSFHBlAa4DrELZ3isWwKAZPPBuUelBHvtH+cBSPvBaQkzCc4UokCDPy7WexA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(376002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(26005)(9686003)(55016003)(82960400001)(38070700009)(6506007)(38100700002)(86362001)(33656002)(122000001)(66574015)(83380400001)(7416002)(7696005)(478600001)(5660300002)(71200400001)(4326008)(52536014)(64756008)(66476007)(8936002)(966005)(66556008)(54906003)(2906002)(316002)(8676002)(66446008)(110136005)(41300700001)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yzk2Rk8yakwza2NtWWwrYkh2WCt2Mm9KY1gzOHRxUFNJM3d0alpOZHBkK3dh?=
 =?utf-8?B?cWhxM1I3Q0JWZzlYbFhPZHQvMGtJVVYyMkFPeUxMMDV5UjNtSnUyR09jd211?=
 =?utf-8?B?eEYzWGZxR1JrWDRSRTVyM3M3SDdsSDlROTV1UCsramE4eFluOTcybmRtbzdw?=
 =?utf-8?B?b1RPUTNCMFgwYit1Ky9CRi9sbkg3ZmwxVVlNQytzVXZzZmJuYUJHL2hpMXIv?=
 =?utf-8?B?QzB6Z1NlbGdraHcyS0I5U3VjZlhZTTE4VEVCQ1VkZ0J6cGc1eS9TbDFMYzZV?=
 =?utf-8?B?OHhhZFRWb1UxSVVlVDBWNVJ1SSswMVl3UmRWWk5KUzJZMGxZRnFqVi9ETTNj?=
 =?utf-8?B?dk1jT2hkYjZBWjA0dWVtcCsybXFpOEZwRklERlpKQ3Y5QVpnNmw5MDA2Rjlh?=
 =?utf-8?B?WFFtSldHTnhlNlIyMlFFZmFOcXFVeHhqTU53bTVlVGUzK09aRHBHWVV6RTFp?=
 =?utf-8?B?QkluSUxreTRaZ21QVEtRUlBJUndycXJtYVYrdGRiZjFXN0xFQVA0WmRmOEFv?=
 =?utf-8?B?dk0vWFgrdXlLaGVtOWFMY3lmeXBCNDcvSERWdkVKeURjTUNRbE5yS1RkcGhn?=
 =?utf-8?B?QkJSWm1KMnNvalU0YTVjbEMvcTZEeVlXYjh1NU50eUh0b2dNSnY3UDllaEY4?=
 =?utf-8?B?TmxxbklmSXBlYXlXdHErL2FFTE5yak5VZmRZai9aT1NwWGNjUE1lR0Y5blM5?=
 =?utf-8?B?czBIUGpsQmpvekZvdng0UzY5UmVPTUIwekV0cUZJMkFJNzlnOHB5ZzNXT3h4?=
 =?utf-8?B?a1VJY2EzdkRRRzlEbXRlQnNqdmdNMEU4U29mbDJvRkVkQVc4cmVyV3ZmNHFr?=
 =?utf-8?B?Z2NPQzZTandjdmVnQWFtczN3Tmlrdkh4eTc4STI5aUpPczBHSHhrTTJsbWk4?=
 =?utf-8?B?RUJpT01EbEc4aE5iSTRRcVZNOUtab3d0YWRtbUlTYzFicHhNemtTYlVENktC?=
 =?utf-8?B?TzMyUmd4Z2RqOCsxZ3ZOa2hJdHl2UHRpem1sbm5VQmdmcVA5djJwbUVhOFRz?=
 =?utf-8?B?TXA4RHY5aFlXUzI3SDB0MnNhWG5VbzhRWFVzaEl3U1laNmEyYlhOOXJMWWdP?=
 =?utf-8?B?N1V5MGUrVDQ4Y3BjdHFjR09WUnpGWlBZRytjQnV1SkIvNEdKSDhhb1R0Ky9v?=
 =?utf-8?B?ZUN1NXdFcDBPVEdxK0V0K1dpUEhDc1VlNEJ0RVBWVjRaSzZLVDVHT1dWd3FU?=
 =?utf-8?B?MTJ1UURHL3lwdmxteWNTeGJPRVNqdFF5eHJneU4wVGJrZWJXZjRJb2gxdFY0?=
 =?utf-8?B?ZzVNRWpJOGQrTUllY3dPU1VJZnJoeC93MkRxSFVzbFZqSklSZkhWNDB3c1RJ?=
 =?utf-8?B?Q0JRWFl5aXpxTzlvSjBFUmt2RzBuRi9oQzR2VWdCK1ZlcDNjTG5ONWRDV2Vm?=
 =?utf-8?B?eS9iRE0xSFFXVWdSL3ZFNUxhNndzbDNvOHdBMUZDTUlPK0N0VXNWeHZTRGFM?=
 =?utf-8?B?OFBSYU8zRURpNnJMOEJvY1B2TkNVdEhMSmIrSVpGdmQ2WG0wY3VGWFkycnhM?=
 =?utf-8?B?V1h3R3N3L1MzKzdWeEdmV1FKRlFMcGFoeGcyeVJ2US9YdzAyeklHWEcvZGVC?=
 =?utf-8?B?M0FDNU15TGFoenhpbDBMQWRrVnNlNjhvRmNkWUY3R3RTNjNxdVdtQ0w1U0FF?=
 =?utf-8?B?bkpSUXZPdjNyUGNGMHdNVVRpZEtqTHJ4SnVxY0Nma1psaVp1VndSL0RCQlh2?=
 =?utf-8?B?YkZkYVd3ZHRhbGJ6UTdULy9pWWR3U0xobGY2MVh0a2RLeWN0MVNyanZYaGVr?=
 =?utf-8?B?QjNFSG1XWHhUTTRFWGNOOVFWcXlXYXkrOXRwSWVjWWZCc1dlb2h5OGZPZ0ZV?=
 =?utf-8?B?M2FjL0tWS2RkMFdnQTFaRGRMaVZvdWlCaitjK2hhRm5ON2FlSFZuT1hDUlZ3?=
 =?utf-8?B?Wkw2a2VuenRiby9PMDZUMTlOWUVlbjhIV1JPVXRSbkRGZDZWcU0wQ1N2eWJk?=
 =?utf-8?B?VW1SRDErSUxRN3RqYjZvTm9MUzRpVE1MdmZFSGtzanRQQjhkT1BFNDE3ejhk?=
 =?utf-8?B?dnlyaGdIamw1aGNxbzE3cmh4TnpqYk9MUUY1ZmpMVGt0S1pPdjlJRllIN0Vq?=
 =?utf-8?B?Y3BTTGRRaDhwZkxETUNwbjIxa1B6V1RnRXkrV2w2U0cxS2x6eXgrNkV2SkQ1?=
 =?utf-8?Q?ZetrHmklHa6AxY+5ZLMgxg4Ny?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?R215RjJzTWhNeVBxZzJCNlZjb3NuQ2kvTnlaczlvR3hYdEd4S09Kck8yK3hS?=
 =?utf-8?B?eUFKbUFtNWI4Z2pQbTR6eEMrbVhXd2RqYndGZkJmem5LYTJITUpXZTg2Q2ds?=
 =?utf-8?B?RVEyQm5mYVBwZnk3c0J5NDFDNkRuSjNFaEFjU3JzRlB5dFlKTnVZN2xJTC8v?=
 =?utf-8?B?VXdpZDc2YmJvUWY2NTBhUlRIM3luMng4Zm1LalBaNHV4N2FhelRtMCtweTRy?=
 =?utf-8?B?c1RkQ1FTaTZXUW5RRDNqemNSc3RsNmNiNkIyRFI0UzMrUXFDVG82RFFLcmNX?=
 =?utf-8?B?SEduT0RHKyt6S2ZHWVlSQ2dZaGM0UnZGd2plT25TMU1WeWlWeXZmRkNzcG8r?=
 =?utf-8?B?d2F6TTdWMFcxYUdtalFwMHB0U2lkeDI2dlZwU3FwaHEzTjRIckpYYUwzVFlU?=
 =?utf-8?B?MWNKMmxMbTR0U2RDdDVXbEhtVklwN210TWxKNXpFQ3g2ZU5TanBtcmo4Y3N4?=
 =?utf-8?B?UVZPWnVmSENUL0d2c2pUUStjNkoxSXpVMUw3SkYrY3htZk5YcDlibDNXNzZn?=
 =?utf-8?B?anRHNkpBSUoyK2dNVmtYZ095VU9weVVGQlJOczhUUGVsdE1hZmExcDdrZnpQ?=
 =?utf-8?B?akwxN3Y2NWhiU0NtclpUdVB1MDVIVEd2LzUxcXNyTDBmVy9MeUxrVWs2OE1E?=
 =?utf-8?B?U00vb2NzdGgrN2NuM1V1Ymd5SnJ0UXRVKzVqbldHOE43WUFLNCsxU0JZUmUr?=
 =?utf-8?B?VGpBcys3eVFWRFR6dTNtTVZLeTArNUZ4d3VrU3VWZ2IySllNT3VqU3U4ZXNh?=
 =?utf-8?B?bmhqYXgzc2h1WGJRNGhwZFZZVE9SYkNRQXloMWU1OXg1NjVsdDVqVnkxQ1d3?=
 =?utf-8?B?dkw3WDBlbFNHMDNRZlJYaTV1Q2pKSzhaL2IvQXcvTFhZTDNwQWpRWnl6aVVL?=
 =?utf-8?B?RTAvVmZuUnd4elJBR2xOeHR6a1AzUXNyaWhHVEN2aE9ONTZ1cXhkOWdjdGVJ?=
 =?utf-8?B?eTFoSUtlMUYyZS9pTjdQd1dlNGQ1M2g1TjRITnhNZk0xaTZiakZaZkk0Zlg3?=
 =?utf-8?B?M094TjgvMnZ6bVczV3JESzNvNkRoSkMwdHA5OGJwQ3hFSUU5a3BqT3oyM1Qy?=
 =?utf-8?B?NmZSTmVWTlEzWThtaEZ2MDRmVzdpdnJ0Z2t2dlNtOVFPeDlOSmowU0o2U1JI?=
 =?utf-8?B?cU93ay9PdzdwVnlWQVdKc2NJZDhDcUp6VEFvT2htRzZhY3RpWjAySWd3Qjd1?=
 =?utf-8?B?ckxuYlNVVnZMOFgyM0NDeDFSYUdYSlpkdlRKZGhhWDI0WkhhU3M1d2g2K0NQ?=
 =?utf-8?B?VENtNFN0bTJJZkYxSVlWWE1TVEo5YjZBNkc0bFF3TWFpc3hKSmhEQzJTMUNT?=
 =?utf-8?B?VE5yWEdWME9UZnphMDNFK3A0UzNSV000NFp4Qm8zTG5KdGw5dkIwM2lCTmhQ?=
 =?utf-8?B?OXUvWmJuNHNmWlBocUhvbjcxWWxFRUFPN1pIVDRDUGpseWFWRG9PYVpPU3Zq?=
 =?utf-8?B?Z2RuWGxhbDB3OXV5YmFLbW1GOG9MM0FsampnQ3pSWS9TeXRuckdFWVhOM3VM?=
 =?utf-8?B?NlpMbTRpUkcvdHZEWWE3WEZyVFJqWVBBWTd1YzJrQ1dHMThMOVFCQWxxM3FR?=
 =?utf-8?Q?arrTUmE9t7d/UvHnp3Fcoq+7o=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f60d9db-f701-4874-92eb-08dbdc551cdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 10:10:31.7437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2hiaz13SWLoSyEIBxqTeo3HFg8R//MmZgsliatkDIkGsrVSFvmOF064IbEAEKHQJhAMIha+6xHw+Rk8NNDuLww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8875
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RG9lcyB0aGUgZG91YmxlICJyZWNvdmVyeSIgIGluIHRoZSBzdWJqZWN0IGludGVudGlvbmFsPw0K
DQpUaGFua3MsDQpBdnJpDQogDQo+IEhpDQo+IA0KPiBTb21lIGlzc3VlcyBoYXZlIGJlZW4gZm91
bmQgd2l0aCBDUUUgZXJyb3IgcmVjb3ZlcnkuICBIZXJlIGFyZSBzb21lIGZpeGVzLg0KPiANCj4g
QXMgb2YgVjIsIHRoZSBhbHRlcm5hdGl2ZSBpbXBsZW1lbnRhdGlvbiBmb3IgdGhlIHBhdGNoIGZy
b20gS29ybmVsIER1bMSZYmE6DQo+IA0KPiAgICAgICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LW1tYy9lN2MxMmUwNy03NTQwLTQ3ZWEtODg5MS0NCj4gMmNlYzczZDU4ZGYxQGludGVs
LmNvbS9ULyN1DQo+IA0KPiBpcyBub3cgaW5jbHVkZWQsIHNlZSBwYXRjaCA2ICJtbWM6IGNxaGNp
OiBGaXggdGFzayBjbGVhcmluZyBpbiBDUUUgZXJyb3INCj4gcmVjb3ZlcnkiKQ0KPiANCj4gUGxl
YXNlIGFsc28gbm90ZSAtPnBvc3RfZGlzYWJsZSgpIHNlZW1zIHRvIGJlIG1pc3NpbmcgZnJvbQ0K
PiBjcWhjaV9yZWNvdmVyeV9zdGFydCgpLiAgSXQgd291bGQgYmUgZ29vZCBpZiAtPnBvc3RfZGlz
YWJsZSgpIHVzZXJzIGNvdWxkDQo+IGNoZWNrIGlmIHRoaXMgbmVlZHMgYXR0ZW50aW9uLg0KPiAN
Cj4gDQo+IENoYW5nZXMgaW4gVjI6DQo+IA0KPiAgICAgICBtbWM6IGNxaGNpOiBGaXggdGFzayBj
bGVhcmluZyBpbiBDUUUgZXJyb3IgcmVjb3ZlcnkNCj4gICAgICAgICAgICAgTmV3IHBhdGNoDQo+
IA0KPiAgICAgICBtbWM6IGNxaGNpOiBXYXJuIG9mIGhhbHQgb3IgdGFzayBjbGVhciBmYWlsdXJl
DQo+ICAgICAgICAgICAgIEFkZCBmaXhlcyBhbmQgc3RhYmxlIHRhZ3MNCj4gDQo+IA0KPiBBZHJp
YW4gSHVudGVyICg2KToNCj4gICAgICAgbW1jOiBibG9jazogRG8gbm90IGxvc2UgY2FjaGUgZmx1
c2ggZHVyaW5nIENRRSBlcnJvciByZWNvdmVyeQ0KPiAgICAgICBtbWM6IGNxaGNpOiBJbmNyZWFz
ZSByZWNvdmVyeSBoYWx0IHRpbWVvdXQNCj4gICAgICAgbW1jOiBibG9jazogQmUgc3VyZSB0byB3
YWl0IHdoaWxlIGJ1c3kgaW4gQ1FFIGVycm9yIHJlY292ZXJ5DQo+ICAgICAgIG1tYzogYmxvY2s6
IFJldHJ5IGNvbW1hbmRzIGluIENRRSBlcnJvciByZWNvdmVyeQ0KPiAgICAgICBtbWM6IGNxaGNp
OiBXYXJuIG9mIGhhbHQgb3IgdGFzayBjbGVhciBmYWlsdXJlDQo+ICAgICAgIG1tYzogY3FoY2k6
IEZpeCB0YXNrIGNsZWFyaW5nIGluIENRRSBlcnJvciByZWNvdmVyeQ0KPiANCj4gIGRyaXZlcnMv
bW1jL2NvcmUvYmxvY2suYyAgICAgIHwgIDIgKysNCj4gIGRyaXZlcnMvbW1jL2NvcmUvY29yZS5j
ICAgICAgIHwgIDkgKysrKysrKy0tDQo+ICBkcml2ZXJzL21tYy9ob3N0L2NxaGNpLWNvcmUuYyB8
IDQ0ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+IC0tLS0tDQo+ICAz
IGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KPiANCj4g
DQo+IFJlZ2FyZHMNCj4gQWRyaWFuDQo=
