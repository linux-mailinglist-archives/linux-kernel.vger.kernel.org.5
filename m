Return-Path: <linux-kernel+bounces-6823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10695819E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431521C2242A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3F121A1F;
	Wed, 20 Dec 2023 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yYioOZO4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4E721A17
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5e730eb1770so23332207b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703071846; x=1703676646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SufIfXUXtE/IGgc3anNuqd58CF8HQVlRsSz3wdrFNs=;
        b=yYioOZO4GWbJQ1FKbcHMWk8nB634r7ZMkx9PTasis3AWqD43reT+OuSQQafjBzTtml
         LCUc/X45hvgiiYuLKFilG+/a/XpTD9tM0C/MFVCp0IQpocr0Kgb6JR59TPgE5mRKQDk2
         HP0V2CLIdru0RGnpkt2QqVGklLHwgesqFN7d6hBwPucDYpncu+C+k6xlO1A6yYeJ6mFR
         iFQC7POOS1gDKCuL53ubiMXFw2QYSmGCe0xq35U8r4tJ9Yiej5gtEn2MKlJ+2ZhLgL+h
         VD/1mnnAxyFqGiTtR3t2J5CSm8C2Qo3TI3ITLNJWmz14jL92TUhqR1ooVGaS9BlTfIcz
         4nVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703071846; x=1703676646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SufIfXUXtE/IGgc3anNuqd58CF8HQVlRsSz3wdrFNs=;
        b=KDp5Vo2XLCIroRt0KFoGcsvGZ6rqq+zDKbuh1grA7VpUYEIYNFk+NUvgerXq4oxerj
         cEaRHPXuUi3wYbY2my4oytP+HAenGOIF76ccxqG/pUJ0j5IDsuYDz6OqqYYiUU8D1zb2
         xz7jgwTzQGgUxjHuAPnka1c/A/PRqk5sMelUGIz6vSaSRP1mrXorG8AQ6TXHmE3+9THC
         Kjj/swP8p9uEkDnf3b85fEnFfsk+x35dQiKaKaYHzrYU3CcJHm/nFTQDl+siKmpNcKZU
         Cerqr++OoMQo0TPJkTIUZPRt/0cwaZMBDMK9VSietURGxPyi1lLNL2dYIANKqeF8ytcE
         /HZQ==
X-Gm-Message-State: AOJu0Yz1TgiKuBHFfJdx72Sf+SQbkhiskvyZzbDYzAYE55lHOB5x+KZW
	RMRRKAYLPt7uBP749frirMVnhStiTzdnrDFv+s+k4w==
X-Google-Smtp-Source: AGHT+IGnvk6xRVkvFKhYWp0Qwy3vExCwRaFW2DEjlA/odXuqOOyoMcBeTXq4E6gIhF5x48xCcjowrVFlndR3yRM84pI=
X-Received: by 2002:a0d:d642:0:b0:5e8:789b:3be6 with SMTP id
 y63-20020a0dd642000000b005e8789b3be6mr480696ywd.17.1703071846489; Wed, 20 Dec
 2023 03:30:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202312151810+0800-wangjinchao@xfusion.com>
In-Reply-To: <202312151810+0800-wangjinchao@xfusion.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Dec 2023 12:30:35 +0100
Message-ID: <CACRpkdYvCF2Bk-akuOX88xW21DZmvX+7k+L5yhRW00wdhfF9Dw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: lpass-lpi: remove duplicated include
To: Wang Jinchao <wangjinchao@xfusion.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stone.xulei@xfusion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 11:11=E2=80=AFAM Wang Jinchao <wangjinchao@xfusion.=
com> wrote:

> remove the second #include <linux/seq_file.h>
>
> Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>

Patch applied.

Yours,
Linus Walleij

