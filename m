Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB17C7D0A42
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbjJTIIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbjJTIIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:08:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC27E8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:08:45 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53da72739c3so662449a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697789324; x=1698394124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2HOC5/4bMpg9cyF+EiTAHykbUuGuPCUW4tYTG2rjRc=;
        b=COwWevCOsfcuz9n75b9IRLTpwXKcdB6sGyCuMR1rEXM2JwrWDLCt9Uw6g/d7asjAvf
         vJAG6WwWjRRWlsoC1X/A0JZLvALcT1fqLNv8G/jNyZG0GYn5yPZKMfzSBLYBaPyDPhBV
         YCuzl/7C9PnuPfADdIFx2knBW1gIG60g1UtcjmruJ7qTlu1jHqBQfQWWB4pO73ATIluq
         zddyuteV2Lk1NV2KRhJZoY6QHgb0bPOlVglpMDDdVyB0sISF/KQ6cSalrjR9VIIyBi4C
         YVSxZg0ZR52m2NPW3UWvWH9GRCPQWPpoP2WPgeNGmVqh6SlB24WG2+Yg13hGSsIz55/R
         bgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697789324; x=1698394124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2HOC5/4bMpg9cyF+EiTAHykbUuGuPCUW4tYTG2rjRc=;
        b=V8izq3lhlYgEfjkuMzkILtqZZaUPpheh2ryEKHQUVs1WWBoLqZYdH+/LLrRJYqN5Ad
         AnU2euWSMp6C+gU+K/JQDRotLGnMRl+zerFAyRJGc3Qsin87DBjPB24tSYkHIKKyO0B0
         tl2pmRIiuovhoTIXP2bfPtKZRHEQax6EXYsaYm3Q+xnpAQdr2eskqZZ0NtuNIfSnATkk
         +0ZML5xZAIto8mPoAFa/50rvfAJaXy+nLVu3NZYbybo1rnLIzMRAyi2v7TQvHAzp+C2H
         4fgGSSLyv5bU8mVFMfIsrstMPx6qancTctI8ENezJYyrgf7oXKx9wC4n9ThVsCyG34E1
         JoUQ==
X-Gm-Message-State: AOJu0YyMQOxZ6q2X36dO5g+Tipy8wKxG5d3TB61fLirgwJbLIyhmRMTC
        fw8Dc4z9sS6UVtZ3099rI0VWWq0PWVzZG+PKILI=
