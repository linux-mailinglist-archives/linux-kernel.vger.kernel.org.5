Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB2B805432
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345218AbjLEMcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjLEMcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:32:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC809C9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ogO+B5CVWB2JdnKIKTxq0tYZWbAi4tBGoLWra+512TA=; b=AmP7tK6+5ERGFcOfx9SJkJ4B4c
        UeUR+PFZXOKeuXNn9HUAMaiulecKMNEz+mV5Od96kQFRlMxryN4fkFs5A3+wZOFM3IFD3xUen4QLI
        nDm5IwKhOyM1Kr0Y3D1p381zeR3CmW28iyAzS4LYYjfHx77E7R7qJFO2vwA5vnapPQdM7TXlEoWAc
        KI9IHtlT3SoyAHHdHIjSaJ6fkrJugC/aPZOtEPjpqxgO416MAqSFY9GpCpvmVhwjIO7Bo0ukSkS6B
        xijLdKVTDRGT3iYCD2WLvdQ9Kyu5p1dIojl5jHoxu1a06DNUUoA3HTS/tS8ve5jqvHtgeaQ5kzzv7
        L27SGjNw==;
Received: from [46.18.216.58] (helo=[127.0.0.1])
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rAUbM-001rpD-6Y; Tue, 05 Dec 2023 12:32:36 +0000
Date:   Tue, 05 Dec 2023 12:32:36 +0000
From:   David Woodhouse <dwmw2@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     pdurrant@amazon.co.uk, bp@alien8.de, dave.hansen@intel.com,
        dave.hansen@linux.intel.com, hdegoede@redhat.com, hpa@zytor.com,
        jalliste@amazon.co.uk, juew@amazon.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rafael.j.wysocki@intel.com,
        tglx@linutronix.de, usama.arif@bytedance.com, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86=3A_intel=5Fepb=3A_Add_earlyp?= =?US-ASCII?Q?aram_option_to_keep_bias_at_performance?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAJZ5v0i-+9VwccRLGDcQdhz_UyBbw8k0LR9GbdvaRxs8PxP=0g@mail.gmail.com>
References: <53bce76c5c60463eba1372df426a64b9@amazon.co.uk> <1D71D218-5EB6-47DE-A01B-3A66F9F4C74E@infradead.org> <CAJZ5v0iVvMLK_VcPRJ4sW1eOh0EtfcFvKjH5j1y1GbA0Y6q--Q@mail.gmail.com> <5322CF05-344D-4ADE-B38C-7DCE7F076E0C@infradead.org> <CAJZ5v0i-+9VwccRLGDcQdhz_UyBbw8k0LR9GbdvaRxs8PxP=0g@mail.gmail.com>
Message-ID: <35268BBA-E97F-4ACB-A1C1-04C94AFDEA65@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 December 2023 12:31:19 GMT, "Rafael J=2E Wysocki" <rafael@kernel=2Eorg=
> wrote:
>On Tue, Dec 5, 2023 at 1:15=E2=80=AFPM David Woodhouse <dwmw2@infradead=
=2Eorg> wrote:
>>
>> On 5 December 2023 12:12:09 GMT, "Rafael J=2E Wysocki" <rafael@kernel=
=2Eorg> wrote:
>> >On Tue, Dec 5, 2023 at 1:00=E2=80=AFPM David Woodhouse <dwmw2@infradea=
d=2Eorg> wrote:
>> >>
>> >>
>> >> Paul writes:
>> >> > The problem is that this will take effect even on a kexec and henc=
e it is throttling
>> >> > a system that set ENERGY_PERF_BIAS_PERFORMANCE prior to the kexec=
=2E  We use kexec to
>> >> > live update the host kernel of our systems whilst leaving virtual =
machines running=2E
>> >> > This resetting of the perf bias is having a very detrimental effec=
t on the downtime
>> >> > of our systems across the live update - about a 7 fold increase=2E
>> >>
>> >> It isn't just about kexec, is it? Even in a clean boot why wouldn't =
we want to stay in performance mode until the kernel has *finished* booting=
?
>> >
>> >Because it may overheat during that period=2E
>> >
>> >> It's literally adding seconds to the startup time in some cases=2E
>> >>
>> >> And yes, we *particularly* care in the kexec case because guests exp=
erience it as excessive steal time=2E But it ain't great in the general cas=
e either, surely?
>> >
>> >So IMV it would be perfectly fine to add a command line arg to provide
>> >the initial value of energy_perf_bias for the ones who know what they
>> >are doing=2E
>>
>> We don't even care about setting it to an "initial value" during boot=
=2E We just want to leave it how it was already set up=2E
>
>Which does not work on some systems=2E
>
>The problem here is that the BIOS cannot be trusted to set the initial
>value that makes sense for the given platform and that's why the code
>is the way it is=2E

Yeah, I understand why we have the existing hack=2E We just need a way to =
disable it when it's doing the wrong thing=2E

