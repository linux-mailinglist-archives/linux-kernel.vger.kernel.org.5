Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7489B7B0C2D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 20:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjI0SuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 14:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0SuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 14:50:00 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176598F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 11:49:59 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4060b623e64so35422375e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695840597; x=1696445397; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R1itOLkylDTQc/2A2yBLCkbYqw9eu/lNAc5CXGwFbJ0=;
        b=P+cDXPaCqYn7aKtatZq5pA3wPKzCmQvyrgQvn5M+VIwvojYaDmKkd6JKtxo+B0MuSw
         aGnAf8TwaXukDXXRn7W6H7iLQCYu4qTAlJLDvhf0rBICMiPKbz2xPuKWPxL0xVB+435W
         p/ieyeZBfNFIMhjPA8Lc7ht/jVetmatd/jBPXM9MPaaIQHAXlTF4pzAs0WtxjnwQCin/
         5GQ+EMaKAebWcRc3Pzz31WQC+TjPlsYEVLA4xG0dthqoNd+j/wIhYzVU4IIgyHRw+uB2
         TE8p5l8C7KOc1K1l+cXdw1ElZGTgMO/f5qWCg16C45NBkKUmOX2ZAJlFCj19TU4y5Cc5
         de1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695840597; x=1696445397;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1itOLkylDTQc/2A2yBLCkbYqw9eu/lNAc5CXGwFbJ0=;
        b=Ptn9HlVx9bBvn+mHhixY/lQXffL57qXZ4dtSwV7EcLyz8JzTMpf4Su3LpnBK28Adf3
         QaCoUbf1SxtDQjRp8hHf0Z+msJzYcHk7GvkitUhAu1XsyffFMxjo8v4a5NcFXUvSJTQg
         ALYqKEd9IyBAXkpcf679BBAnrqLau4DN3jQOtKLuSJwFbPAeNryFXgpheyP9CNFxRcw6
         HNTLM7XT0WZQIyhbgtt9LW965O36yXveAF+v1AIWtpElu8gbd/IGJPP+9CTsNYs7MCje
         Z0uLmcWoi/2r/KzngbCsLFjyGxOtH1bDqqRYNB2aKT5SGFA7CU7X6hvaTWJbHMdQYzNh
         XddA==
X-Gm-Message-State: AOJu0YwJ/Yr3I78k/aIU3nrTBtaLoqqleQDshXRNbKh7a3cl/nLFePgd
        qppv5/0zpW0vr7Sx/o0JOPE=
X-Google-Smtp-Source: AGHT+IGeFdsdEIFmk8RA4GwxSOTEPxHmjmcwLkojsHT6AEJXOvOw35P8cqeCoxyKpOpJNO67PqbsrQ==
X-Received: by 2002:a05:600c:2044:b0:405:3941:ce2c with SMTP id p4-20020a05600c204400b004053941ce2cmr5457597wmg.6.1695840597222;
        Wed, 27 Sep 2023 11:49:57 -0700 (PDT)
Received: from yoga ([2001:638:904:ffe5:5742:c50f:bd0:6aa6])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c1d9300b0040531f5c51asm18515027wms.5.2023.09.27.11.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 11:49:56 -0700 (PDT)
Date:   Wed, 27 Sep 2023 20:49:50 +0200
From:   Sven Frotscher <sven.frotscher@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM
To:     August Wikerfors <git@augustwikerfors.se>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, regressions@lists.linux.dev
Message-Id: <2ZQN1S.P7M0RX306S1D3@gmail.com>
In-Reply-To: <e8479eff-a5cb-41b0-8bf6-bcc20ccbecfb@augustwikerfors.se>
References: <R5KN1S.18M6QDS4T9PY1@gmail.com>
        <e8479eff-a5cb-41b0-8bf6-bcc20ccbecfb@augustwikerfors.se>
X-Mailer: geary/44.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 > > Signed-off-by: Sven Frotscher <sven.frotscher@gmail.com>
 > Since this fixes a regression caused by commit c008323fe361 which has
 > been backported to stable, please add "Fixes:" and "Cc:" tags above 
the
 > "Signed-off-by:" tag to ensure the fix also gets backported in a 
timely
 > manner [1]:
 >
 > Fixes: c008323fe361 ("ASoC: amd: yc: Fix a non-functional mic on 
Lenovo 82SJ")
 > Cc: stable@vger.kernel.org
I will.

 > > +>..>...>...DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 > > +>..>...>...DMI_MATCH(DMI_PRODUCT_NAME, "82YM"),
 > Your e-mail client seems to have mangled the leading whitespace here,
 > which will prevent the patch from applying cleanly.
My e-mail client isn't the problem here, but my Vim syntax highlighting
for tabs... I should've noticed that when copy-pasting from test e-mail
to patch e-mail via Vim.

Should I reply to this thread with a [PATCH v2] message or create a new
thread?
Anyway, thank you for pointing out these issues.

Regards,
Sven


