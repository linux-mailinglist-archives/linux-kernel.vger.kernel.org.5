Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9407B7CF894
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345433AbjJSMSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjJSMSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:18:16 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA9512F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:18:13 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231019121811epoutp0241941260c7e05bda633b52d8d04fbcf3~PgW12QGDX0096900969epoutp02f
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:18:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231019121811epoutp0241941260c7e05bda633b52d8d04fbcf3~PgW12QGDX0096900969epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697717891;
        bh=LSEnNiF2YpXKAbjq34Mo6BOGvOSItMmMICDdDuIOxKI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=lGp7Kar5xgA9344eSIOeY7ganFQuGoWo/UfHIPtlN//8NwjpaTWcD3r40WakH8CuP
         zpLc4aendQC/EXbQ5I8p25Rqg/6aneo+WyBdqt3828hNolDSKwXMpgbPEc8LKlErJA
         Afqb59k3rOUT/eUEc5pqKYgOiVZ6TeJM7K1IIdSo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20231019121810epcas1p3b10d40304395485d5922c46f484cf528~PgW0kmdfq1224512245epcas1p3A;
        Thu, 19 Oct 2023 12:18:10 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.135]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SB6Dx3GgKz4x9Pr; Thu, 19 Oct
        2023 12:18:09 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.04.10025.18E11356; Thu, 19 Oct 2023 21:18:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20231019121808epcas1p414de96132c83c7a70aab041be305f72e~PgWzN-Laj0634506345epcas1p4v;
        Thu, 19 Oct 2023 12:18:08 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231019121808epsmtrp234103f0930c820aabce44031c5d7cd5a~PgWzNDn522185621856epsmtrp2A;
        Thu, 19 Oct 2023 12:18:08 +0000 (GMT)
X-AuditID: b6c32a39-9d9ff70000002729-a1-65311e81913e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.B9.07368.08E11356; Thu, 19 Oct 2023 21:18:08 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231019121808epsmtip1e64ed5bacf4e625cb2e434765df2c198~PgWy2DIDK0853208532epsmtip1c;
        Thu, 19 Oct 2023 12:18:08 +0000 (GMT)
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
In-Reply-To: <4f7d4701-d40c-4aa4-908a-7e8dd4206c01@kernel.org>
Subject: RE: [PATCH v8 18/26] PM / devfreq: rockchip-dfi: account for
 multiple DDRMON_CTRL registers
