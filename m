Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56E07D3D77
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjJWR0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjJWR0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:26:11 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8F6A2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:26:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53e70b0a218so5345748a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698081965; x=1698686765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiki+rx48OzrXJWoYglYJgoiu/eOXoM93dwbSSnqdNw=;
        b=RuNVDhJ0ut2rMtEKo2unrCHOryd5OIZP9tBvaxpDKw/RebrADD3+kisN8KZpeucw+D
         651ZijZuzmjyPhyNmKc0Clc7AVPJzDN9x5bytgeya+rXyqDNZZoaQBSpN2XgxVNSozc1
         JtXzCqo5cK53KYv4PohWyOw/w7czOPbma7uus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698081965; x=1698686765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiki+rx48OzrXJWoYglYJgoiu/eOXoM93dwbSSnqdNw=;
        b=tCilWt5Nz5hyC1nZG3bgVgsXbIl983vniCbabqBXVdHIqjcjx+6HxJKmdv9lebt/oT
         fsqaZ+WgNwVp0zLfJrmiYJMfsH1ByNieDyTGbITE7aEazvpVA3rQHXtXgQ2QVxjvP0wV
         PEHjPTOKEzw4GLtewMln+ACkb5mbg6nnPtj/iS7kuN+aTC1BN3yg9CTs+jwaZr6i/i41
         TOgGqdj9Saq7jgrJ/QELnaH8XJM7Z7I0zEGvflZY5ypTe55VxueGBCSF85SuXnzDR8f/
         aapbdBjt/fOeNOlVorZuxl7G2/bxqW4Qk6OQ6+6SDDdAAFlw9v448x9TYvaYrWj6ATVX
         33vg==
X-Gm-Message-State: AOJu0YyloXwRcPo/KmWFaoCKyaXRk9dI6KSI8YPA6Zo8R8bOztnbtKAD
        rZcaW2O9FdIcGRGUMV81Uw5D8inBcRoe/d8GuI7ozQ==
X-Google-Smtp-Source: AGHT+IFBERacVNNK2FodNj3gW1Li4p9kvXenXgs4Wpc6/7Sh3wao6UpMag5dE9/nF44cMit2nzz1fg==
X-Received: by 2002:a05:6402:5106:b0:53e:4dc6:a2e8 with SMTP id m6-20020a056402510600b0053e4dc6a2e8mr8378775edd.19.1698081964996;
        Mon, 23 Oct 2023 10:26:04 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id o2-20020a509b02000000b0053db0df6970sm6742564edi.54.2023.10.23.10.26.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 10:26:04 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so4595e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:26:03 -0700 (PDT)
X-Received: by 2002:a05:600c:3b1b:b0:404:74f8:f47c with SMTP id
 m27-20020a05600c3b1b00b0040474f8f47cmr5652wms.5.1698081963601; Mon, 23 Oct
 2023 10:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <DB3PR10MB683528B8252ED2A802A0E154E8D8A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DB3PR10MB683528B8252ED2A802A0E154E8D8A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 23 Oct 2023 10:25:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W0G6C-=99viHMQaW2REGRQr2xgaejnJmadOdZkoE7AjA@mail.gmail.com>
Message-ID: <CAD=FV=W0G6C-=99viHMQaW2REGRQr2xgaejnJmadOdZkoE7AjA@mail.gmail.com>
Subject: Re: [PATCH] drm: docs: Remove item from TODO list
To:     Yuran Pereira <yuran.pereira@hotmail.com>
Cc:     airlied@gmail.com, neil.armstrong@linaro.org, sam@ravnborg.org,
        daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 23, 2023 at 9:31=E2=80=AFAM Yuran Pereira <yuran.pereira@hotmai=
l.com> wrote:
>
> Since "Clean up checks for already prepared/enabled in panels" has
> already been done and merged [1], I think there is no longer a need
> for this item to be in the gpu TODO.
>
> [1] https://patchwork.freedesktop.org/patch/551421/
>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> ---
>  Documentation/gpu/todo.rst | 25 -------------------------
>  1 file changed, 25 deletions(-)

It's not actually all done. It's in a bit of a limbo state right now,
unfortunately. I landed all of the "simple" cases where panels were
needlessly tracking prepare/enable, but the less simple cases are
still outstanding.

Specifically the issue is that many panels have code to properly power
cycle themselves off at shutdown time and in order to do that they
need to keep track of the prepare/enable state. After a big, long
discussion [1] it was decided that we could get rid of all the panel
code handling shutdown if only all relevant DRM KMS drivers would
properly call drm_atomic_helper_shutdown().

I made an attempt to get DRM KMS drivers to call
drm_atomic_helper_shutdown() [2] [3] [4]. I was able to land the
patches that went through drm-misc, but currently many of the
non-drm-misc ones are blocked waiting for attention.

...so things that could be done to help out:

a) Could review patches that haven't landed in [4]. Maybe adding a
Reviewed-by tag would help wake up maintainers?

b) Could see if you can identify panels that are exclusively used w/
DRM drivers that have already been converted and then we could post
patches for just those panels. I have no idea how easy this task would
be. Is it enough to look at upstream dts files by "compatible" string?

I've gotten side-tracked at the moment so I haven't been driving
progress on this very quickly. I still plan to poke some of the
drm_atomic_helper_shutdown() patches eventually...


[1] https://lore.kernel.org/r/20230804140605.RFC.4.I930069a32baab6faf46d6b2=
34f89613b5cec0f14@changeid
[2] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[4] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.or=
g
