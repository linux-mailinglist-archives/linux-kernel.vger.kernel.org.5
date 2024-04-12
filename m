Return-Path: <linux-kernel+bounces-142237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2678A2958
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C682B247FE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26AA50A72;
	Fri, 12 Apr 2024 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7WRa6jJ"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DC950A66
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910597; cv=none; b=auOazx3zIBZgsWggCjbk1eSRLeRYrByssnxe6Fg4r0hST7dM73EeDoQqDLTGhv/bdg9xCbW2NNz6pJY45karBhdjBY8ycY83eECrZvVDBCFqTef2BcIajNJZMioyQWm9pJ+jiOtZByXb93maAP2otScUkONhPzeewPGlSoFdMWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910597; c=relaxed/simple;
	bh=BfeZ4IL+0uJkrnFhXyulwMZH9YOcEsG7N4UPSxQwrXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jtqf/wZv7fXX68/r1Ninuld71ZMXUQhjRv+cs2a7yBRLb/Q2l1Ax3mZXDJaN9thLfEijPgOnwtl1jk7CZJLCTBpcAuD4APlKYXI2sRJd0PstrwGy96oTOlUzv7vPJqCZlassoqzKpsRbLkcQ9mFB3xVIbipUyLsUrqRlqMDztn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o7WRa6jJ; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so635488276.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712910594; x=1713515394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfeZ4IL+0uJkrnFhXyulwMZH9YOcEsG7N4UPSxQwrXw=;
        b=o7WRa6jJQjOSiSk+LM1LMe0eCEDv7pAxXn+9tRG+OHle1hjRfBQS5s4F9tkEkGlWtT
         f7n3wIJFjkHAHvZwljozZ0uKtwjuUKi0eaYYJDDemqW9FU+mGFRDmjLvyesUEIAt3tja
         lnf51I6sIlylsYJ3Ou/TPakkR8Gu9dQTcGrT/289MGzM+MGDyfAhvrwZk6tzeGHEfdn6
         m7aJ/3QPgOvSvdYopJkVKasAeYQ1rSzpt82omMLk48Mszc0FlJQkvsAhL9eKdq9Bu4ko
         MDKGhGFCZuXU0zDg2b3hNghLYlSjkxzb3uvPX6ThfTnh2diP9VhfEMM7p090E0VrH/2W
         17Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712910594; x=1713515394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfeZ4IL+0uJkrnFhXyulwMZH9YOcEsG7N4UPSxQwrXw=;
        b=Vo/HHfHdbsPW7IqWZLD+HWMuADhrEeuGTCmG91xh29vDVqaz8jo3P4JmnhDc7Ym6Dx
         5kFpigVkABO/hM6pY7flTbVa2YwkqWh7ZqNgkq2aDTd88i4kQnk6BcntOQe4bFOmaBiB
         AS8wQ+HKhXyMutyWfpvQD703SRCWNt5BcKXAk6J9fjkJHlgZTfo9HPPM/W2CzoT/uKGS
         oaQrOxQWjsYySlE7Tvogd0B/tyORAL/PphGRQuA6TQ4oPVeCVYhth12iKHfU9TChDlkX
         OuvaoT2YlcfQEdafLNp66SLsE95WizSQ1xdRbPyAh21d5ok3D/YXZQeiQMfUwz/pBNaN
         ET1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdIfinWHWqE2koeu9WMXWxwfI6qRJTXVLZJ7PvvMY316Me0IImM981tnEPDQxvUwJ0AlLtWO+XPj0Q7tpVug8m6KOYOFUUrgyS+I66
X-Gm-Message-State: AOJu0YzX+Mf70PDNAP1JBnMi7Q28qkEfc20VBlVoe/zQVtXlj5KH5Sp7
	uukr0B1go1fC9V9Eo34CypaSBrE2l2KVu070YlXCTSWyYAcMROMAYeIjBVNNoaV/mSYakwYdwbC
	rJJfZP7F8ZAUvUQEh43wuS8HfzKwdr+imygOfZg==
X-Google-Smtp-Source: AGHT+IFFCDn8Tj8KbGC7ulaXoT+mmD8v5dmvH9Q8fuetYWLwrEUEyf1O0q+ueZp7Pg5qNbx8uhruJtp5xKm1GgD2U80=
X-Received: by 2002:a25:29c6:0:b0:dcf:3aa6:7334 with SMTP id
 p189-20020a2529c6000000b00dcf3aa67334mr1854728ybp.7.1712910594707; Fri, 12
 Apr 2024 01:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409-qcom-pmic-gpio-hog-v2-0-5ff812d2baed@z3ntu.xyz> <20240409-qcom-pmic-gpio-hog-v2-1-5ff812d2baed@z3ntu.xyz>
In-Reply-To: <20240409-qcom-pmic-gpio-hog-v2-1-5ff812d2baed@z3ntu.xyz>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 12 Apr 2024 10:29:43 +0200
Message-ID: <CACRpkdbRxhKYNHgssFZ0Pf5_0_Gt7+Ga0OhWdhxG5eKCrZ7Wkw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom,pmic-gpio: Allow
 gpio-hog nodes
To: Luca Weiss <luca@z3ntu.xyz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 8:36=E2=80=AFPM Luca Weiss <luca@z3ntu.xyz> wrote:

> Allow specifying a GPIO hog, as already used on
> qcom-msm8974-lge-nexus5-hammerhead.dts.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

This patch applied to the pinctrl tree!

Yours,
Linus Walleij

