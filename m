Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFA77FED2E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjK3Kp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3Kp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:45:27 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DCA10D0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:45:31 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231130104529epoutp047c9dacc7ff13d1b29a656176ea8d6aeb~cYL49rQYY1232112321epoutp04E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:45:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231130104529epoutp047c9dacc7ff13d1b29a656176ea8d6aeb~cYL49rQYY1232112321epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701341129;
        bh=s8wTb2fzY9WshxK4eH5EZHAmMVUPHQUf9jclYR3tT/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F4dSvs9JVHGMIVQtrAAQ/mQfB54Y3GynhE4NbV3ebrPklOscto7gLwW+Mv0/+KDk0
         wpeeKJaBHvA+3f+lYk7+U8SQBu2AMV/X1BKfRNFOhWMfIVyw9DlLJlprsSasvS1oTv
         6kT3xzFfSQ+Bx4dJqqiuM3mdDs8fdGDEukorrnr8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20231130104528epcas2p2758ff847bb75631b3bab63a693a4d18f~cYL4fQbol1717017170epcas2p2X;
        Thu, 30 Nov 2023 10:45:28 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.101]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SgtBc2kyVz4x9Pp; Thu, 30 Nov
        2023 10:45:28 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.48.10022.8C768656; Thu, 30 Nov 2023 19:45:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20231130104527epcas2p35fd020b1ea3dfa88419c326a03589ec2~cYL3fkf0S1044410444epcas2p3p;
        Thu, 30 Nov 2023 10:45:27 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231130104527epsmtrp149f2648c5ffd7785a2a6bf24d01c8772~cYL3eyPJ_1276512765epsmtrp1I;
        Thu, 30 Nov 2023 10:45:27 +0000 (GMT)
X-AuditID: b6c32a47-bfdfa70000002726-9c-656867c8b3ad
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.BE.07368.7C768656; Thu, 30 Nov 2023 19:45:27 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231130104527epsmtip108ce628ba056676d0fa69526ad220b4c~cYL3RLAFy0757807578epsmtip19;
        Thu, 30 Nov 2023 10:45:27 +0000 (GMT)
Date:   Thu, 30 Nov 2023 20:20:33 +0900
From:   Youngmin Nam <youngmin.nam@samsung.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Hyunki Koo <hyunki00.koo@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, sbeom.choi@samsung.com,
        Peter Griffin <peter.griffin@linaro.org>,
        =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
        willmcvicker@google.com
