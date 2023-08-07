Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90287728F8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjHGPVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjHGPVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:21:17 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E88B10FC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:21:16 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-56c4c4e822eso3053710eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 08:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691421675; x=1692026475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFlLq06XoS8bt4Ay89yaWZpaCr87zT/IgWzMgvEmuw4=;
        b=MmcL5nQHZACpNnXN4dZPbh+sgq05PF/k6Rxa56Ek393PHIq9w9mAvW0zAHpdVzF+NN
         cosithLWmIPrp+t7M6GrF4MkCb8sSO/Kp8whqWaLaRvaxnRpF3Dq6KmZYPOyeUlBhzNb
         6DkytODVspyPd7WaKIsRSqbsf2chBCxgy7VAUAma6WQ4AImUDs2n7R56ZWhcArMjg51m
         825Dy7oq3NV4YfOOVFoxXxo+hY/8ikLv+Q34b3VhIBw2ll2XKHN3V0Bwys5H7EPih5ur
         PJcONDyx4Bg0nW3UA0r1DkVQxMP1S+bhL/+dPNKhGVyi9P2rhQLQELCI73uaJMjN8lFl
         RTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691421675; x=1692026475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFlLq06XoS8bt4Ay89yaWZpaCr87zT/IgWzMgvEmuw4=;
        b=KXqVsHV03THK112FpJpI+jnJ5wlBdvIwf9ax0bzVAtC8l4AztbmARhA5XOzJJFCCco
         4TYm8rlWjva/uv+/c6qPP27ZfB0iyo77cAz5yX0S9zsa5SNa3waZhIyxBTlm+RImyouy
         3Ee+lnfKs8cUHx0lf89h9by1egEl12TOjeq8FHKtnHY3aikmAqS0wyHy658PhEqNuU5A
         0PRTODtYVIer2PhpRy7ozrz/XmTpvXwh+SmGy6cH3ReCqxW8c5+rQcXPY2yzS6R+39nE
         uHgGLLICU8XEz5JVF3fZ9BDzfNxKKBcVvdKybxh7of9aariSMYUaN3L0pO9etLphjyXS
         TBFw==
X-Gm-Message-State: AOJu0YxeFbjGJG8IvCUNtvLJUVVBreb1QbyTmpIatFJ5eokDvvvMRFEd
        55UEN3j8JU1JDYqfANNciQhaMX3eLEai9KoKjrM=
X-Google-Smtp-Source: AGHT+IFoGuDmEsm5027KwVdF4+3XRGvnrye77PQ8OYzwNgwha7CyLWpYOeAUzA7ev6pb8ZxzTbQCTA+lAI5cZZM8YFY=
X-Received: by 2002:a4a:3406:0:b0:56c:a273:7d99 with SMTP id
 b6-20020a4a3406000000b0056ca2737d99mr8322281ooa.5.1691421675601; Mon, 07 Aug
 2023 08:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230807130108.853357011@linutronix.de> <20230807135026.583926152@linutronix.de>
In-Reply-To: <20230807135026.583926152@linutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Aug 2023 18:20:39 +0300
Message-ID: <CAHp75Vfn6b+Cc8Ewwi9UmNoOU6EUJWk6WeN073AGA10=W_R5Ow@mail.gmail.com>
Subject: Re: [patch 03/53] x86/platform/ce4100: Dont override x86_init.mpparse.setup_ioapic_ids
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
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

On Mon, Aug 7, 2023 at 4:52=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> There is no point to do that. The ATOMs have an XAPIC for which this
> function is a pointless exercise.

CE4x00 are DT based platforms. I never looked at them deeply, so I
don't know how this affects DT parsing on x86.

I have one system at hand, but it has a signed BIOS and I have had no
time to actually break through it and be able to boot a newer kernel
to test...

--=20
With Best Regards,
Andy Shevchenko
