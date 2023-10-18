Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA847CEA2F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjJRVoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjJRVom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:44:42 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD11FE;
        Wed, 18 Oct 2023 14:44:40 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39IKNlpP004867;
        Wed, 18 Oct 2023 16:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-id:content-transfer-encoding:mime-version;
         s=PODMain02222019; bh=wxzOFJfVkumZPj/hJ6ifd6B2jXmtxzbOcm0Sd0thg
        Dk=; b=QmwkAfFxYrSzht9w2ngLdmMdCaRZ6lE+zc105gnELRVZ+YviC6nBULKkE
        Mj4yDH2IdJv3HT7ij7wvLT+llltzJr7PYrbDlr9bBT397FEl0A30BekPsZ27pTXR
        DsM8PfXOvPkmopYBOlqTSlqfMqobwauEfVTTL/kFKQXz6ow0fZfMAeFXht73k00S
        Y/B/XNcU0KF/dvr/bHN9X0AC/0Fk0+BYWlioA+i//Ql/39wV2UUfnu63xFy0cW3u
        3B9xdJvUSRHek8V9l1ePDiT915NL3ePh/iW2Ms/n2PhbLHNRcqVBWaWPQUAM9tPs
        E4Bn7JLG2En41lqoOR/T16tfNNEzw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3tqrcw6ybu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 16:44:34 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzlE7O4Q9jNByKtYKPX4Yi3rzjc4R+BFsgbBn6NEK1zKNks+/tCMQXZTW2dHXPsbbhaHG8hBNMnWyDTS+Uc5s5aY11RUnqMCqisurBsNKuZ69H8664WxN1IOi9Hksf3RJvezzYcx+OO+QidYI6q5/R4240n5hoqgixQOHTXzaTJsjJqz/GW95AtbqNY2iEQJ22kESNPWjVcfWrCLWhhWg7QMXst2Qal3+6Is+UtyHINvBiD6EOtnagSSKZEDfsTVwpsswQjByZpcnFF1DUo3iNvwnLc4ZoliXfWbJ1QQKEQ+6bRYbsv7ohAOH7zJUp84N9bS+/Z2/u4Qi/Y9e4Nblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxzOFJfVkumZPj/hJ6ifd6B2jXmtxzbOcm0Sd0thgDk=;
 b=YpIPuMZJSpXmOwd1Bd+PENdUQh82BpTzL9wfasm0t5Xyxj4kp6xz+PHwCZY0C0Xt4hk/zobF/cu/n++JKmnUkrAI3y+rfn6aRwk35sCOfh0Q4vLb5bUExAF9TWsVMLkat1C6vu19UMAB+NnVmeZKAj8Swyw9HLfIml6NeMTBfgq4jSOzT7pZjN85+czDbQ7jWvei6EwATPgdBq5IVe5p0YGiKU+PMfwkiikUsYbzegAnbflK2XcB6jn7tCEqJuCtGM70qYmDs3f7g9JdD8bdDra8/foR4fCqojhAgf9HIzjJ5m58v083kF+p8sr72v68nt8Ga7uFMU/++5tsN+m7cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxzOFJfVkumZPj/hJ6ifd6B2jXmtxzbOcm0Sd0thgDk=;
 b=HuVk773MzmYj+k7zp4Nw2ASWS6xAxjUpbFqvciKMVNtPJ875lL64rm2uegzWZejl26om4eKdE9Epn9A+5XoNG7ib8e/8VAYzIiWp4xoVezKceLzi7P5iOZbfmexYCaE+oYznu5iRR/JNmC/q8CeThDWLATIXsHkzx1mScWwm9HY=
Received: from BN8PR19MB3057.namprd19.prod.outlook.com (2603:10b6:408:95::13)
 by LV2PR19MB5837.namprd19.prod.outlook.com (2603:10b6:408:175::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Wed, 18 Oct
 2023 21:44:30 +0000
Received: from BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::8a74:6925:435d:19a5]) by BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::8a74:6925:435d:19a5%6]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 21:44:27 +0000
From:   James Ogletree <James.Ogletree@cirrus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     James Ogletree <james.ogletree@opensource.cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Fred Treven <Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: input: cirrus,cs40l50: Add initial DT
 binding
Thread-Topic: [PATCH v4 1/4] dt-bindings: input: cirrus,cs40l50: Add initial
 DT binding
Thread-Index: AQHaAeybXKq5Yljy8kunuOewT9MXjbBP7LoAgAAn6AA=
Date:   Wed, 18 Oct 2023 21:44:27 +0000
Message-ID: <E1BF54AA-9573-4CDA-8DBA-42E2F8B05491@cirrus.com>
References: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
 <20231018175726.3879955-2-james.ogletree@opensource.cirrus.com>
 <65cc9c43-e776-41bc-adad-1e57c3b24d7f@linaro.org>
