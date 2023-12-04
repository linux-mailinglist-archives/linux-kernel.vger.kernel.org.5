Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DC68031A0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjLDLiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjLDLiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:38:10 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D290DD5;
        Mon,  4 Dec 2023 03:38:16 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54c79968ffbso2379854a12.3;
        Mon, 04 Dec 2023 03:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701689895; x=1702294695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TshOAyXPwgpEMcSujG2nmniqgvta5JHY6dbp5d3/QQ=;
        b=D1qUjECQaTH9vrawjQidP3EgYswoWAnGxoGdxp3jdgEHy5UvqpFGOpYK938/7J1z9/
         Wqu6bXe22Wg7jVrC4DHn0L/6l8DBUS6agE8iX5Hiauz1kXvljJWXV2yuIhMm5C+cG86N
         xsP7e445fXxp7x47IYyc+8JV77QJ+K8Ye4JM05T7ad6BiIIIbb5MTPIXyihDEW5ZCkw8
         YBLXv0sS8lUyK1kYoVGRlUCePvSWxM4yv4WaMX0aGke/9ozUpSdUhMpwQJANC664yXMI
         R/fNO5fzSS2I0N218KMOZKHVbFYDWMWle8qDkmMbiMVVlAmfTapbKjRsIjB30Z1jOhKG
         xQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701689895; x=1702294695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TshOAyXPwgpEMcSujG2nmniqgvta5JHY6dbp5d3/QQ=;
        b=IWue88jxOJokokIqmMNq20nybu+f6DT+Aq7nMJsq9Rt0HdKXE2Vc90LTkd7E5zlPDj
         Dd+q/IV9m2zZuoqX/2qp3Qmw6Mbt4GDiVSHBqUT4xVrzk/wBOQaZGf75n+D46udOPFYh
         eiRWYY7544HkaGm6lLuuGg90OiAXNa4lmZEFvH9Xr7AY9XBozbuV/Rubt4M1bwYyiBQw
         hD+lwaiUHcMbC5FK2rNNYie7ilpFCBaWu8TaZzDrbKh6GEW+1zAPMRXmg2k8KPwrZSsF
         DKhHUjUbwyvqfPK0n7AIprGZcxRcLTF8Btlr8JVb01GMoQ5T/pKFoRRiXWaO1CLwcoE3
         QkUw==
X-Gm-Message-State: AOJu0YyQqj2uwRJM1KZlv1qfF7MvBFCOVb1mdBFp/QBrcZwrh8vM8ddM
        GcQx1JMsjm7oZzWTGr7UseTeKJYNuqJekZ0pOcm/6xYEpTw=
X-Google-Smtp-Source: AGHT+IFhQPSht53hH+KJU08jzHUqjQ69yCeOObv98M4zwamnkX/04Bw9md0GCg5VFBhdebBH9UpS4WWiOKD4RY1hgng=
X-Received: by 2002:a05:6402:28a4:b0:54c:e4d9:758b with SMTP id
 eg36-20020a05640228a400b0054ce4d9758bmr337039edb.34.1701689895032; Mon, 04
 Dec 2023 03:38:15 -0800 (PST)
MIME-Version: 1.0
References: <20231204033549.2020289-1-wenst@chromium.org>
In-Reply-To: <20231204033549.2020289-1-wenst@chromium.org>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 4 Dec 2023 13:38:02 +0200
Message-ID: <CAEnQRZBseYM8FO+fJND6pxhDrH+TFc8k6Aoj4ScNwXaz+Whmng@mail.gmail.com>
Subject: Re: [PATCH] ASoC: SOF: Move sof_of_machine_select() to core.c from sof-of-dev.c
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Dec 4, 2023 at 5:46=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
>
> This reverts commit 014fdeb0d747304111cfecf93df4407c1a0c80db.
>
> Commit 014fdeb0d747 ("ASoC: SOF: Move sof_of_machine_select() to
> sof-of-dev.c from sof-audio.c") caused a circular dependency between
> the snd_sof and snd_sof_of modules:
>
>         depmod: ERROR: Cycle detected: snd_sof -> snd_sof_of -> snd_sof
>         depmod: ERROR: Found 2 modules in dependency cycles!
>
> Move the function back with sof_machine_select().
>
> Fixes: 014fdeb0d747 ("ASoC: SOF: Move sof_of_machine_select() to sof-of-d=
ev.c from sof-audio.c")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Thanks for fixing this.

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
