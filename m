Return-Path: <linux-kernel+bounces-147068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2D48A6F00
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4761C21DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46CF130496;
	Tue, 16 Apr 2024 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vC5cP3gH"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A988013048E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279000; cv=none; b=ImBLcDIvfEtXCynZa96TWSA7T6DLL/6BUzjREHCs8mGbThh0GUfoIUFOIpRWZF8//c++xYcTju5y7tzf9zMBFh7jO9BYk9A8P6nPtdSOyUSRYgucMfyCCR5RepvayeUQaeW8yv3CUlNKdcTSGuGlC1ccT6yjljqPQiv7Ef4R3Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279000; c=relaxed/simple;
	bh=3u9Sa7giDgPt1Wvl9jEHgyYRd2FVkBY5rzmWZa3BbG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHoFYmU+SGJJsLjaFNz8J14cIZkzakms405jqDjfFZ2CiYHjoGK7drWoFXcyEKn2EqSyryEH7CzeaRKdmhdQDzcQQksMmlv7dUzF0LemYO2oT1YYv4yDR/z88ZfdUtTW+7FDM5syJs7sR0kFHSUQFpfIU1uu8CviHSHlZmvX5WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vC5cP3gH; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso4951525276.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713278997; x=1713883797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qJzGnOg1SHKsRCJmdbwuM9RJK+vob+tb6vu88judbOk=;
        b=vC5cP3gHToBZy30b/F1+l33Y23Zj4TQil2fSr7OpOEEKXZpfAa1IjRZsMc6OiQh9pJ
         xyd8+5NdqyKJ8wniYTrIeIRi8voZmTWw2huFADFFkMVPr2gac8chBeP8RprQy+OY8G5I
         B+rHQF3aKAkH/S3brxY3/j/q5jrisNjr6c2gcG5n7g5h0HTCEEhLYl3PFe6EXasT5ZHu
         ghaBR6bMf+j3K5VcoVHjHwHJGzwbLN43EghB5kT/rxEUCBHbTspiDDMHJcpNLIhwsMbq
         9WSpFvi0mgNEi8pLqrtpisJG/mixYzoB5G7BXbS+O6irqtrdwZK9G6IXxzvNqnKw/dmc
         D5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713278997; x=1713883797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJzGnOg1SHKsRCJmdbwuM9RJK+vob+tb6vu88judbOk=;
        b=eoKcEaIWfvw1q9H23F9wzT7kh5bpJEvzKBfanJRoXp7Zvpbz4Va0xMD4qxlqxuBN++
         d5dn0iIX0JCWKw/kMbjU0g2NukXIhK3V6lVkrjoHgudOgfS5No5CUX8aoxhZ+S2zBhVx
         7PrLYEVdqBCA5Q3jD3pM4M5pYnLTwQBTU20JODPOga1QP1J4y67IK4PgSGpLRjE+i8R9
         3hKrGGrkum3hSTH2LvenueJBXeBGS4RttPGzYxFEwBY5oKtFfoMAl9qHFqJytX7r3PNk
         +2xW5ZToObbomH3qDlZu/Z4KU5PzjPBqfIPWYy+wzG5mP81XthzuUtdjwZLuEMzS6El4
         X0JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYu1gfaFdspz79RYa9EXpUfKgr/CP3r8tr/9uHoo2HH+c/PXgB6oFFOAcOGjow3RqJMA6WhDVkLWEpLPl3jG5s7H6wS/C43AJGSdj0
X-Gm-Message-State: AOJu0YygvDVisaAqX8eYMDGLNrDoj4VF3O6YbXOEQ9VMIMRMs5MfOqDQ
	AS8kVgvH0iPmjaKAamP+P2fMlN793K4+K71E4ZVZj4saR8pG4XASxjFkQHcb5x/LvNdceKhdG8V
	+GpW4Gq2/yfzHISNqcfUDvRoaqytDyUxKAmH5vQ==
X-Google-Smtp-Source: AGHT+IENg3f4q4qDx4Uo22QWVhG5m/PHgSy1nPplO90P/inGp0NQFhD+3BgUC9UMslfVeoHnbLKK/wtJ+SfdgTeRyHU=
X-Received: by 2002:a25:74c5:0:b0:dc7:464c:e979 with SMTP id
 p188-20020a2574c5000000b00dc7464ce979mr12879999ybc.28.1713278997544; Tue, 16
 Apr 2024 07:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416-ucsi-glink-altmode-v1-0-890db00877ac@linaro.org>
 <20240416-ucsi-glink-altmode-v1-3-890db00877ac@linaro.org> <1545d3fb-88f3-44e7-b981-610df6bdf6f7@linaro.org>
In-Reply-To: <1545d3fb-88f3-44e7-b981-610df6bdf6f7@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 16 Apr 2024 17:49:46 +0300
Message-ID: <CAA8EJpom1vnbjqOU6gD89TdZxDBzY_3upgrdvmXyJLA1tsDBvw@mail.gmail.com>
Subject: Re: [PATCH 3/8] usb: typec: ucsi: glink: check message data sizes
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Apr 2024 at 17:33, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 4/16/24 04:20, Dmitry Baryshkov wrote:
> > The driver gets data from the DSP firmware. Sanitize data size before
> > reading corresponding message structures.
> >
> > Fixes: 62b5412b1f4a ("usb: typec: ucsi: add PMIC Glink UCSI driver")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
>
> I think more backstory would be beneficial here.. Does this happen often?
> What are the consequences? What are the causes? Can there be one-off invalid
> messages, or does that mean the firwmare has entered some unstable state?
>
> And I suppose, if answer to the last question is "unstable state", are we
> doing something incorrectly in Linux that causes it to happen?

No. I haven't seen such cases. However as we are getting the data from
external entity which don't control, we should check that the messages
conform to what we are expecting.



-- 
With best wishes
Dmitry

