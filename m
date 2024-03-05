Return-Path: <linux-kernel+bounces-92734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6F0872517
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C982CB218EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC141111AD;
	Tue,  5 Mar 2024 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="QVNYraUf"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C11ED271
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658182; cv=none; b=pZGGRonJY9tN+bxBIm+/BGZHK60apNZlq8AqKVS3bDuAjdfcaiMKF8k/mytVB3HhxcVvLvkgjt30t8IJ4TILapOxWYCcbV9iQ2ct1gq563mq6odgWCcZ+kJJalb0lden80eFt6T8s8O6Jti6yAEHft5RfLGfa3D+Gb+ub4mvepE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658182; c=relaxed/simple;
	bh=Zw4l4xaElaLOEKj9OaYH5+Qm7U0Dl9t6Q4rKgJ0cWIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Tp9iz1m6xGf865gFLOaWQf6Mhn91Z2SZUmiNzKgJJ4qYtd0qD7/9WjMUd66tVO3nsBX9/EPxNm/1eud7v9MMbWvYvXzQMwjEQPLdNccP/xj98xVqS8i636/4mop9KflWLMAu11OWfC3lsbcob9QbNYXQcpOzbZCUyr7auaXU/9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=QVNYraUf; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d8b519e438so5498377a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 09:03:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709658180; x=1710262980;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akX53V2nVTjwCzZgOpVZs2PRh2jCa/bbbRZ+++4zsjI=;
        b=BHPEYvi2k2nH+ZZAba1e+s+6mUu+Cl2IiwljYFMpBr5rYVZ8C08wu56hmOvj71lRNo
         LGhwEIxastrBAPIbLHjHvfQgGwxxJs89VAoTojwbiopLUn8VGKZDmZFY0ECMvgXPJphA
         C7r3PNiaPGldSrfO47WgzQnvMx0r4luVNyq2b2rM6mx6RF2e9VJ9FFzUEC2HxM3xaG5F
         786wwZ/0gA4o4VZaXdyLY3QbVwND/i17A4aUAdNSmSERH3c0oAOfoWGpL1UaNVZreHvi
         StRNksHkW9IK21324rkUP5LAZqnKc3AKcBtd4Rd3mwPh2txITZmxGNYAtPDW+/seJFYA
         poYg==
X-Gm-Message-State: AOJu0YyFYBRZPYMoWzvBriv6hRgOT/SJqdmGhGKU9wQgxQarj7KUginn
	U73LAYdaTZDDNnp5aCeIwSeFj7EdiSmOxebKbjycwcYk0lvpLqLsrG0+rgg67IjLFw==
X-Google-Smtp-Source: AGHT+IF0BOHBEr+gD75pqjHKOZpIJ7xLLUKCELzzCNbGpIy4gZiT3m4T/TfykDLZEUUfYTon7Jsj6A==
X-Received: by 2002:a17:90a:9e4:b0:299:9d8:d7c9 with SMTP id 91-20020a17090a09e400b0029909d8d7c9mr10455754pjo.18.1709658179587;
        Tue, 05 Mar 2024 09:02:59 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id x7-20020a626307000000b006e624f5c866sm3799645pfb.145.2024.03.05.09.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 09:02:58 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709658177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=akX53V2nVTjwCzZgOpVZs2PRh2jCa/bbbRZ+++4zsjI=;
	b=QVNYraUfWzY9JikDkAyTT9+HAkEMcVUe2wyi11p3NoHodqT7Y7mhai7nFnnROvjGKbkD5w
	bjLo4oOisUO1peZck9qe/qdBwwLQFPACNVgQGhLFKXFYVq05vjXQkoBowJQOC3QCuKKKuP
	MTFuKnRyDjX8LHFhfeEO1wIhN3mDZY9zGov7ziGF5xdZTZQqEKY/OGMIjPAMk3mXHEn9q3
	T7yrcqIFN374uSFVBpEksPUkMgoOwSjSqX3NiakPSQEdHOnFDb9Hf8rfG4U9cQ7jpZUdES
	VfCoDYbnthob19/kqhBMVa8CkXiUA6vsQrbm22vOBOmyTKhJ6T75KcfD6x+ndg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 14:02:47 -0300
Subject: [PATCH] ktest: force $buildonly = 1 for 'make_warnings_file' test
 type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-ktest-v1-1-5a93b8b17dba@marliere.net>
X-B4-Tracking: v=1; b=H4sIADZQ52UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYwNT3eyS1OISXctUExNTI0NDo2RLYyWg2oKi1LTMCrA50bG1tQCvpup
 FVwAAAA==
To: Steven Rostedt <rostedt@goodmis.org>, 
 John Hawley <warthog9@eaglescrag.net>
Cc: linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=Zw4l4xaElaLOEKj9OaYH5+Qm7U0Dl9t6Q4rKgJ0cWIg=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl51A+VyMStt/A250BkvkEUc5nbKX8p5U4iJVSA
 GmuXw9l+IeJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZedQPgAKCRDJC4p8Y4ZY
 pjusD/9vbj2F/uTaiz6lulalDSSXTffWOTKqGDnbeV2uuWqjwm0KTKkFXttVztz9X9uea9m4l1k
 M7mPposY7wMrWxlfBl4OZff2K1NDf4ffA3vPcRagl+5jo0bOCxeLtQC60PoB4z6zoyEPv4D6DKR
 BV9M/PYGJGA6NLmdoPFTT+9KRiuD5DWJhKPoiygzu9oCTh1LQUNxgLro4+2LJaGzUf+7Qlhel+Z
 L5eueMrAfDW/iH9SCRQuJN2Y14IyBDzv1trEL799rWJKCZfZ9bPgWlypEhEMdMTXI8FE9SB7tYd
 +iDSr4Y5aivFmhoYOBoLJtXgdy5xCnFhDp2M3+3pyX1+51ESi0GDERm+ovTHafQUuJE/++/xl6X
 rm3gJl9cm6Yuzj8qw9rPQVN2+DWzNh3snFgfyf5FsdrQwZ9oue8WJp0Tpa/UmrkWBbVL9JxpGpp
 dNFzLFiF/ydIu8HgdpWD2hu0NZSh0vW8coW96b5L8drEZNkRvlb6pElBa1Qt3cotGpLXuwMMvW1
 zNtyDnj+7fKFmLwI8nKuygjBEf5czUfXhrwa6V/QtPrXko6OQg3Wh0tt0SuIvVA1kodV+N9bSgI
 XE1RpEMMLp/gkRv+4rZ6nu+WIlI+vk/Y7MO1BdM6EfTW4HJfUU0FZwKqZmgMAZmQMTsj81idRsQ
 MsJivGDaP4/yj5Q==
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
 tools/testing/ktest/ktest.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 829f5bdfd2e4..ab4bf87ba991 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -843,6 +843,7 @@ sub set_value {
     if ($lvalue =~ /^(TEST|BISECT|CONFIG_BISECT)_TYPE(\[.*\])?$/ &&
 	$prvalue !~ /^(config_|)bisect$/ &&
 	$prvalue !~ /^build$/ &&
+	$prvalue !~ /^make_warnings_file/ &&
 	$buildonly) {
 
 	# Note if a test is something other than build, then we

---
base-commit: 7e90b5c295ec1e47c8ad865429f046970c549a66
change-id: 20240305-ktest-9e4452112c93

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


