Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BE37FCDC1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 05:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjK2ENI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 23:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjK2ENH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 23:13:07 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255651AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 20:13:13 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cfb3ee8bc7so34007705ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 20:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701231192; x=1701835992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8j4EYBU493LEz8Zh+tBELxNXmpbmkFEmew+FDxkJD34=;
        b=f8XRb8nT3cOKs/muag7BMWdHdf/L6fSqJ0m80Vjz0MQHAFn5JjZw6j5YpKvm+EeDRG
         0qKtkXX8tWftyWPV1N92Xu1g5sqSWtFaKDiDFLtFsxi1XZtfEEnxGcmDAngTDHZpQ6Fd
         BXlDAJk7/17fFC1OXHgRIFlF5mJXKCVpfxGXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701231192; x=1701835992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8j4EYBU493LEz8Zh+tBELxNXmpbmkFEmew+FDxkJD34=;
        b=M2AkLQo4UO9JsogUg5JWy50tpXrYQwMZ/ZimaqmrQns78httoYRt5ColZJuZK8Epj1
         3MkxkcsKuPOdOpT98sT5J+6o/lcxLt9Hpl3Fgg0sNryS5rTr8RtPwQf1fdJkyNyuT31l
         lpau67reUAbZcMr/KXeon/IEsYqhuXVbeSO4S3SI3YI/t/byPCGa072emFc35HRqoGSz
         7JBeHkuoo5UcpcJFtbzXnGd6fvwm907pdVYUqlxC+9pdzt7HGGaLiV/Ubr8oMZl0Z+RP
         wtcdPpuWy1p6ivN0mcV4kATyl9qkYmyRdOo0eSJn5QHEL148z9BQxY91YSbe8RXRnXe9
         ru0g==
X-Gm-Message-State: AOJu0YwGa7QwOZsbtEsXowFLznwS3sleXRvZTYjiScRiZpTDj5YL1TWz
        2aieB7I5YY0F+TcJR3LsgfK0WVkIOqufgjOtMok=
X-Google-Smtp-Source: AGHT+IHILBtN2a2WsTtZvFxUUrflJxAdcdnD0krcYu0qCRcCl171VU82Qlhcma9Lq5IXFYKaaHEGtw==
X-Received: by 2002:a17:902:d303:b0:1cf:876e:aa41 with SMTP id b3-20020a170902d30300b001cf876eaa41mr19256468plc.30.1701231192562;
        Tue, 28 Nov 2023 20:13:12 -0800 (PST)
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id ju12-20020a170903428c00b001bbb8d5166bsm11146965plb.123.2023.11.28.20.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 20:13:11 -0800 (PST)
Date:   Wed, 29 Nov 2023 13:13:07 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Patrick Georgi <pgeorgi@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Reinauer <reinauer@google.com>
Subject: Re: [PATCH] kconfig: WERROR unmet symbol dependency
Message-ID: <20231129041307.GB6525@google.com>
References: <20231122034753.1446513-1-senozhatsky@chromium.org>
 <20231128053443.GA6525@google.com>
 <CAK7LNAT_Z4TeNzngMskEoNdSTWUH5gGzYm5MfO6C_H8rFcF6ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAT_Z4TeNzngMskEoNdSTWUH5gGzYm5MfO6C_H8rFcF6ng@mail.gmail.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/11/28 23:19), Masahiro Yamada wrote:

[..]

> KCONFIG_WERROR is meant to turn all warnings
> to errors.
> I do not see getenv("KCONFIG_WERROR")
> sprinkled everywhere in Kconfig.
> One more thing, you cannot directly exit(1)
> from sym_calc_value().

We do exit(1) for KCONFIG_WARN_UNKNOWN_SYMBOLS in conf_read().

I can introduce two new helpers that will tell if confdata.c and symbol.c
triggered any warnings and if KCONFIG_WERROR is set. And then different
code paths can call them and handle exit gracefully, depending on the
context (ncurses, menu, etc.).

Something like this

