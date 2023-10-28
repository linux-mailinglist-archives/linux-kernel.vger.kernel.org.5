Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4D17DA7AF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 17:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjJ1PHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 11:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1PHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 11:07:36 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9AC91;
        Sat, 28 Oct 2023 08:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=amPD2Fv/HjzzurFL/5PbBJlVeFR9uLqmO4pACbtWeSM=; b=gh
        Z/6tGXugP/rUAK2/gcHRJsj10N/7Y7i8cEejJllfAcKBCjzDAdvPaG6z1hpubLIdwQVC161N9eff0
        pbyTRX8AAQe+6ngnAO0kTpFtj/d0L1+ADFaj9+GA7vZdzuelUfUTVkfuSdCBQWx0830yQjxzc2Swk
        TPr7a1OI5OFXX+s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qwktF-000PNE-09; Sat, 28 Oct 2023 17:06:17 +0200
Date:   Sat, 28 Oct 2023 17:06:16 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Stitt <justinstitt@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shay Agroskin <shayagr@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        Dimitris Michailidis <dmichail@fungible.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Louis Peens <louis.peens@corigine.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Ronak Doshi <doshir@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com, Jiawen Wu <jiawenwu@trustnetic.com>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com,
        linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] ethtool: Implement ethtool_puts()
Message-ID: <c7fffb8e-3ca7-4a70-8c6a-0b9c3d6d96d1@lunn.ch>
References: <20231027-ethtool_puts_impl-v3-0-3466ac679304@google.com>
 <20231027-ethtool_puts_impl-v3-1-3466ac679304@google.com>
 <8ca4ba13-1bcf-4c7b-91b6-8c77fbe55b30@lunn.ch>
 <CAFhGd8p8mmGfR-eTu_g3k64Z79z=M1xfjTFDhmJ1XaszCtQx1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8p8mmGfR-eTu_g3k64Z79z=M1xfjTFDhmJ1XaszCtQx1w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 06:20:08PM -0700, Justin Stitt wrote:
> On Fri, Oct 27, 2023 at 4:43 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > +/**
> > > + * ethtool_puts - Write string to ethtool string data
> > > + * @data: Pointer to start of string to update
> >
> > Isn't it actually a pointer to a pointer to the start of string to
> > update?
> 
> I suppose.

Its kind of relevant because you increment by the length, which you
can only do because it is **. I also find it a pretty strange API, so
documenting it correctly is important for me.

> 
> FWIW, I just copy-pasted the sprintf doc and tweaked:
> /**
>  * ethtool_sprintf - Write formatted string to ethtool string data
>  * @data: Pointer to start of string to update

So that need fixing as well. I will cook up a patch for this one.

   Andrew
