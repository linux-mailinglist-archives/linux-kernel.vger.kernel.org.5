Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856A87D8F19
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345315AbjJ0HBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjJ0HBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:01:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2058B1B1;
        Fri, 27 Oct 2023 00:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698390089; x=1729926089;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cIEmfPEhBSaBCKUssGcUCRJzV4NVVDOS45vUJ47BQDU=;
  b=P7ArcD1+dgH8oCPQP86U9puEFZuvt/i3cm3dkffJdHl4HxQMyUe4iUZq
   8qDoZ/FYvaBGHvyawVBDkoYYTiWX84kpdkdI8BCLMkfzgPXD9l9i8rGX/
   BGB8CpppJBvsSYhuoNwfUyAt8vrbgV4MO29OecuPcU84t0wp4W87CnL5d
   BeX5Djj0abDcWjXcAwpNoJiEY5DqlFmuf507+NvNNE9BucUyWF7FO7s58
   SPmkcJs7XsPdROlZnJs/KVmbo6ecMGzjzbvpKFl1BaAFAcaEBvb0vX6bO
   lLWq/et4gO3VKoH7DgceWtcAOLiw7J3reIes0BP+xDdwyRmEQB6BB8z4H
   Q==;
X-CSE-ConnectionGUID: 08krs5xWRva7BoDLifzgBA==
X-CSE-MsgGUID: QYBiKMaVS+2goSKr5cDXgQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="177870865"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2023 00:01:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 27 Oct 2023 00:00:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 27 Oct 2023 00:00:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CemnkCZHnczNh0XBimP8NLTaGaedTgAaEQVTloWwiRmarbfdh7h+z0kwBnYmgx3DofnZWHjaMmuselFj32/f4Gr90S77DsvTKC4i/QrB1nsB2jhCt4naROgKT6TXtUDoFrPVJKQaw9nXMzs8nengAB6nigmFovUxHSISGry21ELz065HUfvIYfy4oO7CpnfrPeBqEaPV9/unkKw7GOnpauhFJX4RrwkdoZc9kgF599ZS2TrkYkAsNvBVi/daGmf8tEMgHQULBz5WTgUWkWsq3Qke4DzEtlrCBJOsYDihbcGrYXIsASQrKEFsRlQG0EM2MUd2f43UbVnKx+GYOjnVkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIEmfPEhBSaBCKUssGcUCRJzV4NVVDOS45vUJ47BQDU=;
 b=GU0A3hcjzoYsuuInlzxfcFYy1wn4qufqH0ckF3ZjWqYgwDzli9HsipJIWqcg5AH+f0xb8w+mDix38pAAS4LcwQfZXN4vHLzmTzgzXwM09MBCC2gFwBgdqFt/5SQkcc6qnu1L/BbYdI1r1pwo2zarU+rhHo15bF2iyZEApa1TcHH0+2aE6l2QPfL3G/27xbDjnTL3Bptx4GZ5BE+P2WiN7zoihIo1SFddiRjAkowt4nkYiC1VOTkuZovck1CsqkbZ6mQvVUYKhTYxy1MfJdu8YbRQoHO6i6ssSXVngyeKYLw5L8q+eJVhoNag47/IAtVIR1YoZyfg7lLTNt5n+lxaoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIEmfPEhBSaBCKUssGcUCRJzV4NVVDOS45vUJ47BQDU=;
 b=vus8OfeJM2GfqrzBeSyTfAgvNC+kKruHDLvV3l7ULp1M0oRXBRQLYnb9X1F1XQzZsX79Gbch/597CxJLm+t0DYlZx3MOIbi8J3NY/VVxiIzsLNlKjgu+m0gCvDfThnyzT8/Sinw3ubvGA/pEkcF/2PZbbkhYu+BXXvL9zA3Z5m8=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 DS0PR11MB8762.namprd11.prod.outlook.com (2603:10b6:8:1a9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.22; Fri, 27 Oct 2023 07:00:58 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510%4]) with mapi id 15.20.6933.022; Fri, 27 Oct 2023
 07:00:58 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <andrew@lunn.ch>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <Steen.Hegelund@microchip.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>,
        <casper.casan@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
        <Woojung.Huh@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [PATCH net-next v2 2/9] net: ethernet: oa_tc6: implement mac-phy
 software reset
Thread-Topic: [PATCH net-next v2 2/9] net: ethernet: oa_tc6: implement mac-phy
 software reset
Thread-Index: AQHaBchLKhew5fqyxUWYo0q8cO3RgrBX+QGAgAJrWwCAAh58AIAAuEKA
Date:   Fri, 27 Oct 2023 07:00:57 +0000
Message-ID: <14219af7-5074-4aef-a26c-b68412451f5a@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-3-Parthiban.Veerasooran@microchip.com>
 <219ae3d7-0c75-49c0-b791-5623894ba318@lunn.ch>
 <fe52e414-c2a7-4e29-bb37-73a5614b3951@microchip.com>
 <005b6980-4aa3-4bf7-92cc-d9f938b04006@lunn.ch>
