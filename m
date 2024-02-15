Return-Path: <linux-kernel+bounces-66902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954F085635D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52626288C41
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0636612CDBE;
	Thu, 15 Feb 2024 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/aJ4/pD"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FFE12CDBA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000702; cv=none; b=Vrs+jVTFDF98I6HP5L/otnOwIB72lsfwYhKuHUq9XqI0DJCHS1O4AAFPQ13jc9HcgFFO5Wri3dYXzZLKbx8BlQ6hjIHxljh7jBt2OoPPGSLVauiBfYEsISIePjb9N3e3GJ9eKWyX4e4gMKvwhKBSsbKLIwzUZ8oYh3qOVN48AJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000702; c=relaxed/simple;
	bh=DgW0/XHFyuTsoRhvV5ziiagS+vbVnW2v6G9k6XFqQaM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ljHUkMpcUUdnyVkdQyAQkeyGAP8cWPmHMhs8GMsI72hGQ817v8JZqfb9EK9Jv3UGfcuLgOLckRRTwvXtlD6zjyePv9E1FK8moTVEHXNu6WsXWwQl+CtWbBYwOIr98d3JBQWPcXTgHZP97Qse2uU2o8NTfS9deXIp4ZnZCHqyllk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/aJ4/pD; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a293f2280c7so115382666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 04:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708000698; x=1708605498; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DgW0/XHFyuTsoRhvV5ziiagS+vbVnW2v6G9k6XFqQaM=;
        b=e/aJ4/pDDHPAVe0aHKjhVL1XTd6DDeYL6F1YUoY7vrxA/+duK5muOzqK5AO0XSpOMQ
         MKgs6mAiuJxeUZMAknUoT4w/i8ixERmqNhlTOqmvwFwHnQW7wbcNcF/Lhquc2iZxyCq8
         1FZP58a6G52eWRQOB+fs5kLErPr+QQns5atroWYlGmQOnL8fIusseKeix2YXDP30F7kd
         xszjbcnoRLKAYtWfC811iTHxbp4zyZWk02hSenGvHpxmJAG16d9XJAhT8qPpKoVtNxxk
         xBH4NAl6TEpvtZR/OwzfMSWTtytvYG+B7EG86cDaJW2UBCL//qlmxTgY/slU7cgg/Pah
         bs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708000698; x=1708605498;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DgW0/XHFyuTsoRhvV5ziiagS+vbVnW2v6G9k6XFqQaM=;
        b=Frwh2De8oyGtP1hqlPfNqUmVjtJFE82ne897RO7avKzaQxSkd45OHQwqNfsX6vKLXp
         JT8Oh5KcpTGi282xa64D5iCbSC4nXtAjBTmUbPbfR1P38UmqlzDaXhBonPf5vbNdGv5/
         4Xmrfvo68QJnzvZGEolx2aPOERPORla4chfGge+4bO9gSRU8nQU+e8uePjcqBQP9EQve
         GeCW++LJerHW1Fwk3fEyJnifXU6TPqVP1reH2Qxq46Or76PF305VMBzL6mYt6WGFyTCi
         MgaGyBKX29xTn4f1VMff2Vf/A1qI7L/2js7WS8KcHT+expV9hH58WES8CKqchXF7mo/J
         bV7w==
X-Gm-Message-State: AOJu0YznK5K/28d8J01Rki3nv/hY3WoaoW4sFJ3HSzppv/dLlyqNHG/h
	21s0AheYVCmbrk0ul7hKYvdT14qLtIldVDVvwrLP74VNs9douVFPsfJoejUgDF27jpwOIlyXd2r
	QP1pdCct+i3Z5SKK9IrKjOYWFnnLNRbl5
X-Google-Smtp-Source: AGHT+IFjMqnp/JVN62EDS+c7oJ+THbUNCPZ8btx/Uz4+iYloJ/cYD8PNcCDEp9fDRS8iTrkiDD44NtBTi8S5pO9ESt8=
X-Received: by 2002:a17:907:382:b0:a3d:7d05:21ac with SMTP id
 ss2-20020a170907038200b00a3d7d0521acmr1312590ejb.53.1708000698392; Thu, 15
 Feb 2024 04:38:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jon Maser <jonmaser8@gmail.com>
Date: Thu, 15 Feb 2024 04:38:07 -0800
Message-ID: <CAF=mWJOZqD7VnbzrsqCZ1t=sc9d+NUUOzBp5u-GuiwZHS-3K7w@mail.gmail.com>
Subject: hi! I was wondering if Linus and the linux community could help make
 linux jobs
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

id like to run this by linus torevalds since he runs the linux kernel project

linux users and linus torevalds with the help of ibm/red
hat/microsoft/etc could advocate teaching linux in colleges all across
the globe, with companies invested in linux providing an
infrastructure for remote access, for a more profitable linux
industry. we're not talking about stuff like kernel programming, we're
talking stuff like linux research.

one thing that caught my eye was rust interoperability in the linux
kernel, this could mean alot of new jobs for linux. imagine taking a
nntp boot course in rust programming and working for red hat making
proprietary software, or some other project available to developers

also ive noticed most governments have some sort of linux
implementation and they can contribute to a job market

so yeah hers what i think, and im on a head of antipsych pills, as a campaign

0. linus and companies discuss the future of linux jobs, possibly
remote and in person
1. with 0, advocate linux/bsd/unix in colleges across the globe
2. with 1, invest in business infrastructure
3. make preparations for some sort of web site connecting empoloyees with 2
4. deploy!
thats just a rough guess, id really like for linus to atleast try 1 so
linux has a future in this world, you never know, windows and gpt4
might really take off

would be nice if linux was like the internet super hero

so what do you say? bring linux classes to universities and colleges
so we can all get jobs?

hope this email makes sense, damned zyprexa lol

jon masters

