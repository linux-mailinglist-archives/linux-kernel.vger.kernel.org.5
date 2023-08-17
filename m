Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D60B77F29F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349244AbjHQI6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349201AbjHQI6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:58:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA2910C8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:58:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-26b5e737191so2393639a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262692; x=1692867492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehijAG3+DimElseOvhT2ydoS3VjVdNFUrFCVSW8Tlxc=;
        b=hSxOPHq4BKOHG2rjMx+eCEaltK6EuVzY7bFcWGYSKFEM4Ma2nvNcu1knimN7RQYL5j
         V6ZILhSBJ4uRpu1Yex71+JSerksuhVkWPYksqQmCYT+6Ayogq/Lkm02Xf3/T44eLdmfg
         AYrAhWo3fORH8bOal2jmfPFbxW92+q9w3Gvtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262692; x=1692867492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehijAG3+DimElseOvhT2ydoS3VjVdNFUrFCVSW8Tlxc=;
        b=eqV7dt5BkVLLTVhPkUxYoGNSLeOO/U0bZ7I8041O0XdrY/WdkTNXX4nSOGE2bwj3Zo
         KUE0tp6WAAges/SjfGq2RWUlSiYXg3QVQ/37LCoRWqIVBOqT4mOUPZ7rryAjnJm2990d
         KfdYVyYPKRGbfS0sXQPHuLNGE8o/TV6tKsaJF5yiLVkgAPi8if7dUHH3YftArxMfv2G+
         LLsqTGUugSJOzQd3qNNdX9yOjmILGsMJ3UWuCoxKQzAvcShqttQKDY726/Cfg2vtL7lL
         KmDGkDVbg7NsPeljQ8EwooyoDksCDJiDyxUql4K3NpFzZ4XgvQEGMBKvR+qmPg+vncbW
         12ZA==
X-Gm-Message-State: AOJu0YyH6+XnIyodZ787/mZJ7JMwFIPsxVgP+60poDgfYpsrbreBjCeV
        XUk0XuCpFms7EMfdDhXUWNAe+thcU4ffWg6BXC0jTQ==
X-Google-Smtp-Source: AGHT+IH7wJlK1Wn93MuV/91kwcNihtgsOunIPXO95uzJnJCqLl1ks9/sg/b2XhIGI7m4uJxhwSFPfPgEM1o0qlVcsn8=
X-Received: by 2002:a17:90b:3b49:b0:268:1be1:745a with SMTP id
 ot9-20020a17090b3b4900b002681be1745amr3423253pjb.29.1692262692654; Thu, 17
 Aug 2023 01:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2> <169181869006.505132.4695602314698748304.stgit@devnote2>
In-Reply-To: <169181869006.505132.4695602314698748304.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 17 Aug 2023 10:58:01 +0200
Message-ID: <CABRcYmLzPRZERpF2PUru7_LJOASrGp9Q=ftdxFfJYCVd0QFDJg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] Documentations: probes: Update fprobe document to
 use ftrace_regs
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 7:38=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Update fprobe document so that the entry/exit handler uses ftrace_regs
> instead of pt_regs.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Florent Revest <revest@chromium.org>
