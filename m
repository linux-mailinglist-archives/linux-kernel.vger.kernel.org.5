Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9C576E431
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbjHCJUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbjHCJT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:19:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4CF3588
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:19:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CC4461D02
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29959C433CA;
        Thu,  3 Aug 2023 09:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691054366;
        bh=+YP6BwBbxh7CWrNRq+3Moki+4QaTvwJk3L5Xzum7BFE=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=WQ3YxRTT3nJ7eseT5Yp+27RAjLRVvVFiqZ5cwiDbF3nD8MYGbSghD20JdS6eGTGoH
         280uFnNjnWK9Y2cxgLw7YdoN4f+J5l/PdLUfn8NQ8NPc48EQuubAcoNMky18V5LJwO
         CkRtm3tYU3ozfJfTrqdDcZzvazTzSiWGLE8Wq3Ti4T8fM03Sq3FWz/Yx70Uoym16Tw
         Y+LZdrpBVof5dgIljW5aGhFZiaE5HmlQsgayBV7S9r7pz95ohpbNDkCOFV2+hPjNsH
         tOQMPESyr96VME5DSLUxTBsk3dFlJN21FUtVujqce1gRMozoGwFENg1zB47q2eGjfS
         PeZ8Q9rYuEcug==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0817D27C005B;
        Thu,  3 Aug 2023 05:19:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 03 Aug 2023 05:19:25 -0400
X-ME-Sender: <xms:HHHLZPsrzXKFVkHuP9C3wu1T_IFEPdlWNQN6oyVy4J1IXPR33Hgqng>
    <xme:HHHLZAdYObTD8BT0Hd-T1ww_ElLN0Nhsf_IAXvq3XVZ188s5oiA74n5nhnKZPYQNE
    lYXS_Oqw11HKZ1V1io>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkedvgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvddttdffjeefgeeggfelfefggefhheeffefftefggfelgeduveevtefh
    feejveeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:HHHLZCwdVXHZn_fnjFm4aPnDSiufcgp4GZhPmXSlLi0_KamjvdWaZA>
    <xmx:HHHLZONf5gqhHUyyoYfFMTnXiLPDdqTJ2Nx-9FIv7dhbi1aZJpH_qA>
    <xmx:HHHLZP-JxBmldlI-Htztv3Mw_uZav5v-ChqYIeDriJnMw19eZ5WhsA>
    <xmx:HHHLZKk7QN9U-KOmNmPLRApwymwuaSPUR_8UNQoM_gucbvL0qPJS3w>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4017DB60089; Thu,  3 Aug 2023 05:19:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <4a3fae63-cf85-4e18-b785-1a438ec761aa@app.fastmail.com>
In-Reply-To: <fecb873aefad8dd4c1d89935cf8f7790e9ba231d.camel@physik.fu-berlin.de>
References: <20230802184849.1019466-3-arnd@kernel.org>
 <D28BDDE3-7FE6-4ACC-98B9-B6AB6D9518A3@gmail.com>
 <fecb873aefad8dd4c1d89935cf8f7790e9ba231d.camel@physik.fu-berlin.de>
Date:   Thu, 03 Aug 2023 11:19:03 +0200
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "D. Jeff Dionne" <djeffdionne@gmail.com>
Cc:     linux-sh@vger.kernel.org, "Rich Felker" <dalias@libc.org>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 3/4] sh: remove superhyway bus support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023, at 10:44, John Paul Adrian Glaubitz wrote:
> On Thu, 2023-08-03 at 16:58 +0900, D. Jeff Dionne wrote:
>> On Aug 3, 2023, at 04:15, Arnd Bergmann <arnd@kernel.org> wrote:
>> >=20
>> > From: Arnd Bergmann <arnd@arndb.de>
>> >=20
>> > superhyway was only referenced on sh4-202, which is now gone, so re=
move it all as well.
>> >=20
>> > I could find no trace of anything ever calling
>> > superhyway_register_driver(), not in the git history but also not o=
n the web, so I assume this has never served any purpose on mainline ker=
nels.
>>=20
>> I don=E2=80=99t know, but I think it is fairly safe to assume that th=
ere were no superhyway implementations other than internal to SuperH Co =
(or Hitachi).  Probably not at ST either.
>>=20
>> I think this board, and infrastructure, can go without affecting any =
actual (even historical) user.  If anyone wants further conformation tha=
t there are/were no users of this in the wild, raise a flag and I will f=
ind out.
>
> OK, I'll think about applying this series. The thing is, we're going t=
o=20
> convert SuperH
> to device trees anyways. We're waiting now Yoshinori to post a rebased=20
> version of the
> patch series.

Applying this first should definitely help with the DT conversion,
especially not having to create a bus specific binding for superhyway
would help, as converting that to DT would be a complete rewrite
but also be untestable without drivers attaching to the bus.

I would also recommend trying to eliminate most of the SoC
support for chips that only support a reference board but no
products or known user of the reference board itself. While
a lot of the conversion could be done fairly mechanical, at
least the clk driver for each chip is a huge effort.

I looked at the clk conversion in the past, as this is not just
needed for the DT work, but also to remove CONFIG_HAVE_LEGACY_CLK.
The patch series I did a while ago renames the sh clk interfaces
to no longer conflict with COMMON_CLK, which should allow it
to coexist with a DT-enabled platform in the same kernel build.
Let me know if you'd like me to dig out and rebase that series,
it probably still applies and may help you here.

     Arnd