Subject: Re: [PATCH v10 3/3] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Message-ID: <ZWhwAQ0pxZsRgwz8@perf>
MIME-Version: 1.0
In-Reply-To: <3e3a39eb-edb5-4d5d-bd30-d447e7605049@linaro.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmhe6J9IxUg5/LBCy2vNrMYtG8eD2b
        xaqlN5gtpmz4wGTR//g1s8X58xvYLTY9vsZqcXnXHDaLGef3MVmcWdzLbrFhxj8Wi7b+B4wW
        n27FWaz69J/Rgc9jwaZSj02rOtk87lzbw+axf+4ado/NS+o9+rasYvRYv+Uqi8fnTXIBHFHZ
        NhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVysplCXm
        lAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjPa
        Nz9lKjjjUvFq8i2mBsYjZl2MnBwSAiYSWza/Zexi5OIQEtjBKPF1xS42COcTo8Tc07OZIJxv
        jBLbN65jhGlZfWg7K0RiL6PEgTdP2EASQgIPGSWu93GB2CwCqhI7Pl9lB7HZBHQltp34B9Ys
        IqAjsf/+anaQZmaBl8wSa6aeYAVJCAuES0xrWApWxCugLPHzzStWCFtQ4uTMJywgNqeAncSV
        mduZIa7YwSGxeEs6hO0iMaXzFhOELSzx6vgWdghbSuJlfxuUnS2x+tclKLtCov1eD9QcY4lZ
        z9rB9jILZEh0HvgMZHMAxZUljtxigQjzSXQc/ssOEeaV6GgTguhUk/g1ZQM0TGQkdi9eATXR
        Q+J7Yzc0fH4CA+7BOfYJjHKzkHwzC8k2CFtHYsHuT2yzgFYwC0hLLP/HAWFqSqzfpb+AkXUV
        o1hqQXFuemqxUYExPIKT83M3MYITsZb7DsYZbz/oHWJk4mA8xCjBwawkwnv9aXqqEG9KYmVV
        alF+fFFpTmrxIUZTYNxMZJYSTc4H5oK8knhDE0sDEzMzQ3MjUwNzJXHee61zU4QE0hNLUrNT
        UwtSi2D6mDg4pRqYQio2XUyyfbzUJlxBrGl18b132mHzY39OUjZzrPmZFiP4arKrSUbG5Qtf
        /Nmfzdo9u0uZ+YTb2hgZ6dtd2Y+FT2vO6Ppg4PEq5qDIwT9PangzlPmevhNp0Uqb3x9lcf2b
        840QScspj7qeKy0R+/3P+mkRi/+FCdk2EXuXXDK46HA2eGXaLMPsSN8jubt5xe5ntTVL7OX8
        v/9C18IlHF9sjJ1WXu1b3bVe/FjDlMl9GgVakbpKVy6cXzjBm0X+xl/+e9u088W+T3E0Scuo
        y99a9b7cd19C/SdFVdXrl59OUS7YP9/41LkTnzOccibd8uEp/f3syCEBZo0bXX6vxXaUxemJ
        G1bOsO3smDzb0maGEktxRqKhFnNRcSIAsjxHJE0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJTvd4ekaqwZ0POhZbXm1msWhevJ7N
        YtXSG8wWUzZ8YLLof/ya2eL8+Q3sFpseX2O1uLxrDpvFjPP7mCzOLO5lt9gw4x+LRVv/A0aL
        T7fiLFZ9+s/owOexYFOpx6ZVnWwed67tYfPYP3cNu8fmJfUefVtWMXqs33KVxePzJrkAjigu
        m5TUnMyy1CJ9uwSujLben2wFPU4VRxuvMzUwzjXpYuTkkBAwkVh9aDtrFyMXh5DAbkaJ1bcn
        s0IkZCRur7wMZQtL3G85AlV0n1Fi0Y+9bCAJFgFViR2fr7KD2GwCuhLbTvxjBLFFBHQk9t9f
        zQ7SwCzwmlli3qEvYJOEBcIlpjUsBSviFVCW+PnmFdTUn4wS3578YoVICEqcnPmEBcRmFtCS
        uPHvJVMXIweQLS2x/B8HSJhTwE7iysztzBMYBWYh6ZiFpGMWQscCRuZVjJKpBcW56bnJhgWG
        eanlesWJucWleel6yfm5mxjB0aSlsYPx3vx/eocYmTgYDzFKcDArifBef5qeKsSbklhZlVqU
        H19UmpNafIhRmoNFSZzXcMbsFCGB9MSS1OzU1ILUIpgsEwenVAOTpcWvSJ6X+QbmgQmuTD6/
        vTPXTK5ZLW4x87Zo553lqw567m645j/tHo92wTZP1Zdv3ppX3S/5M2XlUYP9qx/yGCefu+ZU
        aTND5h/vrIS98x4tlW3SMc5SM60xWjzzmJP2h8uClV8/Tb2zxsOCTWTCzkyGO5UVF2V52WyP
        ii5mM348w+jA5JcH59WX2yfw2K7yfWXuFj+1ifHz6qCpVXqT9vV/uPIupdqlts703SSlD4b3
        Fyx5XmkUPjf6+b5pWxYcdjbaPcNm4xb2Q78uvnC9Gjp34tKYJS6LVupMbJjGn7aYs2wSp+f9
        uffYe8y6Jp9O46w/m2R8Zevs9bvueP564Ngi/YyJ1dbxVeUhV+bdc5RYijMSDbWYi4oTAUYB
        Q4gVAwAA
