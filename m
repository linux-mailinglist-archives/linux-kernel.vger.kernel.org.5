Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DBA7CF79E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345393AbjJSLzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjJSLzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:55:37 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DF4138
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:55:34 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231019115533epoutp03ba1bba470c41420a545bbdc43052a92c~PgDEj33lA1738017380epoutp03H
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:55:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231019115533epoutp03ba1bba470c41420a545bbdc43052a92c~PgDEj33lA1738017380epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697716533;
        bh=psy4QftyA5KPXqqnQvROb7WNKzsQxIims/4fEJN+UQI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=fMbYulMteJW3LrPneG9t+AwXPKgUnUGgWis9FQUGxvXJmPfBQD4QK6Zaug1PaJUjN
         qT01POA1dei+WGjPhNsxhlF6WDIALTrIEfu006CJpzLeq+ljuMUzYo6H2ikuJaYFfD
         x2ePTk+3c6GNTl8iPKWVVeOe2V5olgFGkaXfNU3s=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231019115531epcas1p2eda8408e7529aa70e32cb86451d97f6f~PgDC7L1xM0430504305epcas1p2D;
        Thu, 19 Oct 2023 11:55:31 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.237]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SB5kp2WnSz4x9Py; Thu, 19 Oct
        2023 11:55:30 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.B1.09744.23911356; Thu, 19 Oct 2023 20:55:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231019115529epcas1p2bf7d77ba6a893ea2f37974f98b824232~PgDBQejpf0430504305epcas1p2C;
        Thu, 19 Oct 2023 11:55:29 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231019115529epsmtrp1359b6b9a93630d8d36f59ad7ce699b6f~PgDBOxaD82014720147epsmtrp1y;
        Thu, 19 Oct 2023 11:55:29 +0000 (GMT)
X-AuditID: b6c32a35-107fa70000002610-26-6531193266b9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.0A.08817.13911356; Thu, 19 Oct 2023 20:55:29 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231019115529epsmtip2cb86bfd56724e16c8aefef5f0179a41b~PgDA5E3g90465904659epsmtip2I;
        Thu, 19 Oct 2023 11:55:29 +0000 (GMT)
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
In-Reply-To: <20231018061714.3553817-14-s.hauer@pengutronix.de>
Subject: RE: [PATCH v8 13/26] PM / devfreq: rockchip-dfi: Pass private data
 struct to internal functions
