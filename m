Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26001803769
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345757AbjLDOra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbjLDOr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:47:28 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39E1C1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:47:34 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-4b2dc44d54aso289995e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701701253; x=1702306053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bX/Yl6Fne78JiTtjbgizPJTRVPgBrbrjEPicipm3hfA=;
        b=da0SoF/lNx/KbqN6eRJSInC8lQdDj2SgrP4dTpLPI+YYxXC/QFFmglkH/Pq+FRsdeF
         fdDF0sn2lclcw6E7Md/UzcJiijuGaQKSx5zxjzK3Ts2y159+uvRdHxtPK+unsmLWPHYw
         7eiDGAawUtOx3jY7X0Y5QW9riDp6+Syy2Xx1pyuvKXDS0H3Y4N14JwKAPs+5ZNdDN4ow
         6mN6w2u9hn+iDta/kZ1SoeOvyzd/nMOMD3Jli6NQ+zXLWN4LAUkIP60znEc6ZQ8YoPBy
         6VhtgqUSqT0GQh+ivE1QSpsxoPl+e/d87AzbczjdkLBaJVEkaPcFYkN0hncd3xyv7bRv
         VrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701701253; x=1702306053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bX/Yl6Fne78JiTtjbgizPJTRVPgBrbrjEPicipm3hfA=;
        b=mvj8RXCb/fwtqexR1P6qMXBFmXsQGh6NbA7pgQj5LJT/YDrbaBeZ/IdwkzeXDFiv94
         bLla2Qo72g0JzyDFN1vmBkTEutsUDvQDihSjM9Hz1Nmqgj8Z4d3QT4pBLwqvsogp9GYV
         yCS+odvTHuTaiLByEvdywz6y4t9+lxCYm47mZKL4fNw/o/vEXVuv8iJKsLkvsWzxcnZE
         o3E06BKUDf+osl/UY43D27oe8biV5YpRxPHD+3AZmAg3hLzjEZrx20EOJOQHOcA140/X
         9aywP4y5Jg29ACNpTrufZtL3Kr504k4jfb9ENerEyOHjW8x9lE2HIYLT0RGUhqbjiZ1r
         np1g==
X-Gm-Message-State: AOJu0Yw589MPzWf929kbKpTe+VhO/NTR/O8R3lGoYc1s9Y79uHObDPKp
        vDoBM/isCInTxFMf+c9VCvNf7XaZquNmjSjnowGTqA==
X-Google-Smtp-Source: AGHT+IFY73W+4MNAcyCY6jIfpVp53Q0fNfxy46tIpnAyBJEpAJ8ayAz5DWAMLJpNXPZqLCf2s0/Dt+6hTFOFUBadvfA=
X-Received: by 2002:ac5:c4cf:0:b0:4b2:dbd8:c38c with SMTP id
 a15-20020ac5c4cf000000b004b2dbd8c38cmr1159608vkl.17.1701701253555; Mon, 04
 Dec 2023 06:47:33 -0800 (PST)
MIME-Version: 1.0
References: <20231201172212.1813387-28-cmllamas@google.com>
 <20231204115743.43597-1-aliceryhl@google.com> <ZW3mFp2Zo85N8pBE@google.com>
In-Reply-To: <ZW3mFp2Zo85N8pBE@google.com>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Mon, 4 Dec 2023 15:47:22 +0100
Message-ID: <CAH5fLghSHt+8Q+1em=RsPmxW4hpuwoYbjO7A2fK18-vbWJm7fQ@mail.gmail.com>
Subject: Re: [PATCH v2 27/28] binder: reverse locking order in shrinker callback
To:     Carlos Llamas <cmllamas@google.com>
Cc:     arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        tkjos@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 3:45=E2=80=AFPM Carlos Llamas <cmllamas@google.com> =
wrote:
>
> On Mon, Dec 04, 2023 at 11:57:42AM +0000, 'Alice Ryhl' via kernel-team wr=
ote:
> > > +   trace_binder_unmap_kernel_start(alloc, index);
> > > +
> > > +   page_to_free =3D page->page_ptr;
> > > +   page->page_ptr =3D NULL;
> > > +
> > > +   trace_binder_unmap_kernel_end(alloc, index);
> >
> > What are these trace calls used for? Previously they wrapped the call t=
o
> > __free_page, and happened after the `trace_binder_unmap_user_*` calls.
> >
>
> It also used to wrap an unmap_kernel_range() call, which explains the
> naming of the tracepoint I suppose. It looked like this:
>
>         trace_binder_unmap_kernel_start(alloc, index);
>
>         unmap_kernel_range(page_addr, PAGE_SIZE);
>         __free_page(page->page_ptr);
>         page->page_ptr =3D NULL;
>
>         trace_binder_unmap_kernel_end(alloc, index);
>
> My thinking was that we care more about the page->page_ptr clearing but
> it sounds like we could just drop the tracepoint, we no longer have a
> kernel mapped area.

Ok. Feel free to remove or move the trace calls however it needs to be
done and add my tag:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
