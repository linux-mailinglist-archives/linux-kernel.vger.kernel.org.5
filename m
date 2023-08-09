Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FBB776A66
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjHIUkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbjHIUj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:39:56 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F382129
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:39:40 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9d3dacb33so3604211fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 13:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691613578; x=1692218378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TSYHDp/bGdSV83cYMojLR3N70tOMtA0XRESFOp2abM=;
        b=U1tdU+M/xgMilj8lcoHb5Sun+oVgQywgVRPPUdjM1j3Kk4ftceez2F8OryRkqKuAzR
         Zcq3rwP0m4jxoY/CtDmBK002Z/crYWRYtlEvNHl+MjlHFQUt2Hasmy6xO76Pj5Bw6Nuj
         RuH7/ax7BE8Fx8M6TPcGlvbGK5p3jAJR45sl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691613578; x=1692218378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TSYHDp/bGdSV83cYMojLR3N70tOMtA0XRESFOp2abM=;
        b=Q2a37wkDfFNm66TujRJv5P391gQsaZoIWS4zThCtOhCszSbBiimLjlJy37utc68WJu
         iBAeYLp2LJgwFGiQ2Q5ELpxvAR+Jiiyd1LR8NfnsycbbFTHj7v937ducMc6K6mRpuNfn
         xXYHjDfGTlGrZ20Jqsq6uwhyxKVp31Ac8erkccIrVisbqR0KCsO5tNWdNQFi/asFiiAu
         xoeOrpPTZVq6mTPBfmcPb/bKfXHQxiN4Ibn4juqvTHEGqz8lUkWsOKZN/MQPz3cjOby9
         pEzVUGQxEkElNqzEXq9sTv/9OQEyN8CgqORDSp/lnjazgN2TNgQtho2fLibtqd2tm3E3
         YtAw==
X-Gm-Message-State: AOJu0YwWgvP1xCUV3pCnKeRximTUmczvQMneDT2vg81cV/9h8YwL/4ud
        Tz8DYSfpEzc1blpkSKp1wMgeC4K0eJPtY6W7LVS0RQbn9CSdkrf1u3g=
X-Google-Smtp-Source: AGHT+IFhr2UBSAua/2aL1dFLqsuIdLLwE7M0o8NS9ZIohgmDqTjZWGSzXSxQxhLLo8IwCL8P6Zt0X74T9yetTzgYa5c=
X-Received: by 2002:a2e:9084:0:b0:2b9:e230:25d0 with SMTP id
 l4-20020a2e9084000000b002b9e23025d0mr242971ljg.14.1691613578096; Wed, 09 Aug
 2023 13:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230809103633.485906560@linuxfoundation.org> <20230809135326.GE3031656@google.com>
 <f47340c6-3c41-1f91-d0f9-fe0b59a23aac@roeck-us.net> <CAEXW_YQ4GqPwvUF8=8CWmdj=cD56v_eEVK-EirsObQXyBDFVpg@mail.gmail.com>
 <35e4b770-2ead-4a19-ad01-fa75996adef4@roeck-us.net> <20230809201413.GA3374446@google.com>
 <6b05a082-41a7-f0cf-c0a4-1cced8d5a230@roeck-us.net>
In-Reply-To: <6b05a082-41a7-f0cf-c0a4-1cced8d5a230@roeck-us.net>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 9 Aug 2023 16:39:27 -0400
Message-ID: <CAEXW_YT-7epvu4uUS19aDAcM0X63j9_L2aa-XGGFGSLceLu8bA@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/92] 5.15.126-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        paulmck@kernel.org
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

On Wed, Aug 9, 2023 at 4:38=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> On 8/9/23 13:14, Joel Fernandes wrote:
> > On Wed, Aug 09, 2023 at 12:25:48PM -0700, Guenter Roeck wrote:
> >> On Wed, Aug 09, 2023 at 02:35:59PM -0400, Joel Fernandes wrote:
> >>> On Wed, Aug 9, 2023 at 12:18=E2=80=AFPM Guenter Roeck <linux@roeck-us=
.net> wrote:
> >>>>
> >>>> On 8/9/23 06:53, Joel Fernandes wrote:
> >>>>> On Wed, Aug 09, 2023 at 12:40:36PM +0200, Greg Kroah-Hartman wrote:
> >>>>>> This is the start of the stable review cycle for the 5.15.126 rele=
ase.
> >>>>>> There are 92 patches in this series, all will be posted as a respo=
nse
> >>>>>> to this one.  If anyone has any issues with these being applied, p=
lease
> >>>>>> let me know.
> >>>>>>
> >>>>>> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> >>>>>> Anything received after that time might be too late.
> >>>>>>
> >>>>>> The whole patch series can be found in one patch at:
> >>>>>>       https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/p=
atch-5.15.126-rc1.gz
> >>>>>> or in the git tree and branch at:
> >>>>>>       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-s=
table-rc.git linux-5.15.y
> >>>>>> and the diffstat can be found below.
> >>>>>
> >>>>> Not necesscarily new with 5.15 stable but 3 of the 19 rcutorture sc=
enarios
> >>>>> hang with this -rc: TREE04, TREE07, TASKS03.
> >>>>>
> >>>>> 5.15 has a known stop machine issue where it hangs after 1.5 hours =
with cpu
> >>>>> hotplug rcutorture testing. Me and tglx are continuing to debug thi=
s. The
> >>>>> issue does not show up on anything but 5.15 stable kernels and neit=
her on
> >>>>> mainline.
> >>>>>
> >>>>
> >>>> Do you by any have a crash pattern that we could possibly use to fin=
d the crash
> >>>> in ChromeOS crash logs ? No idea if that would help, but it could pr=
ovide some
> >>>> additional data points.
> >>>
> >>> The pattern shows as a hard hang, the system is unresponsive and all =
CPUs
> >>> are stuck in stop_machine. Sometimes it recovers on its own from the
> >>> hang and then RCU immediately gives stall warnings. It takes 1.5 hour
> >>> to reproduce and sometimes never happens for several hours.
> >>>
> >>> It appears related to CPU hotplug since gdb showed me most of the CPU=
s
> >>> are spinning in multi_cpu_stop() / stop machine after the hang.
> >>>
> >>
> >> Hmm, we do see lots of soft lockups with multi_cpu_stop() in the backt=
race,
> >> but not with v5.15.y but with v5.4.y. The actual hang is in stop_machi=
ne_yield().
> >
> > Interesting. It looks similar as far as the stack dump in gdb goes, her=
e are
> > the stacks I dumped with the hang I referred to:
> > https://paste.debian.net/1288308/
> >
>
> That link gives me "Entry not found".

Yeah that was weird. Here it is again: https://pastebin.com/raw/L3nv1kH2
