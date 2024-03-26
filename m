Return-Path: <linux-kernel+bounces-119150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D38F688C4D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7691A1F65FE2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8FA12D757;
	Tue, 26 Mar 2024 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ThSkPvrq"
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BCB12D1EA;
	Tue, 26 Mar 2024 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462392; cv=none; b=tX/k5U2YpA5luAkT6RSQ1/m/ojnHKpuVayNt6n/rNO1nl56RsuCNz3hT4GF0bPXVl6Syvqvl6VOjCFJD7JaIeRMZbMlr0aOa+xm/yW0Hx++56fXntki2+tcRRiffmCWpdx4jA76mcV4nLZOktyOsogfUTVVQvjmODH9JnrZ1hoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462392; c=relaxed/simple;
	bh=n9z/gDZDjYHMPOJp96or4lFZ6RAQsFRPlqy/HgMln+g=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jbG2DW1llgx4yt4cDJ16lv2hiakValGTEeDbC4LzHf78hJBktj6SVkQxw0Lsctv0I+mz8q3WBFnDRFNAE7Jsw1IvYf4f3Zv9JfGlYJLaX7kH/Xcastobuox+J7CNV/5RnA54aig3y7Cs/Z2jxmZHEpyY8/SKMuFZSgrLEz9zgFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=ThSkPvrq; arc=none smtp.client-ip=185.70.40.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1711462382; x=1711721582;
	bh=quQENs3rklSsj+2GdwQaRpRYzCTsHSLXn4kJT0x0+f8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ThSkPvrqgIoy6VfgshgKlw6Tl91BwJvnC1KZJf6cS0Gk1mdQeQRnWdYe2ZVYnnW8W
	 HxLMTuiewSpUaYZZiFulLiY8mrQTQJt6gl7jLEyAzHHz2bWtWJthus+ohhPUqFrPO4
	 8rLM/bunvFAqtQGFA7YBRlHkuMlQiuxCIlPEmS5oCe1ucoLnOa7cR6bKghYPMUsb6O
	 lIxINcVgoPGMzokJsBqKz87KGFa94VAvDVhALw+4XDmAOzhSL8WO+pxIVLIYmpq8RY
	 EB2irEQ2DsQNOEz1Nm/I8KNSidIZsagCKdrZrTeXTkwui+Ae7gsbU3pxOym2KprA4A
	 X1V35ov5VLnyg==
Date: Tue, 26 Mar 2024 14:12:40 +0000
To: linux-kernel@vger.kernel.org
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 0/2] arm64: dts: qcom: msm8916/8216-samsung-fortuna: Add samsung,fortuna binding
Message-ID: <20240326141222.200452-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add common binding samsung,fortuna used by the following
Samsung Galaxy Grand Prime devices:
- SM-G530FZ (msm8916-samsung-grandprimelte)
- SM-G530H  (msm8216-samsung-fortuna3g)
- SM-G530W  (msm8916-gprimeltecan)


