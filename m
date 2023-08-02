Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A3776DA5A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjHBWCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjHBWCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:02:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992DE2129;
        Wed,  2 Aug 2023 15:02:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BE8361B13;
        Wed,  2 Aug 2023 22:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DF0C433C7;
        Wed,  2 Aug 2023 22:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691013723;
        bh=fq3cWmTxdhO7mpPCgQ+OwosSWhnsTUfvrL0qkaxNDpA=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=eSD9SlAQ7rbg2TqZs1FdP/PgGOmU65z7JePTWO3d5We+u4brrkJrxovT/SI3iyOfH
         JVlReuJujc8BgIdt2O6XeN15kZioYenOejcdY77w8e4tTlm3xFWv/Kl2wrCWgTpnK/
         xMUBul9dQML3TS5OySlpxJ8ulpn8KS6bqtzqHynqlQqszVJ7DqGwq+L/gbdaFDeRNR
         YURr0fqvlcXrWgqxMdg88Nue82ApcIOJXN+06P8+9mtbkOrHS1hoipXzxiJUwb68we
         5oDq6NOWnMAmho2iSu4YwnNhESZ3+5+6odzEzd6BR8jI++nV3CAImViHRlpztyyYMc
         odpYoK+G8preg==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id EDEBE27C0054;
        Wed,  2 Aug 2023 18:02:01 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 02 Aug 2023 18:02:01 -0400
X-ME-Sender: <xms:WNLKZNWVYqB1BnzgHH-kIgBALkBKjcpcgEFj8Y6Jv3OxnkdTlpWjHw>
    <xme:WNLKZNlF6fozETDCORwW4f2s1qybZXkw59Jmf2JNSgxwqkjHle4SFCWOjR2W7E0w0
    jdsq4r6jez1900NfVc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkedugddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdelhfduueevkeeujeeuhfevfedufeeuteduvdeijeffheffieeiteel
    jeelffdtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnug
    eppehkvghrnhgvlhdrohhrghesrghrnhgusgdruggv
X-ME-Proxy: <xmx:WNLKZJYLgPNGXsizjVniNWNg24UkWht5ff6PSsu8gFJtTvXKk8CffA>
    <xmx:WNLKZAUfGb_-TRwivRvE_HYi1UkciViGtHLnwmOYrO1sScwiq2iT4A>
    <xmx:WNLKZHl3cBoEUeRDSPOF9qEAFDhR3rf-iccz98gWBpTrTYwc_tI0DQ>
    <xmx:WdLKZFX4g4ANJBjULxrdbKClBBZLjFhKGhJw1UFDlOOlf0fu7odMRg>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D12B5B6008F; Wed,  2 Aug 2023 18:02:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <9a22ecee-ebb0-437e-bd2b-99b5c6944855@app.fastmail.com>
In-Reply-To: <CAKwvOd=SvHUPd8+sWtqgxghPEciD5sqPiggZx+OOEqxtJrML6Q@mail.gmail.com>
References: <20230802092647.3000666-1-sergio.paracuellos@gmail.com>
 <CAKwvOd=SvHUPd8+sWtqgxghPEciD5sqPiggZx+OOEqxtJrML6Q@mail.gmail.com>
Date:   Thu, 03 Aug 2023 00:01:25 +0200
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Nick Desaulniers" <ndesaulniers@google.com>,
        "Sergio Paracuellos" <sergio.paracuellos@gmail.com>,
        "Nathan Chancellor" <nathan@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, "kernel test robot" <lkp@intel.com>,
        clang-built-linux <llvm@lists.linux.dev>
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

On Wed, Aug 2, 2023, at 23:26, Nick Desaulniers wrote:
> On Wed, Aug 2, 2023 at 2:26=E2=80=AFAM Sergio Paracuellos <sergio.para=
cuellos@gmail.com> wrote:
>>
>> When CONFIG_OF is disabled then the matching table is not referenced =
and
>> the following warning appears:
>>
>> drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable 'mtm=
ips_of_match' [-Wunused-const-variable]
>> 821 |   static const struct of_device_id mtmips_of_match[] =3D {
>>     |                          ^
>>
>> Silence it declaring 'mtmips_of_match' with '__maybe_unused'.
>>
>> Fixes: 6f3b15586eef ("clk: ralink: add clock and reset driver for MTM=
IPS SoCs")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202307242310.CdOnd2py-l=
kp@intel.com/
>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>
> I think this is fine; Arnd or Nathan do you have a preference? or thou=
ghts here?
>
> If not, thanks for the patch.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> (I have a slight preference for wrapping the use in `#ifdef CONFIG_OF`
> since with the approach used by this patch, if all users are removed
> we will never get a warning for this var. But it's a weak preference;
> it's more important to me that we don't have -Werror promote this
> warning to a build breakage)

I don't understand why there are two match tables in the same
driver, with almost the same contents. I have not looked very
closely here, but why can't we just drop the mtmips_clk_of_match[]
table (the one without the .data fields) and use the same
table for both? Is this because of the ralink,rt2880-reset entry
that is missing in mtmips_of_match, or is that another bug?

I also see that there is both a platform_driver instance for
late probing and a list of CLK_OF_DECLARE_DRIVER() entries.
Do we need both here?

      Arnd
