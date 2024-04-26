Return-Path: <linux-kernel+bounces-160758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 833048B426C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396571F223CF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01223D3AC;
	Fri, 26 Apr 2024 22:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="FzJjArNr"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9556D3A1B0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 22:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714172280; cv=none; b=h3qb9csYyPYc9C2Ud7hqPmI2plUu3APXod15/ZESD7ilSIoaADx0wuf31XcJEiqTZjB3Ud7TVlVmucF3q6sovKDl2VOt14RKlATQKnUXToNJhpW1yMn+8XgEIe9l0RNkOvfwcqphtrJIUupn+2i41J1f2nMorR3Vj7W2dA7FbYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714172280; c=relaxed/simple;
	bh=BXBOryCRmdGU3MpjZtj/f9m+SVkcFk68TeUd1IaFwL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fp3aqUAqlak7wQOwBGHZHHagOja+qRoouFYei1bf0jh+ObwGD/1Xd6Fn4MGuOYpbDIZzQjmgnH7LNQfVuKhMQFx7nhCjmExomjVmpLpmBaYkMOmTAtzXFbwvI6QIDAsSpieBN1fjUPLhh731YPrJ3xhP0RDyooZxYjShaXYZPXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=FzJjArNr; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1714172276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SqC2//5SbqmO7sl0eIyTlpelQ5K5dhBqbZvBw6LmbcE=;
	b=FzJjArNrn0fjQZ78lse7C+m9UIX+MxlPLZVwrQyH/p8SIbdpp0/6cXQ422lnrlWKnO9/jZ
	f0YIgQvTicvUvb/q9pPK4zsfb5/lqIHhOoVF2SkWz7MV0zuxtAsEUB3jLwINdu0BpjyCv3
	mmsNj65FqDdirRB8dOutGxacL4tC1OWggiz9Ad1I04PKsDIgtNEO+oifxTZF5+rV/aLbWi
	BXQYI0Y7v02OAOHDHTlA0aFsRUEg1FkvWk/tENbaUPDUUofiRsYAXovaes7k32rPKJasQK
	WjKjNNipzuKHM7WvnNvB8P/G28YDRPPyT2fNuLZYSRjG7sIVUlbdHtVSycuM9A==
From: Kenny Levinsen <kl@kl.wtf>
To: Jiri Kosina <jikos@kernel.org>,
	Dmitry Torokhov <dtor@chromium.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Radoslaw Biernacki <rad@chromium.org>,
	Lukasz Majczak <lma@chromium.org>
Cc: Kenny Levinsen <kl@kl.wtf>
Subject: [PATCH v3 3/3] HID: i2c-hid: Align i2c_hid_set_power() retry with HID descriptor read
Date: Sat, 27 Apr 2024 00:47:09 +0200
Message-ID: <20240426225739.2166-4-kl@kl.wtf>
In-Reply-To: <20240426225739.2166-1-kl@kl.wtf>
References: <20240426225739.2166-1-kl@kl.wtf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The retry for HID descriptor and for power commands deals with the same
device quirk, so align the two.

Tested-by: Lukasz Majczak <lma@chromium.org>
Reviewed-by: Lukasz Majczak <lma@chromium.org>
Signed-off-by: Kenny Levinsen <kl@kl.wtf>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 6ac1b11fb675..4ec12c083714 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -385,25 +385,21 @@ static int i2c_hid_set_power(struct i2c_hid *ihid, int power_state)
 	i2c_hid_dbg(ihid, "%s\n", __func__);
 
 	/*
-	 * Some devices require to send a command to wakeup before power on.
-	 * The call will get a return value (EREMOTEIO) but device will be
-	 * triggered and activated. After that, it goes like a normal device.
+	 * Some STM-based devices need 400µs after a rising clock edge to wake
+	 * from deep sleep, which in turn means that our first command will
+	 * fail on a bus error. Certain Weida Tech devices also need this
+	 * wake-up. Retry the command in this case.
 	 */
-	if (power_state == I2C_HID_PWR_ON) {
+	ret = i2c_hid_set_power_command(ihid, power_state);
+	if (ret && power_state == I2C_HID_PWR_ON) {
+		usleep_range(400, 500);
 		ret = i2c_hid_set_power_command(ihid, I2C_HID_PWR_ON);
-
-		/* Device was already activated */
-		if (!ret)
-			goto set_pwr_exit;
 	}
 
-	ret = i2c_hid_set_power_command(ihid, power_state);
 	if (ret)
 		dev_err(&ihid->client->dev,
 			"failed to change power setting.\n");
 
-set_pwr_exit:
-
 	/*
 	 * The HID over I2C specification states that if a DEVICE needs time
 	 * after the PWR_ON request, it should utilise CLOCK stretching.
-- 
2.44.0


