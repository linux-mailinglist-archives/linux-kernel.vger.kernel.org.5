Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF1B7F2171
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjKTXcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKTXcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:32:08 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33932A2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:32:05 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32fdc5be26dso3210852f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1700523123; x=1701127923; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LivTIn+Mzfm4V76NAY22FThYk4d+bbOVIr11rT80ov4=;
        b=MCq/sn8AonkVKoLqNn5Q1NMxcZGA96HPtArMaHND+OZQm6XlmuJkl4Qx8CrVgtpZnU
         cyd2e6TybP723xQGzjSUoYPXRtmZFSbL2YXaejPIZ29YvVj0xX2VlrLeInq0qpHqgani
         gPQKXYjlfHtXr5caDcTs8beh4TQJyiGGHH3XCsB4jSpY9QlP8ntSdiGKI/ID85tqMGmN
         1qNWsKPtnXXEnPadJZEkswB5fFj/tWNA9POMRODkHRXzonUVoIcJpSwI3rMqmHz0nqP/
         lAybidG9t8ktmrFw7xRkTqrpTPAn82VBa8OOPFZZvDctWGiWvHmbtHqe3nXy53mpkurL
         4nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700523123; x=1701127923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LivTIn+Mzfm4V76NAY22FThYk4d+bbOVIr11rT80ov4=;
        b=c1cwDaZzuK61MQ9WIYZ54YGALHe64uMAl57QMVxJcNRqbmVemUYQQ8JbRezFtu21EQ
         PBN5mKlK1xf9CGYzJl+/0tjmlJ71WHQk0txXvAenj00ovQYwLAHT9wsEneFM8x/JobvW
         l3IaDNUY+NlNKbYf6vpaHmRMEaDFlUjW0pqmlJYa7iEBx3pPOhlM8EgDS4MpVU+R7JLf
         aD8+mRPAygt5HL+f1yk1VLZG/IoOqL+oLuT+Ry/2qO2hKtMFHmAE1abpLRV2pyTwhdGJ
         3OVemSrHdo+6IvtC2fxcLZidAvbVoIoOk4xW0uZZHSWSikU3aEF0DoXUuJh9LDH5oSZX
         17Gw==
X-Gm-Message-State: AOJu0YwnGfNqgyTf4BwjJbslKFwt0XI30ztM2bnppAR8Th7DACD8lsxz
        NUu+wduExndaW494mZ/+Gx2x++AbOYSnhkQCCVAPf1ib+weG5Qa30hI=
X-Google-Smtp-Source: AGHT+IHpcmPExtK67atdaxwWnyiYeCi6k+SQSH5bx2f3uKwQEOJG/Oh95gfg8c1enjKiPJ3dfOaOB0PThA1KqgZYN9o=
X-Received: by 2002:a5d:67cb:0:b0:32d:a2a0:bd6c with SMTP id
 n11-20020a5d67cb000000b0032da2a0bd6cmr5182381wrw.34.1700523123614; Mon, 20
 Nov 2023 15:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20231115185439.2616073-1-yzhong@purestorage.com>
 <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk> <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com>
 <ZVUiLr3g1_i5YmRQ@kbusch-mbp.dhcp.thefacebook.com> <CA+AMecH1TZc3zVm0OF1VwwTBCrLp9mZnOa5zw59yr_W0WbH_uw@mail.gmail.com>
 <ZVWR4Rtr1N7IF6iQ@kbusch-mbp.dhcp.thefacebook.com> <20231117132846.GB7867@lst.de>
 <ZVeW-8cNNVOvNdaR@kbusch-mbp.dhcp.thefacebook.com> <20231120082346.GA11622@lst.de>
 <2fc7ca93-3ad7-4127-b779-76c32f8d9124@grimberg.me>
In-Reply-To: <2fc7ca93-3ad7-4127-b779-76c32f8d9124@grimberg.me>
From:   Randy Jennings <randyj@purestorage.com>
Date:   Mon, 20 Nov 2023 15:31:52 -0800
Message-ID: <CAPpK+O2aitq+ubFRBtjOrUWjdRz=8x3Us9Am4_aVcSo4vAhLYA@mail.gmail.com>
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, hcoutinho@purestorage.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> It doesn't make sense for effects logs to be different per-controller
>> for the same shared namespace. The spec doesn't seem to explicitly
>> prevent that, but hints that all hosts should be seeing the same thing
>> no matter which controller they're connected to:
>
> Also agreed as already indicated in the past mail.

Yuanyuan Zhong already pointed out a situation where the commands
supported portion of the log page could be different.  When upgrading
the subsystem, some controllers may be upgraded sooner than others.
The upgrade could support new commands.

However, I would be surprised if the effects would be different for
currently supported commands, unless a controller was not reporting
effects before and starts reporting them.

Sincerely,
Randy Jennings
