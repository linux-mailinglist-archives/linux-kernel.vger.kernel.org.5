Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97218759B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjGSQtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjGSQtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:49:09 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07A71FFD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:49:02 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-263315da33cso1308127a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689785342; x=1690390142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5oKfuESxM+AbYitYVm52qNXw+XWHUNvJL7SdYQTD1A=;
        b=owITUim9KtkXTm/sHKMPJvCR/Jav8bcKjZmelH3deMYE6RexIHkb7sP3I00tgazDpN
         da7AgknVpC8VAJNcX8VrnfM0/c2nYuWoMoj348aPdQD62ThaVkNUGx4TlQ9bT1twfY+L
         V37xhOQprPMRZ62bwcqIrQ/ANrY8i/F7DINqbH+pAz3PMwc17I47lXAA8mazLZoYkSs+
         e4KVLu8EiyNALjRG3IUvy6Du2Xtg6nUKm/TJLQ0/yhXySVjBudtU05w57yI8X4oP2HuG
         zMiAr62Tb3nacDfS8qkLI3sXrBe1Ms709DsKUN8jhbC0hU4Tsxcf+gC/HmiwzwGn9o82
         JvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689785342; x=1690390142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5oKfuESxM+AbYitYVm52qNXw+XWHUNvJL7SdYQTD1A=;
        b=VpmpR6yJ127beIKHMi5AuBTP2Pc5ZfebcnAAYwN52WeHDA27f6WVXoVgVzIY64jpPf
         sUXTj9wKSJQBxudHOB/Um+UMgkzHTsH3TPYQHjbDbqIaKQwCL7VpJx9RFCuzntTLiZKH
         iCHr+Kvdp4a4p6o7nb4+rRNqlCZjBisR3X5/M/6RtDPQMx2mq591q+s+SzkjyxtKpKED
         nRsMpwDqSS7cVYJvo/Uq7mib4LwDVgAwYVUxHPxNGj8aJVsSPMkxNTRL/ryGtzk4CWwS
         torme70r3YmwodwwY5uPBkH9WJ+TYMLe4p9+9CYIt5RrZ6khr+uqorGtOVeBLdmin+J5
         1HuQ==
X-Gm-Message-State: ABy/qLYgpd4+6SPYYLE50EgTfH7og2RmKEcVvwapwHKB1PMG7oVxshR8
        lO7Ti5FiRJYOrq/fxlP+o9DWyVhJr7vseoCniM4=
X-Google-Smtp-Source: APBJJlFVxTBOJZyOAApETTi1cRHOhfvHsqzZIpoAZFguJ4tWPkKoTOnqKPrWk2Z72eDkR6FaHpGVLbFHpVIf9yUfU3U=
X-Received: by 2002:a17:90a:5386:b0:263:484c:f173 with SMTP id
 y6-20020a17090a538600b00263484cf173mr2648285pjh.2.1689785341744; Wed, 19 Jul
 2023 09:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230719163154.19492-1-matuszpd@gmail.com>
In-Reply-To: <20230719163154.19492-1-matuszpd@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Jul 2023 13:48:50 -0300
Message-ID: <CAOMZO5A6BYuJYr_6mLSKhAYTQYpki3otdrOaH7Gw+2177rXn9g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Add support for 22.05 kHz sample rate
To:     Matus Gajdos <matuszpd@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 1:32=E2=80=AFPM Matus Gajdos <matuszpd@gmail.com> w=
rote:
>
> Add support for 22.05 kHz sample rate for TX.
>
> Signed-off-by: Matus Gajdos <matuszpd@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
