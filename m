Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A7377D5D0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbjHOWO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238679AbjHOWOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:14:38 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A86198C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:14:37 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-58c4f61ca12so19520677b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692137676; x=1692742476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWhssGhn2cSXZMJR+zaKUad1XnnAKwzBQkgfn7VvUN8=;
        b=I9ZzB+A6XT7r8pSBQ5GQ1r3twGl3VsuYoUirwdMDXOUSsrctQunTkEck5tI+v2XGNh
         gvk1PrIdNaPUO86K1bYaoyJemS9lHxvwAf4a8Nls7FEi0y0ghlsh7YDM/vplJkM580wJ
         bUIIhnc+5w8vuA8p8S3oeI2od3HuOiSjCQ3X1V6MgPT/Y5LtYV5e9oNVS3+4FetGVwIA
         b86SpcoaQC2csRS5rTlqsAGzVzWLBM+sJVZk0dBTVPIdacBb9Da1l8aAEDmZvUbcf08t
         KLRrrLh5Nbr0AXOO5WHqz//brz91U/SFPHjoebqTbIjRJhvdt8DwQJYi8cLqPHv5Uw61
         rrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692137676; x=1692742476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWhssGhn2cSXZMJR+zaKUad1XnnAKwzBQkgfn7VvUN8=;
        b=iBGPPyIOJOP3yOMwABKWks+ja+qfSRNiAZ36n0rbyY+cXhk4OzLVWjvmprymi0Ut2T
         gcSJYITljgtOgqiIgZC6VMcpiVU+rYmKsNzYIhw9CuSo1S/cDHLZCYx+E1GcnAjho72C
         bSnahfGP4InxCRwqiTF8EENWf02Y8WD3ZriSks1HytwQaOeNdOJPgZxdsNUrV1FmfU/k
         Ws4elX4+GRXsvdClGfdg02FlDYW8iyfYsiLde9nJTzI4zBh0slSHWv3fjhEhOR8osu+z
         NNOv18XQMu2kua1V8BfN0M00TuH6vv7/jKOivJZ7XcMXlUGrqaGyym+PukHxBICSsVo1
         SLsg==
X-Gm-Message-State: AOJu0YxEwnnnVyvHgFwgo70sbxsSBBZloMKvMtuI0Dm7Ude9TF1UjMyS
        e9+WOE9pX8VQbiWOlLqWOYOENA4/VKRI2s760y28
X-Google-Smtp-Source: AGHT+IFOVQHf2CmsZWQr99eCE4yVLvmwB+wEyktAtLNY0vVerWb17bjc8CmS5aAemQ3HQ+s5ggNphgS/arRNUMeVsn0=
X-Received: by 2002:a81:89c6:0:b0:57a:3dd8:1038 with SMTP id
 z189-20020a8189c6000000b0057a3dd81038mr18049772ywf.12.1692137676685; Tue, 15
 Aug 2023 15:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230815204644.52358-1-atulpant.linux@gmail.com> <20b96495d277cb2007541a119bb09def.paul@paul-moore.com>
In-Reply-To: <20b96495d277cb2007541a119bb09def.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Aug 2023 18:14:25 -0400
Message-ID: <CAHC9VhSQ9FsxF2rg57B-V5f23OKAA-uCHb1iOkCiTuNeTXHMbg@mail.gmail.com>
Subject: Re: [PATCH v1] kernel: auditsc: Removes use of assignment in if
 condition and moves open brace following function definitions to the next line.
To:     Atul Kumar Pant <atulpant.linux@gmail.com>, eparis@redhat.com
Cc:     audit@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org
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

On Tue, Aug 15, 2023 at 6:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Aug 15, 2023 Atul Kumar Pant <atulpant.linux@gmail.com> wrote:
> >
> > The patch fixes following checkpatch.pl issue:
> > ERROR: open brace '{' following function definitions go on the next lin=
e
> > ERROR: do not use assignment in if condition
> >
> > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > ---
> >  kernel/auditsc.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
>
> Merged into audit/next, thanks.

I also wanted to say that I changed the subject line to "audit:
cleanup function braces and assignment-in-if-condition", what you had
written was far too long for a subject line.  A subject line should be
brief and does not need to be a full sentence, in fact it probably
should *not* be a full sentence.

--=20
paul-moore.com
