Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D764277E227
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245366AbjHPNGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245433AbjHPNGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:06:35 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24E02712
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:06:28 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-54290603887so3958987a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692191188; x=1692795988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y8LN8kLzzLczsPbdJAMvHHgeSuXAc6gkdKeWAaN4L44=;
        b=Ktdl2pgaHZptGepBHvj9uBh+Ex2svm7kOQy0oPCJUlhZJogSdmIUlJz5mlGxjF06jn
         yh9iP8z2++tuthp+kMS+42ig6DtlNijgRJ8srGolUb1ueoSmWLz5HdgxLWlMj/3qNsV4
         ThYqkRmCXnApKgNz634RGW8kdPG0IxSlUNrtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692191188; x=1692795988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8LN8kLzzLczsPbdJAMvHHgeSuXAc6gkdKeWAaN4L44=;
        b=VnRKGjwY4GHTu+i5Pw38aVgwFfMhbmFps3RXEalI0kirbUWrxwaBgyThcTw38GMtNj
         dICTIXupFySuVUOE6pIHjyfCxSK3S7kdb+9aFBEa00NxXjPCYw1iKcekgEnrAE2u1Ycm
         GP3aVeBCPcDjkN6SkAvevX1iLFq03SP+O7tPVqEbTTt/p+7EE5IWQbMM94T7K54+bpRz
         c6WltEoW6gTnjWT0KL6SJ7H+rRuiL51Falng4BPhZZ/s1r8N9teDUuhVDg1Ev4XCkhXX
         urz95rSwQhd3/PcmUhAXKwmjlYXS+b+wOKlpCWmYPsobm6l044zrJ5Dc3+kaNv2MUewC
         vQ4Q==
X-Gm-Message-State: AOJu0YzCgt2V4uFyPSIPDo2CSvgpz6jpr7HfKKxfzxPNrNrJVmk6nh7k
        Y7rKU83xjKupiAvuXx8aO05SiQ==
X-Google-Smtp-Source: AGHT+IHt1aDr1VoKfxePkEnb6zzzgPARwvGN/v1bEnHZCx6EPswEzl0KK3MUVtKBqWM4wh9HYw4Mrg==
X-Received: by 2002:a17:90b:3741:b0:25e:d727:6fb4 with SMTP id ne1-20020a17090b374100b0025ed7276fb4mr1198090pjb.2.1692191188228;
        Wed, 16 Aug 2023 06:06:28 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id y11-20020a170902700b00b001b89b7e208fsm13106575plk.88.2023.08.16.06.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 06:06:27 -0700 (PDT)
Date:   Wed, 16 Aug 2023 22:06:23 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Tomasz Figa <tfiga@chromium.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: kconfig: list unknown symbols in the old .config
Message-ID: <20230816130623.GI907732@google.com>
References: <20230816124221.GH907732@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816124221.GH907732@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/16 21:42), Sergey Senozhatsky wrote:
> Hi,
> 
> We recently were hit (unnecessarily hard) when after kernel uprev we
> figured that something wasn't working. The root cause was a rename of
> the CONFIG_FOO option between kernel releases, which make oldconfig
> doesn't warn/notify about.
> 
> Would it be possible to add either a new --listunknown mode to conf or
> to somehow make it conf_warning("unknown symbol: %s\n", line) when it
> reads a line from oldconf that it cannot sym_find()?
> 
> That would save a ton of time.

So I have this simple (quick-n-dirty) patch, that seem to be doing
the trick. Just to show the idea.

Running `make listunknown` produces the following (on a hand-crafted
.config):

.config:6:warning: unknown symbol: CONFIG_DISABLE_BUGS
.config:7:warning: unknown symbol: CONFIG_COMPILE_GOOD_CODE_ONLY
make[2]: *** [scripts/kconfig/Makefile:77: listunknown] Error 1
...

---

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 33d19e419908..37b777a0848c 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -36,6 +36,7 @@ enum input_mode {
 	yes2modconfig,
 	mod2yesconfig,
 	mod2noconfig,
+	listunknown,
 };
 static enum input_mode input_mode = oldaskconfig;
 static int input_mode_opt;
@@ -683,6 +684,7 @@ static const struct option long_opts[] = {
 	{"yes2modconfig", no_argument,       &input_mode_opt, yes2modconfig},
 	{"mod2yesconfig", no_argument,       &input_mode_opt, mod2yesconfig},
 	{"mod2noconfig",  no_argument,       &input_mode_opt, mod2noconfig},
+	{"listunknown",  no_argument,       &input_mode_opt, listunknown},
 	{NULL, 0, NULL, 0}
 };
 
@@ -712,6 +714,7 @@ static void conf_usage(const char *progname)
 	printf("  --yes2modconfig         Change answers from yes to mod if possible\n");
 	printf("  --mod2yesconfig         Change answers from mod to yes if possible\n");
 	printf("  --mod2noconfig          Change answers from mod to no if possible\n");
+	printf("  --listunknown           List symbols that are not recognized anymore\n");
 	printf("  (If none of the above is given, --oldaskconfig is the default)\n");
 }
 
@@ -823,6 +826,12 @@ int main(int ac, char **av)
 			exit(1);
 		}
 		break;
+	case listunknown:
+		if (conf_read_listunknown())
+			exit(1);
+		else
+			exit(0);
+		break;
 	default:
 		break;
 	}
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 992575f1e976..d70cd3b034e1 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -341,64 +341,113 @@ static ssize_t compat_getline(char **lineptr, size_t *n, FILE *stream)
 	return -1;
 }
 
-int conf_read_simple(const char *name, int def)
+static FILE *open_conf_file(const char *name)
 {
-	FILE *in = NULL;
-	char   *line = NULL;
-	size_t  line_asize = 0;
-	char *p, *p2;
-	struct symbol *sym;
-	int i, def_flags;
+	char *env, *p;
+	FILE *in;
 
-	if (name) {
-		in = zconf_fopen(name);
-	} else {
-		char *env;
+	if (name)
+		return zconf_fopen(name);
 
-		name = conf_get_configname();
-		in = zconf_fopen(name);
-		if (in)
-			goto load;
-		conf_set_changed(true);
+	name = conf_get_configname();
+	in = zconf_fopen(name);
+	if (in)
+		return in;
 
-		env = getenv("KCONFIG_DEFCONFIG_LIST");
-		if (!env)
-			return 1;
+	conf_set_changed(true);
 
-		while (1) {
-			bool is_last;
+	env = getenv("KCONFIG_DEFCONFIG_LIST");
+	if (!env)
+		return NULL;
 
-			while (isspace(*env))
-				env++;
+	while (1) {
+		bool is_last;
 
-			if (!*env)
-				break;
+		while (isspace(*env))
+			env++;
 
-			p = env;
-			while (*p && !isspace(*p))
-				p++;
+		if (!*env)
+			break;
 
-			is_last = (*p == '\0');
+		p = env;
+		while (*p && !isspace(*p))
+			p++;
 
-			*p = '\0';
+		is_last = (*p == '\0');
 
-			in = zconf_fopen(env);
-			if (in) {
-				conf_message("using defaults found in %s",
-					     env);
-				goto load;
-			}
+		*p = '\0';
 
-			if (is_last)
-				break;
+		in = zconf_fopen(env);
+		if (in) {
+			conf_message("using defaults found in %s",
+				     env);
+			return in;
+		}
+
+		if (is_last)
+			break;
+		env = p + 1;
+	}
+
+	return NULL;
+}
+
+int conf_read_listunknown(void)
+{
+	FILE *in = NULL;
+	char *line = NULL;
+	size_t line_asize = 0;
+	char *p, *p2;
+	struct symbol *sym;
 
-			env = p + 1;
+	conf_filename = conf_get_configname();
+	in = open_conf_file(conf_filename);
+	if (!in)
+		return 1;
+
+	conf_warnings = 0;
+	while (compat_getline(&line, &line_asize, in) != -1) {
+		conf_lineno++;
+		sym = NULL;
+		if (line[0] == '#')
+			continue;
+
+		if (memcmp(line, CONFIG_, strlen(CONFIG_)) == 0) {
+			p = strchr(line + strlen(CONFIG_), '=');
+			if (!p)
+				continue;
+			*p++ = 0;
+			p2 = strchr(p, '\n');
+			if (p2) {
+				*p2-- = 0;
+				if (*p2 == '\r')
+					*p2 = 0;
+			}
+
+			sym = sym_find(line + strlen(CONFIG_));
+			if (!sym)
+				conf_warning("unknown symbol: %s", line);
 		}
 	}
+
+	free(line);
+	fclose(in);
+	return conf_warnings;
+}
+
+int conf_read_simple(const char *name, int def)
+{
+	FILE *in = NULL;
+	char   *line = NULL;
+	size_t  line_asize = 0;
+	char *p, *p2;
+	struct symbol *sym;
+	int i, def_flags;
+
+	in = open_conf_file(name);
 	if (!in)
 		return 1;
 
-load:
 	conf_filename = name;
 	conf_lineno = 0;
 	conf_warnings = 0;
diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index edd1e617b25c..d76faaec120a 100644
--- a/scripts/kconfig/lkc_proto.h
+++ b/scripts/kconfig/lkc_proto.h
@@ -5,6 +5,7 @@
 void conf_parse(const char *name);
 int conf_read(const char *name);
 int conf_read_simple(const char *name, int);
+int conf_read_listunknown(void);
 int conf_write_defconfig(const char *name);
 int conf_write(const char *name);
 int conf_write_autoconf(int overwrite);
