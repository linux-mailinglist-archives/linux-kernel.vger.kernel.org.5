Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F2F76A15D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjGaTho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjGaThj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:37:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD34A1982
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:37:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-317798b359aso4357223f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1690832256; x=1691437056;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7uwEzlRP4+mthnZWfhTuzziq4CFxBm7M91f+ZmwKXs=;
        b=SwPzih8iRWN4rPibGLwjv1Ii3dnjPqG8CSPKQ06PccPtss6AwN2JkMvpuwV9zl4UtV
         W9q5KknSXsecflaQvizPn9qnzmFW6z/TIamLkyc/x9TwMLyKp7XMUKITxBdcMhmpD2hF
         sA84/3kiR8K5oqHf5Fsw0hjWKTUiuq/CWjDKquiu7n6oDbpaGdN3E+YEIq/FhzsfkSRQ
         k4wn1/E/EpCK2Dg6lKKb91aRqmafaeqpiv2u8ulpdTZFFbD5cU1N+tIXHPcl8F45pdyx
         O2O+ev4vpdwp4p8E3kQJ1WA2T8jDgt0YXInCu5mAYnkL9eEkKgTn4gfTi33Bftg5SsWu
         6pyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690832256; x=1691437056;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7uwEzlRP4+mthnZWfhTuzziq4CFxBm7M91f+ZmwKXs=;
        b=dTasrWMavfyLncmNWmgSMkPiTck+i7MCrJLLR6Z3WUhW4+a3X2drpPHVeCXKtbZjiQ
         dXfEl8HhD3iU7hBqESYmC0OwY2rq8Z1ht6GBbZv/q4GbxBlrIyB/nT+9lUJxIvCi7ndn
         Y3AMDoNvuW3eePMMCY5rbJw6YlEh8EIv43lsIj4a5jbFFmom75tFyptKFVnyMpGlbIT8
         MoqeWGpgMhvi5Fp94jWJsGH3AE7AQDXHRGTKCIUfszLAS0Rnrw+bVrh/d94yEkKvYuqT
         4hwfVhKKbDfE7jGQO2pki4pflLKME3hdJvMJCf8k1gtq9lFLMTobXXXjPr7FjPZyAhS+
         Zy6A==
X-Gm-Message-State: ABy/qLY1OtO3+erx2b1Dn+R0F8jwr3FmoxzOrXExyeUvNQQKSuw/CGBT
        erwqJAvDBh0pP73sqMYPF/VJWQ==
X-Google-Smtp-Source: APBJJlF2ToddA8wgn58G3MLiexQHKqLAt4xSzrHHHVz3bukGSKzr1533OUsywQMPb0lND6ZYc3cf1Q==
X-Received: by 2002:adf:e7ce:0:b0:317:5bde:e6de with SMTP id e14-20020adfe7ce000000b003175bdee6demr615220wrn.8.1690832256236;
        Mon, 31 Jul 2023 12:37:36 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id k13-20020a056000004d00b003176bd661fasm13829076wrx.116.2023.07.31.12.37.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Jul 2023 12:37:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v4 09/10] tools: lib: perf: Implement riscv mmap support
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAHVXubjhM9C1fw_Us=8+RuSJbW0pacFAk9gp7j2=BtMUPy_Byw@mail.gmail.com>
Date:   Mon, 31 Jul 2023 20:37:24 +0100
Cc:     Ian Rogers <irogers@google.com>,
        Brendan Sweeney <brs@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?utf-8?Q?R=C3=A9mi_Denis-Courmont?= <remi@remlab.net>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Atish Patra <atishp@rivosinc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3736D0AC-C87B-45D8-AB20-3A5A55D4FA64@jrtc27.com>
