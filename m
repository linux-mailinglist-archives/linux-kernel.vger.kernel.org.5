Return-Path: <linux-kernel+bounces-49503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F369E846B30
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242851C26995
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A0560256;
	Fri,  2 Feb 2024 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lpOw8qrT"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5992D5FF13
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863721; cv=none; b=FZCQuhWtWN8eAW74keLI5Hl+XfvF+07Jwf2ChZLJveYN1Un7vEXfivfsmW2VM7qZANw3N6r53RoFFKYATxtHfy0sZivaBuQVAMn1k8tMwYhKOOeh02HkyKKYgvD8GQqh983IXntjbiY34NYqaew+iKGv/HQUitOYBGTaiABnspo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863721; c=relaxed/simple;
	bh=sxX6A1jY2QUTnGziquDNeweaFL0CvM8/+UjRl9k6dKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSVaY0y5XfRULNeFyv69IGY93yHQoSyqrpbkWKt9ciC2cztq6DQiliKUZZk8N58opQV4v9pdCnVGgTT8gwS37agVRkQ5vYy9AzYlnEZ4lx5xCKetLlRs3VyzDY1yDOcxMNhteI3/oobH+8I5EQ5RRt/VblC0za5Y8Vf/q53ABDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lpOw8qrT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d73066880eso15971605ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706863720; x=1707468520; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TItsROaQHyjEbJFLwPA4KC7BHoQVWA8FloUjcj8REgk=;
        b=lpOw8qrT/7eEPoth7zOhVcLEX9OJWruHy4yfIfIdqquPCOvj67p5PV4ysnSJnTnSEW
         qCwxnCOsE7nfCHNbgbIJwaz0M47byGNvhfWcaP0XNotebjeCXZcy9+zH09oTXXgunGO6
         Nq/kYlqIz+ZHMwJlGCFVp7Wn0NFGLegQQdCbIkR1Dw2NlA2p8oXAuFSlyxzFUwq976c8
         M5MpsXewjGUnFOrvBLuMfQVErU35kcW6O+bEIOHzvAmiA0ytXdAnV96XTQIr+j9pXjsI
         nwicTAbaFkyI3IAfO2vAvHLlB0i5yud7pRqT/hW5SwIb3sjjWDc2eEVe3u3Tc2VOmZpD
         aJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863720; x=1707468520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TItsROaQHyjEbJFLwPA4KC7BHoQVWA8FloUjcj8REgk=;
        b=j3K52nHef8o/B4iMwIT+XSJ7ZP4Ld4wCvb9f60KywZ+XkkKEcNAEkB9gsmCG5rbidq
         hOXs9dN/zWmqNj2is/09C/JbfJwUigq0nKHpxRSApAGYOFZfLV3LW110oMhY/AbJpNPb
         fs0rSrT3YrjGiAGpLKFEI6XibghIQbcTXOa67PBNbNn/ok4gMGEgIrEyOb5RxuIHO79L
         tGp/kkWXgMvE5NIadbqx7q3ZQom9hLNQNNCot0H4Royskk7PZJGmHcMQeQXqlQ9vrckr
         EQJwY4OP+l2AtUdNUNNmvXbJT0b3XWVG+LYsyRRb9r2f5zZV69Bzm66DozSANlkTxZZV
         MiXQ==
X-Gm-Message-State: AOJu0YxQsMCZPNvNv5wq2126MZ7lIyDDLcymg3bWRNmwokee+LKkxP+t
	lI0wP3AznrqMMsMHOFKwGKPBgcHNN60hqBiJkEnoWFfmtyaYrwWt9quiM33AgX4=
