Return-Path: <linux-kernel+bounces-104575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 133F787D03E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E761C20F22
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4809A3D572;
	Fri, 15 Mar 2024 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="bduQWdkK"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F073C18EA8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710516497; cv=none; b=lwywElhO5mZEzF4xYCABEcILkQGmjMBShPX56zFK1uaxLvVEXekUCTnwmfH/xYcBVHgDl08F1ezdfAWxay2SVRAq/2UFVPn26pjCV+EDQSU8eVghDHwhtJvaMgzjy7GZslW5nCpUBbif5J1oIuOVSq0Lig9NspQbpGjar8gtMJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710516497; c=relaxed/simple;
	bh=HVfoK+Uh1up1JNb73t2crV+ULhV//F5/UUKtGoYgKNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ds8gNwf2s/tIlOS1QF8roqi4U4B7532XE2sou9FXoFUdOTrNBtBFeUtv7Wz6qd9WfOgc6TtSN3J3WsfCV8pTEeB+6esVTiXLTlc400JlKK9mOkgR+Pl0RAd+xCDpFzkBGuhTcvSvoN5UdlywVJ4yIV1V0/EfaOLjXLtmSKt5QuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=bduQWdkK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6ee9e3cffso1184237b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710516495; x=1711121295;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYG2Uz4R+YhaI6DjJkYLtaqN7Gdx2MEgWj2tFeh+CPM=;
        b=j+xwJwTijQqU7Y9o5ZYg27uRj96AwIZzM2ly1OYII7O02S8YIISJIvVTuf6i8cUKsm
         DwBtXHaIGP+0rSEKDKCgd0lQYQ1d3ed/dDU2YWbCrx6r+WVVT6FFyzssNRA5sraQP2BA
         HxMcek6pEk9onPn4yx3jjp4O66bu0HEq6khpGS2JuRFYARWOz6rn7mjSvm8CXW5QgUFR
         tmx96KWi0CNe/6oCDGVehPMEe3dePWmxtXa/W7ltfi5ebsHIj+4YXDSyRQVqNsSffzX4
         9YbI4BqnuMCD859t4PsyI6vJWiEXvFAJQ+c+rOcxSWxOhj63ZcfKzaRoJ3B/0CPuo17g
         NoKw==
X-Gm-Message-State: AOJu0Yyn8bb0fQc0C/0+p62nYINDbI8/vE7piZ2Dm2OssAz4DIk02DsB
	Fgtf6AG9xXzdc2wEv09hr9+UJZ92/b2qndpYhuUwmZ/6Xl8N/Gq/
X-Google-Smtp-Source: AGHT+IFpEMQdX9lZ8NJgqBKpDDKbaojWdLf5hPI6VqHhnjMQL7vDMbf3Js8aI6dSr2x5ghasGUc74A==
X-Received: by 2002:a05:6a20:9186:b0:1a3:48b9:9ff6 with SMTP id v6-20020a056a20918600b001a348b99ff6mr5541702pzd.7.1710516494936;
        Fri, 15 Mar 2024 08:28:14 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id g70-20020a636b49000000b005ceeeea1816sm2625315pgc.77.2024.03.15.08.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 08:28:14 -0700 (PDT)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1710516492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OYG2Uz4R+YhaI6DjJkYLtaqN7Gdx2MEgWj2tFeh+CPM=;
	b=bduQWdkK+qnbK97q8dqjO24Ae4HgrU+v28ozLnArILYjSXXMYwjpv40IM1FE/KB/F6ZqnF
	bMwYIWm8Gr0ONQm2I9tojKC3wYiYXU7LSU6cZBfiRqwiKWAFTNfZ8ZmK8VKP5GoKOoGd1u
	hF1AWbB32uoQBa7DzHqIwnbKzORKuQuDDfuqx237p/2fo/EcBAwLLpT3llKrU7brWvCi6i
	oXCevggRxdYwVGWhGbm1AkgN9NI6iWJkSDxw6mlaLVxF+O1w55SzwDBPIxpCqs0+EDqR/D
	GJfRDwz7xbEbZejOJN8FjPcPw2GyrAIi4CiZD2qLduQhZYpICGsID7yHM0lo2g==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Fri, 15 Mar 2024 12:28:08 -0300
