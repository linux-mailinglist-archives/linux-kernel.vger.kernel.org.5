Return-Path: <linux-kernel+bounces-41436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D4D83F109
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F76283312
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55E41E87D;
	Sat, 27 Jan 2024 22:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tW/hJqkx"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E081D6B8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 22:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706395405; cv=none; b=ahV9KBCawuYNMQY4P5OE8niDStGTVNcltnjUkhFY35WOrXRcpFekdRQ1dPIlgZksyjewpHmMVaPRUo8bRC9pHb70gCC1iTmDuKa0/9Nyh/JFmmhtuRJAoyYN3CNvHHGAivdGxrs4R8B8j1HdB2cDUkOoNwST9GJ134xrnthcapM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706395405; c=relaxed/simple;
	bh=mWjXtlhzxJ0HumO9EQxiUCzJoLvCZ3auqmtfLpgoNWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpre4fxFKADYRWUAjxGg0QIvlcgVxyKsA58GqRI2X4F4Wyi4LqrD/BkG/rE8Vprfi07s2CI+cgCKIMqgqsSMP67LB4cBgdLiTjEHvdGzBhpUOaAlj39yHnaYHASOltV/80DbULtb+U6b3zHjAX+fP++9PIGL7AZMa3O3sXf+llA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tW/hJqkx; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59a33cc946dso62965eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 14:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706395402; x=1707000202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mWjXtlhzxJ0HumO9EQxiUCzJoLvCZ3auqmtfLpgoNWU=;
        b=tW/hJqkxhIwsPSPb25FSMkxaJcNfr8wPiN/bfhpt0PoE9+RVCGzFg9t+PkTVJsuThF
         T/JxL/TGDKsnKKXVqHV+aYYiKdLXdtv5dveTI90c+bS/BGs8pzNrsjEy6A2Ond4zMkEZ
         SxRd9UZIdnQ1JuZiiQFoWEas+Z2mtD6sB4IXYw7nc7SYUg/DgS8Xh40oyys4weZpPnek
         iQEKbsWLjsVOUvebYnl6gXunj+FAUGICscDeUm38LIku5YtpLGvD2ced25D0Hg5gyFCE
         LHELpYmqijcA9kHqefgP0XZB4AGDTTH7pyW5TfiYnAfnMh4hBuXpfRfr5ir1U4cWuXHy
         UqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706395402; x=1707000202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWjXtlhzxJ0HumO9EQxiUCzJoLvCZ3auqmtfLpgoNWU=;
        b=CHd//DQiju2+yCKufurkTrBY2znAg+gBCcqNzR2CpJov8Sg1h8uQCQuGeSaWv1XQDm
         78bnqawmF4zWZUrR5/cR6JtIS1Xw7AP0iugHzXRw5Q7u8ur7je+DKzOZz968/8vZOfbG
         alluP4BbALt3LffmkqOB+bNHg15adakPCWj9uKzdBUrRcmE1RXDiyUE+Z4DuPUrBeJgu
         FsZDAn+/lbvMAITxIzNE0DXV3TB41zF1o6Z6BkRIFBnXyx7NUxY2mZaURGppfbMLmOcT
         3W3rlkuMzFTSjeZ7qM5mC//z+Bt+9W+nrfdq/Pzz3KP8tmvIpiTdjflf6B1gl/ZFhLn6
         RFJg==
X-Gm-Message-State: AOJu0YyZ5ibPurh3Bv0ViR7ULIYg5aYHD6c53zM4pcey7GNMn2zIT6F6
	kB5KF8HB+Mc23V7A2iJuw8oJTaWeI3TL5WqTTMIJDfcFMj7vrf7wfgy6Ccu9w9jlFgDaX6uXpC+
	jb9U9Y/oGWtW2qMW2uRUjjZ7CAoP4wkggXhR/Ww==
X-Google-Smtp-Source: AGHT+IFXp7NCE5mHliI2s6UcPGOQOOnMnagfJsrWiYKpFAZOLGMz3u/gyVvCJTLQGIRgnARNlVJtzQilk+9uP9DVKEI=
X-Received: by 2002:a05:6830:10c7:b0:6e1:eb2:aef7 with SMTP id
 z7-20020a05683010c700b006e10eb2aef7mr1371438oto.10.1706395402752; Sat, 27 Jan
 2024 14:43:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231225082305.12343-1-quic_aiquny@quicinc.com>
In-Reply-To: <20231225082305.12343-1-quic_aiquny@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 27 Jan 2024 23:43:12 +0100
Message-ID: <CACRpkdYM5=55m2ywC981VXVzbCg64Opbh4yEw2TLja998cES-w@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: Add lock to ensure the state atomization
To: Maria Yu <quic_aiquny@quicinc.com>
Cc: andersson@kernel.org, kernel@quicinc.com, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Maria,

I wanted to apply this v3 patch, but I can't figure out what it is based on?

Could you rebase the patch on v6.8-rc1 and resend?

Yours,
Linus Walleij

