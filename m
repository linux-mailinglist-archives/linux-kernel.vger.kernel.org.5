Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B2F7B53D9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbjJBNRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbjJBNRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:17:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5316DAB;
        Mon,  2 Oct 2023 06:17:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3248e90f032so4037390f8f.1;
        Mon, 02 Oct 2023 06:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696252661; x=1696857461; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z+g2r1MHpKADoUhttLvqNozABTTCpwn69LleV+mBSZw=;
        b=edzn5DWU/7iZa5TAFHiTzaPNzXDiRYSHNI6TprTsDbjWg7heWu2ZzW2YA34Num7VY6
         eNogLP7u1qK9+msAtZVB6KC8lQzMC8pVOf5Nt05i0P37/qK2ubNRp/FyIdYxoQgjBrMG
         OILHx/7XkivqrgIVa0IY2FxTFKDPU/kbxD1slyaWAoEMwFepB2JGlsXmfGG4S/j/acih
         4y5oqhFTaIClglqEjTo2tY+Pwbbg6yqr975Y0d/qsNm2foxXhlhV7HOct4p+mECzeIkL
         cbMBInGjHcRCEGuzpjbvUpFNt87Br2bOknZYT62fWrl72/HoIwi5ihRiBZvnJW9+plRJ
         ZqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696252661; x=1696857461;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+g2r1MHpKADoUhttLvqNozABTTCpwn69LleV+mBSZw=;
        b=ishtn1kMpPQaf4WgCtZZ4wcLunFplychJ6hDnTmCDpy73ZUhjGXrtHFdUB6wDjL2B6
         CPR+Z0h4bSaiRNNpnwKfYwyTh7KmiWTPOwjoHwL+cW8l2GFtZpKAeKVG/2a7Fg+80/N+
         Nl/ahy3dq53IyMKjW6q2pxIWCAebqrcqLpT2N7dcZnOwHzF/DUlvOz++R44cR0Db5ASn
         /sVo1f8/CLn2PCncORd2Zb0KjxRGnfi8UnC4fTxePJxfR//tEQ2Drd34H8G83oMdyvNL
         sTHj47rTViUhk7HGgweQX2cwPXiiVMzNx/5qP2juVYfZI69H/s0z+VsmZstz6zfbARa2
         m0vg==
X-Gm-Message-State: AOJu0YyvYgs8pKgY+FYllcXD7eHVks1v3zAd7PrQnlfNchGhEz8vAvW+
        L/x8bIufhkcpU7uPw3J9J6w=
X-Google-Smtp-Source: AGHT+IGeZQu02JzP/Nlg3C7p7vx5VY6jCwGLZ0tAXK3iajF+JbhjNs9qkMjRAcg7uKIaJxyg3RvqMA==
X-Received: by 2002:adf:ec47:0:b0:313:dee2:e052 with SMTP id w7-20020adfec47000000b00313dee2e052mr9195032wrn.26.1696252660381;
        Mon, 02 Oct 2023 06:17:40 -0700 (PDT)
Received: from yoga ([2001:638:904:ffe5:5742:c50f:bd0:6aa6])
        by smtp.gmail.com with ESMTPSA id t11-20020a5d42cb000000b0031431fb40fasm6907727wrr.89.2023.10.02.06.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 06:17:40 -0700 (PDT)
Date:   Mon, 02 Oct 2023 15:17:33 +0200
From:   Sven Frotscher <sven.frotscher@gmail.com>
Subject: Re: [PATCH v4] ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        mario.limonciello@amd.com, git@augustwikerfors.se,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>
Message-Id: <9XKW1S.IRRCIDM08XWX1@gmail.com>
In-Reply-To: <89698b5f-a616-4f49-802a-21326a868c7f@sirena.org.uk>
References: <20230927223758.18870-1-sven.frotscher@gmail.com>
        <46560887-0b6e-42ac-96c3-b4dbc1d7cb61@leemhuis.info>
        <4fa7d39d-dc34-4550-97fa-2b089f364cca@sirena.org.uk>
        <541ac45b-8de7-4fa2-85ee-456d34e60aa9@leemhuis.info>
        <64c78944-4d62-4eda-b92b-3b415fea3333@sirena.org.uk>
        <65KW1S.A6C8VBV29YCM@gmail.com>
        <89698b5f-a616-4f49-802a-21326a868c7f@sirena.org.uk>
X-Mailer: geary/44.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>  > Until someone tests or otherwise provides specific information on 
>> a
>>  > given machine we're just guessing about how it's wired up.
> 
>>  What specific information are we talking about here? I have the 
>> 82YM in
>>  front of me and could help investigate.
> 
> We need to know what magic set of quirks makes the thing work.  Are 
> you
> saying that your patch doesn't actually do that?

It does.

Maybe the non-quirk check (ll. 395-403, seems to be using ACPI) is too 
specific? But I'm a bit out of my depth here, so I can't investigate 
that by myself.


