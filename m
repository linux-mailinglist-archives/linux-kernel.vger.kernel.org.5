Return-Path: <linux-kernel+bounces-42944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7BF84091F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1177285778
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF271534F0;
	Mon, 29 Jan 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq+PBRE4"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901DD60DEF;
	Mon, 29 Jan 2024 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540199; cv=none; b=L2g/8QPcABCjk//00pO9wxXcN6vrFa5cltxqXvvGKJFaYQtEQJYVZIDMmrSzOmbjyybzMVi51tTjhsSFPz9HY5KMoryTCthonwxf0PuGtJfumFQSPSVKtlaLPsaLeuS8SIuBhAo3ruzenmTzISgNuORPCy1MLHwwueKLUTyWk+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540199; c=relaxed/simple;
	bh=kaaVpI7LDaG0uH0fkT3XOQiB7JqvFksV/AM/Syz+XVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNpb3tP6L6rW1yNItqpUSEuRaGPKVIqidiAkThISD9c5SsXTH0nNVKtaVpeGzM0mQ/WXo8ecxbIHH9+TbxvJeDC6ot3t9FJ12cbVZe0G3Va2qGY9gNhXtfyRd0h8ZPJRGLQYwcmkvCePnsTMgWU9i+wq1unVuphyK6zBwlWThmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zq+PBRE4; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5110ef21c76so1785137e87.1;
        Mon, 29 Jan 2024 06:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706540195; x=1707144995; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NAJkJkcPwG8nuRAAgJpfIK0vVFsBkG5KrzaQLnD/SnY=;
        b=Zq+PBRE41tf1vYgoM3IBdJUziIGE9wdjEGuZZMQLbYaV/xPWzPNgcfY7fWTBQRk4zk
         MS7MQUzWavx30ygoTbcomXjdTdkdnDK0lbOMFNSOC+Jge3QKu3NtgMGhkZakX/D3+0Mg
         GS6yd9mAQ0ryDzXSA5f8JbJbDWBCWBeSTzcTnZkThmuErWDhEp06azJ50Xh2e0uVWa8G
         k0VcgBYs+R4o5MfEDjBfPm1c0m5HCDEYQzQXvPMlwNSCuU1EVmyU9XjI73bP9Rv6boeO
         fQ+22zSwF4MByA6ZDbH7eC2YLxawNGCHgJgsDUFTG0XXta5WDZ4W8iWDWdoKo9R7phF2
         ImPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706540195; x=1707144995;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAJkJkcPwG8nuRAAgJpfIK0vVFsBkG5KrzaQLnD/SnY=;
        b=Ty//+Slnr8Y4Em1L6KeGxzjiUPJI5It5FNavBFmWQBt3sWbNlU7BgKnn1U7XMhlSF/
         SeqLWMH5FszW7Jbs3zA27jx5oHJtfLkUVir6TZTAf5odm3Phu/SxI8n4ot+EVfCkOE9d
         Y7Gimi5lcDxX9OKb18A+jYMUPKwBsLMticKQBa6aAxAEykZ3/saTA1NmJo3EWTSf573Z
         a2s79jSbJhGzfD4rXuZT5154THlu3YSjQXzdzgDFUvn+H7v+r2PHQkq87sQ5wEM8fSql
         bcIHMCAhqQAIBuCDjThtKmQjWOvz/REft8YaQm6lAXNt5jm8vP5YdzX1zuDr+P8PBMOz
         iQyw==
X-Gm-Message-State: AOJu0YyTOyO5y/j01hIYmvS0fJUJX4Q+0xOoN8kyxuVGVzenSmkxsRNn
	RcJkWrP3uahb1Kj7dUfY1EfWhmL8ZvhQRj8LfOwCWlqQRHBG/KSm
X-Google-Smtp-Source: AGHT+IGacQrN++ehCAVKGus4IrAPseuvrd7OjNWz6Lp7W5tyukehnQ014tLZGJdF3E7iJXqrnB5sAg==
X-Received: by 2002:a19:7506:0:b0:510:6e7:6999 with SMTP id y6-20020a197506000000b0051006e76999mr3854595lfe.45.1706540195125;
        Mon, 29 Jan 2024 06:56:35 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090634ce00b00a35a11fd795sm1561216ejb.129.2024.01.29.06.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:56:34 -0800 (PST)
Date: Mon, 29 Jan 2024 16:56:32 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: remove OF-based MDIO bus registration
 from DSA core
Message-ID: <20240129145632.d2mu6vbwcqhjpyty@skbuf>
References: <20240122053348.6589-1-arinc.unal@arinc9.com>
 <20240123154431.gwhufnatxjppnm64@skbuf>
 <d32d17ed-87b5-4032-b310-f387cea72837@arinc9.com>
 <CAJq09z6pidHvtv=3F_yKHDdY89kzYSF+xh89pzg1raAiQPMyMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJq09z6pidHvtv=3F_yKHDdY89kzYSF+xh89pzg1raAiQPMyMg@mail.gmail.com>

On Sat, Jan 27, 2024 at 11:23:33PM -0300, Luiz Angelo Daros de Luca wrote:
> > > IIUC, Luiz made the original patch for the realtek switches. Shouldn't
> > > we wait until realtek registers ds->user_mii_bus on its own, before
> > > reverting? Otherwise, you're basically saying that Luiz made the DSA
> > > core patch without needing it.
> >
> > My findings point to that. Luiz made the patch to optionally register the
> > MDIO bus of the MDIO controlled Realtek switches OF-based. So it's not
> > necessary to wait.
> 
> Back in the time when I wrote that code, with the phy_read/write in
> dsa_switch_ops, the OF node was only required to associate IRQ to each
> port. Until my patch to register its own mdiobus driver lands (I hope
> that happens before the next version), the port status will fall back
> to polling. I don't think it is a critical feature but I'll let the
> maintainers decide. ACK for me.
> 
> Regards,
> 
> Luiz

It isn't really great that this loses IRQ support for Realtek internal PHYs,
especially since Arınç's commit message did not estimate this would happen.

I don't see why this patch could not wait until you resubmit the realtek
consolidation set and it gets accepted.

