Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461247B843A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242971AbjJDPxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbjJDPxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:53:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48866C1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:53:05 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c1c66876aso432063366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 08:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1696434784; x=1697039584; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=hZDNFZC6WiTT02ULBJ6jIt5/1FUgLgt3WVljz4aDHFY=;
        b=Ls5YFI1iHeKJe7R9ObhOWxWOAdkDFbGSGmuerXZc5oJ9ZvxzqT6Z3Mjw//CJ0RogKo
         U4S5BxK78MCXwDfKUtDC7WT4xdYtO31BSlskDlzX3I/7fLG7SLJnFN2EpfpgWqXJZ8y+
         MHNh27Ai/0BPhPJ5nOpPVvTgMG8+sZpForTwXRqMHqmxcQB6OMLyGYTBquZkH2BNiKoq
         s/Cpajy/G6f0vzNy1GmxkXOAldS/DJkfsYBiZs+GxUW3j9UQQu0l7EIwT8UUlcfo2Cvs
         KGzSHJZ7yhy/+6eVyy5+zI3eCGlogsTFDigrVWoSQiEDiZyeZtowYevjeDNvuDO+40FR
         Apiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696434784; x=1697039584;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZDNFZC6WiTT02ULBJ6jIt5/1FUgLgt3WVljz4aDHFY=;
        b=sgEimNuK9BamWo8FgGGqQTnB6Kby+2Vcqpn/uAqwpf+j0EAJKr3lfs7P7VSUmz9V4H
         6fMmUGa8jqVobDteiqtlts0ACqxgadvKyX4hSybO0tpBMUbSLOglHzZxDRT+hexDNaX6
         g3FUpKgl22xDMIaQ7vEtfsm7JLCbkpg52uSXKPwAVZBCePOFOOU3ts5A2ylw0W39CkQ+
         /YvW4Kxkpnrp5EUfnRV88OddLew3lDEU6uFxPyI8mB6y00Wnsc4iw5l3RIyTpBnl0WfB
         Uw7+gpcO2JcknxJo4F9x9O04PgvAVfAKtKYNWMNCkv10mn8cgSod13FJkFFUq3Ka1av9
         JECw==
X-Gm-Message-State: AOJu0YykRQI476itz5aA9CDv3KCD1km3JdpSTem3LE5sZqcMYZ4Mg+9u
        9cLqcEnmyuo9IipOiNEt/wwd8g==
X-Google-Smtp-Source: AGHT+IHyhGmibidLlX+i+h3CeE+RkyvRJ1BmsD82yqONASQWydT4Q9HuIszDXGT+fFfHOEohePFpdQ==
X-Received: by 2002:a17:906:538f:b0:9a2:1ce5:1243 with SMTP id g15-20020a170906538f00b009a21ce51243mr2663645ejo.60.1696434783543;
        Wed, 04 Oct 2023 08:53:03 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id gh18-20020a170906e09200b009b27d4153cfsm3034424ejb.176.2023.10.04.08.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:53:03 -0700 (PDT)
References: <CVZ2KU4KK5YH.2HVL1F6X93YLL@pogg>
 <20231003222947.374039-1-aliceryhl@google.com>
 <CVZLU74VWMKA.GQXYH7WUNPS4@pogg> <ZR144pugIJQRAFjj@boqun-archlinux>
 <CVZQQCDA444R.KWA6OPEZRIBG@ftml.net>
User-agent: mu4e 1.10.7; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Konstantin Shelekhin <k.shelekhin@ftml.net>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>, alex.gaynor@gmail.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com, gary@garyguo.net,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, tj@kernel.org, wedsonaf@gmail.com,
        yakoyoku@gmail.com
Subject: Re: [PATCH v4 7/7] rust: workqueue: add examples
Date:   Wed, 04 Oct 2023 17:49:30 +0200
In-reply-to: <CVZQQCDA444R.KWA6OPEZRIBG@ftml.net>
Message-ID: <87v8bm5qqp.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

"Konstantin Shelekhin" <k.shelekhin@ftml.net> writes:

>> This is not a problem until nvmet actually uses/switches to Rust, right?
>> ;-) We can certainly improve the API when a real user needs something.
>> Or you know someone is already working on this?
>
> Nope, not at this moment. I have an itch to experiment with Rust and
> iSCSI, but that's my personal toy without any plans to at least propose
> it to the subsystem maintainers yet.

If you are so inclined, I would suggest you take a look at the blk-mq
bindings and the nvme (pci) [1] and null_blk [2] Rust drivers. I am
available if you have any questions!

BR Andreas

[1] https://github.com/metaspace/linux/tree/nvme-next-for-6.6
[2] https://github.com/metaspace/linux/tree/null_blk-next-for-6.6
