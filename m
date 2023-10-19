Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93CF7CF890
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345451AbjJSMR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjJSMRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:17:53 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3327BE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:17:45 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231019121743epoutp02ed9ddfa6d81be00135733732622c35c1~PgWcDSLsX0129001290epoutp02U
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:17:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231019121743epoutp02ed9ddfa6d81be00135733732622c35c1~PgWcDSLsX0129001290epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697717864;
        bh=s1ZasyYHb4u4TAOpIX00ZD0JfTVvUw1BMxbGp0tXpyk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=MaO04EManHeSWBwCrD3pQQ3uQrKhnnc2UtxObYtDty6BsSYcwnB678lGrtW0bp5fH
         BRiwCxITo8D6m2lDF6TDmHg1/Fw5rZLlnKXoA/iavPl2B5FolW9Kx3z6I7n497RUpE
         GNcrKDHLw1YerjdzHVsc2TL/LCjKFrLTfidHlFEE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231019121742epcas1p260045d633b1a1097b59639f59e929d79~PgWbEnHHF2054920549epcas1p2Z;
        Thu, 19 Oct 2023 12:17:42 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.136]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SB6DP5lcmz4x9Pr; Thu, 19 Oct
        2023 12:17:41 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.63.09744.56E11356; Thu, 19 Oct 2023 21:17:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20231019121740epcas1p3f391843e0c3663d628c4e1400b0000b9~PgWYwi-9a1224512245epcas1p3f;
        Thu, 19 Oct 2023 12:17:40 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231019121740epsmtrp194ba0776c18cdba17d2ea85bb18a6cfe~PgWYvmNwn0076900769epsmtrp1O;
        Thu, 19 Oct 2023 12:17:40 +0000 (GMT)
X-AuditID: b6c32a35-eabff70000002610-6c-65311e6596de
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.B9.07368.46E11356; Thu, 19 Oct 2023 21:17:40 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231019121740epsmtip19fc3f88b5b265a8b15d7bdb3f01f2ce0~PgWYaNOC70851008510epsmtip1k;
        Thu, 19 Oct 2023 12:17:40 +0000 (GMT)
From:   "Chanwoo Choi" <cw00.choi@samsung.com>
To:     "'Chanwoo Choi'" <chanwoo@kernel.org>,
        "'Sascha Hauer'" <s.hauer@pengutronix.de>,
        <linux-rockchip@lists.infradead.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "'Heiko Stuebner'" <heiko@sntech.de>,
        "'Kyungmin Park'" <kyungmin.park@samsung.com>,
        "'MyungJoo Ham'" <myungjoo.ham@samsung.com>,
        "'Will Deacon'" <will@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>, <kernel@pengutronix.de>,
        "'Michael Riesch'" <michael.riesch@wolfvision.net>,
        "'Robin Murphy'" <robin.murphy@arm.com>,
        "'Vincent Legoll'" <vincent.legoll@gmail.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Conor Dooley'" <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        "'Sebastian Reichel'" <sebastian.reichel@collabora.com>
In-Reply-To: <b24844da-f82c-448d-91bc-bc2a8d2053b1@kernel.org>
Subject: RE: [PATCH v8 17/26] PM / devfreq: rockchip-dfi: make register
 stride SoC specific
