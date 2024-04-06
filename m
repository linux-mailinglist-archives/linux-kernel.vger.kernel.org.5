Return-Path: <linux-kernel+bounces-133901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA2D89AA86
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA221F21B3A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833B92C1A7;
	Sat,  6 Apr 2024 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="XJK4D9KT"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2095028DB3
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712402074; cv=none; b=Xo+CJjde/FrGPlqKu0KFiDdGrCBnkonwdYnJI+oXufJUfyRfgklM8NViPKrmGOKB6TBAzKzskMTJVA7PMsTWZOEzCqMx65w1YbfGUDahBP+NG4YEU557LqW3fofNrWocHTQ5r5QRLNrwU7W1BeZpNQ+Ud5HBVpD/9Mi9Ulj3s6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712402074; c=relaxed/simple;
	bh=3C7DZftyxSnn0rTfhltm6sKkocVJ5v0xMVJQDYSE0iw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=B/wieYmM8dBd+4wQCt8nQ7CJfTxDtE/6PEhFqib2X4cetsfSG0Fe0CHFRtJPKk+my8h2K91IYAN3znVNEVlManxjse1/XrXqOn2oSu08ytYwO5s27l72FEuLdkFOe3PpCJEnQOFDq8ltlVA74vToTiE5yYwmnxHo/Rw02iygu6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=XJK4D9KT; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1712402057; x=1712661257;
	bh=Zv5ijIXBQXd7ATsnV92LCb66jrANS2OynezQJOtP7D4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=XJK4D9KTfuKdqX7is1NQ3jGKP9gcT9/BtL0cOhHM5+oXH/xiavon3w5szOgWwNJHV
	 xjTWeneVsRLpX5KpE5X2eptC+vhndrNVzzvSqNnzbmvW0JB57JDYzDSPqYPhDQZdmj
	 Un4TIF7vBa/s/IQp0QAD4gQrnnguU57dLcsaInmROGI2tYjnk1vIpu1dfLKZNp1wn4
	 GuH7Zw+h8WHuU5VH9y0Hi7A1RIV2Rj/kLTAyQoicAQ+K9g29SVDAZPC7Oed44VaATw
	 LLvARdYGhnI22PvTei+upYAl3YVqHMzaUJI5sB19P25712oBbxrlRkURJ9k1vNpCvZ
	 vFB9S/FivrZCw==
Date: Sat, 06 Apr 2024 11:14:12 +0000
To: linux-kernel@vger.kernel.org
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 0/3] arm64: dts: qcom: msm8916-samsung-fortuna: Add accelerometer/magnetometer
Message-ID: <20240406111348.14358-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Some Grand Prime use a Bosch BMC150 accelerometer/magnetometer combo.
The chip provides two separate I2C devices for the accelerometer
and magnetometer that are already supported by the bmc150-accel
and bmc150-magn driver.
Some Grand Prime use a ST LSM303C accelerometer/magnetometer combo.
Core Prime LTE uses ST LIS2HH12 accelerometer.

Add support for them.
---
v2: fix accelerometer@1d: 'interrupt-names' does not match any of the regex=
es:
    'pinctrl-[0-9]+'


