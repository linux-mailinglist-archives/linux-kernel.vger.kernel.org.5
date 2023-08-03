Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E193E76E2C4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjHCIRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjHCIQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:16:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F53273E;
        Thu,  3 Aug 2023 01:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691050245; x=1691655045; i=deller@gmx.de;
 bh=dfiBLyzpVYXFy3yK9Npb4p0ssJPM4Ud7kOOxIWKf0lc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=hTpTJSzMRHrE8odnN1cBnRxduE6UIe38TX5C5DZ1ZLoPGPJCEbjvwqyflDXFoPDeS2K0VWZ
 SoJ1xHQ6K24uw0rj/LpHTNdmsT4bNnJq9rjKH93aaRdnWXeQHMgDesePXzZQHFc/nesvBsLlv
 1sjzMeVsytP8yOXV+ZDWbHLcDXvBe+4FKSZYAucAnel35/K6YhdMJm5Q0Y9N7n5t5+FZ7WXbf
 sjaA2ayFAXgx1GggdTJiplaeKtWzG7qtDrQVZGVevS7nrf3Wq151lAnsVo6fIJNq4ZtNpm3JT
 QmyaLh7NVrxOmzn6q9x4TOsLfkdkyI3FxD8lUaYAHk838lwBrtcg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.147.53]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC30P-1qYsLg3AXV-00COKo; Thu, 03
 Aug 2023 10:10:45 +0200
Message-ID: <c4a235b1-1cf6-bbb6-36e3-c1823b93a132@gmx.de>
Date:   Thu, 3 Aug 2023 10:10:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] parport: gsc: remove DMA leftover code
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230726150944.2265044-1-arnd@kernel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230726150944.2265044-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m7Yr6Wb3MSwoycBscWmITJuwXxgsSmRov9IejZc36+28cPV3DJW
 b0eihGWihexijDqYEquVSxlIp7+uBh6CpTSKBdGPKjsn6Ctj/aEfr2+h0tqpngL90lMj0/u
 64Wl7LO2g60exyYXzyRvRMH4fm46iNXrRz5VDuJOzLaDvK88NX57Qn+Q9IuIA5lBPRbzqPo
 znQGRqBHtvdMMbz1ZFUDg==
UI-OutboundReport: notjunk:1;M01:P0:XxrnvFKcmrI=;4qmLB6lX5zp+8R4jEBSSdPPD0Ah
 KMVXmXN6fkM2jYkILNbtY6ZzunnARGUVu2UuzOAlYPIkD9/xN9IEvq97y9HZQcppnZbwHBTal
 dfYlu+EWC1SCnvxauBYPtDc5lQWPFnfGnj6xxFLp+p/9YzVUByfcvVOd7LuNwOUwSbfbgafWl
 dZZtaZtVhiCzzv0wSjEAebIpcFUtkHI5cX8KgkgxxVtoPq1BiLByon84ocWiKrkqvVV+fXetK
 PrCJpjm3j4SrZFuY+OFoicWDtlZWUhBUx6Z6LAF8ivaSVeh3vpXQjme19lDdMy4MXE1zIFD3/
 32xlv4+JGbucUWp+La3M94HB/LqQ6TXmt0xPPdpW6umbxkh6JITPnx6S8Zhg/Qep3NoRGZ51L
 n5FKwhMryCsTY0Nr9/wonO4b06i6FVNDhp+DEh62rRVE9ye8tbPh3OT7m4LpSIa5amYeXEOpI
 Q6Pkyg1oH1/sKQ9zrw5MBs8lrHsqTxDpvAfJHPU6GNp0lc57bqh2eK3KJAdFmjBcepG1w7HOx
 oiRMKMUwMaQqOcJoFNec+afgm3I/Zy4kU2IlmI3H26ny0DWqEEsBFju7+9W6x2eDeNZWFbK80
 m40kl8B7zN8J+5EQS8pKazt/Hr58UWmE0/pgz9e4vvYoEXYtGShbiKO+xFGA7uswomfFDEd8e
 SmXDoPLdj8KJ8aqKCJeE2vq+f6i64a9sQb83d23F+HwL2g/GppjNFlJugfHixv0RlEp0yjKSj
 MRX/f3tMtKmPPTRvMUg/q+yS2O0cQZd1yLW9uASL48MX1SezhNfQZKb4AQRIDsuf6Pbna0LvV
 9c9DETsUFPg//a+JgW+2+f/DIKaC5+8RsV1+BwJ3VMQcnaQV+80SlXtzkH72HqctRa5bCFNGO
 V+kzxJF1nO5PkyJJZQYGvVX2f0s0HhpeuQRGSOq19WnEi2EEZ5Ynuj5ezoRjKeQyRdQ0cc23S
 EDIuE0kEn7oMswKQMDS6q5wCkQ8=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 17:09, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> This driver does not actually work with DMA mode, but still tries
> to call ISA DMA interface functions that are stubbed out on
> parisc, resulting in a W=3D1 build warning:
>
> drivers/parport/parport_gsc.c: In function 'parport_remove_chip':
> drivers/parport/parport_gsc.c:389:20: warning: suggest braces around emp=
ty body in an 'if' statement [-Wempty-body]
>    389 |    free_dma(p->dma);
>
> Remove the corresponding code as a prerequisite for turning on -Wempty-b=
ody
> by default in all kernels.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd!

I've added it to the parisc for-next git tree.

Helge

