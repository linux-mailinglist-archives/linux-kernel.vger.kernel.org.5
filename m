Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2317CF7BB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345421AbjJSL6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjJSL6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:58:34 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4565CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:58:31 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231019115829epoutp04f51d3e9ebe059e1c3aba02d92bb79688~PgFpUQn6H0631606316epoutp04c
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:58:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231019115829epoutp04f51d3e9ebe059e1c3aba02d92bb79688~PgFpUQn6H0631606316epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697716710;
        bh=ccFnxQ/4QOewwa6GKl0dvdiK5KIe7gLbSAatJOrblZ0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=K3xBSWXILghWq9smFl/Rj3fpD2qUlAVDuNu76ME8n0ACprviEPWHDfxiuh8M3GlzJ
         3KfcPRbvzgU2mlx+u7rsb8XnJpwnAGu/oIEB6vzjnDUZxrh6o1eLjciUWL0CWsYt3t
         154bODMm4UhfIoDgYGPxA+Y2v/ebs83zyCqUwSuo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231019115829epcas1p166fa0f293f9d62668a8cd4084c6d2d18~PgFojKGmJ0985509855epcas1p1Z;
        Thu, 19 Oct 2023 11:58:29 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.144]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SB5pD1j7Pz4x9Pp; Thu, 19 Oct
        2023 11:58:28 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.0E.19104.4E911356; Thu, 19 Oct 2023 20:58:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20231019115827epcas1p46278913c6a55f8a1181c05d06c6086a1~PgFnFUDFe3097630976epcas1p4g;
        Thu, 19 Oct 2023 11:58:27 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231019115827epsmtrp1529dda33050218a4af18d1363b5f3402~PgFnEVCkX2182621826epsmtrp1Z;
        Thu, 19 Oct 2023 11:58:27 +0000 (GMT)
X-AuditID: b6c32a4c-80dff70000004aa0-38-653119e498a1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.E8.07368.3E911356; Thu, 19 Oct 2023 20:58:27 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231019115827epsmtip292a974f54e7aae558a4406fcef1dd1d5~PgFms9csO0706207062epsmtip2D;
        Thu, 19 Oct 2023 11:58:27 +0000 (GMT)
From:   "Chanwoo Choi" <cw00.choi@samsung.com>
To:     "'Sascha Hauer'" <s.hauer@pengutronix.de>,
        <linux-rockchip@lists.infradead.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "'Heiko Stuebner'" <heiko@sntech.de>,
        "'Chanwoo Choi'" <chanwoo@kernel.org>,
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
In-Reply-To: <20231018061714.3553817-15-s.hauer@pengutronix.de>
Subject: RE: [PATCH v8 14/26] PM / devfreq: rockchip-dfi: Prepare for
 multiple users
