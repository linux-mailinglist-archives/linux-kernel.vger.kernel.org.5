Return-Path: <linux-kernel+bounces-3811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A198C8172BB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44984B22D79
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E44949888;
	Mon, 18 Dec 2023 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CwfmekGU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870193788E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-35d74cf427cso13146715ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702908576; x=1703513376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QqXSmTnTtT3Od7GmRltkqUPr4ByKUT9ybKktXPVKvg=;
        b=CwfmekGUkzyeJX97NoAfw1ZBZveJosaJsuOA7JOn/0dDLJ2I6JvpwhjNLhCG2CA9yE
         DirIuVMRgm0ACNJ8VQPTVx0j9JlLPjQGLHWL6ntgqHrpzo6tTGgw3cZXlyCIwz2kMcEz
         JVIIuZwTqb9PdjsFOD0bUpwzCI9W07Xw9Njq3zH/RK+fDw34fuhbrqkBoiBIZzCBo2va
         dLjJZYI/KhuVKOxQXM5a0s0p2czUV+ZkeEFzyeN8zbT4qR2R7zTiWpZgLhu3fYWEpNVS
         h7Y8H/OGZvMdlJemwN9SGNryz6waCYQN9jdYvKr2QUQ6DDpwfYr6m7vHlMpiu+X0Qmbk
         6XXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702908576; x=1703513376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QqXSmTnTtT3Od7GmRltkqUPr4ByKUT9ybKktXPVKvg=;
        b=NIR3rd+4St6Iob2ne6ICMcgiIkofeiMQ5AzsMwjcfbJrjnZZwJvG8OYWBhZH6n39cB
         J86pJJx//FumlQnnoGz0h9Rat/3fkXi8iOP7e2Ft4R/FpsmyEX8CxfkkQL2Csijd8yeH
         HFP0d4q5sJJZylzvPl5CrIV6KR32pS6QVImwtE3upYuwjb74Qiym5pBzFBCWPqppmD9i
         QinDDbkpWq+1d69S3rt5rNGExThYeTXEzhhcbvWeKerlmScQnwclnCK5Tv0ObBXYb3zX
         UZ8WRqaUPWOnwpBujPZ19VHlepSO9Jb4GWDww/RxRqaNxY6na1t6fKiY9xsDNGnHfjMe
         Eclg==
X-Gm-Message-State: AOJu0YxbP+UyDN3KdQSjhjQM8DRGdt0h2JXTl5oEXCrKHsgv2M+WfpWZ
	q0YBXhR/PISQe+WaXnEIN1zCycYh5P41SMWyVRZhEg==
X-Google-Smtp-Source: AGHT+IFYjruUvqVZXDvbXT4LNhRX+qeEr6xvnJELdCnoTBR7EBrvWnDtSE1Zyb2YKZ0Fu9zHGj9ZHRrOE2/7mu+2rhs=
X-Received: by 2002:a05:6e02:194f:b0:35d:5553:7427 with SMTP id
 x15-20020a056e02194f00b0035d55537427mr21641253ilu.8.1702908576714; Mon, 18
 Dec 2023 06:09:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218094548.37105-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231218094548.37105-1-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 18 Dec 2023 15:09:25 +0100
Message-ID: <CACRpkdZwRJ1U8n=HP8TzqNVK4J5RqhiJYBdH0COexMH7TyDknw@mail.gmail.com>
Subject: Re: [GIT PULL] pinctrl: samsung: drivers for v6.8
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Sylwester Nawrocki <snawrocki@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 10:45=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Google and Samsung SoC pinctrl changes for v6.8.

Pulled in to my "devel" branch for V6.8!

Excellent work as always, thanks for keeping the Samsung Exynos in order,
there are so many users of this SoC now that without your coordination
it would be complete chaos.

Yours,
Linus Walleij

