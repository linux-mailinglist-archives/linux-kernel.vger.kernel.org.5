Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8DD7BFEA7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjJJOCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjJJOCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:02:48 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A474A7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:02:47 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7bbcc099fso11386727b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696946566; x=1697551366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iq4eoW8jfFj/+ZP1aTkhFBnmtOEaFbXmrzqoRlws6JA=;
        b=CPthzV1TPYANATT2/u+wqSknOSioLJzPexD+yyi4SBcj8AAo6mmeY5xgipmTLrnl0p
         WoRSTNzKkwqK4p/Hkwyr3sEJdBFFURq+jBXoBoqS1HK/X1DUF4Qv8HiaTa15wid6PvwL
         dYVeMVbpZhviwix7XeRSTVA4u23U4DfGa1uMkeQ5ePuWInt/KD4I4d6Z01YLYQLpyNwG
         7c7By85ILQuq0ZMwyhtGcpQ1QVaRHhnqx4KTRYH+oXcjjodNkqLdsjDuBLl12Lz0IlwF
         GL8uL2/uGpZi5fgDzlU3KZc09YxM3hA9U96TYkEFmnj7uOaK0P4fp7bst4XnMhBOPOSy
         m2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696946566; x=1697551366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iq4eoW8jfFj/+ZP1aTkhFBnmtOEaFbXmrzqoRlws6JA=;
        b=JEusP+sanu7EZx5fixl2DEPsBovntjWxHSQCTziiIS9G5+bpkfUaEvifEhKyI7D5tE
         DdXAJBWwtiBvr+RJLLMASFw2MXWsF5TMKCfnrZuqm9l6pcdDiA8+uVW04IkoPTntiF08
         poRaN0KPOY+eegHKbZ4smr+1cVr+Z8JvVozm+6NqLo/DuWDVRRm9wVn0WY69fO0uY8v1
         aHAmOWy9P+Uj3dQs15Rbd6iJ1MIj6DOKd0jxnjkyDxGplC1AogvUvLAcdPcGQ8e8S/q1
         KswURLLWKMz7vXkk731gDCyVGKrXvjndXDaxTIgPX6adHdQerAYSCXyleiF5iBmviy4m
         fNSw==
X-Gm-Message-State: AOJu0YyKf7VriUR4Ypsh0LISEFOpwq092wcXoiLRAyC9J+Ga5CZOIc19
        BMdoPIAv3DYJOcBUImUOIDrkAxKaKqG6wwUDMz5OpqHd3Y1Rqc/4
X-Google-Smtp-Source: AGHT+IGb+fobYyH9jPWXdnwKZrIwUquLwcs9mLIeGss2OMDSLJCnSccmCbPwIL727hUYqgvMAIu6DiOKkAByEiq7Yms=
X-Received: by 2002:a25:8407:0:b0:d86:b9d5:124c with SMTP id
 u7-20020a258407000000b00d86b9d5124cmr16715855ybk.37.1696946566156; Tue, 10
 Oct 2023 07:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <m334yivh1f.fsf@t19.piap.pl>
In-Reply-To: <m334yivh1f.fsf@t19.piap.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Oct 2023 16:02:35 +0200
Message-ID: <CACRpkdZ+7YFYNPXuiFU=JRZYOia5V+145dpRrLN+LTuHE5RuUA@mail.gmail.com>
Subject: Re: [RFC] IXP4XX MAINTAINERS entries
To:     =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Deepak Saxena <dsaxena@plexity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 1:44=E2=80=AFPM Krzysztof Ha=C5=82asa <khalasa@piap=
.pl> wrote:

> Are you OK with the following?

I'm sad about you stepping down, IXP4xx has a mean time before failure
of 60 years and we've only done 20 years yet! ;)

> If so, perhaps you can pick it up?
> Or state your Ack, or something :-)

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I sent a pull request for IXP4xx today already, so just send
this to soc@kernel.org for direct application.

Yours,
Linus Walleij
