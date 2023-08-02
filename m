Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AC076D09A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbjHBOuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbjHBOuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:50:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887D8E61
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:50:11 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so65247335e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 07:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690987808; x=1691592608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCYYmzNqtzxNv8UbxN3uv60kE4E3C48+cD2+0APdVk8=;
        b=bfwUet4qi7yyF7aKFOmhonqH5OcPqZZdq/h8mIfyRqAlamxsMsBJLoJX72eyQyg8kZ
         rgqPuYe4+k77PaeBmcB+78yVr0g0gs6KfZ2378hHcDiu0S+vbibTZzmrojhRi5ur+uaT
         cZeIwEtlFiDH4a7ak6yKOdnGaii8cT5vATQBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690987808; x=1691592608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCYYmzNqtzxNv8UbxN3uv60kE4E3C48+cD2+0APdVk8=;
        b=DR2vIb32iJ4/ysUmeXjQSIkcv7/NV/tpxrMvTRto3pPTjdBfQCHFjSzoIToiH9rhY+
         OlISv6yaV9aNZWewSrVmu5aGhMyVUo9Qsrr2kn/SCLFSQ5OaQnxQ7k7ECx3RpMZ+biTi
         qnRgv3kKmCG+7OVdcYUhyW1zZyM5CLVxwk3xU0oskeeqOZ6yLzirekRgks67XqQ6u73G
         wIXla4j4BfmguzXDqsZ/5FNNTJU8voO6HNwB2+tIGlMSXr8uTSFRBRrScac+LxedEbrN
         Fb+HJfb1P1S7Nwqgig/J0goKusByuYBikiBFp2wDWrlxPy7IjdY6x1YS9lTUBG4fao9L
         HqWw==
X-Gm-Message-State: ABy/qLaUYrGWQdQfHx3QpERgC5+QCLGF9cY0JF3r6fwO5elj91JUt8JU
        snep2LYqcPY3m8tlM/B7auQ/tQu/TbgNqFVRNTI2X9m8
X-Google-Smtp-Source: APBJJlGMQMwiWAbDZZqhZtGpHhrmyf+YnY7s8EVJy9vWGqJMw9NsqMo2mEQa2Zva6OBcURql+Mzrbw==
X-Received: by 2002:a5d:62c7:0:b0:30e:3da5:46e5 with SMTP id o7-20020a5d62c7000000b0030e3da546e5mr4380418wrv.59.1690987808730;
        Wed, 02 Aug 2023 07:50:08 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id m4-20020a056402050400b0051e22660835sm8844012edv.46.2023.08.02.07.50.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 07:50:08 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5229e0603edso11024a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 07:50:08 -0700 (PDT)
X-Received: by 2002:a50:d70e:0:b0:522:203b:c348 with SMTP id
 t14-20020a50d70e000000b00522203bc348mr412547edi.5.1690987807863; Wed, 02 Aug
 2023 07:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230802142136.0f67b762@canb.auug.org.au>
In-Reply-To: <20230802142136.0f67b762@canb.auug.org.au>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 2 Aug 2023 07:49:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XEbpuMb4FvDkVkkX+Btig4eFnNrp5LWs+rQJ9Sy3wg4w@mail.gmail.com>
Message-ID: <CAD=FV=XEbpuMb4FvDkVkkX+Btig4eFnNrp5LWs+rQJ9Sy3wg4w@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the drm-misc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 1, 2023 at 9:21=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> Hi all,
>
> After merging the drm-misc tree, today's linux-next build (htmldocs)
> produced this warning:
>
> include/drm/drm_panel.h:270: warning: Function parameter or member 'follo=
wer_lock' not described in 'drm_panel'
>
> Introduced by commit
>
>   de0874165b83 ("drm/panel: Add a way for other devices to follow panel s=
tate")

Thanks for the report. I've posted:

https://lore.kernel.org/all/20230802074727.1.I4036706ad5e7f45e80d41b7771642=
58e52079cd8@changeid/

To fix this one.

-Doug