Date:   Thu, 19 Oct 2023 21:17:39 +0900
Message-ID: <002a01da0286$41249280$c36db780$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQFYMiMsP3soeW2GlDsie1R9CxInBwGqUH+LAb1ZOqkCBeySs7EpO3pA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIJsWRmVeSWpSXmKPExsWy7bCmvm6qnGGqwcoOdYuJN66wWKzZe47J
        Yv6Rc6wW/x+9ZrVYNXUni0Xfi4fMFmeb3rBbbHp8jdXi8q45bBafe48wWnx68J/ZYun1i0wW
        BxeqWNxuXMFm0br3CLvFwQ9PWC3+bt/EYnH3tZ/F8bXP2Cxa7pg6iHismbeG0WPH3SWMHjtn
        3WX32LSqk83jzrU9bB6bl9R79P818OjbsorRY/u1ecwenzfJecz//ZgxgDsq2yYjNTEltUgh
        NS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6EElhbLEnFKgUEBicbGS
        vp1NUX5pSapCRn5xia1SakFKToFpgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGj2Uv2QpOyFfM
        +fmbpYHxhGQXIyeHhICJRHPnWpYuRi4OIYEdjBK3vmyAcj4xSlxa+pQRpEpI4BujxKk/XjAd
        6z6/ZYUo2ssoMW3ieWYI5yWjxPGnq4A6ODjYBHQkFvwIBWkQEaiReN59H6yBWeA8q8TCNwtZ
        QRKcAnYSm+e1sIDUCwvEStxe5gASZhFQlTj9ez7YGF4BS4mVE4JAwrwCghInZz5hAbGZBeQl
        tr+dwwxxj4LEz6fLWCHiIhKzO9uYIda6Sdy89ZsdZK2EwHxOiXfH29khGlwkrk6dDGULS7w6
        vgXKlpJ42d8G1TCZUeLi69fMEM56RomNK1ug1hlL7F86mQnkOmYBTYn1u/QhwooSO3/PZYS4
        gk/i3dceVpASCQFeiY42IYgSZYnLD+4yQdiSEovbO9kmMCrNQvLbLCS/zULyzyyEZQsYWVYx
        iqUWFOempxYbFhjCIzs5P3cTIzjta5nuYJz49oPeIUYmDsZDjBIczEoivKoeBqlCvCmJlVWp
        RfnxRaU5qcWHGE2BgT2RWUo0OR+YefJK4g1NLA1MzIyMTSwMzQyVxHmZH/WmCAmkJ5akZqem
        FqQWwfQxcXBKNTCF8rjd87+yVkO9reT4LeVtP9iZs76w2UdGLWlfJW0bXsx49YJykNvh4Bk7
        PeOYLJsfSMjustJzmRXtl7fBZdKknp+yFaHu+xe8nbcrLmFJkbjQ3tk1Lm5lxnpptle+XxLy
        52Re62T5nKHq4IGL+d5n1f8ETF9iIjdt716DhLCNC6zrpuv/nPsy0LDsjU5g/RPprXM6li0W
        0PJN9HvfZnNeTMdiZd+ZU3cylB+FKBkrpJ0v4ysVcDtqndVUeF9SMHOyDO+03V67Xbakvzie
        tTa4V/vyL12hjLyWi3V3Nu7Km89UVzxv8xubt9omuw2Y5wacmVXz5905hi7Fd991VNdGd7tl
        iz67FsRUmZ9grMRSnJFoqMVcVJwIAK5MdaiEBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCSnG6KnGGqwd5VQhYTb1xhsViz9xyT
        xfwj51gt/j96zWqxaupOFou+Fw+ZLc42vWG32PT4GqvF5V1z2Cw+9x5htPj04D+zxdLrF5ks
        Di5UsbjduILNonXvEXaLgx+esFr83b6JxeLuaz+L42ufsVm03DF1EPFYM28No8eOu0sYPXbO
        usvusWlVJ5vHnWt72Dw2L6n36P9r4NG3ZRWjx/Zr85g9Pm+S85j/+zFjAHcUl01Kak5mWWqR
        vl0CV8aPZS/ZCk7IV8z5+ZulgfGEZBcjJ4eEgInEus9vWbsYuTiEBHYzSvR/3skIkZCUmHbx
        KHMXIweQLSxx+HAxRM1zRomtXV1MIHE2AR2JBT9CQcpFBOokJnfvYgOpYRa4zSqxcPovZoiG
        L4wS01f+Zgep4hSwk9g8r4UFxBYWiJaYve0SWJxFQFXi9O/5jCBDeQUsJVZOCAIJ8woISpyc
        +QSsnFlAW+LpzadQtrzE9rdzmCHuVJD4+XQZK0RcRGJ2ZxszxEFuEjdv/WafwCg8C8moWUhG
        zUIyahaS9gWMLKsYJVMLinPTc5MNCwzzUsv1ihNzi0vz0vWS83M3MYITgJbGDsZ78//pHWJk
        4mA8xCjBwawkwqvqYZAqxJuSWFmVWpQfX1Sak1p8iFGag0VJnNdwxuwUIYH0xJLU7NTUgtQi
        mCwTB6dUA5NoxK72ZKP3LK0Zn+/JNU45/GxtgnDs8hslx29MVnx+UjPGd/vfD/OuWLfN4D6S
        dn1uWt/Fz3mze/otlD9ut7YKSwu5Uu0fdFK37UX99phvXRtdpLOlEuZMLlJubt4bXxPYyN/S
        tz8zkXejhYaAoPLfl8liqXp6/We8Yir/tq6UPZmqIcC74M1ppec/L3TtNn31oVjI8sPX9R6K
        ZzYse6nGWtvz6fSNL83iWVnVL7aH3n/P03vk+w0eGcG52b4XtWMOGjcxC5uu39ln9+kfQ1iV
        3dIlpplKbbGLdt7w3iJSIL+uzFOcVVm88vCi9pdeO5afnr4x6bffcsbXnIUFLwV+BCufZQkI
        3JWw/6vbBSWW4oxEQy3mouJEAL+B+shvAwAA
X-CMS-MailID: 20231019121740epcas1p3f391843e0c3663d628c4e1400b0000b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231018151140epcas1p27660de229a6804cac74a70c9de2d3245
References: <20231018061714.3553817-1-s.hauer@pengutronix.de>
        <20231018061714.3553817-18-s.hauer@pengutronix.de>
        <CGME20231018151140epcas1p27660de229a6804cac74a70c9de2d3245@epcas1p2.samsung.com>
        <b24844da-f82c-448d-91bc-bc2a8d2053b1@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Chanwoo Choi <chanwoo@kernel.org>
