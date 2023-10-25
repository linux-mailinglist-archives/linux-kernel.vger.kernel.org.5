Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135527D682D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjJYKTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjJYKTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:19:50 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD873123;
        Wed, 25 Oct 2023 03:19:47 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39P949qd024896;
        Wed, 25 Oct 2023 06:19:35 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3tvv63ctjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 06:19:34 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZN2zewg01YZKjNDoSgRjl4o91zoCbreYuFhLc1zJpIkfj9WSujOI9nqx+YiVzqpPvfVaiPH3KcbbKUpHl5VuGuiRRCGoRH0tpgw7BAuPWKdgdJOkhZYjKxzRcr2u72zxS3egyRKmlGeh9vb1v+fo9hrzQE1wZkEfkvX0097gZpzr4Tin3d1SxAhTpVIv4joDS3BTFFlaSlWVqhlwoVR4bYKjuFwbb27ymXnXb8oR5GMw23Zt7priztQgW/K2LwAP3QHGDsu4TW+ptaeVFS2pylyBMjxke0Zlpjkrra6e6CB9LnQmOeuTu2VUotGa3cfTpf6mqXgrVtOiypMKjLhuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrIh9r4ByXqy2mv1k5shzNsGnLrM0kmAYwsGYHuQmMA=;
 b=JiLLz21LFlYSLZ9C2HsoggqCgAhiuBEt9pa2k+sg9SaGFQJXAnR4xeV2s3+mhO+b6K/0AjZbCBB1yj5dLNxruaYvR5OvxMeJE9E1SjVRJKkCMXzmANuSA9o0DQ7glB/LeSQO7oVhfvDwshY8kW79gh9Pp0bfZk+tmsNdfVBuuYrw0bQ6a9YVZg9RRMWZB9u6SRJ9AT+l+akPPBny9eNbZsvcr6vgqAccIhRgJhnsvnLCDddZtj5On/8xCCc+xtmE8fVfj86u+dM06ScryhfOrO7agM4XTxz3i8llYBvHB5OnPK1UCxjNgokV6bSF4qwZWgKffkdNk++uFcxj1Mx7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrIh9r4ByXqy2mv1k5shzNsGnLrM0kmAYwsGYHuQmMA=;
 b=sGMzzG8ZzPPIvhlBLrAGvFQH1v66HyyZ/D4+PoYnZjEBlJLUKDZcVVujt7HnKZ4LtU2m1Sfs9b26axiNREi4rzV/kcKOPiuJTa5m2PGCNO5LP0VS24nhGpWK4LeTSMqV0VskfqEdk7bvcUklMHZVgMlvokXtPCZnY4BlzkDoSPE=
Received: from BN7PR03MB4545.namprd03.prod.outlook.com (2603:10b6:408:e::31)
 by SA2PR03MB5948.namprd03.prod.outlook.com (2603:10b6:806:115::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14; Wed, 25 Oct
 2023 10:19:31 +0000
Received: from BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e2c3:4dcc:c87e:bbca]) by BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e2c3:4dcc:c87e:bbca%5]) with mapi id 15.20.6886.034; Wed, 25 Oct 2023
 10:19:31 +0000
From:   "Balas, Eliza" <Eliza.Balas@analog.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v3 1/2] dt-bindings: misc: adi,axi-tdd: Add device-tree
 binding for TDD engine
Thread-Topic: [PATCH v3 1/2] dt-bindings: misc: adi,axi-tdd: Add device-tree
 binding for TDD engine
Thread-Index: AQHaAowB9bhJsll8RU+bJVO0WUIVKbBZVjaAgADoktA=
Date:   Wed, 25 Oct 2023 10:19:30 +0000
Message-ID: <BN7PR03MB4545D2A90C4D76AF2C6C166997DEA@BN7PR03MB4545.namprd03.prod.outlook.com>
References: <20231019125646.14236-1-eliza.balas@analog.com>
 <20231019125646.14236-2-eliza.balas@analog.com>
 <20231024190947.GA270524-robh@kernel.org>
