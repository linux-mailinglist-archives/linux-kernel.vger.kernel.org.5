Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2DD7B0835
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjI0P1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjI0P1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:27:38 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5943121
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:27:37 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bff776fe0bso190475861fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695828456; x=1696433256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IskEJlA+1Xi+P4CK/j2l20j5wUzirP4EWW7EpWRuvU4=;
        b=WBe6kY8m2xiIHK+7ph+oKtSLVDlGjGiU0EBkQgNF37vo0ndgO0vqMpGUIfDFeBMqLv
         ylp/uzvtpSA1LGU+tS0R2lT+eJ7O24f9DFT4MKhHWT9t5MyivM0nhXA05sECcYBC7R5t
         C9+9jzo4gkBguQHeIrcokHmd88bsWyV5hpApbCymg+kPfDyA3lrlPP3lqbRecckGsAhU
         qWvAWTYsVKl3X1DhnKtuYhJtHRL3r2AieryaALjNe/37nxgUzR2SLp4+4us3I6qpDbtx
         b5wuEXEFzW1llNIFoaVUN/FuBXhvPLZoX95ne5mpzOOnnLv1XhZ9k9SQdmFfkfDXzVvx
         QlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695828456; x=1696433256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IskEJlA+1Xi+P4CK/j2l20j5wUzirP4EWW7EpWRuvU4=;
        b=KMRMzv9o2ERYUp9J1PZWwvLWv7FpNOAF4VysAspv63O4Zwl5N8spKKpqCYDsy1B0ei
         PKuEiBesm1ZPPUGsUzSwQKm9CODvBLxR3G6+jYQxAXk5+SZC2YO9rHiYA/1CoTfeZEbH
         qn50k77zfbSoVAFLBRLlaMJv1/ht8uPHaoBdb1pB6HzEEMxQL5PkO9MJIXi0SRIR1YDf
         XlSmZIKxcbiqHWg5+kNo+IY0ZtoCEkmqvBTSaYcvA2csHlMbRRJxjW8XlY2KRYOdoR88
         EfrIrP/OXtKiuWhz5AA1TK65Im+Ezs2+HMR3mrs8dKjct0qRXRBqGTQ3VkYp9fKFp4kL
         2A6w==
X-Gm-Message-State: AOJu0YyHdBf7znyXHUihc2A8S/pK5ikqfVGPWunEHq6jLePdYpL6bwjS
        Hcf9FAHK0Lkp0larAnq+LRAaQ6Y/2JuKDHKbd+rsYE+xOby/0Q==
X-Google-Smtp-Source: AGHT+IEHT5aib1jiL0PldTcUlcTIlNgMuNoB906ITYTiSL8bEUpcMEgkMjYQDTVJhcmpnJtWWNxORnbzZABEqkqV+lU=
X-Received: by 2002:a2e:9d55:0:b0:2c0:1cfd:8698 with SMTP id
 y21-20020a2e9d55000000b002c01cfd8698mr2118499ljj.36.1695828455759; Wed, 27
 Sep 2023 08:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDJoNtU9Vuh87PxDkxo+7M_Kg_K4PPNGksPuW_guFbChYu-jA@mail.gmail.com>
 <20220601155702.176588-1-ariel.miculas@gmail.com> <CAPDJoNvZmeeU+T94rp8BJ0+bH5pDXQCEKPHiQF0Kcu=JrRRfrg@mail.gmail.com>
 <CAPDJoNsb-HtfOQhD6ntZ8Hqx3fv3WAh1U5Jd3GzyN5EwO8znWA@mail.gmail.com>
 <CAPDJoNuR8pNa+rp-PG_eeS14EvpMBLAmjNf9JvL=+0QTpwww-w@mail.gmail.com> <d6bd3632-207e-b232-b4a1-0c592a3aaae9@csgroup.eu>
In-Reply-To: <d6bd3632-207e-b232-b4a1-0c592a3aaae9@csgroup.eu>
From:   Ariel Miculas <ariel.miculas@gmail.com>
Date:   Wed, 27 Sep 2023 18:27:24 +0300
Message-ID: <CAPDJoNvADrCj8L2RAthXVbBxMNrjbY_4pnHu0QtKKARgyoQ-QA@mail.gmail.com>
Subject: Re: Fwd: [PATCH] powerpc/ptrace: Fix buffer overflow when handling
 PTRACE_PEEKUSER and PTRACE_POKEUSER
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

I've forwarded this old email thread for visibility and discussion's
sake around my recent blog post [1][2]

Regards,
Ariel

[1] https://news.ycombinator.com/item?id=37671991
[2] https://www.reddit.com/r/programming/comments/16tf5ne/how_i_got_robbed_of_my_first_kernel_contribution/?ref=share&ref_source=link