X-Google-Smtp-Source: AGHT+IFKJTKBJ1qZaEdzHRI6R3ULv7nSG6aIb1erLw8eof4kdB83jJqiV5IsTHm9r+TtHnCR1jZmWQ==
X-Received: by 2002:a17:90a:9415:b0:293:eaec:fd67 with SMTP id r21-20020a17090a941500b00293eaecfd67mr7058447pjo.14.1706863719736;
        Fri, 02 Feb 2024 00:48:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXTEwJbtE+hsf4fe9iCtFquFGaddaPiWZ6SnyAr0Einu4dhTiJbRdR7UsVh3wDijhbLCJy4cgq+WMa32kNB4DVIJ2CTvjvXu0QA+jepl2n5oU047rQfjh9yHEHsiiZ+3aZVPN2LIIzPHR59vKArcMIcOGJnWSGcxBhqXb0TN0G04w4wTYfPowAIDmztFuw3hXmNVpH/zvuBW4p/QvlVMswA4AJlDPiFke0+cJC8VBOZEPAQgzm4hnXEjuGRTNbSYioOI/Q++uuarI9wkhlxcl5I/iYC8zOTF+O5BAWMOKXF8GJmHwEOCoeUxQ21aQ/KeZpdSNG+68oMJ51E2GniW1hMaJrxApOTFBMSMCQGwlT0ne8wRSNvA2p5z5j4f9Y1MkgOUW/sdryWa5PgJxIHDqPHSheCrCT7xbEOIL8mNdusCKQpve8UzaMbCRG6fEz3HztBo4io4GCsbdgYf/1hEo6jY7yscTM4euX7ng586XMYFPY4lUWHwAeHZb1XYtHyRIKmbQ43J31dY25rJbxYBSi2SXlZTf1I+etr5v6pZjLBurjzWF9YzWmS602pOBZV+Th8SH99xW9a0+HO/D+WYHwmaRpdLRXX+xGrUGyJKI4iS992HPL5L2yc2C19Aiu/pkxxCLNMOjjMh6SewbZHG5CEqgva9cPnS9GJGjqgxTvbudduv7QTe0cO9p6r6VSsC1kZ
Received: from sunil-laptop ([106.51.184.12])
        by smtp.gmail.com with ESMTPSA id kb3-20020a17090ae7c300b0029647c140ddsm564007pjb.17.2024.02.02.00.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:48:39 -0800 (PST)
Date: Fri, 2 Feb 2024 14:18:31 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo Xu <haibo1.xu@intel.com>
Subject: Re: [RFC PATCH v2 05/21] pnp.h: Return -EPROBE_DEFER for disabled
 IRQ resource in pnp_irq()
Message-ID: <ZbysXzWX6FH5e6AH@sunil-laptop>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
 <20231025202344.581132-6-sunilvl@ventanamicro.com>
 <CAJZ5v0hHYa4c2U-tegdBtoTak=MirXwyBXbN9yrWPx_x-+yMzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hHYa4c2U-tegdBtoTak=MirXwyBXbN9yrWPx_x-+yMzg@mail.gmail.com>

On Thu, Feb 01, 2024 at 07:00:51PM +0100, Rafael J. Wysocki wrote:
> On Wed, Oct 25, 2023 at 10:24 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > To support deferred PNP driver probe, pnp_irq() must return -EPROBE_DEFER
> > so that the device driver can do deferred probe if the interrupt controller
> > is not probed early.
> >
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  include/linux/pnp.h | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/pnp.h b/include/linux/pnp.h
> > index c2a7cfbca713..21cf833789fb 100644
> > --- a/include/linux/pnp.h
> > +++ b/include/linux/pnp.h
> > @@ -147,12 +147,18 @@ static inline resource_size_t pnp_mem_len(struct pnp_dev *dev,
> >  }
> >
> >
> > -static inline resource_size_t pnp_irq(struct pnp_dev *dev, unsigned int bar)
> > +static inline int pnp_irq(struct pnp_dev *dev, unsigned int bar)
> >  {
> >         struct resource *res = pnp_get_resource(dev, IORESOURCE_IRQ, bar);
> >
> > -       if (pnp_resource_valid(res))
> > +       if (pnp_resource_valid(res)) {
> > +#if IS_ENABLED(CONFIG_ARCH_ACPI_DEFERRED_GSI)
> > +               if (!pnp_resource_enabled(res))
> > +                       return -EPROBE_DEFER;
> > +#endif
> 
> What would be wrong with
> 
> if (IS_ENABLED(CONFIG_ARCH_ACPI_DEFERRED_GSI) && !pnp_resource_enabled(res))
>         return -EPROBE_DEFER;
> 
> ?
Hi Rafael,

Actually, this is v2 version of the patch and there is recent v3. Please
take a look at [1] for the latest version.

However, your comment is still valid for v3. I will update as you
mentioned.

[1] - https://lore.kernel.org/linux-arm-kernel/20231219174526.2235150-7-sunilvl@ventanamicro.com/

Thanks,
Sunil
> 
> > +
> >                 return res->start;
> > +       }
> >         return -1;
> >  }
> >
> > --
> > 2.39.2
> >

