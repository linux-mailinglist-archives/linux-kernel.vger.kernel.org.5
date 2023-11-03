Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9366A7E026C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjKCL6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjKCL6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:58:30 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D051BC;
        Fri,  3 Nov 2023 04:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699012704; x=1730548704;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/g2wdQpyUWgHrZj5inbiOvgajFAZhVKDHTzQSlWLPFM=;
  b=Nse4Qc0y5ojSDDDEhtjjUJG4cNoFkWPZoId2BXlYydruY4Q7BsJ4oh8v
   zdDbU+XlYnNo0SSHnK8XPcL2JnWh/qsFAXW37puZv14eItP1W64puLueK
   IiUEyKUJ6m0pIrKPZ3NbJd/i59U+oae3cWhIM7Vy0VzT/lWfMiTAqoGyz
   NRGkGVjiWehFTMMHseoI7ez474d/3x1DdfEGr8s39lNX9YhikrNCqpz/f
   ZhCXw7WX1dJx31CEdLzOvryGNYDnt9IELqGs+hqBuFa3u5/2saX1GYLrK
   6XCf1SVCkw79O3KGizHHhJNSAxDtNaycyglJ6FW+69mGoeM80bZF7/N7d
   w==;
X-CSE-ConnectionGUID: i4sGwpqmSxmMIpojiHqSbg==
X-CSE-MsgGUID: 5yjQhLN5Qm+cAKZK90Xn4Q==
X-IronPort-AV: E=Sophos;i="6.03,273,1694707200"; 
   d="scan'208";a="1388862"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2023 19:58:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwaTCUxgEh3TynqVcJUnd8zbkROS2j1hdExZJHviLnrVz+yjccUXk+uiUL7acAUSqcDYouSninwPzE0bq7cLM13DoVXQCmHBmeY3VACvgnAnGA4Mg1YCzzFdH9Qa1hIC+RDhOAiDDH/tG5GUadB+daJY2fhmYnEP/LahnZJ20wki+ZTATEJewJy5wHy4mEB365syGj1FG9nKVR6CzUeLrxvaJ4nNOYUsJ/H2kODBbWExDO3q8x+6sgbEdfzn0/h7awSKuRjDI5I2NZZdEARVXNhF6NDl4c8V2L257aWjKXhXLz8VXrxUc54FAus+dd855E2Su81SFm+cBjQKmCkGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaOk/Psau8KJuMTWKfy16TZGsxYdUPNYGhOyJgsDFJQ=;
 b=N0YAYAv1iKy/JUbOHa3ZQUUusPYcbRqsyuongVmFaWxtwpxigxS6ginPa/vaqg0SRSZbBrkfXTZ2dT/9oH37B4J22Vm1lq6eWlEXNXmKfs4UfFfN04MeHtEgXERzCIMDBm60/Pb7SQ4vB0JAnMW04qk3a0cyGbtx9tW3OZSAotxa6xtL8eveJHCDfDF5Tbd7Cr05D4Srs7jLelhJFLTYRZaAmouKZmaSvpT3giZLKdQgAI/SYEhhlKOPxrMEa3By8dBWaJ+u9C/N04CuwJ7fIc1lk7Q8JQvENLhB7y+zpo4WnKXPOIAE0h+K/HuTG0TfZtaOCQ3FS3ruQQ9aqfDZxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaOk/Psau8KJuMTWKfy16TZGsxYdUPNYGhOyJgsDFJQ=;
 b=ESe9A7RY9OrPhDS3s52mdHAfmRj2ySPV8KmEPD3IOQsHcNuwq1FYhyJa00806AUpTzXuLAhWmkmo9DG66Bxr7F8iq1KOKrFgm/kKQf8CIECFULiGifLGzczyeHYvUR0/wOGhf4hFBNRZDOkQd/MFnYl820KMljuAvq/4hzusWbo=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB7237.namprd04.prod.outlook.com (2603:10b6:510:a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.21; Fri, 3 Nov 2023 11:58:18 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd%5]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 11:58:18 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-2?Q?Kornel_Dul=EAba?= <korneld@chromium.org>,
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
Subject: RE: [PATCH V2 5/6] mmc: cqhci: Warn of halt or task clear failure
Thread-Topic: [PATCH V2 5/6] mmc: cqhci: Warn of halt or task clear failure
Thread-Index: AQHaDjLZw7S/sDZV6UOnOsoxT8d19LBofX1w
Date:   Fri, 3 Nov 2023 11:58:18 +0000
Message-ID: <DM6PR04MB6575C0C38B7675957B2C0B7BFCA5A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231103084720.6886-1-adrian.hunter@intel.com>
 <20231103084720.6886-6-adrian.hunter@intel.com>
