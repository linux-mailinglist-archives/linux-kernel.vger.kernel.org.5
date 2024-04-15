Return-Path: <linux-kernel+bounces-145379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612C38A5567
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931511C221D4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BE371B32;
	Mon, 15 Apr 2024 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YtBpYTUZ"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861D81D52B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192244; cv=none; b=i7URrc8gqVVGpZeN3NLCBESYlU3LZU/6dqMJRL6cNwL3y/U56yGerETWSueRoV08bx084LyIF89irKNrUkC4KTf0sJwBBIRCUbJ2/qG5LV/WE7Kr1ly888P5b8qx2iDVG/Xzaz1s6bJLwgsnZQJlzgS5XAWA2qau73gV/agSZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192244; c=relaxed/simple;
	bh=KehpfQl+nFVwyeBbKTZT+XW0EbxiUmM5b6iOnH+si1k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=thii35psp6ZFwtBtLmAdo3IA/hDR/Vg7/tN0xQ3agkOqGrCZuMO8pT6nZyO24lJWJcHRaJg/ShtVKED7jWG33NMn0Dg+oLuueYIw21qbS9Nnxr92lLbbvkH2RyJXN0IPDP4OTiNGLPIPdKe2UCriSMNy31TUnV0n5K9WeWlTdyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YtBpYTUZ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-41634d6c008so10896105e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713192241; x=1713797041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0bmcD1dsKmxdOPG1Zb6XlpeF2OhOoXu9RprsqunU6bk=;
        b=YtBpYTUZMBbri/hmJ5zxlLFpf7YBqdISk+18XFkh+nFFjaeOsNfXfLmswIdU8UnoTh
         EVO8YaKQSjN3PFoQNbplnaPRLqFMAR3mrmU8WaDBB+TDSxrbTZIAk+8jm1sj3fG6WItn
         j7V70Y2siCesj6mcdo187WBOJrcfVLu4RfImvEve8vkia11SQLFgUvV32fU1n++XMpj1
         oiHeYUG6mt5rVtjF8hkj7RHxl6pZCMOrlkUDvT47lP0WcXqc9XXygNmry8PUyPOSO6wk
         iJckUWhfXJazU5/LGqfFaj0pjm5gL+ideoyXozsAfhCDwzmMtTVaADokMjOtxEwRHdJu
         pV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713192241; x=1713797041;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0bmcD1dsKmxdOPG1Zb6XlpeF2OhOoXu9RprsqunU6bk=;
        b=qO64sHqnht57xxrbRIWj0PYlZXCSvwecrTP2RWDobJhu5Ogjme0bYIgpTY5tffA547
         AQK5OKR1l0l6CMKlxPAjamhz0zuu2ytd+lnMCVlMK43QSFfnFPbNR3xrDtR6V/8Ee9Y+
         uGEElVIhMTWalcLr1XEhH3WL8LuU/XVcFAxDAuHQLnVO2cQxuYE7xC0/GqE28D/vrqlC
         QfR9eLSZVswA/M6bmIADD5hZ6IoSpLUbmGvD188KrNN82Gt9T2zx1js3QFfa/Jvu+KiB
         Mt5v8BMHXj+P/5DXEyUONzzT4vBzQnSiyq1WGpO0ObouBW6IUenP0eR3hHbBdFsUgPvv
         SdJg==
X-Forwarded-Encrypted: i=1; AJvYcCWteCG6SsF052+EYJAJO0KD1qOu0ZckZS3d7ADYkWjfi+yG0XCSlhjM9x0mQmNFP1UJ0cblBzUb9VT6WTOUkDLXgAoMaiKmPYGg8jDu
X-Gm-Message-State: AOJu0YwgBAZF1QWoRHYHhGYpfJ0+/FTM5G5tKMyNbHYMtyixP1tpnh6o
	WSbWsHFgFDPk8RXz6pzgn5yt6bQ2ODBVVeCQUKM4e6x7ba3bk9jRva4GBrC0wpputhm4D54kNvb
	d92vOfpaZBg==
X-Google-Smtp-Source: AGHT+IFEmFS1HiEMaFINlIUIUMR/6wAm50IL2RKmWT9wBF0Ao1Ak+ndSv5qjpwOV71WeC8xHyrbagpOvd2bt2Q==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:600c:458d:b0:416:a53f:38fd with SMTP
 id r13-20020a05600c458d00b00416a53f38fdmr32504wmo.1.1713192240874; Mon, 15
 Apr 2024 07:44:00 -0700 (PDT)
Date: Mon, 15 Apr 2024 14:43:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACk9HWYC/x3MQQqAIBBA0avErBtIS5CuEi2ixhoqDackiO6et
 HyL/x8QikwCbfFApMTCwWeosoBxGfxMyFM26Eo3VaMMrmlHoc2dJKegDyjXFFANxjhbK2ethtw ekRzf/7fr3/cDxrlkFWcAAAA=
X-Mailer: b4 0.14-dev
Message-ID: <20240415-kvm-selftests-no-sudo-v1-1-95153ad5f470@google.com>
Subject: [PATCH] KVM: selftests: Avoid assuming "sudo" exists
From: Brendan Jackman <jackmanb@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

I ran into a failure running this test on a minimal rootfs.

Can be fixed by just skipping the "sudo" in case we are already root.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh
index 7cbb409801eea..0e56822e8e0bf 100755
--- a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh
+++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh
@@ -13,10 +13,21 @@ NX_HUGE_PAGES_RECOVERY_RATIO=$(cat /sys/module/kvm/parameters/nx_huge_pages_reco
 NX_HUGE_PAGES_RECOVERY_PERIOD=$(cat /sys/module/kvm/parameters/nx_huge_pages_recovery_period_ms)
 HUGE_PAGES=$(cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages)
 
+# If we're already root, the host might not have sudo.
+if [ $(whoami) == "root" ]; then
+	function maybe_sudo () {
+		"$@"
+	}
+else
+	function maybe_sudo () {
+		sudo "$@"
+	}
+fi
+
 set +e
 
 function sudo_echo () {
-	echo "$1" | sudo tee -a "$2" > /dev/null
+	echo "$1" | maybe_sudo tee -a "$2" > /dev/null
 }
 
 NXECUTABLE="$(dirname $0)/nx_huge_pages_test"

---
base-commit: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702
change-id: 20240415-kvm-selftests-no-sudo-1a55f831f882

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


