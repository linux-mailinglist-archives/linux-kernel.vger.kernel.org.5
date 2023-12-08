Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2549E80AB6C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574551AbjLHR5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjLHR5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:57:03 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8412C10D8;
        Fri,  8 Dec 2023 09:57:09 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b8b782e142so1659574b6e.1;
        Fri, 08 Dec 2023 09:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702058229; x=1702663029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1WnAv4rqpkRBBu2iSDQkGPMJXuvelVfqmuGMjwRzKqU=;
        b=TEszEjn5gOY9Xv0zNJCcQBJqicTrKDF64CMC5XkEeJlUhslKGU/3HhrH3w00NK7dwc
         801RR/xNTHWub3KzmqWF2eRhvCSn+7zSj5AQ1W+cUKuRxUoK4ntTpDXj7PJpOeSaDTPp
         p5kzsMdP46RWnzY/VCOU0OJhDsA5aEBHl2htPMXEMF/2NMKw5G/ltJAAqkd1Z31fzKAJ
         +SFoeJTIHnZFfto1gzls0GgUWGvnWEt6njhtluQDrL3Y+n3F9ODN7p28au46hPg1iUEF
         BiBt1xocWMURP1I35l4F2TP0CtGf7bj9j5LVC+df/DKrk3wRj/70g09vGH5JIXR0uX9v
         GVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702058229; x=1702663029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WnAv4rqpkRBBu2iSDQkGPMJXuvelVfqmuGMjwRzKqU=;
        b=OoVxvjPOWW6zYsPjzQiTyS3F7IPm7ihl+M5rlsk/EHAQ7pdj1CMw80zhnw1rh+ZwBH
         376fozIFWIlkkZgHIyWX5cCY+YwCsyXGwmm8IT0JoB7R0CW+j2rCcc1JXPcQJoSw5TS0
         wyJAVPsUYHU2iDyUCbL/6gJvuUHJtwuuScv+TOJ93h4emHDiqY3PMKAWZ2iBt8KBd/pt
         qzk0j84eRR8x1l8bciN1kpV/0nepu3fSYlyB90YcUKk12ur/PPsYpWHdn1u6pIx0gXfE
         LkDMy4zd9Wk5E9D7FpPMONJfikr4+vP9o3OP9bsF0MNj9IywBnEUvAz3HDVRE4YN2g6z
         RH6w==
X-Gm-Message-State: AOJu0YwsHfo4rh6rVO/e1Obqn02dEvKAsfkjxW919t5od6Hjjh+o6M7G
        8Ya96roGufNyC8feGvrm3+I=
X-Google-Smtp-Source: AGHT+IEcLUyHhL2CbqRWJAIQmBN+MG0RexK0ve1YG4CeCuQqr0pIP7EVVtSqrL+KlA817FR2+jDtIQ==
X-Received: by 2002:a05:6808:198d:b0:3b5:75ad:5b73 with SMTP id bj13-20020a056808198d00b003b575ad5b73mr547697oib.13.1702058228721;
        Fri, 08 Dec 2023 09:57:08 -0800 (PST)
Received: from google.com ([187.174.134.190])
        by smtp.gmail.com with ESMTPSA id j5-20020a544805000000b003af644e6e81sm398580oij.45.2023.12.08.09.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:57:08 -0800 (PST)
Date:   Fri, 8 Dec 2023 17:57:05 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        rrameshbabu@nvidia.com
Subject: Re: [PATCH v2 2/2] Input: i8042: Add a quirk for Framework 16" laptop
Message-ID: <ZXNY8a_Zja9rSupQ@google.com>
References: <20231206212140.7458-1-mario.limonciello@amd.com>
 <20231206212140.7458-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206212140.7458-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 03:21:40PM -0600, Mario Limonciello wrote:
> The Framework 16" laptop doesn't have a PS/2 keyboard. At bootup the
> following messages are emitted:
> 
> i8042: PNP: No PS/2 controller found.
> i8042: PNP: Probing ports directly.
> i8042: Can't read CTR while initializing i8042
> i8042: probe of i8042 failed with error -5
> 
> There are no PNP devices as those listed in `pnp_kbd_devids` but
> i8042_pnp_init() ignores this and still runs and will continue to
> try to probe.
> 
> As there is no PS/2 keyboard or mouse in this laptop, set a quirk
> to avoid this behavior.

I believe the proper fix for this is for the firmware not report i8042
as present by properly setting up FADT. Please take a look at
arch/x86/kernel/acpi/boot.c::acpi_parse_fadt() and how it sets flag
X86_LEGACY_I8042_FIRMWARE_ABSENT.

It will still say "PNP: No PS/2 controller found" which is an
"informational" message, but should not try to probe ports directly and
report errors.

Thanks.

-- 
Dmitry