In-Reply-To: <20231024190947.GA270524-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZWJhbGFzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctZmExM2I2ZTgtNzMxZi0xMWVlLThkYjgtNzQwNGYx?=
 =?us-ascii?Q?NTcwNWY3XGFtZS10ZXN0XGZhMTNiNmU5LTczMWYtMTFlZS04ZGI4LTc0MDRm?=
 =?us-ascii?Q?MTU3MDVmN2JvZHkudHh0IiBzej0iODI0NiIgdD0iMTMzNDI3MDI3NjgzODMx?=
 =?us-ascii?Q?OTMyIiBoPSIxU3MrRUdGcS9DQnkxK3BXOEp5NzVOSUs1R1E9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFFb0NBQUI4?=
 =?us-ascii?Q?OEllOExBZmFBV0hXektreXhWUmNZZGJNcVRMRlZGd0RBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQWxHVEdWZ0FBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBYVFC?=
 =?us-ascii?Q?ZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQnpBRjhB?=
 =?us-ascii?Q?WmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5?=
 =?us-ascii?Q?QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFERUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZB?=
 =?us-ascii?Q?R29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRh?=
 =?us-ascii?Q?Pg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR03MB4545:EE_|SA2PR03MB5948:EE_
x-ms-office365-filtering-correlation-id: 996a44c7-af5a-46f6-8b23-08dbd543e077
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BIiye47DMqgkbxs7l80TJ5I2xSWnZYraJ3md+leRZiZUujXQikUuRjoFamJ98vehW/I7ZvPvSgcwxnmHnO4HBRLz9/Dzise0oGxTR97G4i2lRYT3HaiFXEB+IG8LxD5Z+7z4XQWiggVqWOufPa+3jJwgno7odbpHEl5DIof4UXw1m99eFvngKmd+QJed8SNTOGn4+1NBQ41p4cI8egyXze/HN2p07kPV2a17OhOZtezhg3sBYhFq7uGcyucYA/DKa0VCdDAIBKceILlqnCo59p8GIiHt/O9VjOOLertvOrmUr0wDpnHjoZVrNPoaWY8AcyyV0lSnttmT4VXPEvUFwP8kS4SrFOvOnTYJJaJ6494RKhOsWbt+tmpwxk+7c56WMGhdh/n/p0VO8ri/VT7h6oL61rhnqiNiz1Mr8hx5vOWvS7Q4UydJJxuTV8cx+mjjUyDdeH2voLuP6IeKLyS6lBjPc0ttecZg0mZa7Zb9yd8wcQGp2s1rwcLjRJO3QqHpZJ85XbEWlhN4APgas9DxUigilq0Bi0yXCCzEAS76Wl0b5MG49Etg0BNRaWBzBZheAmPjYooh1IgVIak34UhGp7BpvyB3xOCf7CGzFyiyhEdgGWHEA62TSO35jcXI1/kx7wPsjmpa3QrpEO3ob1pj8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4545.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(346002)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(38070700009)(478600001)(2906002)(55016003)(9686003)(5660300002)(4326008)(38100700002)(8676002)(8936002)(66446008)(41300700001)(52536014)(66476007)(316002)(66946007)(71200400001)(33656002)(86362001)(6916009)(966005)(7696005)(66556008)(26005)(6506007)(122000001)(76116006)(64756008)(83380400001)(53546011)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xRhCGa1YryQMoV21+7BE00kvX//KWAIBLfpdArhBv2r4HiScgRaDOOS/B6j0?=
 =?us-ascii?Q?RSmEJ5+CM+mvVaObIEqdHjm3ohfz0gBdJoDk/8EQ1+Bot7SE1K+I7xH7RADS?=
 =?us-ascii?Q?vHSRikFdRtCWxD/8d4vuXytmNjY6LLmYgI6G52+1FlWGK85vbCn5gQhibUMq?=
 =?us-ascii?Q?hAb8/5s6R8eoJTTI85Hiy2vu1caKYtCQZ7RE1quRiVSFjjI0G1CBiPWjSmKz?=
 =?us-ascii?Q?I2ujISnHO22riSKpwUREEbB0DK02Fv9gTpjt61ddEjv/v922z9QNLTBXx+mS?=
 =?us-ascii?Q?vX1ibDOrugqbAj3g9alLqNj/2mYZFYo4VQmNLIJeW0hgxSoIIN04uSEDBzEq?=
 =?us-ascii?Q?/dmkUoMtMmmFuauRg+aMs+V+TTQBmMV+wntwt7fxLCtlVSO891yeRsLwsVTA?=
 =?us-ascii?Q?Wh9s8jg+5WjmNX2QbrvJa2u4pGg4gkOqWuXbUEhYW6Fmy7YN5HlAVwl3rt+F?=
 =?us-ascii?Q?sZm0XB1k5LiXzx02bGXqORsV1zeQIRfMwEhJhyqSpx/mVQDi7O+pF7kigpKN?=
 =?us-ascii?Q?JV6WB37YuT0GMXmv5DPsQQY9uwKC5mYDY+57Ge7jQz2jPJmdoymVljlW+myr?=
 =?us-ascii?Q?d0OYjEAFWPKKiBOpbNMJ2J9uatW6uPODJVUpMWG/llBmhlZ5+0svgmVgF5vq?=
 =?us-ascii?Q?EXyIG2bj7fatnn2BtpXr/ILjwwrU8ak7rhnVI0IjNJ53uMPiegbokPBND/6I?=
 =?us-ascii?Q?MGid/HnLG5FjEcPOY+q6BZkCfLqHy29VDelvHbYpL2eksqcLlDLMsU8LWj8T?=
 =?us-ascii?Q?H+BXxY3GAhfJek9/0KC+OFs2CBqwcSvAMqtdyobCf6Im82HFow740SU4AWml?=
 =?us-ascii?Q?ayaohMoAew6FvwO8NjTw1Ne+WTdObQO16s/osW6E55F1gX8jfNFlIfEo2LT0?=
 =?us-ascii?Q?c23Ym0z2EEj2uNvIIkXW8gZIT6Cew8wohDhq0sNhfY3hHAuwb209JLPlI5eV?=
 =?us-ascii?Q?vvvTj+Kjj8hvYxMLIhZ+IdeLTT5uqOcsqUHW9hCz3L6LX9XLiLq664NvqtIm?=
 =?us-ascii?Q?Umg6T423mbxc1oD1E5L5pzF2NHlZsWHO2266tMh3sXn3x0bS3/ArwpgIT845?=
 =?us-ascii?Q?hovHwEHbMzjWePBjdWIdB7aUqyzY37NF1Ga2rla8D/6OEWr/AXj+4tm0JwVL?=
 =?us-ascii?Q?Al2hsDgFU7naWnmk5u+QvnFZZkVlF50X282LT1TenPu6I1E2HrhtB7npxxoQ?=
 =?us-ascii?Q?hQMZMwxzKnDIpoVfvINQqJZwDiF+02Nxu1U8XyB3qe+oI7W5zOZRr6I7z0El?=
 =?us-ascii?Q?rA4taAOpzgNF0Eh+x7aU22z4tu4Q457NVtLZPna454S7g70Gg7zsu104DPBM?=
 =?us-ascii?Q?R0dDXd+/TE9DCmb5p7QP7FAb3iS43DT9n/IvxnpRQAhb2RI1OrZGNQv/og18?=
 =?us-ascii?Q?rB0+f76NH+XgXlVKR6XKV2GnNW6kGy/bw7RV+M8bX/+Xod9xOSeKr0sWRzxj?=
 =?us-ascii?Q?1DJSiVfEAlweaOo8c3vXvGrEc6Rc563PuXw4YDWcbREJswagqYlhyhnYk1H0?=
 =?us-ascii?Q?sHihK6d8drjy0uHrfbxBHASZnd/1tJW//UjLFyv+vmQ2ad0MrCH68mvMgFNA?=
 =?us-ascii?Q?z49s09Tw9AZPMWxu7P61dDWuFf2aGyyAiI+g6Rxm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4545.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996a44c7-af5a-46f6-8b23-08dbd543e077
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 10:19:30.8142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PjXql+d2tTJD0ABiwt9Ctgj5FYf94gONL5f5xxXZDF0OYxYUgccoi1OtRLMkVpS8usAcLetmsqLyuK5VkdbCqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5948
X-Proofpoint-GUID: D5Rw9RZZyLYxEVZvcSEsiqFdCGUXSCLG
X-Proofpoint-ORIG-GUID: D5Rw9RZZyLYxEVZvcSEsiqFdCGUXSCLG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310170000 definitions=main-2310250089
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, October 24, 2023 22:10
> To: Balas, Eliza <Eliza.Balas@analog.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Krzysztof K=
ozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor
> Dooley <conor+dt@kernel.org>; Derek Kiernan <derek.kiernan@amd.com>; Drag=
an Cvetic <dragan.cvetic@amd.com>; Arnd
> Bergmann <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Subject: Re: [PATCH v3 1/2] dt-bindings: misc: adi,axi-tdd: Add device-tr=
ee binding for TDD engine
>=20
> [External]
>=20
> On Thu, Oct 19, 2023 at 03:56:45PM +0300, Eliza Balas wrote:
> > Add device tree documentation for the AXI TDD Core.
> > The generic TDD controller is in essence a waveform generator
> > capable of addressing RF applications which require Time Division
> > Duplexing, as well as controlling other modules of general
> > applications through its dedicated 32 channel outputs.
> >
> > Signed-off-by: Eliza Balas <eliza.balas@analog.com>
> > ---
> >  .../devicetree/bindings/misc/adi,axi-tdd.yaml | 65 +++++++++++++++++++
> >  MAINTAINERS                                   |  7 ++
> >  2 files changed, 72 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/adi,axi-tdd.=
yaml
> >
> > diff --git a/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml b/=
Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
> > new file mode 100644
> > index 000000000000..4449d9abf46e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
> > @@ -0,0 +1,65 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2023 Analog Devices Inc.
> > +%YAML 1.2
> > +---
> > +$id: https://urldefense.com/v3/__http://devicetree.org/schemas/misc/ad=
i,axi-
> tdd.yaml*__;Iw!!A3Ni8CS0y2Y!4FubpNBZ9iITDA4tWD49qCUp7AqEs72W2OQmpSkLyK2lC=
iWNWSbXGS6MGhJSdKMVza7CV5IRsVxNlA$
> > +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/core.yaml*__;Iw!!A3Ni8CS0y2Y!4FubpNBZ9iITDA4tWD49qCUp7AqEs72W2OQm=
pSkLyK2lCiWNWSbXGS6MGhJSdKMVza7CV5
> J20y6r-A$
> > +
> > +title: Analog Devices AXI TDD Core
> > +
> > +maintainers:
> > +  - Eliza Balas <eliza.balas@analog.com>
> > +
> > +description: |
> > +  The TDD controller is a waveform generator capable of addressing RF
> > +  applications which require Time Division Duplexing, as well as contr=
olling
> > +  other modules of general applications through its dedicated 32 chann=
el
> > +  outputs. It solves the synchronization issue when transmitting and r=
eceiving
> > +  multiple frames of data through multiple buffers.
> > +  The TDD IP core is part of the Analog Devices hdl reference designs =
and has
> > +  the following features:
> > +    * Up to 32 independent output channels
> > +    * Start/stop time values per channel
> > +    * Enable and polarity bit values per channel
> > +    * 32 bit-max internal reference counter
> > +    * Initial startup delay before waveform generation
> > +    * Configurable frame length and number of frames per burst
> > +    * 3 sources of synchronization: external, internal and software ge=
nerated
> > +  For more information see the wiki:
> > +  https://wiki.analog.com/resources/fpga/docs/axi_tdd
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,axi-tdd
>=20
> I don't understand where the version number went. Now my question is is
> there only one version of this (ever). It's not specific enough unless
> there's a version register that can be relied on.
>=20
> This patch needs to answer any questions raised in previous versions.
> Assume the reviewers don't remember your patch and will ask the same
> questions again otherwise.
>=20
> Rob

This is the only TDD driver and I use the information from
the version register to determine the version.
That is why I had to remove the version number from=20
the compatible string.

Thank you,
Eliza

