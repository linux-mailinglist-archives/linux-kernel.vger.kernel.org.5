Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3D0799A51
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 19:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237679AbjIIR6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 13:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjIIR6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 13:58:42 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFC01B0;
        Sat,  9 Sep 2023 10:58:38 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7A6203200915;
        Sat,  9 Sep 2023 13:58:35 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Sat, 09 Sep 2023 13:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1694282315; x=1694368715; bh=kz
        fQfbD4H0h1eVP4XE03NxUwAQnVnu2GWtpn9ElctzI=; b=iQHRGv7n2P0Iu0lgUu
        q1VaaMYEWNb3Yljns1enh64TgG2naQ4FGTdscA4l4/WZ6T882PoG41gjfGWu4tbQ
        tbIVAdzqu24XwI7xBvUTvvaWW5mzbYABvw5uGGFwbHyW91BzYObAAauyDLYr15Ji
        VdmfK8wOzQti/Gvg3+spltK5uY45UUZ0deNMblo2Wn4vcu/aC4w73BhMJLo/bABT
        W0S/9VGLNCg6BdC3h8h8AcrfEvng8GtHKlEGhXmbviMlAvk+uydXIbjU6DAGyfq8
        9biylLJx7bLpCP4dWpd/nLPIYBEpNy/yTJnW0JRO80oIetKtXaGdolHC0XaqepCS
        Vz9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694282315; x=1694368715; bh=kzfQfbD4H0h1e
        VP4XE03NxUwAQnVnu2GWtpn9ElctzI=; b=OG8L8gGqmb+H6oqbYvA8drV2fIeG1
        3mX+xmlqNLJonvpBcA53CV2RsDpVvOV6HcIV9GGfwMUGpEgh93PDre9mXPNRO3PS
        YIsLU+T4CgEe5D5WT1Yhs1qxl29gn4AmHEEFjRoNWcfPkeJS01as9j+O8WC+ovC1
        BfZb1CkMUzczJSblw5KVbRlsdYKRoR1nox8SdKSRvatLicew9SuZwsHMPsFJXVY4
        pi7TbRYS9wTW0c2kFdDTh+cu1dPcDZux1yKT8fkRBl87ifaOb2/BL/pJ05JP5Z/j
        YpGLYy3JKslPOBth7JGPub71UOiHAV45Vdj1JRQN7UXTrLR947zKl7i3g==
X-ME-Sender: <xms:SrL8ZPsQAt5YXtlr3Egoccj8k3Wcua0m7I8fRt228As_N7ncroYV_g>
    <xme:SrL8ZAfZfPvwY40c_cMmGOJgXuVevNVqp4sJYF13Obhz8Y1zc0vceN9gljCW3SsYr
    m9MzuNeNdisSFsf9l4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdduhedmnecujfgurhepofgfggfkjghffffhvfevufgtsehttder
    tderredtnecuhfhrohhmpedflfgrnhcujfgvnhgurhhikhcuhfgrrhhrfdcuoehkvghrnh
    gvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpeffffeufefhiedvfeehgeev
    ffffffduvdduhfefjeekgeeviefhuddvgeekvddvhfenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlhesjhhfrghrrhdrtggt
X-ME-Proxy: <xmx:SrL8ZCwK-VrOTsm5ia085m9jcCKunKhxCP2iImHIZoZTPQdUsiBffQ>
    <xmx:SrL8ZONIoEgYxO6ljafhdqFQYbwchY_ZvlCnKgykNghrbYLgRcI7RQ>
    <xmx:SrL8ZP--QjUWDMIV__rsPbGkRVOb_Dshc-AIXD4xlAIU4E2or-FmGQ>
    <xmx:S7L8ZA0PY8dT4Ik5njquLVDDPTnOXzyJMOoTkdaW3tR3ITeN5apa1A>
Feedback-ID: i0fc947c4:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1516015A0091; Sat,  9 Sep 2023 13:58:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-711-g440737448e-fm-20230828.001-g44073744
Mime-Version: 1.0
Message-Id: <5c94f7f4-697f-4388-9243-009c0c2d745f@app.fastmail.com>
In-Reply-To: <CAMw=ZnT-Ck-Y4i-MZAf99U5nzgDaj-q8UPRH_c00JgGMtUy_QA@mail.gmail.com>
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CAMw=ZnT-Ck-Y4i-MZAf99U5nzgDaj-q8UPRH_c00JgGMtUy_QA@mail.gmail.com>
Date:   Sat, 09 Sep 2023 19:57:09 +0200
From:   "Jan Hendrik Farr" <kernel@jfarr.cc>
To:     "Luca Boccassi" <bluca@debian.org>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, tglx@linutronix.de, dhowells@redhat.com,
        vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, bhelgaas@google.com,
        lennart@poettering.net, systemd-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> - the cmdline section is actually optional, just like it's optional to
> pass it on a traditional kexec load, so it should be used if present,
> but skipped if not

Should be an easy fix.

This should be updated in the UKI documentation as for other optional sections it's explicitly marked. I assumed that in the case of an empty cmdline the section would still be included but empty. Or is that semantically different: empty .cmdline section -> no cmdline allowed, no .cmdline section -> user can specify cmdline in bootloader?

> - the dtb section also is optional but supported, and given kexec
> supports loading a new dtb I think this change should support it too
> immediately.  Moreover, we are adding support for multiple DTBs in a
> single UKI (by simply having multiple .dtb sections, and picking the
> one that matches the firmware), as a stretch goal would be nice to
> support that too, but it can also come later

As far as I know dtb is not supported by kexec_file_load at all at the moment. Maybe someone here knows more about this. I'll look into it.

> - also what would it take to support arm64, which is the other major UEFI arch?

I'm not familiar with UEFI on arm64, but I can certainly look into it. I assume it's not gonna be that difficult.