---
 scripts/kconfig/conf.c      |  6 ++++++
 scripts/kconfig/confdata.c  | 13 ++++++++-----
 scripts/kconfig/lkc_proto.h |  2 ++
 scripts/kconfig/symbol.c    |  9 +++++++++
 4 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 33d19e419908..662a5e7c37c2 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -827,6 +827,9 @@ int main(int ac, char **av)
 		break;
 	}
 
+	if (conf_errors())
+		exit(1);
+
 	if (sync_kconfig) {
 		name = getenv("KCONFIG_NOSILENTUPDATE");
 		if (name && *name) {
@@ -890,6 +893,9 @@ int main(int ac, char **av)
 		break;
 	}
 
+	if (sym_dep_errors())
+		exit(1);
+
 	if (input_mode == savedefconfig) {
 		if (conf_write_defconfig(defconfig_file)) {
 			fprintf(stderr, "n*** Error while saving defconfig to: %s\n\n",
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index bd14aae1db58..9c8bee10c952 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -155,6 +155,13 @@ static void conf_message(const char *fmt, ...)
 static const char *conf_filename;
 static int conf_lineno, conf_warnings;
 
+bool conf_errors(void)
+{
+	if (conf_warnings)
+		return getenv("KCONFIG_WERROR");
+	return false;
+}
+
 static void conf_warning(const char *fmt, ...)
 {
 	va_list ap;
@@ -365,10 +372,9 @@ int conf_read_simple(const char *name, int def)
 	char *p, *val;
 	struct symbol *sym;
 	int i, def_flags;
-	const char *warn_unknown, *werror, *sym_name;
+	const char *warn_unknown, *sym_name;
 
 	warn_unknown = getenv("KCONFIG_WARN_UNKNOWN_SYMBOLS");
-	werror = getenv("KCONFIG_WERROR");
 	if (name) {
 		in = zconf_fopen(name);
 	} else {
@@ -526,9 +532,6 @@ int conf_read_simple(const char *name, int def)
 	free(line);
 	fclose(in);
 
-	if (conf_warnings && werror)
-		exit(1);
-
 	return 0;
 }
 
diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index edd1e617b25c..e4931bde7ca7 100644
--- a/scripts/kconfig/lkc_proto.h
+++ b/scripts/kconfig/lkc_proto.h
@@ -12,6 +12,7 @@ void conf_set_changed(bool val);
 bool conf_get_changed(void);
 void conf_set_changed_callback(void (*fn)(void));
 void conf_set_message_callback(void (*fn)(const char *s));
+bool conf_errors(void);
 
 /* symbol.c */
 extern struct symbol * symbol_hash[SYMBOL_HASHSIZE];
@@ -22,6 +23,7 @@ void print_symbol_for_listconfig(struct symbol *sym);
 struct symbol ** sym_re_search(const char *pattern);
 const char * sym_type_name(enum symbol_type type);
 void sym_calc_value(struct symbol *sym);
+bool sym_dep_errors(void);
 enum symbol_type sym_get_type(struct symbol *sym);
 bool sym_tristate_within_range(struct symbol *sym,tristate tri);
 bool sym_set_tristate_value(struct symbol *sym,tristate tri);
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index a76925b46ce6..4eb352bba710 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -37,6 +37,7 @@ static struct symbol symbol_empty = {
 
 struct symbol *modules_sym;
 static tristate modules_val;
+static int sym_warnings;
 
 enum symbol_type sym_get_type(struct symbol *sym)
 {
@@ -317,6 +318,14 @@ static void sym_warn_unmet_dep(struct symbol *sym)
 			       "  Selected by [m]:\n");
 
 	fputs(str_get(&gs), stderr);
+	sym_warnings++;
+}
+
+bool sym_dep_errors(void)
+{
+	if (sym_warnings)
+		return getenv("KCONFIG_WERROR");
+	return false;
 }
 
 void sym_calc_value(struct symbol *sym)
-- 
2.43.0.rc1.413.gea7ed67945-goog