X-CMS-MailID: 20231130104527epcas2p35fd020b1ea3dfa88419c326a03589ec2
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----ZFAZrZVr5TxXMN5_QF171-VskmmdrLRpnqlQmdet6NoUytTn=_440ee_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200506080258epcas2p4f242fb66a2145f76b0e108014ee351fb
References: <20200506080242.18623-1-hyunki00.koo@samsung.com>
        <CGME20200506080258epcas2p4f242fb66a2145f76b0e108014ee351fb@epcas2p4.samsung.com>
        <20200506080242.18623-3-hyunki00.koo@samsung.com>
        <3e3a39eb-edb5-4d5d-bd30-d447e7605049@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------ZFAZrZVr5TxXMN5_QF171-VskmmdrLRpnqlQmdet6NoUytTn=_440ee_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Nov 30, 2023 at 10:19:40AM +0000, Tudor Ambarus wrote:
> I'm trying my luck on a 3 year old patch, fingers crossed :).
> 
> On 5/6/20 09:02, Hyunki Koo wrote:
> 
> Hi, Hyunki!
> 
> > Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> > 
> > This is required for some newer SoCs.
> 
> Is the 32-bit access mandatory for the newer SoCs? I'm asking because I
> see a SError Interrupt when using 8-bit accesses on gs101 (pixel6). Can
> you confirm if gs101 USI UART is restricted to only 32 bit data width
> accesses?
> 
> If 32-bit accesses are mandatory, we should impose this restriction so
> that we avoid crashing the kernel on wrong user configuration. I have
> some patches ready, waiting just for a confirmation.

Hi.

Yes, some newer exynos SoCs allow only 32bit access to UART TX / RX register.
This feature is related with SoC Bus architecture so it should be controlled by "reg-io-width" in
UART device tree.

Thanks.

