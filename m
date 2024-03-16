Return-Path: <linux-kernel+bounces-105207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A83C87DA84
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 16:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219752822BE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 15:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFAD1B970;
	Sat, 16 Mar 2024 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="PdW0ak0K"
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0850D1B815;
	Sat, 16 Mar 2024 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710601201; cv=none; b=uppS9f5x2cakXdh5f/gqLKMAVjQ67oBvqm9DnVVxHhUeQl1liiPKbUE2s620ukgnZAz6b/QnzLXC0G5/zM/3619Xgtbz+QfFYBe2zEAavq0/Z+/ukTAYjqwvnOvzXHoCtJ4DMYUy10dW17vuH79H2HwTlyVsqBlMrbgy4T1+9YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710601201; c=relaxed/simple;
	bh=6ThZgc5bF473g6yEtflfN91+NcQ9yyOlhjLf9QzysLI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bsN3J8eOWdGVdjwX7gk4sbcO9CHoD2Q9m3R/AGj/hStZEB2tDNDG1ok/ddWdB5/FF1B70T0Ap/dyNSlOBFxrZ5mxyvepzwFVSPmzSR8Xfl21gEOtblCkqbfpnStxgsh1uKwMHJu80k6bMNPImtOV1rCt68OgxdIWv3vaGUxDZtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=PdW0ak0K; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1710601192; x=1710860392;
	bh=SriqUYtoFiKymMAfUU6MXviFeq8Af+j9dgH8WNG12F8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=PdW0ak0KUwhpUR7dTEOlI7rLBCYqCc1WerPJICt5BqXzbSTalwiJ//Qw3gKTsaVxd
	 tKwjODoK4G2VVrVzuG6xy9z2DXPFCDEvMQbVXfD/DNkNsUCIrxGoUf9uvNCSukJPUw
	 pJNW4fk0rX+NEtlCq2N1FSbQaXlwgMcR6vHU5g9xUHnBtoeMctcFNyTDxa9YX1vyIX
	 lUP38jiZUU/bqNwtP1jj5XOVu9t43iawropcPIB24KZMNg9ci9RVFbA4R+qHDAQmLJ
	 kRp9YWL90XnBr7P/VRrtQHPCf7s/KZwsjKzI+fzS40jIZGlBVncdeClpGhOpoHLFWo
	 0AuUN7Fx4q4pg==
Date: Sat, 16 Mar 2024 14:59:42 +0000
To: "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Koakuma <koachan@protonmail.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "ndesaulniers@google.com" <ndesaulniers@google.com>, "arnd@arndb.de" <arnd@arndb.de>
Subject: [sparc] Use of -fcall-used-* flags in Makefile?
Message-ID: <JAYB7uS-EdLABTR4iWZdtFOVa5MvlKosIrD_cKTzgeozCOGRM7lhxeLigFB1g3exX445I_W5VKB-tAzl2_G1zCVJRQjp67ODfsSqiZWOZ9o=@protonmail.com>
Feedback-ID: 6608610:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello, first time poster so apologies if I posted to the wrong list.

Anyone knows why the SPARC makefiles (arch/sparc/Makefile and
arch/sparc/vdso/Makefile) set `-fcall-used-g5` and  `-fcall-used-g7`
in their CFLAGS?
Would it be safe if the kernel is compiled without those flags?

The context is that there's an effort to make the sparc64 kernel build
under LLVM/clang, and if possible we'd like to build the kernel without
those flags, at least when building with clang, since it simplifies
a lot of things on the LLVM side.
(LLVM tracker: https://github.com/llvm/llvm-project/issues/40792)

