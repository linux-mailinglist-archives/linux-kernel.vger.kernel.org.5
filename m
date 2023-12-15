Return-Path: <linux-kernel+bounces-899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CD28147B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB6F1C23110
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6E82C6B1;
	Fri, 15 Dec 2023 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KrEQCCw5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021462D7A2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b9dd6886e2so246967b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 04:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702642235; x=1703247035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rdz5g8JIsOq1Cbe3l1Dtqt4Oc9mqtgEioye8X2MmpJE=;
        b=KrEQCCw56JSgulwegh/qrVamr22TDg0oGj6oWWutKge9cphiAduVinYcAEyf1QlPtA
         QlgDBg+/pDrauOypPJKECFURVYxXeZDR5XeteFJPPN31zSKHXxwxyjfzPGiREhXKA1g4
         /LsgyP72Li1mPfgCP41PZghbbxPaStSOBX6cnmX8M0huDwSBLJcyvId9gInHVtqbDstv
         3me2eQxlPK+nPeexjEgdxqoaobPhogFQ+/o48tfcysVMGRu8NvBfDNzelq9xDFsudqZR
         xOkOAcQxcDtLzsmgOZPMlh9lXQvYUItv0P7ZsOSVo8Tjk/MOo14OaL39gvhLMVf+i7Ao
         dySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702642235; x=1703247035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rdz5g8JIsOq1Cbe3l1Dtqt4Oc9mqtgEioye8X2MmpJE=;
        b=UlstVthHCNggVs/v5G33DH6IaedmCYpksuAzbz8OfIB7Nqxz3XYfVo4ypNAtm671Jj
         Js92pFTiPrgCRdyHEW50apP35W5v6GRM2FhTOADpSjaa4Et8LHJsSGaPT1cUhMZ0Sdqn
         6lVoBNyt0bPmM7DUxQ7vCZCZsx6US78NkNXz0PAb4p844O/H6pjy9sw3qWOTJXPDkZsL
         JaSzpbL8lYjtkMS0rzPnluJODwcQj9KW4/19qbxiRFv61l5W8bdPPrzO9P/QTAf4JneC
         gqM5dP7Il/L8hQqpANR/y9ktur0FWpt/MgQ1WF+clMZRv7BD6eYumhPr685LTato+Z7X
         ddyQ==
X-Gm-Message-State: AOJu0YytIJWi4CK2gaTTEFYVC+/PpDk4m5IJfBHiS6EhRTSFRQTMHlrP
	8FHMbdeKlshVSLOsgbQ8Yl0RGZkhJfeeGVysqf/x/g==
X-Google-Smtp-Source: AGHT+IHw8KfOLr4wweU0WvNfNFZsz6TpTv4zZskhdTsim+mkMrxkExM3yX2jf2+qysG2Rfaj9Z7MbOc0PCYYxVNN2Ss=
X-Received: by 2002:a05:6808:164d:b0:3ba:964:1742 with SMTP id
 az13-20020a056808164d00b003ba09641742mr6912482oib.20.1702642234999; Fri, 15
 Dec 2023 04:10:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202312151816.munFeE4L-lkp@intel.com/> <f06a9b6eac184cc648ae7444c480add6da87a84d.1702639801.git.namcao@linutronix.de>
In-Reply-To: <f06a9b6eac184cc648ae7444c480add6da87a84d.1702639801.git.namcao@linutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 15 Dec 2023 13:10:24 +0100
Message-ID: <CACRpkdYtzmMrUAKcLfA=i5qmsddxw6afH9zKtiMS95EtatMsAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: pl022: delete description of cur_msg
To: Nam Cao <namcao@linutronix.de>
Cc: broonie@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 12:33=E2=80=AFPM Nam Cao <namcao@linutronix.de> wro=
te:

> The variable cur_msg was removed, but its description is left behind.
> Delete this description.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312151816.munFeE4L-lkp@i=
ntel.com/
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

