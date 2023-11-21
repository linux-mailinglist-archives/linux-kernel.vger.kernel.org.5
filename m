Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E414A7F31D5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbjKUPCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbjKUPCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:02:50 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D1D9A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:02:46 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALAE1fL000455
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:02:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 mime-version : content-type : content-transfer-encoding; s=s2048-2021-q4;
 bh=f3bh1EM01pdAJOCirKUK5UmL9w5jdYumyiGcu+cOP5I=;
 b=HldiKRYaQ5F8ds4lZRCgkyGwJJkGHnPPDcAFNpBcJNNem8PQNmnvubCpi1Vu+v0VL+ub
 oWOBOK0m+bmeOI+P6PU6dxaiIAmsXHciRnSYtfYqd8St1wSEhXyzZogTivjrvhgXt4dV
 plomhybe3DL31MdDID02KuBJxZxIc+v1D4JdlXgizcRHYRMb4QqSo9O+3u3aGMNVIVcE
 EUfQGSzgsx9/uzYzt5BSd8ZqdZXckgnuYWliNPuTY+3aoX5/2eejKT7D2EPV7r9/5dTA
 gjh8HxWog1eEgHrRAfYETnK+RO0l98oVinIREvKxD7DAcp3tdoNEW+LvN1H0xBMb/+zy bg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ugtm720fp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:02:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDyaUYGL8JFoNZbt2BN0eG8Pzy1iUSuXZ1o1biIs9aSHg0Zw0ZfrKXwjD7zlnslQVve6Wsh/Kv8ylP7zk18lznVg9m14veILjnU1196uQ1oK0GsWDTxqGwzJY0JjBxhM5jvKFUdjh9ZISPz123DtogMtsjJ1P/tpWIAFWIykPKjMgJtBdtCJY4pAZt9/Q4iwJ9scHNgFYK4tDQF1yhEZ7VdDA4mQjzprmfzyMr8NXwTMuHuFrxtty8jXhNS1AAooir2HC7xplJGsCfXsr8/EH8Xv3Hbn9/G+cgy62s0G4Hue91P6JVQOJIVpv49477wtG1RJ3R7mDa4MVAFivfTFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuAtWkLNl+3b/dHXdgFTFEi9YOHdd4xBRUY1KmL4O8Q=;
 b=KZRHI0wJV7cPT0tNaGYruC3tftrHHQsy/fWmmn0wY2Uirmy+XeGgsuvJe3q26n7PC9z1a+C+QJQ2DNpbwHb2FlT+mywsnQSM14UiUnqzGLpKgW1fnDPp4T3anO447xRC1lpDO42JJ8U3IO0n1hRJx3Vo5Zx4RKuNT8jsiEdsz71ltBhxTNVAapiy45PnIiE1N7B+gVi50dFvFoalwjBSa58Pvq1TMjW5R+ISLukmnSY9I5/cmLUNJYtX/KrSCztk4xXHQOJhRA5DHBuovVj4iQm4s+ThFrbpbqtPxTILkebeft2lo5Lrbf9JKtPbiJtMP3alPLYqlKChNYd1Hkzltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by SJ0PR15MB4535.namprd15.prod.outlook.com (2603:10b6:a03:378::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 21 Nov
 2023 15:02:39 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::cbea:e86f:62db:9b00]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::cbea:e86f:62db:9b00%3]) with mapi id 15.20.7025.017; Tue, 21 Nov 2023
 15:02:38 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
