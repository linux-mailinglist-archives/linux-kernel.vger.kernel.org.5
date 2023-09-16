Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC517A324C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 21:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbjIPTmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 15:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjIPTma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:42:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD929CDE;
        Sat, 16 Sep 2023 12:42:25 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694893343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/zPwTVnbIqykq0xrJwLN9r6avPOKHnWBnlaBD7Ntd/o=;
        b=CUQAEeiOCW0UB0mZHKKbATmxrT7v104AXTk8BgIS3LnhJdkwcK31VIKNUWTyr5NJ5FDSAZ
        1rUmkomzu0i8ra8Pr7MuVj6uXx2bx2AvsuHAsgoTtNXk1SlphGsF2Tko1c6bGtCosz+5D3
        3LvB5+XWrTyiZslCvN25C026vuzPMwe37ifQkKb5hvuaQ1IXWgjVHVi1QG1ERhp6yVLoCG
        KEjXv3lRy4sKTNf9zIytvVhfEZiamkJbj8QmGaOgd3j5PMU/plPNL9TqQlN3PM7t/8qtdr
        r8HTYvNQEPG5ZOF1NNpsGWfBpFE4WC9xOJQFYPlGWWvKaI1nzHahesMl0GR2sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694893343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/zPwTVnbIqykq0xrJwLN9r6avPOKHnWBnlaBD7Ntd/o=;
        b=/s+j74ZDjoLeO5pQcnU/VyXRmqc0m+3/h/bRCXztbsATbbfdFH/5imwYhMMMSk+geHP+hf
        BWo+CyCuYQ4k1qBQ==
To:     Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>,
        Thierry Reding <treding@nvidia.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Davis <afd@ti.com>,
        Matthew Howell <matthew.howell@sealevel.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-mediatek@lists.infradead.org, Lukas Wunner <lukas@wunner.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Russell King <linux@armlinux.org.uk>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Hongyu Xie <xiehongyu1@kylinos.cn>,
        Jiamei Xie <jiamei.xie@arm.com>, Rob Herring <robh@kernel.org>,
        delisun <delisun@pateo.com.cn>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Yangtao Li <frank.li@vivo.com>,
        Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Baruch Siach <baruch@tkos.co.il>,
        Sherry Sun <sherry.sun@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sergey Organov <sorganov@gmail.com>, Tom Rix <trix@redhat.com>,
        Marek Vasut <marex@denx.de>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Jacky Huang <ychuang3@nuvoton.com>,
        Shan-Chun Hung <schung@nuvoton.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Lucas Tanure <tanure@linux.com>,
        linux-amlogic@lists.infradead.org,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-actions@lists.infradead.org,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yuan Can <yuancan@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-unisoc@lists.infradead.org,
        Kevin Cernekee <cernekee@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Lech Perczak <lech.perczak@camlingroup.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Isaac True <isaac.true@canonical.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nick Hu <nick.hu@sifive.com>,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        linux-riscv@lists.infradead.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-stm32@st-md-mailman.stormreply.com,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Hammer Hsieh <hammerh0314@gmail.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Timur Tabi <timur@kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH tty v1 00/74] serial: wrappers for uart port lock
In-Reply-To: <1446dc6-5ab0-629-45c8-3b7d8c76367d@linux.intel.com>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
 <1446dc6-5ab0-629-45c8-3b7d8c76367d@linux.intel.com>
Date:   Sat, 16 Sep 2023 21:48:14 +0206
Message-ID: <878r95nbvt.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-15, Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> Would this also be useful to enable printing to console while under
> port's lock (by postponing the output until the lock is released)?
>
> E.g., 8250_dw.c has had this commented out since the dawn on time:
>         /*
>          * FIXME: this deadlocks if port->lock is already held
>          * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
>          */

Yes, this will fix such issues. However, only for consoles that are
converted to the new NBCON console type.

Good news, the 8250 driver will be the flagship driver that is converted
as part of the rework. So this particular issue will be solved then. I
will try to remember this so that I can remove the FIXME in the series.

Thanks for mentioning it.

John
