Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45677CB635
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjJPWGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJPWGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:06:49 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B807AC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:06:47 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77428510fe7so424536485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697494007; x=1698098807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxgcJ9Prpia4Vvx+9SxOpdXD9itd8jDcIDDzlnFELa4=;
        b=nhWDHkeKpVXODgitSRfBrfDzteWEqZrMlz4Kp+2Zsnb72C4tmdBgWJN4dFBkX9t8bi
         QY5qT4u81Iycc7s9JrUFrzSxC8Yx1wxRkVCZlAKiPf2w93uAzyOsepaDL9IMvRm7Z89O
         AjprPDG54spUP3Q5IxCB/V5Bco5AgNzbqlplNfCW9NJLdxx3+9uMe8aBFpYxfUEbpLmC
         lvzkPOiH1iHHHP93dpbzXLyD8ekSSsFgjxZylLNeCbUBVjq1KQWvwyVC1Zbhajo0mwwt
         V8Ot1tCSc+4PPVDE+46YNWgxMWslg2xZIUe61ynz8ez7G+Nxwnj6MtOQYLtRlwsCboyJ
         t3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697494007; x=1698098807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxgcJ9Prpia4Vvx+9SxOpdXD9itd8jDcIDDzlnFELa4=;
        b=Vhfpe+KBbbD/MR/twyMs5xnasM4cWlRa+1X4CG+kIWNhwMCfUmXeikKbg3H698OvgW
         8cUOa8YFa59dc73mfbweGk4q5o4CdbSRE05EYHXv0g0r2WWXbUhHsECvJn76tiBodMBM
         0DNbJSBy8aO364bzwZpauTHOEFCdcxnakSpM5lDURd8XjuY0H7boFEmuQt0nz0a3k0wI
         O6D5/8Wz1SZQdu6m0oAKG4loytwQ/QWJTBYwUWtYRbxcetuA+ot7o5Mq79TjqihV9CUs
         PNpj4Z9ig3Ex7VyKixdD+JaGtfTwkEEY2U5GADmw+zbe/2wSEeN6HNwD2t20EhsgSXO3
         xsXA==
X-Gm-Message-State: AOJu0YwSOx+ujV00oyj1Yxy4d6A2+ft02DFCr/YI5RhUyoiTHEi9/Gvn
        +PsKUDuxLcauguu38bXa5fFiZ3ZJewYLkvPt9QlgBdDjjyfS+72S4Hc=
X-Google-Smtp-Source: AGHT+IGDsRfz/iknxdaN0B6u9akDF6l9rbCkNV08iJ39A/Et8FmRWoB6TQmMG0bXWfFRSPwbLsR04aQI+1f8lSvqKpM=
X-Received: by 2002:a05:620a:2914:b0:773:c43e:5e73 with SMTP id
 m20-20020a05620a291400b00773c43e5e73mr120396qkp.25.1697494006641; Mon, 16 Oct
 2023 15:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJgzZorfiG26TCfwNBVYJkkkVBAQowJhRUtX4EzWSxwZbfNoyw@mail.gmail.com>
 <fb983fa3-bf4d-42aa-b5c3-4927504c32d9@acm.org>
In-Reply-To: <fb983fa3-bf4d-42aa-b5c3-4927504c32d9@acm.org>
From:   enh <enh@google.com>
Date:   Mon, 16 Oct 2023 15:06:30 -0700
Message-ID: <CAJgzZooT78F996rW3ax2nVf4S=HWfhqkHjYCkXOEHdK5tf3Y3g@mail.gmail.com>
Subject: Re: [PATCH] scsi_status_is_good() uses __KERNEL__ constants.
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 1:48=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 10/16/23 13:42, enh wrote:
> > Without this missing #ifdef, userspace code trying to use this header
> > directly won't compile. glibc manually removes it, bionic removes it
> > using a script. If we add this, the preprocessor can remove it instead.
>
> Is that the right solution? Shouldn't these software projects be
> modified such that <scsi/scsi.h> is *not* included?

i'm not sure that's practical? all linux libcs i know of include these
headers. (though bionic only has them because glibc did. i'm assuming
the same is true for musl?)

i think there's obviously a question of "why aren't these uapi
headers, if stuff is using them?". just looking at Android, i see
sg3_utils, mtools, compiler-rt (for ioctls), and toybox (for the eject
command).

or perhaps --- even if most of the scsi headers should be non-uapi, is
there a subset of stuff that should be in uapi?

but "libc can use this header directly like it does uapi headers,
rather than having to need a human manually fix the header" seemed
like a step forward from the status quo where everyone's shipping
their own hacked-up versions of these headers?

> Thanks,
>
> Bart.
>