References: <20230727141428.962286-1-alexghiti@rivosinc.com>
 <20230727141428.962286-10-alexghiti@rivosinc.com>
 <CAP-5=fU5XYXrVnRUidpwjV2LiTsdebfidL43_Qo4Z7TBxMsVGA@mail.gmail.com>
 <CAHVXubgVAe1WsiZx5Ay+3KPK4u24k_vsnTwFFmBeVsHrGXwhfw@mail.gmail.com>
 <CAHVXubj80rQRShuDS09BeTrfR6nux0A68EMWLbeat8fd_Y3YdA@mail.gmail.com>
 <CAP-5=fWwzuGZ6a6Z38ndsb7gw7_uwS0a2VGXx08hMeiK8eZ91w@mail.gmail.com>
 <CAHVXubjhM9C1fw_Us=8+RuSJbW0pacFAk9gp7j2=BtMUPy_Byw@mail.gmail.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jul 2023, at 17:06, Alexandre Ghiti <alexghiti@rivosinc.com> =
wrote:
>=20
> On Mon, Jul 31, 2023 at 5:10=E2=80=AFPM Ian Rogers =
<irogers@google.com> wrote:
>>=20
>> On Mon, Jul 31, 2023 at 3:27=E2=80=AFAM Alexandre Ghiti =
<alexghiti@rivosinc.com> wrote:
>>>=20
>>> On Mon, Jul 31, 2023 at 12:15=E2=80=AFPM Alexandre Ghiti =
<alexghiti@rivosinc.com> wrote:
>>>>=20
>>>> Hi Ian,
>>>>=20
>>>> On Fri, Jul 28, 2023 at 7:53=E2=80=AFPM Ian Rogers =
<irogers@google.com> wrote:
>>>>>=20
>>>>> On Thu, Jul 27, 2023 at 7:28=E2=80=AFAM Alexandre Ghiti =
<alexghiti@rivosinc.com> wrote:
>>>>>>=20
>>>>>> riscv now supports mmaping hardware counters so add what's needed =
to
>>>>>> take advantage of that in libperf.
>>>>>>=20
>>>>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>>>>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>>>>>> Reviewed-by: Atish Patra <atishp@rivosinc.com>
>>>>>> ---
>>>>>> tools/lib/perf/mmap.c | 65 =
+++++++++++++++++++++++++++++++++++++++++++
>>>>>> 1 file changed, 65 insertions(+)
>>>>>>=20
>>>>>> diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
>>>>>> index 0d1634cedf44..378a163f0554 100644
>>>>>> --- a/tools/lib/perf/mmap.c
>>>>>> +++ b/tools/lib/perf/mmap.c
>>>>>> @@ -392,6 +392,71 @@ static u64 read_perf_counter(unsigned int =
counter)
>>>>>>=20
>>>>>> static u64 read_timestamp(void) { return read_sysreg(cntvct_el0); =
}
>>>>>>=20
>>>>>> +#elif __riscv_xlen =3D=3D 64
>>>>>=20
>>>>> This is something of an odd guard, perhaps:
>>>>> #elif defined(__riscv) && __riscv_xlen =3D=3D 64
>>>>>=20
>>>>> That way it is more intention revealing that this is riscv code. =
Could
>>>>> you add a comment relating to the __riscv_xlen ?
>>>>=20
>>>> I guess Andrew answered that already.
>>>>=20
>>=20
>> Not sure. I still think it looks weird:
>> ...
>> #if defined(__i386__) || defined(__x86_64__)
>> ...
>> #elif defined(__aarch64__)
>> ...
>> #elif __riscv_xlen =3D=3D 64
>> ...
>> #else
>> static u64 read_perf_counter(unsigned int counter __maybe_unused) { =
return 0; }
>> static u64 read_timestamp(void) { return 0; }
>> #endif
>>=20
>> The first two are clearly #ifdef-ing architecture specific assembly
>> code, under what conditions I get RISC-V code  =C2=AF\(=E3=83=84)/=C2=AF=
 At least worth
>> a comment like "csrr is only available when you have xlens of 64
>> because ..."
>=20
> __riscv_xlen indicates riscv64, which is the only target of this
> patchset. But if you prefer, I don't mind adding back the
> defined(__riscv) if I re-spin a new version.

I mean, -Wundef is a thing that will scream at you if you evaluate a
macro that=E2=80=99s undefined and get an implicit 0, and parts of the =
linux
build seem to enable it. So I would strongly recommend against
(ab)using that feature of the preprocessor, especially when it aligns
with greater clarity.

Jess

