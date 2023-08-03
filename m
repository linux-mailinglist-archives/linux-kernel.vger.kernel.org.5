Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF52A76E279
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjHCIIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjHCIHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:07:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081175FE8;
        Thu,  3 Aug 2023 00:58:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A1D761C77;
        Thu,  3 Aug 2023 07:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D28C433C7;
        Thu,  3 Aug 2023 07:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691049537;
        bh=1qShQjYaIAI9saShacA94XNnUPtQtDSYRE2iho6abzY=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=C6Z+TjeaxxbACJdwD8YPcW4jlhHMmgoVwaIYyg4uJUvfPF5CYLoW01pzEFrcFN1Tm
         KF+k/vxoEt79Vr8Q+h0Sf+/9R/S1PuYtIAHdhpnL32AR+0FVdOp5qpq8pKL1BpY1Sg
         7WmpDrYFRfu5BjvU2kb/A2IJKDF6q6vxhRqgKqWN9IQfAltnErNsWpT1AEVLpp55kP
         NGnSSApl7fQckh1dJ/nxuVPIrRRmpsHPX3YBP7QeDlDlvZB8IUXmLm+3aMzt1I2z3E
         MXVhM9+4dpoKbQFFqaMf+QVrm4TWVIF9Lfc0c0YvipHdkX9i+EjENgFMwMoImInn6w
         4qLhA6bjM/IbA==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4557D27C0054;
        Thu,  3 Aug 2023 03:58:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 03 Aug 2023 03:58:55 -0400
X-ME-Sender: <xms:Pl7LZJ-3J51E4ssLZq_jPPvqAfxn0O339l3SsaufWz-qlKL6uBu8bg>
    <xme:Pl7LZNskbAnLHD40mbyq3rc_Ff6uBSk6z34YhAfVm42v3bkjTc3-gKb2wMHnYbVMO
    t-UvcL1Qcd2FWnsvOU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkedugdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvlefhudeuveekueejuefhveefudefueetuddvieejffehffeiieet
    leejlefftdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnh
    gupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Pl7LZHDLbAcR4nLf7eawaAtZE8Rzj8xxjAjrVk5F8SRsb_648I4qCQ>
    <xmx:Pl7LZNeqPNiZ1OS850XQSFUDHxJ3OhX1EXTuLF5XPrIxH7-uH5vZiA>
    <xmx:Pl7LZOOryb8J4d4EUUBFmhMu29VCRwMUfmmtu9DmeIqgbJIWiPLQDg>
    <xmx:P17LZNebZAJs5jRtVluuuJBE6ckHiEKYKhxHDsTW-VvfWjgXGnnLUA>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 97527B60089; Thu,  3 Aug 2023 03:58:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <b0e203e7-3b3c-40ad-8d99-e43415c0d3c5@app.fastmail.com>
In-Reply-To: <CAMhs-H-2g2QF8NjZOknEop_3UFc_R3YYhpEveU2fc-Ks-iM1bA@mail.gmail.com>
References: <20230802092647.3000666-1-sergio.paracuellos@gmail.com>
 <CAKwvOd=SvHUPd8+sWtqgxghPEciD5sqPiggZx+OOEqxtJrML6Q@mail.gmail.com>
 <9a22ecee-ebb0-437e-bd2b-99b5c6944855@app.fastmail.com>
 <CAMhs-H-2g2QF8NjZOknEop_3UFc_R3YYhpEveU2fc-Ks-iM1bA@mail.gmail.com>
Date:   Thu, 03 Aug 2023 09:58:34 +0200
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Sergio Paracuellos" <sergio.paracuellos@gmail.com>
Cc:     "Michael Turquette" <mturquette@baylibre.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        clang-built-linux <llvm@lists.linux.dev>,
        "kernel test robot" <lkp@intel.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: ralink: mtmips: quiet unused variable warning
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023, at 00:35, Sergio Paracuellos wrote:
> Hi Arnd.=20
>
> El El jue, 3 ago 2023 a las 0:02, Arnd Bergmann <arnd@kernel.org> escr=
ibi=C3=B3:
>> On Wed, Aug 2, 2023, at 23:26, Nick Desaulniers wrote:
>> > On Wed, Aug 2, 2023 at 2:26=E2=80=AFAM Sergio Paracuellos <sergio.p=
aracuellos@gmail.com> wrote:
>> >>
>> >> When CONFIG_OF is disabled then the matching table is not referenc=
ed and
>> >> the following warning appears:
>> >>
>> >> drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable '=
mtmips_of_match' [-Wunused-const-variable]
>> >> 821 |   static const struct of_device_id mtmips_of_match[] =3D {
>> >>     |                          ^
>> >>
>> >> Silence it declaring 'mtmips_of_match' with '__maybe_unused'.
>> >>
>> >> Fixes: 6f3b15586eef ("clk: ralink: add clock and reset driver for =
MTMIPS SoCs")
>> >> Reported-by: kernel test robot <lkp@intel.com>
>> >> Closes: https://lore.kernel.org/oe-kbuild-all/202307242310.CdOnd2p=
y-lkp@intel.com/
>> >> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>> >
>> > I think this is fine; Arnd or Nathan do you have a preference? or t=
houghts here?
>> >
>> > If not, thanks for the patch.
>> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>> >
>> > (I have a slight preference for wrapping the use in `#ifdef CONFIG_=
OF`
>> > since with the approach used by this patch, if all users are removed
>> > we will never get a warning for this var. But it's a weak preferenc=
e;
>> > it's more important to me that we don't have -Werror promote this
>> > warning to a build breakage)
>>=20
>> I don't understand why there are two match tables in the same
>> driver, with almost the same contents. I have not looked very
>> closely here, but why can't we just drop the mtmips_clk_of_match[]
>> table (the one without the .data fields) and use the same
>> table for both? Is this because of the ralink,rt2880-reset entry
>> that is missing in mtmips_of_match, or is that another bug?
>
> ralink,rt2880-reset is for old dts compatibility and only applies to=20
> reset driver. The one with data fields apply for clocks and is needed.

Ok, I see. It still looks like the two tables can simply be
merged by adding the ralink,rt2880-reset entry to mtmips_of_match[],
which will allow it to be used for mtmips_clk_driver (which doesn't
use the data) as well as for mtmips_clk_init() (which doesn't
need get called for ralink,rt2880-reset).

>> I also see that there is both a platform_driver instance for
>> late probing and a list of CLK_OF_DECLARE_DRIVER() entries.
>> Do we need both here?
>
> This system controller driver provide clock and reset controllers.=20
> Clock cannot be a platform driver since we need to set=20
> mips_hpr_frequency at a very early sargento. Reset stuff can be a=20
> platform driver so both of them are needed.

     Arnd
