Return-Path: <linux-kernel+bounces-138269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FB989EF03
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6142A28156E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B68C1553BB;
	Wed, 10 Apr 2024 09:37:21 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A046155733
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741841; cv=none; b=ehz1/ahSVQM7NAEtJd7SWH1FZwoxHDvfFHoHNwd0UFw6IX4v/51UuIORmB8GEaKZwALTMefipY/b9AsZCSA0z37O78AAcupKxiEHj77mQ9oZmrSHpi78Rp/M75C2jgHSRQdWD4ueFQ8mpKy840r49YQfrZBjDT3J4bP/FkPaWSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741841; c=relaxed/simple;
	bh=V3thOMH725aUngVQIvJOn0JXhTHGo+7aXCDKvdaxyB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4+nvc4XnQ462blwMD5goXqZ/tsya/HX3s04pQ70xieE77D68zE9/+o0orHXPxP1+Ry7NmTKX/st1ExNYUAkmHGanjaevMSGhnJjGlZqLieYso8VgMYFI8DwZSq4qBRMj7e+vH8Y+a0kb+fubc0dp2QSOdHSMvTacBfaPmT66eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp86t1712741709t1j9dvxx
X-QQ-Originating-IP: UlX+U0HDn8U2wZOPMdV+GrEUZEAqhBp6L5g2wVnl0vA=
Received: from HX01040082.powercore.com.cn ( [14.19.178.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Apr 2024 17:35:07 +0800 (CST)
X-QQ-SSF: 00400000000000B09000000A0000000
X-QQ-FEAT: Gg/rOgmEge/NdIqCpZvkuVgy2frrl2wIfYRWto7rpHg7PxnU70es4ZHQMstKx
	nVA80ljUsv+MGwF43KZcabPuqFDRNKi2LugMuiiUkXKrJZdMwWKk2mlizvKQQKyC6JJfmIZ
	84exB4Wp9i/AXK+kegVX6S+Rti3fN9Fe8RpZU3X0yg3WJPYA5gEY0Ej663A2ok87+uBItI4
	5wEvgW5Kgp7qY0ZL8PgrIjXfCWTBC1GddSrW1MYuidO9vOwdmAFMLrc+irGJtfxIlxcz3dT
	ojwpUwcSZqXC47Q7OM6ApLmkXbOWGZ7Vfi9Ua1MO0w32hBX10ooUKqpdEMk5s2LGDIiwf8I
	LJYHird74EwlEYlIDsSrXanwB8UqLhEW+LGizET1oBAhi9F57WJKWUX4JAOfAcz0U6L7X9r
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4513538048317919293
From: Jinglin Wen <jinglin.wen@shingroup.cn>
To: bjorn@kernel.org
Cc: palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	gregkh@linuxfoundation.org,
	atishp@rivosinc.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 0/3] Add early console functionality
Date: Wed, 10 Apr 2024 17:35:07 +0800
Message-Id: <20240410093507.8312-1-jinglin.wen@shingroup.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <87y19lpub5.fsf@all.your.base.are.belong.to.us>
References: <87y19lpub5.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-2

Thank you for taking the time to review this patch.

Björn <bjorn@kernel.org> writes:
> Jinglin Wen <jinglin.wen@shingroup.cn> writes:
> 
> > The following patch series implements support for the early
> > console on the RISC-V platform.
> 
> I fail to see how this is different from earlycon=3Dsbi

Yep, you are right, this patch duplicates the functionality of
earlycon=sbi, and should be discarded.

Thanks,

Jinglin Wen

