Return-Path: <linux-kernel+bounces-28653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C101830163
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A483628798C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B076811CAD;
	Wed, 17 Jan 2024 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ne6qfII5"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C6D11184;
	Wed, 17 Jan 2024 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705480666; cv=none; b=mkWTDHQwe6c/P6dNAqPdCosiBqjrZfnYLH6JfiyY066Pq9fujahiRla3H0yHKYCsrUP/4wAOtrHUpL15EubEQBhPz1y9S4kNwas4/XonI4RNaj9KxYZU10+Ok5B00GoClG2or2QBibURt2ffmCV2wAUqj+sROSOXRD7qO8pWiBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705480666; c=relaxed/simple;
	bh=+4nKia+MxGDsWlDfyR/tVIYEDLuXX3TCdF6V2ikrzZQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DSoyumAtKyift+nMxxnjHCrnQbLL3BupZeepPiyoMqlUxvTg431xSETeoD1uDP0EyaDgeQHn+TsvHJJgHlIYCKcrwBERDEdOIc1IMBJzzA2mm0k2Hbw3LUDfttJ7IfDMpCwORmnMeF727t3gvLo+dBYqCeGWbwZYtuhalqWNqR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ne6qfII5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a28da6285c1so1925494766b.0;
        Wed, 17 Jan 2024 00:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705480663; x=1706085463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+4nKia+MxGDsWlDfyR/tVIYEDLuXX3TCdF6V2ikrzZQ=;
        b=ne6qfII5HROuESX0SbIUvscK7Pjtmp9QY2YatXF5LdpuXG8xhGU4x7j8bm94JwoLYZ
         +Ujff9ZMjQ76jXWv0C3UHq5wC2FhUU4pEhoZ6ODa8rIVtsXzpTH7QdbiKG8NqOietZUZ
         0OqbpdNrWDYl8scsX7HQzhLWOLue2HCO1aoKOU3GP+D0dYtNFK597UVYay6zBRovUUt5
         tTxvDYy1XC6wKhR2nVMJ7b5wsnThP5v6ThiFmfTX1Il3Ux7ZuMrjdZqOQ7x2VK0juvRR
         T6Xeh+4VlpVvx2vwp9reDc8Z75i28Ku0VDqPfIZhfyQvRflUVbVKWhNhg4AtmMaH4EJe
         3w7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705480663; x=1706085463;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+4nKia+MxGDsWlDfyR/tVIYEDLuXX3TCdF6V2ikrzZQ=;
        b=iaB/Xd5Oftmuaw/tPMh0sn7qMfq2sjDl4DrCIHVXM8qyZRD5SvV8yBE515rt8gck14
         IeLUT2XNwhqEh4GBkDIsFWQC5VABNnaBRy36J7Y4aZNyOGArH1Rtw5A8x2Zv9PfI/kJm
         /RB2E0BwLdvrj5hRZA5LHPeMsjiuTvn9WdEXwL5mWwjV/0UcpSXGv/9RajDEpfrMVxeD
         N1m0fwNo7nP1FXq39GMvd1Yx+vQV3x+M7/6B9VgEdTgE7JrCRRYIM3vTelGZpzCr1Mc+
         2YcZZpnzOZGmTZxqm22O2wKq6iblIy6rBx5g7E7R0DjimKl6Jxaqb/0qDJriJno0pPjz
         emqw==
X-Gm-Message-State: AOJu0YyodOj4Oqr2vJqLGhzDDL/eKEmXlAWCspY3IwlCyTmTdI0A2WgL
	hEU+775A2WIqau5IaGaTZSoRepobtWhkG26tmgb4EN6M18M=
X-Google-Smtp-Source: AGHT+IGHJeQhWQxRVMZYNHEVg+GX0qoJUr59gYGSOZYNlC6nUqQiGhDep3fN9x6ul5DgMscsDfrs+fg5Tag1g01wgJE=
X-Received: by 2002:a17:906:ee9:b0:a28:b985:8da0 with SMTP id
 x9-20020a1709060ee900b00a28b9858da0mr467271eji.22.1705480662461; Wed, 17 Jan
 2024 00:37:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Wed, 17 Jan 2024 09:37:31 +0100
Message-ID: <CAKXUXMyfrM6amOR7Ysim3WNQ-Ckf9HJDqRhAoYmLXujo1UV+yA@mail.gmail.com>
Subject: Question about reference to config KERNEL_6_2
To: Johannes Berg <johannes.berg@intel.com>, Gregory Greenman <gregory.greenman@intel.com>, 
	linux-wireless <linux-wireless@vger.kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, kernel-janitors <kernel-janitors@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Dear Johannes, dear Gregory,

I am a kernel janitor checking for issues in kernel build config
options in the repository. Amongst others, I check for references to
config options that have not been defined anywhere in the tree using
an existing script in the repository,
/scripts/checkkconfigsymbols.py.

At the beginning of this year, I checked which issues were introduced
in 2023 and were not yet resolved by others or my janitor work
throughout the year. In other words, looking at some issues that
simply slipped through last year.

Commit ffbd0c8c1e7f ("wifi: mac80211: add an element parsing unit
test") and commit 730eeb17bbdd ("wifi: cfg80211: add first kunit
tests, for element defrag") add new configs that depend on
!KERNEL_6_2, but the config option KERNEL_6_2 does not exist in the
tree.

Also, Kalle Valo [1] asked during patch review about that, but did not
get any response on the mailing list.

So, what is the KERNEL_6_2 option all about? Is this something that
was just used locally for early development?

Can we just delete this dependency in these two config options?

If so, I will gladly send a patch for that.

[1] https://lore.kernel.org/all/877cp6q7ws.fsf@kernel.org/


Best regards,

Lukas