In-Reply-To: <20231103084720.6886-6-adrian.hunter@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB7237:EE_
x-ms-office365-filtering-correlation-id: 4675eddf-b5b8-4f31-0df7-08dbdc642b3c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gHX+KXjby2K1Q9I+GFH1qbAFJqc/U5im89yS0Ybwt2f0q2q+cS93KIfHKaw/XGCVgNB7gSaDe628z4zquwP+PMGlDYqnUCDacw7yB21u13CtSuVqzG502P4Z5Nlo/Rw1UxTJBVRrvWI0npwD4kMD6WFAoVUiVV7huKwcgteDU2mks/JsjiblPMjxEa/IjkV/kb3q/XyIKRmezHM83jaAxyZPCFL7rC+5PwTyofgHCHxpT00XGck5H3+1dTDF1vbhqW5WEGLICrs9eHLAIUOeKVztiP5pQ4pD69wmqbZHY8/QUjQwIU4ReHpF+x2KLf55jhiATB5/TqgH/krkmha5eO2N865hZyEix8RqG2EowxkpLP45+ZLYtoCCf00ePdqVT8VLgP8u8cEalsulXbm/sPNU2sLjJtUvb4nmZ0Ud0ykMw3myLGM7o5FObElR2EIOuJhb3PCdNe8+CwubAwzewsWthMc/HGjv0YbFnZV6T1nJw/fsu0hxQNviyAOWs+IdOqQAu2zJ/MGn6Ugz2/45bjSOTdojhHS8j0z9wJfPuGUQn0bCApL+eFmkJqtFafl8do8aOMu1EQC1HSszA8l/zuhscWZMPea3cdpYWtXVg0RJsr8oyOoOx5stCSDVpDNgwUdHSYE6OTuWycGOhcKvGwYg5gdL1qtOYyjIuiwm2cc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799009)(64100799003)(451199024)(55016003)(66556008)(76116006)(54906003)(66946007)(66476007)(66446008)(64756008)(316002)(110136005)(122000001)(86362001)(38100700002)(38070700009)(33656002)(82960400001)(9686003)(83380400001)(26005)(71200400001)(7696005)(6506007)(2906002)(478600001)(41300700001)(5660300002)(8676002)(52536014)(4326008)(7416002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?rw/87TY+7gqP1Hf2UxdPCNsV0as3g+QObhl9kuuOYRkjfVRGbU95IVQb9X?=
 =?iso-8859-2?Q?v+qAETzI1Pczq6BjdVb0b8HBPlIVQOdVawOUczOMQmpXlje8enbJEeK3u0?=
 =?iso-8859-2?Q?3Y5QjDBBQVMhYWdQ0qy+ta3bMEjJ05mEwZODhq9tzX6EZ2FJviKXvU+7Yk?=
 =?iso-8859-2?Q?04uQUVUUXEOnLkFRx+/Vm9i4bR3NzjAFH+/ierbT5bWs/pF87TCOEJlzb5?=
 =?iso-8859-2?Q?8AgGa+IQJMWJw6vaKN+UWUfyaNldcTytp/wIILp30XSrowniP2V9mmnAiy?=
 =?iso-8859-2?Q?Tm0evaJMkOWTkCWRsc1uV0W9u5BNpI9Ygio0hvLw5lz1lg1T3Yb71Sy4qy?=
 =?iso-8859-2?Q?nHgT3fQlEUjy/T+jtBQEHmk+G89hVtLFpqKgsyEOSWxqEQ4BaKhynyOCAQ?=
 =?iso-8859-2?Q?dBygL88uWyZoAD9+rqkmwDJMdWpO3dHTGi6ZivZlnak03q31MN1rDkSzEC?=
 =?iso-8859-2?Q?tJE1FF7toaKyE+8qLlB/XiBcxU0KWXU6/LYNljMGjVNHj5L0MrE38hzIJD?=
 =?iso-8859-2?Q?9AscVqkoPd3qi8Clb/92vm3fKVFA7YqS7UF30qOle48VtdzZQxcDRhB+7L?=
 =?iso-8859-2?Q?5dHYMryba0SG2wO64d7of4FYpgTdWXOUcpKku1DOVE5qJTKrkcRwnra0Tz?=
 =?iso-8859-2?Q?kbkX/Rr2cBHI8gxXTrRGXB7klhul8N1dX46PyEEDChUJhBvbXxvSGpW/M7?=
 =?iso-8859-2?Q?vWgYruayjdB40VYICONTI9QzO75RLniz7Cwh+DqrySRe2ilFNunuEIXGIB?=
 =?iso-8859-2?Q?ddNAqi/s6/HACzbBM8NH0aayZva5S0ALhPbLC+HiE75TzSMSoUfcV3BOsr?=
 =?iso-8859-2?Q?CJNZIdZeILR4nah7EX8bxWb+/ja5QyyRW09YtJypieCBtE99EtfTqHfz/3?=
 =?iso-8859-2?Q?bpTCYS0N9op4Lio04Aq/Pf5C/+a4sHltexh59dJIi5nkCciOJmrpVLxXxC?=
 =?iso-8859-2?Q?w/fVvbtvuvhrwoosylQP19CO44xC0XXdcZZVBdiS/uA4UUKCMVE47loQiw?=
 =?iso-8859-2?Q?pQtXjahF00YVe5+7ss3MIbPmRA6pb5/Qv8B37Vb/LW1TkihNUNR70sCLhg?=
 =?iso-8859-2?Q?Tbfc2tVy4O4aowZ10/F0cNknjUFjULCigvdQTnlMzkI8U5Lpsjuz5lLvQc?=
 =?iso-8859-2?Q?QIJibPjRq7zf/R5hl3GPpBY5hvk3EDAkamR7YDC3k+sxYn4KUhbyx5bZ4u?=
 =?iso-8859-2?Q?Pzc8L80oRf5uNl5kD0FFkGE6uXwrMU/yNzt73d+rhZA9Ii2PW46TqCP3QN?=
 =?iso-8859-2?Q?y/cUkFSxuW0f0ou/KXU726N4Nrm9kTC039AqVAH2lo9hgzyQiRPZyZ2QUu?=
 =?iso-8859-2?Q?VcfUs0vOGoVEh8UzIvUzoN9kBzevT2C/WfMzlv2zrAbRK96iwi5MUKd1ym?=
 =?iso-8859-2?Q?IXlEa89m39zQy+Wl5mwbJ09lNNKmiPkYZFodN0tmV25NLf6p4WEwD/En+R?=
 =?iso-8859-2?Q?rIFzSmIpeDPiFj37cbky9HxvIlUZB7JIBH7MCPBl1APzOQPDdZTwJwG8ts?=
 =?iso-8859-2?Q?SNUkHnQjbINt04rU7jsIYcwQ0Sn8epwQXzawfuCmB03yiWjxWiwyLwj6w/?=
 =?iso-8859-2?Q?wOKqZXnznzrgsChrEMF8BrUIGbXuq4nhgaE5rMhq2YEDCZHiheSgwnsO9j?=
 =?iso-8859-2?Q?FazkPq6nVw6cYqCHPpchVp1hmjhHpua5KL?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-2?Q?nYSbZGpFRiHCReKPx8XBs935dhdLq4eXgjGb0GGgonv5vrRkFjMO6BTrKV?=
 =?iso-8859-2?Q?FIdYBICXQ//eC8nlewD88eXiX8TUM0RmjO3+OqjfjnDgxOpWfq43F2KKJg?=
 =?iso-8859-2?Q?8kXeL5ePqious5dSn9riIBX12Z5HXosNfWvnKp3K0M35SvvwoYU4cpp+ng?=
 =?iso-8859-2?Q?8kigcrcn9vI1kPK9eFOuvp+9GoF1u0YkwlCZeP70er4dwYc+UvjGjZpDUw?=
 =?iso-8859-2?Q?SuwMn8eYZ1ZZDiKC2pDntPmB6phJE4DqooXYuSbTEvB/K9hWVn/JkrNXMn?=
 =?iso-8859-2?Q?TuZ2YveXBLHOZjPusY0g30BRRlgW2SWwqt/36EW2c1P+MLQJTgyzhcjr2+?=
 =?iso-8859-2?Q?FbVUAGdimYxOTnUsWMpbIfHkQbBh/RQWbAE8uUZhLhjZkuWlDt9UtvUkZS?=
 =?iso-8859-2?Q?zR/AcL3VHs2ocJwp8muUL74eidRwIqUXLnisCTL5lSPMdmDpC7oH4k2scC?=
 =?iso-8859-2?Q?4k/wwFRq6uen4EGgth4xyLJ/b6+nAfcodQM/2Hlj7qRpHaC5aXE0wEZnGU?=
 =?iso-8859-2?Q?JiG1uv9O2+6t5FBrVq2yMgblR/f/AwOtfY5ZGutwHGdKkjUAyFiqwZI+Hp?=
 =?iso-8859-2?Q?m5cIuxVoUkMMfAICttRpfZiiRFjauVWYPQx1+FsygkJ0sVH4XGgXeU76dR?=
 =?iso-8859-2?Q?ePFbTtDfQ5tRQ0CrKSjihORfWkUysMCayDrQo354I1upqTjZg8S+OCByRd?=
 =?iso-8859-2?Q?90aC4gwjofJU0k/8IMztfLRsK2t8LldYOFrefEMI/Kgrv4EKNOzXQ7f1+W?=
 =?iso-8859-2?Q?GnAX79e/BQSj/ohdWzbgtPC94TXukxoMEc7H2FpvlZSR/CIT7MnL9LAJnr?=
 =?iso-8859-2?Q?iKtls4t/LNn8vKppf/SefWNZftc83KSPKcl+/44idM0CUnQ28qHG4tEvJN?=
 =?iso-8859-2?Q?APnXqDNdeppQi837oND7JI6KusAuYdJZ2atC85l0vF28iiMh+q7HullAUP?=
 =?iso-8859-2?Q?8gYJLrIFlRFi6ySKGOT6vAi97Zw7+Fd5XUy7GuvSnYRqefzOyUyDupOpCt?=
 =?iso-8859-2?Q?MQhX1FRNDVd0NQdbipi8kNAM10vD0R4mqhRRZgYDhCdfSfCQGGFU8Gertv?=
 =?iso-8859-2?Q?bOeATxy6FA+PJ8yOWvW6uqT7ipmnoGfUECi15PbXvluHUQVIUy2CTINlvI?=
 =?iso-8859-2?Q?VeC4B6eL6EhoIoUHv0R2UV4iJWBpkPMmj02delXw26nzKZzMoffUyBCX4d?=
 =?iso-8859-2?Q?s08x6l4jUcTId7OC/wTBhY+DUVWJMatlMz0=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4675eddf-b5b8-4f31-0df7-08dbdc642b3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 11:58:18.3050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y87ziAiAjdLbtMkPh59FdXdjk6VlJBIuHi8Wt22cQ6xpp1UJZ/M9+5VExvzHSMg68KDO0jVKO2G04EcMZ73Nsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7237
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> A correctly operating controller should successfully halt and clear tasks=
.
> Failure may result in errors elsewhere, so promote messages from debug to
> warnings.
>=20
> Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled
> host")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>  drivers/mmc/host/cqhci-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.=
c
> index 15f5a069af1f..948799a0980c 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -942,8 +942,8 @@ static bool cqhci_clear_all_tasks(struct mmc_host
> *mmc, unsigned int timeout)
>         ret =3D cqhci_tasks_cleared(cq_host);
>=20
>         if (!ret)
> -               pr_debug("%s: cqhci: Failed to clear tasks\n",
> -                        mmc_hostname(mmc));
> +               pr_warn("%s: cqhci: Failed to clear tasks\n",
> +                       mmc_hostname(mmc));
>=20
>         return ret;
>  }
> @@ -976,7 +976,7 @@ static bool cqhci_halt(struct mmc_host *mmc,
> unsigned int timeout)
>         ret =3D cqhci_halted(cq_host);
>=20
>         if (!ret)
> -               pr_debug("%s: cqhci: Failed to halt\n", mmc_hostname(mmc)=
);
> +               pr_warn("%s: cqhci: Failed to halt\n",
> + mmc_hostname(mmc));
>=20
>         return ret;
>  }
> --
> 2.34.1

