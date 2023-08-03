Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74EC76E403
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjHCJLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjHCJK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:10:56 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B51F5;
        Thu,  3 Aug 2023 02:10:54 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37397GKp004411;
        Thu, 3 Aug 2023 05:10:31 -0400
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3s7qbk5q8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 05:10:31 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5TRw3nJel3rzy6EUE/Lwl+38QXpps3czhUIHoqy0v8CD4kBxobrHC26TdD2RsPXMOcdUlTj/NHNqyZZvWrW3792xvE8aROb1NU9T9hM1cgj1GsHQKBnWG1xvn77xnHheTIuBJCuWVNMyhHoho0wzZL6YBd02CcVNqj2uCpRIAumNMntcSgp7LuAj+WBTq0cUJMF9AsZ60DqUU4FtgDJlkPyTrTf3AvDCDXqHdV830bVAp9LdTiVc3qu3yg51XN05uKhde/DWGLvAm4V6R1nlSfTkAm0gSv7IWv/AQFsvvIKglSTts9BVGgKWEKAVymCVDX74tHw5rTC7AQUDRqsjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EMi7hPLbmPx9qas3nhqQOgc3Q1SU1yiAVzLpOLV/u0=;
 b=XNVyt41MyOeFGLCGsHBhpsIf0pSrkhU159tGfDes+LsztsDeYaPqV9Juetflcbxv7Arsm1vwAELgUZlgGU8yuQI7li8Sc/TbDqndEMTHJYPmIXnYiMTgTmIwGyf4XN85aQP81XRsbVEA7y7f8C6jQdCw6bU4ezmvJkaMjLrVs2rzNUJV3EUCxDVS1whFxKX/7IBhlaeHc1trcpB/Os/SWM0t6R+5b52vmjCR0G1dAvstJib0pgYCHoUUYGQqaAqsYDk5aPrNBFFK0+QnfiKPKsmU0X7TAQYrF1/94FaBqin16c4IeRt0iUvJOY+UNLl5p1uhyBGgiHVHaqdxlf0fJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EMi7hPLbmPx9qas3nhqQOgc3Q1SU1yiAVzLpOLV/u0=;
 b=dFTVlChp80ygZCefXjpgAbNt53obzu/W1Ahtb122mhtodQzumeE5sjfJXr143Pk8j5ppH0ssvQLzAG8s5XHgecPltHbi1t/DEC/eQPDYQNV7ytXWclPz5l8TkjD7tvHp6PKmZlStuY1VeJam+7Ffdzg3eNDJxOpfhWge77Xk080=
