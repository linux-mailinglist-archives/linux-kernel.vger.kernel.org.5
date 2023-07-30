Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1ECD76845C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 10:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjG3IFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 04:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjG3IFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 04:05:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19BC1FDD
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 01:05:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-317716a4622so3253169f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 01:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690704332; x=1691309132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQqVrg2AxkeCUd4RFlnJm2NAddhvnsPrl7tjyYt2XYM=;
        b=5okC5Aj5PW/3arYaXCw8luJS22Yb5F6prA74ByuC2wrv64Nul77hf1IiiKHS+AHfHv
         pwzEpdsZzeTTUl4h5YJJY+JXF+pVkN6HGor5AR84ZVYKB/pyahJwFxeVoK86OsQnmRxQ
         uIBgIAiA1ZSm2zPtAuRjrO++fNIa8HqbvAwEUAURfjL3w8o8G8IVpnv8z+ob3cJLnifw
         LMb/EVXGuUYXQVIdlBKwGFCYIRzJDgF+l6X9G+iahb3o0DbrWKUWCnNZfx+NVhFXzqpz
         kOnOXVeSo3AHMjmKaJnm0qr+zIGfCVTYUvHWQ1sBUsbj+ARrYj2A06X7lwjUIsZBJRjp
         YH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690704332; x=1691309132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQqVrg2AxkeCUd4RFlnJm2NAddhvnsPrl7tjyYt2XYM=;
        b=VMQBzZ6rnd83Qxv872+DCncvu6QPWxgnBJbSwh5UdBINF8+1suppq6tiRwkl4/eSfj
         8DLc1V5jqpw1YLqIWP+ieGvBxT04IO+R8GCT76/YqHYEUHRSKD8iocUZTG2XX1tde1re
         jkwnL8XnMOlsxBNWVvRSElDgAIDwECIp5/1x1i1MwOV/Sd0vgA9N/nPf7RTcB3Z2KVZG
         v+HHVY+xr/vNERDfoZ52lPBBnxDalw1iUVAAUeZX1NCVGdU0jQYupfoOlkxwLd4Ho+Au
         NXERZeeHnPD7Eg199hrSLXln07zM/5iO+AuJxmscIXvoiGOJ2/H/pqCsjLXrrNSSFy9D
         c9Ew==
X-Gm-Message-State: ABy/qLYJnSfk2hH5aVCgoNdH26LVOwZiesSR4YhuCTVJoEdAeQX74V+V
        t2vBVi3DACVvGrCxGfxK7llA7Q==
X-Google-Smtp-Source: APBJJlHEPEWmqkF8H1Jaf/ZUug/vBvFFXwfcGvYuIotJ4EKrCxaBKVGHH9AWj97g80VWeLeGnmpgNg==
X-Received: by 2002:a05:6000:10cc:b0:314:5376:f0d6 with SMTP id b12-20020a05600010cc00b003145376f0d6mr4543789wrx.52.1690704332551;
        Sun, 30 Jul 2023 01:05:32 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b0031766e99429sm9338684wrq.115.2023.07.30.01.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 01:05:32 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Sun, 30 Jul 2023 10:05:16 +0200
Subject: [PATCH net-next 2/4] selftests: mptcp: join: colored results
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230730-upstream-net-next-20230728-mptcp-selftests-misc-v1-2-7e9cc530a9cd@tessares.net>
References: <20230730-upstream-net-next-20230728-mptcp-selftests-misc-v1-0-7e9cc530a9cd@tessares.net>
In-Reply-To: <20230730-upstream-net-next-20230728-mptcp-selftests-misc-v1-0-7e9cc530a9cd@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3273;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=GmVKWSiJ8DZnxhxB0kl8fOaIodE+Lir7/6qs2cskk90=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkxhnJl4WfzchoILJExO3108dVUOzhC417y4x41
 Ms9Sy1JJvCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMYZyQAKCRD2t4JPQmmg
 c0RfD/9bXbfjLoHS4Im02miuggaUqtrL3Z7WfbT1oFymNnIWy/X85nEcnYNv1zPYiME1rwqEvkP
 4ASfCChFQ+JMjeTLm/6O8BNxxskGEie73qKVJxMzXWmyTT5Lxm+Hd2lXUGAgBkz0G5+KMy7eHWQ
 POjXUE49nIWQL8kRcczytUnHao6U+5hPVm8wjOyYOXzqBDfBIjzxA2LAueyCUiQCeEduLyQo7vI
 PT22O3CarBhZSrQ73E1SJWCICA4YX03+jqlxwupX7MQuQ8KyMQPNMt9EU6rQ0RDaGRvDzlxIE/E
 quhGBCBpC3Nae6cFyvaR5pBZD4ZbvUxBhucdHwywe2aRH7n18ZIjUv55oLgL8ZuJIy1x93C/eJO
 O0Ykqjn+xneDH0udWn1a406WP/m5GjkIDQP+YSjkVE/hLy1Sui3puJjPnxh+bdEIB1WScbi0MQm
 bUKVx8bToJ+TKrZK1YK3tDRd7iq3cRMwHmPVFzFED7pgMvudwoHY30pM1yJCavGmN87zQigCHMT
 IrzY/n8bPD7MFOrad9EpLPZBdjrUfGyOzlLCld+BsgSOUavc3NLc/+WHLV6QLA3UOtNvWQKoQd5
 H8cdRALxxUSW8f2GCnL7vBT8ruaI/VHJrhgdxMXnOgzhYaKBM5Ps0Lkh6n5PvoJk46/MSIgjzVr
 cVDX3+YVlI8n+Mg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to the parent commit, it is easy to change the output and add