In-Reply-To: <65cc9c43-e776-41bc-adad-1e57c3b24d7f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR19MB3057:EE_|LV2PR19MB5837:EE_
x-ms-office365-filtering-correlation-id: 187b8cfd-213d-4f82-3297-08dbd023671c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WKgCgAItPg6iueXmy9mvajQUdXwp72zchWnNrIE9Tl4++yWVFsd5SKCSew5/v0qvkO9gLzRGDW7yhdf0/Rfgj+qFsJwS/PWWQJKZ0tDXo+XtJaLQMn5um0GJtUGwJI3BGLW/eYVKaXR3PWnbG0FDylOEtyhTQJlY4/CGnqLH/oEDhGl5eBEjziWKxKfTLHM5XueKhW7YG2bI0K/iOtYmc1jmybpzzYnIBAHb+roYORG+k/6AyuMfOIQimSLOi42/oFXptrWBNozoYgH1UWES6JzwtOwMZSYekEJxHZqSmUajs+oAxWrNWxOM9DXvZuwdNrgSCSjO3pPvHhZxFGIr53xgMNokTUbhZw7Cyrlgx/MhdRUKh2n0Jvo/w/JYREZVDLhfTG6M4ld9WC4aAPBNmtIaUawiE6tjwksNSjMRO6ib6MfH0GHllmvOf4qHVYeOgoL2i6om8HLqVrt13zPj2nUhF6roTBJCex+HcxbfE6qIX8V+j2+2bOaMWcrj9mmMD8WAvrCox3t1DSsuhRaeYA1yA4xp7k/cCq5r5Da8CU2P5AMOijNW19I7LUwaE0x03UtiJeCHkZFhA47BCRDKS0B0yhfivzPOccEJjrfvawcuP8JQQL1LbQur/B4Xd079eltx7FmyNv4HpIq/ZXvJMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR19MB3057.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39850400004)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(36756003)(33656002)(66476007)(41300700001)(66556008)(5660300002)(4326008)(91956017)(6916009)(8676002)(64756008)(54906003)(2906002)(316002)(83380400001)(66946007)(76116006)(66446008)(6506007)(6512007)(478600001)(53546011)(2616005)(26005)(71200400001)(6486002)(8936002)(966005)(38070700005)(122000001)(38100700002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bqRiNFfr0xRHfpyDzhuUF9tCvUVPaAPj2YdxY8sqltsW7lc4TbTzx9AaxH8L?=
 =?us-ascii?Q?8eFF655geXYcABWAhSF+frWoAbQecgcbxKj36U5QXdAQmrgoe8XiNNfAsLtu?=
 =?us-ascii?Q?OUktREdOUjSiRR+lBL8aAGjVi1NUxih63RwfD2Z6S9Zu9ifvscmafu2cMMo/?=
 =?us-ascii?Q?tGqsXynGYThA9iZ2cg9dMG8LuJ5wpRoTGakKj6X3s3i0eScxieAUFWvwNj/7?=
 =?us-ascii?Q?a+QOXjbRowVCRVr3+ZyOTYT61cYSZ+0CtGyZBTBv4DqqCjM4ZyWImHQumO12?=
 =?us-ascii?Q?aegjjKlwqwrGlKoBBtV/5Fj0x15QmadC18GfXCU2DXRtRgU6x5E/YmMeHeRw?=
 =?us-ascii?Q?RCTziU7E2nVSHB5iHg/baUoqyDplmwOOplEq2qbc/iM+vdwnvjhAJuDYkMxS?=
 =?us-ascii?Q?hsFj66uguYC365EsPIsTh7PSPxbEkD5A0vWcgF9CeD3/gEuYuTOSTvY7lIlJ?=
 =?us-ascii?Q?wFklBZ1tG4dQLrNo7XVvqURHxKPetqR2g+lXrym3KlN3hh4qbR8DRcsJRgLi?=
 =?us-ascii?Q?aQ61qRXz1kJlUuHZR+qK0GR2b+UvLB49MW5gwYn3ozPeFXefIPrNTSqPQsmM?=
 =?us-ascii?Q?WfliV++O7Y+IAR6sLuXbSIMQG9LjfsmhxbTRGIBd0QCcud8vbE2jtyRAFrJ2?=
 =?us-ascii?Q?0wR19A3PAREFcrdc5UQwCUlIfeIoylinDRkcqLSb0DvzpoquA0QSbXbO9xcI?=
 =?us-ascii?Q?phPvXRBgwwQ7jMlhdJtUfUT5mhryWco1/dvnjuXIKp3TzB7c99kP3iD1mQ/L?=
 =?us-ascii?Q?cnToPkfsszJhFAo5S1MveNzJub4G7U5epMEqYKeOuNXK+hlioOe8VH3hJZqa?=
 =?us-ascii?Q?2LBrbxlyTdQd1jIpCLuBGoY2pnz+EZIGG+5Tb+2F6GkKPR77/u8+tqLKkxL5?=
 =?us-ascii?Q?7jPRIuHDqsmTHYhJRU728nJkrxdfLD3pC8YjJI6JX+fPDR9/ZXIkmt82cefz?=
 =?us-ascii?Q?ripC77QePXpHB9GTRyFq6mkymGjjoaM6rdRrQ07A9NaPjH2JwasoZQG46ASH?=
 =?us-ascii?Q?FuJFWpholY4JtT4Vc3tu8jaBK3R9SpkT9FDqd++hJFt3y3kSlsDs/3e/LnTd?=
 =?us-ascii?Q?h4sK1g8CBZEr1myQlAfq8lo/tVCK+sLpok3mnElNG9mTwGA21D37zANtwZWC?=
 =?us-ascii?Q?nRfjsqN0bCczkrU1d+x4wa6z5I+ArnKBo5Ax4CWeivdzp+zjiStqRE3mZ082?=
 =?us-ascii?Q?THJA75EvFIOxh7HMkHmCYGnKazcf0ESpm1Wm0rpDNmDuB6LxiVaAUBH+/ynr?=
 =?us-ascii?Q?nMJadVTRtHZ++fPrHX431z1L6bEk+W/O6SMCe6zuqNDNzuv2opTNIDsDqoHO?=
 =?us-ascii?Q?Pg7pKc5fbEDz+awjt0G1t04zZVJU19t3T1aY3YzI9DldkTJyh6TAnvYpcRuX?=
 =?us-ascii?Q?hygU4yEg3rOOflyl77uGmGn78341s6hkCYeFkxEk8e1oDd6ynW5gjMNU9kPe?=
 =?us-ascii?Q?ikjW5KcrMDkXa//16th3jRVuNPzIp9gsTPNMsZLO8CoA6zkOuCy7DbuJfH4l?=
 =?us-ascii?Q?fLKOKuspWciq3O5M9gkcw4l6dI8ZYJDlei3sCDlfdednZGN/ziV4LwCa+f+L?=
 =?us-ascii?Q?uONeQDnS3AsuCx5UMLYo6OPwqrhgVmh4bw9E0uCkB1oh9efT8/L7E85nJ/Ja?=
 =?us-ascii?Q?zQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98420FC96FB36A44AADF593CDBD489AB@namprd19.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR19MB3057.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187b8cfd-213d-4f82-3297-08dbd023671c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 21:44:27.4876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m4AfkoOpWtMjs+ryzCg3MKNEeksKWqK2mpNexVIaPvJLCixdH2KfYuOPWcUMK8fEZeD5PSyuUg24iUdCXRCa/Tle81c8NVgr9sBAsBnMEuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB5837
X-Proofpoint-GUID: 7yvK5X1nk3VedVxlfg-hJSWJsUj3CkqY
X-Proofpoint-ORIG-GUID: 7yvK5X1nk3VedVxlfg-hJSWJsUj3CkqY
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 18, 2023, at 2:21 PM, Krzysztof Kozlowski <krzysztof.kozlowski@lin=
aro.org> wrote:
>=20
> On 18/10/2023 19:57, James Ogletree wrote:
>> From: James Ogletree <james.ogletree@cirrus.com>
>>=20
>> The CS40L50 is a haptic driver with waveform memory,
>> integrated DSP, and closed-loop algorithms.
>>=20
>> Add a YAML DT binding document for this device.
>>=20
>=20
> This is a friendly reminder during the review process.
>=20
> It looks like you received a tag and forgot to add it.
>=20
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
>=20
> https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.5-rc3/sou=
rce/Documentation/process/submitting-patches.rst*L577__;Iw!!DQ3KfwI!1EWk9UB=
nRfBQy30s9CXXIfiyzRiXLDvIiZsri22s9tJuRYN-X0PHPgMwZsqkKEq2hSBTrsP1Rj0hTWa4ws=
8u42Em84kK3mI$=20
>=20
> If a tag was not added on purpose, please state why and what changed.
>=20
> Best regards,
> Krzysztof

Noted for the future. This was an accidental leave-out.

Best,
James