> Sent: Thursday, October 19, 2023 12:11 AM
> To: Sascha Hauer <s.hauer@pengutronix.de>; linux-
> rockchip@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> linux-pm@vger.kernel.org; Heiko Stuebner <heiko@sntech.de>; Kyungmin Park
> <kyungmin.park@samsung.com>; MyungJoo Ham <myungjoo.ham@samsung.com>; Will
> Deacon <will@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> kernel@pengutronix.de; Michael Riesch <michael.riesch@wolfvision.net>;
> Robin Murphy <robin.murphy@arm.com>; Vincent Legoll
> <vincent.legoll@gmail.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; devicetree@vger.kernel.org; Sebastian Reichel
> <sebastian.reichel@collabora.com>; Jonathan Cameron
> <Jonathan.Cameron@huawei.com>
> Subject: Re: [PATCH v8 17/26] PM / devfreq: rockchip-dfi: make register
> stride SoC specific
> 
> On 23. 10. 18. 15:17, Sascha Hauer wrote:
> > The currently supported RK3399 has a stride of 20 between the channel
> > specific registers. Upcoming RK3588 has a different stride, so put the
> > stride into driver data to make it configurable.
> > While at it convert decimal 20 to hex 0x14 for consistency with RK3588
> > which has a register stride 0x4000 and we want to write that in hex as
> > well.
> >
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >
> > Notes:
> >     Changes since v7:
> >      - Initialize ddrmon_stride for RK3568 and explain why it's not
> > needed
> >
> >  drivers/devfreq/event/rockchip-dfi.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/devfreq/event/rockchip-dfi.c
> > b/drivers/devfreq/event/rockchip-dfi.c
> > index 63977f9fc2693..a3d823ac68ace 100644
> > --- a/drivers/devfreq/event/rockchip-dfi.c
> > +++ b/drivers/devfreq/event/rockchip-dfi.c
> > @@ -113,6 +113,7 @@ struct rockchip_dfi {
> >  	int active_events;
> >  	int burst_len;
> >  	int buswidth[DMC_MAX_CHANNELS];
> > +	int ddrmon_stride;
> >  };
> >
> >  static int rockchip_dfi_enable(struct rockchip_dfi *dfi) @@ -190,13
> > +191,13 @@ static void rockchip_dfi_read_counters(struct rockchip_dfi
> *dfi, struct dmc_coun
> >  		if (!(dfi->channel_mask & BIT(i)))
> >  			continue;
> >  		res->c[i].read_access = readl_relaxed(dfi_regs +
> > -				DDRMON_CH0_RD_NUM + i * 20);
> > +				DDRMON_CH0_RD_NUM + i * dfi->ddrmon_stride);
> >  		res->c[i].write_access = readl_relaxed(dfi_regs +
> > -				DDRMON_CH0_WR_NUM + i * 20);
> > +				DDRMON_CH0_WR_NUM + i * dfi->ddrmon_stride);
> >  		res->c[i].access = readl_relaxed(dfi_regs +
> > -				DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
> > +				DDRMON_CH0_DFI_ACCESS_NUM + i * dfi-
> >ddrmon_stride);
> >  		res->c[i].clock_cycles = readl_relaxed(dfi_regs +
> > -				DDRMON_CH0_COUNT_NUM + i * 20);
> > +				DDRMON_CH0_COUNT_NUM + i * dfi->ddrmon_stride);
> >  	}
> >  }
> >
> > @@ -664,6 +665,8 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
> >  	dfi->buswidth[0] = FIELD_GET(RK3399_PMUGRF_OS_REG2_BW_CH0, val) ==
> 0 ? 4 : 2;
> >  	dfi->buswidth[1] = FIELD_GET(RK3399_PMUGRF_OS_REG2_BW_CH1, val) ==
> 0
> > ? 4 : 2;
> >
> > +	dfi->ddrmon_stride = 0x14;
> > +
> >  	return 0;
> >  };
> >
> > @@ -690,6 +693,8 @@ static int rk3568_dfi_init(struct rockchip_dfi
> > *dfi)
> >
> >  	dfi->buswidth[0] = FIELD_GET(RK3568_PMUGRF_OS_REG2_BW_CH0, reg2) ==
> > 0 ? 4 : 2;
> >
> > +	dfi->ddrmon_stride = 0x0; /* not relevant, we only have a single
> > +channel on this SoC */
> > +
> >  	return 0;
> >  };
> >
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> --
> Best Regards,
> Samsung Electronics
> Chanwoo Choi


Applied it. Thanks

Best Regards,
Chanwoo Choi

