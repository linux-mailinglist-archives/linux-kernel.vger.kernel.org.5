Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849087BEC33
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377532AbjJIVCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377082AbjJIVCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:02:52 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D83BA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:02:51 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59f6492b415so43023057b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 14:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696885370; x=1697490170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJz0h0Tx8tbmQIBwQkViScvt69REAVK+f5XbSP6AYKE=;
        b=zUDlbyAE84bS8JysuwtlFOlOCAIWHq5vzlBdmzHuLZHTu9Su55E3ZOHSlochmwe4ku
         jUA+nBDgJjp5jJot7wg1c5nQdLExC35cCoWHvQS/AE9DqudRhIwlBxbNaDP5yy6GuK3k
         gn6JHPIjOS8no3KV+MCnjIamgwIABXgze4vo00hH2wRYKc+gaKukjamaSsq/QjUqbEyZ
         N98niBdGNGk90sjPdMYWvgAODLTESYfa37pxPF+38K9T83mGNoV0fAaW+jeUhbXOC4zZ
         cNg01NNqtizcd40c26dWJt3yPK7VEl8abjTF9eOtd41mV5IdgAK+YdqSeZKYwdgT38Nm
         Quzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696885370; x=1697490170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJz0h0Tx8tbmQIBwQkViScvt69REAVK+f5XbSP6AYKE=;
        b=DBFh06CkkttP/46HkNIrWYX3njNpM73vG+munAnlE34rIG6g3DU/6oDArelzGZGRjm
         vPITUVlsmlM8LWOJoQSmv75/bVTxkmfTlpLxkrDTy38FBnsnknP2x7ACrqCp6lDXh7wq
         FSUQnZS0j3DPt9ldqve/dSpTsHrh3VDHMT2Sk2iur7FWTALvE4jCvmRpvE1yj3KykloF
         Rvy+ZtbE8EoWf6AxOfqgpEMCmZYzFikKhzMn+X/Fg0C3BjSV+b06JJsVPna48FO0oxpD
         BLohhE5GJ9B5Ku8u6dj6SbA86NIB66O+p/IzXmeIjMTxKcTZx1hHWgq77ywKHLhcBRY1
         TTKA==
X-Gm-Message-State: AOJu0YzjomlKi5CtWWObEyPD4LyRpR6eD8yr00A465slvxqfeG+4mWBf
        783ilh/hLOSi0VAS9+7NdX3qsA0tmlapivKf7JWFcQ==
X-Google-Smtp-Source: AGHT+IG7zTQ1sPIVq6sSufNIqZ5HokqJWtqPk7b7cMpFUs43lI/+XA7kKBK7iStn8zLZan3BdCgDzKJEQFuFjmdMKw0=
X-Received: by 2002:a81:49d0:0:b0:56c:f0c7:7d72 with SMTP id
 w199-20020a8149d0000000b0056cf0c77d72mr10143379ywa.4.1696885370504; Mon, 09
 Oct 2023 14:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231007060639.725350-1-yangcong5@huaqin.corp-partner.google.com>
 <CACRpkdbek0-Vhk4_34qY+0=EGrQxJS_CfLuF_5fRozMMyc+=Kw@mail.gmail.com> <CAD=FV=UFa_AoJQvUT3BTiRs19WCA2xLVeQOU=+nYu_HaE0_c6Q@mail.gmail.com>
In-Reply-To: <CAD=FV=UFa_AoJQvUT3BTiRs19WCA2xLVeQOU=+nYu_HaE0_c6Q@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Oct 2023 23:02:39 +0200
Message-ID: <CACRpkdYrFhTCa9rJ4savOcqRxcnyqoojCnwaCk6cnJv=aWxo4A@mail.gmail.com>
Subject: Re: [v1 0/2] Break out as separate driver from boe-tv101wum-nl6 panel driver
To:     Doug Anderson <dianders@google.com>
Cc:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        hsinyi@google.com, swboyd@chromium.org, airlied@gmail.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 10:53=E2=80=AFPM Doug Anderson <dianders@google.com>=
 wrote:

> Also: just as a heads up, Hsin-Yi measured the impact of removing the
> "command table" for init and replacing it with a whole pile of direct
> function calls. She found that it added over 100K to the driver (!!!).
> I believe it went from a 45K driver to a 152K driver. Something to
> keep in mind. ;-)

Sounds like Aarch64 code. I would love a comparison of the same
driver compiled to ARMv7t thumb code. Just for the academic
interest. Because I have heard about people running ARM32
kernels on Aarch64 hardware for this exact reason: so they can
have thumb, which is compact.

OK OK we definitely need command sequence tables in the core,
what we have now is each driver rolling its own which is looking bad.

Yours,
Linus Walleij