Date:   Thu, 19 Oct 2023 20:55:29 +0900
Message-ID: <001801da0283$27db0f50$77912df0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQFYMiMsP3soeW2GlDsie1R9CxInBwC0pjKqAMVQrjmxSNJDsA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf1AUZRie73Zvb8+CWQ6iDzS6lmjSkeMWOFwQrClHtmTySPlHM9i5W37E
        cXfdHpY1U2SKYSlepAPHCVjIFJ0gF8iPIAc8fkQDDmCUCA6CaHAgCAMDmRLHYvHf877zPN/7
        PO/3fTgie4D542l6M2fSszoS24BevrpZERzqR3HKugKCtvx5HaXtTd0iutjZLaaXR1xiuvxM
        PUqf+us2QncdmZTQjtF+Md3XYMPouZNOQM8OLyP0hT96RHTz+Rfpm599j9HHmpwSunnmjph+
        VOtA6SHXW3T7xbsYfXRQ9aoPYy+yA6ZuqBQw9dYhCeMoz8GYwf5GjPmp9FMm95GSOVVdDpja
        /iKEmXMEMMUPR4H6qf3p0akcq+VMck6vMWjT9Ckx5O69ia8nqiKUVDAVSW8j5Xo2g4shd8ap
        g3el6VYCkvJDrC5zpaVmeZ4M2RFtMmSaOXmqgTfHkJxRqzOqjAqezeAz9SkKPWeOopTKUNUK
        MSk9dWK2AjUOyz8s+LEMywJtG08AKQ6JcHhr1IadABtwGVEHYOPdaUQoZgHsvXVtrVgAcOiq
        TfREktM6g7qxjGgC0HJuj0AaB/Ds1GPxCYDjGLEVliwmuDk+RALM7ahb1SLEghjOLL/hpkiJ
        V+Di6KoLb+I9ePpipcSNUSIIPu6oQNzYg4iEn1cMrGEv+GvBHVQ45nlYO2VDBDtyuDRWJhb6
        PrAwJxsRxr4GbWW9q8kgUSiFOWPVa/53wstFXWIBe8OJ9mqJgP3heG62RBDkAdjjciFCUQlg
        1Q9H18aFwSsX8kTuBAixGVY2hAjtF2D9w3NAcOEJ789/tboHSHjAL7JlAiUQ9g0PrXnwg98d
        z8FOA9K6Lpt1XTbrujzW/4eVALQc+HJGPiOF4ykj9d9lawwZDrD69reo6oBlakbRAkQ4aAEQ
        R0gfjyBGyck8tOzhjziTIdGUqeP4FqBa2bYF8X9GY1j5PHpzIhUeqQyPCA0Lp6kIinzWAxk5
        qZURKayZS+c4I2d6ohPhUv8s0dsJnNeAru/l84eJKyF5uoa+SXXp1vYua43CNuonza/da0+P
        SbeHxeGbou77imKdvSUProl/izr2tLnGQl5aej/6SEvVjXcCOri0vFLf28ljTeMBWUHDQTXS
        Ujx/MSzrRqBvd3dSbA2vPiA2j2wqjM5f8P7lW8PwrnjP4qXU5m2F7cG9qEat7vRMGQ/5+9C7
        Z9nB+NyArxtcrR+MzLUpLHbXQJz05p7dXX6uznHNwL7A5Oo2r33GNy/5HTTs0MvPjFiDudaX
        Wu1xve0TSfOeS/euU42Oe03Yz2n/9DdMOzd2OpHYye0Lrum8j7/p8azSfpJ8MF7z3PzxA1+W
        /V7hH7Z/O4nyqSy1BTHx7L+rQRyfhAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWy7bCSvK6hpGGqwf254hYTb1xhsViz9xyT
        xfwj51gt/j96zWqxaupOFou+Fw+ZLc42vWG32PT4GqvF5V1z2Cw+9x5htPj04D+zxdLrF5ks
        Di5UsbjduILNonXvEXaLgx+esFr83b6JxeLuaz+L42ufsVm03DF1EPFYM28No8eOu0sYPXbO
        usvusWlVJ5vHnWt72Dw2L6n36P9r4NG3ZRWjx/Zr85g9Pm+S85j/+zFjAHcUl01Kak5mWWqR
        vl0CV8arT+tYCh4oVMxcvYytgfGYdBcjJ4eEgIlE59EPLF2MXBxCArsZJZ5uOcoKkZCUmHbx
        KHMXIweQLSxx+HAxRM1zRokN738zgcTZBHQkFvwIBSkXEQiV6D+xgwmkhlmghU1i17LPbBAN
        hxglZi2+wg7SwClgL/HjMdhiYYEMif4FC5lBbBYBVYl/J9aB2bwClhLN625B2YISJ2c+YQFp
        ZRbQk2jbyAgSZhaQl9j+dg4zxJkKEj+fLmOFiItIzO5sY4a4x0lizrJLbBMYhWchmTQLYdIs
        JJNmIelewMiyilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOPq1tHYw7ln1Qe8QIxMH
        I9CHHMxKIryqHgapQrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5NERJITyxJzU5NLUgtgsky
        cXBKNTBF3Cjmby1Ni83qU2E6MEdXtfk2x2qjzW0/Z6zckiJv++6N4UOZCwVz7x61/uZx/GP9
        zOdcf9aYWu5R59PmNJhRZ7ih4/uhvaVMyo3JlvwuC9/G/g3I3RPzTldfVsh2U+kcX+ZgNYWT
        Uml7vra8+u8pPGedBh/D7CrP7akCX/i/Kc5Ost13VVzmCrPF84DaY/cMX4ewLhH4u8TUlJH1
        ldqm/TcKBf9/rv98d6qYZTVPuKqGrtbihcF8SUKH+kO7yk+XP151Zo1Cg0945RuXuQ1z1ocs
        VZxQKL/Ca7Ni8brjbAcfnjBslywL/lMqHVP9f8+XlL6XfEqCgiva4wqDBZa9dPz3t8r25beX
        YclnLZRYijMSDbWYi4oTAYFzOaZtAwAA
