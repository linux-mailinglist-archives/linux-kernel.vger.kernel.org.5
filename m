Return-Path: <linux-kernel+bounces-23941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2A682B436
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6162868B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0246F52F78;
	Thu, 11 Jan 2024 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="edm5ent/"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EBC52F60
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a271a28aeb4so615173866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704994679; x=1705599479; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PhCoVrdbtNk6IQHDSfgyH6zuFvjv3tDoIQvmJczMbPo=;
        b=edm5ent/Kbxede2bjOrwi1elFYaRI9CKDyiziDIVPuTB03QItwV4JpPX1RMjdClDy3
         ZewKtY1XcecuETybU+2Qf7SqUSx/YuFJXXOAMLWch3FEqwjAomc6bsVHQGePGWtuH6D7
         ic+mEv1xxj/P9i3q5XrxnvkFxVEuqujdvZBR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704994679; x=1705599479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PhCoVrdbtNk6IQHDSfgyH6zuFvjv3tDoIQvmJczMbPo=;
        b=YM7yu9Z9N0eC/kSC6dAQIDXYcJytMvoZhgDhUIDWh+Rp7eRnjgI6XGmM1KqldGV1nw
         fa4sL+2SBQNM+BBpthrCJGM1QV3rtrOUIzOle9fXWJw0ogLKTLP2/dq+E7n7PzWxJq0z
         ZVrvhnK/W64XBjhxw23qCtoUpjI9/8YVodLp+h/nZKQSxnGAWxFlZWRN5jM5PfxNGoNg
         k84yO8WUWxwQ55pZsJ0Z3u0p2xSzVnBRLCoycw54WWjnabKosZV5PfA/CWUw8mNimrHN
         MsQ8qOqUgs3U5JVbE5LnGkiAevsaAHYPGJGw0v7zR04A2P/aXa6vlBdY8Pg9WAW6eDjp
         UhNA==
X-Gm-Message-State: AOJu0Yw8vIIOEC3Aad6i92qJ6sbZpF2jlsYZTYaV+8RtdzbLyEj7XCW5
	9lSqgKjMuNduIfAro+hIXTE5skC6ks7TNd3Z5TmUOiy3htfHKukB
X-Google-Smtp-Source: AGHT+IHXLPT5h81zQ8G8ZcNbBADAFFqOTHWyd49W1Wac8K0b8/+YHQ7M4aVyYY5eOWHeF9eRNza5UA==
X-Received: by 2002:a17:906:26d9:b0:a23:8918:2399 with SMTP id u25-20020a17090626d900b00a2389182399mr9153ejc.130.1704994678957;
        Thu, 11 Jan 2024 09:37:58 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id rv25-20020a17090710d900b00a26c8c70069sm823565ejb.48.2024.01.11.09.37.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 09:37:58 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55569b59f81so6912148a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:37:58 -0800 (PST)
X-Received: by 2002:a17:906:cb83:b0:a28:b7e2:15b4 with SMTP id
 mf3-20020a170906cb8300b00a28b7e215b4mr5546ejb.88.1704994678124; Thu, 11 Jan
 2024 09:37:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401081028.0E908F9E0A@keescook> <CAHk-=wgznerM-xs+x+krDfE7eVBiy_HOam35rbsFMMOwvYuEKQ@mail.gmail.com>
 <D01C78AC-830C-4D73-9E9F-7FD38CEF2E82@kernel.org> <ZZ2W_xzCSyOgltad@localhost>
 <CAHk-=wi75tFVtZdzFRr4hsDeUKmeACbgD46rLe+2bcd=4mHBBw@mail.gmail.com>
 <ZZ3_Jmb1sb2wQWO_@localhost> <CAHk-=whf9qLO8ipps4QhmS0BkM8mtWJhvnuDSdtw5gFjhzvKNA@mail.gmail.com>
 <20240111094711.GT1674809@ZenIV>
In-Reply-To: <20240111094711.GT1674809@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jan 2024 09:37:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg15ph=mEo2SqcN+6V1GYPq9U+_nCaNaDPbiPisKOj=ug@mail.gmail.com>
Message-ID: <CAHk-=wg15ph=mEo2SqcN+6V1GYPq9U+_nCaNaDPbiPisKOj=ug@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.8-rc1
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Josh Triplett <josh@joshtriplett.org>, Kees Cook <kees@kernel.org>, 
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 01:47, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Two things, both related to ->atomic_open():

Yeah, I was staring at the atomic_open() cases, and just thought that
we could allocate the filp early for that.

It wouldn't matter for normal filesystems, so from a performance
standpoint it would be ok.

My handwavy thinking was that we'd remove 'filp' from the arguments we
pass around, and instead make it be a member of 'struct nameidata',
and then the different codepaths could decide that "now I need the
filp, so I'll instantiate it".

But then I looked more at the code, and it seemed to get quite messy,
quite fast.

               Linus

