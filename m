Return-Path: <linux-kernel+bounces-63654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFAF8532D3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C77F1F238DE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6695786C;
	Tue, 13 Feb 2024 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwJsMTSd"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF6056767;
	Tue, 13 Feb 2024 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833898; cv=none; b=NGgHYKbcivtq3HEjnJckZBIPzp+WYtDlOCvtFxxQaqWpJydRpKwEqC6FKzmNJnm6eSm3NPW2MeIW7KDMpxq3gKztwCxxCsG73hhyGR6OJK/Cn868k50Byrb1rMm6BDbRxwD7wwUe5voziW57JDEiOtUxTGcwnl+tCRoh7bhjsF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833898; c=relaxed/simple;
	bh=1I+nakScsEDd+RcxVEQkaGNKg28+t0BKQ6XSa6ofqEg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxNRMXCN6Zr07rbNyw6vo64J2bio2msmgGjQDK0TMYqG7LI/QXFmXtEr6WHewpczMApH40I6jAel14w35NMn3TbuSiE7OJtvS63YeMyOzuFUJQIM8Q4n2/Zk/kjnQ2Yiyasug07q4ajmSXta+OUCy3g1/lajW5QhD24PtZ/IKMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwJsMTSd; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3394b892691so2913453f8f.1;
        Tue, 13 Feb 2024 06:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707833894; x=1708438694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4CwFixk8Sb3h3montNbLvFtH7zwP/nbPW/5Tg0FN3r8=;
        b=AwJsMTSdk7cc0fUuqbptElygyedHcFsMO9+re79Z47e1tPKLQkBYwxWROvVYexbaZX
         boQpKfGH6bupRZ7eAFH8f0dCSAoIHKJyOd7iMYp967t/QsgF+mXlIyxYdquAXuyWXAG2
         vcRtL0gISF4xyej5Oc3lfy1qQmjggHlfS8NqxuQv8gVKKBqQrJwE/ghEDfQ/cUXgiMRa
         i1IPFS3TqfVpfnn+sg76cecQdxcJ7KTFILtqTXma2RTbSWN/D2otx973KVUc3b8TS1TJ
         otxgvUo/eIfzGTPwpUYoA+WWDSsnBbTy97+5gKX8RMxP4GjAhZ5LoTRM6BK1lHJlcfKR
         20GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707833894; x=1708438694;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CwFixk8Sb3h3montNbLvFtH7zwP/nbPW/5Tg0FN3r8=;
        b=TSUxTa4993pIv75wL6+pKIru0g1tOBe4gGxgdB4yo+Qwui1dXvYpOJAvO0qm7KHjEm
         cKqRMjmN/0KG8xl6hJT1J4oeiEvFSiTePYHeAUc5UBGC1SMQ1a+vcueJ4lvjz0utwVzh
         dL5JdvoH9IVPxsQ/xJbyj972PiZ6aytuNzb8rzWiaFZ7KjamT12nyCa1Ae2w9nNJMYJW
         iz7Ktdfc/QZmSuw2apQVxnEX6COaeCZqmekfS2CFLzCaPVXXAE8+iW/MLKeNC4eMhJwb
         kK4tdjVJl+IDkOIwcl7PJb5B2VPJ63Nf4NBOVL3JnKB1aby1itSMCGeKtvaZBE/ZTj6E
         rMPA==
X-Forwarded-Encrypted: i=1; AJvYcCV69V8BikzsKNa5eblkt6sdGA6Il8RWk/aHpckrWQD6bxQR0ow47qxVv3I2ZdXNVhBuzU9UeOGnTY/2xaXoLIIzxgnnRc1Q7Aa7Bs37L8jvApDG+gF39ue+bK1fgZZqtEuTYH+p
X-Gm-Message-State: AOJu0Yw/gEIn6X4uj+FxJz0IctPCDk/YyXEgwpwMR/ylhf4pwrY61892
	3L9wkNTjymYDUN3y/5YNmm6xXMERsym3vMeiT6Tc3GOEEOwAsT+w
X-Google-Smtp-Source: AGHT+IGbbm/CdV4aQ1hb87rKh17eWI7Kjy9aeM8iV3Gr2KLbguQCG1Vwwf01JIm0ZrVJIY2efu81Ng==
X-Received: by 2002:a5d:4d09:0:b0:33b:6cf0:e33f with SMTP id z9-20020a5d4d09000000b0033b6cf0e33fmr2836120wrt.7.1707833893791;
        Tue, 13 Feb 2024 06:18:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVrpfBk6Lfp2totQRT4XdY5gT+JaV2XNx555fuMg5W+MiP60nNR15gumsR6x4pOYvE2vT3QyaFeWsQklbi0CZMPms6Vg6rJdztgvtNuBLoiEwMi11e3ihmNkF8NPyYFYxmwUR/G5UUhxw+YP903ppeTJWilTfL7BRnW7xSeAwgJjFbPxr5o/VPAyAu5bZmr0OBSQDkqGGUAWsj9+pYiqJ2KfOsh1qOdbChrrJYlWqrR5iaY/cLwK8HtLBolXwUrURDHivPS+HtrpxJ5kZDWSMH7N5eYsPfkHFFAIez/lqpSouj/KoiWXOjAukGUyCdHwCk8TyaQsCtlUWm9
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id y8-20020a5d4708000000b0033b507b0abdsm9642834wrq.32.2024.02.13.06.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:18:13 -0800 (PST)
Message-ID: <65cb7a25.5d0a0220.de7b7.a1f3@mx.google.com>
X-Google-Original-Message-ID: <Zct6IWLbp0mfDLUa@Ansuel-XPS.>
Date: Tue, 13 Feb 2024 15:18:09 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: aquantia: add AQR111 and AQR111B0 PHY
 ID
References: <20240213133558.1836-1-ansuelsmth@gmail.com>
 <233cd45b-28d5-477d-a193-8273684953aa@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <233cd45b-28d5-477d-a193-8273684953aa@lunn.ch>

On Tue, Feb 13, 2024 at 03:09:57PM +0100, Andrew Lunn wrote:
> On Tue, Feb 13, 2024 at 02:35:51PM +0100, Christian Marangi wrote:
> > Add Aquantia AQR111 and AQR111B0 PHY ID. These PHY advertise 10G speed
> > but actually supports up to 5G speed, hence some manual fixup is needed.
> 
> Any chance this is a "golden screwdriver" situation? The chip really
> can do 10G, but the firmware is supposed to limit it to 5G? This is
> just a firmware "bug"?
>

From [1] the PHY can support up to 5G so yes it is a firmware bug. I can
try searching for some regs to fix the wrong provision values if really
needed.

[1] https://www.marvell.com/content/dam/marvell/en/public-collateral/transceivers/marvell-phys-transceivers-aqrate-gen3-product-brief-2019-09.pdf

-- 
	Ansuel