CC:     Nick Terrell <terrelln@meta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Terrell <terrelln@meta.com>
Subject: Re: [PATCH] zstd: fix g_debuglevel export warning
Thread-Topic: [PATCH] zstd: fix g_debuglevel export warning
Thread-Index: AQHZoGECYFJRnoBdN0Sz99kqw9AI77CF1roA
Date:   Tue, 21 Nov 2023 15:02:38 +0000
Message-ID: <C5610F2F-F115-49F4-851D-A8A2CB669296@meta.com>
References: <20230616144400.172683-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20230616144400.172683-1-ben.dooks@codethink.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|SJ0PR15MB4535:EE_
x-ms-office365-filtering-correlation-id: 1adef0f4-dae3-4d28-8b9f-08dbeaa2e73f
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MLfAnFc8pd6cGZMd5owhZgLwKvwVf5zl+Zj/x1/xNIoJxtgmpHA5t282HdT/Y81bN3+oiTpP1dl3d6HgsD4ztDf7IkRdurta+ESqk23cfSgOD9LslNbcWMtxSDD4WtWCF9nSmAJx9wa/2l5QT0FWm0S/+tU5GZD6CnpcMVVgMvFOfLkrUMyCXZIjdBl0eBI+OXyfUoPxG34wsZMV3dKT9VqgunTuEacjEUmqbrEXd44MtnQ7D/PJlvnH8VWlSZdikoBNi6opNKDURlpiiFwVY3fKiaTj03GjAKGHrH6OsO4vI38Cz8E07j4MJev0V0f6nI7BXHCu87VLuHJJeMrhLi+bL96SMz6YAiLOfLdAR0w2Qycz/vAlN6/f/G/Byzc6qrc8jW60hbMWa+0QCcmGF+l0jti86/JiVkY9d62Sblh6wHkyCYbPLDqn2lS628YcZ8Qpz8jQNSbWK5IujPAmU9+gqATsGGGwhDTNoQUAY1UVQDuSZzYEC35h3b1DK3jjuwAvzLdMf/g5dq7GTuJLWF4EvxYYTxM1OW3zhsTwe1tCpkxhWM4m5KhcGbzaZtgNLC3gGSy4XuL0CeXpfysaP1pzHU6Y/FKYW+aC8VID+TceMqlGgpbrfIRBxcKUgQxaGtdfYPncC9CWLgXo9i0ypBkd1S2B13/9WJZ4GBIokFqg21/YC5U+rxvhwdMbPY1N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(346002)(366004)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6512007)(71200400001)(6506007)(6486002)(122000001)(478600001)(6916009)(26005)(8676002)(8936002)(4326008)(38100700002)(2616005)(66946007)(91956017)(76116006)(66556008)(64756008)(66476007)(66446008)(54906003)(53546011)(83380400001)(107886003)(316002)(5660300002)(2906002)(33656002)(41300700001)(86362001)(36756003)(38070700009)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qy90dEE1Wk9zNFZOdzd3ZnFGRG5zUzNaZEdITVo2NWRUcmpOakZ1eXFROFVD?=
 =?utf-8?B?YTM0V1hCUlN3UC9remlYdVY4aHFHWUY0NHo3MG02R0I1eTNSejNrNUZOUk4z?=
 =?utf-8?B?KzZ2UjhOV3NNRUZEeW00T0U3YVp4TzhIL2NBaVZ6WTJRVXpyemRvTUZYWUMw?=
 =?utf-8?B?U1NSV1p2bERrcmlXNjBiTVVDWnIvRW1NNnR1MWtKb2oxajcwRit3aXk0SFM3?=
 =?utf-8?B?SEkxUnlMbFkxbG0vU252cjdZV1FYbWVvc3ZIdHpOZzF2eFZac1IvNnFNcFRi?=
 =?utf-8?B?YzZWeTJjVWZGV0o5UnVXY01XOHlSM0tlL2hxUE5oak0vZlBWQUJIM1luS1B5?=
 =?utf-8?B?LzA4MjNOQVRBZkZXYmZ5QkNib1Q3S3pNVzZNWTA1d1VYVXJxWVowczFNWUx1?=
 =?utf-8?B?eFRQZStrR1NsSWNPN0pUbDlUT3h0L2ttRWZyMTR5V25kYjZBOTVLK2RRL3dH?=
 =?utf-8?B?cVNDYnhNZGp6Q3VzWDhlZUEwQ1FJakxKWnEySmJyMWxBVnl1SFpvZ1hZM1R1?=
 =?utf-8?B?YXBsMmJxZ0hBdi9rQUNqQ2U4SW4zMTk2V3l4UGY1YlNGVzNOMUhiMys0dlFy?=
 =?utf-8?B?Z3hpN3NoU0ZuNW9ubmx1QUI1b1YrT3MybVFOWnlObkhCcUZpNG1DUjBwblIv?=
 =?utf-8?B?YUVpRzdFWDFuNTdsaEZPL3BMcCs3SmNkQVh0Q2FjcHRSMEw3YWQvVEYyT3F6?=
 =?utf-8?B?NEZWS2ZuTWlWSjNZNWh3eENwS1NCT1grQko5RjRUZDJJZnFiQTV0QlFyVHpr?=
 =?utf-8?B?QThKbFJOT1ArQ2orakY3T0ozQTRLMFNFejd2TEJIWnA4eUpMZGFGVjVxWTJo?=
 =?utf-8?B?TFc4VUVjNDdkRFZ1WlpCYUtjMGpaTTNaVmsxV3gxU3dOdnhSZGIvSlByVWkv?=
 =?utf-8?B?QlZERVpob0dxSW85OTkxbDYraGRFKzF5b052OHpNWVNHNXZFVXFFaEdVbGVr?=
 =?utf-8?B?T1RZaTlCZkZrRTVETDhFN3ZTMVk1bTVONytGdFg3Wm03b0IzQVNQS0RCTUY0?=
 =?utf-8?B?ZHcvdDlHMCs5L2YzZGlqOW9rdjU3UUJNWGlmcENBK3RzT09IR0YyQXFUaTBW?=
 =?utf-8?B?b2pFdGllY1NLb0JZcGtlNnhaTFErQ0pCeGpOYUlDVEQ2a2ZNOGZOS0ZIZTZt?=
 =?utf-8?B?bFB2Qk1XNDB5TTBrOTZIbVl1MENMdCtuamIrdDJ5RVVzVTlZQllZdmJXTGdI?=
 =?utf-8?B?ZFA0S1FsS2hya3F0MCsyYTRkZW52S05iVjhMZ1crYVpjeGg5blh1Zkhud1No?=
 =?utf-8?B?dEY5NkFRTk1EeC95ejMwZEdOQTJUbzE3WEFiekNnaFN5cWZzRTVPQUdlWEpa?=
 =?utf-8?B?UHNCTnV0QjdBSllUMG84SXFjWTZrSTZHd0wvMmgwaS9URG1vSGpTdDcwOXFz?=
 =?utf-8?B?RXkyeTRRaXY1NXNQM3F1TC9sR0U5Y3Q3bllOUVZKQ0dZSE5KRm1yUEJWMmt0?=
 =?utf-8?B?TmlDMHkwSEhYRmpsNHpjWlNncWdNcEpLTmZXdlFnb0VITFV1ZkMrQkc2Q1kr?=
 =?utf-8?B?TlBNZExLN2hVTHlBUmRwMWxHTzR1VzlpUTJCU3BqTEw4eGFsY2VDcDJHUlFL?=
 =?utf-8?B?d1RDbVNGRmUrNTllN1o4dG91TTREQTlXQmxNRnhWMmtnbDNpcTh6a2ZKZTlq?=
 =?utf-8?B?aHk4eW5BZzZpMGIra09Sb3pZSzA5ckZXWVE5NlF3YS8xMTRnSEMxbzZRVGNH?=
 =?utf-8?B?L2Vna2NBeDNqT01GMVlZQmtkdWN4SERrekFPYkdLUHZiamVXL0RJK21nUFBO?=
 =?utf-8?B?aW5TTGRtOSsrbmVGbnlNK2RtVWZZMkFicVVCZGE5LzVLRXVadXZ0Z3FPTlp0?=
 =?utf-8?B?UWU1R3lzSHd4dWF1S0RSVGc4SEpHeThpTDVuSDN4bzZEb1hRaHRCN1NNSlJI?=
 =?utf-8?B?SGNaMXdjeTQwWHIrbkM3cllrVCtIb3FuWmtWc1FEOFhZSU1BV2pqYXI5aU1p?=
 =?utf-8?B?Tjd5NnlSRitNcWZjOVFHVjFvSVI4aU9iTTZ4QkIzUXMrdkZFaEQ0dm1uVnVW?=
 =?utf-8?B?VEZzdW9NTFBiZVVVQldqUW5Wckdzc210b3BGM2xaVFpuZExYaVZYS2xCcHFK?=
 =?utf-8?B?bjRlWGJ4bFNOdW9TT2c4eTZOeUdqRU5JUjIwSkVlbmg4bWJpOExMcTBYRUdO?=
 =?utf-8?Q?PjM6oujgHr85gYdKPMosw0gIk?=
