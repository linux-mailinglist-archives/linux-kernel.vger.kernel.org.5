Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436E17ADB65
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjIYP2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjIYP2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:28:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE65FF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695655637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wckYes9tuj8TsYij0Z4ld4U0TeFfOFKN2Inn7boKvjk=;
        b=F8U6nQRpCpbSrUMGbjMu2UV/TGzyz5rLFiSF+J3JsUrojlmR5oczxxfYAJPezOscY1YmYf
        YUfHLGIQcpntxw2Vn+xRX/eZAzvcIXE5k7xlkirYGbUZ2cLkm0HTZ9BpR7CL4eZ/GEahfI
        JdpOMy9+7kgU2RqLg1Rl6DoFBysDryg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-GYeKA_uAPLy33MFICqjnZA-1; Mon, 25 Sep 2023 11:27:15 -0400
X-MC-Unique: GYeKA_uAPLy33MFICqjnZA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40554735995so40713115e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695655634; x=1696260434;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wckYes9tuj8TsYij0Z4ld4U0TeFfOFKN2Inn7boKvjk=;
        b=ZRPc6CmPl6JVvAXoCjgX4aUHkkF7FXIERBeqU7c7dyRn0rOCSz48JKITjggVBubnAs
         tIBc4P8z+FWOqpjUN+iAjcTERv2bsskri5uVMC3Fsl6f/ku036IM/YIc1XxgDf+Vz6Iq
         XO+nhbVUwxHKRc7eYT2mcusK+wiFglPPaWsRY5CmELPWw1DNn8H6CRGeZBxHOx/QtOdH
         p5jAbvhFoCF1tp30eCx8QS6B2nWwvZNxLd2Q8zyBK8Ra3YJhkzEDQLXs+wIiOlf40S+U
         ygt9amkztZTwUB6AbY2AH1XytuSpVNuaODeUyrvfryQbpcj7BVfQNKXFzVM3oxL7VVWr
         9kAQ==
X-Gm-Message-State: AOJu0YwT7MVpVONNI/ZvKEpWuM0IDcfdP2egpmXFs4hl58jOBA7XQdBS
        UmcSqBNNr0F8NJu9zhXM5BTVdQg7exHqgWKUAi2zCEM5Hikc6aydFekXusd+ALZOtja0v2aGvkk
        WoePmCCAeggz+RDGUtIbIeKb3UPERwSOwVZ8=
X-Received: by 2002:a7b:cbd1:0:b0:405:36e3:e863 with SMTP id n17-20020a7bcbd1000000b0040536e3e863mr6718237wmi.8.1695655634474;
        Mon, 25 Sep 2023 08:27:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnUGDIoj3/uAJn5Af95qg7TvdfuoTHpeIxNzT9laP9ft2YNgz4K0T93YKo0VDl+RqviGHKHA==
X-Received: by 2002:a7b:cbd1:0:b0:405:36e3:e863 with SMTP id n17-20020a7bcbd1000000b0040536e3e863mr6718216wmi.8.1695655634131;
        Mon, 25 Sep 2023 08:27:14 -0700 (PDT)
Received: from rh (p200300c93f1ec600a890fb4d684902d4.dip0.t-ipconnect.de. [2003:c9:3f1e:c600:a890:fb4d:6849:2d4])
        by smtp.gmail.com with ESMTPSA id v21-20020a7bcb55000000b00404719b05b5sm12555738wmj.27.2023.09.25.08.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:27:13 -0700 (PDT)
Date:   Mon, 25 Sep 2023 17:27:12 +0200 (CEST)
From:   Sebastian Ott <sebott@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: Support segments with 0 filesz and misaligned
 starts
In-Reply-To: <87jzsemmsd.fsf_-_@email.froward.int.ebiederm.org>
Message-ID: <84e974d3-ae0d-9eb5-49b2-3348b7dcd336@redhat.com>
References: <20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net> <36e93c8e-4384-b269-be78-479ccc7817b1@redhat.com> <87zg1bm5xo.fsf@email.froward.int.ebiederm.org> <37d3392c-cf33-20a6-b5c9-8b3fb8142658@redhat.com>
 <87jzsemmsd.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463795790-784343621-1695655633=:4500"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463795790-784343621-1695655633=:4500
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 25 Sep 2023, Eric W. Biederman wrote:
>
> Implement a helper elf_load that wraps elf_map and performs all
> of the necessary work to ensure that when "memsz > filesz"
> the bytes described by "memsz > filesz" are zeroed.
>
> Link: https://lkml.kernel.org/r/20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net
> Reported-by: Sebastian Ott <sebott@redhat.com>
> Reported-by: Thomas Weißschuh <linux@weissschuh.net>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
> fs/binfmt_elf.c | 111 +++++++++++++++++++++---------------------------
> 1 file changed, 48 insertions(+), 63 deletions(-)
>
> Can you please test this one?
>

That one did the trick! The arm box booted successful, ran the binaries
that were used for the repo of this issue, and ran the nolibc compiled
binaries from kselftests that initially triggered the loader issues.

Thanks,
Sebastian
---1463795790-784343621-1695655633=:4500--