> ---
>   drivers/parport/parport_gsc.c | 28 ++++------------------------
>   drivers/parport/parport_gsc.h |  7 -------
>   2 files changed, 4 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/parport/parport_gsc.c b/drivers/parport/parport_gsc=
.c
> index 0dcc497b0449a..5e4475254bd0a 100644
> --- a/drivers/parport/parport_gsc.c
> +++ b/drivers/parport/parport_gsc.c
> @@ -28,7 +28,6 @@
>   #include <linux/sysctl.h>
>
>   #include <asm/io.h>
> -#include <asm/dma.h>
>   #include <linux/uaccess.h>
>   #include <asm/superio.h>
>
> @@ -226,9 +225,9 @@ static int parport_PS2_supported(struct parport *pb)
>
>   /* --- Initialisation code -------------------------------- */
>
> -struct parport *parport_gsc_probe_port(unsigned long base,
> +static struct parport *parport_gsc_probe_port(unsigned long base,
>   				       unsigned long base_hi, int irq,
> -				       int dma, struct parisc_device *padev)
> +				       struct parisc_device *padev)
>   {
>   	struct parport_gsc_private *priv;
>   	struct parport_operations *ops;
> @@ -250,12 +249,9 @@ struct parport *parport_gsc_probe_port(unsigned lon=
g base,
>   	}
>   	priv->ctr =3D 0xc;
>   	priv->ctr_writable =3D 0xff;
> -	priv->dma_buf =3D NULL;
> -	priv->dma_handle =3D 0;
>   	p->base =3D base;
>   	p->base_hi =3D base_hi;
>   	p->irq =3D irq;
> -	p->dma =3D dma;
>   	p->modes =3D PARPORT_MODE_PCSPP | PARPORT_MODE_SAFEININT;
>   	p->ops =3D ops;
>   	p->private_data =3D priv;
> @@ -286,17 +282,9 @@ struct parport *parport_gsc_probe_port(unsigned lon=
g base,
>   	if (p->irq =3D=3D PARPORT_IRQ_AUTO) {
>   		p->irq =3D PARPORT_IRQ_NONE;
>   	}
> -	if (p->irq !=3D PARPORT_IRQ_NONE) {
> +	if (p->irq !=3D PARPORT_IRQ_NONE)
>   		pr_cont(", irq %d", p->irq);
>
> -		if (p->dma =3D=3D PARPORT_DMA_AUTO) {
> -			p->dma =3D PARPORT_DMA_NONE;
> -		}
> -	}
> -	if (p->dma =3D=3D PARPORT_DMA_AUTO) /* To use DMA, giving the irq
> -                                           is mandatory (see above) */
> -		p->dma =3D PARPORT_DMA_NONE;
> -
>   	pr_cont(" [");
>   #define printmode(x)							\
>   do {									\
> @@ -321,7 +309,6 @@ do {									\
>   			pr_warn("%s: irq %d in use, resorting to polled operation\n",
>   				p->name, p->irq);
>   			p->irq =3D PARPORT_IRQ_NONE;
> -			p->dma =3D PARPORT_DMA_NONE;
>   		}
>   	}
>
> @@ -369,8 +356,7 @@ static int __init parport_init_chip(struct parisc_de=
vice *dev)
>   		pr_info("%s: enhanced parport-modes not supported\n", __func__);
>   	}
>
> -	p =3D parport_gsc_probe_port(port, 0, dev->irq,
> -			/* PARPORT_IRQ_NONE */ PARPORT_DMA_NONE, dev);
> +	p =3D parport_gsc_probe_port(port, 0, dev->irq, dev);
>   	if (p)
>   		parport_count++;
>   	dev_set_drvdata(&dev->dev, p);
> @@ -382,16 +368,10 @@ static void __exit parport_remove_chip(struct pari=
sc_device *dev)
>   {
>   	struct parport *p =3D dev_get_drvdata(&dev->dev);
>   	if (p) {
> -		struct parport_gsc_private *priv =3D p->private_data;
>   		struct parport_operations *ops =3D p->ops;
>   		parport_remove_port(p);
> -		if (p->dma !=3D PARPORT_DMA_NONE)
> -			free_dma(p->dma);
>   		if (p->irq !=3D PARPORT_IRQ_NONE)
>   			free_irq(p->irq, p);
> -		if (priv->dma_buf)
> -			dma_free_coherent(&priv->dev->dev, PAGE_SIZE,
> -					  priv->dma_buf, priv->dma_handle);
>   		kfree (p->private_data);
>   		parport_put_port(p);
>   		kfree (ops); /* hope no-one cached it */
> diff --git a/drivers/parport/parport_gsc.h b/drivers/parport/parport_gsc=
.h
> index 9301217edf12c..d447a568c2570 100644
> --- a/drivers/parport/parport_gsc.h
> +++ b/drivers/parport/parport_gsc.h
> @@ -63,8 +63,6 @@ struct parport_gsc_private {
>   	int writeIntrThreshold;
>
>   	/* buffer suitable for DMA, if DMA enabled */
> -	char *dma_buf;
> -	dma_addr_t dma_handle;
>   	struct pci_dev *dev;
>   };
>
> @@ -199,9 +197,4 @@ extern void parport_gsc_inc_use_count(void);
>
>   extern void parport_gsc_dec_use_count(void);
>
> -extern struct parport *parport_gsc_probe_port(unsigned long base,
> -						unsigned long base_hi,
> -						int irq, int dma,
> -						struct parisc_device *padev);
> -
>   #endif	/* __DRIVERS_PARPORT_PARPORT_GSC_H */

