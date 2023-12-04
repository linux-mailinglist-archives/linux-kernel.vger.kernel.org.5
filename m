Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E045B803345
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjLDMnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjLDMnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:43:42 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18138C0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:43:48 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c9f84533beso15848401fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1701693826; x=1702298626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifaBWDok56rOJrwktkTbeCMpMChkalyopQG2VrB4qc0=;
        b=B85f2YZVEL8Wx/g1k7QRvfHAS4AR1d6l+jW09gjds6Dy0vImnM8CbqoJ+qWBj3hRM7
         iOCYIWz0l3HwaXv1HScX7FN0dBjncKZylSzLuo/Hf8bPOZrKjDMzLTIxsv+FXMTR9vq8
         uwomzKuu2QsJx/HxZnjD/tFzAoBie0g+HSTfV7fb+TgNie4qPOM32TBSD8Lm4HMY3cYH
         Tq5IMwFHc8BAxKgGIChb/JOF9aWSca49tqdzRkpc5pjz65bvXHUav4uM3Y8oJYNfzijN
         XfQQRk1bVXLZ6Zc4VFiycPtGN56fbwDt2kMk0ZmKYlUiADSpadi9gIKLHRZcxoD93U8b
         JWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701693826; x=1702298626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifaBWDok56rOJrwktkTbeCMpMChkalyopQG2VrB4qc0=;
        b=W/tXCA5loNw7BFjUbnAlqLKu9VBWvMP0s5pPvEBrJ1ht8WV5G/IF1cl7JD7gQ7wdz/
         1arHk9k8zlD+jCGnpAHvC4aGQPzdfThH5AecekmzlZx1pR9YpALwTKRYED+AXGGVQ9wN
         e0umjmqGqn/vSXsvYDOAyk4OVy2W/9D3EbQJztUsNV3yYAM+5B09keOrK8q9NixQ/Ats
         iVlSQPHCt4i79N+1NOFyJtBfPlvWX1M1PQhg1nlJMhaSSfl5LlvLDBZlNdgJDiXx59Q3
         SFzef4+A6C3ffHPF8B/CKsBzmpJpODt/KzcUq5SgKGrD/mBcifphmmzwH/TX8pf1u8M7
         bp6w==
X-Gm-Message-State: AOJu0YwEfQEmpZmbP9mYqQanwb2qr3jSNhasA1tFdKVXrfpqtYbk/b/U
        ApvLORqgChi3uRNMjrx/3Q8kC35PFSdaU2HBZjsNBaBCPH46iUU/w0s=
X-Google-Smtp-Source: AGHT+IH3a/5RYp3bEr2Ffk+LqkGB1gJR/4JfjcVTZLOOnjaHj0lfPxm8gmvBYA3s5LXfwyoiDu3kXOuxYA9OSeqTEvw=
X-Received: by 2002:a2e:3004:0:b0:2c9:d874:6f02 with SMTP id
 w4-20020a2e3004000000b002c9d8746f02mr2293034ljw.95.1701693825991; Mon, 04 Dec
 2023 04:43:45 -0800 (PST)
MIME-Version: 1.0
References: <20231201125638.1699026-1-max.kellermann@ionos.com>
 <20231201125638.1699026-2-max.kellermann@ionos.com> <2023120424-siren-catlike-eb00@gregkh>
In-Reply-To: <2023120424-siren-catlike-eb00@gregkh>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Mon, 4 Dec 2023 13:43:35 +0100
Message-ID: <CAKPOu+_iV3uZpwKU0=nGhgmGdgqqgJE4B7Snjkr4Dk-9hCExSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs/kernfs/dir: obey S_ISGID
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 1:22=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> I only see patch 2/2 here, what happened to patch 1/2?

I used "get_maintainer.pl" as "tocmd/cccmd", and apparently, only the
second patch touches code that you maintain, and "git send-email"
determines the destinations for each individual patch, not for the
series, so the first patch wasn't sent to you directly. Not sure how
to configure "git send-email" to merge the destinations of the whole
series for all patches, but I'll figure it out for v2 (fixing two
minor checkpatch warnings). Meanwhile, you can see the first patch
here: https://lore.kernel.org/lkml/20231201125638.1699026-1-max.kellermann@=
ionos.com/
