Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5B87C9C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 01:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjJOXVi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 15 Oct 2023 19:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJOXVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 19:21:36 -0400
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1801.securemx.jp [210.130.202.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE239A9;
        Sun, 15 Oct 2023 16:21:34 -0700 (PDT)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1801) id 39FMouak634900; Mon, 16 Oct 2023 07:50:56 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 39FMoS9q1779506; Mon, 16 Oct 2023 07:50:29 +0900
X-Iguazu-Qid: 2yAbn6s0GZ3E7cqpM0
X-Iguazu-QSIG: v=2; s=0; t=1697410228; q=2yAbn6s0GZ3E7cqpM0; m=nv43srUfvixbPAZsBANMrJNL3Y/yk/ZyK6tJU6Wv3tA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1801) id 39FMoQrH1898351
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 16 Oct 2023 07:50:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2QuTO4Uog/Zb6mg4iSMO0y0FfU+w/+o+E26U1atOt+CQeiZI+wY2ojLV9UA0EGxZuAXXzr1nJSq0NI1x6g+adACDIrHvkpO8BIC9jPp2Af4KKQo87Bte1suMq/vOO27ioyzO7/StTQeGRtwm10SisbuMrrOGR8ru8KH2lnWvjQEc1cEBE7ixV+/EEDCYbioV5Gy32NGn5xSkTZqNH4877ieMgn8hHrdPRmEkfrUoA4arpezJncsMDLDMtgZMnRetT1BQjPrvppkSXQqmpK7s+v0Dc3PijPXiliJRkP5rFhK+40YjYcVTUZq/P/u8qM+cPRIad3zZ2SsSJdtplETyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JL/ggxVdMHugFO7wYGOT57XnnX8FFo/zrLQmR6iFBX0=;
 b=DYoHNSIDAY4CGKE0EUxBOU/noTEkmxRkevbdpibbBRkZoNL/eAqSTWD2En3l5cdZODNPsejuFecuETW5Y5LRDwm+pD0LdTIbzDEJFBJokZ8iJ31DeJLoPQxydD/XYbxv42qk2+MX4fkI+G6k1y7NpCyuJO4iGOgeDJOh6F8ATRKd5VLIfJ7JEGAx63Wut4XJLoa7f7+hAT+V55OcnnGnvlUpmYXmvNehrfFiL3gmsKVxpKtM5T3N/NCORxXm4rm++GVgdlTHAjUxtLw4ILZPKJfZyK0RAu2ND9DoqFO7BPvGRrEQ5PmbRkJDwVU+QjDj+7uc8FGgyDZwF+shGVv3QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <gustavoars@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <keescook@chromium.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH 2/2][next] clk: visconti: Add bounds-checking coverage for
 struct visconti_pll_provider
Thread-Topic: [PATCH 2/2][next] clk: visconti: Add bounds-checking coverage
 for struct visconti_pll_provider
Thread-Index: AQHZ/LJ2dpVjEBIgOEOHBXIfYO2wnbBLemLg
Date:   Sun, 15 Oct 2023 22:50:25 +0000
X-TSB-HOP2: ON
Message-ID: <TYVPR01MB11245A06AA4A22CE6A1B5676792D0A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <cover.1697076650.git.gustavoars@kernel.org>
 <675633f7ae9893371d35b238f06fd02a3acffebb.1697076650.git.gustavoars@kernel.org>
