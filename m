Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434247AD042
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjIYGgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjIYGgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:36:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E057E8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 23:35:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c240e637aso111505727b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 23:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695623755; x=1696228555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bcrp0ZXERhmGEwBm/uzVnD0KZhCDXIgRvCKxEA2CEAk=;
        b=ZYoPrP7prgqoMG+F/VdEmJgvQfssIWp+3Za1kea+ThT7jy5rWM8NP7QgrALyluSX1S
         Z+C9wuMAle2wGCIG2SGs9b0B5VlzDwncbNwaUKPp1gTxPnPMpf3186EnzuGmOSvT+oGq
         Rwf5Vf3Az28gEdHO5TDo++mrUy5MmWKAtN/1MZJq3GT0tPx76Paq5tWRsYnug7B8CLga
         y6kkMQtRMeRUk0eID7Hpp1RfdesMjjvSgK9X7o3+eI/S+C35qj2kzHAVaij5OYn0OL8T
         J/1OGrMCjsrifafySkxBnU+TQk90vyT8Q5EfzRX67R+iNS08QZiSuBkRV+pVy39SmHaW
         Ibxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695623755; x=1696228555;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bcrp0ZXERhmGEwBm/uzVnD0KZhCDXIgRvCKxEA2CEAk=;
        b=ssrv7EPe3MNNreM209+f4Dn5um4GoYHKAalJvmyoiY49AC2l2KdbMlebn+fBoOEAe0
         Gw2nN/cleS1JFUwaOlObmYaqzvgdTfONy+jF9FczbcZWMJT52U7ikGhVDVm3NAobKpQr
         ssylow0gf/nhDmOKdbAt+EkcmtNgpR+O7FqMs2SRJdBxBQ4MdLffqtph4cm9vzfk0Ich
         yQx3gJJXgHb0oe9QfN3G5YSpdBTkYb/G/Pwp9tCE2s0VJ6p329SkkwJcbJ9Y5P2sLTAV
         mdoqaelk5E7m59vT0uUb89rd90ghcWr4rwlq7K/yscBgRs5p9FESmmubVCCT4LBXPihT
         nZcg==
X-Gm-Message-State: AOJu0YywFwsSEh6aksWS0qaPfE/7iz+HoY/BmTdHWf/TGBwGSwg2Kjcc
        RT/BMsxHNmOzakZ51MFnxtvHiN15ttzmFdYnsQ==
X-Google-Smtp-Source: AGHT+IEL+v1AKm/ankIjajUpkORjZ9CG55V363ptxL+fCbeQnS97/LMJgSUav90kcBtnIjOjc2USO1BqtT7+Ykf+5g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:ac17:0:b0:59b:ec33:ec70 with SMTP
 id k23-20020a81ac17000000b0059bec33ec70mr62785ywh.6.1695623755612; Sun, 24
 Sep 2023 23:35:55 -0700 (PDT)
Date:   Mon, 25 Sep 2023 06:35:54 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEkqEWUC/x3MQQqDQAwAwK9Izg3olqL1K9LDNkk1B7dLIqKIf
 3fxOJc5wMVUHPrqAJNVXf+poHlUQFNMo6ByMYQ6POt3eKEvlijvyKarmOPMyDOS7XlBQo5tw13 77YgJypFNfrrd//A5zwsvv404bwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695623754; l=1489;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=JzUgrhuHr9AIb+fIgjCoX4OAuDxhGR+xHWRbaTpyl7I=; b=sT93N+bGfSIOi1sfnFt85uF+GI0tMjBiB+kioUutRn1Sju1ssa2QNCZUqxcrTzj+gGFqgTzPt
 +W7ks6UvmCLDpC5diuhueOkl7nJyKmMWRREAquuJd6gWCqbGMqbJZEE
X-Mailer: b4 0.12.3
Message-ID: <20230925-strncpy-drivers-md-dm-crypt-c-v1-1-eef875e4f9b2@google.com>
Subject: [PATCH] dm crypt: replace open-coded kmemdup_nul
From:   Justin Stitt <justinstitt@google.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kzalloc() followed by strncpy() on an expected NUL-terminated string is
just kmemdup_nul(). Let's simplify this code (while also dropping a
deprecated strncpy() call [1]).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
Similar-to: https://lore.kernel.org/all/20230925-strncpy-drivers-hwmon-acpi_power_meter-c-v4-1-3bac7534f10f@google.com/
---
 drivers/md/dm-crypt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index f2662c21a6df..8a03b3590733 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2858,10 +2858,9 @@ static int crypt_ctr_auth_cipher(struct crypt_config *cc, char *cipher_api)
 	if (!start || !end || ++start > end)
 		return -EINVAL;
 
-	mac_alg = kzalloc(end - start + 1, GFP_KERNEL);
+	mac_alg = kmemdup_nul(start, end - start, GFP_KERNEL);
 	if (!mac_alg)
 		return -ENOMEM;
-	strncpy(mac_alg, start, end - start);
 
 	mac = crypto_alloc_ahash(mac_alg, 0, CRYPTO_ALG_ALLOCATES_MEMORY);
 	kfree(mac_alg);

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230925-strncpy-drivers-md-dm-crypt-c-da71d87b8cdc

Best regards,
--
Justin Stitt <justinstitt@google.com>