X-CMS-MailID: 20231019115529epcas1p2bf7d77ba6a893ea2f37974f98b824232
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231018063753epcas1p45e46817a10b532029db3cc843ce7f6af
References: <20231018061714.3553817-1-s.hauer@pengutronix.de>
        <CGME20231018063753epcas1p45e46817a10b532029db3cc843ce7f6af@epcas1p4.samsung.com>
        <20231018061714.3553817-14-s.hauer@pengutronix.de>
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
> Subject: [PATCH v8 13/26] PM / devfreq: rockchip-dfi: Pass private data
> struct to internal functions
> 
> The internal functions do not need the struct devfreq_event_dev *, so pass
> them the struct rockchip_dfi *. This is a preparation for adding perf
> support later which doesn't have a struct devfreq_event_dev *.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/devfreq/event/rockchip-dfi.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c
> b/drivers/devfreq/event/rockchip-dfi.c
> index bdf421b248df9..d56a33d03db4c 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -73,9 +73,8 @@ struct rockchip_dfi {
>  	unsigned int max_channels;
>  };
> 
> -static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev
> *edev)
> +static void rockchip_dfi_start_hardware_counter(struct rockchip_dfi
> +*dfi)
>  {
> -	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
>  	void __iomem *dfi_regs = dfi->regs;
> 
>  	/* clear DDRMON_CTRL setting */
> @@ -103,18 +102,16 @@ static void
> rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
>  		       dfi_regs + DDRMON_CTRL);
>  }
> 
> -static void rockchip_dfi_stop_hardware_counter(struct devfreq_event_dev
> *edev)
> +static void rockchip_dfi_stop_hardware_counter(struct rockchip_dfi
> +*dfi)
>  {
> -	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
>  	void __iomem *dfi_regs = dfi->regs;
> 
>  	writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_SOFTWARE_EN),
>  		       dfi_regs + DDRMON_CTRL);
>  }
> 
> -static void rockchip_dfi_read_counters(struct devfreq_event_dev *edev,
> struct dmc_count *count)
> +static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct
> +dmc_count *count)
>  {
> -	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
>  	u32 i;
>  	void __iomem *dfi_regs = dfi->regs;
> 
> @@ -132,7 +129,7 @@ static int rockchip_dfi_disable(struct
> devfreq_event_dev *edev)  {
>  	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
> 
> -	rockchip_dfi_stop_hardware_counter(edev);
> +	rockchip_dfi_stop_hardware_counter(dfi);
>  	clk_disable_unprepare(dfi->clk);
> 
>  	return 0;
> @@ -149,7 +146,7 @@ static int rockchip_dfi_enable(struct
> devfreq_event_dev *edev)
>  		return ret;
>  	}
> 
> -	rockchip_dfi_start_hardware_counter(edev);
> +	rockchip_dfi_start_hardware_counter(dfi);
>  	return 0;
>  }
> 
> @@ -167,7 +164,7 @@ static int rockchip_dfi_get_event(struct
> devfreq_event_dev *edev,
>  	u32 access = 0, total = 0;
>  	int i;
> 
> -	rockchip_dfi_read_counters(edev, &count);
> +	rockchip_dfi_read_counters(dfi, &count);
> 
>  	/* We can only report one channel, so find the busiest one */
>  	for (i = 0; i < dfi->max_channels; i++) {
> --
> 2.39.2


Applied it. Thanks

Best Regards,
Chanwoo Choi

