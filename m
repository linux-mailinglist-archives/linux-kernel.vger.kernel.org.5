Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0827D25E5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 22:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjJVUjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 16:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVUjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 16:39:17 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8115E8;
        Sun, 22 Oct 2023 13:39:13 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 986E55C026F;
        Sun, 22 Oct 2023 16:39:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 22 Oct 2023 16:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1698007150; x=1698093550; bh=doL/WjX8M9OyqFyRATCQp2eBX
        behjhN+IYh+66J1hmg=; b=NhuAjGG9FwuP9gm+RnTkX0YLlCpkZgAyE6bSYV38y
        w9wdv0hpAsdyShAodEsnr/OtCLMcKiOTDEWfbqq7VeVf+JS9G3jfOO8Zwbw5fD6A
        iua+zPAhfEkGJMflRn5Q0ycO6agEUYMJSqcCDL2Ola+KA+c3CBazhRqGcBmUF0iW
        PS3yjF8BI8kEkiWLLOoicgy/YejYrAg9bGl+rEpV8Z+ouUG4T+fXZKOJTbcMbtsa
        xShVXqDvkNTyJi6LHUHY0jh3zrOCReiDSnxhcf0vpF7HWLCn6p/fkPycG68I/Jq4
        wgP0RQmX96CBMo/a755JacDuodu+FoFmkgRHTZmzFqxtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698007150; x=1698093550; bh=doL/WjX8M9OyqFyRATCQp2eBXbehjhN+IYh
        +66J1hmg=; b=lenZ7wiurBSbCpf+zohCXtsTK+mugurgBocRWBkqcn32l4fWOmz
        CboJA52bXNVFC6aPXBieczqJsdNa9ga6TtRJ3hz1QCuxXCWZI6Ie+EqVMsRcwkN/
        0cxMrkYZMtcRLdrj2t1/VYSuP0vgCE1yDGb8JhE0uZalcarOtQidKM37jTbp6o/h
        Jif/+SgNhdG3J8wu46jE4u8z9CDf9ykqBQ5+cL3UNCt9rDfZ4ZfzkmzsSCSU1ajq
        gF+kzMcvgr3iNbIiSQyVfTbE3HsSBQfllS3qwGGAq3yNfup0q5vX8wgMncQToG5D
        ++bIZFKNE36Lb6N21XzaYfFt3EH1j4PPYHQ==
X-ME-Sender: <xms:bog1ZcEgQcs6WpGiO0dvuUvU5VVxs6ZxVNWD7EMTrpkmODyDg0MKpQ>
    <xme:bog1ZVV0Cuaa3FjuQ6-m87gOQNEWwaq2jVGsZ2VH0d92-Tkw_fhHBsQEURaqJK4XW
    wJY4bSglhcwtQ>
X-ME-Received: <xmr:bog1ZWI-tEKvEBtSOoB2tNWM6I3EKkXAH6x55aDJT6u7ePYJ9FhJRuH64CBSu3JLdfWD0EoYi56XJp6j4HZj-ryfs4OEaQpPGeoYaMK-5Sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeggdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesthdtredttd
    dtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecu
    ggftrfgrthhtvghrnhepgfehjeeuudeutefggffgteefffduvddvtefgueetueffueeiie
    dugfeigfevkeefnecuffhomhgrihhnpehkrhhorghhrdgtohhmpdhgihhthhhusgdrtgho
    mhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrh
    gvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:bog1ZeEHBhokfRUdIDYmOeifOYRpWswtwUkxUmTLf4MViJOZ34hP3g>
    <xmx:bog1ZSVFVR3Px6GrXXwN1OLOSOxnSqotqV3NywP32Be84ciuLlwERg>
    <xmx:bog1ZRNLcG5R5qyPthdWjJctRzJkdMPN5Q9z4UmbNnWM_SMMS3HiLg>
    <xmx:bog1ZfjxE3RBWpg-wR9tAGy3uH0qo-S3D02U5FcSIC-WruqalXN9lg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Oct 2023 16:39:09 -0400 (EDT)
Date:   Sun, 22 Oct 2023 22:39:08 +0200
From:   Greg KH <greg@kroah.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: usbview 3.1 release
Message-ID: <ZTWIbP7NcKkIRDIH@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it seems to be "release usb tools day", here is the announcement for
the 3.1 release of usbview.

Nothing really fancy happened since the 3.0 release earlier this year,
just some packaging helpers for distros, and some gtk+ fixes for dark
themes and tooltip cleanups.

The package can be downloaded at:
	http://www.kroah.com/linux/usb/usbview-3.0.tar.gz
and the git tree can be found at:
	http://github.com/gregkh/usbview

The shortlog is below.

thanks,

greg k-h

------

Barak A. Pearlmutter (1):
      perform radical pkexecectomy

FeRD (Frank Dana) (1):
      Let Gtk handle tooltips

Greg Kroah-Hartman (5):
      usbview 3.1 release

Matthias Klumpp (2):
      Display correctly when a dark GTK+ theme is used
      Add AppStream metadata
