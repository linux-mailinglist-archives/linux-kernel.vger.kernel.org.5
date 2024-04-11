Return-Path: <linux-kernel+bounces-139643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7668A05AB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412FD1C21EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A056217D;
	Thu, 11 Apr 2024 01:53:38 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EBE7F9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712800418; cv=none; b=hYbXfNJhJNKn6flUXLQLuO5Oz3tzoNkEKlQzviJ4dYb2ZgkUzn15eabrV+YUgoAqFJ81gZ0NF6d3zwkJVxOxZagXQSzV5+YXZxFbnwihQlbtkUEz/riNImEVneNZvWAUyNXhWRT+zTrn4xjVy8oP9jOB1QdZQWZlxjSbCgJjTn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712800418; c=relaxed/simple;
	bh=ChsB5VUcTkqb5revTC0jishd5DrVH73z4tHPnIFZZsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TJKVm0d+GO9QvZ+5wfRlMW7FUkRPPYNx34JFgNb7xKxfiyhl3/lMD02cOsDUSsZ8gWTn5/i4B8XguJU0ZnU4MEOZpL5+4TjYt4WDuZBTuifgGVmEVSmMxA1EEgls5cWXyM/c1QYpYLd24bx/BlFN6DonsVL3D+0bZMACBPkWkV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp90t1712800304t1ksuc7r
X-QQ-Originating-IP: MIR7lNCdXm2gxJlu1KOUSY0BdyMnYLIqBuKiWzcg/GQ=
Received: from HX01040082.powercore.com.cn ( [14.19.178.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 11 Apr 2024 09:51:43 +0800 (CST)
X-QQ-SSF: 01400000000000B09000000A0000000
X-QQ-FEAT: zT6n3Y95oi0rtWnXgdbUTchQrChx9AHGrXslGgx/sf7vMqCwU+36IS0UQL8+/
	tgIX0Ns6fv6B/lTRlMBRJrGgdeeM1y+STtw1ZKRpoO7GbOJu6wgdtlYz00ISDXa5CMTYAfR
	VrScp0TqdkyqhAq+fn7ZgsxQO6HNKh/iiEmmiP6selOt+4skjcWmWbuteJICvtVG/vB8AmF
	1wDyAlvinUahCav1JnIq0HZvyNNPZNi4U8bXOMJNobsdqqFyBKyLQTmWJQ0CBh7GudJz/bj
	Xwe109SKfzZp3W2EcuXwb1n65yCtpYSfD5fmOsA/T030prwm3M5FmthrcRB7Frw5HaSA6P6
	+t0PceOQKnCEZQ4Xd/Z8Sr4PPNbkVhMyl0h6lNVV+EtU/HlKFYcEg5de8VuV8s3ipwbeMAK
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16034395823288831725
From: Jinglin Wen <jinglin.wen@shingroup.cn>
To: palmer@dabbelt.com
Cc: bjorn@kernel.org,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	gregkh@linuxfoundation.org,
	atishp@rivosinc.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 0/3] Add early console functionality
Date: Thu, 11 Apr 2024 09:51:44 +0800
Message-Id: <20240411015144.24901-1-jinglin.wen@shingroup.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <87y19lpub5.fsf@all.your.base.are.belong.to.us>
References: <87y19lpub5.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-2

Thank you for taking the time to review this patch.

Bjorn <bjorn@kernel.org> writes:
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

