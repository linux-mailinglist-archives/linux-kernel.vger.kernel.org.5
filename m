Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1F779CE02
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbjILKSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjILKSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:18:34 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE2CCC3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:18:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 1A1E832009AC;
        Tue, 12 Sep 2023 06:18:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 12 Sep 2023 06:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694513906; x=1694600306; bh=Aa
        RVvFPfI2bzRIL7hx+q18RtZvZUqfDW3vPfBd146jo=; b=s0OjQwH0jz+h05xwLU
        jRPvLnJBhKvPubR4at6NcFOEXKZan+jJs7Erwy9WgjvsrNTmuqV23/QIR1IYEXuG
        bfyXoCiVog+CsCYKVXLnqYAC01xrz9IR1UQ05tks1JhrZACKpfbGBg9uTqmgEi/H
        qGLBPGGRq6x52RU+SViSUN9KEvZuKKdyUZDpsv0Th60wFExdxeTJ3pPzbbWohUnw
        d4Glq/UBx66n+TncGg3rf7hJcRvbC7t3TrX1vpJEp3NOsBNAqNRJ0wKUzbv/NPkA
        a/JAdoXGXHsZIJ6cN4M3GAsxokXsJZp0ou/oa90e9E4F0VpKPtaFsoI3SHx9xZjb
        NyPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694513906; x=1694600306; bh=AaRVvFPfI2bzR
        IL7hx+q18RtZvZUqfDW3vPfBd146jo=; b=1v72ewXb4csmUt0GGYqoutngHVH8c
        ItPxAG8lBFcR6DRAEkDlrQrBNdXFvvNXEaxlUMCnI3ViNQiYYrraZrKI/BZkgYyy
        8GoOTgiEtO7JaFWljLLUwHzlc4AIkxZu+SxG7SwnMJQr1PklbHHVTzra/qL2akcU
        6abgBc8KK5xfnNRd/DguVKNMyn0zePrisiJCBCAuWMGjJH6BF/lo+Hw6hh6a6F/1
        D6EQOQUhZJ+eZgr3Tk+vMBo8rFBu4gtdFQaFDxDfvI56P6gryvKzXi2mUrWZoIG2
        ux7PmnUz/4GyI/aZI+NKiFFoHuDT+gvplEjhLUu9qwWTVbPpEbMXKJ5Yg==
X-ME-Sender: <xms:8joAZeW6psE5VRzVpE1JxjHDcBCig1ADRJEITwziH01DHn65B4_EmQ>
    <xme:8joAZalt-WhBdbkkW0J5kMXANZZNbQe4guP3iOBxn-i7KCfJib2P8pN8yxwsD40Ob
    96bSW-99d76GSUow7U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:8joAZSbf5Wf8mmgRre0ddycbDpaxcPvrLbrU4KPqfQDh7esifY4YYQ>
    <xmx:8joAZVWTR7Nyizqt40sDxHrwVYt2Eb6E2YFS5uSYUbARKu_bz6Gehg>
    <xmx:8joAZYndd2i2HUgOBHERNAUj3jjo5onR51hpkJ04J6OvgA07j-qL2w>
    <xmx:8joAZSjZM6zJYAGaqD6F6bOv-WhLl0nBHxksvgUXSIkVX9dUVR8afQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F02E5B60089; Tue, 12 Sep 2023 06:18:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <96c5309d-bb06-486e-a1f8-e3d71b275f13@app.fastmail.com>
In-Reply-To: <20230912083910.15994-1-peter.ujfalusi@linux.intel.com>
References: <20230912083910.15994-1-peter.ujfalusi@linux.intel.com>
Date:   Tue, 12 Sep 2023 12:18:04 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Peter Ujfalusi" <peter.ujfalusi@linux.intel.com>, tiwai@suse.com,
        "Jaroslav Kysela" <perex@perex.cz>
Cc:     "Masahiro Yamada" <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: core: Increase the name array size for debugfs directory
 name
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023, at 10:39, Peter Ujfalusi wrote:

> While the code is correct, we need to silence the compiler somehow.
> It could be done by limiting the range in sprintf like
> sprintf(name, "card%d", idx % SNDRV_CARDS);
> sprintf(name, "card%hhd", idx);
> etc
>
> These are too workaroundish. Increase the name array to 15 instead which
> looks better and only adds 7 bytes on stack.

It looks like we use the same string for kobject_set_name(), so
maybe this would work as well:

--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -278,9 +278,6 @@ static int snd_card_init(struct snd_card *card, struct device *parent,
                         size_t extra_size)
 {
        int err;
-#ifdef CONFIG_SND_DEBUG
-       char name[8];
-#endif
 
        if (extra_size > 0)
                card->private_data = (char *)card + sizeof(struct snd_card);
@@ -364,8 +361,8 @@ static int snd_card_init(struct snd_card *card, struct device *parent,
        }
 
 #ifdef CONFIG_SND_DEBUG
-       sprintf(name, "card%d", idx);
-       card->debugfs_root = debugfs_create_dir(name, sound_debugfs_root);
+       card->debugfs_root = debugfs_create_dir(kobject_name(&card->card_dev.kobj),
+                                               sound_debugfs_root);
 #endif
        return 0;
 

   Arnd
