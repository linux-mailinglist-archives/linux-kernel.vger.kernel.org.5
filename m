Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6640681171D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442246AbjLMPe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442342AbjLMPeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:34:13 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A559510F3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:31:47 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-28abd1ecb85so1312872a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702481507; x=1703086307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZzlMKqeaQDgaUycRwSe7fFFE/6tq3edh0ES7fNxHN8=;
        b=Zm3fN/XZ+MxkJ5+AjUrO7vxzYXpY9YLG0OcYXQdSsxCnz6+0O15GgGpyiE1C9r/vHt
         5AUYcpNT2dfIuF9MHW0Xw8HWg16LXkAvwwssIRxynqWVC7J/0kt8Oc2bW9EswXpajznP
         pFm1ZYr2wlHgWvTngpMVdTLZkLCEfq/s8iVlyvdSUZBBMUgUzUsV1hloNGhPAtbrP1+f
         nYaYsXWd11ccJQxag3vwhIQqJ6lKNkUfqyHInUDa0k6HjNAzpetKDRCGjFjcECujnqJ7
         vrzjnKs2VA9D8kHnkdddNCzVqwPqO4TYz+NTuI/VJepJ51oVIk5TYvmIWmWaOb+JwjIb
         AHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702481507; x=1703086307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZzlMKqeaQDgaUycRwSe7fFFE/6tq3edh0ES7fNxHN8=;
        b=bDn20xCwEzQDwySuo2084iJz+R4hAYUyxD7C1mbFcu7kL9UN3cksLJ0a8AypfmpR43
         We9sTi8Bd6Tk+Q0K+HYJnqqm5oJuwuA2Xl2CTtzZtOIi7jKPIqFjyK3NpzouWZQ9PISG
         Bz5GGgNijqrDm+g783HJgrSdbSHtf0qMiKypMa3bOCqixQOeW8XJCXmsTS0+09FTs5bu
         2NpzGI0dGLZUPLXRWPzgjGn67Kb5vGT9AAV7v6yUpHgE2lxincVHRnYes48y9yI2Z/Uz
         L0LhefEm9APMfwOjcUyLS8v1+yekpb2IbKIdDMac/gl1k9rekTfzv40irDgD/P5DjogY
         wR+g==
X-Gm-Message-State: AOJu0YyFYF468h7heeF3vFhc3vl0jrmR7wbYTzyUV0zHlu9PBLRfRawr
        nehnp8im1wpqsG9nbiOU+ScSrFu8CuzDnHWLkIg=
X-Google-Smtp-Source: AGHT+IG5iZTcVImc/59btC+BAiAzwRNe1KCNitVlOmR6VYh3v0mNwJx54lXiUMbKt/6067AbRjmM4byKkaFp8rZSNN4=
X-Received: by 2002:a17:90a:cf85:b0:28a:b3bf:3c56 with SMTP id
 i5-20020a17090acf8500b0028ab3bf3c56mr1926683pju.20.1702481506962; Wed, 13 Dec
 2023 07:31:46 -0800 (PST)
MIME-Version: 1.0
References: <20231128075532.110251-1-haibo.li@mediatek.com>
 <20231128172238.f80ed8dd74ab2a13eba33091@linux-foundation.org>
 <CA+fCnZcLwXn6crGF1E1cY3TknMaUN=H8-_hp0-cC+s8-wj95PQ@mail.gmail.com> <ecf38b22-ee64-41e5-b9b5-c32fc1cb57bc@moroto.mountain>
In-Reply-To: <ecf38b22-ee64-41e5-b9b5-c32fc1cb57bc@moroto.mountain>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 13 Dec 2023 16:31:35 +0100
Message-ID: <CA+fCnZc73qNqNiCMcKFKRuoBki=Bmhdw-mOY9chV=CjAtm0R+g@mail.gmail.com>
Subject: Re: [PATCH] fix comparison of unsigned expression < 0
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     "Liu, Yujie" <yujie.liu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Haibo Li <haibo.li@mediatek.com>, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, xiaoming.yu@mediatek.com
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

On Mon, Dec 4, 2023 at 5:12=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> > But I actually don't think we need to fix anything here.
> >
> > This issue looks quite close to a similar comparison with 0 issue
> > Linus shared his opinion on here:
> >
> > https://lore.kernel.org/all/Pine.LNX.4.58.0411230958260.20993@ppc970.os=
dl.org/
> >
> > I don't know if the common consensus with the regard to issues like
> > that changed since then. But if not, perhaps we can treat this kernel
> > test robot report as a false positive.
>
> I would say that the consensus has changed somewhere around 2015 or
> so.  Unsigned comparisons to zero used to be one of the most common
> types of bugs in new code but now almost all subsystems have turned on
> the GCC warning for this.
>
> However, this is a Smatch warning and I agree with Linus on this.  For
> example, Smatch doesn't complain about the example code the Linus
> mentioned.
>
>         if (a < 0 || a > X)
>
> And in this case, it's a one liner fix for me to add KASAN_SHADOW_OFFSET
> as an allowed macro and silence the warning.

Hi Dan,

If this sounds like a good idea to you, please add an exception.

From the KASAN side, I think adding an exception for this case makes sense.

Thank you!