X-Google-Smtp-Source: AGHT+IEAWdQfumCDboDguKUKyT4qWljV3n6nbzinXUufpUyrZr5SR9UwFJiXRa4u5UlKUWUdfIHBATdukwue5+USKoM=
X-Received: by 2002:a50:99db:0:b0:53d:ff75:9c38 with SMTP id
 n27-20020a5099db000000b0053dff759c38mr790525edb.39.1697789323787; Fri, 20 Oct
 2023 01:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
 <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com>
 <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com> <CAHk-=wj1dLFkL9Qv2vtk0O8Q6WE-11Jq3KucZoz2Kkw59LAexw@mail.gmail.com>
 <9F926586-20D9-4979-AB7A-71124BBAABD3@vmware.com> <CAHk-=wi7YKPKKZw5SpA9gZcf4paG4pZ2kUM50g-LQmdF0g6vWg@mail.gmail.com>
 <CAFULd4bpHkNzCzKed23mTTBWRyhPnOm91f+F6UE413VK+oFtMQ@mail.gmail.com>
 <CAFULd4Z-q4Ot6iyOLo7DkjE=dY3RHXUV+yx6R0iWk=-tZ6ufhQ@mail.gmail.com>
 <CAHk-=wjSnECwAe+Bi0PD6uods3ZDs8up5OAy-qZKF5OgPLpDiA@mail.gmail.com>
 <CAFULd4bLEU-tBC8dO1wf66UAxQ2d1HxQ=D6wvtHZfdQCKhnpkw@mail.gmail.com>
 <CAFULd4YAFTFqon3ojv7N6h=G_1pAjSH3T6YvX0G=g7Fwh7j1jQ@mail.gmail.com>
 <A2E458DE-8B84-4FB2-BF6D-3EAB2B355078@vmware.com> <CAFULd4b_PdKb=8U5+Zz-XNoYdULtcQJnmf-yCrpCv7RRogSXyQ@mail.gmail.com>
 <CAFULd4Y8_MOMGcatcMuUaC89zX5F-VYr0niiJ9Yd8hQ16neHjw@mail.gmail.com>
 <3F9D776E-AD7E-4814-9E3C-508550AD9287@vmware.com> <CAFULd4Zruoq4b5imt3NfN4D+0RY2-i==KGAwUHR8JD0T8=HJBw@mail.gmail.com>
 <28B9471C-4FB0-4AB0-81DD-4885C3645E95@vmware.com> <CAHk-=whS8-Lk_=mFp=mr-JrbRYtScgz-4s_GLAOQGafa_3zP9g@mail.gmail.com>
 <CAFULd4Yy-v40tK94rexSOL99FGMke2Jk42wgcjoEBxV=2hXoCw@mail.gmail.com>
 <CAHk-=wjrLoy6xEDXB=piEUagDLMmV5Up7UK75W1D0E0UFVO-iA@mail.gmail.com>
 <CAFULd4autFT=96EckL9vUDgO5t0ESp27+NDVXQHGi7N=PAo-HQ@mail.gmail.com>
 <CAFULd4Zhw=zoDtir03FdPxJD15GZ5N=SV9=4Z45_Q_P9BL1rvQ@mail.gmail.com>
 <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com>
 <CAHk-=wgCPbkf0Kdi=4T3LAVvNEH0jxJBWcTiBkrFDBsxkC9mKQ@mail.gmail.com>
 <CAFULd4aTY002A7NHRCX21aTpYOE=tnpouBk6hkoeWND=LnT4ww@mail.gmail.com>
 <CAHk-=wia9vFmyCJPkYg0vvegF8eojLy+DxVtpfoDv-UHoWKfqQ@mail.gmail.com>
 <CAFULd4Zj5hTvATZUVYhUGrxH3fiAUWjO9C27UV_USf2H164thQ@mail.gmail.com>
 <CAHk-=whEc2HR3En32uyAufPM3tEh8J4+dot6JyGW=Eg5SEhx7A@mail.gmail.com>
 <CAFULd4avm_TaEoRauohRc90SUrx-D+wBJvg+htQDQ1_N=zNemw@mail.gmail.com>
 <CAHk-=wijmmRB7-ZeT-sdxCSUoB83Lb5dnN7a7mCcH3cRw_aghQ@mail.gmail.com>
 <CAFULd4b91Tr9Q2p4a20eusC+QO6O81gxY+nP-zpFiFKGTmLpYg@mail.gmail.com>
 <CAHk-=wi3LZ_4OGAMhvgO0JSTp-eEPOGp+siq1nJNLY1JAxdP5Q@mail.gmail.com>
 <CAFULd4YxvMtTEfQL-RiLisTxDwoJZZxXXB+3CWqCpzZkUf85JA@mail.gmail.com>
 <CAHk-=wj8qEwR1eGeJdup2q90WK7ZWBjpcXJEBi-TBp29p0n8oQ@mail.gmail.com> <CAHk-=wjvHDp+oiC4UZxivF6fCjKWFAAzgBYZdng6qe+ED6rLTg@mail.gmail.com>
In-Reply-To: <CAHk-=wjvHDp+oiC4UZxivF6fCjKWFAAzgBYZdng6qe+ED6rLTg@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Fri, 20 Oct 2023 10:08:32 +0200
Message-ID: <CAFULd4ZzyZBZf0DrdURvxLrPaBtANMsK7UqCYk2_Qyu-AsL0zw@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 12:39=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Unrelated question to the gcc people (well, related in the way that
> this discussion made me *test* this).

Perhaps you should report this in the gcc bugzilla and move the
discussion there. This thread already has more than 100 messages...

Thanks,
Uros.
