Return-Path: <linux-kernel+bounces-43054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7A2840ACF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78014284D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D0115530D;
	Mon, 29 Jan 2024 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NO0OnGUd"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744BD1552FE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544467; cv=none; b=iz2s4NyzXlOE48vmkCZTD7aJz51aKSUNEoWcWsAca84qtYQZnJdcXJ55GIi2MP8727Crah712LEoc2qX97rHq9Qxgtzp6c33xZlvSkATyIoJFUuHXkFOwERUqqkoBmGLFgWfZo9Ofz6v/bKMuMHtfTNxX4+JsQfGfLZtLqXfxW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544467; c=relaxed/simple;
	bh=ieYO7asVjzOp1pmdKd+4G7HOL/m6MhMfA8meIoXK+k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLvuH79mELPoA4PmgBs/20nMl4s10QGiBupuyABjlbzyb+FRGCfF/dQ6vIbqHDWi6WEbE01urByIcQw3WUsMVg+/PaRDi5HruFDB92UMbKl61QiDVLZBWDO+qyOG0VzJpL03DJ4LnGADuV5yYJQb62ns5dndD5obcoihRDXNavQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NO0OnGUd; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-783f1fba0a8so116366885a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706544465; x=1707149265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoA8ykTcXOR0pRD9YzZGVSBtlm4LxiIgPgCN0LHC8uU=;
        b=NO0OnGUdNMhbX1M7DLTXaC2iFFAdG8TyFggpf9EnNdpwXQJcJnlYpBX4hg55Rm3UeK
         bMgKWq46Ee5HR08vWm9S2VdpqYRTKR6kkw4dYHaqj0f3Q03z98vL7BzwtCrKzwO4bKYl
         eljLMLTL0p8cGETRthPV0QYF9V45J7e7jtB4Md0CoO/+gmS5nRFKi3XAZeurol1fabm9
         ghJHjtUbk8H6PdNgogLk6KMXqrxWSaBnJBYllXeUwwZN0tiMuKtZWipxTwcFsdodnN8Q
         UCM6swQumQZcAQTRjOZ19qi9pQkRZqOAlbeM2eoOMqyJMK1R9KWZdcz8l8emeWtZLJHL
         dK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706544465; x=1707149265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AoA8ykTcXOR0pRD9YzZGVSBtlm4LxiIgPgCN0LHC8uU=;
        b=pLjMJgDTqIbwkrzOpuKrLib5D0julRbTtcHXDotYkbxwe5SbsCsnpx1br7x2EJqGwN
         I+yf1NBxQ+efo9Id8QeHeovI9CehZp50ZcYZXhem/lAbuKaYvAw6FyvJ8D2Id0yX077I
         1pCIXIMunltdcyZbN5FJTmploXssodNSSWUxwON+35fQBCtd7oxV493dv4ZodLbdLKwa
         AzJk/VBDTILsvHyCs0/4bBp6JuN4UhOsTyfi2WNkhNRy+PTprynQlS15fadEaXypbh4N
         R57UOw+otFJNLR74DXp+cSNoWK3s2Ae42RF+NP4GB+MnDYAeDezCA2S/sKQ923Meu3jo
         +iOQ==
X-Gm-Message-State: AOJu0Yx2gcTMfPz77gV0E1nH8ko7EWpCQALQ+gGfHsTrVe95JL1jh+uA
	tTQyLPgo5fMka2quLeq97VTL6CONUqKjConFPHCKjuB4XBqZniG6LNC7yx8yl3pRzECJa7IMNLk
	YPqb0RCE5kuLMe+m4/xZdapZWf/Y=
X-Google-Smtp-Source: AGHT+IF8BD6lOlfezSh1UMY77xTigTnD2DFXVR9WSqs49I7788NQamOuITZR7dUlGrjjnUyNApJIEMydBxKBndi4Upg=
X-Received: by 2002:a05:6214:202c:b0:680:b72b:7d7f with SMTP id
 12-20020a056214202c00b00680b72b7d7fmr7394134qvf.127.1706544465390; Mon, 29
 Jan 2024 08:07:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125170628.2017784-1-tj@kernel.org>
In-Reply-To: <20240125170628.2017784-1-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Tue, 30 Jan 2024 00:07:33 +0800
Message-ID: <CAJhGHyDHP97ZHbDwPwhiYvBWbzvXw_UnXhPs4RRJ6nQBo3_x=Q@mail.gmail.com>
Subject: Re: [PATCHSET v3 wq/for-6.9] workqueue: Implement system-wide
 max_active for unbound workqueues
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Tejun

On Fri, Jan 26, 2024 at 1:06=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:

> This patchset includes the following patches:
>
>  0001-workqueue-Move-pwq-max_active-to-wq-max_active.patch
>  0002-workqueue-Factor-out-pwq_is_empty.patch
>  0003-workqueue-Replace-pwq_activate_inactive_work-with-__.patch
>  0004-workqueue-Move-nr_active-handling-into-helpers.patch
>  0005-workqueue-Make-wq_adjust_max_active-round-robin-pwqs.patch
>  0006-workqueue-RCU-protect-wq-dfl_pwq-and-implement-acces.patch
>  0007-workqueue-Move-pwq_dec_nr_in_flight-to-the-end-of-wo.patch
>  0008-workqueue-Introduce-struct-wq_node_nr_active.patch
>  0009-workqueue-Implement-system-wide-nr_active-enforcemen.patch
>  0010-tools-workqueue-wq_dump.py-Add-node_nr-max_active-du.patch
>

I just left a small piece of comments on patch 8 and patch 9.
After they are resolved, for patch 1-9:

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

Thanks
Lai

