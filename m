Return-Path: <linux-kernel+bounces-98414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3FD8779C2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 03:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12F51C208B5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 02:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40D410E3;
	Mon, 11 Mar 2024 02:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9ot7Q4V"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC99A35
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 02:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710123168; cv=none; b=kmFVTmtD0bnzBLlg8Ay3jrk88RX+2xUeq4UYfiXIOzT23ni8jgjoTU51dliCSpb0b3RXCMfi62spar/xatxHFulmN0bMhMl+1Hm0dHpU1C8Fl9lmCV1b0lrXi/W982hoD1CuMetJhNoUk/lr7U/TV9CLuNHRq5f/TvpMa/rjBt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710123168; c=relaxed/simple;
	bh=42nfzlzZGGNRqTPL62CdkBCL7Qp58c681aY1xNpzb7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwBjfggV0YyvKLYwjizMbOO8Ql9W0K+fQZTkpxN9R+EgWKHUbZ/+Ewze/6TjhSEXaBxBJQrBKarACD1uybqyq4cjZv4uIpoFbSFVZd11IMHXSbdxjMuo615cOPA9QtYiVXFF0axIIc4XBg0x9C/472EfHiLLfOlrFJljHxvnzBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9ot7Q4V; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so3237732a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 19:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710123166; x=1710727966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42nfzlzZGGNRqTPL62CdkBCL7Qp58c681aY1xNpzb7c=;
        b=E9ot7Q4VIaRSe9px+NDOCstgjQJPl3evUrbVYY32QjxdJgolZUKlzkRKt3nA5XWdx5
         K8FRsjf6repz2NoTFhqjN6M5rEaVMea6ORulXMTkUS4CE/zTwOMAqi1jIZNZOAtIV9v2
         v0SXRio0i0pICu7wgiqF8x4ylk+M9g0mi7KvnUZW592wV5jNtUJV7GAjKv16+whipChj
         ZTuYUbX9uL/nuXGXPVGVRyrs9P9MfuasWE6oMekeK5mExjKXgS2xjZ/zCG/E2Jy2mHTO
         ul1NOInXNz1lhMuBfjBi/fPiuoz0+VJC718ED98b7/MpcUkx7NtncfnwQJCU6fv9iAE9
         8RSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710123166; x=1710727966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42nfzlzZGGNRqTPL62CdkBCL7Qp58c681aY1xNpzb7c=;
        b=xTjPMiYqmZnmHPB3Vn1uzDrNz9Gfnl3/pfvcaF6SmhpdYuUTpSMRMTgtHhpPECkkWj
         ttzDJIHz+kpPlm4mL9gdVXQ0smejg7pqrJVU5vcMm//4sHZmitDUtoRbGV3ShYdX8W/6
         7t0DeltCNQuiBuf1ldAULVXqVijum7cieSYRj9gTaZfrYGidra4lvXt4xjiqJeLIzWyx
         fU+rDJcHAAXf6Z37K3zwK8nF5wN6URoVqu6CRoGuDRnwWAMWWCJ7lD2zxg9OlzZYP0r9
         zgB3Lq335KMqmSQSoVB8nMRS2N3vWemBxn6+mtTO98OYz3htF1JZxPHmSLD6mTQTZiDF
         rkrw==
X-Forwarded-Encrypted: i=1; AJvYcCUxOPkqXm6vzChmkjmwKAtcC0/fsVVNzzv0hxMhWeQwOIHSM8QujA6XfPipD8Ge7byV84ycc4dMP+vPCccFwts8Ps7WFHKsqZ/W5plB
X-Gm-Message-State: AOJu0YxPUwvl9l45eksHJHaMaiUEPD9SVQzcMvg0y7gSXD/IzE7b6pbQ
	mO3R6vTOLQPJj6h0Ek3yqbWwJTGM2bNSp1EybzHa12bstjZuODmMfdBMXuQLiSFt40lqsQzDda5
	ypqRCx2QJ1oAqm48fqTz7t+7iqWk=
X-Google-Smtp-Source: AGHT+IEqisN8VLPqViNCFJ8DyM265wSMI/kyFcH6flJsMrwHibv1TUsXR+hfU4ZzVs1QXlpT/99UHlBg8w+NffzuIc4=
X-Received: by 2002:a17:90b:e13:b0:29a:72b:df85 with SMTP id
 ge19-20020a17090b0e1300b0029a072bdf85mr8689814pjb.7.1710123166051; Sun, 10
 Mar 2024 19:12:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170987627011.449367.8705596691078598981.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <170987627011.449367.8705596691078598981.stgit@dwillia2-xfh.jf.intel.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Mon, 11 Mar 2024 10:12:34 +0800
Message-ID: <CAJhGHyDzCD2PrOi3gf-SZgG16gBCs8XEszXMSWBv7s=+=gsyFA@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Cleanup subsys attribute registration
To: Dan Williams <dan.j.williams@intel.com>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 1:39=E2=80=AFPM Dan Williams <dan.j.williams@intel.c=
om> wrote:

Thanks for the clean.

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

Thanks
Lai

