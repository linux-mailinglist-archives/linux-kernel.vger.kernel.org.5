Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CA7786453
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 02:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbjHXAsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 20:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbjHXArz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 20:47:55 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4C6CED
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 17:47:53 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a3cae6d94so3790807b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 17:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692838072; x=1693442872;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mqmqQz32jBcW9BevzM5t/zeWptvSYdEFNatyBEm47Vs=;
        b=bCMBaZ+BXhH5KQKBdOAO9bRl6+m9EFy7XxlE2DpJUVSXCkrKK/lXy+QbD2jPLqp9vt
         GuwSVAbqKsmEgFYo9Es5U3dSiRu7+tYw7JKGcpeDMT+hy/acPcL2KdcmiB+tsejsrFkN
         QIUBWW2nFa2r8YqCXGC+e4ub2bYzbKKkI2Gmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692838072; x=1693442872;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqmqQz32jBcW9BevzM5t/zeWptvSYdEFNatyBEm47Vs=;
        b=fM0xNNse1dxG1IPFtXklchcLX36lH/YJJLF+I3r+7BBWRBfbDwsb9Z35ZLxi11Z1Lj
         PlwTOoy185z5Xte3GMd/zVlMsg6VtQem6dC2AL9wMB3EPgIk6jxXSomGitwFmg0KpmZW
         fAIlbreZChZp1fQwgzkcNZvhoZXaw1uFnbjvYmegfdifV3Y7twJ2SgWJTjjF83CJmlBm
         pWz/xPABX5p28TG2TPdtvNihoC/sTPzTU1mg/q6cl39vZihe/lpnjmnfox9k4noycH6x
         6fnIHf//YWQ06kUhjtBSqspXbNs9uEjoJrrhBX0l+5spq+eQ2NOUikPI6yIR1HNckjfJ
         W2bg==
X-Gm-Message-State: AOJu0Yx0ssU2IW+EFykI2rXjBoN70v/Z+3G3MencCR9ttBZH7pnhRD/m
        Lu0jdwn1ie0RBX5f6q1Ur4mGNA==
X-Google-Smtp-Source: AGHT+IF2pUCFtH2+SpnHTH/g5ciVoWAYzING55WBLUuNjl1Hy4m9cFG8aGTmEZRpb71c17WJ0Me8WQ==
X-Received: by 2002:a05:6a20:a11f:b0:140:3aa:e2ce with SMTP id q31-20020a056a20a11f00b0014003aae2cemr17743934pzk.42.1692838072501;
        Wed, 23 Aug 2023 17:47:52 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id jc19-20020a17090325d300b001b8b73da7b1sm11457406plb.227.2023.08.23.17.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 17:47:52 -0700 (PDT)
Date:   Thu, 24 Aug 2023 09:47:47 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ying Sun <sunying@nj.iscas.ac.cn>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Siyuan Guo <zy21df106@buaa.edu.cn>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jesse T <mr.bossman075@gmail.com>
Subject: Re: [PATCH] kconfig: add dependency warning print about invalid
 values in verbose mode
Message-ID: <20230824004747.GC3913@google.com>
References: <20230809002436.18079-1-sunying@nj.iscas.ac.cn>
 <CAK7LNARH-ziDD8=+90y5Zzo0cqqnc5qaiVWW0YQzdZ=nO9+e8w@mail.gmail.com>
 <CAJFTR8SajdzT2kKscEpPon9faUa8tHrvYPC_+awG3VeHVS8sSg@mail.gmail.com>
 <20230823015551.GB3913@google.com>
 <CAK7LNAQNk2MU=M5Q6GXtm34VyFcNOhVgw3UQ7Mdn4hoqQ_636A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQNk2MU=M5Q6GXtm34VyFcNOhVgw3UQ7Mdn4hoqQ_636A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/24 06:52), Masahiro Yamada wrote:
> On Wed, Aug 23, 2023 at 10:56 AM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (23/08/19 22:40), Jesse T wrote:
> > > > > From: Ying Sun <sunying@nj.iscas.ac.cn>
> > > > >
> > > > > Add warning about the configuration option's invalid value in verbose mode,
> > > > >  including error causes, mismatch dependency, old and new values,
> > > > >  to help users correct them.
> >
> > Are those really errors?
> >
> > ERROR : CLANG_VERSION[140006 => 0] value is invalid  due to it has default value
> > ERROR : CC_IS_GCC[n => y] value is invalid  due to it has default value
> > ERROR : GCC_VERSION[0 => 120200] value is invalid  due to it has default value
> >
> > I'm using clang, so corresponding options are set accordingly in my .config
> 
> 
> I think not errors, but warnings.

I agree.

Masahiro, do we really need "list missing" to be blocked on this?
This patch has been posted on Aug 8 and there was not much progress
since then. Can we, perhaps, move "list missing" forward?


---
 scripts/kconfig/confdata.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index fa2ae6f63352..bf6d473755aa 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -360,7 +360,10 @@ int conf_read_simple(const char *name, int def)
        char *p, *p2;
        struct symbol *sym;
        int i, def_flags;
+       bool missing = false;
+       const char *sanity_checks;
 
+       sanity_checks = getenv("KCONFIG_SANITY_CHECKS");
        if (name) {
                in = zconf_fopen(name);
        } else {
@@ -448,6 +451,13 @@ int conf_read_simple(const char *name, int def)
                        if (def == S_DEF_USER) {
                                sym = sym_find(line + 2 + strlen(CONFIG_));
                                if (!sym) {
+                                       if (sanity_checks) {
+                                               conf_warning("unknown symbol: %s",
+                                                            line + 2 + strlen(CONFIG_));
+                                               missing = true;
+                                               continue;
+                                       }
+
                                        conf_set_changed(true);
                                        continue;
                                }
@@ -482,6 +492,13 @@ int conf_read_simple(const char *name, int def)
 
                        sym = sym_find(line + strlen(CONFIG_));
                        if (!sym) {
+                               if (sanity_checks && def != S_DEF_AUTO) {
+                                       conf_warning("unknown symbol: %s",
+                                                    line + strlen(CONFIG_));
+                                       missing = true;
+                                       continue;
+                               }
+
                                if (def == S_DEF_AUTO)
                                        /*
                                         * Reading from include/config/auto.conf
@@ -530,6 +547,10 @@ int conf_read_simple(const char *name, int def)
        }
        free(line);
        fclose(in);
+
+       if (missing)
+               exit(1);
+
        return 0;
 }
 
-- 
2.42.0.rc1.204.g551eb34607-goog
