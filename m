Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D858789DD0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 14:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjH0MQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 08:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjH0MQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 08:16:16 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAFA13E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 05:16:14 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-5733710eecaso1495764eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 05:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693138573; x=1693743373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhxICFeGkDE2p17yC8izuoNjV+Z/iSI5rHHAjSvkmHw=;
        b=glPoHyK4XgY4XfEpkbQSpCwxsu9p7pC8YvPcSkKscCVQo0lr6ziV/COWFB4o1orXf8
         xFiWZ9EZ4Z2hsC1GLsd9skmQXMfc9C2iUo+XEFuuIJoY5jfebtVz+RA3zJ3++HBLVXuK
         MMUbkadAzJJgsIO1jTIUCz8MWDnnPsUDSZ9fhwnQU34L3ZHGv4iMCGgnf6kxfWLMm7hA
         AMkFtU+EMmCUxrTyXhUq+mH3uNCFReKUV8sGIx2hMB59adBLlOc6ojpyKp+nY9HKdRO0
         jtmhXQzyhUb/e5YJl6s4/1Jm8yF0EltsodG//DBU6w0R5D8PR8RJoo6XwvhjApRA/w54
         ngsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693138573; x=1693743373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhxICFeGkDE2p17yC8izuoNjV+Z/iSI5rHHAjSvkmHw=;
        b=BbdvoUoybo4Gqz7KOhmeKrl5y4s8aYDxy6giCOYEltpfQxoUfNWn2QY+hJpHyVUij7
         HoQX+YtL1BZXtSEDbjljKeVEcs31/bHsc3VM7tFXj/JuUaPTbn18virkygDaZnVhpl0E
         M2cW9W19rukOoFJ1F8vqQFdOy7Opdf8ylGQxxYUNp5jxPDNCg7IsEDlik2Zt+y1hWVbZ
         3YfhnhwtF1G9pccxyxSBM+yBLM0rllQcBbzFyeg+nEk7bCt+aPCvJC4haLBVcPekvi2i
         B/cbDPQcYzv8XR7Yvac6TEB0s1caKhzEAiYQUq87T3uON9Eusm1+GUiVb+Ioa7xwlL1M
         nrLQ==
X-Gm-Message-State: AOJu0YxG92MvJrtxjVxWw9kJBAoaWtA2ZYTOUY0mzWHdh+TtG5ggcahZ
        9ffhDn6CMtBEN+aCQ+ImMwK+st2ZyjNGKw5kLXc=
X-Google-Smtp-Source: AGHT+IEuFbu3ypnxCPMjRAy9jZ5umJQygWrfnlYh8Z97NtpdIHgolR1SEqkq2yYJgDmchyspR/bvLesvrkcnv9Frry4=
X-Received: by 2002:a05:6870:5693:b0:1be:dbd9:dd21 with SMTP id
 p19-20020a056870569300b001bedbd9dd21mr8542691oao.48.1693138573344; Sun, 27
 Aug 2023 05:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xKQ549ExO83Yur=_MPv3aYFdR0nfzUSuEXO74OddAr5gQ@mail.gmail.com>
 <ZOs5exw+95zzzawK@finisterre.sirena.org.uk>
In-Reply-To: <ZOs5exw+95zzzawK@finisterre.sirena.org.uk>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 27 Aug 2023 07:16:01 -0500
Message-ID: <CAHCN7x+jkU-UoR9DAPorC_i8Z-6sf4Qg2qRW444mzU1DcKiwnA@mail.gmail.com>
Subject: Re: Question about simple-audio-card with dummy CODEC
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 6:54=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Sat, Aug 26, 2023 at 11:15:30PM -0500, Adam Ford wrote:
>
> > I am asking what is the best way to let simple-audio-card  use a dummy
> > codec?  If the dummy codec is the better option, what compatible name
> > should I use?
>
> We have a driver for DMICs, dmic.c - you should use that.  In general

Thank you. This looks like exactly what I need.  I just didn't know
what it was called.

> you should never use the dummy CODEC, you should use a driver for the
> specific thing on the board which will at least describe the
> capabilities of the hardware even if it doesn't have any ops that do
> anything.

I thought the dummy codec was a bad idea based on my searching.  I
appreciate the quick response.

adam
