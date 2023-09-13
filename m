Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021B879E93D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbjIMN1P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Sep 2023 09:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240902AbjIMN1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:27:14 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F6019B1;
        Wed, 13 Sep 2023 06:27:10 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d7cbcfdf137so5985235276.2;
        Wed, 13 Sep 2023 06:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694611630; x=1695216430;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlTO8VUYsx7PmNq9m5A7uTHn55FRtbCGrjx/4WjOV/Q=;
        b=MR17P+93qmk4MLg7NaW/t6q3MkT3lg2m26lLTDVLz1LKSxPhZYsavova+9U/b/yKQY
         Xv88PcNMFP/SkX1krJ0cmYw0sKJu5OHMhXCoAMlQ/QNaSl8fRWTXwBZa55AaPP/ohizT
         7U7XNFXSYPmfJrz5Mj7sfv8bXYt//EFKzaQukjCme/AOtm/GfkRcY90F63PO4ybaJNzG
         Yxj21Xx2mKFi4gK5km6gFam3/2tyMRv8Di+fQ8f5gEu8ZL26zpTr0+RMnNTmWduSN1Uw
         Ge6Dny8ukJyi4qPpN6XciBzUbD/akSdvbW9xF8fKXIk4E+0LWZgLBz5PozEGlqWKmGCk
         w8cA==
X-Gm-Message-State: AOJu0YyzewrtEcF8G4rOD36CwfiKOucHJ/e3PxB0DgT6xTRJV2fVTofK
        4FRUj3OltoM1R0m1EKJtMidv4KOsxONy0Q==
X-Google-Smtp-Source: AGHT+IHrscU5LeqiT5p/6SKLB0CGMJAS87Rhd9ivpNoNymY7CtFjuYUHvztA/hU2VbsUlB05q2fUPg==
X-Received: by 2002:a25:d045:0:b0:d80:ce33:af5b with SMTP id h66-20020a25d045000000b00d80ce33af5bmr2632718ybg.59.1694611629987;
        Wed, 13 Sep 2023 06:27:09 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id d11-20020a25888b000000b00d7823cc7d62sm2627504ybl.19.2023.09.13.06.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 06:27:09 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-59b53488f7cso57444947b3.0;
        Wed, 13 Sep 2023 06:27:08 -0700 (PDT)
X-Received: by 2002:a25:ac4b:0:b0:d81:754a:7cb8 with SMTP id
 r11-20020a25ac4b000000b00d81754a7cb8mr568577ybd.65.1694611628683; Wed, 13 Sep
 2023 06:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <ad298077-fca8-437e-b9e3-66e31424afb1@paulmck-laptop>
 <20230906172954.oq4vogeuco25zam7@revolver> <495849d6-1dc6-4f38-bce7-23c50df3a99f@paulmck-laptop>
 <20230911235452.xhtnt7ply7ayr53x@revolver> <33150b55-970c-4607-9015-af0e50e4112d@paulmck-laptop>
 <CAMuHMdWKwdxjRf031aD=Ko7vRdvFW-OR48QAc=ZFy=FP_LNAoA@mail.gmail.com>
 <f9b0a88c-8a64-439f-a488-85d500c9f2aa@paulmck-laptop> <CAMuHMdX89u6wL9W+8ZOn-OTT1FreYjEqYnvEip4Aq3k1gOP0EQ@mail.gmail.com>
 <62936d98-6353-486e-8535-86c9f90bc7f4@paulmck-laptop> <CAMuHMdVp10=AQDcC31OEvy2LPWSdjvHnbCKVtRtt-Re=7wr=1w@mail.gmail.com>
 <20230913132404.wepr7l7o5qegy7hw@revolver>
In-Reply-To: <20230913132404.wepr7l7o5qegy7hw@revolver>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Sep 2023 15:26:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXDqziMK_GUEd5wLR=Yk0=oP0jC-zAE7dGUYkOpGPZ7gg@mail.gmail.com>
Message-ID: <CAMuHMdXDqziMK_GUEd5wLR=Yk0=oP0jC-zAE7dGUYkOpGPZ7gg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>, paulmck@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On Wed, Sep 13, 2023 at 3:24 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> * Geert Uytterhoeven <geert@linux-m68k.org> [230913 09:15]:
> > On the affected systems (RZ/A1 and RZ/A2), the WARN_ON_ONCE() did
> > not trigger, until I applied Liam's patch ("init/main: Clear boot task
> > idle flag"), which got rid of the "Interrupts were enabled early" warning,
> > and now tells me, as expected:

[...]

> > However, Liam's patch causes lots of warnings on the other systems...
> >
>
> What patch?  The "init/main" patch?

Indeed.

> What systems and what are they?

Reported in the thread:
https://lore.kernel.org/all/CAMuHMdWR68a49=vthdp03stpvaHLS5BRa+rhVdnr7gQDFkNotQ@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
