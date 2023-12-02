Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AD4801E75
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 21:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjLBUZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 15:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjLBUZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 15:25:41 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E776BA8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 12:25:47 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-28659b38bc7so1750751a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 12:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701548747; x=1702153547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iWmTwjW3FnLpctM7BL1LmgQcPd+SHX+/bRvCSLNNvhU=;
        b=oaq+XIsh4I3Se+pEmLd6xYfDeHN+k+LYW7VLXSgBC8ii4lv8RuYuB84Zvv/Yq8I/Wi
         4BQyFHgkur102e+MuTRXVaPqfb1WvfJ7hkTLXIMLjPrGyqefTX5Bs9LMMWK8yd2qHVcm
         5EwNi2fM8DtOH+b7Rna8wtBxEdLeEwR0h4hQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701548747; x=1702153547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iWmTwjW3FnLpctM7BL1LmgQcPd+SHX+/bRvCSLNNvhU=;
        b=chagXhoNwLCOFN1xa3Nfnc0hbLPktgSIfylYOE0cvOahSMaFYB9SUtQ+6QItyqGrMo
         w5TdCk1AZO2sGhrCE+GVdY6DXMV3lCMB6MxJYJvHZyGqbqPCA9rR1ytPu5Wls0QtPTVF
         eOUcG6vv8wrnQTfdH1TDQYXgxNfVLG/0dsFIF0OIhfu6Iw7ViekjgUGOzpFaIUw/aQmp
         NgnOxuBMWDTcvqP/UUekGBW2JaCt6OdLwg050l8QyN+lKVZLNDauhr29dKUXo3Z6xHF8
         0UyGKiL3C01zbxTzKT26XLLmA2syWPN8CTpz++ALQD8AYlUlq3xwklF9HC8fQyEWGq3k
         op/Q==
X-Gm-Message-State: AOJu0Yy2+WPcXAJOqkw2YNu1DxImcI5MhlkYHDT4dX8tI2BEE5rg/O6b
        gr56FvpcNEZG+Oh0YTJKtBhSpQ==
X-Google-Smtp-Source: AGHT+IHetUDarX9T2ChHXvmUlsmJEsZNIHfoFI1u/mh+/0bCLi8FlhnaePtBtK7zgVVvE8EZ8UKZvg==
X-Received: by 2002:a17:90a:c7d7:b0:286:6cc0:caca with SMTP id gf23-20020a17090ac7d700b002866cc0cacamr1257532pjb.65.1701548747333;
        Sat, 02 Dec 2023 12:25:47 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id nu3-20020a17090b1b0300b002804c91633dsm5226023pjb.14.2023.12.02.12.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 12:25:46 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Michael Walle <mwalle@kernel.org>,
        Max Schulze <max.schulze@online.de>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] netlink: Return unsigned value for nla_len()
Date:   Sat,  2 Dec 2023 12:25:43 -0800
Message-Id: <20231202202539.it.704-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3148; i=keescook@chromium.org;
 h=from:subject:message-id; bh=zqo8NNuvyL3Qo2gExRi3IB5p0gfHuwCMkVKNBkSt50w=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBla5LGl8X7l/qpTOEDPnYi96YG0MitkUNkEC/FI
 A3j9Fe7zFKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWuSxgAKCRCJcvTf3G3A
 JgoaEACVG4dPOEdzCMFdjgjnjNsFP6YjpLhlh2wley6rzZtotKdVNy0AOydgKPjgS65AvnvUNXR
 /IRKgFRbhTx+RtBg3KsqDiB4ONUbRzPkQkz9n5xKKAuVOSI7E1EoH9swDwyTyIYcytqZvlHCc52
 onLfhraPURvpPAZiWQYbgTgKBND4TPOafYeZ/e5XY3EN5p+f3DMXHdbF7H/L9ZpfjveTb9trcf5
 tHkxZEgXMNxPmbazRN4Duy7HLLgRVO4HE1AHImH7eljQf9AYCaAZ1O6BHnLnkzHXRdLiLRMPEya
 DY4kIVbgWCmwlUGP+63nzrVNEWUxxzNb2PeM9nu3Odn8p1bFYNvPYUbRt+h5ShfeHkG6dXZ1/3m
 h9nCL0BfS5ry8Cu2vzeI5/95Js0bEHofGTADKawRIN0Tt7lhEX9dlW5yBQselzzpnCdj6xx//24
 DHvyEtf1oEmI5e++mC/JFIj0xDBzGur/AfXRCWfrZoEscEpHM/snfkGeyuyI0lc0mcRattkSc3P
 xSTQf57GcUHdUhCLkxXM7R5EjmirxJ1YI4F/U6JySq6hi9GPa6KEg/SILEDOc/SLq+YdIFY7m4K
 PT423H32ZacYrNJ8D3laZJlFDzDFasiRxGmOdH8j1BZ3U7e2iaKcNS/98PECi3YfBYz4ZRIz9sq
 3BBeuU0 dTrrwZVQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value from nla_len() is never expected to be negative, and can
never be more than struct nlattr::nla_len (a u16). Adjust the prototype
on the function. This will let GCC's value range optimization passes
know that the return can never be negative, and can never be larger than
u16. As recently discussed[1], this silences the following warning in
GCC 12+:

net/wireless/nl80211.c: In function 'nl80211_set_cqm_rssi.isra':
net/wireless/nl80211.c:12892:17: warning: 'memcpy' specified bound 18446744073709551615 exceeds maximum object size 9223372036854775807 [-Wstringop-overflow=]
12892 |                 memcpy(cqm_config->rssi_thresholds, thresholds,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
12893 |                        flex_array_size(cqm_config, rssi_thresholds,
      |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
12894 |                                        n_thresholds));
      |                                        ~~~~~~~~~~~~~~

A future change would be to clamp the subtraction to make sure it never
wraps around if nla_len is somehow less than NLA_HDRLEN, which would
have the additional benefit of being defensive in the face of nlattr
corruption or logic errors.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311090752.hWcJWAHL-lkp@intel.com/ [1]
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Max Schulze <max.schulze@online.de>
Cc: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 v2:
 - do not clamp return value (kuba)
 - adjust NLA_HDRLEN to be u16 also
 v1: https://lore.kernel.org/all/20231130200058.work.520-kees@kernel.org/
---
 include/net/netlink.h        | 2 +-
 include/uapi/linux/netlink.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 83bdf787aeee..7678a596a86b 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1200,7 +1200,7 @@ static inline void *nla_data(const struct nlattr *nla)
  * nla_len - length of payload
  * @nla: netlink attribute
  */
-static inline int nla_len(const struct nlattr *nla)
+static inline u16 nla_len(const struct nlattr *nla)
 {
 	return nla->nla_len - NLA_HDRLEN;
 }
diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
index f87aaf28a649..270feed9fd63 100644
--- a/include/uapi/linux/netlink.h
+++ b/include/uapi/linux/netlink.h
@@ -247,7 +247,7 @@ struct nlattr {
 
 #define NLA_ALIGNTO		4
 #define NLA_ALIGN(len)		(((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
-#define NLA_HDRLEN		((int) NLA_ALIGN(sizeof(struct nlattr)))
+#define NLA_HDRLEN		((__u16) NLA_ALIGN(sizeof(struct nlattr)))
 
 /* Generic 32 bitflags attribute content sent to the kernel.
  *
-- 
2.34.1