Date:   Thu, 19 Oct 2023 20:58:27 +0900
Message-ID: <001901da0283$91f90b80$b5eb2280$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQFYMiMsP3soeW2GlDsie1R9CxInBwFFM3QSAUhOkoGxQDa4oA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xTVxTO7Xt9LRj0rWC8AnH4ABMJP/oEysWBkun0oWQSifvBdNjRJ2VA
        27RlinOuW+RHCwoMcKOgBSZkIMisOMDJEGQDk8k0juoi3QpWHQNUcCCEsI7ycOO/73znfOec
        794cISaaJjyFqQotq1ZI0ynCFf/u+sbgIPtamhUP24So+N6vOGrs6OchU08/HzmGR/mooawd
        R6f+HMLQzc/HBMj8wMJHd65UEuj5yR6AJm0ODNXevc1DXdV+6P5n3xAou6NHgLqe2flovtWM
        I+vom6i36RGBTgyGx3gwjWcbAdNmPQeYdqNVwJgb9AQzaLlKMJfOfcoUzouZUy0NgGm1nMWY
        5+Z1jGnuAYhfkZgWJWelMlbtwyqSlbJURUo0tTshaVtSuERMB9GRKILyUUgz2Ghqe1x80I7U
        9AWDlM9H0vTMBSpeqtFQIVui1MpMLesjV2q00RSrkqWrwlXBGmmGJlOREqxgtZtpsXhT+ELh
        wTR5Re7vuCo/8Ei54xahA71+BuAihGQYHPv7W2AArkIReRXAvIpSjAsmAdQbbgq4YBrAp1OX
        iZeSS5aHS5IOAOfyanBnQkSOAPjTmMwAhEKCDIRVM/uctAe5Dxb2tfGcGCOn+fCZI9aJXcit
        sLPcLHBid/ItWN5RsdgGJ/1hl2NgkXcjI+HErB1w+BV4o9yOc31eha3jlRi3jw+cfVjH53gP
        WKHPwbi5r0Pb8I1FN5A0ucBbNVM4J9gOL+vvLmF3+Fdvi4DDnnCkMEfACUoAvD06uqRuBvBi
        /YmlcaGws7aE53SJkRth85UQjl4P2+fOAG6LlfDJVAHfWQJJN5iXI+JKfOEdm5XH4bXw61w9
        UQQo4zJvxmXejMv8GP8fVgXwBuDJqjQZKWwyraKDFOzh/348WZlhBosHEBDXBl40zwd3A54Q
        dAMoxCgPN39GzIrcZNKso6xamaTOTGc13SB84cWLMc/VycqFC1Jok+iwSHGYZFNoGKIlNLXG
        bf9krkxEpki1bBrLqlj1Sx1P6OKp423Tvr2n1S/ixf01O58UjJsOWOVlqdmFY3HBsdXe+gK/
        upjh87U7DVEDR8HEzJbHh/wTXfvq8eI9Kw9cYEu7LWg2/g/TtZKZaf/s0+djma6igakLF48F
        bq3P/uVjiWus/YyrjfpKAhMEXzbtemf1e7qsYmtRn/snv801f6Gdvj53r1Rv9sWP58c4BHvX
        zdqKJCuUbxzerBvKyrHxH1GEtyWi42la0+OxmuINrMlrR9zxH2aq/klc9VrSqkO9lW3H6PqQ
        8eayXQGD/QnlLkP79x6pDciNPP3zh9FeG97H5BN11XGdjUbf2O/XhxparqXJf9xd94EO1Op8
        4cjBd0e98728sMx8CtfIpXQAptZI/wXtK4L3iQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCSvO5jScNUg5sLJS0m3rjCYrFm7zkm
        i/lHzrFa/H/0mtVi1dSdLBZ9Lx4yW5xtesNusenxNVaLy7vmsFl87j3CaPHpwX9mi6XXLzJZ
        HFyoYnG7cQWbReveI+wWBz88YbX4u30Ti8Xd134Wx9c+Y7NouWPqIOKxZt4aRo8dd5cweuyc
        dZfdY9OqTjaPO9f2sHlsXlLv0f/XwKNvyypGj+3X5jF7fN4k5zH/92PGAO4oLpuU1JzMstQi
        fbsErozZ7fdYCrp1Kmb+v8DWwHhcpYuRk0NCwERi87WnjF2MXBxCArsZJRqetzNCJCQlpl08
        ytzFyAFkC0scPlwMUfOcUeLcxzPsIHE2AR2JBT9CQcpFBEIl+k/sYAKpYRZoYZPYtewzG0TD
        IUaJK9f6WUCqOAXsJfbP3MQOYgsLhEhMmfQdLM4ioCpx8P9VsDivgKXEx59PGCFsQYmTM5+w
        gCxjFtCTaNsIFmYWkJfY/nYOM8SdChI/ny5jhYiLSMzubGOGOMhJ4sGjk8wTGIVnIZk0C2HS
        LCSTZiHpXsDIsopRMrWgODc9N9mwwDAvtVyvODG3uDQvXS85P3cTIzj+tTR2MN6b/0/vECMT
        ByPQixzMSiK8qh4GqUK8KYmVValF+fFFpTmpxYcYpTlYlMR5DWfMThESSE8sSc1OTS1ILYLJ
        MnFwSjUw3fE0TzwqP/nN0yDTs09Pvj5TJndRS1Lpp0jFlhS3ZcYWno+eLnLnY9TcU5tvs0K0
        Zd7X2Zm77sf5eE+q0OtROvDPyyK8/2ZHyRE1/8lTEyokX0Q83/qm+sWBLz+tb35JXcB4eW1b
        VGfohsK7jBZrm+5/Y9uT1PpKszXsa33V8a/it/QPBxm2VdjxLF12IkXp7LvMsLWK75V07oke
        fSnQvCFkSvvsjVPOvy/aayt3TLj1HaNkzMyfAcJ/fCWzFebLRggL3VqwwHz73o/rdn3k16x5
        r/lwcUiide10V/5XthulLqwRMnyldJXVJ/Vr8odKxtUb7WIN2B7oSz1d8jdqypTWzdzLf6V6
        P7zEx7btmBJLcUaioRZzUXEiAIPRq3tuAwAA
