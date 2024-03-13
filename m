Return-Path: <linux-kernel+bounces-101181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D195787A3AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D0A2833F8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA378168D0;
	Wed, 13 Mar 2024 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiDPwk/Q"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746F41FAA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710315726; cv=none; b=RR7aQwSG4heeSfHr5f4M1SOQK6fE1oNd7rk1mkYEE2CV2ZNlpR1EuI3Aejp+lWiK9fCtxyPoCtJFfg2g5+owm1SihpKsu56F49lJ7C6V2driBJKKN77V4yfjXEbsgCPD6j0WOiXus8utdeI4t+D1g4zR+BhR2wbNxzl/abGyusc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710315726; c=relaxed/simple;
	bh=fuYTIC3nVUj5MyFc0eZVYlQzJDxs+W00tM5m6Wwk9wI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQ4ZNQZ4PPnxRwUKQ1H3XFj0cDtm6e3kdL/dKrzCCbmGN53Tz7c9mb/heiZml3bcINDoIv9n940lMztdzQhigar5s7heeANsoKiNRyolT/bcgWL02uoUPiFwqS+opnamhp18Gthw4EWA+7v6t8Buh1iI2L+l4P+ITKWJ+oirhWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiDPwk/Q; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5683093ffbbso7516224a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 00:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710315723; x=1710920523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JB9ZKn1WQyo25KpHERFSuVdjhh2lPDjMXTJozAJQBhA=;
        b=TiDPwk/QJl2AyN/qjywpomgH1PqkaBS8Iu4Ncn54MLBWxVAPJdCnpPzUu0x1chgUTC
         jCvZ5U9Q70o90ggpfhBU5UsQM6212Uempw6hTwBMUJS2ugJi3f6xd7ZOHXNWaqt00caZ
         cMlnrDPso0hwP0T9gL1EZSRN27sjfSgGV4IWNErvBiLzqajO/um7IINbm1V20cz8l63t
         JZN1xtxKNc7HLazlA4j7h+S/1aQX0zD8xPJTuzfHFX5wERsPuLkJfGjUI3ZatZ54UN5A
         zHS9vkmalfNfkZ3ZcFfE2fiRcsOhFuKu8pTq42XUk65JesmJe9hPsyC6xMXeJf3uFQza
         07cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710315723; x=1710920523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JB9ZKn1WQyo25KpHERFSuVdjhh2lPDjMXTJozAJQBhA=;
        b=J64Bc+bOwziTfjmqHYE6LZSnWYHF5MGJL+uOpXVxpj07d6KMNDi3T7qoLScBbAk9qR
         WhQ+9Q9KDQH7iq8gRdIg4D8WVRHA5dR61fcceJPrbq/aYZ5LDX7FL/AV6hZuLUB9r3oK
         wZhApI4JpJOadn67LG0ahfkr1Hx/XprZ3hDoVRkMXHuAqlombDTqLrdKW5ywxu15gWiM
         UHP2LI1YHJ8ik+mfrYOVSBRnfgRagVUqjnEgd3Ta5Xw/9YD01XreEh36GO/kzUvel3Z5
         JFSk/21HsoXP+u2iXzZv3b5UxsO+vFb2shxGo1CU0hpLR6BiLx7cHO93llKec2iGDhOS
         qGaA==
X-Forwarded-Encrypted: i=1; AJvYcCXNAwtTDbYH6W5iZFViIb8Xy5kKm+0o8q/f7PPtD/Vb5FGyzeH8McAqnYxMPgiATAtsX3TXFR98bfuMfszuOFYpjuke3C5s73GruQzG
X-Gm-Message-State: AOJu0Ywl8vNLe5crUthPf5pdUkcJmMDu1jXsk2sy0XrDExGKM/sKhU8p
	k7U6ru5h5uAtAStIvctlIp9kIdbeSzA/O5BnvOqan4NE3ugJMTI/iyenGE0217esr5vDBime9Rg
	65K0A5NCeGX/wwdJxT5VWLFL4ZuM=
X-Google-Smtp-Source: AGHT+IE9GcGZtZ7tNVNDUWfdNp47jXNvjT7qH+jP4m7epLAE8uVbmKGfY0phd254UGioaKZGPPU709mx3bHF2KdDHQs=
X-Received: by 2002:a17:906:cd13:b0:a43:9857:8112 with SMTP id
 oz19-20020a170906cd1300b00a4398578112mr6590474ejb.20.1710315722600; Wed, 13
 Mar 2024 00:42:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKHoSAurcujiErjTeWM+ZGkSVVOj3zQu2ED5rZsSLq-+FXb1qQ@mail.gmail.com>
 <ZfE41uSsTUmbtl6A@thinky-boi>
In-Reply-To: <ZfE41uSsTUmbtl6A@thinky-boi>
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Wed, 13 Mar 2024 15:41:51 +0800
Message-ID: <CAKHoSAsZRg5sTuLMTzSxmuP0_qBKrXvMYR2R1SZt_wNH9ONbLg@mail.gmail.com>
Subject: Re: WARNING in kvm_age_gfn
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Oliver, I have confirmed the situation about the sha1 in the
path that is my fault. I will test this crash in the latest new linux
arm version. Meanwhile, more batches of the reports will be provided
after validation on the new experiment.

Best,
Cheung Wall

On Wed, Mar 13, 2024 at 1:25=E2=80=AFPM Oliver Upton <oliver.upton@linux.de=
v> wrote:
>
> Hi,
>
> On Wed, Mar 13, 2024 at 01:02:10PM +0800, cheung wall wrote:
> > Hello,
> >
> > when using Syzkaller to fuzz the latest Linux Kernel arm64 version,
> > the following crash
>
> First, thank you. Glad to see folks are fuzzing KVM/arm64 now.
>
> > was triggered on:
> >
> > HEAD commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a  (tag: v6.7)
>
> In order for these sorts of bug reports to be actionable, they really
> need to be against a close-to-upstream tree. 6.8 is out now, and 6.9-rc1
> is right around the corner.
>
> Having said that, I think there might be an issue or two with your bot
> because...
>
> > git tree: upstream
> >
> > console output: https://pastebin.com/raw/3NCyqPUn
> >
> > kernel config: https://pastebin.com/raw/mXEg4abU
> >
> > C reproducer: https://pastebin.com/raw/N0gEqk5x
>
> This reproducer doesn't work on upstream (tested kvmarm-6.9 tag), and
>
> > WARNING: CPU: 0 PID: 711 at arch/arm64/kvm/mmu.c:1592
> > kvm_age_gfn+0x64/0xdc
> > data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/ar=
ch/arm64/kvm/mmu.c:1592
>
> The SHA1 in this path is suspiciously the same as 6.1.61. Are you
> certain the bot is working on the correct tree? Nevertheless, I think
> the WARN and associated bug were addressed in commit df6556adf27b
> ("KVM: arm64: Correctly handle page aging notifiers for unaligned
> memslot").
>
> Last thing -- I'm guessing your syzkaller runs will dredge up quite a bit
> of low-hanging bugs given how little exposure this code has had. Could
> you please aggregate the first batch of reports and send as a single
> series of email? Makes it much easier to keep track of.
>
> --
> Thanks,
> Oliver

