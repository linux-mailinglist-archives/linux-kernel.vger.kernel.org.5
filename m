Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D357A119A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjINXVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjINXVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:21:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8B41A2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:21:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8186d705a9so1807347276.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694733667; x=1695338467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K4BixPSI6K4mFdvHjP22A4GYUb6n9IBpB9f1xvsMH7k=;
        b=e0wVhOi64Sny8sVdEfpPEtHTV/fR9FWnHmeddV0l9GMAD+uWOLQ28c5NA2LLbelWZY
         rnSuVIGuyPLYM6dYp90NOGyrr6qG541NgfPOuZO765/WJ3rsMCYKo4jUVYAOM3yEQGQM
         cwpQOaO09fXWFN93J+x3cO9Z5TTOLUE1TjySdUwTv3XJvyY7Sf+gFZ1e3afS52AAN3/l
         1o11N5J32JJ6k9M1h4uruNR+DBitlOaY66wwqf/zldspxmv2tLR1EFXPR++PShcg8aRt
         FSHYYjlh0JXoo+eqNl/jA3+vdsad+Tl0x10pcaUMtUy5Ilzkf5s9dTfE83UZIbg/mBqG
         +cQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694733667; x=1695338467;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K4BixPSI6K4mFdvHjP22A4GYUb6n9IBpB9f1xvsMH7k=;
        b=XFF+p7DWG9x8HzOYugHBAZ3OGwH4rgBVn38Er987Mn1OSCH9+L9syt8cEfsHhLHN2z
         eByrC4Z4vGbUc5eywfFNiTX4CkTANnlC1qt1x54eer9/8iFv3FwX4ehCxNJo73nQtMkC
         UQ8qUawU4l/bXeQkKCcBDXod3z2fcJiWK4z47+/7pXNXmwmWV09FJtJz8V1Jmpbx3gG/
         2KePy3S3GSgdLHq2f1ssVTAEhck1cIoyfnOtIxliPwGlQS/v8V+7k3GSWME16We+kjqx
         aSq91EUDrXcl5FhPD38mHl+3l9dOwvDz/gY3vDzIYjkUl04lKZ7iHKuRzXvSqbSBu1wE
         NDTQ==
X-Gm-Message-State: AOJu0Yxx/SSHtk4BPttY+SAo5KLIbkwz8nLzx8FXuIY+9sUSknZXDpqu
        P8p62vsNvI9qTau+0XK6anjCvXbB8RmL22/p7w==
X-Google-Smtp-Source: AGHT+IFq3p2ctNKfynOgDkjxwZcw+cwOO3eWZyDO7yA9WDMfkjmAMvoMpTDs7Uz247dBLv6Bmcx4o1fQfc3Tnq8V7A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a5b:cb:0:b0:d05:98ef:c16b with SMTP id
 d11-20020a5b00cb000000b00d0598efc16bmr208490ybp.5.1694733667417; Thu, 14 Sep
 2023 16:21:07 -0700 (PDT)
Date:   Thu, 14 Sep 2023 23:21:06 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGGVA2UC/x3NMQ7CMAxA0atUnrGUNAhRroIYQuJSD3UiG6Wgq
 ncnYnzL/zsYKZPBbdhBqbFxkQ5/GiAtUV6EnLthdGNwkz+jvVVS/WJWbqSGy7YWQX6utWyk0jD h1UUXZn/JU4jQQ1Vp5s9/cn8cxw+ObRsDdAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694733666; l=1418;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=EQqFhuW6eyqVcI+2qvkN1RrCgJ3Q+ZXalbGWG4ulzH0=; b=zl7/VHFqVwFRJkvIBYDgTR3z8vsBLvP/9HPrgIpXao92oev7YfIZMtLc+vTpq3+YfxHy/8tSV
 gQhyQ2VQBRIAJjn6FVAwdCVZDDTwvbnJgKbwaEimBGIqyZmsAX2qbOq
X-Mailer: b4 0.12.3
Message-ID: <20230914-strncpy-drivers-hwmon-ibmpowernv-c-v1-1-ba6b7f42c98c@google.com>
Subject: [PATCH] hwmon: (ibmpowernv) refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-hwmon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding since `buf` is already zero-initialized.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/hwmon/ibmpowernv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 594254d6a72d..57d829dbcda6 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -234,7 +234,7 @@ static int get_sensor_index_attr(const char *name, u32 *index, char *attr)
 	if (copy_len >= sizeof(buf))
 		return -EINVAL;
 
-	strncpy(buf, hash_pos + 1, copy_len);
+	strscpy(buf, hash_pos + 1, copy_len);
 
 	err = kstrtou32(buf, 10, index);
 	if (err)

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230914-strncpy-drivers-hwmon-ibmpowernv-c-80a03f16d93a

Best regards,
--
Justin Stitt <justinstitt@google.com>

