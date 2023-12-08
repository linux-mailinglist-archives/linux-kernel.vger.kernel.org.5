Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1A080B002
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbjLHW6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLHW6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 17:58:08 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267CA10D0;
        Fri,  8 Dec 2023 14:58:14 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-db7d198e791so2592122276.3;
        Fri, 08 Dec 2023 14:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702076293; x=1702681093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vkZJWyCONDAHz0FaVDvZB6zmKrAESqJ9IE9pDa4fis=;
        b=DxJak9az09YX+RrcjR0SqywDrRGIkChSW8jPuyhrRazmcBYGGCltlV0X6aH+Ka0DN2
         6bUJMiNHGGhvS6Kua+aZWm6nzQg6r8djsSQCxlRex5Jm8RomRKPe/RdHDe0hx6aQVs+C
         ZwzUQjrNE3VCerZ+FGKRYEUWetzywvSMuTNsnU06Eqw6IqXctGKZRv1lxeGPVFc8/S0k
         4VoFiHdLfx/gqBHqCUDMJZlsZHjW0NirsuZ2/xrMn2E5hO1mEosfN/tDP1Hw/VWUMRHR
         yDzIMxEtK7ITJ9OapZmb+8lBQmW0KkFkUptVgUv5sVbqz1ZtDeXjUgI/Z2helHxfcoBs
         wp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702076293; x=1702681093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vkZJWyCONDAHz0FaVDvZB6zmKrAESqJ9IE9pDa4fis=;
        b=QenGuk6ugn+Pm9hew0BT6PDbvMGSqO80bikl8qcjWSQbIcmcxuznZwYR9IwJCJI8cF
         /cYQskHKYxcIfJL+BhfEw9i82U3QNhRqUUB9KS57AoFrC76GnNyI1lTA6/RPtAJ6YjFQ
         l8QdzJqCeSOouOkPse3SE8xnOBTzmebLa65CCHm0T5JuhgYjYMxKeDIu1mMR2v70LOd8
         YOOTYSvPkoYxKtbKA8K92+OmmZ9wYxOxCaxqCYmkt5gt7Cuz8FbQYmT0oZihVKzT/z8y
         xqW4TFsGrRzpxS8XKaeCf2BQ0BoRqzLiXG7dzC4tHdawhbZDp/xWa0b/1jiZwXRDjFiB
         7bUw==
X-Gm-Message-State: AOJu0YzWG2JwlsuwzZs+Cus5gE83GEaZdwSl65pU85BcHXe2ApQr7FDi
        XFiytpM8yEJ2Flm0HUF10rkGf373BESp7jW8Ao0=
X-Google-Smtp-Source: AGHT+IHRjn7Lp5sdB7NwuF75Sg/gHbOAxY9dG8W4KlGbjzvaQdcV0/6nyKSUuPNwpydoRSS5n2lAP/D1SdV+eaxYSZI=
X-Received: by 2002:a25:6b4c:0:b0:db4:72de:ba0a with SMTP id
 o12-20020a256b4c000000b00db472deba0amr615111ybm.36.1702076293359; Fri, 08 Dec
 2023 14:58:13 -0800 (PST)
MIME-Version: 1.0
References: <20231208-clang-format-mt-for-each-v1-1-b4b73186b886@quicinc.com>
In-Reply-To: <20231208-clang-format-mt-for-each-v1-1-b4b73186b886@quicinc.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 8 Dec 2023 23:58:02 +0100
Message-ID: <CANiq72n_9woLVKCTnhXAQcUkpS59O2QW_HzTLmpHXnkoGPiCQQ@mail.gmail.com>
Subject: Re: [PATCH] clang-format: Add maple tree's for_each macros
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 11:08=E2=80=AFPM Elliot Berman <quic_eberman@quicinc=
.com> wrote:
>
> Add maple tree's for_each macros so clang-format operates correctly on
> {mt,mas}_for_each.

Thanks, applied (moved `mt_for_each` to the right spot).

I have also applied a full update of the list on top, since it has
been a while since we have done so.

Cheers,
Miguel