In-Reply-To: <675633f7ae9893371d35b238f06fd02a3acffebb.1697076650.git.gustavoars@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TY3PR01MB10015:EE_
x-ms-office365-filtering-correlation-id: 65110d56-d330-4edd-9665-08dbcdd11ebb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2tkAWnix0QEO9AkaGxPFLzFhbDzlAE89Ljn8hP8UnNHzqs7u+Fs3fYkGVrb9SSfHwLs1N6vmR+IgAr5yge7rUzBEApmx7nu5YsGLemqQPUXMbAoa8x1bDwKtbS0DYAfGNkd6pznn2N3GF0lOG+H78IDEKXzKgIWgo0zF1xSj7YCyO4HLeASK7HHIQkdrl2tt+ZDSsHQCvJG0y7SL/GQnVbBs4ajkTTIT5W/LrtpWppwswk8GwBa5KD7k4AYEFaf1fT653wX7iO8wqON6xOlaUVTmWu0sjo32HAWLZ//hfvV00VOtdodM1NzVHnlTKB77aOQ1sW9z4pvvc2R0EncmZSpWek8ezb/53OFZJqxtRht8wH3V4zjoRmMKW2EI8J6K0eFVo6yt9A+WEIPiRtl7WXostPU3iH45YREuRgkclOX0FxfhjeDbUlnRd6h9cBL8odNPQ7N/fVfqQb9IkytcGdOwRx5olU8fDwGxRd8vpibfqkwNoyeCUzG9PMnocdBu2mgO+u8BLma4HaKHhFWvmSidUiPLq5M7hvLc0BQTu4bAsfUFTT2GkvsGfYvI0BeqYAkPethJ0GRAbTRUVYRNDrw9aAtx6qd7YpW/aiyNYxFmd06SI4j8edKoMNc7Uru8zIryfdeHie19+bUu6//GRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(396003)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(478600001)(316002)(110136005)(66556008)(41300700001)(66446008)(8936002)(8676002)(4326008)(76116006)(66946007)(66476007)(54906003)(64756008)(55236004)(5660300002)(71200400001)(52536014)(6506007)(7696005)(53546011)(55016003)(122000001)(38100700002)(38070700005)(86362001)(9686003)(26005)(83380400001)(2906002)(33656002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?V1VFL1hNZnpXVlB4MnMrcWZKK1VCVXAzV005VXo4U2ttQ04yOTlVSFI2?=
 =?iso-2022-jp?B?dlhyWFpvNEdidXB1VWJqa3h4ejJCSHB5YXVqUjRYd1lEL3h6TitIMERQ?=
 =?iso-2022-jp?B?bVkzcFVrVGZyWFA3TTh0bitVeHdkWmdISkYrTXJjM205Y1NOcGZaWW5i?=
 =?iso-2022-jp?B?MzVNVlY5dy9iSDFyZ1cxaCtYQzFWTjJJTjNMOXlVQ2YydHJ1TmdEVlFL?=
 =?iso-2022-jp?B?SWdSZ0NDVTJPeFRnenA4cmVtTzA5L1BoL20vQUJqdERwWEZ0em1aUTlN?=
 =?iso-2022-jp?B?QlJ1bmx3SmpyMTg4MUVJb3Z5QkFvS1lLQTU0VmtidWp2NEdpTUNkS3JD?=
 =?iso-2022-jp?B?aW4rZVB4KzZPczBJZ2JheGVCZlh3UkREOTRRVFFNOEJON2dhbkNsRVlt?=
 =?iso-2022-jp?B?cGYzTHozajBGYmZKWGtsSHJJMHFLZDltRTVPc1p4Unp2OWFWNTF4T1BJ?=
 =?iso-2022-jp?B?b25sOVEwRXA2MjMyM3RwaE9XZmRCQUk1a3JPdVZzMUplSy80dk9KeVNO?=
 =?iso-2022-jp?B?OTYyV1VKVzNsVHJ4VzYvelJmS3BIUU4xMTFkTnRYYkd4eEJFVDRPWHd6?=
 =?iso-2022-jp?B?N2c0OUI3a1d0bjFNaXQ1UmhxQllPSGNSN1JFQm42dlB1anJSY1hZa0dr?=
 =?iso-2022-jp?B?ZmFFSTl5K3VmRGppTjV1SHpwK3BqY1B3VXBlOGdWT2NSYi8vS3V6d29z?=
 =?iso-2022-jp?B?VWNBd3pudEZWUWJkRmtiLzRNZUZGaVU3LzBpTUU0bDVWZGNlMkttalpm?=
 =?iso-2022-jp?B?WkVqODc2Rkc4S1k3cXRuc2RzUXIyZ0txYnovWk0ra2w5MVpjLzN2emFy?=
 =?iso-2022-jp?B?WVVlbk5jZDZiQWhyU3g5ZXJFaGZ1Ynp6TW9QQVBaYmlHRm16dE5CMjdP?=
 =?iso-2022-jp?B?M05yM29iUGJ0NWFTZExPeHY3bWxEVitkb0h6Y2FkZEFubXNsbDZIM1NL?=
 =?iso-2022-jp?B?NjlaVW5VN3VicUZCM3dhbGNMNjRsbWJIL1NLdXd4SGdiUGdqb0hlZ2dZ?=
 =?iso-2022-jp?B?YTVnNE10Ri9GYWNwYTlpMWQyWHgxa2toTi9KTU5FNC9SZy93Ymg2STY5?=
 =?iso-2022-jp?B?MW5lbFhRMGgwTThSa2prTFBKYThxR0h2YmVRaFA2eGZldEhiYWs0c2FI?=
 =?iso-2022-jp?B?bHJSd2NaQnVSTDFBVS9LdWdLd0ppcGZhaWlETjVZMEhtRld3YU14cTls?=
 =?iso-2022-jp?B?RGh0cFh2RjNteUhKQ2Zhb0pHMzlRMmI5U2ZFaU1FZ2RnQW5JZGg4KzRn?=
 =?iso-2022-jp?B?cEFOQnc1Q3dKSEhOanpxVlVOWmc2VC8yTXE5eG5KVFlzVlBsNHZRT3NH?=
 =?iso-2022-jp?B?V1lEYjNMMmNXbmt3NFpsZW1ENUNXWXl3VUVzbWpPSVdrOHUySWwwbEoy?=
 =?iso-2022-jp?B?NFZ4dWY5RVA1NURHSXg1akpKM1dsSlVSYXk2Qlk2QUZDR29HWFM1R2o3?=
 =?iso-2022-jp?B?NlJ4ak5CellIbUdUM1VZQ01RMWVtRnBVWFA5NmpQTVpUWk1NUWpHU0hm?=
 =?iso-2022-jp?B?OWtsWnJCWWpwWHRqamNqTTV5WG0zSGZiUXRDVkxWeGExRzNZakV6eGxi?=
 =?iso-2022-jp?B?diswQUtIc0dldzZKVVBzbzFPbm5LOXNHVW8xWWhnYXBPSzg4cEFFQlI2?=
 =?iso-2022-jp?B?MUZ2cTJNMXVLSnlGSjIvNzQ4WnFvSHNrbDRSalE0Rlc2ZEdacHFOTjhk?=
 =?iso-2022-jp?B?TWpIclVXQlBxbUZqamlOTHVqeVhub3dUU0NwN1VhZjg2Rm5lM3FaQitz?=
 =?iso-2022-jp?B?eEJJSG1CSndxUXVxdCtETTFweVAwakMzZ1dIdUFEWTVrZ0V5TVZVTkhw?=
 =?iso-2022-jp?B?dnNhcHpCcnBFSnVUOFNJWk9tVVA5bVZRcE1ibkNNY1ltemFsem9CRDAy?=
 =?iso-2022-jp?B?NkhDZTR3SDJmdlpuQ0t5Q3hvL2prYlNOdU1xTXg5TUEvZDVYYW5GKzU3?=
 =?iso-2022-jp?B?NlF0anR1aXdtTFdWMHlWZFdQWFpiWFowNnJoUGxVVDloczVLYTRoWWV6?=
 =?iso-2022-jp?B?L3RhT00xN1ZGMDMycmYzbnY0OStQdnkxVUVtSENlZFU3d0hDeUpidDlv?=
 =?iso-2022-jp?B?T3g1ZWt1ajFJRnUvNUllOTFaWlN1TC9FaVU5ZWRFa0tyR0JaRUphT1B3?=
 =?iso-2022-jp?B?bUhtZWlCbzQ4QjdPZGpHM24xTEQveGlQVG92TjdaRFl3TUFlUHdINWtY?=
 =?iso-2022-jp?B?dFUrQW5VUHlGQkZxcGNJWlJkMFJiUGpMRUlISkZsSzRTRVRBZ1ZGSDd6?=
 =?iso-2022-jp?B?NkJoWm42YUpvUUF4RmF4SVZabnpCR3F1YVBscTR0UmM3MEI0MzBvWWJk?=
 =?iso-2022-jp?B?ZHl3MjBsNFV4ODdHdkZmalpuQVRsUU9TMHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65110d56-d330-4edd-9665-08dbcdd11ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2023 22:50:25.0447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mdCyyMhvKAE2qiZGg8Fx06ryprnLE4fdCZwSnkHpt/O9L2/S1n8hMr4aXi41zChvxo3Wx2Y2tr9qOUcR++evDuNT0CfpTY1L71R+BBaFHwNkfjB/0Eu3094QDf7K1EBR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10015
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo A. R. Silva,