Date:   Thu, 19 Oct 2023 21:18:08 +0900
Message-ID: <002b01da0286$520e6800$f62b3800$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQFYMiMsP3soeW2GlDsie1R9CxInBwEGhR7sAbjX9zcBRb4as7E0f3aw
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUwTZxze27teD2bJUXC+wOLwhonCii1QOKZF5sQc6pBk4h9uS23oQRnQ
        Nr3CnJoBBpx1oiAhQilCEZgSCIIwwMj4EIISwDEL2xz1AxiofCpxwzDHWg43/nt+H8/v9zzv
        B46IFjBPPEFjYPQaZRKJOaM/3NoqFmdslDISy5wblfurFaWqWwd4VEnXAJ9aHp3iU1X5LSh1
        7sljhOo/OS2g6seG+dS9G2aMWsjuAtSLR8sIVfHLII/qsPhQv2dcwais1i4B1TE/zqdeN9Wj
        lG0qiuqpmcCozBFZuDtdfaka0M22ckC3mGwCur7KiNEjwzcx+np5Gn3+tYQ+11AF6KbhSwi9
        UL+RLlkaA9FvH07coWaUKkbvzWhitaoETbyc3Pep4mOFLFgiFUtDqRDSW6NMZuTk7v3R4j0J
        SXaDpHeqMinFnopWsiy5LWyHXptiYLzVWtYgJxmdKkkn0/mzymQ2RRPvr2EMH0olkgCZvfFI
        orq7PRvorIFHc7qtaDr4Z8sZ4IRDIgi+LDqPngHOuIhoBrD9r27ABS8AHKoZ53PBnwAOzjby
        31A662YEXKEVwPHByVXKUwD/tnbbKziOER/A0sUYB8GdOAEnv3u4Mgkh7vKhZdqyMsmJCIMF
        tddXsBsRB+9//2AFo8Rm2Gep4zmwkAiFBaNZgMOu8E7hOOrACPEebJoxI5wib/jqj0o+l3eH
        RcZTCLd4D3xaXc7jekqcYO9kGId3w9GaOYzDbvBZT4OAw55wYbYVcwiFRJ7d8tQUwgW1ANZd
        zVzdFgjbKvJ4DpcIsRXW3tjGpTfBlqViwIlwgbMvz/IdLZAQwtOnRFzL+/DeI9uqHg94+Vsj
        lgNI0xprpjXWTGvsmP5fVgrQKvAOo2OT4xlWqpP9d92x2uR6sPL6fUObwcWZef9OwMNBJ4A4
        QroLN9MSRiRUKb8+xui1Cn1KEsN2Apn9sHMRz/WxWvv30RgU0qBQSVBwQGAQJQ2WkhuEAzPZ
        KhERrzQwiQyjY/RveDzcyTOdd+JWjc/dk+3zXxbqIjy+ysOO9P3WKxx6LPez7jQ8cdX3Fh17
        4NFv2p4Q/ElXGlnwc1903YahiMWWRWtDGTPx1pyT34F1CN4xgu90CU/vWSeN/Kxyrzrk84Hl
        b+YOlfXK1InutnfZVFv+TwpzzMVrXtO3X+23xFUXlPVk+ZX7lHpNTHkZeMefnz10+UJPx/pN
        /Y1ueSEVGW3ZRvnDiOhWuYo9KHAttB3ww11yDlsrTcWRS7fzBSM/3nR2eR5gMhbvKsqbj5w0
        HxXvU3xhvRB37crpTDJ9133+RwmxbQqz78D2usb+qIO+feLc4+L+1Gcxd8b3RonMTcKxkfSy
        djSNMSrDSZRVK6W+iJ5V/gu0k3gFhgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsWy7bCSnG6DnGGqQe9UTYuJN66wWKzZe47J
        Yv6Rc6wW/x+9ZrVYNXUni0Xfi4fMFmeb3rBbbHp8jdXi8q45bBafe48wWnx68J/ZYun1i0wW
        BxeqWNxuXMFm0br3CLvFwQ9PWC3+bt/EYnH3tZ/F8bXP2Cxa7pg6iHismbeG0WPH3SWMHjtn
        3WX32LSqk83jzrU9bB6bl9R79P818OjbsorRY/u1ecwenzfJecz//ZgxgDuKyyYlNSezLLVI
        3y6BK+PogV7GgivGFROOXmFpYPyn0cXIySEhYCJxaONb9i5GLg4hgd2MEuunn2aFSEhKTLt4
        lLmLkQPIFpY4fLgYouY5o8SSR/MYQeJsAjoSC36EgpSLCNRJTO7exQZSwyxwm1Vi4fRfzBAN
        Xxglbq7bxghSxSlgJzFj/WawBcICKRLnru9nBrFZBFQlzizcyARi8wpYSsx41MoIYQtKnJz5
        hAXEZhbQlnh68ymULS+x/e0cZohDFSR+Pl3GChEXkZjd2cYMcZGbxMs1S5gmMArPQjJqFpJR
        s5CMmoWkfQEjyypGydSC4tz03GTDAsO81HK94sTc4tK8dL3k/NxNjOAUoKWxg/He/H96hxiZ
        OBgPMUpwMCuJ8Kp6GKQK8aYkVlalFuXHF5XmpBYfYpTmYFES5zWcMTtFSCA9sSQ1OzW1ILUI
        JsvEwSnVwBRyMI3LhOuTrZpX+59TzmwikbrqIYfjr1/OEdUSa26IvbpwzSz/kMkTOC2kvinu
        01rqtCb/G9vK1nuXFN6LHdwcsffRG8Gdkm0Lli6bKvJfMkMt5pOYevAVvwM1uQEaNX1OHWkB
        y/znGFsr77yb7G/M5+dh/sStpmdOtNkBm6z5a7y/FVRqJHes3DZbZ6lQ4gO38MMP+qc3VhZY
        HCvc7cX5xl/7mqnZyUvNBkcYTiiHb3HUfntkate3LezKPMrGO0omfcp6vdtR7seLgN5cCdl1
        x5z/u5dMVEm3s74ivPz9my+efz6Gm0qvmJn7565DGl+aiXkPy5uuowkvlOTmJ7VZKsd9uPf7
        ZucqvgcblViKMxINtZiLihMBnaIq1nADAAA=
X-CMS-MailID: 20231019121808epcas1p414de96132c83c7a70aab041be305f72e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231018151205epcas1p468f16d3d456f5b3aad4cee0d1f374f61
References: <20231018061714.3553817-1-s.hauer@pengutronix.de>
        <20231018061714.3553817-19-s.hauer@pengutronix.de>
        <CGME20231018151205epcas1p468f16d3d456f5b3aad4cee0d1f374f61@epcas1p4.samsung.com>
        <4f7d4701-d40c-4aa4-908a-7e8dd4206c01@kernel.org>
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
> Sent: Thursday, October 19, 2023 12:12 AM
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
> Subject: Re: [PATCH v8 18/26] PM / devfreq: rockchip-dfi: account for
> multiple DDRMON_CTRL registers
> 
> On 23. 10. 18. 15:17, Sascha Hauer wrote:
> > The currently supported RK3399 has a set of registers per channel, but
> > it has only a single DDRMON_CTRL register. With upcoming RK3588 this
> > will be different, the RK3588 has a DDRMON_CTRL register per channel.
> >
> > Instead of expecting a single DDRMON_CTRL register, loop over the
> > channels and write the channel specific DDRMON_CTRL register. Break
> > out early out of the loop when there is only a single DDRMON_CTRL
> > register like on the RK3399.
> >
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >
> > Notes:
> >     Changes since v7:
> >      - initialize ddrmon_ctrl_single for RK3568
> >
> >  drivers/devfreq/event/rockchip-dfi.c | 73
> > +++++++++++++++++++---------
> >  1 file changed, 49 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/devfreq/event/rockchip-dfi.c
> > b/drivers/devfreq/event/rockchip-dfi.c
> > index a3d823ac68ace..bf38829a2a4af 100644
> > --- a/drivers/devfreq/event/rockchip-dfi.c
> > +++ b/drivers/devfreq/event/rockchip-dfi.c
> > @@ -114,12 +114,13 @@ struct rockchip_dfi {
> >  	int burst_len;
> >  	int buswidth[DMC_MAX_CHANNELS];
> >  	int ddrmon_stride;
> > +	bool ddrmon_ctrl_single;
> >  };
> >
> >  static int rockchip_dfi_enable(struct rockchip_dfi *dfi)  {
> >  	void __iomem *dfi_regs = dfi->regs;
> > -	int ret = 0;
> > +	int i, ret = 0;
> >
> >  	mutex_lock(&dfi->mutex);
> >
> > @@ -133,29 +134,41 @@ static int rockchip_dfi_enable(struct rockchip_dfi
> *dfi)
> >  		goto out;
> >  	}
> >
> > -	/* clear DDRMON_CTRL setting */
> > -	writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_TIMER_CNT_EN |
> DDRMON_CTRL_SOFTWARE_EN |
> > -		       DDRMON_CTRL_HARDWARE_EN), dfi_regs + DDRMON_CTRL);
> > +	for (i = 0; i < dfi->max_channels; i++) {
> > +		u32 ctrl = 0;
> >
> > -	/* set ddr type to dfi */
> > -	switch (dfi->ddr_type) {
> > -	case ROCKCHIP_DDRTYPE_LPDDR2:
> > -	case ROCKCHIP_DDRTYPE_LPDDR3:
> > -		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_LPDDR23,
> DDRMON_CTRL_DDR_TYPE_MASK),
> > -			       dfi_regs + DDRMON_CTRL);
> > -		break;
> > -	case ROCKCHIP_DDRTYPE_LPDDR4:
> > -	case ROCKCHIP_DDRTYPE_LPDDR4X:
> > -		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_LPDDR4,
> DDRMON_CTRL_DDR_TYPE_MASK),
> > -			       dfi_regs + DDRMON_CTRL);
> > -		break;
> > -	default:
> > -		break;
> > -	}
> > +		if (!(dfi->channel_mask & BIT(i)))
> > +			continue;
> >
> > -	/* enable count, use software mode */
> > -	writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_SOFTWARE_EN,
> DDRMON_CTRL_SOFTWARE_EN),
> > -		       dfi_regs + DDRMON_CTRL);
> > +		/* clear DDRMON_CTRL setting */
> > +		writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_TIMER_CNT_EN |
> > +			       DDRMON_CTRL_SOFTWARE_EN |
> DDRMON_CTRL_HARDWARE_EN),
> > +			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
> > +
> > +		/* set ddr type to dfi */
> > +		switch (dfi->ddr_type) {
> > +		case ROCKCHIP_DDRTYPE_LPDDR2:
> > +		case ROCKCHIP_DDRTYPE_LPDDR3:
> > +			ctrl = DDRMON_CTRL_LPDDR23;
> > +			break;
> > +		case ROCKCHIP_DDRTYPE_LPDDR4:
> > +		case ROCKCHIP_DDRTYPE_LPDDR4X:
> > +			ctrl = DDRMON_CTRL_LPDDR4;
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +
> > +		writel_relaxed(HIWORD_UPDATE(ctrl,
> DDRMON_CTRL_DDR_TYPE_MASK),
> > +			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
> > +
> > +		/* enable count, use software mode */
> > +		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_SOFTWARE_EN,
> DDRMON_CTRL_SOFTWARE_EN),
> > +			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
> > +
> > +		if (dfi->ddrmon_ctrl_single)
> > +			break;
> > +	}
> >  out:
> >  	mutex_unlock(&dfi->mutex);
> >
> > @@ -165,6 +178,7 @@ static int rockchip_dfi_enable(struct rockchip_dfi
> > *dfi)  static void rockchip_dfi_disable(struct rockchip_dfi *dfi)  {
> >  	void __iomem *dfi_regs = dfi->regs;
> > +	int i;
> >
> >  	mutex_lock(&dfi->mutex);
> >
> > @@ -175,8 +189,17 @@ static void rockchip_dfi_disable(struct
> rockchip_dfi *dfi)
> >  	if (dfi->usecount > 0)
> >  		goto out;
> >
> > -	writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_SOFTWARE_EN),
> > -		       dfi_regs + DDRMON_CTRL);
> > +	for (i = 0; i < dfi->max_channels; i++) {
> > +		if (!(dfi->channel_mask & BIT(i)))
> > +			continue;
> > +
> > +		writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_SOFTWARE_EN),
> > +			      dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
> > +
> > +		if (dfi->ddrmon_ctrl_single)
> > +			break;
> > +	}
> > +
> >  	clk_disable_unprepare(dfi->clk);
> >  out:
> >  	mutex_unlock(&dfi->mutex);
> > @@ -666,6 +689,7 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
> >  	dfi->buswidth[1] = FIELD_GET(RK3399_PMUGRF_OS_REG2_BW_CH1, val) ==
> 0
> > ? 4 : 2;
> >
> >  	dfi->ddrmon_stride = 0x14;
> > +	dfi->ddrmon_ctrl_single = true;
> >
> >  	return 0;
> >  };
> > @@ -694,6 +718,7 @@ static int rk3568_dfi_init(struct rockchip_dfi *dfi)
> >  	dfi->buswidth[0] = FIELD_GET(RK3568_PMUGRF_OS_REG2_BW_CH0, reg2) ==
> > 0 ? 4 : 2;
> >
> >  	dfi->ddrmon_stride = 0x0; /* not relevant, we only have a single
> > channel on this SoC */
> > +	dfi->ddrmon_ctrl_single = true;
> >
> >  	return 0;
> >  };
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

