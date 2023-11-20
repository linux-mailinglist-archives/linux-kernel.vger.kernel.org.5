Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB937F1DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjKTUOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 15:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKTUOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:14:22 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40189C8;
        Mon, 20 Nov 2023 12:14:19 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-dae7cc31151so4382627276.3;
        Mon, 20 Nov 2023 12:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700511258; x=1701116058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjZQInSkumDPknIIf3NAz5y9yKKX3FVPVDmh/NXMtbE=;
        b=VBreR7acQ25+JfsbqIiMnG7XrED9lTnC9Wpjo6913BDOLXlYr+krvmyCA47yaj8yY3
         Kl/czyTC7TigkrnIGGbAGx/wnQ42dbOooVE9izvV+qYNpaqlWw2zX3bnoBIOhWExCHQ+
         PVEafzUFkHt2odeLMedNxy7ij6p4n28YumqFNUH6I+9fzDURZdtz6wJ/6l/hIY+FRahh
         VVAjQwqggEZFgCyLfCDMCyQe3sx64iA2A+lf9Q0nau6e2YneC6x7R3d/DJULYZNih9fC
         Gv85lgl+eN2vgDv+Gw5toRNm6EuNnYgt7aZOfF/dxwB853Fkz5hcJKIhh0lWcAAMXS0h
         7Xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700511258; x=1701116058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjZQInSkumDPknIIf3NAz5y9yKKX3FVPVDmh/NXMtbE=;
        b=UHmUD6mVPW6WAhIQV7aL15kN0rki/G/ZDnovCv/AZeE15FqImODNqFQz3ylk+gfsW3
         /mMG/Pi4Nws9+rFxT/HvXQL6nguZQdyXqo+p8w6NRBtHFCt8jjzXpNJEUKnonLrEZxHI
         QuJaNnAss+1O+6MwYw5MeVjyj5GFuBhXXu5y/MV1vdQRvvFz1kp5HuGeu47LfPHwzcSI
         y6H6O2qoh7LyyPBmS5ykV0jt1SBZP6R369sFvhM8imLTFasIqGltWVQdWnOl0O1kQhNP
         8Ydx402+MSb/KR0fa5e265kN8JAztfbsLyuy4x21kcT1q0drkTpy38RmNfuIgfCywJRS
         TqUg==
X-Gm-Message-State: AOJu0YyAfF4QvMo5s/3bNKIcQT8vtMQcKiirxiHiN3zIEQNoTNmov3Qt
        i5CySm5jWTG4hlVxpiTEm8fjsqSzHrnWFRjlCF4=
X-Google-Smtp-Source: AGHT+IFzS9COkrOxjGX+jIQpYFk8Ecx5lHTVdXiBYlbD6mkWs4M4DCTVV5hsZvwRfoMSWZ+kYEHCjGnISBHD8v1k8FQ=
X-Received: by 2002:a05:6902:136d:b0:d9a:f948:aae1 with SMTP id
 bt13-20020a056902136d00b00d9af948aae1mr7809326ybb.29.1700511258263; Mon, 20
 Nov 2023 12:14:18 -0800 (PST)
MIME-Version: 1.0
References: <20231117-maintainers-v1-1-85f2a7422ed9@google.com>
In-Reply-To: <20231117-maintainers-v1-1-85f2a7422ed9@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 20 Nov 2023 21:14:06 +0100
Message-ID: <CANiq72nTZa3YR1x_yMgffFQ3BVf9CEu50Nyd1WZS9QVBxdMhYA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: refresh LLVM support
To:     ndesaulniers@google.com
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Nov 17, 2023 at 8:24=E2=80=AFPM <ndesaulniers@google.com> wrote:
>
> - COMPILER ATTRIBUTES

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks Nick for everything and see you back soon!

Cheers,
Miguel
