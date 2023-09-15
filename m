Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856B67A24EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbjIORgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbjIORfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:35:37 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ED330C1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:34:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5924b2aac52so31847397b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694799277; x=1695404077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XJJJkdYQoV+TuxyICMmymuiRvcaqdo/oW6N/B153WLE=;
        b=Hz8jyX9trB5SbK12NzI2q1kW8Cf/npNWwmFvDkY+H9qRrI4zEJ2hTZqhmA6ki3V85n
         gXXHSCi2mR3seK/b7NF9GXcCvkBZT1vhiPcmsYvx8iV7+e8YxV0IHvgJ3/jsNS1wlAUH
         FPJpwifjOuHdQeHeMefLGDqcd232Ad/3yDAsvsDN4fuFZ65t6EAe2bHH4gmoXDiobC4A
         LZSQsAS5O+bN2wRTQEJRzD0NNUE6nbimgOFZQv+DEs+5J4TP32JEPrtAksm2kKShh+b1
         Sf4EPVxAV7c8ln1fa25+5xJ5k1ZWRtsw8QTGo8uUVOP6hRvBd10dfC0sx46izelumbaU
         bCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799277; x=1695404077;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJJJkdYQoV+TuxyICMmymuiRvcaqdo/oW6N/B153WLE=;
        b=a+nCklApPnpw8kkUNttTk8phcKUX7xwSjvdKvWtoItKqcij1VjiGZOw6c5vRtaivza
         58zGeMxrnnZaF9BDaE6A0tzrwbGnSg1m7gcBaGqEYpJN5QGGUAQNh4buN3BkatCQeHMW
         Ojte0jN/j/uPgqc/UtXS2E4J59HJoPqZIGAY/qMJSqQ+ECaq6ik+RRDFb8jJFBr0Q48t
         GDwE3JpLxwQ2OJab0D7mpwnnD3q4dT/WbkRtrVFFmHE0mtH/yX9tzPtt038umFfKO693
         vIjSjHkhNv1diIH017N3lgzE9NN/UGG8Y+XO16fYq7plZHaFVKsHLBs6RbIDF24OA0X/
         1ejA==
X-Gm-Message-State: AOJu0YylJ2caJmiy9ZiiSrA8NDOega0gNAmz1L4pCzhqLIpoD9kMjYaC
        87YOXP6ueWWIYmnatTZYz1wE2bV0tcbbdA/5EHw=
X-Google-Smtp-Source: AGHT+IEAHmjL5dTMrhswiFhjsYks3tmeFWHVYfPFl5tpcAmcDOUwNVDZ9Oub8FCz1WrA9lAgdMaDDhBi7ijkvR//Z9s=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:7f04:6b3:b482:dd2c])
 (user=ndesaulniers job=sendgmr) by 2002:a25:804f:0:b0:d81:7f38:6d69 with SMTP
 id a15-20020a25804f000000b00d817f386d69mr56369ybn.0.1694799276916; Fri, 15
 Sep 2023 10:34:36 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:34:27 -0700
In-Reply-To: <20230915-bpf_collision-v3-0-263fc519c21f@google.com>
Mime-Version: 1.0
References: <20230915-bpf_collision-v3-0-263fc519c21f@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=eMOZeIQ4DYNKvsNmDNzVbQZqpdex34Aww3b8Ah957X4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694799273; l=1627;
 i=ndesaulniers@google.com; s=20230823; h=from:subject:message-id;
 bh=Un0BK6Kn/Y9x5wHtdOd6qUrWjso13vQumzj2rjmjBdg=; b=5rueaC75pOHuA1brjat1Uh1IHpP8UpGk090yWGibirzkwVfVTSK3QKijrRtvJGvRfelm2Ou2H
 XSO66QfARkFC4DnKw4VJgK1+C1hdJdgOulmLsUL76zhBZiawI1HpDVv
X-Mailer: b4 0.12.3
Message-ID: <20230915-bpf_collision-v3-1-263fc519c21f@google.com>
Subject: [PATCH  bpf  v3 1/2] bpf: Fix BTF_ID symbol generation collision
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        stable@vger.kernel.org,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Marcus Seyfarth <m.seyfarth@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Marcus and Satya reported an issue where BTF_ID macro generates same
symbol in separate objects and that breaks final vmlinux link.

ld.lld: error: ld-temp.o <inline asm>:14577:1: symbol
'__BTF_ID__struct__cgroup__624' is already defined

This can be triggered under specific configs when __COUNTER__ happens to
be the same for the same symbol in two different translation units,
which is already quite unlikely to happen.

Add __LINE__ number suffix to make BTF_ID symbol more unique, which is
not a complete fix, but it would help for now and meanwhile we can work
on better solution as suggested by Andrii.

Cc: stable@vger.kernel.org
Reported-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Reported-by: Marcus Seyfarth <m.seyfarth@gmail.com>
Closes: https://github.com/ClangBuiltLinux/linux/issues/1913
Debugged-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/bpf/CAEf4Bzb5KQ2_LmhN769ifMeSJaWfebccUasQOfQKaOd0nQ51tw@mail.gmail.com/
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/btf_ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index a3462a9b8e18..a9cb10b0e2e9 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -49,7 +49,7 @@ word							\
 	____BTF_ID(symbol, word)
 
 #define __ID(prefix) \
-	__PASTE(prefix, __COUNTER__)
+	__PASTE(__PASTE(prefix, __COUNTER__), __LINE__)
 
 /*
  * The BTF_ID defines unique symbol for each ID pointing

-- 
2.42.0.459.ge4e396fd5e-goog

