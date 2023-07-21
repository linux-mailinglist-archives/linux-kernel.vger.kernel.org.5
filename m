Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE34B75D0B6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjGUR3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjGUR3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:29:16 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2AE26BF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:29:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e28b299adso3044279a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689960552; x=1690565352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F08KAtvy0KJ26wsao6zq1OV/NB54IO3TMvYDTGLgN88=;
        b=mlkESRJESGxoZQEKyF5zLu5HQPv5XdhTiV9zrT0ZJq8WLw6E00CpDcaABzqdgFS4dz
         8M1D5mw7gPD8fH5PoGzPRnzaP7I1cXJnrk+3NbuS+Kwg9ryzE6iWcqhT6UDCxhoY4eQ3
         3EPirUWVL3rMq1L1mpkh7di2w77n9DerBbCEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689960552; x=1690565352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F08KAtvy0KJ26wsao6zq1OV/NB54IO3TMvYDTGLgN88=;
        b=V4tZy8sYnedBHUv609teDVFtcgyHTv4KrKIqckXQLWYF3/+7bC8AVxnqBwgIGHPDKA
         CXxKP/5PIlzUH3br1U3g4OXkmkWolHWROQBGTSJqMBYOc9kGJaAeTrZ82in+mfJ84lEf
         hGwMCpTxMn7CTh81w/NtrFnJ37Hv6QAFKqhoVdNf3xf+YCxnTtJXxvuAAcAQVuWFW5qH
         EEPtRzxpkeAjFB90JZu7IiMfkr042Kt38HIiUIUlaxNlWzL7wSLr6WcLBSpF9OA6sA56
         jP5CGgIQfXMj3q9jdTMOwJvpb1LjYvReb60k4DWpoxQ9VtaaUjOvGusEEr6FSgr8RQTo
         0dRA==
X-Gm-Message-State: ABy/qLZ8ZkZm2ld65INBWFI6BMVLAZEDBnGEahlCb3R4vLZSYSiA+ptH
        997F23E3Fv9Yi5Kyczmmcoe4vnMahroAfVclpAo=
X-Google-Smtp-Source: APBJJlGVFJ3y5uLhrXMlnITplTBt9tIzVG6Jp2/5QrcLCaYv7qAvSdzOKSrk7l7Sq29dutH24Egckg==
X-Received: by 2002:aa7:c151:0:b0:51e:2525:68a3 with SMTP id r17-20020aa7c151000000b0051e252568a3mr2112739edp.25.1689960552361;
        Fri, 21 Jul 2023 10:29:12 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id e22-20020a50fb96000000b0051a5cf5fcaasm2359573edq.23.2023.07.21.10.29.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 10:29:11 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-991da766865so338429766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:29:11 -0700 (PDT)
X-Received: by 2002:a17:906:1d8:b0:988:4dc:e3a3 with SMTP id
 24-20020a17090601d800b0098804dce3a3mr2137406ejj.31.1689960550768; Fri, 21 Jul
 2023 10:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <ZLm3G5G6/gmLZwkn@tora> <ZLooCXV11JCdWOdK@google.com> <b1370c4b-7bad-4aac-0fa7-32d6479aa255@gmail.com>
In-Reply-To: <b1370c4b-7bad-4aac-0fa7-32d6479aa255@gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 21 Jul 2023 10:28:59 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOuJVG7bpXdKMf9nobjJ=qcTiBWVj+TQ3Kpwqct27HSag@mail.gmail.com>
Message-ID: <CA+ASDXOuJVG7bpXdKMf9nobjJ=qcTiBWVj+TQ3Kpwqct27HSag@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Add DMI definition for
 post-Skylake machines running custom Coreboot builds
To:     Alicja Michalska <ahplka19@gmail.com>
Cc:     Tzung-Bi Shih <tzungbi@kernel.org>, linux-kernel@vger.kernel.org,
        robbarnes@google.com, lalithkraj@google.com, rrangel@chromium.org,
        bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:16=E2=80=AFAM Alicja Michalska <ahplka19@gmail.c=
om> wrote:
> I've explained the reason behind adding this patch, but we'll go with
> different approach next time around.

FWIW, I'm also confused about your first sentence the same way
Tzung-Bi is. If two people are confused by parts of your description,
then maybe it needs improvement :)

> Since we're discussing this, I would like to suggest removal of DMI
> matches for EOL machines from lines 503...535 (Link, Samus, Peppy, Glimme=
r).
>
> Those machines aren't supported by Google anymore. Patch I suggested
> will match DMI while running custom firmware.
>
> If maintainers are okay with it, I will submit a patch removing DMI
> matches for stock firmware running on those machines since it's not
> needed anymore.

That seems actively harmful. These devices continue to work just fine
with their stock BIOS, even if Google no longer supports updating the
Google-built OS. That doesn't mean people can't boot other OS'es
(e.g., their own ChromiumOS builds; or other Linux distros) on them.

Brian
