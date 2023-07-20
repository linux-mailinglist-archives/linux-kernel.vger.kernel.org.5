Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5D575B040
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGTNkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGTNkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:40:32 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1251C198D;
        Thu, 20 Jul 2023 06:40:26 -0700 (PDT)
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K9ZjFb023708;
        Thu, 20 Jul 2023 13:40:07 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3rxknwky2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 13:40:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgQV8hOXoIccUqAXDCjX86B6HY/HF4lgoYZOtoxW3A6pppXxh4Vt2nzC/aPC/NbOEGlEPXpHcMMygD0P0CkPkTLRQf99sLvmRSi+OJBA3yDU1DBkAKFa0AQExY5DYXT4g2xEcr3z6jn5sOvJnLjiPSOqXoL9W5XHSI3gKmVTih5bgReLfQx+87HRLMwbepLDQZ+E1X1r9aTbzmmU5lTMu7RZ9FDo+Cm3jObFwWrUoNr/gwc+ocMcZSXMw67CMeVvnkmsr/+LIEO5761Omcnhxr21m802AF1CmcLEGgjo3Wtm9K7OIx8PkjneYAIGsJ+qekmN4hFEO9QRtdYqZtsKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUnnBVxL7G2pB1IcHwPl76htaJXzOc+k9ojl4zbvCF8=;
 b=a+ahu0IVW4rGuRp9LnTDUwFTbCB2UAcIlFMWVd19OQfjnfItYiyiGuDPsIoV0YxXS13GMuLazDtrud0C4PXh9cpDVopQwl7l8vLTLh+UTwcVBjUvouP8OVDZhBQD9Yj75Q1KKz+IONV8Gd1sph+c0TcY9j17XMoEkMep9Z3KnG71eJ7MxTKRLzHrd6+qiwed+ZPPYCoKGx4cn87fXlKB0MeFcH+pLpId7rS/qQWx3A+/D96icQaobvZap1jpKsZAwilKzICaVe0dW/CcTtJS7kbFvLGiGHh2HPuZgCkwGsvDqTMT9K1delmG8n7E2DOrbVysN4ZRDyyQg8rfI14LNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUnnBVxL7G2pB1IcHwPl76htaJXzOc+k9ojl4zbvCF8=;
 b=JLBU4wpCwvNxSdXHf5au3cD2cyCz/b1aRZHD2RTW1hx2zMSOEAPBV3Qd6Hx4qPzZiQ6gyPOUb9qBgOsvLyaK9nJpoEF1iCmsV4IYLuw6QBV7xr/XtTprffyMGrL6j6/2CmG/+icGZQIOOZncFkYuGXIUv8lh3tw5z7rgZ89ymwHco/deMAMT1RprL3k7bE9IhWZp36QKsBDoszVDu2Sv5a5KqbFQCFO3vDZ8N+JI7dpDikqqLnIHRQCOZ7T02OwJJFSArcMrYtYU1S8usShVa9yhliR+c8KI2MhXQgJL5ttS9KFJI+7goHIV7egF8oTyfTFgnFU8pjS4Rqh84ts0Gg==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by GV1PR03MB8381.eurprd03.prod.outlook.com (2603:10a6:150:54::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 13:40:03 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::ccb5:5aee:f10d:ab26]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::ccb5:5aee:f10d:ab26%4]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 13:40:03 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Thread-Topic: [PATCH v3 3/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Thread-Index: AQHZmJMWFmItseqHB0qRWKbh+9Pp/K9+8aOAgEPuLAA=
Date:   Thu, 20 Jul 2023 13:40:03 +0000
Message-ID: <87sf9ihfc7.fsf@epam.com>
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
 <43109a0f2f362222fca79e2afd15c46ed9a32977.1686063941.git.oleksii_moisieiev@epam.com>
 <ZIAxLdexyKBnMOmU@surfacebook>
In-Reply-To: <ZIAxLdexyKBnMOmU@surfacebook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|GV1PR03MB8381:EE_
x-ms-office365-filtering-correlation-id: 9b4b8f8a-1742-4487-61fe-08db8926d237
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pH3fmcByLLZIxueMVTgzL56s3v/D22PRhQLJOW2YEOtmUybn4VDeUZlvwJD6EqKGIGtp6uS39MES/U62NDSFwNrb41V3c/aOZxgiGLrQGvSjp7nyU7OT3/8oePIHFl3cU2r1rFSGj9dTB1v+K5H9ye3hyZgHWdsSzhQgKFBjgf+3hAS1ZlvOPBpt96v4aBiSQUpows8JReDnjoIn2X9gdDTuprlhhLT7/iAvxRfzES95Tc+N5yzwvG3NrGyya5kTLdbuL6jjnOd51QolVjctrpqSP2ww04VA4VfdswHOlbLtLLZ++5T1UOUbXi5pFG86w8FESiL2EEVgqFa5I4IqJH+428u9KTGjdjYZIQvy+ylfZt26dk592RuP0cKg3uWODr7khExx/LFJKC8EdZLcheVwUSS6hndmVpjqHTMXJAbObzTQa77nDujmE4mVLSXqvDv1UowuOaPo2DoaQNsEqXTKo3JYrjhHDEUgmJCs8v12ORMhY8Bkug8ffXVNZyj1fi2lDElAouIXgh7xvstosIB70aE16IFXEnweq3XZF8psvpXvARAfzRxonupPWIQAHkWuv1KKw4XUNIM+Fk243jIrMvtbZLVSf/7iSTPBIeZJCdYvqaglsL27qyOyJkvwN5NCcuq9emO5pP9Y0FlUjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(2906002)(83380400001)(2616005)(38070700005)(86362001)(36756003)(122000001)(38100700002)(6916009)(316002)(4326008)(71200400001)(76116006)(66446008)(91956017)(66946007)(64756008)(66556008)(66476007)(26005)(186003)(55236004)(6506007)(41300700001)(478600001)(6512007)(6486002)(54906003)(8936002)(8676002)(7416002)(5660300002)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v/W0LAfuZkQ0Q9wOuFURznfWO+g7ZVBLsmA5vRpFLrmp9NuYj8zt++kLOc?=
 =?iso-8859-1?Q?2gkjf53Et4FRzVMZ19W1yBROD0sOx9jykztG1luxNe3aO4v+fsv6L85xD+?=
 =?iso-8859-1?Q?kaZRaP0ncqN6pCwaZW8bNPfHnujpNmF50vRlAnOnGFt/IbPQhUqWcZZbO9?=
 =?iso-8859-1?Q?FGvMUd0VjxlBKgHnjOJlXpl+C8jAq6KQfWdd2Zq19atPXDRgpXyaoltOki?=
 =?iso-8859-1?Q?nMob8Znju6Z3H/yMlWI2F1ka6pqL0SD9UGdJme3qReECXP9I98LSf6frC4?=
 =?iso-8859-1?Q?O5b2Dl0h3xOLw93PzKEGTGvDO59jZqOB/X33pfI/I6sROAFuNLiso0Vjdm?=
 =?iso-8859-1?Q?Kuvq1UpSPExqXSBNed7tsxSQAmqQ/SaUUBb7e97Am/5kKrDAkdoa7ZVQkO?=
 =?iso-8859-1?Q?A/2zlyMD2QL7VizyfhMF0XNRuS35PNgj2envwgo5LgmZSwZqw2GQRU+rRG?=
 =?iso-8859-1?Q?Fclgf/dfZ0rav9IGUoFxStYDuDILSs1AJel4PdiJzY8WbjuSiSgeDD/Oaj?=
 =?iso-8859-1?Q?TKX7bRcQhL0g8EjOWI4w4Lt7vem/Zar+IrrSamdIvq1ECQGmvPv0vIuw51?=
 =?iso-8859-1?Q?YTll+tEjVmmpMkxmMqhHCqmc/PUmvYeN76GvYQ/lTYBcY3yn5PTVceuT57?=
 =?iso-8859-1?Q?TYXOHw3JdxVCkJdgbNLp4CfpPALoeIfD3Dx3dYqae8Tv7w2yP0L7LXtor5?=
 =?iso-8859-1?Q?NtlOkLEuQIojR2JF4C/Dsqomj4MOWIsvoatl4zBQjHIzCK/a7UaCXQ8ROP?=
 =?iso-8859-1?Q?V8AB/jdG483dvyxKVMQY0pmkfPloofAqMwaEQ9BVEFpSu1ABVVTfMD9k1X?=
 =?iso-8859-1?Q?q7tZrUWAXxh0zGxpbDFX1PqMql5jXxiXV/pmukVI3BnbknhrMWwXiPX0Lh?=
 =?iso-8859-1?Q?RTX/eoNKe6+Vw5jV0znqA44ARvvNRUQX4g3azhPmPl9OdU0J7ou0vi7o8q?=
 =?iso-8859-1?Q?+o0qkMQgnYLjvOj20yj1Pn/OF1Q+phhoNT/s3vrWZCaObLPoCd0PkzewKe?=
 =?iso-8859-1?Q?xKWfN/05U5oUiRxRf69OQ7/PVf9aXfn1ke4Ws1MP/p1B1vGMr6l/U89Hep?=
 =?iso-8859-1?Q?qhvJ0qGkJ7BKnT4ABXqDsC0lXf+FwjH2KYkh69lqbptIxx5BY72KSL5dXf?=
 =?iso-8859-1?Q?gReqzrs00TDlEZh4Rs6TnK5SMMhdaDH4FGJYE4XJ2MSyQjUv4LCS7hUxRQ?=
 =?iso-8859-1?Q?5neWqWK9zj9NJGyJdhlzlJDFD634Iiyx3uFZ4ZiNJnWiIXKCOyf80o2paI?=
 =?iso-8859-1?Q?TQ1P4oDv7s8zlNFDRehlXA8uoPhB0g+D6uc0RN3qXUs0Y9ycnGg0Yl/oA6?=
 =?iso-8859-1?Q?PgmQ3oZ1xvot+r0DabBFhuItElC6kMH8ITx/Kzg887kVv8uv5bP1f7unsH?=
 =?iso-8859-1?Q?hqlj3BmJpVYbgnKQF1XZP8mzQ8Wnqcg0bOFr8p2dW851MlflAgR+pUrk2o?=
 =?iso-8859-1?Q?SXIK7IpJOfWCKTV2Rw7r3jY4Uf3ffkIqy6fchfHVWf4zdtcljIHn7gFzJi?=
 =?iso-8859-1?Q?I55qd66sZJpP0zzjn9LPGoYoOci3geGU1Y1kpHDxjFKFMTBQeqUG5VULvE?=
 =?iso-8859-1?Q?XUYICmzQDnsHRYbd1LR6PqDs0EIXU4xe9fMclqDEeo6hdDDdY1R9MZCaCX?=
 =?iso-8859-1?Q?T8FbrhUm2nSOu17N8lPpibx4uFY5E7j8KOxuAYP5bbYJks8BjSUtVekQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4b8f8a-1742-4487-61fe-08db8926d237
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 13:40:03.1320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AtB1YI0gnslAWas55OCZxW3GFuvwalRavLOULEepXUW0OGrg3Ao2pLY8YH+9eK41dMoyTkqlQTN2OkTUU/TdC5FRUqg1o9yq3NFU/7fJkCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8381
X-Proofpoint-ORIG-GUID: akm6161UO6vh71FCwdshpDHl0EP-BG7A
X-Proofpoint-GUID: akm6161UO6vh71FCwdshpDHl0EP-BG7A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andy,

andy.shevchenko@gmail.com writes:

> Tue, Jun 06, 2023 at 04:22:28PM +0000, Oleksii Moisieiev kirjoitti:
>> scmi-pinctrl driver implements pinctrl driver interface and using
>> SCMI protocol to redirect messages from pinctrl subsystem SDK to
>> SCP firmware, which does the changes in HW.
>>=20
>> This setup expects SCP firmware (or similar system, such as ATF)
>> to be installed on the platform, which implements pinctrl driver
>> for the specific platform.
>>=20
>> SCMI-Pinctrl driver should be configured from the device-tree and uses
>> generic device-tree mappings for the configuration.

[snip]

> ...
>
>> +error:
>
> Labels shoud be self-explanatory, i.e. they should tell what _will_ be wh=
en goto.
>
>> +	devm_kfree(pmx->dev, pmx->functions[selector].groups);
>
> Red Flag. Please, elaborate.
>

Thank you for the review.
I did some research regarding this and now I'm confused. Could you
please explain to me why it's a red flag?
IIUC devm_alloc/free functions are the calls to the resource-managed
alloc/free command, which is bound to the device.
pinctrl-scmi driver does devm_pinctrl_register_and_init which does
devres_alloc and doesn't open devres_group like
scmi_alloc_init_protocol_instance (thanks to Cristian detailed
explanation).

As was mentioned in Documentation/driver-api/driver-model/devres.rst:

```
No matter what, all devres entries are released on driver detach.  On
release, the associated release function is invoked and then the
devres entry is freed.
```

Also there is devm_pinctrl_get call listed in the managed interfaces.

My understanding is that all resources, bound to the particular device
will be freed on driver detach.

Also I found some examples of using devm_alloc/free like from dt_node_to_ma=
p
call in pinctrl-simple.c driver.

I agree that I need to implement .remove callback with proper cleanup,
but why can't I use devm_* here?
Maybe I've misunderstood your point.

--=20
Thanks,
Oleksii=