Subject: [PATCH v2] ktest: force $buildonly = 1 for 'make_warnings_file'
 test type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-ktest-v2-1-c5c20a75f6a3@marliere.net>
X-B4-Tracking: v=1; b=H4sIAAdp9GUC/13MywrCMBCF4VcpszaSyQWNK99Dukja0Q5qK0kIS
 sm7G7t0+R8O3wqJIlOCU7dCpMKJl7mF2nUwTH6+keCxNSipjNTSinumlIUjY6xCVIPT0L6vSFd
 +b86lbz1xykv8bGzB3/ovFBQorHc6HAMexuDPTx8fTJH2M2Xoa61fEpzPlp0AAAA=
To: Steven Rostedt <rostedt@goodmis.org>, 
 John Hawley <warthog9@eaglescrag.net>
Cc: linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=HVfoK+Uh1up1JNb73t2crV+ULhV//F5/UUKtGoYgKNc=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl9GkJhmWKM+dPb79J+i0Bk0Od6G3bH2OgWu7Le
 fbqNIRKkC6JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZfRpCQAKCRDJC4p8Y4ZY
 plfeD/4vPpFvfANgw8MhLQL3FQdXWinhYKWRj+R821TFhP34TgdgLWF/AkO5EYdcZBhvCzayKGg
 Y1ARe41i4AfbrlWWYZcTMvXHgA2xXEWD6FvDazB5eyopU3dGRrilGh1zqFget22thhD/X6KiXLa
 Vo5vpL+NAH9rlO/ugDPEzlhTTXsY4GhhshllPSjOuZPoZTQKS33tsUIu/ydP5PpaEVTGK7g5WPx
 L7GG7VpxW1cMJyU8F2x02nwzyGY0LHP36Pqvngo/aZ7lp9JpjjaFiNaeSLtI/xxKErp4jjxHcsg
 3IopvlCKw4oGSWFbQnbAZjg+Bo3wu8gr5KmRZxQiXsT+yxJjXv1gyMmIyr52U50FrfFpTu8aWUQ
 CHDDq7zM3JyNdNaH4MpOMZIkJUEycpc2ZqdjWBv6SHtMPsc1GQbUjEAAR2h3TqxbwJMKo9pTs5M
 d0jCZ0pWyxloA9HkqacUh+xJ1XgAutMTQO+I9qi10hdWMNpUH++lGuB/F2oWQSch2iTKlw8Wb2f
 FHDM6ZaSuhIcgzFI+NecOC4aI2ywTDjlOBA71Hbj87dEdjBIUxDsRES867r4xJDllpb5S58BDZw
 mSQOSJ5UAPfNd+H6pctf819nb9mIGMwCFpe9bmifwQNWQe/tZyz+Cr5GKXH+p3lXD4thf66nofd
 iXgqXPPzGyIZz9g==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

The test type "make_warnings_file" should have no mandatory configuration
parameters other than the ones required by the "build" test type, because
its purpose is to create a file with build warnings that may or may not be
used by other subsequent tests. Currently, the only way to use it as a
stand-alone test is by setting POWER_CYCLE, CONSOLE, SSH_USER,
BUILD_TARGET, TARGET_IMAGE, REBOOT_TYPE and GRUB_MENU.

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
Changes in v2:
- Fixed the pattern to include EOL (\$), as requested.
- Link to v1: https://lore.kernel.org/r/20240305-ktest-v1-1-5a93b8b17dba@marliere.net
---
 tools/testing/ktest/ktest.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 829f5bdfd2e4..24451f8f4291 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -843,6 +843,7 @@ sub set_value {
     if ($lvalue =~ /^(TEST|BISECT|CONFIG_BISECT)_TYPE(\[.*\])?$/ &&
 	$prvalue !~ /^(config_|)bisect$/ &&
 	$prvalue !~ /^build$/ &&
+	$prvalue !~ /^make_warnings_file$/ &&
 	$buildonly) {
 
 	# Note if a test is something other than build, then we

---
base-commit: fe46a7dd189e25604716c03576d05ac8a5209743
change-id: 20240305-ktest-9e4452112c93

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


