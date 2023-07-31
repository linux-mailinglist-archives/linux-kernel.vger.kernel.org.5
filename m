Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48557699A1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjGaOg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjGaOgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:36:54 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9508114;
        Mon, 31 Jul 2023 07:36:52 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe078dcc3aso27898335e9.2;
        Mon, 31 Jul 2023 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690814211; x=1691419011;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kkutauyKjoRTiHe2v8gg+WoQKCC/QoPgB6R+1tXox7w=;
        b=S2lOACsHPoq/K3TkdXYZXYhbKcXiuZr/nJHIDR7CGG1gMwJdEE0+KqF4S+DBeWfIv6
         YxFmun5GCJ5KQvrrzUDifCqvjs48y1CQpnQhtkSaagJKedkS4gtYhtn/OozJe1fXNbPZ
         TYIFnv93z9vB9C2rjelHfj3USvw68zahWSqWW4ZMHS5uh0FuCFQGLgnA9MmqC/RB6GTr
         zRdPcarRP9TMxSop+z5Kvi8b1c0wMMAtqVe75u3Fdd+33/8pLlCyV6+sN+t7S42dmPE6
         kd7mVQZ54sUUA8he5Mcb1FMp8N4GF866zNEORIbAGNKHwH7s1IZ4eLTW5KAghUj3VODA
         FerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690814211; x=1691419011;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkutauyKjoRTiHe2v8gg+WoQKCC/QoPgB6R+1tXox7w=;
        b=HNCW18OXFdJVHdm1xs9fS+2elpCR9wIFr8wm+Xaqc1+xF4nrEoA51/8ljUcUv6X+tR
         w73HbDoMeC52xCsdMZh+3QsyuVO7hLqKbeS+BJMnw5WRkgFkBHHScAmgGDF4dgdRSlOL
         h+2YLi5PiLHT5B0f8KzZAb3z+Qqrb33Djynl4d43+PInwSVq+cyStvVjuG3Pm7KSvZ9u
         MX4eL+zXT4ggQizQoxzJYIcGX0c0/u28ex1Aw4lItfwtfOEbyA1bOYXtf4P1hr8F4F07
         df8krs/qYO4cNahR8Rp6ATAxCAObpvZgAOexFmoYA4cT0kvEJILG5qFLlDxBFzUXM/3i
         kj1A==
X-Gm-Message-State: ABy/qLZEiZQCCJ/xA8QSAYr3UgpDOWoz00RyeJeYDVNHDumsHierBpGE
        pZQgZn9fR6pcPJ37zTRkAsWJOk+W7Fp5bl7A
X-Google-Smtp-Source: APBJJlHIDNSihtiwGaHdnGOx8J+yb8SNvjkWYuZDkeg1iT6eBkExFBfpafmGRe38yVazvTRWu78jVw==
X-Received: by 2002:a05:600c:3653:b0:3fe:2219:9052 with SMTP id y19-20020a05600c365300b003fe22199052mr116610wmq.18.1690814210754;
        Mon, 31 Jul 2023 07:36:50 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.45.217])
        by smtp.gmail.com with ESMTPSA id g22-20020a7bc4d6000000b003fe1cdbc33dsm4650528wmk.9.2023.07.31.07.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 07:36:50 -0700 (PDT)
Date:   Mon, 31 Jul 2023 19:36:47 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     ztarkhani@microsoft.com, alison.schofield@intel.com,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lsm: add comment block for security_sk_classify_flow LSM hook
Message-ID: <ZMfG/w5FWqCGE4pn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

security_sk_classify_flow LSM hook has no comment block. Add a comment
block with a brief description of LSM hook and its function parameters.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 security/security.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/security.c b/security/security.c
index d5ff7ff45b77..ffc5519e49cd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4396,6 +4396,13 @@ void security_sk_clone(const struct sock *sk, struct sock *newsk)
 }
 EXPORT_SYMBOL(security_sk_clone);
 
+/**
+ * security_sk_classify_flow() - Set a flow's secid based on socket
+ * @sk:  original socket
+ * @flic: target flow
+ *
+ * Set the target flow's secid to socket's secid.
+ */
 void security_sk_classify_flow(struct sock *sk, struct flowi_common *flic)
 {
 	call_void_hook(sk_getsecid, sk, &flic->flowic_secid);
-- 
2.34.1

