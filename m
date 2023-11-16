Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82C27EDD0A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344957AbjKPInG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344953AbjKPInD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:43:03 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7E81A3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:42:59 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-672096e0e89so2850606d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700124179; x=1700728979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rm7nK+NtRd4bAMB5kW+BiMwXh44U1dcDR7sRoBwvzjA=;
        b=nF+ikcHl03m7jOFzOAk/aLqZezXmQgj0b9DWtjCdLAwRSJxsX8BuMwqSwQfhoNEU2Y
         T5t05s7fvpTrjEQj+Nb4F1+FgXrP2A62wROKfW/m50hPu3RXEI9l1N/vP93IH3TSDgfl
         IsaP87awPArZPPTL+1gI7x2wVNO/F5TV0KHkG7fey69OTSCGxuTU4O1IE6dqJ0s2fYCw
         38SYX8eXQE17rVXnSYKhcVbmPq/UiAsRVKBgjUneJVoTrDm7H+ekYFrL70NS0ytb7VXr
         4FbT/QqWjpoLpXwCFwXPSPaLl1fINFPVZgU9xhjNvv7pUSn5CxGNniMqzW/2ByH99lHn
         /vqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700124179; x=1700728979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rm7nK+NtRd4bAMB5kW+BiMwXh44U1dcDR7sRoBwvzjA=;
        b=bRVDuClAbyj37qWkimc8pFzEqJXRbbmwMZCsHoxJkQLULfIX7ge71W6qKyfNrNzEmv
         +UQCl22KuFs/9KQdpHUOpEd9dyDyBJGV8qU+3Jk0H5Uo+9E/IROqsZWDMPsPYmzCS+iK
         Qzp9Ypmx4HdorwGp9eZ3NiY1IuOqn8h1OG3hOC3JhBpRfZ3nT/l4jvuYK3LheXrK4IAw
         HTrOXG8Qk7BVhdYqUSK2sw3FGrPymoead+9z7MucwoFSCsC6f7xAqaoLe6EG0QYD2/wp
         cXGfzN6EU+qAGAwIauZU2mxSLWCdl1YVHH5iPWNtDfLKCuXCi4NU1l887BcuB4zJw0Tz
         Oqcw==
X-Gm-Message-State: AOJu0YwM3ueSju7DcV9vAg8cS8aVD/Kg/gyy+quN0z0qZ1HuA7EEoMBv
        gjILnpUBjHmz4uKHkPqLCVY2561mc09x8tavu6oHCA==
X-Google-Smtp-Source: AGHT+IH6qhh+dNSCS8qlmsj8ih0YO9KvQIu5BurzqUnTPk5VIq6JplJrO+8kjsmK6Xqo+e4Abaw23H8ROYFxm8aLIFw=
X-Received: by 2002:a0c:fbc2:0:b0:670:6340:2b03 with SMTP id
 n2-20020a0cfbc2000000b0067063402b03mr7946532qvp.21.1700124178734; Thu, 16 Nov
 2023 00:42:58 -0800 (PST)
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-1-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Nov 2023 09:42:18 +0100
Message-ID: <CAG_fn=U+X=EE9SSb61E=QDReBXn6PGiX4gJnMfNKsTwQ6saKcA@mail.gmail.com>
Subject: Re: [PATCH 00/32] kmsan: Enable on s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 9:34=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Hi,
>
> This series provides the minimal support for Kernel Memory Sanitizer on
> s390. Kernel Memory Sanitizer is clang-only instrumentation for finding
> accesses to uninitialized memory. The clang support for s390 has already
> been merged [1].
>
> With this series, I can successfully boot s390 defconfig and
> debug_defconfig with kmsan.panic=3D1. The tool found one real
> s390-specific bug (fixed in master).
>
> Best regards,
> Ilya

Hi Ilya,

This is really impressive!
Can you please share some instructions on how to run KMSAN in QEMU?
I've never touched s390, but I'm assuming it should be possible?
