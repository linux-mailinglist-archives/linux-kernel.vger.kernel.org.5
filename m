Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4410F801653
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441833AbjLAWcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAWcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:32:00 -0500
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC9712A;
        Fri,  1 Dec 2023 14:32:07 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 8617A2B00344;
        Fri,  1 Dec 2023 17:32:02 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 01 Dec 2023 17:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1701469922; x=1701477122; bh=3t
        kYsMWbKQfh7kgu+7rruDUDrB2QAfkIq4Km6a5Mvvo=; b=LOjQ9wXjw4VM9J3b9P
        rwSsQ+E+CzZ6OSUJx0CMjinOlbgQZN3Rhh1SJW/C2qpjTTJcV7Y+psEN4lY2G+Ub
        qpGbWjkTy99IlUAjtuReYp/hb2z+Hq4SFun44JxlvFte/V+pxdserNMsR95EHsTH
        /lMg9fM6tkV9gj4XUH56gCj9ZiEV2uuI5n+KoxVjioItGbME3DZFaDYVS60hLZ7w
        HpwO2Zydt6ay0ZpmkaMh0hVbeFgoxn3NY3qvG24Fm5Y6jPWU+FQoWJuZMrR+LHM5
        7HHF+bSWwBqCq4VjDhf4GUyVdZe33/fxGK+L2/XF5+TEipW/Ow52/jc8fWYzPVEd
        9IMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701469922; x=1701477122; bh=3tkYsMWbKQfh7
        kgu+7rruDUDrB2QAfkIq4Km6a5Mvvo=; b=fT/RiyrgsZhWtJbhIUhKOFxdnURkA
        Wzkzu5sR5UiNAkhrL0ERyd5vMBWhFdzekf4ELeQnJ7lYImJ8haAJD2uk7gv1A1Ge
        13VazCKbT3mmQFPTWbLgkI02mKMsuTQJKpu9nBCbZEicb+6UuFy0nihReEOvArw2
        1Jd9xk2bZ+4E8RvgGpxlajNbjG6fe6VugiorVf8/cfKYW5lYtPm3Lo5/OWU7DOKa
        1D1FjPx/sAGznqapbZJH0EZEXUBzNXxV6TSzCzehMU6lpysGAsVCpwHREDdqv6IN
        Mg98p9ms6N5A0A8s7a/YqbFnJz5o0emQn8tvN+Zxtv1usJGkKXue90m3g==
X-ME-Sender: <xms:4V5qZZnn4bFbmDMmG45kZTZp0rFsmvSSSOIPt2eJIOyEZQjtfoXm-w>
    <xme:4V5qZU0uRSqgIcS5CC6DWOvAn5J1QBspmFww-vKuRnX6V0zVbgSl6-gGmI36v98aC
    hWNq0_WtzRpCA1pJnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:4V5qZfo8apN8dyULmN7Ku45hApYE5RA8EoOtVkiJejanSL8WhK7brg>
    <xmx:4V5qZZn-X353ChUMAH6g0xsfOcdSpDscqreoik1stSrVE_lV81gblA>
    <xmx:4V5qZX2h7Kwh4kM7IG_rxYoe6BKP3jxX3eK3e7pg_i2R6s6e6tUKQw>
    <xmx:4l5qZe8syULkaIcrCbpBN_N-7JlmDhNB_wuUwCscP8Z6E2l0Ip6Qxp5bQYU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0EF3BB60089; Fri,  1 Dec 2023 17:32:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <375165a6-e748-495e-9f74-81bb6496ac7e@app.fastmail.com>
In-Reply-To: <90423946a0dbdcdb7cb3c93b3897683ce07c5e69.camel@redhat.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
 <20231201121622.16343-3-pstanner@redhat.com>
 <32552a65-b540-4baa-9180-e04a278f0ca6@app.fastmail.com>
 <90423946a0dbdcdb7cb3c93b3897683ce07c5e69.camel@redhat.com>
Date:   Fri, 01 Dec 2023 23:31:36 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Philipp Stanner" <pstanner@redhat.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Uladzislau Koshchanka" <koshchanka@gmail.com>,
        "Neil Brown" <neilb@suse.de>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "John Sanpe" <sanpeqf@gmail.com>,
        "Kent Overstreet" <kent.overstreet@gmail.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Kees Cook" <keescook@chromium.org>,
        "David Gow" <davidgow@google.com>,
        "Yury Norov" <yury.norov@gmail.com>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        "Jason Baron" <jbaron@akamai.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        "Ben Dooks" <ben.dooks@codethink.co.uk>,
        "Danilo Krummrich" <dakr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] lib: move pci-specific devres code to drivers/pci/
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023, at 20:00, Philipp Stanner wrote:
>
> The devres functions have different compile rules than the iomap
> functions have.
>
> I would dislike it very much to need yet another preprocessor
> instruction, especially if we're talking about #ifdef PCI within the
> very PCI driver.

Ah right, I had forgotten about s390 zpci being special here,
otherwise we wouldn't need an #ifdef here.

      Arnd
