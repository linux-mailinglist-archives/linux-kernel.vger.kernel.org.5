Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522E27C9D63
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 04:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjJPCZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 22:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJPCZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 22:25:55 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABA4C1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 19:25:53 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c17de836fbso47826741fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 19:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1697423152; x=1698027952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0LfinplnzcaTdsRdXhDFzIQMiKq8VSmVBDANoGvJi8=;
        b=briofXFeEXvRNAHg0LLhr+F8stXPVW/11SOKkKnHXBHq/8aF6Dl0yRfBD4u0EFtfwr
         01/9FGAyO1Y3Iyoj/3nV6EiKTrLaxjOlWeDHh/WZ3reFBYRdorsw0AgNOcWa6L08E3PS
         1Bh9EdPZMejz4tUmzRktRytijVrt1z9UU2XFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697423152; x=1698027952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0LfinplnzcaTdsRdXhDFzIQMiKq8VSmVBDANoGvJi8=;
        b=c7eqMIjKN+ybDHAE5HssqsS5NQ2EaTZMcbXL6gCSENzwYqs3ctTmnehY+qXwde9P3D
         J5tceh6e0iLWxJHT98gWfBmswlqDg5cMbxG/zU6yaI9gXAsbANp76Xq4agMr/nvdLmOB
         LoEG32uh8HJOl9yro6RQu8gkiR3mBNnjmvlPMVPmAkxtIsb4haZ075vqMlHjqexGbcMW
         VaNC19z4PM85aePVZZNKCM+1cYgnPsje1m+2OuHnQ+yJD7GGZDIzNmqIgQ0uXUm44LBJ
         Dw65l6ijTkXvBaDvPLbXbxqaBycR8+2y7u14paIM59+YjWKncmSfgN2hfwQh3fFjZ6C5
         brFg==
X-Gm-Message-State: AOJu0YzP8CASOUx9gmpT++a417Lq7O4H+x53H92efwdUUo+n7MrZ2/5O
        kHTL6uQWvDKdS5EeYmRHljQflIAkvEcw7zNba28GlA==
X-Google-Smtp-Source: AGHT+IH+QrM3pSw2s87D50J4FBEKwsOAzgXABrnT9ujQNdoYkm+yIVIj1/2F4MvqnrHtyPQ3DN/A1XFuRQGCEyjzLvw=
X-Received: by 2002:a2e:3219:0:b0:2c5:1ad3:7798 with SMTP id
 y25-20020a2e3219000000b002c51ad37798mr1822219ljy.52.1697423151283; Sun, 15
 Oct 2023 19:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231004175203.943277832@linuxfoundation.org> <CAEXW_YT6bH70M1TF2TttB-_kP=RUv_1nsy_sHYi6_0oCrX3mVQ@mail.gmail.com>
 <2023101110-resurface-nuclear-bfee@gregkh>
In-Reply-To: <2023101110-resurface-nuclear-bfee@gregkh>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 15 Oct 2023 22:25:40 -0400
Message-ID: <CAEXW_YRf0e6V6PcGJ-LWiS=ERgy4yxHoSG4d+DHLjXZ8Ah7kJA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/183] 5.15.134-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 1:44=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Oct 11, 2023 at 11:58:49AM -0400, Joel Fernandes wrote:
> > Hello Greg,
> >
> > On Sat, Oct 7, 2023 at 9:00=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 5.15.134 release=
.
> > > There are 183 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/pa=
tch-5.15.134-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git linux-5.15.y
> > > and the diffstat can be found below.
> > [...]
> > > Liam R. Howlett <Liam.Howlett@oracle.com>
> > >     kernel/sched: Modify initial boot task idle setup
> > >
> >
> > Let us drop this patch because it caused new tasks-RCU warnings (both
> > normal and rude tasks RCU) in my stable test rig. We are discussing
> > the "right fix" and at that time a backport can be done.
> >
> > Hope Liam is also Ok with that. I am happy to do that future backport i=
f needed.
>
> This is already in a released kernel, a bunch of them:
>         5.15.134 6.1.56 6.5.6 6.6-rc3
> should it be reverted from all of the stable releases, or just for
> 5.15.y?

Just 5.15.y. The others don't have an issue with the patch per my tests.

Thanks,

 - Joel