Content-ID: <08DF3C298EBD2041810D612D2F651C2E@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adef0f4-dae3-4d28-8b9f-08dbeaa2e73f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 15:02:38.8270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7q/f9bkQX9Dcj7pDtbQjIvivpwlRbY+WM9W+i+JVTIocKll8FTYZFavraKt3C3+ljpl+NGGKPEbsEInRWRjnmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4535
X-Proofpoint-ORIG-GUID: LYAgKS-n6KsDnOmOIZ-xU3JCYHBerAPW
X-Proofpoint-GUID: LYAgKS-n6KsDnOmOIZ-xU3JCYHBerAPW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_08,2023-11-21_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 16, 2023, at 10:44=E2=80=AFAM, Ben Dooks <ben.dooks@codethink.co.u=
k> wrote:
>=20
> >=20
> The g_debuglevel variable in debug.c is only used when DEBUGLEVEL is
> defined to be above 2. This means by default there's no actual definition
> of this in the headers, so sparse is giving the following warning:
>=20
> lib/zstd/common/debug.c:24:5: warning: symbol 'g_debuglevel' was not decl=
ared. Should it be static?
>=20
> We can use the same check as in the header to remove this if it isn't
> going to be used, silencing the warning and removing a small bit of unused
> data.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Thanks for the patch, I=E2=80=99ve applied it to my tree for v6.8.

Best,
Nick Terrell

> ---
> lib/zstd/common/debug.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/lib/zstd/common/debug.c b/lib/zstd/common/debug.c
> index bb863c9ea616..820520b93d2b 100644
> --- a/lib/zstd/common/debug.c
> +++ b/lib/zstd/common/debug.c
> @@ -21,4 +21,6 @@
>=20
> #include "debug.h"
>=20
> +#if (DEBUGLEVEL>=3D2)
> int g_debuglevel =3D DEBUGLEVEL;
> +#endif
> --=20
> 2.39.2
>=20

