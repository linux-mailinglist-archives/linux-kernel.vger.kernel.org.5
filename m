Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57B57C9C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 01:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjJOXUp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 15 Oct 2023 19:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJOXUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 19:20:43 -0400
X-Greylist: delayed 1830 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 Oct 2023 16:20:40 PDT
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1122.securemx.jp [210.130.202.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2247AC5;
        Sun, 15 Oct 2023 16:20:39 -0700 (PDT)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1122) id 39FMoAqJ1035729; Mon, 16 Oct 2023 07:50:10 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 39FMndfh3802245; Mon, 16 Oct 2023 07:49:40 +0900
X-Iguazu-Qid: 2rWh9TRRTaNZMT9u8g
X-Iguazu-QSIG: v=2; s=0; t=1697410179; q=2rWh9TRRTaNZMT9u8g; m=rxjg5/rHVFP8yMXDDcqMHONH17IXrdIhaTGQb2qk9Bo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1122) id 39FMnaBO1723630
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 16 Oct 2023 07:49:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFD1qvT/ciRlpXGeaLFpDdr9DVlkXmnj1mtXVJIQxqvUswaawA6MHk8lqESyTnCmI6xoLNiBd0G9Rh6YQ08Ny5Kv2HKeX6UsB3gy5SGXJAdOaTvQtBPZFW7Nm/LCJ2AwhCIjaH5VJtnJyFYEnFQYC5fDgboav7AicFUjg8E21uyarUPuf4n4QAVNO7Oy7OwUsCIXmpBlkqL5hvLcs2z6UIRap6hRpMcoxF7PqAzjr078mW2K19soTKxBpbrVSB290dLuVcbDOikMdb7cyF3jeqqrNT7xu9N75lmV84OGe+2+/a396QoRzyUq3mzM5Bkly0YdJzFEwMLq6IQuxzUSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vy8JyURHZZBZUz9ePdwlh5+VnUnhhj6XNaaatgRQ9Gk=;
 b=mYMDG+eBmMyW3gHNDI7JpM6O1Mnyv531O43otgXStmuITX3Tj/6u3Sb+7DmRp39EMdcjKXTKKqi0JRmP/rbueMwqNukuBPL40sidbni3rjDbptQtIzkf/zgrybeUS68s2lvmmYByZ4WbZ7Q85JISjwEcILyYRZg75zFAIarLAh9XJQKJUu6d+mruYCt4lcg1nllLFLDYvtwx2L3c1BmP5uR8LFGZrJ7PFCtS8urXK2i8ryy1l966ZWS0+Ux4J5OgumFArqBFpwOBtkmtz97M01sNi9YTwAuMOMHGqax1pfbVcTd7dSbh37hb959e8XeHlHjoXOGnlqkIBWdzOi4RCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <gustavoars@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <keescook@chromium.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH 1/2][next] clk: visconti: Fix undefined behavior bug in
 struct visconti_pll_provider
Thread-Topic: [PATCH 1/2][next] clk: visconti: Fix undefined behavior bug in
 struct visconti_pll_provider
Thread-Index: AQHZ/LJNyQMz8Qp5hUqym6eH9mB9QrBLegCA
Date:   Sun, 15 Oct 2023 22:49:34 +0000
X-TSB-HOP2: ON
Message-ID: <TYVPR01MB112454C37D7A41F76CB84B0AA92D0A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <cover.1697076650.git.gustavoars@kernel.org>
 <0a59a721d54b557076cc94eabeb694d463773204.1697076650.git.gustavoars@kernel.org>
