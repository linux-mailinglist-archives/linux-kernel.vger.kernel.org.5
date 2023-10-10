Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A867A7BF12F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441930AbjJJDCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378482AbjJJDCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:02:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E3CA4;
        Mon,  9 Oct 2023 20:02:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53808d5b774so9273372a12.3;
        Mon, 09 Oct 2023 20:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696906938; x=1697511738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NFw7jVHwZYrsuKeB3oiagILvwz0AJLaFyHBUay/pXI=;
        b=KedbAA66c2lovP2/bCByzWMAYTxUQ0R/c7/hjpCoUx8SEhU9br8HN8HtYEbTi6L/Fz
         n5hTt6CD1m4OJhl+Cw3ICSD0VJXJZYF8nTG7ZwhNLEZ5GKf5PQhoOHHw5IBPT/pU1aru
         jT6L+musipjgz5qcQpGVJP1bGKsNyKFmo9xZBJxOEbmLT+AuZzgxf1jAtDHWDCaV4yhl
         E0NxVgpNhJnYSVuT3Sm1XTDLMw7XRUxv67LlPip23Nq8SM6raDi7nqeGHQ4GKFl38GCJ
         Ltk7KWiT6H73uA9j2aejVcqmgTMYDh+yVZGCXjlW6r7ADwHaIQMLtTTD9AS4GQpkgohE
         Md9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696906938; x=1697511738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NFw7jVHwZYrsuKeB3oiagILvwz0AJLaFyHBUay/pXI=;
        b=HBBfPpfSmEVLp1dBlpcHi7ihY8dvGe1ngKserIE4LfybURN3wLa5RCiqW+/cu37ShK
         czPV0lnQPmi+eannV7o4p7jOA9FnO+uCouR+7v9ty6i0FR4q39hB+Ifsy5dhd1Umq4A6
         7w61S8KGWs5zcFkR87zBPV4ngNhcHUWbsKz0jd+9TwJ575mspwYrTaeYRtdqyNiwxxzy
         e9gg3+ZanOwbKdWPBQi/5pvlx/r5QkBiOJ3SjbqQdUkX27uvvzdkf2wtRfUHc1UhJPP7
         9xt6C37EIoIxdI4YL2ivwU4dPwVvNHons4CrvllsBFseNlJtuQmPTTLZMzJqYfCEpJAI
         Girw==
X-Gm-Message-State: AOJu0Yxgeo/Mr2/DRLu8od0vOk7VzeHFrSqqmw97H50IRZ0RHtL+vaoP
        RgIWu3608aA9sEa3oNJ8qKJ41Std2osF2ZZMKpE=
X-Google-Smtp-Source: AGHT+IH6dZvjOAHSoyZ23JF4sn6FJyDLMeAw5grAZpTEz+0OBLlzvWWcjEkif2Tg9mP7XdnE3F8cAKLKbkxmFY5kzDE=
X-Received: by 2002:a50:fa95:0:b0:52c:92e3:1d12 with SMTP id
 w21-20020a50fa95000000b0052c92e31d12mr14278796edr.11.1696906938155; Mon, 09
 Oct 2023 20:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231009161028.it.544-kees@kernel.org>
In-Reply-To: <20231009161028.it.544-kees@kernel.org>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Mon, 9 Oct 2023 23:02:06 -0400
Message-ID: <CAKf6xpvPgaSMA=oCMgXqoHWYfYt53_U1vAhvh1dX6HHytKjOwA@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: p54: Annotate struct p54_cal_database with __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Lamparter <chunkeey@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 12:10=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> Add __counted_by for struct p54_cal_database.
>
> Cc: Christian Lamparter <chunkeey@googlemail.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Suggested-by: Jason Andryuk <jandryuk@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Jason Andryuk <jandryuk@gmail.com>

Thanks,
Jason