X-CMS-MailID: 20231019115827epcas1p46278913c6a55f8a1181c05d06c6086a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231018063817epcas1p46805fa64ee2bba269696390b250bba91
References: <20231018061714.3553817-1-s.hauer@pengutronix.de>
        <CGME20231018063817epcas1p46805fa64ee2bba269696390b250bba91@epcas1p4.samsung.com>
        <20231018061714.3553817-15-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Wednesday, October 18, 2023 3:17 PM
> To: linux-rockchip@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> linux-pm@vger.kernel.org; Heiko Stuebner <heiko@sntech.de>; Chanwoo Choi
> <chanwoo@kernel.org>; Kyungmin Park <kyungmin.park@samsung.com>; MyungJoo
> Ham <myungjoo.ham@samsung.com>; Will Deacon <will@kernel.org>; Mark
> Rutland <mark.rutland@arm.com>; kernel@pengutronix.de; Michael Riesch
> <michael.riesch@wolfvision.net>; Robin Murphy <robin.murphy@arm.com>;
> Vincent Legoll <vincent.legoll@gmail.com>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> devicetree@vger.kernel.org; Sebastian Reichel
> <sebastian.reichel@collabora.com>; Sascha Hauer <s.hauer@pengutronix.de>;
> Jonathan Cameron <Jonathan.Cameron@huawei.com>; Chanwoo Choi
> <cw00.choi@samsung.com>
> Subject: [PATCH v8 14/26] PM / devfreq: rockchip-dfi: Prepare for multiple
> users
> 
> When adding perf support later the DFI must be enabled when either of
> devfreq-event or perf is active. Prepare for that by adding a usage
> counter for the DFI. Also move enabling and disabling of the clock away
> from the devfreq-event specific functions to which the perf specific part
> won't have access.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/devfreq/event/rockchip-dfi.c | 57 +++++++++++++++++++---------
>  1 file changed, 40 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c
> b/drivers/devfreq/event/rockchip-dfi.c
> index d56a33d03db4c..7a4f1901314d4 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -68,14 +68,29 @@ struct rockchip_dfi {
>  	void __iomem *regs;
>  	struct regmap *regmap_pmu;
>  	struct clk *clk;
> +	int usecount;
> +	struct mutex mutex;
>  	u32 ddr_type;
>  	unsigned int channel_mask;
>  	unsigned int max_channels;
>  };
> 
> -static void rockchip_dfi_start_hardware_counter(struct rockchip_dfi *dfi)
> +static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
>  {
>  	void __iomem *dfi_regs = dfi->regs;
> +	int ret = 0;
> +
> +	mutex_lock(&dfi->mutex);
> +
> +	dfi->usecount++;
> +	if (dfi->usecount > 1)
> +		goto out;
> +
> +	ret = clk_prepare_enable(dfi->clk);
> +	if (ret) {
> +		dev_err(&dfi->edev->dev, "failed to enable dfi clk: %d\n",
> ret);
> +		goto out;
> +	}
> 
>  	/* clear DDRMON_CTRL setting */
>  	writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_TIMER_CNT_EN |
> DDRMON_CTRL_SOFTWARE_EN | @@ -100,14 +115,30 @@ static void
> rockchip_dfi_start_hardware_counter(struct rockchip_dfi *dfi)
>  	/* enable count, use software mode */
>  	writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_SOFTWARE_EN,
> DDRMON_CTRL_SOFTWARE_EN),
>  		       dfi_regs + DDRMON_CTRL);
> +out:
> +	mutex_unlock(&dfi->mutex);
> +
> +	return ret;
>  }
> 
> -static void rockchip_dfi_stop_hardware_counter(struct rockchip_dfi *dfi)
> +static void rockchip_dfi_disable(struct rockchip_dfi *dfi)
>  {
>  	void __iomem *dfi_regs = dfi->regs;
> 
> +	mutex_lock(&dfi->mutex);
> +
> +	dfi->usecount--;
> +
> +	WARN_ON_ONCE(dfi->usecount < 0);
> +
> +	if (dfi->usecount > 0)
> +		goto out;
> +
>  	writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_SOFTWARE_EN),
>  		       dfi_regs + DDRMON_CTRL);
> +	clk_disable_unprepare(dfi->clk);
> +out:
> +	mutex_unlock(&dfi->mutex);
>  }
> 
>  static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct
> dmc_count *count) @@ -125,29 +156,20 @@ static void
> rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct dmc_coun
>  	}
>  }
> 
> -static int rockchip_dfi_disable(struct devfreq_event_dev *edev)
> +static int rockchip_dfi_event_disable(struct devfreq_event_dev *edev)
>  {
>  	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
> 
> -	rockchip_dfi_stop_hardware_counter(dfi);
> -	clk_disable_unprepare(dfi->clk);
> +	rockchip_dfi_disable(dfi);
> 
>  	return 0;
>  }
> 
> -static int rockchip_dfi_enable(struct devfreq_event_dev *edev)
> +static int rockchip_dfi_event_enable(struct devfreq_event_dev *edev)
>  {
>  	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
> -	int ret;
> -
> -	ret = clk_prepare_enable(dfi->clk);
> -	if (ret) {
> -		dev_err(&edev->dev, "failed to enable dfi clk: %d\n", ret);
> -		return ret;
> -	}
> 
> -	rockchip_dfi_start_hardware_counter(dfi);
> -	return 0;
> +	return rockchip_dfi_enable(dfi);
>  }
> 
>  static int rockchip_dfi_set_event(struct devfreq_event_dev *edev) @@ -
> 191,8 +213,8 @@ static int rockchip_dfi_get_event(struct devfreq_event_dev
> *edev,  }
> 
>  static const struct devfreq_event_ops rockchip_dfi_ops = {
> -	.disable = rockchip_dfi_disable,
> -	.enable = rockchip_dfi_enable,
> +	.disable = rockchip_dfi_event_disable,
> +	.enable = rockchip_dfi_event_enable,
>  	.get_event = rockchip_dfi_get_event,
>  	.set_event = rockchip_dfi_set_event,
>  };
> @@ -280,6 +302,7 @@ static int rockchip_dfi_probe(struct platform_device
> *pdev)
>  		return PTR_ERR(dfi->regmap_pmu);
> 
>  	dfi->dev = dev;
> +	mutex_init(&dfi->mutex);
> 
>  	desc = &dfi->desc;
>  	desc->ops = &rockchip_dfi_ops;
> --
> 2.39.2


Applied it. Thanks

Best Regards,
Chanwoo Choi

