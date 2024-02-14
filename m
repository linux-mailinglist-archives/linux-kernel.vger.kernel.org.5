Return-Path: <linux-kernel+bounces-65995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1349C8554F9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42B528452F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984D21B7E2;
	Wed, 14 Feb 2024 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F32IyfOs"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEAD13EFF5
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946656; cv=none; b=W4g7QrAMf+371+mGo/jPYfYP54pwLxSXuY16bPmv94td0bNKRzRy3V0dEMItBIxpb/UIyZIjVKQjLQq8y3RhKq9mOFoadLlihp1McYJ/iPM2OiUZz7KLppAfvNMPjYsKBZed+293yOAo229bYB/hEPtIlEyHfzJPkhNsT7XoiVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946656; c=relaxed/simple;
	bh=rTR0KwEV3pN6LQgr03O1fGeN2jOztRwS9iqPUavn6rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWIigZx/MBZFckf8iWoGmPqThgQFYzmDNni9rb9DFlR7q/0bv5XANcpJDoAZY2wTvvuR95VWsVdfT74I6qDbowksLvjmhHX6vSajCTX2JYVdmclmHB/Wz2ypfbv+V1iYAUJbpJr+VT3f4oWg7neEWYt9zxwMf70dnQZ62x5r3nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F32IyfOs; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a26f73732c5so20063466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707946653; x=1708551453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ir/unotnfD5rMdtsGoyJfuSxeOlSTFmP2bDl4ko9QIQ=;
        b=F32IyfOsrm+T+CJX6/WvoP80dYy6ETeXGlbVRkaicnVqz8HvvY3cja/Y8P7muR23xZ
         OsKkSkhqpIpGytV2UwPpJ+fkpZKt2aAcTPLbmsuqVMzQDUv2rMYGhG6HzaQZ6nVl2C0x
         FJR6G8SEeAU2KpoeYk4ifDrWrpQ9KcnMEUqOwnItZ0x+sV2zs8r4oF1NF5aD9LpfwDYj
         MvHyA8er3UoPYiC/VdE9dRgtbngpRCNiWTwX9QB+MPYsgodpXnfCup5Pt3Q1OkLiy5iG
         ApSaGkXX9HKvZUJPpl9lclKp+MbJfABnpUcbU4xhBRieU4EsipgcpZp3CRDK5IEgmmvE
         wc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707946653; x=1708551453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ir/unotnfD5rMdtsGoyJfuSxeOlSTFmP2bDl4ko9QIQ=;
        b=TDBsviFuQNSFUXajQ4k6HEzg/GNNJuC4A36II/OmEb/kvotW4oAUMWKyR67PRGs1Qx
         LsmkG/okajcBr8tHkzPjc+RyIdz3CfqlyH7PccNU+n2eg8xnt+fuC+BIIDVwNKpuG7QZ
         mfd7QZYzT8S79YYdeFMuvPk2A1OfQmo0PdeozZP+CrkVPd7dPkmMpIOK8PjZtX4RCnIh
         0XuRPIICRit1U5Ih/t1/4QfFajlHDkISfIxh/8dJ2v7JuUKAS6wYvsCyYpD9BfXa+eQv
         RBuJRHcJzslDxUrEiIulrfwskMfsMiPV3w1+Lgvm6BmHf7gF9BfueDw4u85d6gf6RdxB
         cz2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlyZzy5G3jZGjq5GlY0KmGjd3ZNH+NRfwFfPNmTJ9zNUGay3WkVpQFpcW2p5e7olclXgZu702RSsnYzpNu9fjDokWtHIGcMUujOhUA
X-Gm-Message-State: AOJu0YysmuUkV2OZWIKkfxmhw3kMrSWJ9nfsYfrL/z2JsEw8RoNXluak
	dQdYF3u4CptZ0mh4wKntccOhwlJ6dvVzZMDldY9AhDL155i11uzQoC/ncmLjwio=
X-Google-Smtp-Source: AGHT+IHk8JLhkU3PqjlB3r1X7UjDpDlD05JGbvpAVKzdIOh6hcCu0LS+v/I1vied8tFOXqlMkHNH4g==
X-Received: by 2002:a17:906:ccc1:b0:a3d:30a0:2e79 with SMTP id ot1-20020a170906ccc100b00a3d30a02e79mr2565149ejb.54.1707946653601;
        Wed, 14 Feb 2024 13:37:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWf55Ibmdxn4mP1NgfJga60DJOumX4O0k/ju9udq+ijqg03KBqFzNuxp3XkGYlC8PLAgOML2h7P9FIrghvOxk+13ZbEiPwSDSQpzylyKcGKntugzulOXfO+UO0HJWUMaqvCtevi42PRrUUzUS/BXVaAnsPCZC/Oyp1WTdnoNVxdUl+Q/KiUx+tTpiXOcnfxIQlJBxP/YAuDrCiniNFjo24YgFRBqo4nznj4EKhPoBPPe6Xk1vCO3tz+0OO7F2YPl5wZAgtZicZTKn+kA0Ee7eAHqaB/QuO4hnkES/QspkiETCivrxFxKUBnNk9GepzntLozlmbkNCQVFg5F3PnRJ2SHFpX81NPX4ua6xQCF7KGxdftPmEEb60b3KfHRaxI8+qf+9lKArK5F7+YfQnM6yTVzZ/lbYBqPnCsF8ERlRsMjex4BvwfrPksIMGVL5h03HdQxtVn9pfBqTxB+ceGzYV88sL/GGwpt/zOx2WWJJkTRKegN/sMgqQ==
Received: from linaro.org ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b00a3cf243de37sm2249089ejc.111.2024.02.14.13.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 13:37:33 -0800 (PST)
Date: Wed, 14 Feb 2024 23:37:31 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RFC v3 2/4] spmi: pmic-arb: Make the APID init a version
 operation
Message-ID: <Zc0ymyR87km2rZjW@linaro.org>
References: <20240214-spmi-multi-master-support-v3-0-0bae0ef04faf@linaro.org>
 <20240214-spmi-multi-master-support-v3-2-0bae0ef04faf@linaro.org>
 <d9f88786-abe3-4826-adbd-fee461a70c2c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9f88786-abe3-4826-adbd-fee461a70c2c@linaro.org>

On 24-02-14 22:16:58, Konrad Dybcio wrote:
> On 14.02.2024 22:13, Abel Vesa wrote:
> > Rather than using conditionals in probe function, add the APID init
> > as a version specific operation. Due to v7, which supports multiple
> > buses, pass on the bus index to be used for sorting out the apid base
> > and count.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> 
> [...]
> 
> 
> > +
> >  /*
> >   * v5 offset per ee and per apid for observer channels and per apid for
> >   * read/write channels.
> > @@ -1178,6 +1246,49 @@ static int pmic_arb_offset_v5(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
> >  	return offset;
> >  }
> >  
> > +/*
> > + * Only v7 supports 2 bus buses. Each bus will get a different apid count,
> 
> "bus buses"?

Urgh. Will fix in the next version.

> 
> Konrad

