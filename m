Return-Path: <linux-kernel+bounces-97308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6845C87688D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0D41C22361
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED6416FF34;
	Fri,  8 Mar 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0hre7N0"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3652D36D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915599; cv=none; b=aQM+rFIx7Jd9WBxjiY1A+aoS7XflOl++J5WntzYuyrZZ2RWYaVn+laJlM5vI18ifXwRrpOJNxK1frkW2XND1l7fAbve5d7V8Kk/LJ8/dO9WuWwMKqfE/1l2Jixh4+93z3pkUV5U7jQalTu/NKKKhx7I94snbzCCSaxvWbECIwhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915599; c=relaxed/simple;
	bh=YLr6G3rAMNcVza6oIHRd6RKxX87uDcHfFYf/FpowA9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcG5c7ge7tYVN2l8CLMJHPlDLGeUJuaUar3bevfprHXiEz5eXW3/hF34PbGAyf4g3uq620WCdCVBddO5Zo8VixqxggBP84i6lp/zlYtLOF+R6XbnfHKhBqirJJzEtc7nAZFm56yO5L/nUvDNe/GGaynmmVtSHmgSti3x+WUOBzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0hre7N0; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a293f2280c7so367200566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 08:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709915596; x=1710520396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUeIfZJ43gO8lAwOVHd9gk61hYVExWZlcr16GPR9ZJ8=;
        b=d0hre7N0DLC0n+3Sdr10AkiaL1KeWg2odY+czhV9qnRDHpkpsSm/6tLICxTsOog/Ny
         BTBAgtqUcq1IzzBODIeKfNxPN4ib1CHHJLEz7Fc72dsQXvCCFLXiB2zH3WeyZenwm5Tw
         xAikXDO7uCM06JKBSLNv7ihRUB/HUOBf8aAa/5mB/2f0BhBKN1bSb1w/o5o8/25TJn82
         Y71Z5ixy9JqN4qZqkID/tNHhqOYkFMW6XZIdC5lUh668ckVpvEGe0SM4opdWi9hy6evY
         V7N+1FFBbZ5osCA7x6fICUxssUphaugHwCMEsxh8ZQJMd7adjECs6QI6SS3Xd2K7lW5A
         iS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709915596; x=1710520396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUeIfZJ43gO8lAwOVHd9gk61hYVExWZlcr16GPR9ZJ8=;
        b=q63V7VaSzOHmCDm4aOGW90fKPLdGYEHhjlGAndIbTK/GVAexiXfStbrDtzWTiKexeu
         raL74doKCry9F3TL9DhFvPcqQMj7/A+ozvLldElldvi6n8wnCDDBkGMV054vi4ZvNlGa
         KJfNRgbvdTOa8TMmGq2/bmMYCs+T8XZ/01MrV+X5BbT4TXRf2OWJ/Eu3RZZyL/ttR5mE
         Ydg+qdw3QPR7q21zVVhl9BilJynxrmobnbMfgxHRpRI1u7XeyQ9mZSE/FuXolgKtCAFH
         zNBlz3Sec9XoQYbXKmStc5uqGYfywKFntpIQe42wkcx761ZExIBolTVnG5OoKkp4CPdz
         qgAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIvDSzFQ5zlpkJGe9r/+Wya5UfETvPFF7E3LgN0/EKV2tx+cu3LkrZMBwEUajlxt6wWr3su1aAGg498JqYPJsCqpFF5yej0y4PGtIJ
X-Gm-Message-State: AOJu0YzJD6h7RaCaInftZWfppeMERNNKcvLbJVmxn93yOKPLQI3kDEZI
	wP4fegSkY2BEqbpsU0A4A0ZB9AKlXveC1fBPDAVzg0/6cxZBeYpuASolcAHIPD5gQMxPvuo3iui
	+2Sej0YQr5vuVnTyu1Wpj1uXySmQ2dsgOb8G+ng==
X-Google-Smtp-Source: AGHT+IFufWYJDsITgpL7UXaFj2BN8cigArfb1h/ryoZ7D9OkY/0oqOqz+QCWLnkhrwH1vzy0xR2WiJinQTfCeoaPrYA=
X-Received: by 2002:a17:906:ce26:b0:a44:415d:fa3a with SMTP id
 sd6-20020a170906ce2600b00a44415dfa3amr14864468ejb.40.1709915596471; Fri, 08
 Mar 2024 08:33:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308015435.100968-1-brookxu.cn@gmail.com> <20240308144208.GA9194@lst.de>
 <CADtkEefTzbYN4qEAgAXDTB-+HMxfENw2m+xcoxzy83YW-bGEhA@mail.gmail.com> <20240308163100.GA17078@lst.de>
In-Reply-To: <20240308163100.GA17078@lst.de>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Sat, 9 Mar 2024 00:33:07 +0800
Message-ID: <CADtkEeeZfkJnW9-3B5r_rujjRWq7oDdJG4TtEKg8aB8+WHB1ig@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: fix reconnection fail due to reserved tag allocation
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

noted, sounds great.

Christoph Hellwig <hch@lst.de> =E4=BA=8E2024=E5=B9=B43=E6=9C=889=E6=97=A5=
=E5=91=A8=E5=85=AD 00:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Mar 09, 2024 at 12:29:27AM +0800, =E8=AE=B8=E6=98=A5=E5=85=89 wro=
te:
> > This works now, but I donot know whether
> > nvme_alloc_admin_tag_set()/nvme_alloc_io_tag_set()
> > will be suitable for all driver in future, such as driver for apple
> > device not use these two funcs
> > to init tagset (anyway it not use these two macros too), so maybe new
> > driver would use these
> > value in other position.
>
> nvme-apply should realy be converted to use the generic helpers,
> I just need some help from the maintainers.  I'll ping them.
>
> But I'm fine with just taking this bug fix as-is and clean this up
> later.

