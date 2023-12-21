Return-Path: <linux-kernel+bounces-8903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 339C881BDF9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2DFAB21D53
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6346350B;
	Thu, 21 Dec 2023 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PzaVHwf3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C42634F5
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dbdbfaab70eso988897276.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703182608; x=1703787408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nyMLgLGAFCwB8tigzL3zmg0fWOPsybCh7CewIziIx18=;
        b=PzaVHwf3bnIVaEYmaMtoFhjA0TJYZJKa/q/WmBIyKiLo5U+Em4vxWoCMNZ2USWmnBW
         dVdhyT3J22SakSsMqYiKX8DY6VY4N9IEKgU1xx2d7dsZ3BnMVVzUmFT4x4pvntKU4Va6
         INNiezQbtip1s5ikq1O9K6ce3gVmvGNjpu+50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703182608; x=1703787408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyMLgLGAFCwB8tigzL3zmg0fWOPsybCh7CewIziIx18=;
        b=QAipJJfvQn2vCng4FHuiYmQEfFGIhQei+EX2x7Ichy0yWyawH4HD/K+BdRXcVAKQF9
         0CtjqgguAmurJaM57ZRfGt1NzgDhVF4pDDHZ43eNr90+KpN+nWJjPJoLL29yT7e1Kyql
         RfjHCR6uU4U9nhhtvX3qJq6qv+EE70f9j4bz1kMh+WJcZ9SsfG898Dik3VKRlWdF3xyZ
         Qw+ek0ER24RNEyDosxpB4KGNxSwMU2IYV/EzHtx1LxsuRDUDdRuHYiZD3YjQBreXDSe+
         BKPZFx4m38mmDEen6YhkNSec4N2sn/sCeI7qJkiE9SxgHdW+CpQDU6A3EVeBmvZYJNp4
         pvQA==
X-Gm-Message-State: AOJu0Yy/gHVktjvNQnm0Z87fet9UTlM1XDhBLTB0bznMwpCH7zWl1lrA
	5EAe0o4sUvc/MHLpbOeh07Ba0Z43KR6swyspsrNyPtjNdiqG
X-Google-Smtp-Source: AGHT+IEz2hEouqtFpi9y297UCAmL1hayY/sHAX9vot3iBwQrrLhdG3TcbADflkdpdeiHilF5fsnb81+c8Xz+HGLa+yA=
X-Received: by 2002:a5b:94c:0:b0:dbd:5ab8:1dbc with SMTP id
 x12-20020a5b094c000000b00dbd5ab81dbcmr128760ybq.108.1703182608426; Thu, 21
 Dec 2023 10:16:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.3.I1016a45ac9e8daf8a9ebc9854ab90ec3542e7c30@changeid> <bc1731e0-0770-4bc9-abd7-239733a03d95@linaro.org>
In-Reply-To: <bc1731e0-0770-4bc9-abd7-239733a03d95@linaro.org>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Thu, 21 Dec 2023 11:16:36 -0700
Message-ID: <CANg-bXBfEb1jBBsBJse7jmV1V8v=6Qe_NhTLNyYhjqmad+yv9g@mail.gmail.com>
Subject: Re: [PATCH v2 03/22] Documentation: devicetree: Clarify wording for
 wakeup-source property
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Raul Rangel <rrangel@chromium.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.
>
> You nicely skipped all my filters... No need to resend to fix this, but
> fix it if sending a new version.

I picked up the tags by using that exact command against "wakeup-source.txt".
"Documentation: devicetree:" was used in the originating commit and is
why I used it. There isn't really a consistent history wrt to tags on
this file. Looking at the containing directory, "dt-bindings: power"
looks pretty common. I'll use that unless you'd prefer something else.

