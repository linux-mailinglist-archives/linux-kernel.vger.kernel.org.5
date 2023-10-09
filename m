Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46847BED49
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378898AbjJIVXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378835AbjJIVXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:23:38 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8F8D7B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:23:03 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so757170276.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 14:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696886582; x=1697491382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uL0ewLkuzHBQT2y41NjEQzD7MVpvDNSNx6iew+H1Nw8=;
        b=UCsLPt0rat7mXH3opvKqyGYhux40b7VkVCgn6O/bRLUFRWSloAcU4FfJkmOe/dc6ZS
         YhwnuGWOoq/a42TPR34vBZPOrWEtlaY1g0LDcME3l77yzsoNqn9c23cyNnstCeNu8JTm
         9GKF8L+vdTuV4NXdI6CROUNCoc5z7FjtP///Yq+y+gpQ/0BtzE8ErSKYpd3EUAQT/9ot
         6R2NwsbWqng+jAO5CJDbtprVdLBXen2E329O8NeOcR3ocqBL6XwsH7C5EKvgEPpObvd6
         fommqLs8YKZG2+wfFmk1sFgk/bwGWWAHVJ+ulcCbO9HleyqbxAWCVydBKoVb0sZCX5Pb
         Kimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696886582; x=1697491382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uL0ewLkuzHBQT2y41NjEQzD7MVpvDNSNx6iew+H1Nw8=;
        b=b4dr6MkCG9svxfyOvwmj5P/eqrRlRV+YEm6IntUeqkufTpx/5ytpFhv/fhQMxSL3JG
         nLFlBds+ruQ7cTBors/fxbGV4EQzwBAdDSIdtUiOvImRGNqOMDvAAEyhgPxWyqlm7edq
         y2lJWRM2cOdBUPsu2Pv1HjISKjVHLY+PGUo/3XVTHMYS0N2FQHkuzelaTjin8t2TYsJi
         8R6IUpXvpTBAR0TtHo6DM4ZyMSBViM4y+wuBaYITSBxLyT59QpFQ2Fc4mRs3t8bKN/cN
         keyCPjYSCeC4gzL3BC/40YOmOpDPLMv+Zxrw849CPSyGnpfVWewqs0jnt6Huuh8WzF/l
         lBKA==
X-Gm-Message-State: AOJu0Yxhvjonm2kP2STDmtUR3FnjiofT3XlEbiYv4ukUD5XNMNuqHGMv
        y/t1x5yXE0oYtNSGtZu/ajbJFRHRmiCaIcis6b86bQ==
X-Google-Smtp-Source: AGHT+IFWc0p6u51fAKRyFsD5XnGHAFf8gAy6kDEPQDhsWl7wnajt3ldzXCuOFULDjik560XMwPQ86SjjvHbpti0emnk=
X-Received: by 2002:a25:27c7:0:b0:d81:ce57:571a with SMTP id
 n190-20020a2527c7000000b00d81ce57571amr14109849ybn.54.1696886582707; Mon, 09
 Oct 2023 14:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230213045351.3945824-1-debug@rivosinc.com> <20230213045351.3945824-16-debug@rivosinc.com>
 <7c4448d1-4622-436f-8779-f52c4f011783@sirena.org.uk>
In-Reply-To: <7c4448d1-4622-436f-8779-f52c4f011783@sirena.org.uk>
From:   Deepak Gupta <debug@rivosinc.com>
Date:   Mon, 9 Oct 2023 14:22:51 -0700
Message-ID: <CAKC1njQuw_nzbQ07BGAQOi3C=vr35JhAc6-TB5nzY3zG3Nff3Q@mail.gmail.com>
Subject: Re: [PATCH v1 RFC Zisslpcfi 15/20] sslp prctl: arch-agnostic prctl
 for shadow stack and landing pad instr
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am really sorry to have missed this and being late.
I saw your GCS patches. Thanks for picking this up.

On Wed, Jun 7, 2023 at 1:22=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Sun, Feb 12, 2023 at 08:53:44PM -0800, Deepak Gupta wrote:
>
> > +int __weak arch_get_shadow_stack_status(struct task_struct *t, unsigne=
d long __user *status)
> > +{
> > +     return -EINVAL;
> > +}
>
> Having looked at this further is there any great reason why the status
> is passed as a pointer?  It seems needless effort.

I was trying to be cleaner here to not overload returned status with a poin=
ter.
You could say that any negative value is an error. I don't have any
favorites here.

-Deepak