Received: from PH7PR03MB7391.namprd03.prod.outlook.com (2603:10b6:510:2e6::5)
 by SA2PR03MB5771.namprd03.prod.outlook.com (2603:10b6:806:11e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 09:10:27 +0000
Received: from PH7PR03MB7391.namprd03.prod.outlook.com
 ([fe80::200d:e2:3bae:2a5b]) by PH7PR03MB7391.namprd03.prod.outlook.com
 ([fe80::200d:e2:3bae:2a5b%4]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 09:10:26 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Mark Brown <broonie@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "zzzzTilki, zzzzIbrahim" <Ibrahim.Tilki@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux@leemhuis.info" <linux@leemhuis.info>
Subject: RE: [PATCH v3 2/2] regulator: max77857: Add ADI MAX77857/59/MAX77831
 Regulator Support
Thread-Topic: [PATCH v3 2/2] regulator: max77857: Add ADI MAX77857/59/MAX77831
 Regulator Support
Thread-Index: AQHZuGy8mN9TLCcuJkyLQ19F8fkBDa+/r5IAgAyW/YCAARHLsIAAaoOAgAn0bACAAAK6AIAAAIEAgAAAvwCAAKY8YA==
Date:   Thu, 3 Aug 2023 09:10:26 +0000
Message-ID: <PH7PR03MB7391287FA2CF2C1982724952E708A@PH7PR03MB7391.namprd03.prod.outlook.com>
References: <20230717050736.10075-1-okan.sahin@analog.com>
 <20230717050736.10075-3-okan.sahin@analog.com>
 <20230718155502.GA3542993@dev-arch.thelio-3990X>
 <20230726161033.GA1102409@dev-arch.thelio-3990X>
 <PH7PR03MB739122A373964651D995EA5AE701A@PH7PR03MB7391.namprd03.prod.outlook.com>
 <20230727145143.GB2013261@dev-arch.thelio-3990X>
 <CAKwvOdnPQEdbTGBO0hBn7CC4d0xtRV2zmfrYDfAhH0stfDYeJA@mail.gmail.com>
 <32af6891-8246-46de-ba1d-ae1999f6eb10@sirena.org.uk>
 <20230802230426.GA3027248@dev-arch.thelio-3990X>
 <ae431bb5-d132-4737-b4bb-58a323f877a6@sirena.org.uk>
In-Reply-To: <ae431bb5-d132-4737-b4bb-58a323f877a6@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcb2thbi5zYWhp?=
 =?us-ascii?Q?blxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?us-ascii?Q?NGJhMjllMzViXG1zZ3NcbXNnLTkyOTVjY2JkLTMxZGQtMTFlZS1iZjAxLTU4?=
 =?us-ascii?Q?NmMyNWQzYzNlNFxhbWUtdGVzdFw5Mjk1Y2NiZi0zMWRkLTExZWUtYmYwMS01?=
 =?us-ascii?Q?ODZjMjVkM2MzZTRib2R5LnR4dCIgc3o9IjIwMjQiIHQ9IjEzMzM1NTI3NDIz?=
 =?us-ascii?Q?MzQxOTI1NiIgaD0iNjJFNDRSWUxXY2VrR3RPR21mc2VET3pTdDQwPSIgaWQ9?=
 =?us-ascii?Q?IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9D?=
 =?us-ascii?Q?QUFENGxadFY2c1haQVRqQmZTZHBSbk9sT01GOUoybEdjNlVEQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQVFBQkFBQUF2ZGhreGdBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdR?=
 =?us-ascii?Q?QWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJ6?=
 =?us-ascii?Q?QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxBR01B?=
 =?us-ascii?Q?ZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlB?=
 =?us-ascii?Q?REVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFIQUFj?=
 =?us-ascii?Q?Z0J2QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwv?=
 =?us-ascii?Q?bWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB7391:EE_|SA2PR03MB5771:EE_
x-ms-office365-filtering-correlation-id: b8af900f-d45f-4e71-b96c-08db94017a11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B70rNYSpXTS7YyBgggxEuV1pjWTCOHYxoYMpbgEy2IQ1DzqshNPKu2Nqh6QWkPp5LcHtzEeUrE8BXTFCXLY+73xgYmm+/xVVFSpoE++0lHp/YKhU3V9HBp2MtCR+ZlNTI5jROAmOM0WfAl6m72HDAf/2Ivkp1Ue8dofS8FmUdPVB6+Z9CKVNVOmGbiBoaJXUMv/ZYpM0a/JbzOs0nD4QxhMc9zBVJvTkxaYLrQ7WP2xH9zpi6dmOqrrocNcxXoHyrjPHdpqwH2upsacPMInF0CKF1i7jRWRKw24hv6mYE9Md/bcse6g66pU6hQ4zF5Ab9YkB8Q8X7gX0wtdzIv1jt7n/OX/usAWecF5W0gdVp/KSNn0lokNCwHyuKjmKmtIEUkg2M0gpfTZs7FE1SSlOBh0QlBKlQk1wXUbCXrH8/DuTSoIP5oofJMaiZKTxkYIHzbxKMqfwNQGDzqK09A1zBqWF34uutRdoYKnS6S5sFytqYGAIw2OLYpH11DUnAAAdhjD8uD0d5Az7idSpTfAc+yarZp7o6TKgdTVjDoLNRUGH7bRjNdD2udWsqQdLYW2DWWQs7CR+wgjHe464lXzDS2rrSPedG8QKLvwmlE66xtM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR03MB7391.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(4744005)(41300700001)(66556008)(66446008)(316002)(2906002)(4326008)(76116006)(64756008)(66946007)(66476007)(52536014)(8936002)(8676002)(5660300002)(122000001)(38100700002)(33656002)(26005)(186003)(38070700005)(6506007)(86362001)(83380400001)(9686003)(478600001)(110136005)(54906003)(7696005)(71200400001)(966005)(55016003)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?keQESOVjSJKG0nWjQnRfk/lEBlH94tgb/kgwp5G/XhndGWYiD6G2gXvkizvT?=
 =?us-ascii?Q?VCYIQL6WEUZLH4CjqYzooefc8axnpPDyVtAtkELuxwN7i5g+kJTryFfZXRIB?=
 =?us-ascii?Q?F8PrtSgyf/7VZQbbsTYaYExm59vavybo8jzPAEIcv7kLKluPb6xwhLNgwARl?=
 =?us-ascii?Q?V/Z7qCAZ7y/o8AEX+Wcy9PyZSzuFbRAGyPCA6eD5ot7dm9m1MZr+8Q504Ych?=
 =?us-ascii?Q?I8UEwP6LIop2t7WIMS+U2fh4ow+Z6brjGVfdmkYi7hncjvf5V7WGpU5rZ2UB?=
 =?us-ascii?Q?deIMQGGSEeehiSxd6HjrgdqLipNU9qpy+LB1y3Ov6Mr6UqhwfCAMzyMTLAnP?=
 =?us-ascii?Q?nX9ynZx37BiYIdrMGO8xJNfemlTHGa6qOdmx8FVtOxfkWGP24TxE6WYsnxL3?=
 =?us-ascii?Q?TZA4V4oHoQcqiGE0RaFzRKpQVywIDm9WdsdHPdC1samLRK2nxtxU9FKca3au?=
 =?us-ascii?Q?LAfP+u5PpK7zhCQ3GGv1gKW/kj8zBoUoE6UFxh6sXE5Ti5iK97TX/TU5f+O+?=
 =?us-ascii?Q?zDz3zzNn2SM7Iig3WNS8Pxj9gHg3grzIeFfgy7tsrlgQLROwYwLDkF0xjImq?=
 =?us-ascii?Q?wgTqRlE5Q0jJNJFGBWX5Qt6vqh06dSn1inRWpEGaGGDnYLxw3YgW8Sr5hytJ?=
 =?us-ascii?Q?PPaQuYwdfPn5Nx+C/treoF2HUKXJ0X9T3Ey8Yu3B6SGX7XBCcADC+wQb52au?=
 =?us-ascii?Q?wJ0xRJA7F6MFjLTV87YdRILp6yEGBRpor6pXqPokQSxndbbvk7hlYw8zTeDt?=
 =?us-ascii?Q?+Ra8+LXvElyieyrqx+iwmMKmnxCVSayzx0FQu+yfCCMPsBC8+qY8oTGt31rW?=
 =?us-ascii?Q?5wph0RylXUwGk8lwerJacRPKuFZWaGugGLfakXtLxmRkBM/QPbeIYmtH+dQp?=
 =?us-ascii?Q?EPkd/h5lCDK5vG5XE0M3MGy7a7AhGOVspI0q+bUfrOq/TjL8KD9o5CCWRtgr?=
 =?us-ascii?Q?4DrXhNMf9KQ128Z5akyJjuCmHFt+QW0lRZmvNfZrFwEll4iRcZPj4XmHDiem?=
 =?us-ascii?Q?jxLuyS2lZLgGXzzmmwx42BlBuv1f5hdhZW5JlntZCs+xDFCeCqWEthhGCvXH?=
 =?us-ascii?Q?kmz9qF8j/yOYwoRrl9IE5lYIlI9fJsC7RJO+ypJlC3xes6Nkk9UCgumJ7NzE?=
 =?us-ascii?Q?dBnOaUPLQwEI1qIdP59lzuxoHMxPzLptAA/5p/q4es4u9VWPE+Q0Fh4zLyQA?=
 =?us-ascii?Q?HQlrODGEH9pBCpIqTA0qj/qEk7yymo+I3Q5pOwa/IWUqhSCsvBppC1GWMuwU?=
 =?us-ascii?Q?iGJi2nuZJAlfW5eR0T5o+qs8/lNsfizE/UQVT3IiCYjPaM9pV9vffvizk3tf?=
 =?us-ascii?Q?OWIE4VafhrjK3qtwDSSPf8fEpCqH4ZMV4JmAAUmJLnzhPINfWEcmY4Og7sgC?=
 =?us-ascii?Q?17i7xLdBPWtN4ERVzHTHl1BEqbFovS/M1RilSLjbrqWrUaCOK1eTrnerbaEk?=
 =?us-ascii?Q?LUfo9vvgDmOuqpRfg9OcMq7bwoOA5LgDYamrVMMdcgfscmxJHemMrwQ6wfUO?=
 =?us-ascii?Q?0t0F8LHCtcEhxINPZtoLhPmc0Y3MS/ke67iopX27JELjQh1Th52JTPE2ozCp?=
 =?us-ascii?Q?YX6rNraMPz+25t1MdNtGpZTPnF+V8J2qM9vhBNmI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7391.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8af900f-d45f-4e71-b96c-08db94017a11
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 09:10:26.6643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UiyP80alAkuW1BiJ0IXwHVq6c1iMufdyHG1qV4X4mH2/79p0Ymm4M6ZXlqiKDwVbS/NQRZ7+zZwJZ0xwtvN/EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5771
X-Proofpoint-GUID: qQ8KHx5QgmUbrKRZbUIw01QWcg8msYIJ
X-Proofpoint-ORIG-GUID: qQ8KHx5QgmUbrKRZbUIw01QWcg8msYIJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_07,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=618 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308030081
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

02, 2023 at 04:04:26PM -0700, Nathan Chancellor wrote:
>> On Thu, Aug 03, 2023 at 12:02:38AM +0100, Mark Brown wrote:
>> > On Wed, Aug 02, 2023 at 03:52:52PM -0700, Nick Desaulniers wrote:
>> > > Hi Okan,
>> > > Have you sent a follow up fix? The build should not remain broken fo=
r
>> > > so long.  Otherwise I think Broonie should drop your patch.
>> >
>> > Someone sent what's probably a fix but I was waiting for some
>> > confirmation that the change actually works on hardware, it's not supe=
r
>> > obvious.
>>
>> Got a pointer? I don't see anything on lore:
>>
>> https://lore.kernel.org/all/?q=3Ddfn:drivers/regulator/max77857-regulato=
r.c
>
>Oh, they didn't actuallly send it to the list :(

Hi Mark and Nathan,

Actually, I have received email about fix before I send new patch. As far a=
s I understand, it was not sent to correct list, right?=20

Regards,
Okan Sahin
