Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E5A8053CE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442366AbjLEMH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442328AbjLEMHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:07:24 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB867B9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:07:30 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d99bc65219so1545562a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 04:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701778050; x=1702382850; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zSrcY98acoKnfNLTxuI3CQ8pgAhrIS9wrKdFv+hFBgY=;
        b=FoTrLTC8mpJrBd2rizRa7CqXiBbhAr6mrYSBxIpeIBRC2xykxMFil4tWV1Q0NNRZjB
         rYJKRJDQUt0wHZfkH0lqmq0+bsPhbNEZDOQgIs1dQAnIpoF84n3DzGRKBOuzzLrvEy6v
         3Erc/fN2+ZwdNDI59B7V9lPZVolElHQIXEd3dheYqXNKsGTzMDuqxNQjuT+tZ9UoFhZu
         zd3h/o8fFlCIuWBhcv3fRdUaihLWeOEgWAUl7zofS1pcXP2bZ4pGUnnEBoKdfqXM4o/U
         8b5Ai1E7IoLU7ilrl2af0GvjGzzjDiMd+zbNpghuKodzc+QOpLHz98EFd8RgQeOe/OmW
         oAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701778050; x=1702382850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSrcY98acoKnfNLTxuI3CQ8pgAhrIS9wrKdFv+hFBgY=;
        b=jpwWuCacKnQzD30kR+4jD+oOjMto2TVAcMOXpac6StTwLsuqqPm4TmAp0lV1OZcsM+
         y0qiEsACwYnPQJOu5fL0UYNc7kKB3JLoxQnNfyT+V9ALakaarrGKBJ43MGg4ywrCUT7T
         4NVfEqu9i4XiaN5zdaGNOVuENwtQrPAZ8NsIAWY581tyz4XBMl1aud4ykxAaKdBcRzFg
         pkLMwpSgQDPVhUV1xgl6YfMOcXrs5z8EdpZ/3ZL15knwX9Aqh95cgyAt7IF1GGXNbX3a
         TlzrQwdy768ImGRtEkF5ghJBGBE1Cvq3rOpFy7PhpwO8Yy0QUiylEVb/uSyqe2RcCZg7
         +o5g==
X-Gm-Message-State: AOJu0YzP2XH/VQsdsyzhdPSH1jOE//jvvtIqte7OZpgJzXgwzQt9a5U/
        lHTo3WlRNGEuwcdRxfXB0oh0QpofjJU/Ng/WXNah8Q==
X-Google-Smtp-Source: AGHT+IF0UttUrgGr5cdMWJGSb7e7DEnicomjDDMfd87WaVglVNgQoKPiFU153JXWWx2Q6CbzNqmh/KBwm2YLz1s0JW8=
X-Received: by 2002:a05:6870:65a8:b0:1fa:e8f0:f732 with SMTP id
 fp40-20020a05687065a800b001fae8f0f732mr8074320oab.52.1701778049979; Tue, 05
 Dec 2023 04:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20231129164439.1130903-1-arnaud.pouliquen@foss.st.com>
 <CAFA6WYP=_BPt_x1FxeVdAdB_mMjdz8QzvkfFXx-5msy8PZG6nA@mail.gmail.com>
 <60b67bd5-36c3-4318-9a2b-bcf172681d45@foss.st.com> <CAFA6WYN9eJ1vGTKfGXy7M709=aGkg1oF3odK7iGRUBokbKtqzw@mail.gmail.com>
 <40902a86-3b88-45bc-bb6f-2de0eb48dc9d@foss.st.com> <CAFA6WYPGkpVN-XP7eAzLXMReRi7FBp3boKzhMfasasuE=XWBow@mail.gmail.com>
 <438a8b44-ea5f-4e13-bd7e-e1c2e2a481c4@kernel.dk> <cf00a996-c262-4457-93de-ca7960ad6df6@kernel.dk>
 <a1f4e290-34ad-4606-9a95-350d00727483@foss.st.com>
In-Reply-To: <a1f4e290-34ad-4606-9a95-350d00727483@foss.st.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 5 Dec 2023 17:37:18 +0530
Message-ID: <CAFA6WYMi52WTWho5y=967fm8utqtdq9fuCjVJFA9G0MaHtNYgg@mail.gmail.com>
Subject: Re: [PATCH v4] tee: Use iov_iter to better support shared buffer registration
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud,

On Mon, 4 Dec 2023 at 22:32, Arnaud POULIQUEN
<arnaud.pouliquen@foss.st.com> wrote:
>
> Hi,
>
> On 12/4/23 17:40, Jens Axboe wrote:
> > On 12/4/23 9:36 AM, Jens Axboe wrote:
> >> On 12/4/23 5:42 AM, Sumit Garg wrote:
> >>> IMO, access_ok() should be the first thing that import_ubuf() or
> >>> import_single_range() should do, something as follows:
> >>>
> >>> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> >>> index 8ff6824a1005..4aee0371824c 100644
> >>> --- a/lib/iov_iter.c
> >>> +++ b/lib/iov_iter.c
> >>> @@ -1384,10 +1384,10 @@ EXPORT_SYMBOL(import_single_range);
> >>>
> >>>  int import_ubuf(int rw, void __user *buf, size_t len, struct iov_iter *i)
> >>>  {
> >>> -       if (len > MAX_RW_COUNT)
> >>> -               len = MAX_RW_COUNT;
> >>>         if (unlikely(!access_ok(buf, len)))
> >>>                 return -EFAULT;
> >>> +       if (len > MAX_RW_COUNT)
> >>> +               len = MAX_RW_COUNT;
> >>>
> >>>         iov_iter_ubuf(i, rw, buf, len);
> >>>         return 0;
> >>>
> >>> Jens A., Al Viro,
> >>>
> >>> Was there any particular reason which I am unaware of to perform
> >>> access_ok() check on modified input length?
> >>
> >> This change makes sense to me, and seems consistent with what is done
> >> elsewhere too.
> >
> > For some reason I missed import_single_range(), which does it the same
> > way as import_ubuf() currently does - cap the range before the
> > access_ok() check. The vec variants sum as they go, but access_ok()
> > before the range.
> >
> > I think part of the issue here is that the single range imports return 0
> > for success and -ERROR otherwise. This means that the caller does not
> > know if the full range was imported or not. OTOH, we always cap any data
> > transfer at MAX_RW_COUNT, so may make more sense to fix up the caller
> > here.
> >
>
> Should we limit to MAX_RW_COUNT or return an error?
> Seems to me that limiting could generate side effect later that could be not
> simple to debug.
>
>
> >>>  int import_ubuf(int rw, void __user *buf, size_t len, struct iov_iter *i)
> >>>  {
> >>> -       if (len > MAX_RW_COUNT)
> >>> +               return -EFAULT;
> >>>         if (unlikely(!access_ok(buf, len)))
> >>>                 return -EFAULT;
> >>>
> >>>         iov_iter_ubuf(i, rw, buf, len);
> >>>         return 0;
>
> or perhaps just remove the test as __access_ok() already tests that the
> size < TASK_SIZE
>
> https://elixir.bootlin.com/linux/v6.7-rc4/source/include/asm-generic/access_ok.h#L31
>

It looks like there are predefined constraints for using import_ubuf()
which doesn't properly match our needs. So let's directly use:
iov_iter_ubuf() instead.

-Sumit

>
> Thanks,
> Arnaud
>