In-Reply-To: <0a59a721d54b557076cc94eabeb694d463773204.1697076650.git.gustavoars@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TY3PR01MB10015:EE_
x-ms-office365-filtering-correlation-id: d1136a38-2dd7-4e22-726d-08dbcdd10065
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xnTeirAG2Yy0fu7SQGDlfGzpBwveDWzAn0wuhk8mfbmXs7Vy6CyJ0PA+rDI31y63+TvOYwduo5FuGJD+xFwOz4YxfEpzQiW52Zip2DoLJt680+mVP7rlNUQHyoi6miCLonxJsNuYzO91NtaZ8FE3GL4cs1pyYZAN4PyE5IvchprGdTWEWXWI4VWadkabcgfCb64iywwFsiNS8T5UUoUgndzZIMccqq0G4rG7RSEFRPbehJvnaIVGJqLizRrngLZRU3h4PdAuTadN2lAhyUPi72uM0/kq7qTG0ILsnFo/xhiRiP+YWBf24J74+OUa5EJu2ufAWskJQLBOnQotK1kIhv0r3u4/UrWwnzoPBGa76WmLfjjKyJp689PI4S+Lu/PWHN+MMqtbl2sFdUq+sS2f99g8DqNXExJerISqpsmZocytbSSvhjLGt5g3zhOH0/X4Gtn4zbjtQs13MTOTfWzg6AfzTwBpyzPKUDVPTtz13EWHvEpEB65XvqRFl3ScmhQ1VyEsf+ZQ3ySmSwE8JHAGxlRhosYr0Yeac46r8KcDEu+1NJ1mtrfogbdVmI8EjuhJ66wH19sBpbPNXT2thAcmq4fDrnG/26cX4Qr9nMdfl6dREuIzlgIqwYxnxyg9qCYPbVWWspou3aLJgWYR3WWbPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(396003)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(478600001)(316002)(110136005)(66556008)(41300700001)(66446008)(8936002)(8676002)(4326008)(76116006)(66946007)(66476007)(54906003)(64756008)(55236004)(5660300002)(71200400001)(52536014)(6506007)(7696005)(53546011)(55016003)(122000001)(38100700002)(38070700005)(86362001)(9686003)(26005)(83380400001)(2906002)(33656002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?a1NXTXBsSHp2OXZKVlZVeWttOFBJRUI0bXZSTGRXeTg5N0NHYlJITFpS?=
 =?iso-2022-jp?B?R0VnZVc5azZoT2lSamdYSUZvM1pIdUF3TFRMb05Oc0RlMXQyOUtOb2cv?=
 =?iso-2022-jp?B?NUZ3bDVWRStWYU5XcnI0cFFRaDVlVmt0b0pTWDRlN2pwRDJrS1NZVGs5?=
 =?iso-2022-jp?B?QjBMTVNBNUltK05NQWFLWDVqeVJmYklIdWxuMlFrZVdQUk5WaE54NC9o?=
 =?iso-2022-jp?B?SDU4dmRMRWs5V1JGMk9FSlVPcW1YRk1FRkRkWExmend5SzltemlPbnBM?=
 =?iso-2022-jp?B?OHpBSmx0aW1rZ0dIWmJrK2YzNG9mNlpCc0tCTnl4bzd2KzhXUkJCaWlD?=
 =?iso-2022-jp?B?cHV0Zmk4RHRjNXR3YlZyUTBQRGdWSlJXdmxJUWtLMXZPeWZIZXVtUEVR?=
 =?iso-2022-jp?B?ckVMWTZPaWJZNXRoRFZQRG5YREtLMkRUaktEZmdYeUMxdk9aVFQxQUNS?=
 =?iso-2022-jp?B?T25oRVo3eDdQbmNEZmlTVzZlbDRqQXd6cGpHMkMrWWM2L2w4UmgrRWhZ?=
 =?iso-2022-jp?B?MklYanAyUlMwdSs1dEwwcDFEcXMzVE9ibFJnZ0pUSnJRU2wwMmdKUVNm?=
 =?iso-2022-jp?B?YXUvdURUeHpHRFlwY0xsZytURzJ2MndYekhWVDQ4NHVNYXRBdzZaTFcz?=
 =?iso-2022-jp?B?ZmhleXJya0RtMlFxWkNYa2UxKzZob3ZlRmh0bVNGNjRNei9sZlBIRzZj?=
 =?iso-2022-jp?B?eW9qMVYzNkthZmVQNU1uaFVCYjl5L2pRbWVjYlpSelRrdU9USGhFOFBt?=
 =?iso-2022-jp?B?U2lvd1pNdW1IclF4TFM2aktSUGE4VHk4VWxzV05zZTJLQmN6ekc5bmtx?=
 =?iso-2022-jp?B?ODFwbE1oVzFBNW91eFMwTnN1WFd1UExHMVduMnpHelpyOXRXYnhvWHF0?=
 =?iso-2022-jp?B?b3MzUHZ3M2RIQkZFcTNBUTQ1YnZkMFkzVUk2VEdKTzZXTVF0Zk5OTjlY?=
 =?iso-2022-jp?B?WlJoZEl2RVR0aWtSVUplTmlzNndoblFKWEtmK2ZnaUtnV0tFRzlwVnRE?=
 =?iso-2022-jp?B?aDByQmpzNUtyaHBCVVl3eHRWeER4RlM5eGw0VnJkWW1yS3NQZU5QbzJH?=
 =?iso-2022-jp?B?TWZkQWtTQTM1dXdxSmV5TDMweWVEZFN3ZFZoWnJrRTd1STJsZ29rbUlJ?=
 =?iso-2022-jp?B?MUdrT2ltRldjSnlWOVVqTTFRZFFlSzY3SnFzUXFzeTMyM0RZa3BOYlpo?=
 =?iso-2022-jp?B?bHR4UnJESHNROUM3c1NSQjlhNVlCNk5jb2MwblFGLzloUnBBU1VndkJm?=
 =?iso-2022-jp?B?Y2JVUWwyZUNHMzhMSytNT2VXQkZsZE0xQlk5UitIa1Rqam1nazZOZmJF?=
 =?iso-2022-jp?B?dFlwTlNVSERFa3JTU2FNYVpuQk8zK3FEc3RKRXBFZVJJeXE1YXRJZUFG?=
 =?iso-2022-jp?B?M2RNVG5HeFEzZEZ4UVNKTGZDbHZFYU9pMC85TXBEaStCRXJsTWJZby9S?=
 =?iso-2022-jp?B?bGl5dW1zWXNwcXUzYUU1dDhDUDZPTzlJbmQ4N1FUWitia0JLMUlKMWhl?=
 =?iso-2022-jp?B?RVcwazFiTFlIaWcrcEFzeUlpWGM0bUhqd1hLeExkRUhSNFpRK0h4Rm4w?=
 =?iso-2022-jp?B?SWJsTmVnRkNkK0JmVzJWSEdHM05QUERCN1h2M01sYmJGYTAzcGIyczlJ?=
 =?iso-2022-jp?B?akxtcFhGZUR4d1VvdXNWYXpVT255NFBOR0paN2FDNU9SVlVTVTNxTFdS?=
 =?iso-2022-jp?B?M2dhSUFGa0JBd1J4bEx4ZUhDVGRJcnZBT01OdSswNitIYzhsYjR4UlVn?=
 =?iso-2022-jp?B?djJrdEtlYXdaRlhFWXFHVXJSSkVpUUY0SVhjdkNHcnlUU1pONW8wdlA5?=
 =?iso-2022-jp?B?YUlMTjhFbUxzekowUXhaT0w5MW9TdnA0ajJTN3lxUExRczNFa3RDNlpU?=
 =?iso-2022-jp?B?dUpoM2U4a25XaXJxenpGeUpnYUhuNEVNdEltdmwwSFhKbjhoM3JwVXNR?=
 =?iso-2022-jp?B?ZjhXT0pXclFNYy9XWjRvYzIwdFh0M1cvSGF2MVVxRmJOVGhvSHJMK3VP?=
 =?iso-2022-jp?B?UWd0TmtNOXNrb2FMRDhNV0ExVU02R1JaUFRpVDdmY283cGJSVHltOXhM?=
 =?iso-2022-jp?B?ZTY5N3BzTFRWSndTeUZTZUZTU1hKRldQUklET2V6TkFIanlLcFJNWWRq?=
 =?iso-2022-jp?B?ZU10WXljL0NEWkpTQWMwYzhLQi9QVUNGOEIrenAzTkgzMmYrUFdsUlRM?=
 =?iso-2022-jp?B?Mk5QOCt6S0JJVTRac29DVFUveklqV3hqZHh0ekdIWTliSkx0b1pQbU1N?=
 =?iso-2022-jp?B?elFUM2JMOEJqb2Y1eTNBK1JMOUVjRzM5NXVFcVJEOU5EUFE1cmsranNw?=
 =?iso-2022-jp?B?VzJ4blVhYVNrYk9LNE1DcjRpMnR3WkNNL3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1136a38-2dd7-4e22-726d-08dbcdd10065
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2023 22:49:34.1120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ORa+6UCfj8NLpgPZkK/GNaarA6ZgSI73VQJJXr0qnhmSgvTH4QpwbnaDnPUgUPFKqTx4teTfJjmq+T91i64f9IxTGDj1IL4dA7fhQVLRCzNSVHNWwYrSg/sJjT5lsivX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10015
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo A. R. Silva,

Thanks for your patch!

> -----Original Message-----
> From: Gustavo A. R. Silva <gustavoars@kernel.org>
> Sent: Thursday, October 12, 2023 11:18 AM
> To: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@kernel.org>; iwamatsu nobuhiro(岩松 信洋 ○ＤＩＴＣ□ＤＩＴ○Ｏ
> ＳＴ) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: Kees Cook <keescook@chromium.org>; linux-clk@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Gustavo A.
> R. Silva <gustavoars@kernel.org>; linux-hardening@vger.kernel.org
> Subject: [PATCH 1/2][next] clk: visconti: Fix undefined behavior bug in struct
> visconti_pll_provider
> 
> `struct clk_hw_onecell_data` is a flexible structure, which means that it
> contains flexible-array member at the bottom, in this case array
> `hws`:
> 
> include/linux/clk-provider.h:
> 1380 struct clk_hw_onecell_data {
> 1381         unsigned int num;
> 1382         struct clk_hw *hws[] __counted_by(num);
> 1383 };
> 
> This could potentially lead to an overwrite of the objects following `clk_data` in
> `struct visconti_pll_provider`, in this case `struct device_node *node;`, at
> run-time:
> 
> drivers/clk/visconti/pll.h:
>  16 struct visconti_pll_provider {
>  17         void __iomem *reg_base;
>  18         struct clk_hw_onecell_data clk_data;
>  19         struct device_node *node;
>  20 };
> 
> Notice that a total of 56 bytes are allocated for flexible-array `hws` at line 328.
> See below:
> 
> include/dt-bindings/clock/toshiba,tmpv770x.h:
>  14 #define TMPV770X_NR_PLL		7
> 
> drivers/clk/visconti/pll-tmpv770x.c:
>  69 ctx = visconti_init_pll(np, reg_base, TMPV770X_NR_PLL);
> 
> drivers/clk/visconti/pll.c:
> 321 struct visconti_pll_provider * __init visconti_init_pll(struct device_node
> *np,
> 322                                                         void __iomem
> *base,
> 323                                                         unsigned long
> nr_plls)
> 324 {
> 325         struct visconti_pll_provider *ctx;
> ...
> 328         ctx = kzalloc(struct_size(ctx, clk_data.hws, nr_plls),
> GFP_KERNEL);
> 
> `struct_size(ctx, clk_data.hws, nr_plls)` above translates to sizeof(struct
> visconti_pll_provider) + sizeof(struct clk_hw *) * 7 ==
> 24 + 8 * 7 == 24 + 56
> 		  ^^^^
> 		   |
> 	allocated bytes for flex array `hws`
> 
> $ pahole -C visconti_pll_provider drivers/clk/visconti/pll.o struct
> visconti_pll_provider {
> 	void *                     reg_base;             /*     0     8 */
> 	struct clk_hw_onecell_data clk_data;             /*     8     8 */
> 	struct device_node *       node;                 /*    16     8 */
> 
> 	/* size: 24, cachelines: 1, members: 3 */
> 	/* last cacheline: 24 bytes */
> };
> 
> And then, after the allocation, some data is written into all members of `struct
> visconti_pll_provider`:
> 
> 332         for (i = 0; i < nr_plls; ++i)
> 333                 ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
> 334
> 335         ctx->node = np;
> 336         ctx->reg_base = base;
> 337         ctx->clk_data.num = nr_plls;
> 
> Fix all these by placing the declaration of object `clk_data` at the end of `struct
> visconti_pll_provider`. Also, add a comment to make it clear that this object
> must always be last in the structure, and prevent this bug from being
> introduced again in the future.
> 
> Fixes: b4cbe606dc36 ("clk: visconti: Add support common clock driver and
> reset driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro

