Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD4C7A23BB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbjIOQmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbjIOQmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:42:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205E1118
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:42:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d77fa2e7771so2799851276.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694796145; x=1695400945; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5w8nYSzkVPx0Y4u1Ts0WLw0xCMJcfflotrabEjHQ33Q=;
        b=ApwWh6n0wxiKSuI9gEA0fx0wrklh1S2ew7sCqhPf6FbE9afejpIXqjisiF7zu5r11D
         ZUAykGC9rMwJ8Y8fr+ylxXv+PG8lgScEAIWNXH3TKVhNOk4EUUFUg39RSMJnJV2o7iyg
         H4LD3sIKrnOkeSHF6O2A4BVz6APzAxC/tCx1Ub20h2Emh2fxRd8nddncuf5O7zydF2+6
         6eQiGLWqAfizCCpCzSUjqhWPmhjOhoOeZutKRwpgSEpa+TlQrZCXC/W+bgji+SfjYeys
         sBiTbfBntmTxUGLD3iigbvmEJV7Vt2wxwmP4ksJQP7yHOCLVpa0/nY8c+B8Ipst1WgfH
         bgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694796145; x=1695400945;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5w8nYSzkVPx0Y4u1Ts0WLw0xCMJcfflotrabEjHQ33Q=;
        b=oAtsXVtKj0isgvR/Zun3zgl/jisUO6vlEr4OpO8r1vgoRqW9rmtrj8o3jqzMeTVgXC
         lBH1UV1N2rjQrqN787WxqJPc4/dw3O+pH9Qpz4TAUka/BvT7AQ381C++cCEuAcsNFepA
         cHBQpR8ObLkdylF3jCS18YMynaMTsIV1nZBue8G5BBoya784YZo29m3G8+aA7FFxcT/s
         BWJ68pBGtcSfaky9vh3orD9MolCTcnzEJzx5Vw5t6J80NoPprgxOdN+kIx3gkAHnifRZ
         9TokymcioA6DMgo9LTuR4F8SVOkvTWGFXQFw61ISx4ePdD3D4m5VZxLad22Ld06hDC6g
         2H6A==
X-Gm-Message-State: AOJu0YwYVlrJMQ7dUuUX6+7VmJxRt2aEVlrh/sj+Ai/GxdcYnZS8TFn+
        kNSNOKuad9RDGLlaJ6ZcJhFW9h3NELGrOWGy/u0=
X-Google-Smtp-Source: AGHT+IGST3z+4KkcZ6kz4kNyjk4QqtRxcLbAmEGaWSms7bQf894dFDpTB9oaFPiSxyc4T6mpJxzaP3F9DPY4Ro3m/Hs=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:22ea:f17b:9811:4611])
 (user=ndesaulniers job=sendgmr) by 2002:a25:fc01:0:b0:d10:5b67:843c with SMTP
 id v1-20020a25fc01000000b00d105b67843cmr50528ybd.4.1694796145127; Fri, 15 Sep
 2023 09:42:25 -0700 (PDT)
Date:   Fri, 15 Sep 2023 09:42:20 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGuJBGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI2MDS0NT3aSCtPjk/JwcsEpdYzMLC8tEY0vDFBMTJaCegqLUtMwKsHnRsbW 1AKn00e1fAAAA
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=eMOZeIQ4DYNKvsNmDNzVbQZqpdex34Aww3b8Ah957X4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694796143; l=1838;
 i=ndesaulniers@google.com; s=20230823; h=from:subject:message-id;
 bh=xGla73CQna/Fo/W2LSdP2nzHHuTYVpRoroUyiOyj28c=; b=PXHwW1V09cFms7V2IdxFS5Lhjdgg3ChUMjyCNuo5CFmdvRYm+zJ/C9YtGZKTavJ+GvRYufx1c
 3hWeTQ77CCGBtgQPO5uvlTnSX1I/sGSpJSC8fEX0g1G09/3VdFv6clr
X-Mailer: b4 0.12.3
Message-ID: <20230915-bpf_collision-v2-1-027670d38bdf@google.com>
Subject: [PATCH v2] bpf: Fix BTF_ID symbol generation collision
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, stable@vger.kernel.org,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Marcus Seyfarth <m.seyfarth@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
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
Tested-by: Marcus Seyfarth <m.seyfarth@gmail.com>
Debugged-by: Nathan Chancellor <nathan@kernel.org>
Co-developed-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/CAEf4Bzb5KQ2_LmhN769ifMeSJaWfebccUasQOfQKaOd0nQ51tw@mail.gmail.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 tools/include/linux/btf_ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 71e54b1e3796..30e920b96a18 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -38,7 +38,7 @@ asm(							\
 	____BTF_ID(symbol)
 
 #define __ID(prefix) \
-	__PASTE(prefix, __COUNTER__)
+	__PASTE(prefix, __COUNTER__ __LINE__)
 
 /*
  * The BTF_ID defines unique symbol for each ID pointing

---
base-commit: 9fdfb15a3dbf818e06be514f4abbfc071004cbe7
change-id: 20230915-bpf_collision-36889a391d44

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

