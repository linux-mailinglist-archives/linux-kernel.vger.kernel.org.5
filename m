Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2BE7BDB6D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376319AbjJIMTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346558AbjJIMSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:18:51 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90E93870
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:16:02 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-65afd746330so27322966d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 05:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696853762; x=1697458562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iw95tEeWB9saYTjeuqfwDCk67AfASMwamONQ4Q2lXGY=;
        b=D7fYYAak61ciJboQ4Wt9EBlt0lhIx4vvspagxHDouOBQ5BPQeGpbhMpQmVTA1vF8UE
         KEIFIKfd5QW5QQLsB1aKaXun6chYdOC+Qt1h8vZxX3IP+gDoeHINv4geS36ZQ3Lgtqwv
         YAphlcclHpi4yKKqikC1L6GbYT0JcnvqlyNNVyGgcOEcUSmY2g4wqo3XrQuj64p6MV/f
         i96w/+cx/yqMESo1OPl304jNaQ63wZ1lbBkIojW7DBMaCRVa0HUEpFl6AcxvdSVvWbvW
         Niqn+cbyhI0++IIvqMCT9aXFOtT3Qu71MDdc/ZjzyGO7w9TM6m98xrtiYJ/ZpbURolao
         sHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696853762; x=1697458562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iw95tEeWB9saYTjeuqfwDCk67AfASMwamONQ4Q2lXGY=;
        b=QvFJMFJ33PEgKq2JPBRE+daDVdt6aCGv+LLh3+r3Aa0arcxZ8pyXVz16XP/v3unc6r
         XSrXbGUc6c53gI7s4v1xI9KeSeRzBxbmOM+QEPX33ce1PZf0oBLrYZ95+CFNpalY67EP
         c4ho5wNVzO/CJjHJ9wF+gvxeWUHypwZdZYKuJNLXBsJ3Po05cOu+IFn1gACqaUYpJ7sA
         gposo2uEw8rd4UkqaCIKIYvyCTLlj9RtiZSIZ+n+0oHMeRDdLiNZsxLM5T/xBDOvSSSX
         c0/TXW5oMj7U4uWKFZp98ptHtzsBGr9D9NVMBJpdsGU+t/tpJ75/MzKoK9NnyI0NuOBG
         nMlw==
X-Gm-Message-State: AOJu0Yw4yERiQNb8mZdItbRfKm8cQC+VYh75HizTTap3dH3KBspuzQdm
        XJt8PIZ4vqQMr8camaIwh7UkoHSscop+f923anQuIw==
X-Google-Smtp-Source: AGHT+IEJxXM/xTsmEX/IkrwKYO8Wl9OBkKBFQveDekw2SADwckQ7HwXu/jVY1YyfS4fU9QTcerTLDfajbJ4m3cRb/AQ=
X-Received: by 2002:ad4:55d3:0:b0:641:8b09:98ac with SMTP id
 bt19-20020ad455d3000000b006418b0998acmr13512054qvb.37.1696853761812; Mon, 09
 Oct 2023 05:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <d94caa60d28349ca5a3c709fdb67545d9374e0dc.1694625260.git.andreyknvl@google.com>
 <20230916174334.GA1030024@mutt> <20230916130412.bdd04e5344f80af583332e9d@linux-foundation.org>
In-Reply-To: <20230916130412.bdd04e5344f80af583332e9d@linux-foundation.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 9 Oct 2023 14:15:25 +0200
Message-ID: <CAG_fn=W0OO4GGS0-pnHFpnWGsBN3dZJ9tnRxPmEKRkkP4Vh48A@mail.gmail.com>
Subject: Re: [PATCH v2 12/19] lib/stackdepot: use list_head for stack record links
To:     Andrew Morton <akpm@linux-foundation.org>,
        andrey.konovalov@linux.dev
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>, arnd@arndb.de,
        sfr@canb.auug.org.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2023 at 10:04=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Sat, 16 Sep 2023 19:43:35 +0200 Anders Roxell <anders.roxell@linaro.or=
g> wrote:
>
> > On 2023-09-13 19:14, andrey.konovalov@linux.dev wrote:
> > > From: Andrey Konovalov <andreyknvl@google.com>
> > >
> > > Switch stack_record to use list_head for links in the hash table
> > > and in the freelist.
> > >
> > > This will allow removing entries from the hash table buckets.
> > >
> > > This is preparatory patch for implementing the eviction of stack reco=
rds
> > > from the stack depot.
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > >
> >
> > Building on an arm64 kernel from linux-next tag next-20230915, and boot
> > that in QEMU. I see the following kernel panic.
> >
> > ...
> >
> > The full log can be found [1] and the .config file [2]. I bisected down
> > to this commit, see the bisect log [3].

I am also seeing similar crashes on an x86 KMSAN build.

They are happening when in the following code:

        list_for_each(pos, bucket) {
                found =3D list_entry(pos, struct stack_record, list);
                if (found->hash =3D=3D hash &&
                    found->size =3D=3D size &&
                    !stackdepot_memcmp(entries, found->entries, size))
                        return found;
        }

`found` is NULL

@Andrey, could you please take a look?
