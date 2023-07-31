Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDDE769758
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjGaNSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjGaNSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:18:45 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A58B10E3;
        Mon, 31 Jul 2023 06:18:43 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 17CE35C00E9;
        Mon, 31 Jul 2023 09:18:40 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 31 Jul 2023 09:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690809520; x=1690895920; bh=80
        1WsE/c7u7Xz/YIkabyJaAJBLEEYxfh2dsjpigtnr4=; b=oqqPOiImVyRAHfJJ2v
        Fx/iYSwDgIpz9bFWFBslp2rtwpJv7JqE/OeODIgQn3MQ/DJ17ndUz+K8JF9zHfxx
        zsa6BETBp+9ld7qttnYRCqyXU6lZdIV5KlLig+EahHb/YuSJKUUKVLw6ruLmN0yJ
        PnchjokJECXNo5s7vvj+ZwHa36DoYvhz7rWJRngnVf7/s6/4H5Ei18ZZUEjzBnA6
        A7VuY2pq6DKytCrYxC0yHDXnOyqDVQM3vflrbbOmsN8vVU4pvCg+zyC5xU3wI5PM
        0GJJEY8i0TE3XloTWsPxT8yaf+l+sqALeLn3AmG0yfbPWW6XpAgdBvZcVmB6ltMd
        hyGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690809520; x=1690895920; bh=801WsE/c7u7Xz
        /YIkabyJaAJBLEEYxfh2dsjpigtnr4=; b=Z5wmAcNoxjSiSFWK1gV3UG11v9WU8
        v9nm3TPjqy76TfNRsoN3t/aT2rT4JvbGyt2HNzGb4F5nPBXVRTfe/BQ2Aw16wVII
        yjH2xwJNWVdGsi1mFoOMNJDrgO8aW7wAvnsngd6gGgFZ9SDhZXpsoxLNOoZeJscx
        wB10mwFJPd3dTk99D5oPJMZ0LC9bai05aEbrXO9b2zHl8luCmzeaN9OKD1WfXB8f
        h6Un5QzmnvV7lB9qctuTAsDuU/pNUqgr4RQkjluQypzdpZBD+wLobb+aMTsupUrT
        ldE0DkK7Jo0wwM3NY08mzcYVHayFP7nFZbd9gsBIC0oiZitwiipok8ZbA==
X-ME-Sender: <xms:r7THZOqpItXO0LF3ah9ouCPxLb0mxwsp0TYa2ajw4CoVQUqo76nBjA>
    <xme:r7THZMqwGLyzII8DvxR5gLwonDtZB_FwVQDeLfhriAhKXXXCDT4BoEOZurEipWzMO
    n0LXch750CpiBUKS2U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeggdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:r7THZDMa8WKtm4EKC8GgNXWgTi823TeZm1jOheAfOXhBP-ovSDJ7kg>
    <xmx:r7THZN5lGWQTD0K-CDc544h-8gOCAsyViUerNncYX1x8mNu4SIBnNA>
    <xmx:r7THZN6XQRntuB_OQybj3UdURV6YT6TQInnOdFRT9W1vUynNIG1g5w>
    <xmx:sLTHZHv1Njg7MmEu3PzvIX3lyEks4Pmi6JcwPbtwCNIjeMjDpfmtcA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 925CBB60089; Mon, 31 Jul 2023 09:18:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <a16db5ac-2b9a-45ab-b693-2f459d689c7d@app.fastmail.com>
In-Reply-To: <20230731110239.107086-3-clamor95@gmail.com>
References: <20230731110239.107086-1-clamor95@gmail.com>
 <20230731110239.107086-3-clamor95@gmail.com>
Date:   Mon, 31 Jul 2023 15:18:16 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Svyatoslav Ryhel" <clamor95@gmail.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Samu Onkalo" <samu.p.onkalo@nokia.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] misc: adps990x: convert to OF
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023, at 13:02, Svyatoslav Ryhel wrote:
> Add ability to use device tree bindings keeping existing setup.

I see that there are no more in-tree users of the old
apds990x_platform_data, so I think it would be best to completely
remove that codepath and merge that structure into struct
apds990x_chip, to simplify the probing and avoid the extra
allocation.

   Arnd
