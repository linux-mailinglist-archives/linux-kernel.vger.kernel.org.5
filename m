Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8650F7C79ED
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 00:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443042AbjJLWot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 18:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443035AbjJLWos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 18:44:48 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039D79D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:44:47 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53d9b94731aso2802824a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697150685; x=1697755485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUJJKm9lDcsKSbt0Gh9bMyGUZpKtFWFjgv7jiH7IfeI=;
        b=bB8ShZb8VhRolUs4zsVgo6F6wXq5R6qVHlJ9gMlWhvfV32525T3J77wMdYQCEgpdSf
         7FDuWb2tfNVeiXMe1IODWcfWmLK3myyIJbJMUxDQqQAgzeG+S85hjCM0yyM07CTxJvef
         FAVl57+Xv/XpjhUQ3UJ09RCh6bzaGFAGdvYGnVK+OcPrAR6Pz3sGFHvUXZ+YgdQBapsp
         X5Vg7UDfLOjtAD56VRKIjfIglTS4eMjH67dS6MuW2D2jpq0Dl2RVEPgwpjOiMzLpWRls
         xEF3RGyOva0lmYbOP2to5YubR1tUf2igu3f9QkhGZ7LmxzOYvm0nZg4w2O+PlTiAuki7
         TnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697150685; x=1697755485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUJJKm9lDcsKSbt0Gh9bMyGUZpKtFWFjgv7jiH7IfeI=;
        b=f1je83mThccoNft2GieiYi6bttxQkbAQFU5YAYhdiiX+paYD8jnDyUu0QDJ48rdsqb
         Evk8kJJswMRrRGQuTKsVuu13mYHc2PdNqcg4Zpj3rQySOl3wjbTIbYhf/hPuB5MINHRR
         GweWz/Y+PizV7JRh0GhtqGnPS7+jQqTlw/+o24t8W4dUCBl+4GnZqpmpxgL5MZ65zUng
         NaDnu6GBy1tnwyUCidZXDW0SVYtUUPZzTqkLwnw9NypTRdDmCnsh2HslXClnXjrFMzW7
         w9EGPjwSy/bJyNdLSdGenhz+Rtz+AdhBsTuy5rBSZtEUowQ0Aod/gVGY7uQCykCb7IRP
         ZA1w==
X-Gm-Message-State: AOJu0YyvKYksL9pc5l7w+INfmRIeF14ZuBHqtVi2tbYiLa9gBwfZyYd+
        QxYXv3TSlBa/qz8JTciXSVi5rNeuIueAIMUUVps=
X-Google-Smtp-Source: AGHT+IFyYAt1/XqbFKonx4X0m+I/iV1wGqc3tYFtJONQ1BAT6fF9nLfX+r3BSk6hrxlKs3nNElJ86qvizT+DQ06Y4ys=
X-Received: by 2002:a05:6402:350f:b0:53e:1f6:fa24 with SMTP id
 b15-20020a056402350f00b0053e01f6fa24mr3460608edd.20.1697150683614; Thu, 12
 Oct 2023 15:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231012201743.292149-1-ubizjak@gmail.com> <3af8dcec-66ec-4bd4-b7bf-4bc6f5f3c70f@intel.com>
 <CAFULd4byzHyoz4xM1gL_T1wFkNE-ab8K4upXfPirxM9PdX5JWg@mail.gmail.com>
 <5722e74b-6fc6-4d6e-be25-069ea6385990@zytor.com> <CAFULd4afhj-kJwneh7wz0sExWqOmPicG4fcfF++_fUMHpoNbXA@mail.gmail.com>
 <5694b2bd-de40-45c0-8b38-ac01bc11798a@zytor.com>
In-Reply-To: <5694b2bd-de40-45c0-8b38-ac01bc11798a@zytor.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Fri, 13 Oct 2023 00:44:32 +0200
Message-ID: <CAFULd4YUD_7x5=j1MBB9mcS6rRm9zdmZ33SyjaTArScLVMv2KA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce %rip-relative addressing to PER_CPU_VAR macro
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
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

On Thu, Oct 12, 2023 at 11:22=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wro=
te:
>
> On 10/12/23 14:17, Uros Bizjak wrote:
> >>
> >> Are you PIC-adjusting the percpu variables as well?
> >
> > After this patch (and after fixing percpu_stable_op to use "a" operand
> > modifier on GCC), the only *one* remaining absolute reference to
> > percpu variable remain in xen-head.S, where:
> >
> >      movq    $INIT_PER_CPU_VAR(fixed_percpu_data),%rax
> >
> > should be changed to use leaq.
> >
> > All others should then be (%rip)-relative.
> >
>
> I mean, the symbols themselves are relative, not absolute?

The reference to the symbol is relative to the segment register, but
absolute to the location of the instruction. If the executable changes
location, then instruction moves around  and reference is not valid
anymore. (%rip)-relative reference compensate for changed location of
the instruction.

Uros.
