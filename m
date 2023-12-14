Return-Path: <linux-kernel+bounces-216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98233813DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4434F1F228C9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A8F66AD6;
	Thu, 14 Dec 2023 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2mlQODcE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143C7671E0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50d11bd3144so1248e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 15:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702594985; x=1703199785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cphvl2wyh1GyJLsprr0iWOYpnSYMRlz6FGZQv5qE9aY=;
        b=2mlQODcEusuv6ZaY/m1uqrHHIbS6H5lahSzqKxnzZ6XQVDzkWxLzBZiByd5mVch2S+
         wGvWzedmmi8mx336SXOvCOxtsRIVp/rfjdJzGusZ0hmYQ9/waPsk5Af5kn/ALqZuuu0W
         zm5L16KVNqitad05mnS0kXqYOp8RNQ/DuxphA5BELM2c2FzkT7kf4WQtVe8FMsPGEvkl
         QL020CGzO5zSe3fxzcZCZ2EQRwsxhOKK2iqVQ0Yrel5GWwpbxn+EFJDTnRjlv7RrBcZT
         OFClf8wBjbz1mMruA10K5fR52bSMF/ZPNI06AIdX9joPFg31kOqYJy//ye74OIA3VAVP
         zftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702594985; x=1703199785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cphvl2wyh1GyJLsprr0iWOYpnSYMRlz6FGZQv5qE9aY=;
        b=f1nUHpG5l1DpY3yNBX0Pf2gOjSbV/eMILUsYnc2YzX//q90dpNblordbyVep0katck
         KlswNRjEB//tbv7KMO1j4hoTHtOhBJdsjqEMgMJy3hTKCLx43byFu+eWLsp3W8GMi/rU
         /AAftdaKgepdDl6agrgctW2LI6MWKZ27PvlXjHrPGqnyU6lvlMxrH6y/VWMv/rCcNcv8
         9/BkB/5lW8CavvGz2Nyh3VBM6xFe1Mq7OgnF7a/hNLLsiiE2zeWdCWBTxtGMk48TGDP8
         TSek24wBhsJRVLQxiv/RzRXv1+SQM1buU0oMqjng8YAuE79yXg5a8qTWE1aEDMoipYfx
         b+bQ==
X-Gm-Message-State: AOJu0YwT5mKJhfc4SfRKo5Jvy+94FJvmLh0K/ad4YMgIVmZVhKbydPDC
	oFPx4O9830aZ1XTb3hHd47H9VKslT6ADQtbfE5oAF9a3JJkYO/dGAjtf93L3
X-Google-Smtp-Source: AGHT+IGXb16j/LfeqtBoeO0x3fK0w00V9lsrj7lfha/L4eV4jsQEDQaHUg/9HPGFB+bKX/beNWh7ACqwFXJFkQTQH1Q=
X-Received: by 2002:a50:c082:0:b0:54c:9996:7833 with SMTP id
 k2-20020a50c082000000b0054c99967833mr718937edf.7.1702594641723; Thu, 14 Dec
 2023 14:57:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207090738.15721-12-rdbabiera@google.com> <20231207090738.15721-13-rdbabiera@google.com>
 <ZXGt2drhV/K+qtTG@kuha.fi.intel.com>
In-Reply-To: <ZXGt2drhV/K+qtTG@kuha.fi.intel.com>
From: RD Babiera <rdbabiera@google.com>
Date: Thu, 14 Dec 2023 14:57:10 -0800
Message-ID: <CALzBnUEvKWScSxjE60ONDc7KsUPDwy48rWrSKATyr2D2nQBimg@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] usb: typec: bus: provide transmit type for
 alternate mode drivers
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org, pmalani@chromium.org, 
	bleung@chromium.org, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, badhri@google.com, 
	tzungbi@kernel.org, utkarsh.h.patel@intel.com, 
	andriy.shevchenko@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heikki,

On Thu, Dec 7, 2023 at 3:34=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> Instead of forcing this change immediately on every existing user of
> that API, why not supply separate API for the cable alt modes?
>
> Although the SOP* communication is the same in most parts, at least
> Attention (and probable some other messages too) is not valid with
> cable plugs. So maybe it would be more clear to just separate SOP
> communication from SOP Prime/Double Prime in the API?

Your idea makes much more sense and simplified implementation, so
I added it to the next version of the patch set.

Thanks a lot!
---
RD

