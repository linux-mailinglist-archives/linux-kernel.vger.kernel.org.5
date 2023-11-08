Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88DA7E4DB4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjKHAEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjKHAEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:04:42 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E72310E4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:04:40 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5437269a661so490465a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699401878; x=1700006678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1gFsj3ZQRKq2XSC6mkK8HfxUGZGy5exG2oL8DwFzoo=;
        b=IOOZs+Pl6ljyHcuHuoHFKCMZOe19v7u/pG8eCMcAffrxlquoh3xilJVcmQqZjYWWOf
         RsRWONKKhaw9n1UpbmrSEyUS0TOxol14HEU7N23Arj9OiPLzZgKXqCc5Fdz8tV1nkJ4v
         zmjPVyYvOe2PIi+IeH9lHL95d1pkIs0YG6Usg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699401878; x=1700006678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1gFsj3ZQRKq2XSC6mkK8HfxUGZGy5exG2oL8DwFzoo=;
        b=b5UtS7KiA4mM0yt3hjhfleKISFZ8TfbE4yaQIiyWgT525H0W2bwIpXsdWq9iKr/gsA
         1Qw3W/md1Ib9Tt1zi2V3RIL0WLoGGW6/kVp+/1FIe3vDGQ8Idd4/u5fANyhWdPblkiuU
         XCBljN3Fpzm/Y2xixSr7zzI0Dc7S+hCshI2KgurCUSafbPfQulR7HS80JDmJjyzZeJSr
         +ZoBguTK8WJqD1BW2P+WObfy9WU1L7XnbX7XNfcaJgOJotsi68BWKxtfJipgclhy3pGZ
         JHjuFgVG8vMqUnDYOwVImOHs4Ru0f0kMl97Xwv+edIC2jL8cwi8+KZmDrzzKT5kvByOI
         yzxw==
X-Gm-Message-State: AOJu0YxkAWLlylFZoN/KFC1JKnmhc69Aq+jx//xmqGnUAjJMFzdEM5MB
        0+CyTe02FaNrMgpmkXU0LWRZAnm7kj47QhutI/9XKA==
X-Google-Smtp-Source: AGHT+IF0QlWf0ufWIpT0rd/wyWdY+QoaUPsEEGKuvHTV2bIzyRYV84r95KdlFHu1ox2T3ycH1Jc+VQ==
X-Received: by 2002:a17:906:1d05:b0:9ae:5879:78dd with SMTP id n5-20020a1709061d0500b009ae587978ddmr3602140ejh.1.1699401878636;
        Tue, 07 Nov 2023 16:04:38 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id f25-20020a170906085900b009c758b6cdefsm161294ejd.128.2023.11.07.16.04.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 16:04:38 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9c3aec5f326so45972366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:04:37 -0800 (PST)
X-Received: by 2002:a17:907:7784:b0:9bd:81c3:2a85 with SMTP id
 ky4-20020a170907778400b009bd81c32a85mr3252018ejc.32.1699401877597; Tue, 07
 Nov 2023 16:04:37 -0800 (PST)
MIME-Version: 1.0
References: <20231107142154.613991-1-agruenba@redhat.com> <CAHk-=wie7WsYHkEChV0hpcf7CRRJQw9-E8O8RxrFGKF6mEJ73g@mail.gmail.com>
 <CAHpGcM+u=77p_k8dZ6gKu84wnkdvGYA4E6=MXqNw=ZY+ejjiaw@mail.gmail.com>
In-Reply-To: <CAHpGcM+u=77p_k8dZ6gKu84wnkdvGYA4E6=MXqNw=ZY+ejjiaw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Nov 2023 16:04:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiN4e_C+tONr6p+f51ae8QoXB8tvoN8zQFdyiRi1DzO1A@mail.gmail.com>
Message-ID: <CAHk-=wiN4e_C+tONr6p+f51ae8QoXB8tvoN8zQFdyiRi1DzO1A@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fixes
To:     =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 at 14:18, Andreas Gr=C3=BCnbacher
<andreas.gruenbacher@gmail.com> wrote:
>
> I apologize for referring to the entire set of commits as fixes when
> it's really fixes and various other things. I've said so in the tag
> description, but I realize now that that's not good enough. Lying
> about what those commits are wasn't my intention though.

.. and hey, sorry about my outburst.

Your pull request was the first one this merge window where I reacted
to how many of the commits weren't in my copy of the linux-next tree,
and there wasn't any reason why in the description. So I reacted very
strongly.

It didn't help that I had a headache. Rather than look at how many
other of the pending pull requests I have that ended up coming in in
the last 24 hours have the same issue, I decided to lie down in a dark
room for a few hours.

                  Linus
