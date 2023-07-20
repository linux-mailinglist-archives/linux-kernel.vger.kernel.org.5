Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D5A75BAC6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 00:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjGTWrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 18:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGTWrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 18:47:04 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762ABE65;
        Thu, 20 Jul 2023 15:47:00 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D7842733;
        Thu, 20 Jul 2023 22:46:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D7842733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689893220; bh=tFdI7CTQuCic0jHrfVESxCPoArF8aqckP43aHZq4XRw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fy1XrfyRidnLQ/BIZvEKZPSlS2qvjsnFuWVdcmAUTlJ73zRlVXvkC2/GGT0qIlb8A
         BO0mcvJ1Cm7GEJd7D+CGh75PDlC1j5W+QK3/rq3wbjZXILsU3uCHOoYxKisR8pYwwO
         w1tjk27BYl9lzMU23BRUAEWvIfTeQUIlN49kspM42fCbqV2iebDnkpapQy6kvqcRB3
         cSwRJnpyE3uYsI9w2mHSebP0N0hHnOEzUoPufRUAPseBiVKecruxVzPQ3PU1pJBRtl
         11SlVMj6a2924ZkpGxTpciyRc0/3gDC1A5f1mEfBr1h2KLZTuvNFXIHxETyhnLH+hs
         EvlYgDcFjV2kw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>, ojeda@kernel.org
Cc:     jani.nikula@linux.intel.com, rdunlap@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        konstantin@linuxfoundation.org, rust-for-linux@vger.kernel.org,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH v8 0/2] docs: Integrate rustdoc into Rust documentation
In-Reply-To: <20230718151534.4067460-1-carlos.bilbao@amd.com>
References: <20230718151534.4067460-1-carlos.bilbao@amd.com>
Date:   Thu, 20 Jul 2023 16:46:59 -0600
Message-ID: <87mszqfbfg.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> Include HTML output generated with rustdoc into the Linux kernel
> documentation on Rust.
>
> Carlos Bilbao:
>  docs: Move rustdoc output, cross-reference it
>  docs: Integrate rustdoc generation into htmldocs

So I've been messing with this a bit, trying the various combinations.

- With no .config file, it behaves as it always did - thanks.

- With CONFIG_RUST=y I get the rustdocs, as expected.  There is a time
  penalty of about 5%, which is unfortunate, but that's the cost of
  progress, I guess.

- Setting CONFIG_RUST=n led to a crash with make complaining:
  "No rule to make target 'rustdoc'".  That isn't something I have been
  able to reproduce, though, so I have no idea what happened there; have
  you ever seen this?

Other than that one bit of strangeness, I think this is about ready to
be applied.

Thanks,

jon