Thanks for your patch!

> -----Original Message-----
> From: Gustavo A. R. Silva <gustavoars@kernel.org>
> Sent: Thursday, October 12, 2023 11:19 AM
> To: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@kernel.org>; iwamatsu nobuhiro(岩松 信洋 ○ＤＩＴＣ□ＤＩＴ○Ｏ
> ＳＴ) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: Kees Cook <keescook@chromium.org>; linux-clk@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Gustavo A.
> R. Silva <gustavoars@kernel.org>; linux-hardening@vger.kernel.org
> Subject: [PATCH 2/2][next] clk: visconti: Add bounds-checking coverage for
> struct visconti_pll_provider
> 
> In order to gain the bounds-checking coverage that __counted_by provides to
> flexible-array members at run-time via CONFIG_UBSAN_BOUNDS (for array
> indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions), we must make sure that the counter member, in this particular case
> `num`, is updated before the first access to the flex-array member, in this
> particular case array `hws`. See below:
> 
> commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
> __counted_by") introduced `__counted_by` for `struct clk_hw_onecell_data`
> together with changes to relocate some of assignments of counter `num`
> before `hws` is accessed:
> 
> include/linux/clk-provider.h:
> 1380 struct clk_hw_onecell_data {
> 1381         unsigned int num;
> 1382         struct clk_hw *hws[] __counted_by(num);
> 1383 };
> 
> However, this structure is used as a member in other structs, in this case in
> `struct visconti_pll_provider`:
> 
> drivers/clk/visconti/pll.h:
>  16 struct visconti_pll_provider {
>  17         void __iomem *reg_base;
>  18         struct device_node *node;
>  19
>  20         /* Must be last */
>  21         struct clk_hw_onecell_data clk_data;
>  22 };
> 
> Hence, we need to move the assignments to `ctx->clk_data.num` after
> allocation for `struct visconti_pll_provider` and before accessing the flexible
> array `ctx->clk_data.hws`. And, as assignments for all members in `struct
> visconti_pll_provider` are originally adjacent to each other, relocate all
> assignments together, so we don't split up `ctx->clk_data.hws = nr_plls` from
> the rest. :)
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro

