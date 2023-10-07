Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8607BC9F5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 23:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344185AbjJGVin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 17:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344151AbjJGVil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 17:38:41 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD74C93
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 14:38:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5347e657a11so5518048a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 14:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696714719; x=1697319519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+I/45KrjHN3ZeY3XR2SSNQX+9zJsoPF88BTVLY4S8EE=;
        b=Sw+q1/2x1HYyQr99wb1xt3xZSF7eMDlxzvo6EDz60hMXvCHOm4jCFl+v+/a4mBN5jZ
         z6OKO9C+4rsTsHXDhtmNywlyQ4OOgyy1vKzl4hhxJjG/zP4cZgojQT7qPwJfhk3+l9yY
         H7l49XSK6/h2sVZ6PbDR7Fd4J3pEN1jQiyqmYemZPd+sgNFrzDohDrFt4f3AnAjJF4VZ
         fJTbhWkdoX7BBw/qKYXTeQYPZyZ50/VSZj6WpHGjFvbnDmQJJjABaaLcfxtT3nSCvs46
         Cnh/MBAyIqyA5JHp6KyZty5571NHTKhZah1mgUHQ9Fq3m9sq9U8ZUcb/6UsAO8p/dr9P
         HWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696714719; x=1697319519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+I/45KrjHN3ZeY3XR2SSNQX+9zJsoPF88BTVLY4S8EE=;
        b=hY6cEEYAWidKY0jo8d/Wewv3EB+IB9PBanbiS2fqGMesGQ3AebjheCv5TwmkbZYEli
         sN4NYLmic2QHuyUBWuWBlCqUEy8HVQx1vHA2Qm6rzXRcFq4bDJpCWfQsTymPcWQdYj42
         Nn2OSmzdm6btCEFLAVmVuGWB/RF7L+soulisgMX9Zk/It4bqFvrLVSwfTx8QAL5EI+vK
         T/72XU6u4ca1JsoQIufy/maVcjCkr1I+RPiMlv+H53KJf1zeaOyqgv2uV/fV6gaEmixb
         9Kp1S4+U/YZ8SbshHrzGOaxgNAOKL6tB+DzJrxnw7v+ga7ZfbNWDvV1eIvpXEJse3D6H
         EDgg==
X-Gm-Message-State: AOJu0Yxr1KAaXUdyn+2kkB+5P99NMIqfs/r7fl4z3+rPRA8kpoK9ieKK
        5qz/NxZdL3kD7NqlXGTc0SM=
X-Google-Smtp-Source: AGHT+IEm65+9UiTL7QBI6KanJVCoMNLDB1gai1TEEGtv70vmFAuFPNm7Zmwz6Sd2yjaWzE3L7L+Z1Q==
X-Received: by 2002:aa7:dac3:0:b0:52b:d169:b382 with SMTP id x3-20020aa7dac3000000b0052bd169b382mr9888941eds.29.1696714718736;
        Sat, 07 Oct 2023 14:38:38 -0700 (PDT)
Received: from dell.intranet (77-255-201-154.dynamic.inetia.pl. [77.255.201.154])
        by smtp.gmail.com with ESMTPSA id w15-20020aa7cb4f000000b0052a063e52b8sm4269087edt.83.2023.10.07.14.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 14:38:38 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] ASoC: ti: ams-delta: Fix cx81801_receive() argument types
Date:   Sat,  7 Oct 2023 23:38:18 +0200
Message-ID: <20231007213820.376360-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since types of arguments accepted by tty_ldis_ops::receive_buf() have
changed, the driver no longer builds.

.../linux/sound/soc/ti/ams-delta.c:403:24: error: initialization of 'void (*)(struct tty_struct *, const u8 *, const u8 *, size_t)' {aka 'void (*)(struct tty_struct *, const unsigned char *, const unsigned char *, unsigned int)'} from incompatible pointer type 'void (*)(struct tty_struct *, const u8 *, const char *, int)' {aka 'void (*)(struct tty_struct *, const unsigned char *, const char *, int)'} [-Werror=incompatible-pointer-types]
  403 |         .receive_buf = cx81801_receive,

Fix it.

Fixes: e8161447bb0c ("tty: make tty_ldisc_ops::*buf*() hooks operate on size_t")
Fixes: 892bc209f250 ("tty: use u8 for flags")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 sound/soc/ti/ams-delta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index 371943350fdf..666057d50ea0 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -336,8 +336,8 @@ static void cx81801_hangup(struct tty_struct *tty)
 }
 
 /* Line discipline .receive_buf() */
-static void cx81801_receive(struct tty_struct *tty, const u8 *cp,
-		const char *fp, int count)
+static void cx81801_receive(struct tty_struct *tty, const u8 *cp, const u8 *fp,
+			    size_t count)
 {
 	struct snd_soc_component *component = tty->disc_data;
 	const unsigned char *c;
-- 
2.42.0

