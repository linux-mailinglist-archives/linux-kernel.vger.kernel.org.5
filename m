Return-Path: <linux-kernel+bounces-45449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 138FD8430E9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3702286327
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7B35B1EE;
	Tue, 30 Jan 2024 23:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="opV4NaYl"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318E57EF1F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706656433; cv=none; b=HhO1yCJ3gzoOzomqtKLuo9TgTRdqWJpCxzy9nb6uMXGxZ7WF137EvG5KB0kcUw1qc+cuhxgQJeUjDl9c6J1zqq1WeRX6WgG4shrqJHHNc9K41qGWB2dplFCWI0F23/mupIYefVKdwXmbDT3dVay9NT5yJPC4wc+M570k/I50hcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706656433; c=relaxed/simple;
	bh=aCglTAeVcM0PfMd5hwBjAlJh3ooM/5RsDnU91GWahMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/5IjFLudO5XAJuv632clZvgouBrEJ2vIrwQTpohxjrnS6ULwiv7nkxRy2TpKIZWLzkv1RLc3rOhk9Wtn06LutPHzIjtWjJqIDAb+VYEHvqJwySqnEJNwOV++VX9ox7k7Dpa6ZCV1LIxb6XWBnhHlrlAmyHPl9tHX/nuyLjzNUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=opV4NaYl; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6de0f53f8e8so266421b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706656431; x=1707261231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCglTAeVcM0PfMd5hwBjAlJh3ooM/5RsDnU91GWahMA=;
        b=opV4NaYlwKKIDdO7mZG0r2sxBLQJ9TWN+8Mw59h4LKHsxarYux4eMRUM96W2EmdVYb
         FynTt/wATDjIALtgIy8ed160jWjRGB+BT6ylFxkKeZNY85zv5krcKEpGUanEqrAneXEK
         U1/nVm1qGU5UV0xZG7w4q0k4KL/nrDPkVsXknBRDD+Nfh90pnQ2qMPIh6FIHrUI5tPok
         W3eQmKe+ksoqd8JKJjdkTiKiXzOGq+Fxx5Wx6rnRywjyzjUMPhv9qdmZ4Lcm6vTdOUh8
         WliSvNkW/lUy8g8qYoKlGTTKyFVS/nGB2uNBVKKrMOeveLwop4LW0lQpxxjcvc0Gpzbx
         gATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706656431; x=1707261231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCglTAeVcM0PfMd5hwBjAlJh3ooM/5RsDnU91GWahMA=;
        b=iKxIuI9rEwrgcvJcs6s8JK6je8kcu0Vz0p+iulTxCUDmCvmkPktaVKl/W2JTC97uiL
         9v7wHICm6d3wT64czTigpEGgiST3Utnl0yehPkV+WWzlgzLtH2Fam7iZsNZvBEUiUlSb
         tQcy5FfZsKnemNX5GFRY6dEnakRneAycJkWx/5+2KJD1tj62B8Ih1AoYqDQkggJxqKrz
         4X3LWOHkZNamycKzPCrtApNw0bUVdr7G4JCTbiQvJ/8QEEXEjiUHsuFB/zooQ3UBKXYV
         HtYdFaTJlQGQmqjzvVzpDNafkBXM8W3HyfX625wHbj5Wb3eTz8CP3zs5QqsQYeZC0f/O
         r4Fw==
X-Gm-Message-State: AOJu0Yz8esQLJjmnfBJs93dHWfdRC9W77Zv62lfqNRupUEU/rrMPyc7l
	jvEffz2uGgYa5D7PjioO3y5giILBRxtrDjzsB2iVUu2h9tUXVlyS7vr5JXIQnkhkz01pT7QL2Rp
	Q5I2xtGS22zFvBG/BEKrHLnD80NuAA5uL9zFJHg==
X-Google-Smtp-Source: AGHT+IHQAahjrMg9Y0dWXqUUXGOGOSgWGyqO+PDriasAlruF7X/96XL4KAI6X8n/QyRmm5M2vm1fvk6Mz+jrJ7j0344=
X-Received: by 2002:a05:6a20:9f06:b0:19a:5257:9828 with SMTP id
 mk6-20020a056a209f0600b0019a52579828mr3198323pzb.22.1706656431461; Tue, 30
 Jan 2024 15:13:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYtEGe_DhY2Ms7+L7NKsLYUomGsgqpdBj+QwDLeSg=JhGg@mail.gmail.com>
 <ad5b7442-385d-41db-9202-a36414460610@sirena.org.uk> <CA+G9fYsbwWpDVR9KJXx8UO5MXsYT81uAJbLLNDnLianr8jmXUA@mail.gmail.com>
 <63e92a6a-9cb7-4272-b524-ccaf997aceb3@sirena.org.uk> <CAEUSe7_9tE5K7NpsmaG_v_bTJaMGhVVSDRhMn1QYnr2z4vSg8w@mail.gmail.com>
 <20231221093442.3c4b84f0d39350f9deb4e51f@kernel.org>
In-Reply-To: <20231221093442.3c4b84f0d39350f9deb4e51f@kernel.org>
From: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date: Tue, 30 Jan 2024 17:13:40 -0600
Message-ID: <CAEUSe7-q2byVG=qM-uw-oe+aRb=wbDzAc8JMJQdUCFbqJMwyeg@mail.gmail.com>
Subject: Re: selftests: ftrace: Internal error: Oops: sve_save_state
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	linux-stable <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Masami-san!

Sorry for the late reply -- winter break, expired artifacts, life, etc.

On Wed, 20 Dec 2023 at 18:34, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> Hi Daniel,
> Would you know what ftrace selftest testcase script is running when
> this crash happened? I think it depends on the selftest version but
> I don't know which one you run.

If I remember correctly, that actually happened during LTP testing. I
found a new instance on 6.1 today, on ltp-controllers, so there were
no kselftests involved.

I'll share more details in a bit.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org

