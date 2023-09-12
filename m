Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC7C79C99A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjILIRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjILIRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:17:02 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D543FE73
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:16:58 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d7e9d849bdfso4622724276.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694506618; x=1695111418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6RGfYRFPXOdj912iVMfEgfkufAW2hfFKbw8063QGj8=;
        b=XMesouPHqx0GDPIbSkl+Ff8EcJYB4IWw+90vgbqSa5Re2CyzcZJun47XBvDy6aZykb
         L7tJhoBEbSrTrs3u8qpX3QLyImFip8fyRue2rjj3qpGXhTatySnlWZpLBrougTmVo+Jt
         NsruI2tcjKbURBHA6MWpwCh9bPqFqc5K/CPz6zHzqiRjmYNbmT179F0UwuCr3PeY+/KM
         Hf0uprT6NqCKfg0b2JMcr+0GGZm1AJtoYXPZZyLNiz7FW4ziB2UUMf7OcvcVLpXcAWbB
         iUKCTfLzGn9Tt30N7qbqDZSHfC+R8q9SwxAbvP+M7LayhXKH3gON46/j01MIOurwKMCJ
         KDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694506618; x=1695111418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6RGfYRFPXOdj912iVMfEgfkufAW2hfFKbw8063QGj8=;
        b=KBwOPZ7b4+QQ4pNJo/sDDHZInQKxzlsZ58/iwkCe5FBumxG0T5laIHHFvPLT+0hDd6
         D3+pIqL9EgTERM5GXtSZDi6x6ihqnzsTq1J90QmWnOhYK2rmR2FHJfur3OUP1rSjuvr9
         FmyB2KJrru+JPqCstYIuTzgFsnsPY0ABbwtr6EgKcR94a4lAFoQL3LuF9DatltNhDQep
         mHgyaUCY1ooIzNqyyPL8u41dasVHJHfz+JZjueC0qWxfLBh/CYqobsiAlBHLtpth9bH1
         CLPtTmrheyhwyEVUp+mb6KaXF9LAzA1uVW8qZ9CresyXb0L/PFRkyohemn05XR49VpOI
         jXUQ==
X-Gm-Message-State: AOJu0YxZ+uWqZstsx+Q7p+phFVjj7BFE/l2IK/QOekmrd8LPvw8XcXsN
        hnxV+hhxOFI3HhxuHCdR/i9R54erPJqqyTIJ1qWEWA==
X-Google-Smtp-Source: AGHT+IGjg7IAksfDlRe/Cye9RRC/1cK8ZBAaKvMgb15gIkeFfbf1pX+zTtOYhhJVTPUcDjSH5LyQ/Bse3k0BXF00j5s=
X-Received: by 2002:a25:d697:0:b0:d47:8db3:8bcf with SMTP id
 n145-20020a25d697000000b00d478db38bcfmr11703010ybg.49.1694506618096; Tue, 12
 Sep 2023 01:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230909063613.2867-1-jernej.skrabec@gmail.com> <20230909063613.2867-2-jernej.skrabec@gmail.com>
In-Reply-To: <20230909063613.2867-2-jernej.skrabec@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Sep 2023 10:16:47 +0200
Message-ID: <CACRpkdbaSza1KjbeM3X4103xcWZx+4cwAnMiG9eaLF4JVZv0JA@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: pinmux: Remove duplicate error message in pin_request()
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 9, 2023 at 8:36=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmail=
.com> wrote:

> Detailed error message is already printed at the end of the function, so
> drop redundant one a few lines earlier.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Patch applied!

Yours,
Linus Walleij
