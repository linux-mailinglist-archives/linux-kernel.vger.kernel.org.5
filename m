Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C4279438B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243262AbjIFTEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbjIFTEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:04:41 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674371FDA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 12:04:06 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d74a012e613so137240276.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 12:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694027023; x=1694631823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8z7JfMeTWIa2dMIiQZF3QfNFt+waJmFYaLRg5N1AX5A=;
        b=eo+K1xA7ms6DFDGW/npp6j1DlZ9ma2kXzhbQMBJ4a2VgYVEFXPkeaBQVVADWrSkaaL
         4H0NyWrMepvuD7mzRqytOve+hi6s5VTklS43E6CUeVRcvDEL5KY8gDQSQrqpVmtXxYzP
         0Pb8AvCA7doDlXW/pQ//NIGzftAAN9rB9gc8magZoSt7z7gct3D4KXUu8sosZXN1uyd7
         qi29bkrHpWfjTBTnC2vmdtrwnJVdpmyhWtKUrkZe4JrgwwZCgIxsB7CP2gSNbTN2iSU/
         3Mmf4JaYShJ93KiHxmzJBP52gBRm7RX9rOiHAybadKPBvgekIYFJaV7k2M6XHRHfZ08e
         rB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694027023; x=1694631823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8z7JfMeTWIa2dMIiQZF3QfNFt+waJmFYaLRg5N1AX5A=;
        b=cL+73lIKxlJZZGDj8TLFmDFMCg0gOHbMkjFgAvmIOn1BfETpsTpr0fmYu/VX1K/+qz
         Qt1F74gqH1qz0BqTgGp0S6mIcA6ZID1QGQbw/Qk+6oYOymqLyazyLqqHWo0zfF7/F+Xq
         Sh006+NIl4JPm6SwfJ6dBQjHzSds9sjlKE4cjr/k0p1MccEuouAdghb2kRm1GouEa8CR
         1ntkRNd7XHKkD3xY6MLQZ8W7Nbe2AjmQCfTy4AwKUjWRtSVfUrgIs41kSMk3VKqogPTr
         kdO8a4jBj0htM4U3jrgxjIDH+vQT18lxevNN34+yfmWwLWUvnmjuaJ9rqTaVSdn4nP1R
         43pg==
X-Gm-Message-State: AOJu0YzPp1Kn8CMHo6ryZIYWeNTR+KCqhjbEssBIqvpQIsyO8GqQ7xxq
        mnvwLmebuJnCHCfl6354SiKatpNkktd7F/ooB3NsBg==
X-Google-Smtp-Source: AGHT+IH86FyU3nX8IvvfomZQMTa9OGpwmdFMH+65w5YXwKbO2KVUTcIKAGjBIG77tJnR85zEQ4SNo0g2UWc6erEZNP4=
X-Received: by 2002:a25:a429:0:b0:d79:e08f:e9c2 with SMTP id
 f38-20020a25a429000000b00d79e08fe9c2mr496388ybi.11.1694027023098; Wed, 06 Sep
 2023 12:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230906095542.3280699-1-sarah.walker@imgtec.com> <20230906095542.3280699-4-sarah.walker@imgtec.com>
In-Reply-To: <20230906095542.3280699-4-sarah.walker@imgtec.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 Sep 2023 21:03:31 +0200
Message-ID: <CACRpkdaNbr_7ivzz=fam2rup0HYH6UivBexLDWLLyWiXDSHoOA@mail.gmail.com>
Subject: Re: [PATCH v6 03/20] dt-bindings: gpu: Add Imagination Technologies
 PowerVR/IMG GPU
To:     Sarah Walker <sarah.walker@imgtec.com>
Cc:     dri-devel@lists.freedesktop.org, frank.binns@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, corbet@lwn.net, christian.koenig@amd.com,
        matt.coster@imgtec.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        faith.ekstrand@collabora.com, afd@ti.com, hns@goldelico.com,
        matthew.brost@intel.com, luben.tuikov@amd.com, dakr@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 6, 2023 at 11:56=E2=80=AFAM Sarah Walker <sarah.walker@imgtec.c=
om> wrote:

> Add the device tree binding documentation for the IMG AXE GPU used in
> TI AM62 SoCs.
>
> Co-developed-by: Frank Binns <frank.binns@imgtec.com>
> Signed-off-by: Frank Binns <frank.binns@imgtec.com>
> Signed-off-by: Sarah Walker <sarah.walker@imgtec.com>
> ---
> Changes since v5:
> - Update compatible string & description to match marketing name
> - Remove unnecessary clock-names definition in ti,am62-gpu constraints
> - Document that GPU revision is discoverable

This looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
