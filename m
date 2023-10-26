Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9477D84AF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345238AbjJZO15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345237AbjJZO14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:27:56 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF811B9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1698330470;
        bh=+AVbEQ2cO0W9NNjiJtJkceR113CnWKAa4egRigHhpC8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=h6cR5JYN2ZWd9xnbjDhtTfiqFnYa7QwdfKSvUPHy2sPmCvLqnUWcTcYNzMcg+2QuQ
         B7yAAh9KNG9PMgTSwpZDR7BSNH2ogrBNpVHMBnfh9kXusJbz1ED0sLguYX36OkdewS
         DSpW/5oH06539YK83ggl+fQt8QRx7dOo/t2MQRUE=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 248311287229;
        Thu, 26 Oct 2023 10:27:50 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ZZkmk4Z3gm94; Thu, 26 Oct 2023 10:27:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1698330469;
        bh=+AVbEQ2cO0W9NNjiJtJkceR113CnWKAa4egRigHhpC8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Y6dY9H2Ag71Glx/YfwRdXuukMdycq0MxM73+lD+vaQqdcz4au5+rNKmd/9D7ptupA
         QM7lQ0BOpVCJE2L0eyXBZA93gOyWaok2k8pGROHfh6X2YlIKXyQnqNYudbPqejHGVj
         9iBvcEpE9yOctDEZApzyqJziWi6xU6Gayw/agEZQ=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 992DA1281005;
        Thu, 26 Oct 2023 10:27:47 -0400 (EDT)
Message-ID: <f6372ec20b47624799546130e9170bf9ff1d22a5.camel@HansenPartnership.com>
Subject: Re: the nul-terminated string helper desk chair rearrangement
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Lunn <andrew@lunn.ch>, Christoph Hellwig <hch@lst.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Date:   Thu, 26 Oct 2023 10:27:45 -0400
In-Reply-To: <c7445b16-27c9-4182-8b0a-4272ddd2d341@lunn.ch>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
         <20231019054642.GF14346@lst.de> <202310182248.9E197FFD5@keescook>
         <20231020044645.GC11984@lst.de>
         <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
         <202310201127.DA7EDAFE4D@keescook> <20231026100148.GA26941@lst.de>
         <c7445b16-27c9-4182-8b0a-4272ddd2d341@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-26 at 15:44 +0200, Andrew Lunn wrote:
> > > > [1]:
> > > > https://elixir.bootlin.com/linux/v6.6-rc6/source/include/linux/fortify-string.h#L292
> 
> I found that https://elixir.bootlin.com/linux

That's a 404, I think you mean

https://elixir.bootlin.com/linux/latest/source

>  is the best way to find Documentation for functions and structures.
> I would suggest try it first, and only when what fails to start using
> grep.

I just tried it with system_state and it doesn't even find the
definition.  I think it might be because it has annotations which
confuse the searcher (it's in init/main.c as

 enum system_states system_state __read_mostly;

).  If there's any meaningful doc about it, elixir also doesn't find
it.

James
 
