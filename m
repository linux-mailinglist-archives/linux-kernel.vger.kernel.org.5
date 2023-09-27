Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317C77B030D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjI0LdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjI0LdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:33:08 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70522FC;
        Wed, 27 Sep 2023 04:33:06 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 85ADF3200915;
        Wed, 27 Sep 2023 07:33:05 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 27 Sep 2023 07:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695814385; x=1695900785; bh=tL
        PMR4Ht0/BKoUHoXgDOXEeoVJTsygutTza5hGk75d8=; b=A51ltvg1n8b03SXt96
        acxvKx0++U/ERi2Z7rQSodymHwUR9sQ/ltKJ0RLUpNqMvp9cKe9Dmh/G4GvL7Twr
        etGcWiiZoYfCgdcGpwJkUeAjbLe8Wi7LofByK/E3jpskFD+ZITaG9M/O5I6oipU2
        exKV9VfJ733M3YNkXNCeq//hnWLC/wDx4CvVUsbZO4xOriWpcosW+PVr7vtBnNfZ
        eEeImc16lyJJMpvJ9oJZhNFQzq9lfnDwS9VGWcPS30IfB86CcH+kn1zGA6nKtogY
        O6XA+SHi6mpWMCXYM+DI3AxguojAak0txo9iKZXo5nEQBtvRBBibA8SNQQtWAItd
        jJhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695814385; x=1695900785; bh=tLPMR4Ht0/BKo
        UHoXgDOXEeoVJTsygutTza5hGk75d8=; b=MuKpiGJU5usVvEA9WHMd5Q+DZq6Op
        bvsl210wss94dsHfHs3eyBkCGHLLVK/LTXYouCzRbrelvh6kRzzjm1Ji66e1hS5b
        RoToGd23+c5X7LMfiNlu3tx3spo2WVKuSrX9abQYJYFbLQS68VGfP+fDe0xS+n7l
        DVQzOpNZtw6FuUZWwLT0KQUd5Yxjotf8YDP9Htbhtg7U/THXGU4RudbpfmSFf5P2
        CEYGtDEcVCtKhEuA/tDH3HfDqy/P7N6Y98gWFDrP8ucgEx50CLynUzqmienQKzk6
        QVVlYBLgv98qYj6ZPp+2UpxuYvMa3iBf4QJeisanh12qeV/+0xj0WRAZw==
X-ME-Sender: <xms:8BIUZVucRwfz0gynE5jY9X5jwn3hX1Dgmwu0v9s1dBmBWB1rwYTDhg>
    <xme:8BIUZedw0cVE66DPAv7894g-B28rAKGOwmJ9soA2pVcPhzhDnrm3hvZRvrE01F6FI
    zWgjrQYpBWeifGMOX0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdefgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:8BIUZYz08MNtYPTgDHdBpUPPvNcxpwgyOqcS6nQFasH3UpmENacdtA>
    <xmx:8BIUZcNTQQfp32kJUFRn7Gv2nk1hk7HIUE7ch2eTxvVuAzvcnGQ1zw>
    <xmx:8BIUZV-gGVab80b_b1Q6CABnv6ZEWx5Yv2yv6FRLkYaJ1XDaYTn1Ww>
    <xmx:8RIUZYnpzmszaYlD10Y8hxEtdB6XsaBPZb1tQLe1AqkoflPIMFbIvQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4E056B60089; Wed, 27 Sep 2023 07:33:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <cd24fd64-80e8-4bd3-b77e-ed7cca5f7fee@app.fastmail.com>
In-Reply-To: <ZRQGpg/jX25Wgm8z@kekkonen.localdomain>
References: <20230927072127.2529885-1-arnd@kernel.org>
 <ZRQGpg/jX25Wgm8z@kekkonen.localdomain>
Date:   Wed, 27 Sep 2023 13:32:43 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Sakari Ailus" <sakari.ailus@linux.intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Wentong Wu" <wentong.wu@intel.com>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: pci: intel: ivsc: select V4L2_FWNODE
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023, at 12:40, Sakari Ailus wrote:
>
> V4L2_FWNODE already implies V4L2_ASYNC so V4L2_ASYNC can be removed. I
> somehow thought this only needed V4L2_ASYNC but that indeed is not the
> case.
>
> I'll just drop the line selecting V4L2_ASYNC above if that's fine.
>

Sure, sounds good to me.

    Arnd