some colours to help spotting issues.

The colours are not used if stdout is redirected or if NO_COLOR env var
is set to 1 as specified in https://no-color.org.

It is possible to force displaying the colours even if stdout is
redirected by setting this env var:

  SELFTESTS_MPTCP_LIB_COLOR_FORCE=1

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  8 ++---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 39 +++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6da3a6c98ba7..136d20641fce 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -215,22 +215,22 @@ print_info()
 	# It can be empty, no need to print anything then
 	[ -z "${1}" ] && return
 
-	printf "%-${nr_blank}sInfo: %s\n" " " "${*}"
+	mptcp_lib_print_info "      Info: ${*}"
 }
 
 print_ok()
 {
-	echo "[ ok ]${1:+ ${*}}"
+	mptcp_lib_print_ok "[ ok ]${1:+ ${*}}"
 }
 
 print_fail()
 {
-	echo "[fail]${1:+ ${*}}"
+	mptcp_lib_print_err "[fail]${1:+ ${*}}"
 }
 
 print_skip()
 {
-	echo "[skip]${1:+ ${*}}"
+	mptcp_lib_print_warn "[skip]${1:+ ${*}}"
 }
 
 # [ $1: fail msg ]
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index b1a0fdd0408b..92a5befe8039 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -4,10 +4,49 @@
 readonly KSFT_PASS=0
 readonly KSFT_FAIL=1
 readonly KSFT_SKIP=4
+
+# shellcheck disable=SC2155 # declare and assign separately
 readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
 
 MPTCP_LIB_SUBTESTS=()
 
+# only if supported (or forced) and not disabled, see no-color.org
+if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
+   [ "${NO_COLOR:-}" != "1" ]; then
+	readonly MPTCP_LIB_COLOR_RED="\E[1;31m"
+	readonly MPTCP_LIB_COLOR_GREEN="\E[1;32m"
+	readonly MPTCP_LIB_COLOR_YELLOW="\E[1;33m"
+	readonly MPTCP_LIB_COLOR_BLUE="\E[1;34m"
+	readonly MPTCP_LIB_COLOR_RESET="\E[0m"
+else
+	readonly MPTCP_LIB_COLOR_RED=
+	readonly MPTCP_LIB_COLOR_GREEN=
+	readonly MPTCP_LIB_COLOR_YELLOW=
+	readonly MPTCP_LIB_COLOR_BLUE=
+	readonly MPTCP_LIB_COLOR_RESET=
+fi
+
+# $1: color, $2: text
+mptcp_lib_print_color() {
+	echo -e "${MPTCP_LIB_START_PRINT:-}${*}${MPTCP_LIB_COLOR_RESET}"
+}
+
+mptcp_lib_print_ok() {
+	mptcp_lib_print_color "${MPTCP_LIB_COLOR_GREEN}${*}"
+}
+
+mptcp_lib_print_warn() {
+	mptcp_lib_print_color "${MPTCP_LIB_COLOR_YELLOW}${*}"
+}
+
+mptcp_lib_print_info() {
+	mptcp_lib_print_color "${MPTCP_LIB_COLOR_BLUE}${*}"
+}
+
+mptcp_lib_print_err() {
+	mptcp_lib_print_color "${MPTCP_LIB_COLOR_RED}${*}"
+}
+
 # SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
 # features using the last version of the kernel and the selftests to make sure
 # a test is not being skipped by mistake.

-- 
2.40.1

