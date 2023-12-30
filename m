Return-Path: <linux-kernel+bounces-13327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043FB82038C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 05:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CDAA1F219C7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 04:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A54C17E9;
	Sat, 30 Dec 2023 04:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBhBP9UI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C5E1367;
	Sat, 30 Dec 2023 04:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-594e9135d82so1306151eaf.2;
        Fri, 29 Dec 2023 20:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703909577; x=1704514377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejfueo89WFs/oFJaApIa/W2r85V6qCPW0jGnmXIzsAU=;
        b=lBhBP9UIuq8HjwWExl9FDGTANls96UOzuzVN0Lgc0MY9UiYtXxuSc8j+57ET31kq0B
         xg9PVHmQCIa9vsuDqcKgnsaBkD7A4Wg67UGBrTvBb6TJA07wm+wc//1DjIYDTS7tJKNK
         4G4mZ8k42/66U0iPtASc/thjfjsmFlWyq1Lv3TwSV7NebNyJpnPUlbC0Ho7+O6t3Hr+9
         G1Wq/wDNnjzZMEOzMqIKjNyFyXkR98jawiME+owq42ckeQArto3EBfIl86grtYlJG1sj
         S+vZGoWqh412Yu5GMkiTXKLCfhWeL3kkNi1pYyah6ctint061Th+h/rTw/iL1Z8YID2b
         cXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703909577; x=1704514377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejfueo89WFs/oFJaApIa/W2r85V6qCPW0jGnmXIzsAU=;
        b=N/2X80cE6zshVEBcZwWenxJHca/lBiDEs4UVk7SWw6C7amWVpIYcjJSPlAXk7oCww5
         vvbBMrCLAYrhls7rvCJYGg2x+HZHdeWFujMgQvAYKTOqJfEnPEEcSsLrC1Y8tyBni+km
         eeMJ0siX/hJQ9L+u+gohpdGD8+/vOM51B1bfbIwXb4hjrZBSnMBHfAXHxc1z4HwmWV4J
         KjUd/xijKvzZmDERZ1yt4XaxcNo84FJsg9k1QBpML1P+9sbPAOc/hCvZyrg+eBErf8Lu
         DWsjzpH39jPGYypO15LFeh3i1A9ymFwK6vdrhb17smiFvzkOGlWjMlhJeG6YN8fNCm3f
         qpAg==
X-Gm-Message-State: AOJu0Yx9BYN7iW+NJ3hhoRqiV84FccyqOkx+zJAF5SWK6yBoEH5/Nl9/
	joyjfZJgZxXtvhoiURD59B66mMUEwU5mR8MZYTjDoxT+
X-Google-Smtp-Source: AGHT+IGs/93N6pvlZGycPQsHoufKzGa1iXlpHFU278prPiJa7vjr78QNNTc2J+L53QPoGAmP3vVaNU+gjcPX/5H9hMY=
X-Received: by 2002:a05:6820:2221:b0:591:a34c:f064 with SMTP id
 cj33-20020a056820222100b00591a34cf064mr7898267oob.6.1703909577411; Fri, 29
 Dec 2023 20:12:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMMLpeTCZDakqdkxm+jvQHxbRXhCYd4_PK+VVqMAmZHjSPuPRw@mail.gmail.com>
 <20231229163339.2716-1-dan@danm.net>
In-Reply-To: <20231229163339.2716-1-dan@danm.net>
From: Alex Henrie <alexhenrie24@gmail.com>
Date: Fri, 29 Dec 2023 21:12:21 -0700
Message-ID: <CAMMLpeTdYhd=7hhPi2Y7pwdPCgnnW5JYh-bu3hSc7im39uxnEA@mail.gmail.com>
Subject: Re: [REGRESSION] net/ipv6/addrconf: Temporary addresses with short
 lifetimes generating when they shouldn't, causing applications to fail
To: Dan Moulding <dan@danm.net>
Cc: bagasdotme@gmail.com, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, regressions@lists.linux.dev, 
	Jiri Kosina <jikos@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 9:33=E2=80=AFAM Dan Moulding <dan@danm.net> wrote:
>
> I think a maintainer will probably need to make a call here and decide
> how to proceed.
>
> > TEMP_PREFERRED_LIFETIME is an administratively set variable: The user
> > can change it to whatever they want whenever they want, and the
> > operating system can adjust it automatically too.
>
> Agreed. And the behavior it seems you really want is to prevent the
> user from administratively setting it to a value that is lower than
> REGEN_ADVANCE, so that it won't stop generating new temporary
> addresses altogether.
>
> But preventing the user from configuring it to a value that is too low
> is different from generating new temporary addresses with preferred
> lifetimes that are greater than the currently configured value of
> TEMP_PREFERRED_LIFETIME. I still believe it would be better, and would
> be in conformance with the RFC, to simply not allow the user to
> configure a too-short TEMP_PREFERRED_LIFETIME instead of tinkering
> with the lifetimes of generated temporary addresses.

In RFC 4941, REGEN_ADVANCE is a constant value of 5 seconds.[1]
However, Linux uses a variable regen_advance that depends on the
Retrans Timer value in the router advertisement.[2][3][4] Let's
imagine that when the user tries to set
/proc/sys/net/ipv6/conf/*/temp_prefered_lft to 3 seconds, they get an
error message that says "Sorry, the network requires at least 4
seconds." After a few minutes, network conditions change, and now 5
seconds is the minimum. Should the kernel just give up on using
private addresses? Or, the minimum might drop to 3 seconds, which is
what the user really wanted. Should the operating system tell the user
to change the value?

What I think you're getting at is that Linux might be violating the
spec by allowing TEMP_PREFERRED_LIFETIME to be less than 5 seconds.
The RFC says: [5]

> When processing a Router Advertisement with a Prefix
> Information option carrying a global scope prefix for the purposes of
> address autoconfiguration (i.e., the A bit is set), the node MUST
> perform the following steps:

> 5.  A temporary address is created only if this calculated Preferred
>     Lifetime is greater than REGEN_ADVANCE time units.

The right solution might be to make Linux use a constant value for
REGEN_ADVANCE instead of a variable. I think that's how it used to
work before commit 76506a986dc3 (IPv6: fix DESYNC_FACTOR,
2016-10-13).[6] If regen_advance can't change depending on network
conditions then it can't cause private address generation to randomly
stop working. I don't understand why the protocol would require
REGEN_ADVANCE to be a constant, but interpreting the RFC literally, it
would seem that Linux is technically non-compliant.

-Alex

[1] https://datatracker.ietf.org/doc/html/rfc4941#section-5
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/net/ipv6/addrconf.c?h=3Dv6.7-rc7#n1377
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/net/ipv6/ndisc.c?h=3Dv6.7-rc7#n1438
[4] https://datatracker.ietf.org/doc/html/rfc4861#section-4.2
[5] https://datatracker.ietf.org/doc/html/rfc4941#section-3.3
[6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D76506a986dc31394fd1f2741db037d29c7e57843

