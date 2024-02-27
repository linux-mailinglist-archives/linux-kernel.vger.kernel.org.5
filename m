Return-Path: <linux-kernel+bounces-83239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE99E8690A5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ABEB1F25C78
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EDA13AA20;
	Tue, 27 Feb 2024 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MohDgq/G"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C03713A87E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037170; cv=none; b=q0mNTn70NSii4u4zbMgnPL+Igmm2ZuDXqXLDO3msuDPKlOuCQARM8u6uHPnjdpAXfpE1leYp9haq3rRUdmRnqwE/+AlvBKEtHXP2+VhkoWhAmyf01gBlXZXqDi4slVrYlFMIB02ENtK3ICqkBIXw2KNb7BXl4f94MJqexyGn+OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037170; c=relaxed/simple;
	bh=PSjXZXB/iL1gAI7UZkVx6aFnFooNh3+sIUM9+ah4aho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogdDdT1nVc5/EZwK6LVz1iCVxTpr+xRFY06kl1Z+AS5xyaD6kP7FkZWLbewmoEAbrrAt1VeMXe0tKiIB9EzjENSZgHcTeDYywdrMqdiFNTBur57qAq8395xnbu/Y4R7vE+l581GVr9blifHYaeOor6f4pMZtjiIl0U6GDWS8JjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MohDgq/G; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d7881b1843so31889735ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709037169; x=1709641969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSjXZXB/iL1gAI7UZkVx6aFnFooNh3+sIUM9+ah4aho=;
        b=MohDgq/GEFSG0z0E4knRriwRhG2Cc6gHj6KeXGt00rA/pJPGOJ9TfjCKT6xGruRIZX
         MpGlJCZC0tBNDWyWmbwe7GqrJzxsMBZWqUHifKcPA9bmOD54tPLCgrtlWi6OSOWmZZ6r
         3fNgGesJxA8xatdtm5mGOVjgkr99P9dDfUXh1pLIH2rq8Z6s2hQBw1sA9q4PzEZJ0bVO
         zJpcQlA6gcVGUe9kjpj/cJBA4DjovRWGULaw/AG9++kAfzXbaZ9LZq9HcKO8w3jnrAVW
         4au3B29ij8sQ39evLcNKARBk5x3LZqLzg/YlrQueyLUtPr8/QvWKaqFiAwoeNY/mAKnM
         cnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709037169; x=1709641969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSjXZXB/iL1gAI7UZkVx6aFnFooNh3+sIUM9+ah4aho=;
        b=cmNzUa+BDnJ1h4UY5lt/L7fdbaC0aAaRZXE3sEOwhQ/2bd1c0FChBOX2Vgr/jc4a0Z
         A6wdh+4K+k4lB3In1uAMHBQrK/ZUdY3RUOZxUr0T8SvyF9Wex0jWxjbbMiHFYrzlQIiB
         60gZe6Q4R+wiKL8WzW0jE82z9KVfwLdbo/540lHiLfNWYYoGaOo7YJYtD/g1EsqcySgx
         oF3C7KSw7eg4+IXvqEL8Bu4Y9xo4GJors7mgRq/4zvaBUa6UcqycqK6OGhL2W8c4J2Tt
         2h39fVRLDCoIJDn7FM+ijTE2SinOWbaYuI93om/FQ35sRprCvPz5i0JjgTde68dBKawv
         SgxA==
X-Forwarded-Encrypted: i=1; AJvYcCWjwjI1AwXvUdorSqDIP/br8j5VHM1R8DqItJGKwacip632F4j0oLbqIOZk0Rg9Ic3KbBCgtbhwNvhfOWbxVj2uC3zBEa5jpSYVVYEj
X-Gm-Message-State: AOJu0Yy5JgOTN9DqUVdtFxupHroc5N/AKSLEZ/vpnWPrjzH1Ya+EVj8l
	3BrXmrrgp+OmIhzZBcSBBj+iWPH8BXLxEAUa/rsSHciQ0GSgOpegH8T+ovPMXooTlrVZe4RNBsD
	5X/I0Tr3EH1q8WG0hAGM1JzondFA=
X-Google-Smtp-Source: AGHT+IHfI3z9dNBjP91sqj4IoHTWC6qMdTEdL9kDSGMGF49QjbxmXnVai+skXGLKaxzrzGUXuOCsBa5iffEE67iRjUA=
X-Received: by 2002:a17:903:2b0c:b0:1dc:bb56:9d14 with SMTP id
 mc12-20020a1709032b0c00b001dcbb569d14mr1519244plb.41.1709037168850; Tue, 27
 Feb 2024 04:32:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208002841.GA2601476@dev-arch.thelio-3990X>
 <CANiq72=G--5LW-9sg2PscTL863mFVNdnX7LUQX2Xj02qZs4crA@mail.gmail.com>
 <20240212234850.GB3221859@dev-arch.thelio-3990X> <20240213025303.GA4006766@dev-arch.thelio-3990X>
 <CANiq72npYCD-zKqcXPNOAxnKiUCCXGbFQaGo-8=0-171ni+ncQ@mail.gmail.com>
In-Reply-To: <CANiq72npYCD-zKqcXPNOAxnKiUCCXGbFQaGo-8=0-171ni+ncQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 Feb 2024 13:32:36 +0100
Message-ID: <CANiq72kcQUuxcno00+QWrstrcfwC+2_Bvh+8dr5kgVkEtrWOEA@mail.gmail.com>
Subject: Re: Prebuilt LLVM 18.1.0-rc2 uploaded
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>, Conor Dooley <Conor.Dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 9:37=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Thanks Nathan, that was quick!

Is it possible to add libclang for the older toolchains? Or are they
supposed to be immutable?

Relatedly, Connor reports KCFI not working with LLVM 18:
https://lore.kernel.org/rust-for-linux/20240227-uncertain-amaze-6197e627ad9=
5@wendy/

Thanks!

Cheers,
Miguel