> 
> Below is the crash that I see. Thanks!
> 
> [    1.215459] SError Interrupt on CPU6, code 0x00000000be000411 -- SError
> [    1.215464] CPU: 6 PID: 1 Comm: swapper/0 Not tainted
> 6.6.0-rc1-00021-g31831088e862-dirty #88
> [    1.215468] Hardware name: Oriole DVT (DT)
> [    1.215470] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS
> BTYPE=--)
> [    1.215473] pc : s3c24xx_serial_console_putchar+0x1c/0x90
> [    1.215487] lr : uart_console_write+0x50/0x6c
> [    1.215491] sp : ffff80008007b6c0
> [    1.215492] x29: ffff80008007b6c0 x28: 0000000000000000 x27:
> ffffc0ec2c855900
> [    1.215498] x26: ffffc0ec2bdee008 x25: 0000000000000000 x24:
> ffffc0ec2c529a40
> [    1.215501] x23: ffff80008007b830 x22: ffffc0ec2c9578b9 x21:
> ffffc0ec2c9b8330
> [    1.215504] x20: ffffc0ec2aa0d684 x19: ffffc0ec2c95788a x18:
> 0000000000000006
> [    1.215507] x17: 0000000000000000 x16: 0000000000000001 x15:
> ffff80008007b460
> [    1.215510] x14: 0000000000000000 x13: 64656c62616e6520 x12:
> 5d30434153797474
> [    1.215513] x11: 5b20656c6f736e6f x10: 63203a6b746e6972 x9 :
> 656c62616e65205d
> [    1.215515] x8 : 304341537974745b x7 : 205d303534353132 x6 :
> 322e31202020205b
> [    1.215518] x5 : ffffc0ec2c9b82f0 x4 : ffffc0ec2b5bc1c0 x3 :
> ffff800080061000
> [    1.215521] x2 : 0000000000000111 x1 : 0000000000000020 x0 :
> ffffc0ec2c9b8330
> [    1.215526] Kernel panic - not syncing: Asynchronous SError Interrupt
> [    1.215528] CPU: 6 PID: 1 Comm: swapper/0 Not tainted
> 6.6.0-rc1-00021-g31831088e862-dirty #88
> [    1.215531] Hardware name: Oriole DVT (DT)
> [    1.215532] Call trace:
> [    1.215533]  dump_backtrace+0x90/0xe8
> [    1.215542]  show_stack+0x18/0x24
> [    1.215547]  dump_stack_lvl+0x48/0x60
> [    1.215555]  dump_stack+0x18/0x24
> [    1.215559]  panic+0x31c/0x378
> [    1.215565]  nmi_panic+0x8c/0x90
> [    1.215569]  arm64_serror_panic+0x6c/0x78
> [    1.215571]  do_serror+0x3c/0x70
> [    1.215574]  el1h_64_error_handler+0x30/0x48
> [    1.215581]  el1h_64_error+0x64/0x68
> [    1.215583]  s3c24xx_serial_console_putchar+0x1c/0x90
> [    1.215588]  s3c24xx_serial_console_write+0xb8/0xfc
> [    1.215593]  console_flush_all.isra.0+0x168/0x3ac
> [    1.215600]  console_unlock+0x58/0xdc
> [    1.215604]  vprintk_emit+0x1a8/0x2b0
> [    1.215608]  vprintk_default+0x38/0x44
> [    1.215613]  vprintk+0xbc/0xd0
> [    1.215617]  _printk+0x5c/0x84
> [    1.215621]  register_console+0x2a0/0x400
> [    1.215625]  serial_core_register_port+0x61c/0x658
> [    1.215630]  serial_ctrl_register_port+0x10/0x1c
> [    1.215634]  uart_add_one_port+0x10/0x1c
> [    1.215639]  s3c24xx_serial_probe+0x360/0x6fc
> [    1.215644]  platform_probe+0x68/0xc8
> [    1.215650]  really_probe+0x148/0x2b0
> [    1.215653]  __driver_probe_device+0x78/0x12c
> [    1.215656]  driver_probe_device+0x3c/0x15c
> [    1.215658]  __driver_attach+0x90/0x19c
> [    1.215661]  bus_for_each_dev+0x78/0xd4
> [    1.215668]  driver_attach+0x24/0x30
> [    1.215670]  bus_add_driver+0xe8/0x1f8
> [    1.215672]  driver_register+0x5c/0x124
> [    1.215675]  __platform_driver_register+0x28/0x34
> [    1.215678]  samsung_serial_init+0x30/0x8c
> [    1.215687]  do_one_initcall+0x7c/0x1c0
> [    1.215689]  kernel_init_freeable+0x1bc/0x284
> [    1.215695]  kernel_init+0x24/0x1dc
> [    1.215697]  ret_from_fork+0x10/0x20
> [    1.215701] SMP: stopping secondary CPUs
> [    1.215708] Kernel Offset: 0x40ebaa200000 from 0xffff800080000000
> [    1.215710] PHYS_OFFSET: 0xffffc18980000000
> [    1.215711] CPU features: 0xc0000001,70020143,1000720b
> [    1.215714] Memory Limit: none
> > 
> > Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Tested on Odroid HC1 (Exynos5422):
> > Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  drivers/tty/serial/samsung_tty.c | 62 ++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 57 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> > index 326b0164609c..6ef614d8648c 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > @@ -154,10 +154,33 @@ struct s3c24xx_uart_port {
> >  #define portaddrl(port, reg) \
> >  	((unsigned long *)(unsigned long)((port)->membase + (reg)))
> >  
> > -#define rd_reg(port, reg) (readb_relaxed(portaddr(port, reg)))
> > +static u32 rd_reg(struct uart_port *port, u32 reg)
> > +{
> > +	switch (port->iotype) {
> > +	case UPIO_MEM:
> > +		return readb_relaxed(portaddr(port, reg));
> > +	case UPIO_MEM32:
> > +		return readl_relaxed(portaddr(port, reg));
> > +	default:
> > +		return 0;
> > +	}
> > +	return 0;
> > +}
> > +
> >  #define rd_regl(port, reg) (readl_relaxed(portaddr(port, reg)))
> >  
> > -#define wr_reg(port, reg, val) writeb_relaxed(val, portaddr(port, reg))
> > +static void wr_reg(struct uart_port *port, u32 reg, u32 val)
> > +{
> > +	switch (port->iotype) {
> > +	case UPIO_MEM:
> > +		writeb_relaxed(val, portaddr(port, reg));
> > +		break;
> > +	case UPIO_MEM32:
> > +		writel_relaxed(val, portaddr(port, reg));
> > +		break;
> > +	}
> > +}
> > +
> >  #define wr_regl(port, reg, val) writel_relaxed(val, portaddr(port, reg))
> >  
> >  /* Byte-order aware bit setting/clearing functions. */
> > @@ -1974,7 +1997,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
> >  	struct device_node *np = pdev->dev.of_node;
> >  	struct s3c24xx_uart_port *ourport;
> >  	int index = probe_index;
> > -	int ret;
> > +	int ret, prop = 0;
> >  
> >  	if (np) {
> >  		ret = of_alias_get_id(np, "serial");
> > @@ -2000,10 +2023,27 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
> >  			dev_get_platdata(&pdev->dev) :
> >  			ourport->drv_data->def_cfg;
> >  
> > -	if (np)
> > +	if (np) {
> >  		of_property_read_u32(np,
> >  			"samsung,uart-fifosize", &ourport->port.fifosize);
> >  
> > +		if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
> > +			switch (prop) {
> > +			case 1:
> > +				ourport->port.iotype = UPIO_MEM;
> > +				break;
> > +			case 4:
> > +				ourport->port.iotype = UPIO_MEM32;
> > +				break;
> > +			default:
> > +				dev_warn(&pdev->dev, "unsupported reg-io-width (%d)\n",
> > +						prop);
> > +				ret = -EINVAL;
> > +				break;
> > +			}
> > +		}
> > +	}
> > +
> >  	if (ourport->drv_data->fifosize[index])
> >  		ourport->port.fifosize = ourport->drv_data->fifosize[index];
> >  	else if (ourport->info->fifosize)
> > @@ -2587,6 +2627,18 @@ module_platform_driver(samsung_serial_driver);
> >   * Early console.
> >   */
> >  
> > +static void wr_reg_barrier(struct uart_port *port, u32 reg, u32 val)
> > +{
> > +	switch (port->iotype) {
> > +	case UPIO_MEM:
> > +		writeb(val, portaddr(port, reg));
> > +		break;
> > +	case UPIO_MEM32:
> > +		writel(val, portaddr(port, reg));
> > +		break;
> > +	}
> > +}
> > +
> >  struct samsung_early_console_data {
> >  	u32 txfull_mask;
> >  };
> > @@ -2612,7 +2664,7 @@ static void samsung_early_putc(struct uart_port *port, int c)
> >  	else
> >  		samsung_early_busyuart(port);
> >  
> > -	writeb(c, port->membase + S3C2410_UTXH);
> > +	wr_reg_barrier(port, S3C2410_UTXH, c);
> >  }
> >  
> >  static void samsung_early_write(struct console *con, const char *s,
> 
> 

------ZFAZrZVr5TxXMN5_QF171-VskmmdrLRpnqlQmdet6NoUytTn=_440ee_
Content-Type: text/plain; charset="utf-8"


------ZFAZrZVr5TxXMN5_QF171-VskmmdrLRpnqlQmdet6NoUytTn=_440ee_--
