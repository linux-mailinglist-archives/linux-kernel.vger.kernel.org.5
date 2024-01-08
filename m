Return-Path: <linux-kernel+bounces-19432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8A3826CCE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2631F20FC5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E32719BA5;
	Mon,  8 Jan 2024 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQFDCW27"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D50D14A93
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-555e07761acso1942033a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 03:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704713417; x=1705318217; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=A2dPYN7RpQplP4WDf8DLRQnv8gMznORo8Hbp2VTh0AU=;
        b=dQFDCW27QaLEVsDojexvTnmcRt1VC2qxnToZEBwLCeJx4tGfnt0su2oqIxK+SIfwlZ
         YrFlfM0xHMI84c7lcYxLsFgZtiQuNihYbBT5a/+N1RbObF01z4b+SkX0ZqD59b/99xqp
         GoTaUwDJmKf1R37MoXAy2hTWbnGIif72UOkeczrqb/0eGOPsww6zVbi2pkT7BAyiK0SP
         zNy04ZgjJg2iQF7HUKUDmYN5rD/I0J/AJ0IES6cwl2uVS/iT2K4w1fkIyXFQPlrBdk43
         QjEmWYlKIMV1PBfB6vw9oAVIypeylQCzEG8hJhDwoxZ3HbWc3QbJ5LDDRG90PXJ2Piqw
         mS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704713417; x=1705318217;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2dPYN7RpQplP4WDf8DLRQnv8gMznORo8Hbp2VTh0AU=;
        b=ZxctoeNaMqoQ6g8O7Rtir82A5wprGfy2RsH5E/ivvxYld+yqazPubi9mXK58TKc34e
         fZmVjKSd2XPWqMyeFAkBqsKmst6Rv+I487TD5SNbNji8fCYKsmRD6W3VrjOpSFqWMG5n
         wXNnj2ZChcefkDhNuKgBF2Fg8P10TDSnudXy9l1I6aLXqSh4WMtEZWMuBfJYBvKdo/yJ
         mImQNoJXchMg9kaKaybgCcJ8uEu0WSDXrr/3JQw1n8bmypYa8gvzT7f0GeOkiRF1UzfR
         j1q4eDGChj3GHL3ba6ei8ZfAPMHU+kIZcxm4Hf+Fd66j1VdPonSPBBKEqNLI734HTvab
         nehw==
X-Gm-Message-State: AOJu0YztkFrbqIG7F/LP1HYXFCdeqdBIMZNQPnuUkKwEusdswo8uYf/U
	3xFkUADjLmFG//Fyhm2NQDILE1LmVzk=
X-Google-Smtp-Source: AGHT+IFlUpLaqoCJbiSFhD64IlH95xiv08LvOcyzU6Z/yb15d/6OOnUWrAzF2uFu4kBOc6RehvbCJQ==
X-Received: by 2002:a17:906:d195:b0:a26:c748:44e5 with SMTP id c21-20020a170906d19500b00a26c74844e5mr1096591ejz.183.1704713417214;
        Mon, 08 Jan 2024 03:30:17 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id lb24-20020a170906add800b00a2a43568cd8sm1646936ejb.186.2024.01.08.03.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 03:30:16 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 12:30:15 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [GIT PULL] x86/entry changes for v6.8
Message-ID: <ZZvcx3N1KxL2GBb8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/entry git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2024-01-08

   # HEAD: 1e4d3001f59fb7a9917cb746544b65e616b5f809 x86/entry: Harden return-to-user

x86/entry changes for v6.8:

 - Optimize common_interrupt_return()

 - Harden the return-to-user code by making a CONFIG_DEBUG_ENTRY=y
   check unconditional & moving it closer to the IRET.

 Thanks,

	Ingo

------------------>
Peter Zijlstra (2):
      x86/entry: Optimize common_interrupt_return()
      x86/entry: Harden return-to-user


 arch/x86/entry/calling.h  | 12 +++++++++---
 arch/x86/entry/entry_64.S | 33 ++++++++++++++++++++++-----------
 2 files changed, 31 insertions(+), 14 deletions(-)

