Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B307D79D627
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbjILQWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbjILQWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:22:32 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C8F10D;
        Tue, 12 Sep 2023 09:22:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bcf2de59cso742652166b.0;
        Tue, 12 Sep 2023 09:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694535747; x=1695140547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XfZpeOfcmkjD2RwkOI7LjaIvRtoKYYK0xNqzXUjc4kk=;
        b=abw1/11LkpA+ahNq+QaCbGTyb+ulw1ZRMK8JIyKxofIhSF5S2nR3zltBMQPwW2Cu1t
         Ano/Ay2vIt6FrvNP1Uv06Jmi+V7BoJJpD6BBTR7cXYW5nEos1UPMR3RrgJp9jIPKbjag
         L9scuWC0xflqmCPAmWxXNVpEyOFnjA/7Yi1ahDC6gUYn3NcD6gcJ/daMjiyWK9rwwfL6
         0ERnZrcBuhPH+kcfqqUqu1pm4bHfNkxGDXa0oFa8NueBqEXzpfH/8Gdc5Kw3Bjg9M7oB
         3dkeXP7PcAfcJU8/2bt+V3GDBimh7uY00pwJdDESr3oAMDLkPtcFnh9SEnOgJ12m0zGQ
         OsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694535747; x=1695140547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfZpeOfcmkjD2RwkOI7LjaIvRtoKYYK0xNqzXUjc4kk=;
        b=ieIbETahCHZfsaNRK/dzYv0N2LngNu57OlXLvwjuhQ1mZOJSk+QDWyWyYQaw0GcUML
         HhIQ2VNXEFyU/WSzIzxV3boBq1m5IlchKEqzzu+SdLMLOPQGCDbpKM0bib29TJAHyag3
         1xaIWMj/UNSdRUhmKt4998pEu1vKHPpN1ZDoWJ6wQKjPLeVxgfA0gBQHAKObb9CMcZev
         ZfB+OT3PHXIpz+1bmcAAGxBv1sbZeJOuzyJAOnD0Kivy8WorFQQQ+2WISbHUtA1J3ZUu
         RvVCRG8XycGzzf7a8jSXRiRkvPfr5iQLUHPzGMziXY0OD/goCCi5XssbQoHvZ6Z8vBmN
         fBFw==
X-Gm-Message-State: AOJu0Yy1qB0i7xtiqFfWPANjXGzyLBFhvsHfPWwtCNl5Q3UICFdhs80K
        ztC8MFWOq2RsjIS/37psg+dsKUj1ww==
X-Google-Smtp-Source: AGHT+IG9TvD3z/xvZuFAqoVvxB1j1Q7YEwy8ygKiK8gg4f/Ylc0e34g1E+Ze0NmabQio29q2da8QFA==
X-Received: by 2002:a17:907:7791:b0:9a9:e41c:bcb6 with SMTP id ky17-20020a170907779100b009a9e41cbcb6mr11465182ejc.28.1694535746774;
        Tue, 12 Sep 2023 09:22:26 -0700 (PDT)
Received: from p183 ([46.53.254.179])
        by smtp.gmail.com with ESMTPSA id d11-20020a1709064c4b00b00993004239a4sm6998179ejw.215.2023.09.12.09.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 09:22:26 -0700 (PDT)
Date:   Tue, 12 Sep 2023 19:22:24 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org, keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-hardening@vger.kernel.org, David.Laight@aculab.com
Subject: [PATCH v3 1/2] uapi: fix __DECLARE_FLEX_ARRAY for C++
Message-ID: <97242381-f1ec-4a4a-9472-1a464f575657@p183>
References: <930c3ee5-1282-40f4-93e0-8ff894aabf3a@p183>
 <a0c3a352-89c6-4764-b377-f55a68a1b2cb@p183>
 <202309080848.60319AF@keescook>
 <f1819874-2b91-4983-9ebe-6cd83d5d3bc3@p183>
 <202309080910.44BB7CEF@keescook>
 <e364b36eefa049d8863c1c1001018636@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e364b36eefa049d8863c1c1001018636@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__DECLARE_FLEX_ARRAY(T, member) macro expands to

	struct {
		struct {} __empty_member;
		T member[];
	};

which is subtly wrong in C++ because sizeof(struct{}) is 1 not 0,
changing UAPI structures layouts.

This can be fixed by expanding to

	T member[];

Now g++ doesn't like "T member[]" either, throwing errors on
the following code:

	struct S {
		union {
			T1 member1[];
			T2 member2[];
		};
	};

or

	struct S {
		T member[];
	};

Use "T member[0];" which seems to work and does the right thing wrt
structure layout.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Fixes: 3080ea5553cc ("stddef: Introduce DECLARE_FLEX_ARRAY() helper")
---

 include/uapi/linux/stddef.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -29,6 +29,11 @@
 		struct TAG { MEMBERS } ATTRS NAME; \
 	}
 
+#ifdef __cplusplus
+/* sizeof(struct{}) is 1 in C++, not 0, can't use C version of the macro. */
+#define __DECLARE_FLEX_ARRAY(T, member)	\
+	T member[0]
+#else
 /**
  * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
  *
@@ -45,6 +50,7 @@
 		TYPE NAME[]; \
 	}
 #endif
+#endif
 
 #ifndef __counted_by
 #define __counted_by(m)
