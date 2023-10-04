Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D677B8472
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242939AbjJDQDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242499AbjJDQDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:03:37 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB387F0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:03:31 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bff936e10fso13479481fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696435410; x=1697040210; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NzdDVRsopfAtWWCABJTWdwkjTdrlFGdNQruRANZXZ9U=;
        b=ZHBFfJD7SfDPPTg/DXwHObYqYy9EkVB6/hBR2KCVL6iFYiftNPHOrcxqkulDE63OUS
         MNKVawq4ak3tM4LdBgMvNxS/LDp7jkfGbFj/kaaMhaYBmppSUmvZevVvVesqcsAEILhm
         sTYKBVmtw+c3CYbUXrN4A91Id7ytHGR4uBybGsnUInvCJ6QQVbijJ+UIOweGziUtGocJ
         +ClnP6dJigZ5CbqCfThDEDZ1qVwtVzllCLurIcom5AnFyPv7lHzegVG8RJ/98OdwF3Yx
         WB7DDpu9Jmp9YMEJ62/NIw8DP73DxKd+oPej505dwfSYjPOkoI7eotkIJQl2yWK2ROGD
         5qYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696435410; x=1697040210;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NzdDVRsopfAtWWCABJTWdwkjTdrlFGdNQruRANZXZ9U=;
        b=JCE3pUtxHb75hoi2lJ4UN+uF3K8groTTTFnnd1Eh3utyaURl7ABYq3BeA/tSXtus7B
         LbHZ5EYiHdpL1kJN1u+BlO1UY8nz0lj8FmqavcGp+XUP95aPaml90eiBrW6rGw0H/dnx
         +ZRiE53h/WS+TI05xEpbmXpdt+D9tf2n2e1+T+glibOTKY903hD1C63QV+4ZjGvcoLuT
         PxkLh9fd4wL54u/BPe3qv2C2oq3h0a+HQMvba+D9QxRNW7hPfc2hsmNxHDwLbE0R6TIx
         RvYKbmYwKPHRRXqycQ5gcoIfJdEx/xRi6jnTDIFUvWpsJYzXjTm97ZzFez8Z4BUvbdS7
         Wxnw==
X-Gm-Message-State: AOJu0Yw2ojkAcVak1RGnkY1CNWBLU/xFwv1FQi7UC0VP81WHBx8iaaNG
        jiA6h8TFFR0WuNLNLAI7PrWiPakgTvFbtjqCfG0=
X-Google-Smtp-Source: AGHT+IGAD0mOd7H2cYf7lV1yGwmf/2ROW7JkALTfe1t6Wx0/6W5wvw6V3P0v+9G1XcWdMiAJ6QO6ZLaS0DMs2CeKtZQ=
X-Received: by 2002:a05:6512:202d:b0:4fb:8938:48ab with SMTP id
 s13-20020a056512202d00b004fb893848abmr30828lfs.16.1696435409548; Wed, 04 Oct
 2023 09:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231003211650.349521-1-kbosch@protonmail.com>
 <20231004040349.GA53158@workstation.local> <CAM3OPxw3o7z1opx3br0296muuGphF08_qJxfY2fcQTUJVG5o2w@mail.gmail.com>
In-Reply-To: <CAM3OPxw3o7z1opx3br0296muuGphF08_qJxfY2fcQTUJVG5o2w@mail.gmail.com>
From:   Kai Bosch <kellerassel@gmail.com>
Date:   Wed, 4 Oct 2023 18:03:18 +0200
Message-ID: <CAM3OPxy7zO=fGr=AH9FTOJghWiR7VccHLYc9pmf7SDfF_V7JcA@mail.gmail.com>
Subject: Re: [PATCH] Firewire: IP over IEEE 1394: replaced implicit mentions
 of unsigned int
To:     Kai Bosch <kellerassel@gmail.com>, linux-kernel@vger.kernel.org,
        Kai Bosch <kbosch@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Takashi,

 Yes, this was indeed meant to improve human readability and in my
future submissions i will note this in the commit comment.

 It was my first submission and i thought a good point to start was to
go through the warnings that heck_patch.pl will produce on any given c
file and improve on that.

 Sorry if i went about this the wrong way.

 Kind regards

 Kai Bosch
