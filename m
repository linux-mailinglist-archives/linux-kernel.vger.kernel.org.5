Return-Path: <linux-kernel+bounces-30195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92422831B52
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397911F26E30
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA40D286B0;
	Thu, 18 Jan 2024 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JgrIAM52"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A3B25618
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588074; cv=none; b=f3FraxpFgnoCFbEtluhGvnRwHcr5tULr9uT2TPUhV001YToOU3OqMN94hUjggbNjHx09at5Gn83ORcVYKHZWWtnBXCcghZp6loQ395CygW1nnzHVwoybgEia3oNl8cnG7477XghLjCQ1c5VAj/AnG3igVcCWOUuRYFYLY/qeSSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588074; c=relaxed/simple;
	bh=G1FteHCxK5UhTQkX/E13adquaqZH48Y6K07Titsk+0s=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HOmKj+f0LgZseB0K0ubxyChjC9zTCwfpOzY1RIAsSGCZ3YO6z/16WEfOVJ4XoKsOgje7pSCnx7OEFQCr1OHE0aQGbVPfL5FGn4ce5xakvT6hBr5bfyGH88rtrGrpYtDdGfDJbIPReJas5GasNyqhJGml2RvTnqE0Aa2UpWYjWfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JgrIAM52; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e86a9fc4bso31412365e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 06:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705588071; x=1706192871; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iAtIbNKuNxEk1Y8xhpCvEqYWSdM4b28s8XKzqH03fiw=;
        b=JgrIAM522D7gnlWKnR+YWe+To1TDgBV00dv9KU0gQvvaMSfJLxrMOdYNwyMfEQRO/M
         0kL3CdJQaVhzD+UUO8b4Pu5Uxrk+TX+Gur3cHLcQ9SD6YkxEhes7DjWLOoc8if9s6Gg9
         zyjd732XhDLNOSdGnxAkReOpGgRXrab2mtzZ750Xaa5+/9vLkV4UbQAnk7eIVZ2oBzhz
         0QN9eKFBFIhAyj5Eh88nPW7l0fA8Eg/bfJEt39Ma7E7CywioKtOEA6un+bGeGpj6OpPk
         ZADWR0AlyGM5G3pt6WHf5G5P7Z9c4LHYzn7c3zfcUd8W2Rz2WV8+kMpUM8iP7ivg0Jwv
         99bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705588071; x=1706192871;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAtIbNKuNxEk1Y8xhpCvEqYWSdM4b28s8XKzqH03fiw=;
        b=Rh1bsve5EYKVX+4l958HEeY2y1woPpCA+se5Gs16Uew5iLET0cTAkNS9CcIbEKsD4H
         6bBaZcEscQTOQyi9pPB4YiG3YdTR1vme0uwl334uS3FvLjyy8wNCGubSoONUFhHOsjHX
         zAi1mVDRjUsdC4eUCIrFHY1ghUsuHfwaOpzRMzWHIB5AnNQYzbCSP5fGYvd3wmwunsiT
         wBHQH4LOZAooCO5qv1rSG4ZdDeqL00JLcQoQmY9hCKf+aU0AFMhA2khAxk6a8uzrdhG+
         NUmEFrNBc8SYTYvliTN7YFh5GPXLpC0u3mi9yE0+cNHVc/frSan8dqDRenO5l4czWwTe
         zRVA==
X-Gm-Message-State: AOJu0YxdccoScJ0KkOxCMCBbgzV93E6QwRAWdNYCJzpxkxGVU1rLVnrk
	+eXxQwReUAvXRFfO1n5p8Mvbz8TX04PGZJKdTRdgOKkBibiSBkDN9FUHmhEPbf+36NxRThvj0En
	1fH8=
X-Google-Smtp-Source: AGHT+IH7fxW4RabfdxWslJCnZa4eIlBF9xGHdSdq5lOPDbCzvqkPFSh7T8fUqdYO4M8Zt14Pb0pNsQ==
X-Received: by 2002:a05:600c:2309:b0:40e:485c:ae84 with SMTP id 9-20020a05600c230900b0040e485cae84mr548466wmo.9.1705588070681;
        Thu, 18 Jan 2024 06:27:50 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c469000b0040e39cbf2a4sm30242909wmo.42.2024.01.18.06.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 06:27:50 -0800 (PST)
Date: Thu, 18 Jan 2024 14:27:48 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [GIT PULL] kgdb changes for v6.8
Message-ID: <20240118142748.GA109045@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus

Apologies for sending this so late in merge window, especially given as
you will see from the diffstat I can hardly claim to be overworked in
this regard!

Anyhow... the following changes since commit
610a9b8f49fbcf1100716370d3b5f6f884a2835a:

  Linux 6.7-rc8 (2023-12-31 12:51:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-6.8-rc1

for you to fetch changes up to 4f41d30cd6dc865c3cbc1a852372321eba6d4e4c:

  kdb: Fix a potential buffer overflow in kdb_local() (2024-01-17 17:19:06 +0000)

----------------------------------------------------------------
kgdb patches for 6.8

The entire changeset for kgdb this cycle is a single two-line change to
remove some deadcode that, had it not been dead, would have called
strncpy() in an unsafe manner.

To be fair there were other modest clean ups were discussed this cycle
but they are not finalized and will have to wait until next time.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Christophe JAILLET (1):
      kdb: Fix a potential buffer overflow in kdb_local()

 kernel/debug/kdb/kdb_main.c | 2 --
 1 file changed, 2 deletions(-)