In-Reply-To: <005b6980-4aa3-4bf7-92cc-d9f938b04006@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|DS0PR11MB8762:EE_
x-ms-office365-filtering-correlation-id: 97adb413-c134-4f49-f3f9-08dbd6ba78ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jn/+w18JN0BvS+UnlVA+9In6uFBoTpsBti2WThGkkn+Kn/70FdC21i9yQfmG8FFa5AMf0Z4fKhwus74wXx6As2DAAz1COTq7hwpoOf1ZfCeAAsvJWsPe9908eJ9W1/lXXOgnkBXs9R78AX2XEyg8l9/cyJODfTX5aIHgHORlYMV8JMjgCZOF2aptGXnP6OX/PWMBeWWcNkaGn9g7QXVKtXRgTHT878RBIZjpAVg+n0W2pW2stZZREXFA+cVEg6LjwY0ugeDYQ5tZ+2H6JBk7GMQDUL9pWVv+yNKlTF9sUtuwLWOfO1v7HVJAMjXR4keuSVnHcHdcFaqyF2zdK62Q13u71yl9269wlCgSILu0yr0E0PcgRxQ3YBYnrjRr59a+T/r5iHvcM5dYldg45yaQJfs5trpG2YZC8smXeDfueByiPMPZTuZ0EXpa56zHsycdRA5EY54dI8tpAZQuZ2zY7LIFGhuOYMJ4iOMoEnKLDpaIiWNYsSCZ6NT/n0TB98ng7H4UILxjEWWjXI/clpwa1s3ezLacjZn5B7wRcX6x/rKXdyGc3HGLN953a/8Vb/zFPbjl7mDmhAgWjhz/ohz1WYiVxl7kn0RsMJTMpMDYuqNEgMyPqMnSgU+yV7rlV+i38RjE20vKse4RcSIDn3NAJUYpRlQGm3tfU5V4iUw1EchuUs08KEGLDOVznEjx0vB2JMlvfUeoz8aT+E2lomeA0z5G4dQRkGWOMad/NYBiFRg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(83380400001)(53546011)(6506007)(71200400001)(6512007)(66946007)(31686004)(76116006)(64756008)(91956017)(107886003)(2616005)(54906003)(6486002)(122000001)(478600001)(316002)(66556008)(6916009)(66476007)(66446008)(38070700009)(8936002)(4326008)(5660300002)(41300700001)(7416002)(2906002)(86362001)(36756003)(8676002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFFGWktiY2k2WnM2UGJNcXRQVmgwMFIrRFpuNGduYWhlUmpNbUdiT3pHb1VG?=
 =?utf-8?B?YnBZaVBNbnFoQ0ZJOFFhMWYxajh5LzlIaURLNi9ZcUtPK09PY25vNnZhM0xO?=
 =?utf-8?B?YXBhcVhMSnJkU0dlT29vcElzeVZsUzBucWtuMjBNUk5wR3NqR09CWFgyZlp4?=
 =?utf-8?B?M01rU3d5U2Rid0J0L2ZPcHRSZmhuZFVGb1REbmJSbkZEWDI1azhDSmM2L1hM?=
 =?utf-8?B?aFppK3hPYWhSSEtjeHVsVGt3QXByWlhQdXpScTBOS1IvUTRKM1E4Z1hlaXFt?=
 =?utf-8?B?M0cxbG40S2xhdmNUbVpVYmhSWjMwVjF3TDA2aS9JUHRWY1drSHJGRGRYOWxu?=
 =?utf-8?B?YnZYL2MvRmcyeTQxR2hQYk1GTUJtL0cydXl3UVZkUDA3cnc0T0srdWs5eUNr?=
 =?utf-8?B?MWQxTkExS09RRHZCb3k4V1AvaGlTWDBvNURGYVVVSkU0Y254SXlZS0lrU3RH?=
 =?utf-8?B?RGQrQ0xpTUhpSE1keWJaYlR0aU9oRldyS0JpOXEvUng3ME85OWtmZ05RcEpS?=
 =?utf-8?B?REdHMjYzMmpDV2VETklCKzdqZ2VScEpFUVhCa0VPQkE2eGZlMy9ITmhEMHZ5?=
 =?utf-8?B?cWU5UUU1M0FsU2NqMUx6QTV2UXQ2TC9scVl1VEMrSjkrWkkxSFljekNLRFlv?=
 =?utf-8?B?MDFUUDJPYnpHbEhyTnIybWhvSFRlQUlxY0hlR1RPSDRFZnRiRFZXYjJBVkJs?=
 =?utf-8?B?Tnd5MEhVMG1JUUlyMTNVOGpJcXlVTGFzQkNiemtjQVFlUStkdlNzVnBUdUNr?=
 =?utf-8?B?SkpYd3ZvRkhwL3VPZHdka1hXcWc3MkdMTTRwRktSUENpVVFEWnNNbWNhSTZt?=
 =?utf-8?B?S1lQYXpHUVlzRm9ZV0V6cjUzU0RpaVNxWk5idGV1UHV1WEJleElVaWtUaUxX?=
 =?utf-8?B?LytKa3NpTzc0OU5RblhvK3lJcVJNK0ZOWmhWc3gyaGJyTitBUkhJM1NwVkJY?=
 =?utf-8?B?UkNIRUlsOHZCRGVBbXI5eFBKL3RSSGEyZDcwUWhBUnRlNWZoK3hFdWtHZnNn?=
 =?utf-8?B?eWxLK3RVYmIvcURDNzZrYnFMU0t5TTdENFZCOWdGcENRRXBPYmVYUGFVMFFR?=
 =?utf-8?B?bE9HaCtlaWFJZHUxejJiWkVvOENUTDZGR3MyTmE2TXk2Rm00aTFLTHliKzYy?=
 =?utf-8?B?dFRqUE5vZXcwU0tMbWNkUkErSnpWQXhVaFhVN1ZDaDdqV2hocDlOSG9nSXlM?=
 =?utf-8?B?ZnZxd3pMUVFCRWx3a0o0bUxCZDdweGVtNWZrU1pETjlCYVd1dnZFaVM2WjJW?=
 =?utf-8?B?Rk5wdW9hOTJGYlhNdXFLdisvKzRtSklndzBkRDdTUy9jeHM5VkwvWno2R0RB?=
 =?utf-8?B?UVc1L3BrcFVTa2JyK3FlQURMdHJBcms2cXZTS1g3UFZ3S2RVK0d0TGdVQ3k4?=
 =?utf-8?B?aGxIeVVNQWsyTjB1QXFZdVZuYk5CZmNHNmlCVEs5NHBiUXlpQ1lzZjdXMDdN?=
 =?utf-8?B?MnQ3cXJDS2FVeVJ2bitWTW0xV0h6c3ZqWnNrdjQwbVg4WDZBOXRMbG1FZnUv?=
 =?utf-8?B?L0NKYU0ydnhtVDlzbkl6TTc5M1U0UnlCalppRjkxK1BHeC8vY0xVRGFjL1Jl?=
 =?utf-8?B?WXRKdm1FR3FGNFN5U0ZtUmVzNWE5aXcrMUpmb2VIeU9nRkIwQVErUUdYbDdr?=
 =?utf-8?B?V0hJWUs1amNEVTdNZGs4aDV0WmdVR2dWSEVUVWd6M3ljOXBuZkc2Y0c1N3E5?=
 =?utf-8?B?MDc2Q0VDcTNPQXU2ckRNMnFuVlhybHlWYWcxR1UzYitCSWU4THYyRG55UjFV?=
 =?utf-8?B?T0oyeGRwVHE1MHJZL1RyYktmVmtkdjJKQjlZWW9MV0RuS2NrOC9mSERMNXAr?=
 =?utf-8?B?WFdPVlpybDJuNjc3L3h3YjFUaVhrQzY2STJZYk4wWDd1Nk5FRXJDUXQvbGVk?=
 =?utf-8?B?ZjdWSjlYcnBmN2NFc21UWHE4THNrSmd4aFovaUlTUzlZLytHNlFUQ05TOWtF?=
 =?utf-8?B?R0ZEc3VaeWFIZEZnenA0ejNmUHIwaUQ5ei9qNDNLV1FPcjJFQTJrb294SU5G?=
 =?utf-8?B?R3dRVHBja0cvWW4xSHRyMnQ5amhMdktJWitIWHBGS1hnaWZ6N0pWZ01LU3Yr?=
 =?utf-8?B?cXFTK0V0OWdDTlJwNmtXZG1Pb3NwUjFnR2k0QXR0VUdiU0VFZFB0RHJSaDRZ?=
 =?utf-8?B?RDVHcmtjMHpkeGYxYXYycG15VTZSOHc2QnlROU1jcGVrd2NmeWg1STZPK05O?=
 =?utf-8?B?YllWeElGZ3F2cXF0c3ovaUtYalh5Y2pCZXBaeVFKOVBMYUhXd0FqV1B3Y3p3?=
 =?utf-8?Q?TwAZKOZiZmmQ6wXES0N9sF/hoVSrqYuhRtmApWjjaE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <069631CA039A134BA538B159A68E7E71@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97adb413-c134-4f49-f3f9-08dbd6ba78ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 07:00:57.9482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fxm9repRmeqNoJ31RxBF7o+7I+W8S451THktDpc0McOYMdZlwxOvaJHq/RdoragBnGhImPsS7SWChi0wZCte1k5Rm6hA3jnDdQuTL/TaUPw+rg8FYPZeHYj1O/92Bpoo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8762
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAyNy8xMC8yMyAxOjMxIGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4+PiArICAgICByZXQgPSBv
YV90YzZfcGVyZm9ybV9jdHJsKHRjNiwgU1RBVFVTMCwgJnJlZ3ZhbCwgMSwgZmFsc2UsIGZhbHNl
KTsNCj4+Pj4gKyAgICAgaWYgKHJldCkNCj4+Pj4gKyAgICAgICAgICAgICByZXR1cm4gcmV0Ow0K
Pj4+PiArDQo+Pj4+ICsgICAgIC8qIENoZWNrIGZvciByZXNldCBjb21wbGV0ZSBpbnRlcnJ1cHQg
c3RhdHVzICovDQo+Pj4+ICsgICAgIGlmIChyZWd2YWwgJiBSRVNFVEMpIHsNCj4+Pj4gKyAgICAg
ICAgICAgICByZWd2YWwgPSBSRVNFVEM7DQo+Pj4NCj4+PiBQZW9wbGUgZG9uJ3QgYWx3YXlzIGFn
cmVlLCBidXQgaSBmb3VuZCBTVEFUVVMwX1JFU0VUQyBlYXNpZXIgdG8gc2VlDQo+Pj4geW91IGhh
dmUgdGhlIGNvcnJlY3QgYml0IGZvciB0aGUgcmVnaXN0ZXIgeW91IGp1c3QgcmVhZC4NCj4+IERv
IHlvdSB3YW50IG1lIHRvIGRlZmluZSBTVEFUVVMwX1JFU0VUQyBpbnN0ZWFkIG9mIFJFU0VUQyBv
ciBpcyBteQ0KPj4gdW5kZXJzdGFuZGluZyB3cm9uZz8NCj4gDQo+IENvcnJlY3QsIFNUQVRVUzBf
UkVTRVRDLiBJdCBhdm9pZHMgc2lsbHkgdHlwb3MgbGlrZToNCj4gDQo+ICAgICAgIHJldCA9IG9h
X3RjNl9wZXJmb3JtX2N0cmwodGM2LCBTVEFUVVMwLCAmcmVndmFsLCAxLCBmYWxzZSwgZmFsc2Up
Ow0KPiAgICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+IA0KPiAg
ICAgICAvKiBDaGVjayBmb3IgcmVzZXQgY29tcGxldGUgaW50ZXJydXB0IHN0YXR1cyAqLw0KPiAg
ICAgICBpZiAocmVndmFsICYgUkVTRVQpIHsNCj4gICAgICAgICAgICAgICByZWd2YWwgPSBSRVNF
VEM7DQo+IA0KPiB3aGVyZSBSRVNFVCBpcyBhIHZhbGlkIHJlZ2lzdGVyIG5hbWUsIGJ1dCBub3Qg
YSBiaXQuIE9yIHNheToNCj4gDQo+ICAgICAgIHJldCA9IG9hX3RjNl9wZXJmb3JtX2N0cmwodGM2
LCBTVEFUVVMwLCAmcmVndmFsLCAxLCBmYWxzZSwgZmFsc2UpOw0KPiAgICAgICBpZiAocmV0KQ0K
PiAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+IA0KPiAgICAgICAvKiBDaGVjayBmb3IgcmVz
ZXQgY29tcGxldGUgaW50ZXJydXB0IHN0YXR1cyAqLw0KPiAgICAgICBpZiAocmVndmFsICYgU1dS
RVNFVCkgew0KPiAgICAgICAgICAgICAgIHJlZ3ZhbCA9IFNUQVRVUzBfOw0KPiANCj4gd2hlcmUg
U1dSRVNFVCBpcyBhIHZhbGlkIGJpdCwgYnV0IG5vdCBmb3IgU1RBVFVTMC4NCj4gDQo+IEkndmUg
bWFkZSBzaWxseSBtaXN0YWtlcyBsaWtlIHRoaXMsIGFuZCBsZWFybnQgdGhhdCBnb29kIG5hbWlu
ZyBoZWxwcw0KPiB0byBhdm9pZCBpdC4NCk9rLCB0aGFua3MgZm9yIHRoZSBkZXRhaWxlZCBleHBs
YW5hdGlvbi4NCg0KQmVzdCBSZWdhcmRzLA0KUGFydGhpYmFuIFYNCg0KPiANCj4gICAgICAgQW5k
cmV3DQoNCg==
