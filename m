Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8D57F93C8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 17:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjKZQ37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 11:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZQ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 11:29:57 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82884FB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 08:30:03 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c5056059e0so44097641fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 08:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1701016201; x=1701621001; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sSJ+yeqxuvutnkpSkcqAmI5LAVDWcSBce0PQad7lFBQ=;
        b=PkS2bZ9XIf1gB9rDAW2NcW53LskZxG24TPyKzs+aqE5rJ1Htr32CvpMZwO1Gp+Gmo3
         QWnDQdp+IcG1bRebFUlQHhkkpMBcxSK/5nWgZUp3zjQI/Wbf0dHcTTDe+M+z6tCp3aef
         A99jWaJwCfQUd6S/lxAcNbzjzRlNA40tVt160=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701016201; x=1701621001;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSJ+yeqxuvutnkpSkcqAmI5LAVDWcSBce0PQad7lFBQ=;
        b=IteoBXonfu8IUqmry8jw9jEPlCDcfxOBiCvApVCg3K24Vr7Ur+QNnDEFmtT/l/+eTb
         YAMr3cb+AU7/eTZZ58c69qfl6HHmeuJT4ocgatZ/85i0Q0AMjbOnllr/bZIK3CKdT4vA
         JlW46D6YDSCkiWxrDiZpd99hOdJVGjOaNaG/PxXLtqBF0QptBZHJu6/XIKSSorZxUrw9
         C4kM1Y/3QFmnmg6RihgDmp2B99a/Lf/JB3XFTaYBYj++hMFXIGQs5rWjvxJRFhQX9lq3
         vLxBJf4NE6t+am2x4Ys8T6hy4BU+8kQsdqL8BT8tfT3Imi4Hmq3c3we6QN4qt9IRtYJR
         9LNA==
X-Gm-Message-State: AOJu0Yy7E8oFgWs/m7N4qaiDBxitw2WBvCmjfj2JyMM4/fAxS6ugMHm3
        wI+yq2LbTVhjo/gcoDwe0dlOA7kHTvMxmw3rJ8+xMtoY
X-Google-Smtp-Source: AGHT+IG+QV4fr/CGR8XkCiD0cUOleXiRTtSiCcTNPxI/t9z+ph/BKXI15LF8vmxbmjsKUasNW2X4Xg==
X-Received: by 2002:a2e:8e84:0:b0:2c6:f16e:ab2f with SMTP id z4-20020a2e8e84000000b002c6f16eab2fmr5611380ljk.40.1701016201742;
        Sun, 26 Nov 2023 08:30:01 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id a27-20020a2ebe9b000000b002bcdbfe36a1sm1064413ljr.84.2023.11.26.08.30.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 08:30:00 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-507e85ebf50so4668547e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 08:30:00 -0800 (PST)
X-Received: by 2002:a19:5e03:0:b0:509:dec:9f3c with SMTP id
 s3-20020a195e03000000b005090dec9f3cmr4999914lfb.50.1701016200246; Sun, 26 Nov
 2023 08:30:00 -0800 (PST)
MIME-Version: 1.0
References: <ZWLsgGku7j_7_eVE@ls3530>
In-Reply-To: <ZWLsgGku7j_7_eVE@ls3530>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Nov 2023 08:29:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiR5yLK6-n5p=F97unF1bf3DuPdGcv0MZcO51aiik4T0w@mail.gmail.com>
Message-ID: <CAHk-=wiR5yLK6-n5p=F97unF1bf3DuPdGcv0MZcO51aiik4T0w@mail.gmail.com>
Subject: Re: [GIT PULL] fbdev fixes and updates for v6.7-rc3
To:     Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2023 at 22:58, Helge Deller <deller@gmx.de> wrote:
>
> please pull some small fbdev fixes for 6.7-rc3.

These all seem to be pure cleanups, not bug fixes.

Please resend during the merge window.

            Linus
