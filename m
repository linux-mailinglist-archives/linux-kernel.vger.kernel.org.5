Return-Path: <linux-kernel+bounces-13050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC3781FEF9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9A71C217C0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA0E10A3A;
	Fri, 29 Dec 2023 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2y3j9ae"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B3610A21;
	Fri, 29 Dec 2023 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5947cf2a4f6so2743201eaf.2;
        Fri, 29 Dec 2023 02:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703847489; x=1704452289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OrReeVliOmZdguazqDBOVNNl/lwwaLdeM1q8GOH71Zg=;
        b=c2y3j9aearkuTYGTsxlPJPZw73PrsPl38yXB+Yr8jpCw/IQcVYe/Ydhh257fpVc44b
         ZJJc5SJG0aZnjatwIGfkY2L1SKCJuRoAYYSYnFDZBN0R/eGoDd5/c32Y4GgXG/6jHIJ7
         q+UnDDjO03O8ecoHhHNCgyvZQ56wlY4JBF0nBME8MG3/a12bScTXJkyVKUnaBK89tdWV
         vGSbD58GR7fW2dUerA07VdSE5QY3qmjs439qtkbASUb/B1RWZfiz9QWjy0ZzTyOzPhD6
         ya4lRW3o4i7VNgoffbP0p8/BKV9M1js8z3eeftMtHTGjWoQJUhClvf4ef8X7T23P2Gwm
         5zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703847489; x=1704452289;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OrReeVliOmZdguazqDBOVNNl/lwwaLdeM1q8GOH71Zg=;
        b=LBjpbgW4LN6uibnaEUpZ0Nze5ApglgDx0WhglZpNj3y/FtQqtTOKGgPQiHt1rKhdob
         PnRr+Qs3jpa9Qwa2Z0Yv1eT7VW9PsrNjNKYddKZXWxOmwJFjqnBe6tFqY3HQMK65bp4x
         UlBSAnKmSwmawJGKLwWS5cXH6a2mzhoB3v2PKuFsyfGcplmbAYG8vVKXSRp/IpDEAo/F
         YM7cqsYQssxKtZqJmYm+kCOvIp6LkjSou5VuH9aadgUcKw/uzXPnHXyyg6g2P7FVKo4n
         cUxqzHJDy2q5EOjhZtoo6hb9FObpOFgkjkfuJIG8k5Gm3R4gUEfQD3G8HIYnkUf1m2xf
         mgGg==
X-Gm-Message-State: AOJu0YyHKttHemsiqE1Bj5R2a/myoDL8DAac1CDZehUhmS/mGLP54zfi
	+NV1y9JQuO2mdTKvquULFXjvEFXHrq35Y9skwA7WG61uqnxHsA==
X-Google-Smtp-Source: AGHT+IEpA9Q7AinmU9SKdNZXyql6kqFJOrk+XQQkpYyXggeacP1MhCsLUptbgYQR0o3uM4nr1HthQ+JCDAk/8I99o+M=
X-Received: by 2002:a05:6359:4599:b0:175:2220:2e6b with SMTP id
 no25-20020a056359459900b0017522202e6bmr86403rwb.43.1703847489101; Fri, 29 Dec
 2023 02:58:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jasper Niebuhr <yjnworkstation@gmail.com>
Date: Fri, 29 Dec 2023 11:57:57 +0100
Message-ID: <CAMjCObt_VOWp9fz_onYesfpvLLiJqnzpQA8W1HfOpLc0_bNGog@mail.gmail.com>
Subject: Post Compile-Time RandStruct
To: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "luto@amacapital.net" <luto@amacapital.net>, hpa@zytor.com, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	"keescook@chromium.org" <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hi,
my name is York Jasper Niebuhr and I am currently approaching the
finish line of by bachelor's thesis at the Technical University of
Munich. My supervisor and I addressed an issue with grsecurity's
RandStruct (structure layout randomization). Millions of end-users of
any distros - that pre-compile the kernel - are given a kernel with
the same randomization seed, or simply no randomization at all.
Furthermore, distros usually need to publish this seed to ensure
compatibility with separately built components.

We came up with the idea to apply structure layout randomization to
the kernel AFTER it was compiled. In theory, this can be done by
disassembling machine instructions to check if they access a member of
a struct we want to randomize. If so, we can change the according
operand's displacement to reflect the new position of that member.
Additionally, any initial data of objects can be reordered in the
kernel's data segments.

To explore this concept a little further, I spent the past 3 months
building a prototype. This prototype uses only the kernel's debug
information (32 bit DWARF 4, not 32 bit kernel!), especially stuff
like the location descriptions, to get an idea of any entities in the
program. Then, a scanner goes through any function's machine code to
check if the instructions access one such object. Any access is logged
in an intermediate file (pretty much just a binary list). A second
program loads this file, randomizes a few chosen structures and
updates the kernel accordingly. This separation into two programs was
done to lift some load from the end-users machine. Everything up to a
complete intermediate file can be done by the distributor, as it is
fully independent of randomizations. The distributor can then publish
this file, so the end-user's machine can resume with only the
randomization and update process.

In practice, this concept seems to have a lot of potential. Among
other structs, the prototype is currently able to randomize
approximately 70% of the task_struct, including its cred member. This
requires about 20 seconds to run the first program (distributor), as
well as less than 10 milliseconds for the randomization and changes to
the kernel (end-user). These 10 milliseconds include all the file
operations in the kernel's binary file. The prototype detects more
than 11000 instructions that access the task_struct and replaces many
thousands that are relevant to the part it can currently randomize. In
the end, the kernel boots in qemu just fine and system calls like fork
and setuid/getuid produce the expected results.

Unfortunately, debug information turned out to be inaccurate and
incomplete at times. Combined with the kernel's quadrillion edge
cases, this prevented me from taking the prototype any further until
the deadline. We can see this concept fully shine with, for example, a
compiler plugin to log any accesses, instead of a tool that deals with
debug info. The second part of the prototype (or a mature, later
version of it) can be integrated into distro installers or run
whenever the kernel is updated. Even integration into the kernel's
boot process would be an option.

Since I am now in the writing phase of my thesis (deadline mid
January), I thought I'd share our thoughts to hopefully get some
feedback. Do you think this approach solves some of the issues that
RandStruct currently comes with? Can you see such a system actually
being deployed once it's fully functional?

I am of course open to any further questions or suggestions!

Kind Regards,
Jasper

